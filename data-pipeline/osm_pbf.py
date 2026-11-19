"""OSM verisini Overpass yerine Geofabrik'in hazır dosyasından (turkey-latest.osm.pbf) çıkarır.

Overpass herkese açık bir servis; yoğun saatlerde GitHub'ın makinelerinden gelen sorgulara
502/504 dönüyor. Geofabrik dosyası sıradan bir indirme olduğu için bu sorundan etkilenmez.

Adımlar (osmium-tool gerekir; GitHub Actions'ta apt ile kurulur):
  1. İl sınırı: admin_level=4 ilişkileri süzülür, ilin sınırı (çoklu poligon) alınır.
  2. Her kutu (il kutusu + Ihlara gibi ek kutular) için: extract -> tags-filter -> export (GeoJSON).
  3. GeoJSON öğeleri Overpass biçimine çevrilir (node / way + geometry / relation + members),
     cities.py'deki seçicilerle birebir süzülür ve il sınırıyla kırpılır.
Çıktı, pipeline.py'nin Overpass'tan beklediği {"elements": [...]} biçimindedir; sonraki adımlar aynıdır.
"""
from __future__ import annotations

import json
import re
import subprocess
import sys
from pathlib import Path
from typing import Any, Dict, Iterable, List, Optional, Tuple

sys.path.insert(0, str(Path(__file__).resolve().parent))

from cities import City, extra_boxes, selectors  # noqa: E402

GEOFABRIK_URL = "https://download.geofabrik.de/europe/turkey-latest.osm.pbf"

_COND = re.compile(r'\["([^"]+)"(?:(=|~)"([^"]*)")?\]')

Cond = Tuple[str, Optional[str], Optional[str]]


# ---------------------------------------------------------------------------
# Seçiciler (Overpass sözdizimi -> Python)
# ---------------------------------------------------------------------------

def parse_selector(sel: str) -> List[Cond]:
    """'nwr["leisure"~"^(park|garden)$"]["name"]' -> [("leisure", "~", "^(park|garden)$"), ("name", None, None)]"""
    if not sel.startswith("nwr["):
        raise ValueError(f"desteklenmeyen seçici: {sel}")
    conds = _COND.findall(sel[3:])
    return [(k, op or None, v if op else None) for k, op, v in conds]


def tags_match(tags: Dict[str, str], conds: List[Cond]) -> bool:
    for key, op, val in conds:
        if key not in tags:
            return False
        if op == "=" and tags[key] != val:
            return False
        if op == "~" and not re.search(val or "", tags[key]):
            return False
    return True


def filter_expressions(sels: Iterable[str]) -> List[str]:
    """osmium tags-filter için kaba süzgeç: her seçicinin ilk koşulu (eşitse anahtar=değer, değilse anahtar).
    Kesin süzme Python'da tags_match ile yapılır."""
    exprs: List[str] = []
    for sel in sels:
        key, op, val = parse_selector(sel)[0]
        e = f"nwr/{key}={val}" if op == "=" else f"nwr/{key}"
        if e not in exprs:
            exprs.append(e)
    return exprs


# ---------------------------------------------------------------------------
# GeoJSON -> Overpass biçimi
# ---------------------------------------------------------------------------

