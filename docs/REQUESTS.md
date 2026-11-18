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

### Yeni kategori: `tomb` (Türbe)
- Tarih: 2026-11-19
- Kimden: backend
- Durum: açık (mobil)
- İstek: Proje sahibinin isteğiyle türbeler ayrı kategori oldu: `tomb`, TR "Türbe", EN "Tomb" (migration `20261119100000_tomb_category.sql`). `catalog.ts` içindeki `categoryNames` listesine eklenmesi gerekiyor; yoksa ekranda "tomb" yazar. Bir de yeni rozet var: `sultans-rest` ("Padişah Türbeleri", 5 türbe). Geriye uyumlu, başka bir şey değişmedi.
- Yanıt: –

### Test projesinde İstanbul verisinin yüklenmesi
- Tarih: 2026-11-19
- Kimden: mobil
- Durum: açık
- İstek: Test kurulumunda `SQLSTATE 42704: type "geography" does not exist` bildirildi. Şema PostGIS’i `extensions` altında oluşturuyor. `seed.sql` içindeki yer ekleme sorgusu ise türü ve iki PostGIS fonksiyonunu şemasız kullanıyor. Windows kurulum kopyasında ifadeyi `extensions.st_setsrid(extensions.st_makepoint(v.lng, v.lat), 4326)::extensions.geography` olarak düzelttik. Backend kaynağına da uygulayıp dar bir `search_path` ile boş test veritabanına örnek veri yüklemesini doğrular mısın?

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
