#!/usr/bin/env python3
"""Onaylı İstanbul listesinden (results/shortlist.json) ve açıklamalardan
(content/istanbul_descriptions.py) yerleri yükleyen migration'ı üretir.

Kullanım: python data-pipeline/content/build_istanbul.py
Çıktı:    backend/supabase/migrations/20261119120000_istanbul_places.sql
"""
import json
import sys
from pathlib import Path

HERE = Path(__file__).resolve().parent
ROOT = HERE.parent.parent
sys.path.insert(0, str(HERE.parent))
sys.path.insert(0, str(HERE))

import pipeline as p  # noqa: E402
from istanbul_descriptions import BUILT, D, DROPPED, PERIOD, PERIOD_DEFAULT_HISTORICAL  # noqa: E402

OUT = ROOT / "backend/supabase/migrations/20261119120000_istanbul_places.sql"

# Elle doğrulanan / düzeltilen konumlar (2026-11-19)
COORD_FIX = {
    "misir-carsisi": (41.01639, 28.97056, 100),   # Wikipedia koordinatı
    "otagtepe": (41.090137, 29.071269, 150),      # Otağtepe Parkı; yarıçap geniş tutuldu
    "fatih-camii": (41.01940, 28.94960, 100),     # OSM'de başka bir caminin kaydına bağlanmıştı
}


def main() -> int:
    shortlist = json.loads((ROOT / "data-pipeline/results/shortlist.json").read_text(encoding="utf-8"))
    areas_all = json.loads((ROOT / "data-pipeline/results/areas.json").read_text(encoding="utf-8"))

    rows, areas, missing = [], {}, []
    for s in shortlist:
        slug = p.slugify(s["ad_tr"])
        if slug in DROPPED:
            continue
        if slug not in D:
            missing.append(slug)
            continue
        d = D[slug]
        lat, lng = float(s["enlem"]), float(s["boylam"])
        radius = s.get("yaricap_m") or p.DEFAULT_RADIUS_M[s["kategori"]]
        if slug in COORD_FIX:
            lat, lng, radius = COORD_FIX[slug]
        ring = s.get("_ring") or (areas_all.get(s.get("slug", "")) if s.get("alan_var") else None)
        if ring:
            areas[slug] = p.simplify_ring([tuple(pt) for pt in ring])
        rows.append({
            "onay": "x", "slug": slug, "kategori": s["kategori"],
            "ad_tr": s["ad_tr"], "ad_en": s["ad_en"],
            "kisa_aciklama_tr": d[0], "kisa_aciklama_en": d[1],
            "en_iyi_zaman_tr": d[2] if len(d) > 2 else "", "en_iyi_zaman_en": d[3] if len(d) > 3 else "",
            "donem": (PERIOD.get(slug, PERIOD_DEFAULT_HISTORICAL) if p.CATEGORY_KIND[s["kategori"]] == "historical" else None) or "",
            "yapim_yili": str(BUILT[slug]) if slug in BUILT else "", "yaricap_m": str(radius),
            "alan_var": "evet" if ring else "",
            "enlem": f"{lat:.6f}", "boylam": f"{lng:.6f}",
            "wikidata": s.get("wikidata", ""),
            "osm": "" if slug in COORD_FIX else (s.get("osm") or "").split(";")[0],
        })
    if missing:
        print("Açıklaması eksik:", missing, file=sys.stderr)
        return 1
    extra = set(D) - {r["slug"] for r in rows}
    if extra:
        print("Listede olmayan açıklama:", sorted(extra), file=sys.stderr)
        return 1

    sql, stats = p.build_sql(rows, areas)
    if stats["errors"]:
        print(stats["errors"], file=sys.stderr)
        return 1
    header = ("-- İstanbul pilot listesi: proje sahibinin onayladığı yerler (2026-11-19).\n"
              "-- Üreten: data-pipeline/content/build_istanbul.py — elle düzenleme; script'i yeniden çalıştır.\n")
    # Migration'lar zaten işlem bloğunda çalışır; iç begin/commit kaldırılır.
    sql = "\n".join(line for line in sql.splitlines() if line.strip() not in ("begin;", "commit;")) + "\n"
    OUT.write_text(header + sql, encoding="utf-8")
    print(f"{stats['written']} yer ({stats['publishable']} yayında), {len(areas)} alan -> {OUT.relative_to(ROOT)}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
