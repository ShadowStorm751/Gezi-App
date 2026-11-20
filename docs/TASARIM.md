# Gezi tasarım sistemi ve ana akış ekranları

Kaynak: Claude'un hazırladığı iki tasarım sayfası (proje sahibinde):
- **Tasarım sistemi "Gezi"**: renkler, yazı, boşluk, köşe, gölge, 6 bileşen.
- **"Gezi App – Ana akış ekranları"**: Keşfet, Harita, Yer detayı, Buradayım, Rozet kutlaması (390×844 iPhone).

Bu dosya mobil uygulamanın birebir uygulayabilmesi için o tasarımın metin halidir. Ekran görüntülerini proje sahibi ayrıca paylaşır.

## Hava: sıcak keşif

Gezi dergisi gibi: büyük fotoğraf, kâğıt tonlu zemin, yumuşak kartlar, ekranda tek net ana eylem. Kategoriyi renk destekler ama her zaman yazıyla da söylenir.

## Token'lar (`mobile/theme.js` olarak eklenecek)

Aşağıdaki dosya olduğu gibi `mobile/theme.js` yapılabilir. Uygulama şimdilik yalnızca `light` kullanır.

```js
// mobile/theme.js — Gezi tasarım sistemi (docs/TASARIM.md). Ekranlarda çıplak renk kodu kullanma.
export const colors = {
  light: {
    surface: '#FAF6EE',
    surfaceRaised: '#FFFFFF',
    surfaceSunken: '#F1EBDD',
    line: '#E2DACA',
    ink: '#16302B',
    inkMuted: '#56665F',
    primary: '#1F5A4F',
    onPrimary: '#FFFFFF',
    primarySoft: '#DCEBE4',
    primaryInk: '#1F5A4F',
    accent: '#B9502A',
    onAccent: '#FFFFFF',
    accentSoft: '#F6E0D3',
    accentInk: '#8E3A1B',
    gold: '#C9973A',
    goldSoft: '#F5E8CC',
    goldInk: '#7A5414',
    sea: '#2D6A88',
    seaSoft: '#DCEAF1',
    danger: '#B3261E',
    scrim: '#0B1A1766',
  },
  dark: {
    surface: '#111E1B',
    surfaceRaised: '#192A26',
    surfaceSunken: '#21342F',
    line: '#2D433D',
    ink: '#F2EDE2',
    inkMuted: '#A7B5AF',
    primary: '#7FC4B2',
    onPrimary: '#0D1D19',
    primarySoft: '#1C3A33',
    primaryInk: '#9AD6C6',
    accent: '#EE8B5E',
    onAccent: '#1C0D06',
    accentSoft: '#3B2418',
    accentInk: '#F4A983',
    gold: '#E1B865',
    goldSoft: '#3A2E16',
    goldInk: '#EBC77E',
    sea: '#8CC3DD',
    seaSoft: '#17303B',
    danger: '#F2B8B5',
    scrim: '#00000099',
  },
};
export const fonts = {
  display: 'Fraunces_600SemiBold',
  regular: 'DMSans_400Regular',
  medium: 'DMSans_500Medium',
  semibold: 'DMSans_600SemiBold',
  bold: 'DMSans_700Bold',
};
export const type = {
  display:   {fontFamily: fonts.display,  fontSize: 34, lineHeight: 38, letterSpacing: -0.5},
  title:     {fontFamily: fonts.display,  fontSize: 26, lineHeight: 30},
  heading:   {fontFamily: fonts.display,  fontSize: 20, lineHeight: 26},
  cardTitle: {fontFamily: fonts.display,  fontSize: 18, lineHeight: 23},
  bodyLg:    {fontFamily: fonts.regular,  fontSize: 17, lineHeight: 26},
  body:      {fontFamily: fonts.regular,  fontSize: 15, lineHeight: 22},
  label:     {fontFamily: fonts.semibold, fontSize: 14, lineHeight: 18},
  caption:   {fontFamily: fonts.medium,   fontSize: 12, lineHeight: 16},
  eyebrow:   {fontFamily: fonts.bold,     fontSize: 11, lineHeight: 14, letterSpacing: 1.2}, // metni toLocaleUpperCase(lang) ile çevir
};
export const space = {1: 4, 2: 8, 3: 12, 4: 16, 5: 20, 6: 24, 8: 32, 12: 48};
export const radius = {sm: 8, md: 14, lg: 20, xl: 28, pill: 999};
export const shadow = {
  card: {shadowColor: '#16302B', shadowOpacity: 0.08, shadowRadius: 12, shadowOffset: {width: 0, height: 6}, elevation: 3},
  sheet: {shadowColor: '#16302B', shadowOpacity: 0.12, shadowRadius: 16, shadowOffset: {width: 0, height: -4}, elevation: 6},
  pin: {shadowColor: '#16302B', shadowOpacity: 0.2, shadowRadius: 3, shadowOffset: {width: 0, height: 2}, elevation: 2},
};
```

