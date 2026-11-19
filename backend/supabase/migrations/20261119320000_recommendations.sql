-- Kişisel öneriler: "Sana önerilenler" ekranı.
-- Üç bölüm döner:
--   places          gezilmemiş yerler; tanınırlık + yakınlık + kullanıcının sevdiği kategoriler
--                   + yarım kalan rotanın sıradaki durağı + bitmek üzere olan rozete katkı
--   continue_routes yarım kalan rotalar ve sıradaki durak
--   almost_badges   kazanılmamış ama yarısı geçilmiş rozetler
-- Girişsiz kullanıcıya yalnızca tanınırlık ve yakınlığa göre yerler döner; diğer bölümler boş.
-- Konum (lat/lng) isteğe bağlı; verilirse 30 km içindeki yerler önerilir ve yakınlık puana katılır.

-- Kazanılmamış, ilerlemesi başlamış rozetler
create or replace function public.rec_open_badges(p_user uuid, p_lang text)
returns table (slug text, name text, badge_path text, progress int, target int, rule jsonb)
language sql
stable
set search_path = public
as $$
  select a.slug, t.name, a.badge_path, ap.progress, ap.target, a.rule
  from public.achievements a
  join public.achievement_translations t on t.achievement_id = a.id and t.lang = p_lang
  cross join lateral public.achievement_progress(p_user, a.rule) ap
  where p_user is not null and a.is_active
    and ap.target > 0 and ap.progress > 0 and ap.progress < ap.target
    and not exists (select 1 from public.user_achievements ua
                    where ua.user_id = p_user and ua.achievement_id = a.id);
$$;

-- Yarım kalan rotalar ve sıradaki gezilmemiş durak
create or replace function public.rec_open_routes(p_user uuid, p_lang text)
returns table (route_id int, slug text, title text, visited int, stops int, next_place uuid)
language sql
stable
set search_path = public
as $$
  select r.id, r.slug, coalesce(t.title, tr.title),
         count(vv.hit)::int, count(*)::int,
         (array_agg(rs.place_id order by rs.position) filter (where vv.hit is null))[1]
  from public.routes r
  join public.route_stops rs on rs.route_id = r.id
  join public.places p on p.id = rs.place_id and p.is_published
  left join public.route_translations t on t.route_id = r.id and t.lang = p_lang
  left join public.route_translations tr on tr.route_id = r.id and tr.lang = 'tr'
  left join lateral (select 1 as hit from public.visits v
                     where v.place_id = p.id and v.user_id = p_user and not v.flagged limit 1) vv on true
  where p_user is not null and r.is_published
  group by r.id, r.slug, t.title, tr.title
  having count(vv.hit) > 0 and count(vv.hit) < count(*);
$$;

create or replace function public.recommendations(
  lat double precision default null,
  lng double precision default null,
  lang text default 'tr',
  max_results integer default 10
)
returns jsonb
language plpgsql
stable
set search_path = public, extensions
as $$
declare
  uid uuid := auth.uid();
  l text := public.norm_lang(recommendations.lang);
  me geography;
  total_visits int := 0;
  max_pop numeric;
  places_json jsonb;
  routes_json jsonb := '[]'::jsonb;
  badges_json jsonb := '[]'::jsonb;
