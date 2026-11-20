#!/usr/bin/env python3
"""Fotoğrafı hâlâ olmayan yerler için hedefli aday arama (elle seçim için).

photo_candidates.py genel aramada uygun aday bulamadığı yerler için her yere özel
arama terimleri, daha geniş konum yarıçapı ve Wikidata (P18 görsel, P373 Commons kategorisi)
kullanır. Yalnızca serbest lisanslı görseller (photos.license_ok). Her yer için en fazla
12 adayın küçük önizlemesi indirilir.

Çıktı: results/photo-candidates-2/candidates.json ve results/photo-candidates-2/<slug>/<n>.jpg
İnternet gerekir; GitHub Actions'ta çalışır (.github/workflows/photo-candidates-2.yml).
"""
from __future__ import annotations

import json
import sys
import time
from pathlib import Path
from typing import Any, Dict, List

HERE = Path(__file__).resolve().parent
sys.path.insert(0, str(HERE))

import pipeline as p  # noqa: E402
import photos as ph  # noqa: E402
from photo_candidates import commons, geo_search, imageinfo_small, SMALL  # noqa: E402

OUT = HERE / "results/photo-candidates-2"
PER_PLACE = 12

# slug -> (enlem, boylam, geo yarıçap m, wikidata, arama terimleri)
TARGETS: Dict[str, Any] = {
    "aydos-ormani": (40.936208, 29.245396, 3000, "Q6015490",
                     ["Aydos Ormanı", "Aydos forest", "Aydos Tepesi", "Aydos Kartal", "Aydos Sultanbeyli"]),
    "beykoz-korusu": (41.132905, 29.098435, 800, "Q6074699",
                      ["Beykoz Korusu", "Beykoz grove", "Beykoz park", "Beykoz Boğaz manzara"]),
    "hacilli-selalesi": (41.037551, 29.781229, 3000, None,
                         ["Hacıllı şelalesi", "Hacıllı waterfall", "Şile şelale", "Şile waterfall", "Hacıllı Şile"]),
    "telli-baba-turbesi": (41.17527, 29.07184, 250, None,
                           ["Telli Baba", "Telli Baba türbesi", "Telli Baba tomb", "Tellibaba"]),
    "yenikoy-seyir-terasi": (41.319803, 28.722321, 2500, None,
                             ["Yeniköy Arnavutköy", "Yeniköy Karadeniz", "Yeniköy Black Sea", "Arnavutköy Karadeniz sahil"]),
}


def text_search(term: str) -> List[str]:
    data = commons({"action": "query", "list": "search", "srsearch": term, "srnamespace": "6", "srlimit": "10"})
    return [h["title"].removeprefix("File:") for h in data.get("query", {}).get("search", [])]


def category_files(cat: str) -> List[str]:
    data = commons({"action": "query", "list": "categorymembers", "cmtitle": "Category:" + cat,
                    "cmtype": "file", "cmlimit": "30"})
    return [h["title"].removeprefix("File:") for h in data.get("query", {}).get("categorymembers", [])]


def wikidata_files(qid: str) -> List[str]:
    ent = ph.fetch_entities([qid]).get(qid, {})
    files: List[str] = []
    img = ph.entity_image(ent)
    if img:
        files.append(img)
    for c in ent.get("claims", {}).get("P373", []):
        cat = c.get("mainsnak", {}).get("datavalue", {}).get("value")
        if cat:
            files += category_files(cat)
    return files


def main() -> int:
    OUT.mkdir(parents=True, exist_ok=True)
    result: Dict[str, Any] = {}
    for slug, (lat, lng, radius, qid, terms) in TARGETS.items():
        names: List[str] = []
        try:
            if qid:
                names += wikidata_files(qid)
            for t in terms:
                names += text_search(t)
            names += geo_search(lat, lng, min(radius, 10000))
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
            info["file"] = f
            cands.append(info)
            if len(cands) >= PER_PLACE:
                break
        d = OUT / slug
        d.mkdir(exist_ok=True)
        for n, c in enumerate(cands, start=1):
            try:
                (d / f"{n}.jpg").write_bytes(p._with_retries(lambda: p._request(ph.thumb_from(c["url"], SMALL), None, timeout=60)))
                c["preview"] = f"{slug}/{n}.jpg"
            except Exception as exc:
                c["preview"] = None
                p.log(f"{slug}/{n}: indirilemedi {exc}")
            time.sleep(0.3)
        result[slug] = {"lat": lat, "lng": lng, "searched": len(files), "candidates": cands}
        p.log(f"{slug}: {len(files)} dosya tarandı, {len(cands)} uygun aday")
    (OUT / "candidates.json").write_text(json.dumps(result, ensure_ascii=False, indent=1), encoding="utf-8")
    return 0


if __name__ == "__main__":
    sys.exit(main())
