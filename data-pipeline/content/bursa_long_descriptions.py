"""Bursa yerlerinin uzun açıklamaları (TR + EN). Kurallar istanbul_long_descriptions.py ile aynı:

  * Kendi cümlelerimiz; Vikipedi metni kopyalanmaz (results/bursa/wiki-extracts.json.gz yalnızca bilgi kontrolü için).
  * 2 paragraf: (1) ne olduğu ve kısa tarihçe, (2) ne görülmeli + pratik ipucu.
  * Sık değişen bilgi yok: bilet fiyatı, saat, telefon. Tartışmalı ya da doğrulanamayan sayı yazılmaz.
  * Paragraflar "\\n\\n" ile ayrılır.

LONG[slug] = (parti, tr, en). Parti numarası migration'ı belirler (build_long_desc.py --city bursa).
"""

LONG = {
    "bursa-ulu-camii": (1,
        "Bursa Ulu Camii, Sultan I. Bayezid (Yıldırım) tarafından Niğbolu zaferinin ardından yaptırıldı ve 1396-1400 "
        "yılları arasında tamamlandı. Rivayete göre sultan zafer için yirmi cami adamış, sonra bunun yerine yirmi "
        "kubbeli tek bir cami yaptırmıştır. Çok ayaklı cami tipinin en anıtsal örneğidir.\n\n"
        "İçeride, ortadaki kubbenin altında yer alan şadırvan, camiye ender rastlanan bir ferahlık katar. Duvarları "
        "ve ayakları süsleyen yüzlerce büyük hat levhası ve ince işçilikli ceviz minber görülmeye değer. Koza Han ve "
        "Kapalıçarşı hemen yanındadır; namaz vakitleri dışında, sessizce gezilmelidir.",
        "The Grand Mosque of Bursa was commissioned by Sultan Bayezid I (Yıldırım) after his victory at Nicopolis and "
        "completed between 1396 and 1400. Legend says the sultan vowed twenty mosques for the victory and instead built a "
        "single mosque with twenty domes. It is the most monumental example of the multi-pier mosque type.\n\n"
        "Inside, the ablution fountain beneath the central dome gives the mosque a rare sense of openness. The hundreds "
        "of large calligraphy panels on the walls and piers and the finely carved walnut pulpit are well worth seeing. "
        "The Koza Han and the Covered Bazaar are right next door; visit quietly outside prayer times."),

    "ayasofya-camii-iznik": (1,
        "İznik'in tam ortasında, surla çevrili kentin dört kapısından gelen yolların kesiştiği yerdeki Ayasofya, Bizans "
        "döneminde bir bazilika olarak yapıldı. 787'deki II. İznik Konsili bu kilisede toplandı. Orhan Gazi kenti "
        "aldıktan sonra camiye çevrildi; 16. yüzyılda Mimar Sinan tarafından onarıldı. Uzun süre müze olarak "
        "kullanıldıktan sonra 2011'de yeniden cami oldu.\n\n"
        "İçeride, apsis bölümünde Bizans dönemine ait fresk kalıntıları ve döşeme izleri görülebilir. Kentin "
        "Hristiyanlık tarihindeki önemini hissettiren bir yapıdır. Kent merkezinde olduğundan İznik Müzesi, Yeşil "
        "Cami ve surlarla birlikte yürüyerek gezilir.",
        "In the very centre of İznik, where the roads from the four gates of the walled city meet, Hagia Sophia was built "
        "as a basilica in the Byzantine period. The Second Council of Nicaea met in this church in 787. After Orhan Gazi "
        "took the city it was converted into a mosque, and in the 16th century it was repaired by the architect Sinan. "
        "Long used as a museum, it became a mosque again in 2011.\n\n"
        "Inside, remains of Byzantine frescoes and traces of the floor can be seen in the apse. It is a building that "
        "conveys the city's importance in Christian history. Being in the town centre, it is visited on foot together "
        "with the İznik Museum, the Green Mosque and the walls."),

    "emir-sultan-camii": (1,
        "Emir Sultan Camii, Yıldırım Bayezid'in kızı Hundi Fatma Hatun tarafından eşi, Buharalı âlim Emir Sultan adına "
        "15. yüzyılın başında yaptırıldı. Depremlerde zarar gören yapı 1804'te Sultan III. Selim döneminde, 1855 "
        "depreminden sonra da 1868'de yeniden inşa edildi; bugünkü Osmanlı barok görünümü bu dönemden kalır.\n\n"
        "Caminin yanındaki Emir Sultan Türbesi, Bursalıların en çok ziyaret ettiği manevi mekânlardandır; özellikle "
        "cuma günleri kalabalık olur. Avludan Bursa ovasına ve şehre güzel bir manzara açılır. Hemen arkasındaki tarihi "
        "mezarlık ve Yıldırım Camii aynı gezide görülebilir.",
        "The Emir Sultan Mosque was commissioned in the early 15th century by Hundi Fatma Hatun, daughter of Bayezid I, "
        "in the name of her husband, the Bukharan scholar Emir Sultan. Damaged by earthquakes, it was rebuilt in 1804 "
        "under Sultan Selim III and again in 1868 after the earthquake of 1855; its present Ottoman Baroque look dates "
        "from this period.\n\n"
        "The Tomb of Emir Sultan beside the mosque is one of the spiritual places most visited by the people of Bursa, "
        "and it gets busy especially on Fridays. The courtyard offers a fine view over the city and the plain. The "
        "historic cemetery behind it and the Yıldırım Mosque fit into the same visit."),

    "orhan-gazi-camii": (1,
        "Bursa'nın merkezindeki Orhan Gazi Camii, Orhan Gazi tarafından 1339-1340'ta bir külliyenin parçası olarak "
        "yaptırıldı ve kentin en eski Osmanlı yapılarındandır. 1413'te Karamanoğlu kuvvetlerince yakıldı; 1417'de "
        "Çelebi Mehmed tarafından onarıldı.\n\n"
        "Ters T planlı, yanlarında tabhane odaları bulunan yapı, erken Osmanlı cami mimarisini anlamak için iyi bir "
        "örnektir; giriş revakı ve taş-tuğla almaşık örgüsü dikkat çeker. Heykel'e, Koza Han'a ve Kapalıçarşı'ya "
        "yürüme mesafesindedir; çarşı gezisinin başında ya da sonunda görülebilir.",
        "The Orhan Gazi Mosque in central Bursa was founded by Orhan Gazi in 1339-1340 as part of a charitable complex "
        "and is one of the city's oldest Ottoman buildings. It was burned by Karamanid forces in 1413 and restored in "
        "1417 by Mehmed I.\n\n"
        "With its inverted-T plan and side rooms for travelling dervishes, it is a good example for understanding early "
        "Ottoman mosque architecture; note the entrance portico and the alternating courses of stone and brick. It is "
        "within walking distance of Heykel, the Koza Han and the Covered Bazaar, so it fits at the start or end of a "
        "bazaar walk."),

    "iznik-yesil-cami": (1,
        "İznik Yeşil Cami, Sultan I. Murad'ın sadrazamı Çandarlı Kara Halil Hayreddin Paşa tarafından yaptırılmaya "
        "başlandı; paşanın 1387'de ölmesi üzerine oğlu Çandarlı Ali Paşa tarafından tamamlandı. Erken Osmanlı "
        "mimarisinin en zarif örneklerinden sayılır.\n\n"
        "Adını, minaresini kaplayan yeşil-turkuaz çinilerden alır; bugün görülen çiniler sonraki onarımlarda "
        "yenilenmiştir. Mermer kaplı cephesi ve giriş revakındaki taş işçiliği yakından incelenmeye değer. İznik "
        "Müzesi'nin bulunduğu Nilüfer Hatun İmareti hemen karşısındadır.",
        "The Green Mosque of İznik was begun by Çandarlı Kara Halil Hayreddin Pasha, Grand Vizier of Sultan Murad I, and "
        "completed after his death in 1387 by his son Çandarlı Ali Pasha. It is counted among the most elegant examples "
        "of early Ottoman architecture.\n\n"
        "It takes its name from the green and turquoise tiles covering its minaret; the tiles seen today were renewed in "
        "later restorations. Its marble-clad façade and the stone carving of the entrance portico deserve a close look. "
        "The Nilüfer Hatun Soup Kitchen, home to the İznik Museum, is right opposite."),

    "fatih-camii-tirilye": (1,
        "Tirilye'deki Fatih Camii, ilk olarak 8. ya da 9. yüzyılda Bizans kilisesi olarak yapıldı ve Hagios Stephanos "
        "Kilisesi olarak bilinir. 16. yüzyılda camiye çevrildi; Kurtuluş Savaşı yıllarında kısa bir süre yeniden "
        "kilise olarak kullanıldı.\n\n"
        "Kubbeli küçük yapı, Tirilye'nin Bizans geçmişinin en iyi korunmuş izlerindendir; tuğla ve taş örgülü dış "
        "duvarlarına yakından bakın. Köyün taş sokakları, Kemerli Kilise ve sahildeki balık lokantalarıyla birlikte "
        "gezilir. Namaz vakitlerinde içeriyi gezmeyi erteleyin.",
        "The Fatih Mosque in Tirilye was originally built in the 8th or 9th century as a Byzantine church, known as the "
        "Church of St Stephen. It was converted into a mosque in the 16th century and was briefly used as a church again "
        "during the War of Independence years.\n\n"
        "The small domed building is one of the best-preserved traces of Tirilye's Byzantine past; take a close look at "
        "its brick-and-stone outer walls. It is visited together with the village's stone streets, the Arched Church and "
        "the fish restaurants on the shore. Avoid touring the interior during prayer times."),

    "veled-i-yanic-cami": (1,
        "Bursa'nın Hisar semtindeki Veled-i Yaniç (Yaniçoğlu) Camii, kapısı üzerindeki kitabeye göre Temmuz 1440'ta "
        "Mahmud Çelebi tarafından yaptırıldı. Banisi, I. Murad ve Yıldırım Bayezid dönemlerinde devlet hizmetinde "
        "bulunmuş, Ankara Savaşı'na katılmış sufi bir komutandı; caminin bahçesinde yattığı düşünülür.\n\n"
        "Kare planlı, sekizgen kubbeli bu küçük mescidin en ilginç yanı minaresidir: camiden yaklaşık on metre ötede, "
        "girişin karşısındaki bir çeşmenin üzerinde durur ve bir çan kulesini andırır. Hisar'ın tarihi sokaklarında, "
        "Osman Gazi ve Orhan Gazi türbelerine giderken kısa bir durak olarak görülebilir.",
        "According to the inscription over its door, the Veled-i Yaniç (Yaniçoğlu) Mosque in Bursa's Hisar quarter was "
        "built by Mahmud Çelebi in July 1440. Its founder was a Sufi commander who served the state under Murad I and "
        "Bayezid I and fought at the Battle of Ankara; he is believed to be buried in the mosque's garden.\n\n"
        "The most unusual feature of this small square mosque with its octagonal dome is its minaret: it stands about ten "
        "metres away, on top of a fountain opposite the entrance, and resembles a bell tower. It makes a short stop in "
        "the historic streets of Hisar on the way to the tombs of Osman Gazi and Orhan Gazi."),

    "yildirim-camii": (1,
        "Yıldırım Camii, Sultan I. Bayezid'in (Yıldırım) 1391-1395 yılları arasında yaptırdığı büyük külliyenin "
        "camisidir. Külliyede medrese, hamam, imaret, türbe ve Osmanlı'nın ilk darüşşifalarından (hastane) biri "
        "bulunuyordu; Yıldırım Bayezid'in türbesi de buradadır.\n\n"
        "Ters T planlı caminin beş kemerli giriş revakı ve mermer işçiliği, erken Osmanlı mimarisinin en olgun "
        "örneklerindendir. Şehir merkezinin doğusunda, bir tepenin üzerinde yer alır; buradan ovaya bakan manzara "
        "güzeldir. Emir Sultan Camii ile aynı gezide görülebilir.",
        "The Yıldırım Mosque is the mosque of the large complex built by Sultan Bayezid I (Yıldırım) between 1391 and "
        "1395. The complex included a madrasa, a bath, a soup kitchen, a tomb and one of the first Ottoman hospitals; "
        "Bayezid's own tomb is here too.\n\n"
        "The mosque's inverted-T plan, its five-arched entrance portico and its marble work are among the most mature "
        "examples of early Ottoman architecture. It stands on a hill east of the city centre with a fine view over the "
        "plain. It can be seen on the same outing as the Emir Sultan Mosque."),

    "bursa-muradiye-camii": (1,
        "Muradiye Külliyesi, Sultan II. Murad tarafından 15. yüzyılın ilk yarısında kuruldu; Bursa'da bir padişah adına "
        "yapılan son büyük külliyedir. Cami, medrese, hamam ve imaretin yanında, bahçesindeki türbelerle bir Osmanlı "
        "hanedan mezarlığına dönüşmüştür. 2014'te 'Bursa ve Cumalıkızık: Osmanlı İmparatorluğu'nun Doğuşu' adıyla "
        "UNESCO Dünya Mirası Listesi'ne alınan alanın parçasıdır.\n\n"
        "Selvi ve çınarların gölgesindeki bahçede II. Murad, Cem Sultan, Şehzade Mustafa ve sultan ailesinden pek çok "
        "kişinin türbeleri bulunur; II. Murad'ın vasiyetiyle türbesinin tepesi açık bırakılmıştır. Türbelerin "
        "bazılarındaki çiniler ve kalem işleri çok değerlidir. Karşısındaki Osmanlı Evi Müzesi aynı ziyarette "
        "görülür. İçindeki yapılar ayrıca işaretlenebilir.",
        "The Muradiye Complex was founded by Sultan Murad II in the first half of the 15th century and is the last great "
        "complex built in Bursa in a sultan's name. Besides the mosque, madrasa, bath and soup kitchen, the tombs in its "
        "garden have made it an Ottoman dynastic cemetery. It is part of the site added to the UNESCO World Heritage List "
        "in 2014 as 'Bursa and Cumalıkızık: the Birth of the Ottoman Empire'.\n\n"
        "In the garden shaded by cypresses and plane trees lie the tombs of Murad II, Cem Sultan, Prince Mustafa and many "
        "members of the imperial family; by Murad II's wish, the top of his tomb was left open to the sky. The tiles and "
        "painted decoration in some of the tombs are very fine. The Ottoman House Museum opposite fits into the same visit. "
        "The buildings inside can be checked off separately."),

    "yesil-camii": (1,
        "Yeşil Camii, Sultan I. Mehmed (Çelebi) tarafından yaptırıldı ve 1419'da ibadete açıldı. Mimarı Hacı İvaz "
        "Paşa'dır; iç mekândaki çinileri Tebrizli ustalar yaptı. Adını, bir zamanlar dış yüzeyini de kaplayan yeşil "
        "çinilerden alır. Bursa'nın simgelerinden olan Yeşil Külliye'nin merkezidir.\n\n"
        "Mihrap, hünkâr mahfili ve duvarları kaplayan yeşil-mavi çiniler, erken Osmanlı çini sanatının en güzel "
        "örneklerindendir; mermer kapı ve pencere çerçevelerindeki oymalar da etkileyicidir. Giriş revakı hiç "
        "tamamlanmamıştır. Hemen karşısındaki Yeşil Türbe ve çevredeki çay bahçeleriyle birlikte gezilir.",
        "The Green Mosque was built by Sultan Mehmed I (Çelebi) and opened for worship in 1419. Its architect was Hacı "
        "İvaz Pasha, and its tiles were made by craftsmen from Tabriz. It takes its name from the green tiles that once "
        "also covered its exterior. It is the centrepiece of the Green Complex, one of Bursa's symbols.\n\n"
        "The mihrab, the sultan's loge and the green and blue tiles covering the walls are among the finest examples of "
        "early Ottoman tilework, and the carving of the marble door and window frames is impressive too. The entrance "
        "portico was never completed. Visit it with the Green Tomb just opposite and the tea gardens around."),

    "eski-camii-golyazi": (1,
        "Gölyazı'nın içindeki Eski Cami, Uluabat Gölü'ne uzanan yarımadadaki bu balıkçı köyünün tarihi camisidir. "
        "Nüfus mübadelesinden önce Rum ve Türk ailelerin birlikte yaşadığı köyün çok kültürlü geçmişinin "
        "izlerinden biridir.\n\n"
        "Sade yapısıyla köy dokusuna uyum sağlar; çevresindeki dar sokaklar, taş ve ahşap evler ile göl kıyısı "
        "birlikte gezilir. Gölyazı'daki Aziz Panteleimon Kilisesi ve antik tiyatro kalıntıları kısa yürüyüş "
        "mesafesindedir.",
        "The Old Mosque in Gölyazı is the historic mosque of this fishing village on a peninsula reaching into Lake "
        "Uluabat. It is one of the traces of the multicultural past of the village, where Greek and Turkish families "
        "lived side by side before the population exchange.\n\n"
        "Its simple form fits the village fabric, and it is seen together with the narrow streets, stone and timber "
        "houses and lakeshore around it. The Church of St Panteleimon and the remains of the ancient theatre in Gölyazı "
        "are a short walk away."),

    "kemerli-kilise-tirilye": (1,
        "Tirilye'deki Kemerli Kilise, Meryem Ana'ya adanmış Panagia Pantobasilissa Kilisesi'dir; adı 'Her şeyin "
        "Kraliçesi Meryem' anlamına gelir. Bizans dönemine uzanan yapının adı, 1676'da gezgin John Covel'in yazdığı "
        "bir belgede geçer. Yerel halk ona giriş kemeri nedeniyle Kemerli Kilise der.\n\n"
        "Bugün harap durumda olsa da duvarlarındaki fresk kalıntıları ve kemerli girişi görülebilir. Köyün yukarı "
        "kesimindeki dar sokaklarda yer alır; Fatih Camii ve Tirilye'nin taş evleriyle birlikte bir köy yürüyüşüne "
        "eklenebilir. Kalıntılara zarar vermeden dışarıdan bakın.",
        "The Arched Church in Tirilye is the Church of Panagia Pantobasilissa, dedicated to Mary; the name means "
        "'Mary, Queen of All'. Its name appears in a document written by the traveller John Covel in 1676 for this "
        "building of Byzantine origin. Locals call it the Arched Church because of its entrance arch.\n\n"
        "Although in ruins today, its entrance arch and remains of frescoes on its walls can still be seen. It stands in "
        "the narrow streets of the upper village and can be added to a village walk with the Fatih Mosque and Tirilye's "
        "stone houses. Look from outside without damaging the remains."),

    "aziz-panteleimon-kilisesi": (1,
        "Gölyazı'daki Aziz Panteleimon Kilisesi, 19. yüzyılda köyün Rum Ortodoks topluluğu için yapıldı. 1923 nüfus "
        "mübadelesinden sonra ibadete kapandı ve uzun süre farklı amaçlarla kullanıldı.\n\n"
        "Taş duvarları ve göl kıyısındaki konumuyla Gölyazı'nın en dikkat çekici yapılarındandır. Köyün dar "
        "sokaklarında, Eski Cami'den birkaç dakikalık yürüyüşle ulaşılır. Gölyazı'nın gün batımı ve leylek "
        "yuvalarıyla birlikte yarım günlük bir gezi için uygundur.",
        "The Church of St Panteleimon in Gölyazı was built in the 19th century for the village's Greek Orthodox "
        "community. Closed to worship after the 1923 population exchange, it was used for other purposes for a long time.\n\n"
        "With its stone walls and lakeside setting, it is one of the most striking buildings in Gölyazı. It is a few "
        "minutes' walk from the Old Mosque through the village's narrow streets, and suits a half-day trip together with "
        "Gölyazı's sunsets and stork nests."),

    "mayor-sinagogu": (1,
        "Bursa'nın tarihi Yahudi mahallesinde, Arap Şükrü (Sakarya) Sokağı'ndaki Mayor Sinagogu, Mayorka Adası'ndan "
        "sürülerek Osmanlı topraklarına yerleşen Yahudiler tarafından kuruldu; adını da buradan alır. Bugünkü yapının "
        "15. ya da 16. yüzyıldan kaldığı düşünülür.\n\n"
        "Sinagog bugün düzenli ibadete kapalıdır; aynı sokaktaki Geruş Sinagogu ise kullanılmaya devam eder. Arap "
        "Şükrü Sokağı akşamları meyhaneleri ve balıkçılarıyla Bursa'nın en canlı köşelerinden biridir. Sinagogun "
        "içini görmek için önceden topluluk aracılığıyla izin almak gerekir.",
        "In Bursa's historic Jewish quarter, on Arap Şükrü (Sakarya) Street, the Mayor Synagogue was founded by Jews "
        "expelled from the island of Majorca who settled in Ottoman lands, and takes its name from there. The present "
        "building is thought to date from the 15th or 16th century.\n\n"
        "The synagogue is no longer used for regular worship, while the Gerush Synagogue on the same street remains in "
        "use. In the evenings, Arap Şükrü Street, with its taverns and fishmongers, is one of the liveliest corners of "
        "Bursa. To see the interior, permission must be obtained in advance through the community."),

    "bursa-arkeoloji-muzesi": (1,
        "Bursa Arkeoloji Müzesi, 1900'lerin başında İstanbul Arkeoloji Müzesi'ne bağlı bir şube olarak kuruldu ve "
        "1970'lerde Kültürpark'taki bugünkü binasına taşındı. Antik Bithynia ve Mysia bölgelerinden, MÖ 3000'den Bizans "
        "döneminin sonuna kadar uzanan eserleri sergiler.\n\n"
        "Heykeller, mezar stelleri, cam ve seramik eserler, sikke ve takılar ile bahçede sergilenen lahitler ve mimari "
        "parçalar görülebilir. Kültürpark'ın yeşil alanı içinde olduğundan müze ziyaretini bir park yürüyüşüyle "
        "birleştirmek kolaydır.",
        "The Bursa Archaeological Museum was founded in the early 1900s as a branch of the Istanbul Archaeological Museum "
        "and moved to its present building in Kültürpark in the 1970s. It displays finds from the ancient regions of "
        "Bithynia and Mysia, from 3000 BC to the end of the Byzantine period.\n\n"
        "Sculptures, grave stelae, glass and pottery, coins and jewellery are on show, with sarcophagi and architectural "
        "pieces displayed in the garden. As it sits within the green space of Kültürpark, a museum visit combines easily "
        "with a walk in the park."),

    "bursa-ataturk-muzesi": (1,
        "Çekirge Caddesi üzerindeki Bursa Atatürk Müzesi, 1890'larda yapılmış üç katlı bir köşkte bulunur. Atatürk "
        "Bursa'ya geldiğinde bu köşkte kaldı; köşk sonradan müzeye dönüştürüldü.\n\n"
        "Odalarda dönemin mobilyaları, Atatürk'ün kullandığı eşyalar ve fotoğraflar sergilenir. Bahçesi ve sakin "
        "atmosferiyle kısa bir ziyaret için uygundur. Çekirge'nin tarihi kaplıcaları ve I. Murad Hüdavendigar "
        "Külliyesi yakındadır.",
        "On Çekirge Street, the Bursa Atatürk Museum is housed in a three-storey mansion built in the 1890s. Atatürk "
        "stayed in this mansion on his visits to Bursa, and it was later turned into a museum.\n\n"
        "The rooms display period furniture, Atatürk's belongings and photographs. With its garden and calm atmosphere it "
        "suits a short visit. Çekirge's historic thermal baths and the Murad I Hüdavendigar Complex are nearby."),

    "mudanya-mutareke-evi": (1,
        "Mudanya'daki Mütareke Evi, Kurtuluş Savaşı'nın silahlı aşamasını sona erdiren Mudanya Ateşkesi'nin Ekim "
        "1922'de imzalandığı yapıdır. Ev, Rus asıllı tüccar Aleksandr Ganyanof'a aitti; sonradan Mudanyalı iş insanı "
        "Hayri İpar tarafından satın alınıp onarıldı ve müze olarak düzenlendi.\n\n"
        "İki katlı taş yapıda görüşmelerin yapıldığı oda, dönemin belgeleri, fotoğrafları ve eşyaları sergilenir. "
        "Sahile yakın olduğundan Mudanya'nın tarihi sokakları, sahil yolu ve eski tren istasyonu binalarıyla birlikte "
        "gezilebilir.",
        "The Armistice House in Mudanya is where the Armistice of Mudanya, which ended the armed phase of the Turkish "
        "War of Independence, was signed in October 1922. The house belonged to the Russian-born merchant Aleksandr "
        "Ganyanof; it was later bought and restored by the Mudanya businessman Hayri İpar and arranged as a museum.\n\n"
        "The two-storey stone building displays the room where the talks were held, along with documents, photographs "
        "and objects from the period. Being close to the shore, it can be combined with Mudanya's historic streets, "
        "seafront and old railway station buildings."),

    "iznik-muzesi": (1,
        "İznik Müzesi, 1935'te kuruldu ve 1960'tan beri Nilüfer Hatun İmareti'nde hizmet verir. İmaret, Sultan I. "
        "Murad tarafından annesi Nilüfer Hatun adına 14. yüzyılın sonunda yaptırıldı. Yapı kapsamlı bir "
        "restorasyonun ardından yeniden ziyarete açıldı.\n\n"
        "Müzede İznik ve çevresinden çıkan arkeolojik eserlerin yanında, kente dünya çapında ün kazandıran İznik "
        "çinilerinin ve seramiklerinin örnekleri sergilenir. Yapının kendisi de erken Osmanlı mimarisinin güzel bir "
        "örneğidir. Yeşil Cami'nin hemen karşısındadır.",
        "The İznik Museum was founded in 1935 and has occupied the Nilüfer Hatun Soup Kitchen since 1960. The building "
        "was commissioned by Sultan Murad I in the late 14th century in the name of his mother, Nilüfer Hatun. It reopened "
        "after a thorough restoration.\n\n"
        "Alongside archaeological finds from İznik and its surroundings, the museum shows examples of the İznik tiles and "
        "ceramics that brought the town worldwide fame. The building itself is a fine example of early Ottoman "
        "architecture. It stands right opposite the Green Mosque."),

    "bursa-kent-muzesi": (1,
        "Heykel'deki Bursa Kent Müzesi, 2004'ten beri kentin eski adliye binasında hizmet verir. Bursa'nın binlerce "
        "yıllık tarihini, kuruluşundan Osmanlı başkentliğine ve Cumhuriyet dönemine kadar anlatır.\n\n"
        "Bölümlerde kentin tarihi, ünlü Bursalılar, gelenekler ve yöresel giysiler yer alır; bodrum katta canlandırılmış "
        "zanaatkâr dükkânları, ipekçilik ve bıçakçılık gibi Bursa'ya özgü meslekleri gösterir. Şehir gezisine "
        "başlamadan önce uğramak, Bursa'yı tanımak için iyi bir yoldur. Atatürk Anıtı ve Koza Parkı hemen yanındadır.",
        "The Bursa City Museum in Heykel has occupied the city's old courthouse since 2004. It tells Bursa's history "
        "over thousands of years, from its founding through its time as the Ottoman capital to the Republic.\n\n"
        "Sections cover the city's history, famous people of Bursa, traditions and local costumes; on the lower floor, "
        "recreated craftsmen's shops show trades typical of Bursa such as silk-making and knife-making. Stopping here "
        "before exploring the city is a good way to get to know Bursa. The Atatürk Monument and Koza Park are right beside it."),

    "uluumay-osmanli-halk-kiyafetleri-ve-takilari-muzesi": (1,
        "Muradiye semtindeki Uluumay Müzesi, halk bilimci ve koleksiyoncu Esat Uluumay'ın yıllar içinde topladığı "
        "Osmanlı halk kıyafetleri ve takı koleksiyonunu sergiler. UNESCO listesindeki Muradiye Külliyesi'nin hemen "
        "yakınında, tarihi bir yapıda yer alır.\n\n"
        "Anadolu ve Balkanlar'ın farklı bölgelerine ait gelin kıyafetleri, işlemeli giysiler, gümüş takılar ve "
        "aksesuarlar yerel kültürün zenginliğini gösterir. Küçük ama özenli bir müzedir; Muradiye ve Osmanlı Evi "
        "Müzesi ile aynı gezide görülebilir.",
        "The Uluumay Museum in the Muradiye quarter displays the collection of Ottoman folk costumes and jewellery "
        "gathered over the years by the folklorist and collector Esat Uluumay. It occupies a historic building close to "
        "the Muradiye Complex, which is on the UNESCO list.\n\n"
        "Bridal costumes, embroidered garments, silver jewellery and accessories from different parts of Anatolia and the "
        "Balkans show the richness of local culture. It is a small but carefully arranged museum, and can be seen on the "
        "same visit as the Muradiye and the Ottoman House Museum."),

    "panorama-1326-bursa-fetih-muzesi": (1,
        "Tophane'deki Panorama 1326 Bursa Fetih Müzesi, Bursa'nın 1326'da Orhan Gazi tarafından alınışını ve Osmanlı'nın "
        "kuruluş dönemini anlatan panoramik bir müzedir. Bir kent parkına dönüştürülen alanda yer alır.\n\n"
        "Müzenin merkezinde, izleyiciyi kuşatma sahnesinin ortasına yerleştiren 360 derecelik dev bir panorama resmi "
        "bulunur; ön plandaki maketler ve ses efektleriyle sahne canlanır. Çocuklu aileler için ilgi çekicidir. "
        "Tophane Saat Kulesi ve Osman Gazi-Orhan Gazi türbeleri yürüme mesafesindedir.",
        "The Panorama 1326 Conquest Museum in Tophane tells the story of Orhan Gazi's capture of Bursa in 1326 and the "
        "founding era of the Ottoman state. It stands in an area turned into a city park.\n\n"
        "At its heart is a huge 360-degree panoramic painting that places the viewer in the middle of the siege, brought "
        "to life by models in the foreground and sound effects. It appeals to families with children. The Tophane Clock "
        "Tower and the tombs of Osman Gazi and Orhan Gazi are within walking distance."),

    "merinos-tekstil-sanayi-muzesi": (1,
        "Merinos Parkı'ndaki Tekstil Sanayi Müzesi, Cumhuriyet'in ilk büyük sanayi yatırımlarından Merinos Yünlü "
        "Sanayi fabrikasının binasında yer alır. 1938'de üretime başlayan fabrika, Bursa'yı bir tekstil kentine "
        "dönüştüren yapılardandı.\n\n"
        "Müzede fabrikanın tarihi makineleri, üretim aşamaları ve çalışanların hikâyeleri sergilenir; ipekböcekçiliğinden "
        "modern dokumaya Bursa'nın tekstil geçmişi anlatılır. Park içindeki Enerji Müzesi ve kongre merkeziyle birlikte "
        "gezilebilir.",
        "The Textile Industry Museum in Merinos Park occupies the building of the Merinos woollen mill, one of the "
        "Republic's first major industrial investments. The factory, which began production in 1938, was one of the "
        "places that turned Bursa into a textile city.\n\n"
        "The museum displays the factory's historic machinery, the stages of production and the stories of its workers, "
        "telling Bursa's textile history from silkworm breeding to modern weaving. It can be visited together with the "
        "Energy Museum and the congress centre in the park."),

    "tofas-anadolu-araclari-muzesi": (1,
        "Tofaş Anadolu Arabaları Müzesi, otomobil üreticisi Tofaş'ın kurduğu özel bir ulaşım müzesidir. Bursa'nın "
        "ipekçilik geçmişini hatırlatan eski bir ipek fabrikası binasında yer alır.\n\n"
        "Müzede Anadolu'da kullanılan at arabaları, faytonlar, kağnılar ve çeşitli taşıtların yanında, Türkiye'de "
        "üretilen ve birçok ailenin hafızasında yer eden otomobiller sergilenir. Bahçesi ve sakin ortamıyla aileler "
        "için keyifli bir duraktır.",
        "The Tofaş Museum of Anatolian Carriages is a private transport museum founded by the car maker Tofaş. It occupies "
        "an old silk factory building, a reminder of Bursa's silk-making past.\n\n"
        "Horse-drawn carriages, phaetons, ox carts and other vehicles used in Anatolia are displayed alongside cars made "
        "in Turkey that many families remember. With its garden and quiet setting, it is a pleasant stop for families."),

    "17-yuzyil-osmanli-evi-muzesi": (1,
        "Muradiye Külliyesi'nin karşısındaki Osmanlı Evi Müzesi, 17. yüzyıldan kalma üç katlı ahşap bir evde bulunur. "
        "Bursa'da bugün ayakta kalan en eski evlerden biridir.\n\n"
        "Odalarda dönemin ev düzeni canlandırılmıştır; boyalı ahşap tavanlar, duvar dolapları, ocaklar ve cumbalı "
        "pencereler Osmanlı ev yaşamını gösterir. Küçük bir müzedir; Muradiye'nin türbeleri ve Uluumay Müzesi ile "
        "birlikte gezilir.",
        "Opposite the Muradiye Complex, the Ottoman House Museum occupies a three-storey timber house from the 17th "
        "century. It is one of the oldest houses still standing in Bursa.\n\n"
        "The rooms recreate the household arrangement of the period: painted wooden ceilings, built-in cupboards, "
        "fireplaces and bay windows show Ottoman domestic life. It is a small museum, visited together with the Muradiye "
        "tombs and the Uluumay Museum."),

    "cumalikizik-etnografya-muzesi": (2,
        "Cumalıkızık'ın içindeki küçük Etnografya Müzesi, köyün geleneksel evlerinden birinde düzenlenmiştir. Köy "
        "halkının yüzyıllar boyunca kullandığı ev eşyaları, tarım aletleri, giysiler ve el işleri burada sergilenir.\n\n"
        "Köyün taş döşeli sokaklarında yürürken uğranabilecek kısa bir duraktır; evin iç düzeni, Cumalıkızık "
        "evlerinin içinde hayatın nasıl geçtiğini gösterir. Köy kahvaltısı ve ahududu reçeli molasıyla birlikte "
        "gezinin parçası olarak düşünün.",
        "The small Ethnography Museum in Cumalıkızık is set up in one of the village's traditional houses. Household "
        "objects, farming tools, clothing and handicrafts used by the villagers over the centuries are on display.\n\n"
        "It is a short stop while walking the village's cobbled streets, and the layout of the house shows how life went "
        "on inside Cumalıkızık's homes. Think of it as part of a visit that includes a village breakfast and raspberry jam."),

    "karagoz-muzesi": (2,
        "Çekirge Caddesi'ndeki Karagöz Müzesi, 2007'de Bursa Büyükşehir Belediyesi tarafından açıldı ve Türkiye'nin ilk "
        "Karagöz müzesidir. Gölge oyununun Bursa'da doğduğu anlatılır; müze bu geleneği yaşatmak için kuruldu.\n\n"
        "Deveden yapılmış renkli tasvirler, perdeler, oyun metinleri ve dünyanın farklı ülkelerinden gölge oyunu "
        "figürleri sergilenir; zaman zaman Karagöz gösterileri ve atölyeler düzenlenir. Çocuklarla gelinecek keyifli "
        "bir müzedir. Hemen karşısında Hacivat ve Karagöz Anıt Mezarı bulunur.",
        "The Karagöz Museum on Çekirge Street was opened in 2007 by Bursa Metropolitan Municipality and is Turkey's first "
        "museum devoted to Karagöz. Shadow theatre is said to have been born in Bursa, and the museum was founded to keep "
        "the tradition alive.\n\n"
        "Colourful figures made of camel hide, screens, play texts and shadow puppets from other countries are on display, "
        "and Karagöz performances and workshops are held from time to time. It is a fun museum to visit with children. "
        "The Monumental Tomb of Hacivat and Karagöz stands right opposite."),

    "merinos-enerji-muzesi": (2,
        "Merinos Parkı'ndaki Enerji Müzesi, 2012'de eski Merinos fabrikasının elektrik santralinde açıldı. Fabrikaya "
        "uzun yıllar enerji sağlayan buhar kazanları, türbinler ve jeneratörler yerinde korunmuştur.\n\n"
        "Dev makinelerin arasında yürürken bir dönemin sanayi teknolojisini yakından görürsünüz; enerjinin nasıl "
        "üretildiğini anlatan bölümler özellikle öğrenciler için öğreticidir. Park içindeki Tekstil Sanayi Müzesi ile "
        "birlikte gezilir.",
        "The Energy Museum in Merinos Park opened in 2012 in the old power plant of the Merinos factory. The steam boilers, "
        "turbines and generators that powered the factory for many years are preserved in place.\n\n"
        "Walking among the huge machines you see the industrial technology of an era up close, and the sections "
        "explaining how energy was produced are especially instructive for students. It is visited together with the "
        "Textile Industry Museum in the park."),

    "iznik-surlari": (2,
        "İznik'i çevreleyen surlar, antik Nikaia kentinin Helenistik dönemde başlayıp Roma ve Bizans dönemlerinde "
        "yeniden yapılan savunma duvarlarıdır. Yaklaşık beş kilometre uzunluğundaki surlar, dört ana kapısı ve çok "
        "sayıda kulesiyle Anadolu'nun en iyi korunmuş antik kent surlarındandır.\n\n"
        "İstanbul Kapı, Lefke Kapı, Yenişehir Kapı ve Göl Kapı en çok görülen bölümlerdir; İstanbul Kapı'daki Roma "
        "dönemi kabartmaları ilgi çeker. Surların bir bölümü boyunca yürüyebilir ya da bisikletle kent çevresini "
        "dolaşabilirsiniz. Kentin dört kapısını birbirine bağlayan caddeler merkezde Ayasofya'da kesişir.",
        "The walls around İznik are the defences of ancient Nicaea, begun in the Hellenistic period and rebuilt under the "
        "Romans and Byzantines. About five kilometres long, with four main gates and many towers, they are among the "
        "best-preserved ancient city walls in Anatolia.\n\n"
        "The İstanbul Gate, Lefke Gate, Yenişehir Gate and Lake Gate are the most visited parts; the Roman-era reliefs at "
        "the İstanbul Gate draw attention. You can walk along part of the walls or cycle around the town. The streets "
        "linking the four gates meet in the centre at Hagia Sophia."),

    "tophane-saat-kulesi": (2,
        "Tophane Parkı'ndaki saat kulesi, Sultan II. Abdülhamid'in tahta çıkışının yıl dönümü şerefine 20. yüzyılın "
        "başında yapıldı. Altı katlı ve yaklaşık 33 metre yüksekliğindeki kule, aynı yerde daha önce bulunan bir saat "
        "kulesinin yerini aldı ve uzun süre yangın gözetleme kulesi olarak kullanıldı.\n\n"
        "Kulenin bulunduğu Tophane sırtı, şehrin ve ovanın en güzel manzaralarından birini sunar. Hemen yanında Osman "
        "Gazi ve Orhan Gazi'nin türbeleri yer alır; Hisar'ın tarihi sokakları ve Panorama 1326 Müzesi de yürüme "
        "mesafesindedir. Gün batımında park özellikle güzeldir.",
        "The clock tower in Tophane Park was built in the early 20th century to mark an anniversary of Sultan Abdülhamid "
        "II's accession. Six storeys and about 33 metres high, it replaced an earlier clock tower on the same spot and was "
        "long used as a fire lookout.\n\n"
        "The Tophane ridge where it stands offers one of the finest views of the city and the plain. The tombs of Osman "
        "Gazi and Orhan Gazi are right next to it, and the historic streets of Hisar and the Panorama 1326 Museum are "
        "within walking distance. The park is especially lovely at sunset."),

    "koza-hani": (2,
        "Koza Han, 1490'larda Sultan II. Bayezid tarafından, İstanbul'daki külliyesine gelir sağlamak amacıyla "
        "yaptırıldı. Mimarı Abdülula bin Pulat Şah'tır. Adını ipek kozası ticaretinden alır; Bursa ipekçiliğinin "
        "yüzyıllar boyunca merkezi oldu ve bugün de yaz başında koza pazarı burada kurulur.\n\n"
        "İki katlı hanın avlusunun ortasında, sekizgen bir şadırvanın üzerinde yükselen küçük mescit en ünlü "
        "ayrıntısıdır. Avludaki çay bahçesinde oturup ipek eşarp ve kumaş satan dükkânları gezebilirsiniz. Ulu Cami, "
        "Orhan Gazi Camii ve Kapalıçarşı birkaç adım ötededir.",
        "The Koza Han was built in the 1490s by Sultan Bayezid II to provide income for his complex in Istanbul. Its "
        "architect was Abdülula bin Pulat Şah. Named after the silk cocoon trade, it was the centre of Bursa's silk "
        "industry for centuries, and the cocoon market is still held here in early summer.\n\n"
        "Its most famous feature is the small mosque raised on an octagonal fountain in the middle of the courtyard of "
        "the two-storey han. Sit in the courtyard tea garden and browse the shops selling silk scarves and fabrics. The "
        "Grand Mosque, the Orhan Gazi Mosque and the Covered Bazaar are a few steps away."),

    "bursa-ataturk-aniti": (2,
        "Heykel semtine adını veren Bursa Atatürk Anıtı, heykeltıraş Nijat Sirel'in eseridir ve 1931'de eski Hükümet "
        "Meydanı'na dikildi. Mermer bir kaide üzerinde, asker giysileri içinde at üzerindeki Atatürk'ü gösteren bronz "
        "bir heykeldir.\n\n"
        "Anıt, Bursa'nın en bilinen buluşma noktalarından birinin ortasında durur; ulusal bayramlardaki törenler "
        "burada yapılır. Bursa Kent Müzesi ve Koza Parkı hemen yanındadır; tarihi çarşıya buradan yürüyerek "
        "inilebilir.",
        "The Bursa Atatürk Monument, which gave the Heykel ('Statue') district its name, is the work of the sculptor Nijat "
        "Sirel and was erected on the old Government Square in 1931. It is a bronze statue of Atatürk on horseback in "
        "military uniform, set on a marble pedestal.\n\n"
        "The monument stands in the middle of one of Bursa's best-known meeting points, and ceremonies on national "
        "holidays are held here. The Bursa City Museum and Koza Park are right beside it, and you can walk down to the "
        "historic bazaar from here."),

    "iznik-dikilitas": (2,
        "İznik'e bağlı Elbeyli köyü yakınlarındaki Dikilitaş, Roma döneminde Gaius Cassius Philiscus adına dikilmiş "
        "bir anıt mezardır; Beştaş ya da Nişantaşı olarak da anılır. Antik çağda Nikaia (İznik) ile Nikomedia (İzmit) "
        "arasındaki Roma yolunun kenarında yer alıyordu.\n\n"
        "Zeytinliklerin ortasında yükselen dikilitaş biçimindeki anıt ve kaidesindeki yazıt görülebilir. Kısa bir "
        "ziyaret için uygundur; İznik merkezinden birkaç kilometrelik bir sürüşle ulaşılır ve kent surları gezisine "
        "eklenebilir.",
        "Near the village of Elbeyli in İznik district, the Obelisk is a Roman funerary monument raised for Gaius Cassius "
        "Philiscus; it is also known as Beştaş or Nişantaşı. In antiquity it stood beside the Roman road between Nicaea "
        "(İznik) and Nicomedia (İzmit).\n\n"
        "You can see the obelisk-shaped monument rising among olive groves and the inscription on its base. It suits a "
        "short visit, a few kilometres' drive from central İznik, and can be added to a tour of the town walls."),

    "emir-han": (2,
        "Ulu Cami'nin hemen yanındaki Emir Han, Bey Hanı olarak da bilinir ve Orhan Gazi döneminde, 14. yüzyılda "
        "yaptırıldı. Bursa'nın Osmanlı dönemindeki ticaret merkezini oluşturan hanlar bölgesinin en eski yapılarından "
        "biridir.\n\n"
        "İki katlı hanın avlusu, çevresindeki kemerli dükkânlar ve odalarla eski kervansaray düzenini yansıtır. "
        "Kapalıçarşı, Koza Han ve Ulu Cami ile aynı yürüyüşte, birbirine birkaç adım mesafede görülür.",
        "Right beside the Grand Mosque, the Emir Han, also known as the Bey Han, was built in the 14th century under "
        "Orhan Gazi. It is one of the oldest buildings in the han district that formed Bursa's commercial centre in "
        "Ottoman times.\n\n"
        "The courtyard of the two-storey han, with arcaded shops and rooms around it, reflects the layout of an old "
        "caravanserai. It is seen on the same walk as the Covered Bazaar, the Koza Han and the Grand Mosque, all a few "
        "steps apart."),

    "bursa-kapalicarsi": (2,
        "Bursa Kapalıçarşı, 14. yüzyılın sonunda Yıldırım Bayezid'in yaptırdığı Bedesten çevresinde gelişti. 1855 "
        "depremi ve yangınında büyük zarar gören çarşı yeniden yapıldı; Koza Han, Emir Han, Tuz Hanı ve Geyve Hanı gibi "
        "hanlarla birlikte yüzyıllardır kentin ticaret merkezidir.\n\n"
        "Bedesten'de kuyumcular ve antikacılar, çevredeki sokaklarda ipek, havlu, bıçak ve kestane şekeri satan "
        "dükkânlar bulunur. Hanların avlularındaki çay bahçeleri mola vermek için idealdir. Pazar günleri dükkânların "
        "çoğu kapalıdır. İçindeki hanlar ayrıca işaretlenebilir.",
        "Bursa's Covered Bazaar grew up around the Bedesten built by Bayezid I at the end of the 14th century. Badly "
        "damaged in the earthquake and fire of 1855, it was rebuilt, and together with hans such as the Koza Han, Emir "
        "Han, Tuz Han and Geyve Han it has been the city's commercial heart for centuries.\n\n"
        "Jewellers and antique dealers fill the Bedesten, while the streets around it have shops selling silk, towels, "
        "knives and candied chestnuts. The tea gardens in the han courtyards are ideal for a break. Most shops close on "
        "Sundays. The hans inside can be checked off separately."),

    "irgandi-koprusu": (2,
        "Gökdere üzerindeki Irgandı Köprüsü, 1442'de Irgandılı Ali'nin oğlu Hacı Muslihiddin tarafından yaptırıldı. "
        "Üzerinde iki sıra dükkân bulunan, dünyada sayılı örneği kalmış çarşılı köprülerdendir. 1855 depreminde zarar "
        "gördü, Kurtuluş Savaşı sırasında büyük ölçüde yıkıldı; 2000'lerde aslına uygun olarak yeniden yapıldı.\n\n"
        "Bugün köprünün üzerindeki dükkânlarda el sanatı ustaları çalışır; çini, ahşap, cam ve keçe ürünlerini "
        "yapılırken izleyebilirsiniz. Çarşı bölgesinden Yeşil Camii'ye yürürken yol üzerindedir.",
        "Irgandı Bridge over the Gökdere was built in 1442 by Hacı Muslihiddin, son of Ali of Irgandı. With two rows of "
        "shops on top, it is one of the few surviving bridges in the world to carry a bazaar. Damaged in the 1855 "
        "earthquake and largely destroyed during the War of Independence, it was faithfully rebuilt in the 2000s.\n\n"
        "Today craftspeople work in the shops on the bridge, and you can watch tiles, woodwork, glass and felt being made. "
        "It lies on the way from the bazaar district to the Green Mosque."),

    "tuz-han-bursa": (2,
        "Kapalıçarşı bölgesindeki Tuz Hanı, 1454'te Timurtaş Paşa'nın oğlu Umur Bey tarafından yaptırıldı ve Umur "
        "Bey'in Bursa'daki külliyesine gelir sağlamak üzere vakfedildi. Adını, burada yapılan tuz ticaretinden alır.\n\n"
        "Kesme taş ve tuğla ile örülmüş duvarları ve avlu düzeni, erken Osmanlı ticaret yapılarının özelliklerini "
        "taşır. Çarşının işlek sokakları arasında, diğer hanlarla birlikte kısa bir durak olarak görülebilir.",
        "The Tuz Han (Salt Han) in the Covered Bazaar district was built in 1454 by Umur Bey, son of Timurtaş Pasha, and "
        "endowed to provide income for Umur Bey's complex in Bursa. It takes its name from the salt trade carried on here.\n\n"
        "Its walls of cut stone and brick and its courtyard layout show the features of early Ottoman commercial "
        "buildings. It can be seen as a short stop among the busy streets of the bazaar, together with the other hans."),

    "geyve-han": (2,
        "Kapalıçarşı'daki Geyve Hanı, 15. yüzyılda Hacı İvaz Paşa tarafından Yeşil Camii'ye gelir sağlamak amacıyla "
        "yaptırıldı ve Sultan Çelebi Mehmed'e armağan edildi. Hacı İvaz Paşa, Yeşil Camii'nin de mimarıydı.\n\n"
        "Avlusunu çevreleyen kemerli dükkânlarıyla klasik bir Osmanlı hanıdır; bugün de esnafın çalıştığı canlı bir "
        "ticaret yeridir. Bedesten ve Koza Han ile birlikte çarşı gezisinin parçası olarak görülebilir.",
        "The Geyve Han in the Covered Bazaar was built in the 15th century by Hacı İvaz Pasha to provide income for the "
        "Green Mosque, and was presented to Sultan Mehmed I. Hacı İvaz Pasha was also the architect of the Green Mosque.\n\n"
        "With arcaded shops around its courtyard it is a classic Ottoman han, and it remains a lively place of trade where "
        "shopkeepers still work. It can be seen as part of a bazaar walk with the Bedesten and the Koza Han."),

    "iznik-konsil": (2,
        "İznik Gölü'nde, kıyıdan kısa bir mesafede su altında kalan bu Bizans bazilikası, 2014'te havadan çekilen "
        "fotoğraflarla fark edildi. 4. yüzyıla tarihlenen yapının, bir şehit anısına inşa edilmiş bir kilise olduğu "
        "düşünülür; bazı araştırmacılar onu 325'te İznik'te toplanan I. Ekümenik Konsil ile ilişkilendirir, ancak bu "
        "kesin değildir.\n\n"
        "Göl suları çekildiğinde ya da durgun ve berrak olduğunda bazilikanın duvarları kıyıdan görülebilir. Kazı ve "
        "koruma çalışmaları sürdüğü için alana girmeyin; kıyıdaki yürüyüş yolundan izleyin. İznik'in göl kıyısındaki "
        "gün batımıyla birlikte görmek güzeldir.",
        "Lying under the waters of Lake İznik a short distance from the shore, this Byzantine basilica was noticed in "
        "aerial photographs in 2014. Dated to the 4th century, it is thought to have been a church built in memory of a "
        "martyr; some researchers link it to the First Ecumenical Council held in Nicaea in 325, though this is not certain.\n\n"
        "When the lake level drops, or the water is calm and clear, the basilica's walls can be seen from the shore. As "
        "excavation and conservation work continues, do not enter the site; watch from the lakeside path. It is lovely "
        "to see together with the sunset over the lake at İznik."),

    "iznik-roma-tiyatrosu": (2,
        "İznik Roma Tiyatrosu, MS 2. yüzyılda, İmparator Traianus döneminde Bithynia valisi olan Genç Plinius'un "
        "girişimiyle yapıldı. Plinius'un imparatora yazdığı mektuplarda, tiyatronun yapımındaki sorunlardan söz "
        "edilir.\n\n"
        "Kazılarla ortaya çıkarılan oturma sıraları, tonozlu koridorlar ve sahne binasının kalıntıları görülebilir; "
        "tiyatro sonraki dönemlerde başka yapılar için de kullanılmıştır. Kent merkezine yakındır ve surlarla birlikte "
        "yürüyerek gezilebilir.",
        "The Roman Theatre of İznik was built in the 2nd century AD on the initiative of Pliny the Younger, governor of "
        "Bithynia under the Emperor Trajan. Pliny's letters to the emperor mention the problems encountered in its "
        "construction.\n\n"
        "Excavations have revealed rows of seats, vaulted corridors and remains of the stage building; the theatre was "
        "also used for other structures in later periods. It is close to the town centre and can be visited on foot "
        "together with the walls."),

    "aktopraklik-hoyugu": (2,
        "Bursa'nın yaklaşık 25 km güneybatısında, Akçalar'daki Aktopraklık Höyüğü, Uluabat Gölü'nün doğu kıyısına yakın "
        "bir yerleşim alanıdır. Kazılar, burada yaklaşık 8.500 yıl öncesine uzanan köy yerleşimlerinin izlerini ortaya "
        "çıkardı.\n\n"
        "Alan bir arkeopark olarak düzenlenmiştir: yeniden yapılmış tarih öncesi evler, bu dönemin insanlarının nasıl "
        "yaşadığını, ne yiyip nasıl ürettiğini gösterir. Çocuklu aileler için öğretici bir duraktır; Gölyazı ile aynı "
        "gün gezilebilir.",
        "About 25 km south-west of Bursa, Aktopraklık Mound at Akçalar is a settlement site near the eastern shore of Lake "
        "Uluabat. Excavations have revealed traces of village settlements going back about 8,500 years.\n\n"
        "The site is laid out as an archaeopark: reconstructed prehistoric houses show how people of that era lived, what "
        "they ate and how they made things. It is an educational stop for families with children and can be visited on "
        "the same day as Gölyazı."),

    "hisar-arkeopark": (2,
        "Bursa'nın tarihi kalesi Hisar'ın içindeki arkeopark, kentin Bizans dönemine ait kalıntılarının açık havada "
        "sergilendiği bir alandır. Hisar, Bursa'nın ilk yerleşim yeri ve Osmanlıların 1326'da aldığı kalenin "
        "bulunduğu bölümdür.\n\n"
        "Kazılarda ortaya çıkan yapı temelleri, duvar parçaları ve buluntular yürüyüş yolları boyunca görülebilir. "
        "Tophane'deki saat kulesi, Osman Gazi ve Orhan Gazi türbeleri yakındadır; bir Hisar yürüyüşüne kolayca "
        "eklenir.",
        "The archaeopark inside Hisar, Bursa's historic citadel, is an area where remains from the city's Byzantine "
        "period are displayed in the open air. Hisar is where Bursa was first settled and where the castle taken by the "
        "Ottomans in 1326 stood.\n\n"
        "Building foundations, wall fragments and finds uncovered in the excavations can be seen along the walking paths. "
        "The clock tower at Tophane and the tombs of Osman Gazi and Orhan Gazi are nearby, so it fits easily into a walk "
        "around Hisar."),

    "antik-tiyatro": (2,
        "Gölyazı'daki tiyatro, antik Apollonia ad Rhyndacum kentine aittir ve Helenistik döneme tarihlenir. Gölyazı'nın "
        "Zambaktepe mevkiinde yürütülen kazılar, son yıllarda seyirci basamaklarını yeniden gün ışığına çıkardı; "
        "basamakların bazılarında yazıtlar, oturma sıraları arasında ise bir mezar bulundu.\n\n"
        "Kazı sürdüğü için alanın bir kısmı ziyarete kapalı olabilir; çit dışından izleyin ve işaretlere uyun. Tiyatro, "
        "Gölyazı köyüne giriş yolunun yakınındadır; köyün sokakları ve göl kıyısıyla aynı gezide görülür.",
        "The theatre at Gölyazı belonged to the ancient city of Apollonia ad Rhyndacum and dates from the Hellenistic "
        "period. Excavations at the Zambaktepe site in Gölyazı have recently brought its rows of seats back to light; "
        "inscriptions were found on some of the steps and a tomb between the seating rows.\n\n"
        "As digging continues, part of the site may be closed to visitors; watch from outside the fence and follow the "
        "signs. The theatre is near the road into Gölyazı village and is seen on the same visit as the village streets "
        "and the lakeshore."),

    "yesil-turbe": (2,
        "Yeşil Türbe, 1421'de ölen Sultan I. Mehmed (Çelebi) için oğlu II. Murad tarafından yaptırıldı; mimarı Yeşil "
        "Camii'yi de tasarlayan Hacı İvaz Paşa'dır. Şehrin birçok yerinden görülen sekizgen türbe, Bursa'nın "
        "simgelerinden biridir.\n\n"
        "Dışını kaplayan turkuaz çiniler 1855 depreminden sonra yenilendi; içerideki çini kaplı sanduka ve mihrap ise "
        "15. yüzyıl çini sanatının en güzel örneklerindendir. Türbe sessizce ziyaret edilmelidir. Hemen karşısındaki "
        "Yeşil Camii ve çevredeki çay bahçeleri aynı gezide görülür.",
        "The Green Tomb was built for Sultan Mehmed I (Çelebi), who died in 1421, by his son Murad II; its architect was "
        "Hacı İvaz Pasha, who also designed the Green Mosque. Visible from many parts of the city, the octagonal tomb is "
        "one of Bursa's symbols.\n\n"
        "The turquoise tiles covering its exterior were renewed after the 1855 earthquake, while the tiled cenotaph and "
        "mihrab inside are among the finest examples of 15th-century tilework. The tomb should be visited quietly. The "
        "Green Mosque just opposite and the tea gardens around it fit into the same visit."),

    "osman-gazi-turbesi": (2,
        "Tophane'deki Osman Gazi Türbesi, Osmanlı Devleti'nin kurucusu Osman Gazi'nin mezarıdır. Rivayete göre Osman "
        "Gazi, Bursa'nın alınmasından sonra buraya gömülmeyi vasiyet etmiş; oğlu Orhan Gazi onu bir Bizans yapısının "
        "içine defnettirmiştir. Bugünkü türbe, 1855 depreminden sonra Sultan Abdülaziz döneminde yeniden yapıldı.\n\n"
        "Türbe, Osmanlı tarihinin başlangıcını simgeleyen önemli bir ziyaret yeridir; sessiz ve saygılı olunmalıdır. "
        "Hemen yanında Orhan Gazi Türbesi ve saat kulesi bulunur; Tophane Parkı'ndan şehrin manzarası görülür.",
        "The Tomb of Osman Gazi in Tophane is the burial place of Osman I, founder of the Ottoman state. According to "
        "tradition, Osman asked to be buried here after Bursa's capture, and his son Orhan laid him to rest inside a "
        "Byzantine building. The present tomb was rebuilt under Sultan Abdülaziz after the earthquake of 1855.\n\n"
        "The tomb is an important place of visit symbolising the beginning of Ottoman history; be quiet and respectful. "
        "The Tomb of Orhan Gazi and the clock tower are right beside it, and Tophane Park looks out over the city."),

    "hacivat-karagoz-anit-mezari": (2,
        "Çekirge'deki Hacivat ve Karagöz Anıt Mezarı, gölge oyununun iki ünlü karakterine adanmış sembolik bir "
        "mezardır. Rivayete göre Hacivat ile Karagöz, Orhan Gazi döneminde bir caminin inşaatında çalışan ve "
        "şakalaşmalarıyla işi aksattıkları için idam edilen iki ustaydı; onların hikâyesi gölge oyununa dönüştü.\n\n"
        "Anıt mezar, Bursa'nın Karagöz geleneğine bağlılığının simgesidir. Hemen karşısındaki Karagöz Müzesi ile "
        "birlikte gezilmesi önerilir; Çekirge'nin tarihi kaplıcaları da yakındır.",
        "The Monumental Tomb of Hacivat and Karagöz in Çekirge is a symbolic grave dedicated to the two famous characters "
        "of shadow theatre. Legend says Hacivat and Karagöz were two builders working on a mosque in Orhan Gazi's time who "
        "were executed because their joking held up the work, and their story became the shadow play.\n\n"
        "The tomb symbolises Bursa's attachment to the Karagöz tradition. It is best visited with the Karagöz Museum just "
        "opposite, and Çekirge's historic thermal baths are nearby."),

    "orhan-gazi-turbesi": (2,
        "Tophane'deki Orhan Gazi Türbesi, Osmanlı'nın ikinci hükümdarı ve Bursa'nın fatihi Orhan Gazi'nin mezarıdır. "
        "Babası Osman Gazi'nin türbesinin hemen yanındadır. Türbe, eski bir Bizans kilisesinin yerinde yer alır ve "
        "1855 depreminden sonra yeniden yapıldı.\n\n"
        "İçeride, eski kiliseden kalan mozaik döşeme parçaları görülebilir. Osman Gazi Türbesi, saat kulesi ve Tophane "
        "Parkı'nın manzarasıyla birlikte ziyaret edilir; sessiz ve saygılı olunmalıdır.",
        "The Tomb of Orhan Gazi in Tophane is the burial place of the second Ottoman ruler and conqueror of Bursa. It "
        "stands right beside the tomb of his father, Osman Gazi. The tomb occupies the site of an old Byzantine church "
        "and was rebuilt after the earthquake of 1855.\n\n"
        "Inside, fragments of the mosaic floor of the old church can be seen. It is visited together with the Tomb of "
        "Osman Gazi, the clock tower and the view from Tophane Park; be quiet and respectful."),

    "sehzade-mustafa-turbesi": (2,
        "Muradiye Külliyesi'ndeki Şehzade Mustafa Türbesi, Kanuni Sultan Süleyman'ın 1553'te idam ettirilen oğlu "
        "Şehzade Mustafa'ya aittir. Türbe, II. Selim döneminde, 1570'lerde yaptırıldı.\n\n"
        "İç duvarları kaplayan 16. yüzyıl İznik çinileri, Muradiye'deki türbelerin en zengin süslemelerindendir; "
        "çinilerin desenlerine ve renklerine yakından bakın. Muradiye bahçesindeki diğer türbelerle birlikte, sessizce "
        "ziyaret edilmelidir.",
        "The Tomb of Prince Mustafa in the Muradiye Complex belongs to the son of Suleiman the Magnificent who was "
        "executed in 1553. The tomb was built under Selim II in the 1570s.\n\n"
        "The 16th-century İznik tiles covering its inner walls are among the richest decoration of any tomb at Muradiye; "
        "look closely at the patterns and colours. It should be visited quietly, together with the other tombs in the "
        "Muradiye garden."),

    "cem-sultan-turbesi": (2,
        "Muradiye Külliyesi'ndeki Cem Sultan Türbesi, Fatih Sultan Mehmed'in oğlu Cem Sultan'ın mezarıdır. Kardeşi II. "
        "Bayezid ile taht mücadelesini kaybeden Cem, yıllarını Avrupa'da esir olarak geçirdi ve 1495'te İtalya'da öldü; "
        "naaşı birkaç yıl sonra Bursa'ya getirildi.\n\n"
        "Türbenin iç mekânı, kubbeyi ve duvarları kaplayan zengin kalem işleri ve alt kısımdaki çinileriyle Muradiye'nin "
        "en etkileyici türbelerindendir. Aynı türbede başka şehzadeler de yatar. Sessizce ve kurallara uyarak "
        "ziyaret edin.",
        "The Tomb of Cem Sultan in the Muradiye Complex is the burial place of Cem, son of Mehmed the Conqueror. Having "
        "lost the struggle for the throne to his brother Bayezid II, Cem spent years as a captive in Europe and died in "
        "Italy in 1495; his body was brought to Bursa a few years later.\n\n"
        "With rich painted decoration covering the dome and walls and tiles on the lower parts, its interior is one of "
        "the most impressive at Muradiye. Other princes are buried in the same tomb. Visit quietly and follow the rules."),

    "ebe-gulbahar-hatun-turbesi": (2,
        "Muradiye Külliyesi'nin bahçesindeki küçük türbe, Ebe Hatun olarak da anılan Gülbahar Hatun'a aittir. "
        "Muradiye'deki türbeler, II. Murad'dan sonra yaklaşık bir yüzyıl boyunca Osmanlı hanedanının kadın ve şehzade "
        "üyelerinin gömüldüğü yer oldu.\n\n"
        "Sade yapısıyla bahçedeki görkemli türbeler arasında daha alçakgönüllü bir yer tutar. Selvi ve çınarların "
        "gölgesindeki bahçede, diğer türbelerle birlikte gezilir.",
        "The small tomb in the garden of the Muradiye Complex belongs to Gülbahar Hatun, also known as Ebe Hatun. After "
        "Murad II, the Muradiye tombs became the burial place of women and princes of the Ottoman dynasty for about a "
        "century.\n\n"
        "Plain in form, it holds a more modest place among the grander tombs of the garden. It is seen together with the "
        "other tombs in the garden shaded by cypresses and plane trees."),

    "emirsultan-hz-turbesi": (2,
        "Emir Sultan Camii'nin yanındaki türbe, Buharalı âlim ve sufi Emir Sultan'a (Şemseddin Muhammed Buhari) aittir. "
        "Yıldırım Bayezid'in damadı olan Emir Sultan, Bursa'da büyük saygı gören bir manevi önderdi. Türbe, cami gibi "
        "depremlerden sonra 19. yüzyılda yeniden yapıldı.\n\n"
        "Bursa'nın en çok ziyaret edilen türbelerinden biridir; özellikle cuma günleri ve kandil gecelerinde kalabalık "
        "olur. Ziyaret sırasında sessiz olun ve uygun giyinin. Avludan şehrin ve ovanın manzarası görülür.",
        "The tomb beside the Emir Sultan Mosque belongs to the Bukharan scholar and Sufi Emir Sultan (Şemseddin Muhammed "
        "Buhari). Son-in-law of Bayezid I, Emir Sultan was a deeply respected spiritual leader in Bursa. Like the mosque, "
        "the tomb was rebuilt in the 19th century after earthquakes.\n\n"
        "It is one of the most visited tombs in Bursa, crowded especially on Fridays and on holy nights. Be quiet and "
        "dress appropriately during your visit. The courtyard looks out over the city and the plain."),

    "gulruh-hatun-turbesi": (2,
        "Muradiye Külliyesi'ndeki Gülruh Hatun Türbesi, Sultan II. Bayezid'in eşlerinden Gülruh Hatun'a aittir. "
        "Bahçedeki türbeler, Osmanlı sarayındaki kadınların ve şehzadelerin hikâyelerini bir araya getirir.\n\n"
        "Sade bir yapı olan türbe, Muradiye bahçesindeki gezinin bir durağıdır. Türbelerin açık olup olmadığı "
        "değişebilir; görevliye danışın ve sessiz olun.",
        "The Tomb of Gülruh Hatun in the Muradiye Complex belongs to one of the consorts of Sultan Bayezid II. The tombs in "
        "the garden bring together the stories of the women and princes of the Ottoman court.\n\n"
        "A plain building, the tomb is one stop on a walk through the Muradiye garden. Whether the tombs are open may vary; "
        "ask the attendant and keep quiet."),

    "gulsah-hatun-turbesi": (2,
        "Muradiye Külliyesi'ndeki Gülşah Hatun Türbesi, Fatih Sultan Mehmed'in eşlerinden Gülşah Hatun'a aittir. "
        "Muradiye bahçesi, hanedanın birçok kadın üyesinin son durağı oldu.\n\n"
        "Küçük ve sade türbe, bahçedeki diğer türbelerle birlikte görülür. Muradiye'nin gölgeli bahçesinde, türbeler "
        "arasında sakin bir yürüyüş yapmak ziyaretin en güzel yanıdır.",
        "The Tomb of Gülşah Hatun in the Muradiye Complex belongs to one of the consorts of Mehmed the Conqueror. The "
        "Muradiye garden became the final resting place of many women of the dynasty.\n\n"
        "The small, plain tomb is seen together with the other tombs in the garden. A quiet stroll among the tombs in "
        "Muradiye's shady garden is the best part of a visit."),

    "huma-hatun-turbesi": (2,
        "Muradiye Külliyesi'ndeki Hüma Hatun Türbesi, Sultan II. Murad'ın eşi ve Fatih Sultan Mehmed'in annesi Hüma "
        "Hatun'a aittir. Hüma Hatun, oğlunun İstanbul'u almasından birkaç yıl önce öldü.\n\n"
        "Sade mimarisiyle dikkat çeken türbe, İstanbul'u fetheden padişahın annesinin mezarı olması nedeniyle "
        "ziyaretçilerin ilgisini çeker. Muradiye bahçesindeki diğer türbelerle birlikte sessizce ziyaret edilir.",
        "The Tomb of Hüma Hatun in the Muradiye Complex belongs to the consort of Sultan Murad II and mother of Mehmed the "
        "Conqueror. Hüma Hatun died a few years before her son took Constantinople.\n\n"
        "Notable for its plain architecture, the tomb draws visitors as the grave of the mother of the sultan who "
        "conquered Istanbul. It is visited quietly together with the other tombs in the Muradiye garden."),

    "cumalikizik": (2,
        "Uludağ'ın kuzey eteğinde, Bursa'ya yaklaşık 11 km uzaklıktaki Cumalıkızık, erken Osmanlı döneminde kurulan "
        "beş Kızık köyünden biridir ve bugün de yaşayan bir köydür. 2014'te Bursa ile birlikte 'Osmanlı "
        "İmparatorluğu'nun Doğuşu' adıyla UNESCO Dünya Mirası Listesi'ne alındı.\n\n"
        "Taş döşeli dar sokaklar, ahşap ve kerpiçten iki üç katlı evler ve küçük köy meydanı yüzyıllardır büyük ölçüde "
        "korunmuştur. Köy kahvaltısı, gözleme ve ahududu ünlüdür. Hafta sonları çok kalabalık olur; köyde insanların "
        "yaşadığını unutmayın, evlerin içini izinsiz fotoğraflamayın. İçindeki yerler ayrıca işaretlenebilir.",
        "On the northern slopes of Uludağ, about 11 km from Bursa, Cumalıkızık is one of five Kızık villages founded in "
        "the early Ottoman period and is still lived in today. In 2014 it was added to the UNESCO World Heritage List "
        "together with Bursa as 'the Birth of the Ottoman Empire'.\n\n"
        "Narrow cobbled streets, two- and three-storey houses of timber and mud brick and the small village square have "
        "been largely preserved for centuries. The village breakfast, gözleme and raspberries are famous. It gets very "
        "crowded at weekends; remember that people live here and do not photograph inside homes without permission. The "
        "places inside can be checked off separately."),

    "golyazi-adasi": (2,
        "Uluabat Gölü'ne uzanan küçük bir yarımada üzerindeki Gölyazı, antik Apollonia ad Rhyndacum kentinin yerinde "
        "kurulmuştur. Mübadeleye kadar Rum ve Türk ailelerin birlikte yaşadığı balıkçı köyü, bugün taş ve ahşap "
        "evleri, eski kilisesi ve antik kalıntılarıyla Bursa'nın en sevilen kaçış noktalarındandır.\n\n"
        "Göl kıyısındaki balıkçı tekneleri, çatılardaki leylek yuvaları ve gün batımı manzarası ünlüdür; tekne turuyla "
        "Apollon Tapınağı'nın bulunduğu Kız Adası'na gidilebilir. Hafta sonları kalabalık olur, gün batımından önce "
        "gelin. İçindeki yerler ayrıca işaretlenebilir.",
        "Set on a small peninsula reaching into Lake Uluabat, Gölyazı was built on the site of the ancient city of "
        "Apollonia ad Rhyndacum. A fishing village where Greek and Turkish families lived together until the population "
        "exchange, it is today one of Bursa's favourite escapes with its stone and timber houses, old church and ancient "
        "remains.\n\n"
        "The fishing boats along the shore, the stork nests on the roofs and the sunset are famous, and a boat trip takes "
        "you to Kız Adası, where the Temple of Apollo stood. It gets busy at weekends, so arrive before sunset. The "
        "places inside can be checked off separately."),

    "misi": (2,
        "Nilüfer Çayı'nın kıyısındaki Misi (bugünkü adıyla Gümüştepe), Bursa'nın hemen yanında taş evleri ve yemekleriyle "
        "bilinen eski bir köydür. Mübadeleye kadar Rum nüfusun da yaşadığı köyün dokusu, yamaca kurulmuş taş evleriyle "
        "korunmuştur.\n\n"
        "Dere kenarındaki çınarların altında yapılan kahvaltılar ve Misi'ye özgü mantı ile gözleme ünlüdür. Köyün dar "
        "sokaklarında kısa bir yürüyüş yapıp dere kıyısında oturabilirsiniz. Şehir merkezine çok yakın olduğundan "
        "hafta sonu kahvaltısı için popülerdir.",
        "Misi (today officially Gümüştepe), on the banks of the Nilüfer stream, is an old village right next to Bursa "
        "known for its stone houses and food. Home also to a Greek population until the population exchange, it has kept "
        "its fabric of stone houses built up the hillside.\n\n"
        "Breakfasts under the plane trees by the stream and Misi's own mantı and gözleme are famous. You can take a short "
        "walk through the village's narrow streets and sit by the water. Being very close to the city centre, it is "
        "popular for weekend breakfasts."),

    "tirilye": (2,
        "Mudanya yakınlarındaki Tirilye, Bizans döneminde Trigleia adıyla bilinen, mübadeleye kadar Rum nüfusun "
        "yaşadığı eski bir liman köyüdür. 1968-2012 arasında Zeytinbağı adını taşıdı; zeytinlikleri bugün de ünlüdür.\n\n"
        "Taş evlerle çevrili dar sokaklarda Fatih Camii'ne dönüşen Bizans kilisesi, Kemerli Kilise ve bir sarnıçtan "
        "beslenen Bizans dönemi Sofalı Çeşme görülebilir. Sahildeki balık lokantaları ve zeytin-zeytinyağı satan "
        "dükkânlar gezinin parçasıdır. İçindeki yapılar ayrıca işaretlenebilir.",
        "Near Mudanya, Tirilye is an old harbour village known in Byzantine times as Trigleia and home to a Greek "
        "population until the population exchange. Between 1968 and 2012 it was called Zeytinbağı ('olive grove'), and its "
        "olives are still famous today.\n\n"
        "In the narrow streets lined with stone houses you can see the Byzantine church turned into the Fatih Mosque, the "
        "Arched Church and the Byzantine Sofalı Fountain fed by a cistern. The fish restaurants on the shore and shops "
        "selling olives and olive oil are part of the visit. The buildings inside can be checked off separately."),

    "zeyniller-koyu-seyir-tepesi": (2,
        "Uludağ'ın eteğindeki Zeyniler köyünün yakınındaki seyir tepesi, Bursa ovasına ve şehre yukarıdan bakan bir "
        "noktadır. Ağaçlık yamaçlar arasında, şehrin kalabalığından uzak sakin bir yerdir.\n\n"
        "Gün batımında ve gece şehir ışıklarının yandığı saatlerde manzara özellikle güzeldir. Köye giden yol virajlıdır; "
        "dikkatli sürün ve akşam serinliği için yanınıza bir hırka alın. Köydeki kahvaltı ve gözleme yerleriyle "
        "birlikte bir yarım gün geçirilebilir.",
        "Near the village of Zeyniler on the slopes of Uludağ, this viewpoint looks down over the Bursa plain and the city. "
        "Among wooded slopes, it is a quiet spot away from the bustle of the city.\n\n"
        "The view is especially beautiful at sunset and at night when the city lights come on. The road to the village is "
        "winding, so drive carefully, and bring a jumper for the cool evening. You can spend half a day here together with "
        "the village's breakfast and gözleme places."),

    "uludag": (2,
        "Bursa'nın güneyinde yükselen Uludağ, yaklaşık 2.543 metre yüksekliğiyle Marmara Bölgesi'nin en yüksek dağıdır. "
        "Antik çağda Misya Olimposu olarak bilinirdi. Bugün Türkiye'nin en tanınmış kış sporları merkezlerinden biridir.\n\n"
        "Kışın kayak merkezi ve otelleri kalabalıklaşır; yazın ise ormanlarda yürüyüş, zirveye yakın buzul gölleri ve "
        "piknik alanları ilgi çeker. Şehirden Teferrüç'ten kalkan teleferikle ya da karayoluyla çıkılır. Hava dağda hızla "
        "değişebilir; yazın bile kalın giysi alın, kışın yol durumunu ve zincir zorunluluğunu kontrol edin.",
        "Rising south of Bursa, Uludağ is the highest mountain in the Marmara region at about 2,543 metres. Known in "
        "antiquity as the Mysian Olympus, it is today one of Turkey's best-known winter sports centres.\n\n"
        "In winter the ski resort and hotels fill up; in summer, forest walks, the glacial lakes near the summit and picnic "
        "areas draw visitors. You go up from the city by the cable car from Teferrüç or by road. The weather on the "
        "mountain can change quickly; bring warm clothes even in summer, and in winter check road conditions and chain "
        "requirements."),

    "uludag-milli-parki": (2,
        "Uludağ Millî Parkı, 1961'de ilan edildi ve dağın ormanlarını, göllerini ve zirve bölgesini koruma altına alır. "
        "Karaçam, kayın ve göknar ormanları, yükseklere çıktıkça yerini alpin çayırlara ve kayalık alanlara bırakır.\n\n"
        "Yaz aylarında işaretli yürüyüş yolları, zirveye yakın buzul gölleri ve kamp alanları en çok ilgi gören "
        "bölümlerdir. Parka teleferik ya da karayoluyla ulaşılır. Doğal alanda ateş yakma kurallarına uyun, çöplerinizi "
        "geri götürün ve yaban hayatını rahatsız etmeyin.",
        "Uludağ National Park was declared in 1961 and protects the mountain's forests, lakes and summit area. Forests of "
        "black pine, beech and fir give way to alpine meadows and rocky ground as you climb.\n\n"
        "In summer, the marked trails, the glacial lakes near the summit and the camping areas are the most popular parts. "
        "The park is reached by cable car or by road. Follow the rules on fires, take your rubbish back with you and do not "
        "disturb wildlife."),

    "karacabey-longoz-ormanlari": (2,
        "Karacabey Longozu, Susurluk Irmağı'nın Marmara Denizi'ne döküldüğü Kocaçay Deltası'nda yer alan bir subasar "
        "ormanıdır. Kış ve ilkbaharda sularla kaplanan bu orman türü Türkiye'de çok az yerde kalmıştır ve delta, "
        "kuşlar için önemli bir yaşam alanıdır.\n\n"
        "İlkbaharda orman zemini çiçeklerle kaplanır ve ağaçların gövdeleri suya yansır; fotoğrafçılar için en güzel "
        "zamandır. Patikalar yer yer çamurlu olur, uygun ayakkabı giyin ve sivrisineğe karşı hazırlıklı gelin. Kuşları "
        "rahatsız etmemek için sessiz olun.",
        "The Karacabey Floodplain Forest lies in the Kocaçay Delta, where the Susurluk River flows into the Sea of Marmara. "
        "This type of forest, flooded in winter and spring, survives in very few places in Turkey, and the delta is an "
        "important habitat for birds.\n\n"
        "In spring the forest floor is carpeted with flowers and the tree trunks are reflected in the water, the best time "
        "for photographers. Paths can be muddy in places, so wear suitable shoes and come prepared for mosquitoes. Keep "
        "quiet so as not to disturb the birds."),

    "sadagi-kanyonu-tabiat-parki": (2,
        "Orhaneli'ye bağlı Sadağı köyündeki kanyon, Bursa'nın yaklaşık 55 km güneybatısındadır ve tabiat parkı olarak "
        "koruma altındadır. Kilometrelerce uzanan kanyonun dik kaya duvarları arasından berrak bir dere akar.\n\n"
        "Kanyon boyunca uzanan yürüyüş yolu, köprüler ve basamaklarla dere kenarında ilerler; yolda küçük şelaleler ve "
        "su birikintileri görülür. Kayalar kaygan olabileceğinden kaymayan ayakkabı giyin. İlkbahar ve sonbahar en "
        "uygun zamanlardır; yağışlı günlerde ani su yükselmelerine dikkat edin.",
        "The canyon at the village of Sadağı in Orhaneli lies about 55 km south-west of Bursa and is protected as a nature "
        "park. A clear stream flows between the steep rock walls of the canyon, which stretches for kilometres.\n\n"
        "The trail along the canyon follows the stream with bridges and steps, passing small waterfalls and pools. Rocks "
        "can be slippery, so wear non-slip shoes. Spring and autumn are the best times; on rainy days watch out for "
        "sudden rises in the water."),

    "uluabat-golu-sulak-alani": (2,
        "Bursa'nın batısındaki Uluabat (Apolyont) Gölü, su seviyesine göre 135-160 km² arasında değişen geniş bir "
        "tatlı su gölüdür. 1998'den beri uluslararası öneme sahip Ramsar alanıdır; nilüferleri, sazlıkları ve kuşlarıyla "
        "Türkiye'nin önemli sulak alanlarındandır.\n\n"
        "Göl kıyısındaki Gölyazı ve leylekleriyle bilinen Eskikaraağaç köyü, gölü görmek için en iyi noktalardır. "
        "Yaz başında nilüferlerin açtığı dönem ve kuş göçü mevsimleri özellikle güzeldir. Tekne turlarıyla gölün "
        "adalarına ve sazlıklarına gidilebilir.",
        "Lake Uluabat (Apolyont), west of Bursa, is a large freshwater lake whose area varies between 135 and 160 km² "
        "with the water level. A Ramsar site of international importance since 1998, it is one of Turkey's important "
        "wetlands with its water lilies, reed beds and birds.\n\n"
        "Gölyazı on the shore and the village of Eskikaraağaç, known for its storks, are the best places to see the lake. "
        "The early-summer period when the water lilies bloom and the bird migration seasons are especially lovely. Boat "
        "trips take you to the lake's islands and reed beds."),

    "resat-oyal-kultur-parki": (2,
        "Reşat Oyal Kültür Parkı, 1955'te Belediye Başkanı Reşat Oyal tarafından Kültürpark adıyla açıldı ve Bursa'nın "
        "en eski parklarındandır. Şehrin merkezinde, yaklaşık 39 hektarlık bir alana yayılır.\n\n"
        "Ağaçlık yürüyüş yolları, göleti, açık hava tiyatrosu ve çay bahçeleriyle şehrin nefes alma yeridir; Bursa "
        "Arkeoloji Müzesi de parkın içindedir. Yazın akşamları konser ve etkinliklerle canlanır. Müze ziyaretini bir "
        "park yürüyüşüyle birleştirin.",
        "Reşat Oyal Cultural Park was opened in 1955 by Mayor Reşat Oyal under the name Kültürpark and is one of Bursa's "
        "oldest parks. It covers about 39 hectares in the centre of the city.\n\n"
        "With tree-lined paths, a pond, an open-air theatre and tea gardens, it is the city's breathing space, and the "
        "Bursa Archaeological Museum is inside the park. On summer evenings it comes alive with concerts and events. "
        "Combine a museum visit with a walk in the park."),

    "merinos-parki": (2,
        "Merinos Parkı, Cumhuriyet döneminde sanayileşmenin simgelerinden olan Sümerbank Merinos Fabrikası'nın "
        "arazisinde kuruldu. Bursa'nın en büyük kent parklarından biridir.\n\n"
        "Geniş çimenlik alanları, göletleri ve yürüyüş yollarının yanında, fabrikanın tarihi binalarında açılan Tekstil "
        "Sanayi Müzesi, Enerji Müzesi ve Atatürk Kongre Kültür Merkezi parkın içindedir. Hafta sonları aileler ve "
        "sporcularla dolar. İçindeki müzeler ayrıca işaretlenebilir.",
        "Merinos Park was laid out on the grounds of the Sümerbank Merinos Factory, a symbol of the Republic's "
        "industrialisation. It is one of Bursa's largest city parks.\n\n"
        "Besides wide lawns, ponds and walking paths, the Textile Industry Museum, the Energy Museum and the Atatürk "
        "Congress and Culture Centre, housed in the factory's historic buildings, are inside the park. At weekends it "
        "fills with families and people exercising. The museums inside can be checked off separately."),

    "mudanya-sahili": (2,
        "Mudanya'nın deniz kıyısı, tarihi evlerin, balık restoranlarının ve kafelerin sıralandığı canlı bir sahil "
        "şerididir. Mudanya, Osmanlı döneminde Bursa'nın limanıydı ve 19. yüzyılın sonunda Bursa'ya demiryoluyla "
        "bağlandı.\n\n"
        "Sahil yolunda yürüyüş yaparken Mütareke Evi'ni, eski tren istasyonu binalarını ve cumbalı taş evleri "
        "görebilirsiniz. Gün batımında balık yemek ya da iskelede deniz otobüslerini izlemek Mudanya'nın keyfidir. "
        "Hafta sonları kalabalık olur.",
        "Mudanya's waterfront is a lively seaside strip lined with historic houses, fish restaurants and cafés. In Ottoman "
        "times Mudanya was Bursa's port, and at the end of the 19th century it was linked to Bursa by railway.\n\n"
        "Walking along the seafront you can see the Armistice House, the old railway station buildings and stone houses "
        "with bay windows. Eating fish at sunset or watching the sea buses at the pier is the pleasure of Mudanya. It "
        "gets busy at weekends."),

    "kursunlu-plaji": (2,
        "Karacabey'e bağlı Kurşunlu'daki plaj, Marmara Denizi kıyısında uzanan uzun ve kumlu bir halk plajıdır. Son "
        "yıllardaki düzenlemelerle Bursa'nın en çok tercih edilen yaz noktalarından biri haline geldi.\n\n"
        "Geniş kumsalı sayesinde kalabalık günlerde bile yer bulmak kolaydır. Bursa merkezine yaklaşık bir saatlik "
        "sürüş uzaklığındadır; Karacabey'den sonra Kurşunlu tabelalarını izleyin. Gemlik'teki aynı adlı Kurşunlu ile "
        "karıştırmayın.",
        "The beach at Kurşunlu in Karacabey district is a long, sandy public beach on the Sea of Marmara. Recent "
        "improvements have made it one of Bursa's most popular summer spots.\n\n"
        "Its wide sands make it easy to find space even on busy days. It is about an hour's drive from central Bursa; "
        "after Karacabey, follow the signs for Kurşunlu. Do not confuse it with the Kurşunlu of the same name in Gemlik."),

    "gemlik-kursunlu-plaji": (2,
        "Gemlik'e bağlı Kurşunlu'daki halk plajı, Gemlik Körfezi kıyısında yaklaşık 3,5 kilometre boyunca uzanır ve "
        "ücretsizdir. Plajın arkasındaki defne ve ıhlamur ağaçlarıyla kaplı orman, sıcak yaz günlerinde gölge sağlar.\n\n"
        "Belediyenin yaptığı düzenlemelerle sahil yeşil alanlar, yürüyüş yolu ve aydınlatmayla bir kordona dönüştü; "
        "yalnızca kadınlara ayrılmış bir plaj bölümü de vardır. Hafta sonları Bursalıların akınına uğrar, erken gidin. "
        "Karacabey'deki aynı adlı Kurşunlu ile karıştırmayın.",
        "The public beach at Kurşunlu in Gemlik district stretches for about 3.5 kilometres along the Gulf of Gemlik and "
        "is free of charge. The woods of laurel and linden behind the beach give shade on hot summer days.\n\n"
        "Municipal improvements have turned the shore into a promenade with green areas, a walking path and lighting, and "
        "there is also a women-only section. It is packed with people from Bursa at weekends, so go early. Do not confuse "
        "it with the Kurşunlu of the same name in Karacabey."),

    "suuctu-selalesi": (2,
        "Mustafakemalpaşa'ya yaklaşık 18 km uzaklıktaki Suuçtu Şelalesi, ormanın içinde yaklaşık 38 metre yükseklikten "
        "dökülür. Şelaleyi besleyen su, ilçenin içme suyu ihtiyacını da karşılar.\n\n"
        "Şelalenin dibine kısa bir yürüyüşle inilir; çevresi piknik ve mesire alanı olarak düzenlenmiştir. Su en bol "
        "halini ilkbaharda alır. Kayalar ıslak ve kaygan olabilir, dikkatli olun ve doğal alanı temiz bırakın.",
        "About 18 km from Mustafakemalpaşa, Suuçtu Waterfall drops about 38 metres in the middle of the forest. The water "
        "that feeds it also supplies the district's drinking water.\n\n"
        "A short walk takes you down to the foot of the falls, and the surroundings are laid out as a picnic and "
        "recreation area. The water is at its fullest in spring. The rocks can be wet and slippery, so take care and "
        "leave the natural area clean."),

    "saitabat-selalesi": (2,
        "Bursa'nın doğusunda, Uludağ'ın eteğindeki Saitabat köyünün yakınındaki şelale, ormanlık bir vadide yer alır. "
        "Çevresi mesire yeri olarak kullanılır ve şehirden kısa bir sürüşle ulaşılan serin bir kaçış noktasıdır.\n\n"
        "Şelaleye giden patika orman içinden geçer; su ilkbahar aylarında en coşkulu halindedir. Köydeki kahvaltı "
        "yerleri ve dere kenarındaki çay ocaklarıyla birlikte yarım günlük bir doğa gezisi yapılabilir. Patika yer yer "
        "kaygan olabilir.",
        "East of Bursa, near the village of Saitabat on the slopes of Uludağ, this waterfall lies in a wooded valley. The "
        "area around it is used for picnics and is a cool escape a short drive from the city.\n\n"
        "The path to the falls runs through the forest, and the water is at its most vigorous in spring. With the "
        "village's breakfast places and tea stalls by the stream, it makes a half-day nature outing. The path can be "
        "slippery in places."),

    "oylat-selalesi": (2,
        "İnegöl'e bağlı Oylat'taki şelale, Uludağ'ın güneydoğu uzantılarında, çam ve kayın ormanlarıyla kaplı bir "
        "vadide yer alır. Oylat Kaplıcaları'ndan başlayan yaklaşık 2-3 kilometrelik orman yürüyüşüyle ulaşılır.\n\n"
        "Kolay sayılabilecek patika, dere boyunca ilerleyerek şelalenin önündeki küçük havuza varır. Kaplıca ziyareti ve "
        "yakındaki Oylat Mağarası ile birlikte bir gün planlanabilir. Yağışlı havalarda patika çamurlu olur, uygun "
        "ayakkabı giyin.",
        "The waterfall at Oylat in İnegöl district lies in a valley covered with pine and beech forest on the south-eastern "
        "spurs of Uludağ. It is reached by a forest walk of about 2-3 kilometres starting from the Oylat thermal springs.\n\n"
        "The fairly easy path follows the stream to a small pool in front of the falls. A day can be planned around a "
        "visit to the springs and the nearby Oylat Cave. The path gets muddy in wet weather, so wear suitable shoes."),
}
