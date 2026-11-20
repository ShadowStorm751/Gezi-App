# Yeni rozetler: İzmir, Bursa, Kapadokya "keşif" rozetleri (16)

Durum: **15 görsel hazır, `mustafapasa-kesif` görseli bekleniyor** (2026-11-20). 15 görsel `assets/badges/<slug>.webp` (512×512, şeffaf); `badge_path` migration'ı `20261121020000_kesif_badge_paths.sql`.
Not: Gemini halka rengini her rozette aynı petrol mavisi yaptı; set tutarlı göründüğü için olduğu gibi bırakıldı.
Canlıya alırken: migration uygulanır, `badge-upload` fonksiyonu yeniden deploy edilir, sonra Rozet görselleri iş akışı çalıştırılır.
Mevcut 21 rozet Gemini ile çizildi. Aynı görünmeleri için aşağıdaki ortak üslup + her rozetin konusu Gemini'ye verilir.
Görseller gelince Claude kırpar, arka planı şeffaflaştırır, 512×512 `.webp` yapar ve `badge_path` için yeni bir migration ekler.

## Ortak üslup (her istemin başına eklenir)

> Circular collector's badge, 1:1 square image, centered on a plain white background. Two thick concentric outer rings
> in a single accent colour with a thin cream line between them. Inside the circle: a flat vector illustration with
> clean dark-brown outlines, simple shading, limited warm palette, no text, no letters, no numbers, no people's faces.
> Same style as a set of travel-app achievement badges.

## Rozetler

| Rozet slug'ı | Ad (TR / EN) | Halka rengi | İstem (konu) |
| --- | --- | --- | --- |
| `efes-kesif` | Efes Kâşifi / Ephesus Explorer | sıcak altın | The two-storey marble façade of the Library of Celsus with columns and statues in niches, a marble street in front, warm afternoon light. |
| `pergamon-kesif` | Pergamon Kâşifi / Pergamon Explorer | koyu kırmızı | A white marble temple with Corinthian columns on a hilltop, a very steep ancient theatre carved into the hillside below. |
| `kemeralti-carsisi-kesif` | Kemeraltı Çarşısı Kâşifi / Kemeraltı Bazaar Explorer | turuncu | A busy covered bazaar street with arches, hanging lanterns and a small mosque dome and minaret behind. |
| `kulturpark-kesif` | Kültürpark Kâşifi / Kültürpark Explorer | yeşil | A tall slender parachute training tower rising above green park trees and a fountain. |
| `gediz-deltasi-kesif` | Gediz Deltası Kâşifi / Gediz Delta Explorer | pembe-mercan | Pink flamingos standing in shallow turquoise water of a salt marsh, reeds in the foreground. |
| `birgi-kesif` | Birgi Kâşifi / Birgi Explorer | toprak kahve | A three-storey white Ottoman mansion with wooden bay windows and red roof tiles, mountains behind. |
| `bursa-muradiye-camii-kesif` | Muradiye Külliyesi Kâşifi / Muradiye Complex Explorer | lacivert | A garden of small domed Ottoman tombs among tall cypress trees, a mosque minaret behind. |
| `bursa-kapalicarsi-kesif` | Bursa Kapalıçarşı Kâşifi / Bursa Bazaar Explorer | bordo | The courtyard of a two-storey stone Ottoman inn with arcades, a tiny octagonal mosque on a fountain in the middle, silk cocoons in a basket. |
| `golyazi-adasi-kesif` | Gölyazı Kâşifi / Gölyazı Explorer | turkuaz | A small fishing village on a peninsula in a calm lake at sunset, a stork nest on a chimney, wooden boats. |
| `tirilye-kesif` | Tirilye Kâşifi / Tirilye Explorer | zeytin yeşili | Stone houses and an old Byzantine church on a hillside above a small harbour, olive trees. |
| `merinos-parki-kesif` | Merinos Parkı Kâşifi / Merinos Park Explorer | gri-mavi | An old red-brick textile factory with a tall chimney, surrounded by park lawns, a spool of thread. |
| `goreme-deki-kiliseler-listesi-kesif` | Göreme Açık Hava Müzesi Kâşifi / Göreme Open-Air Museum Explorer | kiremit | Rock-cut cave church entrances in soft tuff cliffs, a Byzantine fresco of a saint glimpsed inside a doorway. |
| `ihlara-vadisi-kesif` | Ihlara Vadisi Kâşifi / Ihlara Valley Explorer | yosun yeşili | A deep green canyon with a stream and poplar trees, small cave-church doorways in the cliff walls. |
| `soganli-vadisi-kesif` | Soğanlı Vadisi Kâşifi / Soğanlı Valley Explorer | mor-kahve | A quiet valley with a fairy chimney whose top is carved into a small dome, cave-church doorways in the cliffs, a donkey on the path. |
| `mustafapasa-kesif` | Mustafapaşa Kâşifi / Mustafapaşa Explorer | taş kahve | A quiet old Cappadocian village street with cut-stone Greek mansions, carved stone doorways and arched windows, a rock-cut church in the cliff behind. |
| `cavusin-kesif` | Çavuşin Kâşifi / Çavuşin Explorer | bal sarısı | A tall cliff honeycombed with old cave houses, a church carved high in the rock, a hot-air balloon in the sky. |

Not: `mustafapasa`, `teos`, `emir-sultan-camii` ve `cumalikizik` ana yerlerinin içinde yalnızca 1 yer olduğu için rozetleri yok.
