-- Kapadokya: proje sahibinin onayladığı yerler (2026-11-19).
-- Üreten: data-pipeline/content/build_city.py kapadokya — elle düzenleme; script'i yeniden çalıştır.
-- Yerler gizli eklenir (is_published = false); yayına alma ayrı bir migration ile yapılır.

-- Şehir --------------------------------------------------------------------------
insert into public.cities (slug, names, timezone)
values ('kapadokya', '{"tr": "Kapadokya", "en": "Cappadocia"}', 'Europe/Istanbul')
on conflict (slug) do nothing;

-- Yeni kategori(ler) ------------------------------------------------------------
insert into public.categories (slug, kind, icon, sort_order) values
  ('valley', 'nature', 'valley', 37),
  ('village', 'historical', 'village', 21)
on conflict (slug) do nothing;

insert into public.category_translations (category_id, lang, name)
select c.id, v.lang, v.name
from (values
  ('valley', 'tr', 'Vadi'), ('valley', 'en', 'Valley'),
  ('village', 'tr', 'Tarihi Köy'), ('village', 'en', 'Historic Village')
) v(slug, lang, name)
join public.categories c on c.slug = v.slug
on conflict (category_id, lang) do nothing;

-- Yerler --------------------------------------------------------------------------
-- Otomatik üretildi: data-pipeline/pipeline.py build (2026-11-20 14:48)
-- 63 yer; hepsi gizli (is_published = false); 63 tanesinin TR+EN kısa açıklaması dolu.
-- Tekrar çalıştırılabilir: aynı slug'lı yerler güncellenir, kopya oluşmaz.

insert into public.places
  (city_id, category_id, slug, location, area, checkin_radius_m, period, built_year, wikidata_id, osm_id)
select ci.id, c.id, v.slug,
       st_setsrid(st_makepoint(v.lng::float8, v.lat::float8), 4326)::geography,
       case when v.area_wkt is null then null else st_geogfromtext(v.area_wkt) end,
       v.radius::int, v.period, v.built_year::int, v.wikidata_id, v.osm_id
from (values
  ('karamanoglu-camii', 'mosque', 38.632585, 34.910199, 100, 'Beylikler', null, 'Q98091589', 'way/96870821', null),
  ('karsi-kilise', 'church', 38.740714, 34.634741, 100, 'Bizans', null, 'Q1297810', 'node/800022238', null),
  ('aziz-nikolas-manastiri', 'church', 38.577092, 34.895605, 50, 'Bizans', null, 'Q131523702', 'way/1463219578', null),
  ('kutsal-hac-kilisesi', 'church', 38.573171, 34.873014, 60, 'Bizans', null, null, 'node/11285946844', null),
  ('agacalti-kilisesi', 'church', 38.253225, 34.303657, 60, 'Bizans', null, 'Q6040759', 'node/2401466689', null),
  ('karanlik-kilise', 'church', 38.638704, 34.846265, 25, 'Bizans', null, 'Q114383869', 'node/316770600', null),
  ('kokar-kilise-aksaray', 'church', 38.253370, 34.307899, 60, 'Bizans', null, 'Q6038736', 'node/1007695845', null),
  ('yilanli-kilise-aksaray', 'church', 38.255427, 34.302572, 100, 'Bizans', null, 'Q6049420', 'node/707423018', null),
  ('aciksaray', 'church', 38.737984, 34.662412, 100, 'Bizans', null, 'Q289015', 'node/800022437', null),
  ('aziz-yuhanna-vaftizci-kilisesi-cavusin', 'church', 38.667544, 34.843172, 50, 'Bizans', null, 'Q56245348', 'node/7043126867', null),
  ('keslik-manastiri', 'church', 38.514395, 34.942363, 100, 'Bizans', null, 'Q56245523', 'node/284660795', null),
  ('tokali-kilise', 'church', 38.641100, 34.844674, 30, 'Bizans', null, 'Q115456380', 'node/316770601', null),
  ('selime-katedrali', 'church', 38.301198, 34.259433, 150, 'Bizans', null, 'Q5996572', null, null),
  ('sumbullu-kilise', 'church', 38.254164, 34.302972, 60, 'Bizans', null, 'Q6000139', 'node/1007680355', null),
  ('purenli-seki-kilisesi', 'church', 38.253707, 34.307129, 100, 'Bizans', null, 'Q6009237', 'node/1007671161', null),
  ('azize-barbara-kilisesi', 'church', 38.638732, 34.845129, 20, 'Bizans', null, 'Q73249333', 'node/316770594', null),
  ('azize-catherine-sapeli', 'church', 38.638761, 34.846032, 20, 'Bizans', null, 'Q115445879', 'node/4862240007', null),
  ('basil-sapeli', 'church', 38.639173, 34.845080, 20, 'Bizans', null, 'Q115456531', 'node/9253197332', null),
  ('elmali-kilise', 'church', 38.638719, 34.845005, 20, 'Bizans', null, 'Q115454836', 'node/316770597', null),
  ('pantokrator-kilisesi', 'church', 38.638248, 34.845373, 20, 'Bizans', null, 'Q115456669', 'node/13046162041', null),
  ('yilanli-kilise', 'church', 38.638305, 34.845264, 20, 'Bizans', null, 'Q115455275', 'node/316770599', null),
  ('carikli-kilise', 'church', 38.638837, 34.846264, 20, 'Bizans', null, 'Q115446076', 'node/316770595', null),
  ('haci-bektas-i-veli-turbesi', 'museum', 38.942825, 34.562843, 100, 'Osmanlı', null, 'Q20474091', 'way/168408687', null),
  ('goreme-deki-kiliseler-listesi', 'museum', 38.639277, 34.845632, 250, 'Bizans', null, 'Q15210336', 'way/26045752', null),
  ('nevsehir-muzesi', 'museum', 38.627900, 34.725167, 100, 'Cumhuriyet', null, 'Q28221127', 'way/233586090', null),
  ('guray-muze', 'museum', 38.709994, 34.834683, 100, 'Cumhuriyet', null, 'Q125797576', 'node/2905381216', null),
  ('zelve-acik-hava-muzesi', 'museum', 38.668128, 34.864790, 100, 'Bizans', null, null, 'node/87819399', null),
  ('nevsehir-kalesi', 'fortress', 38.619891, 34.713054, 150, 'Selçuklu', null, 'Q115801729', 'way/492643645', null),
  ('ortahisar-kalesi', 'fortress', 38.619809, 34.864431, 100, null, null, 'Q95640040', 'node/306877927', null),
  ('uchisar-kalesi', 'fortress', 38.630443, 34.805323, 120, null, null, 'Q112865630', 'node/306877923', null),
  ('cavusin-kalesi', 'fortress', 38.667765, 34.842511, 80, 'Bizans', null, null, 'way/253077394', null),
  ('sarihan-kervansarayi', 'monument', 38.711806, 34.909386, 60, 'Selçuklu', null, 'Q2225271', 'relation/7655709', null),
  ('bahattin-in-samanligi-kilise', 'monument', 38.265285, 34.289710, 60, 'Bizans', null, null, 'node/6703665400', null),
  ('derinkuyu-yeralti-sehri', 'archaeological_site', 38.373576, 34.735122, 80, 'Bizans', null, 'Q1328958', 'node/281777097', null),
  ('kaymakli', 'archaeological_site', 38.459927, 34.752488, 80, 'Bizans', null, 'Q1013468', 'node/27151654', null),
  ('ozkonak', 'archaeological_site', 38.806865, 34.840731, 80, 'Bizans', null, 'Q307912', 'node/1628116735', null),
  ('mazi-yeralti-sehri', 'archaeological_site', 38.469991, 34.838911, 80, 'Bizans', null, 'Q16889342', 'node/1143445897', null),
  ('sobesos-antik-kenti', 'archaeological_site', 38.464093, 34.966015, 150, 'Antik', null, 'Q124519571', 'node/144468459', null),
  ('mutfak-ve-kiler', 'archaeological_site', 38.638398, 34.846098, 20, 'Bizans', null, null, 'node/4862240005', null),
  ('altikapi-turbesi', 'tomb', 38.633178, 34.912546, 60, 'Selçuklu', null, null, 'way/133420556', null),
  ('mustafapasa', 'village', 38.584194, 34.896897, 500, 'Osmanlı', null, 'Q1377935', null, null),
  ('cavusin', 'village', 38.672778, 34.839444, 400, null, null, 'Q272689', null, null),
  ('guzelyurt', 'village', 38.277222, 34.371944, 500, 'Osmanlı', null, 'Q1004503', null, null),
  ('aktepe-hill-sunset-point', 'viewpoint', 38.653320, 34.863243, 50, null, null, null, 'node/249610411', null),
  ('temenni-tepe', 'viewpoint', 38.631264, 34.910514, 50, null, null, null, 'node/344940289', null),
  ('uc-guzeller', 'viewpoint', 38.635470, 34.890360, 50, null, null, null, 'node/417913277', null),
  ('ihlara-cam-teras', 'viewpoint', 38.245182, 34.313197, 50, null, null, null, 'node/13081298382', null),
  ('goreme-tarihi-milli-parki', 'forest', 38.650219, 34.852105, 500, null, null, 'Q620593', 'relation/252585', 'SRID=4326;POLYGON((34.782951 38.632194, 34.787584 38.625878, 34.807061 38.605618, 34.825039 38.602396, 34.838223 38.605511, 34.856306 38.606440, 34.862530 38.616301, 34.875729 38.622232, 34.877890 38.622317, 34.879275 38.622372, 34.879981 38.622571, 34.880655 38.621974, 34.882969 38.622756, 34.885689 38.623307, 34.893372 38.620433, 34.895537 38.620055, 34.896829 38.617734, 34.900504 38.616635, 34.903723 38.616534, 34.911046 38.615139, 34.912909 38.619224, 34.914884 38.620253, 34.919145 38.622171, 34.920885 38.625957, 34.921259 38.629133, 34.919666 38.629341, 34.919600 38.629349, 34.917987 38.633028, 34.913409 38.639328, 34.912267 38.641431, 34.913883 38.648055, 34.915530 38.651899, 34.914977 38.663829, 34.919591 38.673766, 34.917462 38.681888, 34.910448 38.682877, 34.893601 38.696358, 34.888059 38.697603, 34.873878 38.697152, 34.866250 38.693130, 34.862283 38.698041, 34.857472 38.697861, 34.823228 38.696576, 34.816658 38.691300, 34.813926 38.689515, 34.812075 38.686627, 34.812256 38.685130, 34.811780 38.683717, 34.809743 38.682901, 34.809579 38.681475, 34.808490 38.678383, 34.808863 38.673588, 34.809658 38.672100, 34.798862 38.658444, 34.796948 38.652856, 34.787037 38.641728, 34.788536 38.638374, 34.782951 38.632194))'),
  ('bagildere-vadisi', 'valley', 38.658938, 34.823656, 500, null, null, null, 'way/657829568', null),
  ('devrent-vadisi', 'valley', 38.672619, 34.885509, 400, null, null, null, 'node/297447938', null),
  ('gul-vadisi', 'valley', 38.655325, 34.846839, 600, null, null, null, 'way/493310623', null),
  ('guvercinlik-vadisi', 'valley', 38.639691, 34.822437, 400, null, null, null, 'node/5338426121', null),
  ('passabag-vadisi', 'valley', 38.677005, 34.854906, 250, null, null, null, 'node/9382198517', null),
  ('meskendir-valley-entrance', 'valley', 38.636738, 34.861173, 400, null, null, null, 'node/9395241384', null),
  ('ihlara-vadisi', 'valley', 38.240833, 34.306111, 1500, null, null, 'Q1366229', null, null),
  ('kizilcukur-vadisi', 'valley', 38.652844, 34.861366, 800, null, null, null, null, null),
  ('soganli-vadisi', 'valley', 38.349736, 34.961323, 900, null, null, 'Q25424230', null, null),
  ('soganli-karabas-kilisesi', 'church', 38.348221, 34.970274, 30, 'Bizans', null, null, 'node/5188164523', null),
  ('soganli-kubbeli-kilise', 'church', 38.348032, 34.968502, 25, 'Bizans', null, null, 'node/5188164524', null),
  ('soganli-sakli-kilise', 'church', 38.347703, 34.968801, 45, 'Bizans', null, null, 'node/5188151823', null),
  ('soganli-yilanli-kilise', 'church', 38.350922, 34.966764, 30, 'Bizans', null, null, 'node/3251854185', null),
  ('soganli-tahtali-kilise', 'church', 38.345721, 34.962775, 80, 'Bizans', null, null, null, null),
  ('soganli-geyikli-kilise', 'church', 38.344920, 34.965489, 45, 'Bizans', null, null, 'node/6734775385', null)
) v(slug, category, lat, lng, radius, period, built_year, wikidata_id, osm_id, area_wkt)
join public.cities ci on ci.slug = 'kapadokya'
join public.categories c on c.slug = v.category
on conflict (slug) do update set
  category_id = excluded.category_id,
  location = excluded.location,
  area = excluded.area,
  checkin_radius_m = excluded.checkin_radius_m,
  period = excluded.period,
  built_year = excluded.built_year,
  wikidata_id = excluded.wikidata_id,
  osm_id = excluded.osm_id;

