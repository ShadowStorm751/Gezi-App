#!/usr/bin/env python3
"""Fotoğrafı olmayan yerler için Commons'tan aday fotoğraflar toplar (elle seçim için).

Her yer için iki kaynak:
  - Commons'ta ada göre dosya araması
  - Yerin koordinatı çevresinde çekilmiş (konum bilgili) dosyalar
Yalnızca serbest lisanslı görseller (photos.license_ok). Her yerin en fazla 8 adayının
330 px küçük resmi indirilir; seçim insan/Claude tarafından yapılır.

Çıktı: results/photo-candidates/candidates.json ve results/photo-candidates/<slug>/<n>.jpg
İnternet gerekir; GitHub Actions'ta çalışır (.github/workflows/photo-candidates.yml).
"""
from __future__ import annotations

import json
import sys
import time
import urllib.parse
from pathlib import Path
from typing import Any, Dict, List

HERE = Path(__file__).resolve().parent
sys.path.insert(0, str(HERE))
sys.path.insert(0, str(HERE / "content"))

import pipeline as p  # noqa: E402
import photos as ph  # noqa: E402

OUT = HERE / "results/photo-candidates"
PER_PLACE = 8
SMALL = 330


def commons(params: Dict[str, str]) -> Dict[str, Any]:
    return ph._get(ph.COMMONS_API, params)


def text_search(name: str) -> List[str]:
    data = commons({"action": "query", "list": "search", "srsearch": f"{name} İstanbul",
                    "srnamespace": "6", "srlimit": "8"})
    return [h["title"].removeprefix("File:") for h in data.get("query", {}).get("search", [])]


def geo_search(lat: float, lng: float, radius: int) -> List[str]:
    data = commons({"action": "query", "list": "geosearch", "gscoord": f"{lat}|{lng}",
                    "gsradius": str(radius), "gsnamespace": "6", "gslimit": "20"})
    return [h["title"].removeprefix("File:") for h in data.get("query", {}).get("geosearch", [])]


def imageinfo_small(files: List[str]) -> Dict[str, Dict[str, Any]]:
    out: Dict[str, Dict[str, Any]] = {}
    for i in range(0, len(files), 40):
        data = commons({"action": "query", "prop": "imageinfo",
                        "iiprop": "url|size|mime|extmetadata", "iiurlwidth": str(ph.WIDTH),
                        "titles": "|".join("File:" + f for f in files[i:i + 40])})
        q = data.get("query", {})
        norm = {n["to"]: n["from"] for n in q.get("normalized", [])}
        for page in q.get("pages", {}).values():
            title = page.get("title", "")
            out[norm.get(title, title).removeprefix("File:")] = page
    return out


def main() -> int:
    from istanbul_descriptions import DROPPED
    sys.path.insert(0, str(HERE / "content"))
    from build_istanbul import COORD_FIX  # noqa: E402
    from build_photos import EXCLUDE  # noqa: E402

    photos = json.loads((HERE / "results/photos.json").read_text(encoding="utf-8"))
    missing = sorted(set(photos["missing"]) | set(EXCLUDE))
    shortlist = {p.slugify(s["ad_tr"]): s for s in json.loads(
        (HERE / "results/shortlist.json").read_text(encoding="utf-8")) if p.slugify(s["ad_tr"]) not in DROPPED}

    OUT.mkdir(parents=True, exist_ok=True)
    result: Dict[str, Any] = {}
    for slug in missing:
        s = shortlist[slug]
        lat, lng = float(s["enlem"]), float(s["boylam"])
        if slug in COORD_FIX:
            lat, lng = COORD_FIX[slug][0], COORD_FIX[slug][1]
        radius = 1000 if s["kategori"] in p.AREA_CATEGORIES or s["kategori"] in ("hill", "beach") else 300
        names: List[str] = []
        try:
            names += text_search(s["ad_tr"])
            names += geo_search(lat, lng, radius)
        except Exception as exc:  # bir yer başarısız olursa diğerlerine devam
            p.log(f"{slug}: arama hatası {exc}")
        seen, files = set(), []
        for f in names:
            if f not in seen and f.lower().rsplit(".", 1)[-1] in ("jpg", "jpeg", "png", "webp"):
                seen.add(f)
                files.append(f)
        infos = imageinfo_small(files) if files else {}
        cands = []
        for f in files:
            info = ph.parse_imageinfo(infos.get(f, {}))
            if not info:
                continue
            cands.append(info)
            if len(cands) >= PER_PLACE:
                break
        d = OUT / slug
        d.mkdir(exist_ok=True)
        for n, c in enumerate(cands, start=1):
            small = ph.thumb_from(c["url"], SMALL)
            try:
                (d / f"{n}.jpg").write_bytes(p._with_retries(lambda: p._request(small, None, timeout=60)))
                c["preview"] = f"{slug}/{n}.jpg"
            except Exception as exc:
                c["preview"] = None
                p.log(f"{slug}/{n}: indirilemedi {exc}")
            time.sleep(0.3)
        result[slug] = {"name": s["ad_tr"], "lat": lat, "lng": lng, "candidates": cands}
        p.log(f"{slug}: {len(cands)} aday")
    (OUT / "candidates.json").write_text(json.dumps(result, ensure_ascii=False, indent=1), encoding="utf-8")
    return 0


if __name__ == "__main__":
    sys.exit(main())
