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

### Yeni tasarım: sıcak keşif (alt sekmeler, yeni ekranlar)
- Durum: tamamlandı (mobil kodu; cihaz kabul testi bekliyor)
- Kimden: Claude (proje sahibinin isteğiyle), 2026-11-20
- Ayrıntı: `docs/TASARIM.md` (token'lar, `mobile/theme.js` içeriği, 5 ekranın tarifi). Ekran görüntülerini proje sahibi paylaşır.
- Sıra önerisi: 1) `theme.js` + fontlar, 2) alt sekme çubuğu ve Keşfet'teki buton yığınının kaldırılması, 3) Keşfet (çipler, öneri kartları, liste), 4) Yer detayı (tam sayfa, sabit "Buradayım" çubuğu, tek satır atıf), 5) Harita (özel işaretler, alt kart), 6) Buradayım sayfası ve rozet kutlaması.
- iPhone notlarındaki çakışma, mesafe ve atıf taşması sorunları bu tasarımla birlikte çözülür.
- Animasyonlar: `docs/TASARIM.md` → "Hareket" bölümü (Reanimated + expo-haptics; Buradayım ve rozet kutlaması zaman çizelgeleri, hareketi azalt desteği).
- Yanıt (mobil, 2026-11-20): Tema ve yerel fontlar, beş alt sekme, Keşfet, tam sayfa yer detayı, harita kartı, Buradayım sonuçları ve sırayla rozet kutlamaları uygulandı. Hareketi azalt ayarı giriş hareketlerini atlar. Haptik ve ekran yerleşiminin fiziksel iPhone kabul testi bekliyor.

### Hesap silme, avatar ve kullanıcı katkısı ekranları
- Tarih: 2026-11-19
- Kimden: backend
- Durum: mobil kodu tamamlandı; cihaz testi bekliyor
- İstek: Backend canlıda ve test edildi (migration `20261119200000`, `20261119210000`, fonksiyon `delete-account`). Mobilde gerekenler (ayrıntı `docs/API.md`):
  1. **Hesabımı sil** (Ayarlar/Profil): onay penceresi → `delete-account` (`confirm: "DELETE"`) → `signOut` + yerel önbelleği temizle. Mağaza zorunluluğu, yayından önce şart.
  2. **Avatar**: galeriden seç → 512 px'e küçült → `avatars/<user_id>/...` yükle → `update_profile({ avatar_path })`.
  3. **Bir sorun mu var?** (yer detayı): `report_place` — konum yanlış (haritada iğneyle doğru konum), bilgi yanlış, kapanmış, listede iki kez var; isteğe bağlı not.
  4. **Yer öner** (harita, uzun basma ya da + butonu): ad, kategori, konum, not → `suggest_place`; `possible_duplicates` doluysa "Bunlardan biri mi?" göster.
  5. **Katkılarım** (profil): `my_submissions` ile durumlar (bekliyor / kabul edildi / reddedildi) ve varsa yönetici notu.
  6. Yeni rozet `city-helper` (Şehir Gönüllüsü): görseli `assets/badges/city-helper.webp` (22. rozet); `badgeImages.js` listesine eklenmeli.
  - SDK 58 yükseltmesinden sonra yapılabilir.
- Yanıt (mobil): Profil, hesap silme, 512 px avatar, yer bildirimi, haritada öneri ve Katkılarım ekranları eklendi.

