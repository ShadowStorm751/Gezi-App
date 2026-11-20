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
│   ├── 20261119140000_istanbul_photos.sql    otomatik eşleşen Commons fotoğrafları (üretilir)
│   ├── 20261119150000_badge_paths.sql        rozet görsel yolları
│   ├── 20261119160000_security_fixes.sql     güvenlik denetçisi düzeltmeleri
│   ├── 20261119170000_islands_tour_fix.sql   Adalar Turu rozet kuralı düzeltmesi
│   ├── 20261119180000_search_ranking.sql     arama sıralaması, tanınırlık puanı
│   ├── 20261119190000_city_pack_has_area.sql paket: alan tanımlı yer bilgisi
│   ├── 20261119200000_account_avatar.sql     profil fotoğrafı (avatars bucket)
│   ├── 20261119210000_place_submissions.sql  kullanıcı bildirimleri ve yer önerileri
│   ├── 20261119220000_city_helper_badge.sql  Şehir Gönüllüsü rozet görseli
│   ├── 20261119230000_istanbul_photos_extra.sql 18 yer için elle seçilmiş fotoğraf (üretilir)
│   ├── 20261119240000_hardening.sql          yayın öncesi yetki/RLS/indeks sertleştirmesi
│   ├── 20261119250000_cities_list.sql        şehir listesi (list_cities)
│   ├── 20261119260000_routes.sql             hazır rotalar: tablolar, RPC'ler, rota rozetleri
│   ├── 20261119270000_istanbul_routes.sql    İstanbul'un 11 rotası (üretilir: content/istanbul_routes.py)
│   ├── 20261119280000_route_badge_paths.sql  rota rozetlerinin görsel yolları
│   ├── 20261119290000_friends.sql            arkadaşlık, kullanıcı arama, arkadaş sıralaması
│   ├── 20261119300000_social_badges.sql      'Gezi Arkadaşı' ve 'Gezi Ekibi' rozetleri
│   ├── 20261119310000_social_badge_paths.sql sosyal rozetlerin görsel yolları
│   ├── 20261119320000_recommendations.sql    kişisel öneriler (recommendations)
│   ├── 20261119330000_user_photos.sql        kullanıcı fotoğrafları, onay, 'Gezi Fotoğrafçısı' rozeti
│   ├── 20261120010000_photographer_badge_path.sql rozet görsel yolu
│   ├── 20261120020000_period_labels_route_covers.sql dönem adı dile göre, rota kapağı en tanınmış duraktan
│   ├── 20261120030000_place_reviews.sql       yer değerlendirmeleri (yıldız + onaylı not)
│   ├── 20261120040000_modular_rules_exports.sql rozet kuralları ve KVKK bölümleri parçalara ayrıldı
│   ├── 20261120050000_istanbul_long_desc_1.sql   uzun açıklamalar, 1. parti (üretilir: content/build_long_desc.py)
│   ├── 2026112006…_istanbul_long_desc_N.sql     2-15. partiler (156/156); content-apply ile yüklenir
│   └── 20261120200000_istanbul_photos_extra2.sql 3 yer için hedefli aramayla seçilen fotoğraf (üretilir: content/build_photos_extra2.py)
├── functions/badge-upload/              rozet görsellerini Storage'a yükler (.github/workflows/badges.yml)
├── functions/checkin/
│   ├── index.ts                      Edge Function
│   ├── rules.ts                      karar kuralları (saf fonksiyonlar)
│   └── rules.test.ts                 kural testleri
└── seed.sql                          yalnızca yerel deneme verisi (şimdilik boş)
```

> **Yeni özellik eklemeden önce:** [`MODULES.md`](MODULES.md) (modül haritası, genişletme noktaları, kontrol listesi) ve `tests/audit.sql`.

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

## Kullanıcı önerilerini yönetmek

Kullanıcıların bildirimleri ve yeni yer önerileri `place_submissions` tablosunda bekler. En kolayı: Claude'a "önerilere bak" de; listeyi çıkarır, her biri için kararını sorar.

Elle (Supabase panelinde **SQL Editor**):

```sql
select * from admin_submissions();                         -- bekleyenler
select admin_resolve_submission('<id>', true, 'Teşekkürler');            -- kabul (yeni yer: yayında olmayan yer olarak eklenir)
select admin_resolve_submission('<id>', true, 'Düzeltildi', true);       -- kabul + değişikliği uygula (konum taşı / kapanan yeri gizle)
select admin_resolve_submission('<id>', false, 'Zaten listede');         -- ret
```

Kabul edilen yeni yer `is_published = false` ile eklenir; TR/EN kısa açıklaması yazılıp yayına alınınca uygulamada görünür.

Güvenlik denetçisi `report_place`, `suggest_place`, `admin_submissions`, `admin_resolve_submission` değerlendirme fonksiyonları (`review_place`, `delete_my_review`, `reviews_for_place`, `place_rating`, `admin_review_comments`, `admin_resolve_review`), fotoğraf fonksiyonları (`submit_place_photo`, `delete_my_photo`, `admin_photo_submissions`, `admin_resolve_photo`) ve arkadaşlık fonksiyonları (`search_users`, `send_friend_request`, `respond_friend_request`, `remove_friend`, `my_friends`, `friends_leaderboard`) için "SECURITY DEFINER" uyarısı verir: bilinçli. Kullanıcılar tabloya doğrudan yazamaz, yalnızca bu fonksiyonlarla (sınırlar ve doğrulamayla) yazar; yönetici fonksiyonları içeride yetki kontrolü yapar (canlı testte doğrulandı).

## Yeni rozet eklemek

Kod değişikliği gerekmez. Admin olarak `achievements` tablosuna kural JSON'u ile satır, `achievement_translations` tablosuna TR ve EN ad ekle. Kural türleri: [`../docs/TECHNICAL_PLAN.md`](../docs/TECHNICAL_PLAN.md#rozet-kuralları).

## Değerlendirme notlarını onaylama (yönetici)

```sql
select public.admin_review_comments('pending');               -- bekleyen notlar
select public.admin_resolve_review('<id>', true);             -- yayınla
select public.admin_resolve_review('<id>', false, 'hakaret'); -- reddet (puan kalır, not görünmez)
```

## Kullanıcı fotoğraflarını onaylama (yönetici)

Supabase → SQL Editor:

```sql
select public.admin_photo_submissions('pending');            -- bekleyenler, url ile
select public.admin_resolve_photo('<id>', true);             -- onayla
select public.admin_resolve_photo('<id>', false, 'bulanık'); -- reddet (neden kullanıcıya görünür)
```

Reddedilen ve 24 saattir gönderilmemiş dosyaları `photo-cleanup` Edge Function'ı siler
(`.github/workflows/photo-cleanup.yml`, her gün 03:17 UTC). Canlı (production) projeye geçince
`update public.app_settings set value = 'https://<yeni-ref>.supabase.co/storage/v1/object/public' where key = 'storage_public_base';`
ve iş akışlarındaki proje adresi güncellenmeli.

## İçerik migration'larını yükleme (content-apply)

Uzun açıklamalar gibi yalnızca veri içeren migration'lar `content-apply` Edge Function'ı ile yüklenir:
1. `python data-pipeline/content/build_long_desc.py <parti> <zaman_damgası>` → migration dosyası.
2. Dosyanın SHA-256'sı `functions/content-apply/index.ts` içindeki `ALLOWED` listesine eklenir ve fonksiyon yeniden yüklenir.
3. Dosya main'e gönderilince `.github/workflows/content-apply.yml` onu fonksiyona yollar; fonksiyon içerik birebir
   eşleşirse tek işlemde uygular ve `schema_migrations`'a kaydeder. Sonuç: `data-pipeline/results/content-apply.txt`.
Şema değişiklikleri bu yolla uygulanmaz.

