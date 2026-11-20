#!/usr/bin/env python3
"""Uzun açıklamalar için kaynak metin toplar (yalnızca bilgi kontrolü; metin kopyalanmaz).

Her yayındaki İstanbul yeri için:
  - TR ve EN Vikipedi makalesinin düz metni (ilk ~7000 karakter)
  - Wikidata'dan doğrulama için temel bilgiler: başlangıç yılı (P571), mimar (P84), mimari üslup (P149),
    resmi site (P856), miras statüsü (P1435)
Vikipedi başlığı shortlist.json'da yoksa ad + "İstanbul" ile arama yapılır (koordinat yakınlığı kontrolüyle).

Çıktı: results/wiki-extracts.json.gz  ({slug: {tr: {title, text}, en: {...}, wikidata: {...}}})
İnternet gerekir; GitHub Actions'ta çalışır (.github/workflows/wiki-extracts.yml).
"""
from __future__ import annotations

import gzip
import json
import sys
import time
import urllib.parse
from pathlib import Path
from typing import Any, Dict, List, Optional

HERE = Path(__file__).resolve().parent
sys.path.insert(0, str(HERE))
sys.path.insert(0, str(HERE / "content"))

import pipeline as p  # noqa: E402

OUT = HERE / "results/wiki-extracts.json.gz"
MAX_CHARS = 7000
WD_PROPS = {"P571": "inception", "P84": "architect", "P149": "style", "P856": "website", "P1435": "heritage"}


def api(lang: str, params: Dict[str, str]) -> Dict[str, Any]:
    url = f"https://{lang}.wikipedia.org/w/api.php?" + urllib.parse.urlencode({**params, "format": "json", "formatversion": "2"})
    return json.loads(p._with_retries(lambda: p._request(url, None, timeout=60)))


def wd(params: Dict[str, str]) -> Dict[str, Any]:
    url = p.WIKIDATA_API + "?" + urllib.parse.urlencode({**params, "format": "json"})
    return json.loads(p._with_retries(lambda: p._request(url, None, timeout=60)))


def extract(lang: str, title: str) -> Optional[Dict[str, str]]:
    data = api(lang, {"action": "query", "prop": "extracts|coordinates", "explaintext": "1",
                      "exsectionformat": "plain", "redirects": "1", "titles": title})
    pages = data.get("query", {}).get("pages", [])
    if not pages or pages[0].get("missing"):
        return None
    pg = pages[0]
    text = (pg.get("extract") or "").strip()
    if not text:
        return None
    coords = pg.get("coordinates") or []
    return {"title": pg.get("title", title), "text": text[:MAX_CHARS],
            "lat": coords[0]["lat"] if coords else None, "lng": coords[0]["lon"] if coords else None}


SEARCH_SUFFIX = {"istanbul": "İstanbul", "izmir": "İzmir", "bursa": "Bursa", "kapadokya": "Kapadokya"}


def search_title(lang: str, name: str, lat: float, lng: float, city: str = "istanbul") -> Optional[str]:
    data = api(lang, {"action": "query", "list": "search", "srsearch": f"{name} {SEARCH_SUFFIX.get(city, '')}".strip(),
                      "srlimit": "5"})
    for hit in data.get("query", {}).get("search", []):
        title = hit["title"]
        info = api(lang, {"action": "query", "prop": "coordinates", "titles": title})
        pages = info.get("query", {}).get("pages", [])
        coords = (pages[0].get("coordinates") or []) if pages else []
        if coords and p.haversine_m(lat, lng, coords[0]["lat"], coords[0]["lon"]) < 1500:
            return title
    return None


