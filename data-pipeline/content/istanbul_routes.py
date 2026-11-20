#!/usr/bin/env python3
"""İstanbul hazır rotaları -> backend/supabase/migrations/20261119270000_istanbul_routes.sql

Duraklar mevcut yer slug'larıdır (results/shortlist.json + DROPPED dışı). Sıra yürüyüş sırasıdır.
est_minutes gezme süresi dahil yaklaşık toplamdır. Tekrar çalıştırılabilir: rotalar slug'a göre
güncellenir, durakları baştan yazılır.
"""
from __future__ import annotations

import json
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent.parent
OUT = ROOT / "backend/supabase/migrations/20261119270000_istanbul_routes.sql"

# slug: (kind, travel_mode, est_minutes, [duraklar], (tr başlık, tr özet), (en başlık, en özet))
ROUTES = {
    "sultanahmet-klasikleri": (
        "historical", "walking", 240,
        ["ayasofya", "ayasofya-turbeleri", "yerebatan-sarnici", "milyon-tasi", "alman-cesmesi",
         "sultanahmet-meydani-hipodrom", "dikilitas", "orme-dikilitas", "sultanahmet-camii",
         "sultan-ahmed-turbesi", "buyuk-saray-mozaikleri-muzesi"],
        ("Sultanahmet Klasikleri",
         "Ayasofya'dan Sultanahmet Camii'ne, Bizans ve Osmanlı'nın yan yana durduğu meydanda kısa ama dolu bir yürüyüş. Yerebatan'ın serinliği, Hipodrom'un dikilitaşları ve Büyük Saray mozaikleri."),
        ("Sultanahmet Classics",
         "A short but packed walk from Hagia Sophia to the Blue Mosque, where Byzantium and the Ottomans stand side by side: the cool Basilica Cistern, the Hippodrome's obelisks and the Great Palace mosaics."),
    ),
    "topkapi-ve-gulhane": (
        "historical", "walking", 300,
        ["iii-ahmed-cesmesi", "aya-irini", "topkapi-sarayi", "cinili-kosk", "istanbul-arkeoloji-muzeleri",
         "gulhane-parki", "gotlar-sutunu", "sarayburnu-manzarasi"],
        ("Topkapı ve Gülhane",
         "Sarayın kapısındaki çeşmeden başlayıp Topkapı'nın avlularına, oradan Arkeoloji Müzeleri'ne ve Gülhane'nin ağaçları arasından Sarayburnu'na inen bir gün. Rotanın sonunda Boğaz ağzı manzarası."),
        ("Topkapı and Gülhane",
         "A day that starts at the fountain by the palace gate, moves through Topkapı's courtyards and the Archaeology Museums, then strolls down through Gülhane's trees to Sarayburnu and its view of the Bosphorus mouth."),
    ),
    "carsilar-ve-suleymaniye": (
        "historical", "walking", 240,
        ["cemberlitas-sutunu", "nuruosmaniye-camii", "kapalicarsi", "bayezid-camii", "suleymaniye-camii",
         "kanuni-sultan-suleyman-turbesi", "hurrem-sultan-turbesi", "rustem-pasa-camii", "misir-carsisi",
         "turhan-sultan-turbesi", "yeni-cami"],
        ("Çarşılar ve Süleymaniye",
         "Kapalıçarşı'nın sokaklarından Mimar Sinan'ın başyapıtı Süleymaniye'ye, oradan Haliç'e doğru inerek Rüstem Paşa'nın çinilerine ve Mısır Çarşısı'nın baharat kokusuna uzanan rota."),
        ("Bazaars and Süleymaniye",
         "From the lanes of the Grand Bazaar to Sinan's masterpiece, the Süleymaniye, then down towards the Golden Horn for the tiles of Rüstem Pasha and the spice-scented Egyptian Bazaar."),
    ),
    "galata-ve-pera": (
        "historical", "walking", 210,
        ["neve-salom-sinagogu", "galata-kulesi", "galata-mevlevihanesi-muzesi", "pera-muzesi",
         "st-antuan-katolik-kilisesi", "masumiyet-muzesi", "aya-triada-kilisesi", "taksim-cumhuriyet-aniti"],
        ("Galata'dan Taksim'e",
         "Galata Kulesi'nin dibinden Mevlevihane'ye, İstiklal Caddesi boyunca Pera'nın müzelerine ve kiliselerine uğrayıp Taksim Meydanı'nda biten bir yürüyüş. Farklı inançların yüzyıllardır komşu olduğu semt."),
        ("Galata to Taksim",
         "A walk from the foot of Galata Tower to the Mevlevi lodge, then along İstiklal Avenue past Pera's museums and churches, ending at Taksim Square. A district where faiths have been neighbours for centuries."),
    ),
    "fener-balat-ve-surlar": (
        "historical", "walking", 240,
        ["yavuz-selim-camii", "aya-yorgi-patrikhane-kilisesi", "sveti-stefan-kilisesi", "ahrida-sinagogu",
         "fethiye-camii", "kariye-camii", "mihrimah-sultan-camii-edirnekapi", "tekfur-sarayi"],
        ("Fener, Balat ve Surlar",
         "Renkli evlerin arasında Rum Patrikhanesi, demir kilise ve Ahrida Sinagogu; ardından tepeye çıkıp Kariye'nin mozaikleri ve kara surlarının dibindeki Tekfur Sarayı. Yokuşlu ama çok fotoğraflık."),
        ("Fener, Balat and the Walls",
         "The Greek Patriarchate, the iron church and Ahrida Synagogue among colourful houses; then uphill to the mosaics of Chora and Tekfur Palace at the foot of the land walls. Hilly but very photogenic."),
    ),
    "dolmabahceden-ortakoye": (
        "historical", "walking", 240,
        ["dolmabahce-camii", "dolmabahce-sarayi", "istanbul-deniz-muzesi", "barbaros-hayreddin-pasa-turbesi",
         "ciragan-sarayi", "yildiz-parki", "malta-kosku", "ortakoy-camii"],
        ("Dolmabahçe'den Ortaköy'e",
         "Boğaz kıyısında sarayların rotası: Dolmabahçe, Deniz Müzesi ve Barbaros Türbesi'nden sonra Çırağan'ı geçip Yıldız Parkı'nın yokuşunda bir mola, sonra Ortaköy Camii'nin önünde Boğaz Köprüsü manzarası."),
        ("Dolmabahçe to Ortaköy",
         "A route of Bosphorus palaces: Dolmabahçe, the Naval Museum and Barbarossa's tomb, past Çırağan to a break in hilly Yıldız Park, then the bridge view in front of Ortaköy Mosque."),
    ),
    "uskudar-ve-camlica": (
        "mixed", "mixed", 270,
        ["mihrimah-sultan-camii-uskudar", "yeni-valide-camii", "aziz-mahmud-hudayi-turbesi", "kiz-kulesi",
         "sakirin-camii", "kucukcamlica-korusu", "buyuk-camlica-tepesi", "camlica-camii"],
        ("Üsküdar ve Çamlıca",
         "İskele meydanındaki Sinan camilerinden Hüdayi'ye, Salacak'tan Kız Kulesi'ne; ardından otobüs ya da taksiyle Çamlıca tepelerine çıkıp bütün şehri yukarıdan görmek. Gün batımına denk getirin."),
        ("Üsküdar and Çamlıca",
         "Sinan's mosques on the pier square, the shrine of Hüdayi and the Maiden's Tower off Salacak; then a bus or taxi up to the Çamlıca hills to see the whole city from above. Best timed for sunset."),
    ),
    "adalar": (
        "nature", "ferry", 420,
        ["kinaliada", "burgaz-adasi", "heybeliada", "buyukada", "adalar-muzesi"],
        ("Adalar",
         "Vapurla dört adaya sırayla uğrayan bir gün: Kınalıada'nın kızıl yamaçları, sakin Burgaz, çam ormanlı Heybeliada ve köşkleriyle Büyükada. Bütün adalar bitince 'Adalar Turu' rozeti de gelir."),
        ("The Princes' Islands",
         "A ferry day hopping across four islands: red-tinged Kınalıada, quiet Burgaz, pine-covered Heybeliada and Büyükada with its mansions. Visiting all of them also earns the 'Islands Tour' badge."),
    ),
    "bebekten-emirgana": (
        "mixed", "walking", 240,
        ["bebek-parki", "asiyan-muzesi", "rumeli-hisari", "sakip-sabanci-muzesi", "emirgan-korusu"],
        ("Bebek'ten Emirgan'a",
         "Boğaz kıyısında sahil yolu boyunca yürüyüş: Bebek koyundan Aşiyan'a, Rumeli Hisarı'nın burçlarına, Sakıp Sabancı Müzesi'ne ve ilkbaharda lalelerle dolan Emirgan Korusu'na."),
        ("Bebek to Emirgan",
         "A shoreline walk along the Bosphorus: from Bebek bay to Aşiyan, the towers of Rumeli Fortress, the Sakıp Sabancı Museum and Emirgan Grove, full of tulips in spring."),
    ),
    "kadikoy-sahili": (
        "nature", "walking", 180,
        ["yogurtcu-parki", "moda-sahili", "fenerbahce-parki", "goztepe-60-yil-parki"],
        ("Kadıköy Sahili",
         "Yoğurtçu Parkı'ndan Moda'nın kayalıklarına, oradan Fenerbahçe burnuna uzanan sahil yürüyüşü. Moda'da tarihi yarımadaya karşı gün batımı, rotanın sonunda Göztepe'nin yeşil parkı."),
        ("Kadıköy Seafront",
         "A seaside walk from Yoğurtçu Park to the rocks of Moda and on to Fenerbahçe point. Sunset over the old city from Moda, and Göztepe's green park at the end."),
    ),
    "bogaz-manzaralari": (
        "nature", "driving", 360,
        ["pierre-loti-tepesi", "buyuk-camlica-tepesi", "otagtepe", "yoros-kalesi",
         "anadolu-kavagi-manzara-seyir-noktasi"],
        ("Boğaz Manzaraları",
         "Arabayla yapılacak bir manzara günü: Pierre Loti'den Haliç, Çamlıca'dan şehir, Otağtepe'den Fatih Sultan Mehmet Köprüsü ve son durakta Yoros Kalesi'nden Boğaz'ın Karadeniz'e açıldığı yer."),
        ("Bosphorus Views",
         "A viewpoint day by car: the Golden Horn from Pierre Loti, the city from Çamlıca, the Fatih Sultan Mehmet Bridge from Otağtepe and, at the last stop, the Bosphorus opening to the Black Sea from Yoros Castle."),
    ),
}


