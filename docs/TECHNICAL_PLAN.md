# Gezi App – MVP Teknik Plan (İstanbul Pilotu)

Son güncelleme: 20 Kasım 2026 (akşam). Bu dosya projenin ortak referansıdır; Claude, ChatGPT ve proje sahibi buradan okur.

## Özet ve kapsam

MVP, İstanbul'da 100-150 yeri (yaklaşık %65 tarihi-kültürel, %35 doğa ve manzara) Supabase + PostGIS üzerinde sunar. Check-in, rozet ve özet mantığı tamamen sunucuda çalışır.

- **Tarihi ve kültürel:** müze, cami, kilise, sinagog, saray, köşk, sur ve kale, kule, sarnıç, türbe, ören yeri, anıt.
- **Doğa ve manzara:** seyir noktası, tepe, koru ve orman, park ve bahçe, sahil ve plaj, ada, şelale.

### Kararlar

| Konu | Karar |
| --- | --- |
| Pilot şehir | İstanbul |
| Mobil | React Native (TypeScript) |
| Backend | Supabase: Postgres + PostGIS, Auth, Storage, Edge Functions |
| Dil | İlk sürümden TR + EN. Bir yer iki dilde de adı ve kısa açıklaması olmadan yayına alınamaz. |
| Harita | Mobil `react-native-maps` kullanıyor; çevrimdışı karo indirme ayrı bir özellik |
| Fotoğraflar | Wikimedia Commons, yalnızca serbest lisans (CC0, kamu malı, CC BY, CC BY-SA, FAL); Wikimedia adresinden gösterilir, yazar ve lisans atfı zorunlu |
| Mobil test | iPhone'da App Store Expo Go ile (SDK 58) |
| Tasarım | "Sıcak keşif": `docs/TASARIM.md` (renk, yazı, boşluk, bileşenler, 5 ana ekran, animasyon zaman çizelgeleri); mobilde `mobile/theme.js` tek kaynak |
| Yeni şehirler | Veri ayrı bir sohbette `data/yeni-sehirler` dalında hazırlanıyor (aday adaylar: İzmir, Bursa, Kapadokya); yerler `is_published = false` eklenir, İstanbul testinden sonra açılır. Canlı Supabase'i yalnızca ana sohbet günceller |

### İş bölümü

| Alan | Sorumlu | Klasör |
| --- | --- | --- |
| Backend: şema, SQL fonksiyonları, check-in, rozet motoru, güvenlik | Claude | `backend/` |
| Veri hattı: OSM + Wikidata → onaylı yer listesi | Claude (script), proje sahibi (onay) | `data-pipeline/` |
| Mobil: ekranlar, harita, geo-AR kamera, paylaşım kartı | ChatGPT | `mobile/` |
| Ürün kararları, yer listesinin onayı, içerik kalitesi | Proje sahibi | – |

İki taraf arasındaki tek sözleşme [`docs/API.md`](API.md). Mobil tarafın backend'den istekleri [`docs/REQUESTS.md`](REQUESTS.md) dosyasına yazılır.

## Mimari

```
Mobil uygulama (React Native)            Supabase                          Veri hattı (Python)
 ├─ Harita ve liste ───────┐              ├─ Auth (e-posta, Apple, Google)   ├─ OSM / Overpass
 ├─ Geo-AR kamera ─────────┼── RPC ──────▶├─ RPC fonksiyonları (okuma)       ├─ Wikidata
 ├─ Paylaşım kartı ────────┤              ├─ Edge Function: checkin          ├─ birleştir, puanla
 ├─ Yerel şehir paketi ────┘              ├─ Postgres + PostGIS  ◀───────────┴─ onaylı liste → seed
 └─ Check-in butonu ──── Edge Function ──▶└─ Storage (fotoğraf, rozet, avatar)
```

- Okumalar Postgres fonksiyonlarıyla (RPC). Mantık veriye yakın kalır, ayrı sunucu gerekmez.
- Tek yazma işlemi check-in. Edge Function üzerinden geçer, kurallar istemciden bağımsız işler.
- Her şema değişikliği `backend/supabase/migrations/` altında bir migration dosyasıdır.

## Veri modeli

Tam şema: [`backend/supabase/migrations/20261118120000_schema.sql`](../backend/supabase/migrations/20261118120000_schema.sql)

