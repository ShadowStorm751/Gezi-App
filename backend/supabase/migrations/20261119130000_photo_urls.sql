-- Yer fotoğrafları dış adresten (Wikimedia Commons) de gösterilebilir.
-- Bir fotoğraf ya Storage'da (storage_path) ya da dış adreste (url) durur.
-- place_detail fotoğraflara url, thumb_url, license_url ekler; city_pack her yere
-- ilk fotoğrafın küçük resmini (thumb_url) ekler. Geriye uyumlu.

alter table public.place_photos alter column storage_path drop not null;
alter table public.place_photos
  add column url text,
  add column thumb_url text,
  add column license_url text;
alter table public.place_photos
  add constraint place_photos_has_source check (storage_path is not null or url is not null);

-- place_detail: fotoğraflara dış adres alanları
create or replace function public.place_detail(
  place_id uuid,
  lang text default 'tr'
)
returns jsonb
language sql stable
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
    'period', p.period,
    'built_year', p.built_year,
    'opening_hours', p.opening_hours,
    'latitude', st_y(p.location::geometry),
    'longitude', st_x(p.location::geometry),
    'checkin_radius_m', p.checkin_radius_m,
    'has_area', p.area is not null,
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
  )
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

-- city_pack: her yere ilk fotoğrafın küçük resmi (yoksa null)
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
