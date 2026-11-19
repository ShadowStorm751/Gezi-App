#!/usr/bin/env python3
"""Onaylı yerler için Wikimedia Commons fotoğrafları: dosya, yazar, lisans.

1. Her yerin Wikidata kaydı (yoksa ada göre arama; bulunan kaydın koordinatı
   yere yakın olmalı) ve ana görseli (P18) bulunur.
2. Commons'tan görselin adresi, boyutu, yazarı ve lisansı alınır.
3. Yalnızca serbest lisanslar kabul edilir: CC0, kamu malı, CC BY, CC BY-SA
   (NC/ND ve diğerleri elenir).

Çıktı: results/photos.json   (slug -> fotoğraf bilgisi); --city ile results/<şehir>/photos.json
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
from cities import CITIES, DEFAULT_CITY  # noqa: E402

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
    """Serbest lisans mı? CC0, kamu malı, CC BY, CC BY-SA, FAL kabul; NC/ND ve diğerleri değil."""
    s = (short_name or "").strip().lower()
    if not s:
        return False
    if re.search(r"\b(nc|nd)\b|noncommercial|noderiv", s):
        return False
    if s.startswith("cc0") or s.startswith("public domain") or s.startswith("pd") or s == "no restrictions":
        return True
    if s in ("fal", "free art license", "licence art libre") or s.startswith("free art license"):
        return True  # Free Art License: ticari kullanıma ve değiştirmeye izin verir (CC BY-SA benzeri)
    return bool(re.match(r"^cc[ -]by(-sa)?([ -]\d(\.\d)?)?(\s|$|[a-z ]*)", s))


def clean_url(url: str) -> str:
    """Wikimedia'nın eklediği utm_ takip parametrelerini atar."""
    if not url or "?" not in url:
        return url
    base, query = url.split("?", 1)
    keep = [kv for kv in query.split("&") if not kv.startswith("utm_")]
    return base + ("?" + "&".join(keep) if keep else "")


