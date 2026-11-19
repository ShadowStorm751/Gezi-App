#!/usr/bin/env python3
"""Gezi App veri hattı: bir şehirdeki tarihi-kültürel ve doğa/manzara yerleri.

Şehir --city ile seçilir (varsayılan: istanbul); ayarlar cities.py içinde.

Üç adım:
  1. fetch       OpenStreetMap (Overpass) ve Wikidata'dan ham veriyi indirir.
  2. candidates  Birleştirir, sınıflandırır, puanlar ve onay için CSV yazar.
  3. build       Onaylanan satırları veritabanına yüklenecek SQL dosyasına çevirir.

Yalnızca Python standart kütüphanesi kullanılır (Python 3.9+). Ayrıntı: README.md
"""
from __future__ import annotations

import argparse
import csv
import json
import math
import re
import sys
import time
import unicodedata
import urllib.error
import urllib.parse
import urllib.request
from datetime import datetime
from pathlib import Path
from typing import Any, Dict, FrozenSet, Iterable, List, Optional, Sequence, Tuple

sys.path.insert(0, str(Path(__file__).resolve().parent))
from cities import CITIES, DEFAULT_CITY, ISTANBUL_PERIODS, City, get_city, overpass_query  # noqa: E402

USER_AGENT = "GeziApp-DataPipeline/0.1 (https://github.com/ShadowStorm751/Gezi-App)"
OVERPASS_URLS = [
    "https://overpass-api.de/api/interpreter",
    "https://overpass.kumi.systems/api/interpreter",
    "https://overpass.private.coffee/api/interpreter",
    "https://maps.mail.ru/osm/tools/overpass/api/interpreter",
]
CHUNK_ROUNDS = 4          # parça sorguda bütün sunucular kaç tur denensin
CHUNK_ROUND_WAIT_S = 90   # turlar arası bekleme
WIKIDATA_API = "https://www.wikidata.org/w/api.php"
DEFAULT_OUT = Path(__file__).resolve().parent / "output"
CITY_SLUG = "istanbul"

# İstanbul ili (admin_level=4) içindeki adı olan yerler. Diğer şehirler: cities.overpass_query.
OVERPASS_QUERY = overpass_query(CITIES["istanbul"])

CATEGORY_KIND = {
    "mosque": "historical", "church": "historical", "synagogue": "historical",
    "palace": "historical", "museum": "historical", "fortress": "historical",
    "tower": "historical", "cistern": "historical", "monument": "historical",
    "archaeological_site": "historical", "tomb": "historical",
    "valley": "nature",
    "viewpoint": "nature", "hill": "nature", "forest": "nature", "park": "nature",
    "beach": "nature", "island": "nature", "waterfall": "nature",
}

DEFAULT_RADIUS_M = {
    "viewpoint": 50, "tower": 60, "cistern": 60, "monument": 60, "tomb": 60,
    "mosque": 100, "church": 100, "synagogue": 100, "museum": 100, "hill": 100,
    "palace": 150, "fortress": 150, "archaeological_site": 150, "beach": 150,
    "park": 200, "waterfall": 100, "forest": 500, "island": 1500, "valley": 300,
}

# Bu kategorilerde poligon varsa "alanın içinde olmak" check-in için yeterli olur.
AREA_CATEGORIES = {"forest", "park", "island", "beach", "archaeological_site", "valley"}

# Onay listesine girecek en fazla aday sayısı (tür başına). İstanbul; diğer şehirler cities.py.
QUOTAS = CITIES["istanbul"].quotas

# Tek bir kategori listeyi doldurmasın (ör. 76 cami).
CATEGORY_CAP = CITIES["istanbul"].category_cap

MAX_RING_POINTS = 150
DUPLICATE_DISTANCE_M = 100
DUPLICATE_DISTANCE_AREA_M = 2000  # ada, orman, park gibi büyük yerler

CSV_COLUMNS = [
    "onay", "puan", "aile", "kategori", "ad_tr", "ad_en",
    "kisa_aciklama_tr", "kisa_aciklama_en", "en_iyi_zaman_tr", "en_iyi_zaman_en",
    "donem", "yapim_yili", "yaricap_m", "alan_var",
    "wikidata_ipucu_tr", "wikidata_ipucu_en", "wikipedia_tr", "wikipedia_en", "fotograf",
    "enlem", "boylam", "slug", "wikidata", "osm",
]

APPROVE_VALUES = {"x", "1", "e", "evet", "y", "yes", "ok", "+"}


# ---------------------------------------------------------------------------
# Yardımcılar
# ---------------------------------------------------------------------------

_TR_MAP = str.maketrans({
    "ç": "c", "Ç": "c", "ğ": "g", "Ğ": "g", "ı": "i", "I": "i", "İ": "i",
    "ö": "o", "Ö": "o", "ş": "s", "Ş": "s", "ü": "u", "Ü": "u",
    "â": "a", "Â": "a", "î": "i", "Î": "i", "û": "u", "Û": "u",
})


