-- Kullanıcı katkısı: mevcut yerler için hata bildirimi ve yeni yer önerisi.
-- Akış: kullanıcı report_place / suggest_place ile gönderir -> admin_submissions ile listelenir ->
-- admin_resolve_submission ile kabul/ret. Kabul edilen yeni yer, yayında olmayan bir yer olarak
-- eklenir (açıklamalar yazılıp yayına alınana kadar uygulamada görünmez).
-- Önerisi kabul edilen kullanıcıya 'city-helper' rozeti.

create type public.submission_kind as enum ('new_place', 'wrong_location', 'wrong_info', 'closed', 'duplicate');
create type public.submission_status as enum ('open', 'accepted', 'rejected');

create table public.place_submissions (
  id uuid primary key default gen_random_uuid(),
  user_id uuid references auth.users(id) on delete set null,   -- hesap silinince bildirim kalır, kimliksiz
  kind public.submission_kind not null,
  place_id uuid references public.places(id) on delete cascade,
  name text check (char_length(name) between 2 and 120),
  category_slug text references public.categories(slug),
  location extensions.geography(Point, 4326),
  note text check (char_length(note) <= 1000),
  lang text not null default 'tr' check (lang in ('tr', 'en')),
  status public.submission_status not null default 'open',
  admin_note text,
  created_place_id uuid references public.places(id) on delete set null,
  created_at timestamptz not null default now(),
  resolved_at timestamptz,
  constraint place_submissions_shape check (
    (kind = 'new_place' and place_id is null and name is not null
       and category_slug is not null and location is not null)
    or (kind <> 'new_place' and place_id is not null)
  )
);

create index place_submissions_status_idx on public.place_submissions (status, created_at);
create index place_submissions_user_idx on public.place_submissions (user_id, created_at desc);

alter table public.place_submissions enable row level security;

create policy "read own" on public.place_submissions
  for select to authenticated using (user_id = auth.uid());
create policy "admin read" on public.place_submissions
  for select to authenticated using (public.is_admin());

-- Yazma yalnızca aşağıdaki fonksiyonlarla.
revoke insert, update, delete on public.place_submissions from anon, authenticated;

-- Yönetici: uygulamada admin rolü ya da Supabase SQL Editor (postgres).
create or replace function public.can_admin()
returns boolean
language sql stable
set search_path = public
as $$
  select public.is_admin() or session_user in ('postgres', 'supabase_admin');
$$;

-- Türkçe harfleri sadeleştirerek slug üretir: 'Çamlıca Kulesi' -> 'camlica-kulesi'
create or replace function public.slugify(t text)
returns text
language sql immutable
set search_path = public
as $$
  select coalesce(nullif(trim(both '-' from left(
           regexp_replace(lower(translate(coalesce(t, ''), 'çÇğĞıIİöÖşŞüÜâÂîÎûÛ', 'ccggiiioossuuaaiiuu')),
                          '[^a-z0-9]+', '-', 'g'), 60)), ''), 'yer');
$$;

-- ---------------------------------------------------------------------------
-- Kullanıcı: mevcut yer için bildirim
-- kind: wrong_location | wrong_info | closed | duplicate
-- wrong_location için doğru konum (lat, lng) isteğe bağlıdır ama önerilir.
-- Dönüş: { ok: true, id } ya da { ok: false, error }
-- Hatalar: not_authenticated, invalid_input, place_not_found, rate_limited, already_reported
-- ---------------------------------------------------------------------------
create or replace function public.report_place(
  place_id uuid,
  kind text,
  note text default null,
  lat double precision default null,
  lng double precision default null,
  lang text default 'tr'
)
returns jsonb
language plpgsql volatile
security definer
set search_path = public, extensions
as $$
declare
  uid uuid := auth.uid();
  k public.submission_kind;
  new_id uuid;
