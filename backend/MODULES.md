# Backend modülleri

Backend tek bir Postgres şeması (`public`) içinde **modüllere** ayrılmıştır. Her modülün kendi tabloları, RPC'leri ve
migration'ları vardır; modüller birbirine yalnızca aşağıdaki **genişletme noktalarından** bağlanır.
Yeni özellik eklemeden önce bu dosyayı oku ve en alttaki kontrol listesini uygula.

## Modül haritası

| Modül | Tablolar | RPC / Edge Function | Migration'lar |
| --- | --- | --- | --- |
| **İçerik** (şehir, yer, fotoğraf) | `cities`, `categories`, `category_translations`, `places`, `place_translations`, `place_photos` | `city_pack`, `city_pack_version`, `city_pack_places`, `nearby_places`, `places_in_bbox`, `place_detail`, `search_places`, `list_cities`, `period_label` | `…18120000_schema`, `…120200_read_api`, `…19090000`–`…190000`, `…250000_cities_list`, `…20020000` |
| **Ziyaret / check-in** | `visits` | Edge `checkin` (+ `rules.ts`), `checkin_context`, `record_visit`, `my_visits` | `…120300_checkin` |
| **Rozetler** | `achievements`, `achievement_translations`, `user_achievements` | `evaluate_achievements`, `achievement_progress` (dağıtıcı), `ach_rule_*`, `my_achievements` | `…120300`, `…20040000_modular_rules_exports` |
| **Profil / hesap** | `profiles`, Storage `avatars` | `update_profile`, Edge `delete-account`, `export_my_data` (birleştirici), `export_section_*` | `…200000_account_avatar`, `…20040000` |
| **Katkı: bildirim ve öneri** | `place_submissions` | `report_place`, `suggest_place`, `my_submissions`, `admin_submissions`, `admin_resolve_submission` | `…210000_place_submissions` |
| **Katkı: fotoğraf** | `photo_submissions`, Storage `user-photos` | `submit_place_photo`, `my_photos`, `delete_my_photo`, `admin_photo_submissions`, `admin_resolve_photo`, Edge `photo-cleanup` | `…19330000_user_photos` |
| **Katkı: değerlendirme** | `place_reviews` | `review_place`, `delete_my_review`, `reviews_for_place`, `place_rating`, `my_reviews`, `admin_review_comments`, `admin_resolve_review` | `…20030000_place_reviews` |
| **Sosyal** | `friendships` | `search_users`, `send_friend_request`, `respond_friend_request`, `remove_friend`, `my_friends`, `friends_leaderboard`, `friend_accepted_achievements` | `…290000_friends`, `…300000_social_badges` |
| **Rotalar** | `routes`, `route_translations`, `route_stops` | `list_routes`, `route_detail`, `route_stops_for`, `route_summary_json` | `…260000_routes`, `…270000_istanbul_routes` |
| **Keşif** | – (okur) | `recommendations`, `rec_open_badges`, `rec_open_routes`, `my_summary`, `city_progress` | `…320000_recommendations` |
| **Altyapı** | `app_settings` | Edge `badge-upload`, Edge `content-apply` (içerik migration'ları), `can_admin`, `is_admin`, `norm_lang`, `slugify`, `search_norm` | – |

## Genişletme noktaları (ortak fonksiyonları yeniden yazma!)

| İhtiyaç | Yapılacak | Dokunulmayacak |
| --- | --- | --- |
| Yeni rozet **kural tipi** | `public.ach_rule_<tip>(p_user uuid, p_rule jsonb) returns table (progress int, target int)` yaz; rozeti `achievements.rule = {"type":"<tip>", ...}` ile ekle | `achievement_progress`, `evaluate_achievements` |
| Yeni rozet (mevcut kural tipiyle) | Yalnızca `achievements` + `achievement_translations` satırı, görsel (`assets/badges/`, `badge-upload` listesi) | Kural fonksiyonları |
| Yeni **kişisel veri** tablosu | `public.export_section_<anahtar>() returns jsonb` (SECURITY INVOKER, `auth.uid()`), `user_id … references auth.users on delete cascade`, dosya varsa `delete-account`'a bucket, `docs/VERI_ENVANTERI.md` | `export_my_data` |
| Yer detayına yeni alan | Yardımcı fonksiyon (ör. `place_rating(place_id) returns jsonb`) + `place_detail`'e tek satır | Diğer alanlar |
| Rozet tetikleyen yeni olay | Olayın RPC'sinde `perform public.evaluate_achievements(user_id)` | Edge `checkin` |
| Yönetici onayı | `admin_*` RPC'leri `can_admin()` ile; kullanıcıya `admin_note` ile neden | – |

`place_detail`, `my_summary` gibi tek parça RPC'leri değiştirmek gerekirse **repodaki dosyadan değil canlıdaki son tanımdan**
başla (`select pg_get_functiondef('public.place_detail'::regproc)`), çünkü birden çok migration onu yeniden tanımlamış olabilir.

## Kurallar (tüm modüller)

- **Tablo:** RLS açık; okuma politikası `(select auth.uid())` ile; `anon`'dan yazma yetkileri kaldırılır; istemci doğrudan yazmaz.
  Yönetici politikaları `admin insert / update / delete` olarak ayrı (SELECT ile çakışmasın). Her yabancı anahtara indeks.
- **Yazma RPC'si:** `security definer`, `set search_path = public`, başta `auth.uid()` kontrolü, `{ ok, error }` döner,
  günlük sınır (rate limit). `backend/README.md`'deki SECURITY DEFINER listesine eklenir.
- **Okuma RPC'si:** mümkünse `security invoker` (RLS geçerli), `lang` parametresi `norm_lang` ile.
- **Ad:** tablo ve RPC adı başka modüldekiyle çakışmasın; **aynı adla ikinci imza açma** (overload) — imza değişecekse önce `drop function`.
- **Kişisel veri:** silme (cascade), dışa aktarım (`export_section_*`), envanter (`docs/VERI_ENVANTERI.md`) üçü birden.

## Yeni özellik eklemeden önce kontrol listesi

1. **Denetimi çalıştır:** `backend/tests/audit.sql` → yalnızca `ozet` satırı kalmalı.
2. **Haritaya bak:** Bu iş mevcut bir modülün parçası mı? Aynı işi yapan tablo/RPC var mı? (`grep -rn "<ad>" backend/ docs/API.md`)
3. **Genişletme noktası seç:** Yukarıdaki tablodan; ortak fonksiyonu yeniden yazmak gerekiyorsa önce neden gerektiğini yaz.
4. **Migration:** Yeni zaman damgalı dosya (eskiler düzenlenmez). Tek konu.
5. **Yerel test:** `/home/claude/sqltest/run.sh` ile sıfırdan kurulum + senaryo testleri; davranışı değişmemesi gereken
   yerlerde önce/sonra **eşdeğerlik** karşılaştırması.
6. **Canlı:** `execute_sql` ile `begin; <migration>; insert into supabase_migrations.schema_migrations …; commit;`
   ardından denetim (`audit.sql`) ve güvenlik/performans danışmanları; akış değiştiyse ilgili `backend/tests/selftest-*.ts`.
7. **Belgeler aynı commit'te:** `docs/API.md` (sözleşme), `docs/REQUESTS.md` (mobil işi), `docs/VERI_ENVANTERI.md` (kişisel veri),
   `backend/README.md` (migration listesi), bu dosya (modül haritası), `docs/TECHNICAL_PLAN.md`.
