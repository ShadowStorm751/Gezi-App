# AGENTS.md — yapay zekâ asistanları için kurallar

Bu repoda iki asistan birlikte çalışır: **Claude** (backend, veri hattı) ve **ChatGPT** (mobil). Proje sahibi ürün kararlarını verir.

## Önce oku

1. `docs/TECHNICAL_PLAN.md` — kapsam, kararlar, mimari.
2. `docs/API.md` — backend ↔ mobil sözleşmesi. Burada olmayan bir fonksiyonu kullanma, uydurma.
3. `docs/REQUESTS.md` — açık istekler.

## Sahiplik

| Klasör | Sahibi | Diğer taraf |
| --- | --- | --- |
| `backend/`, `data-pipeline/` | Claude | Değiştirmez; ihtiyacını `docs/REQUESTS.md`'ye yazar |
| `mobile/` | ChatGPT | Değiştirmez; sorununu `docs/REQUESTS.md`'ye yazar |
| `docs/` | Ortak | API.md'yi yalnızca backend değiştirir |
| `assets/` | Ortak | Görseller (rozetler); iki taraf da kullanır |

## Kurallar

- **Sözleşme:** Backend bir RPC'nin adını, parametresini ya da dönüş alanını değiştirirse `docs/API.md`'yi aynı commit'te günceller. Geriye uyumsuz değişiklik `docs/REQUESTS.md`'ye not edilir.
- **Kişisel veri:** Kişisel veri toplayan ya da değiştiren her özellikte `docs/VERI_ENVANTERI.md` aynı commit'te güncellenir (KVKK metni bu dosyadan yazılacak).
- **Gizli bilgi:** `service_role` key, `.env` dosyaları ve kişisel veri repoya girmez. Mobilde yalnızca anon key kullanılır.
- **Dil:** Kod tanımlayıcıları İngilizce; dokümanlar, yorumlar ve commit açıklamaları Türkçe olabilir. Kullanıcıya görünen her metin TR + EN.
- **Şema değişikliği:** Var olan migration dosyaları düzenlenmez; yeni zaman damgalı migration eklenir (`backend/supabase/migrations/YYYYMMDDHHMMSS_ad.sql`).
- **Test:** Check-in kuralları değişirse `rules.test.ts` güncellenir ve geçmelidir.
- **Commit:** Küçük, tek konulu commit'ler; mesaj ne değiştiğini söyler.

## Komutlar

```bash
# Check-in kural testleri (Node 22.6+)
node --experimental-strip-types --test backend/supabase/functions/checkin/rules.test.ts

# Yerel Supabase (Docker + Supabase CLI gerekir) — ayrıntı: backend/README.md
cd backend && supabase start && supabase db reset
```
