"""İstanbul yerlerinin uzun açıklamaları (TR + EN).

Kurallar:
  * Kendi cümlelerimiz; Vikipedi metni kopyalanmaz (results/wiki-extracts.json.gz yalnızca bilgi kontrolü için).
  * 2 paragraf: (1) ne olduğu ve kısa tarihçe, (2) ne görülmeli + pratik ipucu.
  * Sık değişen bilgi yok: bilet fiyatı, saat, telefon. Tartışmalı ya da doğrulanamayan sayı yazılmaz.
  * Paragraflar "\n\n" ile ayrılır; mobil olduğu gibi gösterir.

LONG[slug] = (parti, tr, en). Parti numarası migration'ı belirler (content/build_long_desc.py).
"""

LONG = {
    "ayasofya": (1,
        "Bizans İmparatoru I. Justinianus'un 532-537 yılları arasında Trallesli Anthemius ve Miletli İsidoros'a "
        "yaptırdığı Ayasofya, yaklaşık bin yıl boyunca dünyanın en büyük kilisesi ve Ortodoks dünyasının merkeziydi. "
        "1453'te İstanbul'un fethiyle camiye çevrildi, minareleri ve Osmanlı ekleri bu dönemde geldi. 1935'te müze oldu, "
        "2020'de yeniden camiye dönüştürüldü.\n\n"
        "İçeride, yerden yaklaşık 55 metre yükseklikte adeta havada duruyormuş gibi görünen dev kubbe, Bizans mozaikleri "
        "ile büyük hat levhaları aynı mekânda buluşur. Ziyaretçi girişi ibadet alanından ayrı düzenlenmiştir; namaz "
        "vakitlerinde ve cuma öğlen ziyaret kısıtlanabilir. Kıyafet olarak omuz ve dizleri örten giysiler, kadınlar için "
        "başörtüsü gerekir.",
        "Built for Emperor Justinian I between 532 and 537 by Anthemius of Tralles and Isidore of Miletus, Hagia Sophia "
        "was the largest church in the world and the heart of Orthodox Christianity for nearly a thousand years. After "
        "the Ottoman conquest of 1453 it became a mosque and gained its minarets. It was a museum from 1935 and was "
        "converted back into a mosque in 2020.\n\n"
        "Inside, the vast dome seems to float some 55 metres above the floor, and Byzantine mosaics share the space with "
        "huge Ottoman calligraphy roundels. Visitors use a separate entrance from worshippers, and access may be limited "
        "during prayer times and at Friday noon. Shoulders and knees should be covered, and women need a headscarf."),

    "suleymaniye-camii": (1,
        "Kanuni Sultan Süleyman'ın emriyle Mimar Sinan'ın inşa ettiği Süleymaniye Camii, 1550'de başlayıp 1557'de "
        "ibadete açıldı. İstanbul'un üçüncü tepesine oturan cami; medreseler, darüşşifa, imaret ve hamamdan oluşan "
        "büyük bir külliyenin merkezidir ve Sinan'ın en önemli eserlerinden sayılır.\n\n"
        "Sade ve aydınlık iç mekânın ardından bahçeye çıkın: Kanuni Sultan Süleyman ile Hürrem Sultan'ın türbeleri "
        "buradadır, Mimar Sinan'ın kendi mütevazı türbesi ise külliyenin hemen dışındadır. Avludaki teras, Haliç ve "
        "Galata'ya bakan İstanbul'un en güzel manzaralarından birini sunar; çevredeki sokaklarda tarihi kuru fasulyecileri de bulabilirsiniz.",
        "Commissioned by Suleiman the Magnificent and built by the great architect Mimar Sinan, the Süleymaniye Mosque "
        "was begun in 1550 and opened for worship in 1557. Crowning Istanbul's third hill, it stands at the centre of a "
        "large complex of schools, a hospital, a soup kitchen and a bath, and is counted among Sinan's finest works.\n\n"
        "After the calm, light-filled prayer hall, step into the garden: the tombs of Suleiman and his wife Hürrem "
        "Sultan are here, while Sinan's own modest tomb lies just outside the complex. The terrace offers one of the "
        "city's best views over the Golden Horn and Galata, and the surrounding lanes are known for traditional "
        "bean-stew eateries."),

    "sultanahmet-camii": (1,
        "Sultan I. Ahmed'in 1609-1617 yılları arasında Mimar Sedefkâr Mehmed Ağa'ya yaptırdığı Sultanahmet Camii, altı "
        "minaresiyle tarihi yarımadanın en tanınan siluetlerinden biridir. İç mekânı süsleyen yirmi binden fazla İznik "
        "çinisi ve mavi tonlu kalem işleri yüzünden dünyada Mavi Cami (Blue Mosque) olarak bilinir.\n\n"
        "Ayasofya'nın tam karşısında, eski Hipodrom'un kenarında durur; ikisini aynı yürüyüşte görmek kolaydır. Cami "
        "ibadete açık olduğundan namaz vakitlerinde ziyaretçi girişi bir süre kapanır. Omuz ve dizleri örten kıyafet "
        "gerekir, kadınlar başlarını örtmelidir; girişte ayakkabılar çıkarılır.",
        "Built between 1609 and 1617 for Sultan Ahmed I by the architect Sedefkâr Mehmed Agha, the Sultan Ahmed Mosque "
        "and its six minarets form one of the most recognisable skylines of the historic peninsula. More than twenty "
        "thousand İznik tiles and blue painted decoration inside earned it its worldwide name, the Blue Mosque.\n\n"
        "It faces Hagia Sophia across a park on the edge of the old Hippodrome, so the two are easy to see on the same "
        "walk. As a working mosque it closes to visitors for a while at each prayer time. Shoulders and knees should be "
        "covered, women should cover their hair, and shoes come off at the door."),

    "topkapi-sarayi": (1,
        "Fatih Sultan Mehmed'in İstanbul'un fethinden sonra Sarayburnu'na yaptırdığı Topkapı Sarayı, 1478'de tamamlandı "
        "ve yaklaşık 380 yıl boyunca Osmanlı padişahlarının evi ve devletin yönetim merkezi oldu. Saray halkı 19. "
        "yüzyılda Dolmabahçe'ye taşınınca boşaldı ve 1924'te müze olarak açıldı.\n\n"
        "Birbirine açılan dört avlu boyunca Divan-ı Hümayun, saray mutfakları, Hazine (Kaşıkçı Elması dahil) ve Kutsal "
        "Emanetler dairesi gezilir; padişahın ailesiyle yaşadığı Harem ayrı bir bölümdür. Tamamını görmek yarım günü "
        "bulabilir, kalabalıktan kaçmak için sabah erken gidin. Dördüncü avludaki teraslardan Boğaz ve Haliç'in "
        "birleştiği nokta görülür.",
        "Built by Sultan Mehmed II on the Seraglio Point after the conquest of Constantinople, Topkapı Palace was "
        "completed in 1478 and for about 380 years served as the home of the Ottoman sultans and the seat of "
        "government. The court moved to Dolmabahçe in the 19th century, and the palace opened as a museum in 1924.\n\n"
        "A sequence of four courtyards leads past the Imperial Council hall, the palace kitchens, the Treasury (home of "
        "the Spoonmaker's Diamond) and the chamber of Holy Relics; the Harem, where the sultan lived with his family, is "
        "a separate section. Seeing it all can take half a day, so arrive early to beat the crowds. Terraces in the "
        "fourth courtyard look out over the meeting point of the Bosphorus and the Golden Horn."),

    "dolmabahce-sarayi": (1,
        "Sultan Abdülmecid'in Boğaz kıyısında, eskiden doldurulmuş bir koyun üzerine Balyan ailesinden mimarlara "
        "yaptırdığı Dolmabahçe Sarayı 1843-1856 yılları arasında inşa edildi. Avrupa barok ve neoklasik üsluplarını "
        "Osmanlı geleneğiyle birleştiren saray, son dönem padişahlarının resmi ikametgâhıydı.\n\n"
        "Selamlık ve Harem bölümleri rehberli turlarla gezilir; tören salonunun dev kristal avizesi ve kubbesi en "
        "etkileyici kısımlardır. Mustafa Kemal Atatürk 10 Kasım 1938'de bu sarayda hayatını kaybetti; kaldığı oda ve "
        "09.05'te durdurulmuş saatler hâlâ saygıyla korunur. Bahçeden ve Saat Kulesi'nin önünden Boğaz manzarası "
        "harikadır.",
        "Sultan Abdülmecid had Dolmabahçe Palace built between 1843 and 1856 on a filled-in bay of the Bosphorus, "
        "designed by architects of the Balyan family. Blending European baroque and neoclassical styles with Ottoman "
        "tradition, it was the official residence of the late Ottoman sultans.\n\n"
        "The state rooms and the Harem are seen on guided tours; the ceremonial hall with its huge crystal chandelier "
        "and dome is the highlight. Mustafa Kemal Atatürk died here on 10 November 1938, and his room, with the clocks "
        "stopped at 9:05, is preserved with great respect. The gardens and the area by the Clock Tower offer lovely "
        "Bosphorus views."),

    "galata-kulesi": (1,
        "Galata'daki Ceneviz kolonisinin surlarına gözetleme kulesi olarak 1348-1349 yıllarında inşa edilen Galata "
        "Kulesi, yüzyıllar boyunca yangın gözetleme kulesi, depo ve zindan olarak kullanıldı. Hezarfen Ahmed Çelebi'nin "
        "17. yüzyılda buradan uçarak Üsküdar'a geçtiği efsanesiyle de bilinir. 2020'den beri müze olarak hizmet verir.\n\n"
        "Asansörle çıkılan ve kuleyi çepeçevre saran seyir balkonundan Tarihi Yarımada, Haliç, Boğaz ve Kız Kulesi tek "
        "bakışta görülür; içerideki katlarda kulenin ve Galata'nın tarihini anlatan sergiler vardır. Özellikle gün batımı "
        "saatlerinde uzun kuyruk olabilir; sabah erken saatler daha sakindir. Çevresindeki dar sokaklar Karaköy'e iner.",
        "Built in 1348-1349 as a watchtower in the walls of the Genoese colony of Galata, the Galata Tower later served "
        "as a fire lookout, a store and even a prison. It is also tied to the legend of Hezarfen Ahmed Çelebi, said to "
        "have flown from here across the Bosphorus to Üsküdar in the 17th century. It has been a museum since 2020.\n\n"
        "A lift takes you up to the balcony that rings the top, with the historic peninsula, the Golden Horn, the "
        "Bosphorus and the Maiden's Tower in one sweep; exhibitions inside tell the story of the tower and Galata. "
        "Queues can be long around sunset, while early morning is quieter. The narrow streets around it lead down to "
        "Karaköy."),

    "kariye-camii": (1,
        "Edirnekapı'da, kara surlarının hemen yakınındaki Kariye, Bizans döneminde Hora Manastırı'nın kilisesiydi. "
        "Bugünkü görünümünü ve dünyaca ünlü mozaik ile freskolarını 14. yüzyılın başında devlet adamı Theodoros "
        "Metokhites'in yaptırdığı onarımda kazandı. 1511'de camiye çevrildi, uzun yıllar müze olarak kullanıldıktan sonra "
        "yeniden cami oldu.\n\n"
        "Altın zeminli mozaikler Hz. İsa ve Hz. Meryem'in hayatından sahneleri anlatır ve geç Bizans sanatının en iyi "
        "örnekleri arasında sayılır. Ziyaret düzeni ve hangi bölümlerin açık olduğu zaman zaman değiştiği için gitmeden "
        "önce kontrol etmekte yarar var. Yakındaki Mihrimah Sultan Camii ve Tekfur Sarayı ile aynı gezide birleştirilebilir.",
        "Near the land walls at Edirnekapı, Kariye was the church of the Byzantine Chora Monastery. It took its present "
        "form, along with its world-famous mosaics and frescoes, during a renovation funded by the statesman Theodore "
        "Metochites in the early 14th century. It became a mosque in 1511, served for many years as a museum, and has "
        "since become a mosque again.\n\n"
        "Its gold-ground mosaics tell the lives of Christ and the Virgin Mary and rank among the finest works of late "
        "Byzantine art. Visiting arrangements and which sections are open change from time to time, so it is worth "
        "checking before you go. It pairs well with the nearby Mihrimah Sultan Mosque and Tekfur Palace."),

    "buyukada": (1,
        "Prens Adaları'nın en büyüğü olan Büyükada, Bizans döneminde sürgün yeri olarak kullanılmış, 19. yüzyıldan "
        "itibaren ise İstanbul'un sevilen yazlık beldesi olmuştur. Ada, ahşap köşkleri, çam ormanları ve motorlu araç "
        "trafiğinin olmayışıyla şehirden çok farklı bir hava taşır. Lev Troçki 1929-1933 yıllarında burada yaşamıştır.\n\n"
        "İskeleden başlayan köşk sokaklarında yürüyüş, bisiklet ya da elektrikli araçlarla ada turu yapılabilir. "
        "Yücetepe'deki Aya Yorgi Kilisesi'ne çıkan yokuşun sonunda tüm adalara bakan bir manzara sizi bekler. Kabataş, "
        "Eminönü ve Bostancı'dan kalkan vapurlarla gidilir; hafta sonları ve yazın çok kalabalık olduğundan hafta içi daha keyiflidir.",
        "The largest of the Princes' Islands, Büyükada was a place of exile in Byzantine times and from the 19th "
        "century became a favourite summer retreat for Istanbul. Wooden mansions, pine woods and the absence of car "
        "traffic give it an atmosphere far removed from the city. Leon Trotsky lived here from 1929 to 1933.\n\n"
        "From the pier you can walk the mansion-lined streets or tour the island by bicycle or electric vehicle. The "
        "climb to the Church of St George on Yücetepe hill ends with a view over all the islands. Ferries run from "
        "Kabataş, Eminönü and Bostancı; weekends and summer get very busy, so a weekday visit is more relaxed."),

    "misir-carsisi": (1,
        "Eminönü'nde Yeni Cami'nin arkasındaki Mısır Çarşısı, cami külliyesinin bir parçası olarak 17. yüzyılda Turhan "
        "Sultan'ın himayesinde inşa edildi. Önceleri Yeni Çarşı ya da Valide Çarşısı diye anılan yapı, adını yapımında "
        "Mısır'dan gelen gelirlerin kullanıldığı rivayetinden alır.\n\n"
        "L biçimli kubbeli koridorları boyunca baharat, kuruyemiş, lokum, çay ve kurutulmuş meyve satan dükkânlar "
        "sıralanır. Ana giriş üzerindeki tarihi restoran ve çarşının yan sokaklarındaki peynir ve şarküteri dükkânları "
        "da görülmeye değer. Hafta sonları çok kalabalık olur; çiçek ve fidan pazarı hemen yanındadır.",
        "Behind the New Mosque in Eminönü, the Spice Bazaar was built in the 17th century as part of the mosque complex "
        "under the patronage of Turhan Sultan. Once called the New Bazaar or the Valide Bazaar, its Turkish name, the "
        "Egyptian Bazaar, comes from the story that revenues from Egypt paid for its construction.\n\n"
        "Its L-shaped, vaulted corridors are lined with shops selling spices, nuts, Turkish delight, tea and dried "
        "fruit. The historic restaurant above the main entrance and the cheese and deli shops in the side streets are "
        "also worth a look. It gets very crowded at weekends; the flower and plant market is right next door."),

    "burgaz-adasi": (1,
        "Prens Adaları'nın büyüklük bakımından üçüncüsü olan Burgazada, yuvarlak biçimli ve çam ormanlarıyla kaplı "
        "küçük bir adadır. Adını antik çağda burada yapıldığı söylenen bir kaleden (pyrgos) alır. Yazar Sait Faik "
        "Abasıyanık hayatının önemli bir bölümünü bu adada geçirmiş, öykülerinin pek çoğunda adayı anlatmıştır.\n\n"
        "Sait Faik'in evi bugün müze olarak ziyaret edilebilir. Adanın batı kıyısındaki Kalpazankaya, gün batımını "
        "izlemek ve denize bakarak oturmak için sevilen bir köşedir. Büyükada'ya göre çok daha sakin olduğu için ada "
        "havasını kalabalıksız yaşamak isteyenler için iyi bir seçimdir.",
        "The third largest of the Princes' Islands, Burgazada is a small, round island covered in pine forest. Its name "
        "comes from a fortress (pyrgos) said to have stood here in antiquity. The writer Sait Faik Abasıyanık spent much "
        "of his life on the island, and it features in many of his short stories.\n\n"
        "Sait Faik's house can be visited as a museum today. Kalpazankaya on the island's western shore is a favourite "
        "spot for watching the sunset over the sea. Far quieter than Büyükada, it is a good choice for enjoying island "
        "life without the crowds."),

    "sultanahmet-meydani-hipodrom": (2,
        "Bugünkü Sultanahmet Meydanı, Roma ve Bizans döneminde araba yarışlarının yapıldığı Hipodrom'un yerindedir. "
        "Septimius Severus döneminde başlanıp I. Konstantin zamanında büyütülen Hipodrom, imparatorların halkla buluştuğu "
        "şehrin kalbiydi; 532'deki Nika Ayaklanması da burada patlak verdi. Osmanlı döneminde meydan Atmeydanı olarak anıldı.\n\n"
        "Meydanın ortasında Firavun III. Thutmosis'ten kalma ve 4. yüzyılda Mısır'dan getirilen Dikilitaş, antik Delfi'den "
        "getirilen Yılanlı Sütun ve taşları açıkta kalmış Örme Dikilitaş sıralanır. Kuzey ucundaki sekizgen Alman Çeşmesi, "
        "Alman İmparatoru II. Wilhelm'in ziyaretinin hatırasıdır. Sultanahmet Camii ve Türk ve İslam Eserleri Müzesi de meydanın iki yanındadır.",
        "Today's Sultanahmet Square occupies the site of the Hippodrome, where chariot races were held in Roman and "
        "Byzantine times. Begun under Septimius Severus and enlarged by Constantine the Great, it was the heart of the city "
        "where emperors met their people; the Nika riot of 532 broke out here. In Ottoman times the square was known as "
        "Atmeydanı, the Horse Square.\n\n"
        "Along its centre stand the Egyptian Obelisk of Pharaoh Thutmose III, brought from Egypt in the 4th century, the "
        "Serpent Column from ancient Delphi and the rough stone Walled Obelisk. The octagonal German Fountain at the north "
        "end commemorates the visit of Kaiser Wilhelm II. The Blue Mosque and the Museum of Turkish and Islamic Arts line "
        "the two sides of the square."),

    "kapalicarsi": (2,
        "Dünyanın en eski ve en büyük kapalı çarşılarından biri olan Kapalıçarşı, Fatih Sultan Mehmed'in fetihten kısa süre "
        "sonra yaptırdığı Cevahir Bedesteni'nin çevresinde büyüyerek oluştu. Yüzyıllar içinde eklenen hanlar ve sokaklarla "
        "bugün yaklaşık dört bin dükkânın bulunduğu, kendi içinde bir şehir gibi işleyen bir yapıya dönüştü.\n\n"
        "Çarşının en eski bölümü olan İç Bedesten'de antika ve mücevherciler, çevresindeki sokaklarda halı, seramik, "
        "deri, aydınlatma ve kumaş dükkânları yoğunlaşır. Kaybolmaktan korkmayın; sokak adları meslek gruplarına göre "
        "verilmiştir ve her yön bir kapıya çıkar. Pazar günleri ve dini bayramların ilk günü kapalıdır; pazarlık burada "
        "gelenektir.",
        "One of the oldest and largest covered markets in the world, the Grand Bazaar grew up around the Cevahir Bedesten, "
        "a warehouse that Sultan Mehmed II built soon after the conquest. Over the centuries, inns and streets were added "
        "until it became a city within the city with around four thousand shops.\n\n"
        "Antique dealers and jewellers cluster in the old Inner Bedesten, while the surrounding lanes are full of carpets, "
        "ceramics, leather, lamps and textiles. Don't worry about getting lost: streets are named after the trades once "
        "practised there, and every direction ends at a gate. It is closed on Sundays and on the first day of religious "
        "holidays, and bargaining is part of the tradition."),

    "kucuk-ayasofya-camii": (2,
        "İmparator I. Justinianus ve eşi Theodora'nın 527-536 yılları arasında Azizler Sergios ve Bakhos adına yaptırdığı "
        "bu kilise, Ayasofya'dan birkaç yıl önce tamamlandığı için halk arasında Küçük Ayasofya adını aldı. II. Bayezid "
        "döneminde, 15. yüzyılın sonunda Darüssaade Ağası Hüseyin Ağa tarafından camiye çevrildi.\n\n"
        "Sekizgen planlı iç mekânı ve sütun başlıklarındaki ince taş işçiliği, İstanbul'un ayakta kalan en eski Bizans "
        "yapılarından birinde olduğunuzu hatırlatır. Avludaki eski medrese odaları bugün sakin bir çay bahçesi ve el "
        "sanatları atölyeleriyle çevrilidir. Sultanahmet'in kalabalığından birkaç dakikalık yürüyüşle uzaklaşmak için iyi bir duraktır.",
        "Built between 527 and 536 by Emperor Justinian I and Empress Theodora and dedicated to Saints Sergius and Bacchus, "
        "this church was finished a few years before Hagia Sophia, which is why it came to be called Little Hagia Sophia. "
        "In the late 15th century, under Bayezid II, it was converted into a mosque by the chief harem eunuch Hüseyin Agha.\n\n"
        "Its octagonal interior and the finely carved column capitals remind you that this is one of the oldest Byzantine "
        "buildings still standing in Istanbul. The cells of the old madrasa around the courtyard now host a quiet tea "
        "garden and craft workshops. It is a good escape from the Sultanahmet crowds, just a few minutes' walk away."),

    "kiz-kulesi": (2,
        "Üsküdar Salacak açıklarındaki küçük bir kayalığın üzerinde yükselen Kız Kulesi'nin geçmişi antik çağa kadar "
        "uzanır. Bizans döneminde burada bir gözetleme kulesi vardı; bugünkü yapı büyük ölçüde Osmanlı döneminde yeniden "
        "inşa edildi ve deniz feneri, karantina istasyonu gibi pek çok işlev üstlendi. Kapsamlı bir restorasyonun ardından "
        "2023'te müze olarak yeniden açıldı.\n\n"
        "Bir kehanetten korunmak için buraya kapatılan prenses ile yılan efsanesi kulenin adının kaynağı olarak anlatılır. "
        "Kuleye Salacak ve Karaköy'den kalkan teknelerle gidilir; içeride kulenin tarihini anlatan sergiler ve Tarihi "
        "Yarımada'ya bakan teras bulunur. Salacak sahilinden gün batımında kule ve şehir siluetini izlemek İstanbul'un "
        "klasik keyiflerindendir.",
        "Rising from a small rock off Salacak in Üsküdar, the Maiden's Tower has a history reaching back to antiquity. "
        "There was a watchtower here in Byzantine times; the present building was largely rebuilt in the Ottoman era and "
        "served as a lighthouse, a quarantine station and more. After a thorough restoration it reopened as a museum in "
        "2023.\n\n"
        "Its name comes from the legend of a princess locked away here to escape a prophecy, only to be bitten by a "
        "snake. Boats run to the tower from Salacak and Karaköy; inside are exhibitions on its history and a terrace "
        "facing the historic peninsula. Watching the sunset over the tower and the old city skyline from the Salacak "
        "shore is a classic Istanbul pleasure."),

    "konstantinopolis-surlari": (2,
        "Konstantinopolis'i yaklaşık bin yıl boyunca koruyan surlar, Haliç ve Marmara kıyılarını da çevreleyerek "
        "toplamda yirmi kilometreyi aşan bir savunma hattı oluşturuyordu. En ünlü bölümü, 5. yüzyılda II. Theodosius "
        "döneminde Marmara'dan Haliç'e kadar inşa edilen, hendek ve iki sıra duvardan oluşan kara surlarıdır. Şehir "
        "1453'te Osmanlılar tarafından fethedilene kadar bu surlar pek az kez aşılabildi.\n\n"
        "Yedikule'den Ayvansaray'a uzanan kara surları boyunca yürüyerek kuleleri, kapıları ve onarılmış bölümleri "
        "görebilirsiniz; Topkapı, Edirnekapı ve Belgradkapı en bilinen kapılardır. Bazı burçlar ve duvar üstleri "
        "korunmasız ve dik olduğundan tırmanmamak gerekir. Surlar, İstanbul'un tarihi alanlarıyla birlikte UNESCO Dünya Mirası "
        "listesindedir.",
        "For nearly a thousand years the walls of Constantinople protected the city, also running along the Golden Horn "
        "and the Sea of Marmara to form a defensive line of more than twenty kilometres. The most famous part is the land "
        "wall built in the 5th century under Theodosius II from the Marmara to the Golden Horn, with a moat and a double "
        "line of walls. Until the Ottoman conquest of 1453 these walls were breached only rarely.\n\n"
        "Walking along the land walls from Yedikule to Ayvansaray you pass towers, gates and restored sections; Topkapı, "
        "Edirnekapı and Belgradkapı are the best-known gates. Some towers and wall tops are steep and unprotected, so "
        "avoid climbing them. Together with Istanbul's other historic areas, the walls are a UNESCO World Heritage Site."),

    "aya-irini": (2,
        "Topkapı Sarayı'nın birinci avlusunda, Ayasofya'nın hemen yanındaki Aya İrini, adını 'kutsal barış'tan alan ve "
        "kökeni 4. yüzyıla uzanan bir Bizans kilisesidir. 532'deki Nika Ayaklanması'nda yanan yapıyı I. Justinianus "
        "yeniden inşa ettirdi. İstanbul'un camiye çevrilmemiş ender Bizans kiliselerinden biridir; Osmanlı döneminde "
        "cephanelik olarak kullanıldı ve 19. yüzyılda eski silahların sergilendiği bir koleksiyona ev sahipliği yaptı.\n\n"
        "Süslemesiz, yalın taş ve tuğla iç mekânı, apsisteki büyük haç mozaiği ve mükemmel akustiği ile çok etkileyicidir; "
        "bu nedenle zaman zaman konser ve sergilere de ev sahipliği yapar. Topkapı Sarayı gezisine başlamadan önce "
        "birinci avluda uğranabilecek bir duraktır.",
        "In the first courtyard of Topkapı Palace, right next to Hagia Sophia, stands Hagia Irene, a Byzantine church "
        "named for 'holy peace' whose origins go back to the 4th century. After it burned in the Nika riot of 532, "
        "Justinian I had it rebuilt. It is one of the few Byzantine churches in Istanbul never converted into a mosque; "
        "the Ottomans used it as an armoury, and in the 19th century it housed a collection of antique weapons.\n\n"
        "Its bare stone-and-brick interior, the large mosaic cross in the apse and its superb acoustics are deeply "
        "atmospheric, which is why it sometimes hosts concerts and exhibitions. It makes a good stop in the first "
        "courtyard before you start exploring Topkapı Palace."),

    "beylerbeyi-sarayi": (2,
        "Sultan Abdülaziz'in emriyle Sarkis Balyan'ın 1863-1865 yıllarında Boğaz'ın Anadolu yakasına inşa ettiği "
        "Beylerbeyi Sarayı, padişahın yazlık sarayı ve yabancı devlet konuklarının ağırlandığı bir konuk sarayıydı. Burada "
        "konaklayan ünlü misafirler arasında Fransa İmparatoriçesi Eugénie de vardı. Sultan II. Abdülhamid hayatının son "
        "yıllarını bu sarayda geçirdi.\n\n"
        "Dolmabahçe'ye göre daha küçük ve samimi olan saray, mermer cepheleri, havuzlu salonu ve Boğaz'a uzanan bahçeleriyle "
        "dikkat çeker; bahçedeki küçük deniz köşkleri ayrıca görülmeye değer. Ziyaret rehberli turla yapılır. Hemen önünden "
        "geçen 15 Temmuz Şehitler Köprüsü'nün altındaki sahil, sarayla birlikte güzel bir Boğaz yürüyüşü sunar.",
        "Built for Sultan Abdülaziz by Sarkis Balyan between 1863 and 1865 on the Asian shore of the Bosphorus, Beylerbeyi "
        "Palace was the sultan's summer residence and a guest palace for foreign dignitaries. Among the famous visitors who "
        "stayed here was Empress Eugénie of France. Sultan Abdülhamid II spent the last years of his life in this palace.\n\n"
        "Smaller and more intimate than Dolmabahçe, it is known for its marble façades, a hall with an indoor pool and "
        "gardens reaching down to the water; the little seaside pavilions in the garden are also worth seeing. Visits are by "
        "guided tour. The shoreline beneath the nearby Bosphorus bridge makes for a lovely waterside walk combined with the palace."),

    "ciragan-sarayi": (2,
        "Beşiktaş ile Ortaköy arasındaki Çırağan Sarayı, Sultan Abdülaziz döneminde Balyan ailesinin mimarlarına yaptırılan "
        "ve 1871'de tamamlanan görkemli bir Boğaz sarayıdır. Tahttan indirilen V. Murad uzun yıllar burada yaşamak zorunda "
        "kaldı. 1909'da Meclis-i Mebusan'a tahsis edilen saray, 1910'daki büyük yangında neredeyse tamamen harap oldu.\n\n"
        "Uzun yıllar harabe olarak kalan yapı, 20. yüzyılın sonlarında aslına uygun cephesiyle restore edilerek bir otelin "
        "parçası hâline getirildi. Bu yüzden içi müze olarak gezilemez; ancak deniz tarafındaki mermer cephesi Boğaz "
        "vapurlarından ve Ortaköy yönünden çok etkileyici görünür. Hemen arkasındaki Yıldız Parkı ile birlikte gezilebilir.",
        "Between Beşiktaş and Ortaköy, Çırağan Palace is a grand Bosphorus palace built for Sultan Abdülaziz by architects "
        "of the Balyan family and completed in 1871. The deposed Sultan Murad V was confined here for many years. Assigned "
        "to the Ottoman parliament in 1909, the palace was almost completely gutted by a great fire in 1910.\n\n"
        "After standing as a ruin for decades, it was restored with its original façade in the late 20th century and became "
        "part of a hotel, so the interior cannot be visited as a museum. Its marble seafront façade, however, is impressive "
        "seen from Bosphorus ferries or from the Ortaköy side. It pairs well with Yıldız Park just behind it."),

    "kinaliada": (2,
        "Prens Adaları'nın İstanbul'a en yakın olanı ve vapurun ilk uğradığı ada olan Kınalıada, Yunanca adı Proti'de de "
        "'ilk' anlamını taşır. Türkçe adını, yamaçlarındaki kızıl renkli topraktan alır. Bizans döneminde sürgün edilen "
        "imparatorlar ve soylular burada manastırlarda yaşamıştır; ada uzun süre Ermeni toplumunun sevdiği bir yazlık oldu.\n\n"
        "Diğer adalara göre daha az ağaçlıktır ama kıyıları boyunca neredeyse her yerden denize girilebilir. İskeleden "
        "yürüyerek adanın tepesindeki manastıra çıkabilir, Marmara ve İstanbul manzarasının tadını çıkarabilirsiniz. Kısa ve "
        "sakin bir ada gezisi için iyi bir seçimdir; Büyükada'ya gidip dönerken de uğranabilir.",
        "The closest of the Princes' Islands to Istanbul and the first stop for the ferry, Kınalıada's Greek name, Proti, "
        "also means 'first'. Its Turkish name comes from the reddish, henna-coloured soil of its slopes. Exiled Byzantine "
        "emperors and nobles lived in monasteries here, and the island later became a favourite summer retreat of the "
        "Armenian community.\n\n"
        "It has fewer trees than the other islands, but you can swim from almost anywhere along its shores. From the pier "
        "you can walk up to the monastery on the hilltop and enjoy views over the Marmara and the city. It is a good choice "
        "for a short, quiet island trip, or a stop on the way to or from Büyükada."),

    "sehzade-camii": (2,
        "Kanuni Sultan Süleyman, 1543'te genç yaşta hayatını kaybeden oğlu Şehzade Mehmed'in anısına bu camiyi Mimar "
        "Sinan'a yaptırdı. 1543-1548 yılları arasında inşa edilen cami, Sinan'ın 'çıraklık eserim' dediği ve ilk büyük "
        "selatin camisidir. Merkezi kubbenin dört yarım kubbeye yaslandığı simetrik planıyla sonraki pek çok camiye örnek oldu.\n\n"
        "Geniş avlusu, şadırvanı ve kalabalıktan uzak sakin havasıyla Şehzadebaşı'nda keyifli bir duraktır. Bahçedeki "
        "türbeler arasında Şehzade Mehmed'in çinilerle bezeli türbesi özellikle dikkat çeker. Bozdoğan Kemeri ve Süleymaniye'ye "
        "yürüme mesafesindedir.",
        "Suleiman the Magnificent had this mosque built by Mimar Sinan in memory of his son Prince Mehmed, who died young "
        "in 1543. Constructed between 1543 and 1548, it is the first great imperial mosque by Sinan, who called it his "
        "'apprentice work'. Its symmetrical plan, with the central dome resting on four half-domes, became a model for many "
        "later mosques.\n\n"
        "With its broad courtyard, ablution fountain and calm atmosphere away from the crowds, it is a pleasant stop in "
        "Şehzadebaşı. Among the tombs in the garden, Prince Mehmed's tile-decorated tomb is especially striking. The Valens "
        "Aqueduct and the Süleymaniye Mosque are within walking distance."),

    "sokollu-mehmed-pasa-camii": (3,
        "Üç padişaha sadrazamlık yapan Sokollu Mehmed Paşa adına eşi Esmahan Sultan'ın Mimar Sinan'a yaptırdığı bu "
        "küçük külliye 1571'de tamamlandı. Kadırga'nın dik yokuşları arasına kurulan cami, eğimli araziyi ustaca "
        "kullanan avlusu ve merdivenleriyle Sinan'ın en zarif eserlerinden biri sayılır.\n\n"
        "Küçük ölçeğine rağmen iç mekânı, mihrap duvarını kaplayan en kaliteli dönem İznik çinileriyle göz kamaştırır. "
        "Mihrap, minber ve giriş kapısının üzerinde Kâbe'deki Hacerü'l-Esved'den getirildiği bilinen küçük taş parçalar "
        "yerleştirilmiştir. Sultanahmet'ten birkaç dakikalık yürüyüş mesafesinde olmasına rağmen sakin kalan bir duraktır.",
        "Built by Mimar Sinan for Grand Vizier Sokollu Mehmed Pasha, who served three sultans, and commissioned by his wife "
        "Esmahan Sultan, this small complex was completed in 1571. Set among the steep lanes of Kadırga, its courtyard and "
        "stairways make clever use of the sloping ground, and it is counted among Sinan's most elegant works.\n\n"
        "Despite its modest size, the interior dazzles with İznik tiles of the finest period covering the mihrab wall. "
        "Small fragments said to come from the Black Stone of the Kaaba are set into the mihrab, the pulpit and the "
        "entrance door. Only a few minutes' walk from Sultanahmet, it remains remarkably peaceful."),

    "heybeliada": (3,
        "Prens Adaları'nın ikinci büyüğü olan Heybeliada, uzaktan bakıldığında yere bırakılmış bir heybeye benzediği "
        "için bu adı alır. Çam ormanlarıyla kaplı tepeleri, sakin koyları ve tarihi köşkleriyle adaların en yeşil olanıdır. "
        "Ümit Tepesi'ndeki Aya Triada Manastırı ve buradaki tarihi Heybeliada Ruhban Okulu ile kıyıdaki Deniz Lisesi adanın "
        "simge yapılarıdır.\n\n"
        "İskeleden başlayan ve adayı çevreleyen yol, yürüyüş ve bisiklet için idealdir; Değirmen Burnu'ndaki çamlık ve "
        "küçük koylar piknik ve deniz için sevilir. Cumhurbaşkanı İsmet İnönü'nün yazları kaldığı köşk bugün müze evdir. "
        "Büyükada'dan daha sakin ama ondan daha az yeşil olmayan bir gün için iyi bir seçimdir.",
        "The second largest of the Princes' Islands, Heybeliada takes its name from its shape, which from afar resembles "
        "a saddlebag (heybe). With pine-covered hills, quiet coves and historic mansions, it is the greenest of the "
        "islands. The Hagia Triada Monastery with the historic Halki Seminary on Ümit Hill, and the Naval High School on "
        "the shore, are its landmarks.\n\n"
        "The road that starts at the pier and circles the island is ideal for walking and cycling; the pine woods and small "
        "coves of Değirmen Point are popular for picnics and swimming. The house where President İsmet İnönü spent his "
        "summers is now a museum. It makes a calmer, equally green alternative to Büyükada."),

    "istanbul-arkeoloji-muzeleri": (3,
        "1869'da Müze-i Hümayun adıyla kurulan İstanbul Arkeoloji Müzeleri, Türkiye'nin müze olarak tasarlanmış ilk "
        "binasına sahiptir. Ressam ve arkeolog Osman Hamdi Bey'in öncülüğünde büyüyen koleksiyon, Balkanlar'dan "
        "Mezopotamya'ya uzanan geniş bir coğrafyadan bir milyonu aşkın eser barındırır. Ana bina 1891'de ziyarete açıldı.\n\n"
        "Müze; ana bina, Eski Şark Eserleri Müzesi ve Çinili Köşk olmak üzere üç yapıdan oluşur. Ana binadaki Sayda "
        "kazılarından çıkan İskender Lahdi en ünlü parçadır; Eski Şark bölümünde ise bilinen en eski barış "
        "antlaşmalarından Kadeş Antlaşması'nın tableti sergilenir. Gülhane Parkı'nın girişinde, Topkapı Sarayı'nın hemen "
        "altında olduğundan aynı gün gezilebilir; rahat bir ziyaret için birkaç saat ayırın.",
        "Founded in 1869 as the Imperial Museum, the Istanbul Archaeology Museums occupy the first building in Turkey "
        "designed as a museum. Built up under the painter and archaeologist Osman Hamdi Bey, the collection holds more than "
        "a million objects from a vast area stretching from the Balkans to Mesopotamia. The main building opened to "
        "visitors in 1891.\n\n"
        "The museum consists of three buildings: the main building, the Museum of the Ancient Orient and the Tiled Kiosk. "
        "The star of the main building is the Alexander Sarcophagus from the excavations at Sidon, while the Ancient Orient "
        "section displays the tablet of the Treaty of Kadesh, one of the oldest known peace treaties. It sits at the "
        "entrance to Gülhane Park just below Topkapı Palace, so both can be seen on the same day; allow a few hours."),

    "fethiye-camii": (3,
        "Çarşamba semtindeki Fethiye Camii, 13. yüzyılın sonlarında Bizans soylusu Mihail Glabas Tarkaniotes'in yaptırdığı "
        "Pammakaristos Kilisesi'dir. Fetihten sonra bir süre Rum Ortodoks Patrikhanesi olarak kullanıldı, 16. yüzyılın "
        "sonunda III. Murad döneminde kazanılan zaferlerin anısına camiye çevrildi ve Fethiye adını aldı.\n\n"
        "Yapının en değerli bölümü, yanındaki küçük şapelde (parekklesion) bulunan ve geç Bizans döneminden kalan altın "
        "zeminli mozaiklerdir; Kariye'deki mozaiklerle aynı dönemin ustalığını yansıtır. Ziyaret düzeni zaman zaman "
        "değiştiği için gitmeden önce kontrol etmekte yarar var. Fener ve Balat sokaklarına yürüme mesafesindedir.",
        "In the Çarşamba district, the Fethiye Mosque was originally the Pammakaristos Church, built in the late 13th "
        "century by the Byzantine noble Michael Glabas Tarchaneiotes. After the conquest it served for a while as the seat "
        "of the Greek Orthodox Patriarchate, and in the late 16th century, under Murad III, it became a mosque named "
        "Fethiye, 'of the conquest', to celebrate military victories.\n\n"
        "Its greatest treasure is the side chapel (parecclesion) with gold-ground mosaics from the late Byzantine period, "
        "reflecting the same mastery as those of Chora. Visiting arrangements change from time to time, so it is worth "
        "checking before you go. The streets of Fener and Balat are within walking distance."),

    "laleli-camii": (3,
        "Sultan III. Mustafa'nın 1760-1763 yılları arasında Mimar Mehmed Tahir Ağa'ya yaptırdığı Laleli Camii, Osmanlı "
        "barok üslubunun İstanbul'daki en güzel örneklerinden biridir ve bulunduğu semte adını vermiştir. Adını, "
        "padişahın saygı duyduğu Laleli Baba adlı bir dervişten aldığı anlatılır.\n\n"
        "Yüksek bir set üzerine oturan caminin altında bir zamanlar dükkânlar ve çarşı bulunan bir alt kat vardır; renkli "
        "mermerlerle süslü iç mekânı barok etkilerini açıkça gösterir. Bahçedeki türbede III. Mustafa ve oğlu III. Selim "
        "yatmaktadır. Ordu Caddesi üzerinde, Beyazıt ile Aksaray arasında kolayca uğranabilecek bir noktadadır.",
        "Built for Sultan Mustafa III between 1760 and 1763 by the architect Mehmed Tahir Agha, the Laleli Mosque is one of "
        "the finest examples of Ottoman baroque in Istanbul and gave its name to the surrounding district. Its name is "
        "said to come from a dervish called Laleli Baba whom the sultan revered.\n\n"
        "The mosque stands on a high platform with a lower level that once housed shops and a market, and its interior, "
        "decorated with coloured marble, shows clear baroque influences. The tomb in the garden holds Mustafa III and his "
        "son Selim III. It lies on Ordu Avenue between Beyazıt and Aksaray, an easy stop on the way."),

    "yeni-cami": (3,
        "Eminönü meydanına hâkim olan Yeni Cami'nin temeli 1597'de III. Murad'ın eşi Safiye Sultan tarafından atıldı; ancak "
        "inşaat uzun yıllar durdu ve cami ancak 1665'te IV. Mehmed'in annesi Turhan Hatice Sultan'ın himayesinde "
        "tamamlanabildi. İstanbul'da Osmanlı hanedanının yaptırdığı büyük klasik camilerin sonuncusu sayılır.\n\n"
        "Galata Köprüsü'nden ya da vapurdan bakıldığında basamaklı kubbeleriyle Haliç kıyısının simgelerinden biridir. "
        "İçeride İznik çinileri ve padişahın namaz kıldığı, ayrı girişli hünkâr kasrı dikkat çeker. Önündeki meydan ve "
        "güvercinler Eminönü'nün en canlı manzarasını oluşturur; Mısır Çarşısı hemen arkasındadır.",
        "Dominating Eminönü square, the New Mosque was begun in 1597 by Safiye Sultan, wife of Murad III, but construction "
        "stalled for decades and it was only completed in 1665 under the patronage of Turhan Hatice Sultan, mother of "
        "Mehmed IV. It is considered the last of the great classical mosques built by the Ottoman dynasty in Istanbul.\n\n"
        "Seen from the Galata Bridge or a ferry, its cascade of domes is one of the landmarks of the Golden Horn shore. "
        "Inside, look for the İznik tiles and the royal pavilion with its own entrance, where the sultan prayed. The square "
        "in front with its pigeons is one of the liveliest scenes in Eminönü, and the Spice Bazaar is right behind it."),

    "yerebatan-sarnici": (3,
        "İmparator I. Justinianus döneminde, 6. yüzyılda şehrin su ihtiyacını karşılamak için Ayasofya'nın yakınına "
        "yapılan Yerebatan Sarnıcı, suyun içinden yükselen yüzlerce mermer sütunu nedeniyle halk arasında Yerebatan Sarayı "
        "diye anılır. Üzerinde eskiden bir bazilika bulunduğu için Bazilika Sarnıcı olarak da bilinir.\n\n"
        "Loş ışıkla aydınlatılan sütun ormanı boyunca uzanan yürüme yollarından ilerlerken, sarnıcın kuzeybatı köşesinde "
        "sütun kaidesi olarak kullanılmış iki Medusa başını görebilirsiniz. Serin ve nemli iç mekân yazın ferahlatıcıdır. "
        "Gün içinde kuyruk oluşabildiğinden sabah erken ya da akşam saatleri daha rahattır.",
        "Built in the 6th century under Emperor Justinian I to supply water to the city, the Basilica Cistern near Hagia "
        "Sophia is known locally as the Sunken Palace because of the hundreds of marble columns rising from its water. It "
        "takes its other name from a basilica that once stood above it.\n\n"
        "As you follow the walkways through the dimly lit forest of columns, look for the two Medusa heads reused as column "
        "bases in the north-west corner. The cool, damp interior is refreshing in summer. Queues can build up during the "
        "day, so early morning or evening visits are easier."),

    "zeyrek-camii": (3,
        "Haliç'e bakan bir yamaçtaki Zeyrek Camii, 12. yüzyılda İmparator II. Ioannis Komnenos ve eşi İrene'nin kurduğu "
        "Pantokrator Manastırı'nın kiliseleridir. Birbirine bitişik iki kilise ve aralarındaki şapelden oluşan yapı, "
        "Komnenos hanedanının mezar yeri olarak da kullanıldı ve Ayasofya'dan sonra İstanbul'da ayakta kalan en büyük "
        "Bizans dini yapısı sayılır.\n\n"
        "Uzun bir restorasyonun ardından ibadete açılan caminin çevresindeki Zeyrek mahallesi, ahşap evleri ve dar "
        "sokaklarıyla UNESCO Dünya Mirası alanının bir parçasıdır. Yakındaki teras ve çay bahçelerinden Haliç, Süleymaniye "
        "ve Galata'yı birlikte gören güzel bir manzara vardır.",
        "On a slope above the Golden Horn, the Zeyrek Mosque was once the church of the Pantokrator Monastery, founded in "
        "the 12th century by Emperor John II Komnenos and Empress Irene. Made up of two adjoining churches and a chapel "
        "between them, it also served as the burial place of the Komnenian dynasty and is considered the largest surviving "
        "Byzantine religious building in Istanbul after Hagia Sophia.\n\n"
        "After a long restoration it has reopened for worship, and the surrounding Zeyrek neighbourhood, with its wooden "
        "houses and narrow lanes, is part of the UNESCO World Heritage Site. Terraces and tea gardens nearby offer a lovely "
        "view taking in the Golden Horn, the Süleymaniye and Galata."),

    "nuruosmaniye-camii": (3,
        "Kapalıçarşı'nın Nuruosmaniye Kapısı'nın hemen yanındaki bu cami, 1748'de I. Mahmud döneminde başlanıp 1755'te "
        "III. Osman zamanında tamamlandı ve adını ondan alır: 'Osman'ın nuru'. İstanbul'da barok üslupla yapılan ilk büyük "
        "cami olması, onu Osmanlı mimarisinde bir dönüm noktası yapar.\n\n"
        "Kavisli hatları, at nalı biçimli avlusu ve geniş pencerelerinden süzülen ışıkla aydınlanan iç mekânı, klasik "
        "Osmanlı camilerinden çok farklı bir hava taşır. Kapalıçarşı'ya girerken ya da çıkarken avlusunda soluklanmak "
        "için idealdir; Çemberlitaş Sütunu da birkaç adım ötededir.",
        "Next to the Nuruosmaniye Gate of the Grand Bazaar, this mosque was begun in 1748 under Mahmud I and completed in "
        "1755 under Osman III, from whom it takes its name: 'the light of Osman'. As the first major mosque in Istanbul "
        "built in the baroque style, it marks a turning point in Ottoman architecture.\n\n"
        "Its curving lines, horseshoe-shaped courtyard and interior flooded with light from large windows feel very "
        "different from the classical Ottoman mosques. Its courtyard is ideal for a breather on the way into or out of "
        "the Grand Bazaar, and the Column of Constantine is just a few steps away."),

    "rumeli-hisari": (3,
        "Fatih Sultan Mehmed'in İstanbul'un fethinden önce, 1452'de Boğaz'ın en dar yerine birkaç ay gibi kısa bir sürede "
        "yaptırdığı Rumeli Hisarı, karşı kıyıdaki Anadolu Hisarı ile birlikte Karadeniz'den şehre gelebilecek yardımı "
        "kesmek için kuruldu. Bu yüzden Boğazkesen adıyla da anılır.\n\n"
        "Yamaca yayılan surları ve üç büyük kulesiyle Boğaz'ın en etkileyici yapılarından biridir; kale içindeki "
        "basamaklar ve surlar boyunca yürüyerek Boğaz'ı ve Fatih Sultan Mehmet Köprüsü'nü yukarıdan görebilirsiniz. Müze "
        "olarak gezilir ve yazın açık hava konserlerine ev sahipliği yapabilir; ziyaret düzeni için gitmeden önce kontrol "
        "etmekte yarar var. Aşağıdaki sahil, Bebek ile Emirgan arasındaki yürüyüş yolunun en güzel kısmıdır.",
        "Built by Sultan Mehmed II in just a few months in 1452, before the conquest of Constantinople, at the narrowest "
        "point of the Bosphorus, Rumeli Fortress worked together with Anadolu Fortress on the opposite shore to cut off "
        "help reaching the city from the Black Sea, earning it the name Boğazkesen, 'the strait-cutter'.\n\n"
        "With its walls climbing the hillside and three great towers, it is one of the most striking sights on the "
        "Bosphorus; walking the steps and walls inside you look down on the strait and the Fatih Sultan Mehmet Bridge. It "
        "is visited as a museum and may host open-air concerts in summer; check visiting arrangements before you go. The "
        "shore below is the loveliest part of the walk between Bebek and Emirgan."),

    "ortakoy-camii": (4,
        "Ortaköy iskelesinin hemen yanında, Boğaz'ın kıyısında yükselen Büyük Mecidiye Camii, Sultan Abdülmecid'in "
        "isteğiyle Balyan ailesinden mimarlara yaptırıldı ve 1856'da tamamlandı. Neobarok üslubu, beyaz kesme taş "
        "cepheleri ve iki ince minaresiyle küçük ama son derece zarif bir yapıdır.\n\n"
        "Büyük pencerelerinden giren deniz ışığı iç mekânı aydınlatır. Arkasında 15 Temmuz Şehitler Köprüsü'nün yükseldiği "
        "manzarası İstanbul'un en çok fotoğraflanan karelerinden biridir. Meydandaki kafeler, kumpir ve waffle tezgâhları "
        "ile hafta sonları kurulan küçük pazar, Ortaköy'ü akşam yürüyüşleri için canlı bir buluşma noktası yapar.",
        "Right beside the Ortaköy pier on the shore of the Bosphorus, the Grand Mecidiye Mosque was built at the request "
        "of Sultan Abdülmecid by architects of the Balyan family and completed in 1856. With its neo-baroque style, white "
        "cut-stone façades and two slender minarets, it is small but exceptionally elegant.\n\n"
        "Light from the water pours in through its large windows. With the Bosphorus bridge rising behind it, the view is "
        "one of the most photographed in Istanbul. The cafés, baked-potato (kumpir) and waffle stalls on the square and the "
        "small weekend market make Ortaköy a lively meeting point for evening strolls."),

    "anadolu-hisari": (4,
        "Göksu Deresi'nin Boğaz'a döküldüğü noktada, Boğaz'ın en dar yerlerinden birinde duran Anadolu Hisarı, 14. yüzyılın "
        "sonunda Yıldırım Bayezid tarafından yaptırıldı ve İstanbul'daki en eski Osmanlı yapılarından biridir. Fatih "
        "Sultan Mehmed 1452'de karşı kıyıya Rumeli Hisarı'nı inşa ederken bu kaleyi de güçlendirdi.\n\n"
        "Rumeli Hisarı'na göre çok daha küçük olan kale, Boğaz vapurlarından ve karşı kıyıdan bakıldığında en güzel "
        "görünür. Çevresindeki tarihi yalılar ve Göksu Deresi boyunca uzanan sahil, sakin bir yürüyüş için idealdir; "
        "Küçüksu Kasrı da yakındadır. Kalenin iç kısmının ziyaret düzeni için gitmeden önce kontrol etmekte yarar var.",
        "Standing where the Göksu stream meets the Bosphorus, at one of the narrowest points of the strait, Anadolu "
        "Fortress was built by Sultan Bayezid I in the late 14th century and is one of the oldest Ottoman structures in "
        "Istanbul. When Mehmed II built Rumeli Fortress on the opposite shore in 1452, he strengthened this castle too.\n\n"
        "Much smaller than Rumeli Fortress, it looks its best from Bosphorus ferries and the opposite shore. The historic "
        "waterside mansions around it and the banks of the Göksu make for a peaceful walk, and Küçüksu Pavilion is nearby. "
        "Check visiting arrangements for the interior before you go."),

    "fatih-camii": (4,
        "Fatih Sultan Mehmed'in 1463-1470 yılları arasında Mimar Atik Sinan'a yaptırdığı Fatih Camii, fetihten sonra "
        "İstanbul'da inşa edilen ilk büyük selatin camisidir. Bizans döneminde imparatorların gömüldüğü Havariyun "
        "Kilisesi'nin bulunduğu tepeye kurulmuştur. Özgün cami 1766 depreminde yıkıldı ve 1771'de III. Mustafa döneminde "
        "bugünkü haliyle yeniden inşa edildi.\n\n"
        "Medreseleri, darüşşifası ve imaretiyle büyük bir külliyenin merkezi olan caminin bahçesinde Fatih Sultan "
        "Mehmed'in türbesi bulunur. Çevresi, geleneksel havasını koruyan canlı bir mahalledir; çarşamba günleri caminin "
        "etrafındaki sokaklarda kurulan büyük semt pazarı da görülmeye değer.",
        "Built for Sultan Mehmed II between 1463 and 1470 by the architect Atik Sinan, the Fatih Mosque was the first great "
        "imperial mosque raised in Istanbul after the conquest. It stands on the hill once occupied by the Byzantine Church "
        "of the Holy Apostles, where emperors were buried. The original mosque collapsed in the earthquake of 1766 and was "
        "rebuilt in its present form in 1771 under Mustafa III.\n\n"
        "At the heart of a large complex of schools, a hospital and a soup kitchen, its garden holds the tomb of Mehmed the "
        "Conqueror. The surrounding area is a lively, traditional neighbourhood, and the big street market held around the "
        "mosque on Wednesdays is well worth seeing."),

    "yildiz-parki": (4,
        "Beşiktaş'ta Çırağan Caddesi'nden yamaç boyunca yükselen Yıldız Parkı, bir zamanlar Yıldız Sarayı'nın has "
        "bahçesiydi. Özellikle Sultan II. Abdülhamid döneminde sarayın bir parçası olarak düzenlenen koru, bugün "
        "İstanbul'un en büyük ve en yeşil kent parklarından biridir.\n\n"
        "Yüzyıllık ağaçların gölgesindeki patikalar, gölet ve köşkler arasında dolaşabilirsiniz; Malta Köşkü ve Çadır "
        "Köşkü bugün kafe ve restoran olarak hizmet verir, Boğaz'a bakan bölümlerden manzara açılır. Yokuşlu bir park "
        "olduğundan rahat ayakkabı iyi olur. Çırağan Sarayı ve Ortaköy'e yürüme mesafesindedir.",
        "Rising up the hillside from Çırağan Avenue in Beşiktaş, Yıldız Park was once the private garden of Yıldız Palace. "
        "Landscaped as part of the palace, especially in the reign of Sultan Abdülhamid II, it is today one of Istanbul's "
        "largest and greenest city parks.\n\n"
        "You can wander paths shaded by century-old trees, past a pond and pavilions; the Malta and Çadır pavilions now "
        "serve as cafés and restaurants, and the upper parts open onto views of the Bosphorus. The park is hilly, so "
        "comfortable shoes help. Çırağan Palace and Ortaköy are within walking distance."),

    "sedef-adasi": (4,
        "Büyükada'nın güneydoğusundaki Sedef Adası, Prens Adaları'nın yerleşim olan en küçüğüdür. Uzaktan bakıldığında "
        "bitki örtüsünün sedefe benzetilmesinden adını alır; eskiden tavşanların bolluğu nedeniyle Tavşanadası diye de "
        "anılırdı. Bizans döneminde burada da bir manastır bulunuyordu.\n\n"
        "Bugün çoğunlukla yazlık evlerden oluşan sakin bir yerleşimdir ve yapılaşma sıkı kurallarla sınırlandırılmıştır. "
        "Berrak suyu ve küçük plajıyla yaz aylarında denize girmek için tercih edilir. Ulaşım çoğunlukla Büyükada'dan "
        "kalkan küçük teknelerle sağlanır; seferler mevsime göre değiştiği için önceden kontrol edin.",
        "South-east of Büyükada, Sedef Island is the smallest inhabited of the Princes' Islands. It takes its name, "
        "'mother-of-pearl', from the way its vegetation looks from afar, and was once also called Rabbit Island for its "
        "many rabbits. In Byzantine times it too had a monastery.\n\n"
        "Today it is a quiet settlement made up mostly of summer houses, with building strictly limited. Its clear water "
        "and small beach make it a summer favourite for swimming. It is usually reached by small boats from Büyükada; "
        "services vary by season, so check in advance."),

    "yassiada": (4,
        "Burgazada'nın güneybatısındaki küçük ve düz Yassıada, Bizans döneminde manastırlara ve sürgünlere ev sahipliği "
        "yaptı. Ada en çok, 1960 darbesinin ardından Başbakan Adnan Menderes ve arkadaşlarının yargılandığı Yassıada "
        "duruşmalarıyla bilinir.\n\n"
        "Kapsamlı bir yeniden düzenlemenin ardından 2020'de Demokrasi ve Özgürlükler Adası adıyla ziyarete açıldı; adada "
        "duruşmaların yapıldığı salonu ve dönemi anlatan bir müze, cami ve konaklama tesisleri bulunur. Adaya yalnızca "
        "belirli seferlerle ulaşılabildiği için gitmeden önce ulaşım ve ziyaret bilgilerini kontrol edin.",
        "South-west of Burgazada, the small, flat island of Yassıada hosted monasteries and exiles in Byzantine times. It "
        "is best known for the Yassıada trials, in which Prime Minister Adnan Menderes and his colleagues were tried after "
        "the 1960 military coup.\n\n"
        "After an extensive redevelopment it opened to visitors in 2020 as the Island of Democracy and Freedoms; it has a "
        "museum telling the story of the period, including the hall where the trials were held, a mosque and "
        "accommodation. It can only be reached by certain boat services, so check transport and visiting details before "
        "you go."),

    "bodrum-camii": (4,
        "Laleli'nin arka sokaklarındaki Bodrum Mesih Paşa Camii, 10. yüzyılda İmparator Romanos Lekapenos'un yaptırdığı "
        "Myrelaion Manastırı'nın kilisesidir. Fetihten sonra 15. yüzyılın sonunda Sadrazam Mesih Paşa tarafından camiye "
        "çevrildi.\n\n"
        "Kırmızı tuğla ve taş sıralarıyla örülmüş cepheleri orta Bizans mimarisinin küçük ama tipik bir örneğidir. Adındaki "
        "'bodrum', yapının altındaki alt yapıdan gelir; hemen yanında 5. yüzyıldan kalan büyük bir rotundanın kalıntıları "
        "bulunur. Kapalıçarşı ve Laleli arasında dolaşırken kısa bir mola için uygundur.",
        "In the backstreets of Laleli, the Bodrum Mesih Pasha Mosque was the church of the Myrelaion Monastery, built in "
        "the 10th century by Emperor Romanos Lekapenos. After the conquest it was converted into a mosque at the end of "
        "the 15th century by Grand Vizier Mesih Pasha.\n\n"
        "Its façades of alternating red brick and stone make it a small but typical example of middle Byzantine "
        "architecture. The word 'bodrum', basement, refers to the substructure beneath it, and right beside it are the "
        "remains of a large 5th-century rotunda. It makes a short stop while exploring between the Grand Bazaar and Laleli."),

    "bozdogan-kemeri": (4,
        "Roma İmparatoru Valens döneminde 4. yüzyılın sonunda tamamlanan Bozdoğan Kemeri, şehrin tepeleri arasındaki "
        "vadiyi aşarak suyu tarihi yarımadaya taşıyan su yolunun en görkemli parçasıdır. Bizans ve Osmanlı dönemlerinde "
        "defalarca onarılarak yüzyıllar boyunca kullanıldı.\n\n"
        "Bugün yaklaşık 900 metresi ayakta duran iki katlı kemerlerin altından Atatürk Bulvarı geçer; özellikle Saraçhane "
        "tarafındaki parktan ve akşam ışıklandırıldığında çok etkileyici görünür. Şehzade Camii ve Fatih yönüne giderken "
        "kolayca görülebilir.",
        "Completed under the Roman Emperor Valens at the end of the 4th century, the Valens Aqueduct is the most impressive "
        "surviving part of the water supply that carried water across the valley between the city's hills to the historic "
        "peninsula. Repaired many times by the Byzantines and the Ottomans, it stayed in use for centuries.\n\n"
        "Today about 900 metres of its two-tiered arches still stand, with Atatürk Boulevard running beneath them; it looks "
        "especially striking from the park on the Saraçhane side and when lit up in the evening. It is easy to see on the "
        "way to the Şehzade Mosque or Fatih."),

    "pierre-loti-tepesi": (4,
        "Eyüp'te Haliç'e bakan tepe, 19. yüzyılın sonlarında burada sık sık oturduğu söylenen Fransız yazar Pierre Loti'nin "
        "adını taşır. Loti, İstanbul'u anlattığı romanlarıyla tanınır ve tepedeki kahvehane onun adıyla anılmaya başladı.\n\n"
        "Kahvehanenin terasından Haliç'in tamamı, köprüler ve uzakta Tarihi Yarımada görülür; gün batımında manzara "
        "özellikle güzeldir. Eyüp Sultan Camii'nin yakınından kalkan teleferikle çıkılabilir ya da tarihi mezarlığın "
        "içinden geçen patikadan yürünebilir. Hafta sonları çok kalabalık olduğundan hafta içi daha keyiflidir.",
        "The hill above the Golden Horn in Eyüp is named after the French writer Pierre Loti, who is said to have often sat "
        "here in the late 19th century. Loti is known for novels set in Istanbul, and the café on the hill came to bear "
        "his name.\n\n"
        "From the café terrace you see the whole Golden Horn, its bridges and, in the distance, the historic peninsula; the "
        "view is especially beautiful at sunset. You can ride the cable car from near the Eyüp Sultan Mosque or walk up the "
        "path through the historic cemetery. Weekends get very crowded, so weekdays are more enjoyable."),

    "tekfur-sarayi": (4,
        "Edirnekapı'da kara surlarına bitişik Tekfur Sarayı, son dönem Bizans imparatorlarının yaşadığı Blakhernai Saray "
        "Kompleksi'nden günümüze sağlam ulaşan tek bölümdür ve 13.-14. yüzyıllara tarihlenir. Renkli tuğla ve taş "
        "süslemeli cephesi geç Bizans saray mimarisinin ender örneklerindendir.\n\n"
        "Osmanlı döneminde yapı bir süre çini atölyesi ve cam imalathanesi olarak kullanıldı; burada üretilen 18. yüzyıl "
        "Tekfur Sarayı çinileri bu yüzden ayrı bir isimle anılır. Restorasyonun ardından müze olarak açılan sarayda bu "
        "çiniler ve kazı buluntuları sergilenir. Kariye ve Mihrimah Sultan Camii ile aynı gezide görülebilir.",
        "Against the land walls at Edirnekapı, Tekfur Palace is the only part of the Blachernae Palace complex, home of the "
        "late Byzantine emperors, to survive intact, dating to the 13th-14th centuries. Its façade decorated with coloured "
        "brick and stone is a rare example of late Byzantine palace architecture.\n\n"
        "In Ottoman times the building served for a while as a tile workshop and glassworks, which is why the "
        "18th-century tiles made here are known by its name. After restoration it opened as a museum displaying these "
        "tiles and finds from excavations. It can be combined with Chora and the Mihrimah Sultan Mosque."),

    "turk-ve-islam-eserleri-muzesi": (5,
        "1914'te Süleymaniye Külliyesi'nin imaret binasında Evkaf-ı İslamiye Müzesi adıyla açılan Türk ve İslam Eserleri "
        "Müzesi, İslam sanatı eserlerini bir arada sergileyen ilk Türk müzesidir. 1983'ten bu yana Sultanahmet Meydanı'na "
        "bakan, 16. yüzyıldan kalma İbrahim Paşa Sarayı'nda bulunur.\n\n"
        "Müze özellikle dünyanın en önemli halı koleksiyonlarından birine sahiptir; Selçuklu ve Osmanlı halıları, el "
        "yazmaları, hat örnekleri, ahşap ve metal eserler sergilenir. Alt kattaki etnografya bölümü Anadolu'daki göçebe "
        "ve köy yaşamını anlatır. Ayasofya ve Sultanahmet Camii'nin hemen karşısında olduğundan aynı gezide görülebilir.",
        "Opened in 1914 as the Museum of Islamic Foundations in the soup-kitchen building of the Süleymaniye complex, the "
        "Museum of Turkish and Islamic Arts was the first Turkish museum to bring works of Islamic art together. Since "
        "1983 it has been housed in the 16th-century Palace of İbrahim Pasha, overlooking the Hippodrome.\n\n"
        "It is above all known for one of the world's finest carpet collections; Seljuk and Ottoman carpets, manuscripts, "
        "calligraphy, woodwork and metalwork are on display. The ethnography section on the lower floor portrays nomadic "
        "and village life in Anatolia. It sits right opposite Hagia Sophia and the Blue Mosque, so it fits easily into the "
        "same visit."),

    "belgrad-ormani": (5,
        "Sarıyer'in kuzeyinde, Boğaz ile Karadeniz arasında uzanan Belgrad Ormanı, İstanbul'un en büyük ormanlık "
        "alanlarından biridir. Bizans ve Osmanlı dönemlerinde şehre içme suyu sağlayan en önemli kaynaktı; adını, Kanuni "
        "Sultan Süleyman'ın Belgrad seferinden sonra buraya yerleştirilen ve su yollarının bakımını üstlenen ailelerden "
        "aldığı anlatılır.\n\n"
        "Ormanın içinde Osmanlı dönemine ait bentler ve su yapıları hâlâ görülebilir; Mimar Sinan'ın yaptığı su sisteminin "
        "parçaları bunlar arasındadır. Neşet Suyu çevresindeki yürüyüş ve koşu parkurları özellikle hafta sonları "
        "kalabalıktır. Piknik alanları ve giriş kuralları değişebildiği için gitmeden önce kontrol edin.",
        "Stretching north of Sarıyer between the Bosphorus and the Black Sea, Belgrad Forest is one of Istanbul's largest "
        "woodlands. In Byzantine and Ottoman times it was the city's main source of drinking water; it is said to take its "
        "name from families settled here after Suleiman the Magnificent's Belgrade campaign, who looked after the "
        "waterworks.\n\n"
        "Ottoman dams and water structures can still be seen inside the forest, among them parts of the water system built "
        "by Mimar Sinan. The walking and running trails around Neşet Suyu get busy, especially at weekends. Picnic areas "
        "and entry rules can change, so check before you go."),

    "rustem-pasa-camii": (5,
        "Mısır Çarşısı'nın yakınında, Tahtakale'nin hareketli çarşı sokaklarında saklı duran Rüstem Paşa Camii, Kanuni "
        "Sultan Süleyman'ın sadrazamı ve damadı Rüstem Paşa için Mimar Sinan tarafından 1560'ların başında yapıldı. "
        "Altındaki dükkânların gelirinin camiye vakfedilmesi için yüksek bir platform üzerine oturtulmuştur.\n\n"
        "Caminin asıl hazinesi, iç duvarları ve revakı baştan sona kaplayan 16. yüzyıl İznik çinileridir; lale, karanfil "
        "ve sümbül motifleri ile mercan kırmızısı tonları Osmanlı çini sanatının en parlak dönemini yansıtır. Girişi dar "
        "merdivenlerle çarşı içinden olduğu için kolayca gözden kaçabilir; tabelaları takip edin.",
        "Hidden among the busy market streets of Tahtakale near the Spice Bazaar, the Rüstem Pasha Mosque was built by "
        "Mimar Sinan in the early 1560s for Rüstem Pasha, grand vizier and son-in-law of Suleiman the Magnificent. It sits "
        "on a raised platform so that the rent from the shops beneath could support the mosque.\n\n"
        "Its real treasure is the 16th-century İznik tilework covering the interior walls and portico; tulip, carnation "
        "and hyacinth motifs and coral-red tones show Ottoman tile art at its peak. The entrance is up narrow stairs from "
        "within the market, so it is easy to miss; follow the signs."),

    "bayezid-camii": (5,
        "Beyazıt Meydanı'nda yükselen Bayezid Camii, Sultan II. Bayezid tarafından 1500'lerin başında yaptırıldı ve "
        "İstanbul'da özgün halini koruyan en eski selatin camisidir. Mimarı kesin olarak bilinmese de erken klasik Osmanlı "
        "mimarisinin önemli bir örneği ve Mimar Sinan'ın sonraki eserlerine öncü sayılır.\n\n"
        "Revaklı avlusu, renkli taşlardan sütunları ve şadırvanıyla huzurlu bir yerdir. Hemen yanında kitapçılarla dolu "
        "Sahaflar Çarşısı, karşısında İstanbul Üniversitesi'nin anıtsal kapısı bulunur; Kapalıçarşı da birkaç adım "
        "ötededir.",
        "Rising over Beyazıt Square, the Bayezid Mosque was built by Sultan Bayezid II in the early 1500s and is the oldest "
        "imperial mosque in Istanbul to survive in its original form. Although its architect is not known for certain, it "
        "is an important example of early classical Ottoman architecture and is seen as a forerunner of Mimar Sinan's "
        "later work.\n\n"
        "Its arcaded courtyard, columns of coloured stone and ablution fountain make it a peaceful place. Right beside it "
        "is the Sahaflar book market, opposite stands the monumental gate of Istanbul University, and the Grand Bazaar is "
        "just a few steps away."),

    "gulhane-parki": (5,
        "Topkapı Sarayı'nın surlarının dibinde, Sarayburnu'na doğru uzanan Gülhane Parkı, Osmanlı döneminde sarayın dış "
        "bahçesiydi. Halka 1912'de park olarak açıldı ve bugün tarihi yarımadanın en büyük ve en eski yeşil alanlarından "
        "biridir. 1839'da Tanzimat Fermanı'nın okunduğu yer olarak da tarihe geçmiştir.\n\n"
        "Ulu çınarların altındaki geniş yollar, Sultanahmet'in kalabalığından kaçmak için idealdir. Nisan ayında "
        "düzenlenen lale festivalinde park rengârenk olur. Parkın ucunda Roma döneminden kalma Gotlar Sütunu, içinde ise "
        "İslam Bilim ve Teknoloji Tarihi Müzesi bulunur; en uçtaki çay bahçesinden Boğaz'ın girişi görülür.",
        "Running below the walls of Topkapı Palace towards Sarayburnu, Gülhane Park was the palace's outer garden in "
        "Ottoman times. It opened to the public as a park in 1912 and is one of the largest and oldest green spaces on the "
        "historic peninsula. It is also where the Tanzimat reform edict was proclaimed in 1839.\n\n"
        "Its broad avenues under huge plane trees are ideal for escaping the Sultanahmet crowds. During the tulip "
        "festival in April the park bursts with colour. At its far end stands the Roman-era Column of the Goths, the "
        "Museum of the History of Science and Technology in Islam is inside the park, and the tea garden at the tip looks "
        "out over the mouth of the Bosphorus."),

    "masumiyet-muzesi": (5,
        "Çukurcuma'daki 19. yüzyıldan kalma bir evde 2012'de açılan Masumiyet Müzesi, Orhan Pamuk'un aynı adlı romanıyla "
        "birlikte tasarladığı bir müzedir. Romanın kahramanı Kemal'in sevdiği Füsun'a dair biriktirdiği eşyaları "
        "sergiler ve bir romanın kurmaca dünyasından yola çıkan ilk müze olarak 2014'te Avrupa Yılın Müzesi Ödülü'nü "
        "kazanmıştır.\n\n"
        "Her vitrin romanın bir bölümüne karşılık gelir ve 1950'ler-1970'ler İstanbul'unun gündelik hayatından nesnelerle "
        "doludur; giriş katındaki binlerce sigara izmaritinden oluşan duvar en çok konuşulan bölümdür. Romanı okumamış "
        "olsanız da anlatılan dönemin atmosferini hissettirir. Çukurcuma'nın antikacı sokakları da gezmeye değer.",
        "Opened in 2012 in a 19th-century house in Çukurcuma, the Museum of Innocence was conceived by Orhan Pamuk together "
        "with his novel of the same name. It displays the objects the novel's hero, Kemal, collected in memory of his "
        "beloved Füsun, and as the first museum built from a novel's fictional world it won the European Museum of the "
        "Year Award in 2014.\n\n"
        "Each display case matches a chapter of the book and is filled with everyday objects from 1950s-1970s Istanbul; "
        "the wall of thousands of cigarette butts on the ground floor is its most talked-about piece. Even if you have not "
        "read the novel, it captures the atmosphere of the era. The antique shops of Çukurcuma are worth exploring too."),

    "yedikule-hisari": (5,
        "Kara surlarının Marmara kıyısına yakın ucundaki Yedikule Hisarı, Fatih Sultan Mehmed'in 1458'de Bizans'ın "
        "görkemli tören kapısı Altın Kapı'nın çevresine eklettiği kulelerle yedi kuleli bir kaleye dönüştü. Osmanlı "
        "döneminde hazine deposu, ardından zindan olarak kullanıldı; Genç Osman'ın 1622'de burada öldürüldüğü bilinir.\n\n"
        "Bugün açık hava müzesi olan kalenin surlarına çıkarak Marmara'yı, kara surlarını ve tarihi yarımadayı "
        "görebilirsiniz. Roma zafer takı olarak yapılan ve sonradan örülen Altın Kapı'nın mermer kemerleri hâlâ "
        "seçilebilir. Restorasyon nedeniyle ziyaret düzeni değişebildiğinden gitmeden önce kontrol edin.",
        "At the end of the land walls near the Sea of Marmara, Yedikule Fortress took shape in 1458 when Mehmed II added "
        "towers around the Golden Gate, Byzantium's grand ceremonial entrance, creating a fortress of seven towers. In "
        "Ottoman times it served as a treasury and later as a prison; Sultan Osman II was killed here in 1622.\n\n"
        "Today an open-air museum, its ramparts offer views of the Marmara, the land walls and the historic peninsula. The "
        "marble arches of the Golden Gate, built as a Roman triumphal arch and later walled up, can still be made out. "
        "Visiting arrangements can change due to restoration, so check before you go."),

    "dikilitas": (5,
        "Sultanahmet Meydanı'nın ortasında duran Dikilitaş, İstanbul'daki en eski anıttır: Mısır firavunu III. Tutmosis "
        "tarafından MÖ 15. yüzyılda Karnak Tapınağı için yaptırıldı. Roma İmparatoru I. Theodosius 390 yılında onu "
        "Hipodrom'a diktirdi; taşınırken kırıldığı için bugün özgün yüksekliğinin yalnızca üst kısmı ayaktadır.\n\n"
        "Pembe granit gövdesindeki hiyeroglifler firavunun zaferlerini anlatır ve 3500 yıla rağmen şaşırtıcı derecede "
        "keskindir. Mermer kaidedeki kabartmalarda ise imparatoru ailesiyle Hipodrom'daki yarışları izlerken ve "
        "dikilitaşın dikilişini görebilirsiniz. Yılanlı Sütun ve Örme Sütun hemen yanındadır.",
        "Standing in the middle of Sultanahmet Square, the Obelisk is the oldest monument in Istanbul: it was made for "
        "Pharaoh Thutmose III in the 15th century BC for the Temple of Karnak. The Roman Emperor Theodosius I had it raised "
        "in the Hippodrome in 390; it broke during transport, so only the upper part of its original height stands today.\n\n"
        "The hieroglyphs on its pink granite shaft celebrate the pharaoh's victories and are remarkably crisp after 3,500 "
        "years. On the reliefs of the marble base you can see the emperor and his family watching the Hippodrome races and "
        "the raising of the obelisk itself. The Serpent Column and the Walled Obelisk stand right next to it."),

    "kucuksu-kasri": (5,
        "Anadolu yakasında, Göksu ve Küçüksu derelerinin arasında Boğaz kıyısında duran Küçüksu Kasrı, Sultan "
        "Abdülmecid'in isteğiyle Nigoğos Balyan tarafından yapıldı ve 1857'de tamamlandı. Padişahların gezinti ve "
        "dinlenme molaları için kullandığı, sürekli ikamet için yapılmamış biniş kasırlarından biridir.\n\n"
        "Denize bakan, zengin süslemeli barok cephesi ve kristal avizelerle bezeli salonları küçük ölçekli bir saray "
        "zarafeti taşır. Önündeki rıhtım ve bahçe Boğaz'ı seyretmek için güzel bir yerdir. Milli Saraylar'a bağlı müze "
        "olarak hizmet verir; ziyaret günleri değişebileceğinden gitmeden önce kontrol edin. Anadolu Hisarı yürüme "
        "mesafesindedir.",
        "On the Asian shore of the Bosphorus, between the Göksu and Küçüksu streams, Küçüksu Pavilion was built by "
        "Nigoğos Balyan at the request of Sultan Abdülmecid and completed in 1857. It is one of the sultans' excursion "
        "pavilions, used for outings and rest stops rather than as a permanent residence.\n\n"
        "Its richly decorated baroque façade facing the water and its salons with crystal chandeliers carry the elegance "
        "of a palace on a small scale. The quay and garden in front are a lovely spot to watch the Bosphorus. It is run "
        "as a museum by the National Palaces administration; opening days can change, so check before you go. Anadolu "
        "Fortress is within walking distance."),

    "mihrimah-sultan-camii-edirnekapi": (5,
        "Edirnekapı'da kara surlarının hemen yanında, tarihi yarımadanın en yüksek tepesinde yükselen Mihrimah Sultan "
        "Camii, Kanuni Sultan Süleyman'ın kızı Mihrimah Sultan için Mimar Sinan tarafından 1560'larda yapıldı. Medrese, "
        "türbe, sıbyan mektebi ve hamamdan oluşan bir külliyenin merkezidir.\n\n"
        "Tek büyük kubbeyi taşıyan duvarlar yüzlerce pencereyle açıldığı için iç mekân olağanüstü aydınlıktır; Sinan'ın "
        "en cesur denemelerinden biri sayılır. Rivayete göre Üsküdar'daki Mihrimah Sultan Camii ile bu cami arasında, "
        "güneşin batışı ve ayın doğuşuna dair romantik bir hikâye anlatılır. Kariye ve Tekfur Sarayı ile aynı gezide görülebilir.",
        "Rising beside the land walls at Edirnekapı, on the highest hill of the historic peninsula, the Mihrimah Sultan "
        "Mosque was built by Mimar Sinan in the 1560s for Mihrimah Sultan, daughter of Suleiman the Magnificent. It is the "
        "heart of a complex with a madrasa, tomb, primary school and bath.\n\n"
        "The walls carrying its single great dome are pierced by hundreds of windows, making the interior exceptionally "
        "bright; it is considered one of Sinan's boldest experiments. Legend links it with the Mihrimah Sultan Mosque in "
        "Üsküdar through a romantic story about the setting of the sun and the rising of the moon. It can be combined with "
        "Chora and Tekfur Palace."),

    "aya-yorgi-patrikhane-kilisesi": (6,
        "Fener'deki Aya Yorgi Kilisesi, 1601'den bu yana Rum Ortodoks Patrikhanesi'nin merkezidir ve dünyadaki Ortodoks "
        "Hristiyanlar için özel bir anlam taşır. Bugünkü yapı, 18. yüzyıl başındaki bir yangından sonra yeniden inşa "
        "edilmiş, dışarıdan bakıldığında oldukça sade, bazilika planlı bir kilisedir.\n\n"
        "Sade cephesinin aksine iç mekân, altın varaklı ahşap ikonostasisi, eski ikonaları ve patrik tahtıyla son derece "
        "zengindir; burada bazı azizlerin kutsal emanetleri de saklanır. Kilise ibadete açık bir mekân olduğundan sessiz "
        "olunmalı ve uygun giyinilmelidir. Fener ve Balat'ın renkli sokaklarıyla birlikte gezilebilir.",
        "The Church of St George in Fener has been the seat of the Ecumenical Patriarchate since 1601 and holds special "
        "meaning for Orthodox Christians worldwide. The present building, rebuilt after a fire in the early 18th century, "
        "is a basilica that looks quite plain from outside.\n\n"
        "In contrast to its modest façade, the interior is richly furnished with a gilded wooden iconostasis, old icons and "
        "the patriarchal throne, and it keeps the relics of several saints. As a working place of worship it calls for "
        "quiet and modest dress. It combines well with the colourful streets of Fener and Balat."),

    "dolmabahce-camii": (6,
        "Dolmabahçe Sarayı'nın hemen yanında, Boğaz kıyısındaki Dolmabahçe Camii, Sultan Abdülmecid'in annesi Bezmialem "
        "Valide Sultan tarafından başlatıldı; onun ölümünden sonra Abdülmecid tarafından tamamlanarak 1855'te ibadete "
        "açıldı. Tasarımı Garabet Balyan'a aittir.\n\n"
        "Barok ve ampir etkileri taşıyan tek kubbeli yapı, ince uzun minareleri ve büyük pencereleriyle 19. yüzyıl "
        "Osmanlı mimarisinin Avrupa'ya açılan yüzünü gösterir. Saray ve saat kulesiyle birlikte sahil boyunca yürürken "
        "kolayca görülebilir; deniz kıyısından cami ile Boğaz'ı aynı karede yakalamak mümkündür.",
        "Right beside Dolmabahçe Palace on the shore of the Bosphorus, the Dolmabahçe Mosque was begun by Bezmialem Valide "
        "Sultan, mother of Sultan Abdülmecid, and completed after her death by Abdülmecid himself, opening for worship in "
        "1855. It was designed by Garabet Balyan.\n\n"
        "With baroque and Empire influences, its single dome, slender minarets and large windows show the European-facing "
        "side of 19th-century Ottoman architecture. It is easy to take in while walking along the shore with the palace "
        "and clock tower, and from the waterfront you can frame the mosque and the Bosphorus in a single shot."),

    "eyup-sultan-camii": (6,
        "Haliç'in kıyısında, surların dışındaki Eyüp Sultan Camii, Hz. Muhammed'in sahabesi ve sancaktarı Ebu Eyyub "
        "el-Ensari'nin türbesinin yanında yer alır. Fatih Sultan Mehmed 1458'de burada ilk külliyeyi yaptırdı; bugünkü "
        "cami 19. yüzyılın başında III. Selim döneminde yeniden inşa edildi. Osmanlı padişahları tahta çıktıklarında "
        "kılıç kuşanma törenleri burada yapılırdı.\n\n"
        "İstanbul'un en kutsal sayılan ziyaret yerlerinden biridir; özellikle cuma günleri, bayramlarda ve kandillerde "
        "çok kalabalık olur. Çinilerle kaplı türbe ziyareti sırasında sessiz ve saygılı olunmalıdır. Çevredeki çarşı ve "
        "tarihi mezarlıktan Pierre Loti Tepesi'ne çıkılabilir.",
        "On the shore of the Golden Horn, outside the city walls, the Eyüp Sultan Mosque stands beside the tomb of Abu "
        "Ayyub al-Ansari, companion and standard-bearer of the Prophet Muhammad. Mehmed II built the first complex here in "
        "1458; the present mosque was rebuilt in the early 19th century under Selim III. Ottoman sultans were girded with "
        "the sword here on their accession.\n\n"
        "It is one of the most sacred places of pilgrimage in Istanbul and gets very busy on Fridays and religious "
        "holidays. Visitors to the tiled tomb should be quiet and respectful. From the surrounding market and historic "
        "cemetery you can walk up to Pierre Loti Hill."),

    "istanbul-modern": (6,
        "2004'te Karaköy'deki eski bir antrepoda açılan İstanbul Modern, Türkiye'nin ilk modern ve çağdaş sanat "
        "müzesidir. 2023'ten bu yana Galataport'ta, Renzo Piano'nun tasarladığı, Boğaz'a bakan yeni binasında "
        "hizmet verir.\n\n"
        "Koleksiyonunda Türkiye'den modern ve çağdaş resim, heykel, fotoğraf ve video eserleri bulunur; dönemsel "
        "sergiler ve fotoğraf galerisi sık sık yenilenir. Teras ve restorandan tarihi yarımadanın ve Boğaz'ın manzarası "
        "görülür. Galataport sahili ve Karaköy'ün sokaklarıyla birleştirilebilir.",
        "Opened in 2004 in a former warehouse in Karaköy, Istanbul Modern is Turkey's first museum of modern and "
        "contemporary art. Since 2023 it has been housed in a new waterfront building designed by Renzo Piano at "
        "Galataport.\n\n"
        "Its collection covers modern and contemporary painting, sculpture, photography and video from Turkey, while its "
        "temporary exhibitions and photography gallery change often. The terrace and restaurant look out over the "
        "historic peninsula and the Bosphorus. It combines well with the Galataport promenade and the streets of Karaköy."),

    "pera-muzesi": (6,
        "Tepebaşı'ndaki Pera Müzesi, Suna ve İnan Kıraç Vakfı tarafından 2005'te açıldı. 1893'te mimar Achilleas Manussos "
        "tarafından yapılan tarihi Bristol Oteli binasında yer alır ve İstiklal Caddesi'nin hemen yakınındadır.\n\n"
        "En bilinen eseri Osman Hamdi Bey'in Kaplumbağa Terbiyecisi tablosudur; Oryantalist resim koleksiyonu, Anadolu "
        "ağırlık ve ölçü aletleri ile Kütahya çini ve seramikleri de sürekli sergilenir. Üst katlardaki dönemsel "
        "sergiler dünyaca tanınmış sanatçıları ağırlar. Galata Kulesi ve Şişhane'ye yürüme mesafesindedir.",
        "Pera Museum in Tepebaşı was opened in 2005 by the Suna and İnan Kıraç Foundation. It occupies the historic "
        "Bristol Hotel, built in 1893 by the architect Achilleas Manussos, just off İstiklal Avenue.\n\n"
        "Its best-known work is Osman Hamdi Bey's The Tortoise Trainer; its collections of Orientalist painting, Anatolian "
        "weights and measures, and Kütahya tiles and ceramics are on permanent display. The temporary exhibitions on the "
        "upper floors host internationally renowned artists. Galata Tower and Şişhane are within walking distance."),

    "camlica-camii": (6,
        "Üsküdar'daki Çamlıca Tepesi'nde yükselen Büyük Çamlıca Camii, 2019'da açıldı ve Cumhuriyet tarihinin en büyük "
        "camisidir. Altı minaresi ve klasik Osmanlı mimarisinden esinlenen kubbesiyle şehrin birçok noktasından görülür.\n\n"
        "Külliyede bir İslam medeniyetleri müzesi, sanat galerisi, kütüphane ve konferans salonu da bulunur. Avlusundan "
        "ve yakındaki Çamlıca Tepesi'nden Boğaz'ın, köprülerin ve tarihi yarımadanın geniş bir manzarası açılır; gün "
        "batımında özellikle güzeldir. İbadet saatlerinde ziyaretçilerin saygılı olması beklenir.",
        "Rising on Çamlıca Hill in Üsküdar, the Grand Çamlıca Mosque opened in 2019 and is the largest mosque built in the "
        "history of the Republic. With six minarets and a dome inspired by classical Ottoman architecture, it can be seen "
        "from many parts of the city.\n\n"
        "The complex also houses a museum of Islamic civilisations, an art gallery, a library and a conference hall. Its "
        "courtyard and nearby Çamlıca Hill offer sweeping views of the Bosphorus, its bridges and the historic peninsula, "
        "especially beautiful at sunset. Visitors are expected to be respectful during prayer times."),

    "cemberlitas-sutunu": (6,
        "Divanyolu üzerindeki Çemberlitaş Sütunu, İmparator I. Konstantin'in 330'da şehri yeni başkent ilan ettiğinde "
        "kendi adını taşıyan forumun ortasına diktirdiği anıttır. Mısır'dan getirilen mor porfir taş bloklardan "
        "oluşur; üzerinde bir zamanlar imparatorun heykeli dururdu.\n\n"
        "Blokları birbirine tutturan demir çemberler sütuna Türkçe adını verir; 18. yüzyıldaki büyük bir yangında "
        "karardığı için Yanık Sütun diye de anılır. Kapalıçarşı'nın girişine çok yakındır ve tramvayla Sultanahmet'ten "
        "gelirken kolayca görülür. Hemen yanındaki tarihi Çemberlitaş Hamamı da bilinen bir duraktır.",
        "On Divanyolu, the Column of Constantine was raised by Emperor Constantine I in 330, when he proclaimed the city "
        "his new capital, at the centre of the forum bearing his name. It is made of purple porphyry drums brought from "
        "Egypt and was once topped by a statue of the emperor.\n\n"
        "The iron hoops binding the drums give it its Turkish name, the 'hooped stone'; blackened in a great 18th-century "
        "fire, it is also known as the Burnt Column. It is very close to an entrance of the Grand Bazaar and easy to spot "
        "when coming by tram from Sultanahmet. The historic Çemberlitaş Bath right beside it is a well-known stop too."),

    "miniaturk": (6,
        "Haliç kıyısında, Sütlüce'de 2003'te açılan Miniatürk, Türkiye'nin ve Osmanlı coğrafyasının önemli yapılarının "
        "küçültülmüş maketlerinin sergilendiği büyük bir açık hava minyatür parkıdır.\n\n"
        "Ayasofya, Sümela Manastırı, Efes'teki Celsus Kütüphanesi ve Galata Kulesi gibi yüzden fazla yapının maketleri "
        "arasında birkaç saatte geniş bir gezi yapılabilir; maketlerin yanındaki bilgi panoları yapıları kısaca anlatır. "
        "Çocuklu aileler için özellikle keyiflidir. Açılış saatleri mevsime göre değişebileceğinden gitmeden önce "
        "kontrol edin.",
        "Opened in 2003 at Sütlüce on the Golden Horn, Miniatürk is a large open-air miniature park displaying scale models "
        "of landmark buildings from Turkey and the former Ottoman lands.\n\n"
        "Among more than a hundred models, such as Hagia Sophia, Sumela Monastery, the Library of Celsus at Ephesus and "
        "Galata Tower, you can make a wide-ranging tour in a few hours, with information panels describing each building. "
        "It is especially enjoyable for families with children. Opening hours can vary by season, so check before you go."),

    "arap-camii": (6,
        "Karaköy'ün arka sokaklarındaki Arap Camii, 14. yüzyılda Galata'daki Cenevizliler döneminde Dominiken rahipleri "
        "tarafından San Domenico (Aziz Paulus) Kilisesi olarak yapıldı ve İstanbul'da günümüze ulaşan tek Gotik "
        "kilisedir. Fetihten sonra camiye çevrildi; adını 15. yüzyılın sonunda İspanya'dan göç eden ve buraya yerleşen "
        "Endülüslü Müslümanlardan aldığı anlatılır.\n\n"
        "Sivri külahlı, kare planlı yüksek kulesi bir kilise çan kulesinden dönüştürülmüş minaredir ve Galata'nın "
        "sıkışık dokusunda hâlâ kolayca seçilir. İç mekânın ahşap tavanı ve uzun dikdörtgen planı yapının kilise "
        "geçmişini yansıtır. Galata Kulesi ve Karaköy gezisine kolayca eklenebilir.",
        "In the backstreets of Karaköy, the Arap Mosque was built in the 14th century by Dominican friars as the Church of "
        "San Domenico (St Paul), when Galata was a Genoese colony, and it is the only Gothic church in Istanbul to "
        "survive. It became a mosque after the conquest and is said to take its name from Andalusian Muslims who fled "
        "Spain and settled here at the end of the 15th century.\n\n"
        "Its tall, square tower with a pointed roof is a church bell tower turned minaret, still easy to pick out in "
        "Galata's dense streets. The wooden ceiling and long rectangular plan of the interior reflect its past as a church. "
        "It is an easy addition to a walk around Galata Tower and Karaköy."),

    "buyuk-saray-mozaikleri-muzesi": (6,
        "Sultanahmet Camii'nin arkasındaki Arasta Çarşısı'nda bulunan Büyük Saray Mozaikleri Müzesi, Bizans "
        "imparatorlarının Büyük Saray'ına ait sütunlu bir avlunun mozaik zeminleri üzerine kurulmuştur. Kazılarda "
        "ortaya çıkan mozaikler yerinde korunarak müzeye dönüştürülmüştür.\n\n"
        "Geç Roma dönemine tarihlenen mozaiklerde av sahneleri, çobanlar, oyun oynayan çocuklar, gerçek ve hayali "
        "hayvanlar canlı renklerle anlatılır; bazı sahnelerin ayrıntısı olağanüstüdür. Küçük ve sakin bir müze olduğu "
        "için Sultanahmet kalabalığından kısa bir mola olarak idealdir. Ziyaret düzenini gitmeden önce kontrol edin.",
        "In the Arasta Bazaar behind the Blue Mosque, the Great Palace Mosaic Museum is built over the mosaic floors of a "
        "colonnaded courtyard of the Byzantine emperors' Great Palace. The mosaics uncovered in excavations were preserved "
        "in place and turned into a museum.\n\n"
        "Dating from the late Roman period, the mosaics depict hunting scenes, shepherds, children at play, and real and "
        "fantastic animals in vivid colour, some in remarkable detail. As a small, quiet museum it makes an ideal short "
        "break from the Sultanahmet crowds. Check visiting arrangements before you go."),

    "ihlamur-kasri": (7,
        "Beşiktaş ile Nişantaşı arasındaki yeşil vadide bulunan Ihlamur Kasrı, Sultan Abdülmecid'in isteğiyle Nigoğos "
        "Balyan tarafından 1850'lerde yapıldı. Padişahların gezinti ve dinlenme için kullandığı mesirede, tören için "
        "kullanılan Merasim Köşkü ile maiyetin kaldığı Maiyet Köşkü olmak üzere iki yapı bulunur.\n\n"
        "Barok süslemeli kesme taş cepheleri ve zengin döşenmiş salonlarıyla küçük ama zarif bir kasırdır. Adını aldığı "
        "ıhlamur ağaçlarının gölgelediği bahçe ve havuz, şehrin ortasında sakin bir mola yeri sunar. Milli Saraylar'a "
        "bağlı müze olarak hizmet verir; ziyaret günlerini gitmeden önce kontrol edin.",
        "In a green valley between Beşiktaş and Nişantaşı, Ihlamur Pavilion was built in the 1850s by Nigoğos Balyan at the "
        "request of Sultan Abdülmecid. The sultans' pleasure ground has two buildings: the Ceremonial Pavilion and the "
        "Retinue Pavilion, where the entourage stayed.\n\n"
        "With its baroque-decorated cut-stone façades and richly furnished rooms, it is small but elegant. The garden and "
        "pool, shaded by the linden trees that give it its name, offer a quiet break in the middle of the city. It is run "
        "as a museum by the National Palaces administration; check opening days before you go."),

    "st-antuan-katolik-kilisesi": (7,
        "İstiklal Caddesi üzerindeki St. Antuan Kilisesi, İstanbul'un en büyük ve cemaati en kalabalık Katolik "
        "kilisesidir. Fransisken rahiplerine bağlıdır; bugünkü yapı mimar Giulio Mongeri tarafından 1906-1912 yılları "
        "arasında Venedik neo-Gotik üslubunda inşa edildi.\n\n"
        "Kırmızı tuğla cephesi ve avlusuyla caddenin kalabalığı içinde hemen dikkat çeker; içerideki renkli vitraylar ve "
        "yüksek kemerler sakin bir atmosfer yaratır. Sonradan Papa XXIII. Ioannes olacak Angelo Roncalli, İstanbul'daki "
        "görevi sırasında burada vaaz vermiştir. Ayinler sırasında ziyaretçilerin sessiz olması beklenir.",
        "On İstiklal Avenue, the Church of St Anthony of Padua is the largest Catholic church in Istanbul and has the "
        "biggest congregation. It is run by Franciscan friars; the present building was erected between 1906 and 1912 by "
        "the architect Giulio Mongeri in Venetian neo-Gothic style.\n\n"
        "Its red-brick façade and courtyard stand out amid the busy avenue, while the stained glass and tall arches inside "
        "create a calm atmosphere. Angelo Roncalli, later Pope John XXIII, preached here during his posting in Istanbul. "
        "Visitors are asked to be quiet during Mass."),

    "ayasofya-turbeleri": (7,
        "Ayasofya'nın güney tarafındaki bahçede yer alan türbeler, 16. ve 17. yüzyılda beş Osmanlı padişahının ve "
        "ailelerinin yattığı yapılardır. II. Selim'in türbesi Mimar Sinan'ın eseridir; III. Murad ve III. Mehmed'in "
        "türbeleri de buradadır. Ayasofya'nın eski vaftizhanesi de I. Mustafa ve Sultan İbrahim için türbeye "
        "dönüştürülmüştür.\n\n"
        "Türbelerin iç duvarları Osmanlı çini sanatının en güzel örnekleri arasında sayılan İznik çinileriyle kaplıdır; "
        "kalem işi kubbeler ve sedef kakmalı kapılar da dikkat çeker. Ayasofya ziyaretiyle birleştirilebilir; giriş "
        "düzeni değişebildiği için gitmeden önce kontrol edin.",
        "In the garden on the south side of Hagia Sophia, these tombs hold five Ottoman sultans of the 16th and 17th "
        "centuries and their families. The tomb of Selim II is the work of Mimar Sinan, and the tombs of Murad III and "
        "Mehmed III are here too. Hagia Sophia's former baptistery was also turned into a tomb for Mustafa I and Sultan "
        "İbrahim.\n\n"
        "Their interiors are lined with İznik tiles counted among the finest examples of Ottoman tile art, and the painted "
        "domes and mother-of-pearl inlaid doors are striking too. They can be combined with a visit to Hagia Sophia; entry "
        "arrangements can change, so check before you go."),

    "fatih-sultan-mehmed-turbesi": (7,
        "İstanbul'u 1453'te fetheden Fatih Sultan Mehmed'in türbesi, Fatih Camii'nin kıble duvarının arkasındaki "
        "hazirededir. Özgün türbe 1766 depreminde yıkıldı ve III. Mustafa döneminde barok üslupta yeniden yapıldı.\n\n"
        "Zengin süslemeli iç mekânında padişahın sandukası, kavuğu ve dönemin hat levhaları bulunur. Hemen yanında "
        "eşi Gülbahar Hatun'un türbesi yer alır. Özellikle cuma günleri ve fetih yıldönümü olan 29 Mayıs'ta çok sayıda "
        "ziyaretçi gelir; ziyaret sırasında sessiz ve saygılı olunmalıdır. Fatih Camii ziyaretinin doğal bir parçasıdır.",
        "The tomb of Mehmed II, who conquered Istanbul in 1453, stands in the graveyard behind the qibla wall of the Fatih "
        "Mosque. The original tomb collapsed in the earthquake of 1766 and was rebuilt in baroque style under "
        "Mustafa III.\n\n"
        "Its richly decorated interior holds the sultan's cenotaph, his turban and calligraphic panels. The tomb of his "
        "consort Gülbahar Hatun stands right beside it. Many visitors come, especially on Fridays and on 29 May, the "
        "anniversary of the conquest; visitors should be quiet and respectful. It is a natural part of a visit to the "
        "Fatih Mosque."),

    "hurrem-sultan-turbesi": (7,
        "Süleymaniye Camii'nin arkasındaki hazirede, Kanuni Sultan Süleyman'ın türbesinin yakınında bulunan Hürrem Sultan "
        "Türbesi, 1558'de ölen Hürrem Sultan için Mimar Sinan tarafından yapıldı. Kanuni'nin eşi olan Hürrem, Osmanlı "
        "tarihinin en etkili kadınlarından biri sayılır.\n\n"
        "Sekizgen planlı türbenin iç duvarları, cennet bahçesini anımsatan çiçek ve ağaç motifli İznik çinileriyle "
        "kaplıdır ve Kanuni'nin türbesiyle birlikte Sinan'ın en zarif türbelerinden biridir. Süleymaniye Camii "
        "ziyaretinin ardından avludan kolayca ulaşılır; ziyaret düzenini gitmeden önce kontrol edin.",
        "In the graveyard behind the Süleymaniye Mosque, near the tomb of Suleiman the Magnificent, the Tomb of Hürrem "
        "Sultan was built by Mimar Sinan for Hürrem, who died in 1558. Suleiman's wife, known in Europe as Roxelana, is "
        "counted among the most influential women in Ottoman history.\n\n"
        "The interior of the octagonal tomb is lined with İznik tiles whose flowers and trees evoke the garden of "
        "paradise, and together with Suleiman's tomb it is one of Sinan's most graceful. It is easily reached from the "
        "courtyard after a visit to the Süleymaniye Mosque; check visiting arrangements before you go."),

    "i-abdulhamid-turbesi": (7,
        "Eminönü'nde, Bahçekapı'daki I. Abdülhamid Türbesi, padişahın 1770'lerde yaptırdığı külliyenin bir parçasıdır. "
        "Burada 27. Osmanlı padişahı I. Abdülhamid ile oğlu IV. Mustafa yatar.\n\n"
        "Kesme taştan, barok süslemeli yapı 18. yüzyılda Osmanlı mimarisine giren Avrupa etkilerinin güzel bir örneğidir. "
        "Sirkeci ile Mısır Çarşısı arasındaki kalabalık ticaret sokaklarının ortasında kalan sakin bir duraktır ve "
        "bölgede dolaşırken kısa bir ziyaret için uygundur.",
        "At Bahçekapı in Eminönü, the Tomb of Abdülhamid I is part of the complex the sultan built in the 1770s. It holds "
        "Abdülhamid I, the 27th Ottoman sultan, and his son Mustafa IV.\n\n"
        "Built of cut stone with baroque decoration, it is a fine example of the European influences that entered Ottoman "
        "architecture in the 18th century. It is a quiet stop in the middle of the busy shopping streets between Sirkeci "
        "and the Spice Bazaar, ideal for a short visit while exploring the area."),

    "ii-mahmud-turbesi": (7,
        "Divanyolu Caddesi üzerindeki II. Mahmud Türbesi, Sultan Abdülmecid'in 1839'da ölen babası için yaptırdığı ve "
        "1840'ta tamamlanan anıtsal bir türbedir. Burada II. Mahmud'un yanı sıra Sultan Abdülaziz ve II. Abdülhamid de "
        "yatar.\n\n"
        "Sekizgen planlı, ampir üslubundaki türbe büyük pencereleri ve parlak iç süslemesiyle dikkat çeker. Çevresindeki "
        "hazirede, Osmanlı'nın son döneminden birçok devlet adamı, yazar ve sanatçının mezarı bulunur; işlemeli mezar "
        "taşları arasında dolaşmak ilginçtir. Çemberlitaş ve Kapalıçarşı'ya birkaç dakika yürüme mesafesindedir.",
        "On Divanyolu, the Tomb of Mahmud II is a monumental mausoleum built by Sultan Abdülmecid for his father, who died "
        "in 1839, and completed in 1840. Besides Mahmud II, Sultans Abdülaziz and Abdülhamid II are buried here.\n\n"
        "Octagonal and in Empire style, the tomb stands out for its large windows and bright interior decoration. The "
        "surrounding cemetery holds the graves of many statesmen, writers and artists of the late Ottoman period, and "
        "wandering among the carved headstones is fascinating. The Column of Constantine and the Grand Bazaar are a few "
        "minutes' walk away."),

    "kanuni-sultan-suleyman-turbesi": (7,
        "Süleymaniye Camii'nin kıble tarafındaki hazirede bulunan Kanuni Sultan Süleyman Türbesi, 1566'da ölen padişah "
        "için Mimar Sinan tarafından yapıldı. Türbede Kanuni'nin yanı sıra II. Süleyman ve II. Ahmed de yatar.\n\n"
        "Sütunlu bir revakla çevrili sekizgen yapının içi, İznik çinileri, kalem işi süslemeler ve kubbeyi süsleyen "
        "değerli taşlarla Osmanlı'nın klasik döneminin en görkemli türbelerinden biridir. Hemen yakınında Hürrem "
        "Sultan'ın türbesi bulunur. Süleymaniye ziyaretine eklenmeli; ziyaret düzenini gitmeden önce kontrol edin.",
        "In the graveyard on the qibla side of the Süleymaniye Mosque, the Tomb of Suleiman the Magnificent was built by "
        "Mimar Sinan for the sultan, who died in 1566. Besides Suleiman, Suleiman II and Ahmed II are buried here.\n\n"
        "Surrounded by a colonnaded portico, the octagonal building's interior, with İznik tiles, painted decoration and "
        "precious stones in the dome, makes it one of the most magnificent tombs of the classical Ottoman era. The tomb of "
        "Hürrem Sultan is close by. Add it to a visit to the Süleymaniye; check visiting arrangements before you go."),

    "malta-kosku": (7,
        "Yıldız Parkı'nın içindeki Malta Köşkü, Sultan Abdülaziz döneminde yapıldı ve adını yapımında kullanılan, "
        "Malta'dan getirildiği anlatılan taşlardan alır. Köşk Osmanlı tarihinin bazı önemli olaylarına sahne oldu; "
        "1881'de Mithat Paşa'nın yargılandığı Yıldız Mahkemesi köşkün yakınında kurulan bir çadırda toplandı.\n\n"
        "Bugün kafe ve restoran olarak hizmet veren köşkün terasından park ağaçlarının arasından Boğaz görülür. Yıldız "
        "Parkı'nda yürüyüş yaparken mola vermek için güzel bir yerdir; Çadır Köşkü de yakındadır.",
        "Inside Yıldız Park, Malta Pavilion was built in the reign of Sultan Abdülaziz and is said to take its name from "
        "stone brought from Malta for its construction. It witnessed some important events in Ottoman history; in 1881 "
        "the Yıldız Court that tried Midhat Pasha sat in a tent set up near the pavilion.\n\n"
        "Now a café and restaurant, its terrace looks out to the Bosphorus through the park's trees. It is a lovely place "
        "to stop while walking in Yıldız Park, and Çadır Pavilion is nearby."),

    "sultan-ahmed-turbesi": (7,
        "Sultanahmet Camii'nin kuzeyinde, Sultanahmet Meydanı'na bakan Sultan Ahmed Türbesi, 1617'de ölen I. Ahmed için "
        "caminin mimarı Sedefkâr Mehmed Ağa tarafından yapıldı. Burada I. Ahmed'in yanı sıra oğulları Genç Osman ve IV. "
        "Murad da yatar.\n\n"
        "Kare planlı, kubbeli türbenin iç duvarları 17. yüzyıl İznik çinileriyle kaplıdır ve sedef kakmalı ahşap işçiliği "
        "dikkat çeker. Sultanahmet Camii ziyaretinin hemen ardından birkaç dakikada görülebilir; sessiz ve saygılı olmak "
        "gerekir.",
        "North of the Blue Mosque, facing Sultanahmet Square, the Tomb of Sultan Ahmed was built for Ahmed I, who died in "
        "1617, by Sedefkâr Mehmed Agha, the mosque's architect. Besides Ahmed I, his sons Osman II and Murad IV are buried "
        "here.\n\n"
        "The interior of the square, domed tomb is lined with 17th-century İznik tiles, and its mother-of-pearl inlaid "
        "woodwork is striking. It takes only a few minutes to see right after a visit to the Blue Mosque; visitors should "
        "be quiet and respectful."),
}
