-- Gezi App: temel şema
-- Tarihi-kültürel ve doğa/manzara yerleri, ziyaretler, rozetler. TR + EN içerik.

create extension if not exists postgis with schema extensions;
create extension if not exists pg_trgm with schema extensions;

create type public.place_kind as enum ('historical', 'nature');
create type public.verify_method as enum ('gps', 'photo');

-- Admin: auth.users.raw_app_meta_data içinde {"role": "admin"} olan kullanıcı.
create or replace function public.is_admin()
returns boolean
language sql stable
set search_path = public
as $$
  select coalesce(auth.jwt() -> 'app_metadata' ->> 'role', '') = 'admin';
$$;

-- ---------------------------------------------------------------------------
-- Şehirler ve kategoriler
-- ---------------------------------------------------------------------------

create table public.cities (
  id serial primary key,
  slug text not null unique check (slug ~ '^[a-z0-9-]+$'),
  names jsonb not null,                          -- {"tr": "İstanbul", "en": "Istanbul"}
  timezone text not null default 'Europe/Istanbul',
  boundary extensions.geography(MultiPolygon, 4326),
  created_at timestamptz not null default now()
);

create table public.categories (
  id serial primary key,
  slug text not null unique check (slug ~ '^[a-z0-9_]+$'),
  kind public.place_kind not null,
  icon text,
  sort_order int not null default 0
);

create table public.category_translations (
  category_id int not null references public.categories(id) on delete cascade,
  lang text not null check (lang in ('tr', 'en')),
  name text not null,
  primary key (category_id, lang)
);

-- ---------------------------------------------------------------------------
-- Yerler
-- ---------------------------------------------------------------------------

create table public.places (
  id uuid primary key default gen_random_uuid(),
  city_id int not null references public.cities(id),
  category_id int not null references public.categories(id),
  kind public.place_kind not null,               -- kategoriden otomatik doldurulur
  slug text not null unique check (slug ~ '^[a-z0-9-]+$'),
  location extensions.geography(Point, 4326) not null,
  area extensions.geography(Polygon, 4326),      -- büyük alanlar: orman, koru, ada, ören yeri
  checkin_radius_m int not null default 75 check (checkin_radius_m between 20 and 5000),
  period text,                                   -- 'Bizans', 'Osmanlı', 'Ceneviz'; doğada boş
  built_year int,                                -- MS yıl; "en eski yapı" istatistiği için
  opening_hours jsonb,
  wikidata_id text unique,
  osm_id text,
  is_published boolean not null default false,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create index places_location_gix on public.places using gist (location);
create index places_area_gix on public.places using gist (area);
create index places_city_idx on public.places (city_id);
create index places_category_idx on public.places (category_id);

create table public.place_translations (
  place_id uuid not null references public.places(id) on delete cascade,
  lang text not null check (lang in ('tr', 'en')),
  name text not null,
  short_desc text,
  long_desc text,
  best_time text,                                -- doğa: 'Gün batımı', 'Nisan (lale zamanı)'
  primary key (place_id, lang)
);

create index place_translations_name_trgm on public.place_translations
  using gin (name extensions.gin_trgm_ops);

create table public.place_photos (
  id uuid primary key default gen_random_uuid(),
  place_id uuid not null references public.places(id) on delete cascade,
  storage_path text not null,                    -- Storage 'place-photos' bucket içindeki yol
  width int,
  height int,
  license text,                                  -- 'CC BY-SA 4.0'
  author text,
  source_url text,
  sort_order int not null default 0
);

create index place_photos_place_idx on public.place_photos (place_id, sort_order);

-- Kategori -> kind eşlemesi, updated_at ve yayın kontrolü.
-- Bir yer, TR ve EN adı + kısa açıklaması olmadan yayına alınamaz.
create or replace function public.places_before_write()
returns trigger
language plpgsql
set search_path = public
as $$
begin
  select c.kind into new.kind from public.categories c where c.id = new.category_id;
  new.updated_at := now();

  if new.is_published and (
    select count(*) from public.place_translations t
    where t.place_id = new.id and t.lang in ('tr', 'en') and t.short_desc is not null
  ) < 2 then
    raise exception 'Yer "%" TR ve EN çevirisi (ad + kısa açıklama) olmadan yayına alınamaz', new.slug
      using errcode = 'check_violation';
  end if;

  return new;
end;
$$;

create trigger places_before_write
  before insert or update on public.places
  for each row execute function public.places_before_write();

-- ---------------------------------------------------------------------------
-- Kullanıcılar
-- ---------------------------------------------------------------------------

create table public.profiles (
  id uuid primary key references auth.users(id) on delete cascade,
  username text unique check (username ~ '^[a-z0-9_]{3,20}$'),
  avatar_path text,
  is_public boolean not null default true,
  preferred_lang text not null default 'tr' check (preferred_lang in ('tr', 'en')),
  created_at timestamptz not null default now()
);

-- Yeni kayıt olan her kullanıcı için boş profil.
create or replace function public.handle_new_user()
returns trigger
language plpgsql
security definer
set search_path = public
as $$
begin
  insert into public.profiles (id) values (new.id) on conflict do nothing;
  return new;
end;
$$;

create trigger on_auth_user_created
  after insert on auth.users
  for each row execute function public.handle_new_user();

-- ---------------------------------------------------------------------------
-- Ziyaretler ve rozetler
-- ---------------------------------------------------------------------------

-- Gizlilik: kullanıcının kendi koordinatı saklanmaz; yalnızca yere olan mesafe ve GPS doğruluğu.
create table public.visits (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  place_id uuid not null references public.places(id) on delete cascade,
  visited_at timestamptz not null default now(),
  method public.verify_method not null default 'gps',
  distance_m real,
  gps_accuracy_m real,
  flagged boolean not null default false,        -- hız kontrolüne takıldı; rozetlere sayılmaz
  unique (user_id, place_id)                     -- MVP: her yer kişi başı bir kez sayılır
);

create index visits_user_time_idx on public.visits (user_id, visited_at desc);
create index visits_place_idx on public.visits (place_id);

create table public.achievements (
  id serial primary key,
  slug text not null unique check (slug ~ '^[a-z0-9-]+$'),
  rule jsonb not null,                           -- bkz. docs/TECHNICAL_PLAN.md "Rozet kuralları"
  badge_path text,                               -- Storage 'badges' bucket içindeki yol
  sort_order int not null default 0,
  is_active boolean not null default true
);

create table public.achievement_translations (
  achievement_id int not null references public.achievements(id) on delete cascade,
  lang text not null check (lang in ('tr', 'en')),
  name text not null,
  description text,
  primary key (achievement_id, lang)
);

create table public.user_achievements (
  user_id uuid not null references auth.users(id) on delete cascade,
  achievement_id int not null references public.achievements(id) on delete cascade,
  earned_at timestamptz not null default now(),
  primary key (user_id, achievement_id)
);
