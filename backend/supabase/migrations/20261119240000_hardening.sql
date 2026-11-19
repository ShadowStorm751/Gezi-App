-- Yayın öncesi sertleştirme (2026-11-19 backend denetimi).
-- 1. Gereksiz tablo yetkileri kaldırılır (TRUNCATE RLS'ye tabi değildir; anon hiç yazmaz).
-- 2. profiles: istemci yalnızca 4 sütunu değiştirebilir; avatar yolu her durumda kendi klasöründe olmalı.
-- 3. RLS ilkeleri: auth.uid() satır başına değil sorgu başına hesaplanır; "admin write" (FOR ALL)
--    SELECT ilkeleriyle çakışmasın diye insert/update/delete olarak bölünür.
-- 4. Yabancı anahtar indeksleri, rozet/yer fotoğrafı bucket sınırları.
-- 5. export_my_data: yayından kalkmış yerlerin ziyaretleri de dahil, kullanıcının bildirimleri eklendi (KVKK).

-- 1. Tablo yetkileri -------------------------------------------------------
revoke truncate, references, trigger on all tables in schema public from anon, authenticated;
revoke insert, update, delete on all tables in schema public from anon;
alter default privileges for role postgres in schema public
  revoke truncate, references, trigger on tables from anon, authenticated;
alter default privileges for role postgres in schema public
  revoke insert, update, delete on tables from anon;

-- 2. profiles ----------------------------------------------------------------
revoke update on public.profiles from authenticated;
grant update (username, avatar_path, is_public, preferred_lang) on public.profiles to authenticated;
alter table public.profiles
  add constraint profiles_avatar_path_own
  check (avatar_path is null or avatar_path like id::text || '/%');

-- 3. RLS ilkeleri ------------------------------------------------------------
drop policy "read public or own" on public.profiles;
create policy "read public or own" on public.profiles
  for select using (is_public or id = (select auth.uid()));

drop policy "update own" on public.profiles;
create policy "update own" on public.profiles
  for update to authenticated
  using (id = (select auth.uid())) with check (id = (select auth.uid()));

drop policy "read own" on public.visits;
create policy "read own" on public.visits
  for select to authenticated using (user_id = (select auth.uid()));

drop policy "read own" on public.user_achievements;
create policy "read own" on public.user_achievements
  for select to authenticated using (user_id = (select auth.uid()));

drop policy "read own" on public.place_submissions;
drop policy "admin read" on public.place_submissions;
create policy "read own or admin" on public.place_submissions
  for select to authenticated
  using (user_id = (select auth.uid()) or (select public.is_admin()));

do $$
declare
  t text;
begin
  foreach t in array array['cities', 'categories', 'category_translations', 'places',
                           'place_translations', 'place_photos', 'achievements',
                           'achievement_translations'] loop
    execute format('drop policy "admin write" on public.%I', t);
    execute format('create policy "admin insert" on public.%I for insert to authenticated '
                   'with check ((select public.is_admin()))', t);
    execute format('create policy "admin update" on public.%I for update to authenticated '
                   'using ((select public.is_admin())) with check ((select public.is_admin()))', t);
    execute format('create policy "admin delete" on public.%I for delete to authenticated '
                   'using ((select public.is_admin()))', t);
  end loop;
end $$;

-- 4. İndeksler ve bucket sınırları ------------------------------------------
create index if not exists place_submissions_place_idx on public.place_submissions (place_id);
create index if not exists place_submissions_created_place_idx on public.place_submissions (created_place_id);
create index if not exists place_submissions_category_idx on public.place_submissions (category_slug);
create index if not exists user_achievements_achievement_idx on public.user_achievements (achievement_id);

update storage.buckets
   set file_size_limit = 1048576, allowed_mime_types = array['image/webp', 'image/png']
 where id = 'badges';
update storage.buckets
   set file_size_limit = 5242880, allowed_mime_types = array['image/jpeg', 'image/png', 'image/webp']
 where id = 'place-photos';

-- 5. export_my_data ----------------------------------------------------------
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
      where s.user_id = auth.uid()), '[]'::jsonb)
  );
$$;
