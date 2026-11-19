"""Veri hattının şehir ayarları.

Her şehir için: Overpass bölgesi, ek OSM etiketleri, kota ve kategori sınırları,
ad sonlarındaki "(İzmir)" gibi eklerin temizliği ve dönem tahmini.
İstanbul ayarları pilotla birebir aynıdır (çıktısı değişmemeli; testte kontrol edilir).

Yeni şehir eklemek: aşağıya bir City kaydı ekle, `python pipeline.py --city <slug> fetch`.
"""
from __future__ import annotations

from dataclasses import dataclass, field
from typing import Dict, FrozenSet, List, Optional, Tuple

# Bütün şehirlerde ortak OSM seçicileri (pilotta kullanılanlar, aynı sırayla).
BASE_SELECTORS: List[str] = [
    'nwr["tourism"="museum"]["name"]',
    'nwr["historic"~"^(castle|fort|citywalls|city_gate|tower|monument|memorial|ruins|archaeological_site|aqueduct|palace|manor|tomb|fountain|building)$"]["name"]',
    'nwr["amenity"="place_of_worship"]["name"]["wikidata"]',
    'nwr["amenity"="place_of_worship"]["name"]["heritage"]',
    'nwr["building"="palace"]["name"]',
    'nwr["tourism"="viewpoint"]["name"]',
    'nwr["natural"="peak"]["name"]',
    'nwr["natural"="wood"]["name"]',
    'nwr["landuse"="forest"]["name"]',
    'nwr["leisure"~"^(park|garden)$"]["name"]["wikidata"]',
    'nwr["leisure"="nature_reserve"]["name"]',
    'nwr["natural"="beach"]["name"]',
    'nwr["waterway"="waterfall"]["name"]',
    'nwr["place"~"^(island|islet)$"]["name"]',
    'nwr["tourism"="attraction"]["name"]["wikidata"]',
    'nwr["man_made"="lighthouse"]["name"]',
    'nwr["place"="square"]["name"]["wikidata"]',
]

# Pilot (İstanbul) ayarları
ISTANBUL_QUOTAS = {"historical": 200, "nature": 100}
ISTANBUL_CATEGORY_CAP = {"tomb": 20, "mosque": 40, "monument": 25, "museum": 30, "park": 25, "viewpoint": 20, "island": 12}
# (bu yıldan önce, dönem) — sırayla; son eşiği aşan yıl için son dönemden sonraki "Cumhuriyet"
ISTANBUL_PERIODS: Tuple[Tuple[int, str], ...] = ((330, "Antik"), (1453, "Bizans"), (1923, "Osmanlı"))


@dataclass(frozen=True)
class City:
    slug: str
    names: Dict[str, str]                 # {"tr": ..., "en": ...}
    area_defs: str                        # Overpass: bölgeleri tanımlayan satırlar
    regions: Tuple[str, ...]              # her seçiciye uygulanacak filtreler: "area.ist" ya da "güney,batı,kuzey,doğu"
    timezone: str = "Europe/Istanbul"
    extra_selectors: Tuple[str, ...] = ()
    extra_rules: FrozenSet[str] = frozenset()   # pipeline.classify_extra içindeki ek kurallar
    quotas: Dict[str, int] = field(default_factory=lambda: dict(ISTANBUL_QUOTAS))
    category_cap: Dict[str, int] = field(default_factory=lambda: dict(ISTANBUL_CATEGORY_CAP))
    name_suffixes: Tuple[str, ...] = ("istanbul", "İstanbul", "turkey", "türkiye")
    periods: Tuple[Tuple[int, str], ...] = ISTANBUL_PERIODS
    note: str = ""
    timeout_s: int = 300                  # Overpass sunucu zaman aşımı
    chunked: bool = False                 # True: her etiket grubu ayrı sorgu (büyük iller, yoğun sunucu)
    bbox: Optional[Tuple[float, float, float, float]] = None  # il sınırını kapsayan kutu (güney, batı, kuzey, doğu)
    tiles: int = 3                        # sınırı gereken gruplar bbox'ın tiles x tiles karelerine bölünür
    province: Optional[str] = None        # parça sorguda yerel kırpma için il sınırı (admin_level=4 adı)


def _province(name: str, var: str) -> str:
    return f'area["boundary"="administrative"]["admin_level"="4"]["name"="{name}"]->.{var};'


