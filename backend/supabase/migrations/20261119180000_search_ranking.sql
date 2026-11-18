-- Arama sıralaması: "galata" aranınca önce Galata Kulesi gelsin.
-- 1) places.popularity: tanınırlık puanı (veri hattındaki "puan": Wikipedia/Wikidata bağlantı
--    sayısı vb.). Elle eklenen 13 yerde puan yoktu, tahmini değer verildi. Türbelerin puanı,
--    içinde yatan padişahın ününden şiştiği için 60 ile sınırlandı.
-- 2) search_norm(): Türkçe harfleri sadeleştirir; "kiz kulesi" de "Kız Kulesi"ni bulur.
-- 3) search_places sıralaması: tam eşleşme > adın başı > bir kelimenin başı > içinde geçen;
--    eşitlikte popularity, sonra ad. İmza ve dönen alanlar aynı (geriye uyumlu).

alter table public.places add column if not exists popularity smallint not null default 0;

update public.places p
set popularity = case when c.slug = 'tomb' then least(v.pop, 60) else v.pop end
from (values
  ('ayasofya', 106),
  ('sultanahmet-camii', 106),
  ('suleymaniye-camii', 106),
  ('kariye-camii', 91),
  ('kucuk-ayasofya-camii', 82),
  ('sokollu-mehmed-pasa-camii', 79),
  ('sehzade-camii', 79),
  ('fethiye-camii', 77),
  ('laleli-camii', 77),
  ('yeni-cami', 77),
  ('zeyrek-camii', 77),
  ('nuruosmaniye-camii', 76),
  ('ortakoy-camii', 75),
  ('fatih-camii', 74),
  ('bodrum-camii', 72),
  ('rustem-pasa-camii', 69),
  ('bayezid-camii', 68),
  ('mihrimah-sultan-camii-edirnekapi', 67),
  ('dolmabahce-camii', 65),
  ('eyup-sultan-camii', 65),
  ('camlica-camii', 64),
  ('arap-camii', 61),
  ('yavuz-selim-camii', 60),
  ('yeni-valide-camii', 60),
  ('mihrimah-sultan-camii-uskudar', 58),
  ('kilic-ali-pasa-camii', 57),
  ('sakirin-camii', 56),
  ('aya-yorgi-patrikhane-kilisesi', 65),
  ('st-antuan-katolik-kilisesi', 61),
  ('meryem-ana-kilisesi', 58),
  ('saint-esprit-kilisesi', 56),
  ('balikli-meryem-ana-rum-manastiri', 54),
  ('kanli-kilise', 53),
  ('sveti-stefan-kilisesi', 53),
  ('aya-triada-kilisesi', 49),
  ('galata-surp-krikor-lusavoric-kilisesi', 47),
  ('neve-salom-sinagogu', 56),
  ('istanbul-askenaz-sinagogu', 51),
  ('ahrida-sinagogu', 50),
  ('topkapi-sarayi', 106),
  ('dolmabahce-sarayi', 100),
  ('beylerbeyi-sarayi', 80),
  ('ciragan-sarayi', 79),
  ('tekfur-sarayi', 70),
  ('kucuksu-kasri', 67),
  ('buyuk-saray-mozaikleri-muzesi', 61),
  ('ihlamur-kasri', 61),
  ('malta-kosku', 60),
  ('adile-sultan-sarayi', 58),
  ('maslak-kasri', 58),
  ('florya-ataturk-deniz-kosku', 54),
  ('aya-irini', 80),
  ('istanbul-arkeoloji-muzeleri', 78),
  ('turk-ve-islam-eserleri-muzesi', 70),
  ('masumiyet-muzesi', 68),
  ('pera-muzesi', 65),
  ('istanbul-modern', 65),
  ('miniaturk', 62),
  ('sakip-sabanci-muzesi', 59),
  ('500-yil-vakfi-turk-musevileri-muzesi', 58),
  ('cinili-kosk', 58),
  ('istanbul-deniz-muzesi', 58),
  ('asiyan-muzesi', 55),
  ('rahmi-m-koc-muzesi', 55),
  ('askeri-muze', 54),
  ('muze-gazhane', 53),
  ('sadberk-hanim-muzesi', 49),
  ('istanbul-islam-bilim-ve-teknoloji-muzesi', 48),
  ('adalar-muzesi', 47),
  ('galata-mevlevihanesi-muzesi', 55),
  ('konstantinopolis-surlari', 81),
  ('rumeli-hisari', 76),
  ('anadolu-hisari', 74),
  ('yedikule-hisari', 68),
  ('sile-kalesi', 47),
  ('galata-kulesi', 94),
  ('kiz-kulesi', 81),
  ('yerebatan-sarnici', 77),
  ('binbirdirek-sarnici', 59),
  ('serefiye-sarnici', 55),
  ('kapalicarsi', 82),
  ('bozdogan-kemeri', 70),
  ('dikilitas', 67),
  ('cemberlitas-sutunu', 64),
  ('orme-dikilitas', 58),
  ('milyon-tasi', 57),
  ('taksim-cumhuriyet-aniti', 56),
  ('kiztasi', 52),
  ('gotlar-sutunu', 51),
  ('iii-ahmed-cesmesi', 51),
  ('alman-cesmesi', 49),
  ('rumeli-feneri', 48),
  ('anadolu-feneri', 35),
  ('misir-carsisi', 90),
  ('sultanahmet-meydani-hipodrom', 85),
  ('sile-feneri', 40),
  ('yoros-kalesi', 57),
  ('arkadios-sutunu', 55),
  ('garipce-kalesi', 43),
  ('anadolu-kavagi-manzara-seyir-noktasi', 20),
  ('sarayburnu-manzarasi', 20),
  ('yenikoy-seyir-terasi', 20),
  ('otagtepe', 35),
  ('pierre-loti-tepesi', 70),
  ('kayis-dagi', 55),
  ('aydos-tepesi', 54),
  ('alemdag', 24),
  ('yildiz-parki', 74),
  ('belgrad-ormani', 69),
  ('emirgan-korusu', 58),
  ('fethipasa-korusu', 55),
  ('polonezkoy-tabiat-parki', 51),
  ('falih-rifki-atay-tabiat-parki', 46),
  ('validebag-korusu', 32),
  ('aydos-ormani', 24),
  ('kucukcamlica-korusu', 24),
  ('gulhane-parki', 68),
  ('buyuk-camlica-tepesi', 51),
  ('macka-demokrasi-parki', 48),
  ('ataturk-arboretumu', 47),
  ('goztepe-60-yil-parki', 45),
  ('mihrabat-tabiat-parki', 45),
  ('florya-ataturk-kent-ormani', 44),
  ('yogurtcu-parki', 44),
  ('fenerbahce-parki', 28),
  ('alfred-heilbronn-botanik-bahcesi', 24),
  ('beykoz-cayiri', 24),
  ('beykoz-korusu', 19),
  ('bebek-parki', 40),
  ('nakkastepe-millet-bahcesi', 40),
  ('menekse-plaji', 24),
  ('ciroz-plaji', 13),
  ('kilyos-plaji', 45),
  ('moda-sahili', 55),
  ('buyukada', 90),
  ('burgaz-adasi', 85),
  ('kinaliada', 79),
  ('heybeliada', 78),
  ('sedef-adasi', 73),
  ('yassiada', 73),
  ('hacilli-selalesi', 13),
  ('kanuni-sultan-suleyman-turbesi', 153),
  ('fatih-sultan-mehmed-turbesi', 122),
  ('yavuz-sultan-selim-turbesi', 90),
  ('hurrem-sultan-turbesi', 87),
  ('ayasofya-turbeleri', 80),
  ('ii-mahmud-turbesi', 79),
  ('sultan-ahmed-turbesi', 74),
  ('sultan-resad-turbesi', 73),
  ('i-abdulhamid-turbesi', 72),
  ('turhan-sultan-turbesi', 43),
  ('barbaros-hayreddin-pasa-turbesi', 7),
  ('yahya-efendi-turbesi', 5),
  ('aziz-mahmud-hudayi-turbesi', 0),
  ('telli-baba-turbesi', 0),
  ('merkez-efendi-turbesi', 0)) v(slug, pop), public.categories c
