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
    'yavuz-selim-camii': (8, "Haliç'e bakan beşinci tepede yükselen Yavuz Selim Camii, Kanuni Sultan Süleyman'ın babası I. Selim adına yaptırdığı ve 1520'lerin başında tamamlanan bir selatin camisidir. Mimarı kesin olarak bilinmez. Tek büyük kubbeli sade planı, erken klasik Osmanlı mimarisinin en yalın örneklerinden biridir.\n\nGeniş avlusu ve bahçesinden Haliç'in güzel bir manzarası açılır. Bahçede Yavuz Sultan Selim'in türbesi, şehzadeler türbesi ve Sultan Abdülmecid'in türbesi bulunur. Turist kalabalığından uzak olduğu için sakin bir ziyaret sunar. Fener ve Balat gezisiyle birleştirilebilir.",
        'Rising on the fifth hill above the Golden Horn, the Yavuz Selim Mosque is an imperial mosque built by Suleiman the Magnificent in the name of his father, Selim I, and completed in the early 1520s. Its architect is not known for certain. Its plain plan under a single great dome makes it one of the purest examples of early classical Ottoman architecture.\n\nIts wide courtyard and garden offer a fine view over the Golden Horn. The garden holds the tomb of Selim I, a tomb of princes and the tomb of Sultan Abdülmecid. Away from the tourist crowds, it makes for a quiet visit. It combines well with Fener and Balat.'),
    'yavuz-sultan-selim-turbesi': (8, "Yavuz Selim Camii'nin bahçesindeki bu türbe, 1520'de ölen I. Selim için oğlu Kanuni Sultan Süleyman tarafından yaptırıldı. Kısa saltanatında Mısır seferiyle Osmanlı topraklarını büyük ölçüde genişleten Yavuz, Osmanlı tarihinin en güçlü padişahlarından biri sayılır.\n\nSekizgen planlı türbenin girişinin iki yanındaki renkli sırlı çini panolar, İstanbul'daki erken dönem çini işçiliğinin değerli örnekleridir. Bahçedeki diğer türbeler ve Haliç manzarasıyla birlikte cami ziyaretinin doğal bir parçasıdır; sessiz ve saygılı olunmalıdır.",
        'In the garden of the Yavuz Selim Mosque, this tomb was built by Suleiman the Magnificent for his father, Selim I, who died in 1520. During his short reign Selim greatly expanded Ottoman lands with his campaign into Egypt and is counted among the most powerful Ottoman sultans.\n\nThe coloured glazed tile panels on either side of the entrance to the octagonal tomb are valuable examples of early tilework in Istanbul. Together with the other tombs in the garden and the view of the Golden Horn, it is a natural part of a visit to the mosque; visitors should be quiet and respectful.'),
    'sultan-resad-turbesi': (8, "Eyüp'teki Sultan Reşad Türbesi, 35. Osmanlı padişahı V. Mehmed Reşad için Mimar Kemaleddin Bey tarafından 1911-1912'de yapıldı. Padişah 1918'de öldüğünde buraya gömüldü; İstanbul'da gömülü son Osmanlı padişahıdır.\n\nKesme taş ve mermerden sekizgen yapı, Osmanlı ve Selçuklu öğelerini yeniden yorumlayan Birinci Ulusal Mimarlık akımının ilk örneklerindendir. İçindeki çiniler ve kalem işleri dikkat çeker. Türbenin yanında aynı mimarın tasarladığı sebil ve mektep de bulunur. Eyüp Sultan Camii'ne birkaç dakika yürüme mesafesindedir.",
        "In Eyüp, the Tomb of Sultan Reşad was built in 1911-1912 by the architect Kemaleddin Bey for Mehmed V Reşad, the 35th Ottoman sultan. He was buried here when he died in 1918, making him the last Ottoman sultan buried in Istanbul.\n\nThe octagonal building of cut stone and marble is one of the first works of the First National Architecture movement, which reinterpreted Ottoman and Seljuk forms. Its tiles and painted decoration are striking. Beside the tomb stand a fountain and a school designed by the same architect. It is a few minutes' walk from the Eyüp Sultan Mosque."),
    'yeni-valide-camii': (8, "Üsküdar'ın merkezindeki Yeni Valide Camii, II. Mustafa ve III. Ahmed'in annesi Gülnuş Emetullah Sultan için 1708-1710 yılları arasında Mimar Kayserili Mehmed Ağa tarafından yapıldı. Klasik Osmanlı mimarisinden Lale Devri zevkine geçişin izlerini taşıyan bir külliyenin merkezidir.\n\nBahçesindeki Gülnuş Sultan türbesinin üstü kubbe yerine demir bir kafesle örtülüdür; anlatıldığına göre valide sultan, mezarına yağmur ve güneş değmesini istemişti. Caminin sebili ve çeşmesi de zarif örneklerdir. Üsküdar Meydanı ve iskelesine birkaç dakika uzaklıktadır.",
        "In the centre of Üsküdar, the Yeni Valide Mosque was built between 1708 and 1710 by the architect Kayserili Mehmed Agha for Gülnuş Emetullah Sultan, mother of Mustafa II and Ahmed III. It is the heart of a complex showing the transition from classical Ottoman architecture to the taste of the Tulip Era.\n\nGülnuş Sultan's tomb in the garden is covered not by a dome but by an iron cage; she is said to have wished for rain and sun to reach her grave. The mosque's fountain and water kiosk are fine examples too. Üsküdar Square and pier are a few minutes away."),
    'binbirdirek-sarnici': (8, "Sultanahmet'teki Binbirdirek Sarnıcı, 4. yüzyılda yapıldığı bilinen ve Filoksenos Sarnıcı diye de anılan bir Bizans su deposudur. 224 sütunu ve 3.500 metrekareyi aşan alanıyla Yerebatan'dan sonra şehrin en büyük kapalı sarnıcıdır.\n\nİki sütunun üst üste bindirilmesiyle yükselen sütunları yapıya büyük bir yükseklik verir. Sarnıç zamanla kurudu ve Osmanlı döneminde ipek ipliği atölyesi olarak kullanıldı. Bugün sergi ve etkinliklere ev sahipliği yaptığından ziyaret düzeni değişebilir, gitmeden önce kontrol edin. Yerebatan'a göre çok daha sakindir.",
        "In Sultanahmet, the Cistern of a Thousand and One Columns, also known as the Cistern of Philoxenos, is a Byzantine reservoir dating to the 4th century. With 224 columns and an area of over 3,500 square metres, it is the city's largest covered cistern after the Basilica Cistern.\n\nIts columns, each made of two shafts stacked one on top of the other, give the space great height. The cistern dried up over time and in the Ottoman period served as a silk-thread workshop. Today it hosts exhibitions and events, so visiting arrangements can change; check before you go. It is far quieter than the Basilica Cistern."),
    'sakip-sabanci-muzesi': (8, "Emirgan'da Boğaz'a bakan Sakıp Sabancı Müzesi, 2002'de açıldı. Uzun süre Sabancı ailesinin evi olan ve bahçesindeki at heykeli nedeniyle Atlı Köşk diye anılan yapı ile ona eklenen modern galerilerde hizmet verir.\n\nKalıcı koleksiyonunda Osmanlı hat sanatı, kitap sanatları ve 19.-20. yüzyıl resimleri bulunur. Müze özellikle Picasso, Rodin ve Dalí gibi ustaların eserlerini getiren büyük uluslararası sergileriyle tanınır. Boğaz manzaralı bahçesi ve kafesi ziyareti keyifli kılar. Emirgan Korusu da hemen yanındadır.",
        'Overlooking the Bosphorus in Emirgan, the Sakıp Sabancı Museum opened in 2002. It occupies the Atlı Köşk, for many years the Sabancı family home and named after the horse statue in its garden, along with modern galleries added beside it.\n\nIts permanent collection covers Ottoman calligraphy, the arts of the book and 19th-20th-century painting. The museum is best known for major international exhibitions that have brought the work of masters such as Picasso, Rodin and Dalí. Its garden and café with Bosphorus views make the visit a pleasure. Emirgan Park is right next door.'),
    '500-yil-vakfi-turk-musevileri-muzesi': (8, "Karaköy'deki 500. Yıl Vakfı Türk Musevileri Müzesi 2001'de açıldı. Sefarad Yahudilerinin 1492'de İspanya'dan sürülerek Osmanlı topraklarına yerleşmesinin 500. yılını kutlamak için kurulan vakfın girişimiyle oluşturuldu.\n\nMüze, Türkiye'deki Yahudi toplumunun yüzyıllara yayılan tarihini ve gündelik hayatını belgeler, fotoğraflar ve eşyalarla anlatır; etnografya bölümünde düğün kıyafetleri ve gelenekler tanıtılır. Güvenlik nedeniyle girişte kimlik istenebilir; ziyaret koşullarını gitmeden önce kontrol edin.",
        'In Karaköy, the Quincentennial Foundation Museum of Turkish Jews opened in 2001. It was created by a foundation set up to mark the 500th anniversary of the arrival of Sephardic Jews in Ottoman lands after their expulsion from Spain in 1492.\n\nThe museum tells the centuries-long history and daily life of the Jewish community in Turkey through documents, photographs and objects; the ethnography section presents wedding dress and traditions. For security, ID may be required at the entrance; check visiting conditions before you go.'),
    'adile-sultan-sarayi': (8, "Anadolu yakasında Kandilli sırtlarındaki Adile Sultan Sarayı, Sultan Abdülmecid'in kız kardeşi Adile Sultan'a armağan olarak Sarkis Balyan'a yaptırıldı. 1916'dan sonra uzun yıllar Kandilli Kız Lisesi olarak kullanıldı ve 1986'da çıkan yangında büyük hasar gördü.\n\nKapsamlı bir restorasyonun ardından 2007'de yeniden açılan yapı bugün kültür merkezi olarak etkinliklere ev sahipliği yapar. Tepedeki konumundan Boğaz'ın ve karşı kıyının geniş bir manzarası görülür. Ziyarete açık olduğu zamanlar etkinliklere göre değiştiğinden gitmeden önce kontrol edin.",
        "On the heights of Kandilli on the Asian shore, the Adile Sultan Palace was built by Sarkis Balyan as a gift from Sultan Abdülmecid to his sister Adile Sultan. From 1916 it served for many years as Kandilli Girls' High School and was badly damaged by fire in 1986.\n\nReopened in 2007 after extensive restoration, it now hosts events as a cultural centre. From its hilltop position it commands wide views of the Bosphorus and the opposite shore. Its opening times depend on events, so check before you go."),
    'cinili-kosk': (8, "Topkapı Sarayı'nın dış bahçesindeki Çinili Köşk, giriş kitabesine göre 1472'de Fatih Sultan Mehmed tarafından yaptırıldı ve İstanbul'da günümüze ulaşan en eski Osmanlı sivil yapılarından biridir. Fatih'in bahçede yaptırdığı farklı üsluptaki köşklerden ayakta kalan tek örnektir ve belirgin İran etkileri taşır.\n\nAdını giriş eyvanını süsleyen firuze ve lacivert çinilerden alır. Bugün İstanbul Arkeoloji Müzeleri'nin bir parçası olarak Selçuklu ve Osmanlı dönemlerine ait çini ve seramik eserleri sergiler. Arkeoloji Müzesi ziyaretiyle aynı biletle görülebilir.",
        'In the outer garden of Topkapı Palace, the Tiled Kiosk was built by Mehmed II in 1472, according to its entrance inscription, and is one of the oldest surviving Ottoman civil buildings in Istanbul. It is the only one left of the pavilions in different styles that Mehmed built in the garden and shows strong Persian influence.\n\nIt takes its name from the turquoise and dark-blue tiles adorning its entrance iwan. Today, as part of the Istanbul Archaeology Museums, it displays Seljuk and Ottoman tiles and ceramics. It can be seen on the same ticket as the Archaeology Museum.'),
    'emirgan-korusu': (8, "Boğaz'ın Avrupa kıyısında Emirgan sırtlarına yayılan Emirgan Korusu, İstanbul'un en büyük ve en sevilen kent parklarından biridir. 17. yüzyılda IV. Murad'ın Emirgüneoğlu Yusuf Paşa'ya armağan ettiği arazi, 19. yüzyılda Mısır Hidivi İsmail Paşa'nın elindeyken bugünkü düzenine kavuştu.\n\nKorunun içinde kafe ve restoran olarak hizmet veren Sarı, Pembe ve Beyaz köşkler bulunur. Nisan ayında düzenlenen Lale Festivali'nde koru milyonlarca laleyle rengârenk olur ve en kalabalık dönemini yaşar. Göletler ve yürüyüş yolları hafta içi sakin bir gezinti sunar.",
        "Spreading across the hills of Emirgan on the European shore of the Bosphorus, Emirgan Park is one of Istanbul's largest and best-loved city parks. Granted by Murad IV to Emirgüneoğlu Yusuf Pasha in the 17th century, the land took its present layout in the 19th century under Khedive İsmail Pasha of Egypt.\n\nInside the park are the Yellow, Pink and White pavilions, now cafés and restaurants. During the Tulip Festival in April the park bursts into colour with millions of tulips and sees its busiest days. Its ponds and walking paths offer a quiet stroll on weekdays."),
    'istanbul-deniz-muzesi': (9, "Beşiktaş iskelesinin yanındaki İstanbul Deniz Müzesi, Deniz Kuvvetleri Komutanlığı'na bağlı olarak hizmet veren ve kökleri 1897'ye uzanan Türkiye'nin en büyük denizcilik müzesidir. Koleksiyonunda yaklaşık 20.000 eser bulunur; 2013'te modern bir binaya taşınmıştır.\n\nMüzenin en etkileyici bölümü, padişahların Boğaz'da kullandığı saltanat kayıklarının sergilendiği salondur. Osmanlı donanmasına ait haritalar, silahlar, gemi modelleri ve Barbaros Hayreddin Paşa ile ilgili eserler de görülebilir. Hemen yanındaki parkta Barbaros'un türbesi ve heykeli bulunur.",
        "Beside the Beşiktaş pier, the Istanbul Naval Museum is Turkey's largest maritime museum, run by the Naval Forces Command with roots going back to 1897. Its collection numbers around 20,000 items, and in 2013 it moved into a modern building.\n\nIts most impressive section is the hall of imperial caiques that the sultans used on the Bosphorus. Maps, weapons and ship models of the Ottoman navy and objects relating to Admiral Barbaros Hayreddin Pasha can also be seen. The park right beside it holds Barbaros's tomb and statue."),
    'maslak-kasri': (9, "Maslak'ta, Büyükdere Caddesi'nin kenarındaki geniş korunun içinde yer alan Maslak Kasırları, 19. yüzyılda padişahların av ve dinlenme için kullandığı köşklerden oluşur. Bugünkü yapılar büyük ölçüde Sultan Abdülaziz dönemine aittir; II. Abdülhamid de şehzadeliğinde burada vakit geçirmiştir.\n\nKasr-ı Hümayun, Mabeyn Köşkü, Limonluk ve Çadır Köşkü gibi yapılar, gökdelenlerle çevrili bir bölgede beklenmedik sakinlikte bir koru içinde dağılmıştır. Milli Saraylar'a bağlı müze olarak hizmet verir; ziyaret günleri değişebileceğinden gitmeden önce kontrol edin.",
        'In Maslak, inside a large wooded grounds beside Büyükdere Avenue, the Maslak Pavilions are a group of 19th-century kiosks the sultans used for hunting and rest. The present buildings mostly date from the reign of Sultan Abdülaziz; Abdülhamid II also spent time here as a prince.\n\nBuildings such as the Imperial Pavilion, the Mabeyn Kiosk, the Orangery and the Tent Kiosk are scattered through a grove of unexpected calm in a district surrounded by skyscrapers. It is run as a museum by the National Palaces administration; opening days can change, so check before you go.'),
    'meryem-ana-kilisesi': (9, "Ayvansaray'daki Vlaherna Meryem Ana Kilisesi ve ayazması, Bizans'ın en kutsal yerlerinden biri sayılan bir Meryem Ana kilisesinin bulunduğu yerdedir. İlk kilise 5. yüzyılda yapılmış ve Meryem Ana'ya ait olduğuna inanılan kutsal emanetleri barındırmıştır. Bu büyük kilise 15. yüzyılda bir yangında yok oldu; bugünkü küçük kilise 19. yüzyılda yapıldı.\n\nYüksek duvarlarla çevrili sakin avludaki ayazma, hâlâ ziyaretçilerin şifa aradığı bir su kaynağıdır. İçerideki ikonalar ve duvar resimleri görülmeye değer. İbadet yeri olduğu için uygun giyinilmeli ve sessiz olunmalıdır. Balat ve Fener'e yürüme mesafesindedir.",
        "In Ayvansaray, the Church of St Mary of Blachernae and its holy spring stand on the site of one of Byzantium's most sacred churches of the Virgin. The first church was built in the 5th century and housed relics believed to belong to the Virgin Mary. That great church was lost to fire in the 15th century; the present small church dates from the 19th century.\n\nThe holy spring in the quiet courtyard, enclosed by high walls, is still a source where visitors seek healing. The icons and wall paintings inside are worth seeing. As a place of worship it calls for modest dress and quiet. Balat and Fener are within walking distance."),
    'mihrimah-sultan-camii-uskudar': (9, "Üsküdar iskelesinin hemen karşısındaki Mihrimah Sultan Camii, Kanuni Sultan Süleyman'ın kızı Mihrimah Sultan için Mimar Sinan tarafından 1548'de yapıldı ve Sinan'ın erken dönem eserlerindendir. Halk arasında İskele Camii diye de anılır.\n\nYüksek bir set üzerine oturan cami, ön cephesindeki geniş son cemaat yeri ve şadırvanıyla meydana hâkimdir; kubbesi üç yandan yarım kubbelerle desteklenir. Rivayete göre Edirnekapı'daki Mihrimah Sultan Camii ile arasında güneşin batışı ve ayın doğuşuna dair romantik bir hikâye anlatılır. Vapurdan inince ilk görülen yapılardan biridir.",
        "Right across from the Üsküdar pier, the Mihrimah Sultan Mosque was built by Mimar Sinan in 1548 for Mihrimah Sultan, daughter of Suleiman the Magnificent, and is one of Sinan's early works. Locals also call it the Pier Mosque.\n\nRaised on a high terrace, the mosque dominates the square with its broad front portico and fountain; its dome is supported by half-domes on three sides. Legend links it with the Mihrimah Sultan Mosque at Edirnekapı through a romantic story about the setting of the sun and the rising of the moon. It is one of the first buildings you see as you step off the ferry."),
    'orme-dikilitas': (9, "Sultanahmet Meydanı'nın güney ucundaki Örme Dikilitaş, yaklaşık 32 metre yüksekliğinde, kaba kesme taştan örülmüş bir anıttır. Yapım tarihi kesin olarak bilinmez; 10. yüzyılda İmparator VII. Konstantinos tarafından onarıldığını belirten bir yazıt taşır.\n\nBir zamanlar yüzeyi yaldızlı bronz levhalarla kaplıydı; bu levhalar 1204'te Haçlılar tarafından sökülüp götürüldü ve bugün taşlardaki tutturma delikleri hâlâ görülebilir. Hipodrom'un orta setinde, Dikilitaş ve Yılanlı Sütun ile aynı çizgide durur.",
        'At the southern end of Sultanahmet Square, the Walled Obelisk is a monument about 32 metres high built of roughly cut stone. Its construction date is not known for certain; an inscription records its restoration by Emperor Constantine VII in the 10th century.\n\nIt was once sheathed in gilded bronze plates, which were stripped away by the Crusaders in 1204, and the holes that held them can still be seen in the stones. It stands on the central spine of the Hippodrome, in line with the Obelisk of Theodosius and the Serpent Column.'),
    'kilic-ali-pasa-camii': (9, "Tophane'deki Kılıç Ali Paşa Camii, Osmanlı donanmasının kaptan-ı deryası Kılıç Ali Paşa için Mimar Sinan tarafından yapıldı ve 1580 civarında tamamlandı. Sinan'ın ileri yaşındaki eserlerindendir ve planı Ayasofya'nın küçültülmüş bir yorumu gibidir.\n\nKülliyedeki türbe, medrese ve hamam da korunmuştur; restore edilen Kılıç Ali Paşa Hamamı bugün yeniden hizmet verir. Cami Karaköy ile Tophane arasındaki sahile yakın olduğundan İstanbul Modern ve Galataport gezisine kolayca eklenebilir.",
        "In Tophane, the Kılıç Ali Pasha Mosque was built by Mimar Sinan for Kılıç Ali Pasha, grand admiral of the Ottoman fleet, and completed around 1580. One of the works of Sinan's later years, its plan reads like a scaled-down interpretation of Hagia Sophia.\n\nThe tomb, madrasa and bath of the complex also survive; the restored Kılıç Ali Pasha Bath is in use again today. Close to the waterfront between Karaköy and Tophane, the mosque is an easy addition to a visit to Istanbul Modern and Galataport."),
    'milyon-tasi': (9, "Ayasofya'nın karşısında, Yerebatan Sarnıcı'nın yakınında duran Milyon Taşı, 4. yüzyılda dikilen ve Bizans İmparatorluğu'nda tüm yol mesafelerinin ölçüldüğü başlangıç noktasıdır. Roma'daki altın mil taşının karşılığı olarak düşünülmüştür.\n\nÖzgün anıt, üzeri kubbeli, dört yöne açılan görkemli bir kemerli yapıydı; bugün ondan yalnızca mermer bir sütun parçası kalmıştır. Sultanahmet'te Ayasofya ile Yerebatan arasında yürürken birkaç dakikalık bir durak olarak görülebilir.",
        "Opposite Hagia Sophia, near the Basilica Cistern, the Milion stone was set up in the 4th century as the zero point from which all road distances in the Byzantine Empire were measured. It was conceived as the counterpart of Rome's Golden Milestone.\n\nThe original monument was an imposing domed arch opening on four sides; today only a fragment of a marble pillar remains. It makes a stop of a few minutes while walking between Hagia Sophia and the Basilica Cistern in Sultanahmet."),
    'yoros-kalesi': (9, "Anadolu Kavağı'nın üzerindeki tepede, Boğaz'ın Karadeniz'e açıldığı noktaya hâkim olan Yoros Kalesi, Bizans döneminde Boğaz'ı denetlemek için yapılmış bir kaledir. Daha sonra uzun süre Cenevizlilerin elinde kaldığı için halk arasında Ceneviz Kalesi diye de bilinir.\n\nSurların kalıntıları arasından Karadeniz'in girişi, Boğaz'ın iki yakası ve Yavuz Sultan Selim Köprüsü görülür; manzara özellikle gün batımında etkileyicidir. Köyden yokuşlu bir yolla yürünerek çıkılır. Kazı çalışmaları nedeniyle bazı bölümlere giriş kısıtlanabilir; aşağıdaki balık restoranları da bilinen bir duraktır.",
        'On the hill above Anadolu Kavağı, commanding the point where the Bosphorus opens to the Black Sea, Yoros Castle was built in the Byzantine period to control the strait. Because it was later held for a long time by the Genoese, it is popularly known as the Genoese Castle.\n\nFrom among the ruins of its walls you can see the entrance to the Black Sea, both shores of the Bosphorus and the Yavuz Sultan Selim Bridge; the view is especially striking at sunset. It is reached on foot by a steep path from the village. Excavation work may restrict access to some parts, and the fish restaurants below are a well-known stop.'),
    'neve-salom-sinagogu': (9, "Galata'daki Neve Şalom Sinagogu 1951'de açıldı ve İstanbul'un en büyük sinagogudur. Adı İbranice 'barış vahası' anlamına gelir. Şehrin Yahudi toplumunun dini ve toplumsal hayatında önemli bir yere sahiptir.\n\nGeniş ibadet salonu ve büyük avizesiyle dikkat çeker. Sinagogda 1986 ve 2003'te düzenlenen saldırılarda hayatını kaybedenler anılır. Güvenlik nedeniyle ziyaretler önceden başvuru ve kimlik kontrolüyle yapılır; koşulları gitmeden önce kontrol edin. Galata Kulesi'ne birkaç dakika uzaklıktadır.",
        "In Galata, the Neve Shalom Synagogue opened in 1951 and is Istanbul's largest synagogue. Its name means 'oasis of peace' in Hebrew. It holds an important place in the religious and community life of the city's Jewish community.\n\nIt is notable for its spacious prayer hall and great chandelier. The synagogue commemorates those who lost their lives in the attacks of 1986 and 2003. For security, visits require advance application and an ID check; check the conditions before you go. Galata Tower is a few minutes away."),
    'saint-esprit-kilisesi': (9, "Harbiye'de Cumhuriyet Caddesi üzerindeki Saint Esprit Katedrali, 1846'da ibadete açılan bir Latin Katolik katedralidir. Mimarı, Ayasofya'nın 19. yüzyıldaki restorasyonunu da yapan İsviçreli mimar Gaspare Fossati'dir.\n\nNotre Dame de Sion Lisesi'nin avlusundaki kilisenin sakin iç mekânı, yüksek sütunları ve vitraylarıyla barok canlandırmacı bir atmosfer taşır. Avludaki Papa XV. Benedictus heykeli, Birinci Dünya Savaşı sırasındaki yardım çalışmaları anısına dikilmiştir. Ayin saatlerinde sessiz olunmalıdır. Taksim'e kısa yürüme mesafesindedir.",
        'On Cumhuriyet Avenue in Harbiye, the Cathedral of the Holy Spirit is a Latin Catholic cathedral opened for worship in 1846. It was designed by the Swiss architect Gaspare Fossati, who also carried out the 19th-century restoration of Hagia Sophia.\n\nSet in the courtyard of the Notre Dame de Sion school, the church has a calm interior in Baroque Revival style, with tall columns and stained glass. The statue of Pope Benedict XV in the courtyard was raised in memory of his relief work during the First World War. Visitors should be quiet during Mass. It is a short walk from Taksim.'),
    'sakirin-camii': (10, "Üsküdar'da, Karacaahmet Mezarlığı'nın girişindeki Şakirin Camii 2009'da ibadete açıldı. Şakir ailesi tarafından yaptırılan caminin mimarı Hüsrev Tayla, iç mekân tasarımcısı ise Zeynep Fadıllıoğlu'dur; Türkiye'de iç tasarımını bir kadının yaptığı ilk cami olarak bilinir.\n\nAlüminyum kaplı kubbesi, cam cepheleri ve damla biçimli dev avizesiyle klasik cami mimarisini çağdaş malzemelerle yeniden yorumlar. Pirinç kafes işçiliği ve sade iç mekânı özellikle mimarlık meraklılarının ilgisini çeker. İbadet saatlerinde ziyaretçilerin saygılı olması beklenir.",
        'In Üsküdar, at the entrance to Karacaahmet Cemetery, the Şakirin Mosque opened for worship in 2009. Commissioned by the Şakir family, it was designed by the architect Hüsrev Tayla, with interiors by Zeynep Fadıllıoğlu; it is known as the first mosque in Turkey whose interior was designed by a woman.\n\nWith its aluminium-clad dome, glass façades and huge drop-shaped chandelier, it reinterprets classical mosque architecture in contemporary materials. Its brass lattice work and clean interior especially attract architecture lovers. Visitors are expected to be respectful during prayer times.'),
    'taksim-cumhuriyet-aniti': (10, "Taksim Meydanı'nın ortasındaki Cumhuriyet Anıtı, İtalyan heykeltıraş Pietro Canonica tarafından yapıldı ve 8 Ağustos 1928'de açıldı. Kaidesi ve çevre düzeni, St. Antuan Kilisesi'nin de mimarı olan Giulio Mongeri'ye aittir.\n\nAnıtın iki yüzü vardır: bir yanda Kurtuluş Savaşı'na önderlik eden Atatürk ve silah arkadaşları, diğer yanda Cumhuriyet'in kuruluşu ve yeni devletin önderleri tasvir edilir. Taksim Meydanı, İstiklal Caddesi'nin başlangıç noktası ve şehrin en önemli buluşma yerlerinden biri olduğu için anıt kolayca görülebilir.",
        "In the middle of Taksim Square, the Republic Monument was made by the Italian sculptor Pietro Canonica and unveiled on 8 August 1928. Its base and surroundings were designed by Giulio Mongeri, also the architect of St Anthony's Church.\n\nThe monument has two faces: one shows Atatürk and his comrades leading the War of Independence, the other the founding of the Republic and the leaders of the new state. As Taksim Square is the starting point of İstiklal Avenue and one of the city's main meeting places, the monument is easy to see."),
    'arkadios-sutunu': (10, "Cerrahpaşa'daki Arkadios Sütunu, İmparator Arkadios'un Gotlara karşı kazanılan zaferi anmak için 5. yüzyılın başında diktirdiği bir zafer sütunuydu. Roma'daki Traianus Sütunu gibi gövdesini sarmal kabartmalar sarıyordu. Halk arasında Avrat Taşı diye bilinir.\n\nDepremlerde zarar gören sütun 18. yüzyılın başında yıkılma tehlikesi nedeniyle indirildi; bugün yalnızca evlerin arasında kalmış kaidesi görülebilir. İçinde sütunun tepesine çıkan merdivenin başlangıcı korunmuştur. Genellikle yalnızca dışarıdan görülebildiği için kısa bir durak olarak düşünülmelidir.",
        "In Cerrahpaşa, the Column of Arcadius was a victory column raised by Emperor Arcadius in the early 5th century to commemorate a victory over the Goths. Like Trajan's Column in Rome, its shaft was wrapped in spiral reliefs. Locally it is known as Avrat Taşı.\n\nDamaged by earthquakes, the column was taken down in the early 18th century because it threatened to collapse; today only its base survives, squeezed between houses. Inside, the start of the staircase that once led to the top is preserved. It can usually only be seen from outside, so plan it as a short stop."),
    'asiyan-muzesi': (10, "Rumelihisarı'nın üstündeki yamaçta, Boğaz'a bakan Aşiyan Müzesi, şair Tevfik Fikret'in 1906-1915 yılları arasında yaşadığı evdir. Planlarını şairin kendisinin çizdiği ahşap ev, 1945'ten bu yana müze olarak hizmet verir. Adı Farsçada 'kuş yuvası' anlamına gelir.\n\nEvde Tevfik Fikret ve ailesine ait eşyalar ile Edebiyat-ı Cedide döneminin önemli yazar ve şairlerine ait eserler sergilenir; şairin mezarı da bahçededir. Bahçeden ve üst kattan Boğaz'ın en güzel manzaralarından biri görülür. Rumeli Hisarı gezisine eklenebilir; ziyaret günlerini önceden kontrol edin.",
        "On the slope above Rumelihisarı overlooking the Bosphorus, the Aşiyan Museum is the house where the poet Tevfik Fikret lived from 1906 to 1915. The wooden house, which the poet designed himself, has been a museum since 1945. Its name means 'bird's nest' in Persian.\n\nIt displays belongings of Tevfik Fikret and his family, along with items of leading writers and poets of the Edebiyat-ı Cedide movement; the poet's grave is in the garden. From the garden and upper floor there is one of the loveliest views of the Bosphorus. It can be added to a visit to Rumeli Fortress; check opening days in advance."),
    'fethipasa-korusu': (10, "Üsküdar'da Kuzguncuk ile Paşalimanı arasındaki yamaçta uzanan Fethipaşa Korusu, adını 19. yüzyıl Osmanlı devlet adamı Fethi Ahmed Paşa'dan alır. Uzun yıllar bakımsız kaldıktan sonra yenilenerek halka açık bir parka dönüştürüldü.\n\nAğaçlık yamaçtaki yürüyüş yolları ve teraslardan Boğaz, köprü ve karşı kıyının geniş bir manzarası görülür. İçindeki kafe ve çay bahçeleri hafta sonları kahvaltı için sevilen yerlerdir. Kuzguncuk'un renkli sokaklarıyla aynı gezide birleştirilebilir.",
        'On the hillside between Kuzguncuk and Paşalimanı in Üsküdar, Fethipaşa Grove takes its name from the 19th-century Ottoman statesman Fethi Ahmed Pasha. After years of neglect it was renovated and turned into a public park.\n\nIts walking paths and terraces on the wooded slope offer wide views of the Bosphorus, the bridge and the opposite shore. The cafés and tea gardens inside are popular for weekend breakfasts. It combines well with the colourful streets of Kuzguncuk.'),
    'galata-mevlevihanesi-muzesi': (10, "Tünel'e yakın Galip Dede Caddesi'ndeki Galata Mevlevihanesi, 1491'de kurulan ve İstanbul'daki ilk Mevlevi tekkesi olan yapıdır. Bugünkü semahane 18. yüzyılın sonunda III. Selim döneminde yeniden inşa edildi. Tekke, tekkelerin kapatıldığı 1925'e kadar Mevlevi kültürünün şehirdeki merkezlerinden biriydi.\n\nBugün müze olan yapıda sekizgen ahşap semahane, Mevlevi müziğinde kullanılan çalgılar, kıyafetler ve el yazmaları sergilenir. Bahçedeki hazirede şair Şeyh Galib'in türbesi ve matbaacı İbrahim Müteferrika'nın mezarı bulunur. Belirli günlerde sema gösterileri yapılır; programı önceden kontrol edin.",
        "On Galip Dede Avenue near Tünel, the Galata Mevlevi Lodge was founded in 1491 and was the first Mevlevi lodge in Istanbul. The present ceremonial hall was rebuilt at the end of the 18th century under Selim III. Until the lodges were closed in 1925, it was one of the city's centres of Mevlevi culture.\n\nNow a museum, it displays the octagonal wooden hall where the whirling ceremony was held, along with instruments of Mevlevi music, garments and manuscripts. The graveyard holds the tomb of the poet Şeyh Galib and the grave of the printer İbrahim Müteferrika. Whirling ceremonies are held on certain days; check the programme in advance."),
    'kayis-dagi': (10, "Anadolu yakasında, Ataşehir ve Maltepe sınırındaki Kayış Dağı, yaklaşık 438 metre yüksekliğiyle Aydos Tepesi ve Alemdağ'dan sonra İstanbul'un en yüksek noktalarından biridir. Yamaçları büyük ölçüde ormanla kaplıdır.\n\nOrmanlık alandaki yürüyüş yolları ve mesire yerleri, hafta sonu doğa yürüyüşü ve piknik için şehre yakın bir seçenek sunar. Açık havada tepeden Marmara Denizi, Adalar ve Anadolu yakasının geniş bir manzarası görülür. Rahat ayakkabı ve su almak iyi olur.",
        "On the Asian side, on the border of Ataşehir and Maltepe, Kayışdağı rises to about 438 metres, making it one of the highest points in Istanbul after Aydos Hill and Alemdağ. Its slopes are largely forested.\n\nThe trails and picnic areas in the forest offer a close-to-the-city option for weekend hikes and picnics. On clear days the summit gives wide views over the Sea of Marmara, the Princes' Islands and the Asian side. Comfortable shoes and water are a good idea."),
    'moda-sahili': (10, "Kadıköy'ün Moda semtinde, burnun çevresinde uzanan Moda Sahili, Anadolu yakasının en sevilen deniz kenarı yürüyüş yerlerinden biridir. Semt, 19. yüzyılda Levanten ailelerin köşkleriyle gelişmiş, bugün kafeleri, dondurmacıları ve canlı sokaklarıyla tanınır.\n\nSahildeki çay bahçeleri ve çimenlik alanlar, karşıda Tarihi Yarımada'nın siluetiyle özellikle gün batımında çok kalabalık olur. Kadıköy çarşısından nostaljik tramvayla ya da sahil boyunca yürüyerek gelinebilir. Moda iskelesi ve Yoğurtçu Parkı da yakındadır.",
        "Curving around the point in Kadıköy's Moda district, the Moda shore is one of the best-loved seaside promenades on the Asian side. The neighbourhood grew in the 19th century with the mansions of Levantine families and is known today for its cafés, ice-cream shops and lively streets.\n\nThe tea gardens and lawns along the shore, facing the skyline of the historic peninsula, get very busy, especially at sunset. You can come from the Kadıköy market by the nostalgic tram or on foot along the shore. Moda pier and Yoğurtçu Park are nearby."),
    'rahmi-m-koc-muzesi': (10, "Haliç kıyısında, Hasköy'deki Rahmi M. Koç Müzesi, 1994'te açılan ve Türkiye'de sanayi, ulaşım ve iletişim tarihine adanan ilk büyük müzedir. Bizans temelleri üzerine kurulmuş Osmanlı dönemi Lengerhane binası ile eski Hasköy tersanesinde hizmet verir.\n\nBuharlı trenler, eski otomobiller, uçaklar, tekneler, mekanik oyuncaklar ve bilimsel aletler arasında saatlerce gezilebilir; ziyaret edilebilen bir denizaltı da koleksiyonun parçasıdır. Çocuklu aileler için İstanbul'un en keyifli müzelerinden biridir. Haliç kıyısındaki kafe ve restoranları mola için uygundur.",
        "On the Golden Horn in Hasköy, the Rahmi M. Koç Museum opened in 1994 as Turkey's first major museum devoted to the history of industry, transport and communications. It occupies the Ottoman-era Lengerhane, an anchor foundry built on Byzantine foundations, and the former Hasköy shipyard.\n\nYou can spend hours among steam trains, vintage cars, aircraft, boats, mechanical toys and scientific instruments; a submarine you can go inside is also part of the collection. It is one of Istanbul's most enjoyable museums for families with children. Its waterfront café and restaurants are good for a break."),
    'serefiye-sarnici': (10, "Divanyolu'nun hemen yakınındaki Şerefiye Sarnıcı, 5. yüzyılda İmparator II. Theodosius döneminde yapılan ve Theodosius Sarnıcı diye de bilinen bir Bizans su deposudur. Mermer başlıklı 32 sütun üzerinde yükselen tonozlarıyla küçük ama etkileyici bir yapıdır.\n\nUzun yıllar bir binanın altında kalan sarnıç kapsamlı bir restorasyonun ardından 2018'de ziyarete açıldı. Sütunlar arasında yapılan ışık ve görüntü gösterileri ziyareti farklı kılar. Yerebatan'a göre çok daha az kalabalıktır ve Binbirdirek Sarnıcı ile aynı gezide görülebilir.",
        'Just off Divanyolu, the Şerefiye Cistern is a Byzantine reservoir built in the 5th century under Emperor Theodosius II and also known as the Cistern of Theodosius. With vaults rising on 32 columns with marble capitals, it is small but impressive.\n\nHidden beneath a building for many years, the cistern opened to visitors in 2018 after extensive restoration. Light and projection shows among the columns make the visit distinctive. It is much less crowded than the Basilica Cistern and can be seen on the same walk as the Cistern of a Thousand and One Columns.'),
    'askeri-muze': (11, "Harbiye'deki Askeri Müze, Osmanlı ordusuna subay yetiştiren Mekteb-i Harbiye'nin 19. yüzyıldan kalma binasında yer alır. Mustafa Kemal Atatürk de bu okulda öğrenim görmüştür. Türkiye'nin en kapsamlı askeri tarih müzelerinden biridir.\n\nMüzede Osmanlı ve Cumhuriyet dönemlerine ait silahlar, zırhlar, üniformalar, sancaklar ve padişahların sefer çadırları sergilenir; Atatürk'ün okuduğu sınıf da korunmuştur. Belirli saatlerde verilen mehter konserleri ziyaretin en sevilen bölümüdür; program ve ziyaret günlerini önceden kontrol edin.",
        "In Harbiye, the Military Museum occupies the 19th-century building of the Mekteb-i Harbiye, the academy that trained officers for the Ottoman army. Mustafa Kemal Atatürk also studied here. It is one of Turkey's most comprehensive museums of military history.\n\nIt displays weapons, armour, uniforms and banners from the Ottoman and Republican periods, as well as the sultans' campaign tents; the classroom where Atatürk studied is preserved. The Ottoman military band (mehter) concerts held at certain times are the favourite part of a visit; check the programme and opening days in advance."),
    'aydos-tepesi': (11, "Anadolu yakasında, Kartal, Pendik, Sultanbeyli ve Sancaktepe arasındaki Aydos Tepesi, 537 metreyle İstanbul'un en yüksek noktasıdır. Adını tepede kalıntıları bulunan, Roma ve Bizans dönemlerine ait Aydos Kalesi'nden alır.\n\nÇevresindeki Aydos Ormanı yürüyüş ve piknik için geniş alanlar sunar. Açık havada tepeden Marmara Denizi, Adalar ve Anadolu yakasının panoraması görülür. Kalenin kazı çalışmaları nedeniyle bazı bölümlere erişim kısıtlanabilir; rahat ayakkabı ve su almak iyi olur.",
        "On the Asian side, between Kartal, Pendik, Sultanbeyli and Sancaktepe, Aydos Hill is Istanbul's highest point at 537 metres. It takes its name from Aydos Castle, a Roman and Byzantine fortress whose ruins stand near the top.\n\nThe surrounding Aydos Forest offers plenty of space for walking and picnics. On clear days the summit gives a panorama of the Sea of Marmara, the Princes' Islands and the Asian side. Excavation work at the castle may restrict access to some parts; comfortable shoes and water are a good idea."),
    'balikli-meryem-ana-rum-manastiri': (11, "Kara surlarının dışında, Silivrikapı yakınındaki Balıklı Meryem Ana Rum Manastırı, 6. yüzyılda İmparator Justinianus döneminde kutsal bir su kaynağının üzerine kurulan bir manastırın yerindedir. Bugünkü kilise 1835'te yeniden inşa edildi.\n\nKilisenin altındaki ayazmada yüzen balıklar yere adını verir; anlatılan efsaneye göre 1453'te şehrin düştüğü haberi geldiğinde tavada kızartılan balıklar suya atlayıp canlanmıştır. Avludaki mezarlıkta Rum Ortodoks patriklerinin mezarları bulunur. İbadet yeri olduğu için uygun giyinilmelidir.",
        "Outside the land walls near Silivrikapı, the Greek Orthodox Monastery of St Mary of the Spring stands on the site of a monastery founded over a holy spring in the 6th century under Emperor Justinian. The present church was rebuilt in 1835.\n\nThe fish swimming in the holy spring beneath the church give the place its Turkish name; legend says that when news of the city's fall came in 1453, fish frying in a pan leapt into the water and came back to life. The cemetery in the courtyard holds the graves of Orthodox patriarchs. As a place of worship it calls for modest dress."),
    'florya-ataturk-deniz-kosku': (11, "Florya sahilinde denizin üzerine kurulan Atatürk Deniz Köşkü, İstanbul Belediyesi tarafından Atatürk'e armağan edilmek üzere mimar Seyfi Arkan'a yaptırıldı ve 1935'te tamamlandı. Atatürk yaz aylarında burada dinlenmiş ve çalışmıştır.\n\nKazıklar üzerinde denize uzanan ve kıyıya bir iskeleyle bağlanan yapı, erken Cumhuriyet döneminin modernist mimarisinin önemli örneklerindendir. 1993'ten bu yana müze olarak hizmet verir ve özgün eşyalarıyla korunur. Ziyaret günleri değişebileceğinden gitmeden önce kontrol edin.",
        'Built over the sea on the Florya shore, the Atatürk Sea Pavilion was commissioned by the Istanbul municipality from the architect Seyfi Arkan as a gift to Atatürk and completed in 1935. Atatürk rested and worked here in the summer months.\n\nStanding on piles over the water and joined to the shore by a pier, it is an important example of early Republican modernist architecture. It has been a museum since 1993 and is preserved with its original furnishings. Opening days can change, so check before you go.'),
    'kanli-kilise': (11, "Fener'in yokuşlarındaki Kanlı Kilise, Moğolların Meryem'i (Mouhliotissa) adıyla bilinen bir Bizans kilisesidir. 13. yüzyılın sonunda, bir Moğol hanıyla evlendirilen İmparatorluk prensesi Maria Palaiologina tarafından yeniden kuruldu.\n\nFetihten sonra camiye çevrilmeden Rum Ortodoks cemaatine bırakılan tek Bizans kilisesi olarak bilinir. 'Kanlı' adının, fetih sırasında bu tepede yaşanan çatışmalardan geldiği anlatılır. Yüksek duvarların arkasındaki kilisenin ziyareti sınırlı olabilir; Fener ve Balat gezisi sırasında kapı açıksa uğrayın.",
        'On the slopes of Fener, the Church of St Mary of the Mongols (Mouchliotissa) is a Byzantine church refounded in the late 13th century by the imperial princess Maria Palaiologina, who had been married to a Mongol khan.\n\nIt is known as the only Byzantine church in the city never converted into a mosque after the conquest, remaining with the Greek Orthodox community. Its Turkish name, the Bloody Church, is said to come from fighting on this hill during the conquest. Behind high walls, it may have limited access; drop by if the gate is open during a walk through Fener and Balat.'),
    'muze-gazhane': (11, "Kadıköy Hasanpaşa'daki Müze Gazhane, 1892'de Anadolu yakasına havagazı sağlamak için kurulan tarihi gazhanenin yapılarında yer alır. Doğal gazın gelmesiyle 1993'te kapanan tesis, uzun bir dönüşüm sürecinin ardından 2021'de kültür merkezi olarak açıldı.\n\nEski fırınlar, bacalar ve gaz depoları; iklim müzesi, karikatür müzesi, sergi salonları, kütüphane ve kafelere dönüştürülmüştür. Endüstriyel mimarisi fotoğrafçıların ilgisini çeker; konserler ve festivaller düzenlenir. Programı önceden kontrol edin. Yoğurtçu Parkı ve Moda'ya yakındır.",
        'In Hasanpaşa, Kadıköy, Müze Gazhane occupies the buildings of the historic gasworks built in 1892 to supply gas to the Asian side. Closed in 1993 with the arrival of natural gas, it reopened as a cultural centre in 2021 after a long transformation.\n\nIts old furnaces, chimneys and gas holders have become a climate museum, a cartoon museum, exhibition halls, a library and cafés. Its industrial architecture draws photographers, and it hosts concerts and festivals. Check the programme in advance. It is close to Yoğurtçu Park and Moda.'),
    'sveti-stefan-kilisesi': (11, "Balat ile Fener arasında Haliç kıyısındaki Sveti Stefan Kilisesi, Bulgar Ortodoks cemaatine aittir ve halk arasında Demir Kilise diye bilinir. Bugünkü yapı, Viyana'da üretilip parçalar halinde getirilen döküm demir elemanlarla kurulmuş ve 1898'de tamamlanmıştır.\n\nDünyada önceden üretilmiş demir parçalarla kurulan sayılı kiliselerden biridir; neo-Gotik cephesi ve altın yaldızlı iç süslemeleriyle dikkat çeker. Yedi yıllık restorasyonun ardından 2018'de yeniden açıldı. Haliç sahilindeki parkın içinde olduğundan Balat yürüyüşüne kolayca eklenebilir.",
        "On the Golden Horn between Balat and Fener, St Stephen's Church belongs to the Bulgarian Orthodox community and is popularly known as the Iron Church. The present building was assembled from cast-iron parts made in Vienna and shipped in pieces, and was completed in 1898.\n\nIt is one of the few churches in the world built from prefabricated iron parts, and stands out for its neo-Gothic façade and gilded interior. It reopened in 2018 after seven years of restoration. Set in the waterfront park, it is an easy addition to a walk around Balat."),
    'kiztasi': (11, "Fatih'te, Saraçhane yakınındaki bir meydanda duran Kıztaşı, Bizans İmparatoru Markianos onuruna 5. yüzyılın ortasında dikilen bir anıt sütundur. Bizans döneminden büyük ölçüde sağlam ulaşan az sayıdaki imparatorluk anıtından biridir.\n\nGranit gövdesinin kaidesinde kanatlı zafer tanrıçası Nike'ların kabartmaları bulunur; sütunun Türkçe adının bu kadın figürlerinden geldiği düşünülür. Mahallenin içinde kısa bir durak olarak görülebilir; Fatih Camii ve Bozdoğan Kemeri'ne yürüme mesafesindedir.",
        "In Fatih, standing in a small square near Saraçhane, the Column of Marcian was raised in honour of the Byzantine Emperor Marcian in the mid-5th century. It is one of the few imperial monuments from the Byzantine era to survive largely intact.\n\nThe base of its granite shaft bears reliefs of winged Victories (Nike), and the column's Turkish name, the 'Maiden's Stone', is thought to come from these female figures. It makes a short stop in the neighbourhood and is within walking distance of the Fatih Mosque and the Valens Aqueduct."),
    'buyuk-camlica-tepesi': (11, "Üsküdar'daki Büyük Çamlıca Tepesi, Anadolu yakasının şehre en yakın ve en bilinen seyir tepelerinden biridir. Osmanlı döneminde de mesire yeri olarak sevilen tepe, 1980'lerde Turing'in başkanı Çelik Gülersoy tarafından düzenlenerek çay bahçeleriyle yeniden halka kazandırıldı.\n\nTepeden Boğaz'ın iki yakası, köprüler, Tarihi Yarımada ve Marmara Denizi geniş bir panorama halinde görülür; manzara özellikle gün batımında ve açık havalarda etkileyicidir. Yakındaki Çamlıca Kulesi ve Büyük Çamlıca Camii ile aynı gezide görülebilir.",
        'In Üsküdar, Büyük Çamlıca Hill is one of the best-known viewpoints on the Asian side close to the city centre. Already a favourite excursion spot in Ottoman times, it was landscaped with tea gardens and given back to the public in the 1980s by Çelik Gülersoy, head of the Touring Club.\n\nFrom the top you see both shores of the Bosphorus, the bridges, the historic peninsula and the Sea of Marmara in a wide panorama, especially striking at sunset and on clear days. It can be combined with the nearby Çamlıca Tower and the Grand Çamlıca Mosque.'),
    'gotlar-sutunu': (11, "Gülhane Parkı'nın Sarayburnu ucunda, ağaçların arasında duran Gotlar Sütunu, şehirde Roma döneminden kalan en eski anıtlardan biridir. Yaklaşık 18,5 metre yüksekliğindeki mermer sütunun 3. ya da 4. yüzyılda dikildiği düşünülür.\n\nKaidesindeki Latince yazıt, Gotlara karşı kazanılan bir zaferi anar ve sütun adını buradan alır. Korint başlığı hâlâ yerindedir. Gülhane Parkı'nda Boğaz'a bakan çay bahçesine doğru yürürken kolayca görülebilir.",
        'At the Sarayburnu end of Gülhane Park, standing among the trees, the Column of the Goths is one of the oldest Roman-era monuments in the city. The marble column, about 18.5 metres high, is thought to have been erected in the 3rd or 4th century.\n\nThe Latin inscription on its base commemorates a victory over the Goths, which gives the column its name. Its Corinthian capital is still in place. It is easy to see while walking through Gülhane Park towards the tea garden overlooking the Bosphorus.'),
    'iii-ahmed-cesmesi': (12, "Topkapı Sarayı'nın Bab-ı Hümayun kapısı ile Ayasofya arasındaki meydanda duran III. Ahmed Çeşmesi, 1728'de Lale Devri'nde yapıldı. Osmanlı mimarisinde rokoko etkisinin en güzel örneklerinden biri olarak kabul edilir.\n\nDört cephesinde birer çeşme, köşelerinde ise gelip geçene su dağıtılan şebekeli sebiller bulunur. Mermer yüzeyleri çiçek, meyve ve vazo motifleriyle kaplıdır; saçağın altındaki şiir kitabeleri arasında padişahın kendi beyitleri de yer alır. Topkapı Sarayı'na girerken birkaç dakika durup incelemeye değer.",
        'In the square between the Imperial Gate of Topkapı Palace and Hagia Sophia, the Fountain of Ahmed III was built in 1728, during the Tulip Era. It is considered one of the finest examples of rococo influence in Ottoman architecture.\n\nEach of its four sides has a fountain, and at the corners are grilled kiosks where water was once handed out to passers-by. Its marble surfaces are covered with flowers, fruit and vases, and the verse inscriptions beneath the eaves include couplets by the sultan himself. It is worth pausing a few minutes to study it on the way into Topkapı Palace.'),
    'istanbul-askenaz-sinagogu': (12, "Galata Kulesi'ne inen Yüksek Kaldırım yokuşundaki Aşkenaz Sinagogu, Avusturya-Macaristan'dan İstanbul'a yerleşen Aşkenaz Yahudileri tarafından 1900'de açıldı. Şehirde Aşkenaz cemaatinin kurduğu sinagoglardan ayakta kalan tek örnektir.\n\nAvrupa üslubundaki cephesi, yokuştaki dükkânların arasında dikkat çeker; iç mekânda ahşap Ehal ve galeriler bulunur. İbadete açık bir sinagog olduğundan ziyaret için önceden izin ve kimlik kontrolü gerekebilir; koşulları gitmeden önce kontrol edin.",
        'On the Yüksek Kaldırım slope leading down from Galata Tower, the Ashkenazi Synagogue was opened in 1900 by Ashkenazi Jews who had settled in Istanbul from Austria-Hungary. It is the only one still standing of the synagogues the Ashkenazi community founded in the city.\n\nIts European-style façade stands out among the shops on the slope, and inside are a wooden Torah ark and galleries. As a working synagogue, visits may require prior permission and an ID check; check the conditions before you go.'),
    'polonezkoy-tabiat-parki': (12, "Beykoz'un ormanları içindeki Polonezköy, 1842'de Polonyalı göçmenler tarafından kurulan bir köydür; 1994'te çevresiyle birlikte tabiat parkı ilan edildi. Köyün Polonya kökenli geçmişi kilisesinde, mezarlığında ve eski evlerinde hâlâ hissedilir.\n\nOrmanlık alandaki yürüyüş ve bisiklet yolları, dere kenarları ve piknik alanları şehirden kaçmak isteyenler için idealdir. Köydeki kahvaltı mekânları ve ev yapımı reçeller hafta sonları çok ilgi görür. Toplu taşımayla ulaşım sınırlı olduğundan yolculuğu önceden planlayın.",
        "In the forests of Beykoz, Polonezköy is a village founded in 1842 by Polish émigrés; in 1994 it was declared a nature park together with its surroundings. The village's Polish past can still be felt in its church, cemetery and old houses.\n\nIts forest walking and cycling trails, streams and picnic areas are ideal for escaping the city. The village's breakfast spots and homemade jams are very popular at weekends. Public transport is limited, so plan your journey in advance."),
    'ahrida-sinagogu': (12, "Balat'taki Ahrida Sinagogu, 15. yüzyılın başlarında, bugün Kuzey Makedonya'da bulunan Ohri'den gelen Romanyot Yahudiler tarafından kuruldu ve adını bu şehirden alır. İstanbul'un en eski ve kapasitesi en büyük sinagoglarından biridir.\n\nEn dikkat çekici bölümü, ortadaki gemi pruvası biçimli ahşap tevadır; Nuh'un gemisini ya da İspanya'dan gelen Yahudileri taşıyan gemileri simgelediği anlatılır. İbadete açık bir sinagog olduğundan ziyaret için önceden izin gerekir; koşulları gitmeden önce kontrol edin.",
        "In Balat, the Ahrida Synagogue was founded in the early 15th century by Romaniote Jews from Ohrid, now in North Macedonia, and takes its name from that city. It is one of the oldest synagogues in Istanbul and the one with the largest capacity.\n\nIts most striking feature is the central wooden reading platform shaped like the prow of a ship, said to symbolise Noah's Ark or the ships that carried Jews from Spain. As a working synagogue it requires permission to visit; check the conditions before you go."),
    'alman-cesmesi': (12, "Sultanahmet Meydanı'nın kuzey ucundaki Alman Çeşmesi, Alman İmparatoru II. Wilhelm'in 1898'deki İstanbul ziyaretinin anısına Sultan II. Abdülhamid'e armağanıdır. Almanya'da üretilen parçalar İstanbul'a getirilerek 1900'lerin başında yerine kuruldu.\n\nSekizgen planlı, neo-Bizans üslubundaki çeşmenin kubbesinin içi altın yaldızlı mozaiklerle kaplıdır; mozaiklerde iki hükümdarın monogramları görülür. Sultanahmet Camii ile Ayasofya arasında yürürken kolayca görülebilir.",
        'At the northern end of Sultanahmet Square, the German Fountain was a gift from the German Emperor Wilhelm II to Sultan Abdülhamid II, commemorating his visit to Istanbul in 1898. Its parts were made in Germany, shipped to Istanbul and assembled in the early 1900s.\n\nThe interior of the dome of this octagonal, neo-Byzantine fountain is covered with gilded mosaics bearing the monograms of the two rulers. It is easy to see while walking between the Blue Mosque and Hagia Sophia.'),
    'aya-triada-kilisesi': (12, "Taksim Meydanı'nın hemen yanında, İstiklal Caddesi'nin başındaki Aya Triada Kilisesi, 1880'de açılan ve İstanbul'un en büyük Rum Ortodoks kiliselerinden biri olan yapıdır. Kubbesi ve iki çan kulesi Taksim'in siluetinin bir parçasıdır.\n\nNeo-barok üsluptaki kilisenin iç mekânı, ikonaları, avizeleri ve süslü ikonostasisiyle oldukça gösterişlidir. Kapı açık olduğunda ziyaret edilebilir; ibadet yeri olduğundan uygun giyinilmeli ve sessiz olunmalıdır. İstiklal Caddesi yürüyüşüne başlarken kısa bir durak olarak uygundur.",
        'Right beside Taksim Square at the top of İstiklal Avenue, the Hagia Triada Church opened in 1880 and is one of the largest Greek Orthodox churches in Istanbul. Its dome and twin bell towers are part of the Taksim skyline.\n\nThe interior of this neo-baroque church is lavish, with its icons, chandeliers and ornate iconostasis. It can be visited when the gate is open; as a place of worship it calls for modest dress and quiet. It makes a short stop at the start of a walk down İstiklal Avenue.'),
    'sadberk-hanim-muzesi': (12, "Sarıyer Büyükdere'de, Boğaz kıyısındaki tarihi yalılarda yer alan Sadberk Hanım Müzesi, 1980'de açılan Türkiye'nin ilk özel müzesidir. Adını, koleksiyonu oluşturan Vehbi Koç'un eşi Sadberk Koç'tan alır.\n\nArkeoloji bölümünde Neolitik dönemden Bizans'a uzanan Anadolu eserleri, Türk-İslam bölümünde ise İznik çinileri, Osmanlı kıyafetleri, işlemeler ve gümüş eşyalar sergilenir. Sakin ve zengin bir koleksiyonu olan müze, Boğaz'ın kuzey köylerine yapılacak bir geziye güzel bir durak olur. Ziyaret günlerini önceden kontrol edin.",
        "In Büyükdere, Sarıyer, set in historic waterside mansions on the Bosphorus, the Sadberk Hanım Museum opened in 1980 as Turkey's first private museum. It is named after Sadberk Koç, wife of Vehbi Koç, who built up the collection.\n\nIts archaeology section covers Anatolian works from the Neolithic to the Byzantine era, while the Turkish-Islamic section displays İznik tiles, Ottoman costume, embroidery and silverware. A quiet museum with a rich collection, it makes a fine stop on a trip to the villages of the upper Bosphorus. Check opening days in advance."),
    'istanbul-islam-bilim-ve-teknoloji-muzesi': (12, "Gülhane Parkı'ndaki tarihi Has Ahırlar binasında 2008'de açılan İslam Bilim ve Teknoloji Tarihi Müzesi, bilim tarihçisi Prof. Dr. Fuat Sezgin'in öncülüğünde kuruldu. 9. ile 16. yüzyıllar arasında İslam dünyasında yapılan bilimsel çalışmaları tanıtır.\n\nAstronomi, coğrafya, tıp, optik, kimya ve mekanik alanlarındaki aletlerin ve haritaların yüzlerce modeli sergilenir; usturlaplar ve su saatleri en ilgi çekenlerdir. Çocuklu aileler ve bilim meraklıları için öğreticidir. Gülhane Parkı yürüyüşüyle birleştirilebilir.",
        'Opened in 2008 in the historic royal stables building in Gülhane Park, the Museum of the History of Science and Technology in Islam was founded under the leadership of the historian of science Prof. Fuat Sezgin. It presents scientific work done in the Islamic world between the 9th and 16th centuries.\n\nHundreds of models of instruments and maps from astronomy, geography, medicine, optics, chemistry and mechanics are on display, with astrolabes and water clocks among the most fascinating. It is instructive for families and science lovers. It combines well with a walk through Gülhane Park.'),
    'macka-demokrasi-parki': (12, 'Dolmabahçe, Maçka, Nişantaşı ve Harbiye arasındaki vadiye yayılan Maçka Demokrasi Parkı, şehrin merkezindeki en büyük yeşil alanlardan biridir. Havuzları, çimenlikleri ve ulu ağaçlarıyla çevredeki yoğun semtlerin nefes alma noktasıdır.\n\nParkın üzerinden geçen Maçka-Taşkışla teleferiği kısa ama keyifli bir manzara yolculuğu sunar. Kafe ve çay bahçeleri, çocuk oyun alanları ve yürüyüş yolları hafta sonları çok kullanılır. Nişantaşı alışverişi ya da Dolmabahçe gezisiyle kolayca birleştirilebilir.',
        'Spreading through the valley between Dolmabahçe, Maçka, Nişantaşı and Harbiye, Maçka Democracy Park is one of the largest green spaces in the city centre. With its pools, lawns and great trees, it is a breathing space for the dense districts around it.\n\nThe Maçka-Taşkışla cable car passing over the park offers a short but enjoyable ride with a view. Its cafés, tea gardens, playgrounds and paths are busy at weekends. It combines easily with shopping in Nişantaşı or a visit to Dolmabahçe.'),
    'rumeli-feneri': (12, "Boğaz'ın Karadeniz'e açıldığı noktada, Avrupa yakasının en kuzey ucundaki Rumeli Feneri, 19. yüzyılın ortasında yapılan ve bugün de çalışan bir deniz feneridir. Karşı kıyıdaki Anadolu Feneri ile birlikte Boğaz'ın girişini işaretler.\n\nFenerle aynı adı taşıyan balıkçı köyü, küçük limanı, balık restoranları ve kayalık sahilleriyle sakin bir kaçış noktasıdır. Köyün üstündeki tepeden Karadeniz'in ve Yavuz Sultan Selim Köprüsü'nün manzarası görülür. Şehir merkezinden uzak olduğu için ulaşımı önceden planlayın.",
        'At the point where the Bosphorus opens to the Black Sea, at the northernmost tip of the European side, Rumeli Feneri is a lighthouse built in the mid-19th century and still in service. Together with Anadolu Feneri on the opposite shore, it marks the entrance to the strait.\n\nThe fishing village that shares its name, with its small harbour, fish restaurants and rocky shore, is a quiet escape. From the hill above the village there are views of the Black Sea and the Yavuz Sultan Selim Bridge. It is far from the city centre, so plan your transport in advance.'),
    'adalar-muzesi': (13, "Büyükada'daki Adalar Müzesi, İstanbul 2010 Avrupa Kültür Başkenti kapsamında açıldı ve İstanbul'un ilk çağdaş kent müzesi olarak bilinir. Adalar Vakfı ile Adalar Belediyesi'nin iş birliğiyle kuruldu.\n\nMüze, Prens Adaları'nın Bizans döneminden günümüze uzanan tarihini, adalarda birlikte yaşayan toplulukları, sayfiye hayatını ve adaların doğasını fotoğraflar, belgeler ve gündelik eşyalarla anlatır. Ziyaret koşulları değişebildiğinden gitmeden önce kontrol edin.",
        "On Büyükada, the Islands Museum opened as part of Istanbul's year as European Capital of Culture in 2010 and is known as Istanbul's first contemporary city museum. It was created through a partnership between the Islands Foundation and the Islands municipality.\n\nThrough photographs, documents and everyday objects, the museum tells the history of the Princes' Islands from Byzantine times to today, the communities who lived together there, summer-resort life and the islands' nature. Visiting arrangements can change, so check before you go."),
    'ataturk-arboretumu': (13, "Sarıyer'de Bahçeköy yakınında, Belgrad Ormanı'nın doğal bitki örtüsü içinde kurulan Atatürk Arboretumu, ağaç ve odunsu bitkilerin bilimsel amaçla sergilendiği geniş bir alandır. Dünyanın farklı bölgelerinden binlerce bitki türüne ev sahipliği yapar.\n\nGöletler etrafında dolaşan patikalar, özellikle sonbaharda yaprakların renk değiştirdiği dönemde fotoğrafçıların gözdesidir. Bitkileri korumak için ziyaretçi sayısı, piknik ve fotoğraf çekimiyle ilgili kurallar uygulanır. Giriş koşullarını gitmeden önce kontrol edin.",
        'In Sarıyer near Bahçeköy, set within the natural woodland of Belgrad Forest, the Atatürk Arboretum is a large area where trees and woody plants are displayed for scientific purposes. It is home to thousands of plant species from around the world.\n\nIts paths winding around ponds are a favourite with photographers, especially in autumn when the leaves change colour. To protect the plants, rules apply to visitor numbers, picnics and photography. Check the entry conditions before you go.'),
    'galata-surp-krikor-lusavoric-kilisesi': (13, "Karaköy'deki Surp Krikor Lusavoriç Kilisesi, kökleri 14. yüzyılın sonuna, Galata'nın Ceneviz dönemine uzanan bir Ermeni Apostolik kilisesidir. Eski kilise 1950'lerde yol genişletme çalışmaları sırasında yıkıldı; bugünkü yapı yakın bir yerde, geleneksel Ermeni kilise mimarisine göre yeniden inşa edildi.\n\nAdını Ermenileri Hristiyanlığa geçiren Aydınlatıcı Aziz Grigor'dan alır. Taş cephesi ve konik kubbesiyle Karaköy'ün kalabalığı içinde kendine özgü bir görünüm sunar. İbadete açık olduğundan kapı açıksa sessizce ziyaret edilebilir.",
        'In Karaköy, the Church of St Gregory the Illuminator is an Armenian Apostolic church whose roots go back to the late 14th century, when Galata was a Genoese colony. The old church was demolished in the 1950s during road widening; the present building was rebuilt nearby following traditional Armenian church architecture.\n\nIt is named after St Gregory the Illuminator, who brought Christianity to the Armenians. With its stone façade and conical dome, it has a distinctive look amid the bustle of Karaköy. As a working church, it can be visited quietly when the gate is open.'),
    'sile-kalesi': (13, "Şile sahilinin hemen açığındaki Ocaklı Ada üzerinde duran Şile Kalesi, Karadeniz kıyısını gözetlemek için yapılmış küçük bir kaledir. En yaygın görüşe göre 14. yüzyılda Cenevizliler tarafından inşa edildi.\n\n2015'teki restorasyonunun ardından aldığı görünüm tartışma yaratsa da, deniz üzerindeki konumuyla Şile'nin simgelerinden biridir. Kalenin karşısındaki kıyıdan ve yakındaki Şile Feneri'nden gün batımında güzel fotoğraflar çekilir. Şile'nin plajları ve ünlü Şile bezi dükkânlarıyla birlikte gezilebilir.",
        "Just off the Şile shore on Ocaklı Island, Şile Castle is a small fortress built to watch over the Black Sea coast. According to the most widely accepted view, it was built by the Genoese in the 14th century.\n\nAlthough its look after the 2015 restoration caused controversy, its position on the sea makes it one of Şile's symbols. The shore opposite the castle and the nearby Şile lighthouse are great spots for sunset photos. It combines well with Şile's beaches and its shops selling the famous Şile cloth."),
    'falih-rifki-atay-tabiat-parki': (13, "Sarıyer'de Belgrad Ormanı içinde bulunan Falih Rıfkı Atay Tabiat Parkı, 2011'de ormandaki tabiat parklarından biri olarak düzenlendi. Adını gazeteci, yazar ve siyasetçi Falih Rıfkı Atay'dan alır.\n\nAğaçlar arasındaki yürüyüş ve bisiklet yolları, gölet kenarları ve piknik alanları şehrin gürültüsünden uzak bir gün geçirmek için uygundur. Hafta sonları kalabalık olabilir; giriş koşulları ve piknik kurallarını gitmeden önce kontrol edin. Belgrad Ormanı'ndaki diğer parklarla birleştirilebilir.",
        "Inside Belgrad Forest in Sarıyer, Falih Rıfkı Atay Nature Park was established in 2011 as one of the forest's nature parks. It is named after the journalist, writer and politician Falih Rıfkı Atay.\n\nIts walking and cycling trails among the trees, pond-side spots and picnic areas are ideal for a day away from the city's noise. It can get busy at weekends; check entry conditions and picnic rules before you go. It combines with the forest's other parks."),
    'goztepe-60-yil-parki': (13, "Kadıköy'de Bağdat Caddesi ile Operatör Cemil Topuzlu Caddesi arasında uzanan Göztepe 60. Yıl Parkı, Anadolu yakasının en çok kullanılan kent parklarından biridir. Park 2013'te yenilenerek bugünkü haline kavuştu.\n\nGeniş çimenlikleri, göleti ve yürüyüş yollarıyla aileler için idealdir; nisan ayında çiçek açan laleler parkı rengârenk yapar. Bağdat Caddesi'nde alışveriş ya da Caddebostan sahilinde yürüyüş yaparken mola vermek için uygun bir yerdir.",
        'In Kadıköy, stretching between Bağdat Avenue and Operatör Cemil Topuzlu Avenue, Göztepe 60th Anniversary Park is one of the most used city parks on the Asian side. It was renovated in 2013 into its current form.\n\nWith its wide lawns, pond and walking paths it is ideal for families, and the tulips blooming in April fill it with colour. It is a good place for a break while shopping on Bağdat Avenue or walking along the Caddebostan shore.'),
    'kilyos-plaji': (13, "Sarıyer'in Karadeniz kıyısındaki Kilyos, geniş kumsallarıyla İstanbul'un Avrupa yakasındaki en bilinen sahil beldelerinden biridir. Yaz aylarında şehirden kaçmak isteyenler için gözde bir plaj durağıdır.\n\nPlajların bir kısmı işletmeler tarafından düzenlenmiştir ve şezlong, duş gibi hizmetler sunar. Karadeniz'de dalgalar ve akıntılar zaman zaman çok tehlikeli olabilir; yalnızca cankurtaran bulunan ve yüzmenin serbest olduğu alanlarda denize girin, uyarı bayraklarına dikkat edin. Hafta sonları yoğun trafiğe hazırlıklı olun.",
        "On Sarıyer's Black Sea coast, Kilyos is one of the best-known seaside resorts on Istanbul's European side, with wide sandy beaches. In summer it is a favourite beach escape from the city.\n\nSome of the beaches are run by businesses offering sunbeds, showers and other services. Waves and currents on the Black Sea can at times be very dangerous; swim only where lifeguards are present and swimming is allowed, and watch the warning flags. Expect heavy traffic at weekends."),
    'mihrabat-tabiat-parki': (13, "Beykoz'da Kanlıca'nın üzerindeki tepede bulunan Mihrabat Tabiat Parkı, yaklaşık 20 hektarlık bir korudur ve 2011'de tabiat parkı ilan edildi. Çoğunluğu yaprak döken ağaçlardan oluşan zengin bir bitki örtüsüne sahiptir.\n\nBoğaz'a hâkim konumundan Fatih Sultan Mehmet Köprüsü ve karşı kıyının geniş manzarası görülür; gün batımında özellikle güzeldir. Piknik alanları ve yürüyüş yollarıyla sakin bir hafta sonu durağıdır. Kanlıca'nın ünlü yoğurduyla aynı gezide birleştirilebilir.",
        "On the hill above Kanlıca in Beykoz, Mihrabat Nature Park is a grove of about 20 hectares declared a nature park in 2011. It has rich vegetation made up mostly of deciduous trees.\n\nFrom its position over the Bosphorus there are wide views of the Fatih Sultan Mehmet Bridge and the opposite shore, especially lovely at sunset. With picnic areas and walking paths, it is a quiet weekend stop. It combines well with Kanlıca's famous yoghurt."),
    'florya-ataturk-kent-ormani': (13, "Bakırköy'ün Florya semtindeki Atatürk Kent Ormanı, yaklaşık 54 hektarlık bir alana yayılan büyük bir kent ormanıdır. 2021'de yapılan ekolojik restorasyonla doğal malzemeden yürüyüş yolları ve dinlenme alanları düzenlendi.\n\nAğaçlar arasındaki patikalar, koşu ve yürüyüş için şehrin Avrupa yakasının batısında sakin bir seçenek sunar. Hemen yakınındaki Florya sahili ve Atatürk Deniz Köşkü ile aynı gezide görülebilir. Piknik ve giriş kurallarını gitmeden önce kontrol edin.",
        'In the Florya district of Bakırköy, the Atatürk Urban Forest is a large city woodland covering about 54 hectares. An ecological restoration in 2021 added walking paths of natural materials and rest areas.\n\nIts trails among the trees offer a quiet option for running and walking on the western side of the European shore. It can be combined with the nearby Florya shore and the Atatürk Sea Pavilion. Check picnic and entry rules before you go.'),
    'yogurtcu-parki': (13, "Kadıköy'de Kurbağalıdere boyunca uzanan Yoğurtçu Parkı, semtin en eski ve en sevilen parklarından biridir. Kurbağalıdere'nin denize döküldüğü bölgeye kadar uzanan park, Moda ile Fenerbahçe arasındaki yürüyüş rotasının bir parçasıdır.\n\nUlu ağaçların gölgesindeki çay bahçeleri, çocuk oyun alanları ve dere kenarındaki yürüyüş yolları gün boyu canlıdır. Yakındaki Müze Gazhane ve Moda sahiliyle aynı gezide birleştirilebilir; Kalamış'a kadar sahil boyunca yürümek de mümkündür.",
        "In Kadıköy, running along the Kurbağalıdere stream, Yoğurtçu Park is one of the district's oldest and best-loved parks. Stretching down to where the stream meets the sea, it forms part of the walking route between Moda and Fenerbahçe.\n\nIts tea gardens under great trees, playgrounds and streamside paths are lively all day. It combines well with the nearby Müze Gazhane and the Moda shore, and you can walk along the coast to Kalamış."),
    'garipce-kalesi': (14, "Boğaz'ın Karadeniz'e açıldığı noktada, Avrupa yakasındaki Garipçe köyünün üzerinde duran Garipçe Kalesi, 18. yüzyılın ikinci yarısında III. Mustafa döneminde Boğaz'ın girişini korumak için yapıldı. Yapımında Osmanlı hizmetindeki Fransız subay Baron de Tott'un rol aldığı bilinir.\n\nKayalıklar üzerindeki kale kalıntılarından Karadeniz'in girişi, karşı kıyı ve Yavuz Sultan Selim Köprüsü görülür. Aşağıdaki küçük balıkçı köyü, kahvaltı ve balık restoranlarıyla sakin bir mola yeri sunar. Kayalıklarda dikkatli yürüyün; şehirden uzak olduğu için ulaşımı önceden planlayın.",
        'At the point where the Bosphorus opens to the Black Sea, above the village of Garipçe on the European shore, Garipçe Castle was built in the second half of the 18th century under Mustafa III to guard the entrance to the strait. The French officer Baron de Tott, then in Ottoman service, is known to have played a role in building it.\n\nFrom the castle ruins on the rocks you see the mouth of the Black Sea, the opposite shore and the Yavuz Sultan Selim Bridge. The small fishing village below, with breakfast and fish restaurants, offers a quiet stop. Walk carefully on the rocks; it is far from the city, so plan your transport in advance.'),
    'turhan-sultan-turbesi': (14, "Eminönü'de Yeni Cami'nin hemen yanındaki Turhan Sultan Türbesi, 1663'te Sultan İbrahim'in eşi ve IV. Mehmed'in annesi Turhan Hatice Sultan için yapıldı. Yarım kalan Yeni Cami'yi tamamlatan da odur.\n\nTürbede Turhan Sultan'ın yanı sıra IV. Mehmed, II. Mustafa, III. Ahmed, I. Mahmud ve III. Osman olmak üzere beş padişah yatar; bu yönüyle İstanbul'un en kalabalık padişah türbelerinden biridir. Mısır Çarşısı'nın girişine çok yakın olduğundan Eminönü gezisi sırasında kısa bir durak olarak görülebilir; sessiz ve saygılı olunmalıdır.",
        'In Eminönü, right beside the New Mosque, the Tomb of Turhan Sultan was built in 1663 for Turhan Hatice Sultan, consort of Sultan İbrahim and mother of Mehmed IV. She was also the one who completed the unfinished New Mosque.\n\nBesides Turhan Sultan, five sultans lie here: Mehmed IV, Mustafa II, Ahmed III, Mahmud I and Osman III, making it one of the most crowded imperial tombs in Istanbul. Very close to the entrance of the Spice Bazaar, it makes a short stop during a walk around Eminönü; visitors should be quiet and respectful.'),
    'bebek-parki': (14, "Boğaz'ın en güzel koylarından birinde, Bebek sahilindeki Bebek Parkı, 18. yüzyılda Hümayunabad Kasrı'nın bahçesiydi. Sabancı Vakfı'nın yenilemesinin ardından 2008'den bu yana Türkan Sabancı Bebek Parkı adını taşır.\n\nAğaçlar altındaki banklar ve çimenlik alanlardan Bebek koyunun ve demirli teknelerin manzarası görülür. Hemen yanında Mimar Kemaleddin'in tasarladığı Bebek Camii bulunur. Sahildeki kafeler ve Arnavutköy'e uzanan yürüyüş yolu ile birlikte keyifli bir Boğaz günü geçirilebilir.",
        'On one of the loveliest bays of the Bosphorus, Bebek Park on the Bebek waterfront was the garden of the Hümayunabad Pavilion in the 18th century. Since a renovation by the Sabancı Foundation it has been called Türkan Sabancı Bebek Park, from 2008.\n\nIts benches under the trees and lawns look out over Bebek bay and the moored boats. Right beside it stands the Bebek Mosque designed by the architect Kemaleddin. Together with the waterfront cafés and the promenade towards Arnavutköy, it makes for a pleasant Bosphorus day.'),
    'nakkastepe-millet-bahcesi': (14, "Üsküdar'da Kuzguncuk ile Altunizade arasındaki sırtlarda bulunan Nakkaştepe Millet Bahçesi, Boğaz'a bakan geniş bir kent parkıdır. Yakın dönemde millet bahçesi olarak düzenlenerek halka açıldı.\n\nGeniş çimenlikleri, yürüyüş yolları ve seyir noktalarından 15 Temmuz Şehitler Köprüsü, Boğaz'ın iki yakası ve karşı kıyıdaki siluet görülür; manzara özellikle gün batımında güzeldir. Piknik ve aile gezileri için uygundur. Aşağıdaki Kuzguncuk sokaklarıyla aynı gezide birleştirilebilir.",
        "On the hills between Kuzguncuk and Altunizade in Üsküdar, Nakkaştepe Nation's Garden is a large city park overlooking the Bosphorus. It was recently landscaped as a nation's garden and opened to the public.\n\nFrom its wide lawns, paths and viewpoints you see the 15 July Martyrs Bridge, both shores of the Bosphorus and the skyline opposite; the view is especially beautiful at sunset. It is good for picnics and family outings. It combines well with the streets of Kuzguncuk below."),
    'sile-feneri': (14, "Şile'de denize bakan yüksek bir burunda duran Şile Feneri, Osmanlı döneminde 19. yüzyılın ortasında, Fransız asıllı Mişel Paşa'nın yönettiği Fenerler İdaresi tarafından yapıldı. Türkiye'nin en büyük deniz fenerlerinden biri olarak bilinir ve bugün de çalışır.\n\nSekizgen taş kulesi Karadeniz kıyısında uzaktan seçilir. Çevresinden Şile Kalesi, Ocaklı Ada ve Şile'nin kumsalları görülür; gün batımı için güzel bir noktadır. Fenerin içinin ziyaret koşulları değişebildiğinden gitmeden önce kontrol edin.",
        "On a high headland overlooking the sea at Şile, Şile Lighthouse was built in the mid-19th century, in Ottoman times, by the Lighthouse Administration run by the French-born Michel Pasha. It is known as one of the largest lighthouses in Turkey and is still in service.\n\nIts octagonal stone tower can be seen from far along the Black Sea coast. From around it you see Şile Castle, Ocaklı Island and Şile's beaches; it is a fine spot for sunset. Visiting arrangements for the interior can change, so check before you go."),
    'anadolu-feneri': (14, "Boğaz'ın Karadeniz'e açıldığı noktada, Anadolu yakasının kuzey ucundaki Yum Burnu'nda duran Anadolu Feneri, 19. yüzyılın ortasında yapıldı ve bugün de çalışır. Karşı kıyıdaki Rumeli Feneri ile birlikte Boğaz'ın girişini işaretler.\n\nFenerle aynı adı taşıyan küçük köy, Karadeniz'e bakan yamaçları ve sakin havasıyla şehirden kaçmak için güzel bir yerdir. Çevrede askeri alanlar bulunduğundan bazı bölümlere giriş kısıtlıdır; tabelalara dikkat edin. Ulaşım ve erişim koşullarını gitmeden önce kontrol edin.",
        'At the point where the Bosphorus opens to the Black Sea, on Yum Point at the northern tip of the Asian side, Anadolu Lighthouse was built in the mid-19th century and is still in service. Together with Rumeli Lighthouse on the opposite shore, it marks the entrance to the strait.\n\nThe small village of the same name, with its slopes facing the Black Sea and its calm atmosphere, is a lovely escape from the city. There are military zones in the area, so access to some parts is restricted; watch the signs. Check transport and access before you go.'),
    'otagtepe': (14, "Beykoz'da Kavacık'ın üzerindeki Otağtepe, Fatih Sultan Mehmet Köprüsü'nün Anadolu ayağına bakan ağaçlık bir tepe ve kent parkıdır. Rivayete göre adını, Fatih Sultan Mehmed'in Rumeli Hisarı'nın yapımı sırasında burada otağ kurmasından alır.\n\nSeyir terasından köprü, Rumeli Hisarı ve Boğaz'ın kuşbakışı manzarası görülür; özellikle gece ışıklandırılmış köprü etkileyicidir. Kafe ve yürüyüş yollarıyla kısa bir mola için uygundur. Toplu taşımayla ulaşmak zor olabilir.",
        "Above Kavacık in Beykoz, Otağtepe is a wooded hill and city park facing the Asian end of the Fatih Sultan Mehmet Bridge. Legend has it that it takes its name, 'tent hill', from the imperial tent Mehmed II pitched here while Rumeli Fortress was being built.\n\nIts viewing terrace offers a bird's-eye view of the bridge, Rumeli Fortress and the Bosphorus; the bridge lit up at night is especially striking. With a café and walking paths, it is good for a short break. Getting there by public transport can be difficult."),
    'validebag-korusu': (14, "Üsküdar'da Altunizade ile Koşuyolu arasında yer alan Validebağ Korusu, yaklaşık 35 hektarlık alanıyla Anadolu yakasının en büyük yeşil alanlarından biridir. Osmanlı döneminde saray ailesine ait bir mesire ve av alanıydı; içinde 19. yüzyıldan kalma tarihi bir kasır bulunur.\n\nUlu ağaçlar arasındaki yürüyüş ve koşu yolları, çevredeki yoğun yapılaşmanın ortasında beklenmedik bir doğa sunar. Koru, kuş türleri ve bitki örtüsüyle doğal sit alanı olarak korunur. Sabah yürüyüşleri ve sakin bir hafta sonu gezintisi için idealdir.",
        'In Üsküdar, between Altunizade and Koşuyolu, Validebağ Grove covers about 35 hectares and is one of the largest green spaces on the Asian side. In Ottoman times it was a pleasure ground and hunting area of the imperial family, and it contains a historic 19th-century pavilion.\n\nIts walking and running paths among great trees offer unexpected nature in the middle of a densely built area. With its birds and plant life, the grove is protected as a natural heritage site. It is ideal for morning walks and quiet weekend strolls.'),
    'fenerbahce-parki': (14, "Kadıköy'de Marmara'ya uzanan Fenerbahçe burnunun büyük bölümünü kaplayan Fenerbahçe Parkı, adını burunda 19. yüzyıldan beri çalışan deniz fenerinden alır. Park, 1990'larda Çelik Gülersoy'un öncülüğünde bugünkü haline getirildi.\n\nÇam ağaçları altındaki piknik alanları, kafeler ve denize inen merdivenlerden Adalar ve Marmara'nın geniş manzarası görülür. Gün batımında ve hafta sonları çok sevilir. Kalamış ve Caddebostan'a uzanan sahil yürüyüş yoluyla birleştirilebilir.",
        "In Kadıköy, covering most of the Fenerbahçe headland jutting into the Marmara, Fenerbahçe Park takes its name from the lighthouse that has worked on the point since the 19th century. It was given its present form in the 1990s under the lead of Çelik Gülersoy.\n\nFrom its picnic areas under the pines, cafés and steps down to the sea there are wide views of the Princes' Islands and the Marmara. It is much loved at sunset and at weekends. It combines with the coastal path towards Kalamış and Caddebostan."),
    'alemdag': (14, "Çekmeköy sınırlarındaki Alemdağ, 442 metre yüksekliğiyle Aydos Tepesi'nden sonra İstanbul'un en yüksek ikinci noktası olarak bilinir. Çevresi geniş ormanlarla kaplıdır ve Bizans döneminde Meludion adıyla anılırdı.\n\nOrmanlık alandaki mesire yerleri ve yürüyüş yolları, hafta sonu piknik ve doğa yürüyüşü için Anadolu yakasının sevilen adreslerindendir. Açık havalarda tepelerden geniş bir manzara görülür. Rahat ayakkabı ve su almak, piknik kurallarını önceden kontrol etmek iyi olur.",
        "Within Çekmeköy, Alemdağ rises to 442 metres and is known as Istanbul's second-highest point after Aydos Hill. Its surroundings are covered with wide forests, and in Byzantine times it was known as Meludion.\n\nIts picnic grounds and forest trails are favourites on the Asian side for weekend picnics and nature walks. On clear days the hills offer wide views. Comfortable shoes and water are a good idea, and it is worth checking picnic rules in advance."),
    'alfred-heilbronn-botanik-bahcesi': (14, "Süleymaniye'de İstanbul Üniversitesi Fen Fakültesi'nin yanındaki Alfred Heilbronn Botanik Bahçesi, 1935'te kuruldu ve Türkiye'nin en eski botanik bahçesidir. Nazi Almanyası'ndan kaçarak İstanbul Üniversitesi'nde çalışan botanikçiler Alfred Heilbronn ve Leo Brauner tarafından kuruldu.\n\nBahçede Türkiye'nin ve dünyanın farklı bölgelerinden binlerce bitki türü, seralar ve bilimsel koleksiyonlar bulunur. Tarihi yarımadanın ortasında az bilinen, sakin bir yeşil alandır. Bir üniversite birimi olduğundan ziyaret saatleri sınırlıdır; gitmeden önce kontrol edin.",
        "In Süleymaniye, beside Istanbul University's Faculty of Science, the Alfred Heilbronn Botanical Garden was founded in 1935 and is Turkey's oldest botanical garden. It was established by the botanists Alfred Heilbronn and Leo Brauner, who had fled Nazi Germany to work at Istanbul University.\n\nThe garden holds thousands of plant species from Turkey and around the world, along with greenhouses and scientific collections. It is a little-known, quiet green space in the middle of the historic peninsula. As a university unit it has limited opening hours; check before you go."),
    'aydos-ormani': (14, "Kartal'ın kuzeyinde, Aydos Tepesi'nin çevresine yayılan Aydos Ormanı, Anadolu yakasında bir zamanlar geniş bir alanı kaplayan güney ormanlarının günümüze ulaşan parçalarından biridir. Kayışdağı ormanlarıyla birlikte bir yeşil kuşak oluşturur.\n\nOrmandaki gölet, piknik alanları ve yürüyüş yolları hafta sonları ailelerin ve doğa yürüyüşçülerinin uğrak yeridir. Aydos Tepesi'ne çıkarak Marmara ve Adalar manzarasıyla gezi tamamlanabilir. Piknik ve giriş kurallarını gitmeden önce kontrol edin.",
        "North of Kartal, spreading around Aydos Hill, Aydos Forest is one of the surviving pieces of the southern forests that once covered a large area of the Asian side. Together with the Kayışdağı woods it forms a green belt.\n\nIts pond, picnic areas and trails are popular with families and hikers at weekends. You can finish with a climb to Aydos Hill for views of the Marmara and the Princes' Islands. Check picnic and entry rules before you go."),
    'beykoz-cayiri': (14, 'Beykoz merkezindeki Beykoz Çayırı, Osmanlı padişahlarının av yeri olarak kullanıldığı için Hünkâr Çayırı diye de anılırdı. Zamanla şehir dokusu içinde kalarak alanının bir kısmını kaybetse de bugün de ilçenin en sevilen açık alanlarından biridir.\n\nGeniş çimenliği ve ulu ağaçlarıyla piknik ve dinlenme için uygundur. Yakınındaki Beykoz meydanında 18. yüzyıldan kalma İshak Ağa Çeşmesi görülebilir; Beykoz sahili ve korusuyla aynı gezide birleştirilebilir.',
        "In the centre of Beykoz, Beykoz Meadow was also known as the Sultan's Meadow because the Ottoman sultans used it as a hunting ground. Although it has lost part of its area as the town grew around it, it remains one of the district's best-loved open spaces.\n\nIts wide lawn and great trees make it good for picnics and relaxing. In nearby Beykoz square you can see the 18th-century İshak Ağa Fountain, and it combines with the Beykoz shore and grove."),
    'kucukcamlica-korusu': (15, "Üsküdar'daki Küçük Çamlıca Korusu, Boğaz çevresinin en yüksek tepelerinden Küçük Çamlıca'nın eteklerinden yaklaşık 227 metrelik zirvesine kadar uzanır. Büyük Çamlıca'ya göre daha sakin ve ağaçlık bir alandır.\n\nTepede bugün şehrin yeni simgelerinden Çamlıca Kulesi yükselir. Korunun yürüyüş yolları ve seyir noktalarından Boğaz, Tarihi Yarımada ve Marmara manzarası görülür. Büyük Çamlıca Tepesi ve Çamlıca Camii ile aynı gezide birleştirilebilir.",
        "In Üsküdar, Küçük Çamlıca Grove stretches from the foot of Küçük Çamlıca, one of the highest hills around the Bosphorus, up to its summit at about 227 metres. It is quieter and more wooded than Büyük Çamlıca.\n\nThe summit is now crowned by Çamlıca Tower, one of the city's new landmarks. The grove's paths and viewpoints overlook the Bosphorus, the historic peninsula and the Marmara. It combines with Büyük Çamlıca Hill and the Çamlıca Mosque."),
    'menekse-plaji': (15, "Küçükçekmece'deki Menekşe Plajı, İstanbul Büyükşehir Belediyesi tarafından işletilen ücretsiz bir halk plajıdır. Marmara kıyısında yaklaşık 630 metre uzunluğunda bir kumsala sahiptir.\n\nYaz aylarında Avrupa yakasının batısında yaşayanlar için yakın bir deniz ve güneşlenme noktasıdır; sahil boyunca yürüyüş yolu ve kafeler bulunur. Denize girmeden önce belediyenin plaj ve deniz suyu kalitesi duyurularını kontrol edin, yalnızca cankurtaran bulunan alanlarda yüzün.",
        "In Küçükçekmece, Menekşe Beach is a free public beach run by the Istanbul Metropolitan Municipality. It has a sandy shore about 630 metres long on the Sea of Marmara.\n\nIn summer it is a nearby spot for swimming and sunbathing for those living on the western side of the European shore, with a promenade and cafés along the coast. Before swimming, check the municipality's notices on beaches and water quality, and swim only where lifeguards are present."),
    'anadolu-kavagi-manzara-seyir-noktasi': (15, "Anadolu Kavağı, Boğaz'ın Anadolu yakasında Karadeniz girişine en yakın balıkçı köylerinden biridir ve Boğaz turu vapurlarının son durağı olarak bilinir. Köyün üzerindeki yamaçlar, Boğaz'ın Karadeniz'e açılan ağzını gören seyir noktaları sunar.\n\nBuradan Boğaz'ın kuzey kesimi, karşı kıyıdaki köyler ve Yavuz Sultan Selim Köprüsü görülür. Yokuş yukarı yürüyüşle Yoros Kalesi'ne kadar çıkılabilir; iskele çevresindeki balık restoranları da bilinen bir duraktır. Vapur saatleri mevsime göre değiştiği için önceden kontrol edin.",
        'Anadolu Kavağı is one of the fishing villages closest to the Black Sea entrance on the Asian side of the Bosphorus and is known as the last stop of the Bosphorus cruise ferries. The slopes above the village offer viewpoints over the mouth of the strait.\n\nFrom here you see the northern Bosphorus, the villages on the opposite shore and the Yavuz Sultan Selim Bridge. An uphill walk leads on to Yoros Castle, and the fish restaurants around the pier are a well-known stop. Ferry times vary by season, so check in advance.'),
    'sarayburnu-manzarasi': (15, "Tarihi Yarımada'nın en ucundaki Sarayburnu, Boğaz'ın, Haliç'in ve Marmara Denizi'nin buluştuğu noktaya bakar. Bizans döneminden beri şehrin en stratejik yerlerinden biri olan burun, Osmanlı döneminde Topkapı Sarayı'nın bahçelerinin bir parçasıydı.\n\nSahil yolundan ve Gülhane Parkı'nın ucundan Üsküdar, Kız Kulesi, Kadıköy ve Boğaz'a giren gemiler görülür. Burunda 1926'da dikilen ve İstanbul'daki ilk Atatürk heykellerinden biri olan anıt bulunur. Gün batımında manzara özellikle etkileyicidir.",
        "At the very tip of the historic peninsula, Sarayburnu looks out over the meeting point of the Bosphorus, the Golden Horn and the Sea of Marmara. One of the city's most strategic spots since Byzantine times, the point was part of the gardens of Topkapı Palace in the Ottoman era.\n\nFrom the coastal road and the end of Gülhane Park you see Üsküdar, the Maiden's Tower, Kadıköy and ships entering the Bosphorus. On the point stands a monument erected in 1926, one of the first statues of Atatürk in Istanbul. The view is especially striking at sunset."),
    'yenikoy-seyir-terasi': (15, "Arnavutköy ilçesine bağlı Yeniköy, Avrupa yakasının Karadeniz kıyısında yer alan sakin bir köydür. Köy çevresindeki yüksek noktalar, Karadeniz'in geniş ve açık manzarasını gören bir seyir terası sunar.\n\nKalabalıktan uzak bu noktada dalgalar, kıyı şeridi ve özellikle gün batımı izlenebilir. Çevrede düzenlenmiş hizmetler sınırlı olabileceğinden su ve ihtiyaçlarınızı yanınızda getirin; ulaşım ve erişim koşullarını gitmeden önce kontrol edin.",
        'Part of the Arnavutköy district, Yeniköy is a quiet village on the Black Sea coast of the European side. The high ground around the village offers a viewing terrace with wide, open views over the Black Sea.\n\nAway from the crowds, it is a place to watch the waves, the coastline and especially the sunset. Facilities in the area may be limited, so bring water and what you need; check transport and access before you go.'),
    'beykoz-korusu': (15, "Beykoz merkezinde, sahilin hemen gerisinden yamaç boyunca yükselen Beykoz Korusu, Boğaz'a hâkim konumda büyük bir ağaçlık alandır. Toplu taşımayla kolayca ulaşılabilmesi onu ilçenin en çok kullanılan yeşil alanlarından biri yapar.\n\nAğaçlar arasındaki yürüyüş yolları, dinlenme alanları ve Boğaz'a bakan noktaları sakin bir gezinti sunar. Beykoz Çayırı ve sahil ile aynı gezide birleştirilebilir; hafta sonları piknikçiler ve aileler tarafından çok tercih edilir.",
        "In central Beykoz, rising up the slope just behind the shore, Beykoz Grove is a large wooded area overlooking the Bosphorus. Easy to reach by public transport, it is one of the district's most used green spaces.\n\nIts paths among the trees, rest areas and spots overlooking the Bosphorus offer a peaceful stroll. It combines with Beykoz Meadow and the shore, and is popular with picnickers and families at weekends."),
    'ciroz-plaji': (15, "Çiroz Plajı, Bakırköy'ün Yeşilköy kıyılarında, Marmara Denizi'ne bakan bir sahil alanıdır. Yeşilköy, tarihi köşkleri ve ağaçlı sokaklarıyla Marmara kıyısının sakin semtlerinden biridir.\n\nSahil boyunca deniz kenarında yürüyüş yapılabilir ve güneşlenilebilir. Denize girmeden önce belediyenin plaj ve deniz suyu kalitesi duyurularını kontrol edin, yalnızca yüzmenin serbest olduğu ve cankurtaran bulunan alanlarda denize girin.",
        "Çiroz Beach is a stretch of shore on the Yeşilköy coast of Bakırköy, facing the Sea of Marmara. Yeşilköy, with its historic mansions and tree-lined streets, is one of the quiet districts of the Marmara coast.\n\nYou can walk and sunbathe along the seafront. Before swimming, check the municipality's notices on beaches and water quality, and swim only where swimming is allowed and lifeguards are present."),
    'hacilli-selalesi': (15, "Şile ilçesinin ormanlık iç kesimlerinde bulunan Hacıllı Şelalesi, orman içinde yürüyüşle ulaşılan küçük bir şelaledir. İstanbul'un kalabalığından uzakta, doğa yürüyüşü sevenlerin keşfettiği sakin bir noktadır.\n\nSuyun miktarı mevsime göre değişir; kış ve ilkbahar aylarında daha gürdür. Patikalar kaygan ve işaretsiz olabileceğinden uygun ayakkabı giyin, yanınıza su alın ve mümkünse grupla ya da bölgeyi bilen biriyle gidin. Ulaşım ve erişim koşullarını gitmeden önce kontrol edin.",
        'In the wooded interior of the Şile district, Hacıllı Waterfall is a small waterfall reached on foot through the forest. Far from the crowds of Istanbul, it is a quiet spot discovered by hiking lovers.\n\nIts flow varies with the season and is strongest in winter and spring. Paths can be slippery and unmarked, so wear suitable shoes, bring water and, if possible, go with a group or someone who knows the area. Check transport and access before you go.'),
    'barbaros-hayreddin-pasa-turbesi': (15, "Beşiktaş iskelesinin yanındaki parkta bulunan Barbaros Hayreddin Paşa Türbesi, Osmanlı donanmasının ünlü kaptan-ı deryası için Mimar Sinan tarafından yapıldı. Barbaros 1546'da öldüğünde, kendi seçtiği bu yere gömüldü.\n\nSekizgen planlı, tek kubbeli türbenin önündeki parkta 1944'te dikilen Barbaros heykeli bulunur. Denizcilik geleneğinde türbenin özel bir yeri vardır; önünden geçen deniz kuvvetleri gemilerinin onu selamladığı anlatılır. Deniz Müzesi'nin hemen yanında olduğundan birlikte gezilebilir.",
        'In the park beside the Beşiktaş pier, the Tomb of Barbaros Hayreddin Pasha was built by Mimar Sinan for the famous grand admiral of the Ottoman fleet. When Barbaros died in 1546, he was buried in this spot he had chosen himself.\n\nIn the park in front of the octagonal, single-domed tomb stands a statue of Barbaros erected in 1944. The tomb holds a special place in naval tradition; navy ships passing by are said to salute it. Right beside the Naval Museum, the two can be visited together.'),
    'yahya-efendi-turbesi': (15, "Beşiktaş'ta Çırağan Sarayı'nın karşısındaki yamaçta bulunan Yahya Efendi Türbesi, Kanuni Sultan Süleyman'ın süt kardeşi olan âlim ve şair Yahya Efendi için yapıldı. Türbe ve yanındaki tekke Mimar Sinan'ın eseridir.\n\nYeşillikler içindeki hazirede Osmanlı hanedanının çeşitli üyelerine ve devlet adamlarına ait zarif mezar taşları bulunur. Boğaz'ın kalabalığından birkaç adım uzakta, ağaçların gölgesinde huzurlu bir yerdir. Ziyaret sırasında sessiz ve saygılı olunmalıdır.",
        'In Beşiktaş, on the slope opposite Çırağan Palace, the Tomb of Yahya Efendi was built for the scholar and poet Yahya Efendi, foster brother of Suleiman the Magnificent. The tomb and the lodge beside it are works of Mimar Sinan.\n\nThe green graveyard holds elegant headstones of members of the Ottoman dynasty and statesmen. A few steps from the bustle of the Bosphorus, it is a peaceful place in the shade of trees. Visitors should be quiet and respectful.'),
    'aziz-mahmud-hudayi-turbesi': (15, "Üsküdar'daki Aziz Mahmud Hüdayi Türbesi, 17. yüzyılın önemli mutasavvıflarından ve Celvetiyye tarikatının kurucusu Aziz Mahmud Hüdayi'nin türbesidir. Hüdayi 1628'de öldüğünde, yanında 16. yüzyılın sonunda yapımına başlanan cami ve külliyeye defnedildi.\n\nTürbe, İstanbul'un en çok ziyaret edilen manevi mekânlarından biridir ve özellikle cuma günleri kalabalık olur. Avludaki çeşmeler ve hazire de görülmeye değer. Ziyaret sırasında sessiz ve saygılı olunmalıdır. Üsküdar merkezinden yürüme mesafesindedir.",
        "In Üsküdar, the Tomb of Aziz Mahmud Hüdayi belongs to one of the leading Sufis of the 17th century and founder of the Celvetiyye order. When Hüdayi died in 1628, he was buried beside the mosque and complex begun at the end of the 16th century.\n\nThe tomb is one of Istanbul's most visited spiritual sites and gets busy, especially on Fridays. The fountains and graveyard in the courtyard are also worth seeing. Visitors should be quiet and respectful. It is within walking distance of central Üsküdar."),
    'merkez-efendi-turbesi': (15, "Zeytinburnu'nda, kara surlarının Mevlanakapı'sının karşısındaki Merkez Efendi Türbesi, 16. yüzyıl mutasavvıfı ve hekimi Merkez Efendi'nin türbesidir. Merkez Efendi, Manisa'da hazırladığı şifalı karışımla mesir macununun ortaya çıkışıyla anılır.\n\nTürbe, cami, kuyu ve geniş tarihi mezarlıktan oluşan külliye sakin bir ziyaret yeridir; ziyaretçilerin kutsal saydığı kuyunun suyu ilgi görür. Ziyaret sırasında sessiz ve saygılı olunmalıdır. Kara surları boyunca yapılacak bir yürüyüşe eklenebilir.",
        'In Zeytinburnu, opposite the Mevlanakapı gate of the land walls, the Tomb of Merkez Efendi belongs to the 16th-century Sufi and physician Merkez Efendi. He is remembered for the healing paste he prepared in Manisa, from which the tradition of mesir paste arose.\n\nThe complex, with its tomb, mosque, well and large historic cemetery, is a quiet place to visit, and the water of the well, regarded as blessed by visitors, draws interest. Visitors should be quiet and respectful. It can be added to a walk along the land walls.'),
    'telli-baba-turbesi': (15, "Sarıyer'de Boğaz kıyısında, Rumelikavağı yolunun kenarındaki Telli Baba Türbesi, halk arasında çok sevilen bir ziyaret yeridir. Türbede yatan zatın kimliği hakkında farklı rivayetler anlatılır.\n\nGeleneğe göre ziyaretçiler, özellikle evlenmek isteyenler, dilek dileyerek türbenin parmaklığına tel bağlar; dileği gerçekleşenlerin gelin teliyle geri döndüğü anlatılır. Türbe adını bu gelenekten alır. Ziyaret sırasında sessiz ve saygılı olunmalıdır; Boğaz kıyısındaki sahil yolu üzerinde kısa bir durak olarak görülebilir.",
        "On the Bosphorus shore in Sarıyer, beside the road to Rumelikavağı, the Tomb of Telli Baba is a much-loved place of popular pilgrimage. Different stories are told about the identity of the person buried there.\n\nBy tradition, visitors, especially those hoping to marry, tie a wire to the tomb's railing as they make a wish, and those whose wishes come true are said to return with a bride's tinsel. The tomb takes its name, 'father of the wire', from this custom. Visitors should be quiet and respectful; it makes a short stop on the coastal road along the Bosphorus."),
}
