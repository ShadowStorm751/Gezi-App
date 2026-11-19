#!/usr/bin/env python3
"""Onaylı bir şehir listesinden migration üretir: şehir kaydı + yerler (+ fotoğraflar).

Girdi (şehir = slug, ör. izmir):
  data-pipeline/results/<şehir>/shortlist.json   onaylanan yerler (koordinat, alan)
  data-pipeline/results/<şehir>/areas.json       alan sınırları
  data-pipeline/results/<şehir>/photos.json      (varsa) Commons fotoğrafları
  data-pipeline/content/<şehir>_descriptions.py  D, DROPPED, PERIOD, PERIOD_DEFAULT_HISTORICAL, BUILT, COORD_FIX

Kullanım: python data-pipeline/content/build_city.py izmir --out backend/supabase/migrations/<zaman>_izmir_places.sql
Yeni şehirlerde yerler gizli eklenir (is_published = false); yayına alma ayrı bir karar.
İstanbul için build_istanbul.py ve build_photos.py aynı fonksiyonları kullanır.
"""
from __future__ import annotations

import argparse
import importlib
import json
import sys
from pathlib import Path
from typing import Any, Dict, List, Optional, Tuple

HERE = Path(__file__).resolve().parent
ROOT = HERE.parent.parent
sys.path.insert(0, str(HERE.parent))
sys.path.insert(0, str(HERE))

import pipeline as p  # noqa: E402
from cities import DEFAULT_CITY, City, get_city  # noqa: E402

# Pilotta olmayan, yeni şehirlerle gelen kategoriler: slug -> (tür, ikon, sıra, TR, EN)
NEW_CATEGORIES = {
    "valley": ("nature", "valley", 37, "Vadi", "Valley"),
    "village": ("historical", "village", 21, "Tarihi Köy", "Historic Village"),
}


def results_dir(city: City) -> Path:
    base = ROOT / "data-pipeline/results"
    return base if city.slug == DEFAULT_CITY else base / city.slug


def load_descriptions(city: City):
    return importlib.import_module(f"{city.slug}_descriptions")


def place_rows(shortlist: List[Dict[str, Any]], areas_all: Dict[str, Any], desc,
               coord_fix: Dict[str, Tuple[float, float, int]]) -> Tuple[List[Dict[str, str]], Dict[str, Any], List[str]]:
    """Onaylı liste + açıklamalar -> pipeline.build_sql satırları. (satırlar, alanlar, açıklaması eksik slug'lar)"""
    rows, areas, missing = [], {}, []
    for s in shortlist:
        slug = s.get("slug_override") or p.slugify(s["ad_tr"])
        if slug in desc.DROPPED:
            continue
        if slug not in desc.D:
            missing.append(slug)
            continue
        d = desc.D[slug]
        lat, lng = float(s["enlem"]), float(s["boylam"])
        radius = s.get("yaricap_m") or p.DEFAULT_RADIUS_M[s["kategori"]]
        if slug in coord_fix:
            lat, lng, radius = coord_fix[slug]
        ring = s.get("_ring") or (areas_all.get(s.get("slug", "")) if s.get("alan_var") else None)
        if ring:
            areas[slug] = p.simplify_ring([tuple(pt) for pt in ring])
        historical = p.CATEGORY_KIND[s["kategori"]] == "historical"
        rows.append({
            "onay": "x", "slug": slug, "kategori": s["kategori"],
            "ad_tr": s["ad_tr"], "ad_en": s["ad_en"],
            "kisa_aciklama_tr": d[0], "kisa_aciklama_en": d[1],
            "en_iyi_zaman_tr": d[2] if len(d) > 2 else "", "en_iyi_zaman_en": d[3] if len(d) > 3 else "",
            "donem": (desc.PERIOD.get(slug, desc.PERIOD_DEFAULT_HISTORICAL) if historical else None) or "",
            "yapim_yili": str(desc.BUILT[slug]) if slug in desc.BUILT else "", "yaricap_m": str(radius),
            "alan_var": "evet" if ring else "",
            "enlem": f"{lat:.6f}", "boylam": f"{lng:.6f}",
            "wikidata": s.get("wikidata", ""),
            "osm": "" if slug in coord_fix else (s.get("osm") or "").split(";")[0],
        })
    return rows, areas, missing


def strip_transaction(sql: str) -> str:
    """Migration'lar zaten işlem bloğunda çalışır; iç begin/commit kaldırılır."""
    return "\n".join(line for line in sql.splitlines() if line.strip() not in ("begin;", "commit;")) + "\n"


def _q(v: Any) -> str:
    if v is None or v == "":
        return "null"
    if isinstance(v, (int, float)):
        return str(int(v))
    return "'" + str(v).replace("'", "''") + "'"