| Tablo | Amaç |
| --- | --- |
| `cities` | Şehirler (ad TR/EN, saat dilimi, sınır) |
| `categories`, `category_translations` | Yer türleri; her kategori `historical` ya da `nature` |
| `places` | Yerler: konum (nokta), isteğe bağlı alan (poligon), check-in yarıçapı, dönem, yapım yılı |
| `place_translations` | TR/EN ad, kısa ve uzun açıklama, en iyi ziyaret zamanı |
| `place_photos` | Fotoğraflar; lisans ve yazar bilgisiyle |
| `profiles` | Kullanıcı adı, avatar, gizlilik, tercih edilen dil |
| `visits` | Ziyaretler: yere mesafe, GPS doğruluğu, `flagged` |
| `achievements`, `achievement_translations` | Rozet tanımları (JSON kural) |
| `user_achievements` | Kazanılan rozetler |

**Doğa yerleri için iki fark:** büyük alanlarda (Belgrad Ormanı, Emirgan Korusu, adalar) `area` poligonu tutulur ve alanın içinde olmak check-in için yeterlidir. Doğa yerlerinde `period` yerine `best_time` alanı kullanılır.

**Gizlilik:** kullanıcının koordinatı saklanmaz; yalnızca check-in anında yere olan mesafe ve GPS doğruluğu kaydedilir.

## Check-in kuralları

Ölçüm SQL'de (`checkin_context`), karar `backend/supabase/functions/checkin/rules.ts` içinde. Sıra:

1. Yer var ve yayında mı? Değilse `place_not_found`.
2. Bu yer zaten gezilmiş mi? İse `already_visited`.
3. Son 1 dakikada 5 check-in varsa `rate_limited`.
4. GPS doğruluğu 50 m'den kötüyse `low_accuracy`.
5. İzin verilen mesafe = `checkin_radius_m` + GPS doğruluğu (en fazla 50 m). Alanı olan yerlerde alanın içinde olmak yeterli. Değilse `too_far`.
6. Önceki check-in'e göre gereken hız 150 km/s üstündeyse ziyaret kaydedilir ama `flagged` olur ve rozetlere sayılmaz. (Önceki yer 200 m'den yakınsa GPS oynaması sayılır.)

**Varsayılan yarıçaplar:** tek yapı 60-100 m; büyük kompleks (Topkapı, Dolmabahçe) 150 m; seyir noktası 50 m; orman, koru, ada poligonla doğrulanır.

Sahte GPS'e karşı MVP'de hız kontrolü yeterli. Sonra: Android Play Integrity, iOS App Attest, fotoğrafla doğrulama.

## Rozet kuralları

Rozetler `achievements.rule` JSON'u ile tanımlanır; yeni rozet için uygulama güncellemesi gerekmez. Her başarılı check-in'den sonra `evaluate_achievements` çalışır. Yalnızca işaretlenmemiş ziyaretler sayılır.

| Tür | Örnek | Anlamı |
| --- | --- | --- |
| `total_count` | `{"type":"total_count","n":10}` | Toplam n yer |
| `kind_count` | `{"type":"kind_count","kind":"nature","n":5}` | n doğa (ya da tarihi) yer |
| `category_count` | `{"type":"category_count","category":"viewpoint","n":5}` | Bir kategoriden n yer |
| `period_count` | `{"type":"period_count","period":"Bizans","n":3}` | Bir dönemden n yer |
| `city_complete` | `{"type":"city_complete","city":"istanbul","kind":"historical"}` | Şehirdeki tüm (tarihi) yerler |
| `place_set` | `{"type":"place_set","places":["buyukada","heybeliada"]}` | Belirli yerlerin hepsi |
| `time_of_day` | `{"type":"time_of_day","category":"viewpoint","from":"17:00","to":"20:00","n":3}` | Belirli saatlerde n check-in (yerel saat) |
| `streak_weeks` | `{"type":"streak_weeks","n":4}` | Art arda n hafta, her hafta en az bir yer |

Seed'de 20 rozet var (6 genel, 8 tarihi, 6 doğa); türbe ile 21, 'Şehir Gönüllüsü' ile 22.

## Yıllık özet

`my_summary(for_year)`: toplam yer, tarihi/doğa dağılımı, en çok gezilen şehir, en eski yapı, favori dönem ve kategori, gezilen yerler arası mesafe, gün batımı check-in'leri, kazanılan rozet sayısı, en yoğun ay. Yıl içinde "şu ana kadarki özet" olarak çalışır. Paylaşım kartı görselini mobil çizer.

## Veri hattı

