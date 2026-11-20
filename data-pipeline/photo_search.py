#!/usr/bin/env python3
"""Fotoğrafı eksik yerler için Commons'ta geniş arama: elle gözden geçirmek üzere aday listesi ve temas sayfası.

photos.py yalnızca güvenli eşleşmeleri otomatik kabul eder. Bu betik daha geniş arar
(Commons metin araması, Wikipedia sayfa görselleri, yakındaki dosyalar) ve hiçbirini otomatik kabul etmez:
adaylar results/<şehir>/photo_candidates.json ve photo_candidates-<n>.png olarak yazılır,
seçilenler <şehir>_descriptions.py içindeki PHOTO_PICK sözlüğüne elle girilir.

Kullanım: python data-pipeline/photo_search.py --city izmir [--per-place 8]
"""
from __future__ import annotations

import json
import math
import sys
from pathlib import Path
from typing import Any, Dict, List, Optional

HERE = Path(__file__).resolve().parent
sys.path.insert(0, str(HERE))
sys.path.insert(0, str(HERE / "content"))

import pipeline as p  # noqa: E402
import photos as ph  # noqa: E402
from cities import CITIES, get_city  # noqa: E402

WIKI_API = "https://{lang}.wikipedia.org/w/api.php"


def dist_m(a: tuple, b: tuple) -> float:
    la1, lo1, la2, lo2 = map(math.radians, (a[0], a[1], b[0], b[1]))
    h = math.sin((la2 - la1) / 2) ** 2 + math.cos(la1) * math.cos(la2) * math.sin((lo2 - lo1) / 2) ** 2
    return 2 * 6371000 * math.asin(math.sqrt(h))


def commons_text_search(query: str, limit: int = 12) -> List[str]:
    data = ph._get(ph.COMMONS_API, {"action": "query", "list": "search", "srsearch": query,
                                    "srnamespace": "6", "srlimit": str(limit)})
    return [h["title"] for h in data.get("query", {}).get("search", []) if ph.is_photo_file(h["title"])]


def wiki_page_images(lang: str, title: str) -> List[str]:
    """Wikipedia maddesindeki görseller (yalnızca Commons'takiler işe yarar; lisans sonra süzülür)."""
    if not title:
        return []
    data = ph._get(WIKI_API.format(lang=lang), {"action": "query", "prop": "images", "titles": title,
                                               "imlimit": "30", "redirects": "1"})
    out: List[str] = []
    for page in data.get("query", {}).get("pages", {}).values():
        for im in page.get("images", []):
            t = im["title"].split(":", 1)[-1]
            if ph.is_photo_file(t) and not any(w in t.lower() for w in ("flag", "logo", "icon", "map", "harita")):
                out.append("File:" + t)
    return out


def file_coords(titles: List[str]) -> Dict[str, tuple]:
    out: Dict[str, tuple] = {}
    for i in range(0, len(titles), 40):
        data = ph._get(ph.COMMONS_API, {"action": "query", "prop": "coordinates",
                                        "titles": "|".join(titles[i:i + 40])})
        for page in data.get("query", {}).get("pages", {}).values():
            c = (page.get("coordinates") or [None])[0]
            if c:
                out[page["title"]] = (c["lat"], c["lon"])
    return out


def search_radius(s: Dict[str, Any]) -> int:
    if s.get("ana_yer"):
        return 150
    return 3000 if s["kategori"] in p.AREA_CATEGORIES else 800


def candidates_for(s: Dict[str, Any], city_name: str, reject: frozenset, per_place: int) -> List[Dict[str, Any]]:
    names = [n for n in (s.get("ad_tr"), s.get("ad_en"), s.get("arama_adi")) if n]
    titles: List[tuple] = []
    seen = set()

    def add(src: str, t: str) -> None:
        t = t if t.startswith("File:") else "File:" + t
        if t not in seen and t.removeprefix("File:") not in reject:
            seen.add(t)
            titles.append((src, t))

    for n in dict.fromkeys(names):
        for q in (f'"{n}"', f"{n} {city_name}"):
            for t in commons_text_search(q):
                add("metin", t)
    for lang, key in (("tr", "wikipedia_tr"), ("en", "wikipedia_en")):
        for t in wiki_page_images(lang, s.get(key) or ""):
            add("wikipedia-" + lang, t)
    here = (float(s["enlem"]), float(s["boylam"]))
    for h in sorted(ph.commons_geosearch(here[0], here[1], search_radius(s), 30), key=lambda h: h.get("dist", 0))[:10]:
        if ph.is_photo_file(h["title"]):
            add("yakin", h["title"])
    if not titles:
        return []
    names_only = [t for _, t in titles[:60]]
    infos = ph.fetch_imageinfo([t.removeprefix("File:") for t in names_only])
    coords = file_coords(names_only)
    kw = ph.name_keywords(*names)
    out: List[Dict[str, Any]] = []
    for src, t in titles[:60]:
        info = ph.parse_imageinfo(infos.get(t.removeprefix("File:"), {}))
        if not info or (info.get("width") or 0) < 800:
            continue
        c = coords.get(t)
        d = round(dist_m(here, c)) if c else None
        score = (2 if ph.title_matches(t, kw) else 0) + (2 if d is not None and d <= search_radius(s) else 0) \
            + (1 if src.startswith("wikipedia") else 0) - (1 if d is not None and d > 5 * search_radius(s) else 0)
        out.append({"kaynak": src, "dosya": t.removeprefix("File:"), "mesafe_m": d, "puan": score,
                    "thumb": ph.thumb_from(info["url"], 240), "lisans": info["license"], "yazar": info["author"]})
    out.sort(key=lambda x: -x["puan"])
    return out[:per_place]


