"""Fotoğraf script'i testleri (internet gerekmez)."""
import sys
import unittest
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent.parent))

import photos as ph  # noqa: E402


def page(license_short, artist='<a href="//commons.wikimedia.org/wiki/User:X">Ali Veli</a>', mime="image/jpeg",
         thumb="https://upload.wikimedia.org/wikipedia/commons/thumb/a/ab/Ayasofya.jpg/1280px-Ayasofya.jpg"):
    return {
        "title": "File:Ayasofya.jpg",
        "imageinfo": [{
            "url": "https://upload.wikimedia.org/wikipedia/commons/a/ab/Ayasofya.jpg",
            "thumburl": thumb, "thumbwidth": 1280, "thumbheight": 853,
            "descriptionurl": "https://commons.wikimedia.org/wiki/File:Ayasofya.jpg",
            "mime": mime,
            "extmetadata": {
                "Artist": {"value": artist},
                "LicenseShortName": {"value": license_short},
                "LicenseUrl": {"value": "https://creativecommons.org/licenses/by-sa/4.0"},
            },
        }],
    }


class LicenseTests(unittest.TestCase):
    def test_free_licenses_accepted(self):
        for lic in ["CC BY-SA 4.0", "CC BY 2.0", "CC-BY-SA-3.0", "CC0", "Public domain", "PD-old", "CC BY-SA 3.0 de", "FAL"]:
            self.assertTrue(ph.license_ok(lic), lic)

    def test_restricted_licenses_rejected(self):
        for lic in ["CC BY-NC 2.0", "CC BY-ND 4.0", "CC BY-NC-SA 2.0", "GFDL", "", "All rights reserved"]:
            self.assertFalse(ph.license_ok(lic), lic)


class ParseTests(unittest.TestCase):
    def test_parse_ok(self):
        info = ph.parse_imageinfo(page("CC BY-SA 4.0"))
        self.assertEqual(info["author"], "Ali Veli")          # HTML temizlendi
        self.assertEqual(info["license"], "CC BY-SA 4.0")
        self.assertTrue(info["url"].endswith("/1280px-Ayasofya.jpg"))
        self.assertTrue(info["thumb_url"].endswith("/500px-Ayasofya.jpg"))
        self.assertEqual((info["width"], info["height"]), (1280, 853))
        self.assertEqual(info["file"], "Ayasofya.jpg")

    def test_parse_rejects_nc_and_non_images(self):
        self.assertIsNone(ph.parse_imageinfo(page("CC BY-NC 2.0")))
        self.assertIsNone(ph.parse_imageinfo(page("CC BY 2.0", mime="application/pdf")))
        self.assertIsNone(ph.parse_imageinfo({"title": "File:x.jpg"}))

    def test_small_original_keeps_url(self):
        url = "https://upload.wikimedia.org/wikipedia/commons/a/ab/Small.jpg"
        self.assertEqual(ph.thumb_from(url, 500), url)

    def test_cleanup(self):
        url = ("https://thumb.wikimedia.org/wikipedia/commons/thumb/8/81/B.JPG/1280px-B.JPG"
               "?utm_source=commons.wikimedia.org&utm_campaign=imageinfo")
        info = ph.parse_imageinfo(page("CC0", artist="My another account ( talk )", thumb=url))
        self.assertEqual(info["url"], "https://thumb.wikimedia.org/wikipedia/commons/thumb/8/81/B.JPG/1280px-B.JPG")
        self.assertTrue(info["thumb_url"].endswith("/500px-B.JPG"))
        self.assertEqual(info["author"], "My another account")

    def test_missing_artist(self):
        self.assertEqual(ph.parse_imageinfo(page("CC0", artist=""))["author"], "Bilinmiyor / Unknown")


