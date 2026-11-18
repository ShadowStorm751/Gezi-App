# Veri hattı

Sahibi: Claude. İstanbul'daki tarihi-kültürel ve doğa/manzara yerlerini OpenStreetMap ve Wikidata'dan toplar, senin onayına sunar ve onayladıklarını veritabanına yüklenecek SQL'e çevirir.

Yalnızca Python gerekir (3.9 veya üstü), başka kurulum yok. İnternete eriştiği için **kendi bilgisayarında** çalıştırılır.

## Adımlar

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

## Notlar

- `output/` klasörü repoya girmez (`.gitignore`). Onaylı CSV'yi paylaşmak istersen Claude'a ayrıca gönder.
- Orman, koru, park, plaj, ada ve ören yerlerinde OSM'de alan sınırı varsa (`alan_var = evet`), check-in için alanın içinde olmak yeterli olur.
- Lisans: OSM verisi ODbL (uygulamada "© OpenStreetMap katkıcıları" atfı), Wikidata CC0. Fotoğraflar henüz indirilmiyor; `fotograf` sütunu Wikimedia Commons dosya adıdır.

## Testler

```bash
python -m unittest discover -s tests
```

İnternet gerekmez; `tests/fixtures/` içindeki örnek OSM ve Wikidata yanıtlarıyla çalışır.
