-- Gezi App: geliştirme verisi (supabase db reset ile yüklenir)
-- DİKKAT: Buradaki 15 yer geliştirme ve test içindir; koordinatlar yaklaşıktır.
-- Gerçek İstanbul listesi data-pipeline çıktısından, onaydan sonra gelecek.

-- Şehir ------------------------------------------------------------------------
insert into public.cities (slug, names, timezone)
values ('istanbul', '{"tr": "İstanbul", "en": "Istanbul"}', 'Europe/Istanbul');

-- Kategoriler ------------------------------------------------------------------
insert into public.categories (slug, kind, icon, sort_order) values
  ('mosque',             'historical', 'mosque',     10),
  ('church',             'historical', 'church',     11),
  ('synagogue',          'historical', 'synagogue',  12),
  ('palace',             'historical', 'palace',     13),
  ('museum',             'historical', 'museum',     14),
  ('fortress',           'historical', 'fortress',   15),
  ('tower',              'historical', 'tower',      16),
  ('cistern',            'historical', 'cistern',    17),
  ('monument',           'historical', 'monument',   18),
  ('archaeological_site','historical', 'ruins',      19),
  ('viewpoint',          'nature',     'viewpoint',  30),
  ('hill',               'nature',     'hill',       31),
  ('forest',             'nature',     'forest',     32),
  ('park',               'nature',     'park',       33),
  ('beach',              'nature',     'beach',      34),
  ('island',             'nature',     'island',     35),
  ('waterfall',          'nature',     'waterfall',  36);

insert into public.category_translations (category_id, lang, name)
select c.id, v.lang, v.name
from (values
  ('mosque', 'tr', 'Cami'),                    ('mosque', 'en', 'Mosque'),
  ('church', 'tr', 'Kilise'),                  ('church', 'en', 'Church'),
  ('synagogue', 'tr', 'Sinagog'),              ('synagogue', 'en', 'Synagogue'),
  ('palace', 'tr', 'Saray ve Köşk'),           ('palace', 'en', 'Palace & Pavilion'),
  ('museum', 'tr', 'Müze'),                    ('museum', 'en', 'Museum'),
  ('fortress', 'tr', 'Kale ve Sur'),           ('fortress', 'en', 'Fortress & Walls'),
  ('tower', 'tr', 'Kule'),                     ('tower', 'en', 'Tower'),
  ('cistern', 'tr', 'Sarnıç'),                 ('cistern', 'en', 'Cistern'),
  ('monument', 'tr', 'Anıt'),                  ('monument', 'en', 'Monument'),
  ('archaeological_site', 'tr', 'Ören Yeri'),  ('archaeological_site', 'en', 'Archaeological Site'),
  ('viewpoint', 'tr', 'Seyir Noktası'),        ('viewpoint', 'en', 'Viewpoint'),
  ('hill', 'tr', 'Tepe'),                      ('hill', 'en', 'Hill'),
  ('forest', 'tr', 'Koru ve Orman'),           ('forest', 'en', 'Grove & Forest'),
  ('park', 'tr', 'Park ve Bahçe'),             ('park', 'en', 'Park & Garden'),
  ('beach', 'tr', 'Sahil ve Plaj'),            ('beach', 'en', 'Coast & Beach'),
  ('island', 'tr', 'Ada'),                     ('island', 'en', 'Island'),
  ('waterfall', 'tr', 'Şelale'),               ('waterfall', 'en', 'Waterfall')
) v(slug, lang, name)
join public.categories c on c.slug = v.slug;

-- Yerler (önce yayında değil; çeviriler eklendikten sonra yayına alınır) ------
insert into public.places
  (city_id, category_id, slug, location, checkin_radius_m, period, built_year)
select ci.id, c.id, v.slug,
       st_setsrid(st_makepoint(v.lng, v.lat), 4326)::geography,
       v.radius, v.period, v.built_year