def clean_author(text: str) -> str:
    text = re.sub(r"\(\s*(talk|discussion|tartışma|contribs?)\s*\)", "", text, flags=re.I)
    return re.sub(r"\s+", " ", text).strip(" ,;")


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
    url = clean_url(ii.get("thumburl") or ii.get("url"))
    author = clean_author(strip_html(get("Artist"))) or clean_author(strip_html(get("Credit"))) or "Bilinmiyor / Unknown"
    return {
        "file": page.get("title", "").removeprefix("File:"),
        "url": url,
        "thumb_url": thumb_from(url, THUMB_WIDTH),
        "width": ii.get("thumbwidth") or ii.get("width"),
        "height": ii.get("thumbheight") or ii.get("height"),
        "author": author,
        "license": lic,
        "license_url": strip_html(get("LicenseUrl"), 300) or None,
        "source_url": clean_url(ii.get("descriptionurl")),
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

# ---------------------------------------------------------------------------
# Yedek yol: Wikidata'da ana görsel yoksa Commons'ta ara (yalnızca yeni şehirler, --commons-fallback)
# ---------------------------------------------------------------------------

GENERIC_WORDS = {
    "plaji", "plaj", "sahili", "camii", "cami", "kilisesi", "kilise", "muzesi", "muze", "selalesi", "vadisi",
    "koyu", "tepesi", "tepe", "kalesi", "adasi", "parki", "bahcesi", "turbesi", "hani", "han", "sapeli",
    "seyir", "noktasi", "tarihi", "eski", "antik", "buyuk", "kucuk", "sarayi", "valley", "beach", "church",
    "museum", "the", "and", "yeralti", "sehri", "kenti", "alani", "tabiat", "milli", "acik", "hava",
}


def name_keywords(*names: str) -> List[str]:
    """Dosya adında aranacak ayırt edici sözcükler (katlanmış, genel sözcükler hariç)."""
    out: List[str] = []
    for n in names:
        for w in re.split(r"[^a-z0-9]+", p.fold(n or "")):
            if len(w) >= 4 and w not in GENERIC_WORDS and w not in out:
                out.append(w)
    return out


def title_matches(title: str, keywords: List[str]) -> bool:
    t = p.fold(title)
    return any(k in t for k in keywords)


def commons_category_files(category: str, limit: int = 30) -> List[str]:
    data = _get(COMMONS_API, {"action": "query", "list": "categorymembers", "cmtitle": f"Category:{category}",
                              "cmtype": "file", "cmlimit": str(limit), "format": "json"})
    return [m["title"] for m in data.get("query", {}).get("categorymembers", [])]


def commons_geosearch(lat: float, lng: float, radius_m: int, limit: int = 50) -> List[Dict[str, Any]]:
    data = _get(COMMONS_API, {"action": "query", "list": "geosearch", "gscoord": f"{lat}|{lng}",
                              "gsradius": str(max(10, min(10000, radius_m))), "gsnamespace": "6",
                              "gslimit": str(limit), "format": "json"})
    return data.get("query", {}).get("geosearch", [])


def entity_commons_category(entity: Dict[str, Any]) -> Optional[str]:
    claims = (entity or {}).get("claims", {}).get("P373") or []
    try:
        return claims[0]["mainsnak"]["datavalue"]["value"]
    except (KeyError, IndexError, TypeError):
        return None


def is_photo_file(title: str) -> bool:
    return bool(re.search(r"\.(jpe?g|png|webp)$", title, re.I))


def commons_fallback(s: Dict[str, Any], entity: Optional[Dict[str, Any]]) -> Optional[Dict[str, Any]]:
    """Önce kaydın Commons kategorisi, sonra adı dosya adında geçen yakındaki fotoğraflar."""
    kw = name_keywords(s["ad_tr"], s.get("ad_en", ""))
    candidates: List[tuple] = []
    cat = entity_commons_category(entity) if entity else None
    if cat:
        candidates += [("commons-kategori", t) for t in commons_category_files(cat) if is_photo_file(t)]
    if kw:
        radius = 80 if s.get("ana_yer") else (1500 if s["kategori"] in p.AREA_CATEGORIES else 400)
        hits = sorted(commons_geosearch(float(s["enlem"]), float(s["boylam"]), radius), key=lambda h: h.get("dist", 0))
        candidates += [("commons-yakin", h["title"]) for h in hits
                       if is_photo_file(h["title"]) and title_matches(h["title"], kw)]
    p.log(f"  yedek yol {s['ad_tr']}: kategori={cat or '-'} aday={len(candidates)} sözcük={kw}")
    if not candidates:
        return None
    # fetch_imageinfo dosya adlarını "File:" öneki olmadan alır ve öyle döndürür
    names = [t.removeprefix("File:") for _, t in candidates[:40]]
    infos = fetch_imageinfo(names)
    for (source, _), name in zip(candidates[:40], names):
        title = name
        info = parse_imageinfo(infos.get(name, {}))
        if info and (info.get("width") or 0) >= 800:
            info.update(kaynak=source, dosya=title)
            return info
    return None


def city_results(slug: str) -> Path:
    """İstanbul: results/, diğer şehirler: results/<şehir>/."""
    return HERE / "results" if slug == DEFAULT_CITY else HERE / "results" / slug


def main(argv: Optional[List[str]] = None) -> int:
    import argparse
    import importlib

    ap = argparse.ArgumentParser(description="Onaylı yerlerin Commons fotoğrafları")
    ap.add_argument("--city", default=DEFAULT_CITY, choices=sorted(CITIES))
    ap.add_argument("--commons-fallback", action="store_true",
                    help="Wikidata'da görseli olmayan yerler için Commons kategorisi ve yakındaki dosyalar")
    args = ap.parse_args(argv)
    try:
        DROPPED = importlib.import_module(f"{args.city}_descriptions").DROPPED
    except ModuleNotFoundError:
        DROPPED = {}
    rdir = city_results(args.city)

    shortlist = json.loads((rdir / "shortlist.json").read_text(encoding="utf-8"))
    places = [s for s in shortlist if (s.get("slug_override") or p.slugify(s["ad_tr"])) not in DROPPED]

    # 1) Wikidata kaydı
    known = sorted({s["wikidata"] for s in places if s.get("wikidata")})
    entities = fetch_entities(known)
    found_by_search: Dict[str, str] = {}
    for s in places:
        if s.get("wikidata"):
            continue
        slug = (s.get("slug_override") or p.slugify(s["ad_tr"]))
        max_m = SEARCH_MAX_DISTANCE_AREA_M if s["kategori"] in p.AREA_CATEGORIES else SEARCH_MAX_DISTANCE_M
        e = search_entity(s["ad_tr"], float(s["enlem"]), float(s["boylam"]), max_m)
        if e:
            entities[e["id"]] = e
            found_by_search[slug] = e["id"]
            p.log(f"  arama ile bulundu: {s['ad_tr']} -> {e['id']}")

    # 2) Görsel dosyaları
    file_for: Dict[str, str] = {}
    for s in places:
        slug = (s.get("slug_override") or p.slugify(s["ad_tr"]))
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

    # 4) Yedek yol (yalnızca istenirse; İstanbul çıktısı değişmesin)
    fallback: Dict[str, str] = {}
    if args.commons_fallback:
        for s in places:
            slug = s.get("slug_override") or p.slugify(s["ad_tr"])
            if slug in photos:
                continue
            qid = s.get("wikidata") or found_by_search.get(slug)
            info = commons_fallback(s, entities.get(qid) if qid else None)
            if info:
                photos[slug] = info
                fallback[slug] = f"{info['kaynak']}: {info['dosya']}"
                p.log(f"  yedek yol: {slug} -> {info['dosya']}")

    missing = sorted((s.get("slug_override") or p.slugify(s["ad_tr"])) for s in places if (s.get("slug_override") or p.slugify(s["ad_tr"])) not in photos)
    result = {
        "photos": photos,
        "wikidata_found_by_search": found_by_search,
        "rejected_license": rejected,
        "commons_fallback": fallback,   # elle gözden geçirilecek
        "missing": missing,
    }
    out = rdir / "photos.json"
    out.write_text(json.dumps(result, ensure_ascii=False, indent=1), encoding="utf-8")
    p.log(f"{len(photos)}/{len(places)} yerin fotoğrafı var; lisans nedeniyle elenen {len(rejected)}; eksik {len(missing)}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
