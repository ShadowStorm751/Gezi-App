-- Arkadaşlar ve arkadaşlar arası sıralama.
-- Akış: kullanıcı adıyla istek gönder -> karşı taraf kabul/ret -> arkadaşlar sıralamada görünür.
-- Tabloya doğrudan yazma yok; yalnızca aşağıdaki fonksiyonlar (sınır ve doğrulamayla).
-- Gizlilik: arkadaş olmayan biri yalnızca kullanıcı adını ve avatarını görebilir; ziyaret
-- sayıları yalnızca kabul edilmiş arkadaşlara ve sıralamada görünür.

create type public.friendship_status as enum ('pending', 'accepted');

create table public.friendships (
  requester_id uuid not null references auth.users(id) on delete cascade,
  addressee_id uuid not null references auth.users(id) on delete cascade,
  status public.friendship_status not null default 'pending',
  created_at timestamptz not null default now(),
  responded_at timestamptz,
  primary key (requester_id, addressee_id),
  check (requester_id <> addressee_id)
);
-- Aynı iki kişi arasında tek kayıt (yönü ne olursa olsun)
create unique index friendships_pair_uq on public.friendships
  (least(requester_id, addressee_id), greatest(requester_id, addressee_id));
create index friendships_addressee_idx on public.friendships (addressee_id, status);

alter table public.friendships enable row level security;
create policy "read own" on public.friendships
  for select to authenticated
  using (requester_id = (select auth.uid()) or addressee_id = (select auth.uid()));
revoke all on public.friendships from anon;
revoke insert, update, delete, truncate, references, trigger on public.friendships from authenticated;
grant select on public.friendships to authenticated;

-- Yardımcı: iki kullanıcı arkadaş mı?
create or replace function public.are_friends(a uuid, b uuid)
returns boolean
language sql
stable
set search_path = public
as $$
  select exists (select 1 from public.friendships f
                 where f.status = 'accepted'
                   and least(f.requester_id, f.addressee_id) = least(a, b)
                   and greatest(f.requester_id, f.addressee_id) = greatest(a, b));
$$;

-- Kullanıcı adına göre arama ----------------------------------------------------
-- Herkese açık profiller ada göre (önek) bulunur; gizli profiller yalnızca tam adla.
create or replace function public.search_users(query text, max_results int default 10)
returns jsonb
language plpgsql
stable
security definer
set search_path = public
as $$
declare
  uid uuid := auth.uid();
  q text := lower(trim(coalesce(search_users.query, '')));
begin
  if uid is null then
    return jsonb_build_object('ok', false, 'error', 'not_authenticated');
  end if;
  if char_length(q) < 2 or q !~ '^[a-z0-9_]+$' then
    return jsonb_build_object('ok', true, 'users', '[]'::jsonb);
  end if;
  return jsonb_build_object('ok', true, 'users', coalesce((
    select jsonb_agg(jsonb_build_object(
             'username', pr.username,
             'avatar_path', pr.avatar_path,
             'relation', case
               when f.status = 'accepted' then 'friend'
               when f.requester_id = uid then 'request_sent'
               when f.addressee_id = uid then 'request_received'
               else 'none' end)
           order by (pr.username = q) desc, pr.username)
    from (
      select * from public.profiles p
      where p.id <> uid and p.username is not null
        and (p.username = q or (p.is_public and p.username like q || '%'))
      order by (p.username = q) desc, p.username
      limit least(greatest(coalesce(search_users.max_results, 10), 1), 20)
    ) pr
    left join public.friendships f
      on least(f.requester_id, f.addressee_id) = least(pr.id, uid)
     and greatest(f.requester_id, f.addressee_id) = greatest(pr.id, uid)), '[]'::jsonb));
end;
$$;

-- İstek gönder ---------------------------------------------------------------
-- Karşı taraf zaten sana istek gönderdiyse doğrudan arkadaş olursunuz.
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
      return jsonb_build_object('ok', true, 'status', 'accepted');
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