def fold(text: str) -> str:
    """Türkçe karakterleri sadeleştirip küçük harfe çevirir: 'Çamlıca' -> 'camlica'."""
    text = text.translate(_TR_MAP)
    text = unicodedata.normalize("NFKD", text).encode("ascii", "ignore").decode("ascii")
    return text.lower()


def clean_name(text: str, suffixes: Sequence[str] = CITIES["istanbul"].name_suffixes) -> str:
    """Görünmez karakterleri ve sondaki '(Istanbul)' gibi açıklamaları atar."""
    text = "".join(ch for ch in text if unicodedata.category(ch) != "Cf")
    pattern = "|".join(re.escape(x) for x in suffixes)
    text = re.sub(rf"\s*\(({pattern})\)\s*$", "", text, flags=re.I)
    return re.sub(r"\s+", " ", text).strip()


def slugify(text: str, max_len: int = 60) -> str:
    slug = re.sub(r"[^a-z0-9]+", "-", fold(text)).strip("-")
    return slug[:max_len].rstrip("-") or "yer"


def haversine_m(lat1: float, lng1: float, lat2: float, lng2: float) -> float:
    r = 6371008.8
    p1, p2 = math.radians(lat1), math.radians(lat2)
    dp, dl = p2 - p1, math.radians(lng2 - lng1)
    a = math.sin(dp / 2) ** 2 + math.cos(p1) * math.cos(p2) * math.sin(dl / 2) ** 2
    return 2 * r * math.asin(math.sqrt(a))


def log(msg: str) -> None:
    print(msg, file=sys.stderr, flush=True)


# ---------------------------------------------------------------------------
# 1. fetch
# ---------------------------------------------------------------------------

def _request(url: str, data: Optional[bytes], timeout: int) -> bytes:
    req = urllib.request.Request(url, data=data, headers={"User-Agent": USER_AGENT})
    with urllib.request.urlopen(req, timeout=timeout) as resp:
        return resp.read()


def _with_retries(fn, attempts: int = 3, wait_s: int = 20):
    for i in range(attempts):
        try:
            return fn()
        except (urllib.error.URLError, TimeoutError) as exc:
            if i == attempts - 1:
                raise
            log(f"  istek başarısız ({exc}); {wait_s} sn sonra tekrar denenecek")
            time.sleep(wait_s)


def _overpass(query: str, timeout_s: int) -> Dict[str, Any]:
    """Sorguyu sırayla sunuculara gönderir. Sunucu zaman aşımı ('remark') da hata sayılır."""
    body = urllib.parse.urlencode({"data": query}).encode()
    last_error: Optional[Exception] = None
    for url in OVERPASS_URLS:
        log(f"Overpass sorgusu: {url} (birkaç dakika sürebilir)")
        try:
            raw = _with_retries(lambda: _request(url, body, timeout=timeout_s + 60))
            data = json.loads(raw)
            remark = data.get("remark", "")
            if re.search(r"error|timed out|out of memory", remark, re.I):
                raise RuntimeError(f"sunucu yanıtı eksik: {remark}")
            return data
        except Exception as exc:  # bir sonraki sunucuyu dene
            last_error = exc
            log(f"  başarısız: {exc}")
    raise RuntimeError(f"Overpass sunucularına ulaşılamadı: {last_error}")


def fetch_osm(out_dir: Path, city: Optional[City] = None) -> Path:
    city = city or CITIES[DEFAULT_CITY]
    query = OVERPASS_QUERY if city.slug == DEFAULT_CITY else overpass_query(city)
    try:
        if city.chunked:
            raise RuntimeError("şehir ayarı: parça parça sorgu")
        data = _overpass(query, city.timeout_s)
    except RuntimeError as exc:
        # Büyük il ya da yoğun sunucu: her etiket grubunu ayrı sorgula, sonuçları birleştir.
        log(f"Tek sorgu olmadı ({exc}); etiket grupları tek tek sorgulanacak")
        data = fetch_osm_chunked(city, out_dir / "osm_chunks")
    path = out_dir / "osm_raw.json"
    path.write_text(json.dumps(data, ensure_ascii=False), encoding="utf-8")
    log(f"  {len(data.get('elements', []))} OSM öğesi -> {path}")
    return path


