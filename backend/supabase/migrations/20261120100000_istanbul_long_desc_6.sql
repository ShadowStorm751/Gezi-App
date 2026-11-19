-- İstanbul uzun açıklamaları, 6. parti (10 yer, TR + EN).
-- Üreten: data-pipeline/content/build_long_desc.py (kaynak: content/istanbul_long_descriptions.py).
-- Metinler kendi cümlelerimizdir; Vikipedi/Wikidata yalnızca bilgi kontrolü için kullanıldı.

update public.place_translations t
   set long_desc = v.long_desc
  from (values
  ('aya-yorgi-patrikhane-kilisesi', 'tr', 'Fener''deki Aya Yorgi Kilisesi, 1601''den bu yana Rum Ortodoks Patrikhanesi''nin merkezidir ve dünyadaki Ortodoks Hristiyanlar için özel bir anlam taşır. Bugünkü yapı, 18. yüzyıl başındaki bir yangından sonra yeniden inşa edilmiş, dışarıdan bakıldığında oldukça sade, bazilika planlı bir kilisedir.

Sade cephesinin aksine iç mekân, altın varaklı ahşap ikonostasisi, eski ikonaları ve patrik tahtıyla son derece zengindir; burada bazı azizlerin kutsal emanetleri de saklanır. Kilise ibadete açık bir mekân olduğundan sessiz olunmalı ve uygun giyinilmelidir. Fener ve Balat''ın renkli sokaklarıyla birlikte gezilebilir.'),
  ('aya-yorgi-patrikhane-kilisesi', 'en', 'The Church of St George in Fener has been the seat of the Ecumenical Patriarchate since 1601 and holds special meaning for Orthodox Christians worldwide. The present building, rebuilt after a fire in the early 18th century, is a basilica that looks quite plain from outside.

In contrast to its modest façade, the interior is richly furnished with a gilded wooden iconostasis, old icons and the patriarchal throne, and it keeps the relics of several saints. As a working place of worship it calls for quiet and modest dress. It combines well with the colourful streets of Fener and Balat.'),
  ('dolmabahce-camii', 'tr', 'Dolmabahçe Sarayı''nın hemen yanında, Boğaz kıyısındaki Dolmabahçe Camii, Sultan Abdülmecid''in annesi Bezmialem Valide Sultan tarafından başlatıldı; onun ölümünden sonra Abdülmecid tarafından tamamlanarak 1855''te ibadete açıldı. Tasarımı Garabet Balyan''a aittir.

Barok ve ampir etkileri taşıyan tek kubbeli yapı, ince uzun minareleri ve büyük pencereleriyle 19. yüzyıl Osmanlı mimarisinin Avrupa''ya açılan yüzünü gösterir. Saray ve saat kulesiyle birlikte sahil boyunca yürürken kolayca görülebilir; deniz kıyısından cami ile Boğaz''ı aynı karede yakalamak mümkündür.'),
  ('dolmabahce-camii', 'en', 'Right beside Dolmabahçe Palace on the shore of the Bosphorus, the Dolmabahçe Mosque was begun by Bezmialem Valide Sultan, mother of Sultan Abdülmecid, and completed after her death by Abdülmecid himself, opening for worship in 1855. It was designed by Garabet Balyan.

With baroque and Empire influences, its single dome, slender minarets and large windows show the European-facing side of 19th-century Ottoman architecture. It is easy to take in while walking along the shore with the palace and clock tower, and from the waterfront you can frame the mosque and the Bosphorus in a single shot.'),
  ('eyup-sultan-camii', 'tr', 'Haliç''in kıyısında, surların dışındaki Eyüp Sultan Camii, Hz. Muhammed''in sahabesi ve sancaktarı Ebu Eyyub el-Ensari''nin türbesinin yanında yer alır. Fatih Sultan Mehmed 1458''de burada ilk külliyeyi yaptırdı; bugünkü cami 19. yüzyılın başında III. Selim döneminde yeniden inşa edildi. Osmanlı padişahları tahta çıktıklarında kılıç kuşanma törenleri burada yapılırdı.

İstanbul''un en kutsal sayılan ziyaret yerlerinden biridir; özellikle cuma günleri, bayramlarda ve kandillerde çok kalabalık olur. Çinilerle kaplı türbe ziyareti sırasında sessiz ve saygılı olunmalıdır. Çevredeki çarşı ve tarihi mezarlıktan Pierre Loti Tepesi''ne çıkılabilir.'),
  ('eyup-sultan-camii', 'en', 'On the shore of the Golden Horn, outside the city walls, the Eyüp Sultan Mosque stands beside the tomb of Abu Ayyub al-Ansari, companion and standard-bearer of the Prophet Muhammad. Mehmed II built the first complex here in 1458; the present mosque was rebuilt in the early 19th century under Selim III. Ottoman sultans were girded with the sword here on their accession.

It is one of the most sacred places of pilgrimage in Istanbul and gets very busy on Fridays and religious holidays. Visitors to the tiled tomb should be quiet and respectful. From the surrounding market and historic cemetery you can walk up to Pierre Loti Hill.'),
  ('istanbul-modern', 'tr', '2004''te Karaköy''deki eski bir antrepoda açılan İstanbul Modern, Türkiye''nin ilk modern ve çağdaş sanat müzesidir. 2023''ten bu yana Galataport''ta, Renzo Piano''nun tasarladığı, Boğaz''a bakan yeni binasında hizmet verir.

Koleksiyonunda Türkiye''den modern ve çağdaş resim, heykel, fotoğraf ve video eserleri bulunur; dönemsel sergiler ve fotoğraf galerisi sık sık yenilenir. Teras ve restorandan tarihi yarımadanın ve Boğaz''ın manzarası görülür. Galataport sahili ve Karaköy''ün sokaklarıyla birleştirilebilir.'),
  ('istanbul-modern', 'en', 'Opened in 2004 in a former warehouse in Karaköy, Istanbul Modern is Turkey''s first museum of modern and contemporary art. Since 2023 it has been housed in a new waterfront building designed by Renzo Piano at Galataport.

Its collection covers modern and contemporary painting, sculpture, photography and video from Turkey, while its temporary exhibitions and photography gallery change often. The terrace and restaurant look out over the historic peninsula and the Bosphorus. It combines well with the Galataport promenade and the streets of Karaköy.'),
  ('pera-muzesi', 'tr', 'Tepebaşı''ndaki Pera Müzesi, Suna ve İnan Kıraç Vakfı tarafından 2005''te açıldı. 1893''te mimar Achilleas Manussos tarafından yapılan tarihi Bristol Oteli binasında yer alır ve İstiklal Caddesi''nin hemen yakınındadır.

En bilinen eseri Osman Hamdi Bey''in Kaplumbağa Terbiyecisi tablosudur; Oryantalist resim koleksiyonu, Anadolu ağırlık ve ölçü aletleri ile Kütahya çini ve seramikleri de sürekli sergilenir. Üst katlardaki dönemsel sergiler dünyaca tanınmış sanatçıları ağırlar. Galata Kulesi ve Şişhane''ye yürüme mesafesindedir.'),
  ('pera-muzesi', 'en', 'Pera Museum in Tepebaşı was opened in 2005 by the Suna and İnan Kıraç Foundation. It occupies the historic Bristol Hotel, built in 1893 by the architect Achilleas Manussos, just off İstiklal Avenue.

Its best-known work is Osman Hamdi Bey''s The Tortoise Trainer; its collections of Orientalist painting, Anatolian weights and measures, and Kütahya tiles and ceramics are on permanent display. The temporary exhibitions on the upper floors host internationally renowned artists. Galata Tower and Şişhane are within walking distance.'),
  ('camlica-camii', 'tr', 'Üsküdar''daki Çamlıca Tepesi''nde yükselen Büyük Çamlıca Camii, 2019''da açıldı ve Cumhuriyet tarihinin en büyük camisidir. Altı minaresi ve klasik Osmanlı mimarisinden esinlenen kubbesiyle şehrin birçok noktasından görülür.

Külliyede bir İslam medeniyetleri müzesi, sanat galerisi, kütüphane ve konferans salonu da bulunur. Avlusundan ve yakındaki Çamlıca Tepesi''nden Boğaz''ın, köprülerin ve tarihi yarımadanın geniş bir manzarası açılır; gün batımında özellikle güzeldir. İbadet saatlerinde ziyaretçilerin saygılı olması beklenir.'),
  ('camlica-camii', 'en', 'Rising on Çamlıca Hill in Üsküdar, the Grand Çamlıca Mosque opened in 2019 and is the largest mosque built in the history of the Republic. With six minarets and a dome inspired by classical Ottoman architecture, it can be seen from many parts of the city.

The complex also houses a museum of Islamic civilisations, an art gallery, a library and a conference hall. Its courtyard and nearby Çamlıca Hill offer sweeping views of the Bosphorus, its bridges and the historic peninsula, especially beautiful at sunset. Visitors are expected to be respectful during prayer times.'),
  ('cemberlitas-sutunu', 'tr', 'Divanyolu üzerindeki Çemberlitaş Sütunu, İmparator I. Konstantin''in 330''da şehri yeni başkent ilan ettiğinde kendi adını taşıyan forumun ortasına diktirdiği anıttır. Mısır''dan getirilen mor porfir taş bloklardan oluşur; üzerinde bir zamanlar imparatorun heykeli dururdu.

Blokları birbirine tutturan demir çemberler sütuna Türkçe adını verir; 18. yüzyıldaki büyük bir yangında karardığı için Yanık Sütun diye de anılır. Kapalıçarşı''nın girişine çok yakındır ve tramvayla Sultanahmet''ten gelirken kolayca görülür. Hemen yanındaki tarihi Çemberlitaş Hamamı da bilinen bir duraktır.'),
  ('cemberlitas-sutunu', 'en', 'On Divanyolu, the Column of Constantine was raised by Emperor Constantine I in 330, when he proclaimed the city his new capital, at the centre of the forum bearing his name. It is made of purple porphyry drums brought from Egypt and was once topped by a statue of the emperor.

The iron hoops binding the drums give it its Turkish name, the ''hooped stone''; blackened in a great 18th-century fire, it is also known as the Burnt Column. It is very close to an entrance of the Grand Bazaar and easy to spot when coming by tram from Sultanahmet. The historic Çemberlitaş Bath right beside it is a well-known stop too.'),
  ('miniaturk', 'tr', 'Haliç kıyısında, Sütlüce''de 2003''te açılan Miniatürk, Türkiye''nin ve Osmanlı coğrafyasının önemli yapılarının küçültülmüş maketlerinin sergilendiği büyük bir açık hava minyatür parkıdır.

Ayasofya, Sümela Manastırı, Efes''teki Celsus Kütüphanesi ve Galata Kulesi gibi yüzden fazla yapının maketleri arasında birkaç saatte geniş bir gezi yapılabilir; maketlerin yanındaki bilgi panoları yapıları kısaca anlatır. Çocuklu aileler için özellikle keyiflidir. Açılış saatleri mevsime göre değişebileceğinden gitmeden önce kontrol edin.'),
  ('miniaturk', 'en', 'Opened in 2003 at Sütlüce on the Golden Horn, Miniatürk is a large open-air miniature park displaying scale models of landmark buildings from Turkey and the former Ottoman lands.

Among more than a hundred models, such as Hagia Sophia, Sumela Monastery, the Library of Celsus at Ephesus and Galata Tower, you can make a wide-ranging tour in a few hours, with information panels describing each building. It is especially enjoyable for families with children. Opening hours can vary by season, so check before you go.'),
  ('arap-camii', 'tr', 'Karaköy''ün arka sokaklarındaki Arap Camii, 14. yüzyılda Galata''daki Cenevizliler döneminde Dominiken rahipleri tarafından San Domenico (Aziz Paulus) Kilisesi olarak yapıldı ve İstanbul''da günümüze ulaşan tek Gotik kilisedir. Fetihten sonra camiye çevrildi; adını 15. yüzyılın sonunda İspanya''dan göç eden ve buraya yerleşen Endülüslü Müslümanlardan aldığı anlatılır.

Sivri külahlı, kare planlı yüksek kulesi bir kilise çan kulesinden dönüştürülmüş minaredir ve Galata''nın sıkışık dokusunda hâlâ kolayca seçilir. İç mekânın ahşap tavanı ve uzun dikdörtgen planı yapının kilise geçmişini yansıtır. Galata Kulesi ve Karaköy gezisine kolayca eklenebilir.'),
  ('arap-camii', 'en', 'In the backstreets of Karaköy, the Arap Mosque was built in the 14th century by Dominican friars as the Church of San Domenico (St Paul), when Galata was a Genoese colony, and it is the only Gothic church in Istanbul to survive. It became a mosque after the conquest and is said to take its name from Andalusian Muslims who fled Spain and settled here at the end of the 15th century.

Its tall, square tower with a pointed roof is a church bell tower turned minaret, still easy to pick out in Galata''s dense streets. The wooden ceiling and long rectangular plan of the interior reflect its past as a church. It is an easy addition to a walk around Galata Tower and Karaköy.'),
  ('buyuk-saray-mozaikleri-muzesi', 'tr', 'Sultanahmet Camii''nin arkasındaki Arasta Çarşısı''nda bulunan Büyük Saray Mozaikleri Müzesi, Bizans imparatorlarının Büyük Saray''ına ait sütunlu bir avlunun mozaik zeminleri üzerine kurulmuştur. Kazılarda ortaya çıkan mozaikler yerinde korunarak müzeye dönüştürülmüştür.

Geç Roma dönemine tarihlenen mozaiklerde av sahneleri, çobanlar, oyun oynayan çocuklar, gerçek ve hayali hayvanlar canlı renklerle anlatılır; bazı sahnelerin ayrıntısı olağanüstüdür. Küçük ve sakin bir müze olduğu için Sultanahmet kalabalığından kısa bir mola olarak idealdir. Ziyaret düzenini gitmeden önce kontrol edin.'),
  ('buyuk-saray-mozaikleri-muzesi', 'en', 'In the Arasta Bazaar behind the Blue Mosque, the Great Palace Mosaic Museum is built over the mosaic floors of a colonnaded courtyard of the Byzantine emperors'' Great Palace. The mosaics uncovered in excavations were preserved in place and turned into a museum.

Dating from the late Roman period, the mosaics depict hunting scenes, shepherds, children at play, and real and fantastic animals in vivid colour, some in remarkable detail. As a small, quiet museum it makes an ideal short break from the Sultanahmet crowds. Check visiting arrangements before you go.')
  ) v(slug, lang, long_desc)
  join public.places p on p.slug = v.slug
 where t.place_id = p.id and t.lang = v.lang;
