# Gezi App

İstanbul'dan başlayarak tarihi-kültürel yerleri ve doğa/manzara noktalarını keşfettiren mobil uygulama. Kullanıcı yerlerin yakınında GPS ile check-in yapar ("Buradayım"), rozet kazanır, hazır rotaları tamamlar, arkadaşlarıyla yarışır ve yıl sonunda paylaşılabilir bir özet alır. Kamerayı çevirince yakındaki yerler ekranda etiket olarak görünür (geo-AR).

## Neler var

- **156 İstanbul yeri** (113 tarihi, 43 doğa ve manzara). Her yerin Türkçe ve İngilizce kısa ve uzun açıklaması var, 154'ünde lisanslı fotoğraf bulunuyor.
- **Buradayım:** sunucuda doğrulanan konum kaydı; uzaklık, GPS doğruluğu ve hız kontrolü yapılır.
- **27 rozet:** dönem, kategori, rota, sosyal ve katkı rozetleri, hepsinin görseli hazır.
- **11 hazır rota:** Sultanahmet Klasikleri, Fener, Balat ve Surlar, Adalar, Boğaz Manzaraları gibi; numaralı durak haritasıyla.
- **Sosyal:** arkadaşlık istekleri, kullanıcı arama, haftalık/aylık/yıllık arkadaş sıralaması.
- **Kişisel öneriler:** gezilmemiş yakın yerler, yarım kalan rotalar, bitmek üzere olan rozetler.
- **Kullanıcı katkısı:** gezilen yere fotoğraf ekleme, 1–5 yıldız değerlendirme, hata bildirimi ve yeni yer önerisi (hepsi yönetici onaylı).
- **Hesap:** e-postayla giriş, avatar, hesap silme, kişisel verileri dışa aktarma (KVKK).
- **Geo-AR kamera ve çevrimdışı şehir paketi:** harita ve kamera, internet olmadan da yerel veriyle çalışır.
- **Tasarım:** "sıcak keşif" tasarım sistemi; alt sekmeler, büyük fotoğraflı kartlar, animasyonlu rozet kutlaması.

## Teknoloji

| Katman | Kullanılan |
| --- | --- |
| Mobil | React Native + Expo SDK 58 (iPhone'da Expo Go ile test), react-native-maps, Reanimated |
| Backend | Supabase: Postgres + PostGIS, Auth, Storage, Edge Functions (Deno) |
| Veri | OpenStreetMap + Wikidata + Wikimedia Commons (yalnızca serbest lisanslı fotoğraflar, atıflı) |
| Otomasyon | GitHub Actions (veri hattı, içerik yükleme, rozet görselleri) |

## Klasörler

| Klasör | İçerik | Sorumlu |
| --- | --- | --- |
| [`docs/`](docs/) | [Teknik plan](docs/TECHNICAL_PLAN.md), [API sözleşmesi](docs/API.md), [istekler](docs/REQUESTS.md), [tasarım](docs/TASARIM.md), [kişisel veri envanteri](docs/VERI_ENVANTERI.md) | Ortak |
| [`backend/`](backend/) | Supabase migration'ları, SQL fonksiyonları, Edge Functions, testler ([modül haritası](backend/MODULES.md)) | Claude |
| [`mobile/`](mobile/) | Expo / React Native uygulaması | ChatGPT |
| [`data-pipeline/`](data-pipeline/) | Yer verisi, fotoğraf ve içerik hazırlayan script'ler | Claude |
| [`assets/`](assets/) | Rozet görselleri | Ortak |

## Telefonda dene

[Mobil kurulum adımlarını](mobile/README.md) izle: `mobile/.env.example` dosyasını `.env` olarak kopyalayıp Supabase adresini ve anon (publishable) anahtarını yaz, `npx expo start --go --lan --clear` çalıştır (Windows'ta `Expo-Go-Baslat.cmd`), çıkan QR kodu iPhone'da Kamera ile okut. Telefon ve bilgisayar aynı Wi-Fi'da olmalı.

Tarayıcıda hızlı bir göz atmak için [Gezi-Test.html](Gezi-Test.html) dosyasını indirip aç. Galata çevresinde örnek konumla kamera demosu çalışır; kamera veya konum izni istemez.

## Birlikte çalışma kuralları

1. **Sözleşme `docs/API.md`.** Mobil yalnızca orada yazan fonksiyonları kullanır. Backend bir imzayı değiştirirse API.md'yi aynı commit'te günceller.
2. **Herkes kendi klasöründe.** Diğer tarafın klasöründe değişiklik gerekiyorsa `docs/REQUESTS.md`'ye yazılır.
3. **Gizli bilgi repoya girmez.** Supabase anahtarları `.env` dosyalarında kalır (`.gitignore`'da). Mobilde yalnızca anon anahtar kullanılır.
4. **Kişisel veri:** kişisel veri toplayan her özellik `docs/VERI_ENVANTERI.md`'yi aynı commit'te günceller.
5. **Küçük ve açıklamalı commit'ler.** Commit mesajı ne değiştiğini söyler.

Yapay zekâ asistanları için ayrıntılı kurallar: [`AGENTS.md`](AGENTS.md).

## Durum (20 Kasım 2026)

- [x] Veritabanı şeması, erişim kuralları, check-in ve rozet motoru (canlı test projesinde, 51 migration)
- [x] İstanbul: 156 yer, TR+EN kısa ve uzun açıklamalar, 154 fotoğraf, 27 rozet, 11 rota
- [x] Backend: rotalar, arkadaşlar ve sıralama, öneriler, kullanıcı fotoğrafları, değerlendirmeler, hesap silme, avatar, KVKK dışa aktarım
- [x] Güvenlik denetimi ve canlı uçtan uca testler (sosyal 29/29, fotoğraf 28/28)
- [x] Mobil: Expo SDK 58, tüm ana ekranlar, yeni tasarım ve animasyonlar
- [ ] iPhone'da baştan sona kabul testi
- [ ] Rotalar, Rozetler ve Profil ekranlarının yeni tasarımı
- [ ] Apple/Google ile giriş, e-posta (SMTP), hata takibi ve analitik
- [ ] KVKK aydınlatma metni ve gizlilik politikası
- [ ] Ayrı canlı (production) Supabase projesi
- [ ] Yeni şehirler (veri hazırlanıyor)

Ayrıntılı durum ve yapılacaklar: [teknik plan](docs/TECHNICAL_PLAN.md).
