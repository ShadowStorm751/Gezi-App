-- Gezi App: erişim kuralları (Row Level Security)
-- İçerik: herkes okur, yalnızca admin yazar.
-- Ziyaret ve rozet: kullanıcı yalnızca kendi satırlarını okur; yazma yalnızca
-- checkin Edge Function'ı (service role) üzerinden yapılır.

alter table public.cities                   enable row level security;
alter table public.categories               enable row level security;
alter table public.category_translations    enable row level security;
alter table public.places                   enable row level security;
alter table public.place_translations       enable row level security;
alter table public.place_photos             enable row level security;
alter table public.profiles                 enable row level security;
alter table public.visits                   enable row level security;
alter table public.achievements             enable row level security;
alter table public.achievement_translations enable row level security;
alter table public.user_achievements        enable row level security;

-- İçerik tabloları: okuma -----------------------------------------------------

create policy "public read" on public.cities for select using (true);
create policy "public read" on public.categories for select using (true);
create policy "public read" on public.category_translations for select using (true);
create policy "public read" on public.achievement_translations for select using (true);

create policy "public read published" on public.places
  for select using (is_published or public.is_admin());

create policy "public read published" on public.place_translations
  for select using (
    exists (select 1 from public.places p
            where p.id = place_translations.place_id and (p.is_published or public.is_admin()))
  );

create policy "public read published" on public.place_photos
  for select using (
    exists (select 1 from public.places p
            where p.id = place_photos.place_id and (p.is_published or public.is_admin()))
  );

create policy "public read active" on public.achievements
  for select using (is_active or public.is_admin());

-- İçerik tabloları: admin yazma -----------------------------------------------

create policy "admin write" on public.cities for all to authenticated
  using (public.is_admin()) with check (public.is_admin());
create policy "admin write" on public.categories for all to authenticated
  using (public.is_admin()) with check (public.is_admin());
create policy "admin write" on public.category_translations for all to authenticated
  using (public.is_admin()) with check (public.is_admin());
create policy "admin write" on public.places for all to authenticated
  using (public.is_admin()) with check (public.is_admin());
create policy "admin write" on public.place_translations for all to authenticated
  using (public.is_admin()) with check (public.is_admin());
create policy "admin write" on public.place_photos for all to authenticated
  using (public.is_admin()) with check (public.is_admin());
create policy "admin write" on public.achievements for all to authenticated
  using (public.is_admin()) with check (public.is_admin());
create policy "admin write" on public.achievement_translations for all to authenticated
  using (public.is_admin()) with check (public.is_admin());

-- Profiller ---------------------------------------------------------------------

create policy "read public or own" on public.profiles
  for select using (is_public or id = auth.uid());

create policy "update own" on public.profiles
  for update to authenticated
  using (id = auth.uid()) with check (id = auth.uid());

-- Ziyaretler ve kazanılan rozetler: yalnızca kendi satırların ------------------

create policy "read own" on public.visits
  for select to authenticated using (user_id = auth.uid());

create policy "read own" on public.user_achievements
  for select to authenticated using (user_id = auth.uid());

-- Fazladan güvenlik: istemci rolleri bu tablolara doğrudan yazamaz.
revoke insert, update, delete on public.visits from anon, authenticated;
revoke insert, update, delete on public.user_achievements from anon, authenticated;
revoke insert, delete on public.profiles from anon, authenticated;