class SearchPickTests(unittest.TestCase):
    def ent(self, qid, lat, lng, human=False):
        claims = {"P625": [{"mainsnak": {"datavalue": {"value": {"latitude": lat, "longitude": lng}}}}]}
        if human:
            claims["P31"] = [{"mainsnak": {"datavalue": {"value": {"id": "Q5"}}}}]
        return {"id": qid, "claims": claims}

    def test_picks_nearest_within_limit(self):
        ents = [self.ent("Q1", 41.10, 29.10), self.ent("Q2", 41.0158, 28.9646), self.ent("Q3", 41.0160, 28.9650)]
        self.assertEqual(ph.pick_search_hit(ents, 41.0157, 28.96447, 1500)["id"], "Q2")

    def test_rejects_far_and_people(self):
        ents = [self.ent("Q1", 41.20, 29.10), self.ent("Q5x", 41.0157, 28.9645, human=True)]
        self.assertIsNone(ph.pick_search_hit(ents, 41.0157, 28.96447, 1500))


if __name__ == "__main__":
    unittest.main()


class FallbackTests(unittest.TestCase):
    def test_keywords_and_match(self):
        kw = ph.name_keywords("Ayıbalığı Plajı", "Ayıbalığı Beach")
        self.assertEqual(kw, ["ayibaligi"])
        self.assertTrue(ph.title_matches("File:Ayıbalığı koyu Karaburun.jpg", kw))
        self.assertFalse(ph.title_matches("File:Karaburun sahil.jpg", kw))
        self.assertEqual(ph.name_keywords("Tarihi Asansör"), ["asansor"])

    def test_photo_file(self):
        self.assertTrue(ph.is_photo_file("File:A.JPG"))
        self.assertFalse(ph.is_photo_file("File:A.svg"))
        self.assertFalse(ph.is_photo_file("File:A.pdf"))

    def test_commons_category(self):
        e = {"claims": {"P373": [{"mainsnak": {"datavalue": {"value": "Şirince"}}}]}}
        self.assertEqual(ph.entity_commons_category(e), "Şirince")
        self.assertIsNone(ph.entity_commons_category({}))


class FallbackFlowTests(unittest.TestCase):
    def test_fallback_uses_names_without_prefix(self):
        seen = {}

        def fake_info(files):
            seen["files"] = files
            return {f: {"title": "File:" + f, "imageinfo": [{
                "url": "https://upload.wikimedia.org/a.jpg", "thumburl": "https://upload.wikimedia.org/a.jpg",
                "thumbwidth": 1280, "thumbheight": 853, "mime": "image/jpeg",
                "descriptionurl": "https://commons.wikimedia.org/wiki/File:" + f,
                "extmetadata": {"LicenseShortName": {"value": "CC BY-SA 4.0"}, "Artist": {"value": "X"}}}]}
                for f in files}

        orig = (ph.fetch_imageinfo, ph.commons_geosearch, ph.commons_category_files)
        ph.fetch_imageinfo = fake_info
        ph.commons_geosearch = lambda lat, lng, r, limit=50: [
            {"title": "File:Sirince village 2019.jpg", "dist": 50}, {"title": "File:Selcuk.jpg", "dist": 10}]
        ph.commons_category_files = lambda c, limit=30: []
        try:
            info = ph.commons_fallback({"ad_tr": "Şirince", "ad_en": "Şirince", "kategori": "village",
                                        "enlem": "37.94", "boylam": "27.43"}, None)
        finally:
            ph.fetch_imageinfo, ph.commons_geosearch, ph.commons_category_files = orig
        self.assertEqual(seen["files"], ["Sirince village 2019.jpg"])   # önek yok, adı uymayan elendi
        self.assertEqual((info["kaynak"], info["dosya"]), ("commons-yakin", "Sirince village 2019.jpg"))


class PhotoSearchHelpersTest(unittest.TestCase):
    def test_radius_and_distance(self):
        import photo_search as s
        self.assertEqual(s.search_radius({"ana_yer": "efes", "kategori": "ruins"}), 150)
        self.assertEqual(s.search_radius({"ana_yer": "", "kategori": "museum"}), 800)
        self.assertAlmostEqual(s.dist_m((38.0, 27.0), (38.001, 27.0)), 111, delta=1)