insert into public.place_translations (place_id, lang, name, short_desc, best_time)
select p.id, v.lang, v.name, v.short_desc, v.best_time
from (values
  ('karamanoglu-camii', 'tr', 'Karamanoğlu Camii', 'Ürgüp''te, Karamanoğulları döneminden kalan tarihi cami.', null),
  ('karamanoglu-camii', 'en', 'Karamanoğlu Mosque', 'A historic mosque in Ürgüp dating from the Karamanid period.', null),
  ('karsi-kilise', 'tr', 'Karşı Kilise', 'Gülşehir''de, 13. yüzyıl fresklerini koruyan kaya oyma kilise.', null),
  ('karsi-kilise', 'en', 'St. Jean Church', 'A rock-cut church in Gülşehir preserving 13th-century frescoes.', null),
  ('aziz-nikolas-manastiri', 'tr', 'Aziz Nikolas Manastırı', 'Mustafapaşa''da, kayaya oyulmuş Aziz Nikolas Manastırı; bugün kültür merkezi olarak kullanılıyor.', null),
  ('aziz-nikolas-manastiri', 'en', 'Monastery of St Nicholas', 'The rock-cut Monastery of St Nicholas in Mustafapaşa, now used as a cultural centre.', null),
  ('kutsal-hac-kilisesi', 'tr', 'Kutsal Haç Kilisesi (Timios Stavros)', 'Mustafapaşa''nın 2 km güneybatısında, Üzengi Vadisi''nde 9. yüzyıldan kalma beş nefli kaya kilisesi.', null),
  ('kutsal-hac-kilisesi', 'en', 'Holy Cross Church (Timios Stavros)', 'A five-aisled 9th-century rock church in the Üzengi Valley, 2 km southwest of Mustafapaşa.', null),
  ('agacalti-kilisesi', 'tr', 'Ağaçaltı Kilisesi', 'Ihlara Vadisi''nde, haç planlı ve freskleriyle tanınan kaya kilisesi.', null),
  ('agacalti-kilisesi', 'en', 'Ağaçaltı Church', 'A cross-shaped rock church in the Ihlara Valley, known for its frescoes.', null),
  ('karanlik-kilise', 'tr', 'Karanlık Kilise', 'Göreme Açık Hava Müzesi''nde, az ışık aldığı için renkleri canlı kalmış fresklerle dolu kilise.', null),
  ('karanlik-kilise', 'en', 'Dark Church', 'A church in the Göreme Open-Air Museum whose frescoes stayed vivid because so little light gets in.', null),
  ('kokar-kilise-aksaray', 'tr', 'Kokar Kilise', 'Ihlara Vadisi''nde, İncil sahneleriyle süslü kaya kilisesi.', null),
  ('kokar-kilise-aksaray', 'en', 'Kokar Church', 'A rock church in the Ihlara Valley decorated with Gospel scenes.', null),
  ('yilanli-kilise-aksaray', 'tr', 'Yılanlı Kilise (Ihlara)', 'Ihlara Vadisi''nde, günahkârların yılanlarla cezalandırıldığı freskiyle bilinen kilise.', null),
  ('yilanli-kilise-aksaray', 'en', 'Snake Church (Ihlara)', 'A church in the Ihlara Valley known for its fresco of sinners punished by snakes.', null),
  ('aciksaray', 'tr', 'Açıksaray', 'Gülşehir''de, kayaya oyulmuş saray benzeri yapılar ve peribacalarından oluşan ören yeri.', null),
  ('aciksaray', 'en', 'Açıksaray', 'A site in Gülşehir of palace-like buildings carved into the rock among fairy chimneys.', null),
  ('aziz-yuhanna-vaftizci-kilisesi-cavusin', 'tr', 'Vaftizci Yahya Kilisesi', 'Çavuşin''de kayalığın tepesine oyulmuş, bölgenin en eski kiliselerinden Vaftizci Yahya Kilisesi.', null),
  ('aziz-yuhanna-vaftizci-kilisesi-cavusin', 'en', 'Church of St John the Baptist', 'The Church of St John the Baptist carved high in the cliff at Çavuşin, one of the oldest in the region.', null),
  ('keslik-manastiri', 'tr', 'Keşlik Manastırı', 'Cemil köyü yakınında, kayaya oyulmuş manastır ve kiliselerden oluşan yapı topluluğu.', null),
  ('keslik-manastiri', 'en', 'Keşlik Monastery', 'A complex of rock-cut monastery buildings and churches near the village of Cemil.', null),
  ('tokali-kilise', 'tr', 'Tokalı Kilise', 'Göreme Açık Hava Müzesi''nin girişinde, bölgenin en büyük ve en zengin freskli kilisesi.', null),
  ('tokali-kilise', 'en', 'Church of the Buckle', 'At the entrance of the Göreme Open-Air Museum, the largest church in the area with the richest frescoes.', null),
  ('selime-katedrali', 'tr', 'Selime Katedrali', 'Ihlara Vadisi''nin kuzey ucunda, kayaya oyulmuş büyük katedral ve manastır yapıları.', null),
  ('selime-katedrali', 'en', 'Selime Cathedral', 'A large cathedral and monastery complex carved into the rock at the northern end of the Ihlara Valley.', null),
  ('sumbullu-kilise', 'tr', 'Sümbüllü Kilise', 'Ihlara Vadisi''nde, cephesi süslü kaya kilisesi.', null),
  ('sumbullu-kilise', 'en', 'Jacinth Church', 'A rock church in the Ihlara Valley with a decorated façade.', null),
  ('purenli-seki-kilisesi', 'tr', 'Pürenli Seki Kilisesi', 'Ihlara Vadisi''nde, vadinin yamacındaki kaya kilisesi.', null),
  ('purenli-seki-kilisesi', 'en', 'Pürenli Seki Church', 'A rock church on the valley side in the Ihlara Valley.', null),
  ('azize-barbara-kilisesi', 'tr', 'Azize Barbara Kilisesi', 'Göreme Açık Hava Müzesi''nde, kırmızı aşı boyalı süslemeleriyle küçük kilise.', null),
  ('azize-barbara-kilisesi', 'en', 'St. Barbara’s Chapel', 'A small church in the Göreme Open-Air Museum decorated with red ochre patterns.', null),
  ('azize-catherine-sapeli', 'tr', 'Azize Catherine Şapeli', 'Göreme Açık Hava Müzesi''nde, Azize Catherine''e adanmış küçük şapel.', null),
  ('azize-catherine-sapeli', 'en', 'Saint Catherina Chapel', 'A small chapel in the Göreme Open-Air Museum dedicated to St Catherine.', null),
  ('basil-sapeli', 'tr', 'Basil Şapeli', 'Göreme Açık Hava Müzesi''nde, Aziz Basil''e adanmış şapel.', null),
  ('basil-sapeli', 'en', 'St. Basil’s Chapel', 'A chapel in the Göreme Open-Air Museum dedicated to St Basil.', null),
  ('elmali-kilise', 'tr', 'Elmalı Kilise', 'Göreme Açık Hava Müzesi''nde, kubbeli ve fresklerle kaplı Elmalı Kilise.', null),
  ('elmali-kilise', 'en', 'Apple Church', 'The domed Apple Church in the Göreme Open-Air Museum, covered in frescoes.', null),
  ('pantokrator-kilisesi', 'tr', 'Pantokrator Kilisesi', 'Göreme Açık Hava Müzesi''nde, Pantokrator İsa tasvirine adanmış kilise.', null),
  ('pantokrator-kilisesi', 'en', 'Pantocrator Church', 'A church in the Göreme Open-Air Museum dedicated to Christ Pantocrator.', null),
  ('yilanli-kilise', 'tr', 'Yılanlı Kilise (Göreme)', 'Göreme Açık Hava Müzesi''nde, Aziz Georgios''un ejderhayla savaştığı freskiyle bilinen kilise.', null),
  ('yilanli-kilise', 'en', 'Snake Church (Göreme)', 'A church in the Göreme Open-Air Museum known for its fresco of St George fighting the dragon.', null),
  ('carikli-kilise', 'tr', 'Çarıklı Kilise', 'Göreme Açık Hava Müzesi''nde, zemindeki ayak izi oyukları nedeniyle ''Çarıklı'' adını alan kilise.', null),
  ('carikli-kilise', 'en', 'Church with Sandals', 'A church in the Göreme Open-Air Museum named ''with Sandals'' after footprint-shaped hollows in its floor.', null),
  ('haci-bektas-i-veli-turbesi', 'tr', 'Hacı Bektaş Veli Külliyesi', 'Hacıbektaş''ta, Hacı Bektaş Veli''nin türbesinin bulunduğu dergâh; bugün müze.', null),
  ('haci-bektas-i-veli-turbesi', 'en', 'Haji Bektash Veli Complex', 'The lodge in Hacıbektaş containing the tomb of Haji Bektash Veli; now a museum.', null),
  ('goreme-deki-kiliseler-listesi', 'tr', 'Göreme Açık Hava Müzesi', 'Kayaya oyulmuş onlarca kilise ve şapelden oluşan, UNESCO listesindeki Göreme Açık Hava Müzesi.', null),
  ('goreme-deki-kiliseler-listesi', 'en', 'Göreme Open Air Museum', 'The Göreme Open-Air Museum, a UNESCO-listed group of dozens of rock-cut churches and chapels.', null),
  ('nevsehir-muzesi', 'tr', 'Nevşehir Müzesi', 'Nevşehir''de, Kapadokya''nın arkeolojisini ve kültürünü anlatan müze.', null),
  ('nevsehir-muzesi', 'en', 'Nevşehir Museum', 'A museum in Nevşehir covering the archaeology and culture of Cappadocia.', null),
  ('guray-muze', 'tr', 'Güray Müze', 'Avanos''ta, yeraltına oyulmuş galerilerde seramik sergileyen müze.', null),
  ('guray-muze', 'en', 'Güray Underground Ceramics Museum', 'A museum in Avanos displaying ceramics in galleries carved underground.', null),
  ('zelve-acik-hava-muzesi', 'tr', 'Zelve Açık Hava Müzesi', 'Zelve''de, terk edilmiş kaya köyü, kiliseleri ve peribacalarından oluşan açık hava müzesi.', null),
  ('zelve-acik-hava-muzesi', 'en', 'Zelve Open-Air Museum', 'An open-air museum at Zelve: an abandoned rock-cut village with churches and fairy chimneys.', null),
  ('nevsehir-kalesi', 'tr', 'Nevşehir Kalesi', 'Nevşehir''in tepesinde, Selçuklu dönemine uzanan kale.', null),
  ('nevsehir-kalesi', 'en', 'Nevşehir Castle', 'The castle on the hill above Nevşehir, with origins in the Seljuk period.', null),
  ('ortahisar-kalesi', 'tr', 'Ortahisar Kalesi', 'Ortahisar''da, içi oyulmuş dev bir kaya kütlesinden oluşan kale.', null),
  ('ortahisar-kalesi', 'en', 'Ortahisar Castle', 'The castle at Ortahisar: a huge rock mass hollowed out into rooms.', null),
  ('uchisar-kalesi', 'tr', 'Uçhisar Kalesi', 'Bölgenin en yüksek noktası; içi odalarla oyulmuş dev kaya kütlesi ve Göreme manzarası.', 'Gün batımı'),
  ('uchisar-kalesi', 'en', 'Uchisar Castle', 'The highest point in the area: a huge rock riddled with rooms, with views over Göreme.', 'Sunset'),
  ('cavusin-kalesi', 'tr', 'Çavuşin Kalesi', 'Çavuşin''de, kayaya oyulmuş evlerle dolu eski köy yamacı.', null),
  ('cavusin-kalesi', 'en', 'Çavuşin Castle', 'The old cliffside of Çavuşin, honeycombed with rock-cut houses.', null),
  ('sarihan-kervansarayi', 'tr', 'Sarıhan Kervansarayı', 'Avanos yakınında, 13. yüzyılda yapılan Selçuklu kervansarayı.', null),
  ('sarihan-kervansarayi', 'en', 'Sarıhan Caravanserai', 'A 13th-century Seljuk caravanserai near Avanos.', null),
  ('bahattin-in-samanligi-kilise', 'tr', 'Bahattin''in Samanlığı Kilisesi', 'Ihlara Vadisi''nde, köylülerin samanlık olarak kullandığı için bu adı alan kaya kilisesi.', null),
  ('bahattin-in-samanligi-kilise', 'en', 'Bahattin''s Granary Church', 'A rock church in the Ihlara Valley named after its later use as a hay store.', null),
  ('derinkuyu-yeralti-sehri', 'tr', 'Derinkuyu Yeraltı Şehri', 'Bölgenin en derin yeraltı şehri; taş kapıları ve havalandırma bacalarıyla çok katlı sığınak.', null),
  ('derinkuyu-yeralti-sehri', 'en', 'Derinkuyu Underground City', 'The deepest underground city in the region, a many-levelled refuge with rolling stone doors and air shafts.', null),
  ('kaymakli', 'tr', 'Kaymaklı Yeraltı Şehri', 'Kaymaklı''da, dar tünellerle bağlanan katları gezilebilen yeraltı şehri.', null),
  ('kaymakli', 'en', 'Kaymaklı Underground City', 'The underground city at Kaymaklı, with levels linked by narrow tunnels open to visitors.', null),
  ('ozkonak', 'tr', 'Özkonak Yeraltı Şehri', 'Avanos yakınında Özkonak''ta, yeraltı şehri ve sığınak.', null),
  ('ozkonak', 'en', 'Özkonak Underground City', 'The underground city and refuge at Özkonak near Avanos.', null),
  ('mazi-yeralti-sehri', 'tr', 'Mazı Yeraltı Şehri', 'Mazı köyünde, kayalığa açılan girişleriyle yeraltı şehri.', null),
  ('mazi-yeralti-sehri', 'en', 'Mazi Underground City', 'The underground city in the village of Mazı, entered through openings in the rock face.', null),
  ('sobesos-antik-kenti', 'tr', 'Sobesos Antik Kenti', 'Şahinefendi''de, mozaikli Roma hamamı ve şapeliyle antik Sobesos kenti.', null),
  ('sobesos-antik-kenti', 'en', 'Sobesos Ancient City', 'The ancient town of Sobesos at Şahinefendi, with a Roman bath and chapel with mosaics.', null),
  ('mutfak-ve-kiler', 'tr', 'Mutfak ve Kiler (Göreme)', 'Göreme Açık Hava Müzesi''nde, manastırın kayaya oyulmuş mutfak ve kiler bölümleri.', null),
  ('mutfak-ve-kiler', 'en', 'Kitchen and Storerooms (Göreme)', 'The rock-cut kitchen and storerooms of the monastery in the Göreme Open-Air Museum.', null),
  ('altikapi-turbesi', 'tr', 'Altıkapı Türbesi', 'Ürgüp''te, 13. yüzyıldan kalan Selçuklu türbesi.', null),
  ('altikapi-turbesi', 'en', 'Altıkapı Tomb', 'A 13th-century Seljuk tomb in Ürgüp.', null),
  ('mustafapasa', 'tr', 'Mustafapaşa (Sinasos)', 'Ürgüp''e bağlı, taş işçiliğiyle süslü Rum konaklarıyla tanınan eski Sinasos.', null),
  ('mustafapasa', 'en', 'Mustafapaşa (Sinasos)', 'Old Sinasos near Ürgüp, known for Greek mansions with carved stone façades.', null),
  ('cavusin', 'tr', 'Çavuşin', 'Göreme ile Avanos arasında, kayalığa oyulmuş eski köyü ve yeni yerleşimiyle Çavuşin.', null),
  ('cavusin', 'en', 'Çavuşin', 'Çavuşin, between Göreme and Avanos, with its old cliffside village and newer settlement.', null),
  ('guzelyurt', 'tr', 'Güzelyurt', 'Aksaray''da, Ihlara Vadisi yakınında, kaya kiliseleri ve taş evleriyle eski Rum kasabası.', null),
  ('guzelyurt', 'en', 'Güzelyurt', 'A former Greek town in Aksaray near the Ihlara Valley, with rock churches and stone houses.', null),
  ('aktepe-hill-sunset-point', 'tr', 'Aktepe Seyir Noktası', 'Zelve''nin güneyinde, Aktepe''nin üzerinde; Kızılçukur Vadisi''ne bakan gün batımı ve balon seyir noktası.', 'Gün doğumu (balonlar) ve gün batımı'),
  ('aktepe-hill-sunset-point', 'en', 'Aktepe Viewpoint', 'A sunset and balloon viewpoint on Aktepe hill, south of Zelve, overlooking the Red Valley (Kızılçukur).', 'Sunrise (balloons) and sunset'),
  ('temenni-tepe', 'tr', 'Temenni Tepe', 'Ürgüp''ün ortasında, kasabaya ve vadilere bakan tepe.', 'Gün batımı'),
  ('temenni-tepe', 'en', 'Temenni Hill', 'A hill in the middle of Ürgüp overlooking the town and valleys.', 'Sunset'),
  ('uc-guzeller', 'tr', 'Üç Güzeller', 'Ürgüp yakınında, şapkalı üç peribacasından oluşan Kapadokya''nın simgelerinden.', 'Gün batımı'),
  ('uc-guzeller', 'en', 'Üç Güzeller (Three Beauties)', 'Three capped fairy chimneys near Ürgüp, one of Cappadocia''s symbols.', 'Sunset'),
  ('ihlara-cam-teras', 'tr', 'Ihlara Cam Teras', 'Ihlara Vadisi''nin başında, kanyona bakan cam seyir terası.', null),
  ('ihlara-cam-teras', 'en', 'Ihlara Glass Terrace', 'A glass viewing terrace at the head of the Ihlara Valley, looking down into the canyon.', null),
  ('goreme-tarihi-milli-parki', 'tr', 'Göreme Tarihî Millî Parkı', 'Peribacaları, vadiler ve kaya yerleşimlerini koruyan, UNESCO listesindeki milli park.', 'İlkbahar ve sonbahar'),
  ('goreme-tarihi-milli-parki', 'en', 'Göreme Historical National Park', 'The UNESCO-listed national park protecting fairy chimneys, valleys and rock-cut settlements.', 'Spring and autumn'),
  ('bagildere-vadisi', 'tr', 'Bağıldere Vadisi', 'Uzun ve ince peribacalarıyla tanınan, Aşk Vadisi olarak da bilinen vadi.', 'Sabah (balonlar)'),
  ('bagildere-vadisi', 'en', 'Love Valley', 'The valley known for its tall, slender fairy chimneys, also called Love Valley.', 'Morning (balloons)'),
  ('devrent-vadisi', 'tr', 'Devrent Vadisi', 'Kayaların hayvan biçimlerine benzediği, Hayal Vadisi olarak da bilinen vadi; ünlü ''deve'' kayası burada.', null),
  ('devrent-vadisi', 'en', 'Devrent Valley', 'The Valley of Imagination, where rocks resemble animals; home to the famous ''camel'' rock.', null),
  ('gul-vadisi', 'tr', 'Gül Vadisi', 'Göreme ile Çavuşin arasında, gün batımında pembeleşen kayalarıyla bilinen yürüyüş vadisi.', 'Gün batımı'),
  ('gul-vadisi', 'en', 'Rose Valley', 'A hiking valley between Göreme and Çavuşin, known for its rocks that turn pink at sunset.', 'Sunset'),
  ('guvercinlik-vadisi', 'tr', 'Güvercinlik Vadisi', 'Göreme ile Uçhisar arasında, kayalara oyulmuş güvercinlikleriyle tanınan vadi.', null),
  ('guvercinlik-vadisi', 'en', 'Pigeon Valley', 'A valley between Göreme and Uçhisar known for its pigeon houses carved into the rock.', null),
  ('passabag-vadisi', 'tr', 'Paşabağları', 'Çok başlı peribacaları ve keşiş hücreleriyle tanınan Paşabağları.', null),
  ('passabag-vadisi', 'en', 'Paşabağ (Monks Valley)', 'Paşabağ, known for its multi-capped fairy chimneys and hermits'' cells.', null),
  ('meskendir-valley-entrance', 'tr', 'Meskendir Vadisi', 'Göreme yakınında, peribacaları arasında yürüyüş yolu olan vadi.', null),
  ('meskendir-valley-entrance', 'en', 'Meskendir Valley', 'A valley near Göreme with a hiking path among the fairy chimneys.', null),
  ('ihlara-vadisi', 'tr', 'Ihlara Vadisi', 'Melendiz Çayı''nın oyduğu, yamaçlarında kaya kiliseleri bulunan 14 km''lik kanyon.', 'İlkbahar ve sonbahar'),
  ('ihlara-vadisi', 'en', 'Ihlara Valley', 'A 14 km canyon carved by the Melendiz stream, with rock churches in its walls.', 'Spring and autumn'),
  ('kizilcukur-vadisi', 'tr', 'Kızılçukur Vadisi', 'Ortahisar yakınında, kırmızı tonlu kayaları ve gün batımı manzarasıyla Kızılçukur.', 'Gün batımı'),
  ('kizilcukur-vadisi', 'en', 'Red Valley', 'The Red Valley near Ortahisar, with reddish rocks and sunset views.', 'Sunset'),
  ('soganli-vadisi', 'tr', 'Soğanlı Vadisi', 'Kayseri''de, kayaya oyulmuş kiliseleri ve sakin köyüyle Soğanlı Vadisi.', null),
  ('soganli-vadisi', 'en', 'Soğanlı Valley', 'The Soğanlı Valley in Kayseri, with rock-cut churches and a quiet village.', null),
  ('soganli-karabas-kilisesi', 'tr', 'Karabaş Kilisesi', 'Soğanlı''da, 11. yüzyıl freskleriyle bölgenin en zengin süslü kiliselerinden.', null),
  ('soganli-karabas-kilisesi', 'en', 'Karabaş Church', 'A church in Soğanlı with 11th-century frescoes, one of the most richly painted in the area.', null),
  ('soganli-kubbeli-kilise', 'tr', 'Kubbeli Kilise', 'Soğanlı''da, bir peribacasının tepesine kubbe biçiminde oyulmuş, benzeri olmayan kilise.', null),
  ('soganli-kubbeli-kilise', 'en', 'Domed Church', 'A unique church in Soğanlı, its dome carved into the top of a fairy chimney.', null),
  ('soganli-sakli-kilise', 'tr', 'Saklı Kilise', 'Soğanlı''da, yamacın içine gizlendiği için uzaktan görülmeyen kaya kilisesi.', null),
  ('soganli-sakli-kilise', 'en', 'Hidden Church', 'A rock church in Soğanlı hidden in the slope, so it cannot be seen from afar.', null),
  ('soganli-yilanli-kilise', 'tr', 'Yılanlı Kilise (Soğanlı)', 'Soğanlı''da, Aziz Georgios''un ejderhayla savaştığı freskiyle bilinen kaya kilisesi.', null),
  ('soganli-yilanli-kilise', 'en', 'Church of the Snakes (Soğanlı)', 'A rock church in Soğanlı known for its fresco of St George fighting the dragon.', null),
  ('soganli-tahtali-kilise', 'tr', 'Tahtalı Kilise', 'Soğanlı''da, Azize Barbara''ya adanmış, freskli kaya kilisesi.', null),
  ('soganli-tahtali-kilise', 'en', 'Tahtalı Church', 'A rock church in Soğanlı dedicated to St Barbara, decorated with frescoes.', null),
  ('soganli-geyikli-kilise', 'tr', 'Geyikli Kilise', 'Soğanlı''da, adını geyikli bir aziz freskinden alan kaya kilisesi.', null),
  ('soganli-geyikli-kilise', 'en', 'Church of the Deer', 'A rock church in Soğanlı named after a fresco of a saint with a deer.', null)
) v(slug, lang, name, short_desc, best_time)
join public.places p on p.slug = v.slug
on conflict (place_id, lang) do update set
  name = excluded.name,
  short_desc = coalesce(excluded.short_desc, public.place_translations.short_desc),
  best_time = coalesce(excluded.best_time, public.place_translations.best_time);


