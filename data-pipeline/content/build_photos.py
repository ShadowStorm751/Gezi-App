#!/usr/bin/env python3
"""results/photos.json -> backend/supabase/migrations/20261119140000_istanbul_photos.sql

Her yere bir Commons fotoğrafı (dış adres). Tekrar çalıştırılabilir: önce aynı yerlerin
Commons fotoğraflarını siler, sonra ekler. (Diğer şehirler: build_city.py)
"""
import json
import sys
from pathlib import Path

HERE = Path(__file__).resolve().parent
ROOT = HERE.parent.parent
sys.path.insert(0, str(HERE.parent))
sys.path.insert(0, str(HERE))

from build_city import photos_sql  # noqa: E402
OUT = ROOT / "backend/supabase/migrations/20261119140000_istanbul_photos.sql"

# Elle elenen eşleşmeler: ada göre bulunan kayıt başka bir yapıya ait çıktı.
EXCLUDE = {
    "otagtepe": "bulunan kayıt 'Otağtepe Su Sarnıcı'; fotoğraf manzarayı göstermiyor",
}


def main() -> int:
    data = json.loads((ROOT / "data-pipeline/results/photos.json").read_text(encoding="utf-8"))
    photos = {k: v for k, v in data["photos"].items() if k not in EXCLUDE}
    if not photos:
        print("photos.json boş", file=sys.stderr)
        return 1
    sql = photos_sql(photos, "İstanbul yerlerinin")
    OUT.write_text(sql, encoding="utf-8")
    print(f"{len(photos)} fotoğraf -> {OUT.relative_to(ROOT)}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