def fetch_osm_chunked(city: City, cache_dir: Optional[Path] = None) -> Dict[str, Any]:
    """Her etiket grubu ayrı sorgu. Biten parçalar cache_dir'e yazılır; yeniden çalıştırmada atlanır."""
    from cities import selectors
    seen: Dict[Tuple[str, int], Dict[str, Any]] = {}
    sels = selectors(city)
    if cache_dir:
        cache_dir.mkdir(parents=True, exist_ok=True)
    for i, sel in enumerate(sels, start=1):
        log(f"  [{i}/{len(sels)}] {sel}")
        cached = cache_dir / f"{i:02d}.json" if cache_dir else None
        if cached and cached.exists():
            part = json.loads(cached.read_text(encoding="utf-8"))
        else:
            part = None
            for rnd in range(1, CHUNK_ROUNDS + 1):
                try:
                    part = _overpass(overpass_query(city, [sel]), city.timeout_s)
                    break
                except RuntimeError as exc:
                    if rnd == CHUNK_ROUNDS:
                        raise
                    log(f"  tur {rnd} başarısız ({exc}); {CHUNK_ROUND_WAIT_S} sn sonra yeniden")
                    time.sleep(CHUNK_ROUND_WAIT_S)
            if cached:
                cached.write_text(json.dumps(part, ensure_ascii=False), encoding="utf-8")
            time.sleep(5)
        for el in part.get("elements", []):
            seen.setdefault((el["type"], el["id"]), el)
    return {"elements": list(seen.values()), "chunked": True}


def fetch_wikidata(out_dir: Path, batch_size: int = 50) -> Path:
    osm = json.loads((out_dir / "osm_raw.json").read_text(encoding="utf-8"))
    qids = sorted({
        el["tags"]["wikidata"].strip()
        for el in osm.get("elements", [])
        if re.fullmatch(r"Q\d+", el.get("tags", {}).get("wikidata", "").strip())
    })
    log(f"Wikidata: {len(qids)} kayıt indirilecek")
    entities: Dict[str, Any] = {}
    for i in range(0, len(qids), batch_size):
        batch = qids[i:i + batch_size]
        params = urllib.parse.urlencode({
            "action": "wbgetentities", "format": "json", "ids": "|".join(batch),
            "props": "labels|descriptions|claims|sitelinks", "languages": "tr|en",
        })
        raw = _with_retries(lambda: _request(f"{WIKIDATA_API}?{params}", None, timeout=60))
        entities.update(json.loads(raw).get("entities", {}))
        log(f"  {min(i + batch_size, len(qids))}/{len(qids)}")
        time.sleep(1)
    path = out_dir / "wikidata.json"
    path.write_text(json.dumps(entities, ensure_ascii=False), encoding="utf-8")
    return path


# ---------------------------------------------------------------------------
# 2. candidates
# ---------------------------------------------------------------------------

def classify(tags: Dict[str, str], extra_rules: FrozenSet[str] = frozenset()) -> Optional[str]:
    """OSM etiketlerinden kategori slug'ı. Uygun değilse None.

    extra_rules yalnızca temel kuralların reddettiği öğelere uygulanır (şehre özgü, cities.py).
    """
    cat = _classify_base(tags)
    if cat is None and extra_rules:
        cat = classify_extra(tags, extra_rules)
    return cat


def classify_extra(tags: Dict[str, str], rules: FrozenSet[str]) -> Optional[str]:
    """Şehre özgü ek kurallar (temel kurallardan sonra, yalnızca reddedilenler için)."""
    name = fold(tags.get("name", ""))
    if "bath" in rules and tags.get("amenity") == "public_bath" and re.search(r"hamam|kaplica|bath", name):
        return "monument"
    if "cappadocia" in rules:
        if tags.get("natural") == "valley" or re.search(r"\bvadisi?\b|\bvalley\b", name):
            return "valley"
        if re.search(r"yer ?alti|underground", name):
            return "archaeological_site"
        if re.search(r"kilise|church|manastir|monastery|sapel|chapel", name) \
                or tags.get("historic") in ("church", "monastery"):
            return "church"
        if re.search(r"kervansaray|caravanserai|\bhani\b", name):
            return "monument"
        if re.search(r"peri ?baca|bacalar|guzeller|pasabag|devrent|kaya|rock|ask vadisi|kale", name) \
                or tags.get("natural") in ("rock", "stone", "cliff"):
            return "viewpoint"
    return None


