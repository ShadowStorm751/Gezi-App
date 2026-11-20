-- Bursa: proje sahibinin onayladığı yerler (2026-11-19).
-- Üreten: data-pipeline/content/build_city.py bursa — elle düzenleme; script'i yeniden çalıştır.
-- Yerler gizli eklenir (is_published = false); yayına alma ayrı bir migration ile yapılır.

-- Şehir --------------------------------------------------------------------------
insert into public.cities (slug, names, timezone)
values ('bursa', '{"tr": "Bursa", "en": "Bursa"}', 'Europe/Istanbul')
on conflict (slug) do nothing;

-- Yeni kategori(ler) ------------------------------------------------------------
insert into public.categories (slug, kind, icon, sort_order) values
  ('village', 'historical', 'village', 21)
on conflict (slug) do nothing;

insert into public.category_translations (category_id, lang, name)
select c.id, v.lang, v.name
from (values
  ('village', 'tr', 'Tarihi Köy'), ('village', 'en', 'Historic Village')
) v(slug, lang, name)
join public.categories c on c.slug = v.slug
on conflict (category_id, lang) do nothing;

-- Yerler --------------------------------------------------------------------------
-- Otomatik üretildi: data-pipeline/pipeline.py build (2026-11-20 15:29)
-- 71 yer; hepsi gizli (is_published = false); 71 tanesinin TR+EN kısa açıklaması dolu.
-- Tekrar çalıştırılabilir: aynı slug'lı yerler güncellenir, kopya oluşmaz.

insert into public.places
  (city_id, category_id, slug, location, area, checkin_radius_m, period, built_year, wikidata_id, osm_id)
select ci.id, c.id, v.slug,
       st_setsrid(st_makepoint(v.lng::float8, v.lat::float8), 4326)::geography,
       case when v.area_wkt is null then null else st_geogfromtext(v.area_wkt) end,
       v.radius::int, v.period, v.built_year::int, v.wikidata_id, v.osm_id
