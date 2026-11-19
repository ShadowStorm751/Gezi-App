#!/usr/bin/env python3
"""Onaylanan yer listesini (results/<şehir>/approved.csv) veri hattının adaylarıyla birleştirip
results/<şehir>/shortlist.json yazar: koordinat, alan sınırı, Wikidata/OSM kimliği, ana yer.

approved.csv proje sahibinin onay tablosundan çıkarılır (sütunlar: slug, ad_tr, ad_en, kategori,
ana_yer, not). Aday listesinde olmayan, elle eklenen yerlerin yaklaşık konumu aşağıdaki ADDED
sözlüğündedir; kesin konum coords.py ile Wikidata'dan doğrulanır (results/<şehir>/coords.json).

Kullanım: python data-pipeline/content/make_shortlist.py izmir
"""
from __future__ import annotations

import csv
import json
import sys
from pathlib import Path
from typing import Any, Dict, List

HERE = Path(__file__).resolve().parent
ROOT = HERE.parent.parent
sys.path.insert(0, str(HERE.parent))

import pipeline as p  # noqa: E402
from cities import get_city  # noqa: E402

# Aday listesinde olmayan yerler: slug -> (enlem, boylam, aramada kullanılacak ad, OSM kimliği ya da "")
# Konumlar yaklaşık (± birkaç yüz metre); coords.py Wikidata'daki koordinatla değiştirir ve raporlar.
# Arama adı '|' ile ayrılmış birden çok ad olabilir; sırayla denenir.
ADDED: Dict[str, Dict[str, Any]] = {
    "izmir": {
        "kemeralti-carsisi": (38.4189, 27.1310, "Kemeraltı", ""),
        "tarihi-asansor": (38.4092, 27.1238, "Tarihi Asansör", ""),
        "sirince": (37.9437, 27.4319, "Şirince", ""),
        "alacati": (38.2829, 26.3747, "Alaçatı", ""),
        "birgi": (38.2558, 28.0656, "Birgi", ""),
    },
    "bursa": {
        "yesil-camii": (40.1815, 29.0735, "Yeşil Camii", ""),
        # OSM'de var; Wikidata bağlantısı padişahın kendisine gidiyor, o yüzden aday listesine girmedi.
        "orhan-gazi-turbesi": (40.186771, 29.057694, "Orhan Gazi Türbesi", "way/325992024"),
        "tophane-saat-kulesi": (40.18785, 29.05747, "Tophane Saat Kulesi", "node/1786762169"),
        "bursa-kapalicarsi": (40.1840, 29.0640, "Bursa Bedesteni|Bedesten Bursa|Kapalıçarşı Bursa|Bursa Kapalıçarşı", ""),
        "irgandi-koprusu": (40.1838, 29.0710, "Irgandı Köprüsü", ""),
        "iznik-surlari": (40.4357, 29.7208, "İznik surları", ""),
        "cumalikizik": (40.1750, 29.1720, "Cumalıkızık", ""),
        "misi": (40.1630, 28.9760, "Gümüştepe|Misi, Nilüfer|Misi köyü", ""),
        "tirilye": (40.3920, 28.7950, "Tirilye", ""),
    },
    "kapadokya": {
        "ihlara-vadisi": (38.2450, 34.3000, "Ihlara Vadisi", ""),
        "selime-katedrali": (38.2990, 34.2650, "Selime Katedrali", ""),
        "soganli-vadisi": (38.3450, 35.0750, "Soğanlı Vadisi|Soğanlı, Yeşilhisar|Soğanlı", ""),
        "kizilcukur-vadisi": (38.6580, 34.8650, "Kızılçukur|Red Valley Cappadocia|Kızılçukur Vadisi", ""),
        "mustafapasa": (38.5770, 34.8970, "Mustafapaşa", ""),
        "cavusin": (38.6700, 34.8400, "Çavuşin", ""),
        "guzelyurt": (38.2770, 34.3700, "Güzelyurt", ""),
    },
}


def load_candidates(rdir: Path) -> Dict[str, Dict[str, str]]:
    return {r["slug"]: r for r in p.read_csv(rdir / "candidates.csv")}


def build(city_slug: str) -> List[Dict[str, Any]]:
    city = get_city(city_slug)
    rdir = ROOT / "data-pipeline/results" / city.slug
    cands = load_candidates(rdir)
    areas = json.loads((rdir / "areas.json").read_text(encoding="utf-8"))
    added = ADDED.get(city.slug, {})
    out: List[Dict[str, Any]] = []
    with (rdir / "approved.csv").open(encoding="utf-8") as f:
        for row in csv.DictReader(f):
            slug, cat = row["slug"], row["kategori"]
            if cat not in p.CATEGORY_KIND:
                raise SystemExit(f"{slug}: bilinmeyen kategori {cat}")
            c = cands.get(slug)
            if c:
                item = {k: c[k] for k in ("enlem", "boylam", "wikidata", "osm", "yapim_yili", "donem",
                                          "wikidata_ipucu_tr", "wikidata_ipucu_en", "wikipedia_tr",
                                          "wikipedia_en", "fotograf", "puan")}
                ring = areas.get(slug) if c.get("alan_var") and cat in p.AREA_CATEGORIES else None
            elif slug in added:
                lat, lng, search, osm = added[slug]
                item = {"enlem": f"{lat:.6f}", "boylam": f"{lng:.6f}", "wikidata": "", "osm": osm,
                        "arama_adi": search, "konum_yaklasik": not osm}
                ring = None
            else:
                raise SystemExit(f"{slug}: aday listesinde yok ve ADDED içinde konumu yok")
            item.update({
                "slug": slug, "slug_override": slug, "ad_tr": row["ad_tr"], "ad_en": row["ad_en"],
                "kategori": cat, "aile": p.CATEGORY_KIND[cat], "ana_yer": row["ana_yer"] or None,
                "not": row["not"], "alan_var": "evet" if ring else "", "_ring": ring,
            })
            out.append(item)
    slugs = {o["slug"] for o in out}
    bad = [o["slug"] for o in out if o["ana_yer"] and o["ana_yer"] not in slugs]
    if bad:
        raise SystemExit(f"Ana yeri listede olmayanlar: {bad}")
    return out


def main(argv: List[str]) -> int:
    city = argv[1] if len(argv) > 1 else ""
    items = build(city)
    path = ROOT / "data-pipeline/results" / city / "shortlist.json"
    path.write_text(json.dumps(items, ensure_ascii=False, indent=1), encoding="utf-8")
    parents = sum(1 for i in items if any(j["ana_yer"] == i["slug"] for j in items))
    print(f"{city}: {len(items)} yer, {parents} ana yer, "
          f"{sum(1 for i in items if i.get('konum_yaklasik'))} yaklaşık konum -> {path.relative_to(ROOT)}")
    return 0


if __name__ == "__main__":
    sys.exit(main(sys.argv))