def _classify_base(tags: Dict[str, str]) -> Optional[str]:
    name = fold(tags.get("name", ""))
    historic = tags.get("historic", "")

    if tags.get("place") in ("island", "islet"):
        return "island"
    if tags.get("tourism") == "viewpoint":
        return "viewpoint"
    if tags.get("waterway") == "waterfall":
        return "waterfall"
    if tags.get("natural") == "beach":
        return "beach"
    if tags.get("natural") == "peak":
        return "hill"
    if tags.get("natural") == "wood" or tags.get("landuse") == "forest" \
            or tags.get("leisure") == "nature_reserve":
        return "forest"

    if historic in ("palace", "manor") or tags.get("building") == "palace" \
            or re.search(r"\b(saray|sarayi|kosku|kasri)\b", name):
        return "palace"
    if "sarnic" in name or historic == "cistern":
        return "cistern"
    if historic in ("castle", "fort", "citywalls", "city_gate") \
            or re.search(r"\b(hisari|kalesi|surlari)\b", name):
        return "fortress"
    landmark = bool(historic) or tags.get("tourism") == "attraction" \
        or tags.get("man_made") in ("tower", "lighthouse")
    if historic == "tower" or (landmark and re.search(r"\bkulesi\b", name)):
        return "tower"
    if tags.get("amenity") == "place_of_worship":
        religion = tags.get("religion", "")
        if religion == "muslim":
            return "mosque"
        if religion == "christian":
            return "church"
        if religion == "jewish":
            return "synagogue"
        return "monument"
    if tags.get("tourism") == "museum":
        return "museum"
    if historic == "tomb":
        return "tomb"
    if historic in ("ruins", "archaeological_site"):
        return "archaeological_site"
    if historic in ("monument", "memorial", "aqueduct", "fountain", "building"):
        return "monument"
    if tags.get("leisure") in ("park", "garden"):
        return "park"
    # Turistik yer / meydan / fener: yalnızca tarihi bir ipucu varsa
    if tags.get("tourism") == "attraction" or tags.get("place") == "square" \
            or tags.get("man_made") == "lighthouse":
        if re.search(r"carsi|hipodrom|meydani|feneri|bedesten|han\b|hamam|kemer|sutun|kule", name):
            return "monument"
    return None


def element_geometry(el: Dict[str, Any]) -> Tuple[Optional[float], Optional[float], Optional[List[Tuple[float, float]]]]:
    """(enlem, boylam, kapalı halka [(boylam, enlem), ...] ya da None)."""
    if el.get("type") == "node":
        return el.get("lat"), el.get("lon"), None

    def closed_ring(geom: List[Dict[str, float]]) -> Optional[List[Tuple[float, float]]]:
        pts = [(g["lon"], g["lat"]) for g in geom if g]
        if len(pts) >= 4 and pts[0] == pts[-1]:
            return pts
        return None

    def bounds_center() -> Tuple[Optional[float], Optional[float]]:
        b = el.get("bounds")
        if not b:
            return None, None
        return (b["minlat"] + b["maxlat"]) / 2, (b["minlon"] + b["maxlon"]) / 2

    if el.get("type") == "way":
        geom = el.get("geometry") or []
        pts = [(g["lon"], g["lat"]) for g in geom if g]
        if not pts:
            lat, lng = bounds_center()
            return lat, lng, None
        ring = closed_ring(geom)
        uniq = pts[:-1] if ring else pts
        lat = sum(p[1] for p in uniq) / len(uniq)
        lng = sum(p[0] for p in uniq) / len(uniq)
        return lat, lng, ring

    if el.get("type") == "relation":
        segments = [
            [(g["lon"], g["lat"]) for g in m["geometry"] if g]
            for m in el.get("members", [])
            if m.get("type") == "way" and m.get("role") in ("outer", "") and m.get("geometry")
        ]
        rings = stitch_rings(segments)

        def bbox_area(r: List[Tuple[float, float]]) -> float:
            xs, ys = [p[0] for p in r], [p[1] for p in r]
            return (max(xs) - min(xs)) * (max(ys) - min(ys))

        ring = max(rings, key=bbox_area) if rings else None
        lat, lng = bounds_center()
        if lat is None and ring:
            lat = sum(p[1] for p in ring[:-1]) / (len(ring) - 1)
            lng = sum(p[0] for p in ring[:-1]) / (len(ring) - 1)
        return lat, lng, ring

    return None, None, None


def stitch_rings(segments: List[List[Tuple[float, float]]]) -> List[List[Tuple[float, float]]]:
    """Uç uca eklenen yol parçalarını kapalı halkalara birleştirir (OSM multipolygon)."""
    segs = [list(sg) for sg in segments if len(sg) >= 2]
    rings: List[List[Tuple[float, float]]] = []
    while segs:
        cur = segs.pop(0)
        changed = True
        while cur[0] != cur[-1] and changed:
            changed = False
            for i, sg in enumerate(segs):
                if sg[0] == cur[-1]:
                    cur = cur + sg[1:]
                elif sg[-1] == cur[-1]:
                    cur = cur + sg[::-1][1:]
                elif sg[-1] == cur[0]:
                    cur = sg + cur[1:]
                elif sg[0] == cur[0]:
                    cur = sg[::-1] + cur[1:]
                else:
                    continue
                segs.pop(i)
                changed = True
                break
        if len(cur) >= 4 and cur[0] == cur[-1]:
            rings.append(cur)
    return rings


def simplify_ring(ring: List[Tuple[float, float]], max_points: int = MAX_RING_POINTS) -> List[Tuple[float, float]]:
    body = ring[:-1]
    if len(body) <= max_points:
        return ring
    step = math.ceil(len(body) / max_points)
    kept = body[::step]
    return kept + [kept[0]]


