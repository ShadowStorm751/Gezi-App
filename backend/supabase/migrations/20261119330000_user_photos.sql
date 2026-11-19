-- Kullanıcı fotoğrafları: kullanıcı gezdiği yere fotoğraf yükler, yönetici onaylayınca yerde görünür.
--
-- Akış (mobil):
--   1. Dosyayı Storage 'user-photos' bucket'ına <user_id>/<rastgele>.jpg olarak yükle (en fazla 5 MB).
--   2. submit_place_photo(place_id, storage_path, caption) -> bekleyen gönderim.
--   3. Yönetici admin_resolve_photo ile onaylar -> place_photos'a eklenir, place_detail'de görünür.
--      Reddedilen ve 24 saatte gönderilmeyen dosyaları photo-cleanup Edge Function'ı siler.
-- Gizlilik: dosya adları tahmin edilemez; bucket herkese açık olsa da bekleyen fotoğrafın adresini
-- yalnızca yükleyen bilir. Hesap silinince gönderimler, onaylı fotoğraflar ve dosyalar da silinir.

-- Ayarlar: herkese açık Storage adresinin başı (proje başına farklı; canlı projede güncellenmeli)
create table if not exists public.app_settings (
  key text primary key,
  value text not null
);
alter table public.app_settings enable row level security;
revoke all on public.app_settings from anon, authenticated;
insert into public.app_settings (key, value) values
  ('storage_public_base', 'https://oxzypxygluqnwvtvqpil.supabase.co/storage/v1/object/public')
on conflict (key) do nothing;

-- Bucket ve Storage izinleri
insert into storage.buckets (id, name, public, file_size_limit, allowed_mime_types)
values ('user-photos', 'user-photos', true, 5242880, array['image/jpeg', 'image/png', 'image/webp'])
on conflict (id) do update set public = excluded.public, file_size_limit = excluded.file_size_limit,
  allowed_mime_types = excluded.allowed_mime_types;

create policy "user-photos: read own folder" on storage.objects
  for select to authenticated
  using (bucket_id = 'user-photos' and (storage.foldername(name))[1] = (select auth.uid())::text);
create policy "user-photos: upload to own folder" on storage.objects
  for insert to authenticated
  with check (bucket_id = 'user-photos' and (storage.foldername(name))[1] = (select auth.uid())::text);
create policy "user-photos: delete own folder" on storage.objects
  for delete to authenticated
  using (bucket_id = 'user-photos' and (storage.foldername(name))[1] = (select auth.uid())::text);

-- Gönderimler
create type public.photo_status as enum ('pending', 'approved', 'rejected');

create table public.photo_submissions (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  place_id uuid not null references public.places(id) on delete cascade,
  storage_path text not null unique,
  caption text check (char_length(caption) <= 200),
  status public.photo_status not null default 'pending',
  admin_note text,
  created_at timestamptz not null default now(),
  resolved_at timestamptz,
  files_deleted_at timestamptz
);
create index photo_submissions_user_idx on public.photo_submissions (user_id, created_at desc);
create index photo_submissions_status_idx on public.photo_submissions (status, created_at);
create index photo_submissions_place_idx on public.photo_submissions (place_id);

alter table public.photo_submissions enable row level security;
create policy "read own or admin" on public.photo_submissions
  for select to authenticated
  using (user_id = (select auth.uid()) or (select public.is_admin()));
revoke all on public.photo_submissions from anon;
revoke insert, update, delete, truncate, references, trigger on public.photo_submissions from authenticated;
grant select on public.photo_submissions to authenticated;

-- Onaylı kullanıcı fotoğrafı place_photos'ta; gönderim silinince fotoğraf da silinir
alter table public.place_photos
  add column submission_id uuid unique references public.photo_submissions(id) on delete cascade;

-- Gönder ----------------------------------------------------------------------
create or replace function public.submit_place_photo(
  place_id uuid,
  storage_path text,
  caption text default null
)
returns jsonb
language plpgsql
volatile
security definer
set search_path = public
as $$
declare
  uid uuid := auth.uid();
  new_id uuid;
