-- Modüler yapı: yeni özellik eklemek için büyük ortak fonksiyonları yeniden yazmak gerekmesin.
--
-- 1) Rozet kuralları: her kural tipi kendi fonksiyonu
--      public.ach_rule_<tip>(p_user uuid, p_rule jsonb) returns table (progress int, target int)
--    achievement_progress yalnızca dağıtıcıdır; yeni kural tipi = yeni ach_rule_* fonksiyonu.
--    Bilinmeyen tip (0, 0) döner (eskisi gibi).
-- 2) KVKK dışa aktarım: her modül kendi bölümünü verir
--      public.export_section_<anahtar>() returns jsonb   (auth.uid() ile, SECURITY INVOKER)
--    export_my_data bu adla başlayan tüm fonksiyonları bulup tek JSON'da birleştirir.
--    Yeni kişisel veri = yeni export_section_* fonksiyonu (+ docs/VERI_ENVANTERI.md).
-- 3) Kullanılmayan yardımcı are_friends kaldırıldı.
-- Dönen değerler ve imzalar değişmedi (geriye uyumlu).

-- 1) Rozet kuralları -----------------------------------------------------------------

create or replace function public.ach_rule_total_count(p_user uuid, p_rule jsonb)
returns table (progress integer, target integer)
language sql stable set search_path = public as $$
  select count(*)::int, coalesce((p_rule ->> 'n')::int, 1)
  from public.visits v
  where v.user_id = p_user and not v.flagged;
$$;

create or replace function public.ach_rule_kind_count(p_user uuid, p_rule jsonb)
returns table (progress integer, target integer)
language sql stable set search_path = public as $$
  select count(*)::int, coalesce((p_rule ->> 'n')::int, 1)
  from public.visits v
  join public.places p on p.id = v.place_id
  where v.user_id = p_user and not v.flagged
    and p.kind = (p_rule ->> 'kind')::public.place_kind;
$$;

create or replace function public.ach_rule_category_count(p_user uuid, p_rule jsonb)
returns table (progress integer, target integer)
language sql stable set search_path = public as $$
  select count(*)::int, coalesce((p_rule ->> 'n')::int, 1)
  from public.visits v
  join public.places p on p.id = v.place_id
  join public.categories c on c.id = p.category_id
  where v.user_id = p_user and not v.flagged
    and c.slug = p_rule ->> 'category';
$$;

create or replace function public.ach_rule_period_count(p_user uuid, p_rule jsonb)
returns table (progress integer, target integer)
language sql stable set search_path = public as $$
  select count(*)::int, coalesce((p_rule ->> 'n')::int, 1)
  from public.visits v
  join public.places p on p.id = v.place_id
  where v.user_id = p_user and not v.flagged
    and p.period = p_rule ->> 'period';
$$;

create or replace function public.ach_rule_city_complete(p_user uuid, p_rule jsonb)
returns table (progress integer, target integer)
language sql stable set search_path = public as $$
  select count(v.id)::int, count(p.id)::int
  from public.places p
  join public.cities ci on ci.id = p.city_id
  left join public.visits v
    on v.place_id = p.id and v.user_id = p_user and not v.flagged
  where ci.slug = p_rule ->> 'city'
    and p.is_published
    and (p_rule ->> 'kind' is null or p.kind = (p_rule ->> 'kind')::public.place_kind);
$$;

create or replace function public.ach_rule_place_set(p_user uuid, p_rule jsonb)
returns table (progress integer, target integer)
language sql stable set search_path = public as $$
  select count(v.id)::int, jsonb_array_length(p_rule -> 'places')
  from public.places p
  left join public.visits v
    on v.place_id = p.id and v.user_id = p_user and not v.flagged
  where p.slug in (select jsonb_array_elements_text(p_rule -> 'places'));
$$;

