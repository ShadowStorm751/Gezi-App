-- Backend denetimi: yeni özellik eklemeden ÖNCE ve SONRA çalıştır (Supabase SQL Editor ya da execute_sql).
-- Her satır bir kontrol; "sorun" sütunu boş olmayan satırlar düzeltilmeli. Ayrıntı: backend/MODULES.md
with
fns as (
  select p.oid, p.proname, pg_get_function_identity_arguments(p.oid) as args, p.prosecdef
  from pg_proc p join pg_namespace n on n.oid = p.pronamespace
  where n.nspname = 'public' and not exists (select 1 from pg_depend d where d.objid = p.oid and d.deptype = 'e')
),
checks as (
  -- 1) Aynı adla birden çok fonksiyon (overload): PostgREST hangisini çağıracağını şaşırır
  select 'overload' as kontrol, proname || ' (' || count(*) || ' imza: ' || string_agg(args, ' | ') || ')' as sorun
  from fns group by proname having count(*) > 1
  union all
  -- 2) RLS kapalı tablo
  select 'rls_kapali', c.relname
  from pg_class c join pg_namespace n on n.oid = c.relnamespace
  where n.nspname = 'public' and c.relkind = 'r' and not c.relrowsecurity
  union all
  -- 3) anon'un yazabildiği tablo
  select 'anon_yazma', table_name || ':' || privilege_type
  from information_schema.role_table_grants
  where grantee = 'anon' and table_schema = 'public' and privilege_type in ('INSERT', 'UPDATE', 'DELETE', 'TRUNCATE')
  union all
  -- 4) search_path'i sabitlenmemiş SECURITY DEFINER fonksiyon
  select 'definer_search_path', f.proname
  from fns f join pg_proc p on p.oid = f.oid
  where f.prosecdef and not exists (select 1 from unnest(coalesce(p.proconfig, '{}')) c where c like 'search_path=%')
  union all
  -- 5) Kural fonksiyonu olmayan rozet
  select 'rozet_kurali_yok', a.slug || ' (' || (a.rule ->> 'type') || ')'
  from public.achievements a
  where to_regprocedure(format('public.ach_rule_%s(uuid, jsonb)', a.rule ->> 'type')) is null
  union all
  -- 6) Görseli olmayan etkin rozet
  select 'rozet_gorseli_yok', a.slug
  from public.achievements a where a.is_active and a.badge_path is null
  union all
  -- 7) Kullanıcıya bağlı olup KVKK dışa aktarımında bölümü olmayan tablo (user_id/requester_id sütunu olanlar)
  select 'kvkk_bolumu_yok', c.table_name
  from information_schema.columns c
  where c.table_schema = 'public' and c.column_name in ('user_id', 'requester_id')
    and c.table_name not in ('place_submissions', 'photo_submissions', 'place_reviews', 'friendships',
                             'visits', 'user_achievements')   -- bölümü olanlar: export_section_* ile eşleşmeli
  union all
  -- 8) İndekssiz yabancı anahtar
  select 'fk_indeks_yok', con.conrelid::regclass || '.' || a.attname
  from pg_constraint con
  join pg_attribute a on a.attrelid = con.conrelid and a.attnum = con.conkey[1]
  where con.contype = 'f' and con.connamespace = 'public'::regnamespace
    and not exists (select 1 from pg_index i where i.indrelid = con.conrelid and i.indkey[0] = con.conkey[1])
)
select kontrol, sorun from checks
union all
select 'ozet', format('%s fonksiyon, %s tablo, %s rozet kuralı, %s KVKK bölümü',
  (select count(*) from fns),
  (select count(*) from pg_class c join pg_namespace n on n.oid = c.relnamespace where n.nspname = 'public' and c.relkind = 'r'),
  (select count(*) from fns where proname like 'ach\_rule\_%'),
  (select count(*) from fns where proname like 'export\_section\_%'))
order by 1;
