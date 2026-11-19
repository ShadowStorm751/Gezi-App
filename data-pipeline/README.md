# Veri hattı

Sahibi: Claude. Bir şehirdeki (pilot: İstanbul) tarihi-kültürel ve doğa/manzara yerlerini OpenStreetMap ve Wikidata'dan toplar, senin onayına sunar ve onayladıklarını veritabanına yüklenecek SQL'e çevirir.

Yalnızca Python gerekir (3.9 veya üstü), başka kurulum yok. İnternete eriştiği için **kendi bilgisayarında** çalıştırılır.

## Kod bilmeden: GitHub'da çalıştırma

Hiçbir şey kurmana gerek yok. Veri hattı GitHub'ın sunucularında çalışır (`.github/workflows/data-pipeline.yml`):

- Claude `run-request.txt` dosyasını güncelleyip yüklediğinde ya da sen GitHub'da **Actions → Veri hattı → Run workflow** butonuna bastığında başlar.
- 5-10 dakika sonra sonuç `data-pipeline/results/candidates.csv` olarak depoya eklenir.
- Onay işini sohbette Claude ile birlikte yaparsın. SQL'i Claude üretir, sen yalnızca Supabase'e yapıştırırsın.

## Adımlar (kendi bilgisayarında çalıştırmak istersen)

Bu klasörde bir terminal aç. Windows'ta `python` yerine `py` yazman gerekebilir.

### 1. Veriyi indir (5-10 dakika)

```bash
python pipeline.py fetch
```

OpenStreetMap'ten İstanbul ilindeki adı olan müze, cami, kilise, saray, kale, sarnıç, seyir noktası, tepe, orman, park, plaj, ada ve şelaleleri; Wikidata'dan da bunların TR/EN adlarını, yapım yıllarını, Wikipedia sayfalarını ve fotoğraf bilgilerini indirir. Sunucu yoğunsa birkaç kez dener, olmazsa ikinci bir sunucuya geçer.

### 2. Aday listesini üret

```bash
python pipeline.py candidates
```

`output/candidates.csv` dosyasını yazar: en önemli **200 tarihi** ve **100 doğa** adayı, puana göre sıralı. Aynı yerin kopyaları (aynı Wikidata kaydı ya da 100 m içinde aynı ad) birleştirilir.

### 3. Listeyi onayla

`output/candidates.csv` dosyasını Excel'de ya da Google Sheets'te aç (Sheets: Dosya → İçe aktar, ayırıcı olarak noktalı virgül).

| Sütun | Ne yapmalısın |
| --- | --- |
| `onay` | Almak istediğin yerlere **x** yaz. Boş bırakılanlar alınmaz. |
| `kisa_aciklama_tr`, `kisa_aciklama_en` | 1-2 cümle. İkisi de doluysa yer **yayına alınır**; boşsa yer eklenir ama gizli kalır. |
| `en_iyi_zaman_tr`, `en_iyi_zaman_en` | İsteğe bağlı, doğa yerleri için: "Gün batımı" / "Sunset". |
| `ad_tr`, `ad_en` | Kontrol et; `ad_en` boşsa doldur (zorunlu). |
| `kategori`, `donem`, `yaricap_m` | Gerekirse düzelt. `donem` yapım yılından tahmin edildi. |
| `wikidata_ipucu_*`, `wikipedia_*`, `fotograf` | Yalnızca bilgi için; açıklama yazarken yardımcı olur. |
| `slug`, `enlem`, `boylam`, `wikidata`, `osm`, `alan_var` | Değiştirme. |

Hedef: 100-150 yer, yaklaşık üçte biri doğa. Dosyayı aynı adla, aynı biçimde (CSV) kaydet.

Wikipedia metinlerini birebir kopyalama; açıklamaları kendi cümlelerinle yaz. İstersen onayladığın listenin açıklama taslaklarını Claude yazabilir.

### 4. SQL üret ve yükle

```bash
python pipeline.py build
```

`output/places_import.sql` dosyasını yazar. Supabase panelinde **SQL Editor**'a yapıştırıp çalıştır. Dosya tekrar çalıştırılabilir: aynı yer ikinci kez eklenmez, güncellenir. Boş bıraktığın açıklamalar veritabanındaki mevcut açıklamayı silmez.

## Şehirler

Şehir ayarları `cities.py` içinde: Overpass bölgesi, şehre özgü ek OSM etiketleri ve sınıflandırma kuralları, kota, kategori sınırları, dönem eşikleri. Komutlar `--city` alır (varsayılan `istanbul`):

