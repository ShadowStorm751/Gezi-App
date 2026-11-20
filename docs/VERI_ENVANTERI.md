# Kişisel veri envanteri

Gezi App'in topladığı kişisel verilerin listesi: ne toplanıyor, neden, nerede saklanıyor, kim görüyor, ne zaman siliniyor.
KVKK aydınlatma metni ve gizlilik politikası bu dosyadan yazılacak. **Kişisel veri toplayan ya da değiştiren her özellikte
bu dosya aynı commit'te güncellenir** (backend: Claude, mobil: ChatGPT).

Son güncelleme: 2026-11-20 (yer değerlendirmeleri eklendi).

## Genel

| Konu | Durum |
| --- | --- |
| Veri sorumlusu | Emre (uygulama sahibi). Şirket/şahıs bilgisi ve iletişim adresi KVKK metninde yazılacak. |
| Ana veri işleyen | Supabase (veritabanı, dosya deposu, kimlik doğrulama, Edge Functions). Sunucu: AWS eu-central-1, **Frankfurt (AB)** → yurt dışına aktarım, KVKK md. 9 kapsamında açıklanmalı. |
| Hesap olmadan | Harita, yer bilgileri, rotalar, öneriler hesapsız kullanılabilir; sunucuda kişisel veri tutulmaz (yalnızca altyapı logları). |
| Çocuklar | Yaş sınırı henüz belirlenmedi (karar: Emre). Mağaza yaş derecelendirmesiyle uyumlu olmalı. |
| Pazarlama, reklam, satış | Yok. Veri üçüncü taraflara satılmaz, reklam için kullanılmaz. |
| Hata takibi / analitik | Henüz yok. Eklenince (öneri: Sentry + AB sunuculu PostHog) bu dosyaya yazılacak. |

## Sunucuda tutulan veriler

| Veri | Ne zaman toplanır | Amaç | Saklandığı yer | Kim görür | Silinme |
| --- | --- | --- | --- | --- | --- |
| **E-posta, parola özeti**, giriş zamanları | Kayıt / giriş | Hesap, giriş | Supabase Auth (`auth.users`) | Yalnızca sistem | Hesap silinince |
| Apple / Google kimliği | Apple/Google ile giriş (henüz yok) | Hesap | Supabase Auth | Yalnızca sistem | Hesap silinince |
| **Kullanıcı adı**, profil fotoğrafı, profil herkese açık mı, dil | Profil düzenleme | Profil, arkadaş bulma | `profiles`, Storage `avatars/<id>/` | Kullanıcı adı + avatar: herkes (gizli profil yalnızca tam adla aranınca); diğerleri: yalnız kişi | Hesap silinince (dosyalar dahil) |
| **Ziyaretler**: hangi yer, ne zaman, yere uzaklık (m), GPS doğruluğu (m), şüpheli hız işareti | Check-in ("Buradayım") | Ziyaret doğrulama, rozetler, istatistik, sıralama, öneriler | `visits` | Kişi; arkadaşlar yalnızca **sayıları** görür (sıralama, toplam yer) | Hesap silinince |
| ⚠️ Check-in anındaki **GPS koordinatı** | Check-in | Yere yakınlık kontrolü | **Saklanmaz.** Yalnızca istekte kullanılır, uzaklık hesaplanıp atılır | – | – |
| Konum (öneriler / yakındaki yerler) | Kullanıcı "Konumumu kullan" der | Yakındaki yerleri gösterme | **Saklanmaz** (yalnızca istek anında) | – | – |
| Rozetler (hangi rozet, ne zaman) | Otomatik | Oyunlaştırma | `user_achievements` | Kişi; arkadaşlar rozet **sayısını** görür | Hesap silinince |
| **Arkadaşlıklar**: kim kime istek gönderdi, durum, tarihler | Arkadaş ekleme | Arkadaş listesi, sıralama | `friendships` | İki taraf | Silme/ret anında; hesap silinince |
| **Yer bildirimleri ve önerileri**: tür, not, önerilen konum, durum, yönetici notu | "Bir sorun mu var?", "Yer öner" | İçerik düzeltme | `place_submissions` | Kişi, yöneticiler | Hesap silinince **kimliksizleştirilir** (`user_id = null`), içerik kalır |
| **Kullanıcı fotoğrafları**: dosya, açıklama, durum, yönetici notu | "Fotoğraf ekle" | Yer galerisi | `photo_submissions`, Storage `user-photos/<id>/` | Bekleyen: kişi + yönetici (adres tahmin edilemez); onaylı: **herkes**, "@kullanıcıadı" ile | Kullanıcı silince; reddedilen dosyalar en geç 1 gün içinde; gönderilmeyen dosyalar 24 saatte; hesap silinince |
| **Yer değerlendirmeleri**: puan (1-5), kısa not, tarih | "Değerlendir" (yalnızca gezilen yer) | Yer puanı, diğer kullanıcılara bilgi | `place_reviews` | Puan ortalaması herkese; not: yönetici onayından sonra herkese, "@kullanıcıadı" ile | Kullanıcı silince; hesap silinince |
| Altyapı logları (IP, cihaz/uygulama bilgisi, istek zamanı) | Her istek | Güvenlik, hata ayıklama | Supabase logları | Yalnızca proje sahibi | Supabase saklama süresi (plan bazlı, kısa süreli) |

