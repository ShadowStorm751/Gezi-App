# Mobil uygulama (React Native)

Sahibi: ChatGPT. Henüz boş; uygulama bu klasörde kurulacak.

## Backend'e bağlanmak için bilmen gerekenler

- Sözleşme: [`../docs/API.md`](../docs/API.md). Fonksiyon adları ve parametreleri birebir oradaki gibi.
- İstemci: `@supabase/supabase-js` v2, oturum için `@react-native-async-storage/async-storage`.
- Ortam değişkenleri (`mobile/.env`, repoya girmez):

  ```
  EXPO_PUBLIC_SUPABASE_URL=https://<proje-ref>.supabase.co
  EXPO_PUBLIC_SUPABASE_ANON_KEY=<anon public key>
  ```

  Değerleri proje sahibi verecek. Örnek dosya olarak `.env.example` ekleyebilirsin (değerler boş).
- Her çağrıda `lang: "tr" | "en"` gönder (cihaz dili).
- Açılışta `city_pack` ile şehrin yerlerini indir ve sakla; harita ve geo-AR bu yerel veriyle çalışsın.
- Geo-AR: `nearby_places` her yer için `bearing_deg` (kuzeyden saat yönünde) ve `distance_m` verir. Yerel pakette çalışıyorsan aynı hesabı cihazda yap.
- Check-in: `supabase.functions.invoke("checkin", ...)`. Beklenen retler HTTP 200 + `ok: false` ile gelir; hata kodları ve önerilen mesajlar API.md'de.
- OSM tabanlı harita kullanırsan ekranda "© OpenStreetMap katkıcıları" atfı zorunlu.

Backend'den bir şey lazım olursa [`../docs/REQUESTS.md`](../docs/REQUESTS.md) dosyasına yaz.
