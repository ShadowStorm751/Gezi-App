# İstekler ve notlar (Mobil ↔ Backend)

Mobil tarafın backend'den bir ihtiyacı olduğunda (yeni alan, yeni fonksiyon, hata) buraya yazılır. Backend tarafı yanıtlar ve durumu günceller. En yeni en üstte.

Biçim:

```
### <kısa başlık>
- Tarih: YYYY-AA-GG
- Kimden: mobil | backend | proje sahibi
- Durum: açık | yapılıyor | tamamlandı | reddedildi
- İstek: ne lazım ve neden (hangi ekran)
- Yanıt: (backend doldurur) ne yapıldı, API.md'de hangi bölüm
```

---

### Hesap silme, avatar ve kullanıcı katkısı ekranları
- Tarih: 2026-11-19
- Kimden: backend
- Durum: açık (mobil)
- İstek: Backend canlıda ve test edildi (migration `20261119200000`, `20261119210000`, fonksiyon `delete-account`). Mobilde gerekenler (ayrıntı `docs/API.md`):
  1. **Hesabımı sil** (Ayarlar/Profil): onay penceresi → `delete-account` (`confirm: "DELETE"`) → `signOut` + yerel önbelleği temizle. Mağaza zorunluluğu, yayından önce şart.
  2. **Avatar**: galeriden seç → 512 px'e küçült → `avatars/<user_id>/...` yükle → `update_profile({ avatar_path })`.
  3. **Bir sorun mu var?** (yer detayı): `report_place` — konum yanlış (haritada iğneyle doğru konum), bilgi yanlış, kapanmış, listede iki kez var; isteğe bağlı not.
  4. **Yer öner** (harita, uzun basma ya da + butonu): ad, kategori, konum, not → `suggest_place`; `possible_duplicates` doluysa "Bunlardan biri mi?" göster.
  5. **Katkılarım** (profil): `my_submissions` ile durumlar (bekliyor / kabul edildi / reddedildi) ve varsa yönetici notu.
  6. Yeni rozet `city-helper` (Şehir Gönüllüsü): görseli `assets/badges/city-helper.webp` (22. rozet); `badgeImages.js` listesine eklenmeli.
  - SDK 58 yükseltmesinden sonra yapılabilir.
- Yanıt: –

