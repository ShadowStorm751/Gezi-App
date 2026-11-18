-- Gezi App: check-in iç fonksiyonları
-- Bu fonksiyonlar yalnızca service role ile çağrılır (checkin Edge Function'ı).
-- İstemci rolleri (anon, authenticated) bunları çağıramaz.
-- Karar kuralları (doğruluk, mesafe, hız, sıklık) Edge Function'daki rules.ts içindedir;
-- SQL tarafı yalnızca ölçüm yapar ve kaydeder.

-- Check-in kararı için gereken ölçümler.
create or replace function public.checkin_context(
  p_user uuid,
  p_place uuid,
  p_lat double precision,
  p_lng double precision
)
returns jsonb
language plpgsql stable
security definer
set search_path = public, extensions
as $$
declare
  me geography := st_setsrid(st_makepoint(p_lng, p_lat), 4326)::geography;
  pl record;
  prev record;
begin
  select p.id, p.is_published, p.checkin_radius_m, p.location, p.area, ci.slug as city_slug
    into pl
  from public.places p
  join public.cities ci on ci.id = p.city_id
  where p.id = p_place;

  if not found or not pl.is_published then
    return jsonb_build_object('found', false);
  end if;

  -- Son ziyaret: hız kontrolü için o yerin şu anki konuma uzaklığı ve zamanı.
  select v.visited_at, st_distance(p2.location, me) as distance_m
    into prev
  from public.visits v
  join public.places p2 on p2.id = v.place_id
  where v.user_id = p_user
  order by v.visited_at desc
  limit 1;

  return jsonb_build_object(
    'found', true,
    'city_slug', pl.city_slug,
    'radius_m', pl.checkin_radius_m,
    'distance_m', st_distance(pl.location, me),
    'inside_area', coalesce(st_covers(pl.area, me), false),
    'already_visited', exists (
      select 1 from public.visits v where v.user_id = p_user and v.place_id = p_place),
    'recent_count', (
      select count(*) from public.visits v
      where v.user_id = p_user and v.visited_at > now() - interval '1 minute'),
    'previous', case
      when prev.visited_at is null then null
      else jsonb_build_object('visited_at', prev.visited_at, 'distance_m', prev.distance_m)
    end
  );
end;
$$;

-- Ziyareti kaydeder. Aynı yer zaten ziyaret edildiyse null döner.
create or replace function public.record_visit(
  p_user uuid,
  p_place uuid,
  p_distance_m real,
  p_accuracy_m real,
  p_flagged boolean
)
returns uuid
language sql volatile
security definer
set search_path = public
as $$
  insert into public.visits (user_id, place_id, method, distance_m, gps_accuracy_m, flagged)
  values (p_user, p_place, 'gps', p_distance_m, p_accuracy_m, p_flagged)
  on conflict (user_id, place_id) do nothing
  returning id;
$$;

-- Koşulu yeni sağlanan rozetleri verir; yeni kazanılan rozet id'lerini döner.
create or replace function public.evaluate_achievements(p_user uuid)
returns setof integer
language sql volatile
security definer
set search_path = public
as $$
  insert into public.user_achievements (user_id, achievement_id)
  select p_user, a.id
  from public.achievements a
  cross join lateral public.achievement_progress(p_user, a.rule) ap
  where a.is_active
    and ap.target > 0
    and ap.progress >= ap.target
    and not exists (
      select 1 from public.user_achievements ua
      where ua.user_id = p_user and ua.achievement_id = a.id)
  on conflict do nothing
  returning achievement_id;
$$;

revoke execute on function public.checkin_context(uuid, uuid, double precision, double precision)
  from public, anon, authenticated;
revoke execute on function public.record_visit(uuid, uuid, real, real, boolean)
  from public, anon, authenticated;
revoke execute on function public.evaluate_achievements(uuid)
  from public, anon, authenticated;

grant execute on function public.checkin_context(uuid, uuid, double precision, double precision)
  to service_role;
grant execute on function public.record_visit(uuid, uuid, real, real, boolean)
  to service_role;
grant execute on function public.evaluate_achievements(uuid)
  to service_role;
