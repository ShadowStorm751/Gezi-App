#!/usr/bin/env python3
"""Onaylı yerler için Wikimedia Commons fotoğrafları: dosya, yazar, lisans.

1. Her yerin Wikidata kaydı (yoksa ada göre arama; bulunan kaydın koordinatı
   yere yakın olmalı) ve ana görseli (P18) bulunur.
2. Commons'tan görselin adresi, boyutu, yazarı ve lisansı alınır.
3. Yalnızca serbest lisanslar kabul edilir: CC0, kamu malı, CC BY, CC BY-SA
   (NC/ND ve diğerleri elenir).

Çıktı: results/photos.json   (slug -> fotoğraf bilgisi)
İnternet gerekir; GitHub Actions'ta çalışır (.github/workflows/photos.yml).
Yalnızca standart kütüphane.
"""
from __future__ import annotations

import html
import json
import re
import sys
import time
import urllib.parse
from pathlib import Path
from typing import Any, Dict, List, Optional

HERE = Path(__file__).resolve().parent
sys.path.insert(0, str(HERE))
sys.path.insert(0, str(HERE / "content"))

import pipeline as p  # noqa: E402

WIKIDATA_API = "https://www.wikidata.org/w/api.php"
COMMONS_API = "https://commons.wikimedia.org/w/api.php"
WIDTH = 1280
THUMB_WIDTH = 500
SEARCH_MAX_DISTANCE_M = 1500
SEARCH_MAX_DISTANCE_AREA_M = 5000


# ---------------------------------------------------------------------------
# Saf yardımcılar (testli)
# ---------------------------------------------------------------------------

def strip_html(text: str, max_len: int = 200) -> str:
    text = re.sub(r"<[^>]+>", " ", text or "")
    text = html.unescape(text)
    text = re.sub(r"\s+", " ", text).strip()
    return text[:max_len].rstrip()


def license_ok(short_name: str) -> bool:
    """Serbest lisans mı? CC0, kamu malı, CC BY, CC BY-SA kabul; NC/ND ve diğerleri değil."""
    s = (short_name or "").strip().lower()
    if not s:
        return False
    if re.search(r"\b(nc|nd)\b|noncommercial|noderiv", s):
        return False
    if s.startswith("cc0") or s.startswith("public domain") or s.startswith("pd") or s == "no restrictions":
        return True
    return bool(re.match(r"^cc[ -]by(-sa)?([ -]\d(\.\d)?)?(\s|$|[a-z ]*)", s))


def thumb_from(url: str, width: int) -> str:
    """Commons küçük resim adresini başka genişliğe çevirir (…/1280px-Dosya.jpg -> …/500px-Dosya.jpg)."""
    return re.sub(r"/\d+px-", f"/{width}px-", url, count=1) if "/thumb/" in url else url


def parse_imageinfo(page: Dict[str, Any]) -> Optional[Dict[str, Any]]:
    """Commons query yanıtındaki bir sayfadan fotoğraf bilgisi; lisans uygun değilse None."""
    infos = page.get("imageinfo") or []
    if not infos:
        return None
    ii = infos[0]
    meta = ii.get("extmetadata") or {}
    get = lambda k: (meta.get(k) or {}).get("value", "")  # noqa: E731
    lic = strip_html(get("LicenseShortName"), 60)
    if not license_ok(lic):
        return None
    if not str(ii.get("mime", "image/jpeg")).startswith("image/"):
        return None
    url = ii.get("thumburl") or ii.get("url")
    author = strip_html(get("Artist")) or strip_html(get("Credit")) or "Bilinmiyor / Unknown"
    return {
        "file": page.get("title", "").removeprefix("File:"),
        "url": url,
        "thumb_url": thumb_from(url, THUMB_WIDTH),
        "width": ii.get("thumbwidth") or ii.get("width"),
        "height": ii.get("thumbheight") or ii.get("height"),
        "author": author,
        "license": lic,
        "license_url": strip_html(get("LicenseUrl"), 300) or None,
        "source_url": ii.get("descriptionurl"),
    }


def entity_coord(entity: Dict[str, Any]) -> Optional[tuple]:
    for c in entity.get("claims", {}).get("P625", []):
        v = c.get("mainsnak", {}).get("datavalue", {}).get("value") or {}
        if "latitude" in v:
            return v["latitude"], v["longitude"]
    return None


def entity_image(entity: Dict[str, Any]) -> Optional[str]:
    for c in entity.get("claims", {}).get("P18", []):
        v = c.get("mainsnak", {}).get("datavalue", {}).get("value")
        if v:
            return v
    return None


