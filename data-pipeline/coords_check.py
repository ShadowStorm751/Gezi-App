#!/usr/bin/env python3
"""Wikidata'da konumu olmayan yerler için bağımsız konum kontrolü.

coords.py OSM konumunu Wikidata P625 ile karşılaştırır; Wikidata'da kayıt ya da konum yoksa yer
"wikidata_yok" kalır ve OSM konumu kontrolsüz kullanılır. Bu betik o yerler için:
  1. OSM öğesini OpenStreetMap API'sinden yeniden okur: hâlâ var mı, adı ne, konumu bizimkiyle aynı mı?
  2. Wikipedia (tr/en) maddesinin koordinatını alır (madde adı biliniyorsa ya da adla bulunursa).
  3. Adı dosya adında geçen, konum bilgili Commons fotoğraflarının konumlarına bakar (orta değer).
  4. Ana yeri olanlarda ana yere uzaklığı hesaplar.
Sonuç results/<şehir>/coords_check.json; şüpheli olanlar elle incelenir.

Kullanım: python data-pipeline/coords_check.py --city izmir
"""
from __future__ import annotations

import json
import statistics
import sys
from pathlib import Path
from typing import Any, Dict, List, Optional

HERE = Path(__file__).resolve().parent
sys.path.insert(0, str(HERE))
sys.path.insert(0, str(HERE / "content"))

import pipeline as p  # noqa: E402
import photos as ph  # noqa: E402
from cities import CITIES  # noqa: E402
from photo_search import commons_text_search, dist_m, file_coords  # noqa: E402

OSM_API = "https://api.openstreetmap.org/api/0.6"
WIKI_API = "https://{lang}.wikipedia.org/w/api.php"
CHECK_STATES = {"wikidata_yok"}


def tolerance_m(s: Dict[str, Any]) -> int:
    """Bağımsız kaynakla kabul edilebilir fark: iç yer < nokta < alan."""
    if s.get("ana_yer"):
        return 100
    if s["kategori"] in p.AREA_CATEGORIES:
        return 1500
    return 300


def osm_element(ref: str) -> Optional[Dict[str, Any]]:
    """'node/1', 'way/2', 'relation/3' -> {ad, merkez, silinmis}. İlişkilerde yalnızca etiketler."""
    kind, _, oid = ref.partition("/")
    url = f"{OSM_API}/{kind}/{oid}{'/full' if kind == 'way' else ''}.json"
    try:
        data = json.loads(p._request(url, None, timeout=60))
    except Exception as e:  # noqa: BLE001  (410 = silinmiş)
        return {"hata": str(e)[:120]}
    els = data.get("elements", [])
    me = next((e for e in els if e["type"] == kind and str(e["id"]) == oid), None)
    if not me:
        return {"hata": "öğe yok"}
    tags = me.get("tags", {})
    center = None
    if kind == "node":
        center = (me["lat"], me["lon"])
    elif kind == "way":
        nodes = [e for e in els if e["type"] == "node"]
        if nodes:
            center = (statistics.fmean(n["lat"] for n in nodes), statistics.fmean(n["lon"] for n in nodes))
    return {"ad": tags.get("name:tr") or tags.get("name"), "ad_en": tags.get("name:en"),
            "merkez": center, "etiketler": {k: v for k, v in tags.items() if not k.startswith("name:")}}


def wiki_coord(lang: str, title: str) -> Optional[tuple]:
    data = ph._get(WIKI_API.format(lang=lang), {"action": "query", "prop": "coordinates", "titles": title,
                                               "redirects": "1"})
    for page in data.get("query", {}).get("pages", {}).values():
        c = (page.get("coordinates") or [None])[0]
        if c:
            return (c["lat"], c["lon"])
    return None


def wiki_search_coord(name: str, here: tuple, max_m: float) -> Optional[Dict[str, Any]]:
    """trwiki'de adla ara; bulunan maddelerden koordinatı yakın olanı döndür."""
    data = ph._get(WIKI_API.format(lang="tr"), {"action": "query", "list": "search", "srsearch": name,
                                               "srlimit": "5"})
    for h in data.get("query", {}).get("search", []):
        c = wiki_coord("tr", h["title"])
        if c and dist_m(here, c) <= max_m:
            return {"madde": h["title"], "konum": c}
    return None


