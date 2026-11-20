-- İzmir uzun açıklamaları, 5. parti (18 yer, TR + EN).
-- Üreten: data-pipeline/content/build_long_desc.py (kaynak: content/izmir_long_descriptions.py).
-- Metinler kendi cümlelerimizdir; Vikipedi/Wikidata yalnızca bilgi kontrolü için kullanıldı.

update public.place_translations t
   set long_desc = v.long_desc
  from (values
  ('efes-varius-hamami', 'tr', 'Efes''in üst girişine yakın Varius Hamamı, MS 2. yüzyılda yapılan büyük bir Roma hamamıdır. Roma kentlerinde hamamlar yalnızca yıkanma yeri değil, aynı zamanda buluşma, sohbet ve spor alanıydı; bu yapı da Efes''in üst kentteki sosyal yaşamının önemli bir parçasıydı.

Kalın tuğla duvarlar, sıcak ve soğuk bölümlerin izleri ve tonozlu mekânlar görülebilir. Ören yerine üst girişten girdiğinizde ilk duraklardan biridir; Devlet Agorası''na doğru yürürken kısa bir göz atmak yeterlidir.'),
  ('efes-varius-hamami', 'en', 'Near the upper entrance of Ephesus, the Baths of Varius are a large Roman bath complex built in the 2nd century AD. In Roman cities, baths were not just places to wash but also for meeting, conversation and exercise, and this building was an important part of social life in the upper city of Ephesus.

You can see thick brick walls, traces of the hot and cold rooms and vaulted spaces. It is one of the first stops when you enter the site by the upper gate; a short look on your way to the State Agora is enough.'),
  ('pergamon-gymnasium-alani', 'tr', 'Pergamon akropolünün güney yamacındaki gymnasium, Helenistik dünyanın en büyük gymnasiumlarından biriydi. Üç terasa yayılan yapıda çocuklar, gençler ve genç erkekler ayrı katlarda eğitim görür, spor yapar ve derslere katılırdı.

Terasları birbirine bağlayan tonozlu merdivenler, sütunlu avlular ve hamam bölümleri görülebilir. Akropolün tepesinden aşağı, kentin orta kesimine inen patika üzerindedir; teleferikle çıkıp yürüyerek inerseniz yolunuz buradan geçer. Yamaç dik ve gölgesizdir, su almayı unutmayın.'),
  ('pergamon-gymnasium-alani', 'en', 'On the southern slope of the Pergamon acropolis, the gymnasium was one of the largest in the Hellenistic world. Spread across three terraces, it was where boys, youths and young men trained, exercised and attended lessons, each group on its own level.

You can see the vaulted stairways linking the terraces, colonnaded courtyards and bath sections. It lies on the path that leads down from the top of the acropolis to the middle city; if you go up by cable car and walk down, your route passes here. The slope is steep and shadeless, so remember to bring water.'),
  ('traianus-cesmesi', 'tr', 'Efes''in Kuretler Caddesi üzerindeki Traianus Çeşmesi, 2. yüzyılın başında İmparator Traianus onuruna yapılan iki katlı anıtsal bir çeşmedir. Cephenin ortasında ayağını bir küreye basmış imparator heykeli dururdu; bugün yalnızca ayak ve küre parçası yerindedir.

Cephe, bulunan parçalarla kısmen yeniden kurulmuştur; havuz ve sütunlar suyun bir zamanlar nasıl aktığını hayal ettirir. Heykellerin asılları Efes Müzesi''ndedir. Hadrianus Tapınağı''na giderken yolun hemen üzerindedir.'),
  ('traianus-cesmesi', 'en', 'The Fountain of Trajan on Curetes Street in Ephesus is a two-storey monumental fountain built in the early 2nd century in honour of the Emperor Trajan. At the centre of the façade stood a statue of the emperor with one foot on a globe; today only the foot and globe remain in place.

The façade has been partly rebuilt from the pieces found, and the basin and columns help you imagine the water once flowing here. The original statues are in the Ephesus Museum. It lies right on the street on your way to the Temple of Hadrian.'),
  ('trajan-tapinagi', 'tr', 'Pergamon akropolünün en yüksek noktasındaki Trajan Tapınağı, 2. yüzyılda İmparator Traianus ve Zeus Philios için yapılmaya başlandı, Hadrianus döneminde tamamlandı. Tapınak, yüksek bir teras üzerinde, uzaktan görülecek biçimde konumlandırılmıştı.

Alman arkeologların yeniden diktiği beyaz mermer Korint sütunları, akropolün en çok fotoğraflanan görüntüsüdür. Terasın kenarından aşağıda tiyatro ve Bergama ovası görülür. Rüzgârlı ve gölgesiz bir noktadır; öğle sıcağından kaçının.'),
  ('trajan-tapinagi', 'en', 'At the highest point of the Pergamon acropolis, the Temple of Trajan was begun in the 2nd century for the Emperor Trajan and Zeus Philios and completed under Hadrian. It was set on a high terrace so that it could be seen from afar.

Its white marble Corinthian columns, re-erected by German archaeologists, are the most photographed view of the acropolis. From the edge of the terrace you look down on the theatre and the Bergama plain. It is windy and shadeless here; avoid the midday heat.'),
  ('sirince', 'tr', 'Selçuk''un yaklaşık 8 km doğusunda, tepelerin arasındaki Şirince, eski adı Kirkinca olan bir Rum köyüydü. 1923 nüfus mübadelesinden sonra Selanik çevresinden gelen ailelerin yerleştiği köy, sonradan Şirince adını aldı. Yamaca basamak basamak dizilen beyaz badanalı taş evleri korunmuştur.

Dar sokaklarda dolaşın, meyve şaraplarını tadın, köy kahvaltısı yapın; Vaftizci Yahya Kilisesi ve köyün üstündeki tepeler manzara sunar. Hafta sonları ve tatillerde çok kalabalık olur; hafta içi sabah saatleri daha sakindir. Efes ile aynı güne kolayca eklenir.'),
  ('sirince', 'en', 'About 8 km east of Selçuk, tucked among the hills, Şirince was a Greek village formerly called Kirkintzes. After the 1923 population exchange, families from around Thessaloniki settled here and the village later took the name Şirince. Its whitewashed stone houses, stacked up the hillside, have been preserved.

Wander the narrow streets, taste the fruit wines and have a village breakfast; the Church of St John the Baptist and the hills above the village offer views. It gets very crowded at weekends and holidays, while weekday mornings are calmer. It is easy to add to a day at Ephesus.'),
  ('alacati', 'tr', 'Çeşme''ye bağlı Alaçatı, 19. yüzyılda bağcılık ve tütüncülükle gelişen bir Rum kasabasıydı. Taş evleri, renkli pencere kepenkleri ve tepedeki yel değirmenleri o dönemden kalır. Bugün Ege''nin en popüler tatil yerlerinden biridir.

Dar sokaklardaki butik oteller, restoranlar ve tasarım dükkânları yazın çok canlıdır. Kasabanın güneyindeki koy, sürekli esen rüzgârı nedeniyle dünyanın önemli rüzgâr sörfü noktalarındandır; baharda düzenlenen Ot Festivali de ünlüdür. Yaz akşamları çok kalabalık olur; sakin bir gezi için ilkbaharı ya da sonbaharı seçin.'),
  ('alacati', 'en', 'Alaçatı, part of Çeşme, was a Greek town that grew in the 19th century on vineyards and tobacco. Its stone houses, colourful shutters and the windmills on the hill date from that period. Today it is one of the most popular holiday spots on the Aegean.

Boutique hotels, restaurants and design shops in the narrow streets are lively in summer. The bay south of town, with its constant wind, is one of the world''s notable windsurfing spots, and the Herb Festival held in spring is well known. Summer evenings get very crowded; for a quieter visit choose spring or autumn.'),
  ('birgi', 'tr', 'Ödemiş''e bağlı Birgi, Bozdağlar''ın eteğinde, bir dere vadisine kurulmuş tarihi bir kasabadır. Bizans döneminde Pyrgion adıyla bilinen yerleşim, 14. yüzyılda Aydınoğulları Beyliği''nin başkenti oldu ve 15. yüzyılın başında Osmanlı topraklarına katıldı.

Ulu Cami, Çakırağa Konağı, İmam Birgivi''nin türbesi ve yüzlerce yıllık ahşap çıkmalı evleriyle Batı Anadolu''nun en iyi korunmuş kasabalarındandır. Taş döşeli sokaklarda yürüyün, çınar altındaki kahvelerde oturun. Hafta sonu kalabalıklaşır; bir gece konaklamak kasabanın sakinliğini daha iyi hissettirir.'),
  ('birgi', 'en', 'Birgi, part of Ödemiş, is a historic town set in a stream valley at the foot of the Bozdağlar mountains. Known as Pyrgion in the Byzantine period, it became the capital of the Aydınid principality in the 14th century and passed to the Ottomans in the early 15th century.

With its Grand Mosque, the Çakırağa Mansion, the tomb of İmam Birgivi and centuries-old timber houses with projecting upper floors, it is one of the best-preserved towns in western Anatolia. Walk the stone-paved streets and sit in the cafés under the plane trees. It gets busy at weekends; staying a night lets you feel the town''s calm better.'),
  ('sahin-tepesi', 'tr', 'Buca ile Bornova arasındaki yol üzerinde bulunan Şahin Tepesi, kentin iç kesiminden İzmir Körfezi''ne ve şehrin büyük bölümüne açılan geniş bir manzara sunar. Kıvrımlı Şahin Tepesi yolu, iki ilçeyi birbirine bağlayan eski güzergâhlardandır.

Gün batımında körfeze doğru yayılan şehir ışıkları özellikle güzeldir. Tepe ve çevresi bir seyir noktası olarak kullanılır; araçla gidiyorsanız yol dik ve virajlıdır, dikkatli sürün. Kalabalıktan uzak, kısa bir akşam gezisi için uygundur.'),
  ('sahin-tepesi', 'en', 'On the road between Buca and Bornova, Şahin Hill offers a wide view from the inland part of the city over the Gulf of İzmir and much of the city. The winding Şahin Tepesi road is one of the old routes linking the two districts.

At sunset the city lights spreading towards the gulf are especially beautiful. The hill and its surroundings serve as a viewpoint; if you drive, the road is steep and twisting, so take care. It suits a short evening outing away from the crowds.'),
  ('yamanlar-dagi', 'tr', 'Karşıyaka''nın arkasında yükselen Yamanlar Dağı, yaklaşık 1.076 metre yüksekliğinde, büyük ölçüde volkanik kayalardan oluşan bir dağdır. İzmirlilerin en sevdiği hafta sonu kaçış noktalarından biridir.

Çam ormanları arasındaki krater gölü Karagöl, mitolojide Tantalos efsanesiyle ilişkilendirilir; gölün çevresinde yürüyüş ve piknik alanları vardır. Yukarıdan körfezin ve şehrin geniş bir manzarası görülür. Yazın orman yangını riskine karşı ateş yakılmaması gereken alanlara dikkat edin.'),
  ('yamanlar-dagi', 'en', 'Rising behind Karşıyaka, Mount Yamanlar is about 1,076 metres high and made largely of volcanic rock. It is one of İzmir residents'' favourite weekend escapes.

Karagöl, a crater lake among the pine forests, is linked in mythology with the legend of Tantalus, and there are walking and picnic areas around the lake. From up here you get a wide view of the gulf and the city. In summer pay attention to the areas where fires are banned because of the forest-fire risk.'),
  ('gediz-deltasi', 'tr', 'Gediz Nehri''nin İzmir Körfezi''ne döküldüğü yerde oluşan delta, Çiğli, Menemen ve Foça kıyılarına yayılan yaklaşık 15.000 hektarlık bir sulak alandır. 1998''den beri uluslararası öneme sahip Ramsar alanıdır ve Türkiye''nin en önemli kuş alanlarındandır.

Lagünler, tuzlalar, sazlıklar ve çamur düzlükleri yüzlerce kuş türüne ev sahipliği yapar; flamingolar yıl boyunca görülür ve burada ürer. Alanı görmek için en iyi yer İzmir Kuş Cenneti''dir; dürbün getirin ve kuşları rahatsız etmeden gözlemleyin. İlkbahar ve sonbahar göç dönemleri en zengin zamanlardır.'),
  ('gediz-deltasi', 'en', 'Formed where the Gediz River flows into the Gulf of İzmir, the delta is a wetland of about 15,000 hectares spreading along the shores of Çiğli, Menemen and Foça. It has been a Ramsar site of international importance since 1998 and is one of Turkey''s most important bird areas.

Lagoons, salt pans, reed beds and mudflats host hundreds of bird species; flamingos are seen year-round and breed here. The best place to see the area is the İzmir Bird Paradise; bring binoculars and watch the birds without disturbing them. The spring and autumn migration seasons are the richest times.'),
  ('buyuk-park', 'tr', 'Bornova''daki Büyük Park, ilçenin merkezine yakın, ağaçlık ve geniş bir şehir parkıdır. Ege Üniversitesi yerleşkesine komşu olduğundan öğrencilerin ve ailelerin buluştuğu bir yeşil alandır.

Yürüyüş yolları, çimenlik alanlar ve oturma yerleriyle kısa bir mola ya da sabah yürüyüşü için uygundur. Bornova''nın Levanten köşkleri ve Cumhuriyet Meydanı ile birlikte bir ilçe gezisine eklenebilir.'),
  ('buyuk-park', 'en', 'Büyük Park in Bornova is a wide, wooded city park near the district centre. Bordering the Ege University campus, it is a green space where students and families meet.

With its walking paths, lawns and benches it suits a short break or a morning walk. It can be added to a tour of the district together with Bornova''s Levantine mansions and Cumhuriyet Square.'),
  ('izmir-kus-cenneti', 'tr', 'Çiğli''deki İzmir Kuş Cenneti, Gediz Deltası''nın en korunaklı bölümüdür. 1980''lerde su kuşları koruma ve üreme sahası ile birinci derece doğal sit alanı ilan edildi. Türkiye''deki kuş türlerinin önemli bir bölümü burada görülebilir.

Ziyaretçi merkezinde alanı tanıtan sergiler bulunur; buradan yürüyerek ya da bisikletle gözlem kulelerine gidilir. Flamingolar, pelikanlar ve balıkçıllar en sık görülen kuşlardır. Dürbün getirin, sessiz olun ve patikalardan ayrılmayın. Sabah erken ve akşamüstü kuşlar daha hareketlidir; yazın sivrisineğe karşı hazırlıklı olun.'),
  ('izmir-kus-cenneti', 'en', 'The İzmir Bird Paradise in Çiğli is the most protected part of the Gediz Delta. In the 1980s it was declared a waterbird protection and breeding area and a first-degree natural site. A large share of Turkey''s bird species can be seen here.

The visitor centre has displays introducing the area, and from there you walk or cycle to the observation towers. Flamingos, pelicans and herons are the birds you see most often. Bring binoculars, keep quiet and stay on the paths. Birds are most active early in the morning and late in the afternoon; in summer be ready for mosquitoes.'),
  ('camalti-tuzlasi', 'tr', 'Gediz Deltası''ndaki Çamaltı Tuzlası, yaklaşık 58 km²''lik alanıyla Türkiye''nin en büyük deniz tuzlasıdır. Evliya Çelebi''nin de sözünü ettiği tuzla, 19. yüzyılda modern üretime geçti ve bugün ülkenin deniz tuzu ihtiyacının büyük bölümünü karşılar.

Sığ tuz havuzlarında yaşayan küçük karidesler, flamingolara pembe rengini veren besin kaynağıdır; bu yüzden havuzların kenarında yüzlerce flamingo beslenirken görülebilir. Tuzlanın içi işletme alanıdır; flamingoları Kuş Cenneti''nin gözlem noktalarından ya da yol kenarındaki uygun yerlerden izleyin.'),
  ('camalti-tuzlasi', 'en', 'The Çamaltı Salt Pan in the Gediz Delta, covering about 58 km², is Turkey''s largest sea salt works. Mentioned by Evliya Çelebi, it switched to modern production in the 19th century and today meets much of the country''s need for sea salt.

The tiny shrimps living in the shallow salt pools are the food that gives flamingos their pink colour, so hundreds of flamingos can be seen feeding at the edges of the pools. The salt works itself is an industrial area; watch the flamingos from the Bird Paradise viewpoints or suitable spots by the road.'),
  ('kulturpark', 'tr', 'Kültürpark, 1922 yangınında harabeye dönen bölgenin üzerinde 1936''da kuruldu ve kısa sürede genişletildi. Belediye Başkanı Behçet Uz''un önderliğinde açılan park, kurulduğundan beri İzmir Enternasyonal Fuarı''na ev sahipliği yapar ve kentin kültür hayatının merkezlerindendir.

Ağaçlık yolları, göleti, Paraşüt Kulesi, açık hava tiyatrosu ve fuar pavyonlarıyla şehrin ortasında büyük bir yeşil alandır. Yaz sonundaki fuar döneminde konserler ve etkinliklerle dolup taşar; diğer zamanlarda sakin bir yürüyüş için idealdir. İçindeki yapılar ayrıca işaretlenebilir.'),
  ('kulturpark', 'en', 'Kültürpark was founded in 1936 on the area left in ruins by the 1922 fire and was soon enlarged. Opened under the leadership of Mayor Behçet Uz, the park has hosted the İzmir International Fair since its founding and is one of the centres of the city''s cultural life.

With tree-lined paths, a pond, the Parachute Tower, an open-air theatre and fair pavilions, it is a large green space in the middle of the city. During the fair at the end of summer it overflows with concerts and events; at other times it is ideal for a calm walk. The buildings inside can be checked off separately.'),
  ('buca-golet', 'tr', 'Buca Gölet, Mart 1999''da açılan ve yaklaşık 167.000 m²''lik alana yayılan bir rekreasyon alanıdır. Ortasında yapay bir gölet, çevresinde amfitiyatro, kafeterya ve restoranlar bulunur.

Göletin çevresindeki yürüyüş yolu, çocuk oyun alanları ve piknik yerleri hafta sonları aileler tarafından yoğun kullanılır. Ağaçlık alanda sabah yürüyüşü yapmak ya da gölete karşı çay içmek için uygundur.'),
  ('buca-golet', 'en', 'Buca Gölet is a recreation area opened in March 1999, covering about 167,000 m². At its centre is an artificial pond, surrounded by an amphitheatre, a cafeteria and restaurants.

The walking path around the pond, playgrounds and picnic spots are busy with families at weekends. The wooded area suits a morning walk or a glass of tea facing the water.'),
  ('susuzdede-parki', 'tr', 'Göztepe''deki Susuzdede Parkı, aynı adı taşıyan tepenin üzerinde yer alan yaklaşık 46.000 m²''lik bir parktır. Tepe, Cumhuriyet''ten önce Aya Agapi olarak bilinirdi; bugünkü adını burada bulunan Susuz Dede''nin mezarından alır.

Güzelyalı ve Göztepe''nin üzerinden körfeze, karşıdaki Karşıyaka''ya ve şehrin silüetine geniş bir manzara açılır; gün batımı en güzel zamanıdır. Kafesi ve oturma alanlarıyla kısa bir akşam molası için uygundur.'),
  ('susuzdede-parki', 'en', 'Susuzdede Park in Göztepe is a park of about 46,000 m² on the hill of the same name. Before the Republic the hill was known as Aya Agapi; it takes its present name from the tomb of Susuz Dede that stands here.

From above Güzelyalı and Göztepe it opens a wide view of the gulf, Karşıyaka on the far shore and the city skyline; sunset is the best time. With its café and seating areas it suits a short evening break.'),
  ('asik-veysel-rekreasyon-alani', 'tr', 'Bornova''daki Aşık Veysel Rekreasyon Alanı, halk ozanı Âşık Veysel''in adını taşır. Yapımına 2008''de başlanan ve 2010''da açılan park, yaklaşık 231.000 m²''lik alanıyla İzmir''in büyük yeşil alanlarındandır.

Göl, geniş çimenler, yürüyüş ve bisiklet yolları ile spor alanları bulunur; içindeki Buz Sporları Salonu''nda paten yapılabilir. Hafta sonları piknikçiler ve ailelerle dolar; sabahları koşu için uygundur.'),
  ('asik-veysel-rekreasyon-alani', 'en', 'Aşık Veysel Recreation Area in Bornova is named after the folk poet Âşık Veysel. Begun in 2008 and opened in 2010, the park covers about 231,000 m² and is one of İzmir''s large green spaces.

It has a lake, wide lawns, walking and cycling paths and sports grounds, and you can go skating at the Ice Sports Hall inside. At weekends it fills with picnickers and families, while mornings are good for running.'),
  ('kordon', 'tr', 'Kordon, Konak''taki Cumhuriyet Meydanı''ndan Alsancak Limanı''na kadar körfez boyunca uzanan kıyı şerididir. 19. yüzyılın ikinci yarısında rıhtım olarak yapıldı; konsoloslukların, otellerin ve tüccar evlerinin sıralandığı bu kıyı, kentin vitrini oldu. 1922 yangınından sonra yeniden biçimlendi.

Bugün İzmir''in en sevilen yürüyüş, bisiklet ve gün batımı yeridir: çimenlere oturup körfeze karşı simit yemek, fayton ya da tramvayla gezmek, kıyıdaki kafe ve barlarda akşamı geçirmek klasik İzmir deneyimidir. Gün batımında çok kalabalık olur; erken gelin.'),
  ('kordon', 'en', 'The Kordon is the waterfront strip running along the gulf from Cumhuriyet Square in Konak to Alsancak Port. Built as a quay in the second half of the 19th century, lined with consulates, hotels and merchants'' houses, it became the city''s showcase. It was reshaped after the fire of 1922.

Today it is İzmir''s favourite place for walking, cycling and watching the sunset: sitting on the grass with a simit facing the gulf, riding a horse-drawn carriage or the tram, and spending the evening at the cafés and bars along the shore are classic İzmir experiences. It gets very busy at sunset, so come early.')
  ) v(slug, lang, long_desc)
  join public.places p on p.slug = v.slug
 where t.place_id = p.id and t.lang = v.lang;