begin
  if uid is null then
    return jsonb_build_object('ok', false, 'error', 'not_authenticated');
  end if;
  if report_place.kind not in ('wrong_location', 'wrong_info', 'closed', 'duplicate')
     or char_length(coalesce(report_place.note, '')) > 1000
     or (report_place.lat is null) <> (report_place.lng is null)
     or report_place.lat not between -90 and 90
     or report_place.lng not between -180 and 180 then
    return jsonb_build_object('ok', false, 'error', 'invalid_input');
  end if;
  k := report_place.kind::public.submission_kind;

  if not exists (select 1 from public.places p where p.id = report_place.place_id and p.is_published) then
    return jsonb_build_object('ok', false, 'error', 'place_not_found');
  end if;
  if (select count(*) from public.place_submissions s
      where s.user_id = uid and s.created_at > now() - interval '1 day') >= 20 then
    return jsonb_build_object('ok', false, 'error', 'rate_limited');
  end if;
  if exists (select 1 from public.place_submissions s
             where s.user_id = uid and s.place_id = report_place.place_id
               and s.kind = k and s.status = 'open') then
    return jsonb_build_object('ok', false, 'error', 'already_reported');
  end if;

  insert into public.place_submissions (user_id, kind, place_id, location, note, lang)
  values (uid, k, report_place.place_id,
          case when report_place.lat is null then null
               else st_setsrid(st_makepoint(report_place.lng, report_place.lat), 4326)::geography end,
          nullif(trim(report_place.note), ''), public.norm_lang(report_place.lang))
  returning id into new_id;

  return jsonb_build_object('ok', true, 'id', new_id);
end;
$$;

-- ---------------------------------------------------------------------------
-- Kullanıcı: yeni yer önerisi
-- category: categories.slug (ör. 'mosque', 'viewpoint')
-- Hizmet bölgesi: en yakın yayındaki yer 50 km içinde olmalı.
-- Dönüş: { ok: true, id, possible_duplicates: [{ id, slug, name, distance_m }] }
-- Hatalar: not_authenticated, invalid_input, unknown_category, outside_service_area,
--          rate_limited, already_reported
-- ---------------------------------------------------------------------------
create or replace function public.suggest_place(
  name text,
  category text,
  lat double precision,
  lng double precision,
  note text default null,
  lang text default 'tr'
)
returns jsonb
language plpgsql volatile
security definer
set search_path = public, extensions
as $$
declare
  uid uuid := auth.uid();
  pt geography;
  clean_name text := regexp_replace(trim(coalesce(suggest_place.name, '')), '\s+', ' ', 'g');
  new_id uuid;
  dups jsonb;
begin
  if uid is null then
    return jsonb_build_object('ok', false, 'error', 'not_authenticated');
  end if;
  if char_length(clean_name) not between 2 and 120
     or char_length(coalesce(suggest_place.note, '')) > 1000
     or suggest_place.lat is null or suggest_place.lng is null
     or suggest_place.lat not between -90 and 90
     or suggest_place.lng not between -180 and 180 then
    return jsonb_build_object('ok', false, 'error', 'invalid_input');
  end if;
  if not exists (select 1 from public.categories c where c.slug = suggest_place.category) then
    return jsonb_build_object('ok', false, 'error', 'unknown_category');
  end if;

  pt := st_setsrid(st_makepoint(suggest_place.lng, suggest_place.lat), 4326)::geography;

  if not exists (select 1 from public.places p
                 where p.is_published and st_dwithin(p.location, pt, 50000)) then
    return jsonb_build_object('ok', false, 'error', 'outside_service_area');
  end if;
  if (select count(*) from public.place_submissions s
      where s.user_id = uid and s.created_at > now() - interval '1 day') >= 20 then
    return jsonb_build_object('ok', false, 'error', 'rate_limited');
  end if;
  if exists (select 1 from public.place_submissions s
             where s.user_id = uid and s.kind = 'new_place' and s.status = 'open'
               and st_dwithin(s.location, pt, 50)) then
    return jsonb_build_object('ok', false, 'error', 'already_reported');
  end if;

  -- 150 m içindeki yayındaki yerler: kullanıcıya "bu mu?" diye gösterilebilir
  select coalesce(jsonb_agg(jsonb_build_object(
           'id', d.id, 'slug', d.slug, 'name', d.name, 'distance_m', round(d.dist)) order by d.dist), '[]'::jsonb)
    into dups
  from (
    select p.id, p.slug, t.name, st_distance(p.location, pt) as dist
    from public.places p
    join public.place_translations t
      on t.place_id = p.id and t.lang = public.norm_lang(suggest_place.lang)
    where p.is_published and st_dwithin(p.location, pt, 150)
    order by 4
    limit 5
  ) d;

  insert into public.place_submissions (user_id, kind, name, category_slug, location, note, lang)
  values (uid, 'new_place', clean_name, suggest_place.category, pt,
          nullif(trim(suggest_place.note), ''), public.norm_lang(suggest_place.lang))
  returning id into new_id;

  return jsonb_build_object('ok', true, 'id', new_id, 'possible_duplicates', dups);
