-- Sosyal rozetler: 'first-friend' (Gezi Arkadaşı, 1 arkadaş) ve 'travel-crew' (Gezi Ekibi, 10 arkadaş).
-- Yeni rozet kuralı friend_count. Arkadaşlık kabul edildiği anda iki tarafın rozetleri değerlendirilir;
-- kabul eden tarafın yeni rozetleri yanıtta 'new_achievements' (slug listesi) olarak döner.

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

  elsif rule_type = 'accepted_submissions' then
    -- Kabul edilen öneri ve bildirimler (yeni yer, konum düzeltmesi vb.)
    return query
      select count(*)::int, n from public.place_submissions s
      where s.user_id = p_user and s.status = 'accepted';

  elsif rule_type = 'routes_completed' then
    -- Yayındaki tüm durakları gezilmiş yayında rotalar (isteğe bağlı: tek şehir).
    return query
      select count(*)::int, n
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

  elsif rule_type = 'friend_count' then
    return query
      select count(*)::int, n from public.friendships f
      where f.status = 'accepted' and (f.requester_id = p_user or f.addressee_id = p_user);

  else
    return query select 0, 0;
  end if;
end;
$$;

-- Arkadaşlık kabul edilince iki tarafın rozetlerini değerlendirir; çağıranın yeni rozetlerini döner.
create or replace function public.friend_accepted_achievements(me uuid, other uuid)
returns jsonb
language plpgsql
volatile
security definer
set search_path = public
as $$
declare
  mine jsonb;
begin
  select coalesce(jsonb_agg(a.slug order by a.sort_order), '[]'::jsonb) into mine
  from public.evaluate_achievements(me) e join public.achievements a on a.id = e;
  perform public.evaluate_achievements(other);
  return mine;
end;
$$;
revoke execute on function public.friend_accepted_achievements(uuid, uuid) from public, anon, authenticated;

create or replace function public.send_friend_request(username text)
returns jsonb
language plpgsql
volatile
security definer
set search_path = public
as $$
declare
  uid uuid := auth.uid();
  target uuid;
  existing public.friendships;
begin
  if uid is null then
    return jsonb_build_object('ok', false, 'error', 'not_authenticated');
  end if;
  if (select pr.username from public.profiles pr where pr.id = uid) is null then
    return jsonb_build_object('ok', false, 'error', 'username_required');
  end if;
  select pr.id into target from public.profiles pr
  where pr.username = lower(trim(send_friend_request.username));
  if target is null then
    return jsonb_build_object('ok', false, 'error', 'user_not_found');
  end if;
  if target = uid then
    return jsonb_build_object('ok', false, 'error', 'cannot_add_self');
  end if;

  select * into existing from public.friendships f
  where least(f.requester_id, f.addressee_id) = least(uid, target)
    and greatest(f.requester_id, f.addressee_id) = greatest(uid, target);

  if found then
    if existing.status = 'accepted' then
      return jsonb_build_object('ok', false, 'error', 'already_friends');
    elsif existing.requester_id = uid then
      return jsonb_build_object('ok', false, 'error', 'already_requested');
    else
      -- Karşı taraf istek göndermiş: kabul et
      if (select count(*) from public.friendships f
          where f.status = 'accepted' and (f.requester_id = uid or f.addressee_id = uid)) >= 500 then
        return jsonb_build_object('ok', false, 'error', 'friend_limit');
      end if;
      update public.friendships f set status = 'accepted', responded_at = now()
      where f.requester_id = target and f.addressee_id = uid;
      return jsonb_build_object('ok', true, 'status', 'accepted',
                                'new_achievements', public.friend_accepted_achievements(uid, target));
    end if;
  end if;

  if (select count(*) from public.friendships f
      where f.requester_id = uid and f.created_at > now() - interval '1 day') >= 30 then
    return jsonb_build_object('ok', false, 'error', 'rate_limited');
  end if;
  if (select count(*) from public.friendships f
      where f.status = 'accepted' and (f.requester_id = uid or f.addressee_id = uid)) >= 500 then
    return jsonb_build_object('ok', false, 'error', 'friend_limit');
  end if;

  insert into public.friendships (requester_id, addressee_id) values (uid, target);
  return jsonb_build_object('ok', true, 'status', 'pending');
end;
$$;

create or replace function public.respond_friend_request(username text, accept boolean)
returns jsonb
language plpgsql
volatile
security definer
set search_path = public
as $$
declare
  uid uuid := auth.uid();
  other uuid;
begin
  if uid is null then
    return jsonb_build_object('ok', false, 'error', 'not_authenticated');
  end if;
  select pr.id into other from public.profiles pr
  where pr.username = lower(trim(respond_friend_request.username));
  if other is null or not exists (
       select 1 from public.friendships f
       where f.requester_id = other and f.addressee_id = uid and f.status = 'pending') then
    return jsonb_build_object('ok', false, 'error', 'request_not_found');
  end if;

  if respond_friend_request.accept then
    if (select count(*) from public.friendships f
        where f.status = 'accepted' and (f.requester_id = uid or f.addressee_id = uid)) >= 500 then
      return jsonb_build_object('ok', false, 'error', 'friend_limit');
    end if;
    update public.friendships f set status = 'accepted', responded_at = now()
    where f.requester_id = other and f.addressee_id = uid;
    return jsonb_build_object('ok', true, 'status', 'accepted',
                              'new_achievements', public.friend_accepted_achievements(uid, other));
  else
    delete from public.friendships f where f.requester_id = other and f.addressee_id = uid;
    return jsonb_build_object('ok', true, 'status', 'declined');
  end if;
end;
$$;

insert into public.achievements (slug, rule, sort_order) values
  ('first-friend', '{"type":"friend_count","n":1}', 9),
  ('travel-crew',  '{"type":"friend_count","n":10}', 10)
on conflict (slug) do nothing;

insert into public.achievement_translations (achievement_id, lang, name, description)
select a.id, v.lang, v.name, v.description
from (values
  ('first-friend', 'tr', 'Gezi Arkadaşı', 'İlk arkadaşını ekle.'),
  ('first-friend', 'en', 'Travel Buddy',  'Add your first friend.'),
  ('travel-crew',  'tr', 'Gezi Ekibi',    '10 arkadaşa ulaş.'),
  ('travel-crew',  'en', 'Travel Crew',   'Reach 10 friends.')
) v(slug, lang, name, description)
join public.achievements a on a.slug = v.slug
on conflict (achievement_id, lang) do nothing;
