"""İzmir yerlerinin uzun açıklamaları (TR + EN). Kurallar istanbul_long_descriptions.py ile aynı:

  * Kendi cümlelerimiz; Vikipedi metni kopyalanmaz (results/izmir/wiki-extracts.json.gz yalnızca bilgi kontrolü için).
  * 2 paragraf: (1) ne olduğu ve kısa tarihçe, (2) ne görülmeli + pratik ipucu.
  * Sık değişen bilgi yok: bilet fiyatı, saat, telefon. Tartışmalı ya da doğrulanamayan sayı yazılmaz.
  * Paragraflar "\\n\\n" ile ayrılır.

LONG[slug] = (parti, tr, en). Parti numarası migration'ı belirler (build_long_desc.py --city izmir).
"""

LONG = {
    "isa-bey-camii": (1,
        "Selçuk'ta, Ayasuluk Tepesi'nin eteğinde, Artemis Tapınağı ile Aziz Yuhanna Bazilikası arasında duran İsa Bey "
        "Camii, Aydınoğlu İsa Bey adına 1374-1375'te yapıldı. Şamlı mimar Ali bin Müşeymiş'in eseri olan cami, plan "
        "olarak Şam Emevi Camii'nden esinlenir ve Anadolu beylikleri döneminin en gösterişli yapılarından sayılır. "
        "19. yüzyılda bir süre kervansaray olarak da kullanıldı.\n\n"
        "Geniş avluyu çevreleyen duvarlarda ve harimde, çevredeki antik kentten getirilmiş granit sütunlar ile mermer "
        "parçalar dikkat çeker; batı cephesindeki renkli taş işçiliğine ve kapı çevresindeki süslemelere yakından bakın. "
        "Aziz Yuhanna Bazilikası ve Artemis Tapınağı yürüme mesafesinde olduğundan üçü aynı gezide görülebilir.",
        "At the foot of Ayasuluk Hill in Selçuk, between the Temple of Artemis and the Basilica of St John, the İsa Bey "
        "Mosque was built in 1374-1375 in the name of the Aydınid ruler İsa Bey. Designed by the Damascene architect Ali "
        "ibn Mushaimish, its plan draws on the Great Mosque of Damascus, and it is counted among the most impressive "
        "buildings of the Anatolian beyliks. In the 19th century it was used for a time as a caravanserai.\n\n"
        "Around the wide courtyard and in the prayer hall you can spot granite columns and marble pieces reused from the "
        "ancient city nearby; look closely at the coloured stonework of the west façade and the carving around the "
        "doors. The Basilica of St John and the Temple of Artemis are within walking distance, so all three fit into one visit."),

    "hisar-camii": (1,
        "Kemeraltı'nın Hisarönü bölgesinde, Kızlarağası Hanı'nın yakınındaki Hisar Camii, 1597-1598'de Aydınoğulları "
        "soyundan Molla Yakup Bey tarafından yaptırıldı. Adını, bugün izi kalmayan ve liman ağzını koruyan eski kaleden "
        "(hisar) alır. Şehir merkezinin en büyük tarihi camisidir.\n\n"
        "İçeride kubbe, kemerler ve ahşap mahfil boyunca uzanan kalem işleri, İzmir'deki Osmanlı süsleme sanatının en "
        "zengin örneklerindendir. Avludaki şadırvan ve çevresindeki çay ocakları, çarşının kalabalığında sakin bir mola "
        "verir. Kızlarağası Hanı ve Kemeraltı'nın ara sokaklarıyla birlikte gezilebilir; namaz vakitlerinde içeriyi "
        "gezmeyi ertelemek gerekir.",
        "In the Hisarönü quarter of Kemeraltı, near the Kızlarağası Han, the Hisar Mosque was built in 1597-1598 by Molla "
        "Yakup Bey, a descendant of the Aydınid dynasty. It takes its name from the old fortress (hisar) that once "
        "guarded the harbour entrance and has since disappeared. It is the largest historic mosque in the city centre.\n\n"
        "Inside, the painted decoration running across the dome, arches and wooden gallery is one of the richest "
        "examples of Ottoman ornament in İzmir. The fountain in the courtyard and the tea stalls around it offer a calm "
        "break from the bustle of the bazaar. Combine it with the Kızlarağası Han and the back streets of Kemeraltı; "
        "avoid visiting the interior during prayer times."),

    "konak-camii": (1,
        "Konak Meydanı'nda, Saat Kulesi'nin hemen yanındaki Konak Camii, Yalı Camii adıyla da bilinir. 18. yüzyılın "
        "ortasında, dönemin valisi Katipzade Mehmed Paşa'nın eşi Ayşe Hanım adına yaptırıldı. Denize çok yakın "
        "olduğu dönemlerde kıyıda duran bu küçük cami, adını buradan alır.\n\n"
        "Sekizgen gövdesi ve dışını kaplayan firuze-mavi Kütahya çinileriyle şehrin en tanınmış simgelerinden biridir. "
        "Saat Kulesi, Hükümet Konağı ve deniz kıyısıyla birlikte meydanın fotoğrafını tamamlar. Küçük olduğu için "
        "ziyaret kısa sürer; Kemeraltı'na buradan girerek çarşı gezisine başlayabilirsiniz.",
        "On Konak Square, right next to the Clock Tower, the Konak Mosque is also known as the Yalı (Waterfront) Mosque. "
        "It was built in the mid-18th century for Ayşe Hanım, wife of the governor Katipzade Mehmed Pasha. In the days "
        "when the sea came closer, this small mosque stood right on the shore, hence its second name.\n\n"
        "Its octagonal body clad in turquoise Kütahya tiles makes it one of the city's best-known landmarks. Together "
        "with the Clock Tower, the Government House and the seafront it completes the classic view of the square. A "
        "visit is short given its size; from here you can walk straight into Kemeraltı to start exploring the bazaar."),

    "basdurak-camii": (1,
        "Kemeraltı'nın ana arteri Anafartalar Caddesi üzerindeki Başdurak Camii, 1652'de Hacı Hüseyin Ağa tarafından "
        "yaptırıldı. Evliya Çelebi, banisinin bir tahıl tüccarı olduğunu aktarır; cami uzun süre onun adıyla, Hacı "
        "Hüseyin Camii olarak anıldı.\n\n"
        "Kare bir plan üzerinde tek büyük kubbeyle örtülü yapı, çarşının dükkânları arasında birden karşınıza çıkar. "
        "Kalabalık caddeden avluya adım atınca çarşının sesi azalır; kısa bir mola için uygun bir duraktır. Kemeraltı "
        "gezisinde Hisar, Şadırvanaltı ve Kestanepazarı camileriyle aynı rotada görülebilir.",
        "On Anafartalar Street, the main artery of Kemeraltı, the Başdurak Mosque was built in 1652 by Hacı Hüseyin Ağa. "
        "The traveller Evliya Çelebi records that its founder was a grain merchant, and for a long time it was known by "
        "his name as the Hacı Hüseyin Mosque.\n\n"
        "Set on a square plan and covered by a single large dome, it appears suddenly among the bazaar's shops. Step "
        "from the busy street into the courtyard and the noise of the market fades, making it a good place for a short "
        "pause. It fits on the same Kemeraltı route as the Hisar, Şadırvanaltı and Kestanepazarı mosques."),

    "aydinoglu-mehmet-bey-camii": (1,
        "Birgi'deki Aydınoğlu Mehmet Bey Camii, Ulu Cami olarak da bilinir. Aydınoğulları Beyliği'nin kurucusu Mehmet "
        "Bey tarafından 1312'de yaptırıldı ve beyliğin inşa ettirdiği ilk camidir. Birgi o dönemde beyliğin "
        "başkentiydi; cami, hamam ve medreseyle birlikte bir külliye olarak düzenlenmişti.\n\n"
        "İçerideki ceviz ağacından, geçme tekniğiyle yapılmış minber Anadolu ahşap işçiliğinin başyapıtlarından "
        "sayılır; mihraptaki çiniler ve minaredeki sırlı tuğla süslemeler de görülmeye değer. Avlunun yanında Mehmet "
        "Bey'in türbesi bulunur. Birgi'nin taş sokakları ve Çakırağa Konağı ile birlikte yarım günlük bir gezi yapılabilir.",
        "The Aydınoğlu Mehmet Bey Mosque in Birgi is also known as the Grand Mosque. It was commissioned in 1312 by "
        "Mehmet Bey, founder of the Aydınid principality, and is the first mosque the dynasty built. Birgi was then "
        "the capital of the beylik, and the mosque formed a complex together with a bath and a madrasa.\n\n"
        "Inside, the walnut pulpit made with interlocking joinery is regarded as a masterpiece of Anatolian woodwork, "
        "and the tiles of the mihrab and the glazed brick decoration on the minaret are also worth seeing. Mehmet Bey's "
        "tomb stands beside the courtyard. Combine it with Birgi's stone streets and the Çakırağa Mansion for a half-day trip."),

    "salepcioglu-camii": (1,
        "Kemeraltı'ndaki Salepçioğlu Camii, Salepçizade Hacı Ahmed Ağa'nın vasiyeti üzerine 1897-1905 yılları arasında "
        "yapıldı. Osmanlı'nın son döneminde İzmir'de inşa edilen önemli camilerdendir ve banisinin adını taşır.\n\n"
        "Dış duvarlarında kesme taş ile mermer birlikte kullanılmış; ana kubbenin önünde giriş tarafında üç küçük kubbe "
        "yer alır. İçerideki kalem işleri ve renkli süslemeler, 19. yüzyılın sonundaki batılılaşma etkisini de "
        "yansıtır. Çarşının ortasında olduğundan Kemeraltı gezisi sırasında kısa bir durak olarak görülebilir.",
        "Salepçioğlu Mosque in Kemeraltı was built between 1897 and 1905 according to the will of Salepçizade Hacı "
        "Ahmed Ağa, whose name it bears. It is one of the notable mosques built in İzmir in the last decades of the "
        "Ottoman Empire.\n\n"
        "Its outer walls combine cut stone and marble, and three small domes sit in front of the main dome on the "
        "entrance side. The painted and coloured decoration inside also reflects the Western influences of the late "
        "19th century. Being in the middle of the bazaar, it makes a short stop on a Kemeraltı walk."),

    "kestanepazari-camii": (1,
        "Kemeraltı'nın Kestanepazarı bölgesindeki cami, Kızıl İbrahim ya da Ahmed Ağa Camii adlarıyla da anılır. "
        "Evliya Çelebi'nin kaydettiği kitabeye göre 1667-1668'de Ahmed Ağa tarafından yaptırıldı; sonraki yüzyıllarda "
        "genişletilerek bugünkü görünümünü 19. yüzyılda aldı.\n\n"
        "Taş ve mermerin birlikte kullanıldığı yapı, çarşının en işlek sokaklarından birinin ortasında yer alır. "
        "Çevresindeki dükkânlar ve kahveciler, Kemeraltı'nın günlük hayatını en canlı haliyle görebileceğiniz "
        "yerlerdendir. Hisar ve Şadırvanaltı camileriyle aynı yürüyüşte görülebilir.",
        "Also known as the Kızıl İbrahim or Ahmed Ağa Mosque, this mosque stands in the Kestanepazarı (Chestnut Market) "
        "quarter of Kemeraltı. According to an inscription recorded by Evliya Çelebi it was built by Ahmed Ağa in "
        "1667-1668; it was enlarged in later centuries and took its present form in the 19th century.\n\n"
        "Built of stone and marble, it sits in the middle of one of the bazaar's busiest streets. The shops and coffee "
        "sellers around it are among the best places to see everyday life in Kemeraltı at its liveliest. It fits on "
        "the same walk as the Hisar and Şadırvanaltı mosques."),

    "bergama-kursunlu-cami": (1,
        "Bergama'nın merkezindeki Kurşunlu Cami, doğu cephesindeki kitabeye göre 1439'da Safi oğlu Hacı Hasan "
        "tarafından yaptırıldı. Adını, kubbesini örten kurşun kaplamadan alır ve kentin erken Osmanlı dönemi "
        "yapılarındandır.\n\n"
        "Kesme taştan, kare planlı bu sade camiyi yaklaşık dokuz metre çapındaki kubbe örter; taş kaide üzerine "
        "tuğladan yükselen tek şerefeli minaresi uzaktan tanınır. Bergama çarşısının içinde kaldığı için Kızıl Avlu ve "
        "Ulu Cami ile birlikte kısa bir şehir yürüyüşünde görülebilir.",
        "According to the inscription on its east façade, the Kurşunlu Mosque in central Bergama was built in 1439 by "
        "Hacı Hasan, son of Safi. It takes its name from the lead covering its dome and is one of the town's early "
        "Ottoman buildings.\n\n"
        "This plain, square mosque of cut stone is covered by a dome about nine metres across, and its single-balcony "
        "brick minaret on a stone base is easy to recognise. As it stands within Bergama's market area, it can be seen "
        "on a short town walk together with the Red Basilica and the Grand Mosque."),

    "bergama-ulu-cami": (1,
        "Bergama Ulu Cami, Yıldırım Camii olarak da bilinir. Kitabesine göre Osmanlı Sultanı I. Bayezid (Yıldırım) "
        "tarafından 1398-1399'da yaptırıldı ve kentin en eski camilerinden biridir.\n\n"
        "Sade dış görünüşüne karşın iç mekândaki ahşap minber ve mihrap çevresi dikkatle bakmaya değer. Bergama'nın "
        "eski çarşı sokakları arasında yer aldığından Kurşunlu Cami ve Kızıl Avlu ile birlikte yürüyerek gezilebilir; "
        "Pergamon ören yerine çıkmadan önce kısa bir durak olarak uygundur.",
        "The Grand Mosque of Bergama is also known as the Yıldırım Mosque. According to its inscription it was built in "
        "1398-1399 by the Ottoman Sultan Bayezid I (Yıldırım), making it one of the oldest mosques in the town.\n\n"
        "Despite its plain exterior, the wooden pulpit and the area around the mihrab deserve a closer look. Set among "
        "the old market streets of Bergama, it can be visited on foot together with the Kurşunlu Mosque and the Red "
        "Basilica, and makes a good short stop before heading up to the ruins of Pergamon."),

    "tire-ulu-camii": (1,
        "Tire Ulu Camii, ilçenin en eski ve en büyük camilerindendir. 14. yüzyılın ilk yarısında, Aydınoğulları "
        "döneminde inşa edildiği; ardından Aydınoğlu Cüneyd Bey tarafından yeniden yaptırıldığı bilinir. Kuzey kapısı "
        "üzerindeki 1870 tarihli kitabe sonraki bir onarımı kaydeder.\n\n"
        "Tire, Aydınoğulları ve Osmanlı döneminden kalma pek çok cami, han ve medreseye sahiptir; Ulu Cami bu dokunun "
        "merkezindedir. Salı günleri kurulan ve bölgenin en canlı pazarlarından sayılan Tire pazarı ile aynı gün "
        "gezilirse ilçenin tarihi ve günlük hayatı birlikte görülür.",
        "The Grand Mosque of Tire is one of the oldest and largest mosques in the town. It is known to have been built "
        "in the first half of the 14th century under the Aydınids and later rebuilt by the Aydınid ruler Cüneyd Bey; "
        "an inscription of 1870 over the north door records a later repair.\n\n"
        "Tire has many mosques, inns and madrasas from the Aydınid and Ottoman periods, and the Grand Mosque stands at "
        "the heart of this historic fabric. Visit on a Tuesday, when Tire's market, one of the liveliest in the region, "
        "is held, to see the town's history and daily life together."),

    "sadirvanalti-camii": (1,
        "Kemeraltı'ndaki Şadırvanaltı Camii, 1636'da Bıyıklıoğlu Mahmut Ağa tarafından yaptırıldı. Adını, caminin "
        "altında yer alan şadırvandan alır. Birkaç yangın geçiren yapı 19. yüzyılda onarıldı; 1834'te bir kütüphane "
        "ve muvakkithane eklendi.\n\n"
        "Caminin alt katında dükkânlar bulunur, ibadet mekânı bunların üzerine oturur; bu düzen, çarşı içindeki "
        "Osmanlı camilerinin ilginç bir örneğidir. Arkasındaki küçük meydan ve kahveler, Kemeraltı'nda soluklanmak "
        "için iyi bir yerdir. Hisar Camii ve Kızlarağası Hanı birkaç dakikalık yürüme mesafesindedir.",
        "The Şadırvanaltı Mosque in Kemeraltı was built in 1636 by Bıyıklıoğlu Mahmut Ağa. Its name means 'under the "
        "fountain', after the ablution fountain beneath the mosque. Damaged by several fires, it was repaired in the "
        "19th century, and a library and timekeeper's room were added in 1834.\n\n"
        "Shops occupy the ground floor and the prayer hall sits above them, an interesting example of an Ottoman mosque "
        "woven into a bazaar. The small square and cafés behind it are a good place to catch your breath in Kemeraltı. "
        "The Hisar Mosque and the Kızlarağası Han are a few minutes' walk away."),

    "meryem-ana-evi": (1,
        "Selçuk'a yaklaşık 7 km uzaklıkta, Bülbül Dağı'nın ağaçlık yamacındaki Meryem Ana Evi, Hz. Meryem'in son "
        "yıllarını geçirdiğine inanılan yer olarak ziyaret edilir. Ev, 19. yüzyılda Alman rahibe Anne Catherine "
        "Emmerich'in anlattığı görümlerdeki tarif izlenerek bulundu. Katolik Kilisesi bu konuda resmi bir hüküm "
        "vermemiştir; ancak birçok papa burayı ziyaret etmiştir.\n\n"
        "Taştan küçük yapı bugün bir şapel olarak düzenlenmiştir; içeride sessiz kalmak ve fotoğraf kurallarına uymak "
        "gerekir. Aşağıdaki çeşmeler ve ziyaretçilerin dileklerini bağladığı dilek duvarı da gezinin parçasıdır. "
        "Hristiyanlar kadar Müslümanlar için de saygın bir mekândır; 15 Ağustos'ta düzenlenen ayin kalabalık olur.",
        "About 7 km from Selçuk, on the wooded slopes of Mount Koressos (Bülbül Dağı), the House of the Virgin Mary is "
        "visited as the place where Mary is believed to have spent her last years. The house was located in the 19th "
        "century by following descriptions in the visions of the German nun Anne Catherine Emmerich. The Catholic Church "
        "has made no official ruling, but several popes have visited.\n\n"
        "The small stone building is now arranged as a chapel; visitors are asked to keep quiet and follow the photo "
        "rules. The fountains below and the wishing wall, where visitors tie their wishes, are part of the visit. It is "
        "revered by Muslims as well as Christians, and the service held on 15 August draws large crowds."),

    "aziz-yuhanna-katedrali": (1,
        "Alsancak'taki Aziz Yuhanna Katedrali, İzmir Katolik Başpiskoposluğu'nun merkezidir ve adını İncil yazarı "
        "Yuhanna'dan alır. Temeli 1862'de atıldı, 1874'te ibadete açıldı. Yapımı sırasında Sultan Abdülaziz'in büyük "
        "bir altın bağışı yaptığı, ana sunağın ise Papa IX. Pius'un hediyesi olduğu bilinir.\n\n"
        "İçerideki tavan resimleri, vitraylar ve mermer sunak, kentin Levanten geçmişinin en güzel izlerindendir. "
        "Ayinler sırasında ziyaret yerine katılım beklenir; diğer zamanlarda sessizce gezilebilir. Alsancak'ın tarihi "
        "sokakları ve Kordon birkaç dakikalık yürüyüş uzaklığındadır.",
        "St John's Cathedral in Alsancak is the seat of the Catholic Archdiocese of İzmir and is dedicated to John the "
        "Evangelist. Its cornerstone was laid in 1862 and it opened in 1874. Sultan Abdülaziz is known to have made a "
        "large donation in gold during its construction, and the high altar was a gift from Pope Pius IX.\n\n"
        "The ceiling paintings, stained glass and marble altar are among the finest traces of the city's Levantine past. "
        "During services visitors are expected to take part rather than tour; at other times it can be visited quietly. "
        "The historic streets of Alsancak and the Kordon promenade are a few minutes' walk away."),

    "aziz-polikarp-kilisesi": (1,
        "Aziz Polikarp Kilisesi, İzmir'de bugün de kullanılan en eski kilisedir. Adını, Havari Yuhanna'nın öğrencisi "
        "olduğu kabul edilen ve şehrin ilk piskoposlarından Polikarp'tan alır. 1625'te Osmanlı padişahının izni ve "
        "Fransa Kralı XIII. Louis'nin isteğiyle yapıldı; 1688 depremi ve ardından çıkan yangında zarar görünce "
        "1690-1691'de onarıldı.\n\n"
        "Dışarıdan sade görünen yapının içi, duvarları ve tavanı kaplayan resimlerle şaşırtır; bunlar arasında "
        "Polikarp'ın yaşamından sahneler yer alır. Kilise Konak'a yakın, Necatibey Bulvarı çevresindedir. Ziyaret için "
        "ayin saatleri dışını seçmek ve sessiz kalmak gerekir.",
        "St Polycarp's Church is the oldest church in İzmir still in use. It is named after Polycarp, held to be a "
        "disciple of John the Apostle and one of the city's first bishops. It was built in 1625 with the Ottoman "
        "sultan's permission at the request of King Louis XIII of France; damaged by the 1688 earthquake and the fire "
        "that followed, it was repaired in 1690-1691.\n\n"
        "Plain from the outside, the church surprises with paintings covering its walls and ceiling, including scenes "
        "from the life of Polycarp. It stands near Konak, around Necatibey Boulevard. Choose a time outside services and "
        "keep quiet during your visit."),

    "santa-maria-katolik-kilisesi": (1,
        "Bornova'daki Santa Maria Katolik Kilisesi, kitabesine göre 1831'de Fransiskenler tarafından yapıldı. 19. "
        "yüzyılda Bornova'ya yerleşen Levanten aileler için inşa edilen kilise, ilçenin çok kültürlü geçmişinin "
        "simgelerindendir. 1970'lerde Cumhuriyet Meydanı düzenlenirken çevresindeki arazi küçüldü.\n\n"
        "Neo-Bizans etkili cephesi ve çan kulesiyle meydanın bir köşesinde hemen fark edilir. Çevredeki Levanten "
        "köşkleri ve Ege Üniversitesi yerleşkesine uzanan sokaklarla birlikte bir Bornova yürüyüşüne eklenebilir. Ayin "
        "olmayan saatlerde sessizce ziyaret edilmelidir.",
        "According to its inscription, St Mary's Catholic Church in Bornova was built by the Franciscans in 1831. "
        "Built for the Levantine families who settled in Bornova in the 19th century, it is a symbol of the district's "
        "multicultural past. Its grounds shrank in the 1970s when Cumhuriyet Square was laid out.\n\n"
        "With its Neo-Byzantine-style façade and bell tower it stands out on a corner of the square. Add it to a Bornova "
        "walk past the Levantine mansions and the streets leading towards the Ege University campus. Visit quietly "
        "outside service times."),

    "ayios-haralambos-kilisesi": (1,
        "Çeşme'nin merkezindeki Ayios Haralambos Kilisesi, 19. yüzyılın ilk yarısında kasabanın Rum Ortodoks topluluğu "
        "için yapıldı. Nüfus mübadelesinden sonra ibadete kapanan yapı, onarımın ardından kültür ve sanat etkinliklerine "
        "ev sahipliği yapmaya başladı.\n\n"
        "Bugün sergi salonu olarak kullanılır; yaz aylarında resim, fotoğraf ve el sanatları sergileri açılır. Taş "
        "cephesi ve çan kulesiyle Çeşme Kalesi'ne giden ana caddenin üzerinde kolayca bulunur. Kale, kervansaray ve "
        "liman yürüyüşüyle aynı gezide görülebilir.",
        "In the centre of Çeşme, the Church of St Charalambos was built in the first half of the 19th century for the "
        "town's Greek Orthodox community. Closed to worship after the population exchange, it was restored and began "
        "hosting cultural and art events.\n\n"
        "Today it serves as an exhibition hall, with painting, photography and craft shows in the summer months. With "
        "its stone façade and bell tower it is easy to find on the main street leading to Çeşme Castle. It fits into "
        "the same walk as the castle, the caravanserai and the harbour."),

    "bet-israel-sinagogu": (1,
        "Karataş'ta, Mithatpaşa Caddesi üzerindeki Bet İsrael Sinagogu 1907'de ibadete açıldı. Sultan II. Abdülhamid'in "
        "izniyle, semtte yaşayan Yahudi topluluğu için yapıldı. İzmir'in en büyük sinagogudur ve bugün de kullanılır; "
        "1950'lerde yapılan onarımla bugünkü görünümünü aldı.\n\n"
        "Karataş, İzmir Yahudilerinin 19. yüzyılın sonundan itibaren yoğun yaşadığı semtlerdendir; Tarihi Asansör ve "
        "Dario Moreno Sokağı aynı yürüyüşte görülebilir. Sinagog ziyareti güvenlik nedeniyle önceden topluluk "
        "aracılığıyla ayarlanmalıdır.",
        "On Mithatpaşa Street in Karataş, the Bet Israel Synagogue opened in 1907. It was built with the permission of "
        "Sultan Abdülhamid II for the Jewish community living in the quarter. It is the largest synagogue in İzmir and "
        "is still in use; it took its present appearance after a restoration in the 1950s.\n\n"
        "Karataş was home to much of İzmir's Jewish community from the late 19th century; the Historic Elevator and "
        "Dario Moreno Street can be seen on the same walk. For security reasons, visits to the synagogue should be "
        "arranged in advance through the community."),

    "sinyora-giveret-sinagogu": (1,
        "Kemeraltı'ndaki Havra Sokağı'nın tarihi sinagoglarından Sinyora Giveret, 16. yüzyılda Portekizli Yahudi "
        "tüccar Dona Gracia Mendes adına kurulduğu kabul edilir; adı 'Hanımefendi' anlamına gelir. 1841'deki büyük "
        "yangında ağır hasar gördü ve sonrasında yeniden onarıldı. Bugün de ibadete açıktır.\n\n"
        "Havra Sokağı ve çevresi, birbirine çok yakın birkaç tarihi sinagoguyla İzmir'in Yahudi mirasının merkezidir; "
        "sokağın balık ve sebze tezgâhları da çarşının en canlı köşelerindendir. Sinagogların içini görmek için "
        "önceden izin ve rehberli ziyaret gerekir.",
        "One of the historic synagogues of Havra Street in Kemeraltı, Signora Giveret is held to have been founded in "
        "the 16th century in the name of the Portuguese Jewish merchant Doña Gracia Mendes; its name means 'the Lady'. "
        "It was badly damaged in the great fire of 1841 and later restored. It is still used for worship.\n\n"
        "With several historic synagogues close together, Havra Street and its surroundings form the heart of İzmir's "
        "Jewish heritage, and the street's fish and vegetable stalls are among the liveliest corners of the bazaar. "
        "Seeing the interiors requires prior permission and a guided visit."),

    "etz-hayim-sinagogu": (1,
        "Havra Sokağı'ndaki Etz Hayim Sinagogu, İzmir'in en eski sinagogu olarak kabul edilir; kökeninin Bizans "
        "dönemine kadar uzandığı düşünülür. Adı İbranicede 'Hayat Ağacı' anlamına gelir. 1841 yangınında zarar gördü, "
        "1851'de onarıldı.\n\n"
        "Bugün düzenli ibadete kapalıdır, ancak kapsamlı restorasyonu ödülle tanınmış ve İzmir Yahudi Mirası "
        "çalışmalarının parçası olmuştur. Avlusu ve ahşap iç düzeni, sokaktaki diğer sinagoglarla birlikte rehberli "
        "turlarda görülebilir; ziyaret önceden ayarlanmalıdır.",
        "The Etz Hayim Synagogue on Havra Street is regarded as the oldest synagogue in İzmir; its origins are thought "
        "to go back to the Byzantine period. Its name means 'Tree of Life' in Hebrew. It was damaged in the fire of 1841 "
        "and restored in 1851.\n\n"
        "It is no longer used for regular worship, but its thorough restoration has won an award and it is part of the "
        "İzmir Jewish Heritage work. Its courtyard and wooden interior can be seen on guided tours together with the "
        "street's other synagogues; visits must be arranged in advance."),

    "algazi-sinagogu": (1,
        "Havra Sokağı'ndaki Algazi Sinagogu, 1724'te Algazi ailesi tarafından yaptırıldı. 1841 yangınında zarar gördü ve "
        "sonraki yüzyıllarda birkaç kez onarıldı; Bet İsrael'den sonra şehrin en büyük sinagogu sayılır.\n\n"
        "Tek katlı taş yapının içinde kadınlar için ayrılmış bölüm ve ahşap ayrıntılar dikkat çeker. Kemeraltı'nın "
        "Yahudi mirası rotasında, Sinyora Giveret ve Etz Hayim sinagoglarıyla birlikte rehberli olarak gezilebilir; "
        "ziyaret için önceden izin almak gerekir.",
        "The Algazi Synagogue on Havra Street was built in 1724 by the Algazi family. Damaged in the fire of 1841, it "
        "was restored several times over the following centuries and is counted as the city's largest synagogue after "
        "Bet Israel.\n\n"
        "Inside the single-storey stone building, the women's section and the wooden details stand out. On Kemeraltı's "
        "Jewish heritage route it can be visited with a guide together with the Signora Giveret and Etz Hayim "
        "synagogues; permission must be obtained in advance."),

    "latife-hanim-kosku-ani-evi": (2,
        "Karşıyaka'da, Bahriye Üçok Bulvarı üzerindeki bu köşk, Latife Hanım'ın ailesi Uşakizadelerin yazlık eviydi ve "
        "1860'larda yapıldığı düşünülür. Atatürk'ün annesi Zübeyde Hanım, hastalığı nedeniyle 1922'nin sonunda İzmir'e "
        "geldi ve son günlerini burada geçirerek bu evde hayatını kaybetti. Köşk sonraki yıllarda adliye ve dershane "
        "olarak kullanıldı; belediyenin restorasyonunun ardından 2008'de anı evi olarak açıldı.\n\n"
        "Odalarda dönemin mobilyaları ve eşyalarının yanı sıra Atatürk, Latife Hanım ve Zübeyde Hanım'ın balmumu "
        "heykelleri yer alır. Köşk, 2020 Ege Denizi depreminde hasar görünce güçlendirme için geçici olarak "
        "kapatılmıştı; gitmeden önce açık olup olmadığını kontrol edin. Karşıyaka sahili ve çarşısı yakındadır.",
        "On Bahriye Üçok Boulevard in Karşıyaka, this mansion was the summer house of the Uşakizade family, Latife "
        "Hanım's relatives, and is thought to date from the 1860s. Atatürk's mother Zübeyde Hanım came to İzmir because "
        "of illness at the end of 1922, spent her last days here and died in this house. Later used as a courthouse and "
        "a tutoring school, it was restored by the municipality and opened as a memorial house in 2008.\n\n"
        "The rooms show period furniture and belongings, along with wax figures of Atatürk, Latife Hanım and Zübeyde "
        "Hanım. The mansion was closed temporarily for strengthening after damage in the 2020 Aegean Sea earthquake, so "
        "check whether it is open before you go. The Karşıyaka waterfront and market are close by."),

    "forbes-kosku": (2,
        "Buca'daki Forbes Köşkü, ilçede yaşayan Levanten Forbes ailesi tarafından 1908'de yaptırıldı. Bir yıl sonra "
        "çıkan yangında tamamen yandı ve 1910'da yeniden inşa edildi. Forbes'lardan sonra Whittall ailesi burada "
        "yaşadı; 1950'den itibaren uzun yıllar poliklinik olarak kullanıldı ve 1999'da restorasyonuna başlandı.\n\n"
        "Bugün Buca Devlet Hastanesi'nin bahçesinde duran köşk, yakındaki Rees Köşkü'ne benzeyen ama daha karışık bir "
        "üslubu yansıtan cephesiyle Buca'nın Levanten mirasının örneklerindendir. Şirinyer'deki ünlü Forbes Caddesi "
        "adını bu aileden alır. Buca'daki diğer Levanten köşkleriyle birlikte bir yürüyüşe eklenebilir.",
        "Forbes Mansion in Buca was built in 1908 by the Levantine Forbes family who lived in the district. A year "
        "later it burned down completely and was rebuilt in 1910. After the Forbes family the Whittalls lived here; from "
        "1950 it served for many years as an outpatient clinic, and restoration began in 1999.\n\n"
        "Standing today in the garden of Buca State Hospital, it is an example of Buca's Levantine heritage, with a "
        "façade similar to the nearby Rees Mansion but in a more mixed style. The well-known Forbes Street in Şirinyer "
        "takes its name from the family. Add it to a walk past Buca's other Levantine mansions."),

    "bizans-sarayi": (2,
        "Efes ören yerinin kuzey kesiminde kalan bu büyük yapı kalıntısı, Bizans Sarayı olarak anılır. Geç antik "
        "çağda, kentin önemli bir yöneticisine ya da din adamına ait konut ve kabul mekânı olduğu düşünülür; büyük "
        "salonları ve kalın tuğla duvarları, Efes'in Hristiyanlık döneminde de önemli bir merkez olduğunu gösterir.\n\n"
        "Ana gezi yolunun biraz dışında kaldığı için çoğu ziyaretçi uğramaz; kalabalıktan uzak bir köşe arıyorsanız "
        "Meryem Kilisesi ve Liman Hamamı yönüne doğru yürürken görebilirsiniz. Kalıntıların üzerine çıkmayın ve "
        "işaretli yollarda kalın.",
        "This large ruined building in the northern part of the Ephesus site is known as the Byzantine Palace. It is "
        "thought to have been the residence and reception hall of an important official or churchman in late "
        "antiquity; its great halls and thick brick walls show that Ephesus remained a major centre in the Christian era.\n\n"
        "Lying a little off the main route, it is skipped by most visitors; if you want a quieter corner, you can see it "
        "while walking towards the Church of Mary and the Harbour Baths. Do not climb on the ruins and stay on the "
        "marked paths."),

    "v-sarayi": (2,
        "Pergamon akropolünün tepesinde, Bergama krallarının saraylarının bulunduğu bölümde yer alan V Sarayı, "
        "bunların en büyüğüdür. Kral II. Eumenes'e ait olduğu düşünülür. Ortasında sütunlu bir avlu bulunan sarayın "
        "odaları mozaiklerle süslüydü; buradan çıkan mozaiklerin bir kısmı bugün Berlin'dedir.\n\n"
        "Bugün görülenler temel duvarları ve avlunun planıdır; buna karşın krallığın gücünü hissettiren bir konumdadır. "
        "Akropolde Trajan Tapınağı, tiyatro ve Athena Kutsal Alanı'na giderken yolunuzun üzerindedir. Teleferikle "
        "çıkılan akropol rüzgârlı ve gölgesizdir; şapka ve su almayı unutmayın.",
        "On the summit of the Pergamon acropolis, in the area where the Attalid kings' palaces stood, Palace V is the "
        "largest of them. It is thought to have belonged to King Eumenes II. Its rooms, arranged around a colonnaded "
        "courtyard, were decorated with mosaics, some of which are now in Berlin.\n\n"
        "What you see today are the foundation walls and the courtyard plan, yet the setting still conveys the power of "
        "the kingdom. It lies on your way to the Temple of Trajan, the theatre and the Sanctuary of Athena. The acropolis, "
        "reached by cable car, is windy and has little shade, so bring a hat and water."),

    "efes-muzesi": (2,
        "Selçuk'taki Efes Müzesi, Efes ve çevresindeki kazılardan çıkan eserleri sergiler. Müzenin en ünlü parçaları, "
        "Artemis'in göğsü yumurta ya da boğa testisi biçiminde süslemelerle kaplı heykelleridir. 2012 sonunda yenileme "
        "için kapanan müze, düzenlemesi yenilenerek yeniden açıldı.\n\n"
        "Yamaç evlerden çıkan eşyalar, yunus üzerindeki Eros heykeli, fildişi kabartmalar ve gladyatör mezarlarına "
        "ayrılan bölüm görülmeye değer. Ören yerinden önce ya da sonra gezilmesi, Efes'te gördüklerinizi "
        "tamamlar; Selçuk merkezde, İsa Bey Camii ve Aziz Yuhanna Bazilikası'na yürüme mesafesindedir.",
        "The Ephesus Museum in Selçuk displays finds from the excavations at Ephesus and the surrounding area. Its most "
        "famous pieces are the statues of Artemis covered with egg- or bull-testicle-shaped ornaments on the chest. "
        "Closed for renovation at the end of 2012, it reopened with a new display.\n\n"
        "Objects from the Terrace Houses, the statue of Eros on a dolphin, the ivory reliefs and the section on the "
        "gladiators' graves are worth seeing. Visiting before or after the ruins completes what you see at Ephesus; it "
        "is in central Selçuk, within walking distance of the İsa Bey Mosque and the Basilica of St John."),

    "izmir-arkeoloji-muzesi": (2,
        "Konak'ta, Bahribaba Parkı'nın içindeki İzmir Arkeoloji Müzesi, kökeni 1920'lere uzanan kentin en köklü "
        "müzelerindendir; bugünkü binasına 1980'lerde taşındı. İzmir ve Batı Anadolu'daki kazılardan çıkan, Tunç "
        "Çağı'ndan Roma ve Bizans dönemlerine uzanan eserleri sergiler.\n\n"
        "Bahçede ve salonlarda lahitler, heykeller ve mimari parçalar; içeride küçük buluntular, cam eserler ve sikke "
        "ile takıların yer aldığı hazine bölümü vardır. Antik Smyrna'yı anlamak için Agora ile birlikte gezilmesi "
        "önerilir. Hemen karşısındaki Etnografya Müzesi aynı ziyarete eklenebilir.",
        "Set in Bahribaba Park in Konak, the İzmir Archaeological Museum is one of the city's oldest museums, with roots "
        "in the 1920s; it moved to its present building in the 1980s. It displays finds from excavations in İzmir and "
        "western Anatolia, from the Bronze Age to the Roman and Byzantine periods.\n\n"
        "Sarcophagi, statues and architectural pieces fill the garden and halls, while inside are small finds, glass and "
        "a treasury section with coins and jewellery. Visit it together with the Agora to understand ancient Smyrna. The "
        "Ethnography Museum just across the way makes an easy addition."),

    "izmir-agorasi": (2,
        "Konak'taki İzmir Agorası, antik Smyrna'nın devlet agorasıydı. MÖ 4. yüzyılda kurulan agora, MS 178 depreminde "
        "yıkılınca Roma İmparatoru Marcus Aurelius'un desteğiyle yeniden yapıldı. Osmanlı döneminde üzerinde mezarlık "
        "ve namazgâh bulunuyordu; kazılar 20. yüzyılda başladı ve bugün de sürüyor.\n\n"
        "Ayakta kalan sütun dizileri, Faustina Kapısı ve büyük bazilikanın tonozlu bodrum katı en etkileyici "
        "bölümleridir. Bodrumda, kaynak sularının aktığı kanallar ve antik duvar yazıları (grafitiler) görülebilir. "
        "Kemeraltı'na çok yakın olduğundan çarşı gezisiyle birleştirmek kolaydır.",
        "The Agora in Konak was the state agora of ancient Smyrna. Founded in the 4th century BC, it was destroyed by "
        "the earthquake of AD 178 and rebuilt with the support of the Roman Emperor Marcus Aurelius. In Ottoman times a "
        "cemetery and an open-air prayer place stood on top of it; excavations began in the 20th century and continue today.\n\n"
        "The standing colonnades, the Faustina Gate and the vaulted basement of the great basilica are the most "
        "impressive parts. In the basement you can see channels where spring water still runs and ancient wall graffiti. "
        "Being very close to Kemeraltı, it is easy to combine with a walk through the bazaar."),

    "tcg-pirireis-s-343": (2,
        "İnciraltı'nda müze gemisi olarak sergilenen TCG Pirireis, 1949'da ABD'de USS Tang adıyla denize indirilen bir "
        "denizaltıdır. 1980'de Türk Deniz Kuvvetleri'ne katılarak TCG Pirireis adını aldı ve uzun yıllar hizmet verdi; "
        "görevden ayrıldıktan sonra müzeye dönüştürüldü.\n\n"
        "İçeride torpido odaları, makine dairesi, kumanda bölümü ve mürettebatın dar yatakhaneleri gezilir; bir "
        "denizaltıda yaşamın ne kadar sıkışık olduğunu yakından görürsünüz. Geçitler dar ve basamaklar dik olduğu için "
        "rahat ayakkabı giyin. İnciraltı sahili ve kent ormanıyla aynı gün gezilebilir.",
        "Displayed as a museum ship at İnciraltı, TCG Pirireis is a submarine launched in the United States in 1949 as "
        "USS Tang. She joined the Turkish Navy in 1980 under the name TCG Pirireis and served for many years, and was "
        "turned into a museum after being decommissioned.\n\n"
        "Inside you walk through the torpedo rooms, engine room, control room and the crew's narrow bunks, and see "
        "first-hand how cramped life on a submarine was. Passages are tight and the steps steep, so wear comfortable "
        "shoes. It can be combined with the İnciraltı seafront and city forest on the same day."),

    "izmir-kadin-muzesi": (2,
        "Basmane yakınlarında, cumbalı tipik bir İzmir evinde bulunan İzmir Kadın Müzesi, 2014'te Konak Belediyesi "
        "tarafından açıldı. Türkiye'de kendi binasında kurulan ilk kadın müzesidir.\n\n"
        "Üç katlı evde İzmir'in ilk kadın sanatçıları, sporcuları, öğretmenleri ve siyasetçileri gibi öncü kadınların "
        "hikâyeleri fotoğraf ve eşyalarla anlatılır. Küçük ve sakin bir müzedir; Kemeraltı'nın üst kısmından ya da "
        "Agora'dan kısa bir yürüyüşle ulaşılabilir.",
        "Housed in a typical İzmir house with a bay window near Basmane, the İzmir Women's Museum was opened by Konak "
        "Municipality in 2014. It was the first women's museum in Turkey to have its own building.\n\n"
        "Across three floors, photographs and belongings tell the stories of pioneering women of İzmir, including the "
        "city's first female artists, athletes, teachers and politicians. It is a small, quiet museum, reached on a "
        "short walk from the upper end of Kemeraltı or from the Agora."),

    "bergama-muzesi": (2,
        "Bergama Müzesi, 1936'dan beri ilçenin merkezinde hizmet veren arkeoloji ve etnografya müzesidir. Pergamon'da "
        "1878'de başlayan kazılardan ve Asklepion'da 1920'lerde başlayan çalışmalardan çıkan eserler burada "
        "korunur.\n\n"
        "Heykeller, kabartmalar, sikkeler ve küçük buluntuların yanında, bugün Berlin'deki Zeus Sunağı'nın maketi "
        "ziyaretçilere sunağın asıl görünüşünü gösterir. Etnografya bölümünde yöre halılarından ve gündelik "
        "eşyalardan örnekler vardır. Akropol ve Asklepion'u gezmeden önce uğramak, kalıntıları anlamayı kolaylaştırır.",
        "The Bergama Museum has served as the town's archaeology and ethnography museum since 1936. It keeps finds from "
        "the excavations at Pergamon, begun in 1878, and from the work at the Asklepion that started in the 1920s.\n\n"
        "Alongside sculptures, reliefs, coins and small finds, a model of the Altar of Zeus, now in Berlin, shows how "
        "the altar originally looked. The ethnography section has examples of local carpets and everyday objects. A "
        "visit before the acropolis and the Asklepion makes the ruins easier to understand."),

    "izmir-ataturk-muzesi": (2,
        "Kordon'daki İzmir Atatürk Müzesi, 1880'de halı tüccarı Agop Ispartalıyan tarafından ailesi için yaptırılan "
        "bir köşkte bulunur. Köşk sonradan Atatürk'e armağan edildi; Atatürk İzmir'e geldiğinde burada kaldı. Müze, "
        "Atatürk'ün İzmir'e gelişinin yıl dönümü olan 11 Eylül 1941'de açıldı.\n\n"
        "Odalarda Atatürk'ün kullandığı eşyalar, giysiler ve dönemin fotoğrafları sergilenir. Denize bakan cephesiyle "
        "Kordon'un en tanınmış yapılarındandır. Ziyaret kısa sürer; Kordon boyunca Alsancak'a yürüyüşle "
        "birleştirilebilir.",
        "The İzmir Atatürk Museum on the Kordon is housed in a mansion built in 1880 by the carpet merchant Agop "
        "Ispartalıyan for his family. The house was later presented to Atatürk, who stayed here on his visits to İzmir. "
        "The museum opened on 11 September 1941, the anniversary of his arrival in the city.\n\n"
        "The rooms display Atatürk's belongings, clothes and photographs from the period. With its façade facing the sea "
        "it is one of the best-known buildings on the Kordon. A visit is short and combines well with a walk along the "
        "seafront to Alsancak."),

    "izmir-etnografya-muzesi": (2,
        "Bahribaba'daki İzmir Etnografya Müzesi, 1831'de neoklasik üslupta yapılan taş bir binadadır. Yapı, Fransızlar "
        "tarafından veba hastaları için St. Roch Hastanesi olarak inşa edildi; sonraki dönemlerde de hastane olarak "
        "kullanıldı ve 1980'lerde müzeye dönüştürüldü.\n\n"
        "İki katta keçe, kalaycılık, çömlekçilik, nalın ve dokuma gibi geleneksel zanaatlar; canlandırılmış bir İzmir "
        "evi odası, gelin odası ve eski bir eczane gibi bölümler yer alır. Arkeoloji Müzesi'nin hemen karşısında "
        "olduğundan ikisi aynı ziyarette gezilebilir.",
        "The İzmir Ethnography Museum in Bahribaba occupies a stone building in the Neoclassical style built in 1831. "
        "It was erected by the French as St Roch Hospital for plague patients, continued to serve as a hospital in later "
        "periods and was turned into a museum in the 1980s.\n\n"
        "Across two floors are traditional crafts such as felt-making, tinsmithing, pottery, clog-making and weaving, "
        "along with a recreated İzmir house room, a bridal chamber and an old pharmacy. It stands just across from the "
        "Archaeological Museum, so the two can be seen in one visit."),

    "umran-baradan-oyun-ve-oyuncak-muzesi": (2,
        "Konak'taki Ümran Baradan Oyun ve Oyuncak Müzesi, seramik sanatçısı Ümran Baradan'ın bağışladığı iki katlı ev "
        "ve oyuncak koleksiyonuyla kuruldu. Konak Belediyesi tarafından işletilen küçük bir müzedir.\n\n"
        "Dünyanın farklı ülkelerinden ve farklı dönemlerden bebekler, tahta ve teneke oyuncaklar ile çocuk oyunlarına "
        "ait eşyalar sergilenir. Çocuklu aileler kadar, kendi çocukluğunun oyuncaklarını görmek isteyen büyükler için "
        "de keyifli bir duraktır. Kısa bir ziyaret için planlayın.",
        "The Ümran Baradan Play and Toy Museum in Konak was founded with the two-storey house and toy collection donated "
        "by the ceramic artist Ümran Baradan. It is a small museum run by Konak Municipality.\n\n"
        "Dolls, wooden and tin toys and objects from children's games from many countries and periods are on display. It "
        "is an enjoyable stop for families with children as well as for adults who want to see the toys of their own "
        "childhood. Plan for a short visit."),

    "arkas-sanat-merkezi": (2,
        "Alsancak'ta, Kordon üzerindeki Arkas Sanat Merkezi Kasım 2011'de açıldı. Uzun süre Fransa Fahri Konsolosluğu "
        "olarak kullanılan tarihi bir köşkte yer alır ve Lucien Arkas'ın oluşturduğu Arkas Koleksiyonu'na ev "
        "sahipliği yapar.\n\n"
        "Müze, koleksiyondan seçkilerin yanı sıra Türk ve Avrupalı sanatçıların eserlerinden oluşan dönemsel "
        "sergiler düzenler; sergiler değiştiği için gitmeden önce güncel programa bakın. Denize bakan konumu nedeniyle "
        "Kordon yürüyüşünde rahatça uğranabilecek bir duraktır.",
        "On the Kordon in Alsancak, the Arkas Art Center opened in November 2011. It occupies a historic mansion long "
        "used by the Honorary Consulate of France and houses the Arkas Collection assembled by Lucien Arkas.\n\n"
        "Besides selections from the collection, the museum holds temporary exhibitions of Turkish and European artists; "
        "check the current programme before you go, as shows change. Facing the sea, it is an easy stop on a walk along "
        "the Kordon."),

    "bostanli-acik-hava-arkeoloji-muzesi": (2,
        "Karşıyaka'nın Bostanlı semtindeki açık hava arkeoloji müzesi 1987'de kuruldu. Körfezin kuzey kıyısındaki "
        "antik yerleşimlerden çıkan, MÖ 10. yüzyıldan MS 3. yüzyıla uzanan eserleri bir arada sergiler.\n\n"
        "Lahitler, mezar stelleri, sütun başlıkları ve yazıtlı taşlar açık havada, yeşillik bir alanda yer alır. Küçük "
        "bir alan olduğu için ziyaret kısa sürer; Bostanlı sahil yolundaki yürüyüş ve bisiklet rotasıyla "
        "birleştirilebilir.",
        "The open-air archaeological museum in the Bostanlı quarter of Karşıyaka was founded in 1987. It brings together "
        "finds from ancient settlements on the northern shore of the gulf, ranging from the 10th century BC to the 3rd "
        "century AD.\n\n"
        "Sarcophagi, grave stelae, column capitals and inscribed stones stand outdoors in a green area. The site is "
        "small, so a visit is short; combine it with the walking and cycling route along the Bostanlı seafront."),

    "cakiraga-konagi": (2,
        "Birgi'deki Çakırağa Konağı, 1761-1764 yılları arasında zengin bir tüccar olan Çakıroğlu Mehmet Bey tarafından "
        "yaptırıldı. Geniş bir bahçe içindeki üç katlı ahşap konak, Osmanlı sivil mimarisinin en iyi korunmuş "
        "örneklerindendir ve restorasyonun ardından müze olarak açıldı.\n\n"
        "Duvarları ve tavanları süsleyen kalem işleri, ahşap oymalar ve özellikle İstanbul ile İzmir'i gösteren "
        "manzara resimleri konağın en ünlü bölümleridir. Odaları gezerken başınızı kaldırıp tavanlara bakmayı "
        "unutmayın. Birgi Ulu Camii ve köyün taş sokaklarıyla birlikte gezilir.",
        "Çakırağa Mansion in Birgi was built between 1761 and 1764 by Çakıroğlu Mehmet Bey, a wealthy merchant. Set in a "
        "large garden, the three-storey timber mansion is one of the best-preserved examples of Ottoman domestic "
        "architecture and opened as a museum after restoration.\n\n"
        "The painted decoration and wood carving on the walls and ceilings, and especially the landscape paintings of "
        "Istanbul and İzmir, are its most famous features. Remember to look up at the ceilings as you go through the "
        "rooms. It is visited together with Birgi's Grand Mosque and the village's stone streets."),

    "cesme-muzesi": (2,
        "Çeşme Kalesi'nin içindeki Çeşme Müzesi, 1965'te silah müzesi olarak kuruldu; nem nedeniyle silahlar başka "
        "müzelere taşınınca 1984'te genel bir müze olarak yeniden düzenlendi.\n\n"
        "Erythrai başta olmak üzere çevredeki antik kentlerden çıkan eserler ile 1770 Çeşme Deniz Savaşı'na ayrılan "
        "bölüm görülebilir. Kale surlarının üzerinden limanı ve kasabayı izlemek ziyaretin en güzel anlarındandır. "
        "Kalenin önündeki Cezayirli Gazi Hasan Paşa heykeli ve kervansaray aynı gezide görülür.",
        "Çeşme Museum, inside Çeşme Castle, was founded in 1965 as a weapons museum; when the weapons were moved to other "
        "museums because of the humidity, it was reorganised as a general museum in 1984.\n\n"
        "You can see finds from the ancient cities around, above all Erythrai, and a section on the Battle of Çeşme of "
        "1770. Watching the harbour and the town from the castle walls is one of the highlights. The statue of Cezayirli "
        "Gazi Hasan Pasha in front of the castle and the caravanserai fit into the same visit."),

    "odemis-muzesi": (2,
        "Ödemiş Müzesi, arsasını 1976'da koleksiyoncu Mutahhar Başoğlu'nun bağışlamasıyla kuruldu ve 1983'te açıldı. "
        "Kent merkezinin biraz doğusunda, ana yol üzerinde yer alan bir arkeoloji ve etnografya müzesidir.\n\n"
        "Antik Hypaipa başta olmak üzere Küçük Menderes havzasındaki yerleşimlerden çıkan heykeller, sikkeler, cam ve "
        "seramik eserler sergilenir; etnografya bölümünde yöreye özgü giysi ve eşyalar vardır. Birgi'ye giderken ya "
        "da dönüşte kısa bir durak olarak planlanabilir.",
        "Ödemiş Museum was founded on land donated in 1976 by the collector Mutahhar Başoğlu and opened in 1983. It is an "
        "archaeology and ethnography museum on the main road just east of the town centre.\n\n"
        "It displays sculptures, coins, glass and pottery from settlements in the Küçük Menderes valley, above all "
        "ancient Hypaipa, while the ethnography section shows local costumes and objects. It makes a short stop on the "
        "way to or from Birgi."),

    "ahmet-piristina-kent-arsivi-ve-muzesi": (2,
        "Ahmet Piriştina Kent Arşivi ve Müzesi, adını fikri ortaya atan Büyükşehir Belediye Başkanı Ahmet Piriştina'dan "
        "alır. Yapımına 1930'da başlanan ve 1932-2001 arasında itfaiye merkezi olarak kullanılan bina, restore edilerek "
        "2004'te müze olarak açıldı.\n\n"
        "Fotoğraflar, haritalar, belgeler ve maketlerle İzmir'in antik çağdan Cumhuriyet'e uzanan kent tarihi anlatılır; "
        "1922 yangını öncesi şehri gösteren görseller özellikle ilgi çeker. Arşiv bölümü araştırmacılara açıktır. "
        "Kültürpark ve Basmane'ye yakındır.",
        "The Ahmet Piriştina City Archives and Museum is named after the metropolitan mayor who proposed it. Its building, "
        "begun in 1930 and used as a fire station from 1932 to 2001, was restored and opened as a museum in 2004.\n\n"
        "Photographs, maps, documents and models tell the story of İzmir from antiquity to the Republic; images of the "
        "city before the fire of 1922 are especially interesting. The archive is open to researchers. It is close to "
        "Kültürpark and Basmane."),

    "key-museum": (2,
        "Torbalı'daki Key Museum, 2015'te açılan büyük bir otomobil ve motosiklet müzesidir. Türkiye'nin bu alandaki en "
        "kapsamlı koleksiyonlarından birine sahiptir ve araçların model yılları 19. yüzyılın sonundan 2000'lere uzanır.\n\n"
        "Klasik otomobiller, yarış arabaları ve motosikletler geniş bir salonda, dönemlerine göre sergilenir; bazı "
        "araçların hikâyeleri de anlatılır. Otomobil meraklıları için birkaç saat ayırmaya değer. İzmir merkezinden "
        "Selçuk-Efes yönüne giderken yol üstünde bir durak olarak planlanabilir.",
        "Key Museum in Torbalı is a large car and motorcycle museum opened in 2015. It holds one of the most extensive "
        "collections of its kind in Turkey, with model years ranging from the late 19th century to the 2000s.\n\n"
        "Classic cars, racing cars and motorcycles are arranged by period in a large hall, and the stories of some "
        "vehicles are told. Car lovers should set aside a couple of hours. It makes a stop on the way from central İzmir "
        "towards Selçuk and Ephesus."),

    "kadifekale": (2,
        "Kadifekale, körfeze hâkim 186 metre yüksekliğindeki Pagos Tepesi'nde yer alır ve antik Smyrna'nın "
        "akropolüdür. Rivayete göre Büyük İskender burada uyurken gördüğü rüya üzerine kentin bu tepenin eteğine "
        "taşınmasını istedi. Kale MÖ 3. yüzyılda kuruldu; Roma, Bizans ve Osmanlı dönemlerinde onarıldı.\n\n"
        "Surların bir bölümü ve kulelerden biri ayaktadır, ama asıl neden manzaradır: körfezin, Konak'ın ve karşı "
        "kıyının en geniş görüntüsü buradan görülür. Gün batımına doğru gidin; çevredeki çay bahçelerinde oturabilirsiniz. "
        "Kemeraltı'ndan yokuş yukarı yürüyüş dik olduğundan taksi ya da otobüs tercih edilebilir.",
        "Kadifekale stands on Mount Pagos, 186 metres above the gulf, and was the acropolis of ancient Smyrna. Legend "
        "says that Alexander the Great, after a dream he had while sleeping here, called for the city to be moved to the "
        "foot of this hill. The castle was founded in the 3rd century BC and repaired in the Roman, Byzantine and Ottoman "
        "periods.\n\n"
        "Parts of the walls and one of the towers still stand, but the real reason to come is the view: the widest "
        "panorama of the gulf, Konak and the far shore. Go towards sunset and sit in one of the tea gardens around. The "
        "walk up from Kemeraltı is steep, so you may prefer a taxi or a bus."),

    "cesme-kalesi": (3,
        "Çeşme Kalesi, Osmanlı Sultanı II. Bayezid döneminde, 1508 civarında, Sakız Adası karşısındaki kıyıyı ve "
        "limanı korumak için yapıldı. 1770'teki Çeşme Deniz Savaşı'na tanıklık eden kale, sonraki yüzyıllarda da "
        "kasabanın simgesi olarak kaldı.\n\n"
        "Surların üzerinde yürüyerek liman, kervansaray ve Ege'nin manzarasını izleyebilirsiniz. Kalenin içinde Çeşme "
        "Müzesi bulunur; yaz akşamları avlusunda konser ve festivaller düzenlenir. Önündeki Cezayirli Gazi Hasan Paşa "
        "heykeli ve çarşı aynı yürüyüşte görülür. Yazın öğle sıcağı yerine sabah ya da akşamüstü gidin.",
        "Çeşme Castle was built around 1508 under the Ottoman Sultan Bayezid II to guard the harbour and the coast facing "
        "the island of Chios. It witnessed the Battle of Çeşme in 1770 and has remained the symbol of the town ever since.\n\n"
        "Walking along the walls you can look out over the harbour, the caravanserai and the Aegean. Çeşme Museum is "
        "inside the castle, and concerts and festivals are held in its courtyard on summer evenings. The statue of "
        "Cezayirli Gazi Hasan Pasha in front and the market fit into the same walk. In summer go in the morning or late "
        "afternoon rather than in the midday heat."),

    "foca-kalesi": (3,
        "Foça Kalesi, antik Phokaia'nın üzerine kurulmuştur. Kentin sur duvarlarının en eski bölümleri MÖ 6. yüzyılın "
        "başlarına uzanır; bugünkü kale ise ortaçağda, Bizans ve ardından Ceneviz döneminde biçimlendi, Osmanlılar "
        "zamanında da onarıldı. Denize bakan bölümü Beşkapılar adıyla bilinir.\n\n"
        "Kale duvarları boyunca yürüyerek Küçükdeniz koyunu, balıkçı teknelerini ve taş evleri izleyebilirsiniz. "
        "Gün batımında sur dibindeki sahil yolu özellikle güzeldir. Foça'nın Akdeniz foklarıyla ünlü kıyısı ve tekne "
        "turlarıyla aynı gün birleştirilebilir.",
        "Foça Castle is built over ancient Phokaia. The oldest parts of the city walls go back to the early 6th century "
        "BC, while the castle as seen today took shape in the Middle Ages under the Byzantines and then the Genoese, and "
        "was repaired in Ottoman times. The section facing the sea is known as Beşkapılar (Five Gates).\n\n"
        "Walking along the walls you look out over the Küçükdeniz bay, its fishing boats and stone houses. The seafront "
        "road at the foot of the walls is especially lovely at sunset. It combines well with Foça's coast, known for "
        "Mediterranean monk seals, and its boat trips."),

    "candarli-kalesi": (3,
        "Dikili'ye bağlı Çandarlı'daki kale, antik Pitane kentinin bulunduğu yarımadada, denizin hemen kıyısında yükselir. "
        "Yapım tarihi kesin bilinmez; 14. yüzyılda Cenevizlilerin onardığı kale, 15. yüzyılda Sadrazam Çandarlı Halil "
        "Paşa'nın emriyle yeniden inşa edildi ve kasaba adını bu aileden aldı.\n\n"
        "Dört köşesindeki kuleleri ve sağlam surlarıyla bölgenin en iyi korunmuş ortaçağ kalelerindendir; son "
        "restorasyonun ardından ziyarete açıldı. Kalenin çevresindeki sahil ve balık restoranları, Bergama ya da "
        "Dikili gezisine eklenecek sakin bir mola sunar.",
        "The castle at Çandarlı, in Dikili district, rises right by the sea on the peninsula where the ancient city of "
        "Pitane stood. Its date of construction is not known for certain; repaired by the Genoese in the 14th century, it "
        "was rebuilt in the 15th century on the orders of the Grand Vizier Çandarlı Halil Pasha, whose family gave the "
        "town its name.\n\n"
        "With towers at its corners and solid walls, it is one of the best-preserved medieval castles in the region and "
        "opened to visitors after its latest restoration. The seafront and fish restaurants around it offer a quiet stop "
        "to add to a trip to Bergama or Dikili."),

    "sigacik-kalesi": (3,
        "Seferihisar'daki Sığacık Kalesi'nin Selçuklu döneminde kurulduğu düşünülür; Aydınoğulları ve Osmanlılar "
        "zamanında kullanıldı ve bugünkü biçimini büyük ölçüde 16. yüzyılda aldı. Kalenin en ilginç yanı, surların "
        "içinin bugün de yaşayan bir mahalle olmasıdır.\n\n"
        "Dar sokaklarda taş evler, pansiyonlar, el sanatı dükkânları ve kafeler arasında dolaşabilirsiniz. Sığacık, "
        "'yavaş şehir' (Cittaslow) Seferihisar'ın kalbidir; pazar günleri kurulan üretici pazarı kalabalık olur. "
        "Limandaki balık lokantaları ve yakındaki Teos antik kenti aynı güne sığar.",
        "Sığacık Castle in Seferihisar is thought to have been founded in the Seljuk period; it was used by the Aydınids "
        "and the Ottomans and largely took its present form in the 16th century. Its most interesting feature is that "
        "the area inside the walls is still a living neighbourhood.\n\n"
        "You can wander narrow streets among stone houses, guesthouses, craft shops and cafés. Sığacık is the heart of "
        "Seferihisar, Turkey's first 'slow city' (Cittaslow); the producers' market held on Sundays gets busy. The fish "
        "restaurants by the harbour and the nearby ancient city of Teos fit into the same day."),

    "sancakburnu-kalesi": (3,
        "İnciraltı'ndaki Sancakburnu Kalesi, Yenikale olarak da bilinir. 1660'larda, Köprülüler döneminde İzmir "
        "Körfezi'nin girişini denetlemek için yapıldı; karşı kıyıdaki Yenikale ile birlikte körfeze giren gemileri "
        "kontrol ediyordu.\n\n"
        "Kale askeri alanda kaldığı için uzun süre ziyarete kapalıydı; gitmeden önce erişim durumunu kontrol edin. "
        "Çevresindeki İnciraltı sahili ve kent ormanı yürüyüş ve bisiklet için uygundur; TCG Pirireis müze "
        "denizaltısı da yakındadır.",
        "Sancakburnu Castle in İnciraltı is also known as Yenikale (New Castle). It was built in the 1660s, in the era of "
        "the Köprülü grand viziers, to control the entrance to the Gulf of İzmir and, together with the battery on the "
        "opposite shore, kept watch over ships entering the gulf.\n\n"
        "As it lies within a military zone it was long closed to visitors, so check access before you go. The İnciraltı "
        "seafront and city forest around it are good for walking and cycling, and the TCG Pirireis museum submarine is "
        "nearby."),

    "ayasuluk-kalesi": (3,
        "Selçuk'ta Ayasuluk Tepesi'nin zirvesindeki kale, Efes'in Bizans döneminde kentin bu tepeye taşınmasıyla "
        "önem kazandı. Bizanslılar tarafından güçlendirilen surlar, Aydınoğulları zamanında da kullanıldı; kale "
        "içinde bu döneme ait bir cami ve sarnıçlar bulunur.\n\n"
        "Kuleli surların üzerinden Selçuk, Artemis Tapınağı'nın bulunduğu ova ve İsa Bey Camii görülür. Kale, hemen "
        "aşağıdaki Aziz Yuhanna Bazilikası ile birlikte gezilir; tepeye çıkış rampalı ve gölgesizdir, sabah erken "
        "saatleri tercih edin.",
        "The castle on the summit of Ayasuluk Hill in Selçuk gained importance when, in the Byzantine period, the city of "
        "Ephesus moved to this hill. Its walls, strengthened by the Byzantines, were also used under the Aydınids, and "
        "inside are a mosque and cisterns from that period.\n\n"
        "From the towered walls you see Selçuk, the plain where the Temple of Artemis stood, and the İsa Bey Mosque. The "
        "castle is visited together with the Basilica of St John just below; the climb is sloping and shadeless, so "
        "early morning is best."),

    "izmir-saat-kulesi": (3,
        "Konak Meydanı'ndaki İzmir Saat Kulesi, Sultan II. Abdülhamid'in tahta çıkışının 25. yılı için 1901'de yapıldı. "
        "Levanten mimar Raymond Charles Père tarafından tasarlandı; saatinin Alman İmparatoru II. Wilhelm'in hediyesi "
        "olduğu anlatılır. Bugün İzmir'in en bilinen simgesidir ve belediye amblemindedir.\n\n"
        "Dört yanındaki çeşmeler, ince işçilikli taş gövdesi ve Kuzey Afrika etkili süslemeleri yakından incelenmeye "
        "değer. Meydandaki güvercinler, Konak Camii ve deniz kıyısıyla şehrin en çok fotoğraflanan köşesidir. "
        "Kemeraltı gezisine buradan başlanabilir; vapur iskelesi de birkaç adım ötededir.",
        "The İzmir Clock Tower on Konak Square was built in 1901 to mark the 25th anniversary of Sultan Abdülhamid II's "
        "accession. It was designed by the Levantine architect Raymond Charles Père, and its clock is said to have been "
        "a gift from the German Emperor Wilhelm II. Today it is İzmir's best-known landmark and appears on the city's "
        "emblem.\n\n"
        "The fountains on its four sides, the finely worked stone shaft and the North African-influenced ornament deserve "
        "a close look. With the pigeons, the Konak Mosque and the waterfront, this is the most photographed corner of "
        "the city. A walk through Kemeraltı can start here, and the ferry pier is a few steps away."),

    "izmir-parasut-kulesi": (3,
        "Kültürpark'taki Paraşüt Kulesi, 1937'de Türk Hava Kurumu tarafından yapıldı. Moskova'daki Gorki Parkı'nda "
        "benzerini gören Belediye Başkanı Behçet Uz'un girişimiyle inşa edilen kule, ülkedeki iki paraşüt kulesinden "
        "biridir ve uzun yıllar paraşüt eğitiminde kullanıldı.\n\n"
        "Çelik iskeleti ve tepesindeki şemsiye biçimli kolu, Kültürpark'ın en tanınmış silüetlerindendir. Bugün "
        "atlama yapılmasa da parkın gölet ve yürüyüş yollarıyla birlikte görülür. Fuar dönemlerinde park çok "
        "kalabalık olur; sakin bir gezi için hafta içi sabahları seçin.",
        "The Parachute Tower in Kültürpark was built in 1937 by the Turkish Aeronautical Association. Built on the "
        "initiative of Mayor Behçet Uz, who had seen a similar tower in Moscow's Gorky Park, it is one of only two "
        "parachute towers in the country and was used for parachute training for many years.\n\n"
        "Its steel frame and umbrella-shaped arm on top make it one of the best-known silhouettes in Kültürpark. Although "
        "no jumps are made today, it is seen together with the park's pond and walking paths. The park gets very crowded "
        "during fairs; for a quiet visit choose a weekday morning."),

    "tarihi-asansor": (3,
        "Karataş'taki Tarihi Asansör, 1907'de Yahudi iş insanı Nesim Levi tarafından yaptırıldı. Aralarında yaklaşık 58 "
        "metre kot farkı bulunan Mithatpaşa Caddesi ile yukarıdaki Şehit Nihat Bey Caddesi'ni birbirine bağlar; "
        "önceden bu yokuş uzun merdivenlerle çıkılıyordu.\n\n"
        "Asansörle yukarı çıkınca terastan körfezin ve Konak'ın geniş bir manzarası açılır; üstteki restoran ve "
        "kafeler gün batımında doludur. Aşağıdaki Dario Moreno Sokağı'nın renkli merdivenleri ve Bet İsrael Sinagogu "
        "aynı yürüyüşte görülebilir.",
        "The Historical Elevator in Karataş was built in 1907 by the Jewish businessman Nesim Levi. It links Mithatpaşa "
        "Street with Şehit Nihat Bey Street above, about 58 metres higher; before it existed, the slope was climbed by "
        "long flights of steps.\n\n"
        "At the top, the terrace opens onto a wide view of the gulf and Konak, and the restaurant and cafés up there are "
        "full at sunset. The colourful steps of Dario Moreno Street below and the Bet Israel Synagogue fit into the same walk."),

    "ataturk-maski": (3,
        "Buca'da, Kadifekale'ye bakan yamaçtaki Atatürk Maskı, Atatürk'ün yüzünü gösteren dev bir beton kabartmadır. "
        "Heykeltıraş Harun Atalayman'ın eseri olan anıtın yapımı 2006'da başladı, 2009'da tamamlandı. Yaklaşık 42 "
        "metre yüksekliğiyle ülkenin en büyük heykellerindendir.\n\n"
        "Şehrin birçok noktasından, özellikle akşam ışıklandırıldığında uzaktan görülür. Yakından görmek için "
        "yamaçtaki seyir alanına çıkılabilir; buradan İzmir'in iç kesimlerine de geniş bir manzara açılır.",
        "In Buca, on a hillside facing Kadifekale, the Atatürk Mask is a giant concrete relief of Atatürk's face. The "
        "work of the sculptor Harun Atalayman, it was begun in 2006 and completed in 2009. At about 42 metres high it is "
        "one of the largest sculptures in the country.\n\n"
        "It can be seen from many parts of the city, especially when lit up in the evening. For a closer look you can go "
        "up to the viewing area on the slope, which also offers a wide view over inland İzmir."),

    "cumhuriyet-meydani": (3,
        "Alsancak ile Konak arasında, Kordon'un ucundaki Cumhuriyet Meydanı, İzmir'in ana kent meydanlarındandır. "
        "Meydanın ortasındaki atlı Atatürk Anıtı, İtalyan heykeltıraş Pietro Canonica'nın eseridir ve 1932'de açıldı.\n\n"
        "Ulusal bayramlardaki törenler burada yapılır. Pasaport vapur iskelesi ve Kordon'un yürüyüş yolu birkaç adım "
        "ötededir; denize karşı oturup simit yemek ya da gün batımını izlemek için iyi bir başlangıç noktasıdır.",
        "Between Alsancak and Konak, at the end of the Kordon, Cumhuriyet (Republic) Square is one of İzmir's main city "
        "squares. The equestrian Atatürk Monument at its centre is the work of the Italian sculptor Pietro Canonica and "
        "was unveiled in 1932.\n\n"
        "Ceremonies on national holidays are held here. The Pasaport ferry pier and the Kordon promenade are a few steps "
        "away, making it a good starting point for sitting by the sea with a simit or watching the sunset."),

    "gundogdu-meydani": (3,
        "Alsancak'ta, Kordon'un ortasındaki Gündoğdu Meydanı, 2000'deki kıyı düzenlemesiyle halka açıldı. Ortasında "
        "Cumhuriyet Ağacı heykeli bulunan geniş meydan, İzmir'in kutlama, konser ve buluşma yeridir.\n\n"
        "Büyük maçlar, yılbaşı ve bayram kutlamaları burada yapılır; sıradan günlerde ise çimlerde oturan, bisiklet "
        "süren ve deniz kıyısında yürüyenlerle doludur. Kordon boyunca Konak'a ya da Alsancak Limanı'na yürüyüş için "
        "iyi bir başlangıç noktasıdır.",
        "Gündoğdu Square, in the middle of the Kordon in Alsancak, opened to the public with the waterfront redesign of "
        "2000. With the Tree of the Republic sculpture at its centre, the wide square is İzmir's place for celebrations, "
        "concerts and meeting up.\n\n"
        "Big matches, New Year and holiday celebrations take place here, and on ordinary days it is full of people "
        "sitting on the grass, cycling and strolling by the sea. It is a good starting point for a walk along the Kordon "
        "to Konak or to Alsancak Port."),

    "ilk-kursun-aniti": (3,
        "Konak'taki İlk Kurşun Anıtı, 15 Mayıs 1919'da İzmir'in işgali sırasında işgal kuvvetlerine ilk kurşunu atan "
        "ve orada hayatını kaybeden gazeteci Hasan Tahsin anısına 1974'te dikildi. Bu olay, Kurtuluş Savaşı'nın "
        "başlangıç anlarından biri olarak anılır.\n\n"
        "Anıtta elinde silah ve bayrakla Hasan Tahsin'in heykeli, yanlarında işgal ve direniş sahnelerini anlatan "
        "kabartmalar bulunur. Her yıl 15 Mayıs'ta burada anma töreni yapılır. Saat Kulesi ve Konak Meydanı'na "
        "yürüme mesafesindedir.",
        "The First Bullet Monument in Konak was erected in 1974 in memory of the journalist Hasan Tahsin, who fired the "
        "first shot at the occupying forces during the occupation of İzmir on 15 May 1919 and was killed there. The event "
        "is remembered as one of the opening moments of the War of Independence.\n\n"
        "The monument shows Hasan Tahsin with a gun and a flag, flanked by reliefs depicting scenes of occupation and "
        "resistance. A memorial ceremony is held here every 15 May. It is within walking distance of the Clock Tower and "
        "Konak Square."),

    "cezayirli-gazi-hasan-pasa-aniti": (3,
        "Çeşme Kalesi'nin önündeki anıt, Osmanlı amirali ve sadrazamı Cezayirli Gazi Hasan Paşa'yı (1713-1790) yanındaki "
        "aslanıyla gösterir. Hasan Paşa, 1770 Çeşme Deniz Savaşı'ndan sağ kurtulan komutanlardandı ve Cezayir'deyken "
        "edindiği evcil aslanla ünlüydü.\n\n"
        "Heykel, kasabanın en çok fotoğraflanan noktalarındandır; arkasında kale, önünde liman ve çarşı uzanır. Kale "
        "ve müze ziyaretiyle birlikte kısa bir durak olarak görülür.",
        "The monument in front of Çeşme Castle shows the Ottoman admiral and grand vizier Cezayirli Gazi Hasan Pasha "
        "(1713-1790) with his lion. Hasan Pasha was among the commanders who survived the Battle of Çeşme in 1770 and was "
        "famous for the tame lion he acquired while in Algiers.\n\n"
        "The statue is one of the most photographed spots in town, with the castle behind it and the harbour and market "
        "in front. It makes a short stop with a visit to the castle and museum."),

    "kizlaragasi-hani": (3,
        "Kemeraltı'ndaki Kızlarağası Hanı, III. Ahmed ve I. Mahmud dönemlerinde saray kızlar ağası olan Hacı Beşir Ağa "
        "tarafından 1744'te yaptırıldı. İzmir'de günümüze ulaşan en büyük Osmanlı hanıdır; uzun yıllar tüccarların "
        "konakladığı ve mal depoladığı bir ticaret merkeziydi.\n\n"
        "İki katlı hanın avlusunu çevreleyen dükkânlarda bugün halı, el sanatları, hediyelik eşya ve antika satılır; "
        "avludaki kahveciler İzmir'in en keyifli kahve molası yerlerindendir. Hisar Camii hemen yanındadır; "
        "Kemeraltı gezisinin merkezi bir durağı olarak düşünün.",
        "The Kızlarağası Han in Kemeraltı was built in 1744 by Hacı Beşir Ağa, chief eunuch of the imperial harem under "
        "Ahmed III and Mahmud I. It is the largest surviving Ottoman han in İzmir and was for many years a trading centre "
        "where merchants stayed and stored their goods.\n\n"
        "Today the shops around the courtyard of the two-storey han sell carpets, crafts, souvenirs and antiques, and the "
        "coffee sellers in the courtyard are one of the nicest places in İzmir for a coffee break. The Hisar Mosque is "
        "right next door; think of it as a central stop on a Kemeraltı walk."),

    "sehit-kubilay-aniti": (3,
        "Menemen'deki Şehit Kubilay Anıtı, 23 Aralık 1930'daki Menemen Olayı'nda hayatını kaybeden yedek subay öğretmen "
        "Mustafa Fehmi Kubilay ile yanında öldürülen bekçiler anısına yapıldı. Heykeltıraş Ratip Aşir Acudoğu'nun eseri "
        "olan anıt 26 Aralık 1934'te açıldı.\n\n"
        "İlçeye hâkim bir tepede yer alan anıt alanında her yıl 23 Aralık'ta anma töreni düzenlenir. Tepeden Menemen "
        "ovası ve çevresi görülür. İzmir'den Foça ya da Bergama yönüne giderken kısa bir durak olarak planlanabilir.",
        "The Martyr Kubilay Memorial in Menemen commemorates Mustafa Fehmi Kubilay, a reserve officer and teacher killed "
        "in the Menemen Incident of 23 December 1930, together with the watchmen killed alongside him. The work of the "
        "sculptor Ratip Aşir Acudoğu, it was unveiled on 26 December 1934.\n\n"
        "Set on a hill above the town, the memorial site hosts a ceremony every 23 December, and the hill looks out over "
        "the Menemen plain. It makes a short stop on the way from İzmir towards Foça or Bergama."),

    "kemeralti-carsisi": (3,
        "Konak Meydanı'ndan Basmane'ye ve Agora'ya kadar uzanan Kemeraltı, İzmir'in yüzyıllardır yaşayan tarihi "
        "çarşısıdır. Bir kısmı, 17. yüzyılda doldurulan eski iç limanın üzerine kuruldu. Hanlar, camiler, sinagoglar, "
        "kiliseler ve sayısız dükkânla kentin ticaret ve günlük hayatının merkezi oldu.\n\n"
        "Anafartalar Caddesi'nden girip ara sokaklarda kaybolun: Kızlarağası Hanı'nda kahve, Havra Sokağı'nda tezgâhlar, "
        "boyoz ve lokma gibi İzmir lezzetleri, kuyumcular ve bakırcılar sizi bekler. Pazar günleri dükkânların çoğu "
        "kapalıdır; hafta içi gündüz en canlı zamanıdır. İçindeki tarihi yapılar ayrıca işaretlenebilir.",
        "Stretching from Konak Square to Basmane and the Agora, Kemeraltı is İzmir's historic bazaar, alive for "
        "centuries. Part of it was built over the old inner harbour, filled in during the 17th century. With its hans, "
        "mosques, synagogues, churches and countless shops, it became the centre of the city's trade and daily life.\n\n"
        "Enter from Anafartalar Street and lose yourself in the side streets: coffee at the Kızlarağası Han, stalls on "
        "Havra Street, İzmir treats such as boyoz and lokma, jewellers and coppersmiths. Most shops close on Sundays, so "
        "weekdays during the day are the liveliest. The historic buildings inside can be checked off separately."),

    "memmius-yapisi": (3,
        "Efes'te, Domitian Meydanı'nın yanında duran Memmius Anıtı, MÖ 1. yüzyılda, Romalı diktatör Sulla'nın torunu "
        "Gaius Memmius adına yapıldı. Roma'nın Efes ve Asya eyaletindeki gücünü vurgulayan bir anıt olarak düşünülür.\n\n"
        "Ayakta kalan bölümlerde kabartmalı bloklar ve dört yönü açık yapının izleri görülür. Üst girişten Kuretler "
        "Caddesi'ne inerken yolunuzun hemen başındadır; yanındaki Pollio Çeşmesi ve Domitian Tapınağı ile birlikte "
        "bakılabilir.",
        "Standing beside Domitian Square in Ephesus, the Memmius Monument was built in the 1st century BC in honour of "
        "Gaius Memmius, grandson of the Roman dictator Sulla. It is thought of as a monument proclaiming Rome's power in "
        "Ephesus and the province of Asia.\n\n"
        "The surviving parts show relief-carved blocks and traces of a structure open on four sides. It lies right at the "
        "start of your route as you walk down from the upper entrance to Curetes Street, and can be seen with the nearby "
        "Pollio Fountain and the Temple of Domitian."),

    "artemis-tapinagi": (3,
        "Selçuk'taki Artemis Tapınağı, antik dünyanın yedi harikasından biri sayılır. Tanrıça Artemis'e adanan tapınak "
        "birkaç kez yeniden yapıldı; MÖ 356'da kundaklanarak yandıktan sonra daha görkemli biçimde inşa edildi. Geç "
        "antik çağda yıkılan yapının yeri 19. yüzyılda İngiliz kazılarıyla bulundu.\n\n"
        "Bugün bataklık bir alanda, parçalardan yeniden dikilmiş tek bir sütun ayakta durur; üzerindeki leylek yuvası "
        "manzaranın parçasıdır. Tapınağın büyüklüğünü hayal etmek için Efes Müzesi'ndeki Artemis heykelleriyle birlikte "
        "düşünün. Ayasuluk Tepesi ve İsa Bey Camii hemen arkada görülür.",
        "The Temple of Artemis at Selçuk is counted among the Seven Wonders of the ancient world. Dedicated to the goddess "
        "Artemis, the temple was rebuilt several times; after it was burned by an arsonist in 356 BC it was rebuilt on an "
        "even grander scale. Destroyed in late antiquity, its site was rediscovered by British excavations in the 19th "
        "century.\n\n"
        "Today a single column, re-erected from fragments, stands in a marshy field, and the stork's nest on top is part "
        "of the view. To imagine the temple's size, pair it with the statues of Artemis in the Ephesus Museum. Ayasuluk "
        "Hill and the İsa Bey Mosque rise just behind."),

    "efes": (3,
        "Efes, antik dünyanın en büyük ve en zengin kentlerinden biriydi. MÖ 10. yüzyılda kurulan kent, Roma döneminde "
        "Asya eyaletinin başkenti oldu; limanı, tapınakları ve kamu yapılarıyla parladı, erken Hristiyanlık için de "
        "önemli bir merkez haline geldi. Limanın zamanla alüvyonla dolması kentin sonunu getirdi. 2015'te UNESCO Dünya "
        "Mirası Listesi'ne alındı.\n\n"
        "Mermer döşeli Kuretler Caddesi, Celsus Kütüphanesi, binlerce kişilik Büyük Tiyatro ve ayrı biletle girilen "
        "Yamaç Evler en önemli duraklardır. İki giriş vardır; üst girişten başlayıp aşağı doğru yürümek daha kolaydır. "
        "Gölge azdır: yazın sabah erken gidin, su, şapka ve rahat ayakkabı alın. İçindeki yapılar ayrıca işaretlenebilir.",
        "Ephesus was one of the largest and richest cities of the ancient world. Founded in the 10th century BC, it became "
        "the capital of the Roman province of Asia and flourished with its harbour, temples and public buildings, also "
        "becoming an important centre of early Christianity. The gradual silting-up of its harbour brought about its "
        "end. It was added to the UNESCO World Heritage List in 2015.\n\n"
        "The marble-paved Curetes Street, the Library of Celsus, the Great Theatre seating thousands and the Terrace "
        "Houses, which need a separate ticket, are the main stops. There are two entrances; starting at the upper gate "
        "and walking downhill is easier. Shade is scarce: in summer go early, and bring water, a hat and comfortable shoes. "
        "The buildings inside can be checked off separately."),

    "pergamon": (3,
        "Bergama'nın üzerindeki tepede yükselen Pergamon akropolü, MÖ 282-133 arasında Bergama Krallığı'nın başkentiydi. "
        "Attalos hanedanı döneminde kent, kütüphanesi, tapınakları ve sanatıyla Helenistik dünyanın parlak "
        "merkezlerinden oldu. 2014'te UNESCO Dünya Mirası Listesi'ne alındı.\n\n"
        "Yamaca oyulmuş dik tiyatro, Trajan Tapınağı'nın beyaz mermer sütunları, kütüphane ve bugün Berlin'de bulunan "
        "Zeus Sunağı'nın temelleri en önemli bölümlerdir. Akropole teleferikle çıkmak zamanı ve gücü korur. Tepe "
        "rüzgârlı ve gölgesizdir; aşağıdaki Asklepion ve Kızıl Avlu ile birlikte bir günlük gezi planlayın. İçindeki "
        "yapılar ayrıca işaretlenebilir.",
        "Rising on the hill above Bergama, the acropolis of Pergamon was the capital of the Kingdom of Pergamon from 282 to "
        "133 BC. Under the Attalid dynasty the city became one of the brightest centres of the Hellenistic world, famed "
        "for its library, temples and art. It was added to the UNESCO World Heritage List in 2014.\n\n"
        "The steep theatre cut into the slope, the white marble columns of the Temple of Trajan, the library and the "
        "foundations of the Altar of Zeus, now in Berlin, are the highlights. Taking the cable car up saves time and "
        "energy. The hill is windy and shadeless; plan a full day together with the Asklepion and the Red Basilica below. "
        "The buildings inside can be checked off separately."),

    "celsus-kutuphanesi": (3,
        "Efes'in simgesi Celsus Kütüphanesi, 2. yüzyılın başında, Asya eyaleti valisi Tiberius Julius Celsus "
        "Polemaeanus anısına oğlu Tiberius Julius Aquila tarafından yaptırıldı. Celsus'un mezarı yapının altındadır. "
        "Binlerce kitap rulosunu barındıran kütüphane, antik dünyanın en büyük kütüphanelerinden biriydi.\n\n"
        "İki katlı cephesi 1970'lerde yeniden ayağa kaldırıldı; nişlerdeki bilgelik, erdem, düşünce ve bilgiyi "
        "simgeleyen kadın heykelleri kopyadır, asılları Viyana'dadır. Sabahın ilk saatlerinde cephe güneşi alır ve "
        "kalabalık azdır. Yanındaki Mazeus ve Mithridates Kapısı'ndan Ticaret Agorası'na geçilir.",
        "The symbol of Ephesus, the Library of Celsus was built in the early 2nd century by Tiberius Julius Aquila in "
        "memory of his father, Tiberius Julius Celsus Polemaeanus, governor of the province of Asia. Celsus's tomb lies "
        "beneath the building. Holding thousands of scrolls, it was one of the largest libraries of the ancient world.\n\n"
        "Its two-storey façade was re-erected in the 1970s; the female statues in the niches, representing wisdom, "
        "virtue, intelligence and knowledge, are copies, with the originals in Vienna. The façade catches the sun early "
        "in the morning, when crowds are thinner. The Gate of Mazaeus and Mithridates beside it leads into the "
        "Commercial Agora."),

    "bergama-zeus-sunagi": (4,
        "Pergamon akropolünün bir terasındaki Zeus Sunağı, MÖ 2. yüzyılın ilk yarısında Kral II. Eumenes döneminde "
        "yapıldı. U biçimli anıtsal yapı, tanrılarla devlerin savaşını anlatan dev kabartma frizleriyle Helenistik "
        "sanatın başyapıtlarından sayılır. 19. yüzyılın sonundaki Alman kazılarında çıkarılan sunak Berlin'e "
        "götürüldü ve orada yeniden kuruldu.\n\n"
        "Akropolde bugün yalnızca basamaklı temeli ve onu gölgeleyen çam ağaçları görülür; yine de sunağın kenti "
        "nasıl taçlandırdığını hayal etmek için iyi bir noktadır. Asıl görünüşünü anlamak için Bergama Müzesi'ndeki "
        "maketine bakın. Athena Kutsal Alanı ve tiyatronun üst kısmı hemen yanındadır.",
        "On a terrace of the Pergamon acropolis, the Altar of Zeus was built in the first half of the 2nd century BC "
        "under King Eumenes II. The U-shaped monumental structure, with its huge relief friezes of the battle between "
        "gods and giants, is counted among the masterpieces of Hellenistic art. Excavated by German archaeologists in "
        "the late 19th century, the altar was taken to Berlin and reassembled there.\n\n"
        "On the acropolis today only its stepped foundation remains, shaded by pine trees; still, it is a good place to "
        "imagine how the altar crowned the city. See the model in the Bergama Museum to understand its original look. "
        "The Sanctuary of Athena and the top of the theatre are right next to it."),

    "klazomenai": (4,
        "Urla'daki Klazomenai, on iki İyon kentinden biridir. Kent bir dönem kıyıdaki karada, Pers tehdidi sırasında "
        "ise bugün Karantina Adası olarak bilinen adacık üzerinde yaşadı. Klazomenai, boyalı pişmiş toprak lahitleriyle "
        "antik sanat tarihinde ayrı bir yere sahiptir.\n\n"
        "Alanın en ilginç noktası, MÖ 6. yüzyıla tarihlenen ve aslına uygun olarak yeniden canlandırılan zeytinyağı "
        "işliğidir; antik çağda zeytinyağının nasıl üretildiğini yerinde gösterir. Kalıntılar dağınıktır, bu yüzden "
        "işaretlere göre ilerleyin. Urla'nın bağ yolu ve İskele'deki balıkçılarla aynı gün gezilebilir.",
        "Klazomenai in Urla was one of the twelve Ionian cities. The city lived for a time on the mainland shore and, "
        "during the Persian threat, on the islet now known as Karantina Island. It holds a special place in the history "
        "of ancient art for its painted terracotta sarcophagi.\n\n"
        "The most interesting spot on the site is the olive oil workshop of the 6th century BC, faithfully reconstructed "
        "to show on the spot how olive oil was produced in antiquity. The remains are scattered, so follow the signs. It "
        "can be combined in one day with Urla's wine route and the fish restaurants at İskele."),

    "kolophon": (4,
        "Menderes ilçesinin Değirmendere mahallesindeki Kolophon, on iki İyon kentinin en eskilerinden biri sayılır ve "
        "MÖ 2. binyılın sonlarına doğru kurulduğu düşünülür. Deniz kıyısında kurulmayan tek İyon kentiydi; antik "
        "yazarlar onun süvarilerinin ünlü olduğunu anlatır.\n\n"
        "Bugün kalıntılar, zeytinliklerin arasındaki tepelere dağılmış sur, temel ve teras parçalarından oluşur; "
        "gösterişli yapılar beklemeyin. Kolophon'un kutsal alanı Klaros ve limanı Notion güneyde, birkaç kilometre "
        "uzaklıktadır; üçü birlikte gezilirse kentin hikâyesi daha iyi anlaşılır.",
        "Colophon, in the Değirmendere quarter of Menderes district, is considered one of the oldest of the twelve Ionian "
        "cities and is thought to have been founded towards the end of the 2nd millennium BC. It was the only Ionian city "
        "not built on the coast, and ancient writers tell of its famous cavalry.\n\n"
        "Today its remains are fragments of walls, foundations and terraces scattered over hills among olive groves; do "
        "not expect grand buildings. Colophon's sanctuary at Claros and its port at Notion lie a few kilometres to the "
        "south; seen together, the three tell the city's story more clearly."),

    "smyrna": (4,
        "Bayraklı'daki Tepekule höyüğü, İzmir'in ilk kuruluş yeri olan Eski Smyrna'dır. Bir zamanlar körfeze uzanan "
        "küçük bir yarımadada kurulan yerleşim, MÖ 7. yüzyılda surları ve Athena Tapınağı ile gelişti; Lidyalıların "
        "MÖ 600 dolaylarındaki saldırısıyla yıkıldı. Kent, Helenistik dönemde Kadifekale'nin eteğine taşındı.\n\n"
        "Kazı alanında sur kalıntıları, tapınak terasının temelleri ve ilk dönem evlerin izleri görülür. Homeros'un "
        "burada yaşadığına dair anlatılar alana ayrı bir anlam katar. Bayraklı'nın gökdelenleri arasında kalan bu "
        "sessiz tepe, kentin 3.000 yılı aşan tarihini görmek için ilginç bir duraktır.",
        "The Tepekule mound in Bayraklı is Old Smyrna, the original site of İzmir. Founded on a small peninsula that once "
        "reached into the gulf, the settlement grew in the 7th century BC with its walls and Temple of Athena, and was "
        "destroyed by the Lydians around 600 BC. In the Hellenistic period the city moved to the foot of Kadifekale.\n\n"
        "On the excavation site you can see remains of the walls, the foundations of the temple terrace and traces of the "
        "earliest houses. Traditions that Homer lived here give the site extra meaning. Set among Bayraklı's towers, this "
        "quiet hill is an interesting stop to see more than 3,000 years of the city's history."),

    "teos": (4,
        "Seferihisar'da, Sığacık'ın hemen güneyindeki Teos, İyon Birliği'nin önemli kentlerindendi. Şair Anakreon'un "
        "memleketi olan kent, şarap ve tiyatro tanrısı Dionysos'a bağlılığıyla bilinir; Dionysos sanatçılarının "
        "birliği bir dönem burada toplandı.\n\n"
        "Zeytinlikler arasına yayılan alanda Dionysos Tapınağı, tiyatro, odeion ve meclis binası gezilebilir; liman "
        "tarafında kıyıya inen yollar da vardır. Sığacık Kalesi ve limanıyla aynı gün görülebilir. Gölge az olduğundan "
        "sabah ya da akşamüstünü seçin. Tapınak ayrıca işaretlenebilir.",
        "Just south of Sığacık in Seferihisar, Teos was one of the important cities of the Ionian League. The hometown of "
        "the poet Anacreon, it was known for its devotion to Dionysus, god of wine and theatre, and the guild of "
        "Dionysian artists was based here for a time.\n\n"
        "Across the site, spread among olive groves, you can visit the Temple of Dionysus, the theatre, the odeion and "
        "the council house, with paths leading down towards the harbour. It fits into the same day as Sığacık Castle and "
        "harbour. Shade is scarce, so choose the morning or late afternoon. The temple can be checked off separately."),

    "kyme": (4,
        "Aliağa'da, Nemrut Körfezi kıyısındaki Kyme, antik Aiolis bölgesinin en önemli kentiydi. Güçlü bir liman "
        "kentiydi ve antik kaynaklara göre şair Hesiodos'un babası buradan göç etmişti.\n\n"
        "Kazılarda agora, tapınak ve liman yapılarına ait kalıntılar ortaya çıkarıldı; ancak alan sanayi bölgesine "
        "yakın olduğundan çevresi pek çekici değildir. Arkeoloji meraklıları için, Foça ya da Çandarlı yolunda kısa "
        "bir durak olarak uygundur. Gitmeden önce kazı alanının ziyarete açık olup olmadığını kontrol edin.",
        "Kyme, on the shore of Nemrut Bay in Aliağa, was the most important city of ancient Aeolis. It was a strong "
        "harbour town, and according to ancient sources the father of the poet Hesiod emigrated from here.\n\n"
        "Excavations have uncovered remains of the agora, temples and harbour structures, though the surroundings are "
        "not very attractive because of the nearby industrial zone. For archaeology lovers it makes a short stop on the "
        "road to Foça or Çandarlı. Check whether the excavation area is open before you go."),

    "klaros": (4,
        "Menderes'in Ahmetbeyli mahallesindeki Klaros, antik dünyanın ünlü kehanet merkezlerinden biriydi. Kolophon "
        "kentinin kutsal alanı olan Klaros'ta Apollon Klarios'a adanmış tapınak bulunuyordu; kehanet almak için "
        "uzak kentlerden heyetler gelirdi.\n\n"
        "Tapınağın altında, rahiplerin kutsal kaynağa ulaştığı yeraltı koridorları görülebilir. Apollon, Artemis ve "
        "Leto'nun dev heykellerinin parçaları, sunaklar ve kutsal yol üzerindeki yazıtlı taşlar alanın en ilginç "
        "parçalarıdır. Notion ve Ahmetbeyli plajı çok yakındır.",
        "Claros, in the Ahmetbeyli quarter of Menderes, was one of the famous oracle centres of the ancient world. As the "
        "sanctuary of the city of Colophon, it held a temple to Apollo Clarius, and delegations came from distant cities "
        "to consult the oracle.\n\n"
        "Beneath the temple you can see the underground corridors through which the priests reached the sacred spring. "
        "Fragments of the colossal statues of Apollo, Artemis and Leto, the altars and the inscribed stones along the "
        "sacred way are the most interesting parts of the site. Notion and Ahmetbeyli beach are very close."),

    "lebedos": (4,
        "Ürkmez yakınlarında denize uzanan bir yarımada üzerindeki Lebedos, on iki İyon kentinden biriydi. Teos ile "
        "Efes arasında yer alan küçük bir liman kentiydi; Helenistik dönemde Dionysos sanatçılarının birliğine bir süre "
        "ev sahipliği yaptığı bilinir.\n\n"
        "Bugün yarımadada sur kalıntıları ve yapı temelleri görülür; alan bakımsızdır ve tabela azdır, bu yüzden "
        "keşif duygusu arayanlar için uygundur. Ürkmez sahili ve Gümüldür'ün koylarıyla birlikte bir yaz gününe "
        "eklenebilir.",
        "On a peninsula reaching into the sea near Ürkmez, Lebedos was one of the twelve Ionian cities. It was a small "
        "harbour town between Teos and Ephesus, and in the Hellenistic period it is known to have hosted the guild of "
        "Dionysian artists for a time.\n\n"
        "Today you can see remains of walls and building foundations on the peninsula; the site is unkempt and has few "
        "signs, so it suits those looking for a sense of discovery. Add it to a summer day at Ürkmez beach and the coves "
        "of Gümüldür."),

    "meryem-kilisesi": (4,
        "Efes'teki Meryem Kilisesi, Hz. Meryem'e (Theotokos) adanmış ilk büyük kiliselerden biridir. MS 431'de toplanan "
        "Üçüncü Ekümenik Konsil'in burada yapıldığına inanılır; bu nedenle Konsil Kilisesi olarak da anılır. Kilise, "
        "daha önceki bir Roma yapısının uzun salonuna yerleştirilmişti.\n\n"
        "Uzun bazilika planının izleri, sütun kaideleri ve iyi korunmuş vaftizhanesi görülebilir. Ören yerinin alt "
        "girişine yakın, ana yolun biraz kuzeyinde kalır; liman caddesi tarafına yürüyüşte kolayca eklenir. Hristiyanlık "
        "tarihi açısından Efes'in en önemli noktalarından biridir.",
        "The Church of Mary at Ephesus is one of the first great churches dedicated to Mary as Theotokos (Mother of God). "
        "The Third Ecumenical Council of AD 431 is believed to have been held here, which is why it is also called the "
        "Church of the Councils. The church was set into the long hall of an earlier Roman building.\n\n"
        "You can see traces of its long basilica plan, column bases and a well-preserved baptistery. It lies near the "
        "lower entrance of the site, a little north of the main path, and is easily added to a walk along the Harbour "
        "Street. It is one of the most important places at Ephesus for the history of Christianity."),

    "notion": (4,
        "Ahmetbeyli'de, Kuşadası Körfezi'ne bakan iki doruklu bir tepe üzerindeki Notion, Kolophon'un liman kentiydi. "
        "Adı Yunanca 'güneydeki' anlamına gelir. Sonraki dönemde Kolophon halkının bir kısmının buraya taşınmasıyla "
        "kent 'deniz kıyısındaki Kolophon' olarak da anıldı.\n\n"
        "Surların, agoranın, tiyatronun ve tapınak temellerinin kalıntıları denize bakan yamaçlara yayılır; "
        "manzarası ziyaretin en güzel yanıdır. Tepeye patika ile çıkılır, rahat ayakkabı giyin. Aşağıdaki plaj ve "
        "Klaros ile aynı gezide görülebilir.",
        "On a two-peaked hill overlooking the Gulf of Kuşadası at Ahmetbeyli, Notion was the port of Colophon. Its name "
        "means 'the southern one' in Greek. When part of Colophon's population later moved here, the city was also known "
        "as 'Colophon by the sea'.\n\n"
        "Remains of walls, the agora, the theatre and temple foundations spread over the slopes facing the sea, and the "
        "view is the best part of the visit. A footpath leads up the hill, so wear comfortable shoes. It can be combined "
        "with the beach below and with Claros."),

    "kizil-avlu": (4,
        "Bergama'nın merkezindeki Kızıl Avlu, MS 2. yüzyılda, büyük olasılıkla İmparator Hadrianus döneminde Mısır "
        "tanrıları için yapılmış dev bir tapınaktır. Kırmızı tuğla duvarları nedeniyle bu adı alır. Bizans döneminde "
        "içine bir kilise yerleştirildi; Vahiy Kitabı'nda anılan yedi kiliseden Bergama kilisesiyle ilişkilendirilir.\n\n"
        "Yapının altında Selinos Çayı'nın geçtiği tüneller vardır; yanlardaki kulelerden birinde kutsal havuzlar ve "
        "heykel parçaları görülebilir. Ölçeği yakından bakınca etkileyicidir. Bergama çarşısının içinde olduğundan "
        "akropol ve Asklepion ile aynı gün gezilir.",
        "The Red Basilica in central Bergama is a vast temple built in the 2nd century AD, most likely under the Emperor "
        "Hadrian, for Egyptian gods. It takes its name from its red brick walls. In the Byzantine period a church was set "
        "inside it, associated with the church of Pergamon, one of the seven churches named in the Book of Revelation.\n\n"
        "Beneath the building are tunnels carrying the Selinus stream; in one of the side towers you can see sacred pools "
        "and sculpture fragments. Its scale is impressive up close. Being inside Bergama's market area, it is visited on "
        "the same day as the acropolis and the Asklepion."),

    "larissa": (4,
        "Menemen'in Buruncuk köyü yakınındaki tepede bulunan Larissa, Aiolis bölgesinin en eski kentlerinden biridir. "
        "Gediz (Hermos) ovasına hâkim konumuyla önemli bir yerleşimdi; alan 20. yüzyılın başlarında yapılan kazılarla "
        "tanındı.\n\n"
        "Tepede sur parçaları ve yapı temelleri görülür; alan küçük ve bakımsızdır, tabela azdır. Tepeden Gediz ovasının "
        "geniş bir manzarası açılır. Arkeoloji meraklıları için Menemen'den Foça'ya giderken kısa bir durak olabilir.",
        "On a hill near the village of Buruncuk in Menemen, Larissa is one of the oldest cities of the Aeolis region. "
        "Commanding the plain of the Gediz (Hermos), it was an important settlement, and the site became known through "
        "excavations in the early 20th century.\n\n"
        "Fragments of walls and building foundations can be seen on the hill; the site is small, unkempt and has few signs. "
        "The hill offers a wide view over the Gediz plain. For archaeology lovers it can be a short stop on the way from "
        "Menemen to Foça."),

    "metropolis": (4,
        "Torbalı yakınlarında, Yeniköy'deki Metropolis antik kenti, adını 'ana tanrıça kenti' anlamından alır. Tepedeki "
        "yerleşimin izleri Neolitik çağa kadar iner; kent asıl gelişimini Helenistik ve Roma dönemlerinde yaşadı.\n\n"
        "Küçük ama zarif tiyatrosu, hamamlar, stoa ve meclis binası kalıntıları görülebilir; kazılarda çıkan eserlerin "
        "bir kısmı yakındaki kazı evinde ve müzelerdedir. Çok kalabalık olmayan, tepeden ovaya bakan huzurlu bir "
        "alandır. Efes yoluna yakın olduğundan aynı güne eklenebilir.",
        "The ancient city of Metropolis at Yeniköy near Torbalı takes its name from its meaning, 'city of the mother "
        "goddess'. Traces of settlement on the hill go back to the Neolithic, but the city flourished mainly in the "
        "Hellenistic and Roman periods.\n\n"
        "You can see its small but elegant theatre, baths, a stoa and the council house; some of the finds are kept in "
        "the dig house nearby and in museums. It is an uncrowded, peaceful site looking out from the hill over the plain. "
        "Being close to the road to Ephesus, it can be added to the same day."),

    "st-jean-bazilikasi": (4,
        "Selçuk'ta Ayasuluk Tepesi'nin yamacındaki Aziz Yuhanna Bazilikası, Havari Yuhanna'nın mezarı olduğuna inanılan "
        "yerin üzerine 6. yüzyılda İmparator I. Justinianus tarafından yaptırıldı. İstanbul'daki Havariler Kilisesi "
        "örnek alınarak haç planlı ve çok kubbeli olarak tasarlanmıştı.\n\n"
        "Kısmen yeniden dikilen sütunlar, mezar odasının bulunduğu bölüm ve vaftizhane gezilebilir. Bazilikanın "
        "terasından İsa Bey Camii, Artemis Tapınağı'nın tek sütunu ve ova görülür. Tepedeki Ayasuluk Kalesi ile birlikte "
        "gezilir; yokuş gölgesizdir, sabah ya da akşamüstü gidin.",
        "On the slope of Ayasuluk Hill in Selçuk, the Basilica of St John was built in the 6th century by the Emperor "
        "Justinian I over the place believed to be the tomb of John the Apostle. Modelled on the Church of the Holy "
        "Apostles in Constantinople, it was designed on a cross plan with several domes.\n\n"
        "You can walk among the partly re-erected columns, the area of the tomb chamber and the baptistery. From the "
        "basilica's terrace you see the İsa Bey Mosque, the single column of the Temple of Artemis and the plain. It is "
        "visited together with Ayasuluk Castle at the top; the climb is shadeless, so go in the morning or late afternoon."),

    "belevi-anit-mezari": (4,
        "Selçuk'a bağlı Belevi'deki anıt mezar, Efes'e yaklaşık 14 km uzaklıktadır ve Helenistik dönemin en büyük "
        "mezar anıtlarından biridir. Kimin için yapıldığı tartışmalıdır; Makedon kralı Lysimakhos için başlatıldığı ve "
        "sonradan bir Seleukos kralının gömüldüğü düşünülür. Mezardan çıkan lahit Efes Müzesi'ndedir.\n\n"
        "Kayaya oyulmuş kare kaidesi ve çevresindeki mimari parçalar, yapının ne kadar görkemli olduğunu gösterir. "
        "Yol kenarında, kolay ulaşılan bir alandır; İzmir'den Selçuk'a giderken kısa bir mola için uygundur.",
        "The monumental tomb at Belevi, in Selçuk district, lies about 14 km from Ephesus and is one of the largest "
        "funerary monuments of the Hellenistic period. Who it was built for is debated; it is thought to have been begun "
        "for the Macedonian king Lysimachus and later used for the burial of a Seleucid king. The sarcophagus found in "
        "the tomb is in the Ephesus Museum.\n\n"
        "Its square base carved from the rock and the architectural pieces around it show how grand the building was. It "
        "is right by the road and easy to reach, making a short break on the way from İzmir to Selçuk."),

    "yesilova-hoyugu": (4,
        "Bornova'daki Yeşilova Höyüğü, İzmir'in bilinen en eski yerleşimidir. 2003'te bulunan höyükte, yaklaşık MÖ "
        "6500 ile 4000 arasında kesintisiz yaşanan bir tarım köyünün izleri ortaya çıkarıldı. O dönemde körfezin kıyısı "
        "buraya çok daha yakındı.\n\n"
        "Kazı alanının yanındaki ziyaretçi merkezinde buluntular sergilenir ve yeniden yapılmış Neolitik evler, "
        "insanların 8.000 yıl önce nasıl yaşadığını gösterir. Çocuklu aileler için öğretici bir duraktır. Kent içinde, "
        "Bornova'ya kolay ulaşılır.",
        "Yeşilova Mound in Bornova is the oldest known settlement in İzmir. Discovered in 2003, it has revealed a farming "
        "village lived in continuously from roughly 6500 to 4000 BC. At that time the shore of the gulf was much closer.\n\n"
        "The visitor centre beside the excavation displays finds, and reconstructed Neolithic houses show how people "
        "lived 8,000 years ago. It is an educational stop for families with children. It is within the city and easy to "
        "reach in Bornova."),

    "efes-tiyatrosu": (4,
        "Efes'in Büyük Tiyatrosu, Panayır Dağı'nın yamacına oyulmuştur ve yaklaşık 25.000 kişilik kapasitesiyle "
        "antik dünyanın en büyük tiyatrolarındandır. Helenistik dönemde yapıldı, Roma döneminde genişletildi. Yeni "
        "Ahit'te anlatılan, Aziz Pavlus'a karşı gümüşçülerin ayaklanması burada geçer.\n\n"
        "Basamakların üst sıralarından Liman Caddesi'nin denize doğru uzanan düz çizgisi görülür; eskiden bu cadde "
        "limana ulaşıyordu. Sahne binasının kalıntıları ve akustik, yukarıdan aşağı bakınca daha iyi anlaşılır. "
        "Basamaklar yüksek ve kaygandır, dikkatli inin.",
        "The Great Theatre of Ephesus is carved into the slope of Mount Panayır and, with room for about 25,000 people, "
        "is one of the largest theatres of the ancient world. Built in the Hellenistic period, it was enlarged under the "
        "Romans. The silversmiths' riot against St Paul described in the New Testament took place here.\n\n"
        "From the upper rows you see the straight line of the Harbour Street running towards the sea, which once reached "
        "the harbour. The remains of the stage building and the acoustics are best appreciated from above. The steps are "
        "high and slippery, so go down carefully."),

    "yedi-uyurlar-mezarligi": (4,
        "Efes'e yaklaşık 1 km uzaklıkta, Panayır Dağı'nın kuzeydoğu yamacındaki Yedi Uyurlar, ünlü bir efsaneyle "
        "anılır: Roma İmparatoru Decius döneminde zulümden kaçan yedi Hristiyan genç bir mağarada uykuya dalar ve "
        "yaklaşık iki yüzyıl sonra uyanır. Efsane Kur'an'da da Ashab-ı Kehf olarak anlatılır.\n\n"
        "Bugün yamaçta, Bizans döneminde efsane etrafında gelişen mezarlık ve kilisenin kalıntıları görülür. Alanın "
        "yakınındaki gözleme ve köy kahvaltısı yapılan yerler, Efes gezisinden sonra mola vermek için popülerdir. Efes "
        "alt girişine yakındır.",
        "About 1 km from Ephesus, on the north-east slope of Mount Panayır, the Seven Sleepers are tied to a famous legend: "
        "fleeing persecution under the Roman Emperor Decius, seven young Christians fall asleep in a cave and wake about "
        "two centuries later. The story is also told in the Quran as the Companions of the Cave.\n\n"
        "On the slope today you can see the remains of the cemetery and church that grew up around the legend in "
        "Byzantine times. The gözleme and village breakfast places nearby are popular for a break after visiting "
        "Ephesus. It is close to the lower entrance of Ephesus."),

    "bergama-kutuphanesi": (4,
        "Pergamon akropolündeki kütüphane, Athena Kutsal Alanı'nın yanında yer alıyordu ve antik dünyanın en önemli "
        "kütüphanelerinden biriydi. Attalos kralları onu İskenderiye Kütüphanesi'nin rakibi olarak büyüttü. "
        "Anlatılana göre Mısır'ın papirüs ihracatını yasaklaması üzerine Bergama'da parşömen yaygınlaştı; 'parşömen' "
        "kelimesi de kentin adından gelir.\n\n"
        "Bugün okuma salonunun temelleri ve rafların yerleştirildiği duvar boşlukları görülebilir. Akropolün "
        "tepesinde, Trajan Tapınağı ve tiyatroya giden yol üzerindedir. Rüzgârlı ve gölgesiz alan için şapka alın.",
        "The library on the Pergamon acropolis stood beside the Sanctuary of Athena and was one of the most important "
        "libraries of the ancient world. The Attalid kings built it up as a rival to the Library of Alexandria. According "
        "to tradition, when Egypt banned the export of papyrus, parchment came into wide use at Pergamon, and the word "
        "'parchment' derives from the city's name.\n\n"
        "Today you can see the foundations of the reading room and the wall recesses where the shelves stood. It is at "
        "the top of the acropolis, on the way to the Temple of Trajan and the theatre. Bring a hat for this windy, "
        "shadeless site."),

    "imparatorlar-tapinagi-ve-sunagi-ile-domitianus-terasi": (4,
        "Efes'te, Devlet Agorası'nın yakınındaki büyük teras, MS 89-90'da Flavius hanedanı imparatorlarına adanan "
        "tapınağı taşıyordu. Uzun süre Domitianus Tapınağı olarak anılan yapı, bugün yazıtlardan bilinen adıyla "
        "Sebastoi (İmparatorlar) Tapınağı olarak tanımlanır. Efes'e imparator kültü için tapınak kurma hakkının "
        "verilmesi kent için büyük bir onurdu.\n\n"
        "Teras duvarları ve alt kattaki tonozlu mekânlar görülebilir; tapınaktaki dev imparator heykelinin parçaları "
        "müzelerde korunur. Üst girişten Kuretler Caddesi'ne inerken Memmius Anıtı ile birlikte yolunuzun üzerindedir.",
        "Near the State Agora in Ephesus, the great terrace carried the temple dedicated in AD 89-90 to the emperors of "
        "the Flavian dynasty. Long known as the Temple of Domitian, it is now identified by its name from inscriptions "
        "as the Temple of the Sebastoi (the Emperors). Being granted the right to build a temple for the imperial cult "
        "was a great honour for Ephesus.\n\n"
        "You can see the terrace walls and the vaulted rooms of the lower level; fragments of the colossal imperial "
        "statue from the temple are kept in museums. It lies on your way, with the Memmius Monument, as you walk down "
        "from the upper entrance to Curetes Street."),

    "bouleuterion-odeion": (4,
        "Efes'in Devlet Agorası'nın kuzeyindeki Bouleuterion, kent meclisinin toplandığı yarım daire biçimli yapıdır; "
        "konserler için de kullanıldığından Odeion olarak da anılır. Bugünkü hâli MS 2. yüzyılda, Efesli zengin "
        "Vedius Antoninus ve eşi Flavia Papiane'nin bağışıyla yapıldı.\n\n"
        "Yaklaşık 1.500 kişilik oturma sıraları iyi korunmuştur; eskiden üzeri ahşap bir çatıyla örtülüydü. Üst "
        "girişten ören yerine girince ilk karşılaşılan yapılardandır. Basamaklarda oturup Devlet Agorası'na bakmak, "
        "kentin yönetim merkezini hayal etmek için iyi bir başlangıçtır.",
        "North of the State Agora in Ephesus, the Bouleuterion is the semicircular building where the city council met; "
        "since it was also used for concerts, it is known as the Odeion too. Its present form dates from the 2nd century "
        "AD, funded by the wealthy Ephesian Vedius Antoninus and his wife Flavia Papiane.\n\n"
        "Its rows of seats for about 1,500 people are well preserved; it was once covered by a wooden roof. It is one of "
        "the first buildings you meet on entering the site from the upper gate. Sitting on the steps and looking out over "
        "the State Agora is a good way to start imagining the city's centre of government."),

    "hadrianus-tapinagi-embolos": (4,
        "Efes'in Kuretler Caddesi üzerindeki küçük Hadrianus Tapınağı, 2. yüzyılın ilk yarısında İmparator Hadrianus "
        "onuruna yapıldı. Ön cephesindeki kemerin ortasında kentin koruyucu tanrıçası Tykhe'nin büstü, içerideki "
        "kapı lentosunun üstünde ise bir Medusa kabartması yer alır.\n\n"
        "Zarif cephesiyle Celsus Kütüphanesi'nden sonra Efes'in en çok fotoğraflanan yapılarındandır. Yerinde görülen "
        "frizler kopyadır, asılları Efes Müzesi'nde sergilenir. Hemen yanında Skolastika Hamamı ve Latrina bulunur.",
        "The small Temple of Hadrian on Curetes Street in Ephesus was built in the first half of the 2nd century in "
        "honour of the Emperor Hadrian. A bust of Tyche, the city's protective goddess, sits at the centre of the arch on "
        "its front, and a Medusa relief is set above the inner doorway.\n\n"
        "With its elegant façade it is, after the Library of Celsus, one of the most photographed buildings at Ephesus. "
        "The friezes on site are copies; the originals are displayed in the Ephesus Museum. The Baths of Scholastica and "
        "the public latrine are right next to it."),

    "dionysos-tapinagi-teos": (4,
        "Teos'taki Dionysos Tapınağı, Helenistik dönemde ünlü mimar Hermogenes tarafından tasarlandı ve antik dünyada "
        "Dionysos'a adanmış en büyük tapınak olarak bilinir. İon düzeninde yapılan tapınak, Teos'un şarap ve tiyatro "
        "tanrısına olan bağlılığının simgesiydi.\n\n"
        "Kazılardan sonra bazı sütunları yeniden ayağa kaldırıldı; zeytin ağaçlarının arasında yükselen sütunlar "
        "özellikle akşamüstü ışığında çok güzeldir. Teos ören yerinin merkezinde olduğundan tiyatro ve odeionla aynı "
        "yürüyüşte görülür.",
        "The Temple of Dionysus at Teos was designed in the Hellenistic period by the famous architect Hermogenes and is "
        "known as the largest temple dedicated to Dionysus in the ancient world. Built in the Ionic order, it symbolised "
        "Teos's devotion to the god of wine and theatre.\n\n"
        "Some of its columns were re-erected after excavation; rising among olive trees, they look especially lovely in "
        "late-afternoon light. Being at the centre of the Teos site, it is seen on the same walk as the theatre and "
        "the odeion."),

    "prytaneion-belediye-sarayi": (4,
        "Efes'teki Prytaneion, kentin yönetim binası ve dini merkezlerinden biriydi. Burada, kentin yaşamını simgeleyen "
        "ve Hestia'ya adanmış kutsal ateş sürekli yanık tutulurdu. Bugün Efes Müzesi'nde sergilenen ünlü Artemis "
        "heykellerinden ikisi bu yapının kazısında bulundu.\n\n"
        "Ayakta kalan Dor düzenindeki sütunlar ve yazıtlı mimari parçalar, Devlet Agorası'nın kuzey kenarında görülür. "
        "Bouleuterion'un hemen yanında olduğundan üst girişten girdikten sonra ilk dakikalarda görülür.",
        "The Prytaneion at Ephesus was one of the city's administrative and religious centres. Here the sacred flame "
        "dedicated to Hestia, symbolising the life of the city, was kept burning at all times. Two of the famous statues "
        "of Artemis now displayed in the Ephesus Museum were found during its excavation.\n\n"
        "Its standing Doric columns and inscribed architectural pieces are seen on the north side of the State Agora. As "
        "it is right beside the Bouleuterion, you reach it in the first minutes after entering by the upper gate."),

    "efes-varius-hamami": (5,
        "Efes'in üst girişine yakın Varius Hamamı, MS 2. yüzyılda yapılan büyük bir Roma hamamıdır. Roma kentlerinde "
        "hamamlar yalnızca yıkanma yeri değil, aynı zamanda buluşma, sohbet ve spor alanıydı; bu yapı da Efes'in "
        "üst kentteki sosyal yaşamının önemli bir parçasıydı.\n\n"
        "Kalın tuğla duvarlar, sıcak ve soğuk bölümlerin izleri ve tonozlu mekânlar görülebilir. Ören yerine üst "
        "girişten girdiğinizde ilk duraklardan biridir; Devlet Agorası'na doğru yürürken kısa bir göz atmak yeterlidir.",
        "Near the upper entrance of Ephesus, the Baths of Varius are a large Roman bath complex built in the 2nd century "
        "AD. In Roman cities, baths were not just places to wash but also for meeting, conversation and exercise, and this "
        "building was an important part of social life in the upper city of Ephesus.\n\n"
        "You can see thick brick walls, traces of the hot and cold rooms and vaulted spaces. It is one of the first stops "
        "when you enter the site by the upper gate; a short look on your way to the State Agora is enough."),

    "pergamon-gymnasium-alani": (5,
        "Pergamon akropolünün güney yamacındaki gymnasium, Helenistik dünyanın en büyük gymnasiumlarından biriydi. Üç "
        "terasa yayılan yapıda çocuklar, gençler ve genç erkekler ayrı katlarda eğitim görür, spor yapar ve "
        "derslere katılırdı.\n\n"
        "Terasları birbirine bağlayan tonozlu merdivenler, sütunlu avlular ve hamam bölümleri görülebilir. Akropolün "
        "tepesinden aşağı, kentin orta kesimine inen patika üzerindedir; teleferikle çıkıp yürüyerek inerseniz "
        "yolunuz buradan geçer. Yamaç dik ve gölgesizdir, su almayı unutmayın.",
        "On the southern slope of the Pergamon acropolis, the gymnasium was one of the largest in the Hellenistic world. "
        "Spread across three terraces, it was where boys, youths and young men trained, exercised and attended lessons, "
        "each group on its own level.\n\n"
        "You can see the vaulted stairways linking the terraces, colonnaded courtyards and bath sections. It lies on the "
        "path that leads down from the top of the acropolis to the middle city; if you go up by cable car and walk down, "
        "your route passes here. The slope is steep and shadeless, so remember to bring water."),

    "traianus-cesmesi": (5,
        "Efes'in Kuretler Caddesi üzerindeki Traianus Çeşmesi, 2. yüzyılın başında İmparator Traianus onuruna yapılan "
        "iki katlı anıtsal bir çeşmedir. Cephenin ortasında ayağını bir küreye basmış imparator heykeli dururdu; "
        "bugün yalnızca ayak ve küre parçası yerindedir.\n\n"
        "Cephe, bulunan parçalarla kısmen yeniden kurulmuştur; havuz ve sütunlar suyun bir zamanlar nasıl aktığını "
        "hayal ettirir. Heykellerin asılları Efes Müzesi'ndedir. Hadrianus Tapınağı'na giderken yolun hemen "
        "üzerindedir.",
        "The Fountain of Trajan on Curetes Street in Ephesus is a two-storey monumental fountain built in the early 2nd "
        "century in honour of the Emperor Trajan. At the centre of the façade stood a statue of the emperor with one foot "
        "on a globe; today only the foot and globe remain in place.\n\n"
        "The façade has been partly rebuilt from the pieces found, and the basin and columns help you imagine the water "
        "once flowing here. The original statues are in the Ephesus Museum. It lies right on the street on your way to "
        "the Temple of Hadrian."),

    "trajan-tapinagi": (5,
        "Pergamon akropolünün en yüksek noktasındaki Trajan Tapınağı, 2. yüzyılda İmparator Traianus ve Zeus Philios "
        "için yapılmaya başlandı, Hadrianus döneminde tamamlandı. Tapınak, yüksek bir teras üzerinde, uzaktan "
        "görülecek biçimde konumlandırılmıştı.\n\n"
        "Alman arkeologların yeniden diktiği beyaz mermer Korint sütunları, akropolün en çok fotoğraflanan "
        "görüntüsüdür. Terasın kenarından aşağıda tiyatro ve Bergama ovası görülür. Rüzgârlı ve gölgesiz bir "
        "noktadır; öğle sıcağından kaçının.",
        "At the highest point of the Pergamon acropolis, the Temple of Trajan was begun in the 2nd century for the "
        "Emperor Trajan and Zeus Philios and completed under Hadrian. It was set on a high terrace so that it could be "
        "seen from afar.\n\n"
        "Its white marble Corinthian columns, re-erected by German archaeologists, are the most photographed view of the "
        "acropolis. From the edge of the terrace you look down on the theatre and the Bergama plain. It is windy and "
        "shadeless here; avoid the midday heat."),

    "sirince": (5,
        "Selçuk'un yaklaşık 8 km doğusunda, tepelerin arasındaki Şirince, eski adı Kirkinca olan bir Rum köyüydü. 1923 "
        "nüfus mübadelesinden sonra Selanik çevresinden gelen ailelerin yerleştiği köy, sonradan Şirince adını aldı. "
        "Yamaca basamak basamak dizilen beyaz badanalı taş evleri korunmuştur.\n\n"
        "Dar sokaklarda dolaşın, meyve şaraplarını tadın, köy kahvaltısı yapın; Vaftizci Yahya Kilisesi ve köyün "
        "üstündeki tepeler manzara sunar. Hafta sonları ve tatillerde çok kalabalık olur; hafta içi sabah saatleri "
        "daha sakindir. Efes ile aynı güne kolayca eklenir.",
        "About 8 km east of Selçuk, tucked among the hills, Şirince was a Greek village formerly called Kirkintzes. After "
        "the 1923 population exchange, families from around Thessaloniki settled here and the village later took the "
        "name Şirince. Its whitewashed stone houses, stacked up the hillside, have been preserved.\n\n"
        "Wander the narrow streets, taste the fruit wines and have a village breakfast; the Church of St John the Baptist "
        "and the hills above the village offer views. It gets very crowded at weekends and holidays, while weekday "
        "mornings are calmer. It is easy to add to a day at Ephesus."),

    "alacati": (5,
        "Çeşme'ye bağlı Alaçatı, 19. yüzyılda bağcılık ve tütüncülükle gelişen bir Rum kasabasıydı. Taş evleri, renkli "
        "pencere kepenkleri ve tepedeki yel değirmenleri o dönemden kalır. Bugün Ege'nin en popüler tatil "
        "yerlerinden biridir.\n\n"
        "Dar sokaklardaki butik oteller, restoranlar ve tasarım dükkânları yazın çok canlıdır. Kasabanın güneyindeki "
        "koy, sürekli esen rüzgârı nedeniyle dünyanın önemli rüzgâr sörfü noktalarındandır; baharda düzenlenen Ot "
        "Festivali de ünlüdür. Yaz akşamları çok kalabalık olur; sakin bir gezi için ilkbaharı ya da sonbaharı seçin.",
        "Alaçatı, part of Çeşme, was a Greek town that grew in the 19th century on vineyards and tobacco. Its stone "
        "houses, colourful shutters and the windmills on the hill date from that period. Today it is one of the most "
        "popular holiday spots on the Aegean.\n\n"
        "Boutique hotels, restaurants and design shops in the narrow streets are lively in summer. The bay south of town, "
        "with its constant wind, is one of the world's notable windsurfing spots, and the Herb Festival held in spring is "
        "well known. Summer evenings get very crowded; for a quieter visit choose spring or autumn."),

    "birgi": (5,
        "Ödemiş'e bağlı Birgi, Bozdağlar'ın eteğinde, bir dere vadisine kurulmuş tarihi bir kasabadır. Bizans "
        "döneminde Pyrgion adıyla bilinen yerleşim, 14. yüzyılda Aydınoğulları Beyliği'nin başkenti oldu ve 15. "
        "yüzyılın başında Osmanlı topraklarına katıldı.\n\n"
        "Ulu Cami, Çakırağa Konağı, İmam Birgivi'nin türbesi ve yüzlerce yıllık ahşap çıkmalı evleriyle Batı "
        "Anadolu'nun en iyi korunmuş kasabalarındandır. Taş döşeli sokaklarda yürüyün, çınar altındaki kahvelerde "
        "oturun. Hafta sonu kalabalıklaşır; bir gece konaklamak kasabanın sakinliğini daha iyi hissettirir.",
        "Birgi, part of Ödemiş, is a historic town set in a stream valley at the foot of the Bozdağlar mountains. Known as "
        "Pyrgion in the Byzantine period, it became the capital of the Aydınid principality in the 14th century and "
        "passed to the Ottomans in the early 15th century.\n\n"
        "With its Grand Mosque, the Çakırağa Mansion, the tomb of İmam Birgivi and centuries-old timber houses with "
        "projecting upper floors, it is one of the best-preserved towns in western Anatolia. Walk the stone-paved "
        "streets and sit in the cafés under the plane trees. It gets busy at weekends; staying a night lets you feel "
        "the town's calm better."),

    "sahin-tepesi": (5,
        "Buca ile Bornova arasındaki yol üzerinde bulunan Şahin Tepesi, kentin iç kesiminden İzmir Körfezi'ne ve "
        "şehrin büyük bölümüne açılan geniş bir manzara sunar. Kıvrımlı Şahin Tepesi yolu, iki ilçeyi birbirine "
        "bağlayan eski güzergâhlardandır.\n\n"
        "Gün batımında körfeze doğru yayılan şehir ışıkları özellikle güzeldir. Tepe ve çevresi bir seyir noktası "
        "olarak kullanılır; araçla gidiyorsanız yol dik ve virajlıdır, dikkatli sürün. Kalabalıktan uzak, kısa bir "
        "akşam gezisi için uygundur.",
        "On the road between Buca and Bornova, Şahin Hill offers a wide view from the inland part of the city over the "
        "Gulf of İzmir and much of the city. The winding Şahin Tepesi road is one of the old routes linking the two "
        "districts.\n\n"
        "At sunset the city lights spreading towards the gulf are especially beautiful. The hill and its surroundings "
        "serve as a viewpoint; if you drive, the road is steep and twisting, so take care. It suits a short evening "
        "outing away from the crowds."),

    "yamanlar-dagi": (5,
        "Karşıyaka'nın arkasında yükselen Yamanlar Dağı, yaklaşık 1.076 metre yüksekliğinde, büyük ölçüde volkanik "
        "kayalardan oluşan bir dağdır. İzmirlilerin en sevdiği hafta sonu kaçış noktalarından biridir.\n\n"
        "Çam ormanları arasındaki krater gölü Karagöl, mitolojide Tantalos efsanesiyle ilişkilendirilir; gölün "
        "çevresinde yürüyüş ve piknik alanları vardır. Yukarıdan körfezin ve şehrin geniş bir manzarası görülür. "
        "Yazın orman yangını riskine karşı ateş yakılmaması gereken alanlara dikkat edin.",
        "Rising behind Karşıyaka, Mount Yamanlar is about 1,076 metres high and made largely of volcanic rock. It is one "
        "of İzmir residents' favourite weekend escapes.\n\n"
        "Karagöl, a crater lake among the pine forests, is linked in mythology with the legend of Tantalus, and there are "
        "walking and picnic areas around the lake. From up here you get a wide view of the gulf and the city. In summer "
        "pay attention to the areas where fires are banned because of the forest-fire risk."),

    "gediz-deltasi": (5,
        "Gediz Nehri'nin İzmir Körfezi'ne döküldüğü yerde oluşan delta, Çiğli, Menemen ve Foça kıyılarına yayılan "
        "yaklaşık 15.000 hektarlık bir sulak alandır. 1998'den beri uluslararası öneme sahip Ramsar alanıdır ve "
        "Türkiye'nin en önemli kuş alanlarındandır.\n\n"
        "Lagünler, tuzlalar, sazlıklar ve çamur düzlükleri yüzlerce kuş türüne ev sahipliği yapar; flamingolar yıl "
        "boyunca görülür ve burada ürer. Alanı görmek için en iyi yer İzmir Kuş Cenneti'dir; dürbün getirin ve kuşları "
        "rahatsız etmeden gözlemleyin. İlkbahar ve sonbahar göç dönemleri en zengin zamanlardır.",
        "Formed where the Gediz River flows into the Gulf of İzmir, the delta is a wetland of about 15,000 hectares "
        "spreading along the shores of Çiğli, Menemen and Foça. It has been a Ramsar site of international importance "
        "since 1998 and is one of Turkey's most important bird areas.\n\n"
        "Lagoons, salt pans, reed beds and mudflats host hundreds of bird species; flamingos are seen year-round and breed "
        "here. The best place to see the area is the İzmir Bird Paradise; bring binoculars and watch the birds without "
        "disturbing them. The spring and autumn migration seasons are the richest times."),

    "buyuk-park": (5,
        "Bornova'daki Büyük Park, ilçenin merkezine yakın, ağaçlık ve geniş bir şehir parkıdır. Ege Üniversitesi "
        "yerleşkesine komşu olduğundan öğrencilerin ve ailelerin buluştuğu bir yeşil alandır.\n\n"
        "Yürüyüş yolları, çimenlik alanlar ve oturma yerleriyle kısa bir mola ya da sabah yürüyüşü için uygundur. "
        "Bornova'nın Levanten köşkleri ve Cumhuriyet Meydanı ile birlikte bir ilçe gezisine eklenebilir.",
        "Büyük Park in Bornova is a wide, wooded city park near the district centre. Bordering the Ege University "
        "campus, it is a green space where students and families meet.\n\n"
        "With its walking paths, lawns and benches it suits a short break or a morning walk. It can be added to a tour of "
        "the district together with Bornova's Levantine mansions and Cumhuriyet Square."),

    "izmir-kus-cenneti": (5,
        "Çiğli'deki İzmir Kuş Cenneti, Gediz Deltası'nın en korunaklı bölümüdür. 1980'lerde su kuşları koruma ve üreme "
        "sahası ile birinci derece doğal sit alanı ilan edildi. Türkiye'deki kuş türlerinin önemli bir bölümü burada "
        "görülebilir.\n\n"
        "Ziyaretçi merkezinde alanı tanıtan sergiler bulunur; buradan yürüyerek ya da bisikletle gözlem kulelerine "
        "gidilir. Flamingolar, pelikanlar ve balıkçıllar en sık görülen kuşlardır. Dürbün getirin, sessiz olun ve "
        "patikalardan ayrılmayın. Sabah erken ve akşamüstü kuşlar daha hareketlidir; yazın sivrisineğe karşı hazırlıklı olun.",
        "The İzmir Bird Paradise in Çiğli is the most protected part of the Gediz Delta. In the 1980s it was declared a "
        "waterbird protection and breeding area and a first-degree natural site. A large share of Turkey's bird species "
        "can be seen here.\n\n"
        "The visitor centre has displays introducing the area, and from there you walk or cycle to the observation "
        "towers. Flamingos, pelicans and herons are the birds you see most often. Bring binoculars, keep quiet and stay "
        "on the paths. Birds are most active early in the morning and late in the afternoon; in summer be ready for mosquitoes."),

    "camalti-tuzlasi": (5,
        "Gediz Deltası'ndaki Çamaltı Tuzlası, yaklaşık 58 km²'lik alanıyla Türkiye'nin en büyük deniz tuzlasıdır. "
        "Evliya Çelebi'nin de sözünü ettiği tuzla, 19. yüzyılda modern üretime geçti ve bugün ülkenin deniz tuzu "
        "ihtiyacının büyük bölümünü karşılar.\n\n"
        "Sığ tuz havuzlarında yaşayan küçük karidesler, flamingolara pembe rengini veren besin kaynağıdır; bu yüzden "
        "havuzların kenarında yüzlerce flamingo beslenirken görülebilir. Tuzlanın içi işletme alanıdır; flamingoları "
        "Kuş Cenneti'nin gözlem noktalarından ya da yol kenarındaki uygun yerlerden izleyin.",
        "The Çamaltı Salt Pan in the Gediz Delta, covering about 58 km², is Turkey's largest sea salt works. Mentioned by "
        "Evliya Çelebi, it switched to modern production in the 19th century and today meets much of the country's need "
        "for sea salt.\n\n"
        "The tiny shrimps living in the shallow salt pools are the food that gives flamingos their pink colour, so "
        "hundreds of flamingos can be seen feeding at the edges of the pools. The salt works itself is an industrial "
        "area; watch the flamingos from the Bird Paradise viewpoints or suitable spots by the road."),

    "kulturpark": (5,
        "Kültürpark, 1922 yangınında harabeye dönen bölgenin üzerinde 1936'da kuruldu ve kısa sürede genişletildi. "
        "Belediye Başkanı Behçet Uz'un önderliğinde açılan park, kurulduğundan beri İzmir Enternasyonal Fuarı'na ev "
        "sahipliği yapar ve kentin kültür hayatının merkezlerindendir.\n\n"
        "Ağaçlık yolları, göleti, Paraşüt Kulesi, açık hava tiyatrosu ve fuar pavyonlarıyla şehrin ortasında büyük bir "
        "yeşil alandır. Yaz sonundaki fuar döneminde konserler ve etkinliklerle dolup taşar; diğer zamanlarda sakin "
        "bir yürüyüş için idealdir. İçindeki yapılar ayrıca işaretlenebilir.",
        "Kültürpark was founded in 1936 on the area left in ruins by the 1922 fire and was soon enlarged. Opened under the "
        "leadership of Mayor Behçet Uz, the park has hosted the İzmir International Fair since its founding and is one of "
        "the centres of the city's cultural life.\n\n"
        "With tree-lined paths, a pond, the Parachute Tower, an open-air theatre and fair pavilions, it is a large green "
        "space in the middle of the city. During the fair at the end of summer it overflows with concerts and events; at "
        "other times it is ideal for a calm walk. The buildings inside can be checked off separately."),

    "buca-golet": (5,
        "Buca Gölet, Mart 1999'da açılan ve yaklaşık 167.000 m²'lik alana yayılan bir rekreasyon alanıdır. Ortasında "
        "yapay bir gölet, çevresinde amfitiyatro, kafeterya ve restoranlar bulunur.\n\n"
        "Göletin çevresindeki yürüyüş yolu, çocuk oyun alanları ve piknik yerleri hafta sonları aileler tarafından "
        "yoğun kullanılır. Ağaçlık alanda sabah yürüyüşü yapmak ya da gölete karşı çay içmek için uygundur.",
        "Buca Gölet is a recreation area opened in March 1999, covering about 167,000 m². At its centre is an artificial "
        "pond, surrounded by an amphitheatre, a cafeteria and restaurants.\n\n"
        "The walking path around the pond, playgrounds and picnic spots are busy with families at weekends. The wooded "
        "area suits a morning walk or a glass of tea facing the water."),

    "susuzdede-parki": (5,
        "Göztepe'deki Susuzdede Parkı, aynı adı taşıyan tepenin üzerinde yer alan yaklaşık 46.000 m²'lik bir parktır. "
        "Tepe, Cumhuriyet'ten önce Aya Agapi olarak bilinirdi; bugünkü adını burada bulunan Susuz Dede'nin mezarından "
        "alır.\n\n"
        "Güzelyalı ve Göztepe'nin üzerinden körfeze, karşıdaki Karşıyaka'ya ve şehrin silüetine geniş bir manzara açılır; "
        "gün batımı en güzel zamanıdır. Kafesi ve oturma alanlarıyla kısa bir akşam molası için uygundur.",
        "Susuzdede Park in Göztepe is a park of about 46,000 m² on the hill of the same name. Before the Republic the hill "
        "was known as Aya Agapi; it takes its present name from the tomb of Susuz Dede that stands here.\n\n"
        "From above Güzelyalı and Göztepe it opens a wide view of the gulf, Karşıyaka on the far shore and the city "
        "skyline; sunset is the best time. With its café and seating areas it suits a short evening break."),

    "asik-veysel-rekreasyon-alani": (5,
        "Bornova'daki Aşık Veysel Rekreasyon Alanı, halk ozanı Âşık Veysel'in adını taşır. Yapımına 2008'de başlanan "
        "ve 2010'da açılan park, yaklaşık 231.000 m²'lik alanıyla İzmir'in büyük yeşil alanlarındandır.\n\n"
        "Göl, geniş çimenler, yürüyüş ve bisiklet yolları ile spor alanları bulunur; içindeki Buz Sporları Salonu'nda "
        "paten yapılabilir. Hafta sonları piknikçiler ve ailelerle dolar; sabahları koşu için uygundur.",
        "Aşık Veysel Recreation Area in Bornova is named after the folk poet Âşık Veysel. Begun in 2008 and opened in 2010, "
        "the park covers about 231,000 m² and is one of İzmir's large green spaces.\n\n"
        "It has a lake, wide lawns, walking and cycling paths and sports grounds, and you can go skating at the Ice Sports "
        "Hall inside. At weekends it fills with picnickers and families, while mornings are good for running."),

    "kordon": (5,
        "Kordon, Konak'taki Cumhuriyet Meydanı'ndan Alsancak Limanı'na kadar körfez boyunca uzanan kıyı şerididir. 19. "
        "yüzyılın ikinci yarısında rıhtım olarak yapıldı; konsoloslukların, otellerin ve tüccar evlerinin sıralandığı "
        "bu kıyı, kentin vitrini oldu. 1922 yangınından sonra yeniden biçimlendi.\n\n"
        "Bugün İzmir'in en sevilen yürüyüş, bisiklet ve gün batımı yeridir: çimenlere oturup körfeze karşı simit "
        "yemek, fayton ya da tramvayla gezmek, kıyıdaki kafe ve barlarda akşamı geçirmek klasik İzmir deneyimidir. "
        "Gün batımında çok kalabalık olur; erken gelin.",
        "The Kordon is the waterfront strip running along the gulf from Cumhuriyet Square in Konak to Alsancak Port. "
        "Built as a quay in the second half of the 19th century, lined with consulates, hotels and merchants' houses, it "
        "became the city's showcase. It was reshaped after the fire of 1922.\n\n"
        "Today it is İzmir's favourite place for walking, cycling and watching the sunset: sitting on the grass with a "
        "simit facing the gulf, riding a horse-drawn carriage or the tram, and spending the evening at the cafés and bars "
        "along the shore are classic İzmir experiences. It gets very busy at sunset, so come early."),

    "hasanaga-bahcesi": (6,
        "Buca'daki Hasanağa Bahçesi, bir zamanlar Levanten iş insanı Aliotti'ye ait bir köşk ve bahçeydi. 1920'lerin "
        "ortasında Sarıgöllü Hasan Ağa tarafından satın alındı ve bugünkü adını aldı. Uzun yıllar özel mülk olarak "
        "kalan alan, sonradan belediyeye geçerek halka açık bir parka dönüştürüldü.\n\n"
        "Yaşlı ağaçların gölgesindeki yürüyüş yolları ve tarihi köşk yapısı, Buca'nın bağ evleri ve köşklerle dolu "
        "geçmişini hatırlatır. Sakin bir mola ya da piknik için uygundur. Yakında açılması planlanan metro istasyonu "
        "ulaşımı kolaylaştıracaktır; Buca'daki Levanten köşkleriyle aynı gezide görülebilir.",
        "Hasanağa Garden in Buca was once a mansion and garden belonging to the Levantine businessman Aliotti. In the mid-"
        "1920s it was bought by Hasan Ağa of Sarıgöl and took its present name. Long a private property, the grounds later "
        "passed to the municipality and became a public park.\n\n"
        "The walking paths under old trees and the historic mansion recall Buca's past of country houses and villas. It "
        "suits a quiet break or a picnic. A metro station planned nearby will make it easier to reach, and it can be "
        "seen on the same outing as Buca's Levantine mansions."),

    "ayibaligi-plaji": (6,
        "Karaburun Yarımadası'nın doğu kıyısında, Mordoğan yakınlarındaki Ayıbalığı Koyu, adını bu kıyılarda yaşayan "
        "Akdeniz foklarından (ayıbalığı) alır. Kayalık kıyılar arasında küçük bir kumsal ve son derece berrak bir "
        "deniz sunar.\n\n"
        "Kalabalık plajlardan uzak, doğal bir koy arayanlar için uygundur; tesis sınırlıdır, bu yüzden yiyecek, su ve "
        "gölgelik getirin. Foklar nadiren görülür; görürseniz yaklaşmayın ve rahatsız etmeyin. Yolu virajlıdır; "
        "Mordoğan ve Karaburun köyleriyle birlikte bir yarımada turuna eklenebilir.",
        "On the east coast of the Karaburun Peninsula near Mordoğan, Ayıbalığı Cove takes its name from the "
        "Mediterranean monk seals (ayıbalığı) that live along these shores. Between rocky shores it offers a small beach "
        "and exceptionally clear water.\n\n"
        "It suits those looking for a natural cove away from busy beaches; facilities are limited, so bring food, water "
        "and shade. The seals are rarely seen; if you do see one, keep your distance and do not disturb it. The road is "
        "winding; add it to a tour of the peninsula with Mordoğan and Karaburun's villages."),

    "badembuku-koyu": (6,
        "Karaburun Yarımadası'ndaki Badembükü Koyu, adını çevresindeki badem ağaçlarından alan, doğal haliyle "
        "korunmuş sakin bir koydur. Yarımadanın daha az bilinen köşelerinden biridir.\n\n"
        "Berrak denizi ve kalabalıktan uzak ortamıyla yüzmek ve dinlenmek için uygundur. Tesis yok denecek kadar azdır; "
        "su, yiyecek ve gölgelik getirin, çöplerinizi geri götürün. Koya ulaşan yolun bir kısmı dar ve bozuk olabilir, "
        "dikkatli sürün.",
        "Badembükü Cove on the Karaburun Peninsula, named after the almond trees around it, is a quiet cove kept in its "
        "natural state. It is one of the less-known corners of the peninsula.\n\n"
        "Its clear water and uncrowded setting make it good for swimming and relaxing. Facilities are almost non-existent; "
        "bring water, food and shade, and take your rubbish back with you. Part of the road to the cove may be narrow and "
        "rough, so drive carefully."),

    "ekmeksiz-plaji": (6,
        "Seferihisar'da, Sığacık'ın yakınındaki Ekmeksiz Plajı, ilçenin en uzun kumsallarından biridir. İnce kumu ve "
        "yavaş derinleşen denizi nedeniyle özellikle aileler tarafından tercih edilir.\n\n"
        "Plajın bir bölümü halka açık, bir bölümü işletmelerle donatılmıştır. Yaz hafta sonlarında kalabalık olur; "
        "sabah erken gidin. Sığacık Kalesi, limanı ve Teos antik kentiyle aynı gün birleştirilebilir.",
        "Near Sığacık in Seferihisar, Ekmeksiz Beach is one of the longest sandy beaches in the district. With its fine "
        "sand and gently shelving sea, it is especially popular with families.\n\n"
        "Part of the beach is public and part is equipped by businesses. It gets busy on summer weekends, so go early. It "
        "combines in one day with Sığacık Castle and harbour and the ancient city of Teos."),

    "pamucak-sahili": (6,
        "Selçuk'a bağlı Pamucak, Küçük Menderes Nehri'nin denize döküldüğü yerin yakınında uzanan, kilometrelerce uzun "
        "ve geniş bir kumsaldır. Efes'e birkaç kilometre uzaklıktadır; antik çağda kentin limanı da bu kıyıya "
        "yakındı.\n\n"
        "Geniş kumsalı sayesinde kalabalık günlerde bile yer bulmak kolaydır. Açık denize bakan kıyıda zaman zaman "
        "dalga ve akıntı olabilir; çocuklarla dikkatli olun. Efes gezisinden sonra serinlemek ve gün batımını izlemek "
        "için iyi bir seçenektir.",
        "Pamucak, part of Selçuk, is a broad sandy beach stretching for kilometres near where the Küçük Menderes River "
        "meets the sea. It lies a few kilometres from Ephesus, whose ancient harbour was also close to this coast.\n\n"
        "Thanks to its width, it is easy to find space even on busy days. Facing the open sea, the shore can have waves and "
        "currents at times, so take care with children. It is a good choice for cooling off and watching the sunset after "
        "visiting Ephesus."),

    "akarca-sahili": (6,
        "Seferihisar'daki Akarca Sahili, sığ ve sakin denizi, yazlık siteleri ve sahil yürüyüş yoluyla bilinir. İzmir'e "
        "yakınlığı nedeniyle kentlilerin hafta sonu kaçış noktalarından biridir.\n\n"
        "Denizin uzun süre sığ kalması küçük çocuklu aileler için rahattır. Sahil boyunca kafeler ve küçük plajlar "
        "sıralanır. Seferihisar merkezindeki pazar ve Sığacık Kalesi ile birlikte bir gün planlanabilir.",
        "Akarca Beach in Seferihisar is known for its shallow, calm sea, summer housing and seaside promenade. Being close "
        "to İzmir, it is one of the city's weekend escapes.\n\n"
        "The long stretch of shallow water is comfortable for families with small children. Cafés and small beaches line "
        "the shore. A day can be planned together with the market in central Seferihisar and Sığacık Castle."),

    "alacati-bay-surf-beach": (6,
        "Alaçatı'nın güneyindeki koy, yaz boyunca düzenli esen kuzey rüzgârı ve sığ suyu sayesinde dünyanın önemli "
        "rüzgâr sörfü noktalarından biri sayılır. Koy kıyısında çok sayıda sörf okulu ve ekipman kiralama yeri "
        "bulunur; uluslararası yarışlara da ev sahipliği yapmıştır.\n\n"
        "Rüzgârın neredeyse her gün estiği yaz ayları, öğrenmek için de uygun zamandır; sığ su yeni başlayanlara güven "
        "verir. Yüzmek için rüzgârsız günleri ya da sabah saatlerini seçin. Gün sonunda Alaçatı'nın taş sokaklarına "
        "geçebilirsiniz.",
        "The bay south of Alaçatı, with its steady northerly summer wind and shallow water, is counted among the world's "
        "notable windsurfing spots. Its shore is lined with surf schools and equipment rental, and it has hosted "
        "international competitions.\n\n"
        "The summer months, when the wind blows almost daily, are also a good time to learn, and the shallow water gives "
        "beginners confidence. For swimming, choose windless days or the morning. At the end of the day you can head into "
        "the stone streets of Alaçatı."),

    "altinkum-plaji": (6,
        "Çeşme'nin güneyindeki Altınkum, ince altın renkli kumu ve turkuaz denizi olan birkaç koydan oluşur. Çeşme'nin "
        "en güzel plajları arasında sayılır ve hem halka açık bölümleri hem de işletmeleri vardır.\n\n"
        "Deniz berrak ve yavaş derinleşir; ancak Ege suyu yazın bile serin olabilir. Yaz hafta sonlarında otopark "
        "erken dolar, sabah erken gitmek iyi olur. Çeşme merkezi ve Alaçatı'ya kısa bir sürüş uzaklığındadır.",
        "South of Çeşme, Altınkum is made up of several coves with fine golden sand and turquoise water. It is counted "
        "among Çeşme's most beautiful beaches and has both public sections and beach businesses.\n\n"
        "The water is clear and shelves gently, though the Aegean can be cool even in summer. Parking fills up early on "
        "summer weekends, so arrive early. It is a short drive from central Çeşme and Alaçatı."),

    "dikili-halk-plaji": (6,
        "Dikili'nin merkezine yakın halk plajı, ilçenin uzun kumsal şeridi boyunca uzanır. Ücretsiz ve kolay "
        "ulaşılabilir olduğu için yazın hem yerel halkın hem de yazlıkçıların buluşma yeridir.\n\n"
        "Sahil boyunca yürüyüş yolu, çay bahçeleri ve balık restoranları bulunur. Gün batımında Midilli Adası'na doğru "
        "batan güneşi izlemek güzeldir. Çandarlı Kalesi ve Bergama, aynı tatil içinde gezilebilecek yakınlıktadır.",
        "The public beach near central Dikili stretches along the district's long sandy shore. Free and easy to reach, it "
        "is a summer meeting place for locals and holidaymakers alike.\n\n"
        "A promenade, tea gardens and fish restaurants line the shore. Watching the sun set towards Lesbos is a treat. "
        "Çandarlı Castle and Bergama are close enough to visit during the same holiday."),

    "uzunada": (6,
        "İzmir Körfezi'nin girişindeki Uzunada, yaklaşık 27 km²'lik yüzölçümüyle Türkiye'nin en büyük adalarından "
        "biridir. Antik çağda Drymoussa olarak anılan adada bugün yerleşim yoktur ve doğası büyük ölçüde korunmuştur.\n\n"
        "Adanın bir bölümü askeri alan olduğundan karaya çıkış kısıtlıdır; adayı en iyi Karaburun ya da Foça'dan "
        "kalkan tekne turlarında, koylarında yüzerek tanıyabilirsiniz. Kıyılarında Akdeniz foklarının da yaşadığı "
        "bilinir; rastlarsanız uzak durun.",
        "Uzunada, at the entrance to the Gulf of İzmir, is one of Turkey's largest islands at about 27 km². Known in "
        "antiquity as Drymoussa, it has no settlement today and its nature is largely preserved.\n\n"
        "As part of the island is a military area, landing is restricted; the best way to get to know it is on a boat "
        "trip from Karaburun or Foça, swimming in its coves. Mediterranean monk seals are known to live along its shores; "
        "if you meet one, keep away."),

    "garip-adasi": (6,
        "Dikili'nin Bademli Koyu açığındaki Garip Adası, Kalem Adası ile yan yana duran küçük bir adadır. Yakındaki Kane "
        "Yarımadası ile birlikte bu kıyının doğal dokusunun parçasıdır.\n\n"
        "Adada yerleşim yoktur; çevresi tekne turları, yüzme ve dalış için tercih edilir. Bademli koyundan bakınca "
        "gün batımında özellikle güzel görünür. Gezilerinizi tekneyle planlayın ve doğal alana saygılı olun.",
        "Garip Island, off Bademli Bay in Dikili, is a small island lying side by side with Kalem Island. Together with the "
        "nearby Kane Peninsula, it is part of the natural landscape of this coast.\n\n"
        "The island is uninhabited; the waters around it are popular for boat trips, swimming and diving. Seen from "
        "Bademli bay it looks especially lovely at sunset. Plan your visit by boat and respect the natural area."),

    "karantina-adasi": (6,
        "Urla'daki Karantina Adası, adını 1865'te Fransızların burada kurduğu karantina tesislerinden alır. Osmanlı "
        "döneminde İzmir'e gelen gemilerin yolcuları bulaşıcı hastalıklara karşı burada bekletilirdi; tesis, kendi "
        "döneminin oldukça gelişmiş bir sağlık yapısıydı. Antik Klazomenai'nin bir bölümü de bu ada üzerindeydi.\n\n"
        "Ada, kıyıya bir yolla bağlıdır. Tarihi yapılar ve adanın kıyısı, Urla İskele'deki balık restoranları ile "
        "birlikte kısa bir yürüyüş için uygundur. Bazı alanlar kamu kullanımında olabileceğinden kapalı bölümlere "
        "girmeyin.",
        "Karantina (Quarantine) Island in Urla takes its name from the quarantine facilities set up here by the French in "
        "1865. In Ottoman times passengers on ships arriving at İzmir were held here as a precaution against infectious "
        "disease; the station was quite advanced for its time. Part of ancient Klazomenai also stood on this island.\n\n"
        "The island is linked to the shore by a road. Its historic buildings and shoreline suit a short walk together with "
        "the fish restaurants at Urla İskele. Some areas may be in public use, so do not enter closed sections."),

    "cifit-adasi": (6,
        "Seferihisar kıyısının hemen önündeki Çıfıtkalesi Adası, anakaraya yüz metreden daha yakın küçük bir adacıktır. "
        "Antik çağda burada Myonnesos yerleşimi bulunuyordu ve adacığın anakaraya bir set ile bağlı olduğu bilinir.\n\n"
        "Adacıkta sur ve yapı kalıntıları görülebilir; çevresindeki berrak su yüzme ve şnorkel için çok uygundur. "
        "Kıyıdan kısa bir yüzüşle ya da kanoyla ulaşanlar olur; kayalık yüzeyde dikkatli olun ve kalıntılara zarar "
        "vermeyin.",
        "Just off the Seferihisar coast, Çıfıtkalesi is a small islet less than a hundred metres from the mainland. In "
        "antiquity the settlement of Myonnesos stood here, and the islet is known to have been joined to the mainland "
        "by a causeway.\n\n"
        "Remains of walls and buildings can be seen on the islet, and the clear water around it is excellent for swimming "
        "and snorkelling. Some people reach it with a short swim or by canoe from the shore; take care on the rocky "
        "surface and do not damage the ruins."),

    "kalem-adasi": (6,
        "Dikili'nin Bademli kıyısına yaklaşık 400 metre uzaklıktaki Kalem Adası, kuzey-güney yönünde uzanan dar ve "
        "uzun bir adadır. Garip Adası ile birlikte Bademli koyunun önünde yer alır.\n\n"
        "Adanın çevresi, berrak suyu ve sakin koylarıyla tekne gezileri ve yüzme için tercih edilir. Ada üzerinde "
        "kamuya açık bir tesis bulunmadığından ziyaret genellikle tekneden yapılır; doğal alana saygılı olun.",
        "About 400 metres off the Bademli shore in Dikili, Kalem Island is a narrow, elongated island running north to "
        "south. Together with Garip Island it lies in front of Bademli bay.\n\n"
        "With its clear water and quiet coves, the waters around the island are popular for boat trips and swimming. As "
        "there are no public facilities on the island, visits are usually made from a boat; respect the natural area."),

    "degirmendere-selalesi": (6,
        "Değirmendere Şelalesi, orman içinde kısa bir yürüyüşle ulaşılan doğal bir şelaledir. Adını aldığı dere "
        "boyunca eskiden su değirmenlerinin bulunduğu bu vadi, İzmir'e yakın serin bir kaçış noktasıdır.\n\n"
        "Şelalenin suyu yağışlı aylarda ve ilkbaharda en bol halindedir; yaz sonunda azalabilir. Patika kayalık ve "
        "yer yer kaygan olabilir, uygun ayakkabı giyin. Doğaya çöp bırakmayın ve ateş yakmayın.",
        "Değirmendere Waterfall is a natural waterfall reached by a short walk through the forest. The valley, along the "
        "stream that once turned water mills and gave the place its name, is a cool escape close to İzmir.\n\n"
        "The waterfall is at its fullest in the rainy months and in spring, and may dwindle by late summer. The path can "
        "be rocky and slippery in places, so wear suitable shoes. Leave no rubbish and do not light fires."),

    "buyuk-su-ucuran-selalesi": (6,
        "Menemen'in kuzeyindeki dağlık alanda bulunan Büyük Su Uçuran Şelalesi, yürüyüşle ulaşılan yüksek bir "
        "şelaledir. Su, kayalık bir yamaçtan dökülürken adını veren görüntüyü oluşturur.\n\n"
        "Şelaleye giden patika orman ve kayalıklar arasından geçer; yürüyüş deneyimi olanlar için uygundur. Su, kış "
        "ve ilkbahar aylarında en coşkulu halindedir. Yanınıza su alın, yalnız gitmemeye çalışın ve yağışlı günlerde "
        "kaygan kayalara dikkat edin.",
        "In the hills north of Menemen, Büyük Su Uçuran ('Great Flying Water') is a tall waterfall reached on foot. The "
        "water pours down a rocky slope, creating the sight that gives it its name.\n\n"
        "The trail runs through forest and rocks and suits those with some hiking experience. The falls are at their most "
        "vigorous in winter and spring. Bring water, try not to go alone, and watch out for slippery rocks on rainy days."),

    "nebiler": (6,
        "Dikili'nin Nebiler köyü yakınlarındaki şelale, dar bir kanyonun içinde akan derenin oluşturduğu bir dizi küçük "
        "çağlayan ve havuzdan oluşur. Çevre köylerin serinlemek için gittiği doğal bir alandır.\n\n"
        "Kanyon boyunca yürürken bazı yerlerde suya girmek gerekebilir; su ayakkabısı işinize yarar. Su miktarı "
        "mevsime göre değişir, en canlı hali ilkbahardadır. Yağışlı havalarda dere aniden yükselebilir, dikkatli olun.",
        "The waterfall near the village of Nebiler in Dikili is a series of small cascades and pools formed by a stream "
        "flowing through a narrow canyon. It is a natural spot where people from nearby villages come to cool off.\n\n"
        "Walking along the canyon you may need to wade in places, so water shoes are useful. The amount of water varies "
        "with the season and is liveliest in spring. In rainy weather the stream can rise suddenly, so be careful."),

    "izmir-kultur-sanat-fabrikasi": (2,
        "Alsancak'taki İzmir Kültür Sanat Fabrikası, kentin eski Tekel tütün fabrikasının restore edilmesiyle "
        "oluşturulan büyük bir kültür kompleksidir. İzmir Resim ve Heykel Müzesi 2023'te buraya taşındı; Kültürpark'taki "
        "İzmir Tarih ve Sanat Müzesi'nin eserleri de buraya aktarıldı ve kompleks içinde bir arkeoloji ve etnografya "
        "müzesi açıldı.\n\n"
        "Müze, İzmir ve çevresinin 8.500 yılı aşan tarihini tematik salonlarda anlatır; yanında resim ve heykel "
        "koleksiyonları, dönemsel sergiler ve konserler yer alır. Endüstri yapısının yüksek tavanlı salonları da "
        "görülmeye değer. Kültürpark'ın kuzey kenarına ve Alsancak'a yürüme mesafesindedir.",
        "The İzmir Culture and Art Factory in Alsancak is a large cultural complex created by restoring the city's old "
        "Tekel tobacco factory. The İzmir Museum of Painting and Sculpture moved here in 2023; the collections of the "
        "İzmir Museum of History and Art in Kültürpark were also transferred here, and an archaeology and ethnography "
        "museum opened within the complex.\n\n"
        "The museum tells more than 8,500 years of the history of İzmir and its region in themed halls, alongside "
        "painting and sculpture collections, temporary exhibitions and concerts. The high-ceilinged halls of the "
        "industrial building are worth seeing in themselves. It is within walking distance of the north edge of "
        "Kültürpark and of Alsancak."),

    "ataturk-acik-hava-tiyatrosu": (3,
        "Kültürpark'ın içindeki Açıkhava Tiyatrosu, parkın ve İzmir Enternasyonal Fuarı'nın en tanınmış sahnelerinden "
        "biridir. Kuşaklar boyunca fuar konserleriyle özdeşleşen tiyatro, Türkiye'nin pek çok ünlü sanatçısının "
        "İzmirlilerle buluştuğu yer oldu.\n\n"
        "Yaz sonundaki fuar döneminde neredeyse her akşam konser düzenlenir; program ve bilet bilgisini önceden kontrol "
        "edin. Etkinlik olmayan günlerde sahne ve basamaklar parkın sakin bir köşesidir. Paraşüt Kulesi ve göletle "
        "birlikte bir Kültürpark yürüyüşüne eklenebilir.",
        "The Open-Air Theatre in Kültürpark is one of the best-known stages of the park and of the İzmir International "
        "Fair. Associated for generations with the fair's concerts, it is where many of Turkey's famous performers have "
        "met audiences in İzmir.\n\n"
        "During the fair at the end of summer there are concerts almost every evening; check the programme and tickets in "
        "advance. On days without events, the stage and terraces are a quiet corner of the park. Add it to a Kültürpark "
        "walk together with the Parachute Tower and the pond."),
}
