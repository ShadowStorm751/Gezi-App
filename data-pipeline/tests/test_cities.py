"""Şehir parametresi testleri (internet gerekmez)."""
import sys
import unittest
from pathlib import Path

HERE = Path(__file__).resolve().parent
sys.path.insert(0, str(HERE.parent))
sys.path.insert(0, str(HERE.parent / "content"))

import cities  # noqa: E402
import pipeline as p  # noqa: E402

CAPPADOCIA = cities.CITIES["kapadokya"]
IZMIR = cities.CITIES["izmir"]


class QueryTests(unittest.TestCase):
    def test_istanbul_query_is_pilot_query(self):
        q = p.OVERPASS_QUERY
        self.assertEqual(q, cities.overpass_query(cities.CITIES["istanbul"]))
        self.assertIn('["name"="İstanbul"]->.ist;', q)
        self.assertEqual(q.count("(area.ist);"), 17)
        self.assertTrue(q.startswith("\n[out:json][timeout:300];\n") and q.endswith(");\nout geom;\n"))

    def test_multi_region_city(self):
        q = cities.overpass_query(CAPPADOCIA)
        self.assertIn('["name"="Nevşehir"]->.nev;', q)
        self.assertIn('nwr["natural"="valley"]["name"](area.nev);', q)
        self.assertIn('nwr["tourism"="museum"]["name"](38.20,34.20,38.33,34.34);', q)  # Ihlara
        n_sel = len(cities.BASE_SELECTORS) + len(CAPPADOCIA.extra_selectors)
        self.assertEqual(q.count("  nwr["), n_sel * len(CAPPADOCIA.regions))

    def test_unknown_city(self):
        with self.assertRaises(SystemExit):
            cities.get_city("ankara-yok")


class FetchTests(unittest.TestCase):
    def test_timeout_remark_is_error_and_chunks_merge(self):
        import json
        calls = []

        def fake_request(url, data, timeout):
            calls.append(url)
            if len(calls) == 1:  # ilk yanıt: sunucu zaman aşımı, boş liste
                return json.dumps({"elements": [], "remark": "runtime error: Query timed out"}).encode()
            el = {"type": "node", "id": 7, "lat": 38.4, "lon": 27.1, "tags": {"name": "X"}}
            return json.dumps({"elements": [el]}).encode()

        orig_req, orig_sleep = p._request, p.time.sleep
        p._request, p.time.sleep = fake_request, lambda s: None
        try:
            data = p._overpass("q", 10)
            self.assertEqual(len(calls), 2)  # ikinci sunucuya geçti
            self.assertEqual(len(data["elements"]), 1)
            merged = p.fetch_osm_chunked(IZMIR)
            self.assertEqual(len(merged["elements"]), 1)  # aynı öğe tek kez
        finally:
            p._request, p.time.sleep = orig_req, orig_sleep


class ClassifyTests(unittest.TestCase):
    def test_extras_only_when_enabled(self):
        valley = {"natural": "valley", "name": "Güvercinlik Vadisi"}
        self.assertIsNone(p.classify(valley))
        self.assertEqual(p.classify(valley, CAPPADOCIA.extra_rules), "valley")

    def test_extras_never_override_base(self):
        museum = {"tourism": "museum", "name": "Göreme Açık Hava Müzesi Kilisesi"}
        self.assertEqual(p.classify(museum, CAPPADOCIA.extra_rules), "museum")

    def test_cappadocia_rules(self):
        c = lambda tags: p.classify(tags, CAPPADOCIA.extra_rules)  # noqa: E731
        self.assertEqual(c({"tourism": "attraction", "name": "Derinkuyu Yeraltı Şehri"}), "archaeological_site")
        self.assertEqual(c({"tourism": "attraction", "name": "Paşabağları"}), "viewpoint")
        self.assertEqual(c({"natural": "rock", "name": "Üç Güzeller"}), "viewpoint")
        self.assertEqual(c({"historic": "church", "name": "Karanlık Kilise"}), "church")
        self.assertEqual(c({"tourism": "attraction", "name": "Saruhan Kervansarayı"}), "monument")
        self.assertIsNone(c({"tourism": "attraction", "name": "Balon Turu Ofisi"}))

    def test_bath_rule(self):
        tags = {"amenity": "public_bath", "name": "Eski Kaplıca", "wikidata": "Q1"}
        self.assertIsNone(p.classify(tags))
        self.assertEqual(p.classify(tags, IZMIR.extra_rules), "monument")