where p.slug = v.slug and c.id = p.category_id;

create or replace function public.search_norm(s text)
returns text
language sql immutable parallel safe
set search_path = public
as $$
  select lower(translate(coalesce(s, ''),
    'ÇĞİIÖŞÜÂÎÛçğıöşüâîû',
    'cgiiosuaiucgiosuaiu'));
$$;

create or replace function public.search_places(
  q text,
  lang text default 'tr',
  max_results integer default 20
)
returns table(id uuid, slug text, name text, short_desc text, kind place_kind, category text,
              latitude double precision, longitude double precision)
language sql stable
set search_path = public, extensions
as $$
  with qq as (
    select public.search_norm(trim(search_places.q)) as n
  ), m as (
    select s.place_id,
           min(case
                 when public.search_norm(s.name) = qq.n then 0
                 when public.search_norm(s.name) like qq.e || '%' escape '\' then 1
                 when public.search_norm(s.name) like '% ' || qq.e || '%' escape '\' then 2
                 else 3
               end) as rank
    from public.place_translations s,
         (select n, replace(replace(replace(n, '\', '\\'), '%', '\%'), '_', '\_') as e from qq) qq
    where length(qq.n) >= 2
      and public.search_norm(s.name) like '%' || qq.e || '%' escape '\'
    group by s.place_id
  )
  select p.id, p.slug, t.name, t.short_desc, p.kind, c.slug,
         st_y(p.location::geometry), st_x(p.location::geometry)
  from m
  join public.places p on p.id = m.place_id
  join public.categories c on c.id = p.category_id
  join public.place_translations t on t.place_id = p.id and t.lang = public.norm_lang(search_places.lang)
  where p.is_published
  order by m.rank, p.popularity desc, t.name
  limit least(greatest(search_places.max_results, 1), 50);
$$;