1. **Çek:** Overpass API ile İstanbul sınırı içinde aşağıdaki etiketler; Wikidata SPARQL ile yapım yılı, fotoğraf, TR/EN adlar.
2. **Birleştir:** OSM `wikidata=Q…` etiketiyle eşleştir; 30 m'den yakın aynı adlı kayıtları tekilleştir.
3. **Puanla:** Wikipedia makalesi, dil sayısı, fotoğraf gibi sinyallerle önem puanı. En yüksek ~300 aday.
4. **Onayla:** Adaylar CSV'ye dökülür; proje sahibi 100-150 yer seçer, açıklamaları kontrol eder.
5. **Yükle:** Onaylananlar SQL'e dönüşür. Script tekrar çalıştırılabilir, kopya üretmez.

| Aile | OSM etiketleri |
| --- | --- |
| Tarihi-kültürel | `tourism=museum`, `historic=*` (castle, monument, ruins, archaeological_site, city_gate), `amenity=place_of_worship` + `heritage=*`, `building=palace` |
| Doğa-manzara | `tourism=viewpoint`, `natural=peak`, `natural=wood`, `landuse=forest`, `leisure=park` + `wikidata`, `leisure=nature_reserve`, `natural=beach`, `waterway=waterfall`, `place=island` |

**Lisans:** OSM verisi ODbL; uygulamada "© OpenStreetMap katkıcıları" atfı zorunlu. Wikidata CC0. Wikimedia fotoğraflarının lisansı ve yazarı `place_photos` tablosunda saklanır. Wikipedia metinleri birebir kopyalanmaz, açıklamalar yeniden yazılır.

## Güvenlik ve gizlilik

