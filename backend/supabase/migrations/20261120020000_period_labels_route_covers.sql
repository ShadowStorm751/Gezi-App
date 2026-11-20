-- 1) Tarih dönemi dile göre: place_detail.period ve my_summary.favorite_period artık istenen dilde
--    ("Osmanlı" / "Ottoman"). Ham değer place_detail.period_code olarak eklendi. Geriye uyumlu.
-- 2) Rota kapak fotoğrafı (thumb_url) ilk duraktan değil, fotoğrafı olan en tanınmış duraktan.
--    Durak listesine 'popularity' eklendi.

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
           end, p_period) end;
$$;
grant execute on function public.period_label(text, text) to anon, authenticated;

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

create or replace function public.my_summary(for_year integer default null, lang text default 'tr')
returns jsonb
language sql
stable
set search_path = public, extensions
as $$
  with yr as (
    select coalesce(my_summary.for_year,
                    extract(year from now() at time zone 'Europe/Istanbul')::int) as y
  ),
  vs as (
    select v.visited_at, p.id as place_id, p.kind, p.period, p.built_year, p.location,
           c.slug as category, ci.slug as city,
           (v.visited_at at time zone ci.timezone) as local_ts
    from public.visits v
    join public.places p on p.id = v.place_id
    join public.categories c on c.id = p.category_id
    join public.cities ci on ci.id = p.city_id
    cross join yr
    where v.user_id = auth.uid()
      and not v.flagged
      and extract(year from v.visited_at at time zone ci.timezone) = yr.y
  ),
  legs as (
    select st_distance(vs.location, lag(vs.location) over (order by vs.visited_at)) as d
    from vs
  )
  select jsonb_build_object(
    'year', (select y from yr),
    'total_places', (select count(*) from vs),
    'historical', (select count(*) from vs where kind = 'historical'),
    'nature', (select count(*) from vs where kind = 'nature'),
    'top_city', (select city from vs group by city order by count(*) desc, city limit 1),
    'oldest_place', (
      select jsonb_build_object('slug', p.slug, 'name', t.name, 'built_year', vs.built_year)
      from vs
      join public.places p on p.id = vs.place_id
      left join public.place_translations t
        on t.place_id = p.id and t.lang = public.norm_lang(my_summary.lang)
      where vs.built_year is not null
      order by vs.built_year
      limit 1),
    'favorite_period', (
      select public.period_label(period, my_summary.lang) from vs where period is not null
      group by period order by count(*) desc, period limit 1),
    'favorite_category', (
      select category from vs group by category order by count(*) desc, category limit 1),
    'distance_km', (select round((coalesce(sum(d), 0) / 1000)::numeric, 1) from legs),
    'sunset_checkins', (
      select count(*) from vs
      where category = 'viewpoint' and local_ts::time between time '17:00' and time '20:00'),
    'badges_earned', (
      select count(*) from public.user_achievements ua cross join yr
      where ua.user_id = auth.uid()
        and extract(year from ua.earned_at at time zone 'Europe/Istanbul') = yr.y),
    'busiest_month', (
      select extract(month from local_ts)::int from vs
      group by 1 order by count(*) desc, 1 limit 1)
  );
$$;

create or replace function public.route_stops_for(p_route_id int, p_lang text)
returns jsonb
language sql
stable
set search_path = public, extensions
as $$
  select coalesce(jsonb_agg(jsonb_build_object(
           'position', s.n,
           'place_id', s.place_id,
           'slug', s.slug,
           'name', s.name,
           'kind', s.kind,
           'category', s.category,
           'latitude', st_y(s.location::geometry),
           'longitude', st_x(s.location::geometry),
           'thumb_url', s.thumb_url,
           'leg_m', s.leg_m,
           'popularity', s.popularity,
           'visited', case when auth.uid() is null then null else s.visited end) order by s.n), '[]'::jsonb)
  from (
    select row_number() over (order by rs.position) as n,
           p.id as place_id, p.slug, t.name, p.kind, c.slug as category, p.location, p.popularity,
           (select coalesce(ph.thumb_url, ph.url) from public.place_photos ph
             where ph.place_id = p.id and ph.url is not null order by ph.sort_order limit 1) as thumb_url,
           round(coalesce(st_distance(p.location,
                 lag(p.location) over (order by rs.position)), 0))::int as leg_m,
           exists (select 1 from public.visits v
                   where v.place_id = p.id and v.user_id = auth.uid() and not v.flagged) as visited
    from public.route_stops rs
    join public.places p on p.id = rs.place_id and p.is_published
    join public.categories c on c.id = p.category_id
    join public.place_translations t on t.place_id = p.id and t.lang = public.norm_lang(p_lang)
    where rs.route_id = p_route_id
  ) s;
$$;

create or replace function public.route_summary_json(r public.routes, p_lang text, p_stops jsonb)
returns jsonb
language sql
stable
set search_path = public
as $$
  select jsonb_build_object(
    'slug', r.slug,
    'city', (select ci.slug from public.cities ci where ci.id = r.city_id),
    'title', coalesce(t.title, tr.title),
    'summary', coalesce(t.summary, tr.summary),
    'kind', r.kind,
    'travel_mode', r.travel_mode,
    'est_minutes', r.est_minutes,
    'distance_m', (select coalesce(sum((e ->> 'leg_m')::int), 0) from jsonb_array_elements(p_stops) e),
    'stop_count', jsonb_array_length(p_stops),
    'thumb_url', (select e ->> 'thumb_url' from jsonb_array_elements(p_stops) e
                  where e ->> 'thumb_url' is not null
                  order by (e ->> 'popularity')::int desc nulls last, (e ->> 'position')::int
                  limit 1),
    'visited_count', case when auth.uid() is null then null else
      (select count(*) from jsonb_array_elements(p_stops) e where (e ->> 'visited')::boolean)::int end,
    'completed', case when auth.uid() is null then null else
      jsonb_array_length(p_stops) > 0
      and not exists (select 1 from jsonb_array_elements(p_stops) e where not (e ->> 'visited')::boolean) end)
  from (select 1) one
  left join public.route_translations t on t.route_id = r.id and t.lang = public.norm_lang(p_lang)
  left join public.route_translations tr on tr.route_id = r.id and tr.lang = 'tr';
$$;