from (values
  -- slug,                kategori,    lat,     lng,     yarıçap, dönem,     yapım yılı
  ('ayasofya',            'mosque',    41.0086, 28.9802,  100, 'Bizans',   537),
  ('sultanahmet-camii',   'mosque',    41.0054, 28.9768,  100, 'Osmanlı',  1616),
  ('suleymaniye-camii',   'mosque',    41.0162, 28.9639,  100, 'Osmanlı',  1557),
  ('topkapi-sarayi',      'palace',    41.0115, 28.9834,  150, 'Osmanlı',  1478),
  ('dolmabahce-sarayi',   'palace',    41.0392, 29.0005,  150, 'Osmanlı',  1856),
  ('yerebatan-sarnici',   'cistern',   41.0084, 28.9779,   60, 'Bizans',   532),
  ('galata-kulesi',       'tower',     41.0256, 28.9742,   60, 'Ceneviz',  1348),
  ('rumeli-hisari',       'fortress',  41.0849, 29.0566,  150, 'Osmanlı',  1452),
  ('buyuk-camlica',       'viewpoint', 41.0277, 29.0687,   50, null,       null),
  ('pierre-loti',         'viewpoint', 41.0536, 28.9337,   50, null,       null),
  ('otagtepe',            'viewpoint', 41.0930, 29.0720,   50, null,       null),
  ('emirgan-korusu',      'forest',    41.1090, 29.0530,  400, null,       null),
  ('belgrad-ormani',      'forest',    41.1800, 28.9750, 1500, null,       null),
  ('buyukada',            'island',    40.8590, 29.1210, 1500, null,       null),
  ('moda-sahili',         'beach',     40.9800, 29.0240,  150, null,       null)
) v(slug, category, lat, lng, radius, period, built_year)
join public.cities ci on ci.slug = 'istanbul'
join public.categories c on c.slug = v.category;

insert into public.place_translations (place_id, lang, name, short_desc, best_time)
select p.id, v.lang, v.name, v.short_desc, v.best_time
from (values
  ('ayasofya', 'tr', 'Ayasofya',
   '537''de I. Justinianus döneminde tamamlanan; dev kubbesiyle mimarlık tarihinin dönüm noktalarından biri.', null),
  ('ayasofya', 'en', 'Hagia Sophia',
   'Completed in 537 under Emperor Justinian I; its vast dome is a landmark of world architecture.', null),

  ('sultanahmet-camii', 'tr', 'Sultanahmet Camii',
   '1609-1616 arasında inşa edilen, iç mekânındaki mavi İznik çinileriyle tanınan cami.', null),
  ('sultanahmet-camii', 'en', 'Blue Mosque (Sultan Ahmed Mosque)',
   'Built 1609–1616 and known for the blue İznik tiles that line its interior.', null),

  ('suleymaniye-camii', 'tr', 'Süleymaniye Camii',
   'Mimar Sinan''ın Kanuni Sultan Süleyman için yaptığı, Haliç''e bakan külliyenin merkezi.', null),
  ('suleymaniye-camii', 'en', 'Süleymaniye Mosque',
   'Mimar Sinan''s mosque for Suleiman the Magnificent, crowning a complex above the Golden Horn.', null),

  ('topkapi-sarayi', 'tr', 'Topkapı Sarayı',
   'Yaklaşık dört yüzyıl Osmanlı padişahlarının yaşadığı ve devletin yönetildiği saray.', null),
  ('topkapi-sarayi', 'en', 'Topkapı Palace',
   'Home of the Ottoman sultans and seat of government for roughly four centuries.', null),

  ('dolmabahce-sarayi', 'tr', 'Dolmabahçe Sarayı',
   '1856''da tamamlanan, Boğaz kıyısında Avrupa üslubunda yapılmış Osmanlı sarayı.', null),
  ('dolmabahce-sarayi', 'en', 'Dolmabahçe Palace',
   'A European-style Ottoman palace on the Bosphorus shore, completed in 1856.', null),

  ('yerebatan-sarnici', 'tr', 'Yerebatan Sarnıcı',
   'Bizans döneminde yapılan, yüzlerce sütunuyla şehrin en büyük yeraltı su depolarından biri.', null),
  ('yerebatan-sarnici', 'en', 'Basilica Cistern',
   'A Byzantine underground reservoir held up by hundreds of columns, one of the city''s largest.', null),

  ('galata-kulesi', 'tr', 'Galata Kulesi',
   '1348''de Cenevizlilerin yaptığı, tepesinden tarihi yarımadayı gören kule.', null),
  ('galata-kulesi', 'en', 'Galata Tower',
   'Built by the Genoese in 1348, with views over the historic peninsula from the top.', null),

  ('rumeli-hisari', 'tr', 'Rumeli Hisarı',
   'Fatih Sultan Mehmet''in 1452''de Boğaz''ın en dar noktasında yaptırdığı hisar.', null),
  ('rumeli-hisari', 'en', 'Rumelian Castle',
   'Fortress built by Mehmed II in 1452 at the narrowest point of the Bosphorus.', null),

  ('buyuk-camlica', 'tr', 'Büyük Çamlıca Tepesi',
   'Asya yakasının en yüksek tepelerinden; şehri ve Boğaz''ı geniş bir açıdan gösterir.', 'Gün batımı'),
  ('buyuk-camlica', 'en', 'Büyük Çamlıca Hill',
   'One of the highest hills on the Asian side, with a sweeping view of the city and the Bosphorus.', 'Sunset'),

  ('pierre-loti', 'tr', 'Pierre Loti Tepesi',
   'Haliç''e tepeden bakan, adını Fransız yazar Pierre Loti''den alan seyir tepesi.', 'Akşamüstü'),
  ('pierre-loti', 'en', 'Pierre Loti Hill',
   'A hilltop overlooking the Golden Horn, named after the French writer Pierre Loti.', 'Late afternoon'),

  ('otagtepe', 'tr', 'Otağtepe',
   'Fatih Sultan Mehmet Köprüsü''ne ve Boğaz''ın kuzeyine bakan sakin bir seyir parkı.', 'Gün batımı'),
  ('otagtepe', 'en', 'Otağtepe',
   'A quiet viewpoint park looking over the Fatih Sultan Mehmet Bridge and the upper Bosphorus.', 'Sunset'),

  ('emirgan-korusu', 'tr', 'Emirgan Korusu',
   'Lale festivaliyle bilinen, köşkleri ve yaşlı ağaçlarıyla Boğaz kıyısında büyük bir koru.', 'Nisan (lale zamanı)'),
  ('emirgan-korusu', 'en', 'Emirgan Grove',
   'A large Bosphorus-side grove with old trees and pavilions, famous for its tulip festival.', 'April (tulip season)'),

  ('belgrad-ormani', 'tr', 'Belgrad Ormanı',
   'Şehrin kuzeyinde, yürüyüş parkurları ve tarihi bentleriyle İstanbul''un en büyük ormanı.', 'Sabah; ilkbahar ve sonbahar'),
  ('belgrad-ormani', 'en', 'Belgrad Forest',
   'Istanbul''s largest forest, north of the city, with walking trails and historic dams.', 'Mornings; spring and autumn'),

  ('buyukada', 'tr', 'Büyükada',
   'Adaların en büyüğü; özel araç trafiği olmayan, köşkleri ve çamlıklarıyla bilinen ada.', 'İlkbahar ve sonbahar'),
  ('buyukada', 'en', 'Büyükada',
   'The largest of the Princes'' Islands, free of private cars and known for its mansions and pines.', 'Spring and autumn'),

  ('moda-sahili', 'tr', 'Moda Sahili',
   'Kadıköy''de denize uzanan, gün batımı yürüyüşleriyle sevilen sahil.', 'Gün batımı'),
  ('moda-sahili', 'en', 'Moda Seafront',
   'A Kadıköy shoreline loved for sunset walks by the sea.', 'Sunset')
) v(slug, lang, name, short_desc, best_time)
join public.places p on p.slug = v.slug;

