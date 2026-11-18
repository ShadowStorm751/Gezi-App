-- Gezi App: kalıcı başlangıç verisi — şehir, kategoriler, rozetler.
-- Önceden seed.sql içindeydi; seed yalnızca yerel geliştirmede çalıştığı için gerçek projeye
-- yüklenmiyordu. Tekrar çalıştırılabilir (on conflict do nothing).

-- Şehir ------------------------------------------------------------------------
insert into public.cities (slug, names, timezone)
values ('istanbul', '{"tr": "İstanbul", "en": "Istanbul"}', 'Europe/Istanbul')
on conflict (slug) do nothing;

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
  ('waterfall',          'nature',     'waterfall',  36)
on conflict (slug) do nothing;

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
join public.categories c on c.slug = v.slug
on conflict (category_id, lang) do nothing;

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
  ('sunset-collector',    '{"type":"time_of_day","category":"viewpoint","from":"17:00","to":"20:00","n":3}', 25)
on conflict (slug) do nothing;

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
join public.achievements a on a.slug = v.slug
on conflict (achievement_id, lang) do nothing;