def sitelinks(qids: List[str]) -> Dict[str, Dict[str, Any]]:
    out: Dict[str, Dict[str, Any]] = {}
    for i in range(0, len(qids), 40):
        data = wd({"action": "wbgetentities", "ids": "|".join(qids[i:i + 40]), "props": "sitelinks|claims"})
        for qid, ent in data.get("entities", {}).items():
            links = ent.get("sitelinks", {})
            claims = ent.get("claims", {})
            facts: Dict[str, Any] = {}
            for prop, key in WD_PROPS.items():
                vals = []
                for c in claims.get(prop, []):
                    dv = c.get("mainsnak", {}).get("datavalue", {})
                    v = dv.get("value")
                    if isinstance(v, dict) and "time" in v:
                        vals.append(v["time"])
                    elif isinstance(v, dict) and "id" in v:
                        vals.append(v["id"])
                    elif isinstance(v, str):
                        vals.append(v)
                if vals:
                    facts[key] = vals
            out[qid] = {"trwiki": links.get("trwiki", {}).get("title"),
                        "enwiki": links.get("enwiki", {}).get("title"), "facts": facts}
        time.sleep(0.5)
    # Q-id değerlerinin (mimar, üslup, miras) etiketleri
    label_ids = sorted({v for e in out.values() for k in ("architect", "style", "heritage")
                        for v in e["facts"].get(k, []) if str(v).startswith("Q")})
    labels: Dict[str, str] = {}
    for i in range(0, len(label_ids), 40):
        data = wd({"action": "wbgetentities", "ids": "|".join(label_ids[i:i + 40]), "props": "labels",
                   "languages": "tr|en"})
        for qid, ent in data.get("entities", {}).items():
            lab = ent.get("labels", {})
            labels[qid] = (lab.get("tr") or lab.get("en") or {}).get("value", qid)
    for e in out.values():
        for k in ("architect", "style", "heritage"):
            if k in e["facts"]:
                e["facts"][k] = [labels.get(v, v) for v in e["facts"][k]]
    return out


def place_slug(r: Dict[str, Any], city: str) -> str:
    return p.slugify(r["ad_tr"]) if city == "istanbul" else (r.get("slug_override") or r["slug"])


def main(argv: Optional[List[str]] = None) -> int:
    import argparse
    import importlib
    ap = argparse.ArgumentParser(description="Uzun açıklamalar için Vikipedi kaynak metinleri")
    ap.add_argument("--city", default="istanbul")
    args = ap.parse_args(argv)
    city = args.city
    DROPPED = importlib.import_module(f"{city}_descriptions").DROPPED
    rdir = HERE / "results" if city == "istanbul" else HERE / "results" / city
    out_path = OUT if city == "istanbul" else rdir / "wiki-extracts.json.gz"
    rows = [r for r in json.loads((rdir / "shortlist.json").read_text(encoding="utf-8"))
            if place_slug(r, city) not in DROPPED]
    qids = sorted({r["wikidata"] for r in rows if r.get("wikidata")})
    links = sitelinks(qids)
    result: Dict[str, Any] = {}
    for r in rows:
        slug = place_slug(r, city)
        lat, lng = float(r["enlem"]), float(r["boylam"])
        entry: Dict[str, Any] = {"name_tr": r["ad_tr"], "name_en": r.get("ad_en"), "qid": r.get("wikidata") or None}
        wdi = links.get(r.get("wikidata") or "", {})
        entry["wikidata"] = wdi.get("facts", {})
        for lang, field, name in (("tr", "wikipedia_tr", r["ad_tr"]), ("en", "wikipedia_en", r.get("ad_en") or r["ad_tr"])):
            title = r.get(field) or wdi.get(f"{lang}wiki")
            source = "shortlist/wikidata"
            try:
                if not title:
                    title = search_title(lang, name, lat, lng, city)
                    source = "search"
                ex = extract(lang, title) if title else None
            except Exception as exc:  # bir yer başarısız olursa diğerlerine devam
                p.log(f"{slug}/{lang}: {exc}")
                ex = None
            if ex:
                ex["source"] = source
                if ex.get("lat") is not None:
                    ex["distance_m"] = round(p.haversine_m(lat, lng, ex["lat"], ex["lng"]))
            entry[lang] = ex
            time.sleep(0.3)
        result[slug] = entry
        p.log(f"{slug}: tr={'+' if entry['tr'] else '-'} en={'+' if entry['en'] else '-'}")
    out_path.parent.mkdir(parents=True, exist_ok=True)
    with gzip.open(out_path, "wt", encoding="utf-8") as f:
        json.dump(result, f, ensure_ascii=False)
    have = sum(1 for e in result.values() if e["tr"] or e["en"])
    p.log(f"{have}/{len(result)} yer için kaynak metin")
    return 0


if __name__ == "__main__":
    sys.exit(main())