Fontlar: `npx expo install @expo-google-fonts/fraunces @expo-google-fonts/dm-sans expo-font`; `App.js` başında `useFonts({Fraunces_600SemiBold, DMSans_400Regular, DMSans_500Medium, DMSans_600SemiBold, DMSans_700Bold})`, yüklenene kadar mevcut görünüm.

Renk kuralları:
- Metin her zaman `ink`, `inkMuted` ya da bir `*Ink` rengi. `accent` metin olarak yalnızca 16px+ kalın.
- Yumuşak zemin + metin çiftleri: `primarySoft`/`primaryInk`, `accentSoft`/`accentInk`, `goldSoft`/`goldInk`, `seaSoft`/`sea` (hepsi 4.5:1 üstü).
- Ekranda en fazla bir dolu `primary` buton.
- Gezilmemiş yer `accent`, gezilmiş yer `primary` + ✓, rozet/başarı `gold`, doğa `sea`.

## Gezinme (en büyük değişiklik)

Alt sekme çubuğu (`@react-navigation/bottom-tabs`), beş sekme: **Keşfet · Harita · Rotalar · Rozetler · Profil** (EN: Explore · Map · Routes · Badges · Profile). İkonlar 24px çizgi ikon (`lucide-react-native`: compass, map, route, award, user). Seçili sekme: ikonun arkasında 52×30 `primarySoft` hap, ikon ve etiket `primary`; diğerleri `inkMuted`. Zemin `surfaceRaised`, üstte 1px `line`.

Kalkanlar: Keşfet'in üstündeki buton yığını (Rotalar, Profil, + Yer öner, Kamerayla keşfet, Galata'yı evden dene) ve "Rozetler" yazılı buton.
- Kamerayla keşfet → Keşfet başlığının sağında 52px yuvarlak `accent` kamera butonu.
- Yer öner → Harita'da uzun basma (zaten var) + Profil'de bağlantı.
- Galata'yı evden dene → yalnızca konum izni yokken Keşfet'te ikincil bir kart.
- Haritayla liste aynı ekranda değil: harita kendi sekmesinde, tam ekran.

## Ekranlar

### 1. Keşfet
- Üst boşluk güvenli alan; `eyebrow` "İSTANBUL · EMİNÖNÜ" (şehir · semt), altında `display` "Keşfet"; sağda kamera butonu.
- Arama kutusu: 48 yüksek, `surfaceSunken`, `radius.md`, büyüteç ikonu, "Yer, semt ya da rota ara".
- Kategori çipleri (yatay kaydırma): Tümü (seçili: `ink` zemin, `surface` metin), Camiler, Saraylar, Müzeler, Doğa…
- "Sana önerilenler" (`heading`) + sağda "Tümü" metin butonu; altında yatay kaydırılan **PlaceCard**'lar (`recommendations`).
- "Yakındakiler" + sağda "Kuş uçuşu" (`caption`); altında **PlaceRow** listesi, en yakından uzağa.
- "Konumumu kullan" konum izni yoksa listenin üstünde tek primary buton olarak; izin varsa gizli.

### 2. Harita
- Tam ekran harita; üstte yüzen arama hapı (beyaz, `radius.pill`, `shadow.card`) ve çipler (Tümü, Gezilmedi, Tarihi, Doğa).
- Özel işaretler (`Marker` içinde View): gezilmemiş 22px `accent` daire + 3px beyaz kenar; gezilmiş 30px `primary` daire + beyaz ✓; seçili 42px `accent` + beyaz konum ikonu. `shadow.pin`. Üst üste binen işaretler için kümeleme ya da seçili olanı öne alma.
- Bir işarete dokununca alttaki yüzen kart açılır: 76px fotoğraf, `eyebrow` (dönem · kategori · mesafe), `cardTitle` ad, tek satır kısa açıklama, sağda ›. Karta dokununca Yer detayı.
- Sağ altta 48px beyaz yuvarlak "Konumuma git" butonu; sol altta "© OpenStreetMap katkıcıları" (`caption`, yarı saydam zemin, tek satır).

