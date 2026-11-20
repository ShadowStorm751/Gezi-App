-- İstanbul uzun açıklamaları, 10. parti (10 yer, TR + EN).
-- Üreten: data-pipeline/content/build_long_desc.py (kaynak: content/istanbul_long_descriptions.py).
-- Metinler kendi cümlelerimizdir; Vikipedi/Wikidata yalnızca bilgi kontrolü için kullanıldı.

update public.place_translations t
   set long_desc = v.long_desc
  from (values
  ('sakirin-camii', 'tr', 'Üsküdar''da, Karacaahmet Mezarlığı''nın girişindeki Şakirin Camii 2009''da ibadete açıldı. Şakir ailesi tarafından yaptırılan caminin mimarı Hüsrev Tayla, iç mekân tasarımcısı ise Zeynep Fadıllıoğlu''dur; Türkiye''de iç tasarımını bir kadının yaptığı ilk cami olarak bilinir.

Alüminyum kaplı kubbesi, cam cepheleri ve damla biçimli dev avizesiyle klasik cami mimarisini çağdaş malzemelerle yeniden yorumlar. Pirinç kafes işçiliği ve sade iç mekânı özellikle mimarlık meraklılarının ilgisini çeker. İbadet saatlerinde ziyaretçilerin saygılı olması beklenir.'),
  ('sakirin-camii', 'en', 'In Üsküdar, at the entrance to Karacaahmet Cemetery, the Şakirin Mosque opened for worship in 2009. Commissioned by the Şakir family, it was designed by the architect Hüsrev Tayla, with interiors by Zeynep Fadıllıoğlu; it is known as the first mosque in Turkey whose interior was designed by a woman.

With its aluminium-clad dome, glass façades and huge drop-shaped chandelier, it reinterprets classical mosque architecture in contemporary materials. Its brass lattice work and clean interior especially attract architecture lovers. Visitors are expected to be respectful during prayer times.'),
  ('taksim-cumhuriyet-aniti', 'tr', 'Taksim Meydanı''nın ortasındaki Cumhuriyet Anıtı, İtalyan heykeltıraş Pietro Canonica tarafından yapıldı ve 8 Ağustos 1928''de açıldı. Kaidesi ve çevre düzeni, St. Antuan Kilisesi''nin de mimarı olan Giulio Mongeri''ye aittir.

Anıtın iki yüzü vardır: bir yanda Kurtuluş Savaşı''na önderlik eden Atatürk ve silah arkadaşları, diğer yanda Cumhuriyet''in kuruluşu ve yeni devletin önderleri tasvir edilir. Taksim Meydanı, İstiklal Caddesi''nin başlangıç noktası ve şehrin en önemli buluşma yerlerinden biri olduğu için anıt kolayca görülebilir.'),
  ('taksim-cumhuriyet-aniti', 'en', 'In the middle of Taksim Square, the Republic Monument was made by the Italian sculptor Pietro Canonica and unveiled on 8 August 1928. Its base and surroundings were designed by Giulio Mongeri, also the architect of St Anthony''s Church.

The monument has two faces: one shows Atatürk and his comrades leading the War of Independence, the other the founding of the Republic and the leaders of the new state. As Taksim Square is the starting point of İstiklal Avenue and one of the city''s main meeting places, the monument is easy to see.'),
  ('arkadios-sutunu', 'tr', 'Cerrahpaşa''daki Arkadios Sütunu, İmparator Arkadios''un Gotlara karşı kazanılan zaferi anmak için 5. yüzyılın başında diktirdiği bir zafer sütunuydu. Roma''daki Traianus Sütunu gibi gövdesini sarmal kabartmalar sarıyordu. Halk arasında Avrat Taşı diye bilinir.

Depremlerde zarar gören sütun 18. yüzyılın başında yıkılma tehlikesi nedeniyle indirildi; bugün yalnızca evlerin arasında kalmış kaidesi görülebilir. İçinde sütunun tepesine çıkan merdivenin başlangıcı korunmuştur. Genellikle yalnızca dışarıdan görülebildiği için kısa bir durak olarak düşünülmelidir.'),
  ('arkadios-sutunu', 'en', 'In Cerrahpaşa, the Column of Arcadius was a victory column raised by Emperor Arcadius in the early 5th century to commemorate a victory over the Goths. Like Trajan''s Column in Rome, its shaft was wrapped in spiral reliefs. Locally it is known as Avrat Taşı.

Damaged by earthquakes, the column was taken down in the early 18th century because it threatened to collapse; today only its base survives, squeezed between houses. Inside, the start of the staircase that once led to the top is preserved. It can usually only be seen from outside, so plan it as a short stop.'),
  ('asiyan-muzesi', 'tr', 'Rumelihisarı''nın üstündeki yamaçta, Boğaz''a bakan Aşiyan Müzesi, şair Tevfik Fikret''in 1906-1915 yılları arasında yaşadığı evdir. Planlarını şairin kendisinin çizdiği ahşap ev, 1945''ten bu yana müze olarak hizmet verir. Adı Farsçada ''kuş yuvası'' anlamına gelir.

Evde Tevfik Fikret ve ailesine ait eşyalar ile Edebiyat-ı Cedide döneminin önemli yazar ve şairlerine ait eserler sergilenir; şairin mezarı da bahçededir. Bahçeden ve üst kattan Boğaz''ın en güzel manzaralarından biri görülür. Rumeli Hisarı gezisine eklenebilir; ziyaret günlerini önceden kontrol edin.'),
  ('asiyan-muzesi', 'en', 'On the slope above Rumelihisarı overlooking the Bosphorus, the Aşiyan Museum is the house where the poet Tevfik Fikret lived from 1906 to 1915. The wooden house, which the poet designed himself, has been a museum since 1945. Its name means ''bird''s nest'' in Persian.

It displays belongings of Tevfik Fikret and his family, along with items of leading writers and poets of the Edebiyat-ı Cedide movement; the poet''s grave is in the garden. From the garden and upper floor there is one of the loveliest views of the Bosphorus. It can be added to a visit to Rumeli Fortress; check opening days in advance.'),
  ('fethipasa-korusu', 'tr', 'Üsküdar''da Kuzguncuk ile Paşalimanı arasındaki yamaçta uzanan Fethipaşa Korusu, adını 19. yüzyıl Osmanlı devlet adamı Fethi Ahmed Paşa''dan alır. Uzun yıllar bakımsız kaldıktan sonra yenilenerek halka açık bir parka dönüştürüldü.

Ağaçlık yamaçtaki yürüyüş yolları ve teraslardan Boğaz, köprü ve karşı kıyının geniş bir manzarası görülür. İçindeki kafe ve çay bahçeleri hafta sonları kahvaltı için sevilen yerlerdir. Kuzguncuk''un renkli sokaklarıyla aynı gezide birleştirilebilir.'),
  ('fethipasa-korusu', 'en', 'On the hillside between Kuzguncuk and Paşalimanı in Üsküdar, Fethipaşa Grove takes its name from the 19th-century Ottoman statesman Fethi Ahmed Pasha. After years of neglect it was renovated and turned into a public park.

Its walking paths and terraces on the wooded slope offer wide views of the Bosphorus, the bridge and the opposite shore. The cafés and tea gardens inside are popular for weekend breakfasts. It combines well with the colourful streets of Kuzguncuk.'),
  ('galata-mevlevihanesi-muzesi', 'tr', 'Tünel''e yakın Galip Dede Caddesi''ndeki Galata Mevlevihanesi, 1491''de kurulan ve İstanbul''daki ilk Mevlevi tekkesi olan yapıdır. Bugünkü semahane 18. yüzyılın sonunda III. Selim döneminde yeniden inşa edildi. Tekke, tekkelerin kapatıldığı 1925''e kadar Mevlevi kültürünün şehirdeki merkezlerinden biriydi.

Bugün müze olan yapıda sekizgen ahşap semahane, Mevlevi müziğinde kullanılan çalgılar, kıyafetler ve el yazmaları sergilenir. Bahçedeki hazirede şair Şeyh Galib''in türbesi ve matbaacı İbrahim Müteferrika''nın mezarı bulunur. Belirli günlerde sema gösterileri yapılır; programı önceden kontrol edin.'),
  ('galata-mevlevihanesi-muzesi', 'en', 'On Galip Dede Avenue near Tünel, the Galata Mevlevi Lodge was founded in 1491 and was the first Mevlevi lodge in Istanbul. The present ceremonial hall was rebuilt at the end of the 18th century under Selim III. Until the lodges were closed in 1925, it was one of the city''s centres of Mevlevi culture.

Now a museum, it displays the octagonal wooden hall where the whirling ceremony was held, along with instruments of Mevlevi music, garments and manuscripts. The graveyard holds the tomb of the poet Şeyh Galib and the grave of the printer İbrahim Müteferrika. Whirling ceremonies are held on certain days; check the programme in advance.'),
  ('kayis-dagi', 'tr', 'Anadolu yakasında, Ataşehir ve Maltepe sınırındaki Kayış Dağı, yaklaşık 438 metre yüksekliğiyle Aydos Tepesi ve Alemdağ''dan sonra İstanbul''un en yüksek noktalarından biridir. Yamaçları büyük ölçüde ormanla kaplıdır.

Ormanlık alandaki yürüyüş yolları ve mesire yerleri, hafta sonu doğa yürüyüşü ve piknik için şehre yakın bir seçenek sunar. Açık havada tepeden Marmara Denizi, Adalar ve Anadolu yakasının geniş bir manzarası görülür. Rahat ayakkabı ve su almak iyi olur.'),
  ('kayis-dagi', 'en', 'On the Asian side, on the border of Ataşehir and Maltepe, Kayışdağı rises to about 438 metres, making it one of the highest points in Istanbul after Aydos Hill and Alemdağ. Its slopes are largely forested.

The trails and picnic areas in the forest offer a close-to-the-city option for weekend hikes and picnics. On clear days the summit gives wide views over the Sea of Marmara, the Princes'' Islands and the Asian side. Comfortable shoes and water are a good idea.'),
  ('moda-sahili', 'tr', 'Kadıköy''ün Moda semtinde, burnun çevresinde uzanan Moda Sahili, Anadolu yakasının en sevilen deniz kenarı yürüyüş yerlerinden biridir. Semt, 19. yüzyılda Levanten ailelerin köşkleriyle gelişmiş, bugün kafeleri, dondurmacıları ve canlı sokaklarıyla tanınır.

Sahildeki çay bahçeleri ve çimenlik alanlar, karşıda Tarihi Yarımada''nın siluetiyle özellikle gün batımında çok kalabalık olur. Kadıköy çarşısından nostaljik tramvayla ya da sahil boyunca yürüyerek gelinebilir. Moda iskelesi ve Yoğurtçu Parkı da yakındadır.'),
  ('moda-sahili', 'en', 'Curving around the point in Kadıköy''s Moda district, the Moda shore is one of the best-loved seaside promenades on the Asian side. The neighbourhood grew in the 19th century with the mansions of Levantine families and is known today for its cafés, ice-cream shops and lively streets.

The tea gardens and lawns along the shore, facing the skyline of the historic peninsula, get very busy, especially at sunset. You can come from the Kadıköy market by the nostalgic tram or on foot along the shore. Moda pier and Yoğurtçu Park are nearby.'),
  ('rahmi-m-koc-muzesi', 'tr', 'Haliç kıyısında, Hasköy''deki Rahmi M. Koç Müzesi, 1994''te açılan ve Türkiye''de sanayi, ulaşım ve iletişim tarihine adanan ilk büyük müzedir. Bizans temelleri üzerine kurulmuş Osmanlı dönemi Lengerhane binası ile eski Hasköy tersanesinde hizmet verir.

Buharlı trenler, eski otomobiller, uçaklar, tekneler, mekanik oyuncaklar ve bilimsel aletler arasında saatlerce gezilebilir; ziyaret edilebilen bir denizaltı da koleksiyonun parçasıdır. Çocuklu aileler için İstanbul''un en keyifli müzelerinden biridir. Haliç kıyısındaki kafe ve restoranları mola için uygundur.'),
  ('rahmi-m-koc-muzesi', 'en', 'On the Golden Horn in Hasköy, the Rahmi M. Koç Museum opened in 1994 as Turkey''s first major museum devoted to the history of industry, transport and communications. It occupies the Ottoman-era Lengerhane, an anchor foundry built on Byzantine foundations, and the former Hasköy shipyard.

You can spend hours among steam trains, vintage cars, aircraft, boats, mechanical toys and scientific instruments; a submarine you can go inside is also part of the collection. It is one of Istanbul''s most enjoyable museums for families with children. Its waterfront café and restaurants are good for a break.'),
  ('serefiye-sarnici', 'tr', 'Divanyolu''nun hemen yakınındaki Şerefiye Sarnıcı, 5. yüzyılda İmparator II. Theodosius döneminde yapılan ve Theodosius Sarnıcı diye de bilinen bir Bizans su deposudur. Mermer başlıklı 32 sütun üzerinde yükselen tonozlarıyla küçük ama etkileyici bir yapıdır.

Uzun yıllar bir binanın altında kalan sarnıç kapsamlı bir restorasyonun ardından 2018''de ziyarete açıldı. Sütunlar arasında yapılan ışık ve görüntü gösterileri ziyareti farklı kılar. Yerebatan''a göre çok daha az kalabalıktır ve Binbirdirek Sarnıcı ile aynı gezide görülebilir.'),
  ('serefiye-sarnici', 'en', 'Just off Divanyolu, the Şerefiye Cistern is a Byzantine reservoir built in the 5th century under Emperor Theodosius II and also known as the Cistern of Theodosius. With vaults rising on 32 columns with marble capitals, it is small but impressive.

Hidden beneath a building for many years, the cistern opened to visitors in 2018 after extensive restoration. Light and projection shows among the columns make the visit distinctive. It is much less crowded than the Basilica Cistern and can be seen on the same walk as the Cistern of a Thousand and One Columns.')
  ) v(slug, lang, long_desc)
  join public.places p on p.slug = v.slug
 where t.place_id = p.id and t.lang = v.lang;