def pick_search_hit(entities: List[Dict[str, Any]], lat: float, lng: float, max_m: float) -> Optional[Dict[str, Any]]:
    """Arama sonuçlarından koordinatı yere en yakın ve sınır içinde olanı seçer."""
    best, best_d = None, None
    for e in entities:
        if "Q5" in {c.get("mainsnak", {}).get("datavalue", {}).get("value", {}).get("id")
                    for c in e.get("claims", {}).get("P31", [])}:
            continue  # kişi kaydı
        coord = entity_coord(e)
        if not coord:
            continue
        d = p.haversine_m(lat, lng, coord[0], coord[1])
        if d <= max_m and (best_d is None or d < best_d):
            best, best_d = e, d
    return best


# ---------------------------------------------------------------------------
# Ağ
# ---------------------------------------------------------------------------

def _get(url: str, params: Dict[str, str]) -> Dict[str, Any]:
    q = urllib.parse.urlencode({**params, "format": "json"})
    raw = p._with_retries(lambda: p._request(f"{url}?{q}", None, timeout=60))
    time.sleep(0.5)
    return json.loads(raw)


def fetch_entities(qids: List[str]) -> Dict[str, Any]:
    out: Dict[str, Any] = {}
    for i in range(0, len(qids), 50):
        data = _get(WIKIDATA_API, {"action": "wbgetentities", "ids": "|".join(qids[i:i + 50]),
                                   "props": "claims|labels", "languages": "tr|en"})
        out.update(data.get("entities", {}))
    return out


def search_entity(name: str, lat: float, lng: float, max_m: float) -> Optional[Dict[str, Any]]:
    hits = _get(WIKIDATA_API, {"action": "wbsearchentities", "search": name, "language": "tr",
                               "uselang": "tr", "type": "item", "limit": "7"}).get("search", [])
    ids = [h["id"] for h in hits]
    if not ids:
        return None
    ents = fetch_entities(ids)
    return pick_search_hit([ents[i] for i in ids if i in ents], lat, lng, max_m)


def fetch_imageinfo(files: List[str]) -> Dict[str, Dict[str, Any]]:
    out: Dict[str, Dict[str, Any]] = {}
    for i in range(0, len(files), 40):
        batch = files[i:i + 40]
        data = _get(COMMONS_API, {"action": "query", "prop": "imageinfo",
                                  "iiprop": "url|size|mime|extmetadata", "iiurlwidth": str(WIDTH),
                                  "titles": "|".join("File:" + f for f in batch)})
        q = data.get("query", {})
        norm = {n["to"]: n["from"] for n in q.get("normalized", [])}
        for page in q.get("pages", {}).values():
            title = page.get("title", "")
            original = norm.get(title, title).removeprefix("File:")
            out[original] = page
    return out


# ---------------------------------------------------------------------------

def main() -> int:
    from istanbul_descriptions import DROPPED

    shortlist = json.loads((HERE / "results/shortlist.json").read_text(encoding="utf-8"))
    places = [s for s in shortlist if p.slugify(s["ad_tr"]) not in DROPPED]

    # 1) Wikidata kaydı
    known = sorted({s["wikidata"] for s in places if s.get("wikidata")})
    entities = fetch_entities(known)
    found_by_search: Dict[str, str] = {}
    for s in places:
        if s.get("wikidata"):
            continue
        slug = p.slugify(s["ad_tr"])
        max_m = SEARCH_MAX_DISTANCE_AREA_M if s["kategori"] in p.AREA_CATEGORIES else SEARCH_MAX_DISTANCE_M
        e = search_entity(s["ad_tr"], float(s["enlem"]), float(s["boylam"]), max_m)
        if e:
            entities[e["id"]] = e
            found_by_search[slug] = e["id"]
            p.log(f"  arama ile bulundu: {s['ad_tr']} -> {e['id']}")

    # 2) Görsel dosyaları
    file_for: Dict[str, str] = {}
    for s in places:
        slug = p.slugify(s["ad_tr"])
        qid = s.get("wikidata") or found_by_search.get(slug)
        img = entity_image(entities.get(qid, {})) if qid else None
        if img:
            file_for[slug] = img
    infos = fetch_imageinfo(sorted(set(file_for.values())))

    # 3) Lisans süzgeci
    photos: Dict[str, Any] = {}
    rejected: Dict[str, str] = {}
    for slug, f in file_for.items():
        info = parse_imageinfo(infos.get(f, {}))
        if info:
            photos[slug] = info
        else:
            lic = ((infos.get(f, {}).get("imageinfo") or [{}])[0].get("extmetadata") or {}).get("LicenseShortName", {})
            rejected[slug] = strip_html(lic.get("value", "")) or "bilgi yok"

    missing = sorted(p.slugify(s["ad_tr"]) for s in places if p.slugify(s["ad_tr"]) not in photos)
    result = {
        "photos": photos,
        "wikidata_found_by_search": found_by_search,
        "rejected_license": rejected,
        "missing": missing,
    }
    out = HERE / "results/photos.json"
    out.write_text(json.dumps(result, ensure_ascii=False, indent=1), encoding="utf-8")
    p.log(f"{len(photos)}/{len(places)} yerin fotoğrafı var; lisans nedeniyle elenen {len(rejected)}; eksik {len(missing)}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
