# Gezi App · İstanbul pilotu

İlk saha bölgesi Galata. Kullanıcı bir sokakta durup çevresini tarayarak göremediği tarihi yerlerin yönünü ve kuş uçuşu mesafesini öğrenir. Yerinde döndüğünde baloncuk ekranda kayar, mesafe sabit kalır. Baloncuğa dokunarak yerin hikâyesini açar. Ziyaret kaydı ayrı bir yakınlık kontrolü gerektirir.

## İlk mobil teslim

React Native ve Expo ile iki mobil platform için ortak bir ön yüz seçildi. Haritadaki işarete veya listedeki satıra dokunmak aynı yer kartını açar. Kartta kısa tarihçe ve kurumun ziyaret bilgilerine bağlantı bulunur. Başlangıç mesafeleri açıkça belirtilen Galata örnek konumundan hesaplanır. Kullanıcı isterse cihaz konumunu bir defalık alıp uzaklıkları günceller. Yer kataloğu şimdilik Galata ile sınırlıdır.

Node.js 22 ve npm bulunan bir ortamda `mobile` dizininde `npm install`, ardından `npm start` komutuyla Metro'yu başlat. SDK 54 uyumlu Expo Go veya geliştirme derlemesi kullan. Android bağımsız derlemesinde harita sağlayıcısının API anahtarı gerekir. Mesafe ve yön kontrolleri bağımsız olarak `node --test tests/geo.test.cjs` komutuyla çalışır.

## Kamera ve tarayıcı denemesi

Bilgisayarda Gezi-Test.html dosyasını açıp **Kamera demosunu aç** düğmesine bas. Başlangıç noktası kulenin yaklaşık 1 km güneyinde. Bakış yönü sürgüsüyle iki hedefi kadraja al, bir baloncuğa basıp yer kartını aç. **Kuleye yönel** bakış yönünü sıfırlar. Bu deneme kamera veya konum izni istemez.

Mobil uygulamada **Kamerayla keşfet** arka kamerayı açar. Canlı mod cihaz konumunu ve pusulayı kullanır. Pilot kataloğundaki 2 km içindeki yerlerin yatay yönü, başlangıçta varsayılan 60° yatay görüş açısıyla hesaplanır. Hedefin görünürlüğünü binalar engellemez. Etiketler iki ayrı yükseklikte yerleştirilir. Dikey eğim ve gerçek lens görüş açısı saha kalibrasyonuna bırakıldı. Konum ve pusula takibi kamera ekranı kapanınca durur. Fiziksel cihazda izin verme, izin reddi, kuzey geçişi, arka plana alma ve dar sokakta yön sapması kontrol edilmelidir.

## Pilot verisi

`istanbul-pilot.csv` resmî kataloglarla eşleştirilmiş 50 yer adayı içerir. Her satırda kaynak bulunur. `mobile/places.json` içinde yalnızca ilk iki yerin koordinatları ve açıklamaları vardır. Koordinatlar yapı konumudur. Saha gezisinde giriş noktasını ayrıca ölçerek ziyaret doğrulaması için uygun merkezi belirle. Açılış durumunu, saati ve fotoğraf kullanım hakkını yer kaydı yayına alınırken kontrol et.

## Claude ile ilk bağlantı

Önerilen okuma uç noktası `GET /places/nearby?lat=…&lng=…&radius_m=…`. Yanıt için `{ "places": [...] }` kullan. Her öğe için `mobile/places.json` içindeki id, name, category, period, coordinate, description ve source alanlarını koru. `coordinate` nesnesi latitude ve longitude içerir. Kimlik kalıcıdır. Yakında sonuç yoksa boş dizi döner. İstemci, hata durumunu boş sonuçtan ayrı gösterir. İlk entegrasyon denemesi Galata Kulesi'ni 1 km uzaktan içeren bir sorgudur.

Sonraki fazda ziyaret kaydını sunucu doğrular. Aynı kullanıcının aynı yeri tekrar kaydetmesi koleksiyon sayısını artırmamalı. Uzak konumdaki yer detayları okunabilir. Ziyaret alanına giriş, kamera baloncuğunun görünmesinden bağımsızdır.

## Sıradaki cihaz denemesi

1. Örnek konumla aç, iki işareti ve mesafe sırasını kontrol et. Her işaretten ve her liste satırından doğru kartı aç.
2. Konum iznini reddet, örnek konumun açıkça belirtildiğini ve yer kartlarının kullanılabildiğini doğrula.
3. Galata'da konumu al, mesafeleri saha ölçümüyle karşılaştır. Sonraki geliştirme yer fotoğrafları ve backend bağlantısıdır.
4. Kamera fazında kule yaklaşık 1 km uzaktayken dar sokakta dön. Yön kuzeyi geçtiğinde baloncuk sıçramadan kaymalı, dokununca aynı yer kartını açmalı. Gerçek pusula, görüş açısı ve eğim cihazda kalibre edilecek.
