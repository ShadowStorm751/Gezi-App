# Backend (Supabase)

Sahibi: Claude. Sözleşme: [`../docs/API.md`](../docs/API.md).

```
backend/supabase/
├── migrations/
│   ├── 20261118120000_schema.sql     tablolar, PostGIS, yayın kontrolü
│   ├── 20261118120100_rls.sql        erişim kuralları
│   ├── 20261118120200_read_api.sql   okuma RPC'leri, rozet ilerlemesi, yıllık özet
│   ├── 20261118120300_checkin.sql    check-in iç fonksiyonları (yalnızca service role)
│   ├── 20261118120400_storage.sql    depolama alanları
│   ├── 20261119090000_city_pack_version.sql  içerik özetli paket sürümü
│   ├── 20261119100000_tomb_category.sql      türbe kategorisi ve rozeti
│   ├── 20261119110000_reference_data.sql     şehir, kategoriler, rozetler (kalıcı)
│   ├── 20261119120000_istanbul_places.sql    onaylı 156 İstanbul yeri (üretilir, elle düzenleme)
│   ├── 20261119130000_photo_urls.sql         fotoğraflar için dış adres alanları
│   ├── 20261119140000_istanbul_photos.sql    133 yerin Commons fotoğrafı (üretilir)
│   ├── 20261119150000_badge_paths.sql        rozet görsel yolları
│   ├── 20261119160000_security_fixes.sql     güvenlik denetçisi düzeltmeleri
│   ├── 20261119170000_islands_tour_fix.sql   Adalar Turu rozet kuralı düzeltmesi
│   ├── 20261119180000_search_ranking.sql     arama sıralaması, tanınırlık puanı
│   └── 20261119190000_city_pack_has_area.sql paket: alan tanımlı yer bilgisi
├── functions/badge-upload/              rozet görsellerini Storage'a yükler (.github/workflows/badges.yml)
├── functions/checkin/
│   ├── index.ts                      Edge Function
│   ├── rules.ts                      karar kuralları (saf fonksiyonlar)
│   └── rules.test.ts                 kural testleri
└── seed.sql                          yalnızca yerel deneme verisi (şimdilik boş)
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

4. `supabase db push` İstanbul'un 156 yerini, kategorileri ve rozetleri de yükler; ayrıca bir şey çalıştırmaya gerek yok.
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
supabase db reset       # migration'lar (156 İstanbul yeri dahil)
supabase functions serve checkin
```

## Testler

```bash
# Check-in kuralları (Node 22.6+)
node --experimental-strip-types --test supabase/functions/checkin/rules.test.ts
```

SQL fonksiyonları 18 Kasım 2026'da Postgres 16 üzerinde, PostGIS fonksiyonları basit taklitlerle (haversine mesafe, yön) değiştirilerek senaryo testlerinden geçirildi: yakındaki yerler, arama, check-in akışı, rozetler, yıllık özet, RLS ve yetki retleri. Gerçek PostGIS ile ilk `supabase db reset` sonrası bir kez daha doğrulanmalı.

## Rozet görselleri

Kaynak: `assets/badges/*.webp`. Storage'a yükleme (bir kez, ve rozet eklenince):

```bash
supabase storage cp -r ../assets/badges ss:///badges --experimental
```

ya da Supabase panelinde **Storage → badges** içine dosyaları sürükle-bırak.

## Yeni rozet eklemek

Kod değişikliği gerekmez. Admin olarak `achievements` tablosuna kural JSON'u ile satır, `achievement_translations` tablosuna TR ve EN ad ekle. Kural türleri: [`../docs/TECHNICAL_PLAN.md`](../docs/TECHNICAL_PLAN.md#rozet-kuralları).