NEW_CITY_CAP = {"tomb": 25, "mosque": 30, "monument": 25, "museum": 25, "park": 15, "viewpoint": 25,
                "island": 10, "beach": 25, "church": 25, "archaeological_site": 40, "valley": 30, "forest": 20,
                "hill": 15}

CITIES: Dict[str, City] = {
    "istanbul": City(
        slug="istanbul",
        names={"tr": "İstanbul", "en": "Istanbul"},
        area_defs=_province("İstanbul", "ist"),
        regions=("area.ist",),
    ),
    "izmir": City(
        slug="izmir",
        names={"tr": "İzmir", "en": "Izmir"},
        province="İzmir",
        area_defs=_province("İzmir", "izm"),
        regions=("area.izm",),
        extra_selectors=('nwr["amenity"="public_bath"]["name"]["wikidata"]',),
        extra_rules=frozenset({"bath"}),
        quotas={"historical": 150, "nature": 100},
        category_cap=NEW_CITY_CAP,
        name_suffixes=("izmir", "İzmir", "turkey", "türkiye"),
        # Bizans'tan sonra Aydınoğulları (Selçuk, Birgi); Osmanlı 1426'dan itibaren.
        periods=((330, "Antik"), (1300, "Bizans"), (1426, "Beylikler"), (1923, "Osmanlı")),
        note="İzmir ili (Efes/Selçuk, Bergama, Çeşme dahil).",
        bbox=(37.75, 26.20, 39.40, 28.50),
        timeout_s=600,
        chunked=True,
    ),
    "bursa": City(
        slug="bursa",
        names={"tr": "Bursa", "en": "Bursa"},
        province="Bursa",
        area_defs=_province("Bursa", "bur"),
        regions=("area.bur",),
        extra_selectors=('nwr["amenity"="public_bath"]["name"]["wikidata"]',),
        extra_rules=frozenset({"bath"}),
        quotas={"historical": 150, "nature": 80},
        category_cap=NEW_CITY_CAP,
        name_suffixes=("bursa", "Bursa", "turkey", "türkiye"),
        # Bursa 1326'da Osmanlı'nın oldu (ilk başkent).
        periods=((330, "Antik"), (1326, "Bizans"), (1923, "Osmanlı")),
        note="Bursa ili (Uludağ, İznik, Cumalıkızık çevresi dahil).",
        bbox=(39.55, 28.10, 40.70, 30.05),
        timeout_s=600,
        chunked=True,
    ),
    "kapadokya": City(
        slug="kapadokya",
        names={"tr": "Kapadokya", "en": "Cappadocia"},
        # Kapadokya bir il değil: Nevşehir ili + Ihlara Vadisi-Selime (Aksaray) + Soğanlı (Kayseri).
        province="Nevşehir",
        area_defs=_province("Nevşehir", "nev"),
        regions=("area.nev", "38.20,34.20,38.33,34.34", "38.32,35.04,38.37,35.13"),
        extra_selectors=(
            'nwr["natural"="valley"]["name"]',
            'nwr["natural"~"^(rock|stone|cliff|cave_entrance)$"]["name"]',
            'nwr["tourism"="attraction"]["name"]',
            'nwr["amenity"="place_of_worship"]["religion"="christian"]["name"]',
            'nwr["historic"~"^(church|monastery)$"]["name"]',
        ),
        extra_rules=frozenset({"cappadocia"}),
        quotas={"historical": 120, "nature": 100},
        category_cap=NEW_CITY_CAP,
        name_suffixes=("nevşehir", "Nevşehir", "cappadocia", "Cappadocia", "kapadokya", "Kapadokya",
                       "turkey", "türkiye"),
        # Kayaya oyulmuş kiliseler Bizans; 1071 sonrası Selçuklu, 1308 sonrası Beylikler, 1466 Osmanlı.
        periods=((330, "Antik"), (1071, "Bizans"), (1308, "Selçuklu"), (1466, "Beylikler"), (1923, "Osmanlı")),
        timezone="Europe/Istanbul",
        note="Nevşehir ili + Ihlara Vadisi/Selime (Aksaray) + Soğanlı (Kayseri).",
        bbox=(38.25, 34.05, 39.35, 35.20),
        tiles=2,
        timeout_s=600,
        chunked=True,
    ),
}

DEFAULT_CITY = "istanbul"