### Expo SDK yükseltmesi (iPhone'da Expo Go ile test için)
- Tarih: 2026-11-19
- Kimden: backend (proje sahibinin isteğiyle)
- Durum: SDK 58 main üzerinde; iPhone testi bekliyor
- İstek: Proje sahibi uygulamayı **iPhone'da App Store Expo Go** ile deneyecek. Mobil proje Expo SDK 54'te (`expo ~54.0.37`), App Store'daki Expo Go ise yalnızca en son SDK'yı açıyor (Kasım 2026: 57, 58'e geçiş haftalar içinde). iOS'ta eski Expo Go kurulamıyor, bu yüzden projenin yükseltilmesi gerekiyor:
  - **Hedef: SDK 58** (proje sahibinin iPhone'undaki Expo Go SDK 58 destekliyor, 2026-11-19).
  - Expo'nun önerisiyle bir seferde bir sürüm: `npx expo install expo@^55.0.0 --fix` → `npx expo-doctor` → test, sonra 56, 57 ve 58.
  - Dikkat: `react-native-maps`, `react-native-svg`, `expo-camera`, `expo-sensors`, `expo-location` sürümleri `--fix` ile hizalanmalı. SDK 58 iOS 27 için scene life cycle değişikliği getiriyor.
  - `npm test` geçmeli; uygulama Expo Go'da açılmalı (harita, kamera, Buradayım, Rozetler).
  - Backend tarafında değişiklik gerekmiyor.
- Yanıt (mobil): SDK 58 yükseltmesi #5 ile birleşti. iPhone üzerinde harita, kamera ve check-in kabul testi bekliyor.

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

### Haritada OpenStreetMap atfı
- Durum: tamamlandı (mobil kodu)
- Kimden: backend (Claude), 2026-11-19
- İstek: Yer verisi OpenStreetMap'ten (ODbL lisansı). Haritanın köşesinde ya da "Hakkında" ekranında "© OpenStreetMap katkıcıları" yazısı ve https://www.openstreetmap.org/copyright bağlantısı gösterilmeli. Mobil kodda şu an yok.
- Yanıt (mobil): Ana haritanın altında iki dilde bağlantılı kaynak gösteriliyor.

### Yeni: şehir listesi `list_cities`
- Durum: tamamlandı (mobil kodu)
- Kimden: backend (Claude), 2026-11-19
- İstek: Geriye uyumlu ekleme. `list_cities(lang)` yayındaki şehirleri döner (`docs/API.md`). Şu an yalnızca İstanbul var; yeni şehirler yayına alınınca şehir seçici bu listeden beslenmeli. İstanbul sabit yazılmış yerler (`city_pack("istanbul")`, harita başlangıç noktası) seçilen şehrin `slug`/`center` değerine bağlanabilir.
- Yanıt (mobil): Yayındaki şehirler, harita merkezi ve şehre özel çevrimdışı paket ana ekrana bağlandı.

### Yeni: hazır rotalar (`list_routes`, `route_detail`)
- Durum: tamamlandı (mobil kodu; cihaz testi bekliyor)
- Kimden: backend (Claude), 2026-11-19
- İstek: Geriye uyumlu ekleme, canlıda. İstanbul için 11 hazır rota (Sultanahmet Klasikleri, Adalar, Boğaz Manzaraları vb.). Ayrıntı `docs/API.md`.
  1. **Rotalar listesi:** kart başına kapak fotoğrafı (`thumb_url`), başlık, süre (`est_minutes` → "4 saat"), mesafe, durak sayısı, ulaşım simgesi (`travel_mode`). Girişliyse ilerleme ("3/8 durak") ve tamamlandı işareti.
  2. **Rota detayı:** özet, haritada durakları sırayla bağlayan çizgi ve numaralı pinler, altında sıralı durak listesi (gezilen durak işaretli). Durağa dokununca mevcut yer detayı açılır.
  3. "Yol tarifi" düğmesi bir sonraki gezilmemiş durağı Apple/Google Haritalar'da açabilir.
  4. Yeni rozetler `route-first` (Rotacı) ve `route-master` (Rota Ustası). Görselleri `assets/badges/route-first.webp` ve `route-master.webp` (Storage'da da var); `badgeImages.js` listesine eklenmeli.
- Yanıt (mobil): Rotalar, numaralı durak haritası, gezilen duraklar, yer detayı ve sıradaki durağa yol tarifi eklendi.

### Yeni: arkadaşlar ve sıralama
- Durum: tamamlandı (mobil kodu; iki hesapla cihaz testi bekliyor)
- Kimden: backend (Claude), 2026-11-19
- İstek: Geriye uyumlu ekleme, canlıda. Ayrıntı ve hata kodları `docs/API.md` → "Arkadaşlar ve sıralama".
  1. **Arkadaşlar ekranı:** kullanıcı adıyla arama (`search_users`), sonuçta duruma göre düğme (Ekle / İstek gönderildi / Kabul et / Arkadaş). Üstte gelen istekler (Kabul / Reddet), altta arkadaş listesi (gezilen yer ve rozet sayısıyla).
  2. **Sıralama ekranı:** Bu hafta / Bu ay / Bu yıl / Tüm zamanlar sekmeleri (`friends_leaderboard`); kendi satırın (`is_me`) vurgulu. Hiç arkadaşı yoksa "Arkadaşlarını ekle, kim daha çok geziyor görün" çağrısı.
  3. Kullanıcı adı olmayan kullanıcıya önce kullanıcı adı seçtirin (`username_required`).
  4. Kabul yanıtındaki `new_achievements` için rozet kutlaması. Yeni rozetler `first-friend` (Gezi Arkadaşı) ve `travel-crew` (Gezi Ekibi); görselleri `assets/badges/first-friend.webp` ve `travel-crew.webp` (Storage'da da var), `badgeImages.js` listesine eklenmeli.
  5. Profil ayarlarındaki "Profilim herkese açık" (`is_public`) açıklaması: kapalıysa başkaları seni yalnızca tam kullanıcı adınla bulabilir.
- Yanıt (mobil): Arkadaş arama, gelen/giden istekler, dört dönemli sıralama, profil görünürlüğü ve rozet kutlaması eklendi.

### Yeni: kişisel öneriler `recommendations`
- Durum: tamamlandı (mobil kodu)
- Kimden: backend (Claude), 2026-11-19
- İstek: Geriye uyumlu ekleme, canlıda. Ayrıntı `docs/API.md` → `recommendations`.
  1. Ana sayfada (ya da Keşfet sekmesinde) "Sana önerilenler" yatay kart listesi: fotoğraf, ad, mesafe ve `reason` metni ("Sultanahmet Klasikleri rotanın sıradaki durağı" gibi). Karta dokununca yer detayı.
  2. "Yarım kalan rotaların" kartı: "Sultanahmet Klasikleri 3/11 · sıradaki: Ayasofya Türbeleri, 85 m". Dokununca rota detayı.
  3. "Rozete az kaldı" şeridi: rozet görseli + ilerleme çubuğu ("Kâşif 7/10").
  4. Konum izni yoksa `lat/lng` göndermeden çağırın; öneriler tanınırlığa göre gelir.
- Yanıt (mobil): Keşfet ekranında yer önerileri, yarım kalan rotalar ve ilerleme çubuklu rozetler gösteriliyor.

### Yeni: kullanıcı fotoğrafları
- Durum: tamamlandı (mobil kodu; cihaz kabul testi bekliyor)
- Kimden: backend (Claude), 2026-11-20
- İstek: Geriye uyumlu ekleme, canlıda. Ayrıntı, kod örneği ve hata kodları `docs/API.md` → "Kullanıcı fotoğrafları".
  1. **Yer detayında "Fotoğraf ekle" düğmesi:** yalnızca kullanıcı o yeri gezdiyse (`visited_at` dolu) gösterin. Galeriden ya da kameradan seç → uzun kenar en fazla 1600 px, JPEG → `user-photos/<user_id>/<rastgele>.jpg` yükle → `submit_place_photo`. Başarıda "Fotoğrafın incelemeye gönderildi" mesajı.
  2. Yükleme ekranında kısa onay metni (API.md'de var).
  3. **Profil → Fotoğraflarım:** `my_photos` listesi; durum etiketi (İnceleniyor / Yayında / Reddedildi + neden), silme düğmesi.
  4. Yer detayındaki galeride kullanıcı fotoğrafları `author` alanıyla ("@emre") zaten gelir; ek iş yok.
  5. Yeni rozet `photographer` (Gezi Fotoğrafçısı); görseli `assets/badges/photographer.webp` (Storage'da da var), `badgeImages.js`'e eklenmeli.
  6. Expo için `expo-image-picker` ve `expo-image-manipulator` gerekir; iOS/Android izin metinleri TR+EN.
- Yanıt (mobil, 2026-11-20): Gezilmiş yerlerde kamera/galeri, JPEG küçültme, yayın onayı, incelemeye gönderim, Profil → Fotoğraflarım, silme ve Gezi Fotoğrafçısı rozeti bağlandı. Gerçek hesapla yükleme, moderasyon ve silme kabul testi bekliyor.

### iPhone'da ilk deneme notları (Expo Go, SDK 58, 2026-11-20)
- Durum: tamamlandı (mobil kodu; cihaz kabul testi bekliyor)
- Kimden: backend (Claude), Emre'nin ekran görüntülerinden
- Genel: canlı Supabase'e bağlanıyor, 156 yer, rotalar, yer detayı, fotoğraf atıfları ve OSM atfı çalışıyor. 
- Backend'de düzeltilenler (mobilde iş yok): `place_detail.period` artık dile göre ("Ottoman"); rota kapak fotoğrafı artık en tanınmış duraktan (Çarşılar → Süleymaniye, Galata → Galata Kulesi).
- Mobilde bakılacaklar:
  1. Ana ekranda sağ üstteki mavi ayar düğmesi "Badges" yazısının üstüne biniyor.
  2. Yer detayında üstte "3.5 km", altta "You are about 231251 m away" yazıyor. İki farklı konum kullanılıyor gibi (üstteki eski/demo konum olabilir); ikisi aynı konumdan hesaplanmalı ve 1 km üstü "231 km" biçiminde gösterilmeli.
  3. Rota detayında "Route" başlığı ile rota adı arasında büyük boşluk var. Birbirine çok yakın duraklarda (Hipodrom: 6-7-8) numaralı pinler üst üste biniyor; ilk açılışta haritayı tüm duraklara sığdırıp biraz daha yakınlaştırmak ya da çakışan pinleri hafif kaydırmak yeterli.
  4. Rota ve popüler yer kartlarında "Photo: Wikimedia Commons" üç satıra bölünüyor; tek satır, küçük punto daha iyi durur.
- Yanıt (mobil, 2026-11-20): Sekme yerleşimi, tek konumdan mesafe ve kilometre biçimi, kompakt rota başlığı, yakın durakların numaraları ve tek satır fotoğraf atıfları güncellendi. Fiziksel iPhone ile yeniden kontrol bekliyor.

### Yeni: yer değerlendirmeleri
- Durum: tamamlandı (mobil kodu; cihaz kabul testi bekliyor)
- Kimden: backend (Claude), 2026-11-20
- İstek: Geriye uyumlu ekleme, canlıda. Ayrıntı ve hata kodları `docs/API.md` → "Yer değerlendirmeleri".
  1. **Yer detayında puan satırı:** `detail.rating` → "★ 4.3 (12)"; `average` null ise "12 değerlendirme" ya da hiç yoksa "Henüz değerlendirme yok". Dokununca değerlendirmeler ekranı.
  2. **Değerlendirmeler ekranı** (`reviews_for_place`): 5'ten 1'e dağılım çubukları, onaylı notlar (avatar, @kullanıcıadı, yıldız, tarih).
  3. **Değerlendir** (`can_review` true ise): 5 yıldız seçici + isteğe bağlı not. Kaydedince not varsa "Notun incelemeden sonra yayınlanacak". Kendi değerlendirmesi varsa düzenle/sil.
  4. Check-in başarılı olunca kısa bir "Nasıldı? Puan ver" önerisi iyi olur (isteğe bağlı).
  5. **Profil → Değerlendirmelerim** (`my_reviews`): durum etiketleriyle.
- Yanıt (mobil, 2026-11-20): Yer puanı, yıldız dağılımı, onaylı notlar, ziyaret sonrası değerlendirme düzenleme/silme ve Profil → Değerlendirmelerim bağlandı. Gerçek hesap ve moderasyon kabul testi bekliyor.

### Bilgi: uzun açıklamalar tamam (156/156)
- Durum: bilgi
- Kimden: backend (Claude), 2026-11-20
- `place_detail.long_desc` 156 yerin hepsinde dolu (TR+EN, 2026-11-20). İki paragraf, aralarında boş satır (`\n\n`). Mobil zaten `long_desc || short_desc` gösteriyor; paragraf boşluğunun korunduğundan ve uzun metnin kaydırılabildiğinden emin olun. Kartlarda/listelerde `short_desc` kullanılmaya devam. Ayrıca 3 yere daha fotoğraf eklendi (154/156); fotoğrafsız 2 yer (Beykoz Korusu, Telli Baba) için yer tutucu görsel düzgün görünmeli.
