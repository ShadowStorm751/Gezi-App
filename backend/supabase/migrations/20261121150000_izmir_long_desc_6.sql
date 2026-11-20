-- İzmir uzun açıklamaları, 6. parti (17 yer, TR + EN).
-- Üreten: data-pipeline/content/build_long_desc.py (kaynak: content/izmir_long_descriptions.py).
-- Metinler kendi cümlelerimizdir; Vikipedi/Wikidata yalnızca bilgi kontrolü için kullanıldı.

update public.place_translations t
   set long_desc = v.long_desc
  from (values
  ('hasanaga-bahcesi', 'tr', 'Buca''daki Hasanağa Bahçesi, bir zamanlar Levanten iş insanı Aliotti''ye ait bir köşk ve bahçeydi. 1920''lerin ortasında Sarıgöllü Hasan Ağa tarafından satın alındı ve bugünkü adını aldı. Uzun yıllar özel mülk olarak kalan alan, sonradan belediyeye geçerek halka açık bir parka dönüştürüldü.

Yaşlı ağaçların gölgesindeki yürüyüş yolları ve tarihi köşk yapısı, Buca''nın bağ evleri ve köşklerle dolu geçmişini hatırlatır. Sakin bir mola ya da piknik için uygundur. Yakında açılması planlanan metro istasyonu ulaşımı kolaylaştıracaktır; Buca''daki Levanten köşkleriyle aynı gezide görülebilir.'),
  ('hasanaga-bahcesi', 'en', 'Hasanağa Garden in Buca was once a mansion and garden belonging to the Levantine businessman Aliotti. In the mid-1920s it was bought by Hasan Ağa of Sarıgöl and took its present name. Long a private property, the grounds later passed to the municipality and became a public park.

The walking paths under old trees and the historic mansion recall Buca''s past of country houses and villas. It suits a quiet break or a picnic. A metro station planned nearby will make it easier to reach, and it can be seen on the same outing as Buca''s Levantine mansions.'),
  ('ayibaligi-plaji', 'tr', 'Karaburun Yarımadası''nın doğu kıyısında, Mordoğan yakınlarındaki Ayıbalığı Koyu, adını bu kıyılarda yaşayan Akdeniz foklarından (ayıbalığı) alır. Kayalık kıyılar arasında küçük bir kumsal ve son derece berrak bir deniz sunar.

Kalabalık plajlardan uzak, doğal bir koy arayanlar için uygundur; tesis sınırlıdır, bu yüzden yiyecek, su ve gölgelik getirin. Foklar nadiren görülür; görürseniz yaklaşmayın ve rahatsız etmeyin. Yolu virajlıdır; Mordoğan ve Karaburun köyleriyle birlikte bir yarımada turuna eklenebilir.'),
  ('ayibaligi-plaji', 'en', 'On the east coast of the Karaburun Peninsula near Mordoğan, Ayıbalığı Cove takes its name from the Mediterranean monk seals (ayıbalığı) that live along these shores. Between rocky shores it offers a small beach and exceptionally clear water.

It suits those looking for a natural cove away from busy beaches; facilities are limited, so bring food, water and shade. The seals are rarely seen; if you do see one, keep your distance and do not disturb it. The road is winding; add it to a tour of the peninsula with Mordoğan and Karaburun''s villages.'),
  ('badembuku-koyu', 'tr', 'Karaburun Yarımadası''ndaki Badembükü Koyu, adını çevresindeki badem ağaçlarından alan, doğal haliyle korunmuş sakin bir koydur. Yarımadanın daha az bilinen köşelerinden biridir.

Berrak denizi ve kalabalıktan uzak ortamıyla yüzmek ve dinlenmek için uygundur. Tesis yok denecek kadar azdır; su, yiyecek ve gölgelik getirin, çöplerinizi geri götürün. Koya ulaşan yolun bir kısmı dar ve bozuk olabilir, dikkatli sürün.'),
  ('badembuku-koyu', 'en', 'Badembükü Cove on the Karaburun Peninsula, named after the almond trees around it, is a quiet cove kept in its natural state. It is one of the less-known corners of the peninsula.

Its clear water and uncrowded setting make it good for swimming and relaxing. Facilities are almost non-existent; bring water, food and shade, and take your rubbish back with you. Part of the road to the cove may be narrow and rough, so drive carefully.'),
  ('ekmeksiz-plaji', 'tr', 'Seferihisar''da, Sığacık''ın yakınındaki Ekmeksiz Plajı, ilçenin en uzun kumsallarından biridir. İnce kumu ve yavaş derinleşen denizi nedeniyle özellikle aileler tarafından tercih edilir.

Plajın bir bölümü halka açık, bir bölümü işletmelerle donatılmıştır. Yaz hafta sonlarında kalabalık olur; sabah erken gidin. Sığacık Kalesi, limanı ve Teos antik kentiyle aynı gün birleştirilebilir.'),
  ('ekmeksiz-plaji', 'en', 'Near Sığacık in Seferihisar, Ekmeksiz Beach is one of the longest sandy beaches in the district. With its fine sand and gently shelving sea, it is especially popular with families.

Part of the beach is public and part is equipped by businesses. It gets busy on summer weekends, so go early. It combines in one day with Sığacık Castle and harbour and the ancient city of Teos.'),
  ('pamucak-sahili', 'tr', 'Selçuk''a bağlı Pamucak, Küçük Menderes Nehri''nin denize döküldüğü yerin yakınında uzanan, kilometrelerce uzun ve geniş bir kumsaldır. Efes''e birkaç kilometre uzaklıktadır; antik çağda kentin limanı da bu kıyıya yakındı.

Geniş kumsalı sayesinde kalabalık günlerde bile yer bulmak kolaydır. Açık denize bakan kıyıda zaman zaman dalga ve akıntı olabilir; çocuklarla dikkatli olun. Efes gezisinden sonra serinlemek ve gün batımını izlemek için iyi bir seçenektir.'),
  ('pamucak-sahili', 'en', 'Pamucak, part of Selçuk, is a broad sandy beach stretching for kilometres near where the Küçük Menderes River meets the sea. It lies a few kilometres from Ephesus, whose ancient harbour was also close to this coast.

Thanks to its width, it is easy to find space even on busy days. Facing the open sea, the shore can have waves and currents at times, so take care with children. It is a good choice for cooling off and watching the sunset after visiting Ephesus.'),
  ('akarca-sahili', 'tr', 'Seferihisar''daki Akarca Sahili, sığ ve sakin denizi, yazlık siteleri ve sahil yürüyüş yoluyla bilinir. İzmir''e yakınlığı nedeniyle kentlilerin hafta sonu kaçış noktalarından biridir.

Denizin uzun süre sığ kalması küçük çocuklu aileler için rahattır. Sahil boyunca kafeler ve küçük plajlar sıralanır. Seferihisar merkezindeki pazar ve Sığacık Kalesi ile birlikte bir gün planlanabilir.'),
  ('akarca-sahili', 'en', 'Akarca Beach in Seferihisar is known for its shallow, calm sea, summer housing and seaside promenade. Being close to İzmir, it is one of the city''s weekend escapes.

The long stretch of shallow water is comfortable for families with small children. Cafés and small beaches line the shore. A day can be planned together with the market in central Seferihisar and Sığacık Castle.'),
  ('alacati-bay-surf-beach', 'tr', 'Alaçatı''nın güneyindeki koy, yaz boyunca düzenli esen kuzey rüzgârı ve sığ suyu sayesinde dünyanın önemli rüzgâr sörfü noktalarından biri sayılır. Koy kıyısında çok sayıda sörf okulu ve ekipman kiralama yeri bulunur; uluslararası yarışlara da ev sahipliği yapmıştır.

Rüzgârın neredeyse her gün estiği yaz ayları, öğrenmek için de uygun zamandır; sığ su yeni başlayanlara güven verir. Yüzmek için rüzgârsız günleri ya da sabah saatlerini seçin. Gün sonunda Alaçatı''nın taş sokaklarına geçebilirsiniz.'),
  ('alacati-bay-surf-beach', 'en', 'The bay south of Alaçatı, with its steady northerly summer wind and shallow water, is counted among the world''s notable windsurfing spots. Its shore is lined with surf schools and equipment rental, and it has hosted international competitions.

The summer months, when the wind blows almost daily, are also a good time to learn, and the shallow water gives beginners confidence. For swimming, choose windless days or the morning. At the end of the day you can head into the stone streets of Alaçatı.'),
  ('altinkum-plaji', 'tr', 'Çeşme''nin güneyindeki Altınkum, ince altın renkli kumu ve turkuaz denizi olan birkaç koydan oluşur. Çeşme''nin en güzel plajları arasında sayılır ve hem halka açık bölümleri hem de işletmeleri vardır.

Deniz berrak ve yavaş derinleşir; ancak Ege suyu yazın bile serin olabilir. Yaz hafta sonlarında otopark erken dolar, sabah erken gitmek iyi olur. Çeşme merkezi ve Alaçatı''ya kısa bir sürüş uzaklığındadır.'),
  ('altinkum-plaji', 'en', 'South of Çeşme, Altınkum is made up of several coves with fine golden sand and turquoise water. It is counted among Çeşme''s most beautiful beaches and has both public sections and beach businesses.

The water is clear and shelves gently, though the Aegean can be cool even in summer. Parking fills up early on summer weekends, so arrive early. It is a short drive from central Çeşme and Alaçatı.'),
  ('dikili-halk-plaji', 'tr', 'Dikili''nin merkezine yakın halk plajı, ilçenin uzun kumsal şeridi boyunca uzanır. Ücretsiz ve kolay ulaşılabilir olduğu için yazın hem yerel halkın hem de yazlıkçıların buluşma yeridir.

Sahil boyunca yürüyüş yolu, çay bahçeleri ve balık restoranları bulunur. Gün batımında Midilli Adası''na doğru batan güneşi izlemek güzeldir. Çandarlı Kalesi ve Bergama, aynı tatil içinde gezilebilecek yakınlıktadır.'),
  ('dikili-halk-plaji', 'en', 'The public beach near central Dikili stretches along the district''s long sandy shore. Free and easy to reach, it is a summer meeting place for locals and holidaymakers alike.

A promenade, tea gardens and fish restaurants line the shore. Watching the sun set towards Lesbos is a treat. Çandarlı Castle and Bergama are close enough to visit during the same holiday.'),
  ('uzunada', 'tr', 'İzmir Körfezi''nin girişindeki Uzunada, yaklaşık 27 km²''lik yüzölçümüyle Türkiye''nin en büyük adalarından biridir. Antik çağda Drymoussa olarak anılan adada bugün yerleşim yoktur ve doğası büyük ölçüde korunmuştur.

Adanın bir bölümü askeri alan olduğundan karaya çıkış kısıtlıdır; adayı en iyi Karaburun ya da Foça''dan kalkan tekne turlarında, koylarında yüzerek tanıyabilirsiniz. Kıyılarında Akdeniz foklarının da yaşadığı bilinir; rastlarsanız uzak durun.'),
  ('uzunada', 'en', 'Uzunada, at the entrance to the Gulf of İzmir, is one of Turkey''s largest islands at about 27 km². Known in antiquity as Drymoussa, it has no settlement today and its nature is largely preserved.

As part of the island is a military area, landing is restricted; the best way to get to know it is on a boat trip from Karaburun or Foça, swimming in its coves. Mediterranean monk seals are known to live along its shores; if you meet one, keep away.'),
  ('garip-adasi', 'tr', 'Dikili''nin Bademli Koyu açığındaki Garip Adası, Kalem Adası ile yan yana duran küçük bir adadır. Yakındaki Kane Yarımadası ile birlikte bu kıyının doğal dokusunun parçasıdır.

Adada yerleşim yoktur; çevresi tekne turları, yüzme ve dalış için tercih edilir. Bademli koyundan bakınca gün batımında özellikle güzel görünür. Gezilerinizi tekneyle planlayın ve doğal alana saygılı olun.'),
  ('garip-adasi', 'en', 'Garip Island, off Bademli Bay in Dikili, is a small island lying side by side with Kalem Island. Together with the nearby Kane Peninsula, it is part of the natural landscape of this coast.

The island is uninhabited; the waters around it are popular for boat trips, swimming and diving. Seen from Bademli bay it looks especially lovely at sunset. Plan your visit by boat and respect the natural area.'),
  ('karantina-adasi', 'tr', 'Urla''daki Karantina Adası, adını 1865''te Fransızların burada kurduğu karantina tesislerinden alır. Osmanlı döneminde İzmir''e gelen gemilerin yolcuları bulaşıcı hastalıklara karşı burada bekletilirdi; tesis, kendi döneminin oldukça gelişmiş bir sağlık yapısıydı. Antik Klazomenai''nin bir bölümü de bu ada üzerindeydi.

Ada, kıyıya bir yolla bağlıdır. Tarihi yapılar ve adanın kıyısı, Urla İskele''deki balık restoranları ile birlikte kısa bir yürüyüş için uygundur. Bazı alanlar kamu kullanımında olabileceğinden kapalı bölümlere girmeyin.'),
  ('karantina-adasi', 'en', 'Karantina (Quarantine) Island in Urla takes its name from the quarantine facilities set up here by the French in 1865. In Ottoman times passengers on ships arriving at İzmir were held here as a precaution against infectious disease; the station was quite advanced for its time. Part of ancient Klazomenai also stood on this island.

The island is linked to the shore by a road. Its historic buildings and shoreline suit a short walk together with the fish restaurants at Urla İskele. Some areas may be in public use, so do not enter closed sections.'),
  ('cifit-adasi', 'tr', 'Seferihisar kıyısının hemen önündeki Çıfıtkalesi Adası, anakaraya yüz metreden daha yakın küçük bir adacıktır. Antik çağda burada Myonnesos yerleşimi bulunuyordu ve adacığın anakaraya bir set ile bağlı olduğu bilinir.

Adacıkta sur ve yapı kalıntıları görülebilir; çevresindeki berrak su yüzme ve şnorkel için çok uygundur. Kıyıdan kısa bir yüzüşle ya da kanoyla ulaşanlar olur; kayalık yüzeyde dikkatli olun ve kalıntılara zarar vermeyin.'),
  ('cifit-adasi', 'en', 'Just off the Seferihisar coast, Çıfıtkalesi is a small islet less than a hundred metres from the mainland. In antiquity the settlement of Myonnesos stood here, and the islet is known to have been joined to the mainland by a causeway.

Remains of walls and buildings can be seen on the islet, and the clear water around it is excellent for swimming and snorkelling. Some people reach it with a short swim or by canoe from the shore; take care on the rocky surface and do not damage the ruins.'),
  ('kalem-adasi', 'tr', 'Dikili''nin Bademli kıyısına yaklaşık 400 metre uzaklıktaki Kalem Adası, kuzey-güney yönünde uzanan dar ve uzun bir adadır. Garip Adası ile birlikte Bademli koyunun önünde yer alır.

Adanın çevresi, berrak suyu ve sakin koylarıyla tekne gezileri ve yüzme için tercih edilir. Ada üzerinde kamuya açık bir tesis bulunmadığından ziyaret genellikle tekneden yapılır; doğal alana saygılı olun.'),
  ('kalem-adasi', 'en', 'About 400 metres off the Bademli shore in Dikili, Kalem Island is a narrow, elongated island running north to south. Together with Garip Island it lies in front of Bademli bay.

With its clear water and quiet coves, the waters around the island are popular for boat trips and swimming. As there are no public facilities on the island, visits are usually made from a boat; respect the natural area.'),
  ('degirmendere-selalesi', 'tr', 'Değirmendere Şelalesi, orman içinde kısa bir yürüyüşle ulaşılan doğal bir şelaledir. Adını aldığı dere boyunca eskiden su değirmenlerinin bulunduğu bu vadi, İzmir''e yakın serin bir kaçış noktasıdır.

Şelalenin suyu yağışlı aylarda ve ilkbaharda en bol halindedir; yaz sonunda azalabilir. Patika kayalık ve yer yer kaygan olabilir, uygun ayakkabı giyin. Doğaya çöp bırakmayın ve ateş yakmayın.'),
  ('degirmendere-selalesi', 'en', 'Değirmendere Waterfall is a natural waterfall reached by a short walk through the forest. The valley, along the stream that once turned water mills and gave the place its name, is a cool escape close to İzmir.

The waterfall is at its fullest in the rainy months and in spring, and may dwindle by late summer. The path can be rocky and slippery in places, so wear suitable shoes. Leave no rubbish and do not light fires.'),
  ('buyuk-su-ucuran-selalesi', 'tr', 'Menemen''in kuzeyindeki dağlık alanda bulunan Büyük Su Uçuran Şelalesi, yürüyüşle ulaşılan yüksek bir şelaledir. Su, kayalık bir yamaçtan dökülürken adını veren görüntüyü oluşturur.

Şelaleye giden patika orman ve kayalıklar arasından geçer; yürüyüş deneyimi olanlar için uygundur. Su, kış ve ilkbahar aylarında en coşkulu halindedir. Yanınıza su alın, yalnız gitmemeye çalışın ve yağışlı günlerde kaygan kayalara dikkat edin.'),
  ('buyuk-su-ucuran-selalesi', 'en', 'In the hills north of Menemen, Büyük Su Uçuran (''Great Flying Water'') is a tall waterfall reached on foot. The water pours down a rocky slope, creating the sight that gives it its name.

The trail runs through forest and rocks and suits those with some hiking experience. The falls are at their most vigorous in winter and spring. Bring water, try not to go alone, and watch out for slippery rocks on rainy days.'),
  ('nebiler', 'tr', 'Dikili''nin Nebiler köyü yakınlarındaki şelale, dar bir kanyonun içinde akan derenin oluşturduğu bir dizi küçük çağlayan ve havuzdan oluşur. Çevre köylerin serinlemek için gittiği doğal bir alandır.

Kanyon boyunca yürürken bazı yerlerde suya girmek gerekebilir; su ayakkabısı işinize yarar. Su miktarı mevsime göre değişir, en canlı hali ilkbahardadır. Yağışlı havalarda dere aniden yükselebilir, dikkatli olun.'),
  ('nebiler', 'en', 'The waterfall near the village of Nebiler in Dikili is a series of small cascades and pools formed by a stream flowing through a narrow canyon. It is a natural spot where people from nearby villages come to cool off.

Walking along the canyon you may need to wade in places, so water shoes are useful. The amount of water varies with the season and is liveliest in spring. In rainy weather the stream can rise suddenly, so be careful.')
  ) v(slug, lang, long_desc)
  join public.places p on p.slug = v.slug
 where t.place_id = p.id and t.lang = v.lang;