update public.places set is_published = true;

-- Rozetler (20: 8 tarihi, 6 doğa, 6 genel) -------------------------------------
insert into public.achievements (slug, rule, sort_order) values
  -- genel
  ('first-step',          '{"type":"total_count","n":1}', 1),
  ('explorer-10',         '{"type":"total_count","n":10}', 2),
  ('explorer-25',         '{"type":"total_count","n":25}', 3),
  ('explorer-50',         '{"type":"total_count","n":50}', 4),
  ('streak-4-weeks',      '{"type":"streak_weeks","n":4}', 5),
  ('istanbul-complete',   '{"type":"city_complete","city":"istanbul"}', 6),
  -- tarihi
  ('mosque-wanderer',     '{"type":"category_count","category":"mosque","n":5}', 10),
  ('palace-life',         '{"type":"category_count","category":"palace","n":3}', 11),
  ('museum-lover',        '{"type":"category_count","category":"museum","n":5}', 12),
  ('wall-keeper',         '{"type":"category_count","category":"fortress","n":2}', 13),
  ('byzantine-traveler',  '{"type":"period_count","period":"Bizans","n":3}', 14),
  ('ottoman-heritage',    '{"type":"period_count","period":"Osmanlı","n":10}', 15),
  ('history-buff-10',     '{"type":"kind_count","kind":"historical","n":10}', 16),
  ('istanbul-history-complete', '{"type":"city_complete","city":"istanbul","kind":"historical"}', 17),
  -- doğa
  ('first-view',          '{"type":"category_count","category":"viewpoint","n":1}', 20),
  ('view-hunter',         '{"type":"category_count","category":"viewpoint","n":5}', 21),
  ('nature-explorer',     '{"type":"kind_count","kind":"nature","n":5}', 22),
  ('forest-walker',       '{"type":"category_count","category":"forest","n":3}', 23),
  ('islands-tour',        '{"type":"place_set","places":["buyukada","heybeliada","burgazada","kinaliada"]}', 24),
  ('sunset-collector',    '{"type":"time_of_day","category":"viewpoint","from":"17:00","to":"20:00","n":3}', 25);