def parse_inception_year(claims: Dict[str, Any]) -> Optional[int]:
    """Wikidata P571 (yapım/kuruluş tarihi) -> en erken yıl. MÖ yıllar negatif."""
    years = []
    for claim in claims.get("P571", []):
        try:
            t = claim["mainsnak"]["datavalue"]["value"]["time"]
        except (KeyError, TypeError):
            continue
        m = re.match(r"([+-])(\d+)-", t)
        if m:
            year = int(m.group(2))
            years.append(-year if m.group(1) == "-" else year)
    return min(years) if years else None


def guess_period(year: Optional[int], periods: Sequence[Tuple[int, str]] = ISTANBUL_PERIODS) -> str:
    """Yapım yılından dönem tahmini (şehre göre eşikler). Onay sırasında elle düzeltilebilir."""
    if year is None:
        return ""
    for before, name in periods:
        if year < before:
            return name
    return "Cumhuriyet"


def wikidata_info(entity: Optional[Dict[str, Any]], city: Optional[City] = None) -> Dict[str, Any]:
    if not entity or "missing" in entity:
        return {}
    claims = entity.get("claims", {})
    instance_of = {
        c.get("mainsnak", {}).get("datavalue", {}).get("value", {}).get("id")
        for c in claims.get("P31", [])
    }
    if "Q5" in instance_of:  # yere değil kişiye bağlanmış (ör. türbelerde padişah)
        return {}
    labels = entity.get("labels", {})
    descs = entity.get("descriptions", {})
    sitelinks = entity.get("sitelinks", {})
    image = ""
    for c in claims.get("P18", []):
        image = c.get("mainsnak", {}).get("datavalue", {}).get("value", "") or ""
        if image:
            break
    return {
        "label_tr": clean_name(labels.get("tr", {}).get("value", ""), _suffixes(city)),
        "label_en": clean_name(labels.get("en", {}).get("value", ""), _suffixes(city)),
        "desc_tr": descs.get("tr", {}).get("value", ""),
        "desc_en": descs.get("en", {}).get("value", ""),
        "sitelinks": len(sitelinks),
        "trwiki": sitelinks.get("trwiki", {}).get("title", ""),
        "enwiki": sitelinks.get("enwiki", {}).get("title", ""),
        "image": image,
        "heritage": bool(claims.get("P1435")),
        "year": parse_inception_year(claims),
    }


def _suffixes(city: Optional[City]) -> Sequence[str]:
    return (city or CITIES[DEFAULT_CITY]).name_suffixes


CATEGORY_BONUS = {
    "valley": 15,
    "viewpoint": 20, "island": 15, "hill": 10, "waterfall": 10, "palace": 10,
    "beach": 5, "museum": 5, "fortress": 5, "forest": 5,
}


GENERIC_NAME = re.compile(
    r"^(plaj|beach|cesme|çeşme|cami|manzara|seyir|seyir noktasi|seyir terasi|view|viewpoint|teras)$", re.I)


def score(cand: Dict[str, Any], wd: Dict[str, Any]) -> int:
    s = CATEGORY_BONUS.get(cand["kategori"], 0)
    if cand["kategori"] == "viewpoint":
        name = fold(cand["ad_tr"])
        if GENERIC_NAME.match(name) or len(name) < 5 or not re.search(r"[çğıöşü]|tepe|seyir|koru|park|kule|ada|kale|sahil|cami", cand["ad_tr"].lower()):
            s -= CATEGORY_BONUS["viewpoint"]
    if wd:
        s += min(wd.get("sitelinks", 0), 60)
        s += 15 if wd.get("enwiki") else 0
        s += 10 if wd.get("trwiki") else 0
        s += 8 if wd.get("image") else 0
        s += 10 if wd.get("heritage") else 0
    if cand.get("ad_en"):
        s += 3
    if cand.get("_ring") and cand["kategori"] in AREA_CATEGORIES:
        s += 5
    return s


