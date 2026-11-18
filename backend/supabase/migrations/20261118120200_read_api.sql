-- Gezi App: okuma API'si (RPC fonksiyonları)
-- Hepsi SECURITY INVOKER: RLS kuralları çağıran kullanıcıya göre uygulanır.
-- Sözleşme: docs/API.md. Buradaki bir imza değişirse API.md aynı commit'te güncellenir.

-- 'en' dışındaki her değer 'tr' kabul edilir.
create or replace function public.norm_lang(lang text)
returns text
language sql immutable
as $$
  select case when lower(coalesce(lang, '')) = 'en' then 'en' else 'tr' end;
$$;

-- ---------------------------------------------------------------------------
-- nearby_places: harita, liste ve geo-AR için yakındaki yerler (yakından uzağa)
-- bearing_deg: kullanıcıdan yere pusula açısı (0 = kuzey, 90 = doğu, saat yönünde)
-- ---------------------------------------------------------------------------
create or replace function public.nearby_places(
  lat double precision,
  lng double precision,
  radius_m integer default 1000,
  kinds public.place_kind[] default null,
  lang text default 'tr',
  max_results integer default 100
)
returns table (
  id uuid,
  slug text,
  name text,
  short_desc text,
  kind public.place_kind,
  category text,
  latitude double precision,
  longitude double precision,
  distance_m double precision,
  bearing_deg double precision,
  visited boolean
)
language sql stable
set search_path = public, extensions
as $$
  with me as (
    select st_setsrid(st_makepoint(nearby_places.lng, nearby_places.lat), 4326)::geography as g
  )
  select p.id, p.slug, t.name, t.short_desc, p.kind, c.slug,
         st_y(p.location::geometry), st_x(p.location::geometry),
         st_distance(p.location, me.g),
         degrees(st_azimuth(me.g, p.location)),
         exists (select 1 from public.visits v where v.place_id = p.id and v.user_id = auth.uid())
  from me
  cross join public.places p
  join public.categories c on c.id = p.category_id
  join public.place_translations t on t.place_id = p.id and t.lang = public.norm_lang(nearby_places.lang)
  where p.is_published
    and st_dwithin(p.location, me.g, least(greatest(nearby_places.radius_m, 1), 20000))
    and (nearby_places.kinds is null or p.kind = any (nearby_places.kinds))
  order by 9
  limit least(greatest(nearby_places.max_results, 1), 500);
$$;

-- ---------------------------------------------------------------------------
-- places_in_bbox: harita kaydırılırken ekrandaki alanın pinleri
-- ---------------------------------------------------------------------------
create or replace function public.places_in_bbox(
  min_lat double precision,
  min_lng double precision,
  max_lat double precision,
  max_lng double precision,
  kinds public.place_kind[] default null,
  lang text default 'tr',
  max_results integer default 500
)
returns table (
  id uuid,
  slug text,
  name text,
  kind public.place_kind,
  category text,
  latitude double precision,
  longitude double precision,
  visited boolean
)
language sql stable
set search_path = public, extensions
as $$
  select p.id, p.slug, t.name, p.kind, c.slug,
         st_y(p.location::geometry), st_x(p.location::geometry),
         exists (select 1 from public.visits v where v.place_id = p.id and v.user_id = auth.uid())
  from public.places p
  join public.categories c on c.id = p.category_id
  join public.place_translations t on t.place_id = p.id and t.lang = public.norm_lang(places_in_bbox.lang)
  where p.is_published
    and st_intersects(
          p.location,
          st_makeenvelope(places_in_bbox.min_lng, places_in_bbox.min_lat,
                          places_in_bbox.max_lng, places_in_bbox.max_lat, 4326)::geography)
    and (places_in_bbox.kinds is null or p.kind = any (places_in_bbox.kinds))
  limit least(greatest(places_in_bbox.max_results, 1), 1000);
$$;

-- ---------------------------------------------------------------------------
-- place_detail: detay sayfası (yayında değilse ya da yoksa null)
-- ---------------------------------------------------------------------------
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
               'width', ph.width,
               'height', ph.height,
               'license', ph.license,
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