def _parse_id(fid: Any) -> Optional[Tuple[str, int]]:
    """osmium --add-unique-id=type_id: 'n12', 'w34', 'r56'. ('a' önekli alan kimliği de çözülür.)"""
    m = re.fullmatch(r"([nwra])(\d+)", str(fid or ""))
    if not m:
        return None
    kind, num = m.group(1), int(m.group(2))
    if kind == "a":
        return ("way", num // 2) if num % 2 == 0 else ("relation", (num - 1) // 2)
    return {"n": "node", "w": "way", "r": "relation"}[kind], num


def _pts(coords: List[List[float]]) -> List[Dict[str, float]]:
    return [{"lat": round(c[1], 7), "lon": round(c[0], 7)} for c in coords]


def _bounds(rings: List[List[List[float]]]) -> Dict[str, float]:
    xs = [c[0] for r in rings for c in r]
    ys = [c[1] for r in rings for c in r]
    return {"minlat": min(ys), "minlon": min(xs), "maxlat": max(ys), "maxlon": max(xs)}


def feature_to_element(feat: Dict[str, Any]) -> Optional[Dict[str, Any]]:
    ident = _parse_id(feat.get("id"))
    geom = feat.get("geometry") or {}
    tags = {k: str(v) for k, v in (feat.get("properties") or {}).items() if not k.startswith("@")}
    if not ident or not geom:
        return None
    kind, num = ident
    gtype, coords = geom.get("type"), geom.get("coordinates")
    el: Dict[str, Any] = {"type": kind, "id": num, "tags": tags}
    if gtype == "Point":
        el.update(type="node", lat=coords[1], lon=coords[0])
        return el
    if gtype == "LineString":
        el.update(type="way", geometry=_pts(coords))
        return el
    if gtype in ("Polygon", "MultiPolygon"):
        polys = [coords] if gtype == "Polygon" else coords
        outers = [p[0] for p in polys if p]
        if kind == "way" and len(outers) == 1:
            el["geometry"] = _pts(outers[0])
        else:
            el["type"] = "relation"
            el["members"] = [{"type": "way", "role": "outer", "geometry": _pts(r)} for r in outers]
            el["bounds"] = _bounds(outers)
        return el
    return None


def read_geojsonseq(path: Path) -> Iterable[Dict[str, Any]]:
    with path.open(encoding="utf-8") as f:
        for line in f:
            line = line.strip().lstrip("\x1e")
            if line:
                yield json.loads(line)


def province_rings(features: Iterable[Dict[str, Any]], province: str) -> List[List[Tuple[float, float]]]:
    """admin_level=4 sınırlarından ilin dış halkaları [(boylam, enlem), ...]."""
    rings: List[List[Tuple[float, float]]] = []
    for feat in features:
        props = feat.get("properties") or {}
        if props.get("boundary") != "administrative" or str(props.get("admin_level")) != "4" \
                or props.get("name") != province:
            continue
        geom = feat.get("geometry") or {}
        polys = [geom["coordinates"]] if geom.get("type") == "Polygon" else geom.get("coordinates", []) \
            if geom.get("type") == "MultiPolygon" else []
        rings.extend([(c[0], c[1]) for c in p[0]] for p in polys if p)
    return rings


def select_elements(features: Iterable[Dict[str, Any]], city: City, rings, clip: bool,
                    point_in_rings, element_geometry) -> Dict[Tuple[str, int], Dict[str, Any]]:
    conds = [parse_selector(s) for s in selectors(city)]
    out: Dict[Tuple[str, int], Dict[str, Any]] = {}
    for feat in features:
        el = feature_to_element(feat)
        if not el or not any(tags_match(el["tags"], c) for c in conds):
            continue
        lat, lng, _ = element_geometry(el)
        if lat is None or lng is None:
            continue
        if clip and not point_in_rings(lat, lng, rings):
            continue
        out[(el["type"], el["id"])] = el
    return out


# ---------------------------------------------------------------------------
# osmium
# ---------------------------------------------------------------------------

def _osmium(*args: str) -> None:
    cmd = ["osmium", *args]
    res = subprocess.run(cmd, capture_output=True, text=True)
    if res.returncode != 0:
        raise RuntimeError(f"{' '.join(cmd[:3])} …: {res.stderr.strip()[-500:]}")


def _export(src: Path, dst: Path) -> None:
    _osmium("export", str(src), "-f", "geojsonseq", "--add-unique-id=type_id",
            "-x", "print_record_separator=false", "-o", str(dst), "--overwrite")


def fetch_from_pbf(city: City, pbf: Path, work: Path, log, point_in_rings, element_geometry) -> Dict[str, Any]:
    if not city.bbox or not city.province:
        raise SystemExit(f"{city.slug}: pbf kaynağı için bbox ve province gerekli")
    work.mkdir(parents=True, exist_ok=True)

    log(f"İl sınırı: {city.province}")
    adm = work / "adm4.osm.pbf"
    _osmium("tags-filter", str(pbf), "r/admin_level=4", "-o", str(adm), "--overwrite")
    _export(adm, work / "adm4.geojsonseq")
    rings = province_rings(read_geojsonseq(work / "adm4.geojsonseq"), city.province)
    if not rings:
        raise RuntimeError(f"il sınırı bulunamadı: {city.province}")

    exprs = filter_expressions(selectors(city))
    boxes = [(city.bbox, True)] + [(b, False) for b in extra_boxes(city)]
    seen: Dict[Tuple[str, int], Dict[str, Any]] = {}
    for i, (box, clip) in enumerate(boxes):
        s, w, n, e = box
        log(f"Kutu {i + 1}/{len(boxes)}: {box}{' (il sınırına kırpılır)' if clip else ''}")
        part, filt, gj = work / f"box{i}.osm.pbf", work / f"box{i}.f.osm.pbf", work / f"box{i}.geojsonseq"
        _osmium("extract", "-s", "smart", "-b", f"{w},{s},{e},{n}", str(pbf), "-o", str(part), "--overwrite")
        _osmium("tags-filter", str(part), *exprs, "-o", str(filt), "--overwrite")
        _export(filt, gj)
        found = select_elements(read_geojsonseq(gj), city, rings, clip, point_in_rings, element_geometry)
        log(f"  {len(found)} öğe")
        for k, el in found.items():
            seen.setdefault(k, el)
    if not seen:
        raise RuntimeError("hiç öğe bulunamadı")
    return {"elements": list(seen.values()), "source": "geofabrik", "pbf": pbf.name}