insert into public.achievement_translations (achievement_id, lang, name, description)
select a.id, v.lang, v.name, v.description
from (values
  ('first-step', 'tr', 'İlk Adım', 'İlk yerini gez.'),
  ('first-step', 'en', 'First Step', 'Visit your first place.'),
  ('explorer-10', 'tr', 'Kâşif', '10 yer gez.'),
  ('explorer-10', 'en', 'Explorer', 'Visit 10 places.'),
  ('explorer-25', 'tr', 'Gezgin', '25 yer gez.'),
  ('explorer-25', 'en', 'Wanderer', 'Visit 25 places.'),
  ('explorer-50', 'tr', 'Şehir Ustası', '50 yer gez.'),
  ('explorer-50', 'en', 'City Master', 'Visit 50 places.'),
  ('streak-4-weeks', 'tr', '4 Hafta Seri', '4 hafta üst üste her hafta en az bir yer gez.'),
  ('streak-4-weeks', 'en', '4-Week Streak', 'Visit at least one place every week for 4 weeks in a row.'),
  ('istanbul-complete', 'tr', 'İstanbul''u Tamamla', 'İstanbul''daki tüm yerleri gez.'),
  ('istanbul-complete', 'en', 'Complete Istanbul', 'Visit every place in Istanbul.'),

  ('mosque-wanderer', 'tr', 'Cami Gezgini', '5 cami gez.'),
  ('mosque-wanderer', 'en', 'Mosque Wanderer', 'Visit 5 mosques.'),
  ('palace-life', 'tr', 'Saray Hayatı', '3 saray ya da köşk gez.'),
  ('palace-life', 'en', 'Palace Life', 'Visit 3 palaces or pavilions.'),
  ('museum-lover', 'tr', 'Müze Sever', '5 müze gez.'),
  ('museum-lover', 'en', 'Museum Lover', 'Visit 5 museums.'),
  ('wall-keeper', 'tr', 'Surların Bekçisi', '2 kale ya da sur gez.'),
  ('wall-keeper', 'en', 'Keeper of the Walls', 'Visit 2 fortresses or city walls.'),
  ('byzantine-traveler', 'tr', 'Bizans Yolcusu', 'Bizans döneminden 3 yer gez.'),
  ('byzantine-traveler', 'en', 'Byzantine Traveler', 'Visit 3 Byzantine-era places.'),
  ('ottoman-heritage', 'tr', 'Osmanlı Mirası', 'Osmanlı döneminden 10 yer gez.'),
  ('ottoman-heritage', 'en', 'Ottoman Heritage', 'Visit 10 Ottoman-era places.'),
  ('history-buff-10', 'tr', 'Tarih Meraklısı', '10 tarihi yer gez.'),
  ('history-buff-10', 'en', 'History Buff', 'Visit 10 historical places.'),
  ('istanbul-history-complete', 'tr', 'İstanbul Tarihi Tamam', 'İstanbul''daki tüm tarihi yerleri gez.'),
  ('istanbul-history-complete', 'en', 'Istanbul History Complete', 'Visit every historical place in Istanbul.'),

  ('first-view', 'tr', 'İlk Manzara', 'İlk seyir noktanı gez.'),
  ('first-view', 'en', 'First View', 'Visit your first viewpoint.'),
  ('view-hunter', 'tr', 'Manzara Avcısı', '5 seyir noktası gez.'),
  ('view-hunter', 'en', 'View Hunter', 'Visit 5 viewpoints.'),
  ('nature-explorer', 'tr', 'Doğa Kâşifi', '5 doğa yeri gez.'),
  ('nature-explorer', 'en', 'Nature Explorer', 'Visit 5 nature spots.'),
  ('forest-walker', 'tr', 'Orman Yürüyüşçüsü', '3 koru ya da orman gez.'),
  ('forest-walker', 'en', 'Forest Walker', 'Visit 3 groves or forests.'),
  ('islands-tour', 'tr', 'Adalar Turu', 'Büyükada, Heybeliada, Burgazada ve Kınalıada''yı gez.'),
  ('islands-tour', 'en', 'Islands Tour', 'Visit Büyükada, Heybeliada, Burgazada and Kınalıada.'),
  ('sunset-collector', 'tr', 'Gün Batımı Koleksiyoncusu', 'Seyir noktalarında 17:00-20:00 arasında 3 check-in yap.'),
  ('sunset-collector', 'en', 'Sunset Collector', 'Check in at viewpoints between 17:00 and 20:00 three times.')
) v(slug, lang, name, description)
join public.achievements a on a.slug = v.slug;