def contact_sheets(rdir: Path, result: Dict[str, List[Dict[str, Any]]]) -> List[str]:
    """Aday küçük resimlerinden temas sayfaları (satır başına bir yer). Pillow yoksa atlanır."""
    try:
        from PIL import Image, ImageDraw, ImageFont
    except ImportError:
        p.log("Pillow yok; temas sayfası çizilmedi")
        return []
    import io
    W, H, LABEL, COLS = 220, 165, 230, 8
    try:
        font = ImageFont.truetype("/usr/share/fonts/truetype/dejavu/DejaVuSans.ttf", 13)
    except OSError:
        font = ImageFont.load_default()
    rows = [(slug, cands) for slug, cands in result.items()]
    pages: List[str] = []
    for pi in range(0, len(rows), 6):
        chunk = rows[pi:pi + 6]
        sheet = Image.new("RGB", (LABEL + COLS * W, len(chunk) * (H + 22)), "white")
        draw = ImageDraw.Draw(sheet)
        for ri, (slug, cands) in enumerate(chunk):
            y = ri * (H + 22)
            draw.text((6, y + 6), slug, fill="black", font=font)
            if not cands:
                draw.text((6, y + 26), "(aday yok)", fill="gray", font=font)
            for ci, c in enumerate(cands[:COLS]):
                x = LABEL + ci * W
                try:
                    raw = p._with_retries(lambda: p._request(c["thumb"], None, timeout=60))
                    im = Image.open(io.BytesIO(raw)).convert("RGB")
                    im.thumbnail((W - 6, H - 6))
                    sheet.paste(im, (x + 3, y + 3))
                except Exception as e:  # noqa: BLE001
                    draw.text((x + 6, y + 40), f"indirilemedi: {e}"[:30], fill="red", font=font)
                d = "" if c["mesafe_m"] is None else f" {c['mesafe_m']}m"
                draw.text((x + 4, y + H + 2), f"#{ci} {c['kaynak']}{d}"[:30], fill="black", font=font)
        name = f"photo_candidates-{pi // 6 + 1}.png"
        sheet.save(rdir / name, optimize=True)
        pages.append(name)
    return pages


def main(argv: Optional[List[str]] = None) -> int:
    import argparse
    import importlib

    ap = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    ap.add_argument("--city", required=True, choices=sorted(c for c in CITIES if c != "istanbul"))
    ap.add_argument("--per-place", type=int, default=8)
    args = ap.parse_args(argv)
    city = get_city(args.city)
    desc = importlib.import_module(f"{args.city}_descriptions")
    reject = frozenset(getattr(desc, "PHOTO_REJECT_FILES", {}))
    rdir = ph.city_results(args.city)
    missing = set(json.loads((rdir / "photos.json").read_text(encoding="utf-8"))["missing"])
    shortlist = json.loads((rdir / "shortlist.json").read_text(encoding="utf-8"))
    city_name = {"izmir": "İzmir", "bursa": "Bursa", "kapadokya": "Cappadocia"}.get(args.city, args.city)
    result: Dict[str, List[Dict[str, Any]]] = {}
    for s in shortlist:
        slug = s.get("slug_override") or p.slugify(s["ad_tr"])
        if slug not in missing:
            continue
        result[slug] = candidates_for(s, city_name, reject, args.per_place)
        p.log(f"  {slug}: {len(result[slug])} aday")
    (rdir / "photo_candidates.json").write_text(json.dumps(result, ensure_ascii=False, indent=1), encoding="utf-8")
    pages = contact_sheets(rdir, result)
    p.log(f"{city.slug}: {len(result)} eksik yer, {sum(1 for v in result.values() if v)} tanesinde aday var; "
          f"sayfalar: {', '.join(pages) or '-'}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
