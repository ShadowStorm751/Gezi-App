-- İstanbul uzun açıklamaları, 8. parti (10 yer, TR + EN).
-- Üreten: data-pipeline/content/build_long_desc.py (kaynak: content/istanbul_long_descriptions.py).
-- Metinler kendi cümlelerimizdir; Vikipedi/Wikidata yalnızca bilgi kontrolü için kullanıldı.

update public.place_translations t
   set long_desc = v.long_desc
  from (values
  ('yavuz-selim-camii', 'tr', 'Haliç''e bakan beşinci tepede yükselen Yavuz Selim Camii, Kanuni Sultan Süleyman''ın babası I. Selim adına yaptırdığı ve 1520''lerin başında tamamlanan bir selatin camisidir. Mimarı kesin olarak bilinmez. Tek büyük kubbeli sade planı, erken klasik Osmanlı mimarisinin en yalın örneklerinden biridir.

Geniş avlusu ve bahçesinden Haliç''in güzel bir manzarası açılır. Bahçede Yavuz Sultan Selim''in türbesi, şehzadeler türbesi ve Sultan Abdülmecid''in türbesi bulunur. Turist kalabalığından uzak olduğu için sakin bir ziyaret sunar. Fener ve Balat gezisiyle birleştirilebilir.'),
  ('yavuz-selim-camii', 'en', 'Rising on the fifth hill above the Golden Horn, the Yavuz Selim Mosque is an imperial mosque built by Suleiman the Magnificent in the name of his father, Selim I, and completed in the early 1520s. Its architect is not known for certain. Its plain plan under a single great dome makes it one of the purest examples of early classical Ottoman architecture.

Its wide courtyard and garden offer a fine view over the Golden Horn. The garden holds the tomb of Selim I, a tomb of princes and the tomb of Sultan Abdülmecid. Away from the tourist crowds, it makes for a quiet visit. It combines well with Fener and Balat.'),
  ('yavuz-sultan-selim-turbesi', 'tr', 'Yavuz Selim Camii''nin bahçesindeki bu türbe, 1520''de ölen I. Selim için oğlu Kanuni Sultan Süleyman tarafından yaptırıldı. Kısa saltanatında Mısır seferiyle Osmanlı topraklarını büyük ölçüde genişleten Yavuz, Osmanlı tarihinin en güçlü padişahlarından biri sayılır.

Sekizgen planlı türbenin girişinin iki yanındaki renkli sırlı çini panolar, İstanbul''daki erken dönem çini işçiliğinin değerli örnekleridir. Bahçedeki diğer türbeler ve Haliç manzarasıyla birlikte cami ziyaretinin doğal bir parçasıdır; sessiz ve saygılı olunmalıdır.'),
  ('yavuz-sultan-selim-turbesi', 'en', 'In the garden of the Yavuz Selim Mosque, this tomb was built by Suleiman the Magnificent for his father, Selim I, who died in 1520. During his short reign Selim greatly expanded Ottoman lands with his campaign into Egypt and is counted among the most powerful Ottoman sultans.

The coloured glazed tile panels on either side of the entrance to the octagonal tomb are valuable examples of early tilework in Istanbul. Together with the other tombs in the garden and the view of the Golden Horn, it is a natural part of a visit to the mosque; visitors should be quiet and respectful.'),
  ('sultan-resad-turbesi', 'tr', 'Eyüp''teki Sultan Reşad Türbesi, 35. Osmanlı padişahı V. Mehmed Reşad için Mimar Kemaleddin Bey tarafından 1911-1912''de yapıldı. Padişah 1918''de öldüğünde buraya gömüldü; İstanbul''da gömülü son Osmanlı padişahıdır.

Kesme taş ve mermerden sekizgen yapı, Osmanlı ve Selçuklu öğelerini yeniden yorumlayan Birinci Ulusal Mimarlık akımının ilk örneklerindendir. İçindeki çiniler ve kalem işleri dikkat çeker. Türbenin yanında aynı mimarın tasarladığı sebil ve mektep de bulunur. Eyüp Sultan Camii''ne birkaç dakika yürüme mesafesindedir.'),
  ('sultan-resad-turbesi', 'en', 'In Eyüp, the Tomb of Sultan Reşad was built in 1911-1912 by the architect Kemaleddin Bey for Mehmed V Reşad, the 35th Ottoman sultan. He was buried here when he died in 1918, making him the last Ottoman sultan buried in Istanbul.

The octagonal building of cut stone and marble is one of the first works of the First National Architecture movement, which reinterpreted Ottoman and Seljuk forms. Its tiles and painted decoration are striking. Beside the tomb stand a fountain and a school designed by the same architect. It is a few minutes'' walk from the Eyüp Sultan Mosque.'),
  ('yeni-valide-camii', 'tr', 'Üsküdar''ın merkezindeki Yeni Valide Camii, II. Mustafa ve III. Ahmed''in annesi Gülnuş Emetullah Sultan için 1708-1710 yılları arasında Mimar Kayserili Mehmed Ağa tarafından yapıldı. Klasik Osmanlı mimarisinden Lale Devri zevkine geçişin izlerini taşıyan bir külliyenin merkezidir.

Bahçesindeki Gülnuş Sultan türbesinin üstü kubbe yerine demir bir kafesle örtülüdür; anlatıldığına göre valide sultan, mezarına yağmur ve güneş değmesini istemişti. Caminin sebili ve çeşmesi de zarif örneklerdir. Üsküdar Meydanı ve iskelesine birkaç dakika uzaklıktadır.'),
  ('yeni-valide-camii', 'en', 'In the centre of Üsküdar, the Yeni Valide Mosque was built between 1708 and 1710 by the architect Kayserili Mehmed Agha for Gülnuş Emetullah Sultan, mother of Mustafa II and Ahmed III. It is the heart of a complex showing the transition from classical Ottoman architecture to the taste of the Tulip Era.

Gülnuş Sultan''s tomb in the garden is covered not by a dome but by an iron cage; she is said to have wished for rain and sun to reach her grave. The mosque''s fountain and water kiosk are fine examples too. Üsküdar Square and pier are a few minutes away.'),
  ('binbirdirek-sarnici', 'tr', 'Sultanahmet''teki Binbirdirek Sarnıcı, 4. yüzyılda yapıldığı bilinen ve Filoksenos Sarnıcı diye de anılan bir Bizans su deposudur. 224 sütunu ve 3.500 metrekareyi aşan alanıyla Yerebatan''dan sonra şehrin en büyük kapalı sarnıcıdır.

İki sütunun üst üste bindirilmesiyle yükselen sütunları yapıya büyük bir yükseklik verir. Sarnıç zamanla kurudu ve Osmanlı döneminde ipek ipliği atölyesi olarak kullanıldı. Bugün sergi ve etkinliklere ev sahipliği yaptığından ziyaret düzeni değişebilir, gitmeden önce kontrol edin. Yerebatan''a göre çok daha sakindir.'),
  ('binbirdirek-sarnici', 'en', 'In Sultanahmet, the Cistern of a Thousand and One Columns, also known as the Cistern of Philoxenos, is a Byzantine reservoir dating to the 4th century. With 224 columns and an area of over 3,500 square metres, it is the city''s largest covered cistern after the Basilica Cistern.

Its columns, each made of two shafts stacked one on top of the other, give the space great height. The cistern dried up over time and in the Ottoman period served as a silk-thread workshop. Today it hosts exhibitions and events, so visiting arrangements can change; check before you go. It is far quieter than the Basilica Cistern.'),
  ('sakip-sabanci-muzesi', 'tr', 'Emirgan''da Boğaz''a bakan Sakıp Sabancı Müzesi, 2002''de açıldı. Uzun süre Sabancı ailesinin evi olan ve bahçesindeki at heykeli nedeniyle Atlı Köşk diye anılan yapı ile ona eklenen modern galerilerde hizmet verir.

Kalıcı koleksiyonunda Osmanlı hat sanatı, kitap sanatları ve 19.-20. yüzyıl resimleri bulunur. Müze özellikle Picasso, Rodin ve Dalí gibi ustaların eserlerini getiren büyük uluslararası sergileriyle tanınır. Boğaz manzaralı bahçesi ve kafesi ziyareti keyifli kılar. Emirgan Korusu da hemen yanındadır.'),
  ('sakip-sabanci-muzesi', 'en', 'Overlooking the Bosphorus in Emirgan, the Sakıp Sabancı Museum opened in 2002. It occupies the Atlı Köşk, for many years the Sabancı family home and named after the horse statue in its garden, along with modern galleries added beside it.

Its permanent collection covers Ottoman calligraphy, the arts of the book and 19th-20th-century painting. The museum is best known for major international exhibitions that have brought the work of masters such as Picasso, Rodin and Dalí. Its garden and café with Bosphorus views make the visit a pleasure. Emirgan Park is right next door.'),
  ('500-yil-vakfi-turk-musevileri-muzesi', 'tr', 'Karaköy''deki 500. Yıl Vakfı Türk Musevileri Müzesi 2001''de açıldı. Sefarad Yahudilerinin 1492''de İspanya''dan sürülerek Osmanlı topraklarına yerleşmesinin 500. yılını kutlamak için kurulan vakfın girişimiyle oluşturuldu.

Müze, Türkiye''deki Yahudi toplumunun yüzyıllara yayılan tarihini ve gündelik hayatını belgeler, fotoğraflar ve eşyalarla anlatır; etnografya bölümünde düğün kıyafetleri ve gelenekler tanıtılır. Güvenlik nedeniyle girişte kimlik istenebilir; ziyaret koşullarını gitmeden önce kontrol edin.'),
  ('500-yil-vakfi-turk-musevileri-muzesi', 'en', 'In Karaköy, the Quincentennial Foundation Museum of Turkish Jews opened in 2001. It was created by a foundation set up to mark the 500th anniversary of the arrival of Sephardic Jews in Ottoman lands after their expulsion from Spain in 1492.

The museum tells the centuries-long history and daily life of the Jewish community in Turkey through documents, photographs and objects; the ethnography section presents wedding dress and traditions. For security, ID may be required at the entrance; check visiting conditions before you go.'),
  ('adile-sultan-sarayi', 'tr', 'Anadolu yakasında Kandilli sırtlarındaki Adile Sultan Sarayı, Sultan Abdülmecid''in kız kardeşi Adile Sultan''a armağan olarak Sarkis Balyan''a yaptırıldı. 1916''dan sonra uzun yıllar Kandilli Kız Lisesi olarak kullanıldı ve 1986''da çıkan yangında büyük hasar gördü.

Kapsamlı bir restorasyonun ardından 2007''de yeniden açılan yapı bugün kültür merkezi olarak etkinliklere ev sahipliği yapar. Tepedeki konumundan Boğaz''ın ve karşı kıyının geniş bir manzarası görülür. Ziyarete açık olduğu zamanlar etkinliklere göre değiştiğinden gitmeden önce kontrol edin.'),
  ('adile-sultan-sarayi', 'en', 'On the heights of Kandilli on the Asian shore, the Adile Sultan Palace was built by Sarkis Balyan as a gift from Sultan Abdülmecid to his sister Adile Sultan. From 1916 it served for many years as Kandilli Girls'' High School and was badly damaged by fire in 1986.

Reopened in 2007 after extensive restoration, it now hosts events as a cultural centre. From its hilltop position it commands wide views of the Bosphorus and the opposite shore. Its opening times depend on events, so check before you go.'),
  ('cinili-kosk', 'tr', 'Topkapı Sarayı''nın dış bahçesindeki Çinili Köşk, giriş kitabesine göre 1472''de Fatih Sultan Mehmed tarafından yaptırıldı ve İstanbul''da günümüze ulaşan en eski Osmanlı sivil yapılarından biridir. Fatih''in bahçede yaptırdığı farklı üsluptaki köşklerden ayakta kalan tek örnektir ve belirgin İran etkileri taşır.

Adını giriş eyvanını süsleyen firuze ve lacivert çinilerden alır. Bugün İstanbul Arkeoloji Müzeleri''nin bir parçası olarak Selçuklu ve Osmanlı dönemlerine ait çini ve seramik eserleri sergiler. Arkeoloji Müzesi ziyaretiyle aynı biletle görülebilir.'),
  ('cinili-kosk', 'en', 'In the outer garden of Topkapı Palace, the Tiled Kiosk was built by Mehmed II in 1472, according to its entrance inscription, and is one of the oldest surviving Ottoman civil buildings in Istanbul. It is the only one left of the pavilions in different styles that Mehmed built in the garden and shows strong Persian influence.

It takes its name from the turquoise and dark-blue tiles adorning its entrance iwan. Today, as part of the Istanbul Archaeology Museums, it displays Seljuk and Ottoman tiles and ceramics. It can be seen on the same ticket as the Archaeology Museum.'),
  ('emirgan-korusu', 'tr', 'Boğaz''ın Avrupa kıyısında Emirgan sırtlarına yayılan Emirgan Korusu, İstanbul''un en büyük ve en sevilen kent parklarından biridir. 17. yüzyılda IV. Murad''ın Emirgüneoğlu Yusuf Paşa''ya armağan ettiği arazi, 19. yüzyılda Mısır Hidivi İsmail Paşa''nın elindeyken bugünkü düzenine kavuştu.

Korunun içinde kafe ve restoran olarak hizmet veren Sarı, Pembe ve Beyaz köşkler bulunur. Nisan ayında düzenlenen Lale Festivali''nde koru milyonlarca laleyle rengârenk olur ve en kalabalık dönemini yaşar. Göletler ve yürüyüş yolları hafta içi sakin bir gezinti sunar.'),
  ('emirgan-korusu', 'en', 'Spreading across the hills of Emirgan on the European shore of the Bosphorus, Emirgan Park is one of Istanbul''s largest and best-loved city parks. Granted by Murad IV to Emirgüneoğlu Yusuf Pasha in the 17th century, the land took its present layout in the 19th century under Khedive İsmail Pasha of Egypt.

Inside the park are the Yellow, Pink and White pavilions, now cafés and restaurants. During the Tulip Festival in April the park bursts into colour with millions of tulips and sees its busiest days. Its ponds and walking paths offer a quiet stroll on weekdays.')
  ) v(slug, lang, long_desc)
  join public.places p on p.slug = v.slug
 where t.place_id = p.id and t.lang = v.lang;
