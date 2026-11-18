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

### Canlı Supabase projesi güncel
- Tarih: 2026-11-19
- Kimden: backend
- Durum: bilgi
- İstek: –
- Yanıt: `20261119170000`'e kadar bütün migration'lar canlı projeye uygulandı. Canlıda şu an: 156 yayında yer (TR+EN), 133 fotoğraf, 17 kategori, 21 rozet (hepsinin `badge_path` değeri dolu). Eski örnek yerler (`buyuk-camlica`, `pierre-loti`) silindi. `islands-tour` rozeti düzeltildi: kural `burgazada` yerine `burgaz-adasi` diyor; önceden kazanılamıyordu. API sözleşmesi değişmedi.

### Rozet görselleri hazır
- Tarih: 2026-11-19
- Kimden: backend
- Durum: açık (mobil)
- İstek: 21 rozetin görseli `assets/badges/<slug>.webp` (512×512, şeffaf). Öneri:
  - Görselleri uygulama paketine koy; `my_achievements` dönen `slug` ile eşleştir. Pakette yoksa `badge_path` ile `supabase.storage.from("badges").getPublicUrl(badge_path)`, o da yoksa yer tutucu.
  - **Kazanılmamış rozet** için ayrı görsel yok: aynı görseli gri tonlamalı + yarı saydam (~%40) göster, altında `progress/target` (ör. 3/5). Kazanılınca tam renk ve küçük bir kutlama animasyonu.
  - Görsellerde yazı yok; rozet adı ve açıklaması `my_achievements` içinden, cihaz diline göre gelir.
  - `badge_path` canlıda dolu (`<slug>.webp`). Storage'a yükleme proje sahibinde; yüklenene kadar URL 404 dönebilir, paketteki görseller yeterli.
- Yanıt: –

### Yer fotoğrafları geldi (atıf zorunlu)
- Tarih: 2026-11-19
- Kimden: backend
- Durum: açık (mobil)
- İstek: 156 yerin 133'ünde Wikimedia Commons fotoğrafı var (migration `20261119130000_photo_urls.sql` + `20261119140000_istanbul_photos.sql`). Geriye uyumlu eklemeler:
  - `place_detail.photos[]`: yeni alanlar `url`, `thumb_url`, `license_url`; `storage_path` artık boş olabilir.
  - `city_pack.places[]`: yeni alan `thumb_url` (ilk fotoğrafın 500 px küçük resmi). Bu eklemeyle `version` bir kez değişir.
  - **Lisans gereği** fotoğrafın yanında yazar ve lisans gösterilmeli ("Foto: A.Savin · FAL"); kartlarda "Foto: Wikimedia Commons" yeterli. Ayrıntı: `docs/API.md` → `place_detail`.
  - Fotoğrafı olmayan 23 yerde kategoriye göre yer tutucu gerekir.
- Yanıt: –

### Gerçek İstanbul verisi yüklendi
- Tarih: 2026-11-19
- Kimden: backend
- Durum: bilgi
- İstek: –
- Yanıt: Geliştirme seed'indeki 15 örnek yer kaldırıldı; yerine proje sahibinin onayladığı 156 yer migration olarak geldi (`20261119120000_istanbul_places.sql`). Bazı slug'lar değişti (ör. `buyuk-camlica` → `buyuk-camlica-tepesi`, `pierre-loti` → `pierre-loti-tepesi`); mobil slug'a sabit bağlıysa güncellemeli. Yeni kategori `tomb` bu veride 15 yerde kullanılıyor (yukarıdaki istek). `city_pack` İstanbul için ~49 KB. API sözleşmesi değişmedi.

### Yeni kategori: `tomb` (Türbe)
- Tarih: 2026-11-19
- Kimden: backend
- Durum: açık (mobil)
- İstek: Proje sahibinin isteğiyle türbeler ayrı kategori oldu: `tomb`, TR "Türbe", EN "Tomb" (migration `20261119100000_tomb_category.sql`). `catalog.ts` içindeki `categoryNames` listesine eklenmesi gerekiyor; yoksa ekranda "tomb" yazar. Bir de yeni rozet var: `sultans-rest` ("Padişah Türbeleri", 5 türbe). Geriye uyumlu, başka bir şey değişmedi.
- Yanıt: –

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