def commons_photo_positions(names: List[str], here: tuple, max_m: float) -> List[tuple]:
    kw = ph.name_keywords(*names)
    if not kw:
        return []
    titles: List[str] = []
    for h in ph.commons_geosearch(here[0], here[1], int(min(10000, max_m)), 100):
        if ph.title_matches(h["title"], kw):
            titles.append(h["title"])
    for n in dict.fromkeys(names):
        titles += [t for t in commons_text_search(f'"{n}"', 20) if t not in titles]
    coords = file_coords(titles[:80]) if titles else {}
    return [c for t, c in coords.items() if ph.title_matches(t, kw) and dist_m(here, c) <= 20000]


def check_place(s: Dict[str, Any], parent: Optional[Dict[str, Any]]) -> Dict[str, Any]:
    here = (float(s["enlem"]), float(s["boylam"]))
    tol = tolerance_m(s)
    names = [n for n in (s.get("ad_tr"), s.get("ad_en"), s.get("arama_adi")) if n]
    out: Dict[str, Any] = {"ad": s["ad_tr"], "konum": here, "tolerans_m": tol, "kanitlar": []}
    for ref in (s.get("osm") or "").split(";")[:1]:
        if ref:
            e = osm_element(ref)
            out["osm"] = {**e, "fark_m": round(dist_m(here, e["merkez"])) if e.get("merkez") else None}
    for lang in ("tr", "en"):
        t = s.get(f"wikipedia_{lang}")
        if t:
            c = wiki_coord(lang, t)
            if c:
                out["kanitlar"].append({"kaynak": f"wikipedia-{lang}: {t}", "fark_m": round(dist_m(here, c))})
    if not any(k["kaynak"].startswith("wikipedia") for k in out["kanitlar"]):
        hit = wiki_search_coord(s["ad_tr"], here, 20000)
        if hit:
            out["kanitlar"].append({"kaynak": f"wikipedia-tr (arama): {hit['madde']}",
                                    "fark_m": round(dist_m(here, hit["konum"]))})
    pos = commons_photo_positions(names, here, max(tol * 3, 1000))
    if pos:
        med = (statistics.median(c[0] for c in pos), statistics.median(c[1] for c in pos))
        out["kanitlar"].append({"kaynak": f"commons ({len(pos)} fotoğraf, orta değer)", "fark_m": round(dist_m(here, med)),
                                "konum": med})
    if parent:
        out["ana_yere_m"] = round(dist_m(here, (float(parent["enlem"]), float(parent["boylam"]))))
    diffs = [k["fark_m"] for k in out["kanitlar"]]
    if not diffs:
        out["sonuc"] = "kanit_yok"
    elif min(diffs) <= tol:
        out["sonuc"] = "dogrulandi"
    else:
        out["sonuc"] = "supheli"
    osm = out.get("osm") or {}
    if osm.get("hata") or (osm.get("fark_m") or 0) > tol:
        out["sonuc"] = "supheli"
    return out


def main(argv: Optional[List[str]] = None) -> int:
    import argparse
    ap = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    ap.add_argument("--city", required=True, choices=sorted(c for c in CITIES if c != "istanbul"))
    args = ap.parse_args(argv)
    rdir = ph.city_results(args.city)
    states = json.loads((rdir / "coords.json").read_text(encoding="utf-8"))["yerler"]
    shortlist = json.loads((rdir / "shortlist.json").read_text(encoding="utf-8"))
    by_slug = {(s.get("slug_override") or s["slug"]): s for s in shortlist}
    result: Dict[str, Any] = {}
    for slug, st in states.items():
        if st["durum"] not in CHECK_STATES or slug not in by_slug:
            continue
        s = by_slug[slug]
        result[slug] = check_place(s, by_slug.get(s.get("ana_yer") or ""))
        p.log(f"  {slug}: {result[slug]['sonuc']} {[k['fark_m'] for k in result[slug]['kanitlar']]}")
    summary = {k: sum(1 for v in result.values() if v["sonuc"] == k) for k in ("dogrulandi", "supheli", "kanit_yok")}
    (rdir / "coords_check.json").write_text(json.dumps({"ozet": summary, "yerler": result}, ensure_ascii=False,
                                                       indent=1), encoding="utf-8")
    p.log(f"{args.city}: {summary}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
