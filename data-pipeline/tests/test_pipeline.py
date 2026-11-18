"""Veri hattı testleri (internet gerekmez).
Çalıştırma: python -m unittest discover -s data-pipeline/tests
"""
import csv
import json
import sys
import tempfile
import unittest
from pathlib import Path

HERE = Path(__file__).resolve().parent
sys.path.insert(0, str(HERE.parent))

import pipeline as p  # noqa: E402

FIX = HERE / "fixtures"


def load_fixtures():
    osm = json.loads((FIX / "osm_raw.json").read_text(encoding="utf-8"))
    wd = json.loads((FIX / "wikidata.json").read_text(encoding="utf-8"))
    return osm, wd


class HelperTests(unittest.TestCase):
    def test_slugify(self):
        self.assertEqual(p.slugify("Süleymaniye Camii"), "suleymaniye-camii")
        self.assertEqual(p.slugify("İstanbul Arkeoloji Müzeleri"), "istanbul-arkeoloji-muzeleri")
        self.assertEqual(p.slugify("Büyük Çamlıca Tepesi"), "buyuk-camlica-tepesi")
        self.assertEqual(p.slugify("Kız Kulesi"), "kiz-kulesi")
        self.assertEqual(p.slugify("!!!"), "yer")

    def test_classify(self):
        c = p.classify
        self.assertEqual(c({"amenity": "place_of_worship", "religion": "muslim", "name": "X Camii"}), "mosque")
        self.assertEqual(c({"amenity": "place_of_worship", "religion": "christian", "name": "Aya Irini"}), "church")
        self.assertEqual(c({"tourism": "museum", "historic": "palace", "name": "Topkapı Sarayı"}), "palace")
        self.assertEqual(c({"tourism": "museum", "name": "Pera Müzesi"}), "museum")
        self.assertEqual(c({"historic": "building", "name": "Şerefiye Sarnıcı"}), "cistern")
        self.assertEqual(c({"historic": "castle", "name": "Rumeli Hisarı"}), "fortress")
        self.assertEqual(c({"historic": "yes", "name": "Galata Kulesi"}), "tower")
        self.assertEqual(c({"tourism": "viewpoint", "name": "Pierre Loti"}), "viewpoint")
        self.assertEqual(c({"landuse": "forest", "name": "Belgrad Ormanı"}), "forest")
        self.assertEqual(c({"place": "island", "name": "Büyükada"}), "island")
        self.assertEqual(c({"natural": "peak", "name": "Aydos Tepesi"}), "hill")
        self.assertEqual(c({"leisure": "park", "name": "Gülhane Parkı"}), "park")
        self.assertIsNone(c({"shop": "bakery", "name": "Fırın"}))

    def test_inception_and_period(self):
        claim = lambda t: {"P571": [{"mainsnak": {"datavalue": {"value": {"time": t}}}}]}  # noqa: E731
        self.assertEqual(p.parse_inception_year(claim("+1557-00-00T00:00:00Z")), 1557)
        self.assertEqual(p.parse_inception_year(claim("-0660-00-00T00:00:00Z")), -660)
        self.assertIsNone(p.parse_inception_year({}))
        self.assertEqual(p.guess_period(-660), "Antik")
        self.assertEqual(p.guess_period(537), "Bizans")
        self.assertEqual(p.guess_period(1557), "Osmanlı")
        self.assertEqual(p.guess_period(1950), "Cumhuriyet")
        self.assertEqual(p.guess_period(None), "")

    def test_simplify_ring_keeps_closed(self):
        ring = [(float(i), 0.0) for i in range(400)] + [(0.0, 0.0)]
        s = p.simplify_ring(ring, 100)
        self.assertLessEqual(len(s), 101)
        self.assertEqual(s[0], s[-1])


