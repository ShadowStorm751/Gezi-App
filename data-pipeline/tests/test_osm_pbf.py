"""Geofabrik/osmium dönüştürme testleri (osmium ya da internet gerekmez)."""
import json
import sys
import tempfile
import unittest
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent.parent))

import cities  # noqa: E402
import osm_pbf as op  # noqa: E402
import pipeline as p  # noqa: E402

IZMIR = cities.CITIES["izmir"]
SQ = [[26.0, 37.0], [29.0, 37.0], [29.0, 40.0], [26.0, 40.0], [26.0, 37.0]]


def feat(fid, props, gtype, coords):
    return {"type": "Feature", "id": fid, "properties": props, "geometry": {"type": gtype, "coordinates": coords}}


class SelectorTests(unittest.TestCase):
    def test_parse_and_match(self):
        c = op.parse_selector('nwr["leisure"~"^(park|garden)$"]["name"]["wikidata"]')
        self.assertEqual(c, [("leisure", "~", "^(park|garden)$"), ("name", None, None), ("wikidata", None, None)])
        self.assertTrue(op.tags_match({"leisure": "garden", "name": "A", "wikidata": "Q1"}, c))
        self.assertFalse(op.tags_match({"leisure": "gardens", "name": "A", "wikidata": "Q1"}, c))
        self.assertFalse(op.tags_match({"leisure": "park", "name": "A"}, c))
        eq = op.parse_selector('nwr["tourism"="museum"]["name"]')
        self.assertTrue(op.tags_match({"tourism": "museum", "name": "M"}, eq))
        self.assertFalse(op.tags_match({"tourism": "museums", "name": "M"}, eq))

    def test_all_city_selectors_parse(self):
        for city in cities.CITIES.values():
            for sel in cities.selectors(city):
                self.assertTrue(op.parse_selector(sel), sel)

    def test_filter_expressions(self):
        ex = op.filter_expressions(cities.selectors(IZMIR))
        self.assertIn("nwr/tourism=museum", ex)
        self.assertIn("nwr/historic", ex)
        self.assertIn("nwr/amenity=place_of_worship", ex)
        self.assertEqual(len(ex), len(set(ex)))


class ConvertTests(unittest.TestCase):
    def test_ids(self):
        self.assertEqual(op._parse_id("n12"), ("node", 12))
        self.assertEqual(op._parse_id("w34"), ("way", 34))
        self.assertEqual(op._parse_id("a68"), ("way", 34))
        self.assertEqual(op._parse_id("a113"), ("relation", 56))
        self.assertIsNone(op._parse_id(None))

    def test_feature_shapes_match_overpass(self):
        node = op.feature_to_element(feat("n1", {"tourism": "museum", "name": "M"}, "Point", [27.1, 38.4]))
        self.assertEqual(p.element_geometry(node), (38.4, 27.1, None))

        ring = [[27.0, 38.0], [27.1, 38.0], [27.1, 38.1], [27.0, 38.0]]
        way = op.feature_to_element(feat("w2", {"natural": "wood", "name": "Orman"}, "Polygon", [ring]))
        lat, lng, r = p.element_geometry(way)
        self.assertEqual(way["type"], "way")
        self.assertEqual(r[0], r[-1])
        self.assertAlmostEqual(lat, 38.0333, places=3)

        rel = op.feature_to_element(feat("r3", {"place": "island", "name": "Ada"}, "MultiPolygon", [[ring]]))
        lat, lng, r = p.element_geometry(rel)
        self.assertEqual(rel["type"], "relation")
        self.assertIsNotNone(r)
        self.assertAlmostEqual(lat, 38.05)

        line = op.feature_to_element(feat("w4", {"historic": "citywalls", "name": "Sur"}, "LineString",
                                          [[27.0, 38.0], [27.2, 38.0]]))
        self.assertEqual(p.element_geometry(line)[2], None)

    def test_province_and_selection(self):
        feats = [feat("r9", {"boundary": "administrative", "admin_level": "4", "name": "İzmir"}, "MultiPolygon", [[SQ]]),
                 feat("r8", {"boundary": "administrative", "admin_level": "4", "name": "Manisa"}, "Polygon", [SQ])]
        rings = op.province_rings(feats, "İzmir")
        self.assertEqual(len(rings), 1)

        data = [
            feat("n1", {"tourism": "museum", "name": "Müze"}, "Point", [27.1, 38.4]),
            feat("n2", {"tourism": "museum", "name": "Dışarıda"}, "Point", [30.0, 38.4]),    # il dışı
            feat("n3", {"tourism": "museum"}, "Point", [27.1, 38.4]),                       # adı yok
            feat("n4", {"shop": "bakery", "name": "Fırın"}, "Point", [27.1, 38.4]),         # seçici dışı
        ]
        with tempfile.TemporaryDirectory() as d:
            path = Path(d) / "x.geojsonseq"
            path.write_text("\n".join("\x1e" + json.dumps(f) for f in data), encoding="utf-8")
            found = op.select_elements(op.read_geojsonseq(path), IZMIR, rings, True, p.point_in_rings, p.element_geometry)
        self.assertEqual(list(found), [("node", 1)])
        # sonraki adım (aday üretimi) bu biçimle çalışır
        cands = p.build_candidates({"elements": list(found.values())}, {}, IZMIR)
        self.assertEqual(cands[0]["kategori"], "museum")


if __name__ == "__main__":
    unittest.main()