-- Ana yer bağları (ör. Efes ve içindeki yapılar) -----------------------------------
update public.places c
set parent_place_id = pp.id
from (values
  ('agacalti-kilisesi', 'ihlara-vadisi'),
  ('aziz-nikolas-manastiri', 'mustafapasa'),
  ('aziz-yuhanna-vaftizci-kilisesi-cavusin', 'cavusin'),
  ('azize-barbara-kilisesi', 'goreme-deki-kiliseler-listesi'),
  ('azize-catherine-sapeli', 'goreme-deki-kiliseler-listesi'),
  ('bahattin-in-samanligi-kilise', 'ihlara-vadisi'),
  ('basil-sapeli', 'goreme-deki-kiliseler-listesi'),
  ('carikli-kilise', 'goreme-deki-kiliseler-listesi'),
  ('cavusin-kalesi', 'cavusin'),
  ('elmali-kilise', 'goreme-deki-kiliseler-listesi'),
  ('ihlara-cam-teras', 'ihlara-vadisi'),
  ('karanlik-kilise', 'goreme-deki-kiliseler-listesi'),
  ('kokar-kilise-aksaray', 'ihlara-vadisi'),
  ('kutsal-hac-kilisesi', 'mustafapasa'),
  ('mutfak-ve-kiler', 'goreme-deki-kiliseler-listesi'),
  ('pantokrator-kilisesi', 'goreme-deki-kiliseler-listesi'),
  ('purenli-seki-kilisesi', 'ihlara-vadisi'),
  ('selime-katedrali', 'ihlara-vadisi'),
  ('soganli-geyikli-kilise', 'soganli-vadisi'),
  ('soganli-karabas-kilisesi', 'soganli-vadisi'),
  ('soganli-kubbeli-kilise', 'soganli-vadisi'),
  ('soganli-sakli-kilise', 'soganli-vadisi'),
  ('soganli-tahtali-kilise', 'soganli-vadisi'),
  ('soganli-yilanli-kilise', 'soganli-vadisi'),
  ('sumbullu-kilise', 'ihlara-vadisi'),
  ('tokali-kilise', 'goreme-deki-kiliseler-listesi'),
  ('yilanli-kilise', 'goreme-deki-kiliseler-listesi'),
  ('yilanli-kilise-aksaray', 'ihlara-vadisi')
) v(child, parent)
join public.places pp on pp.slug = v.parent
where c.slug = v.child;

