-- İstanbul uzun açıklamaları, 12. parti (10 yer, TR + EN).
-- Üreten: data-pipeline/content/build_long_desc.py (kaynak: content/istanbul_long_descriptions.py).
-- Metinler kendi cümlelerimizdir; Vikipedi/Wikidata yalnızca bilgi kontrolü için kullanıldı.

update public.place_translations t
   set long_desc = v.long_desc
  from (values
  ('iii-ahmed-cesmesi', 'tr', 'Topkapı Sarayı''nın Bab-ı Hümayun kapısı ile Ayasofya arasındaki meydanda duran III. Ahmed Çeşmesi, 1728''de Lale Devri''nde yapıldı. Osmanlı mimarisinde rokoko etkisinin en güzel örneklerinden biri olarak kabul edilir.

Dört cephesinde birer çeşme, köşelerinde ise gelip geçene su dağıtılan şebekeli sebiller bulunur. Mermer yüzeyleri çiçek, meyve ve vazo motifleriyle kaplıdır; saçağın altındaki şiir kitabeleri arasında padişahın kendi beyitleri de yer alır. Topkapı Sarayı''na girerken birkaç dakika durup incelemeye değer.'),
  ('iii-ahmed-cesmesi', 'en', 'In the square between the Imperial Gate of Topkapı Palace and Hagia Sophia, the Fountain of Ahmed III was built in 1728, during the Tulip Era. It is considered one of the finest examples of rococo influence in Ottoman architecture.

Each of its four sides has a fountain, and at the corners are grilled kiosks where water was once handed out to passers-by. Its marble surfaces are covered with flowers, fruit and vases, and the verse inscriptions beneath the eaves include couplets by the sultan himself. It is worth pausing a few minutes to study it on the way into Topkapı Palace.'),
  ('istanbul-askenaz-sinagogu', 'tr', 'Galata Kulesi''ne inen Yüksek Kaldırım yokuşundaki Aşkenaz Sinagogu, Avusturya-Macaristan''dan İstanbul''a yerleşen Aşkenaz Yahudileri tarafından 1900''de açıldı. Şehirde Aşkenaz cemaatinin kurduğu sinagoglardan ayakta kalan tek örnektir.

Avrupa üslubundaki cephesi, yokuştaki dükkânların arasında dikkat çeker; iç mekânda ahşap Ehal ve galeriler bulunur. İbadete açık bir sinagog olduğundan ziyaret için önceden izin ve kimlik kontrolü gerekebilir; koşulları gitmeden önce kontrol edin.'),
  ('istanbul-askenaz-sinagogu', 'en', 'On the Yüksek Kaldırım slope leading down from Galata Tower, the Ashkenazi Synagogue was opened in 1900 by Ashkenazi Jews who had settled in Istanbul from Austria-Hungary. It is the only one still standing of the synagogues the Ashkenazi community founded in the city.

Its European-style façade stands out among the shops on the slope, and inside are a wooden Torah ark and galleries. As a working synagogue, visits may require prior permission and an ID check; check the conditions before you go.'),
  ('polonezkoy-tabiat-parki', 'tr', 'Beykoz''un ormanları içindeki Polonezköy, 1842''de Polonyalı göçmenler tarafından kurulan bir köydür; 1994''te çevresiyle birlikte tabiat parkı ilan edildi. Köyün Polonya kökenli geçmişi kilisesinde, mezarlığında ve eski evlerinde hâlâ hissedilir.

Ormanlık alandaki yürüyüş ve bisiklet yolları, dere kenarları ve piknik alanları şehirden kaçmak isteyenler için idealdir. Köydeki kahvaltı mekânları ve ev yapımı reçeller hafta sonları çok ilgi görür. Toplu taşımayla ulaşım sınırlı olduğundan yolculuğu önceden planlayın.'),
  ('polonezkoy-tabiat-parki', 'en', 'In the forests of Beykoz, Polonezköy is a village founded in 1842 by Polish émigrés; in 1994 it was declared a nature park together with its surroundings. The village''s Polish past can still be felt in its church, cemetery and old houses.

Its forest walking and cycling trails, streams and picnic areas are ideal for escaping the city. The village''s breakfast spots and homemade jams are very popular at weekends. Public transport is limited, so plan your journey in advance.'),
  ('ahrida-sinagogu', 'tr', 'Balat''taki Ahrida Sinagogu, 15. yüzyılın başlarında, bugün Kuzey Makedonya''da bulunan Ohri''den gelen Romanyot Yahudiler tarafından kuruldu ve adını bu şehirden alır. İstanbul''un en eski ve kapasitesi en büyük sinagoglarından biridir.

En dikkat çekici bölümü, ortadaki gemi pruvası biçimli ahşap tevadır; Nuh''un gemisini ya da İspanya''dan gelen Yahudileri taşıyan gemileri simgelediği anlatılır. İbadete açık bir sinagog olduğundan ziyaret için önceden izin gerekir; koşulları gitmeden önce kontrol edin.'),
  ('ahrida-sinagogu', 'en', 'In Balat, the Ahrida Synagogue was founded in the early 15th century by Romaniote Jews from Ohrid, now in North Macedonia, and takes its name from that city. It is one of the oldest synagogues in Istanbul and the one with the largest capacity.

Its most striking feature is the central wooden reading platform shaped like the prow of a ship, said to symbolise Noah''s Ark or the ships that carried Jews from Spain. As a working synagogue it requires permission to visit; check the conditions before you go.'),
  ('alman-cesmesi', 'tr', 'Sultanahmet Meydanı''nın kuzey ucundaki Alman Çeşmesi, Alman İmparatoru II. Wilhelm''in 1898''deki İstanbul ziyaretinin anısına Sultan II. Abdülhamid''e armağanıdır. Almanya''da üretilen parçalar İstanbul''a getirilerek 1900''lerin başında yerine kuruldu.

Sekizgen planlı, neo-Bizans üslubundaki çeşmenin kubbesinin içi altın yaldızlı mozaiklerle kaplıdır; mozaiklerde iki hükümdarın monogramları görülür. Sultanahmet Camii ile Ayasofya arasında yürürken kolayca görülebilir.'),
  ('alman-cesmesi', 'en', 'At the northern end of Sultanahmet Square, the German Fountain was a gift from the German Emperor Wilhelm II to Sultan Abdülhamid II, commemorating his visit to Istanbul in 1898. Its parts were made in Germany, shipped to Istanbul and assembled in the early 1900s.

The interior of the dome of this octagonal, neo-Byzantine fountain is covered with gilded mosaics bearing the monograms of the two rulers. It is easy to see while walking between the Blue Mosque and Hagia Sophia.'),
  ('aya-triada-kilisesi', 'tr', 'Taksim Meydanı''nın hemen yanında, İstiklal Caddesi''nin başındaki Aya Triada Kilisesi, 1880''de açılan ve İstanbul''un en büyük Rum Ortodoks kiliselerinden biri olan yapıdır. Kubbesi ve iki çan kulesi Taksim''in siluetinin bir parçasıdır.

Neo-barok üsluptaki kilisenin iç mekânı, ikonaları, avizeleri ve süslü ikonostasisiyle oldukça gösterişlidir. Kapı açık olduğunda ziyaret edilebilir; ibadet yeri olduğundan uygun giyinilmeli ve sessiz olunmalıdır. İstiklal Caddesi yürüyüşüne başlarken kısa bir durak olarak uygundur.'),
  ('aya-triada-kilisesi', 'en', 'Right beside Taksim Square at the top of İstiklal Avenue, the Hagia Triada Church opened in 1880 and is one of the largest Greek Orthodox churches in Istanbul. Its dome and twin bell towers are part of the Taksim skyline.

The interior of this neo-baroque church is lavish, with its icons, chandeliers and ornate iconostasis. It can be visited when the gate is open; as a place of worship it calls for modest dress and quiet. It makes a short stop at the start of a walk down İstiklal Avenue.'),
  ('sadberk-hanim-muzesi', 'tr', 'Sarıyer Büyükdere''de, Boğaz kıyısındaki tarihi yalılarda yer alan Sadberk Hanım Müzesi, 1980''de açılan Türkiye''nin ilk özel müzesidir. Adını, koleksiyonu oluşturan Vehbi Koç''un eşi Sadberk Koç''tan alır.

Arkeoloji bölümünde Neolitik dönemden Bizans''a uzanan Anadolu eserleri, Türk-İslam bölümünde ise İznik çinileri, Osmanlı kıyafetleri, işlemeler ve gümüş eşyalar sergilenir. Sakin ve zengin bir koleksiyonu olan müze, Boğaz''ın kuzey köylerine yapılacak bir geziye güzel bir durak olur. Ziyaret günlerini önceden kontrol edin.'),
  ('sadberk-hanim-muzesi', 'en', 'In Büyükdere, Sarıyer, set in historic waterside mansions on the Bosphorus, the Sadberk Hanım Museum opened in 1980 as Turkey''s first private museum. It is named after Sadberk Koç, wife of Vehbi Koç, who built up the collection.

Its archaeology section covers Anatolian works from the Neolithic to the Byzantine era, while the Turkish-Islamic section displays İznik tiles, Ottoman costume, embroidery and silverware. A quiet museum with a rich collection, it makes a fine stop on a trip to the villages of the upper Bosphorus. Check opening days in advance.'),
  ('istanbul-islam-bilim-ve-teknoloji-muzesi', 'tr', 'Gülhane Parkı''ndaki tarihi Has Ahırlar binasında 2008''de açılan İslam Bilim ve Teknoloji Tarihi Müzesi, bilim tarihçisi Prof. Dr. Fuat Sezgin''in öncülüğünde kuruldu. 9. ile 16. yüzyıllar arasında İslam dünyasında yapılan bilimsel çalışmaları tanıtır.

Astronomi, coğrafya, tıp, optik, kimya ve mekanik alanlarındaki aletlerin ve haritaların yüzlerce modeli sergilenir; usturlaplar ve su saatleri en ilgi çekenlerdir. Çocuklu aileler ve bilim meraklıları için öğreticidir. Gülhane Parkı yürüyüşüyle birleştirilebilir.'),
  ('istanbul-islam-bilim-ve-teknoloji-muzesi', 'en', 'Opened in 2008 in the historic royal stables building in Gülhane Park, the Museum of the History of Science and Technology in Islam was founded under the leadership of the historian of science Prof. Fuat Sezgin. It presents scientific work done in the Islamic world between the 9th and 16th centuries.

Hundreds of models of instruments and maps from astronomy, geography, medicine, optics, chemistry and mechanics are on display, with astrolabes and water clocks among the most fascinating. It is instructive for families and science lovers. It combines well with a walk through Gülhane Park.'),
  ('macka-demokrasi-parki', 'tr', 'Dolmabahçe, Maçka, Nişantaşı ve Harbiye arasındaki vadiye yayılan Maçka Demokrasi Parkı, şehrin merkezindeki en büyük yeşil alanlardan biridir. Havuzları, çimenlikleri ve ulu ağaçlarıyla çevredeki yoğun semtlerin nefes alma noktasıdır.

Parkın üzerinden geçen Maçka-Taşkışla teleferiği kısa ama keyifli bir manzara yolculuğu sunar. Kafe ve çay bahçeleri, çocuk oyun alanları ve yürüyüş yolları hafta sonları çok kullanılır. Nişantaşı alışverişi ya da Dolmabahçe gezisiyle kolayca birleştirilebilir.'),
  ('macka-demokrasi-parki', 'en', 'Spreading through the valley between Dolmabahçe, Maçka, Nişantaşı and Harbiye, Maçka Democracy Park is one of the largest green spaces in the city centre. With its pools, lawns and great trees, it is a breathing space for the dense districts around it.

The Maçka-Taşkışla cable car passing over the park offers a short but enjoyable ride with a view. Its cafés, tea gardens, playgrounds and paths are busy at weekends. It combines easily with shopping in Nişantaşı or a visit to Dolmabahçe.'),
  ('rumeli-feneri', 'tr', 'Boğaz''ın Karadeniz''e açıldığı noktada, Avrupa yakasının en kuzey ucundaki Rumeli Feneri, 19. yüzyılın ortasında yapılan ve bugün de çalışan bir deniz feneridir. Karşı kıyıdaki Anadolu Feneri ile birlikte Boğaz''ın girişini işaretler.

Fenerle aynı adı taşıyan balıkçı köyü, küçük limanı, balık restoranları ve kayalık sahilleriyle sakin bir kaçış noktasıdır. Köyün üstündeki tepeden Karadeniz''in ve Yavuz Sultan Selim Köprüsü''nün manzarası görülür. Şehir merkezinden uzak olduğu için ulaşımı önceden planlayın.'),
  ('rumeli-feneri', 'en', 'At the point where the Bosphorus opens to the Black Sea, at the northernmost tip of the European side, Rumeli Feneri is a lighthouse built in the mid-19th century and still in service. Together with Anadolu Feneri on the opposite shore, it marks the entrance to the strait.

The fishing village that shares its name, with its small harbour, fish restaurants and rocky shore, is a quiet escape. From the hill above the village there are views of the Black Sea and the Yavuz Sultan Selim Bridge. It is far from the city centre, so plan your transport in advance.')
  ) v(slug, lang, long_desc)
  join public.places p on p.slug = v.slug
 where t.place_id = p.id and t.lang = v.lang;
