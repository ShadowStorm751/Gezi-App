-- city_pack.places[] -> has_area alanı (geriye uyumlu ekleme).
-- Mobil, check-in butonunu çevrimdışı ön kontrol ederken orman/ada gibi alan tanımlı yerleri
-- ayırt edebilsin: bu yerlerde sınırın içinde olmak yeterli, merkeze uzaklık önemsiz.
-- Paket içeriği değiştiği için city_pack.version bir kez değişir.
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