def q(v) -> str:
    return "'" + str(v).replace("'", "''") + "'"


def main() -> int:
    sys.path.insert(0, str(Path(__file__).resolve().parent))
    sys.path.insert(0, str(ROOT / "data-pipeline"))
    import pipeline as p  # noqa: E402
    from istanbul_descriptions import DROPPED  # noqa: E402

    known = {p.slugify(s["ad_tr"]) for s in json.loads(
        (ROOT / "data-pipeline/results/shortlist.json").read_text(encoding="utf-8"))} - set(DROPPED)
    errors = []
    for slug, (kind, mode, mins, stops, tr, en) in ROUTES.items():
        for s in stops:
            if s not in known:
                errors.append(f"{slug}: bilinmeyen durak {s}")
        if len(set(stops)) != len(stops):
            errors.append(f"{slug}: tekrar eden durak")
        for title, summary in (tr, en):
            if not (3 <= len(title) <= 80 and 10 <= len(summary) <= 400):
                errors.append(f"{slug}: başlık/özet uzunluğu ({len(title)}, {len(summary)})")
    if errors:
        print("\n".join(errors), file=sys.stderr)
        return 1

    route_rows, tr_rows, stop_rows = [], [], []
    for order, (slug, (kind, mode, mins, stops, tr, en)) in enumerate(ROUTES.items(), start=1):
        route_rows.append(f"  ({q(slug)}, {q(kind)}, {q(mode)}, {mins}, {order * 10})")
        tr_rows.append(f"  ({q(slug)}, 'tr', {q(tr[0])}, {q(tr[1])})")
        tr_rows.append(f"  ({q(slug)}, 'en', {q(en[0])}, {q(en[1])})")
        for pos, s in enumerate(stops, start=1):
            stop_rows.append(f"  ({q(slug)}, {pos}, {q(s)})")
    nl = ",\n"
    slugs = ", ".join(q(s) for s in ROUTES)
    sql = f"""-- İstanbul hazır rotaları ({len(ROUTES)} rota, {len(stop_rows)} durak).
-- Üreten: data-pipeline/content/istanbul_routes.py. Elle düzenlemeyin; script'i değiştirip yeniden üretin.

insert into public.routes (slug, city_id, kind, travel_mode, est_minutes, sort_order, is_published)
select v.slug, ci.id, v.kind, v.mode::public.route_mode, v.mins, v.ord, true
from (values
{nl.join(route_rows)}
) v(slug, kind, mode, mins, ord)
join public.cities ci on ci.slug = 'istanbul'
on conflict (slug) do update set
  kind = excluded.kind, travel_mode = excluded.travel_mode, est_minutes = excluded.est_minutes,
  sort_order = excluded.sort_order, is_published = excluded.is_published;

insert into public.route_translations (route_id, lang, title, summary)
select r.id, v.lang, v.title, v.summary
from (values
{nl.join(tr_rows)}
) v(slug, lang, title, summary)
join public.routes r on r.slug = v.slug
on conflict (route_id, lang) do update set title = excluded.title, summary = excluded.summary;

delete from public.route_stops rs using public.routes r
where rs.route_id = r.id and r.slug in ({slugs});

insert into public.route_stops (route_id, position, place_id)
select r.id, v.pos, p.id
from (values
{nl.join(stop_rows)}
) v(slug, pos, place)
join public.routes r on r.slug = v.slug
join public.places p on p.slug = v.place;
"""
    OUT.write_text(sql, encoding="utf-8")
    print(f"{len(ROUTES)} rota, {len(stop_rows)} durak -> {OUT.relative_to(ROOT)}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