class CityCandidateTests(unittest.TestCase):
    def test_period_by_city(self):
        self.assertEqual(p.guess_period(1340), "Bizans")                       # İstanbul
        self.assertEqual(p.guess_period(1340, cities.CITIES["bursa"].periods), "Osmanlı")
        self.assertEqual(p.guess_period(1375, IZMIR.periods), "Beylikler")
        self.assertEqual(p.guess_period(1229, CAPPADOCIA.periods), "Selçuklu")
        self.assertEqual(p.guess_period(1950, CAPPADOCIA.periods), "Cumhuriyet")

    def test_name_suffix_by_city(self):
        self.assertEqual(p.clean_name("Saat Kulesi (İzmir)", IZMIR.name_suffixes), "Saat Kulesi")
        self.assertEqual(p.clean_name("Saat Kulesi (İzmir)"), "Saat Kulesi (İzmir)")  # İstanbul ayarı

    def test_city_quota_and_cap(self):
        els = [{"type": "node", "id": i, "lat": 38 + i / 100, "lon": 27.0,
                "tags": {"amenity": "place_of_worship", "religion": "muslim", "name": f"Cami {i}", "heritage": "2"}}
               for i in range(60)]
        self.assertEqual(len(p.build_candidates({"elements": els}, {}, IZMIR)), IZMIR.category_cap["mosque"])

    def test_valley_area(self):
        ring = [{"lat": 38.6, "lon": 34.8}, {"lat": 38.6, "lon": 34.82}, {"lat": 38.62, "lon": 34.82},
                {"lat": 38.6, "lon": 34.8}]
        osm = {"elements": [{"type": "way", "id": 5, "geometry": ring,
                             "tags": {"natural": "valley", "name": "Kızılçukur Vadisi"}}]}
        c = p.build_candidates(osm, {}, CAPPADOCIA)[0]
        self.assertEqual((c["kategori"], c["aile"], c["alan_var"], c["yaricap_m"]), ("valley", "nature", "evet", 300))


class BuildSqlTests(unittest.TestCase):
    ROW = {"onay": "x", "slug": "saat-kulesi", "kategori": "tower", "ad_tr": "Saat Kulesi", "ad_en": "Clock Tower",
           "kisa_aciklama_tr": "a", "kisa_aciklama_en": "b", "enlem": "38.4189", "boylam": "27.1287"}

    def test_city_slug_and_unpublished(self):
        sql, stats = p.build_sql([dict(self.ROW)], {}, "izmir", publish=False)
        self.assertIn("join public.cities ci on ci.slug = 'izmir'", sql)
        self.assertNotIn("is_published = true", sql)
        self.assertEqual(stats["publishable"], 1)

    def test_istanbul_default_unchanged(self):
        sql, _ = p.build_sql([dict(self.ROW)], {})
        self.assertIn("join public.cities ci on ci.slug = 'istanbul'", sql)
        self.assertIn("update public.places set is_published = true", sql)


class MigrationTests(unittest.TestCase):
    def test_city_and_category_sql(self):
        import build_city as bc
        s = bc.city_sql(CAPPADOCIA)
        self.assertIn("'kapadokya', '{\"tr\": \"Kapadokya\", \"en\": \"Cappadocia\"}', 'Europe/Istanbul'", s)
        self.assertIn("on conflict (slug) do nothing", s)
        self.assertIn("('valley', 'tr', 'Vadi')", bc.categories_sql(["valley", "church"]))
        self.assertEqual(bc.categories_sql(["church"]), "")


if __name__ == "__main__":
    unittest.main()