def build_candidates(osm: Dict[str, Any], wikidata: Dict[str, Any],
                     city: Optional[City] = None) -> List[Dict[str, Any]]:
    city = city or CITIES[DEFAULT_CITY]
    raw: List[Dict[str, Any]] = []
    for el in osm.get("elements", []):
        tags = el.get("tags", {})
        name = clean_name(tags.get("name:tr") or tags.get("name") or "", city.name_suffixes)
        if not name:
            continue
        if tags.get("historic") == "tomb" and not re.search(r"türbe|turbe|tomb|mezar", name, re.I):
            name = f"{name} Türbesi"
        category = classify(tags, city.extra_rules)
        if not category:
            continue
        lat, lng, ring = element_geometry(el)
        if lat is None or lng is None:
            continue
        qid = tags.get("wikidata", "").strip()
        qid = qid if re.fullmatch(r"Q\d+", qid) else ""
        wd = wikidata_info(wikidata.get(qid), city) if qid else {}
        year = wd.get("year")
        cand = {
            "aile": CATEGORY_KIND[category],
            "kategori": category,
            "ad_tr": name if tags.get("historic") == "tomb" else (wd.get("label_tr") or name),
            "ad_en": clean_name(tags.get("name:en", ""), city.name_suffixes) or wd.get("label_en") or "",
            "donem": guess_period(year, city.periods) if CATEGORY_KIND[category] == "historical" else "",
            "yapim_yili": "" if year is None else str(year),
            "wikidata_ipucu_tr": wd.get("desc_tr", ""),
            "wikidata_ipucu_en": wd.get("desc_en", ""),
            "wikipedia_tr": wd.get("trwiki", ""),
            "wikipedia_en": wd.get("enwiki", ""),
            "fotograf": wd.get("image", ""),
            "enlem": round(lat, 6),
            "boylam": round(lng, 6),
            "wikidata": qid,
            "osm": f"{el['type']}/{el['id']}",
            "_ring": ring if category in AREA_CATEGORIES else None,
        }
        cand["puan"] = score(cand, wd)
        raw.append(cand)

    merged = _dedupe(raw)

    # Tür başına kota, puana göre.
    out: List[Dict[str, Any]] = []
    for kind, quota in city.quotas.items():
        group = sorted((c for c in merged if c["aile"] == kind),
                       key=lambda c: (-c["puan"], c["ad_tr"]))
        per_cat: Dict[str, int] = {}
        picked: List[Dict[str, Any]] = []
        for c in group:
            if len(picked) >= quota:
                break
            n = per_cat.get(c["kategori"], 0)
            if n >= city.category_cap.get(c["kategori"], quota):
                continue
            per_cat[c["kategori"]] = n + 1
            picked.append(c)
        out.extend(picked)

    # Slug'lar benzersiz olsun.
    used: Dict[str, int] = {}
    for c in out:
        base = slugify(c["ad_tr"])
        n = used.get(base, 0)
        used[base] = n + 1
        c["slug"] = base if n == 0 else f"{base}-{n + 1}"
        c["yaricap_m"] = DEFAULT_RADIUS_M[c["kategori"]]
        c["alan_var"] = "evet" if c.get("_ring") else ""
    return out


def _better(a: Dict[str, Any], b: Dict[str, Any]) -> Dict[str, Any]:
    """İki kopyadan hangisi temsilci olsun: alanı olan, sonra puanı yüksek olan."""
    key = lambda c: (c.get("_ring") is not None, c["puan"])  # noqa: E731
    return a if key(a) >= key(b) else b


def _dedupe(cands: List[Dict[str, Any]]) -> List[Dict[str, Any]]:
    # 1) Aynı Wikidata kaydı
    by_qid: Dict[str, Dict[str, Any]] = {}
    rest: List[Dict[str, Any]] = []
    for c in cands:
        if c["wikidata"]:
            prev = by_qid.get(c["wikidata"])
            if prev:
                keep = _better(prev, c)
                other = c if keep is prev else prev
                keep["osm"] = ";".join(sorted(set(keep["osm"].split(";") + other["osm"].split(";"))))
                by_qid[c["wikidata"]] = keep
            else:
                by_qid[c["wikidata"]] = c
        else:
            rest.append(c)

    # 2) Aynı ad, birbirine yakın (büyük yerlerde 2 km)
    result: List[Dict[str, Any]] = []
    for c in sorted(list(by_qid.values()) + rest, key=lambda c: -c["puan"]):
        limit = DUPLICATE_DISTANCE_AREA_M if c["kategori"] in AREA_CATEGORIES else DUPLICATE_DISTANCE_M
        dup = next((r for r in result
                    if fold(r["ad_tr"]) == fold(c["ad_tr"])
                    and haversine_m(r["enlem"], r["boylam"], c["enlem"], c["boylam"]) < limit),
                   None)
        if dup:
            dup["osm"] = ";".join(sorted(set(dup["osm"].split(";") + c["osm"].split(";"))))
            if dup.get("_ring") is None and c.get("_ring") is not None:
                dup["_ring"] = c["_ring"]
            for k in ("ad_en", "yapim_yili", "fotograf", "wikipedia_tr", "wikipedia_en"):
                if not dup.get(k) and c.get(k):
                    dup[k] = c[k]
        else:
            result.append(c)
    return result


def write_candidates(cands: List[Dict[str, Any]], out_dir: Path) -> Tuple[Path, Path]:
    csv_path = out_dir / "candidates.csv"
    # Türkçe Excel için ; ayırıcı ve BOM.
    with csv_path.open("w", encoding="utf-8-sig", newline="") as f:
        w = csv.DictWriter(f, fieldnames=CSV_COLUMNS, delimiter=";", extrasaction="ignore")
        w.writeheader()
        for c in cands:
            w.writerow({**{k: "" for k in CSV_COLUMNS}, **c})
    areas = {c["slug"]: simplify_ring(c["_ring"]) for c in cands if c.get("_ring")}
    areas_path = out_dir / "areas.json"
    areas_path.write_text(json.dumps(areas), encoding="utf-8")
    return csv_path, areas_path


