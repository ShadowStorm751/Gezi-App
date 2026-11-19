#!/usr/bin/env python3
"""Onaylı İstanbul listesinden (results/shortlist.json) ve açıklamalardan
(content/istanbul_descriptions.py) yerleri yükleyen migration'ı üretir.

Kullanım: python data-pipeline/content/build_istanbul.py
(Diğer şehirler: build_city.py; ortak kod oradadır.)
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
import istanbul_descriptions  # noqa: E402
from build_city import place_rows, strip_transaction  # noqa: E402
from istanbul_descriptions import D  # noqa: E402

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

    rows, areas, missing = place_rows(shortlist, areas_all, istanbul_descriptions, COORD_FIX)
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
    sql = strip_transaction(sql)
    OUT.write_text(header + sql, encoding="utf-8")
    print(f"{stats['written']} yer ({stats['publishable']} yayında), {len(areas)} alan -> {OUT.relative_to(ROOT)}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
