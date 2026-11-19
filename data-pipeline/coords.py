#!/usr/bin/env python3
"""Onaylı yerlerin koordinatlarını Wikidata ile karşılaştırır (koordinat kontrolü).

Her yer için:
  - Wikidata kaydı varsa P625 koordinatı alınır, OSM koordinatıyla arası ölçülür.
  - Kaydı yoksa adıyla aranır (yakındaki sonuç); elle eklenen ve konumu yaklaşık olan yerlerde
    bulunan Wikidata koordinatı önerilen konum olur.
Çıktı: results/<şehir>/coords.json   (slug -> osm, wikidata, qid, mesafe_m, durum)

Durum: "uyumlu" (< eşik), "kontrol" (eşik üstü; elle bakılır), "wikidata_yok", "yaklasik_duzeltildi".
Eşik: ana yerin içindeki yerlerde 25 m, diğerlerinde 150 m.
İnternet gerekir; GitHub Actions'ta çalışır (photos.yml). Yalnızca standart kütüphane.
"""
from __future__ import annotations

import argparse
import json
import sys
from pathlib import Path
from typing import Any, Dict, List, Optional

HERE = Path(__file__).resolve().parent
sys.path.insert(0, str(HERE))

import pipeline as p  # noqa: E402
import photos as ph  # noqa: E402
from cities import CITIES  # noqa: E402

THRESHOLD_M = 150
THRESHOLD_CHILD_M = 25
SEARCH_MAX_M = 3000


def classify(item: Dict[str, Any], wd: Optional[tuple], qid: str, found_by_search: bool) -> Dict[str, Any]:
    """Saf karar fonksiyonu (testli)."""
    osm = (float(item["enlem"]), float(item["boylam"]))
    res: Dict[str, Any] = {"osm": list(osm), "qid": qid or None, "wikidata": list(wd) if wd else None,
                           "arama_ile": found_by_search}
    if not wd:
        res.update(mesafe_m=None, durum="yaklasik_dogrulanamadi" if item.get("konum_yaklasik") else "wikidata_yok")
        return res
    d = round(p.haversine_m(osm[0], osm[1], wd[0], wd[1]))
    res["mesafe_m"] = d
    if item.get("konum_yaklasik"):
        res.update(durum="yaklasik_duzeltildi", onerilen=list(wd))
        return res
    limit = THRESHOLD_CHILD_M if item.get("ana_yer") else THRESHOLD_M
    res["durum"] = "uyumlu" if d <= limit else "kontrol"
    return res


def main(argv: Optional[List[str]] = None) -> int:
    ap = argparse.ArgumentParser(description="Koordinat kontrolü (Wikidata)")
    ap.add_argument("--city", required=True, choices=sorted(c for c in CITIES if c != "istanbul"))
    args = ap.parse_args(argv)
    rdir = HERE / "results" / args.city
    items = json.loads((rdir / "shortlist.json").read_text(encoding="utf-8"))

    qids = sorted({i["wikidata"] for i in items if i.get("wikidata")})
    entities = ph.fetch_entities(qids) if qids else {}
    out: Dict[str, Any] = {}
    for it in items:
        qid, by_search = it.get("wikidata") or "", False
        ent = entities.get(qid) if qid else None
        if not ent:
            lat, lng = float(it["enlem"]), float(it["boylam"])
            hit = None
            for name in (it.get("arama_adi") or it["ad_tr"]).split("|"):
                hit = ph.search_entity(name.strip(), lat, lng, SEARCH_MAX_M)
                if hit:
                    break
            if hit:
                ent, qid, by_search = hit, hit["id"], True
        wd = ph.entity_coord(ent) if ent else None
        out[it["slug"]] = classify(it, wd, qid, by_search)
        p.log(f"  {it['slug']}: {out[it['slug']]['durum']} {out[it['slug']].get('mesafe_m')}")
    summary: Dict[str, int] = {}
    for v in out.values():
        summary[v["durum"]] = summary.get(v["durum"], 0) + 1
    (rdir / "coords.json").write_text(json.dumps({"ozet": summary, "yerler": out}, ensure_ascii=False, indent=1),
                                      encoding="utf-8")
    p.log(f"{args.city}: {summary}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
