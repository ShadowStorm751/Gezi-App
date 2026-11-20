-- İstanbul uzun açıklamaları, 5. parti (10 yer, TR + EN).
-- Üreten: data-pipeline/content/build_long_desc.py (kaynak: content/istanbul_long_descriptions.py).
-- Metinler kendi cümlelerimizdir; Vikipedi/Wikidata yalnızca bilgi kontrolü için kullanıldı.

update public.place_translations t
   set long_desc = v.long_desc
  from (values
  ('turk-ve-islam-eserleri-muzesi', 'tr', '1914''te Süleymaniye Külliyesi''nin imaret binasında Evkaf-ı İslamiye Müzesi adıyla açılan Türk ve İslam Eserleri Müzesi, İslam sanatı eserlerini bir arada sergileyen ilk Türk müzesidir. 1983''ten bu yana Sultanahmet Meydanı''na bakan, 16. yüzyıldan kalma İbrahim Paşa Sarayı''nda bulunur.

Müze özellikle dünyanın en önemli halı koleksiyonlarından birine sahiptir; Selçuklu ve Osmanlı halıları, el yazmaları, hat örnekleri, ahşap ve metal eserler sergilenir. Alt kattaki etnografya bölümü Anadolu''daki göçebe ve köy yaşamını anlatır. Ayasofya ve Sultanahmet Camii''nin hemen karşısında olduğundan aynı gezide görülebilir.'),
  ('turk-ve-islam-eserleri-muzesi', 'en', 'Opened in 1914 as the Museum of Islamic Foundations in the soup-kitchen building of the Süleymaniye complex, the Museum of Turkish and Islamic Arts was the first Turkish museum to bring works of Islamic art together. Since 1983 it has been housed in the 16th-century Palace of İbrahim Pasha, overlooking the Hippodrome.

It is above all known for one of the world''s finest carpet collections; Seljuk and Ottoman carpets, manuscripts, calligraphy, woodwork and metalwork are on display. The ethnography section on the lower floor portrays nomadic and village life in Anatolia. It sits right opposite Hagia Sophia and the Blue Mosque, so it fits easily into the same visit.'),
  ('belgrad-ormani', 'tr', 'Sarıyer''in kuzeyinde, Boğaz ile Karadeniz arasında uzanan Belgrad Ormanı, İstanbul''un en büyük ormanlık alanlarından biridir. Bizans ve Osmanlı dönemlerinde şehre içme suyu sağlayan en önemli kaynaktı; adını, Kanuni Sultan Süleyman''ın Belgrad seferinden sonra buraya yerleştirilen ve su yollarının bakımını üstlenen ailelerden aldığı anlatılır.

Ormanın içinde Osmanlı dönemine ait bentler ve su yapıları hâlâ görülebilir; Mimar Sinan''ın yaptığı su sisteminin parçaları bunlar arasındadır. Neşet Suyu çevresindeki yürüyüş ve koşu parkurları özellikle hafta sonları kalabalıktır. Piknik alanları ve giriş kuralları değişebildiği için gitmeden önce kontrol edin.'),
  ('belgrad-ormani', 'en', 'Stretching north of Sarıyer between the Bosphorus and the Black Sea, Belgrad Forest is one of Istanbul''s largest woodlands. In Byzantine and Ottoman times it was the city''s main source of drinking water; it is said to take its name from families settled here after Suleiman the Magnificent''s Belgrade campaign, who looked after the waterworks.

Ottoman dams and water structures can still be seen inside the forest, among them parts of the water system built by Mimar Sinan. The walking and running trails around Neşet Suyu get busy, especially at weekends. Picnic areas and entry rules can change, so check before you go.'),
  ('rustem-pasa-camii', 'tr', 'Mısır Çarşısı''nın yakınında, Tahtakale''nin hareketli çarşı sokaklarında saklı duran Rüstem Paşa Camii, Kanuni Sultan Süleyman''ın sadrazamı ve damadı Rüstem Paşa için Mimar Sinan tarafından 1560''ların başında yapıldı. Altındaki dükkânların gelirinin camiye vakfedilmesi için yüksek bir platform üzerine oturtulmuştur.

Caminin asıl hazinesi, iç duvarları ve revakı baştan sona kaplayan 16. yüzyıl İznik çinileridir; lale, karanfil ve sümbül motifleri ile mercan kırmızısı tonları Osmanlı çini sanatının en parlak dönemini yansıtır. Girişi dar merdivenlerle çarşı içinden olduğu için kolayca gözden kaçabilir; tabelaları takip edin.'),
  ('rustem-pasa-camii', 'en', 'Hidden among the busy market streets of Tahtakale near the Spice Bazaar, the Rüstem Pasha Mosque was built by Mimar Sinan in the early 1560s for Rüstem Pasha, grand vizier and son-in-law of Suleiman the Magnificent. It sits on a raised platform so that the rent from the shops beneath could support the mosque.

Its real treasure is the 16th-century İznik tilework covering the interior walls and portico; tulip, carnation and hyacinth motifs and coral-red tones show Ottoman tile art at its peak. The entrance is up narrow stairs from within the market, so it is easy to miss; follow the signs.'),
  ('bayezid-camii', 'tr', 'Beyazıt Meydanı''nda yükselen Bayezid Camii, Sultan II. Bayezid tarafından 1500''lerin başında yaptırıldı ve İstanbul''da özgün halini koruyan en eski selatin camisidir. Mimarı kesin olarak bilinmese de erken klasik Osmanlı mimarisinin önemli bir örneği ve Mimar Sinan''ın sonraki eserlerine öncü sayılır.

Revaklı avlusu, renkli taşlardan sütunları ve şadırvanıyla huzurlu bir yerdir. Hemen yanında kitapçılarla dolu Sahaflar Çarşısı, karşısında İstanbul Üniversitesi''nin anıtsal kapısı bulunur; Kapalıçarşı da birkaç adım ötededir.'),
  ('bayezid-camii', 'en', 'Rising over Beyazıt Square, the Bayezid Mosque was built by Sultan Bayezid II in the early 1500s and is the oldest imperial mosque in Istanbul to survive in its original form. Although its architect is not known for certain, it is an important example of early classical Ottoman architecture and is seen as a forerunner of Mimar Sinan''s later work.

Its arcaded courtyard, columns of coloured stone and ablution fountain make it a peaceful place. Right beside it is the Sahaflar book market, opposite stands the monumental gate of Istanbul University, and the Grand Bazaar is just a few steps away.'),
  ('gulhane-parki', 'tr', 'Topkapı Sarayı''nın surlarının dibinde, Sarayburnu''na doğru uzanan Gülhane Parkı, Osmanlı döneminde sarayın dış bahçesiydi. Halka 1912''de park olarak açıldı ve bugün tarihi yarımadanın en büyük ve en eski yeşil alanlarından biridir. 1839''da Tanzimat Fermanı''nın okunduğu yer olarak da tarihe geçmiştir.

Ulu çınarların altındaki geniş yollar, Sultanahmet''in kalabalığından kaçmak için idealdir. Nisan ayında düzenlenen lale festivalinde park rengârenk olur. Parkın ucunda Roma döneminden kalma Gotlar Sütunu, içinde ise İslam Bilim ve Teknoloji Tarihi Müzesi bulunur; en uçtaki çay bahçesinden Boğaz''ın girişi görülür.'),
  ('gulhane-parki', 'en', 'Running below the walls of Topkapı Palace towards Sarayburnu, Gülhane Park was the palace''s outer garden in Ottoman times. It opened to the public as a park in 1912 and is one of the largest and oldest green spaces on the historic peninsula. It is also where the Tanzimat reform edict was proclaimed in 1839.

Its broad avenues under huge plane trees are ideal for escaping the Sultanahmet crowds. During the tulip festival in April the park bursts with colour. At its far end stands the Roman-era Column of the Goths, the Museum of the History of Science and Technology in Islam is inside the park, and the tea garden at the tip looks out over the mouth of the Bosphorus.'),
  ('masumiyet-muzesi', 'tr', 'Çukurcuma''daki 19. yüzyıldan kalma bir evde 2012''de açılan Masumiyet Müzesi, Orhan Pamuk''un aynı adlı romanıyla birlikte tasarladığı bir müzedir. Romanın kahramanı Kemal''in sevdiği Füsun''a dair biriktirdiği eşyaları sergiler ve bir romanın kurmaca dünyasından yola çıkan ilk müze olarak 2014''te Avrupa Yılın Müzesi Ödülü''nü kazanmıştır.

Her vitrin romanın bir bölümüne karşılık gelir ve 1950''ler-1970''ler İstanbul''unun gündelik hayatından nesnelerle doludur; giriş katındaki binlerce sigara izmaritinden oluşan duvar en çok konuşulan bölümdür. Romanı okumamış olsanız da anlatılan dönemin atmosferini hissettirir. Çukurcuma''nın antikacı sokakları da gezmeye değer.'),
  ('masumiyet-muzesi', 'en', 'Opened in 2012 in a 19th-century house in Çukurcuma, the Museum of Innocence was conceived by Orhan Pamuk together with his novel of the same name. It displays the objects the novel''s hero, Kemal, collected in memory of his beloved Füsun, and as the first museum built from a novel''s fictional world it won the European Museum of the Year Award in 2014.

Each display case matches a chapter of the book and is filled with everyday objects from 1950s-1970s Istanbul; the wall of thousands of cigarette butts on the ground floor is its most talked-about piece. Even if you have not read the novel, it captures the atmosphere of the era. The antique shops of Çukurcuma are worth exploring too.'),
  ('yedikule-hisari', 'tr', 'Kara surlarının Marmara kıyısına yakın ucundaki Yedikule Hisarı, Fatih Sultan Mehmed''in 1458''de Bizans''ın görkemli tören kapısı Altın Kapı''nın çevresine eklettiği kulelerle yedi kuleli bir kaleye dönüştü. Osmanlı döneminde hazine deposu, ardından zindan olarak kullanıldı; Genç Osman''ın 1622''de burada öldürüldüğü bilinir.

Bugün açık hava müzesi olan kalenin surlarına çıkarak Marmara''yı, kara surlarını ve tarihi yarımadayı görebilirsiniz. Roma zafer takı olarak yapılan ve sonradan örülen Altın Kapı''nın mermer kemerleri hâlâ seçilebilir. Restorasyon nedeniyle ziyaret düzeni değişebildiğinden gitmeden önce kontrol edin.'),
  ('yedikule-hisari', 'en', 'At the end of the land walls near the Sea of Marmara, Yedikule Fortress took shape in 1458 when Mehmed II added towers around the Golden Gate, Byzantium''s grand ceremonial entrance, creating a fortress of seven towers. In Ottoman times it served as a treasury and later as a prison; Sultan Osman II was killed here in 1622.

Today an open-air museum, its ramparts offer views of the Marmara, the land walls and the historic peninsula. The marble arches of the Golden Gate, built as a Roman triumphal arch and later walled up, can still be made out. Visiting arrangements can change due to restoration, so check before you go.'),
  ('dikilitas', 'tr', 'Sultanahmet Meydanı''nın ortasında duran Dikilitaş, İstanbul''daki en eski anıttır: Mısır firavunu III. Tutmosis tarafından MÖ 15. yüzyılda Karnak Tapınağı için yaptırıldı. Roma İmparatoru I. Theodosius 390 yılında onu Hipodrom''a diktirdi; taşınırken kırıldığı için bugün özgün yüksekliğinin yalnızca üst kısmı ayaktadır.

Pembe granit gövdesindeki hiyeroglifler firavunun zaferlerini anlatır ve 3500 yıla rağmen şaşırtıcı derecede keskindir. Mermer kaidedeki kabartmalarda ise imparatoru ailesiyle Hipodrom''daki yarışları izlerken ve dikilitaşın dikilişini görebilirsiniz. Yılanlı Sütun ve Örme Sütun hemen yanındadır.'),
  ('dikilitas', 'en', 'Standing in the middle of Sultanahmet Square, the Obelisk is the oldest monument in Istanbul: it was made for Pharaoh Thutmose III in the 15th century BC for the Temple of Karnak. The Roman Emperor Theodosius I had it raised in the Hippodrome in 390; it broke during transport, so only the upper part of its original height stands today.

The hieroglyphs on its pink granite shaft celebrate the pharaoh''s victories and are remarkably crisp after 3,500 years. On the reliefs of the marble base you can see the emperor and his family watching the Hippodrome races and the raising of the obelisk itself. The Serpent Column and the Walled Obelisk stand right next to it.'),
  ('kucuksu-kasri', 'tr', 'Anadolu yakasında, Göksu ve Küçüksu derelerinin arasında Boğaz kıyısında duran Küçüksu Kasrı, Sultan Abdülmecid''in isteğiyle Nigoğos Balyan tarafından yapıldı ve 1857''de tamamlandı. Padişahların gezinti ve dinlenme molaları için kullandığı, sürekli ikamet için yapılmamış biniş kasırlarından biridir.

Denize bakan, zengin süslemeli barok cephesi ve kristal avizelerle bezeli salonları küçük ölçekli bir saray zarafeti taşır. Önündeki rıhtım ve bahçe Boğaz''ı seyretmek için güzel bir yerdir. Milli Saraylar''a bağlı müze olarak hizmet verir; ziyaret günleri değişebileceğinden gitmeden önce kontrol edin. Anadolu Hisarı yürüme mesafesindedir.'),
  ('kucuksu-kasri', 'en', 'On the Asian shore of the Bosphorus, between the Göksu and Küçüksu streams, Küçüksu Pavilion was built by Nigoğos Balyan at the request of Sultan Abdülmecid and completed in 1857. It is one of the sultans'' excursion pavilions, used for outings and rest stops rather than as a permanent residence.

Its richly decorated baroque façade facing the water and its salons with crystal chandeliers carry the elegance of a palace on a small scale. The quay and garden in front are a lovely spot to watch the Bosphorus. It is run as a museum by the National Palaces administration; opening days can change, so check before you go. Anadolu Fortress is within walking distance.'),
  ('mihrimah-sultan-camii-edirnekapi', 'tr', 'Edirnekapı''da kara surlarının hemen yanında, tarihi yarımadanın en yüksek tepesinde yükselen Mihrimah Sultan Camii, Kanuni Sultan Süleyman''ın kızı Mihrimah Sultan için Mimar Sinan tarafından 1560''larda yapıldı. Medrese, türbe, sıbyan mektebi ve hamamdan oluşan bir külliyenin merkezidir.

Tek büyük kubbeyi taşıyan duvarlar yüzlerce pencereyle açıldığı için iç mekân olağanüstü aydınlıktır; Sinan''ın en cesur denemelerinden biri sayılır. Rivayete göre Üsküdar''daki Mihrimah Sultan Camii ile bu cami arasında, güneşin batışı ve ayın doğuşuna dair romantik bir hikâye anlatılır. Kariye ve Tekfur Sarayı ile aynı gezide görülebilir.'),
  ('mihrimah-sultan-camii-edirnekapi', 'en', 'Rising beside the land walls at Edirnekapı, on the highest hill of the historic peninsula, the Mihrimah Sultan Mosque was built by Mimar Sinan in the 1560s for Mihrimah Sultan, daughter of Suleiman the Magnificent. It is the heart of a complex with a madrasa, tomb, primary school and bath.

The walls carrying its single great dome are pierced by hundreds of windows, making the interior exceptionally bright; it is considered one of Sinan''s boldest experiments. Legend links it with the Mihrimah Sultan Mosque in Üsküdar through a romantic story about the setting of the sun and the rising of the moon. It can be combined with Chora and Tekfur Palace.')
  ) v(slug, lang, long_desc)
  join public.places p on p.slug = v.slug
 where t.place_id = p.id and t.lang = v.lang;
