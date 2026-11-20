-- Şehir listesi: mobil şehir seçici ve "hangi şehirler var" ekranı için.
-- Yalnızca en az bir yayında yeri olan şehirler döner; veri hattının gizli yüklediği yeni
-- şehirler, yerleri yayına alınana kadar listede görünmez.

create or replace function public.list_cities(lang text default 'tr')
returns jsonb
language sql
stable
set search_path = public, extensions
as $$
  select coalesce(jsonb_agg(c order by (c ->> 'place_count')::int desc, c ->> 'slug'), '[]'::jsonb)
  from (
    select jsonb_build_object(
             'slug', ci.slug,
             'name', coalesce(ci.names ->> public.norm_lang(list_cities.lang), ci.names ->> 'tr'),
             'timezone', ci.timezone,
             'place_count', count(*),
             'historical_count', count(*) filter (where cat.kind = 'historical'),
             'nature_count', count(*) filter (where cat.kind = 'nature'),
             'center', jsonb_build_object('lat', round(avg(st_y(p.location::geometry))::numeric, 5),
                                          'lng', round(avg(st_x(p.location::geometry))::numeric, 5)),
             'bbox', jsonb_build_object('min_lat', round(min(st_y(p.location::geometry))::numeric, 5),
                                        'min_lng', round(min(st_x(p.location::geometry))::numeric, 5),
                                        'max_lat', round(max(st_y(p.location::geometry))::numeric, 5),
                                        'max_lng', round(max(st_x(p.location::geometry))::numeric, 5)),
             'visited_count', case when auth.uid() is null then null else (
                 select count(distinct v.place_id) from public.visits v
                 join public.places vp on vp.id = v.place_id
                 where v.user_id = auth.uid() and not v.flagged
                   and vp.city_id = ci.id and vp.is_published) end
           ) as c
    from public.cities ci
    join public.places p on p.city_id = ci.id and p.is_published
    join public.categories cat on cat.id = p.category_id
    group by ci.id
  ) x;
$$;

grant execute on function public.list_cities(text) to anon, authenticated;
