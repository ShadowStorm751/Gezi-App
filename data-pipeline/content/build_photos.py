#!/usr/bin/env python3
"""results/photos.json -> backend/supabase/migrations/20261119140000_istanbul_photos.sql

Her yere bir Commons fotoğrafı (dış adres). Tekrar çalıştırılabilir: önce aynı yerlerin
Commons fotoğraflarını siler, sonra ekler.
"""
import json
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent.parent
OUT = ROOT / "backend/supabase/migrations/20261119140000_istanbul_photos.sql"

# Elle elenen eşleşmeler: ada göre bulunan kayıt başka bir yapıya ait çıktı.
# Bu yerlerin doğru fotoğrafı build_photos_extra.py ile (migration 20261119230000) eklenir.
EXCLUDE = {
    "otagtepe": "bulunan kayıt 'Otağtepe Su Sarnıcı'; fotoğraf manzarayı göstermiyor",
}


def q(v):
    if v is None or v == "":
        return "null"
    if isinstance(v, (int, float)):
        return str(int(v))
    return "'" + str(v).replace("'", "''") + "'"


def main() -> int:
    data = json.loads((ROOT / "data-pipeline/results/photos.json").read_text(encoding="utf-8"))
    photos = {k: v for k, v in data["photos"].items() if k not in EXCLUDE}
    if not photos:
        print("photos.json boş", file=sys.stderr)
        return 1
    rows = []
    for slug in sorted(photos):
        ph = photos[slug]
        rows.append(f"  ({q(slug)}, {q(ph['url'])}, {q(ph['thumb_url'])}, {q(ph.get('width'))}, {q(ph.get('height'))}, "
                    f"{q(ph['license'])}, {q(ph.get('license_url'))}, {q(ph['author'])}, {q(ph.get('source_url'))})")
    slugs = ", ".join(q(s) for s in sorted(photos))
    sql = f"""-- İstanbul yerlerinin fotoğrafları: Wikimedia Commons, serbest lisanslı ({len(rows)} yer).
-- Üreten: data-pipeline/content/build_photos.py (kaynak: data-pipeline/results/photos.json).
-- Mobil, fotoğrafın altında author ve license bilgisini göstermelidir (lisans koşulu).

delete from public.place_photos ph
using public.places p
where ph.place_id = p.id
  and ph.url like 'https://%.wikimedia.org/%'
  and p.slug in ({slugs});

insert into public.place_photos
  (place_id, url, thumb_url, width, height, license, license_url, author, source_url, sort_order)
select p.id, v.url, v.thumb_url, v.width::int, v.height::int, v.license, v.license_url, v.author, v.source_url, 0
from (values
{("," + chr(10)).join(rows)}
) v(slug, url, thumb_url, width, height, license, license_url, author, source_url)
join public.places p on p.slug = v.slug;
"""
    OUT.write_text(sql, encoding="utf-8")
    print(f"{len(rows)} fotoğraf -> {OUT.relative_to(ROOT)}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
