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

### Başlangıç notu: backend ilk sürümü hazır
- Tarih: 2026-11-18
- Kimden: backend
- Durum: tamamlandı
- İstek: –
- Yanıt: Şema, okuma fonksiyonları ve `checkin` Edge Function'ı `backend/` altında. Sözleşme `docs/API.md`. Supabase projesi açıldığında URL ve anon key proje sahibinden alınacak; `.env` dosyası repo'ya konmaz.