### 3. Yer detayı
- Tam sayfa (alt sayfa değil). Üstte 320px fotoğraf galerisi (kaydırılabilir, sağ altta "1 / 4"); üstünde 44px beyaz yuvarlak Geri, Kaydet, Paylaş butonları.
- İçerik paneli fotoğrafın üstüne 28px biner, üst köşeleri `radius.xl`.
- İlk satır fotoğraf atfı: "Fotoğraf: <yazar> · <lisans> · Wikimedia Commons" (`caption`, tek satır, sonu …). Taşma sorunu böyle çözülür.
- `eyebrow` (dönem · kategori), `title` yer adı (28px).
- Bilgi satırı: yürüme ikonu + "150 m · 2 dk", altın yıldız + "4,6 (128)" (`rating`), saat ikonu + önerilen zaman.
- Etiketler: yüzyıl (`accentSoft`), ilgili rozet ilerlemesi (`goldSoft`, ör. "Osmanlı Mirası 9/10").
- "Hakkında" (`heading`) ve `long_desc` iki paragraf (`bodyLg`, paragraflar arası 14px). Altında değerlendirmeler, fotoğraf ekle, sorun bildir.
- Altta sabit çubuk: solda 52px kamera ("Kamerada takip et"), sağda tam genişlik primary "Buradayım".

### 4. Buradayım (check-in başarılı)
- Yer detayı `scrim` ile kararır; alttan beyaz sayfa: tutamak, 84px `primarySoft` daire içinde 60px `primary` ✓, `title` "Buradasın", açıklama ("Mısır Çarşısı ziyaretin kaydedildi."), ilgili rozet ilerleme kartı (`goldSoft` zemin, rozet görseli altın halkada, `gold` çubuk), primary buton ("Rozeti gör" rozet kazanıldıysa, yoksa "Devam et"), metin buton "Bu ziyarete fotoğraf ekle".
- Hata durumları (uzak, hız, bekleme) aynı sayfada, ✓ yerine `accentSoft` daire ve açıklayıcı metin; mevcut TR/EN hata metinleri kullanılır.

### 5. Rozet kutlaması
- Tam ekran, zemin `#16302B` (koyu orman yeşili). Rozetin arkasında soluk altın ışınlar ve iki ince altın halka; birkaç küçük renkli nokta (konfeti değil, sakin).
- 220px rozet: `goldSoft` daire, 6px altın (`#E1B865`) halka.
- "YENİ ROZET" (altın, harf aralıklı), rozet adı Fraunces 38px krem, açıklama `#C9D3CE`, iki küçük hap (kaçıncı rozet, tarih).
- Altta: altın dolu "Devam et" (metin `#16302B`), altında iki çerçeveli buton "Rozetlerim" ve "Paylaş". Sağ üstte kapat.
- Giriş animasyonu: rozet 0.8 → 1 ölçek + opaklık, 250 ms; ışınlar yavaşça döner (isteğe bağlı, "hareketi azalt" açıksa kapalı).

## Bileşen ölçüleri (özet)

| Bileşen | Ölçü |
| --- | --- |
| Button | yükseklik 48–52, `radius.md`, etiket `label` 15px; primary / secondary (beyaz + `line`) / metin |
| Chip | yükseklik 36, `radius.pill`, yatay boşluk 16 |
| PlaceCard | genişlik 250–260, fotoğraf 160–168, `radius.lg`, `shadow.card`, sağ üstte mesafe hapı |
| PlaceRow | 64px küçük resim `radius.sm`, satır en az 72, aralarda 1px `line` |
| TabBar | 5 sekme, ikon 24, etiket 11px semibold |
| BadgeTile | 84px daire, 3px `gold` halka; kilitli: gri, `surfaceSunken`, altında ilerleme çubuğu |

Fotoğrafı olmayan yerde `surfaceSunken` zemin ve kategori ikonu (`accent`), asla boş gri kutu.
