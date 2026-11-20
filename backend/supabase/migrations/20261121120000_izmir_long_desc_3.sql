-- İzmir uzun açıklamaları, 3. parti (23 yer, TR + EN).
-- Üreten: data-pipeline/content/build_long_desc.py (kaynak: content/izmir_long_descriptions.py).
-- Metinler kendi cümlelerimizdir; Vikipedi/Wikidata yalnızca bilgi kontrolü için kullanıldı.

update public.place_translations t
   set long_desc = v.long_desc
  from (values
  ('cesme-kalesi', 'tr', 'Çeşme Kalesi, Osmanlı Sultanı II. Bayezid döneminde, 1508 civarında, Sakız Adası karşısındaki kıyıyı ve limanı korumak için yapıldı. 1770''teki Çeşme Deniz Savaşı''na tanıklık eden kale, sonraki yüzyıllarda da kasabanın simgesi olarak kaldı.

Surların üzerinde yürüyerek liman, kervansaray ve Ege''nin manzarasını izleyebilirsiniz. Kalenin içinde Çeşme Müzesi bulunur; yaz akşamları avlusunda konser ve festivaller düzenlenir. Önündeki Cezayirli Gazi Hasan Paşa heykeli ve çarşı aynı yürüyüşte görülür. Yazın öğle sıcağı yerine sabah ya da akşamüstü gidin.'),
  ('cesme-kalesi', 'en', 'Çeşme Castle was built around 1508 under the Ottoman Sultan Bayezid II to guard the harbour and the coast facing the island of Chios. It witnessed the Battle of Çeşme in 1770 and has remained the symbol of the town ever since.

Walking along the walls you can look out over the harbour, the caravanserai and the Aegean. Çeşme Museum is inside the castle, and concerts and festivals are held in its courtyard on summer evenings. The statue of Cezayirli Gazi Hasan Pasha in front and the market fit into the same walk. In summer go in the morning or late afternoon rather than in the midday heat.'),
  ('foca-kalesi', 'tr', 'Foça Kalesi, antik Phokaia''nın üzerine kurulmuştur. Kentin sur duvarlarının en eski bölümleri MÖ 6. yüzyılın başlarına uzanır; bugünkü kale ise ortaçağda, Bizans ve ardından Ceneviz döneminde biçimlendi, Osmanlılar zamanında da onarıldı. Denize bakan bölümü Beşkapılar adıyla bilinir.

Kale duvarları boyunca yürüyerek Küçükdeniz koyunu, balıkçı teknelerini ve taş evleri izleyebilirsiniz. Gün batımında sur dibindeki sahil yolu özellikle güzeldir. Foça''nın Akdeniz foklarıyla ünlü kıyısı ve tekne turlarıyla aynı gün birleştirilebilir.'),
  ('foca-kalesi', 'en', 'Foça Castle is built over ancient Phokaia. The oldest parts of the city walls go back to the early 6th century BC, while the castle as seen today took shape in the Middle Ages under the Byzantines and then the Genoese, and was repaired in Ottoman times. The section facing the sea is known as Beşkapılar (Five Gates).

Walking along the walls you look out over the Küçükdeniz bay, its fishing boats and stone houses. The seafront road at the foot of the walls is especially lovely at sunset. It combines well with Foça''s coast, known for Mediterranean monk seals, and its boat trips.'),
  ('candarli-kalesi', 'tr', 'Dikili''ye bağlı Çandarlı''daki kale, antik Pitane kentinin bulunduğu yarımadada, denizin hemen kıyısında yükselir. Yapım tarihi kesin bilinmez; 14. yüzyılda Cenevizlilerin onardığı kale, 15. yüzyılda Sadrazam Çandarlı Halil Paşa''nın emriyle yeniden inşa edildi ve kasaba adını bu aileden aldı.

Dört köşesindeki kuleleri ve sağlam surlarıyla bölgenin en iyi korunmuş ortaçağ kalelerindendir; son restorasyonun ardından ziyarete açıldı. Kalenin çevresindeki sahil ve balık restoranları, Bergama ya da Dikili gezisine eklenecek sakin bir mola sunar.'),
  ('candarli-kalesi', 'en', 'The castle at Çandarlı, in Dikili district, rises right by the sea on the peninsula where the ancient city of Pitane stood. Its date of construction is not known for certain; repaired by the Genoese in the 14th century, it was rebuilt in the 15th century on the orders of the Grand Vizier Çandarlı Halil Pasha, whose family gave the town its name.

With towers at its corners and solid walls, it is one of the best-preserved medieval castles in the region and opened to visitors after its latest restoration. The seafront and fish restaurants around it offer a quiet stop to add to a trip to Bergama or Dikili.'),
  ('sigacik-kalesi', 'tr', 'Seferihisar''daki Sığacık Kalesi''nin Selçuklu döneminde kurulduğu düşünülür; Aydınoğulları ve Osmanlılar zamanında kullanıldı ve bugünkü biçimini büyük ölçüde 16. yüzyılda aldı. Kalenin en ilginç yanı, surların içinin bugün de yaşayan bir mahalle olmasıdır.

Dar sokaklarda taş evler, pansiyonlar, el sanatı dükkânları ve kafeler arasında dolaşabilirsiniz. Sığacık, ''yavaş şehir'' (Cittaslow) Seferihisar''ın kalbidir; pazar günleri kurulan üretici pazarı kalabalık olur. Limandaki balık lokantaları ve yakındaki Teos antik kenti aynı güne sığar.'),
  ('sigacik-kalesi', 'en', 'Sığacık Castle in Seferihisar is thought to have been founded in the Seljuk period; it was used by the Aydınids and the Ottomans and largely took its present form in the 16th century. Its most interesting feature is that the area inside the walls is still a living neighbourhood.

You can wander narrow streets among stone houses, guesthouses, craft shops and cafés. Sığacık is the heart of Seferihisar, Turkey''s first ''slow city'' (Cittaslow); the producers'' market held on Sundays gets busy. The fish restaurants by the harbour and the nearby ancient city of Teos fit into the same day.'),
  ('sancakburnu-kalesi', 'tr', 'İnciraltı''ndaki Sancakburnu Kalesi, Yenikale olarak da bilinir. 1660''larda, Köprülüler döneminde İzmir Körfezi''nin girişini denetlemek için yapıldı; karşı kıyıdaki Yenikale ile birlikte körfeze giren gemileri kontrol ediyordu.

Kale askeri alanda kaldığı için uzun süre ziyarete kapalıydı; gitmeden önce erişim durumunu kontrol edin. Çevresindeki İnciraltı sahili ve kent ormanı yürüyüş ve bisiklet için uygundur; TCG Pirireis müze denizaltısı da yakındadır.'),
  ('sancakburnu-kalesi', 'en', 'Sancakburnu Castle in İnciraltı is also known as Yenikale (New Castle). It was built in the 1660s, in the era of the Köprülü grand viziers, to control the entrance to the Gulf of İzmir and, together with the battery on the opposite shore, kept watch over ships entering the gulf.

As it lies within a military zone it was long closed to visitors, so check access before you go. The İnciraltı seafront and city forest around it are good for walking and cycling, and the TCG Pirireis museum submarine is nearby.'),
  ('ayasuluk-kalesi', 'tr', 'Selçuk''ta Ayasuluk Tepesi''nin zirvesindeki kale, Efes''in Bizans döneminde kentin bu tepeye taşınmasıyla önem kazandı. Bizanslılar tarafından güçlendirilen surlar, Aydınoğulları zamanında da kullanıldı; kale içinde bu döneme ait bir cami ve sarnıçlar bulunur.

Kuleli surların üzerinden Selçuk, Artemis Tapınağı''nın bulunduğu ova ve İsa Bey Camii görülür. Kale, hemen aşağıdaki Aziz Yuhanna Bazilikası ile birlikte gezilir; tepeye çıkış rampalı ve gölgesizdir, sabah erken saatleri tercih edin.'),
  ('ayasuluk-kalesi', 'en', 'The castle on the summit of Ayasuluk Hill in Selçuk gained importance when, in the Byzantine period, the city of Ephesus moved to this hill. Its walls, strengthened by the Byzantines, were also used under the Aydınids, and inside are a mosque and cisterns from that period.

From the towered walls you see Selçuk, the plain where the Temple of Artemis stood, and the İsa Bey Mosque. The castle is visited together with the Basilica of St John just below; the climb is sloping and shadeless, so early morning is best.'),
  ('izmir-saat-kulesi', 'tr', 'Konak Meydanı''ndaki İzmir Saat Kulesi, Sultan II. Abdülhamid''in tahta çıkışının 25. yılı için 1901''de yapıldı. Levanten mimar Raymond Charles Père tarafından tasarlandı; saatinin Alman İmparatoru II. Wilhelm''in hediyesi olduğu anlatılır. Bugün İzmir''in en bilinen simgesidir ve belediye amblemindedir.

Dört yanındaki çeşmeler, ince işçilikli taş gövdesi ve Kuzey Afrika etkili süslemeleri yakından incelenmeye değer. Meydandaki güvercinler, Konak Camii ve deniz kıyısıyla şehrin en çok fotoğraflanan köşesidir. Kemeraltı gezisine buradan başlanabilir; vapur iskelesi de birkaç adım ötededir.'),
  ('izmir-saat-kulesi', 'en', 'The İzmir Clock Tower on Konak Square was built in 1901 to mark the 25th anniversary of Sultan Abdülhamid II''s accession. It was designed by the Levantine architect Raymond Charles Père, and its clock is said to have been a gift from the German Emperor Wilhelm II. Today it is İzmir''s best-known landmark and appears on the city''s emblem.

The fountains on its four sides, the finely worked stone shaft and the North African-influenced ornament deserve a close look. With the pigeons, the Konak Mosque and the waterfront, this is the most photographed corner of the city. A walk through Kemeraltı can start here, and the ferry pier is a few steps away.'),
  ('izmir-parasut-kulesi', 'tr', 'Kültürpark''taki Paraşüt Kulesi, 1937''de Türk Hava Kurumu tarafından yapıldı. Moskova''daki Gorki Parkı''nda benzerini gören Belediye Başkanı Behçet Uz''un girişimiyle inşa edilen kule, ülkedeki iki paraşüt kulesinden biridir ve uzun yıllar paraşüt eğitiminde kullanıldı.

Çelik iskeleti ve tepesindeki şemsiye biçimli kolu, Kültürpark''ın en tanınmış silüetlerindendir. Bugün atlama yapılmasa da parkın gölet ve yürüyüş yollarıyla birlikte görülür. Fuar dönemlerinde park çok kalabalık olur; sakin bir gezi için hafta içi sabahları seçin.'),
  ('izmir-parasut-kulesi', 'en', 'The Parachute Tower in Kültürpark was built in 1937 by the Turkish Aeronautical Association. Built on the initiative of Mayor Behçet Uz, who had seen a similar tower in Moscow''s Gorky Park, it is one of only two parachute towers in the country and was used for parachute training for many years.

Its steel frame and umbrella-shaped arm on top make it one of the best-known silhouettes in Kültürpark. Although no jumps are made today, it is seen together with the park''s pond and walking paths. The park gets very crowded during fairs; for a quiet visit choose a weekday morning.'),
  ('tarihi-asansor', 'tr', 'Karataş''taki Tarihi Asansör, 1907''de Yahudi iş insanı Nesim Levi tarafından yaptırıldı. Aralarında yaklaşık 58 metre kot farkı bulunan Mithatpaşa Caddesi ile yukarıdaki Şehit Nihat Bey Caddesi''ni birbirine bağlar; önceden bu yokuş uzun merdivenlerle çıkılıyordu.

Asansörle yukarı çıkınca terastan körfezin ve Konak''ın geniş bir manzarası açılır; üstteki restoran ve kafeler gün batımında doludur. Aşağıdaki Dario Moreno Sokağı''nın renkli merdivenleri ve Bet İsrael Sinagogu aynı yürüyüşte görülebilir.'),
  ('tarihi-asansor', 'en', 'The Historical Elevator in Karataş was built in 1907 by the Jewish businessman Nesim Levi. It links Mithatpaşa Street with Şehit Nihat Bey Street above, about 58 metres higher; before it existed, the slope was climbed by long flights of steps.

At the top, the terrace opens onto a wide view of the gulf and Konak, and the restaurant and cafés up there are full at sunset. The colourful steps of Dario Moreno Street below and the Bet Israel Synagogue fit into the same walk.'),
  ('ataturk-maski', 'tr', 'Buca''da, Kadifekale''ye bakan yamaçtaki Atatürk Maskı, Atatürk''ün yüzünü gösteren dev bir beton kabartmadır. Heykeltıraş Harun Atalayman''ın eseri olan anıtın yapımı 2006''da başladı, 2009''da tamamlandı. Yaklaşık 42 metre yüksekliğiyle ülkenin en büyük heykellerindendir.

Şehrin birçok noktasından, özellikle akşam ışıklandırıldığında uzaktan görülür. Yakından görmek için yamaçtaki seyir alanına çıkılabilir; buradan İzmir''in iç kesimlerine de geniş bir manzara açılır.'),
  ('ataturk-maski', 'en', 'In Buca, on a hillside facing Kadifekale, the Atatürk Mask is a giant concrete relief of Atatürk''s face. The work of the sculptor Harun Atalayman, it was begun in 2006 and completed in 2009. At about 42 metres high it is one of the largest sculptures in the country.

It can be seen from many parts of the city, especially when lit up in the evening. For a closer look you can go up to the viewing area on the slope, which also offers a wide view over inland İzmir.'),
  ('cumhuriyet-meydani', 'tr', 'Alsancak ile Konak arasında, Kordon''un ucundaki Cumhuriyet Meydanı, İzmir''in ana kent meydanlarındandır. Meydanın ortasındaki atlı Atatürk Anıtı, İtalyan heykeltıraş Pietro Canonica''nın eseridir ve 1932''de açıldı.

Ulusal bayramlardaki törenler burada yapılır. Pasaport vapur iskelesi ve Kordon''un yürüyüş yolu birkaç adım ötededir; denize karşı oturup simit yemek ya da gün batımını izlemek için iyi bir başlangıç noktasıdır.'),
  ('cumhuriyet-meydani', 'en', 'Between Alsancak and Konak, at the end of the Kordon, Cumhuriyet (Republic) Square is one of İzmir''s main city squares. The equestrian Atatürk Monument at its centre is the work of the Italian sculptor Pietro Canonica and was unveiled in 1932.

Ceremonies on national holidays are held here. The Pasaport ferry pier and the Kordon promenade are a few steps away, making it a good starting point for sitting by the sea with a simit or watching the sunset.'),
  ('gundogdu-meydani', 'tr', 'Alsancak''ta, Kordon''un ortasındaki Gündoğdu Meydanı, 2000''deki kıyı düzenlemesiyle halka açıldı. Ortasında Cumhuriyet Ağacı heykeli bulunan geniş meydan, İzmir''in kutlama, konser ve buluşma yeridir.

Büyük maçlar, yılbaşı ve bayram kutlamaları burada yapılır; sıradan günlerde ise çimlerde oturan, bisiklet süren ve deniz kıyısında yürüyenlerle doludur. Kordon boyunca Konak''a ya da Alsancak Limanı''na yürüyüş için iyi bir başlangıç noktasıdır.'),
  ('gundogdu-meydani', 'en', 'Gündoğdu Square, in the middle of the Kordon in Alsancak, opened to the public with the waterfront redesign of 2000. With the Tree of the Republic sculpture at its centre, the wide square is İzmir''s place for celebrations, concerts and meeting up.

Big matches, New Year and holiday celebrations take place here, and on ordinary days it is full of people sitting on the grass, cycling and strolling by the sea. It is a good starting point for a walk along the Kordon to Konak or to Alsancak Port.'),
  ('ilk-kursun-aniti', 'tr', 'Konak''taki İlk Kurşun Anıtı, 15 Mayıs 1919''da İzmir''in işgali sırasında işgal kuvvetlerine ilk kurşunu atan ve orada hayatını kaybeden gazeteci Hasan Tahsin anısına 1974''te dikildi. Bu olay, Kurtuluş Savaşı''nın başlangıç anlarından biri olarak anılır.

Anıtta elinde silah ve bayrakla Hasan Tahsin''in heykeli, yanlarında işgal ve direniş sahnelerini anlatan kabartmalar bulunur. Her yıl 15 Mayıs''ta burada anma töreni yapılır. Saat Kulesi ve Konak Meydanı''na yürüme mesafesindedir.'),
  ('ilk-kursun-aniti', 'en', 'The First Bullet Monument in Konak was erected in 1974 in memory of the journalist Hasan Tahsin, who fired the first shot at the occupying forces during the occupation of İzmir on 15 May 1919 and was killed there. The event is remembered as one of the opening moments of the War of Independence.

The monument shows Hasan Tahsin with a gun and a flag, flanked by reliefs depicting scenes of occupation and resistance. A memorial ceremony is held here every 15 May. It is within walking distance of the Clock Tower and Konak Square.'),
  ('cezayirli-gazi-hasan-pasa-aniti', 'tr', 'Çeşme Kalesi''nin önündeki anıt, Osmanlı amirali ve sadrazamı Cezayirli Gazi Hasan Paşa''yı (1713-1790) yanındaki aslanıyla gösterir. Hasan Paşa, 1770 Çeşme Deniz Savaşı''ndan sağ kurtulan komutanlardandı ve Cezayir''deyken edindiği evcil aslanla ünlüydü.

Heykel, kasabanın en çok fotoğraflanan noktalarındandır; arkasında kale, önünde liman ve çarşı uzanır. Kale ve müze ziyaretiyle birlikte kısa bir durak olarak görülür.'),
  ('cezayirli-gazi-hasan-pasa-aniti', 'en', 'The monument in front of Çeşme Castle shows the Ottoman admiral and grand vizier Cezayirli Gazi Hasan Pasha (1713-1790) with his lion. Hasan Pasha was among the commanders who survived the Battle of Çeşme in 1770 and was famous for the tame lion he acquired while in Algiers.

The statue is one of the most photographed spots in town, with the castle behind it and the harbour and market in front. It makes a short stop with a visit to the castle and museum.'),
  ('kizlaragasi-hani', 'tr', 'Kemeraltı''ndaki Kızlarağası Hanı, III. Ahmed ve I. Mahmud dönemlerinde saray kızlar ağası olan Hacı Beşir Ağa tarafından 1744''te yaptırıldı. İzmir''de günümüze ulaşan en büyük Osmanlı hanıdır; uzun yıllar tüccarların konakladığı ve mal depoladığı bir ticaret merkeziydi.

İki katlı hanın avlusunu çevreleyen dükkânlarda bugün halı, el sanatları, hediyelik eşya ve antika satılır; avludaki kahveciler İzmir''in en keyifli kahve molası yerlerindendir. Hisar Camii hemen yanındadır; Kemeraltı gezisinin merkezi bir durağı olarak düşünün.'),
  ('kizlaragasi-hani', 'en', 'The Kızlarağası Han in Kemeraltı was built in 1744 by Hacı Beşir Ağa, chief eunuch of the imperial harem under Ahmed III and Mahmud I. It is the largest surviving Ottoman han in İzmir and was for many years a trading centre where merchants stayed and stored their goods.

Today the shops around the courtyard of the two-storey han sell carpets, crafts, souvenirs and antiques, and the coffee sellers in the courtyard are one of the nicest places in İzmir for a coffee break. The Hisar Mosque is right next door; think of it as a central stop on a Kemeraltı walk.'),
  ('sehit-kubilay-aniti', 'tr', 'Menemen''deki Şehit Kubilay Anıtı, 23 Aralık 1930''daki Menemen Olayı''nda hayatını kaybeden yedek subay öğretmen Mustafa Fehmi Kubilay ile yanında öldürülen bekçiler anısına yapıldı. Heykeltıraş Ratip Aşir Acudoğu''nun eseri olan anıt 26 Aralık 1934''te açıldı.

İlçeye hâkim bir tepede yer alan anıt alanında her yıl 23 Aralık''ta anma töreni düzenlenir. Tepeden Menemen ovası ve çevresi görülür. İzmir''den Foça ya da Bergama yönüne giderken kısa bir durak olarak planlanabilir.'),
  ('sehit-kubilay-aniti', 'en', 'The Martyr Kubilay Memorial in Menemen commemorates Mustafa Fehmi Kubilay, a reserve officer and teacher killed in the Menemen Incident of 23 December 1930, together with the watchmen killed alongside him. The work of the sculptor Ratip Aşir Acudoğu, it was unveiled on 26 December 1934.

Set on a hill above the town, the memorial site hosts a ceremony every 23 December, and the hill looks out over the Menemen plain. It makes a short stop on the way from İzmir towards Foça or Bergama.'),
  ('kemeralti-carsisi', 'tr', 'Konak Meydanı''ndan Basmane''ye ve Agora''ya kadar uzanan Kemeraltı, İzmir''in yüzyıllardır yaşayan tarihi çarşısıdır. Bir kısmı, 17. yüzyılda doldurulan eski iç limanın üzerine kuruldu. Hanlar, camiler, sinagoglar, kiliseler ve sayısız dükkânla kentin ticaret ve günlük hayatının merkezi oldu.

Anafartalar Caddesi''nden girip ara sokaklarda kaybolun: Kızlarağası Hanı''nda kahve, Havra Sokağı''nda tezgâhlar, boyoz ve lokma gibi İzmir lezzetleri, kuyumcular ve bakırcılar sizi bekler. Pazar günleri dükkânların çoğu kapalıdır; hafta içi gündüz en canlı zamanıdır. İçindeki tarihi yapılar ayrıca işaretlenebilir.'),
  ('kemeralti-carsisi', 'en', 'Stretching from Konak Square to Basmane and the Agora, Kemeraltı is İzmir''s historic bazaar, alive for centuries. Part of it was built over the old inner harbour, filled in during the 17th century. With its hans, mosques, synagogues, churches and countless shops, it became the centre of the city''s trade and daily life.

Enter from Anafartalar Street and lose yourself in the side streets: coffee at the Kızlarağası Han, stalls on Havra Street, İzmir treats such as boyoz and lokma, jewellers and coppersmiths. Most shops close on Sundays, so weekdays during the day are the liveliest. The historic buildings inside can be checked off separately.'),
  ('memmius-yapisi', 'tr', 'Efes''te, Domitian Meydanı''nın yanında duran Memmius Anıtı, MÖ 1. yüzyılda, Romalı diktatör Sulla''nın torunu Gaius Memmius adına yapıldı. Roma''nın Efes ve Asya eyaletindeki gücünü vurgulayan bir anıt olarak düşünülür.

Ayakta kalan bölümlerde kabartmalı bloklar ve dört yönü açık yapının izleri görülür. Üst girişten Kuretler Caddesi''ne inerken yolunuzun hemen başındadır; yanındaki Pollio Çeşmesi ve Domitian Tapınağı ile birlikte bakılabilir.'),
  ('memmius-yapisi', 'en', 'Standing beside Domitian Square in Ephesus, the Memmius Monument was built in the 1st century BC in honour of Gaius Memmius, grandson of the Roman dictator Sulla. It is thought of as a monument proclaiming Rome''s power in Ephesus and the province of Asia.

The surviving parts show relief-carved blocks and traces of a structure open on four sides. It lies right at the start of your route as you walk down from the upper entrance to Curetes Street, and can be seen with the nearby Pollio Fountain and the Temple of Domitian.'),
  ('artemis-tapinagi', 'tr', 'Selçuk''taki Artemis Tapınağı, antik dünyanın yedi harikasından biri sayılır. Tanrıça Artemis''e adanan tapınak birkaç kez yeniden yapıldı; MÖ 356''da kundaklanarak yandıktan sonra daha görkemli biçimde inşa edildi. Geç antik çağda yıkılan yapının yeri 19. yüzyılda İngiliz kazılarıyla bulundu.

Bugün bataklık bir alanda, parçalardan yeniden dikilmiş tek bir sütun ayakta durur; üzerindeki leylek yuvası manzaranın parçasıdır. Tapınağın büyüklüğünü hayal etmek için Efes Müzesi''ndeki Artemis heykelleriyle birlikte düşünün. Ayasuluk Tepesi ve İsa Bey Camii hemen arkada görülür.'),
  ('artemis-tapinagi', 'en', 'The Temple of Artemis at Selçuk is counted among the Seven Wonders of the ancient world. Dedicated to the goddess Artemis, the temple was rebuilt several times; after it was burned by an arsonist in 356 BC it was rebuilt on an even grander scale. Destroyed in late antiquity, its site was rediscovered by British excavations in the 19th century.

Today a single column, re-erected from fragments, stands in a marshy field, and the stork''s nest on top is part of the view. To imagine the temple''s size, pair it with the statues of Artemis in the Ephesus Museum. Ayasuluk Hill and the İsa Bey Mosque rise just behind.'),
  ('efes', 'tr', 'Efes, antik dünyanın en büyük ve en zengin kentlerinden biriydi. MÖ 10. yüzyılda kurulan kent, Roma döneminde Asya eyaletinin başkenti oldu; limanı, tapınakları ve kamu yapılarıyla parladı, erken Hristiyanlık için de önemli bir merkez haline geldi. Limanın zamanla alüvyonla dolması kentin sonunu getirdi. 2015''te UNESCO Dünya Mirası Listesi''ne alındı.

Mermer döşeli Kuretler Caddesi, Celsus Kütüphanesi, binlerce kişilik Büyük Tiyatro ve ayrı biletle girilen Yamaç Evler en önemli duraklardır. İki giriş vardır; üst girişten başlayıp aşağı doğru yürümek daha kolaydır. Gölge azdır: yazın sabah erken gidin, su, şapka ve rahat ayakkabı alın. İçindeki yapılar ayrıca işaretlenebilir.'),
  ('efes', 'en', 'Ephesus was one of the largest and richest cities of the ancient world. Founded in the 10th century BC, it became the capital of the Roman province of Asia and flourished with its harbour, temples and public buildings, also becoming an important centre of early Christianity. The gradual silting-up of its harbour brought about its end. It was added to the UNESCO World Heritage List in 2015.

The marble-paved Curetes Street, the Library of Celsus, the Great Theatre seating thousands and the Terrace Houses, which need a separate ticket, are the main stops. There are two entrances; starting at the upper gate and walking downhill is easier. Shade is scarce: in summer go early, and bring water, a hat and comfortable shoes. The buildings inside can be checked off separately.'),
  ('pergamon', 'tr', 'Bergama''nın üzerindeki tepede yükselen Pergamon akropolü, MÖ 282-133 arasında Bergama Krallığı''nın başkentiydi. Attalos hanedanı döneminde kent, kütüphanesi, tapınakları ve sanatıyla Helenistik dünyanın parlak merkezlerinden oldu. 2014''te UNESCO Dünya Mirası Listesi''ne alındı.

Yamaca oyulmuş dik tiyatro, Trajan Tapınağı''nın beyaz mermer sütunları, kütüphane ve bugün Berlin''de bulunan Zeus Sunağı''nın temelleri en önemli bölümlerdir. Akropole teleferikle çıkmak zamanı ve gücü korur. Tepe rüzgârlı ve gölgesizdir; aşağıdaki Asklepion ve Kızıl Avlu ile birlikte bir günlük gezi planlayın. İçindeki yapılar ayrıca işaretlenebilir.'),
  ('pergamon', 'en', 'Rising on the hill above Bergama, the acropolis of Pergamon was the capital of the Kingdom of Pergamon from 282 to 133 BC. Under the Attalid dynasty the city became one of the brightest centres of the Hellenistic world, famed for its library, temples and art. It was added to the UNESCO World Heritage List in 2014.

The steep theatre cut into the slope, the white marble columns of the Temple of Trajan, the library and the foundations of the Altar of Zeus, now in Berlin, are the highlights. Taking the cable car up saves time and energy. The hill is windy and shadeless; plan a full day together with the Asklepion and the Red Basilica below. The buildings inside can be checked off separately.'),
  ('celsus-kutuphanesi', 'tr', 'Efes''in simgesi Celsus Kütüphanesi, 2. yüzyılın başında, Asya eyaleti valisi Tiberius Julius Celsus Polemaeanus anısına oğlu Tiberius Julius Aquila tarafından yaptırıldı. Celsus''un mezarı yapının altındadır. Binlerce kitap rulosunu barındıran kütüphane, antik dünyanın en büyük kütüphanelerinden biriydi.

İki katlı cephesi 1970''lerde yeniden ayağa kaldırıldı; nişlerdeki bilgelik, erdem, düşünce ve bilgiyi simgeleyen kadın heykelleri kopyadır, asılları Viyana''dadır. Sabahın ilk saatlerinde cephe güneşi alır ve kalabalık azdır. Yanındaki Mazeus ve Mithridates Kapısı''ndan Ticaret Agorası''na geçilir.'),
  ('celsus-kutuphanesi', 'en', 'The symbol of Ephesus, the Library of Celsus was built in the early 2nd century by Tiberius Julius Aquila in memory of his father, Tiberius Julius Celsus Polemaeanus, governor of the province of Asia. Celsus''s tomb lies beneath the building. Holding thousands of scrolls, it was one of the largest libraries of the ancient world.

Its two-storey façade was re-erected in the 1970s; the female statues in the niches, representing wisdom, virtue, intelligence and knowledge, are copies, with the originals in Vienna. The façade catches the sun early in the morning, when crowds are thinner. The Gate of Mazaeus and Mithridates beside it leads into the Commercial Agora.'),
  ('ataturk-acik-hava-tiyatrosu', 'tr', 'Kültürpark''ın içindeki Açıkhava Tiyatrosu, parkın ve İzmir Enternasyonal Fuarı''nın en tanınmış sahnelerinden biridir. Kuşaklar boyunca fuar konserleriyle özdeşleşen tiyatro, Türkiye''nin pek çok ünlü sanatçısının İzmirlilerle buluştuğu yer oldu.

Yaz sonundaki fuar döneminde neredeyse her akşam konser düzenlenir; program ve bilet bilgisini önceden kontrol edin. Etkinlik olmayan günlerde sahne ve basamaklar parkın sakin bir köşesidir. Paraşüt Kulesi ve göletle birlikte bir Kültürpark yürüyüşüne eklenebilir.'),
  ('ataturk-acik-hava-tiyatrosu', 'en', 'The Open-Air Theatre in Kültürpark is one of the best-known stages of the park and of the İzmir International Fair. Associated for generations with the fair''s concerts, it is where many of Turkey''s famous performers have met audiences in İzmir.

During the fair at the end of summer there are concerts almost every evening; check the programme and tickets in advance. On days without events, the stage and terraces are a quiet corner of the park. Add it to a Kültürpark walk together with the Parachute Tower and the pond.')
  ) v(slug, lang, long_desc)
  join public.places p on p.slug = v.slug
 where t.place_id = p.id and t.lang = v.lang;