create or replace function public.ach_rule_time_of_day(p_user uuid, p_rule jsonb)
returns table (progress integer, target integer)
language sql stable set search_path = public as $$
  select count(*)::int, coalesce((p_rule ->> 'n')::int, 1)
  from public.visits v
  join public.places p on p.id = v.place_id
  join public.cities ci on ci.id = p.city_id
  join public.categories c on c.id = p.category_id
  where v.user_id = p_user and not v.flagged
    and (p_rule ->> 'category' is null or c.slug = p_rule ->> 'category')
    and (v.visited_at at time zone ci.timezone)::time
        between (p_rule ->> 'from')::time and (p_rule ->> 'to')::time;
$$;

-- En uzun ardışık hafta serisi (her hafta en az bir ziyaret)
create or replace function public.ach_rule_streak_weeks(p_user uuid, p_rule jsonb)
returns table (progress integer, target integer)
language sql stable set search_path = public as $$
  select coalesce(max(s.len), 0)::int, coalesce((p_rule ->> 'n')::int, 1)
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
$$;

create or replace function public.ach_rule_accepted_submissions(p_user uuid, p_rule jsonb)
returns table (progress integer, target integer)
language sql stable set search_path = public as $$
  select count(*)::int, coalesce((p_rule ->> 'n')::int, 1)
  from public.place_submissions s
  where s.user_id = p_user and s.status = 'accepted';
$$;

create or replace function public.ach_rule_routes_completed(p_user uuid, p_rule jsonb)
returns table (progress integer, target integer)
language sql stable set search_path = public as $$
  select count(*)::int, coalesce((p_rule ->> 'n')::int, 1)
  from (
    select r.id
    from public.routes r
    join public.route_stops rs on rs.route_id = r.id
    join public.places p on p.id = rs.place_id and p.is_published
    left join lateral (
      select 1 as hit from public.visits v
      where v.place_id = p.id and v.user_id = p_user and not v.flagged
      limit 1) vv on true
    where r.is_published
      and (p_rule ->> 'city' is null
           or r.city_id = (select ci.id from public.cities ci where ci.slug = p_rule ->> 'city'))
    group by r.id
    having count(*) > 0 and count(*) = count(vv.hit)
  ) done;
$$;

create or replace function public.ach_rule_friend_count(p_user uuid, p_rule jsonb)
returns table (progress integer, target integer)
language sql stable set search_path = public as $$
  select count(*)::int, coalesce((p_rule ->> 'n')::int, 1)
  from public.friendships f
  where f.status = 'accepted' and (f.requester_id = p_user or f.addressee_id = p_user);
$$;

create or replace function public.ach_rule_approved_photos(p_user uuid, p_rule jsonb)
returns table (progress integer, target integer)
language sql stable set search_path = public as $$
  select count(*)::int, coalesce((p_rule ->> 'n')::int, 1)
  from public.photo_submissions s
  where s.user_id = p_user and s.status = 'approved';
$$;

-- Dağıtıcı: kural tipine göre ach_rule_<tip> fonksiyonunu çağırır
create or replace function public.achievement_progress(p_user uuid, p_rule jsonb)
returns table (progress integer, target integer)
language plpgsql stable
set search_path = public
as $$
declare
  rule_type text := p_rule ->> 'type';
begin
  if rule_type is null or rule_type !~ '^[a-z_]+$'
     or to_regprocedure(format('public.ach_rule_%s(uuid, jsonb)', rule_type)) is null then
    return query select 0, 0;
    return;
  end if;
  return query execute format('select * from public.ach_rule_%s($1, $2)', rule_type) using p_user, p_rule;
end;
$$;

-- 2) KVKK dışa aktarım bölümleri ------------------------------------------------------

create or replace function public.export_section_profile()
returns jsonb language sql stable set search_path = public as $$
  select to_jsonb(pr) from public.profiles pr where pr.id = auth.uid();
$$;

create or replace function public.export_section_visits()
returns jsonb language sql stable set search_path = public as $$
  select coalesce(jsonb_agg(jsonb_build_object(
           'place', p.slug,
           'place_id', v.place_id,
           'visited_at', v.visited_at,
           'method', v.method,
           'distance_m', v.distance_m,
           'gps_accuracy_m', v.gps_accuracy_m) order by v.visited_at), '[]'::jsonb)
  from public.visits v left join public.places p on p.id = v.place_id
  where v.user_id = auth.uid();