```bash
python pipeline.py --city izmir fetch        # çıktı: output/izmir/
python pipeline.py --city izmir candidates
python photos.py --city izmir                 # results/izmir/photos.json
python content/build_city.py izmir --out ../backend/supabase/migrations/<zaman>_izmir_places.sql
```

| Şehir | Bölge | Not |
| --- | --- | --- |
| `istanbul` | İstanbul ili | Pilot; ayarlar ve çıktı değişmedi |
| `izmir` | İzmir ili | Efes/Selçuk, Bergama, Çeşme dahil; dönem: Antik, Bizans, Beylikler, Osmanlı |
| `bursa` | Bursa ili | Uludağ, İznik, Cumalıkızık dahil; 1326'dan sonrası Osmanlı |
| `kapadokya` | Nevşehir ili + Ihlara/Selime (Aksaray) + Soğanlı (Kayseri) | Ek etiketler: vadi, kaya oluşumu, kaya kiliseleri, turistik yerler; yeni kategori `valley` |

- Sonuçlar: İstanbul `results/`, diğer şehirler `results/<şehir>/` (candidates.csv, areas.json, ham veri, shortlist.json, photos.json).
- GitHub'da: `run-request.txt` / `photos-request.txt` içine `Şehirler: izmir` satırı yazılır; main ya da `data/*` dalına yüklenince iş çalışır ve sonucu o dala commit'ler. Büyük illeri **tek tek** çalıştır: iş en fazla 40 dakika sürer, aynı dalda yeni istek eskisini iptal eder.
- Her çalıştırma, başarısız olsa da, `results/<şehir>/status.txt` yazar: ilk satır `ok` ya da `failed`, sonra zaman, sayılar ya da hatanın son satırları ve çalıştırmanın adresi.
- Büyük illerde (`chunked`) Overpass'a her etiket grubu ayrı sorgulanır; alan sınırı gerekmeyen gruplar `out center` ile gelir. Bütün denemeler için toplam süre sınırı var (`fetch --budget-min`, varsayılan 20).
- Açıklamalar: `content/<şehir>_descriptions.py` (İstanbul'la aynı biçim; isteğe bağlı `COORD_FIX`, `PHOTO_EXCLUDE`).
- Migration: `content/build_city.py` şehir kaydı + gerekiyorsa yeni kategori + yerler + fotoğraflar üretir. Yeni şehirlerin yerleri **gizli** eklenir (`is_published = false`); var olan migration dosyasının üzerine yazmaz.

## İstanbul listesi (onaylandı, 2026-11-19)

- `results/shortlist.json`: proje sahibinin onayladığı yerler (koordinat ve alan sınırlarıyla).
- `content/istanbul_descriptions.py`: TR/EN kısa açıklamalar, en iyi ziyaret zamanı, dönem ve yapım yılı; listeden çıkarılanlar ve nedenleri.
- `content/build_istanbul.py`: ikisinden `backend/supabase/migrations/20261119120000_istanbul_places.sql` dosyasını üretir. Açıklama ya da yer değişirse migration'ı elle düzenleme; script'i çalıştır, çıkan dosyayı yeni bir migration olarak ekle.

## Fotoğraflar

- `photos.py` (GitHub Actions: `photos.yml`, tetik: `photos-request.txt`): her onaylı yerin Wikidata görselini bulur, Commons'tan yazar ve lisans bilgisini alır. Yalnızca CC0, kamu malı, CC BY, CC BY-SA ve FAL kabul edilir. Sonuç: `results/photos.json`.
- `content/build_photos.py`: `results/photos.json` → `backend/supabase/migrations/20261119140000_istanbul_photos.sql`. Yanlış eşleşen kayıtlar `EXCLUDE` ile elenir.
- Fotoğraflar Wikimedia'nın adresinden gösterilir (kopyalanmaz); atıf mobilde zorunlu.

## Notlar

- `output/` klasörü repoya girmez (`.gitignore`). Onaylı CSV'yi paylaşmak istersen Claude'a ayrıca gönder.
- Orman, koru, park, plaj, ada ve ören yerlerinde OSM'de alan sınırı varsa (`alan_var = evet`), check-in için alanın içinde olmak yeterli olur.
- Lisans: OSM verisi ODbL (uygulamada "© OpenStreetMap katkıcıları" atfı), Wikidata CC0. Fotoğraflar henüz indirilmiyor; `fotograf` sütunu Wikimedia Commons dosya adıdır.

## Testler

```bash
python -m unittest discover -s tests
```

İnternet gerekmez; `tests/fixtures/` içindeki örnek OSM ve Wikidata yanıtlarıyla çalışır.
