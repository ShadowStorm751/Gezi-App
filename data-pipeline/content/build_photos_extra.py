#!/usr/bin/env python3
"""Elle seçilen ek fotoğraflar -> backend/supabase/migrations/20261119230000_istanbul_photos_extra.sql

Kaynak: results/photo-candidates/candidates.json (photo_candidates.py). Otomatik eşleşmede
fotoğrafı çıkmayan yerler için adaylar önizlemelerine bakılarak seçildi. Seçilmeyenler
(uygun aday yok): aydos-ormani, hacilli-selalesi, beykoz-korusu, telli-baba-turbesi,
yenikoy-seyir-terasi.
"""
import json
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent.parent
sys.path.insert(0, str(Path(__file__).resolve().parent))
from build_photos import q  # noqa: E402

OUT = ROOT / "backend/supabase/migrations/20261119230000_istanbul_photos_extra.sql"

# slug -> aday sırası (1'den başlar) ve kısa gerekçe
PICKS = {
    "alemdag": (1, "Alemdağ tepeleri genel görünüm"),
    "anadolu-kavagi-manzara-seyir-noktasi": (3, "Yoros Kalesi ve Boğaz ağzı"),
    "ayasofya-turbeleri": (1, "II. Selim Türbesi kubbeleri"),
    "aziz-mahmud-hudayi-turbesi": (2, "türbe avlusu ve kubbe"),
    "bebek-parki": (1, "Bebek koyu"),
    "ciroz-plaji": (1, "kumsal"),
    "fatih-sultan-mehmed-turbesi": (2, "Fatih'in sandukası, kamu malı arşiv fotoğrafı"),
    "i-abdulhamid-turbesi": (1, "türbenin dış görünümü"),
    "kilyos-plaji": (3, "Kilyos plajı"),
    "kucukcamlica-korusu": (8, "koru içi"),
    "menekse-plaji": (1, "Menekşe sahili"),
    "misir-carsisi": (3, "çarşının ana koridoru"),
    "moda-sahili": (1, "Moda kayalıkları ve tarihi yarımada"),
    "nakkastepe-millet-bahcesi": (2, "yürüyüş yolu ve köprü manzarası"),
    "otagtepe": (3, "Otağtepe'den FSM Köprüsü"),
    "sarayburnu-manzarasi": (4, "Sarayburnu terasından Galata (5-8: yazar adı yok)"),
    "sultan-ahmed-turbesi": (2, "türbenin dış görünümü"),
    "turhan-sultan-turbesi": (1, "türbe girişi"),
}


def main() -> int:
    cands = json.loads((ROOT / "data-pipeline/results/photo-candidates/candidates.json").read_text(encoding="utf-8"))
    rows = []
    for slug in sorted(PICKS):
        ph = cands[slug]["candidates"][PICKS[slug][0] - 1]
        rows.append(f"  ({q(slug)}, {q(ph['url'])}, {q(ph['thumb_url'])}, {q(ph.get('width'))}, {q(ph.get('height'))}, "
                    f"{q(ph['license'])}, {q(ph.get('license_url'))}, {q(ph['author'])}, {q(ph.get('source_url'))})")
    slugs = ", ".join(q(s) for s in sorted(PICKS))
    sql = f"""-- Otomatik eşleşmede fotoğrafı çıkmayan {len(rows)} İstanbul yeri için elle seçilmiş Commons fotoğrafları.
-- Üreten: data-pipeline/content/build_photos_extra.py (kaynak: results/photo-candidates/candidates.json).
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