-- Keşif rozetleri: ana yer ve içindeki yerlerin hepsi --------------------------------
insert into public.achievements (slug, rule, sort_order) values
  ('cavusin-kesif', '{"type": "place_set", "places": ["cavusin", "aziz-yuhanna-vaftizci-kilisesi-cavusin", "cavusin-kalesi"]}'::jsonb, 100),
  ('goreme-deki-kiliseler-listesi-kesif', '{"type": "place_set", "places": ["goreme-deki-kiliseler-listesi", "azize-barbara-kilisesi", "azize-catherine-sapeli", "basil-sapeli", "carikli-kilise", "elmali-kilise", "karanlik-kilise", "mutfak-ve-kiler", "pantokrator-kilisesi", "tokali-kilise", "yilanli-kilise"]}'::jsonb, 101),
  ('ihlara-vadisi-kesif', '{"type": "place_set", "places": ["ihlara-vadisi", "agacalti-kilisesi", "bahattin-in-samanligi-kilise", "ihlara-cam-teras", "kokar-kilise-aksaray", "purenli-seki-kilisesi", "selime-katedrali", "sumbullu-kilise", "yilanli-kilise-aksaray"]}'::jsonb, 102),
  ('mustafapasa-kesif', '{"type": "place_set", "places": ["mustafapasa", "aziz-nikolas-manastiri", "kutsal-hac-kilisesi"]}'::jsonb, 103),
  ('soganli-vadisi-kesif', '{"type": "place_set", "places": ["soganli-vadisi", "soganli-geyikli-kilise", "soganli-karabas-kilisesi", "soganli-kubbeli-kilise", "soganli-sakli-kilise", "soganli-tahtali-kilise", "soganli-yilanli-kilise"]}'::jsonb, 104)
on conflict (slug) do update set rule = excluded.rule;

