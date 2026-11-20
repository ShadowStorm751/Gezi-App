-- İstanbul hazır rotaları (11 rota, 81 durak).
-- Üreten: data-pipeline/content/istanbul_routes.py. Elle düzenlemeyin; script'i değiştirip yeniden üretin.

insert into public.routes (slug, city_id, kind, travel_mode, est_minutes, sort_order, is_published)
select v.slug, ci.id, v.kind, v.mode::public.route_mode, v.mins, v.ord, true
from (values
  ('sultanahmet-klasikleri', 'historical', 'walking', 240, 10),
  ('topkapi-ve-gulhane', 'historical', 'walking', 300, 20),
  ('carsilar-ve-suleymaniye', 'historical', 'walking', 240, 30),
  ('galata-ve-pera', 'historical', 'walking', 210, 40),
  ('fener-balat-ve-surlar', 'historical', 'walking', 240, 50),
  ('dolmabahceden-ortakoye', 'historical', 'walking', 240, 60),
  ('uskudar-ve-camlica', 'mixed', 'mixed', 270, 70),
  ('adalar', 'nature', 'ferry', 420, 80),
  ('bebekten-emirgana', 'mixed', 'walking', 240, 90),
  ('kadikoy-sahili', 'nature', 'walking', 180, 100),
  ('bogaz-manzaralari', 'nature', 'driving', 360, 110)
) v(slug, kind, mode, mins, ord)
join public.cities ci on ci.slug = 'istanbul'
on conflict (slug) do update set
  kind = excluded.kind, travel_mode = excluded.travel_mode, est_minutes = excluded.est_minutes,
  sort_order = excluded.sort_order, is_published = excluded.is_published;

