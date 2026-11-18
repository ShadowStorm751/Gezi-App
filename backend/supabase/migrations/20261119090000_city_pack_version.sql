-- city_pack sürümü artık paket içeriğinin md5 özeti (REQUESTS.md: "Şehir paketi sürümünü
-- indirmeden kontrol etme"). Ad, açıklama, kategori, konum, yarıçap, yayına alma/kaldırma
-- ya da şehir adı değişince sürüm de değişir. Boş şehirde de bir sürüm döner.
-- city_pack_version: paketi indirmeden yalnızca sürümü verir.

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
           'checkin_radius_m', p.checkin_radius_m) order by p.slug), '[]'::jsonb)
  from public.places p
  join public.categories c on c.id = p.category_id
  join public.place_translations t
    on t.place_id = p.id and t.lang = public.norm_lang(p_lang)
  where p.city_id = p_city_id and p.is_published;
$$;

create or replace function public.city_pack(
  city_slug text default 'istanbul',
  lang text default 'tr'
)
returns jsonb
language sql stable
set search_path = public
as $$
  with pk as (
    select ci.slug,
           ci.names ->> public.norm_lang(city_pack.lang) as name,
           public.city_pack_places(ci.id, city_pack.lang) as places
    from public.cities ci
    where ci.slug = city_pack.city_slug
  )
  select jsonb_build_object(
    'city', pk.slug,
    'name', pk.name,
    'version', md5(jsonb_build_object('name', pk.name, 'places', pk.places)::text),
    'places', pk.places)
  from pk;
$$;

create or replace function public.city_pack_version(
  city_slug text default 'istanbul',
  lang text default 'tr'
)
returns text
language sql stable
set search_path = public
as $$
  select md5(jsonb_build_object(
           'name', ci.names ->> public.norm_lang(city_pack_version.lang),
           'places', public.city_pack_places(ci.id, city_pack_version.lang))::text)
  from public.cities ci
  where ci.slug = city_pack_version.city_slug;
$$;
