#!/usr/bin/env python3
"""Hedefli aramayla seçilen ek fotoğraflar -> backend/supabase/migrations/20261120200000_istanbul_photos_extra2.sql

Kaynak: results/photo-candidates-2/candidates.json (photo_candidates_targeted.py). Önizlemelere
bakılarak seçildi. Seçilmeyenler (yere ait uygun fotoğraf yok): beykoz-korusu (adaylar
çevredeki çeşme ve mescitler), telli-baba-turbesi (adaylar enerji hattı ve genel Boğaz manzarası).
"""
import json
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent.parent
sys.path.insert(0, str(Path(__file__).resolve().parent))
from build_photos import q  # noqa: E402

OUT = ROOT / "backend/supabase/migrations/20261120200000_istanbul_photos_extra2.sql"

# slug -> aday sırası (1'den başlar) ve kısa gerekçe
PICKS = {
    "aydos-ormani": (11, "Aydos Ormanı'ndaki gölet"),
    "hacilli-selalesi": (1, "Hacıllı deresi üzerindeki şelale (Ağva yakını)"),
    "yenikoy-seyir-terasi": (1, "Yeniköy'den Karadeniz'e inen yol"),
}


def main() -> int:
    cands = json.loads((ROOT / "data-pipeline/results/photo-candidates-2/candidates.json").read_text(encoding="utf-8"))
    rows = []
    for slug in sorted(PICKS):
        ph = cands[slug]["candidates"][PICKS[slug][0] - 1]
        rows.append(f"  ({q(slug)}, {q(ph['url'])}, {q(ph['thumb_url'])}, {q(ph.get('width'))}, {q(ph.get('height'))}, "
                    f"{q(ph['license'])}, {q(ph.get('license_url'))}, {q(ph['author'])}, {q(ph.get('source_url'))})")
    slugs = ", ".join(q(s) for s in sorted(PICKS))
    sql = f"""-- Genel ve ilk ek aramada fotoğrafı çıkmayan {len(rows)} İstanbul yeri için hedefli aramayla seçilmiş Commons fotoğrafları.
-- Üreten: data-pipeline/content/build_photos_extra2.py (kaynak: results/photo-candidates-2/candidates.json).
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
