-- Ana yer ve içindeki keşfedilecek yerler (proje sahibinin kararı, 2026-11-19).
-- Örnek: "Efes" ana yerdir; Celsus Kütüphanesi, Büyük Tiyatro gibi 11 yapı onun içindedir.
-- Her biri ayrı yerdir, ayrı check-in alır. Ana yerin kartında "içinde N keşfedilecek yer" görünür.
--
-- Geriye uyumlu eklemeler:
--   places.parent_place_id            (null = bağımsız ya da ana yer)
--   place_detail.parent / children / children_total / children_visited
--   city_pack.places[].parent_id, child_count   (paket içeriği değiştiği için version bir kez değişir)
-- Tek seviye: içteki bir yerin kendi içinde yeri olamaz.

alter table public.places
  add column parent_place_id uuid references public.places(id) on delete set null,
  add constraint places_parent_not_self check (parent_place_id is null or parent_place_id <> id);

create index places_parent_idx on public.places (parent_place_id) where parent_place_id is not null;

-- Tek seviye ve aynı şehir kuralı
create or replace function public.places_check_parent()
returns trigger
language plpgsql
set search_path = public
as $$
declare
  parent_row record;
begin
  if new.parent_place_id is null then
    return new;
  end if;
  select city_id, parent_place_id into parent_row from public.places where id = new.parent_place_id;
  if parent_row.parent_place_id is not null then
    raise exception 'place % : ana yerin kendisi başka bir yerin içinde olamaz (tek seviye)', new.slug;
  end if;
  if parent_row.city_id <> new.city_id then
    raise exception 'place % : ana yer başka bir şehirde', new.slug;
  end if;
  if exists (select 1 from public.places c where c.parent_place_id = new.id) then
    raise exception 'place % : içinde yer olan bir yer başka bir yerin içine konamaz', new.slug;
  end if;
  return new;
end;
$$;

create trigger places_check_parent
  before insert or update of parent_place_id on public.places
  for each row execute function public.places_check_parent();

-- Yer detayındaki ana yer / iç yer alanları (MODULES.md: "yer detayına yeni alan = yardımcı fonksiyon + tek satır")
create or replace function public.place_hierarchy(place_id uuid, lang text default 'tr')
returns jsonb
language sql stable
set search_path = public, extensions
as $$
  select jsonb_build_object(
    'parent', (
      select jsonb_build_object('id', pp.id, 'slug', pp.slug, 'name', pt.name)
      from public.places pp
      join public.place_translations pt
        on pt.place_id = pp.id and pt.lang = public.norm_lang(place_hierarchy.lang)
      where pp.id = x.parent_place_id and pp.is_published),
    'children', coalesce((
      select jsonb_agg(jsonb_build_object(
               'id', ch.id,
               'slug', ch.slug,
               'name', cht.name,
               'category', chc.slug,
               'latitude', st_y(ch.location::geometry),
               'longitude', st_x(ch.location::geometry),
               'checkin_radius_m', ch.checkin_radius_m,
               'thumb_url', (
                 select coalesce(ph.thumb_url, ph.url) from public.place_photos ph
                 where ph.place_id = ch.id and ph.url is not null
                 order by ph.sort_order limit 1),
               'visited', exists (
                 select 1 from public.visits v
                 where v.place_id = ch.id and v.user_id = auth.uid())) order by cht.name)
      from public.places ch
      join public.categories chc on chc.id = ch.category_id
      join public.place_translations cht
        on cht.place_id = ch.id and cht.lang = public.norm_lang(place_hierarchy.lang)
      where ch.parent_place_id = x.id and ch.is_published), '[]'::jsonb),
    'children_total', (
      select count(*) from public.places ch
      where ch.parent_place_id = x.id and ch.is_published),
    'children_visited', (
      select count(*) from public.places ch
      join public.visits v on v.place_id = ch.id and v.user_id = auth.uid()
      where ch.parent_place_id = x.id and ch.is_published and not v.flagged)
  )
  from public.places x
  where x.id = place_hierarchy.place_id;
$$;

grant execute on function public.place_hierarchy(uuid, text) to anon, authenticated;