begin
  if uid is null then
    return jsonb_build_object('ok', false, 'error', 'not_authenticated');
  end if;
  if submit_place_photo.storage_path is null
     or submit_place_photo.storage_path !~ ('^' || uid::text || '/[A-Za-z0-9_-]{8,64}\.(jpg|jpeg|png|webp)$')
     or char_length(coalesce(submit_place_photo.caption, '')) > 200 then
    return jsonb_build_object('ok', false, 'error', 'invalid_input');
  end if;
  if not exists (select 1 from public.places p where p.id = submit_place_photo.place_id and p.is_published) then
    return jsonb_build_object('ok', false, 'error', 'place_not_found');
  end if;
  if not exists (select 1 from storage.objects o
                 where o.bucket_id = 'user-photos' and o.name = submit_place_photo.storage_path) then
    return jsonb_build_object('ok', false, 'error', 'file_not_found');
  end if;
  if exists (select 1 from public.photo_submissions s where s.storage_path = submit_place_photo.storage_path) then
    return jsonb_build_object('ok', false, 'error', 'already_submitted');
  end if;
  if not exists (select 1 from public.visits v
                 where v.user_id = uid and v.place_id = submit_place_photo.place_id and not v.flagged) then
    return jsonb_build_object('ok', false, 'error', 'not_visited');
  end if;
  if (select count(*) from public.photo_submissions s
      where s.user_id = uid and s.created_at > now() - interval '1 day') >= 10 then
    return jsonb_build_object('ok', false, 'error', 'rate_limited');
  end if;
  if (select count(*) from public.photo_submissions s
      where s.user_id = uid and s.place_id = submit_place_photo.place_id and s.status = 'pending') >= 3 then
    return jsonb_build_object('ok', false, 'error', 'too_many_pending');
  end if;

  insert into public.photo_submissions (user_id, place_id, storage_path, caption)
  values (uid, submit_place_photo.place_id, submit_place_photo.storage_path,
          nullif(trim(submit_place_photo.caption), ''))
  returning id into new_id;
  return jsonb_build_object('ok', true, 'id', new_id, 'status', 'pending');
end;
$$;

-- Kullanıcının fotoğrafları ----------------------------------------------------
create or replace function public.my_photos(lang text default 'tr')
returns jsonb
language sql
stable
set search_path = public
as $$
  select coalesce(jsonb_agg(jsonb_build_object(
           'id', s.id,
           'place_id', s.place_id,
           'place_slug', p.slug,
           'place_name', t.name,
           'storage_path', s.storage_path,
           'caption', s.caption,
           'status', s.status,
           'admin_note', s.admin_note,
           'created_at', s.created_at,
           'resolved_at', s.resolved_at) order by s.created_at desc), '[]'::jsonb)
  from public.photo_submissions s
  left join public.places p on p.id = s.place_id
  left join public.place_translations t on t.place_id = s.place_id and t.lang = public.norm_lang(my_photos.lang)
  where s.user_id = auth.uid();
$$;

-- Kendi gönderimini sil (onaylıysa yerden de kalkar). Dosyayı istemci Storage'dan siler;
-- silinmeyen dosyayı photo-cleanup temizler.
create or replace function public.delete_my_photo(photo_id uuid)
returns jsonb
language plpgsql
volatile
security definer
set search_path = public
as $$
declare
  uid uuid := auth.uid();
  path text;
begin
  if uid is null then
    return jsonb_build_object('ok', false, 'error', 'not_authenticated');
  end if;
  delete from public.photo_submissions s
  where s.id = delete_my_photo.photo_id and s.user_id = uid
  returning s.storage_path into path;
  if path is null then
    return jsonb_build_object('ok', false, 'error', 'photo_not_found');
  end if;
  return jsonb_build_object('ok', true, 'storage_path', path);
end;
$$;

-- Yönetici -------------------------------------------------------------------------
create or replace function public.admin_photo_submissions(
  only_status text default 'pending',
  max_results integer default 100
)
returns jsonb
language plpgsql
stable
security definer
set search_path = public
as $$
declare
  base text := (select value from public.app_settings where key = 'storage_public_base');
begin
  if not public.can_admin() then
    raise exception 'admin only' using errcode = '42501';
  end if;
  return coalesce((
    select jsonb_agg(jsonb_build_object(
             'id', s.id, 'status', s.status, 'place', p.slug, 'place_name', t.name,
             'username', pr.username, 'caption', s.caption, 'created_at', s.created_at,
             'url', base || '/user-photos/' || s.storage_path) order by s.created_at)
    from (select * from public.photo_submissions x
          where admin_photo_submissions.only_status is null
             or x.status::text = admin_photo_submissions.only_status
          order by x.created_at
          limit least(greatest(coalesce(admin_photo_submissions.max_results, 100), 1), 500)) s
    join public.places p on p.id = s.place_id
    left join public.place_translations t on t.place_id = p.id and t.lang = 'tr'
    left join public.profiles pr on pr.id = s.user_id), '[]'::jsonb);