-- ---------------------------------------------------------------------------
-- search_places: ada göre arama (TR ve EN adların ikisinde de arar)
-- ---------------------------------------------------------------------------
create or replace function public.search_places(
  q text,
  lang text default 'tr',
  max_results integer default 20
)
returns table (
  id uuid,
  slug text,
  name text,
  short_desc text,
  kind public.place_kind,
  category text,
  latitude double precision,
  longitude double precision
)
language sql stable
set search_path = public, extensions
as $$
  select p.id, p.slug, t.name, t.short_desc, p.kind, c.slug,
         st_y(p.location::geometry), st_x(p.location::geometry)
  from public.places p
  join public.categories c on c.id = p.category_id
  join public.place_translations t on t.place_id = p.id and t.lang = public.norm_lang(search_places.lang)
  where p.is_published
    and length(trim(coalesce(search_places.q, ''))) >= 2
    and exists (
      select 1 from public.place_translations s
      where s.place_id = p.id
        and s.name ilike '%' || replace(replace(replace(trim(search_places.q),
              '\', '\\'), '%', '\%'), '_', '\_') || '%')
  order by t.name
  limit least(greatest(search_places.max_results, 1), 50);
$$;

-- ---------------------------------------------------------------------------
-- city_progress: "120 yerin 13'ünü gezdin" + tür ve kategori kırılımı
-- city_progress_for checkin Edge Function'ı tarafından da kullanılır.
-- ---------------------------------------------------------------------------
create or replace function public.city_progress_for(p_user uuid, p_city_slug text)
returns jsonb
language sql stable
set search_path = public
as $$
  with base as (
    select p.kind, c.slug as category, (v.id is not null) as visited
    from public.places p
    join public.cities ci on ci.id = p.city_id
    join public.categories c on c.id = p.category_id
    left join public.visits v
      on v.place_id = p.id and v.user_id = p_user and not v.flagged
    where ci.slug = p_city_slug and p.is_published
  )
  select jsonb_build_object(
    'city', p_city_slug,
    'total', (select count(*) from base),
    'visited', (select count(*) filter (where visited) from base),
    'by_kind', coalesce((
      select jsonb_object_agg(k.kind, jsonb_build_object('total', k.n, 'visited', k.nv))
      from (select kind, count(*) as n, count(*) filter (where visited) as nv
            from base group by kind) k), '{}'::jsonb),
    'by_category', coalesce((
      select jsonb_agg(jsonb_build_object('category', g.category, 'total', g.n, 'visited', g.nv)
                       order by g.category)
      from (select category, count(*) as n, count(*) filter (where visited) as nv
            from base group by category) g), '[]'::jsonb)
  );
$$;

create or replace function public.city_progress(city_slug text default 'istanbul')
returns jsonb
language sql stable
set search_path = public
as $$
  select public.city_progress_for(auth.uid(), city_progress.city_slug);
$$;

-- ---------------------------------------------------------------------------
-- Rozet ilerlemesi: bir kuralın kullanıcı için (ilerleme, hedef) değeri.
-- Kural türleri: total_count, kind_count, category_count, period_count,
-- city_complete, place_set, time_of_day, streak_weeks. Bilinmeyen tür -> (0, 0).
-- Yalnızca işaretlenmemiş (flagged = false) ziyaretler sayılır.
-- ---------------------------------------------------------------------------
create or replace function public.achievement_progress(p_user uuid, p_rule jsonb)
returns table (progress integer, target integer)
language plpgsql stable
set search_path = public
as $$
declare
  rule_type text := p_rule ->> 'type';
  n int := coalesce((p_rule ->> 'n')::int, 1);
begin
  if rule_type = 'total_count' then
    return query
      select count(*)::int, n from public.visits v
      where v.user_id = p_user and not v.flagged;

  elsif rule_type = 'kind_count' then
    return query
      select count(*)::int, n from public.visits v
      join public.places p on p.id = v.place_id
      where v.user_id = p_user and not v.flagged
        and p.kind = (p_rule ->> 'kind')::public.place_kind;

  elsif rule_type = 'category_count' then
    return query
      select count(*)::int, n from public.visits v
      join public.places p on p.id = v.place_id
      join public.categories c on c.id = p.category_id
      where v.user_id = p_user and not v.flagged
        and c.slug = p_rule ->> 'category';

  elsif rule_type = 'period_count' then
    return query
      select count(*)::int, n from public.visits v
      join public.places p on p.id = v.place_id
      where v.user_id = p_user and not v.flagged
        and p.period = p_rule ->> 'period';

  elsif rule_type = 'city_complete' then
    return query
      select count(v.id)::int, count(p.id)::int
      from public.places p
      join public.cities ci on ci.id = p.city_id
      left join public.visits v
        on v.place_id = p.id and v.user_id = p_user and not v.flagged
      where ci.slug = p_rule ->> 'city'
        and p.is_published
        and (p_rule ->> 'kind' is null or p.kind = (p_rule ->> 'kind')::public.place_kind);

  elsif rule_type = 'place_set' then
    return query
      select count(v.id)::int, jsonb_array_length(p_rule -> 'places')
      from public.places p
      left join public.visits v
        on v.place_id = p.id and v.user_id = p_user and not v.flagged
      where p.slug in (select jsonb_array_elements_text(p_rule -> 'places'));

  elsif rule_type = 'time_of_day' then
    return query
      select count(*)::int, n from public.visits v
      join public.places p on p.id = v.place_id
      join public.cities ci on ci.id = p.city_id
      join public.categories c on c.id = p.category_id
      where v.user_id = p_user and not v.flagged
        and (p_rule ->> 'category' is null or c.slug = p_rule ->> 'category')
        and (v.visited_at at time zone ci.timezone)::time
            between (p_rule ->> 'from')::time and (p_rule ->> 'to')::time;

  elsif rule_type = 'streak_weeks' then
    -- En uzun ardışık hafta serisi (her hafta en az bir ziyaret).
    return query
      select coalesce(max(s.len), 0)::int, n
      from (
        select count(*) as len
        from (
          select w.wk, w.wk - (row_number() over (order by w.wk)) * interval '7 days' as grp
          from (
            select distinct date_trunc('week', v.visited_at at time zone 'Europe/Istanbul') as wk
            from public.visits v
            where v.user_id = p_user and not v.flagged
          ) w
        ) g
        group by g.grp
      ) s;

  else
    return query select 0, 0;
  end if;
end;
$$;

-- ---------------------------------------------------------------------------
-- my_achievements: tüm aktif rozetler; kazanılanlar önce, kilitliler ilerlemeyle
-- ---------------------------------------------------------------------------
create or replace function public.my_achievements(lang text default 'tr')
returns table (
  slug text,
  name text,
  description text,
  badge_path text,
  earned_at timestamptz,
  progress integer,
  target integer
)
language sql stable
set search_path = public
as $$
  select a.slug, t.name, t.description, a.badge_path, ua.earned_at,
         least(ap.progress, ap.target), ap.target
  from public.achievements a
  left join public.achievement_translations t
    on t.achievement_id = a.id and t.lang = public.norm_lang(my_achievements.lang)
  left join public.user_achievements ua
    on ua.achievement_id = a.id and ua.user_id = auth.uid()
  cross join lateral public.achievement_progress(auth.uid(), a.rule) ap
  where a.is_active
  order by ua.earned_at is null, ua.earned_at desc, a.sort_order;
$$;

-- ---------------------------------------------------------------------------
-- my_visits: ziyaret geçmişi, yeniden eskiye. Sonraki sayfa için son satırın
-- visited_at değerini before_time olarak gönder.
-- ---------------------------------------------------------------------------
create or replace function public.my_visits(
  page_size integer default 20,
  before_time timestamptz default null,
  lang text default 'tr'
)
returns table (
  visit_id uuid,
  place_id uuid,
  slug text,
  name text,
  kind public.place_kind,
  category text,
  visited_at timestamptz
)
language sql stable
set search_path = public
as $$
  select v.id, p.id, p.slug, t.name, p.kind, c.slug, v.visited_at
  from public.visits v
  join public.places p on p.id = v.place_id
  join public.categories c on c.id = p.category_id
  left join public.place_translations t
    on t.place_id = p.id and t.lang = public.norm_lang(my_visits.lang)
  where v.user_id = auth.uid()
    and (my_visits.before_time is null or v.visited_at < my_visits.before_time)
  order by v.visited_at desc
  limit least(greatest(my_visits.page_size, 1), 100);
$$;

-- ---------------------------------------------------------------------------
-- my_summary: yıllık özet (yıl içinde "şu ana kadarki özet" olarak da çalışır)
-- distance_km: ziyaret edilen yerler arasındaki düz mesafelerin toplamı (yaklaşık)
-- busiest_month: 1-12; ay adını frontend dile göre yazar
-- ---------------------------------------------------------------------------
create or replace function public.my_summary(
  for_year integer default null,
  lang text default 'tr'
)
returns jsonb
language sql stable
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
      select period from vs where period is not null
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

-- ---------------------------------------------------------------------------
-- city_pack: şehrin tüm yayındaki yerleri tek JSON (açılışta indirilip saklanır;
-- harita ve geo-AR bu yerel veriyle çalışır). version değişmediyse yeniden indirme.
-- ---------------------------------------------------------------------------
create or replace function public.city_pack(
  city_slug text default 'istanbul',
  lang text default 'tr'
)
returns jsonb
language sql stable
set search_path = public, extensions
as $$
  select jsonb_build_object(
    'city', ci.slug,
    'name', ci.names ->> public.norm_lang(city_pack.lang),
    'version', (select max(p2.updated_at) from public.places p2
                where p2.city_id = ci.id and p2.is_published),
    'places', coalesce((
      select jsonb_agg(jsonb_build_object(
               'id', p.id,
               'slug', p.slug,
               'name', t.name,
               'short_desc', t.short_desc,
               'kind', p.kind,
               'category', c.slug,
               'latitude', st_y(p.location::geometry),
               'longitude', st_x(p.location::geometry),
               'checkin_radius_m', p.checkin_radius_m) order by p.slug)
      from public.places p
      join public.categories c on c.id = p.category_id
      join public.place_translations t
        on t.place_id = p.id and t.lang = public.norm_lang(city_pack.lang)
      where p.city_id = ci.id and p.is_published), '[]'::jsonb)
  )
  from public.cities ci
  where ci.slug = city_pack.city_slug;
$$;

-- ---------------------------------------------------------------------------
-- Profil
-- ---------------------------------------------------------------------------
create or replace function public.update_profile(
  username text default null,
  avatar_path text default null,
  is_public boolean default null,
  preferred_lang text default null
)
returns jsonb
language sql volatile
set search_path = public
as $$
  update public.profiles pr set
    username       = coalesce(update_profile.username, pr.username),
    avatar_path    = coalesce(update_profile.avatar_path, pr.avatar_path),
    is_public      = coalesce(update_profile.is_public, pr.is_public),
    preferred_lang = coalesce(update_profile.preferred_lang, pr.preferred_lang)
  where pr.id = auth.uid()
  returning jsonb_build_object(
    'id', pr.id,
    'username', pr.username,
    'avatar_path', pr.avatar_path,
    'is_public', pr.is_public,
    'preferred_lang', pr.preferred_lang);
$$;

-- KVKK: kullanıcının tüm verisi tek JSON.
create or replace function public.export_my_data()
returns jsonb
language sql stable
set search_path = public
as $$
  select jsonb_build_object(
    'exported_at', now(),
    'profile', (select to_jsonb(pr) from public.profiles pr where pr.id = auth.uid()),
    'visits', coalesce((
      select jsonb_agg(jsonb_build_object(
               'place', p.slug,
               'visited_at', v.visited_at,
               'method', v.method,
               'distance_m', v.distance_m,
               'gps_accuracy_m', v.gps_accuracy_m) order by v.visited_at)
      from public.visits v join public.places p on p.id = v.place_id
      where v.user_id = auth.uid()), '[]'::jsonb),
    'achievements', coalesce((
      select jsonb_agg(jsonb_build_object('achievement', a.slug, 'earned_at', ua.earned_at)
                       order by ua.earned_at)
      from public.user_achievements ua join public.achievements a on a.id = ua.achievement_id
      where ua.user_id = auth.uid()), '[]'::jsonb)
  );
$$;