begin
  if (recommendations.lat is null) <> (recommendations.lng is null)
     or recommendations.lat not between -90 and 90
     or recommendations.lng not between -180 and 180 then
    return jsonb_build_object('ok', false, 'error', 'invalid_input');
  end if;
  if recommendations.lat is not null then
    me := st_setsrid(st_makepoint(recommendations.lng, recommendations.lat), 4326)::geography;
  end if;
  select greatest(max(p.popularity), 1) into max_pop from public.places p where p.is_published;
  if uid is not null then
    select count(*) into total_visits from public.visits v where v.user_id = uid and not v.flagged;
  end if;

  -- Yerler
  with ob as materialized (select * from public.rec_open_badges(uid, l)),
  orr as materialized (select * from public.rec_open_routes(uid, l)),
  cand as (
    select p.id, p.slug, p.kind, c.slug as category, p.location, p.popularity,
           tt.name, tt.short_desc,
           case when me is null then null else st_distance(p.location, me) end as dist
    from public.places p
    join public.categories c on c.id = p.category_id
    join public.place_translations tt on tt.place_id = p.id and tt.lang = l
    where p.is_published
      and (me is null or st_dwithin(p.location, me, 30000))
      and (uid is null or not exists (select 1 from public.visits v
                                      where v.place_id = p.id and v.user_id = uid and not v.flagged))
  ),
  taste as (
    select c.slug as category, count(*)::numeric / greatest(total_visits, 1) as share
    from public.visits v
    join public.places p on p.id = v.place_id
    join public.categories c on c.id = p.category_id
    where uid is not null and v.user_id = uid and not v.flagged
    group by c.slug
  ),
  scored as (
    select cand.*,
           coalesce(ta.share, 0) as cat_share,
           rr.title as route_title,
           (select b.name from ob b
             where (b.rule ->> 'type' = 'category_count' and b.rule ->> 'category' = cand.category)
                or (b.rule ->> 'type' = 'kind_count' and b.rule ->> 'kind' = cand.kind::text)
             order by b.progress::numeric / b.target desc limit 1) as badge_name,
           0.45 * cand.popularity / max_pop
           + case when cand.dist is null then 0.15 else 0.35 * exp(-cand.dist / 3000.0) end
           + 0.30 * coalesce(ta.share, 0)
           + case when rr.title is null then 0
                  when cand.dist is null then 0.50
                  else 0.50 * (0.4 + 0.6 * exp(-cand.dist / 5000.0)) end as score
    from cand
    left join taste ta on ta.category = cand.category
    left join lateral (select r.title from orr r where r.next_place = cand.id
                       order by r.visited::numeric / r.stops desc limit 1) rr on true
  ),
  final as (
    select s.*, s.score + case when s.badge_name is not null then 0.30 else 0 end as total
    from scored s
    order by s.score + case when s.badge_name is not null then 0.30 else 0 end desc, s.popularity desc
    limit least(greatest(coalesce(recommendations.max_results, 10), 1), 30)
  )
  select coalesce(jsonb_agg(jsonb_build_object(
           'place_id', f.id,
           'slug', f.slug,
           'name', f.name,
           'short_desc', f.short_desc,
           'kind', f.kind,
           'category', f.category,
           'latitude', st_y(f.location::geometry),
           'longitude', st_x(f.location::geometry),
           'distance_m', round(f.dist)::int,
           'thumb_url', (select coalesce(ph.thumb_url, ph.url) from public.place_photos ph
                         where ph.place_id = f.id and ph.url is not null order by ph.sort_order limit 1),
           'reason', case
             when f.route_title is not null then 'route'
             when f.badge_name is not null then 'badge'
             when f.cat_share >= 0.2 and total_visits >= 3 then 'similar'
             when f.dist is not null and f.dist <= 1500 then 'nearby'
             else 'popular' end,
           'reason_detail', coalesce(f.route_title, f.badge_name)) order by f.total desc, f.popularity desc),
         '[]'::jsonb)
  into places_json
  from final f;

  if uid is not null then
    select coalesce(jsonb_agg(jsonb_build_object(
             'slug', r.slug,
             'title', r.title,
             'visited_count', r.visited,
             'stop_count', r.stops,
             'next_stop', jsonb_build_object(
               'place_id', p.id,
               'slug', p.slug,
               'name', t.name,
               'latitude', st_y(p.location::geometry),
               'longitude', st_x(p.location::geometry),
               'distance_m', case when me is null then null else round(st_distance(p.location, me))::int end))
           order by r.visited::numeric / r.stops desc, r.slug), '[]'::jsonb)
    into routes_json
    from (select * from public.rec_open_routes(uid, l) x order by visited::numeric / stops desc, slug limit 3) r
    join public.places p on p.id = r.next_place
    join public.place_translations t on t.place_id = p.id and t.lang = l;

    select coalesce(jsonb_agg(jsonb_build_object(
             'slug', b.slug, 'name', b.name, 'badge_path', b.badge_path,
             'progress', b.progress, 'target', b.target)
           order by b.progress::numeric / b.target desc, b.slug), '[]'::jsonb)
    into badges_json
    from (select * from public.rec_open_badges(uid, l) x
          where progress::numeric / target >= 0.5
          order by progress::numeric / target desc, slug limit 3) b;
  end if;

  return jsonb_build_object(
    'ok', true,
    'personalized', uid is not null and total_visits > 0,
    'places', places_json,
    'continue_routes', routes_json,
    'almost_badges', badges_json);
end;
$$;

grant execute on function public.recommendations(double precision, double precision, text, integer),
  public.rec_open_badges(uuid, text), public.rec_open_routes(uuid, text)
  to anon, authenticated;