from (values
  ('bursa-ulu-camii', 'mosque', 40.183904, 29.061796, 100, 'Osmanlı', 1399, 'Q32339', 'way/26434413', null),
  ('ayasofya-camii-iznik', 'mosque', 40.429155, 29.720271, 100, 'Bizans', null, 'Q4430013', 'way/192225327', null),
  ('emir-sultan-camii', 'mosque', 40.181148, 29.081002, 100, 'Osmanlı', null, 'Q1207606', 'way/254312132', null),
  ('orhan-gazi-camii', 'mosque', 40.183897, 29.064086, 100, 'Osmanlı', 1339, 'Q6038154', 'way/255187109', null),
  ('iznik-yesil-cami', 'mosque', 40.429734, 29.726886, 100, 'Osmanlı', null, 'Q8053361', 'way/310108583', null),
  ('fatih-camii-tirilye', 'mosque', 40.393031, 28.796880, 40, 'Bizans', null, 'Q5437791', 'way/342544743', null),
  ('veled-i-yanic-cami', 'mosque', 40.185031, 29.056449, 100, 'Bizans', null, 'Q21848538', 'way/407491078', null),
  ('yildirim-camii', 'mosque', 40.187419, 29.082436, 100, 'Osmanlı', null, 'Q128256', 'way/247424180', null),
  ('bursa-muradiye-camii', 'mosque', 40.190977, 29.046526, 120, 'Osmanlı', null, 'Q65219967', 'way/397551853', null),
  ('yesil-camii', 'mosque', 40.182194, 29.074611, 100, 'Osmanlı', 1419, 'Q1549086', null, null),
  ('eski-camii-golyazi', 'mosque', 40.165412, 28.677684, 30, 'Osmanlı', null, 'Q133803234', 'way/384327471', null),
  ('kemerli-kilise-tirilye', 'church', 40.393299, 28.795044, 40, 'Bizans', null, 'Q16931903', 'way/1320463236', null),
  ('aziz-panteleimon-kilisesi', 'church', 40.170278, 28.680504, 40, 'Osmanlı', null, 'Q136645532', 'way/381003504', null),
  ('mayor-sinagogu', 'synagogue', 40.188641, 29.055159, 100, 'Osmanlı', null, null, 'way/483990654', null),
  ('bursa-arkeoloji-muzesi', 'museum', 40.195895, 29.041197, 100, 'Cumhuriyet', null, 'Q6082814', 'node/2794515664', null),
  ('bursa-ataturk-muzesi', 'museum', 40.195127, 29.039873, 100, 'Osmanlı', null, 'Q38251727', 'node/2794515662', null),
  ('mudanya-mutareke-evi', 'museum', 40.379715, 28.881735, 100, 'Osmanlı', null, 'Q6042901', 'way/463271712', null),
  ('iznik-muzesi', 'museum', 40.424080, 29.720685, 100, 'Osmanlı', null, 'Q122731621', 'way/1271253817', null),
  ('bursa-kent-muzesi', 'museum', 40.182387, 29.066437, 100, 'Osmanlı', null, 'Q6040943', 'node/1786760093', null),
  ('uluumay-osmanli-halk-kiyafetleri-ve-takilari-muzesi', 'museum', 40.191853, 29.045857, 100, null, null, 'Q6023010', 'node/2794629724', null),
  ('panorama-1326-bursa-fetih-muzesi', 'museum', 40.186314, 29.075008, 100, 'Cumhuriyet', null, 'Q85973875', 'way/1148944018', null),
  ('merinos-tekstil-sanayi-muzesi', 'museum', 40.199686, 29.051572, 60, 'Cumhuriyet', null, null, 'node/1786721373', null),
  ('tofas-anadolu-araclari-muzesi', 'museum', 40.176509, 29.071029, 100, 'Cumhuriyet', null, null, 'node/6593241586', null),
  ('17-yuzyil-osmanli-evi-muzesi', 'museum', 40.191402, 29.045744, 100, 'Osmanlı', null, null, 'node/12875025174', null),
  ('cumalikizik-etnografya-muzesi', 'museum', 40.175076, 29.171915, 30, null, null, null, 'way/1187304357', null),
  ('karagoz-muzesi', 'museum', 40.201783, 29.027399, 100, 'Cumhuriyet', null, null, 'node/12875025172', null),
  ('merinos-enerji-muzesi', 'museum', 40.201094, 29.050599, 50, 'Cumhuriyet', null, null, 'way/530848643', null),
  ('iznik-surlari', 'fortress', 40.422861, 29.718028, 1100, 'Antik', null, 'Q6028239', null, null),
  ('tophane-saat-kulesi', 'tower', 40.187850, 29.057470, 40, 'Osmanlı', null, null, 'node/1786762169', null),
  ('koza-hani', 'monument', 40.184379, 29.063538, 50, 'Osmanlı', null, 'Q6055245', 'relation/1018973', null),
  ('bursa-ataturk-aniti', 'monument', 40.182595, 29.066882, 60, 'Cumhuriyet', 1931, 'Q61072912', 'node/1786760959', null),
  ('iznik-dikilitas', 'monument', 40.487571, 29.701932, 60, 'Antik', null, 'Q21524994', 'node/3775569054', null),
  ('emir-han', 'monument', 40.184506, 29.062328, 40, 'Osmanlı', null, null, 'relation/3392362', null),
  ('bursa-kapalicarsi', 'monument', 40.185173, 29.062025, 200, 'Osmanlı', null, 'Q139436543', null, null),
  ('irgandi-koprusu', 'monument', 40.181950, 29.070830, 50, 'Osmanlı', null, 'Q6026873', null, null),
  ('tuz-han-bursa', 'monument', 40.184477, 29.065732, 30, 'Osmanlı', null, 'Q132752814', 'relation/17033935', null),
  ('geyve-han', 'monument', 40.185147, 29.062999, 30, 'Osmanlı', null, null, 'relation/3417195', null),
  ('iznik-konsil', 'archaeological_site', 40.425818, 29.710483, 150, 'Bizans', null, 'Q133331', 'node/13388465316', null),
  ('iznik-roma-tiyatrosu', 'archaeological_site', 40.426642, 29.716907, 150, 'Antik', null, 'Q118929560', 'relation/16554896', 'SRID=4326;POLYGON((29.716595 40.426817, 29.716384 40.426850, 29.716367 40.426786, 29.716364 40.426707, 29.716390 40.426610, 29.716451 40.426510, 29.716503 40.426459, 29.716580 40.426405, 29.716671 40.426363, 29.716775 40.426334, 29.716869 40.426324, 29.716963 40.426323, 29.717089 40.426348, 29.717197 40.426384, 29.717282 40.426431, 29.717337 40.426481, 29.717389 40.426546, 29.717432 40.426625, 29.717448 40.426691, 29.717450 40.426768, 29.717446 40.426811, 29.717430 40.426853, 29.717202 40.426806, 29.717083 40.426784, 29.717097 40.426738, 29.717090 40.426693, 29.717062 40.426651, 29.717017 40.426619, 29.716961 40.426600, 29.716899 40.426597, 29.716864 40.426603, 29.716810 40.426625, 29.716769 40.426660, 29.716746 40.426704, 29.716744 40.426750, 29.716760 40.426793, 29.716595 40.426817))'),
  ('aktopraklik-hoyugu', 'archaeological_site', 40.173633, 28.770857, 150, 'Antik', null, 'Q6099398', 'way/234158577', 'SRID=4326;POLYGON((28.769896 40.173812, 28.770178 40.172712, 28.770433 40.172533, 28.771054 40.172606, 28.771665 40.172825, 28.771777 40.173170, 28.771766 40.173572, 28.771575 40.174088, 28.771107 40.174648, 28.770619 40.174705, 28.770225 40.174607, 28.769987 40.174319, 28.769896 40.173812))'),
  ('hisar-arkeopark', 'archaeological_site', 40.183651, 29.053657, 150, 'Bizans', null, null, 'way/1009347298', 'SRID=4326;POLYGON((29.053254 40.183460, 29.053681 40.183250, 29.054125 40.183268, 29.054201 40.183689, 29.054212 40.183884, 29.053843 40.183921, 29.053760 40.183637, 29.053525 40.183706, 29.053591 40.183870, 29.053414 40.183898, 29.053369 40.183669, 29.053308 40.183683, 29.053254 40.183526, 29.053254 40.183460))'),
  ('antik-tiyatro', 'archaeological_site', 40.169718, 28.682594, 60, 'Antik', null, null, 'node/12888452002', null),
  ('yesil-turbe', 'tomb', 40.181412, 29.074882, 60, 'Osmanlı', 1421, 'Q8053362', 'way/254313386', null),
  ('osman-gazi-turbesi', 'tomb', 40.186774, 29.057323, 40, 'Osmanlı', null, 'Q83100', 'way/325992025', null),
  ('hacivat-karagoz-anit-mezari', 'tomb', 40.202118, 29.027248, 60, 'Cumhuriyet', null, null, 'node/13362217961', null),
  ('orhan-gazi-turbesi', 'tomb', 40.186771, 29.057694, 40, 'Osmanlı', null, null, 'way/325992024', null),
  ('sehzade-mustafa-turbesi', 'tomb', 40.190398, 29.045771, 20, 'Osmanlı', null, 'Q20587092', 'node/2796344232', null),
  ('cem-sultan-turbesi', 'tomb', 40.190555, 29.045630, 20, 'Osmanlı', null, null, 'node/2796344231', null),
  ('ebe-gulbahar-hatun-turbesi', 'tomb', 40.190582, 29.045450, 20, 'Osmanlı', null, null, 'node/2796344525', null),
  ('emirsultan-hz-turbesi', 'tomb', 40.181373, 29.080921, 30, 'Osmanlı', null, null, 'way/385004428', null),
  ('gulruh-hatun-turbesi', 'tomb', 40.190647, 29.045407, 20, 'Osmanlı', null, null, 'node/2796344230', null),
  ('gulsah-hatun-turbesi', 'tomb', 40.190252, 29.045627, 20, 'Osmanlı', null, null, 'node/2796344233', null),
  ('huma-hatun-turbesi', 'tomb', 40.190802, 29.047015, 20, 'Osmanlı', null, null, 'node/2796344236', null),
  ('cumalikizik', 'village', 40.175058, 29.171904, 300, 'Osmanlı', null, 'Q6021244', null, null),
  ('golyazi-adasi', 'village', 40.165599, 28.677950, 400, null, null, null, 'way/330917299', null),
  ('misi', 'village', 40.179120, 28.970390, 400, 'Osmanlı', null, 'Q31189684', null, null),
  ('tirilye', 'village', 40.392349, 28.794702, 400, 'Osmanlı', null, 'Q131902682', null, null),
  ('zeyniller-koyu-seyir-tepesi', 'viewpoint', 40.165424, 29.111122, 50, null, null, null, 'node/5534516422', null),
  ('uludag', 'hill', 40.070529, 29.222010, 500, null, null, 'Q925688', 'node/440642722', null),
  ('uludag-milli-parki', 'forest', 40.108492, 29.185995, 500, null, null, 'Q6094187', 'way/126629460', 'SRID=4326;POLYGON((29.063259 40.121417, 29.069147 40.117684, 29.071875 40.113072, 29.073885 40.107471, 29.077906 40.106592, 29.080347 40.102748, 29.085660 40.099234, 29.084511 40.094511, 29.088675 40.093961, 29.089249 40.089018, 29.091690 40.086821, 29.098296 40.086052, 29.113803 40.086931, 29.131771 40.088680, 29.139766 40.088700, 29.146259 40.088999, 29.150602 40.087940, 29.158839 40.085994, 29.166645 40.085900, 29.171123 40.085595, 29.175404 40.087151, 29.187465 40.086931, 29.195794 40.080779, 29.205845 40.080889, 29.212450 40.080119, 29.215896 40.074846, 29.222932 40.072868, 29.224799 40.069022, 29.232697 40.067483, 29.236574 40.066055, 29.241025 40.062099, 29.249497 40.058912, 29.254953 40.056494, 29.262994 40.055065, 29.268451 40.055395, 29.274338 40.058472, 29.280943 40.061329, 29.289989 40.062428, 29.297743 40.059571, 29.308656 40.064187, 29.304492 40.067593, 29.313395 40.071989, 29.319138 40.081438, 29.317415 40.086382, 29.318133 40.092753, 29.310092 40.093632, 29.301907 40.089897, 29.296020 40.094950, 29.288410 40.098794, 29.281374 40.105055, 29.272040 40.108899, 29.274625 40.116586, 29.272471 40.119221, 29.262994 40.115158, 29.252943 40.114719, 29.246481 40.128664, 29.231404 40.114170, 29.228102 40.106263, 29.226809 40.119880, 29.221640 40.124601, 29.211445 40.119221, 29.206276 40.122845, 29.198378 40.130640, 29.201394 40.137776, 29.201968 40.142057, 29.195219 40.138873, 29.185312 40.135909, 29.176265 40.130091, 29.168081 40.143374, 29.164491 40.150179, 29.165783 40.160276, 29.158173 40.161373, 29.158891 40.166750, 29.155014 40.168396, 29.141516 40.157752, 29.135773 40.163348, 29.129886 40.166531, 29.123280 40.167299, 29.118542 40.164884, 29.118072 40.160664, 29.112942 40.154898, 29.104901 40.148423, 29.094562 40.144581, 29.087957 40.148972, 29.087526 40.152813, 29.072018 40.153033, 29.074316 40.147435, 29.071077 40.141548, 29.070295 40.136897, 29.063977 40.126139, 29.063259 40.121417))'),
  ('karacabey-longoz-ormanlari', 'forest', 40.378165, 28.431531, 500, null, null, 'Q105838485', 'relation/17861535', 'SRID=4326;POLYGON((28.389718 40.391820, 28.399196 40.381661, 28.408689 40.372350, 28.419582 40.366215, 28.421422 40.368393, 28.425198 40.367874, 28.428551 40.367363, 28.431544 40.366546, 28.434763 40.367220, 28.437295 40.366485, 28.440127 40.365234, 28.443233 40.365111, 28.446017 40.364923, 28.449274 40.364339, 28.451827 40.363174, 28.454847 40.363493, 28.462653 40.363554, 28.465818 40.364098, 28.470876 40.366517, 28.464492 40.365536, 28.458323 40.364359, 28.453560 40.364690, 28.450508 40.365148, 28.450293 40.366730, 28.448099 40.367874, 28.449113 40.366787, 28.447825 40.366305, 28.446983 40.368455, 28.445197 40.368912, 28.441935 40.369203, 28.440412 40.368921, 28.438438 40.368561, 28.439639 40.369566, 28.436726 40.369991, 28.435257 40.369865, 28.434602 40.369158, 28.433116 40.368688, 28.436463 40.367789, 28.432682 40.367972, 28.429678 40.368222, 28.431614 40.367731, 28.429855 40.367110, 28.426861 40.367674, 28.427119 40.368042, 28.425230 40.369051, 28.425627 40.369452, 28.423514 40.370555, 28.426883 40.370780, 28.428916 40.370147, 28.431952 40.370114, 28.433577 40.370249, 28.431850 40.370682, 28.429645 40.371553, 28.426684 40.371986, 28.423369 40.373155, 28.421663 40.374238, 28.420993 40.375120, 28.419040 40.374205, 28.419410 40.375431, 28.420032 40.375950, 28.421009 40.376910, 28.421164 40.378304, 28.423299 40.378819, 28.420697 40.378860, 28.420435 40.380114, 28.421309 40.380723, 28.421979 40.382595, 28.420644 40.382680, 28.418664 40.383044, 28.420531 40.383886, 28.422285 40.383919, 28.424233 40.383984, 28.426593 40.383669, 28.424689 40.384237, 28.422763 40.384903, 28.419512 40.385140, 28.416545 40.385512, 28.415124 40.385602, 28.418637 40.385627, 28.422516 40.385332, 28.420907 40.385659, 28.418037 40.385982, 28.414909 40.386129, 28.413123 40.386591, 28.410843 40.386897, 28.412399 40.387163, 28.417801 40.387400, 28.420703 40.387702, 28.423396 40.387473, 28.426196 40.386730, 28.428803 40.386938, 28.431362 40.386301, 28.432188 40.385958, 28.434114 40.385385, 28.436968 40.385071, 28.434173 40.385553, 28.433138 40.386068, 28.434522 40.386133, 28.436313 40.386105, 28.439317 40.385876, 28.441941 40.386056, 28.442638 40.386117, 28.443866 40.386207, 28.446881 40.386011, 28.449129 40.386926, 28.446136 40.387453, 28.442675 40.387506, 28.440594 40.387743, 28.442407 40.388184, 28.443547 40.388270, 28.444655 40.388589, 28.448319 40.388491, 28.450094 40.388201, 28.452369 40.389108, 28.456119 40.389516, 28.459402 40.389856, 28.462636 40.390252, 28.464230 40.391257, 28.467507 40.392013, 28.463892 40.391670, 28.462846 40.390644, 28.459112 40.390133, 28.460882 40.391114, 28.457234 40.390321, 28.453404 40.389937, 28.450234 40.389288, 28.448474 40.389181, 28.446077 40.389022, 28.442552 40.389046, 28.438845 40.389026, 28.435562 40.389042, 28.432295 40.389165, 28.428937 40.389541, 28.426228 40.389308, 28.423090 40.389239, 28.423825 40.388119, 28.417607 40.389206, 28.414786 40.390260, 28.413466 40.390673, 28.410360 40.390803, 28.406879 40.390734, 28.403746 40.391600, 28.400484 40.392274, 28.398070 40.392675, 28.394551 40.392838, 28.391676 40.393239, 28.390431 40.392331, 28.389718 40.391820))'),
  ('sadagi-kanyonu-tabiat-parki', 'forest', 39.867015, 28.911235, 500, null, null, null, 'way/431791573', 'SRID=4326;POLYGON((28.903430 39.868786, 28.904157 39.866239, 28.905497 39.864641, 28.906763 39.863725, 28.907170 39.862518, 28.908437 39.861926, 28.908684 39.860340, 28.910038 39.859882, 28.911547 39.859418, 28.914625 39.859502, 28.917584 39.861261, 28.917126 39.863300, 28.917693 39.864496, 28.916529 39.865032, 28.916747 39.865903, 28.916980 39.867009, 28.916180 39.869478, 28.914113 39.870126, 28.911042 39.869936, 28.914069 39.873254, 28.912759 39.876605, 28.910067 39.876571, 28.909543 39.875175, 28.909266 39.873846, 28.906413 39.872617, 28.905657 39.870807, 28.903430 39.868786))'),
  ('uluabat-golu-sulak-alani', 'forest', 40.165260, 28.590293, 500, null, null, 'Q108228823', 'relation/1715013', 'SRID=4326;POLYGON((28.443229 40.205048, 28.443553 40.202606, 28.446068 40.201509, 28.452422 40.194192, 28.461259 40.184865, 28.468572 40.182248, 28.475587 40.180219, 28.483899 40.177597, 28.490144 40.175111, 28.493107 40.172058, 28.494166 40.170333, 28.499313 40.158101, 28.501090 40.154636, 28.504792 40.151209, 28.507801 40.148587, 28.510284 40.146577, 28.520487 40.137891, 28.524065 40.136807, 28.530526 40.135992, 28.536838 40.135294, 28.540283 40.135652, 28.544341 40.135886, 28.548851 40.135115, 28.554266 40.134543, 28.561530 40.127995, 28.561719 40.123649, 28.563286 40.116579, 28.563591 40.110976, 28.565321 40.108994, 28.568144 40.107843, 28.571621 40.107450, 28.574711 40.107024, 28.576988 40.107070, 28.579523 40.107477, 28.582263 40.108150, 28.585355 40.108837, 28.588030 40.109914, 28.590853 40.110451, 28.594184 40.111749, 28.598144 40.113211, 28.599149 40.114465, 28.603583 40.114826, 28.606473 40.114344, 28.608235 40.114876, 28.611515 40.113775, 28.612732 40.112375, 28.615602 40.113161, 28.618942 40.113767, 28.622149 40.114030, 28.624312 40.112886, 28.627884 40.112720, 28.631313 40.113920, 28.633626 40.115481, 28.636296 40.116288, 28.640589 40.118051, 28.645600 40.123065, 28.664308 40.126758, 28.667433 40.128741, 28.673739 40.132495, 28.678262 40.134607, 28.681152 40.135161, 28.683590 40.136642, 28.685836 40.138452, 28.689296 40.139803, 28.689867 40.141657, 28.693809 40.144230, 28.694868 40.145568, 28.694215 40.147478, 28.694484 40.149259, 28.697327 40.150888, 28.700189 40.151307, 28.702478 40.152790, 28.705917 40.154832, 28.709599 40.155008, 28.714749 40.154836, 28.719193 40.157419, 28.720674 40.159605, 28.722034 40.161140, 28.724825 40.164631, 28.728490 40.165075, 28.731680 40.166544, 28.735245 40.168968, 28.735762 40.170572, 28.734669 40.173371, 28.737358 40.178199, 28.733888 40.187428, 28.729190 40.189687, 28.724315 40.190950, 28.720796 40.193767, 28.716410 40.196539, 28.713706 40.197500, 28.710930 40.196639, 28.707181 40.197482, 28.701322 40.199488, 28.697958 40.199115, 28.691990 40.198741, 28.686495 40.199455, 28.683409 40.200210, 28.679467 40.200786, 28.672712 40.200999, 28.669034 40.199459, 28.663871 40.200263, 28.660823 40.201554, 28.657702 40.200869, 28.653006 40.199689, 28.647256 40.203130, 28.642727 40.206382, 28.638939 40.207107, 28.633475 40.208145, 28.626968 40.208275, 28.618154 40.210395, 28.612934 40.210314, 28.605386 40.209038, 28.597936 40.208046, 28.594116 40.208501, 28.588179 40.210330, 28.584147 40.211422, 28.577781 40.213314, 28.571738 40.214529, 28.562479 40.215902, 28.558582 40.215859, 28.547378 40.215433, 28.543416 40.215899, 28.536494 40.217661, 28.526162 40.219257, 28.518324 40.220627, 28.512128 40.221342, 28.507394 40.221096, 28.500965 40.219164, 28.495354 40.220235, 28.490251 40.220992, 28.474731 40.221364, 28.470730 40.221856, 28.461716 40.223141, 28.455339 40.223587, 28.447223 40.215289, 28.443860 40.207671, 28.443229 40.205048))'),
  ('resat-oyal-kultur-parki', 'park', 40.195926, 29.044125, 200, null, null, 'Q6040463', 'way/26434141', 'SRID=4326;POLYGON((29.038756 40.197121, 29.039317 40.196613, 29.039958 40.196298, 29.039880 40.196039, 29.039697 40.195915, 29.039906 40.195748, 29.040096 40.195853, 29.040420 40.195559, 29.040193 40.195362, 29.040649 40.194837, 29.041301 40.194280, 29.042271 40.193808, 29.043233 40.193496, 29.044339 40.193158, 29.046028 40.192602, 29.046758 40.192283, 29.046949 40.192281, 29.047109 40.192233, 29.047259 40.192152, 29.047345 40.192039, 29.047691 40.192082, 29.047493 40.192436, 29.047096 40.192621, 29.047364 40.192914, 29.047171 40.193037, 29.047107 40.193151, 29.047352 40.193972, 29.047164 40.194646, 29.047207 40.194922, 29.047314 40.195621, 29.047327 40.195762, 29.047198 40.195836, 29.047262 40.196918, 29.046693 40.197057, 29.046849 40.197528, 29.047407 40.197425, 29.047482 40.197441, 29.047681 40.197913, 29.047930 40.197845, 29.048005 40.197989, 29.047756 40.198102, 29.046038 40.198633, 29.045560 40.198875, 29.045034 40.199068, 29.044362 40.199259, 29.043940 40.199159, 29.043512 40.199050, 29.042710 40.198989, 29.041832 40.199004, 29.039670 40.199047, 29.039810 40.198203, 29.039820 40.198012, 29.039798 40.197798, 29.039727 40.197605, 29.039393 40.197436, 29.038983 40.197411, 29.038943 40.197339, 29.038756 40.197121))'),
  ('merinos-parki', 'park', 40.198785, 29.053346, 200, null, null, 'Q20472214', 'way/189723143', 'SRID=4326;POLYGON((29.048870 40.200705, 29.049032 40.199128, 29.049074 40.198701, 29.049007 40.198695, 29.049066 40.198216, 29.049955 40.197832, 29.050872 40.197519, 29.051876 40.197173, 29.052050 40.197323, 29.052095 40.197362, 29.052294 40.197357, 29.052335 40.197319, 29.052494 40.197144, 29.052751 40.197108, 29.053017 40.197105, 29.053571 40.197127, 29.053843 40.197180, 29.054369 40.197272, 29.054632 40.197308, 29.054911 40.197321, 29.055389 40.197294, 29.055864 40.197333, 29.056050 40.197368, 29.056164 40.197440, 29.056501 40.197485, 29.056483 40.197805, 29.056410 40.197882, 29.056366 40.197953, 29.056368 40.198029, 29.056431 40.198136, 29.056493 40.198191, 29.056571 40.198218, 29.056743 40.198237, 29.056894 40.198298, 29.057097 40.199014, 29.057455 40.199181, 29.057363 40.199955, 29.056728 40.200023, 29.054654 40.200243, 29.054116 40.200285, 29.053506 40.200204, 29.053314 40.200249, 29.053171 40.200282, 29.052825 40.200494, 29.052790 40.200522, 29.051717 40.201029, 29.050553 40.201450, 29.050176 40.201482, 29.049803 40.201471, 29.049599 40.201461, 29.049425 40.201422, 29.049224 40.201268, 29.048972 40.200978, 29.048870 40.200705))'),
  ('mudanya-sahili', 'beach', 40.370904, 28.893924, 150, null, null, null, 'node/6710803286', null),
  ('kursunlu-plaji', 'beach', 40.396710, 28.293817, 150, null, null, null, 'relation/10458771', 'SRID=4326;POLYGON((28.290079 40.397982, 28.290106 40.397246, 28.292209 40.396527, 28.292906 40.395964, 28.295787 40.395437, 28.297554 40.396009, 28.296734 40.396072, 28.295311 40.396327, 28.294521 40.396411, 28.293245 40.396668, 28.292484 40.396830, 28.291577 40.397143, 28.291117 40.397339, 28.290582 40.397551, 28.290230 40.397791, 28.290079 40.397982))'),
  ('gemlik-kursunlu-plaji', 'beach', 40.363300, 29.031000, 700, null, null, null, null, null),
  ('suuctu-selalesi', 'waterfall', 39.900550, 28.384244, 100, null, null, 'Q6018935', 'node/2560346643', null),
  ('saitabat-selalesi', 'waterfall', 40.147434, 29.224991, 100, null, null, null, 'node/1791443208', null),
  ('oylat-selalesi', 'waterfall', 39.919066, 29.584115, 100, null, null, null, 'node/939087952', null)
) v(slug, category, lat, lng, radius, period, built_year, wikidata_id, osm_id, area_wkt)
join public.cities ci on ci.slug = 'bursa'
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
  ('bursa-ulu-camii', 'tr', 'Bursa Ulu Camii', 'Yıldırım Bayezid''in 1399''da tamamlattığı, 20 kubbeli dev cami; içindeki şadırvan ve hat yazılarıyla ünlü.', null),
  ('bursa-ulu-camii', 'en', 'Bursa Grand Mosque', 'The great twenty-domed mosque completed under Bayezid I in 1399, famous for its indoor fountain and calligraphy.', null),
  ('ayasofya-camii-iznik', 'tr', 'İznik Ayasofya Camii', 'İznik''in merkezinde, 787''de II. İznik Konsili''nin toplandığı Bizans kilisesi; bugün cami.', null),
  ('ayasofya-camii-iznik', 'en', 'Hagia Sophia, İznik', 'The Byzantine church in the centre of İznik where the Second Council of Nicaea met in 787; now a mosque.', null),
  ('emir-sultan-camii', 'tr', 'Emir Sultan Camii', 'Yıldırım Bayezid''in damadı Emir Sultan adına yapılan, Bursa''nın en çok ziyaret edilen camilerinden.', null),
  ('emir-sultan-camii', 'en', 'Emir Sultan Mosque', 'Built in the name of Emir Sultan, son-in-law of Bayezid I; one of Bursa''s most visited mosques.', null),
  ('orhan-gazi-camii', 'tr', 'Orhan Gazi Camii', 'Bursa''nın merkezinde, Orhan Gazi''nin 1339''da yaptırdığı erken Osmanlı camisi.', null),
  ('orhan-gazi-camii', 'en', 'Orhan Gazi Mosque', 'An early Ottoman mosque in the centre of Bursa, built by Orhan Gazi in 1339.', null),
  ('iznik-yesil-cami', 'tr', 'İznik Yeşil Cami', 'İznik''te 14. yüzyılda yapılan, minaresindeki çinilerle ünlü erken Osmanlı camisi.', null),
  ('iznik-yesil-cami', 'en', 'Yeşil Mosque Iznik', 'A 14th-century early Ottoman mosque in İznik, famous for the tiles on its minaret.', null),
  ('fatih-camii-tirilye', 'tr', 'Tirilye Fatih Camii', 'Tirilye''de, Bizans döneminde kilise olarak yapılan ve sonradan camiye çevrilen yapı.', null),
  ('fatih-camii-tirilye', 'en', 'Fatih Mosque, Tirilye', 'A building in Tirilye, built as a Byzantine church and later converted into a mosque.', null),
  ('veled-i-yanic-cami', 'tr', 'Veled-i Yaniç Cami', 'Bursa''da, Bizans kilisesinden dönüştürülen küçük cami.', null),
  ('veled-i-yanic-cami', 'en', 'Veled-i Yaniç Mosque', 'A small mosque in Bursa converted from a Byzantine church.', null),
  ('yildirim-camii', 'tr', 'Yıldırım Camii', 'Yıldırım Bayezid''in kurduğu külliyenin camisi; ters T planlı erken Osmanlı mimarisinin güzel örneği.', null),
  ('yildirim-camii', 'en', 'Bayezid I Mosque', 'The mosque of the complex founded by Bayezid I, a fine example of the early Ottoman ''inverted T'' plan.', null),
  ('bursa-muradiye-camii', 'tr', 'Muradiye Külliyesi', 'II. Murad''ın kurduğu külliye; caminin bahçesinde şehzadelerin ve sultan ailesinin türbeleri bulunur.', null),
  ('bursa-muradiye-camii', 'en', 'Muradiye Complex', 'The complex founded by Murad II; the mosque garden holds the tombs of princes and the sultan''s family.', null),
  ('yesil-camii', 'tr', 'Yeşil Camii', 'Çelebi Mehmed''in 1419''da yaptırdığı, içi yeşil ve mavi çinilerle kaplı, Bursa''nın simgesi olan cami.', null),
  ('yesil-camii', 'en', 'Green Mosque', 'Built by Mehmed I in 1419, its interior lined with green and blue tiles; a symbol of Bursa.', null),
  ('eski-camii-golyazi', 'tr', 'Gölyazı Eski Camii', 'Gölyazı''da, köyün tarihi camisi.', null),
  ('eski-camii-golyazi', 'en', 'Old Mosque, Gölyazı', 'The old historic mosque of the village of Gölyazı.', null),
  ('kemerli-kilise-tirilye', 'tr', 'Kemerli Kilise', 'Tirilye''de, Bizans dönemine ait Panagia Pantobasilissa Kilisesi; köyün en eski yapılarından.', null),
  ('kemerli-kilise-tirilye', 'en', 'Panagia Pantobasilissa Church', 'The Byzantine Church of Panagia Pantobasilissa in Tirilye, one of the village''s oldest buildings.', null),
  ('aziz-panteleimon-kilisesi', 'tr', 'Aziz Panteleimon Kilisesi', 'Gölyazı''da, 19. yüzyılda yapılan Rum Ortodoks kilisesi.', null),
  ('aziz-panteleimon-kilisesi', 'en', 'St. Panteleimon Church', 'A 19th-century Greek Orthodox church in Gölyazı.', null),
  ('mayor-sinagogu', 'tr', 'Mayor Sinagogu', 'Bursa''nın tarihi Yahudi mahallesinde, şehirde bugün de açık olan sinagog.', null),
  ('mayor-sinagogu', 'en', 'Mayor Synagogue', 'A synagogue in Bursa''s historic Jewish quarter that is still in use today.', null),
  ('bursa-arkeoloji-muzesi', 'tr', 'Bursa Arkeoloji Müzesi', 'Kültürpark''ta, Bursa ve çevresindeki antik kentlerden çıkan eserleri sergileyen müze.', null),
  ('bursa-arkeoloji-muzesi', 'en', 'Bursa Archaeological Museum', 'A museum in Kültürpark showing finds from the ancient cities around Bursa.', null),
  ('bursa-ataturk-muzesi', 'tr', 'Bursa Atatürk Müzesi', 'Çekirge''de, Atatürk''ün Bursa ziyaretlerinde kaldığı köşk; bugün müze.', null),
  ('bursa-ataturk-muzesi', 'en', 'Bursa Atatürk Museum', 'The mansion in Çekirge where Atatürk stayed on his visits to Bursa; now a museum.', null),
  ('mudanya-mutareke-evi', 'tr', 'Mudanya Mütareke Evi', 'Mudanya''da, 1922''de Mudanya Ateşkesi''nin imzalandığı ev; bugün müze.', null),
  ('mudanya-mutareke-evi', 'en', 'Mudanya Armistice House', 'The house in Mudanya where the Armistice of Mudanya was signed in 1922; now a museum.', null),
  ('iznik-muzesi', 'tr', 'İznik Müzesi', 'İznik''te, 14. yüzyıldan kalma Nilüfer Hatun İmareti''nde açılan; çini ve arkeoloji eserleri sergilenen müze.', null),
  ('iznik-muzesi', 'en', 'İznik Museum', 'A museum in İznik housed in the 14th-century Nilüfer Hatun soup kitchen, showing tiles and archaeological finds.', null),
  ('bursa-kent-muzesi', 'tr', 'Bursa Kent Müzesi', 'Heykel''de, eski adliye binasında Bursa''nın tarihini ve zanaatlarını anlatan müze.', null),
  ('bursa-kent-muzesi', 'en', 'Bursa City Museum', 'A museum in the old courthouse at Heykel telling the history and crafts of Bursa.', null),
  ('uluumay-osmanli-halk-kiyafetleri-ve-takilari-muzesi', 'tr', 'Uluumay Osmanlı Halk Kıyafetleri ve Takıları Müzesi', 'Muradiye''de, Osmanlı halk kıyafetleri ve takılarını sergileyen müze.', null),
  ('uluumay-osmanli-halk-kiyafetleri-ve-takilari-muzesi', 'en', 'Ulumay Museum of Ottoman Folk Costumes & Jewellery', 'A museum in Muradiye displaying Ottoman folk costumes and jewellery.', null),
  ('panorama-1326-bursa-fetih-muzesi', 'tr', 'Panorama 1326 Bursa Fetih Müzesi', 'Tophane''de, Bursa''nın 1326''da fethini 360 derecelik panorama resimle anlatan müze.', null),
  ('panorama-1326-bursa-fetih-muzesi', 'en', 'Panorama 1326 Conquest Museum', 'A museum in Tophane telling the 1326 conquest of Bursa with a 360-degree panoramic painting.', null),
  ('merinos-tekstil-sanayi-muzesi', 'tr', 'Merinos Tekstil Sanayi Müzesi', 'Merinos Parkı''nda, eski Merinos fabrikasında Bursa''nın tekstil tarihini anlatan müze.', null),
  ('merinos-tekstil-sanayi-muzesi', 'en', 'Merinos Textile Industry Museum', 'A museum in the old Merinos factory telling the history of Bursa''s textile industry.', null),
  ('tofas-anadolu-araclari-muzesi', 'tr', 'Tofaş Anadolu Arabaları Müzesi', 'Bursa''da, eski bir ipek fabrikasında Türkiye''de üretilmiş otomobil ve araçların sergilendiği müze.', null),
  ('tofas-anadolu-araclari-muzesi', 'en', 'Tofaş Museum of Anatolian Carriages and Cars', 'A museum in a former silk factory in Bursa showing cars and vehicles made in Turkey.', null),
  ('17-yuzyil-osmanli-evi-muzesi', 'tr', '17. Yüzyıl Osmanlı Evi Müzesi', 'Muradiye''de, 17. yüzyıldan kalma ahşap Osmanlı evi; dönemin ev yaşamını gösteriyor.', null),
  ('17-yuzyil-osmanli-evi-muzesi', 'en', '17th-Century Ottoman House Museum', 'A 17th-century wooden Ottoman house in Muradiye showing domestic life of the period.', null),
  ('cumalikizik-etnografya-muzesi', 'tr', 'Cumalıkızık Etnografya Müzesi', 'Cumalıkızık''ta, köyün eşyalarının ve gündelik yaşamının sergilendiği küçük müze.', null),
  ('cumalikizik-etnografya-muzesi', 'en', 'Cumalıkızık Ethnography Museum', 'A small museum in Cumalıkızık showing the village''s objects and everyday life.', null),
  ('karagoz-muzesi', 'tr', 'Karagöz Müzesi', 'Çekirge''de, Karagöz ve Hacivat gölge oyununa ait figürleri ve perdeleri sergileyen müze.', null),
  ('karagoz-muzesi', 'en', 'Karagöz Museum', 'A museum in Çekirge showing the figures and screens of the Karagöz and Hacivat shadow play.', null),
  ('merinos-enerji-muzesi', 'tr', 'Merinos Enerji Müzesi', 'Merinos Parkı''nda, fabrikanın eski enerji santralinde açılan müze.', null),
  ('merinos-enerji-muzesi', 'en', 'Merinos Energy Museum', 'A museum in the old power plant of the Merinos factory.', null),
  ('iznik-surlari', 'tr', 'İznik Surları', 'Antik Nikaia''yı çevreleyen, kapılarıyla büyük ölçüde ayakta kalan Roma ve Bizans surları.', null),
  ('iznik-surlari', 'en', 'Walls of Nicaea', 'The Roman and Byzantine walls that encircle ancient Nicaea, with gates largely still standing.', null),
  ('tophane-saat-kulesi', 'tr', 'Tophane Saat Kulesi', 'Tophane''de, Osman Gazi ve Orhan Gazi türbelerinin yanında yükselen 19. yüzyıl saat kulesi.', 'Gün batımı'),
  ('tophane-saat-kulesi', 'en', 'Tophane Clock Tower', 'A 19th-century clock tower in Tophane, next to the tombs of Osman and Orhan Gazi.', 'Sunset'),
  ('koza-hani', 'tr', 'Koza Hanı', 'II. Bayezid döneminde yapılan, ipek kozası ticaretinin merkezi olan han; avlusundaki küçük mescitle ünlü.', null),
  ('koza-hani', 'en', 'Koza Han', 'An inn built under Bayezid II, centre of the silk cocoon trade, famous for the small mosque in its courtyard.', null),
  ('bursa-ataturk-aniti', 'tr', 'Bursa Atatürk Anıtı', 'Heykel meydanında, 1931''de dikilen Atatürk Anıtı.', null),
  ('bursa-ataturk-aniti', 'en', 'Ataturk statue, Bursa', 'The Atatürk Monument on Heykel square, erected in 1931.', null),
  ('iznik-dikilitas', 'tr', 'Dikilitaş (İznik)', 'İznik yakınında, Roma döneminden kalan anıt mezar; Beştaş olarak da bilinir.', null),
  ('iznik-dikilitas', 'en', 'Obelisk of Gaius Cassius Philiscus', 'A Roman funerary monument near İznik, also known as Beştaş.', null),
  ('emir-han', 'tr', 'Emir Han', 'Ulu Cami''nin yanında, Orhan Gazi döneminde yapılan tarihi han.', null),
  ('emir-han', 'en', 'Emir Han', 'A historic inn next to the Great Mosque, built under Orhan Gazi.', null),
  ('bursa-kapalicarsi', 'tr', 'Bursa Kapalıçarşı ve Bedesten', 'Yıldırım Bayezid''in yaptırdığı Bedesten çevresinde gelişen, Bursa''nın hanlarla dolu tarihi çarşısı.', null),
  ('bursa-kapalicarsi', 'en', 'Bursa Grand Bazaar', 'Bursa''s historic bazaar, grown around the covered market built by Bayezid I and filled with old inns.', null),
  ('irgandi-koprusu', 'tr', 'Irgandı Köprüsü', 'Gökdere üzerinde, iki yanında dükkânların sıralandığı 15. yüzyıl köprüsü.', null),
  ('irgandi-koprusu', 'en', 'Irgandı Bridge', 'A 15th-century bridge over the Gökdere stream, lined with shops on both sides.', null),
  ('tuz-han-bursa', 'tr', 'Tuz Hanı', 'Kapalıçarşı''da, tuz ticaretinin yapıldığı tarihi han.', null),
  ('tuz-han-bursa', 'en', 'Tuz Han', 'A historic inn in the bazaar where salt was traded.', null),
  ('geyve-han', 'tr', 'Geyve Han', 'Kapalıçarşı''da, Osmanlı döneminden kalma tarihi han.', null),
  ('geyve-han', 'en', 'Geyve Han', 'A historic Ottoman inn in the bazaar.', null),
  ('iznik-konsil', 'tr', 'İznik Göl Bazilikası', 'İznik Gölü''nde, kıyıya yakın sulara gömülü Bizans bazilikası; sular çekildiğinde görülebiliyor.', null),
  ('iznik-konsil', 'en', 'Submerged Basilica of Nicaea', 'A Byzantine basilica submerged in Lake İznik close to the shore, visible when the water is low.', null),
  ('iznik-roma-tiyatrosu', 'tr', 'İznik Roma Tiyatrosu', 'İznik''te, Roma döneminde yapılan büyük tiyatronun kalıntıları.', null),
  ('iznik-roma-tiyatrosu', 'en', 'Roman theater at Helikore/Nicaea', 'Remains of the large Roman theatre in İznik.', null),
  ('aktopraklik-hoyugu', 'tr', 'Aktopraklık Höyüğü', 'Akçalar''da, 8.500 yıllık yerleşimin kazıldığı ve arkeopark olarak gezilebilen höyük.', null),
  ('aktopraklik-hoyugu', 'en', 'Aktopraklık Mound', 'A mound at Akçalar where an 8,500-year-old settlement was excavated, open as an archaeopark.', null),
  ('hisar-arkeopark', 'tr', 'Hisar Arkeopark', 'Bursa Kalesi''nin içinde, Bizans dönemi kalıntılarının sergilendiği açık hava alanı.', null),
  ('hisar-arkeopark', 'en', 'Hisar Archaeopark', 'An open-air site inside Bursa''s citadel displaying Byzantine-era remains.', null),
  ('antik-tiyatro', 'tr', 'Apollonia Antik Tiyatrosu', 'Gölyazı''da, antik Apollonia kentinin tiyatrosunun kalıntıları.', null),
  ('antik-tiyatro', 'en', 'Ancient Theatre of Apollonia', 'Remains of the theatre of the ancient city of Apollonia at Gölyazı.', null),
  ('yesil-turbe', 'tr', 'Yeşil Türbe', 'Çelebi Mehmed''in türbesi; dışı turkuaz çinilerle kaplı, Bursa''nın en tanınan yapılarından.', null),
  ('yesil-turbe', 'en', 'Green Tomb', 'The tomb of Mehmed I, clad in turquoise tiles; one of Bursa''s best-known buildings.', null),
  ('osman-gazi-turbesi', 'tr', 'Osman Gazi Türbesi', 'Tophane''de, Osmanlı Devleti''nin kurucusu Osman Gazi''nin türbesi.', null),
  ('osman-gazi-turbesi', 'en', 'Tomb of Osman I', 'The tomb of Osman Gazi, founder of the Ottoman state, in Tophane.', null),
  ('hacivat-karagoz-anit-mezari', 'tr', 'Hacivat ve Karagöz Anıt Mezarı', 'Çekirge''de, gölge oyununun kahramanları Hacivat ve Karagöz''e adanan anıt mezar.', null),
  ('hacivat-karagoz-anit-mezari', 'en', 'Tomb of Hacivat and Karagöz', 'A memorial tomb in Çekirge dedicated to Hacivat and Karagöz, heroes of the shadow play.', null),
  ('orhan-gazi-turbesi', 'tr', 'Orhan Gazi Türbesi', 'Tophane''de, Osmanlı''nın ikinci padişahı Orhan Gazi''nin türbesi.', null),
  ('orhan-gazi-turbesi', 'en', 'Tomb of Orhan', 'The tomb of Orhan Gazi, the second Ottoman sultan, in Tophane.', null),
  ('sehzade-mustafa-turbesi', 'tr', 'Şehzade Mustafa Türbesi', 'Muradiye''de, Kanuni''nin oğlu Şehzade Mustafa''nın çinilerle süslü türbesi.', null),
  ('sehzade-mustafa-turbesi', 'en', 'Türbe of Şehzade Mustafa', 'The tiled tomb of Prince Mustafa, son of Suleiman the Magnificent, in Muradiye.', null),
  ('cem-sultan-turbesi', 'tr', 'Cem Sultan Türbesi', 'Muradiye''de, Fatih''in oğlu Cem Sultan''ın türbesi; içi zengin kalem işleriyle süslü.', null),
  ('cem-sultan-turbesi', 'en', 'Tomb of Cem Sultan', 'The tomb of Prince Cem, son of Mehmed the Conqueror, in Muradiye, richly painted inside.', null),
  ('ebe-gulbahar-hatun-turbesi', 'tr', 'Gülbahar Hatun Türbesi', 'Muradiye''de, Gülbahar Hatun''un (Ebe Hatun) türbesi.', null),
  ('ebe-gulbahar-hatun-turbesi', 'en', 'Tomb of Gülbahar Hatun', 'The tomb of Gülbahar Hatun (Ebe Hatun) in Muradiye.', null),
  ('emirsultan-hz-turbesi', 'tr', 'Emir Sultan Türbesi', 'Emir Sultan Camii''nin yanında, Emir Sultan''ın türbesi.', null),
  ('emirsultan-hz-turbesi', 'en', 'Tomb of Emir Sultan', 'The tomb of Emir Sultan beside his mosque.', null),
  ('gulruh-hatun-turbesi', 'tr', 'Gülruh Hatun Türbesi', 'Muradiye''de, Gülruh Hatun''un türbesi.', null),
  ('gulruh-hatun-turbesi', 'en', 'Tomb of Gülruh Hatun', 'The tomb of Gülruh Hatun in Muradiye.', null),
  ('gulsah-hatun-turbesi', 'tr', 'Gülşah Hatun Türbesi', 'Muradiye''de, Gülşah Hatun''un türbesi.', null),
  ('gulsah-hatun-turbesi', 'en', 'Tomb of Gülşah Hatun', 'The tomb of Gülşah Hatun in Muradiye.', null),
  ('huma-hatun-turbesi', 'tr', 'Hüma Hatun Türbesi', 'Muradiye''de, Fatih Sultan Mehmed''in annesi Hüma Hatun''un türbesi.', null),
  ('huma-hatun-turbesi', 'en', 'Tomb of Hüma Hatun', 'The tomb of Hüma Hatun, mother of Mehmed the Conqueror, in Muradiye.', null),
  ('cumalikizik', 'tr', 'Cumalıkızık', 'Uludağ eteğinde, erken Osmanlı döneminden kalan, UNESCO listesindeki tarihi köy.', null),
  ('cumalikizik', 'en', 'Cumalıkızık', 'A historic village on the slopes of Uludağ dating from the early Ottoman period, on the UNESCO list.', null),
  ('golyazi-adasi', 'tr', 'Gölyazı', 'Uluabat Gölü''nde bir yarımada üzerindeki balıkçı köyü; antik Apollonia''nın yerinde, leylekleriyle ünlü.', 'Gün batımı'),
  ('golyazi-adasi', 'en', 'Gölyazı', 'A fishing village on a peninsula in Lake Uluabat, on the site of ancient Apollonia and known for its storks.', 'Sunset'),
  ('misi', 'tr', 'Misi (Gümüştepe)', 'Nilüfer Çayı kıyısında, taş evleri ve yemekleriyle bilinen eski köy (Gümüştepe).', null),
  ('misi', 'en', 'Misi', 'An old village on the Nilüfer stream known for its stone houses and food (Gümüştepe).', null),
  ('tirilye', 'tr', 'Tirilye', 'Mudanya yakınında, taş evleri ve Bizans dönemi yapılarıyla eski bir Rum köyü.', null),
  ('tirilye', 'en', 'Tirilye', 'A former Greek village near Mudanya with stone houses and Byzantine-era buildings.', null),
  ('zeyniller-koyu-seyir-tepesi', 'tr', 'Zeyniller Seyir Tepesi', 'Uludağ''ın eteğinde, Bursa ovasına ve şehre bakan seyir tepesi.', 'Gün batımı'),
  ('zeyniller-koyu-seyir-tepesi', 'en', 'Zeyniller Viewpoint', 'A viewpoint on the slopes of Uludağ overlooking the city and the Bursa plain.', 'Sunset'),
  ('uludag', 'tr', 'Uludağ', 'Marmara Bölgesi''nin en yüksek dağı; kışın kayak, yazın yürüyüş için gidilen zirve.', 'Kış (kayak), yaz (yürüyüş)'),
  ('uludag', 'en', 'Uludağ', 'The highest mountain in the Marmara region, a destination for skiing in winter and hiking in summer.', 'Winter (skiing), summer (hiking)'),
  ('uludag-milli-parki', 'tr', 'Uludağ Millî Parkı', 'Uludağ''ın ormanlarını, göllerini ve zirve bölgesini koruyan milli park.', 'Yaz ve kış'),
  ('uludag-milli-parki', 'en', 'Uludağ National Park', 'The national park protecting the forests, lakes and summit area of Uludağ.', 'Summer and winter'),
  ('karacabey-longoz-ormanlari', 'tr', 'Karacabey Longoz Ormanları', 'Karacabey''de, Kocaçay deltasında sular altında kalan nadir subasar ormanı.', 'İlkbahar'),
  ('karacabey-longoz-ormanlari', 'en', 'Karacabey Floodplain Forest', 'A rare floodplain forest in the Kocaçay delta near Karacabey.', 'Spring'),
  ('sadagi-kanyonu-tabiat-parki', 'tr', 'Sadağı Kanyonu Tabiat Parkı', 'Orhaneli''de, derin kanyonu ve yürüyüş yollarıyla tabiat parkı.', 'İlkbahar ve sonbahar'),
  ('sadagi-kanyonu-tabiat-parki', 'en', 'Canyon of Sadağı Naturel Park', 'A nature park in Orhaneli with a deep canyon and hiking paths.', 'Spring and autumn'),
  ('uluabat-golu-sulak-alani', 'tr', 'Uluabat Gölü Sulak Alanı', 'Uluabat Gölü ve çevresi; nilüferleri ve kuşlarıyla korunan sulak alan.', 'İlkbahar (kuş göçü)'),
  ('uluabat-golu-sulak-alani', 'en', 'Lake Uluabat Wetland', 'Lake Uluabat and its shores, a protected wetland known for water lilies and birds.', 'Spring (bird migration)'),
  ('resat-oyal-kultur-parki', 'tr', 'Reşat Oyal Kültür Parkı', 'Şehrin merkezinde, Arkeoloji Müzesi''nin de bulunduğu büyük kültür parkı.', null),
  ('resat-oyal-kultur-parki', 'en', 'Reşat Oyal Cultural Park', 'The large culture park in the city centre that also contains the Archaeology Museum.', null),
  ('merinos-parki', 'tr', 'Merinos Parkı', 'Eski Merinos fabrikasının çevresinde, müzeleri ve geniş yeşil alanlarıyla şehir parkı.', null),
  ('merinos-parki', 'en', 'Merinos Park', 'A city park around the old Merinos factory with museums and wide green spaces.', null),
  ('mudanya-sahili', 'tr', 'Mudanya Sahili', 'Mudanya''nın tarihi evlerinin sıralandığı deniz kıyısı.', 'Gün batımı'),
  ('mudanya-sahili', 'en', 'Mudanya Seafront', 'The seafront of Mudanya lined with historic houses.', 'Sunset'),
  ('kursunlu-plaji', 'tr', 'Kurşunlu Plajı (Karacabey)', 'Karacabey''de, Kurşunlu''daki uzun kumsallı halk plajı.', 'Yaz'),
  ('kursunlu-plaji', 'en', 'Kurşunlu Beach (Karacabey)', 'A long sandy public beach at Kurşunlu, Karacabey.', 'Summer'),
  ('gemlik-kursunlu-plaji', 'tr', 'Kurşunlu Halk Plajı (Gemlik)', 'Gemlik Körfezi kıyısında, ormanın gölgesindeki 3,5 km''lik ücretsiz halk plajı.', 'Yaz'),
  ('gemlik-kursunlu-plaji', 'en', 'Kurşunlu Public Beach (Gemlik)', 'A free 3.5 km public beach on the Gulf of Gemlik, shaded by woodland.', 'Summer'),
  ('suuctu-selalesi', 'tr', 'Suuçtu Şelalesi', 'Mustafakemalpaşa''da, ormanın içinde yüksekten dökülen şelale.', 'İlkbahar (su bol)'),
  ('suuctu-selalesi', 'en', 'Suuçtu (Waterfly) Waterfall', 'A tall waterfall in the forest near Mustafakemalpaşa.', 'Spring (most water)'),
  ('saitabat-selalesi', 'tr', 'Saitabat Şelalesi', 'Uludağ yolunda, Saitabat köyü yakınında şelale ve mesire yeri.', 'İlkbahar (su bol)'),
  ('saitabat-selalesi', 'en', 'Saitabat Waterfall', 'A waterfall and picnic spot near the village of Saitabat on the road to Uludağ.', 'Spring (most water)'),
  ('oylat-selalesi', 'tr', 'Oylat Şelalesi', 'İnegöl''de, Oylat kaplıcalarına yakın orman içindeki şelale.', 'İlkbahar (su bol)'),
  ('oylat-selalesi', 'en', 'Oylat Waterfall', 'A waterfall in the forest near the Oylat hot springs in İnegöl.', 'Spring (most water)')
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
  ('antik-tiyatro', 'golyazi-adasi'),
  ('aziz-panteleimon-kilisesi', 'golyazi-adasi'),
  ('cem-sultan-turbesi', 'bursa-muradiye-camii'),
  ('cumalikizik-etnografya-muzesi', 'cumalikizik'),
  ('ebe-gulbahar-hatun-turbesi', 'bursa-muradiye-camii'),
  ('emir-han', 'bursa-kapalicarsi'),
  ('emirsultan-hz-turbesi', 'emir-sultan-camii'),
  ('eski-camii-golyazi', 'golyazi-adasi'),
  ('fatih-camii-tirilye', 'tirilye'),
  ('geyve-han', 'bursa-kapalicarsi'),
  ('gulruh-hatun-turbesi', 'bursa-muradiye-camii'),
  ('gulsah-hatun-turbesi', 'bursa-muradiye-camii'),
  ('huma-hatun-turbesi', 'bursa-muradiye-camii'),
  ('kemerli-kilise-tirilye', 'tirilye'),
  ('koza-hani', 'bursa-kapalicarsi'),
  ('merinos-enerji-muzesi', 'merinos-parki'),
  ('merinos-tekstil-sanayi-muzesi', 'merinos-parki'),
  ('sehzade-mustafa-turbesi', 'bursa-muradiye-camii'),
  ('tuz-han-bursa', 'bursa-kapalicarsi')
) v(child, parent)
join public.places pp on pp.slug = v.parent
where c.slug = v.child;

