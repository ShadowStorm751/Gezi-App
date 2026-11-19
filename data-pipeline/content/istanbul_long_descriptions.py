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
}
