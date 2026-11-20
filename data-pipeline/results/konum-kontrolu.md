# Konum kontrolü: Wikidata konumu olmayan yerler (2026-11-20)

`coords_check.py` sonuçları (`results/<şehir>/coords_check.json`) elle incelendi. 39 yer:

- **Doğrulandı (14):** başka bir kaynak (Wikipedia, adı geçen Commons fotoğrafları) OSM konumunu tolerans içinde doğruluyor.
- **"Şüpheli" (13):** elle bakıldı. Çoğu ölçüm hatası: Wikipedia aramasında ilçe maddesi (Çiğli, Dikili, Selçuk…) bulunmuş
  ya da Commons fotoğrafları yerin kendisinden değil çevresinden. Gerçek bir sorun yalnızca aşağıdakilerde çıktı.
- **Bağımsız kanıt yok (12):** plaj, şelale ve küçük kiliseler. OSM öğesi var, adı tutuyor, konumu bilinen
  coğrafyayla uyumlu (ilçe/köy/vadi). Tek kaynak OSM.

Bütün OSM öğeleri hâlâ var, adları tutuyor ve konumları bizimkiyle aynı (fark 0 m).

## Düzeltilenler

| Yer | Sorun | Yapılan |
| --- | --- | --- |
| `kursunlu-plaji` (Bursa) | OSM konumu Karacabey'deki Kurşunlu (40.397, 28.294); açıklama Gemlik'teki Kurşunlu'yu anlatıyordu (65 km doğuda) | Açıklama Karacabey'e göre düzeltildi; konum aynı |
| `aktepe-hill-sunset-point` (Kapadokya) | Açıklama "Göreme'nin üzerindeki seyir noktası" diyordu; OSM noktası Zelve'nin güneyinde, Kızılçukur'un yanında Aktepe | Açıklama düzeltildi; konum aynı |

## Bakılıp doğru bulunanlar

| Yer | Neden şüpheli göründü | Sonuç |
| --- | --- | --- |
| `mayor-sinagogu` (Bursa) | Wikipedia koordinatı 5,5 km uzakta (40.229, 29.092) | Wikipedia koordinatı yanlış: sinagog Arap Şükrü Sokağı'nda; OSM konumu o sokakta (yakındaki fotoğraflar "Arapşükrü sokağı") |
| `antik-tiyatro` (Gölyazı) | Commons fotoğrafları 464 m | vici.org konumu (40.16946, 28.682827) ile 35 m fark; doğru |
| `izmir-kus-cenneti` | Commons fotoğrafları deltanın içinde, 10 km | Ziyaretçi merkezi Çiğli'ye 10 km; OSM noktası bununla uyumlu |
| `zelve-acik-hava-muzesi` | Commons 969 m | Fotoğrafların çoğu Paşabağları'ndan (1 km); doğru |
| `oylat-selalesi`, `sahin-tepesi`, `ihlara-cam-teras`, `soganli-yilanli-kilise` | Commons orta değeri 260–890 m | Fotoğraflar çevreden; konum makul |

## Hâlâ belirsiz

- `soganli-tahtali-kilise`: OSM ile Wikidata 127 m farklı; ikisinin ortası, 80 m check-in alanı.
