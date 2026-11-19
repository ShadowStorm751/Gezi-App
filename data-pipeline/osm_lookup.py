#!/usr/bin/env python3
"""Konumu yaklaşık kalan yerleri OSM'de adıyla arar (Geofabrik Türkiye dosyası + osmium).

Wikidata'da bulunamayan ya da kaba koordinatlı yerler için: tahmini konumun çevresindeki
(± ~4 km) adı olan bütün OSM öğeleri çıkarılır, adında aranan sözcük geçenler mesafeye göre listelenir.
Karar elle verilir; sonuç <şehir>_descriptions.py içindeki COORD_FIX'e yazılır.

Çıktı: results/osm_lookup.json   (slug -> [ {ad, tür, etiketler, enlem, boylam, mesafe_m}, ... ])
Kullanım: python data-pipeline/osm_lookup.py --pbf turkey-latest.osm.pbf
"""
from __future__ import annotations

import argparse
import json
import sys
from pathlib import Path
from typing import Any, Dict, List

HERE = Path(__file__).resolve().parent
sys.path.insert(0, str(HERE))

import osm_pbf  # noqa: E402
import pipeline as p  # noqa: E402

# slug -> (şehir, tahmini enlem, boylam, aranan sözcükler [katlanmış, ör. "kizilcukur"], kutu yarı genişliği (derece))
# Sonuçları işlenen yerler (2026-11-20): misi, bursa-kapalicarsi, iznik-surlari, kizilcukur-vadisi, mustafapasa,
# tarihi-asansor. Kalan: soganli-vadisi (ilk aramada ± 0,04° içinde bulunamadı).
TARGETS: Dict[str, tuple] = {
    # Soğanlı'nın kaya kiliseleri: aday listesine girmediler (OSM'de çoğu natural=yes ya da etiketsiz)
    "soganli-kiliseleri": ("kapadokya", 38.349, 34.962, ["kilise", "church", "karabas", "kubbeli", "sakli",
                                                         "geyikli", "tahtali", "yilanli", "belli", "manastir"], 0.03),
}
BOX_DEG = 0.04


def main(argv: List[str] | None = None) -> int:
    ap = argparse.ArgumentParser(description="Yaklaşık konumlu yerleri OSM'de ara")
    ap.add_argument("--pbf", type=Path, required=True)
    ap.add_argument("--work", type=Path, default=HERE / "output" / "lookup")
    args = ap.parse_args(argv)
    args.work.mkdir(parents=True, exist_ok=True)

    out: Dict[str, List[Dict[str, Any]]] = {}
    for slug, (city, lat, lng, words, *box) in TARGETS.items():
        deg = box[0] if box else BOX_DEG
        part, named, gj = (args.work / f"{slug}.osm.pbf", args.work / f"{slug}.named.osm.pbf",
                           args.work / f"{slug}.geojsonseq")
        b = f"{lng - deg},{lat - deg},{lng + deg},{lat + deg}"
        osm_pbf._osmium("extract", "-s", "smart", "-b", b, str(args.pbf), "-o", str(part), "--overwrite")
        osm_pbf._osmium("tags-filter", str(part), "nwr/name", "-o", str(named), "--overwrite")
        osm_pbf._export(named, gj)
        hits = []
        for feat in osm_pbf.read_geojsonseq(gj):
            el = osm_pbf.feature_to_element(feat)
            if not el:
                continue
            names = " ".join(v for k, v in el["tags"].items() if k.startswith("name"))
            if not any(w in p.fold(names) for w in words):
                continue
            hlat, hlng, _ = p.element_geometry(el)
            if hlat is None:
                continue
            keep = {k: v for k, v in el["tags"].items()
                    if k in ("name", "name:en", "place", "natural", "tourism", "historic", "amenity", "barrier",
                             "building", "wikidata", "highway", "landuse", "boundary", "admin_level")}
            hits.append({"osm": f"{el['type']}/{el['id']}", "etiketler": keep, "enlem": round(hlat, 6),
                         "boylam": round(hlng, 6), "mesafe_m": round(p.haversine_m(lat, lng, hlat, hlng))})
        hits.sort(key=lambda h: h["mesafe_m"])
        out[slug] = hits[:25]
        p.log(f"{slug}: {len(hits)} eşleşme")
    path = HERE / "results" / "osm_lookup.json"
    old = json.loads(path.read_text(encoding="utf-8")) if path.exists() else {}
    old.update(out)
    out = old
    path.write_text(json.dumps(out, ensure_ascii=False, indent=1), encoding="utf-8")
    p.log(f"-> {path}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
