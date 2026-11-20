#!/usr/bin/env python3
"""Uzun açıklamaları (istanbul_long_descriptions.LONG) parti parti migration'a çevirir.

Kullanım: python data-pipeline/content/build_long_desc.py <parti> <zaman_damgası> [--city izmir]
  ör. python data-pipeline/content/build_long_desc.py 1 20261120050000
Çıktı: backend/supabase/migrations/<zaman_damgası>_<şehir>_long_desc_<parti>.sql
Kaynak: content/<şehir>_long_descriptions.py (LONG). Şehir verilmezse istanbul.
Kontroller: slug yayında bir yer mi, uzunluk (TR/EN 300-1400), 2 paragraf, kaçış.
"""
import json
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent.parent
sys.path.insert(0, str(Path(__file__).resolve().parent))
sys.path.insert(0, str(ROOT / "data-pipeline"))
import pipeline as p  # noqa: E402
import importlib  # noqa: E402


def q(s: str) -> str:
    return "'" + s.replace("'", "''") + "'"


def check(slug: str, tr: str, en: str, known: set) -> list:
    errs = []
    if slug not in known:
        errs.append(f"{slug}: yayında böyle bir yer yok")
    for lang, text in (("tr", tr), ("en", en)):
        if not 300 <= len(text) <= 1400:
            errs.append(f"{slug}/{lang}: uzunluk {len(text)}")
        if text.count("\n\n") != 1:
            errs.append(f"{slug}/{lang}: 2 paragraf olmalı ({text.count(chr(10)*2) + 1})")
        if "  " in text or text != text.strip():
            errs.append(f"{slug}/{lang}: fazla boşluk")
    return errs


def known_slugs(city: str, dropped) -> set:
    if city == "istanbul":
        rows = json.loads((ROOT / "data-pipeline/results/shortlist.json").read_text(encoding="utf-8"))
        return {p.slugify(r["ad_tr"]) for r in rows} - set(dropped)
    rows = json.loads((ROOT / f"data-pipeline/results/{city}/shortlist.json").read_text(encoding="utf-8"))
    return {r.get("slug_override") or r["slug"] for r in rows} - set(dropped)


def main(argv=None) -> int:
    import argparse
    ap = argparse.ArgumentParser()
    ap.add_argument("batch", type=int)
    ap.add_argument("stamp")
    ap.add_argument("--city", default="istanbul")
    args = ap.parse_args(argv)
    batch, stamp, city = args.batch, args.stamp, args.city
    DROPPED = importlib.import_module(f"{city}_descriptions").DROPPED
    LONG = importlib.import_module(f"{city}_long_descriptions").LONG
    known = known_slugs(city, DROPPED)
    errs = [e for slug, (_, tr, en) in LONG.items() for e in check(slug, tr, en, known)]
    if errs:
        print("\n".join(errs), file=sys.stderr)
        return 1
    rows = [(s, tr, en) for s, (b, tr, en) in LONG.items() if b == batch]
    if not rows:
        print(f"{batch}. partide açıklama yok", file=sys.stderr)
        return 1
    values = ",\n".join(f"  ({q(s)}, 'tr', {q(tr)}),\n  ({q(s)}, 'en', {q(en)})" for s, tr, en in rows)
    city_name = {"istanbul": "İstanbul", "izmir": "İzmir", "bursa": "Bursa", "kapadokya": "Kapadokya"}.get(city, city)
    sql = f"""-- {city_name} uzun açıklamaları, {batch}. parti ({len(rows)} yer, TR + EN).
-- Üreten: data-pipeline/content/build_long_desc.py (kaynak: content/{city}_long_descriptions.py).
-- Metinler kendi cümlelerimizdir; Vikipedi/Wikidata yalnızca bilgi kontrolü için kullanıldı.

update public.place_translations t
   set long_desc = v.long_desc
  from (values
{values}
  ) v(slug, lang, long_desc)
  join public.places p on p.slug = v.slug
 where t.place_id = p.id and t.lang = v.lang;
"""
    out = ROOT / f"backend/supabase/migrations/{stamp}_{city}_long_desc_{batch}.sql"
    out.write_text(sql, encoding="utf-8")
    total = sum(1 for b, _, _ in LONG.values() if b <= batch)
    print(f"{len(rows)} yer -> {out.relative_to(ROOT)}  (toplam {total}/{len(known)})")
    return 0


if __name__ == "__main__":
    sys.exit(main())