end;
$$;

create or replace function public.admin_resolve_photo(
  photo_id uuid,
  accept boolean,
  admin_note text default null
)
returns jsonb
language plpgsql
volatile
security definer
set search_path = public
as $$
declare
  s public.photo_submissions;
  base text := (select value from public.app_settings where key = 'storage_public_base');
  photo_url text;
  uname text;
begin
  if not public.can_admin() then
    raise exception 'admin only' using errcode = '42501';
  end if;
  select * into s from public.photo_submissions x where x.id = admin_resolve_photo.photo_id for update;
  if not found then
    return jsonb_build_object('ok', false, 'error', 'photo_not_found');
  end if;
  if s.status <> 'pending' then
    return jsonb_build_object('ok', false, 'error', 'already_resolved');
  end if;

  update public.photo_submissions x
     set status = case when admin_resolve_photo.accept then 'approved' else 'rejected' end::public.photo_status,
         admin_note = admin_resolve_photo.admin_note,
         resolved_at = now()
   where x.id = s.id;

  if admin_resolve_photo.accept then
    photo_url := base || '/user-photos/' || s.storage_path;
    select pr.username into uname from public.profiles pr where pr.id = s.user_id;
    insert into public.place_photos
      (place_id, url, thumb_url, license, author, sort_order, submission_id)
    values (s.place_id, photo_url, photo_url, 'Gezi App',
            coalesce('@' || uname, 'Gezi App kullanıcısı'),
            100 + (select count(*) from public.place_photos ph where ph.place_id = s.place_id),
            s.id);
    perform public.evaluate_achievements(s.user_id);
  end if;
  return jsonb_build_object('ok', true, 'status',
                            case when admin_resolve_photo.accept then 'approved' else 'rejected' end);
end;
$$;

revoke execute on function public.submit_place_photo(uuid, text, text), public.my_photos(text),
  public.delete_my_photo(uuid), public.admin_photo_submissions(text, integer),
  public.admin_resolve_photo(uuid, boolean, text)
  from public, anon;
grant execute on function public.submit_place_photo(uuid, text, text), public.my_photos(text),
  public.delete_my_photo(uuid), public.admin_photo_submissions(text, integer),
  public.admin_resolve_photo(uuid, boolean, text)
  to authenticated;

-- Rozet: ilk onaylı fotoğraf ---------------------------------------------------------
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
    return query
      select count(*)::int, n from public.place_submissions s
      where s.user_id = p_user and s.status = 'accepted';

  elsif rule_type = 'routes_completed' then
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

  elsif rule_type = 'approved_photos' then
    return query
      select count(*)::int, n from public.photo_submissions s
      where s.user_id = p_user and s.status = 'approved';

  else
    return query select 0, 0;
  end if;
end;
$$;

insert into public.achievements (slug, rule, sort_order) values
  ('photographer', '{"type":"approved_photos","n":1}', 11)
on conflict (slug) do nothing;

insert into public.achievement_translations (achievement_id, lang, name, description)
select a.id, v.lang, v.name, v.description
from (values
  ('photographer', 'tr', 'Gezi Fotoğrafçısı', 'Bir fotoğrafın onaylanıp yerde yayınlansın.'),
  ('photographer', 'en', 'Travel Photographer', 'Get one of your photos approved and published on a place.')
) v(slug, lang, name, description)
join public.achievements a on a.slug = v.slug
on conflict (achievement_id, lang) do nothing;

-- KVKK dışa aktarımına fotoğraflar -----------------------------------------------
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
      where f.requester_id = auth.uid() or f.addressee_id = auth.uid()), '[]'::jsonb),
    'photos', coalesce((
      select jsonb_agg(jsonb_build_object(
               'place', s.place_id,
               'storage_path', s.storage_path,
               'caption', s.caption,
               'status', s.status,
               'created_at', s.created_at,
               'resolved_at', s.resolved_at) order by s.created_at)
      from public.photo_submissions s
      where s.user_id = auth.uid()), '[]'::jsonb)
  );
$$;