insert into public.achievement_translations (achievement_id, lang, name, description)
select a.id, v.lang, v.name, v.description
from (values
  ('cavusin-kesif', 'tr', 'Çavuşin Kâşifi', 'Çavuşin ve içindeki 2 yerin hepsini gez.'),
  ('cavusin-kesif', 'en', 'Çavuşin Explorer', 'Visit Çavuşin and all 2 places inside it.'),
  ('goreme-deki-kiliseler-listesi-kesif', 'tr', 'Göreme Açık Hava Müzesi Kâşifi', 'Göreme Açık Hava Müzesi ve içindeki 10 yerin hepsini gez.'),
  ('goreme-deki-kiliseler-listesi-kesif', 'en', 'Göreme Open Air Museum Explorer', 'Visit Göreme Open Air Museum and all 10 places inside it.'),
  ('ihlara-vadisi-kesif', 'tr', 'Ihlara Vadisi Kâşifi', 'Ihlara Vadisi ve içindeki 8 yerin hepsini gez.'),
  ('ihlara-vadisi-kesif', 'en', 'Ihlara Valley Explorer', 'Visit Ihlara Valley and all 8 places inside it.'),
  ('mustafapasa-kesif', 'tr', 'Mustafapaşa (Sinasos) Kâşifi', 'Mustafapaşa (Sinasos) ve içindeki 2 yerin hepsini gez.'),
  ('mustafapasa-kesif', 'en', 'Mustafapaşa (Sinasos) Explorer', 'Visit Mustafapaşa (Sinasos) and all 2 places inside it.'),
  ('soganli-vadisi-kesif', 'tr', 'Soğanlı Vadisi Kâşifi', 'Soğanlı Vadisi ve içindeki 6 yerin hepsini gez.'),
  ('soganli-vadisi-kesif', 'en', 'Soğanlı Valley Explorer', 'Visit Soğanlı Valley and all 6 places inside it.')
) v(slug, lang, name, description)
join public.achievements a on a.slug = v.slug
on conflict (achievement_id, lang) do update set name = excluded.name, description = excluded.description;

-- Kapadokya fotoğrafları: Wikimedia Commons, serbest lisanslı (57 yer).
-- Üreten: data-pipeline/content/build_city.py (kaynak: data-pipeline/results/kapadokya/photos.json).
-- Mobil, fotoğrafın altında author ve license bilgisini göstermelidir (lisans koşulu).

delete from public.place_photos ph
using public.places p
where ph.place_id = p.id
  and ph.url like 'https://%.wikimedia.org/%'
  and p.slug in ('aciksaray', 'agacalti-kilisesi', 'aktepe-hill-sunset-point', 'altikapi-turbesi', 'aziz-nikolas-manastiri', 'aziz-yuhanna-vaftizci-kilisesi-cavusin', 'azize-barbara-kilisesi', 'azize-catherine-sapeli', 'bagildere-vadisi', 'basil-sapeli', 'carikli-kilise', 'cavusin', 'cavusin-kalesi', 'derinkuyu-yeralti-sehri', 'devrent-vadisi', 'elmali-kilise', 'goreme-deki-kiliseler-listesi', 'goreme-tarihi-milli-parki', 'gul-vadisi', 'guvercinlik-vadisi', 'guzelyurt', 'haci-bektas-i-veli-turbesi', 'ihlara-vadisi', 'karamanoglu-camii', 'karanlik-kilise', 'karsi-kilise', 'kaymakli', 'keslik-manastiri', 'kizilcukur-vadisi', 'kokar-kilise-aksaray', 'meskendir-valley-entrance', 'mustafapasa', 'mutfak-ve-kiler', 'nevsehir-kalesi', 'nevsehir-muzesi', 'ortahisar-kalesi', 'ozkonak', 'pantokrator-kilisesi', 'passabag-vadisi', 'purenli-seki-kilisesi', 'sarihan-kervansarayi', 'selime-katedrali', 'sobesos-antik-kenti', 'soganli-karabas-kilisesi', 'soganli-kubbeli-kilise', 'soganli-sakli-kilise', 'soganli-tahtali-kilise', 'soganli-vadisi', 'soganli-yilanli-kilise', 'sumbullu-kilise', 'temenni-tepe', 'tokali-kilise', 'uc-guzeller', 'uchisar-kalesi', 'yilanli-kilise', 'yilanli-kilise-aksaray', 'zelve-acik-hava-muzesi');

insert into public.place_photos
  (place_id, url, thumb_url, width, height, license, license_url, author, source_url, sort_order)
