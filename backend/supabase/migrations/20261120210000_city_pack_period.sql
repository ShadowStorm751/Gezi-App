-- city_pack.places[] -> period (istenen dilde) ve period_code (ham, Türkçe) alanları (geriye uyumlu ekleme).
-- Mobil, Keşfet kartlarında ve listelerde "OSMANLI · CAMİ" satırını ve rozet ilerlemesini
-- paketten gösterebilsin. Paket içeriği değiştiği için city_pack.version bir kez değişir.
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
           'period', public.period_label(p.period, p_lang),
           'period_code', p.period,
           'latitude', st_y(p.location::geometry),
           'longitude', st_x(p.location::geometry),
           'checkin_radius_m', p.checkin_radius_m,
           'has_area', p.area is not null,
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