# ---------------------------------------------------------------------------
# 3. build
# ---------------------------------------------------------------------------

def read_csv(path: Path) -> List[Dict[str, str]]:
    text = path.read_text(encoding="utf-8-sig")
    first = text.splitlines()[0] if text else ""
    delimiter = ";" if first.count(";") >= first.count(",") else ","
    return list(csv.DictReader(text.splitlines(), delimiter=delimiter))


def _sql_str(v: Optional[str]) -> str:
    if v is None or v == "":
        return "null"
    return "'" + str(v).replace("'", "''") + "'"


def _sql_num(v: Any) -> str:
    if v is None or str(v).strip() == "":
        return "null"
    s = str(v).strip().replace(",", ".")
    float(s)  # geçersizse ValueError
    return s


def ring_wkt(ring: List[List[float]]) -> str:
    coords = ", ".join(f"{x:.6f} {y:.6f}" for x, y in ring)
    return f"SRID=4326;POLYGON(({coords}))"


def build_sql(rows: List[Dict[str, str]], areas: Dict[str, Any],
              city_slug: str = CITY_SLUG, publish: bool = True) -> Tuple[str, Dict[str, Any]]:
    """Onaylı satırlar -> SQL. publish=False ise açıklaması dolu yerler de gizli kalır."""
    approved = [r for r in rows if r.get("onay", "").strip().lower() in APPROVE_VALUES]
    errors: List[str] = []
    places, translations, ready = [], [], []

    for i, r in enumerate(approved, start=1):
        slug = r.get("slug", "").strip()
        cat = r.get("kategori", "").strip()
        label = slug or f"onaylı satır {i}"
        if not re.fullmatch(r"[a-z0-9-]+", slug):
            errors.append(f"{label}: slug geçersiz")
            continue
        if cat not in CATEGORY_KIND:
            errors.append(f"{label}: bilinmeyen kategori '{cat}'")
            continue
        name_tr, name_en = r.get("ad_tr", "").strip(), r.get("ad_en", "").strip()
        if not name_tr or not name_en:
            errors.append(f"{label}: ad_tr ve ad_en dolu olmalı")
            continue
        try:
            lat, lng = float(_sql_num(r.get("enlem"))), float(_sql_num(r.get("boylam")))
            radius = _sql_num(r.get("yaricap_m")) if r.get("yaricap_m", "").strip() else str(DEFAULT_RADIUS_M[cat])
            year = _sql_num(r.get("yapim_yili"))
        except ValueError:
            errors.append(f"{label}: enlem/boylam/yarıçap/yıl sayı olmalı")
            continue
        ring = areas.get(slug) if r.get("alan_var", "").strip() else None
        area = _sql_str(ring_wkt(ring)) if ring else "null"
        places.append(
            f"  ({_sql_str(slug)}, {_sql_str(cat)}, {lat:.6f}, {lng:.6f}, {int(float(radius))}, "
            f"{_sql_str(r.get('donem', '').strip())}, {year}, {_sql_str(r.get('wikidata', '').strip())}, "
            f"{_sql_str(r.get('osm', '').strip())}, {area})")
        for lang, name in (("tr", name_tr), ("en", name_en)):
            translations.append(
                f"  ({_sql_str(slug)}, '{lang}', {_sql_str(name)}, "
                f"{_sql_str(r.get(f'kisa_aciklama_{lang}', '').strip())}, "
                f"{_sql_str(r.get(f'en_iyi_zaman_{lang}', '').strip())})")
        if r.get("kisa_aciklama_tr", "").strip() and r.get("kisa_aciklama_en", "").strip():
            ready.append(slug)

    stats = {"approved": len(approved), "written": len(places), "publishable": len(ready), "errors": errors}
    if not places:
        return "", stats

    now = datetime.now().strftime("%Y-%m-%d %H:%M")
    sql = f"""-- Otomatik üretildi: data-pipeline/pipeline.py build ({now})
-- {len(places)} yer; {_publish_note(len(ready), publish)}
-- Tekrar çalıştırılabilir: aynı slug'lı yerler güncellenir, kopya oluşmaz.
begin;

insert into public.places
  (city_id, category_id, slug, location, area, checkin_radius_m, period, built_year, wikidata_id, osm_id)
select ci.id, c.id, v.slug,
       st_setsrid(st_makepoint(v.lng::float8, v.lat::float8), 4326)::geography,
       case when v.area_wkt is null then null else st_geogfromtext(v.area_wkt) end,
       v.radius::int, v.period, v.built_year::int, v.wikidata_id, v.osm_id
from (values
{(","+chr(10)).join(places)}
) v(slug, category, lat, lng, radius, period, built_year, wikidata_id, osm_id, area_wkt)
join public.cities ci on ci.slug = {_sql_str(city_slug)}
join public.categories c on c.slug = v.category
on conflict (slug) do update set
  category_id = excluded.category_id,
  location = excluded.location,
  area = excluded.area,
  checkin_radius_m = excluded.checkin_radius_m,
  period = excluded.period,
  built_year = excluded.built_year,
  wikidata_id = excluded.wikidata_id,
  osm_id = excluded.osm_id;

insert into public.place_translations (place_id, lang, name, short_desc, best_time)
select p.id, v.lang, v.name, v.short_desc, v.best_time
from (values
{(","+chr(10)).join(translations)}
) v(slug, lang, name, short_desc, best_time)
join public.places p on p.slug = v.slug
on conflict (place_id, lang) do update set
  name = excluded.name,
  short_desc = coalesce(excluded.short_desc, public.place_translations.short_desc),
  best_time = coalesce(excluded.best_time, public.place_translations.best_time);
"""
    if ready and publish:
        sql += "\nupdate public.places set is_published = true\nwhere slug in (" + \
               ", ".join(_sql_str(s) for s in ready) + ");\n"
    sql += "\ncommit;\n"
    return sql, stats


