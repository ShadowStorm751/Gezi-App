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


def fake_overpass(calls, fail_first=False, node_lat=38.4, node_lng=27.1):
    """Sahte Overpass: il sınırı sorgusuna kare bir ilişki, diğerlerine tek düğüm döner."""
    import json
    import urllib.parse

    def req(url, data, timeout):
        calls.append(url)
        if fail_first and len(calls) == 1:
            return json.dumps({"elements": [], "remark": "runtime error: Query timed out"}).encode()
        q = urllib.parse.parse_qs(data.decode())["data"][0]
        if '"boundary"="administrative"' in q:
            sq = [{"lat": 37.0, "lon": 26.0}, {"lat": 37.0, "lon": 29.0}, {"lat": 40.0, "lon": 29.0},
                  {"lat": 40.0, "lon": 26.0}, {"lat": 37.0, "lon": 26.0}]
            return json.dumps({"elements": [{"type": "relation", "id": 1,
                                             "members": [{"type": "way", "role": "outer", "geometry": sq}]}]}).encode()
        els = [{"type": "node", "id": 7, "lat": node_lat, "lon": node_lng, "tags": {"name": "X"}},
               {"type": "node", "id": 8, "lat": 41.5, "lon": 27.1, "tags": {"name": "İl dışı"}}]
        return json.dumps({"elements": els}).encode()
    return req


class FetchTests(unittest.TestCase):
    def setUp(self):
        self.orig = (p._request, p.time.sleep)
        p.time.sleep = lambda s: None

    def tearDown(self):
        p._request, p.time.sleep = self.orig

    def test_timeout_remark_is_error(self):
        calls = []
        p._request = fake_overpass(calls, fail_first=True)
        data = p._overpass(cities.box_query('nwr["x"]', (1, 2, 3, 4), "center", 10), 10)
        self.assertEqual(len(calls), 2)  # zaman aşımı notu hata sayıldı, ikinci sunucuya geçti
        self.assertEqual(len(data["elements"]), 2)

    def test_chunks_merge_and_clip_to_province(self):
        calls = []
        p._request = fake_overpass(calls)
        merged = p.fetch_osm_chunked(IZMIR)
        ids = sorted(el["id"] for el in merged["elements"])
        self.assertEqual(ids, [7])  # il sınırı dışındaki düğüm kırpıldı, aynı öğe tek kez

    def test_extra_boxes_not_clipped(self):
        calls = []
        p._request = fake_overpass(calls, node_lat=38.25, node_lng=34.25)  # Ihlara: Nevşehir sınırı dışında
        merged = p.fetch_osm_chunked(CAPPADOCIA)
        self.assertEqual([el["id"] for el in merged["elements"]], [7])  # ek kutu kırpılmadı

    def test_cache_resumes(self):
        import tempfile
        calls = []
        p._request = fake_overpass(calls)
        with tempfile.TemporaryDirectory() as d:
            first = p.fetch_osm_chunked(IZMIR, Path(d))
            n = len(calls)
            second = p.fetch_osm_chunked(IZMIR, Path(d))
            self.assertEqual(len(calls), n)  # ikinci çalıştırma tamamen önbellekten
            self.assertEqual(first, second)

    def test_budget_stops_retries(self):
        def always_fail(url, data, timeout):
            raise p.urllib.error.URLError("502")
        p._request = always_fail
        with self.assertRaises(p.BudgetExceeded):
            p.fetch_osm_chunked(IZMIR, None, budget_s=0)


