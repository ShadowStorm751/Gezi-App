-- Bursa uzun açıklamaları, 1. parti (24 yer, TR + EN).
-- Üreten: data-pipeline/content/build_long_desc.py (kaynak: content/bursa_long_descriptions.py).
-- Metinler kendi cümlelerimizdir; Vikipedi/Wikidata yalnızca bilgi kontrolü için kullanıldı.

update public.place_translations t
   set long_desc = v.long_desc
  from (values
  ('bursa-ulu-camii', 'tr', 'Bursa Ulu Camii, Sultan I. Bayezid (Yıldırım) tarafından Niğbolu zaferinin ardından yaptırıldı ve 1396-1400 yılları arasında tamamlandı. Rivayete göre sultan zafer için yirmi cami adamış, sonra bunun yerine yirmi kubbeli tek bir cami yaptırmıştır. Çok ayaklı cami tipinin en anıtsal örneğidir.

İçeride, ortadaki kubbenin altında yer alan şadırvan, camiye ender rastlanan bir ferahlık katar. Duvarları ve ayakları süsleyen yüzlerce büyük hat levhası ve ince işçilikli ceviz minber görülmeye değer. Koza Han ve Kapalıçarşı hemen yanındadır; namaz vakitleri dışında, sessizce gezilmelidir.'),
  ('bursa-ulu-camii', 'en', 'The Grand Mosque of Bursa was commissioned by Sultan Bayezid I (Yıldırım) after his victory at Nicopolis and completed between 1396 and 1400. Legend says the sultan vowed twenty mosques for the victory and instead built a single mosque with twenty domes. It is the most monumental example of the multi-pier mosque type.

Inside, the ablution fountain beneath the central dome gives the mosque a rare sense of openness. The hundreds of large calligraphy panels on the walls and piers and the finely carved walnut pulpit are well worth seeing. The Koza Han and the Covered Bazaar are right next door; visit quietly outside prayer times.'),
  ('ayasofya-camii-iznik', 'tr', 'İznik''in tam ortasında, surla çevrili kentin dört kapısından gelen yolların kesiştiği yerdeki Ayasofya, Bizans döneminde bir bazilika olarak yapıldı. 787''deki II. İznik Konsili bu kilisede toplandı. Orhan Gazi kenti aldıktan sonra camiye çevrildi; 16. yüzyılda Mimar Sinan tarafından onarıldı. Uzun süre müze olarak kullanıldıktan sonra 2011''de yeniden cami oldu.

İçeride, apsis bölümünde Bizans dönemine ait fresk kalıntıları ve döşeme izleri görülebilir. Kentin Hristiyanlık tarihindeki önemini hissettiren bir yapıdır. Kent merkezinde olduğundan İznik Müzesi, Yeşil Cami ve surlarla birlikte yürüyerek gezilir.'),
  ('ayasofya-camii-iznik', 'en', 'In the very centre of İznik, where the roads from the four gates of the walled city meet, Hagia Sophia was built as a basilica in the Byzantine period. The Second Council of Nicaea met in this church in 787. After Orhan Gazi took the city it was converted into a mosque, and in the 16th century it was repaired by the architect Sinan. Long used as a museum, it became a mosque again in 2011.

Inside, remains of Byzantine frescoes and traces of the floor can be seen in the apse. It is a building that conveys the city''s importance in Christian history. Being in the town centre, it is visited on foot together with the İznik Museum, the Green Mosque and the walls.'),
  ('emir-sultan-camii', 'tr', 'Emir Sultan Camii, Yıldırım Bayezid''in kızı Hundi Fatma Hatun tarafından eşi, Buharalı âlim Emir Sultan adına 15. yüzyılın başında yaptırıldı. Depremlerde zarar gören yapı 1804''te Sultan III. Selim döneminde, 1855 depreminden sonra da 1868''de yeniden inşa edildi; bugünkü Osmanlı barok görünümü bu dönemden kalır.

Caminin yanındaki Emir Sultan Türbesi, Bursalıların en çok ziyaret ettiği manevi mekânlardandır; özellikle cuma günleri kalabalık olur. Avludan Bursa ovasına ve şehre güzel bir manzara açılır. Hemen arkasındaki tarihi mezarlık ve Yıldırım Camii aynı gezide görülebilir.'),
  ('emir-sultan-camii', 'en', 'The Emir Sultan Mosque was commissioned in the early 15th century by Hundi Fatma Hatun, daughter of Bayezid I, in the name of her husband, the Bukharan scholar Emir Sultan. Damaged by earthquakes, it was rebuilt in 1804 under Sultan Selim III and again in 1868 after the earthquake of 1855; its present Ottoman Baroque look dates from this period.

The Tomb of Emir Sultan beside the mosque is one of the spiritual places most visited by the people of Bursa, and it gets busy especially on Fridays. The courtyard offers a fine view over the city and the plain. The historic cemetery behind it and the Yıldırım Mosque fit into the same visit.'),
  ('orhan-gazi-camii', 'tr', 'Bursa''nın merkezindeki Orhan Gazi Camii, Orhan Gazi tarafından 1339-1340''ta bir külliyenin parçası olarak yaptırıldı ve kentin en eski Osmanlı yapılarındandır. 1413''te Karamanoğlu kuvvetlerince yakıldı; 1417''de Çelebi Mehmed tarafından onarıldı.

Ters T planlı, yanlarında tabhane odaları bulunan yapı, erken Osmanlı cami mimarisini anlamak için iyi bir örnektir; giriş revakı ve taş-tuğla almaşık örgüsü dikkat çeker. Heykel''e, Koza Han''a ve Kapalıçarşı''ya yürüme mesafesindedir; çarşı gezisinin başında ya da sonunda görülebilir.'),
  ('orhan-gazi-camii', 'en', 'The Orhan Gazi Mosque in central Bursa was founded by Orhan Gazi in 1339-1340 as part of a charitable complex and is one of the city''s oldest Ottoman buildings. It was burned by Karamanid forces in 1413 and restored in 1417 by Mehmed I.

With its inverted-T plan and side rooms for travelling dervishes, it is a good example for understanding early Ottoman mosque architecture; note the entrance portico and the alternating courses of stone and brick. It is within walking distance of Heykel, the Koza Han and the Covered Bazaar, so it fits at the start or end of a bazaar walk.'),
  ('iznik-yesil-cami', 'tr', 'İznik Yeşil Cami, Sultan I. Murad''ın sadrazamı Çandarlı Kara Halil Hayreddin Paşa tarafından yaptırılmaya başlandı; paşanın 1387''de ölmesi üzerine oğlu Çandarlı Ali Paşa tarafından tamamlandı. Erken Osmanlı mimarisinin en zarif örneklerinden sayılır.

Adını, minaresini kaplayan yeşil-turkuaz çinilerden alır; bugün görülen çiniler sonraki onarımlarda yenilenmiştir. Mermer kaplı cephesi ve giriş revakındaki taş işçiliği yakından incelenmeye değer. İznik Müzesi''nin bulunduğu Nilüfer Hatun İmareti hemen karşısındadır.'),
  ('iznik-yesil-cami', 'en', 'The Green Mosque of İznik was begun by Çandarlı Kara Halil Hayreddin Pasha, Grand Vizier of Sultan Murad I, and completed after his death in 1387 by his son Çandarlı Ali Pasha. It is counted among the most elegant examples of early Ottoman architecture.

It takes its name from the green and turquoise tiles covering its minaret; the tiles seen today were renewed in later restorations. Its marble-clad façade and the stone carving of the entrance portico deserve a close look. The Nilüfer Hatun Soup Kitchen, home to the İznik Museum, is right opposite.'),
  ('fatih-camii-tirilye', 'tr', 'Tirilye''deki Fatih Camii, ilk olarak 8. ya da 9. yüzyılda Bizans kilisesi olarak yapıldı ve Hagios Stephanos Kilisesi olarak bilinir. 16. yüzyılda camiye çevrildi; Kurtuluş Savaşı yıllarında kısa bir süre yeniden kilise olarak kullanıldı.

Kubbeli küçük yapı, Tirilye''nin Bizans geçmişinin en iyi korunmuş izlerindendir; tuğla ve taş örgülü dış duvarlarına yakından bakın. Köyün taş sokakları, Kemerli Kilise ve sahildeki balık lokantalarıyla birlikte gezilir. Namaz vakitlerinde içeriyi gezmeyi erteleyin.'),
  ('fatih-camii-tirilye', 'en', 'The Fatih Mosque in Tirilye was originally built in the 8th or 9th century as a Byzantine church, known as the Church of St Stephen. It was converted into a mosque in the 16th century and was briefly used as a church again during the War of Independence years.

The small domed building is one of the best-preserved traces of Tirilye''s Byzantine past; take a close look at its brick-and-stone outer walls. It is visited together with the village''s stone streets, the Arched Church and the fish restaurants on the shore. Avoid touring the interior during prayer times.'),
  ('veled-i-yanic-cami', 'tr', 'Bursa''nın Hisar semtindeki Veled-i Yaniç (Yaniçoğlu) Camii, kapısı üzerindeki kitabeye göre Temmuz 1440''ta Mahmud Çelebi tarafından yaptırıldı. Banisi, I. Murad ve Yıldırım Bayezid dönemlerinde devlet hizmetinde bulunmuş, Ankara Savaşı''na katılmış sufi bir komutandı; caminin bahçesinde yattığı düşünülür.

Kare planlı, sekizgen kubbeli bu küçük mescidin en ilginç yanı minaresidir: camiden yaklaşık on metre ötede, girişin karşısındaki bir çeşmenin üzerinde durur ve bir çan kulesini andırır. Hisar''ın tarihi sokaklarında, Osman Gazi ve Orhan Gazi türbelerine giderken kısa bir durak olarak görülebilir.'),
  ('veled-i-yanic-cami', 'en', 'According to the inscription over its door, the Veled-i Yaniç (Yaniçoğlu) Mosque in Bursa''s Hisar quarter was built by Mahmud Çelebi in July 1440. Its founder was a Sufi commander who served the state under Murad I and Bayezid I and fought at the Battle of Ankara; he is believed to be buried in the mosque''s garden.

The most unusual feature of this small square mosque with its octagonal dome is its minaret: it stands about ten metres away, on top of a fountain opposite the entrance, and resembles a bell tower. It makes a short stop in the historic streets of Hisar on the way to the tombs of Osman Gazi and Orhan Gazi.'),
  ('yildirim-camii', 'tr', 'Yıldırım Camii, Sultan I. Bayezid''in (Yıldırım) 1391-1395 yılları arasında yaptırdığı büyük külliyenin camisidir. Külliyede medrese, hamam, imaret, türbe ve Osmanlı''nın ilk darüşşifalarından (hastane) biri bulunuyordu; Yıldırım Bayezid''in türbesi de buradadır.

Ters T planlı caminin beş kemerli giriş revakı ve mermer işçiliği, erken Osmanlı mimarisinin en olgun örneklerindendir. Şehir merkezinin doğusunda, bir tepenin üzerinde yer alır; buradan ovaya bakan manzara güzeldir. Emir Sultan Camii ile aynı gezide görülebilir.'),
  ('yildirim-camii', 'en', 'The Yıldırım Mosque is the mosque of the large complex built by Sultan Bayezid I (Yıldırım) between 1391 and 1395. The complex included a madrasa, a bath, a soup kitchen, a tomb and one of the first Ottoman hospitals; Bayezid''s own tomb is here too.

The mosque''s inverted-T plan, its five-arched entrance portico and its marble work are among the most mature examples of early Ottoman architecture. It stands on a hill east of the city centre with a fine view over the plain. It can be seen on the same outing as the Emir Sultan Mosque.'),
  ('bursa-muradiye-camii', 'tr', 'Muradiye Külliyesi, Sultan II. Murad tarafından 15. yüzyılın ilk yarısında kuruldu; Bursa''da bir padişah adına yapılan son büyük külliyedir. Cami, medrese, hamam ve imaretin yanında, bahçesindeki türbelerle bir Osmanlı hanedan mezarlığına dönüşmüştür. 2014''te ''Bursa ve Cumalıkızık: Osmanlı İmparatorluğu''nun Doğuşu'' adıyla UNESCO Dünya Mirası Listesi''ne alınan alanın parçasıdır.

Selvi ve çınarların gölgesindeki bahçede II. Murad, Cem Sultan, Şehzade Mustafa ve sultan ailesinden pek çok kişinin türbeleri bulunur; II. Murad''ın vasiyetiyle türbesinin tepesi açık bırakılmıştır. Türbelerin bazılarındaki çiniler ve kalem işleri çok değerlidir. Karşısındaki Osmanlı Evi Müzesi aynı ziyarette görülür. İçindeki yapılar ayrıca işaretlenebilir.'),
  ('bursa-muradiye-camii', 'en', 'The Muradiye Complex was founded by Sultan Murad II in the first half of the 15th century and is the last great complex built in Bursa in a sultan''s name. Besides the mosque, madrasa, bath and soup kitchen, the tombs in its garden have made it an Ottoman dynastic cemetery. It is part of the site added to the UNESCO World Heritage List in 2014 as ''Bursa and Cumalıkızık: the Birth of the Ottoman Empire''.

In the garden shaded by cypresses and plane trees lie the tombs of Murad II, Cem Sultan, Prince Mustafa and many members of the imperial family; by Murad II''s wish, the top of his tomb was left open to the sky. The tiles and painted decoration in some of the tombs are very fine. The Ottoman House Museum opposite fits into the same visit. The buildings inside can be checked off separately.'),
  ('yesil-camii', 'tr', 'Yeşil Camii, Sultan I. Mehmed (Çelebi) tarafından yaptırıldı ve 1419''da ibadete açıldı. Mimarı Hacı İvaz Paşa''dır; iç mekândaki çinileri Tebrizli ustalar yaptı. Adını, bir zamanlar dış yüzeyini de kaplayan yeşil çinilerden alır. Bursa''nın simgelerinden olan Yeşil Külliye''nin merkezidir.

Mihrap, hünkâr mahfili ve duvarları kaplayan yeşil-mavi çiniler, erken Osmanlı çini sanatının en güzel örneklerindendir; mermer kapı ve pencere çerçevelerindeki oymalar da etkileyicidir. Giriş revakı hiç tamamlanmamıştır. Hemen karşısındaki Yeşil Türbe ve çevredeki çay bahçeleriyle birlikte gezilir.'),
  ('yesil-camii', 'en', 'The Green Mosque was built by Sultan Mehmed I (Çelebi) and opened for worship in 1419. Its architect was Hacı İvaz Pasha, and its tiles were made by craftsmen from Tabriz. It takes its name from the green tiles that once also covered its exterior. It is the centrepiece of the Green Complex, one of Bursa''s symbols.

The mihrab, the sultan''s loge and the green and blue tiles covering the walls are among the finest examples of early Ottoman tilework, and the carving of the marble door and window frames is impressive too. The entrance portico was never completed. Visit it with the Green Tomb just opposite and the tea gardens around.'),
  ('eski-camii-golyazi', 'tr', 'Gölyazı''nın içindeki Eski Cami, Uluabat Gölü''ne uzanan yarımadadaki bu balıkçı köyünün tarihi camisidir. Nüfus mübadelesinden önce Rum ve Türk ailelerin birlikte yaşadığı köyün çok kültürlü geçmişinin izlerinden biridir.

Sade yapısıyla köy dokusuna uyum sağlar; çevresindeki dar sokaklar, taş ve ahşap evler ile göl kıyısı birlikte gezilir. Gölyazı''daki Aziz Panteleimon Kilisesi ve antik tiyatro kalıntıları kısa yürüyüş mesafesindedir.'),
  ('eski-camii-golyazi', 'en', 'The Old Mosque in Gölyazı is the historic mosque of this fishing village on a peninsula reaching into Lake Uluabat. It is one of the traces of the multicultural past of the village, where Greek and Turkish families lived side by side before the population exchange.

Its simple form fits the village fabric, and it is seen together with the narrow streets, stone and timber houses and lakeshore around it. The Church of St Panteleimon and the remains of the ancient theatre in Gölyazı are a short walk away.'),
  ('kemerli-kilise-tirilye', 'tr', 'Tirilye''deki Kemerli Kilise, Meryem Ana''ya adanmış Panagia Pantobasilissa Kilisesi''dir; adı ''Her şeyin Kraliçesi Meryem'' anlamına gelir. Bizans dönemine uzanan yapının adı, 1676''da gezgin John Covel''in yazdığı bir belgede geçer. Yerel halk ona giriş kemeri nedeniyle Kemerli Kilise der.

Bugün harap durumda olsa da duvarlarındaki fresk kalıntıları ve kemerli girişi görülebilir. Köyün yukarı kesimindeki dar sokaklarda yer alır; Fatih Camii ve Tirilye''nin taş evleriyle birlikte bir köy yürüyüşüne eklenebilir. Kalıntılara zarar vermeden dışarıdan bakın.'),
  ('kemerli-kilise-tirilye', 'en', 'The Arched Church in Tirilye is the Church of Panagia Pantobasilissa, dedicated to Mary; the name means ''Mary, Queen of All''. Its name appears in a document written by the traveller John Covel in 1676 for this building of Byzantine origin. Locals call it the Arched Church because of its entrance arch.

Although in ruins today, its entrance arch and remains of frescoes on its walls can still be seen. It stands in the narrow streets of the upper village and can be added to a village walk with the Fatih Mosque and Tirilye''s stone houses. Look from outside without damaging the remains.'),
  ('aziz-panteleimon-kilisesi', 'tr', 'Gölyazı''daki Aziz Panteleimon Kilisesi, 19. yüzyılda köyün Rum Ortodoks topluluğu için yapıldı. 1923 nüfus mübadelesinden sonra ibadete kapandı ve uzun süre farklı amaçlarla kullanıldı.

Taş duvarları ve göl kıyısındaki konumuyla Gölyazı''nın en dikkat çekici yapılarındandır. Köyün dar sokaklarında, Eski Cami''den birkaç dakikalık yürüyüşle ulaşılır. Gölyazı''nın gün batımı ve leylek yuvalarıyla birlikte yarım günlük bir gezi için uygundur.'),
  ('aziz-panteleimon-kilisesi', 'en', 'The Church of St Panteleimon in Gölyazı was built in the 19th century for the village''s Greek Orthodox community. Closed to worship after the 1923 population exchange, it was used for other purposes for a long time.

With its stone walls and lakeside setting, it is one of the most striking buildings in Gölyazı. It is a few minutes'' walk from the Old Mosque through the village''s narrow streets, and suits a half-day trip together with Gölyazı''s sunsets and stork nests.'),
  ('mayor-sinagogu', 'tr', 'Bursa''nın tarihi Yahudi mahallesinde, Arap Şükrü (Sakarya) Sokağı''ndaki Mayor Sinagogu, Mayorka Adası''ndan sürülerek Osmanlı topraklarına yerleşen Yahudiler tarafından kuruldu; adını da buradan alır. Bugünkü yapının 15. ya da 16. yüzyıldan kaldığı düşünülür.

Sinagog bugün düzenli ibadete kapalıdır; aynı sokaktaki Geruş Sinagogu ise kullanılmaya devam eder. Arap Şükrü Sokağı akşamları meyhaneleri ve balıkçılarıyla Bursa''nın en canlı köşelerinden biridir. Sinagogun içini görmek için önceden topluluk aracılığıyla izin almak gerekir.'),
  ('mayor-sinagogu', 'en', 'In Bursa''s historic Jewish quarter, on Arap Şükrü (Sakarya) Street, the Mayor Synagogue was founded by Jews expelled from the island of Majorca who settled in Ottoman lands, and takes its name from there. The present building is thought to date from the 15th or 16th century.

The synagogue is no longer used for regular worship, while the Gerush Synagogue on the same street remains in use. In the evenings, Arap Şükrü Street, with its taverns and fishmongers, is one of the liveliest corners of Bursa. To see the interior, permission must be obtained in advance through the community.'),
  ('bursa-arkeoloji-muzesi', 'tr', 'Bursa Arkeoloji Müzesi, 1900''lerin başında İstanbul Arkeoloji Müzesi''ne bağlı bir şube olarak kuruldu ve 1970''lerde Kültürpark''taki bugünkü binasına taşındı. Antik Bithynia ve Mysia bölgelerinden, MÖ 3000''den Bizans döneminin sonuna kadar uzanan eserleri sergiler.

Heykeller, mezar stelleri, cam ve seramik eserler, sikke ve takılar ile bahçede sergilenen lahitler ve mimari parçalar görülebilir. Kültürpark''ın yeşil alanı içinde olduğundan müze ziyaretini bir park yürüyüşüyle birleştirmek kolaydır.'),
  ('bursa-arkeoloji-muzesi', 'en', 'The Bursa Archaeological Museum was founded in the early 1900s as a branch of the Istanbul Archaeological Museum and moved to its present building in Kültürpark in the 1970s. It displays finds from the ancient regions of Bithynia and Mysia, from 3000 BC to the end of the Byzantine period.

Sculptures, grave stelae, glass and pottery, coins and jewellery are on show, with sarcophagi and architectural pieces displayed in the garden. As it sits within the green space of Kültürpark, a museum visit combines easily with a walk in the park.'),
  ('bursa-ataturk-muzesi', 'tr', 'Çekirge Caddesi üzerindeki Bursa Atatürk Müzesi, 1890''larda yapılmış üç katlı bir köşkte bulunur. Atatürk Bursa''ya geldiğinde bu köşkte kaldı; köşk sonradan müzeye dönüştürüldü.

Odalarda dönemin mobilyaları, Atatürk''ün kullandığı eşyalar ve fotoğraflar sergilenir. Bahçesi ve sakin atmosferiyle kısa bir ziyaret için uygundur. Çekirge''nin tarihi kaplıcaları ve I. Murad Hüdavendigar Külliyesi yakındadır.'),
  ('bursa-ataturk-muzesi', 'en', 'On Çekirge Street, the Bursa Atatürk Museum is housed in a three-storey mansion built in the 1890s. Atatürk stayed in this mansion on his visits to Bursa, and it was later turned into a museum.

The rooms display period furniture, Atatürk''s belongings and photographs. With its garden and calm atmosphere it suits a short visit. Çekirge''s historic thermal baths and the Murad I Hüdavendigar Complex are nearby.'),
  ('mudanya-mutareke-evi', 'tr', 'Mudanya''daki Mütareke Evi, Kurtuluş Savaşı''nın silahlı aşamasını sona erdiren Mudanya Ateşkesi''nin Ekim 1922''de imzalandığı yapıdır. Ev, Rus asıllı tüccar Aleksandr Ganyanof''a aitti; sonradan Mudanyalı iş insanı Hayri İpar tarafından satın alınıp onarıldı ve müze olarak düzenlendi.

İki katlı taş yapıda görüşmelerin yapıldığı oda, dönemin belgeleri, fotoğrafları ve eşyaları sergilenir. Sahile yakın olduğundan Mudanya''nın tarihi sokakları, sahil yolu ve eski tren istasyonu binalarıyla birlikte gezilebilir.'),
  ('mudanya-mutareke-evi', 'en', 'The Armistice House in Mudanya is where the Armistice of Mudanya, which ended the armed phase of the Turkish War of Independence, was signed in October 1922. The house belonged to the Russian-born merchant Aleksandr Ganyanof; it was later bought and restored by the Mudanya businessman Hayri İpar and arranged as a museum.

The two-storey stone building displays the room where the talks were held, along with documents, photographs and objects from the period. Being close to the shore, it can be combined with Mudanya''s historic streets, seafront and old railway station buildings.'),
  ('iznik-muzesi', 'tr', 'İznik Müzesi, 1935''te kuruldu ve 1960''tan beri Nilüfer Hatun İmareti''nde hizmet verir. İmaret, Sultan I. Murad tarafından annesi Nilüfer Hatun adına 14. yüzyılın sonunda yaptırıldı. Yapı kapsamlı bir restorasyonun ardından yeniden ziyarete açıldı.

Müzede İznik ve çevresinden çıkan arkeolojik eserlerin yanında, kente dünya çapında ün kazandıran İznik çinilerinin ve seramiklerinin örnekleri sergilenir. Yapının kendisi de erken Osmanlı mimarisinin güzel bir örneğidir. Yeşil Cami''nin hemen karşısındadır.'),
  ('iznik-muzesi', 'en', 'The İznik Museum was founded in 1935 and has occupied the Nilüfer Hatun Soup Kitchen since 1960. The building was commissioned by Sultan Murad I in the late 14th century in the name of his mother, Nilüfer Hatun. It reopened after a thorough restoration.

Alongside archaeological finds from İznik and its surroundings, the museum shows examples of the İznik tiles and ceramics that brought the town worldwide fame. The building itself is a fine example of early Ottoman architecture. It stands right opposite the Green Mosque.'),
  ('bursa-kent-muzesi', 'tr', 'Heykel''deki Bursa Kent Müzesi, 2004''ten beri kentin eski adliye binasında hizmet verir. Bursa''nın binlerce yıllık tarihini, kuruluşundan Osmanlı başkentliğine ve Cumhuriyet dönemine kadar anlatır.

Bölümlerde kentin tarihi, ünlü Bursalılar, gelenekler ve yöresel giysiler yer alır; bodrum katta canlandırılmış zanaatkâr dükkânları, ipekçilik ve bıçakçılık gibi Bursa''ya özgü meslekleri gösterir. Şehir gezisine başlamadan önce uğramak, Bursa''yı tanımak için iyi bir yoldur. Atatürk Anıtı ve Koza Parkı hemen yanındadır.'),
  ('bursa-kent-muzesi', 'en', 'The Bursa City Museum in Heykel has occupied the city''s old courthouse since 2004. It tells Bursa''s history over thousands of years, from its founding through its time as the Ottoman capital to the Republic.

Sections cover the city''s history, famous people of Bursa, traditions and local costumes; on the lower floor, recreated craftsmen''s shops show trades typical of Bursa such as silk-making and knife-making. Stopping here before exploring the city is a good way to get to know Bursa. The Atatürk Monument and Koza Park are right beside it.'),
  ('uluumay-osmanli-halk-kiyafetleri-ve-takilari-muzesi', 'tr', 'Muradiye semtindeki Uluumay Müzesi, halk bilimci ve koleksiyoncu Esat Uluumay''ın yıllar içinde topladığı Osmanlı halk kıyafetleri ve takı koleksiyonunu sergiler. UNESCO listesindeki Muradiye Külliyesi''nin hemen yakınında, tarihi bir yapıda yer alır.

Anadolu ve Balkanlar''ın farklı bölgelerine ait gelin kıyafetleri, işlemeli giysiler, gümüş takılar ve aksesuarlar yerel kültürün zenginliğini gösterir. Küçük ama özenli bir müzedir; Muradiye ve Osmanlı Evi Müzesi ile aynı gezide görülebilir.'),
  ('uluumay-osmanli-halk-kiyafetleri-ve-takilari-muzesi', 'en', 'The Uluumay Museum in the Muradiye quarter displays the collection of Ottoman folk costumes and jewellery gathered over the years by the folklorist and collector Esat Uluumay. It occupies a historic building close to the Muradiye Complex, which is on the UNESCO list.

Bridal costumes, embroidered garments, silver jewellery and accessories from different parts of Anatolia and the Balkans show the richness of local culture. It is a small but carefully arranged museum, and can be seen on the same visit as the Muradiye and the Ottoman House Museum.'),
  ('panorama-1326-bursa-fetih-muzesi', 'tr', 'Tophane''deki Panorama 1326 Bursa Fetih Müzesi, Bursa''nın 1326''da Orhan Gazi tarafından alınışını ve Osmanlı''nın kuruluş dönemini anlatan panoramik bir müzedir. Bir kent parkına dönüştürülen alanda yer alır.

Müzenin merkezinde, izleyiciyi kuşatma sahnesinin ortasına yerleştiren 360 derecelik dev bir panorama resmi bulunur; ön plandaki maketler ve ses efektleriyle sahne canlanır. Çocuklu aileler için ilgi çekicidir. Tophane Saat Kulesi ve Osman Gazi-Orhan Gazi türbeleri yürüme mesafesindedir.'),
  ('panorama-1326-bursa-fetih-muzesi', 'en', 'The Panorama 1326 Conquest Museum in Tophane tells the story of Orhan Gazi''s capture of Bursa in 1326 and the founding era of the Ottoman state. It stands in an area turned into a city park.

At its heart is a huge 360-degree panoramic painting that places the viewer in the middle of the siege, brought to life by models in the foreground and sound effects. It appeals to families with children. The Tophane Clock Tower and the tombs of Osman Gazi and Orhan Gazi are within walking distance.'),
  ('merinos-tekstil-sanayi-muzesi', 'tr', 'Merinos Parkı''ndaki Tekstil Sanayi Müzesi, Cumhuriyet''in ilk büyük sanayi yatırımlarından Merinos Yünlü Sanayi fabrikasının binasında yer alır. 1938''de üretime başlayan fabrika, Bursa''yı bir tekstil kentine dönüştüren yapılardandı.

Müzede fabrikanın tarihi makineleri, üretim aşamaları ve çalışanların hikâyeleri sergilenir; ipekböcekçiliğinden modern dokumaya Bursa''nın tekstil geçmişi anlatılır. Park içindeki Enerji Müzesi ve kongre merkeziyle birlikte gezilebilir.'),
  ('merinos-tekstil-sanayi-muzesi', 'en', 'The Textile Industry Museum in Merinos Park occupies the building of the Merinos woollen mill, one of the Republic''s first major industrial investments. The factory, which began production in 1938, was one of the places that turned Bursa into a textile city.

The museum displays the factory''s historic machinery, the stages of production and the stories of its workers, telling Bursa''s textile history from silkworm breeding to modern weaving. It can be visited together with the Energy Museum and the congress centre in the park.'),
  ('tofas-anadolu-araclari-muzesi', 'tr', 'Tofaş Anadolu Arabaları Müzesi, otomobil üreticisi Tofaş''ın kurduğu özel bir ulaşım müzesidir. Bursa''nın ipekçilik geçmişini hatırlatan eski bir ipek fabrikası binasında yer alır.

Müzede Anadolu''da kullanılan at arabaları, faytonlar, kağnılar ve çeşitli taşıtların yanında, Türkiye''de üretilen ve birçok ailenin hafızasında yer eden otomobiller sergilenir. Bahçesi ve sakin ortamıyla aileler için keyifli bir duraktır.'),
  ('tofas-anadolu-araclari-muzesi', 'en', 'The Tofaş Museum of Anatolian Carriages is a private transport museum founded by the car maker Tofaş. It occupies an old silk factory building, a reminder of Bursa''s silk-making past.

Horse-drawn carriages, phaetons, ox carts and other vehicles used in Anatolia are displayed alongside cars made in Turkey that many families remember. With its garden and quiet setting, it is a pleasant stop for families.'),
  ('17-yuzyil-osmanli-evi-muzesi', 'tr', 'Muradiye Külliyesi''nin karşısındaki Osmanlı Evi Müzesi, 17. yüzyıldan kalma üç katlı ahşap bir evde bulunur. Bursa''da bugün ayakta kalan en eski evlerden biridir.

Odalarda dönemin ev düzeni canlandırılmıştır; boyalı ahşap tavanlar, duvar dolapları, ocaklar ve cumbalı pencereler Osmanlı ev yaşamını gösterir. Küçük bir müzedir; Muradiye''nin türbeleri ve Uluumay Müzesi ile birlikte gezilir.'),
  ('17-yuzyil-osmanli-evi-muzesi', 'en', 'Opposite the Muradiye Complex, the Ottoman House Museum occupies a three-storey timber house from the 17th century. It is one of the oldest houses still standing in Bursa.

The rooms recreate the household arrangement of the period: painted wooden ceilings, built-in cupboards, fireplaces and bay windows show Ottoman domestic life. It is a small museum, visited together with the Muradiye tombs and the Uluumay Museum.')
  ) v(slug, lang, long_desc)
  join public.places p on p.slug = v.slug
 where t.place_id = p.id and t.lang = v.lang;
