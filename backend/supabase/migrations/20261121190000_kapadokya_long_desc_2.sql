-- Kapadokya uzun açıklamaları, 2. parti (41 yer, TR + EN).
-- Üreten: data-pipeline/content/build_long_desc.py (kaynak: content/kapadokya_long_descriptions.py).
-- Metinler kendi cümlelerimizdir; Vikipedi/Wikidata yalnızca bilgi kontrolü için kullanıldı.

update public.place_translations t
   set long_desc = v.long_desc
  from (values
  ('haci-bektas-i-veli-turbesi', 'tr', 'Hacıbektaş ilçesindeki Hacı Bektaş Veli Külliyesi, 13. yüzyılda yaşamış Anadolu erenlerinden Hacı Bektaş Veli''nin türbesi ve dergâhıdır. Alevi ve Bektaşi inancının en önemli merkezidir ve 16 Ağustos 1964''ten beri müze olarak ziyarete açıktır.

Avlulardan geçerek Aslanlı Çeşme, Üçler Sofası, Kırklar Meydanı ve türbeye ulaşılır; dergâh yaşamını anlatan eşyalar, el yazmaları ve giysiler sergilenir. Her yıl ağustosun ortasında düzenlenen anma törenlerinde ilçe çok kalabalık olur. Kutsal bir mekân olduğu için saygılı davranın ve uygun giyinin.'),
  ('haci-bektas-i-veli-turbesi', 'en', 'The Haji Bektash Veli Complex in the town of Hacıbektaş is the tomb and lodge of Haji Bektash Veli, an Anatolian mystic of the 13th century. It is the most important centre of the Alevi and Bektashi faith and has been open as a museum since 16 August 1964.

Passing through its courtyards you reach the Lion Fountain, the Hall of the Three, the Square of the Forty and the tomb itself, with objects, manuscripts and garments describing life in the lodge on display. The town gets very crowded during the commemorations held every year in mid-August. As it is a sacred place, be respectful and dress appropriately.'),
  ('goreme-deki-kiliseler-listesi', 'tr', 'Göreme Açık Hava Müzesi, kayalara oyulmuş kiliseler, şapeller, yemekhaneler ve keşiş hücrelerinden oluşan bir manastır yerleşimidir. Kiliselerin çoğu 10-12. yüzyıllarda freskleriyle süslendi. 1985''te UNESCO Dünya Mirası Listesi''ne alınan ''Göreme Millî Parkı ve Kapadokya Kayalık Alanları''nın en ünlü bölümüdür.

Karanlık Kilise (ayrı bilet), Elmalı, Yılanlı, Çarıklı ve girişin karşısındaki Tokalı Kilise en önemli duraklardır. Gün ortasında tur otobüsleriyle çok kalabalık olur; açılışta ya da akşamüstü gidin. İçlerde fotoğraf kurallarına uyun ve fresklere dokunmayın. İçindeki yapılar ayrıca işaretlenebilir.'),
  ('goreme-deki-kiliseler-listesi', 'en', 'The Göreme Open-Air Museum is a monastic settlement of churches, chapels, refectories and monks'' cells carved into the rock. Most of its churches were decorated with frescoes in the 10th-12th centuries. It is the most famous part of ''Göreme National Park and the Rock Sites of Cappadocia'', added to the UNESCO World Heritage List in 1985.

The Dark Church (separate ticket), the Apple, Snake and Sandals churches and the Tokalı Church across from the entrance are the main stops. It gets very crowded with tour buses in the middle of the day; go at opening time or in the late afternoon. Follow the photo rules inside and do not touch the frescoes. The buildings inside can be checked off separately.'),
  ('nevsehir-muzesi', 'tr', 'Nevşehir Müzesi, 1987''de kurulan bir arkeoloji ve etnografya müzesidir. Kapadokya bölgesinde yapılan kazılardan ve araştırmalardan çıkan, tarih öncesinden Bizans ve Osmanlı dönemlerine uzanan eserleri sergiler.

Pişmiş toprak kaplar, heykelcikler, sikkeler ve takıların yanında etnografya bölümünde yöreye özgü giysiler, halılar ve ev eşyaları yer alır. Kapadokya''yı gezmeye başlamadan önce bölgenin tarihini toplu olarak görmek için iyi bir duraktır.'),
  ('nevsehir-muzesi', 'en', 'The Nevşehir Museum, founded in 1987, is an archaeology and ethnography museum. It displays finds from excavations and surveys in the Cappadocia region, ranging from prehistory to the Byzantine and Ottoman periods.

Alongside pottery, figurines, coins and jewellery, the ethnography section shows local costumes, carpets and household objects. It is a good stop for an overview of the region''s history before you start exploring Cappadocia.'),
  ('guray-muze', 'tr', 'Avanos''taki Güray Müze, kayaların oyulmasıyla yerin altında oluşturulmuş galerilerde seramik sergileyen bir müzedir. Avanos''un Kızılırmak''ın kızıl kilinden beslenen yüzyıllık çömlekçilik geleneğini yaşatmak amacıyla kuruldu.

Antik dönemlerden kalma seramik örneklerinin yanında, çağdaş sanatçıların eserleri de serin yeraltı galerilerinde sergilenir. Avanos''taki çömlek atölyelerinden birinde çamurla çalışmayı denemek, müze ziyaretini tamamlar. Kasaba merkezine ve Kızılırmak kıyısına yakındır.'),
  ('guray-muze', 'en', 'The Güray Museum in Avanos displays ceramics in galleries carved out of the rock underground. It was founded to keep alive Avanos''s centuries-old pottery tradition, fed by the red clay of the Kızılırmak River.

Ancient ceramics are shown alongside works by contemporary artists in the cool underground galleries. Trying your hand at clay in one of Avanos''s pottery workshops completes the visit. It is close to the town centre and the banks of the Kızılırmak.'),
  ('zelve-acik-hava-muzesi', 'tr', 'Avanos''a yaklaşık 5 km, Paşabağları''na 1 km uzaklıktaki Zelve, Aktepe''nin kuzey yamaçlarına yayılan üç vadiden oluşur. Kayalara oyulmuş evler, kiliseler, manastırlar, bir değirmen ve tünellerle dolu bu yerleşimde 1950''lere kadar insanlar yaşadı; erozyon tehlikesi nedeniyle köy yakındaki yeni yerleşime taşındı.

Bugün açık hava müzesi olarak gezilen vadilerde patikalarla dolaşıp kaya evlere, dik merdivenlere ve tünellere girebilirsiniz. Göreme''ye göre daha sakindir ve gezmek birkaç saat sürer. Bazı bölümler çökme riski nedeniyle kapalı olabilir; işaretlere uyun.'),
  ('zelve-acik-hava-muzesi', 'en', 'About 5 km from Avanos and 1 km from Paşabağları, Zelve consists of three valleys spreading over the northern slopes of Aktepe. People lived in this settlement full of rock-cut houses, churches, monasteries, a mill and tunnels until the 1950s, when the village was moved to a new site nearby because of the danger of erosion.

In the valleys, now visited as an open-air museum, you can follow paths and enter cave houses, steep stairways and tunnels. It is quieter than Göreme and takes a few hours to explore. Some sections may be closed because of the risk of collapse; follow the signs.'),
  ('nevsehir-kalesi', 'tr', 'Nevşehir''in en yüksek tepesindeki kale, Selçuklu döneminde, 12. yüzyılda kervan yolunu korumak için yapıldığı düşünülen bir yapıdır. Kale, altında yer alan ve son yıllarda ortaya çıkarılan büyük yeraltı şehrinin (Kayaşehir) üzerinde yükselir.

Surların bir bölümü ayaktadır; tepeden Nevşehir''in, Erciyes ve Hasan dağlarının geniş manzarası görülür. Kalenin çevresindeki tarihi mahallelerde Damat İbrahim Paşa Külliyesi gibi Osmanlı yapıları da gezilebilir.'),
  ('nevsehir-kalesi', 'en', 'The castle on the highest hill of Nevşehir is thought to have been built in the Seljuk period, in the 12th century, to protect the caravan route. It rises above a large underground city (Kayaşehir) uncovered beneath it in recent years.

Part of the walls still stands, and the hilltop offers a wide view of Nevşehir and of Mount Erciyes and Mount Hasan. In the historic neighbourhoods around the castle you can also visit Ottoman buildings such as the Damat İbrahim Pasha Complex.'),
  ('ortahisar-kalesi', 'tr', 'Ortahisar Kalesi, kasabanın ortasında yükselen, içi odalar, tüneller ve merdivenlerle oyulmuş dev bir kaya kütlesidir. Bizans döneminde bir savunma ve barınma yeri olarak kullanıldı; adını bölgedeki diğer kaya kalelerinin ortasında olmasından aldığı anlatılır.

İçerideki merdivenlerle tepeye çıkılabilir; yukarıdan Ortahisar''ın taş evleri, vadiler ve uzakta Erciyes Dağı görülür. Ortahisar, kayalara oyulmuş serin depolarında limon ve patates saklanmasıyla da bilinir. Merdivenler dik ve dar olduğundan dikkatli olun.'),
  ('ortahisar-kalesi', 'en', 'Ortahisar Castle is a huge rock mass rising in the middle of the town, hollowed out with rooms, tunnels and stairs. It was used in the Byzantine period as a place of defence and shelter; its name is said to come from its position in the middle of the region''s other rock castles.

Stairs inside lead to the top, from where you see Ortahisar''s stone houses, the valleys and Mount Erciyes in the distance. Ortahisar is also known for storing lemons and potatoes in cool stores carved into the rock. The stairs are steep and narrow, so take care.'),
  ('uchisar-kalesi', 'tr', 'Uçhisar Kalesi, Kapadokya''nın en yüksek noktalarından birinde yükselen, içi yüzlerce odayla oyulmuş dev bir kaya kütlesidir. Tarih boyunca hem savunma hem barınma yeri olarak kullanıldı; bugün bölgenin simgelerinden biridir.

Zirveye çıkan basamaklardan Göreme, Güvercinlik Vadisi ve açık havada Erciyes Dağı''na uzanan geniş bir manzara açılır; gün batımı en güzel zamanıdır. Kalenin eteğindeki taş evler ve otellerin arasında dolaşmak da keyiflidir. Tepede rüzgâr sert olabilir, akşamları bir hırka alın.'),
  ('uchisar-kalesi', 'en', 'Uçhisar Castle is a huge rock mass rising at one of the highest points in Cappadocia, honeycombed with hundreds of rooms. Used through history for both defence and shelter, it is today one of the symbols of the region.

The steps to the summit open up a wide view over Göreme, Pigeon Valley and, on clear days, Mount Erciyes; sunset is the best time. Wandering among the stone houses and hotels at its foot is pleasant too. The wind on top can be strong, so bring a jumper in the evening.'),
  ('cavusin-kalesi', 'tr', 'Çavuşin''deki kale, eski köyün yerleştiği ve yüzlerce kaya oyma evle delik deşik olmuş yüksek kayalıktır. Köy, 20. yüzyılın ortasındaki kaya düşmelerinden sonra büyük ölçüde terk edildi ve halk aşağıdaki yeni yerleşime taşındı.

Kayalığın eteğinden başlayan patikayla oyma evlerin arasından tırmanıp tepeye yakın Vaftizci Yahya Kilisesi''ne ulaşabilirsiniz. Yukarıdan Gül Vadisi ve Çavuşin''in manzarası görülür. Zemin kayalık ve dik olduğundan rahat ayakkabı giyin ve yıkılmaya yüz tutmuş bölümlere girmeyin.'),
  ('cavusin-kalesi', 'en', 'The ''castle'' at Çavuşin is the tall cliff where the old village stood, riddled with hundreds of rock-cut houses. After rockfalls in the mid-20th century the village was largely abandoned and its people moved to the new settlement below.

A path from the foot of the cliff climbs among the cave houses to the Church of St John the Baptist near the top, with views over the Rose Valley and Çavuşin. The ground is rocky and steep, so wear comfortable shoes and stay out of crumbling sections.'),
  ('sarihan-kervansarayi', 'tr', 'Avanos''un yaklaşık 5 km güneydoğusundaki Sarıhan, Aksaray ile Kayseri arasındaki kervan yolu üzerinde, 13. yüzyılda Selçuklular tarafından yapılan bir kervansaraydır. Adını, yapımında kullanılan sarımsı taştan alır.

Taş işçiliğiyle süslü anıtsal kapısı, avlusu ve kapalı kışlık bölümü restorasyonla korunmuştur. Akşamları kervansarayda Mevlevi sema gösterileri düzenlenir; izlemek isterseniz önceden bilgi alın. Avanos ile Ürgüp arasındaki yol üzerindedir.'),
  ('sarihan-kervansarayi', 'en', 'About 5 km south-east of Avanos, Sarıhan is a caravanserai built by the Seljuks in the 13th century on the caravan route between Aksaray and Kayseri. It takes its name from the yellowish stone used in its construction.

Its monumental gateway decorated with carved stonework, its courtyard and its covered winter hall have been preserved through restoration. In the evenings, Mevlevi whirling ceremonies (sema) are held in the caravanserai; ask in advance if you would like to watch. It lies on the road between Avanos and Ürgüp.'),
  ('bahattin-in-samanligi-kilise', 'tr', 'Ihlara Vadisi''nde, Belisırma köyü yakınlarındaki bu kaya kilisesi, adını onu uzun süre samanlık olarak kullanan köylü Bahattin''den alır. Bizans döneminde fresklerle süslenen kilise, sonraki yüzyıllarda gündelik işlerde kullanıldı.

İçerideki freskler İsa''nın hayatından sahneleri anlatır; bazı bölümleri zarar görmüş olsa da renkleri hâlâ seçilebilir. Ihlara yürüyüşünün orta kesiminde, Belisırma''daki dere kenarı restoranlarına yakındır; vadide mola vermeden önce kısa bir durak olarak görülebilir.'),
  ('bahattin-in-samanligi-kilise', 'en', 'Near the village of Belisırma in the Ihlara Valley, this rock church takes its name from Bahattin, a villager who used it for a long time as a hay barn. Decorated with frescoes in the Byzantine period, the church was put to everyday uses in later centuries.

The frescoes inside tell scenes from the life of Christ; though some parts are damaged, their colours can still be made out. It is in the middle section of the Ihlara walk, close to the streamside restaurants of Belisırma, and makes a short stop before taking a break in the valley.'),
  ('derinkuyu-yeralti-sehri', 'tr', 'Nevşehir''e yaklaşık 30 km uzaklıktaki Derinkuyu Yeraltı Şehri, Kapadokya''nın bilinen en derin yeraltı şehridir. Yumuşak volkanik kayaya kat kat oyulan şehir, tehlike anlarında binlerce insanın hayvanlarıyla birlikte sığınabileceği büyüklüktedir. 1963''te bir ev yenilenirken yeniden bulundu.

Gezilebilen katlarda ahırlar, mutfaklar, şarap işlikleri, bir kilise, havalandırma bacaları ve geçitleri kapatan dev yuvarlak taş kapılar görülür. Tüneller dar ve basıktır; kapalı alan korkusu olanlar dikkatli olmalıdır. Aşağısı serin olduğundan yazın bile ince bir hırka alın.'),
  ('derinkuyu-yeralti-sehri', 'en', 'About 30 km from Nevşehir, Derinkuyu Underground City is the deepest known underground city in Cappadocia. Carved level by level into the soft volcanic rock, it was large enough to shelter thousands of people with their animals in times of danger. It was rediscovered in 1963 during the renovation of a house.

On the levels open to visitors you see stables, kitchens, wine presses, a church, ventilation shafts and huge round stone doors that sealed the passages. The tunnels are narrow and low; people with claustrophobia should be careful. It is cool down below, so bring a light jumper even in summer.'),
  ('kaymakli', 'tr', 'Kaymaklı Yeraltı Şehri, Nevşehir-Niğde yolu üzerindeki Kaymaklı beldesinin altında yer alır ve 1960''lardan beri ziyarete açıktır. Derinkuyu kadar derin değildir ama daha geniş bir alana yayılır; birbirine dar tünellerle bağlanan çok sayıda oda ve geçitten oluşur.

Gezilebilen katlarda depolar, mutfaklar, şarap işlikleri, bir şapel ve geçitleri kapatan taş kapılar görülür. Bazı tünellerde eğilerek ilerlemek gerekir. Kasabadaki evlerin bir kısmının bodrumları hâlâ yeraltı şehrine açılır. Derinkuyu ile aynı gün gezilebilir.'),
  ('kaymakli', 'en', 'Kaymaklı Underground City lies beneath the town of Kaymaklı on the Nevşehir-Niğde road and has been open to visitors since the 1960s. It is not as deep as Derinkuyu but spreads over a wider area, made up of many rooms and passages linked by narrow tunnels.

On the levels open to visitors you see storerooms, kitchens, wine presses, a chapel and stone doors that sealed the passages. In some tunnels you have to bend down. The cellars of some houses in the town still open into the underground city. It can be visited on the same day as Derinkuyu.'),
  ('ozkonak', 'tr', 'Avanos''a yaklaşık 17 km uzaklıktaki Özkonak Yeraltı Şehri, 1970''lerde yerel halkın fark etmesiyle ortaya çıkarıldı. Bir tepenin içine oyulmuş, birbirine tünellerle bağlanan katlardan oluşur.

Geçitleri kapatan taş kapıların yanında, üst katlardan saldırganlara karşı kullanılmış olabilecek delikler ilgi çekicidir. Derinkuyu ve Kaymaklı''ya göre daha az kalabalıktır; yeraltı şehirlerini sakin bir ortamda görmek isteyenler için uygundur. Tüneller dar ve basıktır.'),
  ('ozkonak', 'en', 'About 17 km from Avanos, Özkonak Underground City was uncovered in the 1970s after local people noticed it. It consists of levels carved into a hill and linked by tunnels.

Besides the stone doors that sealed the passages, holes that may have been used against attackers from the upper levels are intriguing. It is less crowded than Derinkuyu and Kaymaklı, suiting those who want to see an underground city in a calm setting. The tunnels are narrow and low.'),
  ('mazi-yeralti-sehri', 'tr', 'Ürgüp''e yaklaşık 18 km, Kaymaklı''ya 10 km uzaklıktaki Mazı köyündeki yeraltı şehrinin girişleri, köyün kenarındaki kayalık yamaçlara açılır. Bölgenin diğer yeraltı şehirleri gibi tehlike anlarında sığınak olarak kullanıldı.

İçeride ahırlar, depolar, bir şarap işliği ve şapel ile geçitleri kapatan taş kapılar görülür. Daha az bilinen bir yer olduğu için sessizdir; ziyaret saatlerini önceden kontrol edin. Köydeki kaya mezarlar ve vadiyle birlikte gezilebilir.'),
  ('mazi-yeralti-sehri', 'en', 'About 18 km from Ürgüp and 10 km from Kaymaklı, the underground city at the village of Mazı has its entrances in the rocky slopes at the edge of the village. Like the region''s other underground cities, it was used as a refuge in times of danger.

Inside are stables, storerooms, a wine press and a chapel, along with stone doors that sealed the passages. Being less well known, it is quiet; check visiting hours in advance. It can be visited together with the village''s rock tombs and valley.'),
  ('sobesos-antik-kenti', 'tr', 'Ürgüp''e yaklaşık 23 km uzaklıktaki Şahinefendi köyünde yer alan Sobesos, çevredeki kalıntıların tesadüfen fark edilmesiyle bulundu; kazılar 2000''lerin başında başladı. Roma ve erken Bizans dönemlerine ait bir yerleşimdir.

Koruyucu bir çatı altında sergilenen, renkli mozaik döşemeli Roma hamamı ve sonradan eklenen şapel alanın en önemli bölümleridir. Kalabalıktan uzak, sakin bir arkeolojik alandır; Mustafapaşa ya da Soğanlı yönündeki bir geziye eklenebilir.'),
  ('sobesos-antik-kenti', 'en', 'Sobesos, at the village of Şahinefendi about 23 km from Ürgüp, was discovered when remains in the area were noticed by chance; excavations began in the early 2000s. It is a settlement of the Roman and early Byzantine periods.

The Roman bath with colourful mosaic floors, displayed under a protective roof, and the chapel added later are the most important parts of the site. It is a quiet archaeological site away from the crowds and can be added to a trip towards Mustafapaşa or Soğanlı.'),
  ('mutfak-ve-kiler', 'tr', 'Göreme Açık Hava Müzesi''ndeki mutfak ve kiler, manastır topluluğunun gündelik yaşamına ait bölümlerdir. Kayaya oyulmuş yemekhanede, keşişlerin birlikte yemek yediği uzun bir taş masa ve sıralar bulunur; yanındaki mutfakta ocak ve depolama oyukları görülür.

Kiliselerin fresklerinden sonra burası, manastırda yaşamın nasıl düzenlendiğini anlamak için iyi bir duraktır. Müze alanının ana yolu üzerindedir; kalabalık kiliselerin önündeki sırayı beklerken kısa bir göz atabilirsiniz.'),
  ('mutfak-ve-kiler', 'en', 'The kitchen and storerooms in the Göreme Open-Air Museum belonged to the daily life of the monastic community. In the rock-cut refectory there is a long stone table with benches where the monks ate together, and in the kitchen next to it you can see the hearth and storage niches.

After the frescoes of the churches, this is a good stop for understanding how life was organised in the monastery. It is on the main path of the museum, so you can take a quick look while waiting to enter the crowded churches.'),
  ('altikapi-turbesi', 'tr', 'Ürgüp''teki Altıkapı Türbesi, Selçuklu dönemine ait bir türbedir. Adını, yapının kenarlarına açılan kemerli açıklıklardan alır.

Kasabanın üzerindeki tepelerden birinde yer alır; buradan Ürgüp''ün peribacaları arasındaki eski evlerine ve çevredeki vadilere bakılabilir. Temenni Tepe ve kasaba merkeziyle birlikte kısa bir yürüyüşe eklenebilir.'),
  ('altikapi-turbesi', 'en', 'The Altıkapı (Six Doors) Tomb in Ürgüp is a tomb from the Seljuk period. It takes its name from the arched openings around the sides of the building.

It stands on one of the hills above the town, from where you can look over Ürgüp''s old houses among the fairy chimneys and the surrounding valleys. It can be added to a short walk with Temenni Hill and the town centre.'),
  ('mustafapasa', 'tr', 'Ürgüp''e bağlı Mustafapaşa, eski adıyla Sinasos, 19. yüzyılda zengin Rum tüccarların yaptırdığı, cepheleri taş oymalarla süslü konaklarıyla tanınır. 1923 nüfus mübadelesinden sonra Rum halk Yunanistan''a göç etti; kasaba 1980''lerde turizme açıldı.

Sokaklarda dolaşırken asma dalları ve meleklerle süslü kapılara, Konstantin-Helena Kilisesi''ne ve medreseye bakın; konakların bir kısmı bugün butik otel olarak kullanılır. Göreme''ye göre çok daha sakindir. Çevredeki vadilerde Aziz Nikolaos Manastırı ve Kutsal Haç Kilisesi gibi kaya kiliseleri vardır. İçindeki yerler ayrıca işaretlenebilir.'),
  ('mustafapasa', 'en', 'Mustafapaşa in Ürgüp district, formerly called Sinasos, is known for the mansions built by wealthy Greek merchants in the 19th century, their façades decorated with stone carving. After the 1923 population exchange the Greek inhabitants left for Greece; the town opened to tourism in the 1980s.

As you wander the streets, look at the doorways carved with vines and angels, the Church of Constantine and Helena and the madrasa; some of the mansions are now boutique hotels. It is much calmer than Göreme. In the valleys around are rock churches such as the Monastery of St Nicholas and the Church of the Holy Cross. The places inside can be checked off separately.'),
  ('cavusin', 'tr', 'Göreme ile Avanos arasındaki Çavuşin, adı 16. yüzyıl kayıtlarında da geçen eski bir köydür. Eski yerleşim, yüksek bir kayalığa oyulmuş evlerden oluşuyordu; 20. yüzyılın ortasındaki kaya düşmelerinden sonra halk aşağıdaki yeni köye taşındı.

Kayalığın tepesine yakın Vaftizci Yahya Kilisesi''ne tırmanmak, köyün girişindeki freskli Büyük Güvercinlik Kilisesi''ni görmek ve Gül Vadisi yürüyüşüne buradan başlamak Çavuşin''de yapılacakların başındadır. Köydeki küçük kafeler ve el sanatı tezgâhları mola için uygundur. İçindeki yerler ayrıca işaretlenebilir.'),
  ('cavusin', 'en', 'Between Göreme and Avanos, Çavuşin is an old village whose name already appears in 16th-century records. The old settlement consisted of houses carved into a tall cliff; after rockfalls in the mid-20th century its people moved to the new village below.

Climbing to the Church of St John the Baptist near the top of the cliff, seeing the frescoed Great Pigeon House Church at the village entrance and starting the Rose Valley walk from here are the highlights of Çavuşin. The village''s small cafés and craft stalls are good for a break. The places inside can be checked off separately.'),
  ('guzelyurt', 'tr', 'Aksaray''a bağlı Güzelyurt, eski adıyla Gelveri, Ihlara Vadisi''ne yaklaşık 15 km uzaklıkta, Hasan Dağı''nın eteğinde kurulu eski bir Kapadokya kasabasıdır. Mübadeleye kadar Rum ve Türk halkın birlikte yaşadığı kasaba, Kapadokyalı kilise babalarından Nazianzoslu Gregorios''la da ilişkilendirilir.

Taş evler, kayalara oyulmuş yapılar, sonradan camiye çevrilen Aziz Gregorios Kilisesi ve Manastır Vadisi''ndeki kaya kiliseleri gezilebilir. Göreme bölgesine göre çok daha sakindir. Ihlara Vadisi ve Selime ile aynı gün planlanabilir.'),
  ('guzelyurt', 'en', 'Güzelyurt in Aksaray province, formerly Gelveri, is an old Cappadocian town at the foot of Mount Hasan, about 15 km from the Ihlara Valley. Home to Greek and Turkish people together until the population exchange, the town is also associated with the Cappadocian Church Father Gregory of Nazianzus.

You can explore stone houses, rock-cut buildings, the Church of St Gregory later turned into a mosque, and the rock churches of the Monastery Valley. It is much quieter than the Göreme area. It can be planned on the same day as the Ihlara Valley and Selime.'),
  ('aktepe-hill-sunset-point', 'tr', 'Aktepe, Zelve''nin güneyinde yükselen ve kuzey yamaçlarında Zelve vadilerinin bulunduğu tepedir. Tepenin üzerindeki seyir noktası, aşağıdaki Kızılçukur Vadisi''ne ve çevredeki peribacalarına geniş bir açıyla bakar.

Gün batımında kızıla dönen kayalar ve sabahın erken saatlerinde vadilerin üzerinde yükselen balonlar en güzel manzaralardır. Göreme merkezindeki seyir noktasından daha sakindir. Zemin toprak ve kayalıktır; karanlıkta dönüş için yanınıza bir el feneri alın.'),
  ('aktepe-hill-sunset-point', 'en', 'Aktepe is the hill rising south of Zelve, with the Zelve valleys on its northern slopes. The viewpoint on top looks out widely over the Red Valley (Kızılçukur) below and the fairy chimneys around it.

The rocks turning red at sunset and the balloons rising over the valleys early in the morning are the finest views. It is quieter than the viewpoint in central Göreme. The ground is earth and rock; bring a torch for the walk back after dark.'),
  ('temenni-tepe', 'tr', 'Ürgüp''ün ortasında yükselen Temenni Tepe, adını ''dilek'' anlamına gelen temenni sözcüğünden alır. Tepede Selçuklu dönemine ait bir türbe bulunur ve burası uzun süredir dilek dilenen bir yer olarak bilinir.

Tepeden Ürgüp''ün kaya oyma evleri, eski Rum konakları ve çevredeki vadiler geniş bir açıyla görülür; gün batımında manzara özellikle güzeldir. Kasaba merkezinden kısa bir yokuşla çıkılır; çay bahçesinde oturup manzarayı izleyebilirsiniz.'),
  ('temenni-tepe', 'en', 'Rising in the middle of Ürgüp, Temenni Hill takes its name from the word temenni, meaning ''wish''. A tomb from the Seljuk period stands on the hill, which has long been known as a place for making wishes.

From the top you get a wide view of Ürgüp''s cave houses, old Greek mansions and the surrounding valleys, especially lovely at sunset. It is a short climb from the town centre, and you can sit in the tea garden and enjoy the view.'),
  ('uc-guzeller', 'tr', 'Ürgüp''ün hemen dışındaki Üç Güzeller, üzerlerinde bazalt ''şapka'' taşıyan üç peribacasından oluşur ve Kapadokya''nın en tanınmış simgelerindendir. Yöresel bir anlatıya göre bu kayalar bir aileyi temsil eder.

Peribacaları, sert kayanın altındaki yumuşak volkanik tüfün rüzgâr ve yağmurla aşınmasıyla oluştu; şapkalar altlarındaki sütunu korur. Seyir terasından özellikle gün batımında fotoğraf çekmek için kalabalık olur. Ürgüp-Mustafapaşa yolu üzerindedir.'),
  ('uc-guzeller', 'en', 'Just outside Ürgüp, the Three Beauties are three fairy chimneys topped with basalt ''caps'' and are among the best-known symbols of Cappadocia. According to a local tale, the rocks represent a family.

Fairy chimneys formed as wind and rain wore away the soft volcanic tuff beneath harder rock, and the caps protect the columns below them. The viewing terrace gets busy, especially at sunset, with people taking photographs. It lies on the Ürgüp-Mustafapaşa road.'),
  ('ihlara-cam-teras', 'tr', 'Ihlara Vadisi''nin ana girişine yakın cam seyir terası, kanyonun kenarından boşluğa doğru uzanan bir platformdur. Ayaklarınızın altındaki camdan, yaklaşık yüz metre aşağıda kıvrılarak akan Melendiz Çayı''nı ve vadi tabanını görebilirsiniz.

Teras, vadiye inmeden önce kanyonun büyüklüğünü görmek için iyi bir noktadır; buradan vadiye inen merdivenler de yakındır. Rüzgârlı havalarda dikkatli olun ve görevlilerin uyarılarına uyun.'),
  ('ihlara-cam-teras', 'en', 'Near the main entrance to the Ihlara Valley, the glass viewing terrace is a platform extending out over the edge of the canyon. Through the glass beneath your feet you can see the Melendiz stream winding along the valley floor about a hundred metres below.

The terrace is a good spot to take in the size of the canyon before descending; the stairs down into the valley are close by. Take care in windy weather and follow the staff''s instructions.'),
  ('goreme-tarihi-milli-parki', 'tr', 'Göreme Tarihî Millî Parkı, yaklaşık 100 km²''lik alanıyla Kapadokya''nın peribacaları, vadileri ve kaya yerleşimlerinin büyük bölümünü koruma altına alır. Erciyes, Hasan ve Göllüdağ volkanlarının milyonlarca yıl önce bıraktığı tüf katmanlarının aşınmasıyla oluşan bu eşsiz arazi, 1985''te UNESCO Dünya Mirası Listesi''ne alındı.

Park sınırları içinde Göreme, Uçhisar, Çavuşin ve Ortahisar ile Güvercinlik, Gül, Kızılçukur ve Aşk vadileri yer alır. Sabahın erken saatlerinde yükselen sıcak hava balonları, parkın en ünlü manzarasıdır. Vadilerde işaretli patikalardan ayrılmayın ve peribacalarına tırmanmayın.'),
  ('goreme-tarihi-milli-parki', 'en', 'Göreme Historical National Park, covering about 100 km², protects much of Cappadocia''s fairy chimneys, valleys and rock settlements. This unique landscape, formed by the erosion of tuff layers left millions of years ago by the volcanoes Erciyes, Hasan and Göllüdağ, was added to the UNESCO World Heritage List in 1985.

Within the park are Göreme, Uçhisar, Çavuşin and Ortahisar, and the Pigeon, Rose, Red and Love valleys. The hot air balloons rising early in the morning are the park''s most famous sight. Stay on the marked paths in the valleys and do not climb on the fairy chimneys.'),
  ('bagildere-vadisi', 'tr', 'Bağıldere Vadisi, halk arasında Aşk Vadisi olarak bilinir ve Göreme ile Uçhisar arasında yer alır. Vadiyi ünlü yapan, onlarca metre yüksekliğe ulaşan ince ve uzun peribacalarıdır.

Vadi tabanındaki patika üzüm bağları ve meyve bahçeleri arasından geçer; yukarıdaki seyir noktasından tüm vadi görülür. Sabahları balonlar sık sık vadinin üzerinden geçer. Yürüyüş birkaç saat sürebilir; su ve şapka alın, patikalar yer yer kumlu ve kaygandır.'),
  ('bagildere-vadisi', 'en', 'Bağıldere Valley, popularly known as Love Valley, lies between Göreme and Uçhisar. What makes it famous are its slender, tall fairy chimneys, some reaching tens of metres in height.

The path along the valley floor passes vineyards and orchards, and the viewpoint above takes in the whole valley. In the mornings balloons often drift over it. The walk can take a few hours; bring water and a hat, and note that paths are sandy and slippery in places.'),
  ('devrent-vadisi', 'tr', 'Avanos ile Ürgüp arasındaki Devrent Vadisi, Hayal Vadisi olarak da bilinir. Diğer vadilerden farklı olarak burada kilise ya da kaya evi yoktur; vadiyi ünlü yapan, hayvan ve insan biçimlerine benzeyen peribacalarıdır.

En ünlüsü deve biçimli kayadır; ziyaretçiler diğer kayalarda da yunus, fok ya da Meryem Ana figürü arar. Pembe tonlu kayalar gün batımında güzelleşir. Yol kenarında olduğundan kısa bir mola için idealdir; Paşabağları ve Zelve yakındır.'),
  ('devrent-vadisi', 'en', 'Devrent Valley, between Avanos and Ürgüp, is also known as Imagination Valley. Unlike the other valleys it has no churches or cave houses; it is famous for fairy chimneys resembling animals and people.

The best known is the camel-shaped rock, and visitors look for dolphins, seals or a figure of the Virgin Mary in the other rocks. The pinkish rocks are lovely at sunset. Being right by the road, it is ideal for a short stop; Paşabağları and Zelve are close by.'),
  ('gul-vadisi', 'tr', 'Göreme ile Çavuşin arasındaki Gül Vadisi, gün batımında pembeye dönen kayaları nedeniyle bu adı alır. Bölgenin en sevilen yürüyüş vadilerinden biridir ve yol boyunca kayalara oyulmuş kiliseler, güvercinlikler ve bağlar bulunur.

Patika Kızılçukur Vadisi ile birleşerek dairesel bir yürüyüşe dönüşebilir. Yol üzerindeki kaya kiliselerinin bazılarında fresk kalıntıları görülür. Akşamüstü yürüyüp gün batımını vadinin üzerindeki seyir noktalarından izlemek en güzelidir; dönüş için el feneri alın.'),
  ('gul-vadisi', 'en', 'The Rose Valley between Göreme and Çavuşin takes its name from its rocks, which turn pink at sunset. It is one of the region''s favourite walking valleys, with rock-cut churches, dovecotes and vineyards along the way.

The path can join the Red Valley to make a circular walk. Some of the rock churches along the route still have remains of frescoes. Walking in the late afternoon and watching the sunset from the viewpoints above the valley is best; bring a torch for the way back.'),
  ('guvercinlik-vadisi', 'tr', 'Göreme ile Uçhisar arasındaki Güvercinlik Vadisi, kayalara oyulmuş sayısız güvercinlikle tanınır. Bu güvercinlikler yüzyıllar boyunca, bağlar için gübre olarak kullanılan güvercin dışkısını toplamak amacıyla oyuldu.

Göreme ile Uçhisar''ı birbirine bağlayan patika, vadi tabanında yaklaşık birkaç kilometre boyunca ilerler; Uçhisar tarafındaki seyir noktasında nazar boncuklarıyla süslü ağaç ünlüdür. Yokuş yukarı yürümek istemiyorsanız Uçhisar''dan başlayıp Göreme''ye inin.'),
  ('guvercinlik-vadisi', 'en', 'Pigeon Valley, between Göreme and Uçhisar, is known for the countless dovecotes carved into its rocks. For centuries these were carved to collect pigeon droppings, used as fertiliser for the vineyards.

The path linking Göreme and Uçhisar runs for a few kilometres along the valley floor, and the tree decorated with evil-eye beads at the viewpoint on the Uçhisar side is well known. If you prefer not to walk uphill, start in Uçhisar and walk down to Göreme.'),
  ('passabag-vadisi', 'tr', 'Zelve yakınlarındaki Paşabağları, Keşişler Vadisi olarak da bilinir. Bir gövdeden birden çok başlığın yükseldiği, Kapadokya''nın en etkileyici peribacaları burada toplanır.

Peribacalarının bazılarına keşiş hücreleri ve şapeller oyulmuştur; bunlardan biri, inzivaya çekilen Aziz Simeon''a adanmıştır. Kısa ve düz patikalarla kolay gezilen bir alandır. Gün içinde tur otobüsleriyle kalabalıklaşır; sabah erken ya da akşamüstü daha sakindir.'),
  ('passabag-vadisi', 'en', 'Paşabağları, near Zelve, is also known as Monks Valley. Cappadocia''s most impressive fairy chimneys, with several caps rising from a single trunk, are gathered here.

Monks'' cells and chapels are carved into some of the chimneys, one of them dedicated to the hermit St Simeon. It is an easy site to explore along short, flat paths. It gets busy with tour buses during the day; early morning and late afternoon are quieter.'),
  ('meskendir-valley-entrance', 'tr', 'Göreme ile Ortahisar arasındaki Meskendir Vadisi, peribacaları, güvercinlikler ve kayalara oyulmuş tüneller arasından geçen bir yürüyüş vadisidir. Kızılçukur ve Gül vadileriyle bağlantılı patikalar sunar.

Vadinin bazı bölümlerinde kayaya oyulmuş dar geçitlerden geçmek gerekir; yol işaretleri sınırlı olduğundan bir harita uygulaması kullanın. Kalabalıktan uzak bir yürüyüş için uygundur; su ve şapka almayı unutmayın.'),
  ('meskendir-valley-entrance', 'en', 'Meskendir Valley, between Göreme and Ortahisar, is a walking valley that passes among fairy chimneys, dovecotes and tunnels carved into the rock. Its paths connect with the Red and Rose valleys.

In some parts of the valley you have to pass through narrow rock-cut passages; signs are limited, so use a map app. It suits a walk away from the crowds; remember to bring water and a hat.'),
  ('ihlara-vadisi', 'tr', 'Aksaray''daki Ihlara Vadisi, Melendiz Çayı''nın volkanik araziyi yararak oluşturduğu, Ihlara''dan Selime''ye uzanan yaklaşık 14 km''lik bir kanyondur. Bizans döneminde keşişlerin yerleştiği vadinin yamaçlarında, fresklerle süslü onlarca kaya kilisesi bulunur.

Ana girişteki merdivenlerle vadi tabanına inilir; dere boyunca uzanan gölgeli patikada yürüyüş yaparken Ağaçaltı, Kokar, Yılanlı ve Sümbüllü kiliselerini görebilirsiniz. Ortadaki Belisırma köyünde dere kenarında yemek molası verilir. Tüm vadiyi yürümek yarım günden fazla sürer; dönüş ulaşımını önceden planlayın. İçindeki yerler ayrıca işaretlenebilir.'),
  ('ihlara-vadisi', 'en', 'The Ihlara Valley in Aksaray is a canyon about 14 km long, from Ihlara to Selime, cut by the Melendiz stream into the volcanic terrain. Settled by monks in the Byzantine period, its slopes hold dozens of rock churches decorated with frescoes.

Stairs at the main entrance lead down to the valley floor; walking the shady path along the stream you can see the Ağaçaltı, Kokar, Snake and Jacinth churches. Lunch by the stream is the usual break at Belisırma village in the middle. Walking the whole valley takes more than half a day, so plan your transport back in advance. The places inside can be checked off separately.'),
  ('kizilcukur-vadisi', 'tr', 'Ortahisar yakınlarındaki Kızılçukur Vadisi, demir bakımından zengin kayalarının kızıl tonlarıyla tanınır. Kapadokya''da gün batımının en güzel izlendiği yerlerden biri olarak bilinir.

Vadinin üzerindeki seyir alanı akşamları kalabalıklaşır; kayaların güneşle birlikte renk değiştirmesini izlemek için gün batımından önce gelin. Vadiden geçen yürüyüş yolları Gül Vadisi ile birleşir ve yol boyunca Haçlı Kilise gibi kaya kiliseleri bulunur. Dönüşte karanlıkta kalmamak için el feneri alın.'),
  ('kizilcukur-vadisi', 'en', 'The Red Valley (Kızılçukur), near Ortahisar, is known for the red tones of its iron-rich rocks. It is famed as one of the best places in Cappadocia to watch the sunset.

The viewing area above the valley gets busy in the evenings; arrive before sunset to watch the rocks change colour with the light. Walking trails through the valley join the Rose Valley, with rock churches such as the Church of the Cross along the way. Bring a torch so you are not caught in the dark on the way back.'),
  ('soganli-vadisi', 'tr', 'Kayseri''nin Yeşilhisar ilçesine bağlı Soğanlı Vadisi, Kapadokya''nın güneyinde, kalabalıktan uzak kalmış bir vadidir. Yukarı ve Aşağı Soğanlı olarak ikiye ayrılan vadinin yamaçlarında, Bizans döneminde oyulmuş çok sayıda kaya kilisesi ve manastır bulunur.

Kubbeli, Saklı, Karabaş, Yılanlı ve Tahtalı kiliseleri vadi boyunca patikalarla gezilir. Köyde kadınların elde yaptığı geleneksel Soğanlı bebekleri satılır. Göreme''ye yaklaşık bir saatlik sürüş uzaklığındadır; Mustafapaşa ve Sobesos ile aynı güne eklenebilir. İçindeki yerler ayrıca işaretlenebilir.'),
  ('soganli-vadisi', 'en', 'Soğanlı Valley, in the Yeşilhisar district of Kayseri, is a valley in southern Cappadocia that has stayed away from the crowds. Divided into Upper and Lower Soğanlı, its slopes hold many rock churches and monasteries carved in the Byzantine period.

The Domed, Hidden, Karabaş, Snake and Tahtalı churches are visited along paths through the valley. In the village, women sell the traditional handmade Soğanlı dolls. It is about an hour''s drive from Göreme and can be added to the same day as Mustafapaşa and Sobesos. The places inside can be checked off separately.'),
  ('soganli-karabas-kilisesi', 'tr', 'Soğanlı Vadisi''ndeki Karabaş Kilisesi, vadinin en zengin süslenmiş kaya kiliselerinden biridir. Fresklerinin önemli bir bölümü 11. yüzyıla tarihlenir ve İsa''nın hayatından sahneleri anlatır.

Kilise, yan yana oyulmuş birkaç mekândan oluşur; duvarlardaki resimlerde bağışçı tasvirleri ve yazıtlar da görülür. Vadinin yamacında, kısa bir tırmanışla ulaşılır. Freskleri korumak için dokunmayın ve flaş kullanmayın.'),
  ('soganli-karabas-kilisesi', 'en', 'The Karabaş Church in Soğanlı Valley is one of the most richly decorated rock churches in the valley. Much of its fresco work dates from the 11th century and tells scenes from the life of Christ.

The church consists of several spaces carved side by side, and the paintings on its walls also include donor portraits and inscriptions. It is reached by a short climb up the valley slope. Do not touch the frescoes or use flash, to protect them.'),
  ('soganli-kubbeli-kilise', 'tr', 'Soğanlı Vadisi''ndeki Kubbeli Kilise, bir peribacasının tepesine kubbe biçiminde oyulmuş olmasıyla Kapadokya''da benzeri olmayan bir yapıdır. Uzaktan bakınca kayanın üzerinde bir kilise kubbesi yükseliyormuş gibi görünür.

Kiliseye kayalığa oyulmuş basamaklarla çıkılır; alt katta başka mekânlar da bulunur. Vadinin en çok fotoğraflanan yapılarındandır; yanındaki Saklı Kilise ile birlikte görülür. Basamaklar dik ve kayalıktır, dikkatli tırmanın.'),
  ('soganli-kubbeli-kilise', 'en', 'The Domed Church in Soğanlı Valley is unique in Cappadocia, carved in the shape of a dome on top of a fairy chimney. From a distance it looks as though a church dome rises from the rock.

Steps cut into the cliff lead up to the church, and there are further spaces on the lower level. It is one of the most photographed buildings in the valley and is seen together with the Hidden Church next to it. The steps are steep and rocky, so climb carefully.'),
  ('soganli-sakli-kilise', 'tr', 'Soğanlı Vadisi''ndeki Saklı Kilise, adını yamacın içine gizlenmiş olmasından alır; uzaktan bakıldığında neredeyse fark edilmez. Bu konum, onu yüzyıllar boyunca korumuştur.

Kiliseye Kubbeli Kilise''nin yakınından ulaşılır; içeride fresk kalıntıları görülebilir. Vadinin bu kesimindeki kiliseler birbirine yakın olduğundan birkaçını aynı yürüyüşte görebilirsiniz. Zemin kayalıktır, uygun ayakkabı giyin.'),
  ('soganli-sakli-kilise', 'en', 'The Hidden Church in Soğanlı Valley takes its name from being tucked into the slope; from a distance it is barely noticeable. This position has protected it over the centuries.

It is reached from near the Domed Church, and remains of frescoes can be seen inside. The churches in this part of the valley are close together, so you can see several on the same walk. The ground is rocky, so wear suitable shoes.'),
  ('soganli-yilanli-kilise', 'tr', 'Soğanlı Vadisi''ndeki Yılanlı Kilise, Aziz Georgios''un ejderhayla (yılanla) savaştığı freskiyle bilinir. Bu sahne, Kapadokya kiliselerinde sevilen ve sık tekrarlanan konulardandır.

Kilise vadinin yamacında yer alır; içerideki freskler zamanla yıpranmış olsa da ana sahneler seçilebilir. Göreme''deki aynı adlı Yılanlı Kilise ile karıştırmayın. Vadideki diğer kiliselerle birlikte kısa bir tırmanışla gezilir.'),
  ('soganli-yilanli-kilise', 'en', 'The Snake Church in Soğanlı Valley is known for its fresco of St George fighting the dragon (snake), a popular and often repeated theme in the churches of Cappadocia.

The church sits on the valley slope; although the frescoes inside have worn over time, the main scenes can still be made out. Do not confuse it with the Snake Church of the same name in Göreme. It is visited with a short climb together with the other churches in the valley.'),
  ('soganli-tahtali-kilise', 'tr', 'Soğanlı Vadisi''ndeki Tahtalı Kilise, Azize Barbara''ya adanmıştır. İçerideki freskler, Bizans döneminde bu uzak vadide de güçlü bir manastır ve resim geleneği olduğunu gösterir.

Tonozları ve duvarları kaplayan resimlerde İsa, Meryem ve azizlerin tasvirleri görülür; renkler hâlâ oldukça canlıdır. Kilise, vadinin aşağı kesiminde yer alır. Freskleri korumak için dokunmayın ve flaş kullanmayın.'),
  ('soganli-tahtali-kilise', 'en', 'The Tahtalı Church in Soğanlı Valley is dedicated to St Barbara. Its frescoes show that a strong monastic and painting tradition flourished even in this remote valley in the Byzantine period.

The paintings covering its vaults and walls show Christ, Mary and the saints, and their colours are still fairly vivid. The church is in the lower part of the valley. Do not touch the frescoes or use flash, to protect them.'),
  ('soganli-geyikli-kilise', 'tr', 'Soğanlı Vadisi''ndeki Geyikli Kilise, adını duvarlarındaki geyikli bir aziz tasvirinden alır. Vadideki diğer kiliseler gibi Bizans döneminde kayaya oyulmuş ve fresklerle süslenmiştir.

Kilise, vadinin daha sakin bir köşesinde kalır; fresklerin bir bölümü yıpranmış olsa da ana figürler seçilebilir. Vadideki yürüyüşe eklemek için yerel rehberlere ya da köydekilere yolu sorabilirsiniz.'),
  ('soganli-geyikli-kilise', 'en', 'The Church of the Deer in Soğanlı Valley takes its name from a depiction of a saint with a deer on its walls. Like the other churches in the valley, it was carved into the rock and decorated with frescoes in the Byzantine period.

The church lies in a quieter corner of the valley; although some of the frescoes have worn, the main figures can still be made out. To add it to your walk through the valley, ask local guides or villagers for the way.')
  ) v(slug, lang, long_desc)
  join public.places p on p.slug = v.slug
 where t.place_id = p.id and t.lang = v.lang;
