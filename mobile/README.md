# Gezi App mobil

React Native / Expo ile İstanbul keşfi. Harita ve kamera aynı WGS84 koordinatlarını kullanır. Dil, cihazın diline göre TR veya EN olur.

## Çalıştırma

Node 22.13 veya üzeri ve npm ile bu klasörde `npm install`, ardından `npx expo start` çalıştır. SDK 54 uyumlu istemci veya geliştirme derlemesi kullan. Kamera ve pusula testi fiziksel cihaz gerektirir. `npm test` konum hesaplarını ve API yanıtlarının işlenmesini sınar.

## Veri kaynağı

İki ortam değişkeni de boşken iki yerlik Galata demosu açılır. Supabase için `.env.example` dosyasını `.env` olarak kopyala, proje URL’sini ve public anon key’i kendi cihazında girip Expo’yu yeniden başlat. Telefon yerel Supabase kullanıyorsa URL bilgisayarın telefondan erişilebilen ağ adresi olmalıdır. Şema ve seed hazırlığı için [backend kurulumuna](../backend/README.md) bak.

- Açılışta kayıtlı İstanbul paketi hemen gösterilir. `city_pack` yanıtı proje ve dile göre ayrı saklanır. İlk çevrimiçi yüklemeden sonra harita ve kamera yerleri çevrimdışı kullanabilir. Harita karolarının çevrimdışı indirilmesi ayrı bir özelliktir.
- **Konumumu kullan** cihaz konumunu alır ve 2 km içindeki yerleri `nearby_places` ile günceller. Hata olursa ekran kayıtlı katalogdan mesafeleri hesaplar. Kamera dönerken RPC çağrılmaz.
- Haritadan veya baloncuktan seçim aynı `place_detail` isteğini açar. Bağlantı kesilirse kısa açıklama erişilebilir kalır.
- Giriş ve ziyaret kaydetme sonraki adımdır. Check-in doğrulaması [API sözleşmesindeki](../docs/API.md) Edge Function’a aittir.