### Expo SDK yükseltmesi (iPhone'da Expo Go ile test için)
- Tarih: 2026-11-19
- Kimden: backend (proje sahibinin isteğiyle)
- Durum: açık (mobil)
- İstek: Proje sahibi uygulamayı **iPhone'da App Store Expo Go** ile deneyecek. Mobil proje Expo SDK 54'te (`expo ~54.0.37`), App Store'daki Expo Go ise yalnızca en son SDK'yı açıyor (Kasım 2026: 57, 58'e geçiş haftalar içinde). iOS'ta eski Expo Go kurulamıyor, bu yüzden projenin yükseltilmesi gerekiyor:
  - **Hedef: SDK 58** (proje sahibinin iPhone'undaki Expo Go SDK 58 destekliyor, 2026-11-19).
  - Expo'nun önerisiyle bir seferde bir sürüm: `npx expo install expo@^55.0.0 --fix` → `npx expo-doctor` → test, sonra 56, 57 ve 58.
  - Dikkat: `react-native-maps`, `react-native-svg`, `expo-camera`, `expo-sensors`, `expo-location` sürümleri `--fix` ile hizalanmalı. SDK 58 iOS 27 için scene life cycle değişikliği getiriyor.
  - `npm test` geçmeli; uygulama Expo Go'da açılmalı (harita, kamera, Buradayım, Rozetler).
  - Backend tarafında değişiklik gerekmiyor.
- Yanıt: –

### Check-in ekranı ("Buradayım" butonu)
- Tarih: 2026-11-19
- Kimden: backend (proje sahibinin isteğiyle)
- Durum: tamamlandı (mobil kodu; saha testi bekliyor)
- İstek: Uygulamanın ana özelliği eksik: kullanıcı bir yere gidince ziyaretini kaydedemiyor, bu yüzden rozetler hep 0'da kalıyor. Sunucu tarafı hazır ve canlıda test edildi (`checkin` Edge Function, sözleşme: `docs/API.md` → "Check-in"). İstenen davranış:

  **1. Buton nerede**
  - Yer detayında (`place_detail` modalı), açıklamanın altında büyük bir "Buradayım / I'm here" butonu.
  - İsteğe bağlı: kamera ekranında takip edilen yere yeterince yakınken aynı buton.

  **2. Butonun durumu (çevrimdışı ön kontrol, karar her zaman sunucuda)**
  - Konum izni yoksa: buton "Konumu aç / Turn on location" olur, basınca izin ister.
  - Giriş yapılmamışsa: buton görünür; basınca Rozetler ekranındaki giriş formunu aç, girişten sonra check-in'i kendiliğinden tekrar dene.
  - Uzaklık ipucu (pakette `checkin_radius_m` ve yeni `has_area` alanı var):
    - `has_area: false` ve mesafe > `checkin_radius_m + min(accuracy, 50)` ise butonun altında "Yaklaşık 240 m uzaktasın" yaz, ama butonu **kapatma** (GPS yanılabilir, sunucu karar versin).
    - `has_area: true` (32 yer: adalar, ormanlar, korular) ise uzaklık yazma; bu yerlerde merkez noktası anlamsız, sınırın içindeyse kabul edilir.
  - Kullanıcı bu yeri zaten gezdiyse (`nearby_places.visited` veya `my_visits`) buton yerine "Gezildi ✓ / Visited ✓" ve tarih göster.

  **3. Basınca**
  - Yeni ve taze konum al: `Location.getCurrentPositionAsync({ accuracy: Location.Accuracy.High })`. Önbellekteki eski konumu kullanma.
  - `supabase.functions.invoke("checkin", { body: { place_id, lat, lng, accuracy_m: coords.accuracy ?? 999, lang } })`.
  - İstek sürerken butonu kilitle (çift tıklama iki istek göndermesin).

  **4. Yanıtlar** (beklenen retler HTTP 200 + `ok: false` gelir; HTTP hataları `error` olarak döner, gövde `await error.context.json()`):

  | Durum | Kullanıcıya (TR / EN) | Ne yap |
  | --- | --- | --- |
  | `ok: true` | "Kaydedildi! 🎉" / "Checked in! 🎉" | Butonu "Gezildi ✓" yap. `new_achievements` doluysa her rozet için tam ekran kutlama (rozet görseli + ad + açıklama). `city_progress.visited / total` ile "İstanbul: 12 / 156" göster. |
  | `ok: true, flagged: true` | Aynı "Kaydedildi" ekranı | Kullanıcıya hata gösterme (hız kontrolüne takıldı, rozete sayılmaz). |
  | `too_far` | "Biraz daha yaklaş (şu an {distance_m} m uzaktasın)." / "Get a little closer (you're {distance_m} m away)." | Buton açık kalsın. |
  | `low_accuracy` | "Konum net değil. Açık bir alana çıkıp tekrar dene." / "Location isn't precise. Step into an open area and try again." | |
  | `already_visited` | "Burayı zaten gezdin." / "You've already visited this place." | Butonu "Gezildi ✓" yap. |
  | `rate_limited` | "Biraz yavaş! Bir dakika sonra tekrar dene." / "Slow down! Try again in a minute." | |
  | `place_not_found` | "Bu yer bulunamadı." / "This place couldn't be found." | Paketi yenile (`city_pack`). |
  | 401 `not_authenticated` | "Devam etmek için giriş yap." / "Sign in to continue." | Giriş formunu aç. |
  | Ağ hatası / 500 | "Bir sorun oldu, tekrar dene." / "Something went wrong, try again." | |

  **5. Sonra**
  - Başarılı check-in'den sonra Rozetler ekranı açıksa yenilensin (yeni rozet animasyonu zaten var).
  - Liste ve haritada gezilen yerler ayırt edilsin (ör. küçük ✓ işareti). `nearby_places` her yer için `visited` döndürüyor; çevrimdışı durum için `my_visits` sonucunu cihazda sakla.

  **6. Test**
  - Gerçek konumda: Sultanahmet'te Ayasofya'nın yanında (yarıçap 100 m) ya da Galata Kulesi'nin dibinde (60 m) dene.
  - Uzaktan denemek için: `too_far` mesajının doğru mesafeyi gösterdiğini kontrol et (sunucu reddeder, kayıt oluşmaz).
  - Saf mantığı (`ok`/hata kodu → mesaj ve buton durumu) `catalog.test.cjs` gibi bir teste ekle.
- Not (backend, 2026-11-19): Mobil kod incelendi, sözleşmeyle uyumlu. Canlı uçtan uca test (geçici kullanıcı, Galata Kulesi) geçti: oturumsuz 401, bozuk istek 400, `too_far` 1545 m, `low_accuracy`, başarı + `first-step` rozeti + şehir ilerlemesi 1/156, tekrar `already_visited`, `my_visits` ve `my_achievements` doğru. Sonuç: `data-pipeline/results/selftest.json`.
- Yanıt (mobil): Yer kartına Buradayım eklendi. Girişten sonra taze konumla aynı yer için devam eder. Başarıda ziyaret, şehir ilerlemesi ve yeni rozetler gösterilir. Harita ve liste hesap bazında önbelleklenen gezileri işaretler. Yakın/uzak gerçek cihaz testi bekliyor.

### `city_pack` içine `has_area` eklendi
- Tarih: 2026-11-19
- Kimden: backend
- Durum: bilgi
- İstek: –
- Yanıt: `city_pack.places[]` artık `has_area: boolean` içeriyor (geriye uyumlu, migration `20261119190000_city_pack_has_area.sql`). Paket içeriği değiştiği için `version` bir kez değişti; uygulama paketi bir kez yeniden indirecek. Check-in ön kontrolünde kullanılır (yukarıdaki istek).

### Canlı Supabase projesi güncel
- Tarih: 2026-11-19
- Kimden: backend
- Durum: bilgi
- İstek: –
- Yanıt: `20261119170000`'e kadar bütün migration'lar canlı projeye uygulandı. Canlıda şu an: 156 yayında yer (TR+EN), 133 fotoğraf, 17 kategori, 21 rozet (hepsinin `badge_path` değeri dolu). Eski örnek yerler (`buyuk-camlica`, `pierre-loti`) silindi. `islands-tour` rozeti düzeltildi: kural `burgazada` yerine `burgaz-adasi` diyor; önceden kazanılamıyordu. API sözleşmesi değişmedi.

### Rozet görselleri hazır
- Tarih: 2026-11-19
- Kimden: backend
- Durum: tamamlandı (mobil uygulama kodu)
- İstek: 21 rozetin görseli `assets/badges/<slug>.webp` (512×512, şeffaf). Öneri:
  - Görselleri uygulama paketine koy; `my_achievements` dönen `slug` ile eşleştir. Pakette yoksa `badge_path` ile `supabase.storage.from("badges").getPublicUrl(badge_path)`, o da yoksa yer tutucu.
  - **Kazanılmamış rozet** için ayrı görsel yok: aynı görseli gri tonlamalı + yarı saydam (~%40) göster, altında `progress/target` (ör. 3/5). Kazanılınca tam renk ve küçük bir kutlama animasyonu.
  - Görsellerde yazı yok; rozet adı ve açıklaması `my_achievements` içinden, cihaz diline göre gelir.
  - `badge_path` canlıda dolu (`<slug>.webp`) ve 21 görselin hepsi `badges` bucket'ında (herkese açık). `getPublicUrl(badge_path)` çalışır.
- Yanıt (mobil): 21 paketli görsel Rozetler ekranında slug ile eşleşiyor. Oturum açan kullanıcı için my_achievements okunuyor. Kilitli rozetler gri ve ilerlemeli, yeni kazanımlar yenilemede kısa animasyonla gösteriliyor. Fiziksel cihaz kontrolü bekliyor.

### Yer fotoğrafları geldi (atıf zorunlu)
- Tarih: 2026-11-19
- Kimden: backend
- Durum: tamamlandı (mobil uygulama kodu)
- İstek: 156 yerin 133'ünde Wikimedia Commons fotoğrafı var (migration `20261119130000_photo_urls.sql` + `20261119140000_istanbul_photos.sql`). Geriye uyumlu eklemeler:
  - `place_detail.photos[]`: yeni alanlar `url`, `thumb_url`, `license_url`; `storage_path` artık boş olabilir.
  - `city_pack.places[]`: yeni alan `thumb_url` (ilk fotoğrafın 500 px küçük resmi). Bu eklemeyle `version` bir kez değişir.
  - **Lisans gereği** fotoğrafın yanında yazar ve lisans gösterilmeli ("Foto: A.Savin · FAL"); kartlarda "Foto: Wikimedia Commons" yeterli. Ayrıntı: `docs/API.md` → `place_detail`.
  - Fotoğrafı olmayan 23 yerde kategoriye göre yer tutucu gerekir.
  - Güncelleme (2026-11-19): 18 yere daha fotoğraf eklendi (migration `20261119230000_istanbul_photos_extra.sql`); artık 151/156. Mobilde değişiklik gerekmez, paket `version` değiştiği için uygulama yeni paketi kendisi indirir. Yer tutucu kalan 5 yer için hâlâ geçerli.
- Yanıt (mobil): Liste kartında Commons atfı, detayda her görselin altında bağlantılı yazar ve lisans gösteriliyor. Fotoğrafsız yerler kategori simgesini kullanıyor.

### Gerçek İstanbul verisi yüklendi
- Tarih: 2026-11-19
- Kimden: backend
- Durum: bilgi
- İstek: –
- Yanıt: Geliştirme seed'indeki 15 örnek yer kaldırıldı; yerine proje sahibinin onayladığı 156 yer migration olarak geldi (`20261119120000_istanbul_places.sql`). Bazı slug'lar değişti (ör. `buyuk-camlica` → `buyuk-camlica-tepesi`, `pierre-loti` → `pierre-loti-tepesi`); mobil slug'a sabit bağlıysa güncellemeli. Yeni kategori `tomb` bu veride 15 yerde kullanılıyor (yukarıdaki istek). `city_pack` İstanbul için ~49 KB. API sözleşmesi değişmedi.

### Yeni kategori: `tomb` (Türbe)
- Tarih: 2026-11-19
- Kimden: backend
- Durum: tamamlandı (mobil uygulama kodu)
- İstek: Proje sahibinin isteğiyle türbeler ayrı kategori oldu: `tomb`, TR "Türbe", EN "Tomb" (migration `20261119100000_tomb_category.sql`). `catalog.ts` içindeki `categoryNames` listesine eklenmesi gerekiyor; yoksa ekranda "tomb" yazar. Bir de yeni rozet var: `sultans-rest` ("Padişah Türbeleri", 5 türbe). Geriye uyumlu, başka bir şey değişmedi.
- Yanıt (mobil): Kategori adı mobil katalogda Türkçe Türbe ve İngilizce Tomb olarak eşlendi.

### Test projesinde İstanbul verisinin yüklenmesi
- Tarih: 2026-11-19
- Kimden: mobil
- Durum: tamamlandı
- İstek: Test kurulumunda `SQLSTATE 42704: type "geography" does not exist` bildirildi. Şema PostGIS’i `extensions` altında oluşturuyor. `seed.sql` içindeki yer ekleme sorgusu ise türü ve iki PostGIS fonksiyonunu şemasız kullanıyor. Windows kurulum kopyasında ifadeyi `extensions.st_setsrid(extensions.st_makepoint(v.lng, v.lat), 4326)::extensions.geography` olarak düzelttik. Backend kaynağına da uygulayıp dar bir `search_path` ile boş test veritabanına örnek veri yüklemesini doğrular mısın?
- Yanıt (backend, 2026-11-19): `seed.sql` artık boş; yer verisi migration'lardan geliyor (`20261119120000_istanbul_places.sql`). Bu migration Supabase'in varsayılan `search_path`'ine (`extensions` dahil) dayanıyor; canlı projede ve `supabase db push`/`db reset` ile sorunsuz. Dar `search_path` ile elle çalıştırılırsa aynı hata çıkar; test kurulumunda migration'ları Supabase CLI ile uygulayın. Windows kopyasındaki seed düzeltmesine artık gerek yok.

### Şehir paketi sürümünü indirmeden kontrol etme
- Tarih: 2026-11-19
- Kimden: mobil
- Durum: tamamlandı
- İstek: Uygulama kayıtlı paketi anında açıyor. `city_pack` sürümü ancak tüm paket geldikten sonra okunabiliyor. Veri hattı devreye girmeden önce değişmemiş paketi indirmemek için koşullu okuma biçimini netleştirebilir miyiz? Çeviri güncellemeleri ile yayından kaldırmaların sürümü değiştirmesi ve boş şehirde `version` değerinin açıklanması da gerekli. Mobil şimdilik mevcut imzayı kullanıyor.
- Yanıt (backend, 2026-11-19): Migration `20261119090000_city_pack_version.sql`.
  - Yeni RPC `city_pack_version(city_slug, lang)`: yalnızca sürümü döner. Kayıtlı sürümle aynıysa `city_pack` çağrılmaz.
  - `version` artık o dildeki paket içeriğinin md5 özeti (opak, 32 karakter). Çeviri değişikliği, yayından kaldırma, konum veya yarıçap değişikliği ve şehir adı sürümü değiştirir. Sürüm dile göre ayrı.
  - Boş şehirde de string sürüm döner, `places: []`. `null` yalnızca şehir yoksa gelir (o durumda `city_pack` de `null`).
  - `city_pack` imzası aynı, geriye uyumlu. Yalnızca `version` biçimi değişti: ISO tarihten özete. Mobil zaten eşitlikle karşılaştırıyor; `validPack` içindeki `version === null` koşulu artık gerekmez ama zarar da vermez.
  - Ayrıntı: `docs/API.md` → `city_pack_version`.

### Başlangıç notu: backend ilk sürümü hazır
- Tarih: 2026-11-18
- Kimden: backend
- Durum: tamamlandı
- İstek: –
- Yanıt: Şema, okuma fonksiyonları ve `checkin` Edge Function'ı `backend/` altında. Sözleşme `docs/API.md`. Supabase projesi açıldığında URL ve anon key proje sahibinden alınacak; `.env` dosyası repo'ya konmaz.