def get_city(slug: Optional[str]) -> City:
    slug = slug or DEFAULT_CITY
    if slug not in CITIES:
        raise SystemExit(f"Bilinmeyen şehir: {slug}. Seçenekler: {', '.join(CITIES)}")
    return CITIES[slug]


def selectors(city: City) -> List[str]:
    return list(BASE_SELECTORS) + list(city.extra_selectors)


# Parça sorguda alan sınırı gerekmeyen gruplar `out center` ile gelir (çok daha hafif).
# Sınırı gereken: orman, park, ada, plaj, vadi, ören yeri (AREA_CATEGORIES).
_HISTORIC_AREA = 'nwr["historic"~"^(ruins|archaeological_site)$"]["name"]'
_HISTORIC_POINT = ('nwr["historic"~"^(castle|fort|citywalls|city_gate|tower|monument|memorial|aqueduct|palace|manor|'
                   'tomb|fountain|building)$"]["name"]')
_GEOM_MARKERS = ('"natural"="wood"', '"landuse"="forest"', '"leisure"~"^(park|garden)$"', '"nature_reserve"',
                 '"natural"="beach"', '"place"~"^(island|islet)$"', '"natural"="valley"', 'ruins|archaeological_site')


Box = Tuple[float, float, float, float]


def tile_boxes(bbox: Box, n: int) -> List[Box]:
    s, w, no, e = bbox
    dy, dx = (no - s) / n, (e - w) / n
    return [(round(s + i * dy, 4), round(w + j * dx, 4), round(s + (i + 1) * dy, 4), round(w + (j + 1) * dx, 4))
            for i in range(n) for j in range(n)]


def extra_boxes(city: City) -> List[Box]:
    """Bölgeler içindeki kutular (il dışı ek alanlar, ör. Ihlara)."""
    return [tuple(float(x) for x in r.split(",")) for r in city.regions if not r.startswith("area.")]  # type: ignore


def chunk_plan(city: City) -> List[Tuple[str, str, Box, bool]]:
    """Parça sorgu planı (yalnızca kutu filtresi, area yok): (seçici, 'center' | 'geom', kutu, il sınırına kırpılsın mı).

    Overpass'ta il alanı (area) filtresi pahalı; bunun yerine il kutusu sorgulanır, sonuç il sınırıyla
    yerelde kırpılır. Alan sınırı gerekmeyen gruplar tek kutuda `out center`, gerekenler kare kare `out geom`.
    Önce hafif (center) parçalar gelir. Ek kutular (Ihlara, Soğanlı) kırpılmaz."""
    assert city.bbox, f"{city.slug}: parça sorgu için bbox gerekli"
    light: List[Tuple[str, str, Box, bool]] = []
    heavy: List[Tuple[str, str, Box, bool]] = []
    for sel in selectors(city):
        parts = [_HISTORIC_AREA, _HISTORIC_POINT] if sel == BASE_SELECTORS[1] else [sel]
        for part in parts:
            geom = any(m in part for m in _GEOM_MARKERS)
            if geom:
                heavy.extend((part, "geom", t, True) for t in tile_boxes(city.bbox, city.tiles))
            else:
                light.append((part, "center", city.bbox, True))
            for box in extra_boxes(city):
                (heavy if geom else light).append((part, "geom" if geom else "center", box, False))
    return light + heavy


def box_query(sel: str, box: Box, out: str, timeout_s: int) -> str:
    return (f"\n[out:json][timeout:{timeout_s}];\n(\n  {sel}({box[0]},{box[1]},{box[2]},{box[3]});\n);\nout {out};\n")


def boundary_query(city: City, timeout_s: int) -> str:
    return (f"\n[out:json][timeout:{timeout_s}];\n"
            f'rel["boundary"="administrative"]["admin_level"="4"]["name"="{city.province}"];\nout geom;\n')


def overpass_query(city: City, only: Optional[List[str]] = None, out: str = "geom",
                   timeout_s: Optional[int] = None) -> str:
    """Şehrin tek parça Overpass sorgusu (İstanbul). only: yalnızca bu seçiciler."""
    lines = []
    for sel in (only if only is not None else selectors(city)):
        for region in city.regions:
            lines.append(f"  {sel}({region});")
    return (
        f"\n[out:json][timeout:{timeout_s or city.timeout_s}];\n"
        f"{city.area_defs}\n"
        "(\n" + "\n".join(lines) + f"\n);\nout {out};\n"
    )