-- place_detail: 20261120030000_place_reviews.sql'deki son tanımın aynısı + tek satır (place_hierarchy).
-- Canlıya uygularken MODULES.md gereği canlıdaki son tanımla karşılaştırın (pg_get_functiondef).
create or replace function public.place_detail(place_id uuid, lang text default 'tr')
returns jsonb
language sql
stable
set search_path = public, extensions
as $$
  select jsonb_build_object(
    'id', p.id,
    'slug', p.slug,
    'kind', p.kind,
    'category', c.slug,
    'category_name', ct.name,
    'city', ci.slug,
    'name', t.name,
    'short_desc', t.short_desc,
    'long_desc', t.long_desc,
    'best_time', t.best_time,
    'period', public.period_label(p.period, place_detail.lang),
    'period_code', p.period,
    'built_year', p.built_year,
    'opening_hours', p.opening_hours,
    'latitude', st_y(p.location::geometry),
    'longitude', st_x(p.location::geometry),
    'checkin_radius_m', p.checkin_radius_m,
    'has_area', p.area is not null,
    'rating', public.place_rating(p.id),
    'photos', coalesce((
      select jsonb_agg(jsonb_build_object(
               'storage_path', ph.storage_path,
               'url', ph.url,
               'thumb_url', ph.thumb_url,
               'width', ph.width,
               'height', ph.height,
               'license', ph.license,
               'license_url', ph.license_url,
               'author', ph.author,
               'source_url', ph.source_url) order by ph.sort_order)
      from public.place_photos ph
      where ph.place_id = p.id), '[]'::jsonb),
    'visited_at', (
      select v.visited_at from public.visits v
      where v.place_id = p.id and v.user_id = auth.uid())
  ) || public.place_hierarchy(p.id, place_detail.lang)
  from public.places p
  join public.cities ci on ci.id = p.city_id
  join public.categories c on c.id = p.category_id
  left join public.category_translations ct
    on ct.category_id = c.id and ct.lang = public.norm_lang(place_detail.lang)
  join public.place_translations t
    on t.place_id = p.id and t.lang = public.norm_lang(place_detail.lang)
  where p.id = place_detail.place_id
    and p.is_published;
$$;

-- city_pack: parent_id ve child_count
create or replace function public.city_pack_places(p_city_id integer, p_lang text)
returns jsonb
language sql stable
set search_path = public, extensions
as $$
  select coalesce(jsonb_agg(jsonb_build_object(
           'id', p.id,
           'slug', p.slug,
           'name', t.name,
           'short_desc', t.short_desc,
           'kind', p.kind,
           'category', c.slug,
           'latitude', st_y(p.location::geometry),
           'longitude', st_x(p.location::geometry),
           'checkin_radius_m', p.checkin_radius_m,
           'has_area', p.area is not null,
           'parent_id', (select pp.id from public.places pp
                         where pp.id = p.parent_place_id and pp.is_published),
           'child_count', (select count(*) from public.places ch
                           where ch.parent_place_id = p.id and ch.is_published),
           'thumb_url', (
             select coalesce(ph.thumb_url, ph.url)
             from public.place_photos ph
             where ph.place_id = p.id and ph.url is not null
             order by ph.sort_order
             limit 1)) order by p.slug), '[]'::jsonb)
  from public.places p
  join public.categories c on c.id = p.category_id
  join public.place_translations t
    on t.place_id = p.id and t.lang = public.norm_lang(p_lang)
  where p.city_id = p_city_id and p.is_published;
$$;

-- Yeni şehirlerde kullanılan dönemler için İngilizce etiketler (geri kalanı 20261120020000 ile aynı)
create or replace function public.period_label(p_period text, p_lang text)
returns text
language sql
immutable
set search_path = public
as $$
  select case when public.norm_lang(p_lang) = 'tr' or p_period is null then p_period
         else coalesce(case p_period
           when 'Osmanlı'    then 'Ottoman'
           when 'Bizans'     then 'Byzantine'
           when 'Ceneviz'    then 'Genoese'
           when 'Roma'       then 'Roman'
           when 'Cumhuriyet' then 'Republican'
           when 'Antik Mısır' then 'Ancient Egyptian'
           when 'Antik'      then 'Ancient'
           when 'Beylikler'  then 'Anatolian Beyliks'
           when 'Selçuklu'   then 'Seljuk'
           end, p_period) end;
$$;