def photos_sql(photos: Dict[str, Dict[str, Any]], title: str) -> str:
    """Her yere bir Commons fotoğrafı. Önce aynı yerlerin Commons fotoğraflarını siler, sonra ekler."""
    rows = []
    for slug in sorted(photos):
        ph = photos[slug]
        rows.append(f"  ({_q(slug)}, {_q(ph['url'])}, {_q(ph['thumb_url'])}, {_q(ph.get('width'))}, {_q(ph.get('height'))}, "
                    f"{_q(ph['license'])}, {_q(ph.get('license_url'))}, {_q(ph['author'])}, {_q(ph.get('source_url'))})")
    slugs = ", ".join(_q(s) for s in sorted(photos))
    return f"""-- {title} fotoğrafları: Wikimedia Commons, serbest lisanslı ({len(rows)} yer).
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


def city_sql(city: City) -> str:
    names = json.dumps(city.names, ensure_ascii=False)
    return (f"insert into public.cities (slug, names, timezone)\n"
            f"values ({_q(city.slug)}, {_q(names)}, {_q(city.timezone)})\n"
            f"on conflict (slug) do nothing;\n")


def categories_sql(used: List[str]) -> str:
    new = [c for c in sorted(set(used)) if c in NEW_CATEGORIES]
    if not new:
        return ""
    cats = ",\n".join(f"  ({_q(c)}, '{NEW_CATEGORIES[c][0]}', {_q(NEW_CATEGORIES[c][1])}, {NEW_CATEGORIES[c][2]})" for c in new)
    trs = ",\n".join(f"  ({_q(c)}, 'tr', {_q(NEW_CATEGORIES[c][3])}), ({_q(c)}, 'en', {_q(NEW_CATEGORIES[c][4])})" for c in new)
    return f"""-- Yeni kategori(ler) ------------------------------------------------------------
insert into public.categories (slug, kind, icon, sort_order) values
{cats}
on conflict (slug) do nothing;

insert into public.category_translations (category_id, lang, name)
select c.id, v.lang, v.name
from (values
{trs}
) v(slug, lang, name)
join public.categories c on c.slug = v.slug
on conflict (category_id, lang) do nothing;

"""


def build_city_migration(city: City, header_date: str) -> Tuple[str, Dict[str, Any]]:
    rdir = results_dir(city)
    desc = load_descriptions(city)
    shortlist = json.loads((rdir / "shortlist.json").read_text(encoding="utf-8"))
    areas_path = rdir / "areas.json"
    areas_all = json.loads(areas_path.read_text(encoding="utf-8")) if areas_path.exists() else {}
    rows, areas, missing = place_rows(shortlist, areas_all, desc, getattr(desc, "COORD_FIX", {}))
    if missing:
        raise SystemExit(f"Açıklaması eksik: {missing}")
    extra = set(desc.D) - {r["slug"] for r in rows}
    if extra:
        raise SystemExit(f"Listede olmayan açıklama: {sorted(extra)}")

    places, stats = p.build_sql(rows, areas, city.slug, publish=False)
    if stats["errors"]:
        raise SystemExit(f"Hatalı satırlar: {stats['errors']}")

    photos_path = rdir / "photos.json"
    photos: Dict[str, Any] = {}
    if photos_path.exists():
        excl = getattr(desc, "PHOTO_EXCLUDE", {})
        slugs = {r["slug"] for r in rows}
        photos = {k: v for k, v in json.loads(photos_path.read_text(encoding="utf-8"))["photos"].items()
                  if k not in excl and k in slugs}

    title = city.names["tr"]
    sql = (f"-- {title}: proje sahibinin onayladığı yerler ({header_date}).\n"
           f"-- Üreten: data-pipeline/content/build_city.py {city.slug} — elle düzenleme; script'i yeniden çalıştır.\n"
           f"-- Yerler gizli eklenir (is_published = false); yayına alma ayrı bir migration ile yapılır.\n\n"
           f"-- Şehir --------------------------------------------------------------------------\n"
           + city_sql(city) + "\n"
           + categories_sql([r["kategori"] for r in rows])
           + "-- Yerler --------------------------------------------------------------------------\n"
           + strip_transaction(places))
    if photos:
        sql += "\n" + photos_sql(photos, title).replace(
            "data-pipeline/content/build_photos.py (kaynak: data-pipeline/results/photos.json)",
            f"data-pipeline/content/build_city.py (kaynak: data-pipeline/results/{city.slug}/photos.json)")
    stats["photos"] = len(photos)
    stats["areas"] = len(areas)
    return sql, stats


def main(argv: Optional[List[str]] = None) -> int:
    ap = argparse.ArgumentParser(description="Onaylı şehir listesinden migration üretir")
    ap.add_argument("city")
    ap.add_argument("--out", type=Path, required=True, help="yeni migration dosyası (var olanın üzerine yazmaz)")
    ap.add_argument("--date", default="", help="başlıktaki onay tarihi (YYYY-AA-GG)")
    ap.add_argument("--force", action="store_true", help="dosya varsa üzerine yaz (yalnızca henüz commit'lenmemiş taslak için)")
    args = ap.parse_args(argv)
    city = get_city(args.city)
    if city.slug == DEFAULT_CITY:
        print("İstanbul için build_istanbul.py kullan.", file=sys.stderr)
        return 2
    if args.out.exists() and not args.force:
        print(f"{args.out} zaten var; var olan migration düzenlenmez.", file=sys.stderr)
        return 1
    sql, stats = build_city_migration(city, args.date)
    args.out.write_text(sql, encoding="utf-8")
    print(f"{city.names['tr']}: {stats['written']} yer (hepsi gizli), {stats['areas']} alan, "
          f"{stats['photos']} fotoğraf -> {args.out}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