insert into public.route_translations (route_id, lang, title, summary)
select r.id, v.lang, v.title, v.summary
from (values
  ('sultanahmet-klasikleri', 'tr', 'Sultanahmet Klasikleri', 'Ayasofya''dan Sultanahmet Camii''ne, Bizans ve Osmanlı''nın yan yana durduğu meydanda kısa ama dolu bir yürüyüş. Yerebatan''ın serinliği, Hipodrom''un dikilitaşları ve Büyük Saray mozaikleri.'),
  ('sultanahmet-klasikleri', 'en', 'Sultanahmet Classics', 'A short but packed walk from Hagia Sophia to the Blue Mosque, where Byzantium and the Ottomans stand side by side: the cool Basilica Cistern, the Hippodrome''s obelisks and the Great Palace mosaics.'),
  ('topkapi-ve-gulhane', 'tr', 'Topkapı ve Gülhane', 'Sarayın kapısındaki çeşmeden başlayıp Topkapı''nın avlularına, oradan Arkeoloji Müzeleri''ne ve Gülhane''nin ağaçları arasından Sarayburnu''na inen bir gün. Rotanın sonunda Boğaz ağzı manzarası.'),
  ('topkapi-ve-gulhane', 'en', 'Topkapı and Gülhane', 'A day that starts at the fountain by the palace gate, moves through Topkapı''s courtyards and the Archaeology Museums, then strolls down through Gülhane''s trees to Sarayburnu and its view of the Bosphorus mouth.'),
  ('carsilar-ve-suleymaniye', 'tr', 'Çarşılar ve Süleymaniye', 'Kapalıçarşı''nın sokaklarından Mimar Sinan''ın başyapıtı Süleymaniye''ye, oradan Haliç''e doğru inerek Rüstem Paşa''nın çinilerine ve Mısır Çarşısı''nın baharat kokusuna uzanan rota.'),
  ('carsilar-ve-suleymaniye', 'en', 'Bazaars and Süleymaniye', 'From the lanes of the Grand Bazaar to Sinan''s masterpiece, the Süleymaniye, then down towards the Golden Horn for the tiles of Rüstem Pasha and the spice-scented Egyptian Bazaar.'),
  ('galata-ve-pera', 'tr', 'Galata''dan Taksim''e', 'Galata Kulesi''nin dibinden Mevlevihane''ye, İstiklal Caddesi boyunca Pera''nın müzelerine ve kiliselerine uğrayıp Taksim Meydanı''nda biten bir yürüyüş. Farklı inançların yüzyıllardır komşu olduğu semt.'),
  ('galata-ve-pera', 'en', 'Galata to Taksim', 'A walk from the foot of Galata Tower to the Mevlevi lodge, then along İstiklal Avenue past Pera''s museums and churches, ending at Taksim Square. A district where faiths have been neighbours for centuries.'),
  ('fener-balat-ve-surlar', 'tr', 'Fener, Balat ve Surlar', 'Renkli evlerin arasında Rum Patrikhanesi, demir kilise ve Ahrida Sinagogu; ardından tepeye çıkıp Kariye''nin mozaikleri ve kara surlarının dibindeki Tekfur Sarayı. Yokuşlu ama çok fotoğraflık.'),
  ('fener-balat-ve-surlar', 'en', 'Fener, Balat and the Walls', 'The Greek Patriarchate, the iron church and Ahrida Synagogue among colourful houses; then uphill to the mosaics of Chora and Tekfur Palace at the foot of the land walls. Hilly but very photogenic.'),
  ('dolmabahceden-ortakoye', 'tr', 'Dolmabahçe''den Ortaköy''e', 'Boğaz kıyısında sarayların rotası: Dolmabahçe, Deniz Müzesi ve Barbaros Türbesi''nden sonra Çırağan''ı geçip Yıldız Parkı''nın yokuşunda bir mola, sonra Ortaköy Camii''nin önünde Boğaz Köprüsü manzarası.'),
  ('dolmabahceden-ortakoye', 'en', 'Dolmabahçe to Ortaköy', 'A route of Bosphorus palaces: Dolmabahçe, the Naval Museum and Barbarossa''s tomb, past Çırağan to a break in hilly Yıldız Park, then the bridge view in front of Ortaköy Mosque.'),
  ('uskudar-ve-camlica', 'tr', 'Üsküdar ve Çamlıca', 'İskele meydanındaki Sinan camilerinden Hüdayi''ye, Salacak''tan Kız Kulesi''ne; ardından otobüs ya da taksiyle Çamlıca tepelerine çıkıp bütün şehri yukarıdan görmek. Gün batımına denk getirin.'),
  ('uskudar-ve-camlica', 'en', 'Üsküdar and Çamlıca', 'Sinan''s mosques on the pier square, the shrine of Hüdayi and the Maiden''s Tower off Salacak; then a bus or taxi up to the Çamlıca hills to see the whole city from above. Best timed for sunset.'),
  ('adalar', 'tr', 'Adalar', 'Vapurla dört adaya sırayla uğrayan bir gün: Kınalıada''nın kızıl yamaçları, sakin Burgaz, çam ormanlı Heybeliada ve köşkleriyle Büyükada. Bütün adalar bitince ''Adalar Turu'' rozeti de gelir.'),
  ('adalar', 'en', 'The Princes'' Islands', 'A ferry day hopping across four islands: red-tinged Kınalıada, quiet Burgaz, pine-covered Heybeliada and Büyükada with its mansions. Visiting all of them also earns the ''Islands Tour'' badge.'),
  ('bebekten-emirgana', 'tr', 'Bebek''ten Emirgan''a', 'Boğaz kıyısında sahil yolu boyunca yürüyüş: Bebek koyundan Aşiyan''a, Rumeli Hisarı''nın burçlarına, Sakıp Sabancı Müzesi''ne ve ilkbaharda lalelerle dolan Emirgan Korusu''na.'),
  ('bebekten-emirgana', 'en', 'Bebek to Emirgan', 'A shoreline walk along the Bosphorus: from Bebek bay to Aşiyan, the towers of Rumeli Fortress, the Sakıp Sabancı Museum and Emirgan Grove, full of tulips in spring.'),
  ('kadikoy-sahili', 'tr', 'Kadıköy Sahili', 'Yoğurtçu Parkı''ndan Moda''nın kayalıklarına, oradan Fenerbahçe burnuna uzanan sahil yürüyüşü. Moda''da tarihi yarımadaya karşı gün batımı, rotanın sonunda Göztepe''nin yeşil parkı.'),
  ('kadikoy-sahili', 'en', 'Kadıköy Seafront', 'A seaside walk from Yoğurtçu Park to the rocks of Moda and on to Fenerbahçe point. Sunset over the old city from Moda, and Göztepe''s green park at the end.'),
  ('bogaz-manzaralari', 'tr', 'Boğaz Manzaraları', 'Arabayla yapılacak bir manzara günü: Pierre Loti''den Haliç, Çamlıca''dan şehir, Otağtepe''den Fatih Sultan Mehmet Köprüsü ve son durakta Yoros Kalesi''nden Boğaz''ın Karadeniz''e açıldığı yer.'),
  ('bogaz-manzaralari', 'en', 'Bosphorus Views', 'A viewpoint day by car: the Golden Horn from Pierre Loti, the city from Çamlıca, the Fatih Sultan Mehmet Bridge from Otağtepe and, at the last stop, the Bosphorus opening to the Black Sea from Yoros Castle.')
) v(slug, lang, title, summary)
join public.routes r on r.slug = v.slug
on conflict (route_id, lang) do update set title = excluded.title, summary = excluded.summary;