# ---------------------------------------------------------------------------
# CLI
# ---------------------------------------------------------------------------

def _publish_note(ready: int, publish: bool) -> str:
    if publish:
        return f"{ready} tanesi TR+EN kısa açıklaması dolu olduğu için yayına alınır."
    return f"hepsi gizli (is_published = false); {ready} tanesinin TR+EN kısa açıklaması dolu."


def summarize(cands: Iterable[Dict[str, Any]]) -> str:
    counts: Dict[str, int] = {}
    for c in cands:
        counts[c["kategori"]] = counts.get(c["kategori"], 0) + 1
    by_kind = {k: sum(n for cat, n in counts.items() if CATEGORY_KIND[cat] == k) for k in QUOTAS}
    lines = [f"  tarihi: {by_kind['historical']}, doğa: {by_kind['nature']}"]
    lines += [f"    {cat}: {n}" for cat, n in sorted(counts.items(), key=lambda x: -x[1])]
    return "\n".join(lines)


def main(argv: Optional[List[str]] = None) -> int:
    ap = argparse.ArgumentParser(description="Gezi App veri hattı")
    ap.add_argument("--out", type=Path, default=None,
                    help="çıktı klasörü (varsayılan: output/, İstanbul dışı şehirlerde output/<şehir>/)")
    ap.add_argument("--city", default=DEFAULT_CITY, choices=sorted(CITIES), help="şehir (varsayılan: istanbul)")
    sub = ap.add_subparsers(dest="cmd", required=True)
    sub.add_parser("fetch", help="OSM ve Wikidata verisini indir")
    sub.add_parser("candidates", help="onay için candidates.csv üret")
    b = sub.add_parser("build", help="onaylı CSV'den SQL üret")
    b.add_argument("csv", type=Path, nargs="?", help="onaylanmış CSV (varsayılan: output/candidates.csv)")
    args = ap.parse_args(argv)

    city = get_city(args.city)
    out: Path = args.out or (DEFAULT_OUT if city.slug == DEFAULT_CITY else DEFAULT_OUT / city.slug)
    out.mkdir(parents=True, exist_ok=True)

    if args.cmd == "fetch":
        log(f"Şehir: {city.names['tr']}")
        fetch_osm(out, city)
        fetch_wikidata(out)
        log("Tamam. Sıradaki adım: python pipeline.py candidates")
        return 0

    if args.cmd == "candidates":
        osm = json.loads((out / "osm_raw.json").read_text(encoding="utf-8"))
        wd_path = out / "wikidata.json"
        wd = json.loads(wd_path.read_text(encoding="utf-8")) if wd_path.exists() else {}
        cands = build_candidates(osm, wd, city)
        csv_path, _ = write_candidates(cands, out)
        log(f"{len(cands)} aday -> {csv_path}\n{summarize(cands)}")
        log("Onaylamak istediğin satırların 'onay' sütununa x yaz, kısa açıklamaları doldur, kaydet.")
        log("Sonra: python pipeline.py build")
        return 0

    if args.cmd == "build":
        csv_path = args.csv or out / "candidates.csv"
        areas_path = out / "areas.json"
        areas = json.loads(areas_path.read_text(encoding="utf-8")) if areas_path.exists() else {}
        sql, stats = build_sql(read_csv(csv_path), areas, city.slug)
        for e in stats["errors"]:
            log(f"  atlandı: {e}")
        if not sql:
            log(f"Onaylı satır yok ({stats['approved']} onay). 'onay' sütununa x yazdığından emin ol.")
            return 1
        sql_path = out / "places_import.sql"
        sql_path.write_text(sql, encoding="utf-8")
        log(f"{stats['written']} yer -> {sql_path} ({stats['publishable']} tanesi yayına alınacak)")
        log("Supabase panelinde SQL Editor'a yapıştırıp çalıştır.")
        return 0
    return 2


if __name__ == "__main__":
    sys.exit(main())