## Cihazda (telefonda) tutulan veriler

| Veri | Amaç | Silinme |
| --- | --- | --- |
| Oturum belirteci (giriş) | Girişli kalmak | Çıkış ya da uygulamayı silme |
| Şehir paketi (yerler, fotoğraf adresleri) | Çevrimdışı kullanım | Uygulamayı silme |
| Ziyaret tarihleri ve kazanılan rozetler (hesap bazında önbellek) | Hızlı gösterim | Çıkışta / hesap silmede temizlenir |
| Kaydedilen yer kimlikleri (hesap veya misafir bazında) | Yer detayındaki kalp seçimini hatırlamak | Kaydı kaldırma, hesap silme veya uygulamayı silme |

## Cihaz izinleri

| İzin | Neden | Zorunlu mu |
| --- | --- | --- |
| Konum | Check-in, yakındaki yerler, kamera ile keşif | Check-in için evet; gezinme için hayır |
| Kamera | Kamera ile keşif (AR), fotoğraf çekme | Hayır |
| Fotoğraf arşivi | Fotoğraf ekleme, profil fotoğrafı | Hayır |
| Hareket sensörleri (pusula) | Kamera ile keşifte yön | Hayır |

## Üçüncü taraflar (cihazdan doğrudan bağlantı)

| Taraf | Ne için | Giden veri |
| --- | --- | --- |
| Supabase (AB) | Tüm sunucu işlemleri | Yukarıdaki veriler |
| Wikimedia Commons | Yer fotoğraflarını göstermek (doğrudan bağlantı) | Cihazın IP adresi, istenen görsel |
| Apple Haritalar (iOS) / Google Haritalar (Android) | Harita görüntüsü | Cihazın IP adresi, görüntülenen bölge (platformun kendi koşulları) |
| Expo (yalnızca geliştirme / güncelleme) | Uygulama dağıtımı | Cihaz ve uygulama sürümü |

## Kullanıcı hakları (KVKK md. 11) — uygulamada karşılığı

| Hak | Nasıl |
| --- | --- |
| Verilerini öğrenme / kopya alma | `export_my_data` (profil, ziyaretler, rozetler, bildirimler, arkadaşlıklar, fotoğraflar, değerlendirmeler tek JSON) |
| Düzeltme | Profil düzenleme; kendi fotoğraf/değerlendirmesini silip yeniden ekleme |
| Silme | Uygulama içinden hesap silme (`delete-account`): hesap, profil, ziyaret, rozet, arkadaşlık, fotoğraf (dosyalarla), değerlendirme silinir; bildirimler kimliksizleşir |
| Görünürlüğü kısma | "Profilim herkese açık" kapalı → yalnızca tam kullanıcı adıyla bulunur |

## Açık konular (KVKK metninden önce karar)

- Veri sorumlusunun kimliği (şahıs mı şirket mi) ve iletişim e-postası
- Yaş sınırı
- Hata takibi / analitik aracı
- E-posta gönderim servisi (SMTP) seçilince üçüncü taraf listesine eklenecek
- Apple/Google ile giriş açılınca: bu sağlayıcılardan gelen ad/e-posta
- Yönetici erişimi: kimler yönetici (şu an yalnızca proje sahibi)
