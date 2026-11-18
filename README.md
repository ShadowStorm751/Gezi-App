# Gezi App

İstanbul'dan başlayarak tarihi-kültürel yerleri ve doğa/manzara noktalarını keşfettiren mobil uygulama. Kullanıcı yerlerin yakınında GPS ile check-in yapar, rozet kazanır, şehri tamamlamaya çalışır ve yıl sonunda paylaşılabilir bir özet alır. Kamerayı çevirince yakındaki yerler ekranda etiket olarak görünür (geo-AR).

## Klasörler

| Klasör | İçerik | Sorumlu |
| --- | --- | --- |
| [`docs/`](docs/) | [Teknik plan](docs/TECHNICAL_PLAN.md), [API sözleşmesi](docs/API.md), [istekler](docs/REQUESTS.md) | Ortak |
| [`backend/`](backend/) | Supabase: veritabanı şeması, SQL fonksiyonları, check-in Edge Function'ı | Claude |
| [`mobile/`](mobile/) | React Native (TypeScript) uygulaması | ChatGPT |
| [`data-pipeline/`](data-pipeline/) | OSM + Wikidata'dan yer verisini toplayan script'ler | Claude |

## Birlikte çalışma kuralları

1. **Sözleşme `docs/API.md`.** Mobil yalnızca orada yazan fonksiyonları kullanır. Backend bir imzayı değiştirirse API.md'yi aynı commit'te günceller.
2. **Herkes kendi klasöründe.** Diğer tarafın klasöründe değişiklik gerekiyorsa `docs/REQUESTS.md`'ye yazılır.
3. **Gizli bilgi repo'ya girmez.** Supabase anahtarları `.env` dosyalarında kalır (`.gitignore`'da).
4. **Küçük ve açıklamalı commit'ler.** Commit mesajı ne değiştiğini söyler.

Yapay zekâ asistanları için ayrıntılı kurallar: [`AGENTS.md`](AGENTS.md).

## Durum

- [x] Teknik plan ve API sözleşmesi
- [x] Veritabanı şeması, erişim kuralları, okuma fonksiyonları
- [x] Check-in Edge Function'ı ve rozet motoru
- [x] Geliştirme verisi: İstanbul'dan 15 yer, 20 rozet
- [ ] Supabase projesinin açılması
- [x] Veri hattı: OSM + Wikidata → onay listesi → SQL
- [ ] Gerçek İstanbul listesi (100-150 yer, proje sahibinin onayıyla)
- [ ] Mobil uygulama
