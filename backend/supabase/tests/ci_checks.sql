-- CI: migration'lar uygulandıktan sonra yeni şehirlerin denetimi. Hata olursa ON_ERROR_STOP ile durur.
\set ON_ERROR_STOP on
\echo '== Şehir başına yer sayısı (yayında / toplam)'
select ci.slug, count(*) filter (where p.is_published) as yayinda, count(*) as toplam,
       count(*) filter (where p.parent_place_id is not null) as ic_yer,
       count(ph.place_id) as fotografli
from public.places p join public.cities ci on ci.id = p.city_id
left join (select distinct place_id from public.place_photos) ph on ph.place_id = p.id
group by ci.slug order by ci.slug;

\echo '== TR+EN adı ve kısa açıklaması eksik yer (0 olmalı)'
select p.slug from public.places p
where (select count(*) from public.place_translations t
       where t.place_id = p.id and t.short_desc is not null) < 2;

\echo '== Ana yerler ve iç yer sayıları'
select pp.slug as ana_yer, count(*) as ic_yer from public.places p
join public.places pp on pp.id = p.parent_place_id group by pp.slug order by pp.slug;

\echo '== Yeni kategoriler ve keşif rozetleri'
select c.slug, c.kind, ct.name from public.categories c
join public.category_translations ct on ct.category_id = c.id and ct.lang = 'tr'
where c.slug in ('village', 'valley');
select a.slug, jsonb_array_length(a.rule -> 'places') as yer, t.name
from public.achievements a join public.achievement_translations t on t.achievement_id = a.id and t.lang = 'tr'
where a.slug like '%-kesif' order by a.slug;

\echo '== Rozet kurallarındaki slug''lar var mı (0 olmalı)'
select a.slug, s.slug as eksik
from public.achievements a, jsonb_array_elements_text(a.rule -> 'places') s(slug)
where a.rule ->> 'type' = 'place_set' and not exists (select 1 from public.places p where p.slug = s.slug);

\echo '== Yayınlama denemesi (geri alınır): place_detail ve city_pack'
begin;
update public.places p set is_published = true
from public.cities ci where ci.id = p.city_id and ci.slug in ('izmir', 'bursa', 'kapadokya');
select (public.place_detail(p.id, 'tr') ->> 'children_total') as efes_ic_yer,
       jsonb_array_length(public.place_detail(p.id, 'en') -> 'children') as efes_children,
       public.place_detail(p.id, 'en') ->> 'name' as ad
from public.places p where p.slug = 'efes';
select public.place_detail(p.id, 'tr') -> 'parent' as celsus_ana_yer
from public.places p where p.slug = 'celsus-kutuphanesi';
select ci.slug, jsonb_array_length(public.city_pack(ci.slug, 'tr') -> 'places') as paket_yer,
       (select count(*) from jsonb_array_elements(public.city_pack(ci.slug, 'tr') -> 'places') e
        where (e ->> 'child_count')::int > 0) as paket_ana_yer
from public.cities ci order by ci.slug;
rollback;

\echo '== Tek seviye kuralı (hata beklenir, yakalanır)'
do $$
begin
  update public.places set parent_place_id = (select id from public.places where slug = 'celsus-kutuphanesi')
  where slug = 'kizil-avlu';
  raise exception 'tek seviye kuralı çalışmadı';
exception when others then
  if sqlerrm like '%tek seviye%' and sqlerrm not like '%çalışmadı%' then
    raise notice 'beklenen hata: %', sqlerrm;
  else
    raise;
  end if;
end $$;
\echo 'TAMAM'
