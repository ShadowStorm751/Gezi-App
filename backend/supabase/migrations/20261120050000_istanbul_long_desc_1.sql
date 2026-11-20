-- İstanbul uzun açıklamaları, 1. parti (10 yer, TR + EN).
-- Üreten: data-pipeline/content/build_long_desc.py (kaynak: content/istanbul_long_descriptions.py).
-- Metinler kendi cümlelerimizdir; Vikipedi/Wikidata yalnızca bilgi kontrolü için kullanıldı.

update public.place_translations t
   set long_desc = v.long_desc
  from (values
  ('ayasofya', 'tr', 'Bizans İmparatoru I. Justinianus''un 532-537 yılları arasında Trallesli Anthemius ve Miletli İsidoros''a yaptırdığı Ayasofya, yaklaşık bin yıl boyunca dünyanın en büyük kilisesi ve Ortodoks dünyasının merkeziydi. 1453''te İstanbul''un fethiyle camiye çevrildi, minareleri ve Osmanlı ekleri bu dönemde geldi. 1935''te müze oldu, 2020''de yeniden camiye dönüştürüldü.

İçeride, yerden yaklaşık 55 metre yükseklikte adeta havada duruyormuş gibi görünen dev kubbe, Bizans mozaikleri ile büyük hat levhaları aynı mekânda buluşur. Ziyaretçi girişi ibadet alanından ayrı düzenlenmiştir; namaz vakitlerinde ve cuma öğlen ziyaret kısıtlanabilir. Kıyafet olarak omuz ve dizleri örten giysiler, kadınlar için başörtüsü gerekir.'),
  ('ayasofya', 'en', 'Built for Emperor Justinian I between 532 and 537 by Anthemius of Tralles and Isidore of Miletus, Hagia Sophia was the largest church in the world and the heart of Orthodox Christianity for nearly a thousand years. After the Ottoman conquest of 1453 it became a mosque and gained its minarets. It was a museum from 1935 and was converted back into a mosque in 2020.

Inside, the vast dome seems to float some 55 metres above the floor, and Byzantine mosaics share the space with huge Ottoman calligraphy roundels. Visitors use a separate entrance from worshippers, and access may be limited during prayer times and at Friday noon. Shoulders and knees should be covered, and women need a headscarf.'),
  ('suleymaniye-camii', 'tr', 'Kanuni Sultan Süleyman''ın emriyle Mimar Sinan''ın inşa ettiği Süleymaniye Camii, 1550''de başlayıp 1557''de ibadete açıldı. İstanbul''un üçüncü tepesine oturan cami; medreseler, darüşşifa, imaret ve hamamdan oluşan büyük bir külliyenin merkezidir ve Sinan''ın en önemli eserlerinden sayılır.

Sade ve aydınlık iç mekânın ardından bahçeye çıkın: Kanuni Sultan Süleyman ile Hürrem Sultan''ın türbeleri buradadır, Mimar Sinan''ın kendi mütevazı türbesi ise külliyenin hemen dışındadır. Avludaki teras, Haliç ve Galata''ya bakan İstanbul''un en güzel manzaralarından birini sunar; çevredeki sokaklarda tarihi kuru fasulyecileri de bulabilirsiniz.'),
  ('suleymaniye-camii', 'en', 'Commissioned by Suleiman the Magnificent and built by the great architect Mimar Sinan, the Süleymaniye Mosque was begun in 1550 and opened for worship in 1557. Crowning Istanbul''s third hill, it stands at the centre of a large complex of schools, a hospital, a soup kitchen and a bath, and is counted among Sinan''s finest works.

After the calm, light-filled prayer hall, step into the garden: the tombs of Suleiman and his wife Hürrem Sultan are here, while Sinan''s own modest tomb lies just outside the complex. The terrace offers one of the city''s best views over the Golden Horn and Galata, and the surrounding lanes are known for traditional bean-stew eateries.'),
  ('sultanahmet-camii', 'tr', 'Sultan I. Ahmed''in 1609-1617 yılları arasında Mimar Sedefkâr Mehmed Ağa''ya yaptırdığı Sultanahmet Camii, altı minaresiyle tarihi yarımadanın en tanınan siluetlerinden biridir. İç mekânı süsleyen yirmi binden fazla İznik çinisi ve mavi tonlu kalem işleri yüzünden dünyada Mavi Cami (Blue Mosque) olarak bilinir.

Ayasofya''nın tam karşısında, eski Hipodrom''un kenarında durur; ikisini aynı yürüyüşte görmek kolaydır. Cami ibadete açık olduğundan namaz vakitlerinde ziyaretçi girişi bir süre kapanır. Omuz ve dizleri örten kıyafet gerekir, kadınlar başlarını örtmelidir; girişte ayakkabılar çıkarılır.'),
  ('sultanahmet-camii', 'en', 'Built between 1609 and 1617 for Sultan Ahmed I by the architect Sedefkâr Mehmed Agha, the Sultan Ahmed Mosque and its six minarets form one of the most recognisable skylines of the historic peninsula. More than twenty thousand İznik tiles and blue painted decoration inside earned it its worldwide name, the Blue Mosque.

It faces Hagia Sophia across a park on the edge of the old Hippodrome, so the two are easy to see on the same walk. As a working mosque it closes to visitors for a while at each prayer time. Shoulders and knees should be covered, women should cover their hair, and shoes come off at the door.'),
  ('topkapi-sarayi', 'tr', 'Fatih Sultan Mehmed''in İstanbul''un fethinden sonra Sarayburnu''na yaptırdığı Topkapı Sarayı, 1478''de tamamlandı ve yaklaşık 380 yıl boyunca Osmanlı padişahlarının evi ve devletin yönetim merkezi oldu. Saray halkı 19. yüzyılda Dolmabahçe''ye taşınınca boşaldı ve 1924''te müze olarak açıldı.

Birbirine açılan dört avlu boyunca Divan-ı Hümayun, saray mutfakları, Hazine (Kaşıkçı Elması dahil) ve Kutsal Emanetler dairesi gezilir; padişahın ailesiyle yaşadığı Harem ayrı bir bölümdür. Tamamını görmek yarım günü bulabilir, kalabalıktan kaçmak için sabah erken gidin. Dördüncü avludaki teraslardan Boğaz ve Haliç''in birleştiği nokta görülür.'),
  ('topkapi-sarayi', 'en', 'Built by Sultan Mehmed II on the Seraglio Point after the conquest of Constantinople, Topkapı Palace was completed in 1478 and for about 380 years served as the home of the Ottoman sultans and the seat of government. The court moved to Dolmabahçe in the 19th century, and the palace opened as a museum in 1924.

A sequence of four courtyards leads past the Imperial Council hall, the palace kitchens, the Treasury (home of the Spoonmaker''s Diamond) and the chamber of Holy Relics; the Harem, where the sultan lived with his family, is a separate section. Seeing it all can take half a day, so arrive early to beat the crowds. Terraces in the fourth courtyard look out over the meeting point of the Bosphorus and the Golden Horn.'),
  ('dolmabahce-sarayi', 'tr', 'Sultan Abdülmecid''in Boğaz kıyısında, eskiden doldurulmuş bir koyun üzerine Balyan ailesinden mimarlara yaptırdığı Dolmabahçe Sarayı 1843-1856 yılları arasında inşa edildi. Avrupa barok ve neoklasik üsluplarını Osmanlı geleneğiyle birleştiren saray, son dönem padişahlarının resmi ikametgâhıydı.

Selamlık ve Harem bölümleri rehberli turlarla gezilir; tören salonunun dev kristal avizesi ve kubbesi en etkileyici kısımlardır. Mustafa Kemal Atatürk 10 Kasım 1938''de bu sarayda hayatını kaybetti; kaldığı oda ve 09.05''te durdurulmuş saatler hâlâ saygıyla korunur. Bahçeden ve Saat Kulesi''nin önünden Boğaz manzarası harikadır.'),
  ('dolmabahce-sarayi', 'en', 'Sultan Abdülmecid had Dolmabahçe Palace built between 1843 and 1856 on a filled-in bay of the Bosphorus, designed by architects of the Balyan family. Blending European baroque and neoclassical styles with Ottoman tradition, it was the official residence of the late Ottoman sultans.

The state rooms and the Harem are seen on guided tours; the ceremonial hall with its huge crystal chandelier and dome is the highlight. Mustafa Kemal Atatürk died here on 10 November 1938, and his room, with the clocks stopped at 9:05, is preserved with great respect. The gardens and the area by the Clock Tower offer lovely Bosphorus views.'),
  ('galata-kulesi', 'tr', 'Galata''daki Ceneviz kolonisinin surlarına gözetleme kulesi olarak 1348-1349 yıllarında inşa edilen Galata Kulesi, yüzyıllar boyunca yangın gözetleme kulesi, depo ve zindan olarak kullanıldı. Hezarfen Ahmed Çelebi''nin 17. yüzyılda buradan uçarak Üsküdar''a geçtiği efsanesiyle de bilinir. 2020''den beri müze olarak hizmet verir.

Asansörle çıkılan ve kuleyi çepeçevre saran seyir balkonundan Tarihi Yarımada, Haliç, Boğaz ve Kız Kulesi tek bakışta görülür; içerideki katlarda kulenin ve Galata''nın tarihini anlatan sergiler vardır. Özellikle gün batımı saatlerinde uzun kuyruk olabilir; sabah erken saatler daha sakindir. Çevresindeki dar sokaklar Karaköy''e iner.'),
  ('galata-kulesi', 'en', 'Built in 1348-1349 as a watchtower in the walls of the Genoese colony of Galata, the Galata Tower later served as a fire lookout, a store and even a prison. It is also tied to the legend of Hezarfen Ahmed Çelebi, said to have flown from here across the Bosphorus to Üsküdar in the 17th century. It has been a museum since 2020.

A lift takes you up to the balcony that rings the top, with the historic peninsula, the Golden Horn, the Bosphorus and the Maiden''s Tower in one sweep; exhibitions inside tell the story of the tower and Galata. Queues can be long around sunset, while early morning is quieter. The narrow streets around it lead down to Karaköy.'),
  ('kariye-camii', 'tr', 'Edirnekapı''da, kara surlarının hemen yakınındaki Kariye, Bizans döneminde Hora Manastırı''nın kilisesiydi. Bugünkü görünümünü ve dünyaca ünlü mozaik ile freskolarını 14. yüzyılın başında devlet adamı Theodoros Metokhites''in yaptırdığı onarımda kazandı. 1511''de camiye çevrildi, uzun yıllar müze olarak kullanıldıktan sonra yeniden cami oldu.

Altın zeminli mozaikler Hz. İsa ve Hz. Meryem''in hayatından sahneleri anlatır ve geç Bizans sanatının en iyi örnekleri arasında sayılır. Ziyaret düzeni ve hangi bölümlerin açık olduğu zaman zaman değiştiği için gitmeden önce kontrol etmekte yarar var. Yakındaki Mihrimah Sultan Camii ve Tekfur Sarayı ile aynı gezide birleştirilebilir.'),
  ('kariye-camii', 'en', 'Near the land walls at Edirnekapı, Kariye was the church of the Byzantine Chora Monastery. It took its present form, along with its world-famous mosaics and frescoes, during a renovation funded by the statesman Theodore Metochites in the early 14th century. It became a mosque in 1511, served for many years as a museum, and has since become a mosque again.

Its gold-ground mosaics tell the lives of Christ and the Virgin Mary and rank among the finest works of late Byzantine art. Visiting arrangements and which sections are open change from time to time, so it is worth checking before you go. It pairs well with the nearby Mihrimah Sultan Mosque and Tekfur Palace.'),
  ('buyukada', 'tr', 'Prens Adaları''nın en büyüğü olan Büyükada, Bizans döneminde sürgün yeri olarak kullanılmış, 19. yüzyıldan itibaren ise İstanbul''un sevilen yazlık beldesi olmuştur. Ada, ahşap köşkleri, çam ormanları ve motorlu araç trafiğinin olmayışıyla şehirden çok farklı bir hava taşır. Lev Troçki 1929-1933 yıllarında burada yaşamıştır.

İskeleden başlayan köşk sokaklarında yürüyüş, bisiklet ya da elektrikli araçlarla ada turu yapılabilir. Yücetepe''deki Aya Yorgi Kilisesi''ne çıkan yokuşun sonunda tüm adalara bakan bir manzara sizi bekler. Kabataş, Eminönü ve Bostancı''dan kalkan vapurlarla gidilir; hafta sonları ve yazın çok kalabalık olduğundan hafta içi daha keyiflidir.'),
  ('buyukada', 'en', 'The largest of the Princes'' Islands, Büyükada was a place of exile in Byzantine times and from the 19th century became a favourite summer retreat for Istanbul. Wooden mansions, pine woods and the absence of car traffic give it an atmosphere far removed from the city. Leon Trotsky lived here from 1929 to 1933.

From the pier you can walk the mansion-lined streets or tour the island by bicycle or electric vehicle. The climb to the Church of St George on Yücetepe hill ends with a view over all the islands. Ferries run from Kabataş, Eminönü and Bostancı; weekends and summer get very busy, so a weekday visit is more relaxed.'),
  ('misir-carsisi', 'tr', 'Eminönü''nde Yeni Cami''nin arkasındaki Mısır Çarşısı, cami külliyesinin bir parçası olarak 17. yüzyılda Turhan Sultan''ın himayesinde inşa edildi. Önceleri Yeni Çarşı ya da Valide Çarşısı diye anılan yapı, adını yapımında Mısır''dan gelen gelirlerin kullanıldığı rivayetinden alır.

L biçimli kubbeli koridorları boyunca baharat, kuruyemiş, lokum, çay ve kurutulmuş meyve satan dükkânlar sıralanır. Ana giriş üzerindeki tarihi restoran ve çarşının yan sokaklarındaki peynir ve şarküteri dükkânları da görülmeye değer. Hafta sonları çok kalabalık olur; çiçek ve fidan pazarı hemen yanındadır.'),
  ('misir-carsisi', 'en', 'Behind the New Mosque in Eminönü, the Spice Bazaar was built in the 17th century as part of the mosque complex under the patronage of Turhan Sultan. Once called the New Bazaar or the Valide Bazaar, its Turkish name, the Egyptian Bazaar, comes from the story that revenues from Egypt paid for its construction.

Its L-shaped, vaulted corridors are lined with shops selling spices, nuts, Turkish delight, tea and dried fruit. The historic restaurant above the main entrance and the cheese and deli shops in the side streets are also worth a look. It gets very crowded at weekends; the flower and plant market is right next door.'),
  ('burgaz-adasi', 'tr', 'Prens Adaları''nın büyüklük bakımından üçüncüsü olan Burgazada, yuvarlak biçimli ve çam ormanlarıyla kaplı küçük bir adadır. Adını antik çağda burada yapıldığı söylenen bir kaleden (pyrgos) alır. Yazar Sait Faik Abasıyanık hayatının önemli bir bölümünü bu adada geçirmiş, öykülerinin pek çoğunda adayı anlatmıştır.

Sait Faik''in evi bugün müze olarak ziyaret edilebilir. Adanın batı kıyısındaki Kalpazankaya, gün batımını izlemek ve denize bakarak oturmak için sevilen bir köşedir. Büyükada''ya göre çok daha sakin olduğu için ada havasını kalabalıksız yaşamak isteyenler için iyi bir seçimdir.'),
  ('burgaz-adasi', 'en', 'The third largest of the Princes'' Islands, Burgazada is a small, round island covered in pine forest. Its name comes from a fortress (pyrgos) said to have stood here in antiquity. The writer Sait Faik Abasıyanık spent much of his life on the island, and it features in many of his short stories.

Sait Faik''s house can be visited as a museum today. Kalpazankaya on the island''s western shore is a favourite spot for watching the sunset over the sea. Far quieter than Büyükada, it is a good choice for enjoying island life without the crowds.')
  ) v(slug, lang, long_desc)
  join public.places p on p.slug = v.slug
 where t.place_id = p.id and t.lang = v.lang;
