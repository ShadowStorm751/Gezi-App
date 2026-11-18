# Backend (Supabase)

Sahibi: Claude. Sözleşme: [`../docs/API.md`](../docs/API.md).

```
backend/supabase/
├── migrations/
│   ├── 20261118120000_schema.sql     tablolar, PostGIS, yayın kontrolü
│   ├── 20261118120100_rls.sql        erişim kuralları
│   ├── 20261118120200_read_api.sql   okuma RPC'leri, rozet ilerlemesi, yıllık özet
│   ├── 20261118120300_checkin.sql    check-in iç fonksiyonları (yalnızca service role)
│   └── 20261118120400_storage.sql    depolama alanları
├── functions/checkin/
│   ├── index.ts                      Edge Function
│   ├── rules.ts                      karar kuralları (saf fonksiyonlar)
│   └── rules.test.ts                 kural testleri
└── seed.sql                          geliştirme verisi: 15 İstanbul yeri, 20 rozet
```

## İlk kurulum (proje sahibi)

1. [supabase.com](https://supabase.com) üzerinde proje aç. Bölge: **Central EU (Frankfurt)**.
2. Bilgisayarına [Supabase CLI](https://supabase.com/docs/guides/local-development/cli/getting-started) kur.
3. Bu klasörde:

   ```bash
   cd backend
   supabase init            # yalnızca ilk sefer: config.toml oluşturur, migrations'a dokunmaz
   supabase login
   supabase link --project-ref <proje-ref>
   supabase db push         # migration'ları uygular
   supabase functions deploy checkin
   ```

4. Geliştirme verisini yüklemek için Supabase panelindeki SQL Editor'da `seed.sql` içeriğini çalıştır.
5. Panelden **Project URL** ve **anon public key** değerlerini mobil tarafa ver (`mobile/.env`). `service_role` key kimseyle paylaşılmaz, repoya girmez.
6. Kendini admin yapmak için SQL Editor'da:

   ```sql
   update auth.users set raw_app_meta_data = raw_app_meta_data || '{"role":"admin"}'
   where email = '<senin e-postan>';
   ```

## Yerel geliştirme

Docker gerekir.

```bash
cd backend
supabase start          # yerel Postgres + Auth + Storage
supabase db reset       # migration'lar + seed.sql
supabase functions serve checkin
```

## Testler

```bash
# Check-in kuralları (Node 22.6+)
node --experimental-strip-types --test supabase/functions/checkin/rules.test.ts
```

SQL fonksiyonları 18 Kasım 2026'da Postgres 16 üzerinde, PostGIS fonksiyonları basit taklitlerle (haversine mesafe, yön) değiştirilerek senaryo testlerinden geçirildi: yakındaki yerler, arama, check-in akışı, rozetler, yıllık özet, RLS ve yetki retleri. Gerçek PostGIS ile ilk `supabase db reset` sonrası bir kez daha doğrulanmalı.

## Yeni rozet eklemek

Kod değişikliği gerekmez. Admin olarak `achievements` tablosuna kural JSON'u ile satır, `achievement_translations` tablosuna TR ve EN ad ekle. Kural türleri: [`../docs/TECHNICAL_PLAN.md`](../docs/TECHNICAL_PLAN.md#rozet-kuralları).