- **RLS:** içerik tablolarını herkes okur, yalnızca admin (`app_metadata.role = 'admin'`) yazar. Ziyaret ve rozetleri kullanıcı yalnızca kendisininkileri okur. Yazma yalnızca service role ile (checkin Edge Function'ı).
- **KVKK:** aydınlatma metni ve gizlilik politikası; uygulama içinden hesap silme (Faz 4); `export_my_data` ile veri dışa aktarma; konum izni yalnızca "uygulama açıkken".
- **Sunucu bölgesi:** Supabase projesi AB'de (Frankfurt). Yurt dışına veri aktarımı için KVKK adımları bir hukukçuyla teyit edilmeli.
- **Performans:** `nearby_places` GiST indeksiyle hızlı. Mobil, `city_pack` ile şehrin tüm yerlerini açılışta bir kez indirir; harita ve geo-AR yerel veriyle çalışır.

## Fazlar

| Faz | Süre | Backend işleri | Durum |
| --- | --- | --- | --- |
| 0 – Hazırlık | 1-2 hf | Supabase projesi, repo ve migration yapısı, veri hattı, yer onayı | Tamam |
| 1 – Altyapı | 3-4 hf | Şema, okuma RPC'leri, RLS, testler, İstanbul verisi | Tamam; canlıda 156 yer, 154 fotoğraf |
| 2 – Ziyaret ve başarım | 3-4 hf | Auth (e-posta), `checkin`, rozet motoru, ilerleme | Tamam; canlı uçtan uca test geçti. Apple/Google girişi bekliyor |
| 3 – Geo-AR | 3-4 hf | `city_pack` (+ `has_area`, `thumb_url`, `period`) | Backend tamam; mobil kamera ekranı var, saha testi bekliyor |
| 4 – Paylaşım ve özet | 2-3 hf | `my_summary`, hesap silme, avatar, rotalar, arkadaşlar, öneriler, kullanıcı fotoğrafları, değerlendirmeler | Backend tamam; mobil kodu tamam, iPhone kabul testi bekliyor |
| 5 – Kapalı beta | 3-4 hf | Hata takibi, analitik, kullanıcı bildirimleri (tamam), ayrı canlı (production) proje | Bildirim akışı tamam; diğerleri yapılacak |

## Canlıdaki durum (20 Kasım 2026, akşam denetimi)

- Supabase projesi `gezi-app-test` (Frankfurt). 51 migration uygulandı; depodaki `backend/supabase/migrations/` ile birebir aynı. Son eklenen: `city_pack` yerlerine `period`/`period_code` (Keşfet kartlarındaki "OSMANLI · CAMİ" satırı için).
- 156 İstanbul yeri (113 tarihi, 43 doğa), hepsinde TR+EN kısa ve uzun açıklama; 154'ünde fotoğraf; 27 rozet, görselleri Storage'da; 11 hazır rota.
- Canlıda kayıtlı kullanıcı yok (test kullanıcıları silindi); ilk gerçek hesap iPhone testinde açılacak.
- `checkin`, `delete-account`, `badge-upload`, `photo-cleanup`, `content-apply` Edge Function'ları yayında; geçici test fonksiyonları 410 dönen boş sürüme çevrildi.
- Canlı testler: sosyal + rota 29/29, kullanıcı fotoğrafları 28/28; modüler rozet/KVKK yapısı için eşdeğerlik testi geçti; `backend/tests/audit.sql` temiz (77 fonksiyon, 19 tablo).
- Güvenlik denetçisinde yalnızca bilinçli SECURITY DEFINER uyarıları var (yazma RPC'leri, `backend/README.md`); performans denetçisinde yalnızca "kullanılmayan indeks" bilgileri.

### Mobil durum (20 Kasım, ChatGPT'nin son çalışması incelendi)

- Yeni tasarım uygulandı: `theme.js` + Fraunces/DM Sans, beş alt sekme, Keşfet (arama, çipler, öneri kartları, yakındakiler), tam sayfa yer detayı (galeri, sabit "Buradayım" çubuğu), tam ekran harita ve seçili yer kartı, Buradayım sonuç sayfası, sıralı rozet kutlaması, Reanimated + haptik, "hareketi azalt" desteği.
- Kullanıcı fotoğrafları (yayın onayıyla), yer değerlendirmeleri (yıldız dağılımı, Değerlendirmelerim), semt araması ve kaydedilen yerler eklendi; `VERI_ENVANTERI.md` güncellendi.
- Kontrol: kullanılan bütün RPC'ler `API.md`'de ve parametreleri doğru; ekranlarda çıplak renk kodu yok; 33 dosyada sözdizimi hatası yok; mobil testleri 28/28 geçiyor; repoda gizli anahtar ya da `.env` yok.
- Bulunan ve backend'de düzeltilen: mobil, paketteki yerlerin dönemini okuyordu ama `city_pack` bu alanı vermiyordu; eklendi. Mobilde küçük iş: paketteki `period_code`'u da `mapPlace`'e eklemek (rozet eşlemesi için) ve semt (`district`) alanının pakette olmadığını bilmek (`REQUESTS.md`).
- Bekleyen: fiziksel iPhone kabul testi (yerleşim, haptik, animasyonlar, kamera/galeri, iki hesapla arkadaşlar).

## Yayına kadar kalanlar

Backend (Claude):
- [x] `city_pack` yerlerine dönem (`period`, `period_code`); Keşfet kartlarında dönem satırı için
- [x] Sıcak keşif tasarım sistemi ve ana akış ekran taslakları (Claude Design), `docs/TASARIM.md`
- [x] Hesap silme: `delete-account` Edge Function (canlıda, test edildi)
- [x] Avatar yükleme: yalnızca kendi klasörü, 2 MB, JPEG/PNG/WebP (canlıda, test edildi)
- [x] Kullanıcı katkısı: hata bildirimi ve yeni yer önerisi, yönetici onay akışı, 'Şehir Gönüllüsü' rozeti (canlıda, test edildi)
- [x] Şehir listesi: `list_cities` (canlıda)
- [x] İstanbul uzun açıklamaları (TR+EN, 2 paragraf): 156/156 canlıda (15 parti), `content-apply` ile yüklendi (`data-pipeline/content/istanbul_long_descriptions.py`). Kaynaksız 4 yer (Anadolu Kavağı ve Yeniköy seyir noktaları, Hacıllı Şelalesi, Telli Baba) temkinli yazıldı; yerinde doğrulanmalı.
- [x] Modüler yapı: rozet kuralları (`ach_rule_*`) ve KVKK bölümleri (`export_section_*`) parçalara ayrıldı; `backend/MODULES.md` + `backend/tests/audit.sql`
- [x] Yer değerlendirmeleri: 1-5 yıldız + onaylı not, puan özeti place_detail'de (canlıda)
- [x] Kişisel veri envanteri: `docs/VERI_ENVANTERI.md` (KVKK metninin kaynağı; her yeni özellikte güncellenir)
- [x] Kullanıcı fotoğrafları: yükleme, yönetici onayı, otomatik temizlik, 'Gezi Fotoğrafçısı' rozeti (canlıda; canlı test 28/28)
- [x] Kişisel öneriler: `recommendations` (gezilmemiş yerler, yarım kalan rotalar, bitmek üzere rozetler; canlıda)
- [x] Arkadaşlar ve sıralama: istek/kabul, kullanıcı arama, haftalık/aylık/yıllık sıralama, 'Gezi Arkadaşı' ve 'Gezi Ekibi' rozetleri (canlıda)
- [x] Hazır rotalar: `list_routes`, `route_detail`, İstanbul'da 11 rota, 'Rotacı' ve 'Rota Ustası' rozetleri (canlıda)
- [ ] Yeni şehir migration'larının gözden geçirilip uygulanması (`data/yeni-sehirler` dalı bitince)
- [ ] Ayrı canlı (production) Supabase projesi; migration'ların GitHub Actions ile uygulanması
- [x] Yayın öncesi güvenlik/performans denetimi ve sertleştirme
- [ ] E-posta gönderimi için özel SMTP (Supabase'in yerleşik e-postası saatte birkaç iletiyle sınırlı; beta öncesi şart)
- [ ] Apple/Google ile giriş: anahtarlar gelince Supabase Auth sağlayıcı ayarı
- [ ] Hata takibi ve analitik (kapalı beta için; araç seçimi açık konu)
- [x] Fotoğrafı olmayan 23 yerin 21'ine elle seçilmiş Commons fotoğrafı (154/156); son 3'ü (Aydos Ormanı, Hacıllı Şelalesi, Yeniköy Seyir Terası) hedefli aramayla bulundu. Kalan 2 yerde (Beykoz Korusu, Telli Baba Türbesi) yere ait serbest lisanslı fotoğraf yok; kendi çekimimiz ya da onaylı kullanıcı fotoğrafı beklenir

Mobil (ChatGPT):
- [x] Expo SDK 54 → 58 (iPhone Expo Go ile çalışıyor)
- [x] Rotalar listesi ve rota detayı ekranları
- [x] Arkadaşlar ve sıralama ekranları
- [x] "Sana önerilenler" bölümü
- [x] Fotoğraf ekleme ve "Fotoğraflarım" ekranları
- [x] Yer puanı, değerlendirmeler ve "Değerlendir" ekranları
- [x] Hesap silme, avatar, "Bir sorun mu var?", "Yer öner" ve "Katkılarım" ekranları
- [x] Haritada "© OpenStreetMap katkıcıları" atfı (ODbL lisans şartı)
- [x] Sıcak keşif tasarımı ve animasyonlar (`docs/TASARIM.md`)
- [ ] `city_pack.period_code` → `mapPlace` (rozet ilerlemesi listelerde de doğru çalışsın; `docs/REQUESTS.md`)
- [ ] Rotalar, Rozetler ve Profil sekmelerinin yeni tasarıma göre son rötuşu (tasarımları henüz çizilmedi)
- [ ] Fiziksel iPhone kabul testi (tüm akış)

Proje sahibi:
- [ ] Apple Developer hesabı ve Google Cloud ayarı (Apple/Google ile giriş, mağaza yayını)
- [ ] KVKK aydınlatma metni ve gizlilik politikası (özellikler bitince; kaynak `docs/VERI_ENVANTERI.md`; hukukçu onayı gerekir)
- [ ] Yeni şehir aday listelerinin onayı
- [x] 'Şehir Gönüllüsü' (city-helper) rozet görseli
- [x] 'Rotacı' (route-first) ve 'Rota Ustası' (route-master) rozet görselleri
- [x] 'Gezi Arkadaşı' (first-friend) ve 'Gezi Ekibi' (travel-crew) rozet görselleri
- [x] 'Gezi Fotoğrafçısı' (photographer) rozet görseli
- [ ] Yönetici için onay ekranı: fotoğraflar, değerlendirme notları, yer bildirimleri (şimdilik Supabase SQL editöründen)
- [ ] Canlı (production) projede `app_settings.storage_public_base` değerini yeni proje adresiyle güncellemek

## Açık konular

- Kapalı beta için kullanıcı sayısı ve tarih (plan: pilot şehirde 20-50 kişi).
- Harita karolarının çevrimdışı indirilmesi gerekli mi?
- Hata takibi/analitik aracı: Sentry + PostHog (AB sunucusu) önerisi; KVKK metnine de girmeli.
- Rozetlerin kazanılmamış hâli: ayrı görsel yok, gri ve yarı saydam gösteriliyor; yeterli mi?