-- Gelen isteği kabul et / reddet --------------------------------------------
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
    return jsonb_build_object('ok', true, 'status', 'accepted');
  else
    delete from public.friendships f where f.requester_id = other and f.addressee_id = uid;
    return jsonb_build_object('ok', true, 'status', 'declined');
  end if;
end;
$$;

-- Arkadaşlıktan çıkar ya da gönderilen isteği geri al ----------------------
create or replace function public.remove_friend(username text)
returns jsonb
language plpgsql
volatile
security definer
set search_path = public
as $$
declare
  uid uuid := auth.uid();
  other uuid;
  n int;
begin
  if uid is null then
    return jsonb_build_object('ok', false, 'error', 'not_authenticated');
  end if;
  select pr.id into other from public.profiles pr
  where pr.username = lower(trim(remove_friend.username));
  delete from public.friendships f
  where other is not null
    and least(f.requester_id, f.addressee_id) = least(uid, other)
    and greatest(f.requester_id, f.addressee_id) = greatest(uid, other)
    and (f.status = 'accepted' or f.requester_id = uid);
  get diagnostics n = row_count;
  if n = 0 then
    return jsonb_build_object('ok', false, 'error', 'not_friends');
  end if;
  return jsonb_build_object('ok', true);
end;
$$;

-- Arkadaş listesi ve bekleyen istekler -------------------------------------
create or replace function public.my_friends()
returns jsonb
language plpgsql
stable
security definer
set search_path = public
as $$
declare
  uid uuid := auth.uid();
begin
  if uid is null then
    return jsonb_build_object('ok', false, 'error', 'not_authenticated');
  end if;
  return jsonb_build_object(
    'ok', true,
    'friends', coalesce((
      select jsonb_agg(jsonb_build_object(
               'username', pr.username,
               'avatar_path', pr.avatar_path,
               'since', coalesce(f.responded_at, f.created_at),
               'total_places', (select count(distinct v.place_id) from public.visits v
                                where v.user_id = pr.id and not v.flagged),
               'badges', (select count(*) from public.user_achievements ua where ua.user_id = pr.id))
             order by pr.username)
      from public.friendships f
      join public.profiles pr
        on pr.id = case when f.requester_id = uid then f.addressee_id else f.requester_id end
      where f.status = 'accepted' and (f.requester_id = uid or f.addressee_id = uid)), '[]'::jsonb),
    'incoming', coalesce((
      select jsonb_agg(jsonb_build_object('username', pr.username, 'avatar_path', pr.avatar_path,
                                          'created_at', f.created_at) order by f.created_at desc)
      from public.friendships f join public.profiles pr on pr.id = f.requester_id
      where f.addressee_id = uid and f.status = 'pending'), '[]'::jsonb),
    'outgoing', coalesce((
      select jsonb_agg(jsonb_build_object('username', pr.username, 'avatar_path', pr.avatar_path,
                                          'created_at', f.created_at) order by f.created_at desc)
      from public.friendships f join public.profiles pr on pr.id = f.addressee_id
      where f.requester_id = uid and f.status = 'pending'), '[]'::jsonb));
end;
$$;

-- Arkadaşlar arası sıralama -------------------------------------------------
-- period: 'week' (pazartesiden beri), 'month', 'year', 'all'. Zaman dilimi: Europe/Istanbul.
-- Puan = dönemde gezilen farklı yer sayısı (işaretli ziyaretler sayılmaz). Eşitlikte kullanıcı adı.
create or replace function public.friends_leaderboard(period text default 'week', city_slug text default null)
returns jsonb
language plpgsql
stable
security definer
set search_path = public
as $$
declare
  uid uuid := auth.uid();
  since timestamptz;
  city int;