-- Keşif rozetleri: ana yer ve içindeki yerlerin hepsi --------------------------------
insert into public.achievements (slug, rule, sort_order) values
  ('bursa-kapalicarsi-kesif', '{"type": "place_set", "places": ["bursa-kapalicarsi", "emir-han", "geyve-han", "koza-hani", "tuz-han-bursa"]}'::jsonb, 100),
  ('bursa-muradiye-camii-kesif', '{"type": "place_set", "places": ["bursa-muradiye-camii", "cem-sultan-turbesi", "ebe-gulbahar-hatun-turbesi", "gulruh-hatun-turbesi", "gulsah-hatun-turbesi", "huma-hatun-turbesi", "sehzade-mustafa-turbesi"]}'::jsonb, 101),
  ('golyazi-adasi-kesif', '{"type": "place_set", "places": ["golyazi-adasi", "antik-tiyatro", "aziz-panteleimon-kilisesi", "eski-camii-golyazi"]}'::jsonb, 102),
  ('merinos-parki-kesif', '{"type": "place_set", "places": ["merinos-parki", "merinos-enerji-muzesi", "merinos-tekstil-sanayi-muzesi"]}'::jsonb, 103),
  ('tirilye-kesif', '{"type": "place_set", "places": ["tirilye", "fatih-camii-tirilye", "kemerli-kilise-tirilye"]}'::jsonb, 104)
