#!/usr/bin/env python3
"""Uzun açıklamaları (istanbul_long_descriptions.LONG) parti parti migration'a çevirir.

Kullanım: python data-pipeline/content/build_long_desc.py <parti> <zaman_damgası>
  ör. python data-pipeline/content/build_long_desc.py 1 20261120050000
Çıktı: backend/supabase/migrations/<zaman_damgası>_istanbul_long_desc_<parti>.sql
Kontroller: slug yayında bir yer mi, uzunluk (TR/EN 300-1400), 2 paragraf, kaçış.
"""
import json
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent.parent
sys.path.insert(0, str(Path(__file__).resolve().parent))
sys.path.insert(0, str(ROOT / "data-pipeline"))
import pipeline as p  # noqa: E402
from istanbul_descriptions import DROPPED  # noqa: E402
from istanbul_long_descriptions import LONG  # noqa: E402


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


def main() -> int:
    batch, stamp = int(sys.argv[1]), sys.argv[2]
    known = {p.slugify(r["ad_tr"]) for r in json.loads(
        (ROOT / "data-pipeline/results/shortlist.json").read_text(encoding="utf-8"))} - set(DROPPED)
    errs = [e for slug, (_, tr, en) in LONG.items() for e in check(slug, tr, en, known)]
    if errs:
        print("\n".join(errs), file=sys.stderr)
        return 1
    rows = [(s, tr, en) for s, (b, tr, en) in LONG.items() if b == batch]
    if not rows:
        print(f"{batch}. partide açıklama yok", file=sys.stderr)
        return 1
    values = ",\n".join(f"  ({q(s)}, 'tr', {q(tr)}),\n  ({q(s)}, 'en', {q(en)})" for s, tr, en in rows)
    sql = f"""-- İstanbul uzun açıklamaları, {batch}. parti ({len(rows)} yer, TR + EN).
-- Üreten: data-pipeline/content/build_long_desc.py (kaynak: content/istanbul_long_descriptions.py).
-- Metinler kendi cümlelerimizdir; Vikipedi/Wikidata yalnızca bilgi kontrolü için kullanıldı.

update public.place_translations t
   set long_desc = v.long_desc
  from (values
{values}
  ) v(slug, lang, long_desc)
  join public.places p on p.slug = v.slug
 where t.place_id = p.id and t.lang = v.lang;
"""
    out = ROOT / f"backend/supabase/migrations/{stamp}_istanbul_long_desc_{batch}.sql"
    out.write_text(sql, encoding="utf-8")
    total = sum(1 for b, _, _ in LONG.values() if b <= batch)
    print(f"{len(rows)} yer -> {out.relative_to(ROOT)}  (toplam {total}/156)")
    return 0


if __name__ == "__main__":
    sys.exit(main())