begin
  if uid is null then
    return jsonb_build_object('ok', false, 'error', 'not_authenticated');
  end if;
  if coalesce(friends_leaderboard.period, '') not in ('week', 'month', 'year', 'all') then
    return jsonb_build_object('ok', false, 'error', 'invalid_input');
  end if;
  since := case friends_leaderboard.period
    when 'all' then '-infinity'::timestamptz
    else date_trunc(friends_leaderboard.period, now() at time zone 'Europe/Istanbul')
         at time zone 'Europe/Istanbul' end;
  if friends_leaderboard.city_slug is not null then
    select ci.id into city from public.cities ci where ci.slug = friends_leaderboard.city_slug;
    if city is null then
      return jsonb_build_object('ok', false, 'error', 'invalid_input');
    end if;
  end if;

  return jsonb_build_object(
    'ok', true,
    'period', friends_leaderboard.period,
    'since', case when friends_leaderboard.period = 'all' then null else since end,
    'entries', coalesce((
      select jsonb_agg(jsonb_build_object(
               'rank', s.rnk, 'username', s.username, 'avatar_path', s.avatar_path,
               'places', s.places, 'is_me', s.id = uid) order by s.rnk, s.username)
      from (
        select m.id, pr.username, pr.avatar_path, m.places,
               rank() over (order by m.places desc) as rnk
        from (
          select u.id, (select count(distinct v.place_id)
                        from public.visits v
                        join public.places p on p.id = v.place_id
                        where v.user_id = u.id and not v.flagged and v.visited_at >= since
                          and (city is null or p.city_id = city)) as places
          from (
            select uid as id
            union
            select case when f.requester_id = uid then f.addressee_id else f.requester_id end
            from public.friendships f
            where f.status = 'accepted' and (f.requester_id = uid or f.addressee_id = uid)
          ) u
        ) m
        join public.profiles pr on pr.id = m.id
      ) s), '[]'::jsonb));
end;
$$;

revoke execute on function public.search_users(text, int), public.send_friend_request(text),
  public.respond_friend_request(text, boolean), public.remove_friend(text), public.my_friends(),
  public.friends_leaderboard(text, text), public.are_friends(uuid, uuid)
  from public, anon;
grant execute on function public.search_users(text, int), public.send_friend_request(text),
  public.respond_friend_request(text, boolean), public.remove_friend(text), public.my_friends(),
  public.friends_leaderboard(text, text), public.are_friends(uuid, uuid)
  to authenticated;

-- KVKK dışa aktarımına arkadaşlar --------------------------------------------
create or replace function public.export_my_data()
returns jsonb
language sql
stable
set search_path = public, extensions
as $$
  select jsonb_build_object(
    'exported_at', now(),
    'profile', (select to_jsonb(pr) from public.profiles pr where pr.id = auth.uid()),
    'visits', coalesce((
      select jsonb_agg(jsonb_build_object(
               'place', p.slug,
               'place_id', v.place_id,
               'visited_at', v.visited_at,
               'method', v.method,
               'distance_m', v.distance_m,
               'gps_accuracy_m', v.gps_accuracy_m) order by v.visited_at)
      from public.visits v left join public.places p on p.id = v.place_id
      where v.user_id = auth.uid()), '[]'::jsonb),
    'achievements', coalesce((
      select jsonb_agg(jsonb_build_object('achievement', a.slug, 'earned_at', ua.earned_at)
                       order by ua.earned_at)
      from public.user_achievements ua join public.achievements a on a.id = ua.achievement_id
      where ua.user_id = auth.uid()), '[]'::jsonb),
    'submissions', coalesce((
      select jsonb_agg(jsonb_build_object(
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
               'resolved_at', s.resolved_at) order by s.created_at)
      from public.place_submissions s
      where s.user_id = auth.uid()), '[]'::jsonb),
    'friendships', coalesce((
      select jsonb_agg(jsonb_build_object(
               'username', pr.username,
               'direction', case when f.requester_id = auth.uid() then 'sent' else 'received' end,
               'status', f.status,
               'created_at', f.created_at,
               'responded_at', f.responded_at) order by f.created_at)
      from public.friendships f
      left join public.profiles pr
        on pr.id = case when f.requester_id = auth.uid() then f.addressee_id else f.requester_id end
      where f.requester_id = auth.uid() or f.addressee_id = auth.uid()), '[]'::jsonb)
  );
$$;