on conflict (slug) do update set rule = excluded.rule;

insert into public.achievement_translations (achievement_id, lang, name, description)
select a.id, v.lang, v.name, v.description
from (values
  ('bursa-kapalicarsi-kesif', 'tr', 'Bursa Kapalıçarşı ve Bedesten Kâşifi', 'Bursa Kapalıçarşı ve Bedesten ve içindeki 4 yerin hepsini gez.'),
  ('bursa-kapalicarsi-kesif', 'en', 'Bursa Grand Bazaar Explorer', 'Visit Bursa Grand Bazaar and all 4 places inside it.'),
  ('bursa-muradiye-camii-kesif', 'tr', 'Muradiye Külliyesi Kâşifi', 'Muradiye Külliyesi ve içindeki 6 yerin hepsini gez.'),
  ('bursa-muradiye-camii-kesif', 'en', 'Muradiye Complex Explorer', 'Visit Muradiye Complex and all 6 places inside it.'),
  ('golyazi-adasi-kesif', 'tr', 'Gölyazı Kâşifi', 'Gölyazı ve içindeki 3 yerin hepsini gez.'),
  ('golyazi-adasi-kesif', 'en', 'Gölyazı Explorer', 'Visit Gölyazı and all 3 places inside it.'),
  ('merinos-parki-kesif', 'tr', 'Merinos Parkı Kâşifi', 'Merinos Parkı ve içindeki 2 yerin hepsini gez.'),
  ('merinos-parki-kesif', 'en', 'Merinos Park Explorer', 'Visit Merinos Park and all 2 places inside it.'),
  ('tirilye-kesif', 'tr', 'Tirilye Kâşifi', 'Tirilye ve içindeki 2 yerin hepsini gez.'),
  ('tirilye-kesif', 'en', 'Tirilye Explorer', 'Visit Tirilye and all 2 places inside it.')
) v(slug, lang, name, description)
join public.achievements a on a.slug = v.slug
on conflict (achievement_id, lang) do update set name = excluded.name, description = excluded.description;