select p.id, v.url, v.thumb_url, v.width::int, v.height::int, v.license, v.license_url, v.author, v.source_url, 0
from (values
  ('aciksaray', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/7/7b/AciksarayFassade.jpg/1280px-AciksarayFassade.jpg', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/7/7b/AciksarayFassade.jpg/500px-AciksarayFassade.jpg', 1280, 1707, 'CC BY 3.0', 'https://creativecommons.org/licenses/by/3.0', 'Klaus-Peter Simon', 'https://commons.wikimedia.org/wiki/File:AciksarayFassade.jpg'),
  ('agacalti-kilisesi', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/9/9f/St._Daniel%27s_Church_plafond.JPG/1280px-St._Daniel%27s_Church_plafond.JPG', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/9/9f/St._Daniel%27s_Church_plafond.JPG/500px-St._Daniel%27s_Church_plafond.JPG', 1280, 1362, 'CC BY-SA 3.0', 'https://creativecommons.org/licenses/by-sa/3.0', 'GMM', 'https://commons.wikimedia.org/wiki/File:St._Daniel%27s_Church_plafond.JPG'),
  ('aktepe-hill-sunset-point', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/9/95/CAPPADOCIA_G%C3%B6reme_National_Park_and_the_Rock_Sites._World_Heritage_List._Turkey._Hot_Air_Ballooning_Cappadocia.jpg/1280px-CAPPADOCIA_G%C3%B6reme_National_Park_and_the_Rock_Sites._World_Heritage_List._Turkey._Hot_Air_Ballooning_Cappadocia.jpg', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/9/95/CAPPADOCIA_G%C3%B6reme_National_Park_and_the_Rock_Sites._World_Heritage_List._Turkey._Hot_Air_Ballooning_Cappadocia.jpg/500px-CAPPADOCIA_G%C3%B6reme_National_Park_and_the_Rock_Sites._World_Heritage_List._Turkey._Hot_Air_Ballooning_Cappadocia.jpg', 1280, 720, 'CC0', 'http://creativecommons.org/publicdomain/zero/1.0/deed.en', 'Feridun F. Alkaya', 'https://commons.wikimedia.org/wiki/File:CAPPADOCIA_G%C3%B6reme_National_Park_and_the_Rock_Sites._World_Heritage_List._Turkey._Hot_Air_Ballooning_Cappadocia.jpg'),
  ('altikapi-turbesi', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/7/7b/%C3%9Crg%C3%BCp_six_gates_tomb_4460.jpg/1280px-%C3%9Crg%C3%BCp_six_gates_tomb_4460.jpg', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/7/7b/%C3%9Crg%C3%BCp_six_gates_tomb_4460.jpg/500px-%C3%9Crg%C3%BCp_six_gates_tomb_4460.jpg', 1280, 960, 'CC BY-SA 4.0', 'https://creativecommons.org/licenses/by-sa/4.0', 'Dosseman', 'https://commons.wikimedia.org/wiki/File:%C3%9Crg%C3%BCp_six_gates_tomb_4460.jpg'),
  ('aziz-nikolas-manastiri', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/6/69/St._Nicholas_monastery_and_churches_courtyard%2C_Mustafapa%C5%9Fa_in_2017_3595.jpg/1280px-St._Nicholas_monastery_and_churches_courtyard%2C_Mustafapa%C5%9Fa_in_2017_3595.jpg', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/6/69/St._Nicholas_monastery_and_churches_courtyard%2C_Mustafapa%C5%9Fa_in_2017_3595.jpg/500px-St._Nicholas_monastery_and_churches_courtyard%2C_Mustafapa%C5%9Fa_in_2017_3595.jpg', 1280, 853, 'CC BY-SA 4.0', 'https://creativecommons.org/licenses/by-sa/4.0', 'Dosseman', 'https://commons.wikimedia.org/wiki/File:St._Nicholas_monastery_and_churches_courtyard,_Mustafapa%C5%9Fa_in_2017_3595.jpg'),
  ('aziz-yuhanna-vaftizci-kilisesi-cavusin', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/4/4f/%C3%87avu%C5%9Fin-Eglise_Saint-Jean-Baptiste_%281%29.jpg/1280px-%C3%87avu%C5%9Fin-Eglise_Saint-Jean-Baptiste_%281%29.jpg', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/4/4f/%C3%87avu%C5%9Fin-Eglise_Saint-Jean-Baptiste_%281%29.jpg/500px-%C3%87avu%C5%9Fin-Eglise_Saint-Jean-Baptiste_%281%29.jpg', 1280, 960, 'CC BY-SA 3.0', 'https://creativecommons.org/licenses/by-sa/3.0', 'Ji-Elle', 'https://commons.wikimedia.org/wiki/File:%C3%87avu%C5%9Fin-Eglise_Saint-Jean-Baptiste_(1).jpg'),
  ('azize-barbara-kilisesi', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/6/67/Cappadocia_G%C3%B6reme_Barbara-Chapel_20241003_142924.jpg/1280px-Cappadocia_G%C3%B6reme_Barbara-Chapel_20241003_142924.jpg', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/6/67/Cappadocia_G%C3%B6reme_Barbara-Chapel_20241003_142924.jpg/500px-Cappadocia_G%C3%B6reme_Barbara-Chapel_20241003_142924.jpg', 1280, 721, 'CC BY-SA 4.0', 'https://creativecommons.org/licenses/by-sa/4.0', 'Rigorius', 'https://commons.wikimedia.org/wiki/File:Cappadocia_G%C3%B6reme_Barbara-Chapel_20241003_142924.jpg'),
  ('azize-catherine-sapeli', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/0/0d/J22_230_Agia_Katharina.jpg/1280px-J22_230_Agia_Katharina.jpg', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/0/0d/J22_230_Agia_Katharina.jpg/500px-J22_230_Agia_Katharina.jpg', 1280, 1920, 'CC BY-SA 4.0', 'https://creativecommons.org/licenses/by-sa/4.0', 'Falk2', 'https://commons.wikimedia.org/wiki/File:J22_230_Agia_Katharina.jpg'),
  ('bagildere-vadisi', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/a/ae/Aerial_view_of_Love_valley_Cappadocia_from_hot_air_balloon_1510259_60_61_Compressor_Nevit.jpg/1280px-Aerial_view_of_Love_valley_Cappadocia_from_hot_air_balloon_1510259_60_61_Compressor_Nevit.jpg', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/a/ae/Aerial_view_of_Love_valley_Cappadocia_from_hot_air_balloon_1510259_60_61_Compressor_Nevit.jpg/500px-Aerial_view_of_Love_valley_Cappadocia_from_hot_air_balloon_1510259_60_61_Compressor_Nevit.jpg', 1280, 960, 'CC BY-SA 3.0', 'https://creativecommons.org/licenses/by-sa/3.0', 'Nevit Dilmen', 'https://commons.wikimedia.org/wiki/File:Aerial_view_of_Love_valley_Cappadocia_from_hot_air_balloon_1510259_60_61_Compressor_Nevit.jpg'),
  ('basil-sapeli', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/5/58/G%C3%B6reme-Aziz_Basil_Sapeli_%281%29.jpg/1280px-G%C3%B6reme-Aziz_Basil_Sapeli_%281%29.jpg', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/5/58/G%C3%B6reme-Aziz_Basil_Sapeli_%281%29.jpg/500px-G%C3%B6reme-Aziz_Basil_Sapeli_%281%29.jpg', 1280, 1702, 'CC BY-SA 3.0', 'https://creativecommons.org/licenses/by-sa/3.0', 'Ji-Elle', 'https://commons.wikimedia.org/wiki/File:G%C3%B6reme-Aziz_Basil_Sapeli_(1).jpg'),
  ('carikli-kilise', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/2/2b/Frescos_in_%C3%87ar%C4%B1kl%C4%B1_Kilise_07.jpg/1280px-Frescos_in_%C3%87ar%C4%B1kl%C4%B1_Kilise_07.jpg', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/2/2b/Frescos_in_%C3%87ar%C4%B1kl%C4%B1_Kilise_07.jpg/500px-Frescos_in_%C3%87ar%C4%B1kl%C4%B1_Kilise_07.jpg', 1280, 960, 'CC BY-SA 4.0', 'https://creativecommons.org/licenses/by-sa/4.0', 'Codas', 'https://commons.wikimedia.org/wiki/File:Frescos_in_%C3%87ar%C4%B1kl%C4%B1_Kilise_07.jpg'),
  ('cavusin', 'https://upload.wikimedia.org/wikipedia/commons/3/34/Cavusin.JPG', 'https://upload.wikimedia.org/wikipedia/commons/3/34/Cavusin.JPG', 1280, 885, 'CC BY-SA 3.0', 'https://creativecommons.org/licenses/by-sa/3.0', 'Elelicht', 'https://commons.wikimedia.org/wiki/File:Cavusin.JPG'),
  ('cavusin-kalesi', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/7/74/Views_of_%C3%87avu%C5%9Fin.jpg/1280px-Views_of_%C3%87avu%C5%9Fin.jpg', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/7/74/Views_of_%C3%87avu%C5%9Fin.jpg/500px-Views_of_%C3%87avu%C5%9Fin.jpg', 1280, 960, 'CC BY-SA 4.0', 'https://creativecommons.org/licenses/by-sa/4.0', 'Codas', 'https://commons.wikimedia.org/wiki/File:Views_of_%C3%87avu%C5%9Fin.jpg'),
  ('derinkuyu-yeralti-sehri', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/6/6c/Derinkuyu_Underground_City_9831_Nevit_Enhancer.jpg/1280px-Derinkuyu_Underground_City_9831_Nevit_Enhancer.jpg', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/6/6c/Derinkuyu_Underground_City_9831_Nevit_Enhancer.jpg/500px-Derinkuyu_Underground_City_9831_Nevit_Enhancer.jpg', 1280, 960, 'CC BY-SA 3.0', 'https://creativecommons.org/licenses/by-sa/3.0', 'Nevit Dilmen', 'https://commons.wikimedia.org/wiki/File:Derinkuyu_Underground_City_9831_Nevit_Enhancer.jpg'),
  ('devrent-vadisi', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/d/d3/Camel_rock%2CDevrent%2C%E3%83%87%E3%83%B4%E3%83%AC%E3%83%B3%E3%83%88%E3%81%AE%E3%83%A9%E3%82%AF%E3%83%80%E5%B2%A9_-_panoramio.jpg/1280px-Camel_rock%2CDevrent%2C%E3%83%87%E3%83%B4%E3%83%AC%E3%83%B3%E3%83%88%E3%81%AE%E3%83%A9%E3%82%AF%E3%83%80%E5%B2%A9_-_panoramio.jpg', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/d/d3/Camel_rock%2CDevrent%2C%E3%83%87%E3%83%B4%E3%83%AC%E3%83%B3%E3%83%88%E3%81%AE%E3%83%A9%E3%82%AF%E3%83%80%E5%B2%A9_-_panoramio.jpg/500px-Camel_rock%2CDevrent%2C%E3%83%87%E3%83%B4%E3%83%AC%E3%83%B3%E3%83%88%E3%81%AE%E3%83%A9%E3%82%AF%E3%83%80%E5%B2%A9_-_panoramio.jpg', 1280, 832, 'CC BY-SA 3.0', 'https://creativecommons.org/licenses/by-sa/3.0', 'ykeiko', 'https://commons.wikimedia.org/wiki/File:Camel_rock,Devrent,%E3%83%87%E3%83%B4%E3%83%AC%E3%83%B3%E3%83%88%E3%81%AE%E3%83%A9%E3%82%AF%E3%83%80%E5%B2%A9_-_panoramio.jpg'),
  ('elmali-kilise', 'https://upload.wikimedia.org/wikipedia/commons/5/56/Elmali_-_Fresco_Mittelschiff.jpg', 'https://upload.wikimedia.org/wikipedia/commons/5/56/Elmali_-_Fresco_Mittelschiff.jpg', 1280, 1707, 'CC BY-SA 3.0', 'https://creativecommons.org/licenses/by-sa/3.0', 'Wolfgang Sauber', 'https://commons.wikimedia.org/wiki/File:Elmali_-_Fresco_Mittelschiff.jpg'),
  ('goreme-deki-kiliseler-listesi', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/e/e5/G%C3%B6reme_Valley_in_Cappadocia_edit1.jpg/1280px-G%C3%B6reme_Valley_in_Cappadocia_edit1.jpg', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/e/e5/G%C3%B6reme_Valley_in_Cappadocia_edit1.jpg/500px-G%C3%B6reme_Valley_in_Cappadocia_edit1.jpg', 1280, 798, 'CC BY-SA 3.0', 'https://creativecommons.org/licenses/by-sa/3.0', 'Brocken Inaglory', 'https://commons.wikimedia.org/wiki/File:G%C3%B6reme_Valley_in_Cappadocia_edit1.jpg'),
  ('goreme-tarihi-milli-parki', 'https://upload.wikimedia.org/wikipedia/commons/d/d3/Goreme_valley.jpg', 'https://upload.wikimedia.org/wikipedia/commons/d/d3/Goreme_valley.jpg', 1280, 867, 'CC BY-SA 3.0', 'http://creativecommons.org/licenses/by-sa/3.0/', 'Bilinmiyor / Unknown', 'https://commons.wikimedia.org/wiki/File:Goreme_valley.jpg'),
  ('gul-vadisi', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/9/9d/Mouth_of_Rose_Valley_-_2014.10_-_panoramio.jpg/1280px-Mouth_of_Rose_Valley_-_2014.10_-_panoramio.jpg', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/9/9d/Mouth_of_Rose_Valley_-_2014.10_-_panoramio.jpg/500px-Mouth_of_Rose_Valley_-_2014.10_-_panoramio.jpg', 1280, 853, 'CC BY 3.0', 'https://creativecommons.org/licenses/by/3.0', 'rheins', 'https://commons.wikimedia.org/wiki/File:Mouth_of_Rose_Valley_-_2014.10_-_panoramio.jpg'),
  ('guvercinlik-vadisi', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/4/42/Turkey.U%C3%A7hisar02.jpg/1280px-Turkey.U%C3%A7hisar02.jpg', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/4/42/Turkey.U%C3%A7hisar02.jpg/500px-Turkey.U%C3%A7hisar02.jpg', 1280, 960, 'CC BY 3.0', 'https://creativecommons.org/licenses/by/3.0', 'Georges Jansoone JoJan', 'https://commons.wikimedia.org/wiki/File:Turkey.U%C3%A7hisar02.jpg'),
  ('guzelyurt', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/f/f2/Lived_on_and_the_living.jpg/1280px-Lived_on_and_the_living.jpg', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/f/f2/Lived_on_and_the_living.jpg/500px-Lived_on_and_the_living.jpg', 1280, 960, 'CC BY-SA 4.0', 'https://creativecommons.org/licenses/by-sa/4.0', 'Nurbanu Karaman', 'https://commons.wikimedia.org/wiki/File:Lived_on_and_the_living.jpg'),
  ('haci-bektas-i-veli-turbesi', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/8/89/Hacibektas-01-mihalorel.jpg/1280px-Hacibektas-01-mihalorel.jpg', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/8/89/Hacibektas-01-mihalorel.jpg/500px-Hacibektas-01-mihalorel.jpg', 1280, 960, 'CC BY 2.0', 'https://creativecommons.org/licenses/by/2.0', 'Михал Орела', 'https://commons.wikimedia.org/wiki/File:Hacibektas-01-mihalorel.jpg'),
  ('ihlara-vadisi', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/7/77/Ihlara_-_25936870521.jpg/1280px-Ihlara_-_25936870521.jpg', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/7/77/Ihlara_-_25936870521.jpg/500px-Ihlara_-_25936870521.jpg', 1280, 853, 'CC BY 2.0', 'https://creativecommons.org/licenses/by/2.0', 'prilfish', 'https://commons.wikimedia.org/wiki/File:Ihlara_-_25936870521.jpg'),
  ('karamanoglu-camii', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/6/61/%C3%9Crg%C3%BCp_Merkez_Karamanoglu_C._Kebir_I._Bey_Camii_0781.jpg/1280px-%C3%9Crg%C3%BCp_Merkez_Karamanoglu_C._Kebir_I._Bey_Camii_0781.jpg', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/6/61/%C3%9Crg%C3%BCp_Merkez_Karamanoglu_C._Kebir_I._Bey_Camii_0781.jpg/500px-%C3%9Crg%C3%BCp_Merkez_Karamanoglu_C._Kebir_I._Bey_Camii_0781.jpg', 1280, 853, 'CC BY-SA 4.0', 'https://creativecommons.org/licenses/by-sa/4.0', 'Dosseman', 'https://commons.wikimedia.org/wiki/File:%C3%9Crg%C3%BCp_Merkez_Karamanoglu_C._Kebir_I._Bey_Camii_0781.jpg'),
  ('karanlik-kilise', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/8/8e/Dark_Church_%28Karanl%C4%B1k_Kilise%29_in_Cappadocia%2C_G%C3%B6reme.jpg/1280px-Dark_Church_%28Karanl%C4%B1k_Kilise%29_in_Cappadocia%2C_G%C3%B6reme.jpg', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/8/8e/Dark_Church_%28Karanl%C4%B1k_Kilise%29_in_Cappadocia%2C_G%C3%B6reme.jpg/500px-Dark_Church_%28Karanl%C4%B1k_Kilise%29_in_Cappadocia%2C_G%C3%B6reme.jpg', 1280, 1707, 'CC BY-SA 4.0', 'https://creativecommons.org/licenses/by-sa/4.0', 'Alperen Çiçekli', 'https://commons.wikimedia.org/wiki/File:Dark_Church_(Karanl%C4%B1k_Kilise)_in_Cappadocia,_G%C3%B6reme.jpg'),
  ('karsi-kilise', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/1/1d/JohannesAlteFresken.jpg/1280px-JohannesAlteFresken.jpg', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/1/1d/JohannesAlteFresken.jpg/500px-JohannesAlteFresken.jpg', 1280, 960, 'CC BY 3.0', 'https://creativecommons.org/licenses/by/3.0', 'Klaus-Peter Simon', 'https://commons.wikimedia.org/wiki/File:JohannesAlteFresken.jpg'),
  ('kaymakli', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/2/24/Kaymakli-05-mihalorel.jpg/1280px-Kaymakli-05-mihalorel.jpg', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/2/24/Kaymakli-05-mihalorel.jpg/500px-Kaymakli-05-mihalorel.jpg', 1280, 960, 'CC BY 2.0', 'https://creativecommons.org/licenses/by/2.0', 'Михал Орела', 'https://commons.wikimedia.org/wiki/File:Kaymakli-05-mihalorel.jpg'),
  ('keslik-manastiri', 'https://upload.wikimedia.org/wikipedia/commons/7/7d/Keslik.JPG', 'https://upload.wikimedia.org/wikipedia/commons/7/7d/Keslik.JPG', 1280, 886, 'CC BY-SA 3.0', 'https://creativecommons.org/licenses/by-sa/3.0', 'Elelicht', 'https://commons.wikimedia.org/wiki/File:Keslik.JPG'),
  ('kizilcukur-vadisi', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/5/5d/Rose_Valley%2C_Cappadocia_-_K%C4%B1z%C4%B1l%C3%A7ukur_Vadisi%2C_Kapadokya_06.jpg/1280px-Rose_Valley%2C_Cappadocia_-_K%C4%B1z%C4%B1l%C3%A7ukur_Vadisi%2C_Kapadokya_06.jpg', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/5/5d/Rose_Valley%2C_Cappadocia_-_K%C4%B1z%C4%B1l%C3%A7ukur_Vadisi%2C_Kapadokya_06.jpg/500px-Rose_Valley%2C_Cappadocia_-_K%C4%B1z%C4%B1l%C3%A7ukur_Vadisi%2C_Kapadokya_06.jpg', 1280, 785, 'CC BY-SA 4.0', 'https://creativecommons.org/licenses/by-sa/4.0', 'Zeynel Cebeci', 'https://commons.wikimedia.org/wiki/File:Rose_Valley,_Cappadocia_-_K%C4%B1z%C4%B1l%C3%A7ukur_Vadisi,_Kapadokya_06.jpg'),
  ('kokar-kilise-aksaray', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/0/0d/Kokar_Kilise_%2810%29.jpg/1280px-Kokar_Kilise_%2810%29.jpg', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/0/0d/Kokar_Kilise_%2810%29.jpg/500px-Kokar_Kilise_%2810%29.jpg', 1280, 1707, 'CC BY-SA 3.0', 'https://creativecommons.org/licenses/by-sa/3.0', 'Ji-Elle', 'https://commons.wikimedia.org/wiki/File:Kokar_Kilise_(10).jpg'),
  ('meskendir-valley-entrance', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/1/12/Dovecotes_in_Meskendir_Valley_-_2014.10_-_panoramio.jpg/1280px-Dovecotes_in_Meskendir_Valley_-_2014.10_-_panoramio.jpg', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/1/12/Dovecotes_in_Meskendir_Valley_-_2014.10_-_panoramio.jpg/500px-Dovecotes_in_Meskendir_Valley_-_2014.10_-_panoramio.jpg', 1280, 960, 'CC BY 3.0', 'https://creativecommons.org/licenses/by/3.0', 'rheins', 'https://commons.wikimedia.org/wiki/File:Dovecotes_in_Meskendir_Valley_-_2014.10_-_panoramio.jpg'),
  ('mustafapasa', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/4/45/St._John_the_Theologian_Church%2C_Mustafapa%C5%9Fa_in_2014_2070.jpg/1280px-St._John_the_Theologian_Church%2C_Mustafapa%C5%9Fa_in_2014_2070.jpg', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/4/45/St._John_the_Theologian_Church%2C_Mustafapa%C5%9Fa_in_2014_2070.jpg/500px-St._John_the_Theologian_Church%2C_Mustafapa%C5%9Fa_in_2014_2070.jpg', 1280, 852, 'CC BY-SA 4.0', 'https://creativecommons.org/licenses/by-sa/4.0', 'Dosseman', 'https://commons.wikimedia.org/wiki/File:St._John_the_Theologian_Church,_Mustafapa%C5%9Fa_in_2014_2070.jpg'),
  ('mutfak-ve-kiler', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/6/66/Cappadocia_G%C3%B6reme_Pantry-Kitchen-Refectory-T_20241003_143735.jpg/1280px-Cappadocia_G%C3%B6reme_Pantry-Kitchen-Refectory-T_20241003_143735.jpg', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/6/66/Cappadocia_G%C3%B6reme_Pantry-Kitchen-Refectory-T_20241003_143735.jpg/500px-Cappadocia_G%C3%B6reme_Pantry-Kitchen-Refectory-T_20241003_143735.jpg', 1280, 964, 'CC BY-SA 4.0', 'https://creativecommons.org/licenses/by-sa/4.0', 'Rigorius', 'https://commons.wikimedia.org/wiki/File:Cappadocia_G%C3%B6reme_Pantry-Kitchen-Refectory-T_20241003_143735.jpg'),
  ('nevsehir-kalesi', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/3/3c/NevsehirKalesi.jpg/1280px-NevsehirKalesi.jpg', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/3/3c/NevsehirKalesi.jpg/500px-NevsehirKalesi.jpg', 1280, 720, 'CC BY-SA 4.0', 'https://creativecommons.org/licenses/by-sa/4.0', 'Ebubekir Boyar', 'https://commons.wikimedia.org/wiki/File:NevsehirKalesi.jpg'),
  ('nevsehir-muzesi', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/d/db/Nev%C5%9Fehir_museum_in_2019_1556.jpg/1280px-Nev%C5%9Fehir_museum_in_2019_1556.jpg', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/d/db/Nev%C5%9Fehir_museum_in_2019_1556.jpg/500px-Nev%C5%9Fehir_museum_in_2019_1556.jpg', 1280, 853, 'CC BY-SA 4.0', 'https://creativecommons.org/licenses/by-sa/4.0', 'Dosseman', 'https://commons.wikimedia.org/wiki/File:Nev%C5%9Fehir_museum_in_2019_1556.jpg'),
  ('ortahisar-kalesi', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/f/f3/Cappadocia_March_2006.jpg/1280px-Cappadocia_March_2006.jpg', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/f/f3/Cappadocia_March_2006.jpg/500px-Cappadocia_March_2006.jpg', 1280, 1082, 'CC BY-SA 3.0', 'https://creativecommons.org/licenses/by-sa/3.0', 'Brocken Inaglory', 'https://commons.wikimedia.org/wiki/File:Cappadocia_March_2006.jpg'),
  ('ozkonak', 'https://upload.wikimedia.org/wikipedia/commons/6/6a/Ozkonak%2C_Avanos%2C_Turkey_01.jpg', 'https://upload.wikimedia.org/wikipedia/commons/6/6a/Ozkonak%2C_Avanos%2C_Turkey_01.jpg', 1280, 960, 'Public domain', null, 'Katpatuka at Turkish Wikipedia', 'https://commons.wikimedia.org/wiki/File:Ozkonak,_Avanos,_Turkey_01.jpg'),
  ('pantokrator-kilisesi', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/7/70/J22_203_Pandokratorkirche.jpg/1280px-J22_203_Pandokratorkirche.jpg', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/7/70/J22_203_Pandokratorkirche.jpg/500px-J22_203_Pandokratorkirche.jpg', 1280, 853, 'CC BY-SA 4.0', 'https://creativecommons.org/licenses/by-sa/4.0', 'Falk2', 'https://commons.wikimedia.org/wiki/File:J22_203_Pandokratorkirche.jpg'),
  ('passabag-vadisi', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/f/f0/Pasaba_Valley.jpg/1280px-Pasaba_Valley.jpg', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/f/f0/Pasaba_Valley.jpg/500px-Pasaba_Valley.jpg', 1280, 960, 'CC BY-SA 4.0', 'https://creativecommons.org/licenses/by-sa/4.0', 'Héctor Ochoa ''Robot8A''', 'https://commons.wikimedia.org/wiki/File:Pasaba_Valley.jpg'),
  ('purenli-seki-kilisesi', 'https://upload.wikimedia.org/wikipedia/commons/8/8b/Aksaray_1998_11.jpg', 'https://upload.wikimedia.org/wikipedia/commons/8/8b/Aksaray_1998_11.jpg', 1280, 820, 'CC BY-SA 4.0', 'https://creativecommons.org/licenses/by-sa/4.0', 'LBM1948', 'https://commons.wikimedia.org/wiki/File:Aksaray_1998_11.jpg'),
  ('sarihan-kervansarayi', 'https://upload.wikimedia.org/wikipedia/commons/7/76/Sarihangesamt.jpg', 'https://upload.wikimedia.org/wikipedia/commons/7/76/Sarihangesamt.jpg', 1280, 800, 'CC BY-SA 3.0', 'https://creativecommons.org/licenses/by-sa/3.0', 'Klaus-Peter Simon', 'https://commons.wikimedia.org/wiki/File:Sarihangesamt.jpg'),
  ('selime-katedrali', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/b/ba/Selime_Cathedral.jpg/1280px-Selime_Cathedral.jpg', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/b/ba/Selime_Cathedral.jpg/500px-Selime_Cathedral.jpg', 1280, 811, 'CC BY-SA 4.0', 'https://creativecommons.org/licenses/by-sa/4.0', 'Dudva', 'https://commons.wikimedia.org/wiki/File:Selime_Cathedral.jpg'),
  ('sobesos-antik-kenti', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/9/90/Capadoccia_Jul_2023_23_00_16_105000.jpeg/1280px-Capadoccia_Jul_2023_23_00_16_105000.jpeg', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/9/90/Capadoccia_Jul_2023_23_00_16_105000.jpeg/500px-Capadoccia_Jul_2023_23_00_16_105000.jpeg', 1280, 960, 'CC BY-SA 4.0', 'https://creativecommons.org/licenses/by-sa/4.0', 'Robot8A', 'https://commons.wikimedia.org/wiki/File:Capadoccia_Jul_2023_23_00_16_105000.jpeg'),
  ('soganli-karabas-kilisesi', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/5/5e/Capadoccia_Jul_2023_22_59_14_257000.jpeg/1280px-Capadoccia_Jul_2023_22_59_14_257000.jpeg', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/5/5e/Capadoccia_Jul_2023_22_59_14_257000.jpeg/500px-Capadoccia_Jul_2023_22_59_14_257000.jpeg', 1280, 960, 'CC BY-SA 4.0', 'https://creativecommons.org/licenses/by-sa/4.0', 'Robot8A', 'https://commons.wikimedia.org/wiki/File:Capadoccia_Jul_2023_22_59_14_257000.jpeg'),
  ('soganli-kubbeli-kilise', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/4/44/Kubbeli_Kilise_03.jpg/1280px-Kubbeli_Kilise_03.jpg', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/4/44/Kubbeli_Kilise_03.jpg/500px-Kubbeli_Kilise_03.jpg', 1280, 1920, 'CC BY-SA 3.0', 'https://creativecommons.org/licenses/by-sa/3.0', 'Bernard Gagnon', 'https://commons.wikimedia.org/wiki/File:Kubbeli_Kilise_03.jpg'),
  ('soganli-sakli-kilise', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/6/6a/Three_churches_domed_hidden_church.JPG/1280px-Three_churches_domed_hidden_church.JPG', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/6/6a/Three_churches_domed_hidden_church.JPG/500px-Three_churches_domed_hidden_church.JPG', 1280, 854, 'CC BY-SA 3.0', 'https://creativecommons.org/licenses/by-sa/3.0', 'This Photo was taken by Wolfgang Moroder . Feel free to use my photos, but please mention me as the author and send me a message . This image is not in the public domain . Please respect the copyright', 'https://commons.wikimedia.org/wiki/File:Three_churches_domed_hidden_church.JPG'),
  ('soganli-tahtali-kilise', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/3/3d/Tahtal%C4%B1_Church_-_St._Barbara_Church_in_So%C4%9Fanl%C4%B1_-_26054091215.jpg/1280px-Tahtal%C4%B1_Church_-_St._Barbara_Church_in_So%C4%9Fanl%C4%B1_-_26054091215.jpg', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/3/3d/Tahtal%C4%B1_Church_-_St._Barbara_Church_in_So%C4%9Fanl%C4%B1_-_26054091215.jpg/500px-Tahtal%C4%B1_Church_-_St._Barbara_Church_in_So%C4%9Fanl%C4%B1_-_26054091215.jpg', 1280, 853, 'CC BY 2.0', 'https://creativecommons.org/licenses/by/2.0', 'prilfish', 'https://commons.wikimedia.org/wiki/File:Tahtal%C4%B1_Church_-_St._Barbara_Church_in_So%C4%9Fanl%C4%B1_-_26054091215.jpg'),
  ('soganli-vadisi', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/0/02/Soganli_Valley_Cappadocia.JPG/1280px-Soganli_Valley_Cappadocia.JPG', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/0/02/Soganli_Valley_Cappadocia.JPG/500px-Soganli_Valley_Cappadocia.JPG', 1280, 854, 'CC BY-SA 3.0', 'https://creativecommons.org/licenses/by-sa/3.0', 'This Photo was taken by Wolfgang Moroder . Feel free to use my photos, but please mention me as the author and send me a message . This image is not in the public domain . Please respect the copyright', 'https://commons.wikimedia.org/wiki/File:Soganli_Valley_Cappadocia.JPG'),
  ('soganli-yilanli-kilise', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/a/ac/38800_So%C4%9Fanl%C4%B1-Ye%C5%9Filhisar-Kayseri%2C_Turkey_-_panoramio_%289%29.jpg/1280px-38800_So%C4%9Fanl%C4%B1-Ye%C5%9Filhisar-Kayseri%2C_Turkey_-_panoramio_%289%29.jpg', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/a/ac/38800_So%C4%9Fanl%C4%B1-Ye%C5%9Filhisar-Kayseri%2C_Turkey_-_panoramio_%289%29.jpg/500px-38800_So%C4%9Fanl%C4%B1-Ye%C5%9Filhisar-Kayseri%2C_Turkey_-_panoramio_%289%29.jpg', 1280, 720, 'CC BY-SA 3.0', 'https://creativecommons.org/licenses/by-sa/3.0', 'izvarin', 'https://commons.wikimedia.org/wiki/File:38800_So%C4%9Fanl%C4%B1-Ye%C5%9Filhisar-Kayseri,_Turkey_-_panoramio_(9).jpg'),
  ('sumbullu-kilise', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/e/e8/S%C3%BCmb%C3%BCll%C3%BC_Kilise_Ihlara_Valley_2008_%28cropped%29.jpg/1280px-S%C3%BCmb%C3%BCll%C3%BC_Kilise_Ihlara_Valley_2008_%28cropped%29.jpg', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/e/e8/S%C3%BCmb%C3%BCll%C3%BC_Kilise_Ihlara_Valley_2008_%28cropped%29.jpg/500px-S%C3%BCmb%C3%BCll%C3%BC_Kilise_Ihlara_Valley_2008_%28cropped%29.jpg', 1280, 937, 'CC BY 2.0', 'https://creativecommons.org/licenses/by/2.0', 'Verity Cridland', 'https://commons.wikimedia.org/wiki/File:S%C3%BCmb%C3%BCll%C3%BC_Kilise_Ihlara_Valley_2008_(cropped).jpg'),
  ('temenni-tepe', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/9/98/Temenni_Tepesi.jpg/1280px-Temenni_Tepesi.jpg', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/9/98/Temenni_Tepesi.jpg/500px-Temenni_Tepesi.jpg', 1280, 829, 'CC BY-SA 4.0', 'https://creativecommons.org/licenses/by-sa/4.0', 'Buzancar', 'https://commons.wikimedia.org/wiki/File:Temenni_Tepesi.jpg'),
  ('tokali-kilise', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/7/7b/J22_235_Tokal%C4%B1_Kilise.jpg/1280px-J22_235_Tokal%C4%B1_Kilise.jpg', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/7/7b/J22_235_Tokal%C4%B1_Kilise.jpg/500px-J22_235_Tokal%C4%B1_Kilise.jpg', 1280, 853, 'CC BY-SA 4.0', 'https://creativecommons.org/licenses/by-sa/4.0', 'Falk2', 'https://commons.wikimedia.org/wiki/File:J22_235_Tokal%C4%B1_Kilise.jpg'),
  ('uc-guzeller', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/f/f3/Three_beauties_of_%C3%9Crg%C3%BCp.jpg/1280px-Three_beauties_of_%C3%9Crg%C3%BCp.jpg', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/f/f3/Three_beauties_of_%C3%9Crg%C3%BCp.jpg/500px-Three_beauties_of_%C3%9Crg%C3%BCp.jpg', 1280, 853, 'CC BY 2.0', 'https://creativecommons.org/licenses/by/2.0', 'prilfish', 'https://commons.wikimedia.org/wiki/File:Three_beauties_of_%C3%9Crg%C3%BCp.jpg'),
  ('uchisar-kalesi', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/3/39/Nev%C5%9Fehir_U%C3%A7_hisar_kalesi.jpg/1280px-Nev%C5%9Fehir_U%C3%A7_hisar_kalesi.jpg', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/3/39/Nev%C5%9Fehir_U%C3%A7_hisar_kalesi.jpg/500px-Nev%C5%9Fehir_U%C3%A7_hisar_kalesi.jpg', 1280, 960, 'CC BY-SA 4.0', 'https://creativecommons.org/licenses/by-sa/4.0', 'SerifeOzoglu', 'https://commons.wikimedia.org/wiki/File:Nev%C5%9Fehir_U%C3%A7_hisar_kalesi.jpg'),
  ('yilanli-kilise', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/7/75/YilanliFresco.jpg/1280px-YilanliFresco.jpg', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/7/75/YilanliFresco.jpg/500px-YilanliFresco.jpg', 1280, 960, 'CC BY-SA 3.0', 'https://creativecommons.org/licenses/by-sa/3.0', 'Niels Elgaard Larsen', 'https://commons.wikimedia.org/wiki/File:YilanliFresco.jpg'),
  ('yilanli-kilise-aksaray', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/1/10/Yilanli_Kilise_%281%29.jpg/1280px-Yilanli_Kilise_%281%29.jpg', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/1/10/Yilanli_Kilise_%281%29.jpg/500px-Yilanli_Kilise_%281%29.jpg', 1280, 1033, 'CC BY-SA 3.0', 'https://creativecommons.org/licenses/by-sa/3.0', 'Ji-Elle', 'https://commons.wikimedia.org/wiki/File:Yilanli_Kilise_(1).jpg'),
  ('zelve-acik-hava-muzesi', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/2/28/Zelve-December.jpg/1280px-Zelve-December.jpg', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/2/28/Zelve-December.jpg/500px-Zelve-December.jpg', 1280, 1707, 'CC0', 'http://creativecommons.org/publicdomain/zero/1.0/deed.en', 'Yumin Cha', 'https://commons.wikimedia.org/wiki/File:Zelve-December.jpg')
) v(slug, url, thumb_url, width, height, license, license_url, author, source_url)
join public.places p on p.slug = v.slug;