end;
$$;

-- ---------------------------------------------------------------------------
-- Kullanıcı: kendi bildirim ve önerileri (yeniden eskiye)
-- ---------------------------------------------------------------------------
create or replace function public.my_submissions(lang text default 'tr')
returns table (
  id uuid,
  kind public.submission_kind,
  status public.submission_status,
  place_id uuid,
  place_name text,
  suggested_name text,
  admin_note text,
  created_at timestamptz,
  resolved_at timestamptz
)
language sql stable
set search_path = public
as $$
  select s.id, s.kind, s.status, coalesce(s.place_id, s.created_place_id), t.name, s.name,
         s.admin_note, s.created_at, s.resolved_at
  from public.place_submissions s
  left join public.place_translations t
    on t.place_id = coalesce(s.place_id, s.created_place_id) and t.lang = public.norm_lang(my_submissions.lang)
  where s.user_id = auth.uid()
  order by s.created_at desc
  limit 100;
$$;

-- ---------------------------------------------------------------------------
-- Yönetici: bekleyenleri listele
-- ---------------------------------------------------------------------------
create or replace function public.admin_submissions(
  only_status text default 'open',
  max_results integer default 100
)
returns table (
  id uuid,
  kind public.submission_kind,
  status public.submission_status,
  place_slug text,
  place_name text,
  suggested_name text,
  category_slug text,
  latitude double precision,
  longitude double precision,
  moved_m double precision,          -- wrong_location: önerilen konumun mevcut konuma uzaklığı
  note text,
  lang text,
  user_id uuid,
  user_accepted_before bigint,       -- bu kullanıcının daha önce kabul edilen katkıları
  created_at timestamptz
)
language plpgsql stable
security definer
set search_path = public, extensions
as $$
begin
  if not public.can_admin() then
    raise exception 'admin only' using errcode = '42501';
  end if;
  return query
    select s.id, s.kind, s.status, p.slug, t.name, s.name, s.category_slug,
           st_y(s.location::geometry), st_x(s.location::geometry),
           case when s.kind = 'wrong_location' and s.location is not null
                then round(st_distance(p.location, s.location)::numeric)::double precision end,
           s.note, s.lang, s.user_id,
           (select count(*) from public.place_submissions s2
            where s2.user_id = s.user_id and s2.status = 'accepted'),
           s.created_at
    from public.place_submissions s
    left join public.places p on p.id = s.place_id
    left join public.place_translations t on t.place_id = p.id and t.lang = 'tr'
    where admin_submissions.only_status is null or s.status::text = admin_submissions.only_status
    order by s.created_at
    limit least(greatest(admin_submissions.max_results, 1), 500);
end;
$$;

-- ---------------------------------------------------------------------------
-- Yönetici: kabul / ret
-- accept = true:
--   new_place      -> yayında olmayan yeni yer (TR ve EN adı önerilen ad; açıklama sonra yazılır)
--   wrong_location -> apply_change = true ise yerin konumu önerilen konuma taşınır
--   closed         -> apply_change = true ise yer yayından kaldırılır
--   wrong_info, duplicate -> otomatik değişiklik yok (düzeltme elle yapılır)
-- Kabulden sonra kullanıcının rozetleri yeniden değerlendirilir.
-- ---------------------------------------------------------------------------
create or replace function public.admin_resolve_submission(
  submission_id uuid,
  accept boolean,
  admin_note text default null,
  apply_change boolean default false
)
returns jsonb
language plpgsql volatile
security definer
set search_path = public, extensions
as $$
declare
  s public.place_submissions;
  new_place uuid;
  city int;
  base_slug text;
  final_slug text;
  i int := 1;
