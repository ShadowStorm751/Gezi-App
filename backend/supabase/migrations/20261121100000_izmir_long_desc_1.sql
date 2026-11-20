-- İzmir uzun açıklamaları, 1. parti (20 yer, TR + EN).
-- Üreten: data-pipeline/content/build_long_desc.py (kaynak: content/izmir_long_descriptions.py).
-- Metinler kendi cümlelerimizdir; Vikipedi/Wikidata yalnızca bilgi kontrolü için kullanıldı.

update public.place_translations t
   set long_desc = v.long_desc
  from (values
  ('isa-bey-camii', 'tr', 'Selçuk''ta, Ayasuluk Tepesi''nin eteğinde, Artemis Tapınağı ile Aziz Yuhanna Bazilikası arasında duran İsa Bey Camii, Aydınoğlu İsa Bey adına 1374-1375''te yapıldı. Şamlı mimar Ali bin Müşeymiş''in eseri olan cami, plan olarak Şam Emevi Camii''nden esinlenir ve Anadolu beylikleri döneminin en gösterişli yapılarından sayılır. 19. yüzyılda bir süre kervansaray olarak da kullanıldı.

Geniş avluyu çevreleyen duvarlarda ve harimde, çevredeki antik kentten getirilmiş granit sütunlar ile mermer parçalar dikkat çeker; batı cephesindeki renkli taş işçiliğine ve kapı çevresindeki süslemelere yakından bakın. Aziz Yuhanna Bazilikası ve Artemis Tapınağı yürüme mesafesinde olduğundan üçü aynı gezide görülebilir.'),
  ('isa-bey-camii', 'en', 'At the foot of Ayasuluk Hill in Selçuk, between the Temple of Artemis and the Basilica of St John, the İsa Bey Mosque was built in 1374-1375 in the name of the Aydınid ruler İsa Bey. Designed by the Damascene architect Ali ibn Mushaimish, its plan draws on the Great Mosque of Damascus, and it is counted among the most impressive buildings of the Anatolian beyliks. In the 19th century it was used for a time as a caravanserai.

Around the wide courtyard and in the prayer hall you can spot granite columns and marble pieces reused from the ancient city nearby; look closely at the coloured stonework of the west façade and the carving around the doors. The Basilica of St John and the Temple of Artemis are within walking distance, so all three fit into one visit.'),
  ('hisar-camii', 'tr', 'Kemeraltı''nın Hisarönü bölgesinde, Kızlarağası Hanı''nın yakınındaki Hisar Camii, 1597-1598''de Aydınoğulları soyundan Molla Yakup Bey tarafından yaptırıldı. Adını, bugün izi kalmayan ve liman ağzını koruyan eski kaleden (hisar) alır. Şehir merkezinin en büyük tarihi camisidir.

İçeride kubbe, kemerler ve ahşap mahfil boyunca uzanan kalem işleri, İzmir''deki Osmanlı süsleme sanatının en zengin örneklerindendir. Avludaki şadırvan ve çevresindeki çay ocakları, çarşının kalabalığında sakin bir mola verir. Kızlarağası Hanı ve Kemeraltı''nın ara sokaklarıyla birlikte gezilebilir; namaz vakitlerinde içeriyi gezmeyi ertelemek gerekir.'),
  ('hisar-camii', 'en', 'In the Hisarönü quarter of Kemeraltı, near the Kızlarağası Han, the Hisar Mosque was built in 1597-1598 by Molla Yakup Bey, a descendant of the Aydınid dynasty. It takes its name from the old fortress (hisar) that once guarded the harbour entrance and has since disappeared. It is the largest historic mosque in the city centre.

Inside, the painted decoration running across the dome, arches and wooden gallery is one of the richest examples of Ottoman ornament in İzmir. The fountain in the courtyard and the tea stalls around it offer a calm break from the bustle of the bazaar. Combine it with the Kızlarağası Han and the back streets of Kemeraltı; avoid visiting the interior during prayer times.'),
  ('konak-camii', 'tr', 'Konak Meydanı''nda, Saat Kulesi''nin hemen yanındaki Konak Camii, Yalı Camii adıyla da bilinir. 18. yüzyılın ortasında, dönemin valisi Katipzade Mehmed Paşa''nın eşi Ayşe Hanım adına yaptırıldı. Denize çok yakın olduğu dönemlerde kıyıda duran bu küçük cami, adını buradan alır.

Sekizgen gövdesi ve dışını kaplayan firuze-mavi Kütahya çinileriyle şehrin en tanınmış simgelerinden biridir. Saat Kulesi, Hükümet Konağı ve deniz kıyısıyla birlikte meydanın fotoğrafını tamamlar. Küçük olduğu için ziyaret kısa sürer; Kemeraltı''na buradan girerek çarşı gezisine başlayabilirsiniz.'),
  ('konak-camii', 'en', 'On Konak Square, right next to the Clock Tower, the Konak Mosque is also known as the Yalı (Waterfront) Mosque. It was built in the mid-18th century for Ayşe Hanım, wife of the governor Katipzade Mehmed Pasha. In the days when the sea came closer, this small mosque stood right on the shore, hence its second name.

Its octagonal body clad in turquoise Kütahya tiles makes it one of the city''s best-known landmarks. Together with the Clock Tower, the Government House and the seafront it completes the classic view of the square. A visit is short given its size; from here you can walk straight into Kemeraltı to start exploring the bazaar.'),
  ('basdurak-camii', 'tr', 'Kemeraltı''nın ana arteri Anafartalar Caddesi üzerindeki Başdurak Camii, 1652''de Hacı Hüseyin Ağa tarafından yaptırıldı. Evliya Çelebi, banisinin bir tahıl tüccarı olduğunu aktarır; cami uzun süre onun adıyla, Hacı Hüseyin Camii olarak anıldı.

Kare bir plan üzerinde tek büyük kubbeyle örtülü yapı, çarşının dükkânları arasında birden karşınıza çıkar. Kalabalık caddeden avluya adım atınca çarşının sesi azalır; kısa bir mola için uygun bir duraktır. Kemeraltı gezisinde Hisar, Şadırvanaltı ve Kestanepazarı camileriyle aynı rotada görülebilir.'),
  ('basdurak-camii', 'en', 'On Anafartalar Street, the main artery of Kemeraltı, the Başdurak Mosque was built in 1652 by Hacı Hüseyin Ağa. The traveller Evliya Çelebi records that its founder was a grain merchant, and for a long time it was known by his name as the Hacı Hüseyin Mosque.

Set on a square plan and covered by a single large dome, it appears suddenly among the bazaar''s shops. Step from the busy street into the courtyard and the noise of the market fades, making it a good place for a short pause. It fits on the same Kemeraltı route as the Hisar, Şadırvanaltı and Kestanepazarı mosques.'),
  ('aydinoglu-mehmet-bey-camii', 'tr', 'Birgi''deki Aydınoğlu Mehmet Bey Camii, Ulu Cami olarak da bilinir. Aydınoğulları Beyliği''nin kurucusu Mehmet Bey tarafından 1312''de yaptırıldı ve beyliğin inşa ettirdiği ilk camidir. Birgi o dönemde beyliğin başkentiydi; cami, hamam ve medreseyle birlikte bir külliye olarak düzenlenmişti.

İçerideki ceviz ağacından, geçme tekniğiyle yapılmış minber Anadolu ahşap işçiliğinin başyapıtlarından sayılır; mihraptaki çiniler ve minaredeki sırlı tuğla süslemeler de görülmeye değer. Avlunun yanında Mehmet Bey''in türbesi bulunur. Birgi''nin taş sokakları ve Çakırağa Konağı ile birlikte yarım günlük bir gezi yapılabilir.'),
  ('aydinoglu-mehmet-bey-camii', 'en', 'The Aydınoğlu Mehmet Bey Mosque in Birgi is also known as the Grand Mosque. It was commissioned in 1312 by Mehmet Bey, founder of the Aydınid principality, and is the first mosque the dynasty built. Birgi was then the capital of the beylik, and the mosque formed a complex together with a bath and a madrasa.

Inside, the walnut pulpit made with interlocking joinery is regarded as a masterpiece of Anatolian woodwork, and the tiles of the mihrab and the glazed brick decoration on the minaret are also worth seeing. Mehmet Bey''s tomb stands beside the courtyard. Combine it with Birgi''s stone streets and the Çakırağa Mansion for a half-day trip.'),
  ('salepcioglu-camii', 'tr', 'Kemeraltı''ndaki Salepçioğlu Camii, Salepçizade Hacı Ahmed Ağa''nın vasiyeti üzerine 1897-1905 yılları arasında yapıldı. Osmanlı''nın son döneminde İzmir''de inşa edilen önemli camilerdendir ve banisinin adını taşır.

Dış duvarlarında kesme taş ile mermer birlikte kullanılmış; ana kubbenin önünde giriş tarafında üç küçük kubbe yer alır. İçerideki kalem işleri ve renkli süslemeler, 19. yüzyılın sonundaki batılılaşma etkisini de yansıtır. Çarşının ortasında olduğundan Kemeraltı gezisi sırasında kısa bir durak olarak görülebilir.'),
  ('salepcioglu-camii', 'en', 'Salepçioğlu Mosque in Kemeraltı was built between 1897 and 1905 according to the will of Salepçizade Hacı Ahmed Ağa, whose name it bears. It is one of the notable mosques built in İzmir in the last decades of the Ottoman Empire.

Its outer walls combine cut stone and marble, and three small domes sit in front of the main dome on the entrance side. The painted and coloured decoration inside also reflects the Western influences of the late 19th century. Being in the middle of the bazaar, it makes a short stop on a Kemeraltı walk.'),
  ('kestanepazari-camii', 'tr', 'Kemeraltı''nın Kestanepazarı bölgesindeki cami, Kızıl İbrahim ya da Ahmed Ağa Camii adlarıyla da anılır. Evliya Çelebi''nin kaydettiği kitabeye göre 1667-1668''de Ahmed Ağa tarafından yaptırıldı; sonraki yüzyıllarda genişletilerek bugünkü görünümünü 19. yüzyılda aldı.

Taş ve mermerin birlikte kullanıldığı yapı, çarşının en işlek sokaklarından birinin ortasında yer alır. Çevresindeki dükkânlar ve kahveciler, Kemeraltı''nın günlük hayatını en canlı haliyle görebileceğiniz yerlerdendir. Hisar ve Şadırvanaltı camileriyle aynı yürüyüşte görülebilir.'),
  ('kestanepazari-camii', 'en', 'Also known as the Kızıl İbrahim or Ahmed Ağa Mosque, this mosque stands in the Kestanepazarı (Chestnut Market) quarter of Kemeraltı. According to an inscription recorded by Evliya Çelebi it was built by Ahmed Ağa in 1667-1668; it was enlarged in later centuries and took its present form in the 19th century.

Built of stone and marble, it sits in the middle of one of the bazaar''s busiest streets. The shops and coffee sellers around it are among the best places to see everyday life in Kemeraltı at its liveliest. It fits on the same walk as the Hisar and Şadırvanaltı mosques.'),
  ('bergama-kursunlu-cami', 'tr', 'Bergama''nın merkezindeki Kurşunlu Cami, doğu cephesindeki kitabeye göre 1439''da Safi oğlu Hacı Hasan tarafından yaptırıldı. Adını, kubbesini örten kurşun kaplamadan alır ve kentin erken Osmanlı dönemi yapılarındandır.

Kesme taştan, kare planlı bu sade camiyi yaklaşık dokuz metre çapındaki kubbe örter; taş kaide üzerine tuğladan yükselen tek şerefeli minaresi uzaktan tanınır. Bergama çarşısının içinde kaldığı için Kızıl Avlu ve Ulu Cami ile birlikte kısa bir şehir yürüyüşünde görülebilir.'),
  ('bergama-kursunlu-cami', 'en', 'According to the inscription on its east façade, the Kurşunlu Mosque in central Bergama was built in 1439 by Hacı Hasan, son of Safi. It takes its name from the lead covering its dome and is one of the town''s early Ottoman buildings.

This plain, square mosque of cut stone is covered by a dome about nine metres across, and its single-balcony brick minaret on a stone base is easy to recognise. As it stands within Bergama''s market area, it can be seen on a short town walk together with the Red Basilica and the Grand Mosque.'),
  ('bergama-ulu-cami', 'tr', 'Bergama Ulu Cami, Yıldırım Camii olarak da bilinir. Kitabesine göre Osmanlı Sultanı I. Bayezid (Yıldırım) tarafından 1398-1399''da yaptırıldı ve kentin en eski camilerinden biridir.

Sade dış görünüşüne karşın iç mekândaki ahşap minber ve mihrap çevresi dikkatle bakmaya değer. Bergama''nın eski çarşı sokakları arasında yer aldığından Kurşunlu Cami ve Kızıl Avlu ile birlikte yürüyerek gezilebilir; Pergamon ören yerine çıkmadan önce kısa bir durak olarak uygundur.'),
  ('bergama-ulu-cami', 'en', 'The Grand Mosque of Bergama is also known as the Yıldırım Mosque. According to its inscription it was built in 1398-1399 by the Ottoman Sultan Bayezid I (Yıldırım), making it one of the oldest mosques in the town.

Despite its plain exterior, the wooden pulpit and the area around the mihrab deserve a closer look. Set among the old market streets of Bergama, it can be visited on foot together with the Kurşunlu Mosque and the Red Basilica, and makes a good short stop before heading up to the ruins of Pergamon.'),
  ('tire-ulu-camii', 'tr', 'Tire Ulu Camii, ilçenin en eski ve en büyük camilerindendir. 14. yüzyılın ilk yarısında, Aydınoğulları döneminde inşa edildiği; ardından Aydınoğlu Cüneyd Bey tarafından yeniden yaptırıldığı bilinir. Kuzey kapısı üzerindeki 1870 tarihli kitabe sonraki bir onarımı kaydeder.

Tire, Aydınoğulları ve Osmanlı döneminden kalma pek çok cami, han ve medreseye sahiptir; Ulu Cami bu dokunun merkezindedir. Salı günleri kurulan ve bölgenin en canlı pazarlarından sayılan Tire pazarı ile aynı gün gezilirse ilçenin tarihi ve günlük hayatı birlikte görülür.'),
  ('tire-ulu-camii', 'en', 'The Grand Mosque of Tire is one of the oldest and largest mosques in the town. It is known to have been built in the first half of the 14th century under the Aydınids and later rebuilt by the Aydınid ruler Cüneyd Bey; an inscription of 1870 over the north door records a later repair.

Tire has many mosques, inns and madrasas from the Aydınid and Ottoman periods, and the Grand Mosque stands at the heart of this historic fabric. Visit on a Tuesday, when Tire''s market, one of the liveliest in the region, is held, to see the town''s history and daily life together.'),
  ('sadirvanalti-camii', 'tr', 'Kemeraltı''ndaki Şadırvanaltı Camii, 1636''da Bıyıklıoğlu Mahmut Ağa tarafından yaptırıldı. Adını, caminin altında yer alan şadırvandan alır. Birkaç yangın geçiren yapı 19. yüzyılda onarıldı; 1834''te bir kütüphane ve muvakkithane eklendi.

Caminin alt katında dükkânlar bulunur, ibadet mekânı bunların üzerine oturur; bu düzen, çarşı içindeki Osmanlı camilerinin ilginç bir örneğidir. Arkasındaki küçük meydan ve kahveler, Kemeraltı''nda soluklanmak için iyi bir yerdir. Hisar Camii ve Kızlarağası Hanı birkaç dakikalık yürüme mesafesindedir.'),
  ('sadirvanalti-camii', 'en', 'The Şadırvanaltı Mosque in Kemeraltı was built in 1636 by Bıyıklıoğlu Mahmut Ağa. Its name means ''under the fountain'', after the ablution fountain beneath the mosque. Damaged by several fires, it was repaired in the 19th century, and a library and timekeeper''s room were added in 1834.

Shops occupy the ground floor and the prayer hall sits above them, an interesting example of an Ottoman mosque woven into a bazaar. The small square and cafés behind it are a good place to catch your breath in Kemeraltı. The Hisar Mosque and the Kızlarağası Han are a few minutes'' walk away.'),
  ('meryem-ana-evi', 'tr', 'Selçuk''a yaklaşık 7 km uzaklıkta, Bülbül Dağı''nın ağaçlık yamacındaki Meryem Ana Evi, Hz. Meryem''in son yıllarını geçirdiğine inanılan yer olarak ziyaret edilir. Ev, 19. yüzyılda Alman rahibe Anne Catherine Emmerich''in anlattığı görümlerdeki tarif izlenerek bulundu. Katolik Kilisesi bu konuda resmi bir hüküm vermemiştir; ancak birçok papa burayı ziyaret etmiştir.

Taştan küçük yapı bugün bir şapel olarak düzenlenmiştir; içeride sessiz kalmak ve fotoğraf kurallarına uymak gerekir. Aşağıdaki çeşmeler ve ziyaretçilerin dileklerini bağladığı dilek duvarı da gezinin parçasıdır. Hristiyanlar kadar Müslümanlar için de saygın bir mekândır; 15 Ağustos''ta düzenlenen ayin kalabalık olur.'),
  ('meryem-ana-evi', 'en', 'About 7 km from Selçuk, on the wooded slopes of Mount Koressos (Bülbül Dağı), the House of the Virgin Mary is visited as the place where Mary is believed to have spent her last years. The house was located in the 19th century by following descriptions in the visions of the German nun Anne Catherine Emmerich. The Catholic Church has made no official ruling, but several popes have visited.

The small stone building is now arranged as a chapel; visitors are asked to keep quiet and follow the photo rules. The fountains below and the wishing wall, where visitors tie their wishes, are part of the visit. It is revered by Muslims as well as Christians, and the service held on 15 August draws large crowds.'),
  ('aziz-yuhanna-katedrali', 'tr', 'Alsancak''taki Aziz Yuhanna Katedrali, İzmir Katolik Başpiskoposluğu''nun merkezidir ve adını İncil yazarı Yuhanna''dan alır. Temeli 1862''de atıldı, 1874''te ibadete açıldı. Yapımı sırasında Sultan Abdülaziz''in büyük bir altın bağışı yaptığı, ana sunağın ise Papa IX. Pius''un hediyesi olduğu bilinir.

İçerideki tavan resimleri, vitraylar ve mermer sunak, kentin Levanten geçmişinin en güzel izlerindendir. Ayinler sırasında ziyaret yerine katılım beklenir; diğer zamanlarda sessizce gezilebilir. Alsancak''ın tarihi sokakları ve Kordon birkaç dakikalık yürüyüş uzaklığındadır.'),
  ('aziz-yuhanna-katedrali', 'en', 'St John''s Cathedral in Alsancak is the seat of the Catholic Archdiocese of İzmir and is dedicated to John the Evangelist. Its cornerstone was laid in 1862 and it opened in 1874. Sultan Abdülaziz is known to have made a large donation in gold during its construction, and the high altar was a gift from Pope Pius IX.

The ceiling paintings, stained glass and marble altar are among the finest traces of the city''s Levantine past. During services visitors are expected to take part rather than tour; at other times it can be visited quietly. The historic streets of Alsancak and the Kordon promenade are a few minutes'' walk away.'),
  ('aziz-polikarp-kilisesi', 'tr', 'Aziz Polikarp Kilisesi, İzmir''de bugün de kullanılan en eski kilisedir. Adını, Havari Yuhanna''nın öğrencisi olduğu kabul edilen ve şehrin ilk piskoposlarından Polikarp''tan alır. 1625''te Osmanlı padişahının izni ve Fransa Kralı XIII. Louis''nin isteğiyle yapıldı; 1688 depremi ve ardından çıkan yangında zarar görünce 1690-1691''de onarıldı.

Dışarıdan sade görünen yapının içi, duvarları ve tavanı kaplayan resimlerle şaşırtır; bunlar arasında Polikarp''ın yaşamından sahneler yer alır. Kilise Konak''a yakın, Necatibey Bulvarı çevresindedir. Ziyaret için ayin saatleri dışını seçmek ve sessiz kalmak gerekir.'),
  ('aziz-polikarp-kilisesi', 'en', 'St Polycarp''s Church is the oldest church in İzmir still in use. It is named after Polycarp, held to be a disciple of John the Apostle and one of the city''s first bishops. It was built in 1625 with the Ottoman sultan''s permission at the request of King Louis XIII of France; damaged by the 1688 earthquake and the fire that followed, it was repaired in 1690-1691.

Plain from the outside, the church surprises with paintings covering its walls and ceiling, including scenes from the life of Polycarp. It stands near Konak, around Necatibey Boulevard. Choose a time outside services and keep quiet during your visit.'),
  ('santa-maria-katolik-kilisesi', 'tr', 'Bornova''daki Santa Maria Katolik Kilisesi, kitabesine göre 1831''de Fransiskenler tarafından yapıldı. 19. yüzyılda Bornova''ya yerleşen Levanten aileler için inşa edilen kilise, ilçenin çok kültürlü geçmişinin simgelerindendir. 1970''lerde Cumhuriyet Meydanı düzenlenirken çevresindeki arazi küçüldü.

Neo-Bizans etkili cephesi ve çan kulesiyle meydanın bir köşesinde hemen fark edilir. Çevredeki Levanten köşkleri ve Ege Üniversitesi yerleşkesine uzanan sokaklarla birlikte bir Bornova yürüyüşüne eklenebilir. Ayin olmayan saatlerde sessizce ziyaret edilmelidir.'),
  ('santa-maria-katolik-kilisesi', 'en', 'According to its inscription, St Mary''s Catholic Church in Bornova was built by the Franciscans in 1831. Built for the Levantine families who settled in Bornova in the 19th century, it is a symbol of the district''s multicultural past. Its grounds shrank in the 1970s when Cumhuriyet Square was laid out.

With its Neo-Byzantine-style façade and bell tower it stands out on a corner of the square. Add it to a Bornova walk past the Levantine mansions and the streets leading towards the Ege University campus. Visit quietly outside service times.'),
  ('ayios-haralambos-kilisesi', 'tr', 'Çeşme''nin merkezindeki Ayios Haralambos Kilisesi, 19. yüzyılın ilk yarısında kasabanın Rum Ortodoks topluluğu için yapıldı. Nüfus mübadelesinden sonra ibadete kapanan yapı, onarımın ardından kültür ve sanat etkinliklerine ev sahipliği yapmaya başladı.

Bugün sergi salonu olarak kullanılır; yaz aylarında resim, fotoğraf ve el sanatları sergileri açılır. Taş cephesi ve çan kulesiyle Çeşme Kalesi''ne giden ana caddenin üzerinde kolayca bulunur. Kale, kervansaray ve liman yürüyüşüyle aynı gezide görülebilir.'),
  ('ayios-haralambos-kilisesi', 'en', 'In the centre of Çeşme, the Church of St Charalambos was built in the first half of the 19th century for the town''s Greek Orthodox community. Closed to worship after the population exchange, it was restored and began hosting cultural and art events.

Today it serves as an exhibition hall, with painting, photography and craft shows in the summer months. With its stone façade and bell tower it is easy to find on the main street leading to Çeşme Castle. It fits into the same walk as the castle, the caravanserai and the harbour.'),
  ('bet-israel-sinagogu', 'tr', 'Karataş''ta, Mithatpaşa Caddesi üzerindeki Bet İsrael Sinagogu 1907''de ibadete açıldı. Sultan II. Abdülhamid''in izniyle, semtte yaşayan Yahudi topluluğu için yapıldı. İzmir''in en büyük sinagogudur ve bugün de kullanılır; 1950''lerde yapılan onarımla bugünkü görünümünü aldı.

Karataş, İzmir Yahudilerinin 19. yüzyılın sonundan itibaren yoğun yaşadığı semtlerdendir; Tarihi Asansör ve Dario Moreno Sokağı aynı yürüyüşte görülebilir. Sinagog ziyareti güvenlik nedeniyle önceden topluluk aracılığıyla ayarlanmalıdır.'),
  ('bet-israel-sinagogu', 'en', 'On Mithatpaşa Street in Karataş, the Bet Israel Synagogue opened in 1907. It was built with the permission of Sultan Abdülhamid II for the Jewish community living in the quarter. It is the largest synagogue in İzmir and is still in use; it took its present appearance after a restoration in the 1950s.

Karataş was home to much of İzmir''s Jewish community from the late 19th century; the Historic Elevator and Dario Moreno Street can be seen on the same walk. For security reasons, visits to the synagogue should be arranged in advance through the community.'),
  ('sinyora-giveret-sinagogu', 'tr', 'Kemeraltı''ndaki Havra Sokağı''nın tarihi sinagoglarından Sinyora Giveret, 16. yüzyılda Portekizli Yahudi tüccar Dona Gracia Mendes adına kurulduğu kabul edilir; adı ''Hanımefendi'' anlamına gelir. 1841''deki büyük yangında ağır hasar gördü ve sonrasında yeniden onarıldı. Bugün de ibadete açıktır.

Havra Sokağı ve çevresi, birbirine çok yakın birkaç tarihi sinagoguyla İzmir''in Yahudi mirasının merkezidir; sokağın balık ve sebze tezgâhları da çarşının en canlı köşelerindendir. Sinagogların içini görmek için önceden izin ve rehberli ziyaret gerekir.'),
  ('sinyora-giveret-sinagogu', 'en', 'One of the historic synagogues of Havra Street in Kemeraltı, Signora Giveret is held to have been founded in the 16th century in the name of the Portuguese Jewish merchant Doña Gracia Mendes; its name means ''the Lady''. It was badly damaged in the great fire of 1841 and later restored. It is still used for worship.

With several historic synagogues close together, Havra Street and its surroundings form the heart of İzmir''s Jewish heritage, and the street''s fish and vegetable stalls are among the liveliest corners of the bazaar. Seeing the interiors requires prior permission and a guided visit.'),
  ('etz-hayim-sinagogu', 'tr', 'Havra Sokağı''ndaki Etz Hayim Sinagogu, İzmir''in en eski sinagogu olarak kabul edilir; kökeninin Bizans dönemine kadar uzandığı düşünülür. Adı İbranicede ''Hayat Ağacı'' anlamına gelir. 1841 yangınında zarar gördü, 1851''de onarıldı.

Bugün düzenli ibadete kapalıdır, ancak kapsamlı restorasyonu ödülle tanınmış ve İzmir Yahudi Mirası çalışmalarının parçası olmuştur. Avlusu ve ahşap iç düzeni, sokaktaki diğer sinagoglarla birlikte rehberli turlarda görülebilir; ziyaret önceden ayarlanmalıdır.'),
  ('etz-hayim-sinagogu', 'en', 'The Etz Hayim Synagogue on Havra Street is regarded as the oldest synagogue in İzmir; its origins are thought to go back to the Byzantine period. Its name means ''Tree of Life'' in Hebrew. It was damaged in the fire of 1841 and restored in 1851.

It is no longer used for regular worship, but its thorough restoration has won an award and it is part of the İzmir Jewish Heritage work. Its courtyard and wooden interior can be seen on guided tours together with the street''s other synagogues; visits must be arranged in advance.'),
  ('algazi-sinagogu', 'tr', 'Havra Sokağı''ndaki Algazi Sinagogu, 1724''te Algazi ailesi tarafından yaptırıldı. 1841 yangınında zarar gördü ve sonraki yüzyıllarda birkaç kez onarıldı; Bet İsrael''den sonra şehrin en büyük sinagogu sayılır.

Tek katlı taş yapının içinde kadınlar için ayrılmış bölüm ve ahşap ayrıntılar dikkat çeker. Kemeraltı''nın Yahudi mirası rotasında, Sinyora Giveret ve Etz Hayim sinagoglarıyla birlikte rehberli olarak gezilebilir; ziyaret için önceden izin almak gerekir.'),
  ('algazi-sinagogu', 'en', 'The Algazi Synagogue on Havra Street was built in 1724 by the Algazi family. Damaged in the fire of 1841, it was restored several times over the following centuries and is counted as the city''s largest synagogue after Bet Israel.

Inside the single-storey stone building, the women''s section and the wooden details stand out. On Kemeraltı''s Jewish heritage route it can be visited with a guide together with the Signora Giveret and Etz Hayim synagogues; permission must be obtained in advance.')
  ) v(slug, lang, long_desc)
  join public.places p on p.slug = v.slug
 where t.place_id = p.id and t.lang = v.lang;
