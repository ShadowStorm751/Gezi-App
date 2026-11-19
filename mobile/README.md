# Gezi App mobil

React Native / Expo ile İstanbul keşfi. Harita ve kamera aynı WGS84 koordinatlarını kullanır. Dil, cihazın diline göre TR veya EN olur.

## Çalıştırma

İlk kurulumda Node.js 22 LTS (22.13+) veya 24 LTS (24.3+) ve npm ile `mobile` klasöründe `npm ci` çalıştır.

Windows’ta paketler kurulduktan sonra `Expo-Go-Baslat.cmd` dosyasına çift tıkla. macOS ve Linux’ta aynı klasörde `npx expo start --go --lan --clear` çalıştır. Telefonu ve bilgisayarı aynı Wi-Fi ağına bağla. QR kodunu Android’de Expo Go SDK 58 içinden, iPhone’da Kamera ile okut. Gezi App açılınca kamera ve konum izinlerini ver. Kamera ve pusulayı fiziksel cihazda dene.

`npm test` konum hesaplarını ve API yanıtlarının işlenmesini sınar.

## Veri kaynağı

İki ortam değişkeni de boşken iki yerlik Galata demosu açılır. Supabase için `.env.example` dosyasını `.env` olarak kopyala, proje URL’sini ve public anon key’i kendi cihazında girip Expo’yu yeniden başlat. Telefon yerel Supabase kullanıyorsa URL bilgisayarın telefondan erişilebilen ağ adresi olmalıdır. Şema ve seed hazırlığı için [backend kurulumuna](../backend/README.md) bak.

- Açılışta kayıtlı İstanbul paketi hemen gösterilir. `city_pack` yanıtı proje ve dile göre ayrı saklanır. İlk çevrimiçi yüklemeden sonra harita ve kamera yerleri çevrimdışı kullanabilir. Harita karolarının çevrimdışı indirilmesi ayrı bir özelliktir.
- **Konumumu kullan** cihaz konumunu alır ve 2 km içindeki yerleri `nearby_places` ile günceller. Hata olursa ekran kayıtlı katalogdan mesafeleri hesaplar. Kamera dönerken RPC çağrılmaz.
- Haritadan veya baloncuktan seçim aynı `place_detail` isteğini açar. Bağlantı kesilirse kısa açıklama erişilebilir kalır.
- Fotoğraflı kartlarda Wikimedia Commons atfı bulunur. Yer detayında her fotoğrafın yazarı ve lisansı görselin altında yer alır.
- **Buradayım** yer kartından yeni bir GPS ölçümü alır ve ziyareti `checkin` ile doğrulatır. Giriş gerekirse aynı karttan giriş yapılınca istek devam eder. Alanı tanımlı yerlerde merkez mesafesi ipucu gösterilmez. Ziyaret tarihleri hesap bazında cihazda saklanır.
- **Rozetler** bölümünde e-posta ve parolayla giriş yapılır. Ad, açıklama ve ilerleme `my_achievements` üzerinden kullanıcının dilinde yüklenir. Kazanılan rozetler tam renkli görünür.