begin
  if not public.can_admin() then
    raise exception 'admin only' using errcode = '42501';
  end if;

  select * into s from public.place_submissions ps where ps.id = admin_resolve_submission.submission_id for update;
  if not found then
    return jsonb_build_object('ok', false, 'error', 'not_found');
  end if;
  if s.status <> 'open' then
    return jsonb_build_object('ok', false, 'error', 'already_resolved', 'status', s.status);
  end if;

  if accept then
    if s.kind = 'new_place' then
      select p.city_id into city
      from public.places p
      order by p.location <-> s.location
      limit 1;

      base_slug := public.slugify(s.name);
      final_slug := base_slug;
      while exists (select 1 from public.places p where p.slug = final_slug) loop
        i := i + 1;
        final_slug := base_slug || '-' || i;
      end loop;

      insert into public.places (city_id, category_id, slug, location, is_published)
      select city, c.id, final_slug, s.location, false
      from public.categories c where c.slug = s.category_slug
      returning id into new_place;

      insert into public.place_translations (place_id, lang, name)
      values (new_place, 'tr', s.name), (new_place, 'en', s.name);

    elsif s.kind = 'wrong_location' and apply_change then
      if s.location is null then
        return jsonb_build_object('ok', false, 'error', 'no_location_in_report');
      end if;
      update public.places set location = s.location where id = s.place_id;

    elsif s.kind = 'closed' and apply_change then
      update public.places set is_published = false where id = s.place_id;
    end if;
  end if;

  update public.place_submissions ps set
    status = case when accept then 'accepted'::public.submission_status else 'rejected'::public.submission_status end,
    admin_note = admin_resolve_submission.admin_note,
    created_place_id = new_place,
    resolved_at = now()
  where ps.id = s.id;

  if accept and s.user_id is not null then
    perform public.evaluate_achievements(s.user_id);
  end if;

  return jsonb_build_object('ok', true, 'status', case when accept then 'accepted' else 'rejected' end,
                            'created_place_id', new_place, 'created_place_slug', final_slug);
end;
$$;

revoke execute on function public.admin_submissions(text, integer) from public, anon;
revoke execute on function public.admin_resolve_submission(uuid, boolean, text, boolean) from public, anon;
revoke execute on function public.report_place(uuid, text, text, double precision, double precision, text) from public, anon;
revoke execute on function public.suggest_place(text, text, double precision, double precision, text, text) from public, anon;
grant execute on function public.report_place(uuid, text, text, double precision, double precision, text) to authenticated;
grant execute on function public.suggest_place(text, text, double precision, double precision, text, text) to authenticated;
grant execute on function public.admin_submissions(text, integer) to authenticated;
grant execute on function public.admin_resolve_submission(uuid, boolean, text, boolean) to authenticated;

-- ---------------------------------------------------------------------------
-- Rozet kuralı: accepted_submissions (kabul edilen katkı sayısı)
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

  elsif rule_type = 'accepted_submissions' then
    -- Kabul edilen öneri ve bildirimler (yeni yer, konum düzeltmesi vb.)
    return query
      select count(*)::int, n from public.place_submissions s
      where s.user_id = p_user and s.status = 'accepted';

  else
    return query select 0, 0;
  end if;
end;
$$;


insert into public.achievements (slug, rule, sort_order)
values ('city-helper', '{"type":"accepted_submissions","n":1}', 7)
on conflict (slug) do nothing;

insert into public.achievement_translations (achievement_id, lang, name, description)
select a.id, v.lang, v.name, v.description
from (values
  ('tr', 'Şehir Gönüllüsü', 'Bir önerin ya da düzeltmen kabul edildi.'),
  ('en', 'City Helper', 'One of your suggestions or corrections was accepted.')
) v(lang, name, description)
join public.achievements a on a.slug = 'city-helper'
on conflict (achievement_id, lang) do nothing;