-- Bursa fotoğrafları: Wikimedia Commons, serbest lisanslı (61 yer).
-- Üreten: data-pipeline/content/build_city.py (kaynak: data-pipeline/results/bursa/photos.json).
-- Mobil, fotoğrafın altında author ve license bilgisini göstermelidir (lisans koşulu).

delete from public.place_photos ph
using public.places p
where ph.place_id = p.id
  and ph.url like 'https://%.wikimedia.org/%'
  and p.slug in ('aktopraklik-hoyugu', 'antik-tiyatro', 'ayasofya-camii-iznik', 'aziz-panteleimon-kilisesi', 'bursa-arkeoloji-muzesi', 'bursa-ataturk-aniti', 'bursa-ataturk-muzesi', 'bursa-kapalicarsi', 'bursa-kent-muzesi', 'bursa-muradiye-camii', 'bursa-ulu-camii', 'cem-sultan-turbesi', 'cumalikizik', 'ebe-gulbahar-hatun-turbesi', 'emir-han', 'emir-sultan-camii', 'emirsultan-hz-turbesi', 'eski-camii-golyazi', 'fatih-camii-tirilye', 'gemlik-kursunlu-plaji', 'geyve-han', 'golyazi-adasi', 'gulruh-hatun-turbesi', 'gulsah-hatun-turbesi', 'hisar-arkeopark', 'huma-hatun-turbesi', 'irgandi-koprusu', 'iznik-dikilitas', 'iznik-konsil', 'iznik-muzesi', 'iznik-roma-tiyatrosu', 'iznik-surlari', 'iznik-yesil-cami', 'karacabey-longoz-ormanlari', 'karagoz-muzesi', 'kemerli-kilise-tirilye', 'koza-hani', 'mayor-sinagogu', 'merinos-parki', 'misi', 'mudanya-mutareke-evi', 'orhan-gazi-camii', 'orhan-gazi-turbesi', 'osman-gazi-turbesi', 'panorama-1326-bursa-fetih-muzesi', 'resat-oyal-kultur-parki', 'sadagi-kanyonu-tabiat-parki', 'sehzade-mustafa-turbesi', 'suuctu-selalesi', 'tirilye', 'tophane-saat-kulesi', 'tuz-han-bursa', 'uluabat-golu-sulak-alani', 'uludag', 'uludag-milli-parki', 'uluumay-osmanli-halk-kiyafetleri-ve-takilari-muzesi', 'veled-i-yanic-cami', 'yesil-camii', 'yesil-turbe', 'yildirim-camii', 'zeyniller-koyu-seyir-tepesi');

insert into public.place_photos
  (place_id, url, thumb_url, width, height, license, license_url, author, source_url, sort_order)