class CandidatesTests(unittest.TestCase):
    def setUp(self):
        osm, wd = load_fixtures()
        self.cands = p.build_candidates(osm, wd)
        self.by_slug = {c["slug"]: c for c in self.cands}

    def test_filters_and_dedupes(self):
        slugs = set(self.by_slug)
        # adı olmayan seyir noktası ve fırın elendi; aynı Wikidata'lı iki cami, aynı adlı iki anıt birleşti
        self.assertEqual(slugs, {
            "suleymaniye-camii", "belgrad-ormani", "buyukada", "pierre-loti-tepesi",
            "ornek-cesmesi", "serefiye-sarnici", "ornek-aniti", "rumeli-hisari", "topkapi-sarayi",
        })
        self.assertEqual(self.by_slug["suleymaniye-camii"]["osm"], "node/1;way/2")
        self.assertEqual(self.by_slug["ornek-aniti"]["osm"], "node/10;node/9")

    def test_wikidata_enrichment(self):
        s = self.by_slug["suleymaniye-camii"]
        self.assertEqual((s["ad_en"], s["yapim_yili"], s["donem"]), ("Süleymaniye Mosque", "1557", "Osmanlı"))
        self.assertEqual(s["fotograf"], "Suleymaniye.jpg")
        self.assertEqual(s["wikipedia_tr"], "Süleymaniye Camii")
        self.assertEqual(self.by_slug["rumeli-hisari"]["ad_en"], "Rumelian Castle")  # OSM name:en önce gelir

    def test_areas_only_for_area_categories(self):
        self.assertEqual(self.by_slug["belgrad-ormani"]["alan_var"], "evet")
        self.assertEqual(self.by_slug["buyukada"]["alan_var"], "evet")      # relation dış halkası
        self.assertEqual(self.by_slug["suleymaniye-camii"]["alan_var"], "")  # cami: yarıçapla
        self.assertEqual(self.by_slug["rumeli-hisari"]["alan_var"], "")      # açık yol: halka yok
        self.assertAlmostEqual(self.by_slug["rumeli-hisari"]["enlem"], 41.085)

    def test_ranking_and_radius(self):
        hist = [c for c in self.cands if c["aile"] == "historical"]
        self.assertEqual(hist[0]["slug"], "topkapi-sarayi")
        self.assertEqual(hist[-1]["puan"], 0)
        self.assertEqual(self.by_slug["pierre-loti-tepesi"]["yaricap_m"], 50)
        self.assertEqual(self.by_slug["buyukada"]["yaricap_m"], 1500)


class BuildTests(unittest.TestCase):
    def test_csv_roundtrip_and_sql(self):
        osm, wd = load_fixtures()
        cands = p.build_candidates(osm, wd)
        with tempfile.TemporaryDirectory() as tmp:
            out = Path(tmp)
            csv_path, areas_path = p.write_candidates(cands, out)
            raw = csv_path.read_bytes()
            self.assertTrue(raw.startswith(b"\xef\xbb\xbf"))  # Excel için BOM

            rows = p.read_csv(csv_path)
            for r in rows:
                if r["slug"] in ("suleymaniye-camii", "belgrad-ormani", "pierre-loti-tepesi"):
                    r["onay"] = "x"
                if r["slug"] == "suleymaniye-camii":
                    r["kisa_aciklama_tr"] = "Mimar Sinan'ın eseri."
                    r["kisa_aciklama_en"] = "A work of Mimar Sinan."
                if r["slug"] == "belgrad-ormani":
                    r["kisa_aciklama_tr"] = "Şehrin en büyük ormanı."
                    r["kisa_aciklama_en"] = "The city's largest forest."
                    r["en_iyi_zaman_tr"] = "Sabah"
                if r["slug"] == "pierre-loti-tepesi":
                    r["ad_en"] = "Pierre Loti Hill"  # açıklama yok -> yayına alınmaz
            # Excel'de kaydedilmiş gibi ; ile yaz ve tekrar oku
            with csv_path.open("w", encoding="utf-8-sig", newline="") as f:
                w = csv.DictWriter(f, fieldnames=p.CSV_COLUMNS, delimiter=";")
                w.writeheader()
                w.writerows(rows)

            areas = json.loads(areas_path.read_text(encoding="utf-8"))
            sql, stats = p.build_sql(p.read_csv(csv_path), areas)

        self.assertEqual((stats["approved"], stats["written"], stats["publishable"]), (3, 3, 2))
        self.assertEqual(stats["errors"], [])
        self.assertIn("'Mimar Sinan''ın eseri.'", sql)  # tırnak kaçışı
        self.assertIn("SRID=4326;POLYGON((", sql)        # orman alanı
        self.assertIn("where slug in ('suleymaniye-camii', 'belgrad-ormani')", sql)
        self.assertTrue(sql.strip().endswith("commit;"))

    def test_invalid_rows_reported(self):
        rows = [
            {"onay": "x", "slug": "Bad Slug", "kategori": "mosque", "ad_tr": "a", "ad_en": "b", "enlem": "41", "boylam": "29"},
            {"onay": "x", "slug": "ok", "kategori": "spaceport", "ad_tr": "a", "ad_en": "b", "enlem": "41", "boylam": "29"},
            {"onay": "x", "slug": "no-en", "kategori": "mosque", "ad_tr": "a", "ad_en": "", "enlem": "41", "boylam": "29"},
            {"onay": "", "slug": "skip", "kategori": "mosque", "ad_tr": "a", "ad_en": "b", "enlem": "41", "boylam": "29"},
        ]
        sql, stats = p.build_sql(rows, {})
        self.assertEqual(sql, "")
        self.assertEqual(stats["approved"], 3)
        self.assertEqual(len(stats["errors"]), 3)


if __name__ == "__main__":
    unittest.main()
