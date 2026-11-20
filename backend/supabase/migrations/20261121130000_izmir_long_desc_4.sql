-- İzmir uzun açıklamaları, 4. parti (24 yer, TR + EN).
-- Üreten: data-pipeline/content/build_long_desc.py (kaynak: content/izmir_long_descriptions.py).
-- Metinler kendi cümlelerimizdir; Vikipedi/Wikidata yalnızca bilgi kontrolü için kullanıldı.

update public.place_translations t
   set long_desc = v.long_desc
  from (values
  ('bergama-zeus-sunagi', 'tr', 'Pergamon akropolünün bir terasındaki Zeus Sunağı, MÖ 2. yüzyılın ilk yarısında Kral II. Eumenes döneminde yapıldı. U biçimli anıtsal yapı, tanrılarla devlerin savaşını anlatan dev kabartma frizleriyle Helenistik sanatın başyapıtlarından sayılır. 19. yüzyılın sonundaki Alman kazılarında çıkarılan sunak Berlin''e götürüldü ve orada yeniden kuruldu.

Akropolde bugün yalnızca basamaklı temeli ve onu gölgeleyen çam ağaçları görülür; yine de sunağın kenti nasıl taçlandırdığını hayal etmek için iyi bir noktadır. Asıl görünüşünü anlamak için Bergama Müzesi''ndeki maketine bakın. Athena Kutsal Alanı ve tiyatronun üst kısmı hemen yanındadır.'),
  ('bergama-zeus-sunagi', 'en', 'On a terrace of the Pergamon acropolis, the Altar of Zeus was built in the first half of the 2nd century BC under King Eumenes II. The U-shaped monumental structure, with its huge relief friezes of the battle between gods and giants, is counted among the masterpieces of Hellenistic art. Excavated by German archaeologists in the late 19th century, the altar was taken to Berlin and reassembled there.

On the acropolis today only its stepped foundation remains, shaded by pine trees; still, it is a good place to imagine how the altar crowned the city. See the model in the Bergama Museum to understand its original look. The Sanctuary of Athena and the top of the theatre are right next to it.'),
  ('klazomenai', 'tr', 'Urla''daki Klazomenai, on iki İyon kentinden biridir. Kent bir dönem kıyıdaki karada, Pers tehdidi sırasında ise bugün Karantina Adası olarak bilinen adacık üzerinde yaşadı. Klazomenai, boyalı pişmiş toprak lahitleriyle antik sanat tarihinde ayrı bir yere sahiptir.

Alanın en ilginç noktası, MÖ 6. yüzyıla tarihlenen ve aslına uygun olarak yeniden canlandırılan zeytinyağı işliğidir; antik çağda zeytinyağının nasıl üretildiğini yerinde gösterir. Kalıntılar dağınıktır, bu yüzden işaretlere göre ilerleyin. Urla''nın bağ yolu ve İskele''deki balıkçılarla aynı gün gezilebilir.'),
  ('klazomenai', 'en', 'Klazomenai in Urla was one of the twelve Ionian cities. The city lived for a time on the mainland shore and, during the Persian threat, on the islet now known as Karantina Island. It holds a special place in the history of ancient art for its painted terracotta sarcophagi.

The most interesting spot on the site is the olive oil workshop of the 6th century BC, faithfully reconstructed to show on the spot how olive oil was produced in antiquity. The remains are scattered, so follow the signs. It can be combined in one day with Urla''s wine route and the fish restaurants at İskele.'),
  ('kolophon', 'tr', 'Menderes ilçesinin Değirmendere mahallesindeki Kolophon, on iki İyon kentinin en eskilerinden biri sayılır ve MÖ 2. binyılın sonlarına doğru kurulduğu düşünülür. Deniz kıyısında kurulmayan tek İyon kentiydi; antik yazarlar onun süvarilerinin ünlü olduğunu anlatır.

Bugün kalıntılar, zeytinliklerin arasındaki tepelere dağılmış sur, temel ve teras parçalarından oluşur; gösterişli yapılar beklemeyin. Kolophon''un kutsal alanı Klaros ve limanı Notion güneyde, birkaç kilometre uzaklıktadır; üçü birlikte gezilirse kentin hikâyesi daha iyi anlaşılır.'),
  ('kolophon', 'en', 'Colophon, in the Değirmendere quarter of Menderes district, is considered one of the oldest of the twelve Ionian cities and is thought to have been founded towards the end of the 2nd millennium BC. It was the only Ionian city not built on the coast, and ancient writers tell of its famous cavalry.

Today its remains are fragments of walls, foundations and terraces scattered over hills among olive groves; do not expect grand buildings. Colophon''s sanctuary at Claros and its port at Notion lie a few kilometres to the south; seen together, the three tell the city''s story more clearly.'),
  ('smyrna', 'tr', 'Bayraklı''daki Tepekule höyüğü, İzmir''in ilk kuruluş yeri olan Eski Smyrna''dır. Bir zamanlar körfeze uzanan küçük bir yarımadada kurulan yerleşim, MÖ 7. yüzyılda surları ve Athena Tapınağı ile gelişti; Lidyalıların MÖ 600 dolaylarındaki saldırısıyla yıkıldı. Kent, Helenistik dönemde Kadifekale''nin eteğine taşındı.

Kazı alanında sur kalıntıları, tapınak terasının temelleri ve ilk dönem evlerin izleri görülür. Homeros''un burada yaşadığına dair anlatılar alana ayrı bir anlam katar. Bayraklı''nın gökdelenleri arasında kalan bu sessiz tepe, kentin 3.000 yılı aşan tarihini görmek için ilginç bir duraktır.'),
  ('smyrna', 'en', 'The Tepekule mound in Bayraklı is Old Smyrna, the original site of İzmir. Founded on a small peninsula that once reached into the gulf, the settlement grew in the 7th century BC with its walls and Temple of Athena, and was destroyed by the Lydians around 600 BC. In the Hellenistic period the city moved to the foot of Kadifekale.

On the excavation site you can see remains of the walls, the foundations of the temple terrace and traces of the earliest houses. Traditions that Homer lived here give the site extra meaning. Set among Bayraklı''s towers, this quiet hill is an interesting stop to see more than 3,000 years of the city''s history.'),
  ('teos', 'tr', 'Seferihisar''da, Sığacık''ın hemen güneyindeki Teos, İyon Birliği''nin önemli kentlerindendi. Şair Anakreon''un memleketi olan kent, şarap ve tiyatro tanrısı Dionysos''a bağlılığıyla bilinir; Dionysos sanatçılarının birliği bir dönem burada toplandı.

Zeytinlikler arasına yayılan alanda Dionysos Tapınağı, tiyatro, odeion ve meclis binası gezilebilir; liman tarafında kıyıya inen yollar da vardır. Sığacık Kalesi ve limanıyla aynı gün görülebilir. Gölge az olduğundan sabah ya da akşamüstünü seçin. Tapınak ayrıca işaretlenebilir.'),
  ('teos', 'en', 'Just south of Sığacık in Seferihisar, Teos was one of the important cities of the Ionian League. The hometown of the poet Anacreon, it was known for its devotion to Dionysus, god of wine and theatre, and the guild of Dionysian artists was based here for a time.

Across the site, spread among olive groves, you can visit the Temple of Dionysus, the theatre, the odeion and the council house, with paths leading down towards the harbour. It fits into the same day as Sığacık Castle and harbour. Shade is scarce, so choose the morning or late afternoon. The temple can be checked off separately.'),
  ('kyme', 'tr', 'Aliağa''da, Nemrut Körfezi kıyısındaki Kyme, antik Aiolis bölgesinin en önemli kentiydi. Güçlü bir liman kentiydi ve antik kaynaklara göre şair Hesiodos''un babası buradan göç etmişti.

Kazılarda agora, tapınak ve liman yapılarına ait kalıntılar ortaya çıkarıldı; ancak alan sanayi bölgesine yakın olduğundan çevresi pek çekici değildir. Arkeoloji meraklıları için, Foça ya da Çandarlı yolunda kısa bir durak olarak uygundur. Gitmeden önce kazı alanının ziyarete açık olup olmadığını kontrol edin.'),
  ('kyme', 'en', 'Kyme, on the shore of Nemrut Bay in Aliağa, was the most important city of ancient Aeolis. It was a strong harbour town, and according to ancient sources the father of the poet Hesiod emigrated from here.

Excavations have uncovered remains of the agora, temples and harbour structures, though the surroundings are not very attractive because of the nearby industrial zone. For archaeology lovers it makes a short stop on the road to Foça or Çandarlı. Check whether the excavation area is open before you go.'),
  ('klaros', 'tr', 'Menderes''in Ahmetbeyli mahallesindeki Klaros, antik dünyanın ünlü kehanet merkezlerinden biriydi. Kolophon kentinin kutsal alanı olan Klaros''ta Apollon Klarios''a adanmış tapınak bulunuyordu; kehanet almak için uzak kentlerden heyetler gelirdi.

Tapınağın altında, rahiplerin kutsal kaynağa ulaştığı yeraltı koridorları görülebilir. Apollon, Artemis ve Leto''nun dev heykellerinin parçaları, sunaklar ve kutsal yol üzerindeki yazıtlı taşlar alanın en ilginç parçalarıdır. Notion ve Ahmetbeyli plajı çok yakındır.'),
  ('klaros', 'en', 'Claros, in the Ahmetbeyli quarter of Menderes, was one of the famous oracle centres of the ancient world. As the sanctuary of the city of Colophon, it held a temple to Apollo Clarius, and delegations came from distant cities to consult the oracle.

Beneath the temple you can see the underground corridors through which the priests reached the sacred spring. Fragments of the colossal statues of Apollo, Artemis and Leto, the altars and the inscribed stones along the sacred way are the most interesting parts of the site. Notion and Ahmetbeyli beach are very close.'),
  ('lebedos', 'tr', 'Ürkmez yakınlarında denize uzanan bir yarımada üzerindeki Lebedos, on iki İyon kentinden biriydi. Teos ile Efes arasında yer alan küçük bir liman kentiydi; Helenistik dönemde Dionysos sanatçılarının birliğine bir süre ev sahipliği yaptığı bilinir.

Bugün yarımadada sur kalıntıları ve yapı temelleri görülür; alan bakımsızdır ve tabela azdır, bu yüzden keşif duygusu arayanlar için uygundur. Ürkmez sahili ve Gümüldür''ün koylarıyla birlikte bir yaz gününe eklenebilir.'),
  ('lebedos', 'en', 'On a peninsula reaching into the sea near Ürkmez, Lebedos was one of the twelve Ionian cities. It was a small harbour town between Teos and Ephesus, and in the Hellenistic period it is known to have hosted the guild of Dionysian artists for a time.

Today you can see remains of walls and building foundations on the peninsula; the site is unkempt and has few signs, so it suits those looking for a sense of discovery. Add it to a summer day at Ürkmez beach and the coves of Gümüldür.'),
  ('meryem-kilisesi', 'tr', 'Efes''teki Meryem Kilisesi, Hz. Meryem''e (Theotokos) adanmış ilk büyük kiliselerden biridir. MS 431''de toplanan Üçüncü Ekümenik Konsil''in burada yapıldığına inanılır; bu nedenle Konsil Kilisesi olarak da anılır. Kilise, daha önceki bir Roma yapısının uzun salonuna yerleştirilmişti.

Uzun bazilika planının izleri, sütun kaideleri ve iyi korunmuş vaftizhanesi görülebilir. Ören yerinin alt girişine yakın, ana yolun biraz kuzeyinde kalır; liman caddesi tarafına yürüyüşte kolayca eklenir. Hristiyanlık tarihi açısından Efes''in en önemli noktalarından biridir.'),
  ('meryem-kilisesi', 'en', 'The Church of Mary at Ephesus is one of the first great churches dedicated to Mary as Theotokos (Mother of God). The Third Ecumenical Council of AD 431 is believed to have been held here, which is why it is also called the Church of the Councils. The church was set into the long hall of an earlier Roman building.

You can see traces of its long basilica plan, column bases and a well-preserved baptistery. It lies near the lower entrance of the site, a little north of the main path, and is easily added to a walk along the Harbour Street. It is one of the most important places at Ephesus for the history of Christianity.'),
  ('notion', 'tr', 'Ahmetbeyli''de, Kuşadası Körfezi''ne bakan iki doruklu bir tepe üzerindeki Notion, Kolophon''un liman kentiydi. Adı Yunanca ''güneydeki'' anlamına gelir. Sonraki dönemde Kolophon halkının bir kısmının buraya taşınmasıyla kent ''deniz kıyısındaki Kolophon'' olarak da anıldı.

Surların, agoranın, tiyatronun ve tapınak temellerinin kalıntıları denize bakan yamaçlara yayılır; manzarası ziyaretin en güzel yanıdır. Tepeye patika ile çıkılır, rahat ayakkabı giyin. Aşağıdaki plaj ve Klaros ile aynı gezide görülebilir.'),
  ('notion', 'en', 'On a two-peaked hill overlooking the Gulf of Kuşadası at Ahmetbeyli, Notion was the port of Colophon. Its name means ''the southern one'' in Greek. When part of Colophon''s population later moved here, the city was also known as ''Colophon by the sea''.

Remains of walls, the agora, the theatre and temple foundations spread over the slopes facing the sea, and the view is the best part of the visit. A footpath leads up the hill, so wear comfortable shoes. It can be combined with the beach below and with Claros.'),
  ('kizil-avlu', 'tr', 'Bergama''nın merkezindeki Kızıl Avlu, MS 2. yüzyılda, büyük olasılıkla İmparator Hadrianus döneminde Mısır tanrıları için yapılmış dev bir tapınaktır. Kırmızı tuğla duvarları nedeniyle bu adı alır. Bizans döneminde içine bir kilise yerleştirildi; Vahiy Kitabı''nda anılan yedi kiliseden Bergama kilisesiyle ilişkilendirilir.

Yapının altında Selinos Çayı''nın geçtiği tüneller vardır; yanlardaki kulelerden birinde kutsal havuzlar ve heykel parçaları görülebilir. Ölçeği yakından bakınca etkileyicidir. Bergama çarşısının içinde olduğundan akropol ve Asklepion ile aynı gün gezilir.'),
  ('kizil-avlu', 'en', 'The Red Basilica in central Bergama is a vast temple built in the 2nd century AD, most likely under the Emperor Hadrian, for Egyptian gods. It takes its name from its red brick walls. In the Byzantine period a church was set inside it, associated with the church of Pergamon, one of the seven churches named in the Book of Revelation.

Beneath the building are tunnels carrying the Selinus stream; in one of the side towers you can see sacred pools and sculpture fragments. Its scale is impressive up close. Being inside Bergama''s market area, it is visited on the same day as the acropolis and the Asklepion.'),
  ('larissa', 'tr', 'Menemen''in Buruncuk köyü yakınındaki tepede bulunan Larissa, Aiolis bölgesinin en eski kentlerinden biridir. Gediz (Hermos) ovasına hâkim konumuyla önemli bir yerleşimdi; alan 20. yüzyılın başlarında yapılan kazılarla tanındı.

Tepede sur parçaları ve yapı temelleri görülür; alan küçük ve bakımsızdır, tabela azdır. Tepeden Gediz ovasının geniş bir manzarası açılır. Arkeoloji meraklıları için Menemen''den Foça''ya giderken kısa bir durak olabilir.'),
  ('larissa', 'en', 'On a hill near the village of Buruncuk in Menemen, Larissa is one of the oldest cities of the Aeolis region. Commanding the plain of the Gediz (Hermos), it was an important settlement, and the site became known through excavations in the early 20th century.

Fragments of walls and building foundations can be seen on the hill; the site is small, unkempt and has few signs. The hill offers a wide view over the Gediz plain. For archaeology lovers it can be a short stop on the way from Menemen to Foça.'),
  ('metropolis', 'tr', 'Torbalı yakınlarında, Yeniköy''deki Metropolis antik kenti, adını ''ana tanrıça kenti'' anlamından alır. Tepedeki yerleşimin izleri Neolitik çağa kadar iner; kent asıl gelişimini Helenistik ve Roma dönemlerinde yaşadı.

Küçük ama zarif tiyatrosu, hamamlar, stoa ve meclis binası kalıntıları görülebilir; kazılarda çıkan eserlerin bir kısmı yakındaki kazı evinde ve müzelerdedir. Çok kalabalık olmayan, tepeden ovaya bakan huzurlu bir alandır. Efes yoluna yakın olduğundan aynı güne eklenebilir.'),
  ('metropolis', 'en', 'The ancient city of Metropolis at Yeniköy near Torbalı takes its name from its meaning, ''city of the mother goddess''. Traces of settlement on the hill go back to the Neolithic, but the city flourished mainly in the Hellenistic and Roman periods.

You can see its small but elegant theatre, baths, a stoa and the council house; some of the finds are kept in the dig house nearby and in museums. It is an uncrowded, peaceful site looking out from the hill over the plain. Being close to the road to Ephesus, it can be added to the same day.'),
  ('st-jean-bazilikasi', 'tr', 'Selçuk''ta Ayasuluk Tepesi''nin yamacındaki Aziz Yuhanna Bazilikası, Havari Yuhanna''nın mezarı olduğuna inanılan yerin üzerine 6. yüzyılda İmparator I. Justinianus tarafından yaptırıldı. İstanbul''daki Havariler Kilisesi örnek alınarak haç planlı ve çok kubbeli olarak tasarlanmıştı.

Kısmen yeniden dikilen sütunlar, mezar odasının bulunduğu bölüm ve vaftizhane gezilebilir. Bazilikanın terasından İsa Bey Camii, Artemis Tapınağı''nın tek sütunu ve ova görülür. Tepedeki Ayasuluk Kalesi ile birlikte gezilir; yokuş gölgesizdir, sabah ya da akşamüstü gidin.'),
  ('st-jean-bazilikasi', 'en', 'On the slope of Ayasuluk Hill in Selçuk, the Basilica of St John was built in the 6th century by the Emperor Justinian I over the place believed to be the tomb of John the Apostle. Modelled on the Church of the Holy Apostles in Constantinople, it was designed on a cross plan with several domes.

You can walk among the partly re-erected columns, the area of the tomb chamber and the baptistery. From the basilica''s terrace you see the İsa Bey Mosque, the single column of the Temple of Artemis and the plain. It is visited together with Ayasuluk Castle at the top; the climb is shadeless, so go in the morning or late afternoon.'),
  ('belevi-anit-mezari', 'tr', 'Selçuk''a bağlı Belevi''deki anıt mezar, Efes''e yaklaşık 14 km uzaklıktadır ve Helenistik dönemin en büyük mezar anıtlarından biridir. Kimin için yapıldığı tartışmalıdır; Makedon kralı Lysimakhos için başlatıldığı ve sonradan bir Seleukos kralının gömüldüğü düşünülür. Mezardan çıkan lahit Efes Müzesi''ndedir.

Kayaya oyulmuş kare kaidesi ve çevresindeki mimari parçalar, yapının ne kadar görkemli olduğunu gösterir. Yol kenarında, kolay ulaşılan bir alandır; İzmir''den Selçuk''a giderken kısa bir mola için uygundur.'),
  ('belevi-anit-mezari', 'en', 'The monumental tomb at Belevi, in Selçuk district, lies about 14 km from Ephesus and is one of the largest funerary monuments of the Hellenistic period. Who it was built for is debated; it is thought to have been begun for the Macedonian king Lysimachus and later used for the burial of a Seleucid king. The sarcophagus found in the tomb is in the Ephesus Museum.

Its square base carved from the rock and the architectural pieces around it show how grand the building was. It is right by the road and easy to reach, making a short break on the way from İzmir to Selçuk.'),
  ('yesilova-hoyugu', 'tr', 'Bornova''daki Yeşilova Höyüğü, İzmir''in bilinen en eski yerleşimidir. 2003''te bulunan höyükte, yaklaşık MÖ 6500 ile 4000 arasında kesintisiz yaşanan bir tarım köyünün izleri ortaya çıkarıldı. O dönemde körfezin kıyısı buraya çok daha yakındı.

Kazı alanının yanındaki ziyaretçi merkezinde buluntular sergilenir ve yeniden yapılmış Neolitik evler, insanların 8.000 yıl önce nasıl yaşadığını gösterir. Çocuklu aileler için öğretici bir duraktır. Kent içinde, Bornova''ya kolay ulaşılır.'),
  ('yesilova-hoyugu', 'en', 'Yeşilova Mound in Bornova is the oldest known settlement in İzmir. Discovered in 2003, it has revealed a farming village lived in continuously from roughly 6500 to 4000 BC. At that time the shore of the gulf was much closer.

The visitor centre beside the excavation displays finds, and reconstructed Neolithic houses show how people lived 8,000 years ago. It is an educational stop for families with children. It is within the city and easy to reach in Bornova.'),
  ('efes-tiyatrosu', 'tr', 'Efes''in Büyük Tiyatrosu, Panayır Dağı''nın yamacına oyulmuştur ve yaklaşık 25.000 kişilik kapasitesiyle antik dünyanın en büyük tiyatrolarındandır. Helenistik dönemde yapıldı, Roma döneminde genişletildi. Yeni Ahit''te anlatılan, Aziz Pavlus''a karşı gümüşçülerin ayaklanması burada geçer.

Basamakların üst sıralarından Liman Caddesi''nin denize doğru uzanan düz çizgisi görülür; eskiden bu cadde limana ulaşıyordu. Sahne binasının kalıntıları ve akustik, yukarıdan aşağı bakınca daha iyi anlaşılır. Basamaklar yüksek ve kaygandır, dikkatli inin.'),
  ('efes-tiyatrosu', 'en', 'The Great Theatre of Ephesus is carved into the slope of Mount Panayır and, with room for about 25,000 people, is one of the largest theatres of the ancient world. Built in the Hellenistic period, it was enlarged under the Romans. The silversmiths'' riot against St Paul described in the New Testament took place here.

From the upper rows you see the straight line of the Harbour Street running towards the sea, which once reached the harbour. The remains of the stage building and the acoustics are best appreciated from above. The steps are high and slippery, so go down carefully.'),
  ('yedi-uyurlar-mezarligi', 'tr', 'Efes''e yaklaşık 1 km uzaklıkta, Panayır Dağı''nın kuzeydoğu yamacındaki Yedi Uyurlar, ünlü bir efsaneyle anılır: Roma İmparatoru Decius döneminde zulümden kaçan yedi Hristiyan genç bir mağarada uykuya dalar ve yaklaşık iki yüzyıl sonra uyanır. Efsane Kur''an''da da Ashab-ı Kehf olarak anlatılır.

Bugün yamaçta, Bizans döneminde efsane etrafında gelişen mezarlık ve kilisenin kalıntıları görülür. Alanın yakınındaki gözleme ve köy kahvaltısı yapılan yerler, Efes gezisinden sonra mola vermek için popülerdir. Efes alt girişine yakındır.'),
  ('yedi-uyurlar-mezarligi', 'en', 'About 1 km from Ephesus, on the north-east slope of Mount Panayır, the Seven Sleepers are tied to a famous legend: fleeing persecution under the Roman Emperor Decius, seven young Christians fall asleep in a cave and wake about two centuries later. The story is also told in the Quran as the Companions of the Cave.

On the slope today you can see the remains of the cemetery and church that grew up around the legend in Byzantine times. The gözleme and village breakfast places nearby are popular for a break after visiting Ephesus. It is close to the lower entrance of Ephesus.'),
  ('bergama-kutuphanesi', 'tr', 'Pergamon akropolündeki kütüphane, Athena Kutsal Alanı''nın yanında yer alıyordu ve antik dünyanın en önemli kütüphanelerinden biriydi. Attalos kralları onu İskenderiye Kütüphanesi''nin rakibi olarak büyüttü. Anlatılana göre Mısır''ın papirüs ihracatını yasaklaması üzerine Bergama''da parşömen yaygınlaştı; ''parşömen'' kelimesi de kentin adından gelir.

Bugün okuma salonunun temelleri ve rafların yerleştirildiği duvar boşlukları görülebilir. Akropolün tepesinde, Trajan Tapınağı ve tiyatroya giden yol üzerindedir. Rüzgârlı ve gölgesiz alan için şapka alın.'),
  ('bergama-kutuphanesi', 'en', 'The library on the Pergamon acropolis stood beside the Sanctuary of Athena and was one of the most important libraries of the ancient world. The Attalid kings built it up as a rival to the Library of Alexandria. According to tradition, when Egypt banned the export of papyrus, parchment came into wide use at Pergamon, and the word ''parchment'' derives from the city''s name.

Today you can see the foundations of the reading room and the wall recesses where the shelves stood. It is at the top of the acropolis, on the way to the Temple of Trajan and the theatre. Bring a hat for this windy, shadeless site.'),
  ('imparatorlar-tapinagi-ve-sunagi-ile-domitianus-terasi', 'tr', 'Efes''te, Devlet Agorası''nın yakınındaki büyük teras, MS 89-90''da Flavius hanedanı imparatorlarına adanan tapınağı taşıyordu. Uzun süre Domitianus Tapınağı olarak anılan yapı, bugün yazıtlardan bilinen adıyla Sebastoi (İmparatorlar) Tapınağı olarak tanımlanır. Efes''e imparator kültü için tapınak kurma hakkının verilmesi kent için büyük bir onurdu.

Teras duvarları ve alt kattaki tonozlu mekânlar görülebilir; tapınaktaki dev imparator heykelinin parçaları müzelerde korunur. Üst girişten Kuretler Caddesi''ne inerken Memmius Anıtı ile birlikte yolunuzun üzerindedir.'),
  ('imparatorlar-tapinagi-ve-sunagi-ile-domitianus-terasi', 'en', 'Near the State Agora in Ephesus, the great terrace carried the temple dedicated in AD 89-90 to the emperors of the Flavian dynasty. Long known as the Temple of Domitian, it is now identified by its name from inscriptions as the Temple of the Sebastoi (the Emperors). Being granted the right to build a temple for the imperial cult was a great honour for Ephesus.

You can see the terrace walls and the vaulted rooms of the lower level; fragments of the colossal imperial statue from the temple are kept in museums. It lies on your way, with the Memmius Monument, as you walk down from the upper entrance to Curetes Street.'),
  ('bouleuterion-odeion', 'tr', 'Efes''in Devlet Agorası''nın kuzeyindeki Bouleuterion, kent meclisinin toplandığı yarım daire biçimli yapıdır; konserler için de kullanıldığından Odeion olarak da anılır. Bugünkü hâli MS 2. yüzyılda, Efesli zengin Vedius Antoninus ve eşi Flavia Papiane''nin bağışıyla yapıldı.

Yaklaşık 1.500 kişilik oturma sıraları iyi korunmuştur; eskiden üzeri ahşap bir çatıyla örtülüydü. Üst girişten ören yerine girince ilk karşılaşılan yapılardandır. Basamaklarda oturup Devlet Agorası''na bakmak, kentin yönetim merkezini hayal etmek için iyi bir başlangıçtır.'),
  ('bouleuterion-odeion', 'en', 'North of the State Agora in Ephesus, the Bouleuterion is the semicircular building where the city council met; since it was also used for concerts, it is known as the Odeion too. Its present form dates from the 2nd century AD, funded by the wealthy Ephesian Vedius Antoninus and his wife Flavia Papiane.

Its rows of seats for about 1,500 people are well preserved; it was once covered by a wooden roof. It is one of the first buildings you meet on entering the site from the upper gate. Sitting on the steps and looking out over the State Agora is a good way to start imagining the city''s centre of government.'),
  ('hadrianus-tapinagi-embolos', 'tr', 'Efes''in Kuretler Caddesi üzerindeki küçük Hadrianus Tapınağı, 2. yüzyılın ilk yarısında İmparator Hadrianus onuruna yapıldı. Ön cephesindeki kemerin ortasında kentin koruyucu tanrıçası Tykhe''nin büstü, içerideki kapı lentosunun üstünde ise bir Medusa kabartması yer alır.

Zarif cephesiyle Celsus Kütüphanesi''nden sonra Efes''in en çok fotoğraflanan yapılarındandır. Yerinde görülen frizler kopyadır, asılları Efes Müzesi''nde sergilenir. Hemen yanında Skolastika Hamamı ve Latrina bulunur.'),
  ('hadrianus-tapinagi-embolos', 'en', 'The small Temple of Hadrian on Curetes Street in Ephesus was built in the first half of the 2nd century in honour of the Emperor Hadrian. A bust of Tyche, the city''s protective goddess, sits at the centre of the arch on its front, and a Medusa relief is set above the inner doorway.

With its elegant façade it is, after the Library of Celsus, one of the most photographed buildings at Ephesus. The friezes on site are copies; the originals are displayed in the Ephesus Museum. The Baths of Scholastica and the public latrine are right next to it.'),
  ('dionysos-tapinagi-teos', 'tr', 'Teos''taki Dionysos Tapınağı, Helenistik dönemde ünlü mimar Hermogenes tarafından tasarlandı ve antik dünyada Dionysos''a adanmış en büyük tapınak olarak bilinir. İon düzeninde yapılan tapınak, Teos''un şarap ve tiyatro tanrısına olan bağlılığının simgesiydi.

Kazılardan sonra bazı sütunları yeniden ayağa kaldırıldı; zeytin ağaçlarının arasında yükselen sütunlar özellikle akşamüstü ışığında çok güzeldir. Teos ören yerinin merkezinde olduğundan tiyatro ve odeionla aynı yürüyüşte görülür.'),
  ('dionysos-tapinagi-teos', 'en', 'The Temple of Dionysus at Teos was designed in the Hellenistic period by the famous architect Hermogenes and is known as the largest temple dedicated to Dionysus in the ancient world. Built in the Ionic order, it symbolised Teos''s devotion to the god of wine and theatre.

Some of its columns were re-erected after excavation; rising among olive trees, they look especially lovely in late-afternoon light. Being at the centre of the Teos site, it is seen on the same walk as the theatre and the odeion.'),
  ('prytaneion-belediye-sarayi', 'tr', 'Efes''teki Prytaneion, kentin yönetim binası ve dini merkezlerinden biriydi. Burada, kentin yaşamını simgeleyen ve Hestia''ya adanmış kutsal ateş sürekli yanık tutulurdu. Bugün Efes Müzesi''nde sergilenen ünlü Artemis heykellerinden ikisi bu yapının kazısında bulundu.

Ayakta kalan Dor düzenindeki sütunlar ve yazıtlı mimari parçalar, Devlet Agorası''nın kuzey kenarında görülür. Bouleuterion''un hemen yanında olduğundan üst girişten girdikten sonra ilk dakikalarda görülür.'),
  ('prytaneion-belediye-sarayi', 'en', 'The Prytaneion at Ephesus was one of the city''s administrative and religious centres. Here the sacred flame dedicated to Hestia, symbolising the life of the city, was kept burning at all times. Two of the famous statues of Artemis now displayed in the Ephesus Museum were found during its excavation.

Its standing Doric columns and inscribed architectural pieces are seen on the north side of the State Agora. As it is right beside the Bouleuterion, you reach it in the first minutes after entering by the upper gate.')
  ) v(slug, lang, long_desc)
  join public.places p on p.slug = v.slug
 where t.place_id = p.id and t.lang = v.lang;
