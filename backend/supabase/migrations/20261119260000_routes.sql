-- Hazır rotalar: sıralı duraklardan oluşan gezi önerileri (ör. "Sultanahmet Klasikleri").
-- Rota tamamlama = yayındaki tüm duraklarda geçerli (işaretlenmemiş) ziyaret.
-- Rozetler: 'route-first' (ilk rota), 'route-master' (5 rota). Ayrıntı: docs/API.md -> list_routes, route_detail.

create type public.route_mode as enum ('walking', 'mixed', 'ferry', 'driving');

create table public.routes (
  id serial primary key,
  slug text not null unique check (slug ~ '^[a-z0-9-]+$'),
  city_id int not null references public.cities(id) on delete cascade,
  kind text not null check (kind in ('historical', 'nature', 'mixed')),
  travel_mode public.route_mode not null,
  est_minutes int not null check (est_minutes > 0),   -- gezme dahil yaklaşık toplam süre
  sort_order int not null default 0,
  is_published boolean not null default false,
  created_at timestamptz not null default now()
);
create index routes_city_idx on public.routes (city_id, sort_order);

create table public.route_translations (
  route_id int not null references public.routes(id) on delete cascade,
  lang text not null check (lang in ('tr', 'en')),
  title text not null check (char_length(title) between 3 and 80),
  summary text not null check (char_length(summary) between 10 and 400),
  primary key (route_id, lang)
);

create table public.route_stops (
  route_id int not null references public.routes(id) on delete cascade,
  position int not null check (position > 0),
  place_id uuid not null references public.places(id) on delete cascade,
  primary key (route_id, position),
  unique (route_id, place_id)
);
create index route_stops_place_idx on public.route_stops (place_id);

-- RLS --------------------------------------------------------------------------
alter table public.routes enable row level security;
alter table public.route_translations enable row level security;
alter table public.route_stops enable row level security;

create policy "public read published" on public.routes
  for select using (is_published or (select public.is_admin()));
create policy "public read published" on public.route_translations
  for select using (exists (select 1 from public.routes r where r.id = route_id
                            and (r.is_published or (select public.is_admin()))));
create policy "public read published" on public.route_stops
  for select using (exists (select 1 from public.routes r where r.id = route_id
                            and (r.is_published or (select public.is_admin()))));

do $$
declare
  t text;
begin
  foreach t in array array['routes', 'route_translations', 'route_stops'] loop
    execute format('create policy "admin insert" on public.%I for insert to authenticated '
                   'with check ((select public.is_admin()))', t);
    execute format('create policy "admin update" on public.%I for update to authenticated '
                   'using ((select public.is_admin())) with check ((select public.is_admin()))', t);
    execute format('create policy "admin delete" on public.%I for delete to authenticated '
                   'using ((select public.is_admin()))', t);
  end loop;
end $$;

revoke truncate, references, trigger on public.routes, public.route_translations, public.route_stops
  from anon, authenticated;
revoke insert, update, delete on public.routes, public.route_translations, public.route_stops
  from anon;
grant select on public.routes, public.route_translations, public.route_stops to anon, authenticated;

-- Okuma fonksiyonları ----------------------------------------------------------

-- Bir rotanın yayındaki durakları, sırasıyla; ziyaret bilgisi giriş yapan kullanıcı için (girişsizse null).
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
           'visited', case when auth.uid() is null then null else s.visited end) order by s.n), '[]'::jsonb)
  from (
    select row_number() over (order by rs.position) as n,
           p.id as place_id, p.slug, t.name, p.kind, c.slug as category, p.location,
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
                  where e ->> 'thumb_url' is not null limit 1),
    'visited_count', case when auth.uid() is null then null else
      (select count(*) from jsonb_array_elements(p_stops) e where (e ->> 'visited')::boolean)::int end,
    'completed', case when auth.uid() is null then null else
      jsonb_array_length(p_stops) > 0
      and not exists (select 1 from jsonb_array_elements(p_stops) e where not (e ->> 'visited')::boolean) end)
  from (select 1) one
  left join public.route_translations t on t.route_id = r.id and t.lang = public.norm_lang(p_lang)
  left join public.route_translations tr on tr.route_id = r.id and tr.lang = 'tr';
$$;

create or replace function public.list_routes(city_slug text default 'istanbul', lang text default 'tr')
returns jsonb
language sql
stable
set search_path = public
as $$
  select coalesce(jsonb_agg(public.route_summary_json(r, list_routes.lang,
                    public.route_stops_for(r.id, list_routes.lang))
                  order by r.sort_order, r.slug), '[]'::jsonb)
  from public.routes r
  join public.cities ci on ci.id = r.city_id
  where ci.slug = list_routes.city_slug and r.is_published;
$$;

create or replace function public.route_detail(route_slug text, lang text default 'tr')
returns jsonb
language sql
stable
set search_path = public
as $$
  select public.route_summary_json(r, route_detail.lang, st.stops) || jsonb_build_object('stops', st.stops)
  from public.routes r
  cross join lateral (select public.route_stops_for(r.id, route_detail.lang) as stops) st
  where r.slug = route_detail.route_slug and r.is_published;
$$;

grant execute on function public.list_routes(text, text), public.route_detail(text, text),
  public.route_stops_for(int, text), public.route_summary_json(public.routes, text, jsonb)
  to anon, authenticated;

-- Rozet kuralı: routes_completed ---------------------------------------------
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

  else
    return query select 0, 0;
  end if;
end;
$$;

insert into public.achievements (slug, rule, sort_order) values
  ('route-first',  '{"type":"routes_completed","n":1}', 7),
  ('route-master', '{"type":"routes_completed","n":5}', 8)
on conflict (slug) do nothing;

insert into public.achievement_translations (achievement_id, lang, name, description)
select a.id, v.lang, v.name, v.description
from (values
  ('route-first',  'tr', 'Rotacı',       'Bir hazır rotanın bütün duraklarını gez.'),
  ('route-first',  'en', 'Route Taker',  'Visit every stop of a curated route.'),
  ('route-master', 'tr', 'Rota Ustası',  '5 hazır rotayı tamamla.'),
  ('route-master', 'en', 'Route Master', 'Complete 5 curated routes.')
) v(slug, lang, name, description)
join public.achievements a on a.slug = v.slug
on conflict (achievement_id, lang) do nothing;