class ChunkPlanTests(unittest.TestCase):
    def test_plan_light_first_heavy_tiled(self):
        plan = cities.chunk_plan(IZMIR)
        outs = [o for _, o, _, _ in plan]
        self.assertEqual(outs, sorted(outs, key=lambda o: o != "center"))  # önce center
        kinds = {sel: o for sel, o, _, _ in plan}
        self.assertEqual(len(kinds), len(cities.selectors(IZMIR)) + 1)  # historic ikiye bölündü
        self.assertEqual(kinds['nwr["tourism"="museum"]["name"]'], "center")
        self.assertEqual(kinds['nwr["natural"="wood"]["name"]'], "geom")
        self.assertEqual(kinds['nwr["historic"~"^(ruins|archaeological_site)$"]["name"]'], "geom")
        wood = [b for sel, _, b, _ in plan if sel == 'nwr["natural"="wood"]["name"]']
        self.assertEqual(len(wood), IZMIR.tiles ** 2)
        self.assertEqual((wood[0][:2], wood[-1][2:]), (IZMIR.bbox[:2], IZMIR.bbox[2:]))

    def test_no_area_filter_in_box_queries(self):
        q = cities.box_query('nwr["tourism"="museum"]["name"]', IZMIR.bbox, "center", 90)
        self.assertNotIn("area", q)
        self.assertIn('nwr["tourism"="museum"]["name"](37.75,26.2,39.4,28.5);', q)
        self.assertIn("out center;", q)
        self.assertIn('["name"="İzmir"]', cities.boundary_query(IZMIR, 90))

    def test_cappadocia_extra_boxes_unclipped(self):
        plan = cities.chunk_plan(CAPPADOCIA)
        unclipped = {b for _, _, b, clip in plan if not clip}
        self.assertEqual(unclipped, {(38.20, 34.20, 38.33, 34.34), (38.31, 34.92, 38.38, 35.00)})

    def test_point_in_rings(self):
        sq = [(0.0, 0.0), (2.0, 0.0), (2.0, 2.0), (0.0, 2.0), (0.0, 0.0)]
        self.assertTrue(p.point_in_rings(1.0, 1.0, [sq]))
        self.assertFalse(p.point_in_rings(3.0, 1.0, [sq]))

    def test_center_geometry(self):
        el = {"type": "way", "id": 1, "center": {"lat": 38.4, "lon": 27.1}}
        self.assertEqual(p.element_geometry(el), (38.4, 27.1, None))
        rel = {"type": "relation", "id": 2, "center": {"lat": 38.5, "lon": 27.2}}
        self.assertEqual(p.element_geometry(rel), (38.5, 27.2, None))


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
        v = bc.categories_sql(["village"])
        self.assertIn("('village', 'historical', 'village', 21)", v)
        self.assertIn("('village', 'en', 'Historic Village')", v)
        self.assertEqual((p.CATEGORY_KIND["village"], p.DEFAULT_RADIUS_M["village"]), ("historical", 400))


if __name__ == "__main__":
    unittest.main()


class CoordsTests(unittest.TestCase):
    def test_classify(self):
        import coords
        base = {"enlem": "37.9394", "boylam": "27.3412"}
        self.assertEqual(coords.classify(dict(base), (37.9395, 27.3413), "Q1", False)["durum"], "uyumlu")
        self.assertEqual(coords.classify(dict(base, ana_yer="efes"), (37.9400, 27.3412), "Q1", False)["durum"], "kontrol")
        self.assertEqual(coords.classify(dict(base), None, "", False)["durum"], "wikidata_yok")
        r = coords.classify(dict(base, konum_yaklasik=True), (37.95, 27.35), "Q2", True)
        self.assertEqual((r["durum"], r["onerilen"]), ("yaklasik_duzeltildi", [37.95, 27.35]))


class ShortlistTests(unittest.TestCase):
    def test_no_slug_shared_between_cities(self):
        import json as _j
        import build_city as bc
        owner = {}
        for city in cities.CITIES.values():
            path = bc.results_dir(city) / "shortlist.json"
            if not path.exists():
                continue
            for i in _j.loads(path.read_text(encoding="utf-8")):
                slug = i.get("slug_override") or p.slugify(i["ad_tr"])
                self.assertNotIn(slug, owner, f"{slug}: {owner.get(slug)} ve {city.slug}")
                owner[slug] = city.slug

    def test_city_shortlists_consistent(self):
        import json as _j
        for city in ("izmir", "bursa", "kapadokya"):
            path = HERE.parent / "results" / city / "shortlist.json"
            if not path.exists():
                continue
            items = _j.loads(path.read_text(encoding="utf-8"))
            slugs = [i["slug"] for i in items]
            self.assertEqual(len(slugs), len(set(slugs)), city)
            for i in items:
                self.assertIn(i["kategori"], p.CATEGORY_KIND)
                self.assertTrue(i["ad_tr"] and i["ad_en"], i["slug"])
                if i["ana_yer"]:
                    self.assertIn(i["ana_yer"], slugs)