delete from public.route_stops rs using public.routes r
where rs.route_id = r.id and r.slug in ('sultanahmet-klasikleri', 'topkapi-ve-gulhane', 'carsilar-ve-suleymaniye', 'galata-ve-pera', 'fener-balat-ve-surlar', 'dolmabahceden-ortakoye', 'uskudar-ve-camlica', 'adalar', 'bebekten-emirgana', 'kadikoy-sahili', 'bogaz-manzaralari');

insert into public.route_stops (route_id, position, place_id)
select r.id, v.pos, p.id
from (values
  ('sultanahmet-klasikleri', 1, 'ayasofya'),
  ('sultanahmet-klasikleri', 2, 'ayasofya-turbeleri'),
  ('sultanahmet-klasikleri', 3, 'yerebatan-sarnici'),
  ('sultanahmet-klasikleri', 4, 'milyon-tasi'),
  ('sultanahmet-klasikleri', 5, 'alman-cesmesi'),
  ('sultanahmet-klasikleri', 6, 'sultanahmet-meydani-hipodrom'),
  ('sultanahmet-klasikleri', 7, 'dikilitas'),
  ('sultanahmet-klasikleri', 8, 'orme-dikilitas'),
  ('sultanahmet-klasikleri', 9, 'sultanahmet-camii'),
  ('sultanahmet-klasikleri', 10, 'sultan-ahmed-turbesi'),
  ('sultanahmet-klasikleri', 11, 'buyuk-saray-mozaikleri-muzesi'),
  ('topkapi-ve-gulhane', 1, 'iii-ahmed-cesmesi'),
  ('topkapi-ve-gulhane', 2, 'aya-irini'),
  ('topkapi-ve-gulhane', 3, 'topkapi-sarayi'),
  ('topkapi-ve-gulhane', 4, 'cinili-kosk'),
  ('topkapi-ve-gulhane', 5, 'istanbul-arkeoloji-muzeleri'),
  ('topkapi-ve-gulhane', 6, 'gulhane-parki'),
  ('topkapi-ve-gulhane', 7, 'gotlar-sutunu'),
  ('topkapi-ve-gulhane', 8, 'sarayburnu-manzarasi'),
  ('carsilar-ve-suleymaniye', 1, 'cemberlitas-sutunu'),
  ('carsilar-ve-suleymaniye', 2, 'nuruosmaniye-camii'),
  ('carsilar-ve-suleymaniye', 3, 'kapalicarsi'),
  ('carsilar-ve-suleymaniye', 4, 'bayezid-camii'),
  ('carsilar-ve-suleymaniye', 5, 'suleymaniye-camii'),
  ('carsilar-ve-suleymaniye', 6, 'kanuni-sultan-suleyman-turbesi'),
  ('carsilar-ve-suleymaniye', 7, 'hurrem-sultan-turbesi'),
  ('carsilar-ve-suleymaniye', 8, 'rustem-pasa-camii'),
  ('carsilar-ve-suleymaniye', 9, 'misir-carsisi'),
  ('carsilar-ve-suleymaniye', 10, 'turhan-sultan-turbesi'),
  ('carsilar-ve-suleymaniye', 11, 'yeni-cami'),
  ('galata-ve-pera', 1, 'neve-salom-sinagogu'),
  ('galata-ve-pera', 2, 'galata-kulesi'),
  ('galata-ve-pera', 3, 'galata-mevlevihanesi-muzesi'),
  ('galata-ve-pera', 4, 'pera-muzesi'),
  ('galata-ve-pera', 5, 'st-antuan-katolik-kilisesi'),
  ('galata-ve-pera', 6, 'masumiyet-muzesi'),
  ('galata-ve-pera', 7, 'aya-triada-kilisesi'),
  ('galata-ve-pera', 8, 'taksim-cumhuriyet-aniti'),
  ('fener-balat-ve-surlar', 1, 'yavuz-selim-camii'),
  ('fener-balat-ve-surlar', 2, 'aya-yorgi-patrikhane-kilisesi'),
  ('fener-balat-ve-surlar', 3, 'sveti-stefan-kilisesi'),
  ('fener-balat-ve-surlar', 4, 'ahrida-sinagogu'),
  ('fener-balat-ve-surlar', 5, 'fethiye-camii'),
  ('fener-balat-ve-surlar', 6, 'kariye-camii'),
  ('fener-balat-ve-surlar', 7, 'mihrimah-sultan-camii-edirnekapi'),
  ('fener-balat-ve-surlar', 8, 'tekfur-sarayi'),
  ('dolmabahceden-ortakoye', 1, 'dolmabahce-camii'),
  ('dolmabahceden-ortakoye', 2, 'dolmabahce-sarayi'),
  ('dolmabahceden-ortakoye', 3, 'istanbul-deniz-muzesi'),
  ('dolmabahceden-ortakoye', 4, 'barbaros-hayreddin-pasa-turbesi'),
  ('dolmabahceden-ortakoye', 5, 'ciragan-sarayi'),
  ('dolmabahceden-ortakoye', 6, 'yildiz-parki'),
  ('dolmabahceden-ortakoye', 7, 'malta-kosku'),
  ('dolmabahceden-ortakoye', 8, 'ortakoy-camii'),
  ('uskudar-ve-camlica', 1, 'mihrimah-sultan-camii-uskudar'),
  ('uskudar-ve-camlica', 2, 'yeni-valide-camii'),
  ('uskudar-ve-camlica', 3, 'aziz-mahmud-hudayi-turbesi'),
  ('uskudar-ve-camlica', 4, 'kiz-kulesi'),
  ('uskudar-ve-camlica', 5, 'sakirin-camii'),
  ('uskudar-ve-camlica', 6, 'kucukcamlica-korusu'),
  ('uskudar-ve-camlica', 7, 'buyuk-camlica-tepesi'),
  ('uskudar-ve-camlica', 8, 'camlica-camii'),
  ('adalar', 1, 'kinaliada'),
  ('adalar', 2, 'burgaz-adasi'),
  ('adalar', 3, 'heybeliada'),
  ('adalar', 4, 'buyukada'),
  ('adalar', 5, 'adalar-muzesi'),
  ('bebekten-emirgana', 1, 'bebek-parki'),
  ('bebekten-emirgana', 2, 'asiyan-muzesi'),
  ('bebekten-emirgana', 3, 'rumeli-hisari'),
  ('bebekten-emirgana', 4, 'sakip-sabanci-muzesi'),
  ('bebekten-emirgana', 5, 'emirgan-korusu'),
  ('kadikoy-sahili', 1, 'yogurtcu-parki'),
  ('kadikoy-sahili', 2, 'moda-sahili'),
  ('kadikoy-sahili', 3, 'fenerbahce-parki'),
  ('kadikoy-sahili', 4, 'goztepe-60-yil-parki'),
  ('bogaz-manzaralari', 1, 'pierre-loti-tepesi'),
  ('bogaz-manzaralari', 2, 'buyuk-camlica-tepesi'),
  ('bogaz-manzaralari', 3, 'otagtepe'),
  ('bogaz-manzaralari', 4, 'yoros-kalesi'),
  ('bogaz-manzaralari', 5, 'anadolu-kavagi-manzara-seyir-noktasi')
) v(slug, pos, place)
join public.routes r on r.slug = v.slug
join public.places p on p.slug = v.place;