select p.id, v.url, v.thumb_url, v.width::int, v.height::int, v.license, v.license_url, v.author, v.source_url, 0
from (values
  ('aktopraklik-hoyugu', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/9/96/Aktopraklk_Hy_2026-05-23_14.43.10_1782249226.jpeg/1280px-Aktopraklk_Hy_2026-05-23_14.43.10_1782249226.jpeg', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/9/96/Aktopraklk_Hy_2026-05-23_14.43.10_1782249226.jpeg/500px-Aktopraklk_Hy_2026-05-23_14.43.10_1782249226.jpeg', 1280, 960, 'CC BY-SA 4.0', 'https://creativecommons.org/licenses/by-sa/4.0', 'Aerdemsenturk', 'https://commons.wikimedia.org/wiki/File:Aktopraklk_Hy_2026-05-23_14.43.10_1782249226.jpeg'),
  ('antik-tiyatro', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/e/e7/Apollonia_Ad_Rhyndacum_2025-09-03_17-23-00.jpg/1280px-Apollonia_Ad_Rhyndacum_2025-09-03_17-23-00.jpg', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/e/e7/Apollonia_Ad_Rhyndacum_2025-09-03_17-23-00.jpg/500px-Apollonia_Ad_Rhyndacum_2025-09-03_17-23-00.jpg', 1280, 576, 'CC BY-SA 4.0', 'https://creativecommons.org/licenses/by-sa/4.0', 'Özgür Arda BAYRAM', 'https://commons.wikimedia.org/wiki/File:Apollonia_Ad_Rhyndacum_2025-09-03_17-23-00.jpg'),
  ('ayasofya-camii-iznik', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/f/f0/Iznik%2C_aya_sofia%2C_esterno_01.jpg/1280px-Iznik%2C_aya_sofia%2C_esterno_01.jpg', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/f/f0/Iznik%2C_aya_sofia%2C_esterno_01.jpg/500px-Iznik%2C_aya_sofia%2C_esterno_01.jpg', 1280, 800, 'CC BY-SA 4.0', 'https://creativecommons.org/licenses/by-sa/4.0', 'Francesco Bini', 'https://commons.wikimedia.org/wiki/File:Iznik,_aya_sofia,_esterno_01.jpg'),
  ('aziz-panteleimon-kilisesi', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/1/11/Aziz_Panteleimon_Kilisesi_02.jpg/1280px-Aziz_Panteleimon_Kilisesi_02.jpg', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/1/11/Aziz_Panteleimon_Kilisesi_02.jpg/500px-Aziz_Panteleimon_Kilisesi_02.jpg', 1280, 960, 'CC BY-SA 4.0', 'https://creativecommons.org/licenses/by-sa/4.0', 'Sadrettin', 'https://commons.wikimedia.org/wiki/File:Aziz_Panteleimon_Kilisesi_02.jpg'),
  ('bursa-arkeoloji-muzesi', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/9/9f/Bursa_Arkeoloji_M%C3%BCzesi_%283%29.jpg/1280px-Bursa_Arkeoloji_M%C3%BCzesi_%283%29.jpg', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/9/9f/Bursa_Arkeoloji_M%C3%BCzesi_%283%29.jpg/500px-Bursa_Arkeoloji_M%C3%BCzesi_%283%29.jpg', 1280, 853, 'CC BY-SA 4.0', 'https://creativecommons.org/licenses/by-sa/4.0', 'Canercangul', 'https://commons.wikimedia.org/wiki/File:Bursa_Arkeoloji_M%C3%BCzesi_(3).jpg'),
  ('bursa-ataturk-aniti', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/5/5a/ATAT%C3%9CRK_ANITI_-_panoramio.jpg/1280px-ATAT%C3%9CRK_ANITI_-_panoramio.jpg', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/5/5a/ATAT%C3%9CRK_ANITI_-_panoramio.jpg/500px-ATAT%C3%9CRK_ANITI_-_panoramio.jpg', 1280, 2276, 'CC BY 3.0', 'https://creativecommons.org/licenses/by/3.0', 'HALUK COMERTEL', 'https://commons.wikimedia.org/wiki/File:ATAT%C3%9CRK_ANITI_-_panoramio.jpg'),
  ('bursa-ataturk-muzesi', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/9/9f/Bursa_Atat%C3%BCrk_M%C3%BCzesi.JPG/1280px-Bursa_Atat%C3%BCrk_M%C3%BCzesi.JPG', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/9/9f/Bursa_Atat%C3%BCrk_M%C3%BCzesi.JPG/500px-Bursa_Atat%C3%BCrk_M%C3%BCzesi.JPG', 1280, 1707, 'CC BY 3.0', 'https://creativecommons.org/licenses/by/3.0', 'Ollios', 'https://commons.wikimedia.org/wiki/File:Bursa_Atat%C3%BCrk_M%C3%BCzesi.JPG'),
  ('bursa-kapalicarsi', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/a/ad/Bursa-kozahan-silk_bazaar_-_panoramio.jpg/1280px-Bursa-kozahan-silk_bazaar_-_panoramio.jpg', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/a/ad/Bursa-kozahan-silk_bazaar_-_panoramio.jpg/500px-Bursa-kozahan-silk_bazaar_-_panoramio.jpg', 1280, 960, 'CC BY 3.0', 'https://creativecommons.org/licenses/by/3.0', 'HALUK COMERTEL', 'https://commons.wikimedia.org/wiki/File:Bursa-kozahan-silk_bazaar_-_panoramio.jpg'),
  ('bursa-kent-muzesi', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/d/d7/ESK%C4%B0_ADL%C4%B0YE_-%C5%9EEH%C4%B0R_MUZES%C4%B0_-_panoramio.jpg/1280px-ESK%C4%B0_ADL%C4%B0YE_-%C5%9EEH%C4%B0R_MUZES%C4%B0_-_panoramio.jpg', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/d/d7/ESK%C4%B0_ADL%C4%B0YE_-%C5%9EEH%C4%B0R_MUZES%C4%B0_-_panoramio.jpg/500px-ESK%C4%B0_ADL%C4%B0YE_-%C5%9EEH%C4%B0R_MUZES%C4%B0_-_panoramio.jpg', 1280, 929, 'CC BY 3.0', 'https://creativecommons.org/licenses/by/3.0', 'HALUK COMERTEL', 'https://commons.wikimedia.org/wiki/File:ESK%C4%B0_ADL%C4%B0YE_-%C5%9EEH%C4%B0R_MUZES%C4%B0_-_panoramio.jpg'),
  ('bursa-muradiye-camii', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/4/49/Bursa_Muradiye_Mosque_Exterior_8037.jpg/1280px-Bursa_Muradiye_Mosque_Exterior_8037.jpg', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/4/49/Bursa_Muradiye_Mosque_Exterior_8037.jpg/500px-Bursa_Muradiye_Mosque_Exterior_8037.jpg', 1280, 852, 'CC BY-SA 4.0', 'https://creativecommons.org/licenses/by-sa/4.0', 'Dosseman', 'https://commons.wikimedia.org/wiki/File:Bursa_Muradiye_Mosque_Exterior_8037.jpg'),
  ('bursa-ulu-camii', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/1/19/71_Bursa_la_Grande_Moschea_%28Edited%29.jpg/1280px-71_Bursa_la_Grande_Moschea_%28Edited%29.jpg', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/1/19/71_Bursa_la_Grande_Moschea_%28Edited%29.jpg/500px-71_Bursa_la_Grande_Moschea_%28Edited%29.jpg', 1280, 943, 'CC BY-SA 4.0', 'https://creativecommons.org/licenses/by-sa/4.0', 'Beñat Irasuegi', 'https://commons.wikimedia.org/wiki/File:71_Bursa_la_Grande_Moschea_(Edited).jpg'),
  ('cem-sultan-turbesi', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/6/66/Cem_Sultan_tomb_7951.jpg/1280px-Cem_Sultan_tomb_7951.jpg', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/6/66/Cem_Sultan_tomb_7951.jpg/500px-Cem_Sultan_tomb_7951.jpg', 1280, 852, 'CC BY-SA 4.0', 'https://creativecommons.org/licenses/by-sa/4.0', 'Dosseman', 'https://commons.wikimedia.org/wiki/File:Cem_Sultan_tomb_7951.jpg'),
  ('cumalikizik', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/9/9d/Bursa_Cumal%C4%B1k%C4%B1z%C4%B1k_in_the_spring_2014_0145.jpg/1280px-Bursa_Cumal%C4%B1k%C4%B1z%C4%B1k_in_the_spring_2014_0145.jpg', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/9/9d/Bursa_Cumal%C4%B1k%C4%B1z%C4%B1k_in_the_spring_2014_0145.jpg/500px-Bursa_Cumal%C4%B1k%C4%B1z%C4%B1k_in_the_spring_2014_0145.jpg', 1280, 852, 'CC BY-SA 4.0', 'https://creativecommons.org/licenses/by-sa/4.0', 'Dosseman', 'https://commons.wikimedia.org/wiki/File:Bursa_Cumal%C4%B1k%C4%B1z%C4%B1k_in_the_spring_2014_0145.jpg'),
  ('ebe-gulbahar-hatun-turbesi', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/1/17/G%C3%9CLBAHAR_HATUN_T%C3%9CRBES%C4%B0_FAT%C4%B0H%C4%B0N_EBES%C4%B0_-_panoramio.jpg/1280px-G%C3%9CLBAHAR_HATUN_T%C3%9CRBES%C4%B0_FAT%C4%B0H%C4%B0N_EBES%C4%B0_-_panoramio.jpg', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/1/17/G%C3%9CLBAHAR_HATUN_T%C3%9CRBES%C4%B0_FAT%C4%B0H%C4%B0N_EBES%C4%B0_-_panoramio.jpg/500px-G%C3%9CLBAHAR_HATUN_T%C3%9CRBES%C4%B0_FAT%C4%B0H%C4%B0N_EBES%C4%B0_-_panoramio.jpg', 1280, 960, 'CC BY 3.0', 'https://creativecommons.org/licenses/by/3.0', 'Mustafa DUMAN', 'https://commons.wikimedia.org/wiki/File:G%C3%9CLBAHAR_HATUN_T%C3%9CRBES%C4%B0_FAT%C4%B0H%C4%B0N_EBES%C4%B0_-_panoramio.jpg'),
  ('emir-han', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/3/3b/Emir_Han.jpg/1280px-Emir_Han.jpg', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/3/3b/Emir_Han.jpg/500px-Emir_Han.jpg', 1280, 853, 'CC BY-SA 4.0', 'https://creativecommons.org/licenses/by-sa/4.0', 'Canercangul', 'https://commons.wikimedia.org/wiki/File:Emir_Han.jpg'),
  ('emir-sultan-camii', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/4/4b/Emir_Sultan_Camii_7067.jpg/1280px-Emir_Sultan_Camii_7067.jpg', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/4/4b/Emir_Sultan_Camii_7067.jpg/500px-Emir_Sultan_Camii_7067.jpg', 1280, 852, 'CC BY-SA 4.0', 'https://creativecommons.org/licenses/by-sa/4.0', 'Dosseman', 'https://commons.wikimedia.org/wiki/File:Emir_Sultan_Camii_7067.jpg'),
  ('emirsultan-hz-turbesi', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/e/e0/Bursa_Emir_Sultan_T%C3%BCrbesi_7095.jpg/1280px-Bursa_Emir_Sultan_T%C3%BCrbesi_7095.jpg', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/e/e0/Bursa_Emir_Sultan_T%C3%BCrbesi_7095.jpg/500px-Bursa_Emir_Sultan_T%C3%BCrbesi_7095.jpg', 1280, 852, 'CC BY-SA 4.0', 'https://creativecommons.org/licenses/by-sa/4.0', 'Dosseman', 'https://commons.wikimedia.org/wiki/File:Bursa_Emir_Sultan_T%C3%BCrbesi_7095.jpg'),
  ('eski-camii-golyazi', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/3/36/20251025_G%C3%B6lyaz%C4%B1_Eski_Cami.jpg/1280px-20251025_G%C3%B6lyaz%C4%B1_Eski_Cami.jpg', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/3/36/20251025_G%C3%B6lyaz%C4%B1_Eski_Cami.jpg/500px-20251025_G%C3%B6lyaz%C4%B1_Eski_Cami.jpg', 1280, 1280, 'CC BY-SA 4.0', 'https://creativecommons.org/licenses/by-sa/4.0', 'Basak', 'https://commons.wikimedia.org/wiki/File:20251025_G%C3%B6lyaz%C4%B1_Eski_Cami.jpg'),
  ('fatih-camii-tirilye', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/f/fa/Fatih_Cami.JPG/1280px-Fatih_Cami.JPG', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/f/fa/Fatih_Cami.JPG/500px-Fatih_Cami.JPG', 1280, 1707, 'CC BY-SA 3.0', 'https://creativecommons.org/licenses/by-sa/3.0', 'Ollios', 'https://commons.wikimedia.org/wiki/File:Fatih_Cami.JPG'),
  ('gemlik-kursunlu-plaji', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/5/5e/Kur%C5%9Funlu_Bal%C4%B1k%C3%A7%C4%B1_Bar%C4%B1na%C4%9F%C4%B1_-03_May%C4%B1s_2013_-_panoramio.jpg/1280px-Kur%C5%9Funlu_Bal%C4%B1k%C3%A7%C4%B1_Bar%C4%B1na%C4%9F%C4%B1_-03_May%C4%B1s_2013_-_panoramio.jpg', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/5/5e/Kur%C5%9Funlu_Bal%C4%B1k%C3%A7%C4%B1_Bar%C4%B1na%C4%9F%C4%B1_-03_May%C4%B1s_2013_-_panoramio.jpg/500px-Kur%C5%9Funlu_Bal%C4%B1k%C3%A7%C4%B1_Bar%C4%B1na%C4%9F%C4%B1_-03_May%C4%B1s_2013_-_panoramio.jpg', 1280, 765, 'CC BY 3.0', 'https://creativecommons.org/licenses/by/3.0', 'A. Kerim ŞENGEL', 'https://commons.wikimedia.org/wiki/File:Kur%C5%9Funlu_Bal%C4%B1k%C3%A7%C4%B1_Bar%C4%B1na%C4%9F%C4%B1_-03_May%C4%B1s_2013_-_panoramio.jpg'),
  ('geyve-han', 'https://upload.wikimedia.org/wikipedia/commons/8/81/Geyve_Hani.jpg', 'https://upload.wikimedia.org/wikipedia/commons/8/81/Geyve_Hani.jpg', 1280, 960, 'CC BY-SA 3.0', 'http://creativecommons.org/licenses/by-sa/3.0/', 'Ninlil at Turkish Wikipedia', 'https://commons.wikimedia.org/wiki/File:Geyve_Hani.jpg'),
  ('golyazi-adasi', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/7/71/G%C3%B6lyaz%C4%B1-1.JPG/1280px-G%C3%B6lyaz%C4%B1-1.JPG', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/7/71/G%C3%B6lyaz%C4%B1-1.JPG/500px-G%C3%B6lyaz%C4%B1-1.JPG', 1280, 1707, 'CC BY-SA 3.0', 'https://creativecommons.org/licenses/by-sa/3.0', 'Ollios', 'https://commons.wikimedia.org/wiki/File:G%C3%B6lyaz%C4%B1-1.JPG'),
  ('gulruh-hatun-turbesi', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/3/3b/G%C3%BClruh_Sultan_T%C3%BCrbesi_in_2003_0731.jpg/1280px-G%C3%BClruh_Sultan_T%C3%BCrbesi_in_2003_0731.jpg', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/3/3b/G%C3%BClruh_Sultan_T%C3%BCrbesi_in_2003_0731.jpg/500px-G%C3%BClruh_Sultan_T%C3%BCrbesi_in_2003_0731.jpg', 1280, 1707, 'CC BY-SA 4.0', 'https://creativecommons.org/licenses/by-sa/4.0', 'Dosseman', 'https://commons.wikimedia.org/wiki/File:G%C3%BClruh_Sultan_T%C3%BCrbesi_in_2003_0731.jpg'),
  ('gulsah-hatun-turbesi', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/d/d6/G%C3%9CL%C5%9EAH_HATUN_T%C3%9CRBES%C4%B0_FAT%C4%B0H%C4%B0N_ZEVCES%C4%B0_K%C3%9CNDEKAR%C4%B0_KAPISI_-_panoramio_%286%29.jpg/1280px-G%C3%9CL%C5%9EAH_HATUN_T%C3%9CRBES%C4%B0_FAT%C4%B0H%C4%B0N_ZEVCES%C4%B0_K%C3%9CNDEKAR%C4%B0_KAPISI_-_panoramio_%286%29.jpg', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/d/d6/G%C3%9CL%C5%9EAH_HATUN_T%C3%9CRBES%C4%B0_FAT%C4%B0H%C4%B0N_ZEVCES%C4%B0_K%C3%9CNDEKAR%C4%B0_KAPISI_-_panoramio_%286%29.jpg/500px-G%C3%9CL%C5%9EAH_HATUN_T%C3%9CRBES%C4%B0_FAT%C4%B0H%C4%B0N_ZEVCES%C4%B0_K%C3%9CNDEKAR%C4%B0_KAPISI_-_panoramio_%286%29.jpg', 1280, 1707, 'CC BY 3.0', 'https://creativecommons.org/licenses/by/3.0', 'Mustafa DUMAN', 'https://commons.wikimedia.org/wiki/File:G%C3%9CL%C5%9EAH_HATUN_T%C3%9CRBES%C4%B0_FAT%C4%B0H%C4%B0N_ZEVCES%C4%B0_K%C3%9CNDEKAR%C4%B0_KAPISI_-_panoramio_(6).jpg'),
  ('hisar-arkeopark', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/5/51/Hisar_Arkeopark_2026-08-26_15.30.54_1789595327.jpeg/1280px-Hisar_Arkeopark_2026-08-26_15.30.54_1789595327.jpeg', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/5/51/Hisar_Arkeopark_2026-08-26_15.30.54_1789595327.jpeg/500px-Hisar_Arkeopark_2026-08-26_15.30.54_1789595327.jpeg', 1280, 960, 'CC BY-SA 4.0', 'https://creativecommons.org/licenses/by-sa/4.0', 'Emirhan Sağdır', 'https://commons.wikimedia.org/wiki/File:Hisar_Arkeopark_2026-08-26_15.30.54_1789595327.jpeg'),
  ('huma-hatun-turbesi', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/7/7d/H%C3%BCma_Hatun_Turbesi_7895.jpg/1280px-H%C3%BCma_Hatun_Turbesi_7895.jpg', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/7/7d/H%C3%BCma_Hatun_Turbesi_7895.jpg/500px-H%C3%BCma_Hatun_Turbesi_7895.jpg', 1280, 1923, 'CC BY-SA 4.0', 'https://creativecommons.org/licenses/by-sa/4.0', 'Dosseman', 'https://commons.wikimedia.org/wiki/File:H%C3%BCma_Hatun_Turbesi_7895.jpg'),
  ('irgandi-koprusu', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/2/26/BURSA-IRGANDI_K%C3%96PR%C3%9CS%C3%9C_2007_-_panoramio.jpg/1280px-BURSA-IRGANDI_K%C3%96PR%C3%9CS%C3%9C_2007_-_panoramio.jpg', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/2/26/BURSA-IRGANDI_K%C3%96PR%C3%9CS%C3%9C_2007_-_panoramio.jpg/500px-BURSA-IRGANDI_K%C3%96PR%C3%9CS%C3%9C_2007_-_panoramio.jpg', 1280, 774, 'CC BY 3.0', 'https://creativecommons.org/licenses/by/3.0', 'HALUK COMERTEL', 'https://commons.wikimedia.org/wiki/File:BURSA-IRGANDI_K%C3%96PR%C3%9CS%C3%9C_2007_-_panoramio.jpg'),
  ('iznik-dikilitas', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/b/bc/Iznik_Obelisk_01.jpg/1280px-Iznik_Obelisk_01.jpg', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/b/bc/Iznik_Obelisk_01.jpg/500px-Iznik_Obelisk_01.jpg', 1280, 1707, 'CC BY-SA 4.0', 'https://creativecommons.org/licenses/by-sa/4.0', 'Kurmanbek', 'https://commons.wikimedia.org/wiki/File:Iznik_Obelisk_01.jpg'),
  ('iznik-konsil', 'https://upload.wikimedia.org/wikipedia/commons/d/dd/THE_FIRST_COUNCIL_OF_NICEA.jpg', 'https://upload.wikimedia.org/wikipedia/commons/d/dd/THE_FIRST_COUNCIL_OF_NICEA.jpg', 1280, 1661, 'Public domain', null, 'Originally uploaded by Coemgenus on en.wikipedia .', 'https://commons.wikimedia.org/wiki/File:THE_FIRST_COUNCIL_OF_NICEA.jpg'),
  ('iznik-muzesi', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/b/b5/%C4%B0znik_M%C3%BCzesi_20231030.jpg/1280px-%C4%B0znik_M%C3%BCzesi_20231030.jpg', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/b/b5/%C4%B0znik_M%C3%BCzesi_20231030.jpg/500px-%C4%B0znik_M%C3%BCzesi_20231030.jpg', 1280, 576, 'CC BY-SA 4.0', 'https://creativecommons.org/licenses/by-sa/4.0', 'Basak', 'https://commons.wikimedia.org/wiki/File:%C4%B0znik_M%C3%BCzesi_20231030.jpg'),
  ('iznik-roma-tiyatrosu', 'https://upload.wikimedia.org/wikipedia/commons/3/3f/%C4%B0znik_Roma_Tiyatrosu_.jpg', 'https://upload.wikimedia.org/wikipedia/commons/3/3f/%C4%B0znik_Roma_Tiyatrosu_.jpg', 1280, 853, 'CC BY-SA 4.0', 'https://creativecommons.org/licenses/by-sa/4.0', 'Yurdanurİznik', 'https://commons.wikimedia.org/wiki/File:%C4%B0znik_Roma_Tiyatrosu_.jpg'),
  ('iznik-surlari', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/f/f7/%C4%B0znik_%28Nicea%29_city_walls-Bursa_-_panoramio.jpg/1280px-%C4%B0znik_%28Nicea%29_city_walls-Bursa_-_panoramio.jpg', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/f/f7/%C4%B0znik_%28Nicea%29_city_walls-Bursa_-_panoramio.jpg/500px-%C4%B0znik_%28Nicea%29_city_walls-Bursa_-_panoramio.jpg', 1280, 827, 'CC BY 3.0', 'https://creativecommons.org/licenses/by/3.0', 'Haluk Comertel', 'https://commons.wikimedia.org/wiki/File:%C4%B0znik_(Nicea)_city_walls-Bursa_-_panoramio.jpg'),
  ('iznik-yesil-cami', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/3/35/%C4%B0znik_Ye%C5%9Fil_Cami.JPG/1280px-%C4%B0znik_Ye%C5%9Fil_Cami.JPG', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/3/35/%C4%B0znik_Ye%C5%9Fil_Cami.JPG/500px-%C4%B0znik_Ye%C5%9Fil_Cami.JPG', 1280, 1912, 'CC BY 2.5', 'https://creativecommons.org/licenses/by/2.5', 'Acar54', 'https://commons.wikimedia.org/wiki/File:%C4%B0znik_Ye%C5%9Fil_Cami.JPG'),
  ('karacabey-longoz-ormanlari', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/9/91/Karacabey_Longozu_-_Bahar.jpg/1280px-Karacabey_Longozu_-_Bahar.jpg', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/9/91/Karacabey_Longozu_-_Bahar.jpg/500px-Karacabey_Longozu_-_Bahar.jpg', 1280, 800, 'CC BY-SA 4.0', 'https://creativecommons.org/licenses/by-sa/4.0', 'Alpertuydes', 'https://commons.wikimedia.org/wiki/File:Karacabey_Longozu_-_Bahar.jpg'),
  ('karagoz-muzesi', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/0/07/Karag%C3%B6z_M%C3%BCzesi.jpg/1280px-Karag%C3%B6z_M%C3%BCzesi.jpg', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/0/07/Karag%C3%B6z_M%C3%BCzesi.jpg/500px-Karag%C3%B6z_M%C3%BCzesi.jpg', 1280, 853, 'CC BY-SA 4.0', 'https://creativecommons.org/licenses/by-sa/4.0', 'Canercangul', 'https://commons.wikimedia.org/wiki/File:Karag%C3%B6z_M%C3%BCzesi.jpg'),
  ('kemerli-kilise-tirilye', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/5/5b/Tirilye_%28Zeytinba%C4%9F%C4%B1%29_%2CBursa-Manast%C4%B1r.._-_panoramio.jpg/1280px-Tirilye_%28Zeytinba%C4%9F%C4%B1%29_%2CBursa-Manast%C4%B1r.._-_panoramio.jpg', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/5/5b/Tirilye_%28Zeytinba%C4%9F%C4%B1%29_%2CBursa-Manast%C4%B1r.._-_panoramio.jpg/500px-Tirilye_%28Zeytinba%C4%9F%C4%B1%29_%2CBursa-Manast%C4%B1r.._-_panoramio.jpg', 1280, 857, 'CC BY 3.0', 'https://creativecommons.org/licenses/by/3.0', 'HALUK COMERTEL', 'https://commons.wikimedia.org/wiki/File:Tirilye_(Zeytinba%C4%9F%C4%B1)_,Bursa-Manast%C4%B1r.._-_panoramio.jpg'),
  ('koza-hani', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/3/35/Kozahan_-silk_bazaar-Main_gate_-_panoramio.jpg/1280px-Kozahan_-silk_bazaar-Main_gate_-_panoramio.jpg', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/3/35/Kozahan_-silk_bazaar-Main_gate_-_panoramio.jpg/500px-Kozahan_-silk_bazaar-Main_gate_-_panoramio.jpg', 1280, 1585, 'CC BY 3.0', 'https://creativecommons.org/licenses/by/3.0', 'Haluk Comertel', 'https://commons.wikimedia.org/wiki/File:Kozahan_-silk_bazaar-Main_gate_-_panoramio.jpg'),
  ('mayor-sinagogu', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/1/17/Sinagogamayorbursa.jpg/1280px-Sinagogamayorbursa.jpg', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/1/17/Sinagogamayorbursa.jpg/500px-Sinagogamayorbursa.jpg', 1280, 720, 'CC BY-SA 4.0', 'https://creativecommons.org/licenses/by-sa/4.0', 'AdamAppel', 'https://commons.wikimedia.org/wiki/File:Sinagogamayorbursa.jpg'),
  ('merinos-parki', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/9/91/Merinosakmbursa2017.jpg/1280px-Merinosakmbursa2017.jpg', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/9/91/Merinosakmbursa2017.jpg/500px-Merinosakmbursa2017.jpg', 1280, 2276, 'CC BY-SA 3.0', 'https://creativecommons.org/licenses/by-sa/3.0', 'Basak', 'https://commons.wikimedia.org/wiki/File:Merinosakmbursa2017.jpg'),
  ('misi', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/f/f5/Misi_k%C3%B6y%C3%BC-g%C3%BCm%C3%BC%C5%9Ftepe_-_panoramio.jpg/1280px-Misi_k%C3%B6y%C3%BC-g%C3%BCm%C3%BC%C5%9Ftepe_-_panoramio.jpg', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/f/f5/Misi_k%C3%B6y%C3%BC-g%C3%BCm%C3%BC%C5%9Ftepe_-_panoramio.jpg/500px-Misi_k%C3%B6y%C3%BC-g%C3%BCm%C3%BC%C5%9Ftepe_-_panoramio.jpg', 1280, 720, 'CC BY 3.0', 'https://creativecommons.org/licenses/by/3.0', 'HALUK COMERTEL', 'https://commons.wikimedia.org/wiki/File:Misi_k%C3%B6y%C3%BC-g%C3%BCm%C3%BC%C5%9Ftepe_-_panoramio.jpg'),
  ('mudanya-mutareke-evi', 'https://upload.wikimedia.org/wikipedia/commons/b/b1/MudanyaM%C3%BCtareke2016.jpg', 'https://upload.wikimedia.org/wikipedia/commons/b/b1/MudanyaM%C3%BCtareke2016.jpg', 1280, 873, 'CC BY-SA 4.0', 'https://creativecommons.org/licenses/by-sa/4.0', 'Udoweier', 'https://commons.wikimedia.org/wiki/File:MudanyaM%C3%BCtareke2016.jpg'),
  ('orhan-gazi-camii', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/2/29/Bursa_Orhan_Gazi_Mosque.jpg/1280px-Bursa_Orhan_Gazi_Mosque.jpg', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/2/29/Bursa_Orhan_Gazi_Mosque.jpg/500px-Bursa_Orhan_Gazi_Mosque.jpg', 1280, 960, 'CC BY-SA 3.0', 'https://creativecommons.org/licenses/by-sa/3.0', 'Adbar', 'https://commons.wikimedia.org/wiki/File:Bursa_Orhan_Gazi_Mosque.jpg'),
  ('orhan-gazi-turbesi', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/7/72/ORHANGAZ%C4%B0_T%C3%9CRBES%C4%B0_BURSA_OSMANGAZ%C4%B0_-_panoramio.jpg/1280px-ORHANGAZ%C4%B0_T%C3%9CRBES%C4%B0_BURSA_OSMANGAZ%C4%B0_-_panoramio.jpg', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/7/72/ORHANGAZ%C4%B0_T%C3%9CRBES%C4%B0_BURSA_OSMANGAZ%C4%B0_-_panoramio.jpg/500px-ORHANGAZ%C4%B0_T%C3%9CRBES%C4%B0_BURSA_OSMANGAZ%C4%B0_-_panoramio.jpg', 1280, 966, 'CC BY 3.0', 'https://creativecommons.org/licenses/by/3.0', 'Mustafa DUMAN', 'https://commons.wikimedia.org/wiki/File:ORHANGAZ%C4%B0_T%C3%9CRBES%C4%B0_BURSA_OSMANGAZ%C4%B0_-_panoramio.jpg'),
  ('osman-gazi-turbesi', 'https://upload.wikimedia.org/wikipedia/commons/4/4a/I_Osman.jpg', 'https://upload.wikimedia.org/wikipedia/commons/4/4a/I_Osman.jpg', 1280, 2046, 'Public domain', null, 'Ottoman miniature painting', 'https://commons.wikimedia.org/wiki/File:I_Osman.jpg'),
  ('panorama-1326-bursa-fetih-muzesi', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/5/53/Bursa_Panorama_1326_Bursa_Conquest_Museum_2018_0039.jpg/1280px-Bursa_Panorama_1326_Bursa_Conquest_Museum_2018_0039.jpg', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/5/53/Bursa_Panorama_1326_Bursa_Conquest_Museum_2018_0039.jpg/500px-Bursa_Panorama_1326_Bursa_Conquest_Museum_2018_0039.jpg', 1280, 852, 'CC BY-SA 4.0', 'https://creativecommons.org/licenses/by-sa/4.0', 'Dosseman', 'https://commons.wikimedia.org/wiki/File:Bursa_Panorama_1326_Bursa_Conquest_Museum_2018_0039.jpg'),
  ('resat-oyal-kultur-parki', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/2/22/KulturParkBursa2017.jpg/1280px-KulturParkBursa2017.jpg', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/2/22/KulturParkBursa2017.jpg/500px-KulturParkBursa2017.jpg', 1280, 2276, 'CC BY-SA 4.0', 'https://creativecommons.org/licenses/by-sa/4.0', 'Basak', 'https://commons.wikimedia.org/wiki/File:KulturParkBursa2017.jpg'),
  ('sadagi-kanyonu-tabiat-parki', 'https://upload.wikimedia.org/wikipedia/commons/0/08/Sadagi.jpg', 'https://upload.wikimedia.org/wikipedia/commons/0/08/Sadagi.jpg', 1280, 2276, 'CC BY-SA 4.0', 'https://creativecommons.org/licenses/by-sa/4.0', 'Cagcagg', 'https://commons.wikimedia.org/wiki/File:Sadagi.jpg'),
  ('sehzade-mustafa-turbesi', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/f/f5/%C5%9Eehzade_Mustafa_T%C3%BCrbesi.jpg/1280px-%C5%9Eehzade_Mustafa_T%C3%BCrbesi.jpg', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/f/f5/%C5%9Eehzade_Mustafa_T%C3%BCrbesi.jpg/500px-%C5%9Eehzade_Mustafa_T%C3%BCrbesi.jpg', 1280, 1707, 'CC BY-SA 4.0', 'https://creativecommons.org/licenses/by-sa/4.0', 'Ibra~28', 'https://commons.wikimedia.org/wiki/File:%C5%9Eehzade_Mustafa_T%C3%BCrbesi.jpg'),
  ('suuctu-selalesi', 'https://upload.wikimedia.org/wikipedia/commons/9/94/Suu%C3%A7tu_Waterfall%2C_Mustafakemalpa%C5%9Fa.jpg', 'https://upload.wikimedia.org/wikipedia/commons/9/94/Suu%C3%A7tu_Waterfall%2C_Mustafakemalpa%C5%9Fa.jpg', 1280, 1684, 'Public domain', null, 'Ahmet Baris Isitan', 'https://commons.wikimedia.org/wiki/File:Suu%C3%A7tu_Waterfall,_Mustafakemalpa%C5%9Fa.jpg'),
  ('tirilye', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/c/c5/Tirilye_Tas_Mektep.jpg/1280px-Tirilye_Tas_Mektep.jpg', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/c/c5/Tirilye_Tas_Mektep.jpg/500px-Tirilye_Tas_Mektep.jpg', 1280, 720, 'CC BY-SA 4.0', 'https://creativecommons.org/licenses/by-sa/4.0', 'Samizambak', 'https://commons.wikimedia.org/wiki/File:Tirilye_Tas_Mektep.jpg'),
  ('tophane-saat-kulesi', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/1/1d/Clock_Tower%2C_Bursa.jpg/1280px-Clock_Tower%2C_Bursa.jpg', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/1/1d/Clock_Tower%2C_Bursa.jpg/500px-Clock_Tower%2C_Bursa.jpg', 1280, 1707, 'CC BY-SA 3.0', 'https://creativecommons.org/licenses/by-sa/3.0', 'User:Darwinek', 'https://commons.wikimedia.org/wiki/File:Clock_Tower,_Bursa.jpg'),
  ('tuz-han-bursa', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/6/69/Tuz_Han.jpg/1280px-Tuz_Han.jpg', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/6/69/Tuz_Han.jpg/500px-Tuz_Han.jpg', 1280, 1707, 'CC0', 'http://creativecommons.org/publicdomain/zero/1.0/deed.en', 'Aysegul.kocak', 'https://commons.wikimedia.org/wiki/File:Tuz_Han.jpg'),
  ('uluabat-golu-sulak-alani', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/0/09/Eskikaraa%C4%9Fa%C3%A7_Leylek_K%C3%B6y%C3%BC.jpg/1280px-Eskikaraa%C4%9Fa%C3%A7_Leylek_K%C3%B6y%C3%BC.jpg', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/0/09/Eskikaraa%C4%9Fa%C3%A7_Leylek_K%C3%B6y%C3%BC.jpg/500px-Eskikaraa%C4%9Fa%C3%A7_Leylek_K%C3%B6y%C3%BC.jpg', 1280, 800, 'CC BY-SA 4.0', 'https://creativecommons.org/licenses/by-sa/4.0', 'Alpertuydes', 'https://commons.wikimedia.org/wiki/File:Eskikaraa%C4%9Fa%C3%A7_Leylek_K%C3%B6y%C3%BC.jpg'),
  ('uludag', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/a/ab/Uludag.JPG/1280px-Uludag.JPG', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/a/ab/Uludag.JPG/500px-Uludag.JPG', 1280, 853, 'CC BY-SA 4.0', 'https://creativecommons.org/licenses/by-sa/4.0', 'Julian Nyča', 'https://commons.wikimedia.org/wiki/File:Uludag.JPG'),
  ('uludag-milli-parki', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/3/3f/Above_the_forest.jpg/1280px-Above_the_forest.jpg', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/3/3f/Above_the_forest.jpg/500px-Above_the_forest.jpg', 1280, 960, 'CC BY-SA 4.0', 'https://creativecommons.org/licenses/by-sa/4.0', 'Perseusfs', 'https://commons.wikimedia.org/wiki/File:Above_the_forest.jpg'),
  ('uluumay-osmanli-halk-kiyafetleri-ve-takilari-muzesi', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/a/a5/Bursa_Ulumay_museum_2006_0034.jpg/1280px-Bursa_Ulumay_museum_2006_0034.jpg', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/a/a5/Bursa_Ulumay_museum_2006_0034.jpg/500px-Bursa_Ulumay_museum_2006_0034.jpg', 1280, 850, 'CC BY-SA 4.0', 'https://creativecommons.org/licenses/by-sa/4.0', 'Dosseman', 'https://commons.wikimedia.org/wiki/File:Bursa_Ulumay_museum_2006_0034.jpg'),
  ('veled-i-yanic-cami', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/a/a3/Veledi_yani%C3%A7_kubbe_2.JPG/1280px-Veledi_yani%C3%A7_kubbe_2.JPG', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/a/a3/Veledi_yani%C3%A7_kubbe_2.JPG/500px-Veledi_yani%C3%A7_kubbe_2.JPG', 1280, 857, 'CC BY-SA 4.0', 'https://creativecommons.org/licenses/by-sa/4.0', 'Sait Can Kutsal', 'https://commons.wikimedia.org/wiki/File:Veledi_yani%C3%A7_kubbe_2.JPG'),
  ('yesil-camii', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/7/7d/Green_Mosque_in_Bursa.jpg/1280px-Green_Mosque_in_Bursa.jpg', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/7/7d/Green_Mosque_in_Bursa.jpg/500px-Green_Mosque_in_Bursa.jpg', 1280, 1179, 'Public domain', null, 'Brücke-Osteuropa', 'https://commons.wikimedia.org/wiki/File:Green_Mosque_in_Bursa.jpg'),
  ('yesil-turbe', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/2/26/Turkey-1353_%282216628788%29.jpg/1280px-Turkey-1353_%282216628788%29.jpg', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/2/26/Turkey-1353_%282216628788%29.jpg/500px-Turkey-1353_%282216628788%29.jpg', 1280, 1707, 'CC BY-SA 2.0', 'https://creativecommons.org/licenses/by-sa/2.0', 'Dennis G. Jarvis', 'https://commons.wikimedia.org/wiki/File:Turkey-1353_(2216628788).jpg'),
  ('yildirim-camii', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/2/2e/YILDIRIM%2CBEYAZIT%2CK%C3%9CLL%C4%B0YES%C4%B0%2CBURSA_-_panoramio_%286%29.jpg/1280px-YILDIRIM%2CBEYAZIT%2CK%C3%9CLL%C4%B0YES%C4%B0%2CBURSA_-_panoramio_%286%29.jpg', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/2/2e/YILDIRIM%2CBEYAZIT%2CK%C3%9CLL%C4%B0YES%C4%B0%2CBURSA_-_panoramio_%286%29.jpg/500px-YILDIRIM%2CBEYAZIT%2CK%C3%9CLL%C4%B0YES%C4%B0%2CBURSA_-_panoramio_%286%29.jpg', 1280, 960, 'CC BY 3.0', 'https://creativecommons.org/licenses/by/3.0', 'Mustafa DUMAN', 'https://commons.wikimedia.org/wiki/File:YILDIRIM,BEYAZIT,K%C3%9CLL%C4%B0YES%C4%B0,BURSA_-_panoramio_(6).jpg'),
  ('zeyniller-koyu-seyir-tepesi', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/5/59/Zeyniler_k%C3%B6y%C3%BC-Bursa_-_panoramio.jpg/1280px-Zeyniler_k%C3%B6y%C3%BC-Bursa_-_panoramio.jpg', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/5/59/Zeyniler_k%C3%B6y%C3%BC-Bursa_-_panoramio.jpg/500px-Zeyniler_k%C3%B6y%C3%BC-Bursa_-_panoramio.jpg', 1280, 858, 'CC BY 3.0', 'https://creativecommons.org/licenses/by/3.0', 'HALUK COMERTEL', 'https://commons.wikimedia.org/wiki/File:Zeyniler_k%C3%B6y%C3%BC-Bursa_-_panoramio.jpg')
) v(slug, url, thumb_url, width, height, license, license_url, author, source_url)
join public.places p on p.slug = v.slug;
