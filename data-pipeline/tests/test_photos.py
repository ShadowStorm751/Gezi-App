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