$$;

create or replace function public.export_section_achievements()
returns jsonb language sql stable set search_path = public as $$
  select coalesce(jsonb_agg(jsonb_build_object('achievement', a.slug, 'earned_at', ua.earned_at)
                            order by ua.earned_at), '[]'::jsonb)
  from public.user_achievements ua join public.achievements a on a.id = ua.achievement_id
  where ua.user_id = auth.uid();
$$;

create or replace function public.export_section_submissions()
returns jsonb language sql stable set search_path = public, extensions as $$
  select coalesce(jsonb_agg(jsonb_build_object(
           'kind', s.kind,
           'place', s.place_id,
           'name', s.name,
           'category', s.category_slug,
           'lat', st_y(s.location::geometry),
           'lng', st_x(s.location::geometry),
           'note', s.note,
           'status', s.status,
           'admin_note', s.admin_note,
           'created_at', s.created_at,
           'resolved_at', s.resolved_at) order by s.created_at), '[]'::jsonb)
  from public.place_submissions s
  where s.user_id = auth.uid();
$$;

create or replace function public.export_section_friendships()
returns jsonb language sql stable set search_path = public as $$
  select coalesce(jsonb_agg(jsonb_build_object(
           'username', pr.username,
           'direction', case when f.requester_id = auth.uid() then 'sent' else 'received' end,
           'status', f.status,
           'created_at', f.created_at,
           'responded_at', f.responded_at) order by f.created_at), '[]'::jsonb)
  from public.friendships f
  left join public.profiles pr
    on pr.id = case when f.requester_id = auth.uid() then f.addressee_id else f.requester_id end
  where f.requester_id = auth.uid() or f.addressee_id = auth.uid();
$$;

create or replace function public.export_section_photos()
returns jsonb language sql stable set search_path = public as $$
  select coalesce(jsonb_agg(jsonb_build_object(
           'place', s.place_id,
           'storage_path', s.storage_path,
           'caption', s.caption,
           'status', s.status,
           'created_at', s.created_at,
           'resolved_at', s.resolved_at) order by s.created_at), '[]'::jsonb)
  from public.photo_submissions s
  where s.user_id = auth.uid();
$$;

create or replace function public.export_section_reviews()
returns jsonb language sql stable set search_path = public as $$
  select coalesce(jsonb_agg(jsonb_build_object(
           'place', r.place_id,
           'rating', r.rating,
           'comment', r.comment,
           'comment_status', r.comment_status,
           'created_at', r.created_at,
           'updated_at', r.updated_at) order by r.created_at), '[]'::jsonb)
  from public.place_reviews r
  where r.user_id = auth.uid();
$$;

-- Birleştirici: public.export_section_*() fonksiyonlarını bulur, anahtarı adın sonundan alır
create or replace function public.export_my_data()
returns jsonb
language plpgsql
stable
set search_path = public
as $$
declare
  result jsonb := jsonb_build_object('exported_at', now());
  fn record;
  part jsonb;
begin
  if auth.uid() is null then
    return result;  -- girişsiz: aktarılacak kişisel veri yok
  end if;
  for fn in
    select p.proname
    from pg_proc p
    join pg_namespace n on n.oid = p.pronamespace
    where n.nspname = 'public' and p.proname like 'export\_section\_%' and p.pronargs = 0
    order by p.proname
  loop
    execute format('select public.%I()', fn.proname) into part;
    result := result || jsonb_build_object(substr(fn.proname, length('export_section_') + 1), part);
  end loop;
  return result;
end;
$$;

-- Parçalar SECURITY INVOKER: RLS geçerli, yalnızca çağıranın kendi verisi okunur; girişsizken boş döner.
-- Bu yüzden varsayılan çalıştırma yetkileri (anon, authenticated) yeterli.

-- 3) Kullanılmayan yardımcı -----------------------------------------------------------
drop function if exists public.are_friends(uuid, uuid);
