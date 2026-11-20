-- Bursa uzun açıklamaları, 2. parti (47 yer, TR + EN).
-- Üreten: data-pipeline/content/build_long_desc.py (kaynak: content/bursa_long_descriptions.py).
-- Metinler kendi cümlelerimizdir; Vikipedi/Wikidata yalnızca bilgi kontrolü için kullanıldı.

update public.place_translations t
   set long_desc = v.long_desc
  from (values
  ('cumalikizik-etnografya-muzesi', 'tr', 'Cumalıkızık''ın içindeki küçük Etnografya Müzesi, köyün geleneksel evlerinden birinde düzenlenmiştir. Köy halkının yüzyıllar boyunca kullandığı ev eşyaları, tarım aletleri, giysiler ve el işleri burada sergilenir.

Köyün taş döşeli sokaklarında yürürken uğranabilecek kısa bir duraktır; evin iç düzeni, Cumalıkızık evlerinin içinde hayatın nasıl geçtiğini gösterir. Köy kahvaltısı ve ahududu reçeli molasıyla birlikte gezinin parçası olarak düşünün.'),
  ('cumalikizik-etnografya-muzesi', 'en', 'The small Ethnography Museum in Cumalıkızık is set up in one of the village''s traditional houses. Household objects, farming tools, clothing and handicrafts used by the villagers over the centuries are on display.

It is a short stop while walking the village''s cobbled streets, and the layout of the house shows how life went on inside Cumalıkızık''s homes. Think of it as part of a visit that includes a village breakfast and raspberry jam.'),
  ('karagoz-muzesi', 'tr', 'Çekirge Caddesi''ndeki Karagöz Müzesi, 2007''de Bursa Büyükşehir Belediyesi tarafından açıldı ve Türkiye''nin ilk Karagöz müzesidir. Gölge oyununun Bursa''da doğduğu anlatılır; müze bu geleneği yaşatmak için kuruldu.

Deveden yapılmış renkli tasvirler, perdeler, oyun metinleri ve dünyanın farklı ülkelerinden gölge oyunu figürleri sergilenir; zaman zaman Karagöz gösterileri ve atölyeler düzenlenir. Çocuklarla gelinecek keyifli bir müzedir. Hemen karşısında Hacivat ve Karagöz Anıt Mezarı bulunur.'),
  ('karagoz-muzesi', 'en', 'The Karagöz Museum on Çekirge Street was opened in 2007 by Bursa Metropolitan Municipality and is Turkey''s first museum devoted to Karagöz. Shadow theatre is said to have been born in Bursa, and the museum was founded to keep the tradition alive.

Colourful figures made of camel hide, screens, play texts and shadow puppets from other countries are on display, and Karagöz performances and workshops are held from time to time. It is a fun museum to visit with children. The Monumental Tomb of Hacivat and Karagöz stands right opposite.'),
  ('merinos-enerji-muzesi', 'tr', 'Merinos Parkı''ndaki Enerji Müzesi, 2012''de eski Merinos fabrikasının elektrik santralinde açıldı. Fabrikaya uzun yıllar enerji sağlayan buhar kazanları, türbinler ve jeneratörler yerinde korunmuştur.

Dev makinelerin arasında yürürken bir dönemin sanayi teknolojisini yakından görürsünüz; enerjinin nasıl üretildiğini anlatan bölümler özellikle öğrenciler için öğreticidir. Park içindeki Tekstil Sanayi Müzesi ile birlikte gezilir.'),
  ('merinos-enerji-muzesi', 'en', 'The Energy Museum in Merinos Park opened in 2012 in the old power plant of the Merinos factory. The steam boilers, turbines and generators that powered the factory for many years are preserved in place.

Walking among the huge machines you see the industrial technology of an era up close, and the sections explaining how energy was produced are especially instructive for students. It is visited together with the Textile Industry Museum in the park.'),
  ('iznik-surlari', 'tr', 'İznik''i çevreleyen surlar, antik Nikaia kentinin Helenistik dönemde başlayıp Roma ve Bizans dönemlerinde yeniden yapılan savunma duvarlarıdır. Yaklaşık beş kilometre uzunluğundaki surlar, dört ana kapısı ve çok sayıda kulesiyle Anadolu''nun en iyi korunmuş antik kent surlarındandır.

İstanbul Kapı, Lefke Kapı, Yenişehir Kapı ve Göl Kapı en çok görülen bölümlerdir; İstanbul Kapı''daki Roma dönemi kabartmaları ilgi çeker. Surların bir bölümü boyunca yürüyebilir ya da bisikletle kent çevresini dolaşabilirsiniz. Kentin dört kapısını birbirine bağlayan caddeler merkezde Ayasofya''da kesişir.'),
  ('iznik-surlari', 'en', 'The walls around İznik are the defences of ancient Nicaea, begun in the Hellenistic period and rebuilt under the Romans and Byzantines. About five kilometres long, with four main gates and many towers, they are among the best-preserved ancient city walls in Anatolia.

The İstanbul Gate, Lefke Gate, Yenişehir Gate and Lake Gate are the most visited parts; the Roman-era reliefs at the İstanbul Gate draw attention. You can walk along part of the walls or cycle around the town. The streets linking the four gates meet in the centre at Hagia Sophia.'),
  ('tophane-saat-kulesi', 'tr', 'Tophane Parkı''ndaki saat kulesi, Sultan II. Abdülhamid''in tahta çıkışının yıl dönümü şerefine 20. yüzyılın başında yapıldı. Altı katlı ve yaklaşık 33 metre yüksekliğindeki kule, aynı yerde daha önce bulunan bir saat kulesinin yerini aldı ve uzun süre yangın gözetleme kulesi olarak kullanıldı.

Kulenin bulunduğu Tophane sırtı, şehrin ve ovanın en güzel manzaralarından birini sunar. Hemen yanında Osman Gazi ve Orhan Gazi''nin türbeleri yer alır; Hisar''ın tarihi sokakları ve Panorama 1326 Müzesi de yürüme mesafesindedir. Gün batımında park özellikle güzeldir.'),
  ('tophane-saat-kulesi', 'en', 'The clock tower in Tophane Park was built in the early 20th century to mark an anniversary of Sultan Abdülhamid II''s accession. Six storeys and about 33 metres high, it replaced an earlier clock tower on the same spot and was long used as a fire lookout.

The Tophane ridge where it stands offers one of the finest views of the city and the plain. The tombs of Osman Gazi and Orhan Gazi are right next to it, and the historic streets of Hisar and the Panorama 1326 Museum are within walking distance. The park is especially lovely at sunset.'),
  ('koza-hani', 'tr', 'Koza Han, 1490''larda Sultan II. Bayezid tarafından, İstanbul''daki külliyesine gelir sağlamak amacıyla yaptırıldı. Mimarı Abdülula bin Pulat Şah''tır. Adını ipek kozası ticaretinden alır; Bursa ipekçiliğinin yüzyıllar boyunca merkezi oldu ve bugün de yaz başında koza pazarı burada kurulur.

İki katlı hanın avlusunun ortasında, sekizgen bir şadırvanın üzerinde yükselen küçük mescit en ünlü ayrıntısıdır. Avludaki çay bahçesinde oturup ipek eşarp ve kumaş satan dükkânları gezebilirsiniz. Ulu Cami, Orhan Gazi Camii ve Kapalıçarşı birkaç adım ötededir.'),
  ('koza-hani', 'en', 'The Koza Han was built in the 1490s by Sultan Bayezid II to provide income for his complex in Istanbul. Its architect was Abdülula bin Pulat Şah. Named after the silk cocoon trade, it was the centre of Bursa''s silk industry for centuries, and the cocoon market is still held here in early summer.

Its most famous feature is the small mosque raised on an octagonal fountain in the middle of the courtyard of the two-storey han. Sit in the courtyard tea garden and browse the shops selling silk scarves and fabrics. The Grand Mosque, the Orhan Gazi Mosque and the Covered Bazaar are a few steps away.'),
  ('bursa-ataturk-aniti', 'tr', 'Heykel semtine adını veren Bursa Atatürk Anıtı, heykeltıraş Nijat Sirel''in eseridir ve 1931''de eski Hükümet Meydanı''na dikildi. Mermer bir kaide üzerinde, asker giysileri içinde at üzerindeki Atatürk''ü gösteren bronz bir heykeldir.

Anıt, Bursa''nın en bilinen buluşma noktalarından birinin ortasında durur; ulusal bayramlardaki törenler burada yapılır. Bursa Kent Müzesi ve Koza Parkı hemen yanındadır; tarihi çarşıya buradan yürüyerek inilebilir.'),
  ('bursa-ataturk-aniti', 'en', 'The Bursa Atatürk Monument, which gave the Heykel (''Statue'') district its name, is the work of the sculptor Nijat Sirel and was erected on the old Government Square in 1931. It is a bronze statue of Atatürk on horseback in military uniform, set on a marble pedestal.

The monument stands in the middle of one of Bursa''s best-known meeting points, and ceremonies on national holidays are held here. The Bursa City Museum and Koza Park are right beside it, and you can walk down to the historic bazaar from here.'),
  ('iznik-dikilitas', 'tr', 'İznik''e bağlı Elbeyli köyü yakınlarındaki Dikilitaş, Roma döneminde Gaius Cassius Philiscus adına dikilmiş bir anıt mezardır; Beştaş ya da Nişantaşı olarak da anılır. Antik çağda Nikaia (İznik) ile Nikomedia (İzmit) arasındaki Roma yolunun kenarında yer alıyordu.

Zeytinliklerin ortasında yükselen dikilitaş biçimindeki anıt ve kaidesindeki yazıt görülebilir. Kısa bir ziyaret için uygundur; İznik merkezinden birkaç kilometrelik bir sürüşle ulaşılır ve kent surları gezisine eklenebilir.'),
  ('iznik-dikilitas', 'en', 'Near the village of Elbeyli in İznik district, the Obelisk is a Roman funerary monument raised for Gaius Cassius Philiscus; it is also known as Beştaş or Nişantaşı. In antiquity it stood beside the Roman road between Nicaea (İznik) and Nicomedia (İzmit).

You can see the obelisk-shaped monument rising among olive groves and the inscription on its base. It suits a short visit, a few kilometres'' drive from central İznik, and can be added to a tour of the town walls.'),
  ('emir-han', 'tr', 'Ulu Cami''nin hemen yanındaki Emir Han, Bey Hanı olarak da bilinir ve Orhan Gazi döneminde, 14. yüzyılda yaptırıldı. Bursa''nın Osmanlı dönemindeki ticaret merkezini oluşturan hanlar bölgesinin en eski yapılarından biridir.

İki katlı hanın avlusu, çevresindeki kemerli dükkânlar ve odalarla eski kervansaray düzenini yansıtır. Kapalıçarşı, Koza Han ve Ulu Cami ile aynı yürüyüşte, birbirine birkaç adım mesafede görülür.'),
  ('emir-han', 'en', 'Right beside the Grand Mosque, the Emir Han, also known as the Bey Han, was built in the 14th century under Orhan Gazi. It is one of the oldest buildings in the han district that formed Bursa''s commercial centre in Ottoman times.

The courtyard of the two-storey han, with arcaded shops and rooms around it, reflects the layout of an old caravanserai. It is seen on the same walk as the Covered Bazaar, the Koza Han and the Grand Mosque, all a few steps apart.'),
  ('bursa-kapalicarsi', 'tr', 'Bursa Kapalıçarşı, 14. yüzyılın sonunda Yıldırım Bayezid''in yaptırdığı Bedesten çevresinde gelişti. 1855 depremi ve yangınında büyük zarar gören çarşı yeniden yapıldı; Koza Han, Emir Han, Tuz Hanı ve Geyve Hanı gibi hanlarla birlikte yüzyıllardır kentin ticaret merkezidir.

Bedesten''de kuyumcular ve antikacılar, çevredeki sokaklarda ipek, havlu, bıçak ve kestane şekeri satan dükkânlar bulunur. Hanların avlularındaki çay bahçeleri mola vermek için idealdir. Pazar günleri dükkânların çoğu kapalıdır. İçindeki hanlar ayrıca işaretlenebilir.'),
  ('bursa-kapalicarsi', 'en', 'Bursa''s Covered Bazaar grew up around the Bedesten built by Bayezid I at the end of the 14th century. Badly damaged in the earthquake and fire of 1855, it was rebuilt, and together with hans such as the Koza Han, Emir Han, Tuz Han and Geyve Han it has been the city''s commercial heart for centuries.

Jewellers and antique dealers fill the Bedesten, while the streets around it have shops selling silk, towels, knives and candied chestnuts. The tea gardens in the han courtyards are ideal for a break. Most shops close on Sundays. The hans inside can be checked off separately.'),
  ('irgandi-koprusu', 'tr', 'Gökdere üzerindeki Irgandı Köprüsü, 1442''de Irgandılı Ali''nin oğlu Hacı Muslihiddin tarafından yaptırıldı. Üzerinde iki sıra dükkân bulunan, dünyada sayılı örneği kalmış çarşılı köprülerdendir. 1855 depreminde zarar gördü, Kurtuluş Savaşı sırasında büyük ölçüde yıkıldı; 2000''lerde aslına uygun olarak yeniden yapıldı.

Bugün köprünün üzerindeki dükkânlarda el sanatı ustaları çalışır; çini, ahşap, cam ve keçe ürünlerini yapılırken izleyebilirsiniz. Çarşı bölgesinden Yeşil Camii''ye yürürken yol üzerindedir.'),
  ('irgandi-koprusu', 'en', 'Irgandı Bridge over the Gökdere was built in 1442 by Hacı Muslihiddin, son of Ali of Irgandı. With two rows of shops on top, it is one of the few surviving bridges in the world to carry a bazaar. Damaged in the 1855 earthquake and largely destroyed during the War of Independence, it was faithfully rebuilt in the 2000s.

Today craftspeople work in the shops on the bridge, and you can watch tiles, woodwork, glass and felt being made. It lies on the way from the bazaar district to the Green Mosque.'),
  ('tuz-han-bursa', 'tr', 'Kapalıçarşı bölgesindeki Tuz Hanı, 1454''te Timurtaş Paşa''nın oğlu Umur Bey tarafından yaptırıldı ve Umur Bey''in Bursa''daki külliyesine gelir sağlamak üzere vakfedildi. Adını, burada yapılan tuz ticaretinden alır.

Kesme taş ve tuğla ile örülmüş duvarları ve avlu düzeni, erken Osmanlı ticaret yapılarının özelliklerini taşır. Çarşının işlek sokakları arasında, diğer hanlarla birlikte kısa bir durak olarak görülebilir.'),
  ('tuz-han-bursa', 'en', 'The Tuz Han (Salt Han) in the Covered Bazaar district was built in 1454 by Umur Bey, son of Timurtaş Pasha, and endowed to provide income for Umur Bey''s complex in Bursa. It takes its name from the salt trade carried on here.

Its walls of cut stone and brick and its courtyard layout show the features of early Ottoman commercial buildings. It can be seen as a short stop among the busy streets of the bazaar, together with the other hans.'),
  ('geyve-han', 'tr', 'Kapalıçarşı''daki Geyve Hanı, 15. yüzyılda Hacı İvaz Paşa tarafından Yeşil Camii''ye gelir sağlamak amacıyla yaptırıldı ve Sultan Çelebi Mehmed''e armağan edildi. Hacı İvaz Paşa, Yeşil Camii''nin de mimarıydı.

Avlusunu çevreleyen kemerli dükkânlarıyla klasik bir Osmanlı hanıdır; bugün de esnafın çalıştığı canlı bir ticaret yeridir. Bedesten ve Koza Han ile birlikte çarşı gezisinin parçası olarak görülebilir.'),
  ('geyve-han', 'en', 'The Geyve Han in the Covered Bazaar was built in the 15th century by Hacı İvaz Pasha to provide income for the Green Mosque, and was presented to Sultan Mehmed I. Hacı İvaz Pasha was also the architect of the Green Mosque.

With arcaded shops around its courtyard it is a classic Ottoman han, and it remains a lively place of trade where shopkeepers still work. It can be seen as part of a bazaar walk with the Bedesten and the Koza Han.'),
  ('iznik-konsil', 'tr', 'İznik Gölü''nde, kıyıdan kısa bir mesafede su altında kalan bu Bizans bazilikası, 2014''te havadan çekilen fotoğraflarla fark edildi. 4. yüzyıla tarihlenen yapının, bir şehit anısına inşa edilmiş bir kilise olduğu düşünülür; bazı araştırmacılar onu 325''te İznik''te toplanan I. Ekümenik Konsil ile ilişkilendirir, ancak bu kesin değildir.

Göl suları çekildiğinde ya da durgun ve berrak olduğunda bazilikanın duvarları kıyıdan görülebilir. Kazı ve koruma çalışmaları sürdüğü için alana girmeyin; kıyıdaki yürüyüş yolundan izleyin. İznik''in göl kıyısındaki gün batımıyla birlikte görmek güzeldir.'),
  ('iznik-konsil', 'en', 'Lying under the waters of Lake İznik a short distance from the shore, this Byzantine basilica was noticed in aerial photographs in 2014. Dated to the 4th century, it is thought to have been a church built in memory of a martyr; some researchers link it to the First Ecumenical Council held in Nicaea in 325, though this is not certain.

When the lake level drops, or the water is calm and clear, the basilica''s walls can be seen from the shore. As excavation and conservation work continues, do not enter the site; watch from the lakeside path. It is lovely to see together with the sunset over the lake at İznik.'),
  ('iznik-roma-tiyatrosu', 'tr', 'İznik Roma Tiyatrosu, MS 2. yüzyılda, İmparator Traianus döneminde Bithynia valisi olan Genç Plinius''un girişimiyle yapıldı. Plinius''un imparatora yazdığı mektuplarda, tiyatronun yapımındaki sorunlardan söz edilir.

Kazılarla ortaya çıkarılan oturma sıraları, tonozlu koridorlar ve sahne binasının kalıntıları görülebilir; tiyatro sonraki dönemlerde başka yapılar için de kullanılmıştır. Kent merkezine yakındır ve surlarla birlikte yürüyerek gezilebilir.'),
  ('iznik-roma-tiyatrosu', 'en', 'The Roman Theatre of İznik was built in the 2nd century AD on the initiative of Pliny the Younger, governor of Bithynia under the Emperor Trajan. Pliny''s letters to the emperor mention the problems encountered in its construction.

Excavations have revealed rows of seats, vaulted corridors and remains of the stage building; the theatre was also used for other structures in later periods. It is close to the town centre and can be visited on foot together with the walls.'),
  ('aktopraklik-hoyugu', 'tr', 'Bursa''nın yaklaşık 25 km güneybatısında, Akçalar''daki Aktopraklık Höyüğü, Uluabat Gölü''nün doğu kıyısına yakın bir yerleşim alanıdır. Kazılar, burada yaklaşık 8.500 yıl öncesine uzanan köy yerleşimlerinin izlerini ortaya çıkardı.

Alan bir arkeopark olarak düzenlenmiştir: yeniden yapılmış tarih öncesi evler, bu dönemin insanlarının nasıl yaşadığını, ne yiyip nasıl ürettiğini gösterir. Çocuklu aileler için öğretici bir duraktır; Gölyazı ile aynı gün gezilebilir.'),
  ('aktopraklik-hoyugu', 'en', 'About 25 km south-west of Bursa, Aktopraklık Mound at Akçalar is a settlement site near the eastern shore of Lake Uluabat. Excavations have revealed traces of village settlements going back about 8,500 years.

The site is laid out as an archaeopark: reconstructed prehistoric houses show how people of that era lived, what they ate and how they made things. It is an educational stop for families with children and can be visited on the same day as Gölyazı.'),
  ('hisar-arkeopark', 'tr', 'Bursa''nın tarihi kalesi Hisar''ın içindeki arkeopark, kentin Bizans dönemine ait kalıntılarının açık havada sergilendiği bir alandır. Hisar, Bursa''nın ilk yerleşim yeri ve Osmanlıların 1326''da aldığı kalenin bulunduğu bölümdür.

Kazılarda ortaya çıkan yapı temelleri, duvar parçaları ve buluntular yürüyüş yolları boyunca görülebilir. Tophane''deki saat kulesi, Osman Gazi ve Orhan Gazi türbeleri yakındadır; bir Hisar yürüyüşüne kolayca eklenir.'),
  ('hisar-arkeopark', 'en', 'The archaeopark inside Hisar, Bursa''s historic citadel, is an area where remains from the city''s Byzantine period are displayed in the open air. Hisar is where Bursa was first settled and where the castle taken by the Ottomans in 1326 stood.

Building foundations, wall fragments and finds uncovered in the excavations can be seen along the walking paths. The clock tower at Tophane and the tombs of Osman Gazi and Orhan Gazi are nearby, so it fits easily into a walk around Hisar.'),
  ('antik-tiyatro', 'tr', 'Gölyazı''daki tiyatro, antik Apollonia ad Rhyndacum kentine aittir ve Helenistik döneme tarihlenir. Gölyazı''nın Zambaktepe mevkiinde yürütülen kazılar, son yıllarda seyirci basamaklarını yeniden gün ışığına çıkardı; basamakların bazılarında yazıtlar, oturma sıraları arasında ise bir mezar bulundu.

Kazı sürdüğü için alanın bir kısmı ziyarete kapalı olabilir; çit dışından izleyin ve işaretlere uyun. Tiyatro, Gölyazı köyüne giriş yolunun yakınındadır; köyün sokakları ve göl kıyısıyla aynı gezide görülür.'),
  ('antik-tiyatro', 'en', 'The theatre at Gölyazı belonged to the ancient city of Apollonia ad Rhyndacum and dates from the Hellenistic period. Excavations at the Zambaktepe site in Gölyazı have recently brought its rows of seats back to light; inscriptions were found on some of the steps and a tomb between the seating rows.

As digging continues, part of the site may be closed to visitors; watch from outside the fence and follow the signs. The theatre is near the road into Gölyazı village and is seen on the same visit as the village streets and the lakeshore.'),
  ('yesil-turbe', 'tr', 'Yeşil Türbe, 1421''de ölen Sultan I. Mehmed (Çelebi) için oğlu II. Murad tarafından yaptırıldı; mimarı Yeşil Camii''yi de tasarlayan Hacı İvaz Paşa''dır. Şehrin birçok yerinden görülen sekizgen türbe, Bursa''nın simgelerinden biridir.

Dışını kaplayan turkuaz çiniler 1855 depreminden sonra yenilendi; içerideki çini kaplı sanduka ve mihrap ise 15. yüzyıl çini sanatının en güzel örneklerindendir. Türbe sessizce ziyaret edilmelidir. Hemen karşısındaki Yeşil Camii ve çevredeki çay bahçeleri aynı gezide görülür.'),
  ('yesil-turbe', 'en', 'The Green Tomb was built for Sultan Mehmed I (Çelebi), who died in 1421, by his son Murad II; its architect was Hacı İvaz Pasha, who also designed the Green Mosque. Visible from many parts of the city, the octagonal tomb is one of Bursa''s symbols.

The turquoise tiles covering its exterior were renewed after the 1855 earthquake, while the tiled cenotaph and mihrab inside are among the finest examples of 15th-century tilework. The tomb should be visited quietly. The Green Mosque just opposite and the tea gardens around it fit into the same visit.'),
  ('osman-gazi-turbesi', 'tr', 'Tophane''deki Osman Gazi Türbesi, Osmanlı Devleti''nin kurucusu Osman Gazi''nin mezarıdır. Rivayete göre Osman Gazi, Bursa''nın alınmasından sonra buraya gömülmeyi vasiyet etmiş; oğlu Orhan Gazi onu bir Bizans yapısının içine defnettirmiştir. Bugünkü türbe, 1855 depreminden sonra Sultan Abdülaziz döneminde yeniden yapıldı.

Türbe, Osmanlı tarihinin başlangıcını simgeleyen önemli bir ziyaret yeridir; sessiz ve saygılı olunmalıdır. Hemen yanında Orhan Gazi Türbesi ve saat kulesi bulunur; Tophane Parkı''ndan şehrin manzarası görülür.'),
  ('osman-gazi-turbesi', 'en', 'The Tomb of Osman Gazi in Tophane is the burial place of Osman I, founder of the Ottoman state. According to tradition, Osman asked to be buried here after Bursa''s capture, and his son Orhan laid him to rest inside a Byzantine building. The present tomb was rebuilt under Sultan Abdülaziz after the earthquake of 1855.

The tomb is an important place of visit symbolising the beginning of Ottoman history; be quiet and respectful. The Tomb of Orhan Gazi and the clock tower are right beside it, and Tophane Park looks out over the city.'),
  ('hacivat-karagoz-anit-mezari', 'tr', 'Çekirge''deki Hacivat ve Karagöz Anıt Mezarı, gölge oyununun iki ünlü karakterine adanmış sembolik bir mezardır. Rivayete göre Hacivat ile Karagöz, Orhan Gazi döneminde bir caminin inşaatında çalışan ve şakalaşmalarıyla işi aksattıkları için idam edilen iki ustaydı; onların hikâyesi gölge oyununa dönüştü.

Anıt mezar, Bursa''nın Karagöz geleneğine bağlılığının simgesidir. Hemen karşısındaki Karagöz Müzesi ile birlikte gezilmesi önerilir; Çekirge''nin tarihi kaplıcaları da yakındır.'),
  ('hacivat-karagoz-anit-mezari', 'en', 'The Monumental Tomb of Hacivat and Karagöz in Çekirge is a symbolic grave dedicated to the two famous characters of shadow theatre. Legend says Hacivat and Karagöz were two builders working on a mosque in Orhan Gazi''s time who were executed because their joking held up the work, and their story became the shadow play.

The tomb symbolises Bursa''s attachment to the Karagöz tradition. It is best visited with the Karagöz Museum just opposite, and Çekirge''s historic thermal baths are nearby.'),
  ('orhan-gazi-turbesi', 'tr', 'Tophane''deki Orhan Gazi Türbesi, Osmanlı''nın ikinci hükümdarı ve Bursa''nın fatihi Orhan Gazi''nin mezarıdır. Babası Osman Gazi''nin türbesinin hemen yanındadır. Türbe, eski bir Bizans kilisesinin yerinde yer alır ve 1855 depreminden sonra yeniden yapıldı.

İçeride, eski kiliseden kalan mozaik döşeme parçaları görülebilir. Osman Gazi Türbesi, saat kulesi ve Tophane Parkı''nın manzarasıyla birlikte ziyaret edilir; sessiz ve saygılı olunmalıdır.'),
  ('orhan-gazi-turbesi', 'en', 'The Tomb of Orhan Gazi in Tophane is the burial place of the second Ottoman ruler and conqueror of Bursa. It stands right beside the tomb of his father, Osman Gazi. The tomb occupies the site of an old Byzantine church and was rebuilt after the earthquake of 1855.

Inside, fragments of the mosaic floor of the old church can be seen. It is visited together with the Tomb of Osman Gazi, the clock tower and the view from Tophane Park; be quiet and respectful.'),
  ('sehzade-mustafa-turbesi', 'tr', 'Muradiye Külliyesi''ndeki Şehzade Mustafa Türbesi, Kanuni Sultan Süleyman''ın 1553''te idam ettirilen oğlu Şehzade Mustafa''ya aittir. Türbe, II. Selim döneminde, 1570''lerde yaptırıldı.

İç duvarları kaplayan 16. yüzyıl İznik çinileri, Muradiye''deki türbelerin en zengin süslemelerindendir; çinilerin desenlerine ve renklerine yakından bakın. Muradiye bahçesindeki diğer türbelerle birlikte, sessizce ziyaret edilmelidir.'),
  ('sehzade-mustafa-turbesi', 'en', 'The Tomb of Prince Mustafa in the Muradiye Complex belongs to the son of Suleiman the Magnificent who was executed in 1553. The tomb was built under Selim II in the 1570s.

The 16th-century İznik tiles covering its inner walls are among the richest decoration of any tomb at Muradiye; look closely at the patterns and colours. It should be visited quietly, together with the other tombs in the Muradiye garden.'),
  ('cem-sultan-turbesi', 'tr', 'Muradiye Külliyesi''ndeki Cem Sultan Türbesi, Fatih Sultan Mehmed''in oğlu Cem Sultan''ın mezarıdır. Kardeşi II. Bayezid ile taht mücadelesini kaybeden Cem, yıllarını Avrupa''da esir olarak geçirdi ve 1495''te İtalya''da öldü; naaşı birkaç yıl sonra Bursa''ya getirildi.

Türbenin iç mekânı, kubbeyi ve duvarları kaplayan zengin kalem işleri ve alt kısımdaki çinileriyle Muradiye''nin en etkileyici türbelerindendir. Aynı türbede başka şehzadeler de yatar. Sessizce ve kurallara uyarak ziyaret edin.'),
  ('cem-sultan-turbesi', 'en', 'The Tomb of Cem Sultan in the Muradiye Complex is the burial place of Cem, son of Mehmed the Conqueror. Having lost the struggle for the throne to his brother Bayezid II, Cem spent years as a captive in Europe and died in Italy in 1495; his body was brought to Bursa a few years later.

With rich painted decoration covering the dome and walls and tiles on the lower parts, its interior is one of the most impressive at Muradiye. Other princes are buried in the same tomb. Visit quietly and follow the rules.'),
  ('ebe-gulbahar-hatun-turbesi', 'tr', 'Muradiye Külliyesi''nin bahçesindeki küçük türbe, Ebe Hatun olarak da anılan Gülbahar Hatun''a aittir. Muradiye''deki türbeler, II. Murad''dan sonra yaklaşık bir yüzyıl boyunca Osmanlı hanedanının kadın ve şehzade üyelerinin gömüldüğü yer oldu.

Sade yapısıyla bahçedeki görkemli türbeler arasında daha alçakgönüllü bir yer tutar. Selvi ve çınarların gölgesindeki bahçede, diğer türbelerle birlikte gezilir.'),
  ('ebe-gulbahar-hatun-turbesi', 'en', 'The small tomb in the garden of the Muradiye Complex belongs to Gülbahar Hatun, also known as Ebe Hatun. After Murad II, the Muradiye tombs became the burial place of women and princes of the Ottoman dynasty for about a century.

Plain in form, it holds a more modest place among the grander tombs of the garden. It is seen together with the other tombs in the garden shaded by cypresses and plane trees.'),
  ('emirsultan-hz-turbesi', 'tr', 'Emir Sultan Camii''nin yanındaki türbe, Buharalı âlim ve sufi Emir Sultan''a (Şemseddin Muhammed Buhari) aittir. Yıldırım Bayezid''in damadı olan Emir Sultan, Bursa''da büyük saygı gören bir manevi önderdi. Türbe, cami gibi depremlerden sonra 19. yüzyılda yeniden yapıldı.

Bursa''nın en çok ziyaret edilen türbelerinden biridir; özellikle cuma günleri ve kandil gecelerinde kalabalık olur. Ziyaret sırasında sessiz olun ve uygun giyinin. Avludan şehrin ve ovanın manzarası görülür.'),
  ('emirsultan-hz-turbesi', 'en', 'The tomb beside the Emir Sultan Mosque belongs to the Bukharan scholar and Sufi Emir Sultan (Şemseddin Muhammed Buhari). Son-in-law of Bayezid I, Emir Sultan was a deeply respected spiritual leader in Bursa. Like the mosque, the tomb was rebuilt in the 19th century after earthquakes.

It is one of the most visited tombs in Bursa, crowded especially on Fridays and on holy nights. Be quiet and dress appropriately during your visit. The courtyard looks out over the city and the plain.'),
  ('gulruh-hatun-turbesi', 'tr', 'Muradiye Külliyesi''ndeki Gülruh Hatun Türbesi, Sultan II. Bayezid''in eşlerinden Gülruh Hatun''a aittir. Bahçedeki türbeler, Osmanlı sarayındaki kadınların ve şehzadelerin hikâyelerini bir araya getirir.

Sade bir yapı olan türbe, Muradiye bahçesindeki gezinin bir durağıdır. Türbelerin açık olup olmadığı değişebilir; görevliye danışın ve sessiz olun.'),
  ('gulruh-hatun-turbesi', 'en', 'The Tomb of Gülruh Hatun in the Muradiye Complex belongs to one of the consorts of Sultan Bayezid II. The tombs in the garden bring together the stories of the women and princes of the Ottoman court.

A plain building, the tomb is one stop on a walk through the Muradiye garden. Whether the tombs are open may vary; ask the attendant and keep quiet.'),
  ('gulsah-hatun-turbesi', 'tr', 'Muradiye Külliyesi''ndeki Gülşah Hatun Türbesi, Fatih Sultan Mehmed''in eşlerinden Gülşah Hatun''a aittir. Muradiye bahçesi, hanedanın birçok kadın üyesinin son durağı oldu.

Küçük ve sade türbe, bahçedeki diğer türbelerle birlikte görülür. Muradiye''nin gölgeli bahçesinde, türbeler arasında sakin bir yürüyüş yapmak ziyaretin en güzel yanıdır.'),
  ('gulsah-hatun-turbesi', 'en', 'The Tomb of Gülşah Hatun in the Muradiye Complex belongs to one of the consorts of Mehmed the Conqueror. The Muradiye garden became the final resting place of many women of the dynasty.

The small, plain tomb is seen together with the other tombs in the garden. A quiet stroll among the tombs in Muradiye''s shady garden is the best part of a visit.'),
  ('huma-hatun-turbesi', 'tr', 'Muradiye Külliyesi''ndeki Hüma Hatun Türbesi, Sultan II. Murad''ın eşi ve Fatih Sultan Mehmed''in annesi Hüma Hatun''a aittir. Hüma Hatun, oğlunun İstanbul''u almasından birkaç yıl önce öldü.

Sade mimarisiyle dikkat çeken türbe, İstanbul''u fetheden padişahın annesinin mezarı olması nedeniyle ziyaretçilerin ilgisini çeker. Muradiye bahçesindeki diğer türbelerle birlikte sessizce ziyaret edilir.'),
  ('huma-hatun-turbesi', 'en', 'The Tomb of Hüma Hatun in the Muradiye Complex belongs to the consort of Sultan Murad II and mother of Mehmed the Conqueror. Hüma Hatun died a few years before her son took Constantinople.

Notable for its plain architecture, the tomb draws visitors as the grave of the mother of the sultan who conquered Istanbul. It is visited quietly together with the other tombs in the Muradiye garden.'),
  ('cumalikizik', 'tr', 'Uludağ''ın kuzey eteğinde, Bursa''ya yaklaşık 11 km uzaklıktaki Cumalıkızık, erken Osmanlı döneminde kurulan beş Kızık köyünden biridir ve bugün de yaşayan bir köydür. 2014''te Bursa ile birlikte ''Osmanlı İmparatorluğu''nun Doğuşu'' adıyla UNESCO Dünya Mirası Listesi''ne alındı.

Taş döşeli dar sokaklar, ahşap ve kerpiçten iki üç katlı evler ve küçük köy meydanı yüzyıllardır büyük ölçüde korunmuştur. Köy kahvaltısı, gözleme ve ahududu ünlüdür. Hafta sonları çok kalabalık olur; köyde insanların yaşadığını unutmayın, evlerin içini izinsiz fotoğraflamayın. İçindeki yerler ayrıca işaretlenebilir.'),
  ('cumalikizik', 'en', 'On the northern slopes of Uludağ, about 11 km from Bursa, Cumalıkızık is one of five Kızık villages founded in the early Ottoman period and is still lived in today. In 2014 it was added to the UNESCO World Heritage List together with Bursa as ''the Birth of the Ottoman Empire''.

Narrow cobbled streets, two- and three-storey houses of timber and mud brick and the small village square have been largely preserved for centuries. The village breakfast, gözleme and raspberries are famous. It gets very crowded at weekends; remember that people live here and do not photograph inside homes without permission. The places inside can be checked off separately.'),
  ('golyazi-adasi', 'tr', 'Uluabat Gölü''ne uzanan küçük bir yarımada üzerindeki Gölyazı, antik Apollonia ad Rhyndacum kentinin yerinde kurulmuştur. Mübadeleye kadar Rum ve Türk ailelerin birlikte yaşadığı balıkçı köyü, bugün taş ve ahşap evleri, eski kilisesi ve antik kalıntılarıyla Bursa''nın en sevilen kaçış noktalarındandır.

Göl kıyısındaki balıkçı tekneleri, çatılardaki leylek yuvaları ve gün batımı manzarası ünlüdür; tekne turuyla Apollon Tapınağı''nın bulunduğu Kız Adası''na gidilebilir. Hafta sonları kalabalık olur, gün batımından önce gelin. İçindeki yerler ayrıca işaretlenebilir.'),
  ('golyazi-adasi', 'en', 'Set on a small peninsula reaching into Lake Uluabat, Gölyazı was built on the site of the ancient city of Apollonia ad Rhyndacum. A fishing village where Greek and Turkish families lived together until the population exchange, it is today one of Bursa''s favourite escapes with its stone and timber houses, old church and ancient remains.

The fishing boats along the shore, the stork nests on the roofs and the sunset are famous, and a boat trip takes you to Kız Adası, where the Temple of Apollo stood. It gets busy at weekends, so arrive before sunset. The places inside can be checked off separately.'),
  ('misi', 'tr', 'Nilüfer Çayı''nın kıyısındaki Misi (bugünkü adıyla Gümüştepe), Bursa''nın hemen yanında taş evleri ve yemekleriyle bilinen eski bir köydür. Mübadeleye kadar Rum nüfusun da yaşadığı köyün dokusu, yamaca kurulmuş taş evleriyle korunmuştur.

Dere kenarındaki çınarların altında yapılan kahvaltılar ve Misi''ye özgü mantı ile gözleme ünlüdür. Köyün dar sokaklarında kısa bir yürüyüş yapıp dere kıyısında oturabilirsiniz. Şehir merkezine çok yakın olduğundan hafta sonu kahvaltısı için popülerdir.'),
  ('misi', 'en', 'Misi (today officially Gümüştepe), on the banks of the Nilüfer stream, is an old village right next to Bursa known for its stone houses and food. Home also to a Greek population until the population exchange, it has kept its fabric of stone houses built up the hillside.

Breakfasts under the plane trees by the stream and Misi''s own mantı and gözleme are famous. You can take a short walk through the village''s narrow streets and sit by the water. Being very close to the city centre, it is popular for weekend breakfasts.'),
  ('tirilye', 'tr', 'Mudanya yakınlarındaki Tirilye, Bizans döneminde Trigleia adıyla bilinen, mübadeleye kadar Rum nüfusun yaşadığı eski bir liman köyüdür. 1968-2012 arasında Zeytinbağı adını taşıdı; zeytinlikleri bugün de ünlüdür.

Taş evlerle çevrili dar sokaklarda Fatih Camii''ne dönüşen Bizans kilisesi, Kemerli Kilise ve bir sarnıçtan beslenen Bizans dönemi Sofalı Çeşme görülebilir. Sahildeki balık lokantaları ve zeytin-zeytinyağı satan dükkânlar gezinin parçasıdır. İçindeki yapılar ayrıca işaretlenebilir.'),
  ('tirilye', 'en', 'Near Mudanya, Tirilye is an old harbour village known in Byzantine times as Trigleia and home to a Greek population until the population exchange. Between 1968 and 2012 it was called Zeytinbağı (''olive grove''), and its olives are still famous today.

In the narrow streets lined with stone houses you can see the Byzantine church turned into the Fatih Mosque, the Arched Church and the Byzantine Sofalı Fountain fed by a cistern. The fish restaurants on the shore and shops selling olives and olive oil are part of the visit. The buildings inside can be checked off separately.'),
  ('zeyniller-koyu-seyir-tepesi', 'tr', 'Uludağ''ın eteğindeki Zeyniler köyünün yakınındaki seyir tepesi, Bursa ovasına ve şehre yukarıdan bakan bir noktadır. Ağaçlık yamaçlar arasında, şehrin kalabalığından uzak sakin bir yerdir.

Gün batımında ve gece şehir ışıklarının yandığı saatlerde manzara özellikle güzeldir. Köye giden yol virajlıdır; dikkatli sürün ve akşam serinliği için yanınıza bir hırka alın. Köydeki kahvaltı ve gözleme yerleriyle birlikte bir yarım gün geçirilebilir.'),
  ('zeyniller-koyu-seyir-tepesi', 'en', 'Near the village of Zeyniler on the slopes of Uludağ, this viewpoint looks down over the Bursa plain and the city. Among wooded slopes, it is a quiet spot away from the bustle of the city.

The view is especially beautiful at sunset and at night when the city lights come on. The road to the village is winding, so drive carefully, and bring a jumper for the cool evening. You can spend half a day here together with the village''s breakfast and gözleme places.'),
  ('uludag', 'tr', 'Bursa''nın güneyinde yükselen Uludağ, yaklaşık 2.543 metre yüksekliğiyle Marmara Bölgesi''nin en yüksek dağıdır. Antik çağda Misya Olimposu olarak bilinirdi. Bugün Türkiye''nin en tanınmış kış sporları merkezlerinden biridir.

Kışın kayak merkezi ve otelleri kalabalıklaşır; yazın ise ormanlarda yürüyüş, zirveye yakın buzul gölleri ve piknik alanları ilgi çeker. Şehirden Teferrüç''ten kalkan teleferikle ya da karayoluyla çıkılır. Hava dağda hızla değişebilir; yazın bile kalın giysi alın, kışın yol durumunu ve zincir zorunluluğunu kontrol edin.'),
  ('uludag', 'en', 'Rising south of Bursa, Uludağ is the highest mountain in the Marmara region at about 2,543 metres. Known in antiquity as the Mysian Olympus, it is today one of Turkey''s best-known winter sports centres.

In winter the ski resort and hotels fill up; in summer, forest walks, the glacial lakes near the summit and picnic areas draw visitors. You go up from the city by the cable car from Teferrüç or by road. The weather on the mountain can change quickly; bring warm clothes even in summer, and in winter check road conditions and chain requirements.'),
  ('uludag-milli-parki', 'tr', 'Uludağ Millî Parkı, 1961''de ilan edildi ve dağın ormanlarını, göllerini ve zirve bölgesini koruma altına alır. Karaçam, kayın ve göknar ormanları, yükseklere çıktıkça yerini alpin çayırlara ve kayalık alanlara bırakır.

Yaz aylarında işaretli yürüyüş yolları, zirveye yakın buzul gölleri ve kamp alanları en çok ilgi gören bölümlerdir. Parka teleferik ya da karayoluyla ulaşılır. Doğal alanda ateş yakma kurallarına uyun, çöplerinizi geri götürün ve yaban hayatını rahatsız etmeyin.'),
  ('uludag-milli-parki', 'en', 'Uludağ National Park was declared in 1961 and protects the mountain''s forests, lakes and summit area. Forests of black pine, beech and fir give way to alpine meadows and rocky ground as you climb.

In summer, the marked trails, the glacial lakes near the summit and the camping areas are the most popular parts. The park is reached by cable car or by road. Follow the rules on fires, take your rubbish back with you and do not disturb wildlife.'),
  ('karacabey-longoz-ormanlari', 'tr', 'Karacabey Longozu, Susurluk Irmağı''nın Marmara Denizi''ne döküldüğü Kocaçay Deltası''nda yer alan bir subasar ormanıdır. Kış ve ilkbaharda sularla kaplanan bu orman türü Türkiye''de çok az yerde kalmıştır ve delta, kuşlar için önemli bir yaşam alanıdır.

İlkbaharda orman zemini çiçeklerle kaplanır ve ağaçların gövdeleri suya yansır; fotoğrafçılar için en güzel zamandır. Patikalar yer yer çamurlu olur, uygun ayakkabı giyin ve sivrisineğe karşı hazırlıklı gelin. Kuşları rahatsız etmemek için sessiz olun.'),
  ('karacabey-longoz-ormanlari', 'en', 'The Karacabey Floodplain Forest lies in the Kocaçay Delta, where the Susurluk River flows into the Sea of Marmara. This type of forest, flooded in winter and spring, survives in very few places in Turkey, and the delta is an important habitat for birds.

In spring the forest floor is carpeted with flowers and the tree trunks are reflected in the water, the best time for photographers. Paths can be muddy in places, so wear suitable shoes and come prepared for mosquitoes. Keep quiet so as not to disturb the birds.'),
  ('sadagi-kanyonu-tabiat-parki', 'tr', 'Orhaneli''ye bağlı Sadağı köyündeki kanyon, Bursa''nın yaklaşık 55 km güneybatısındadır ve tabiat parkı olarak koruma altındadır. Kilometrelerce uzanan kanyonun dik kaya duvarları arasından berrak bir dere akar.

Kanyon boyunca uzanan yürüyüş yolu, köprüler ve basamaklarla dere kenarında ilerler; yolda küçük şelaleler ve su birikintileri görülür. Kayalar kaygan olabileceğinden kaymayan ayakkabı giyin. İlkbahar ve sonbahar en uygun zamanlardır; yağışlı günlerde ani su yükselmelerine dikkat edin.'),
  ('sadagi-kanyonu-tabiat-parki', 'en', 'The canyon at the village of Sadağı in Orhaneli lies about 55 km south-west of Bursa and is protected as a nature park. A clear stream flows between the steep rock walls of the canyon, which stretches for kilometres.

The trail along the canyon follows the stream with bridges and steps, passing small waterfalls and pools. Rocks can be slippery, so wear non-slip shoes. Spring and autumn are the best times; on rainy days watch out for sudden rises in the water.'),
  ('uluabat-golu-sulak-alani', 'tr', 'Bursa''nın batısındaki Uluabat (Apolyont) Gölü, su seviyesine göre 135-160 km² arasında değişen geniş bir tatlı su gölüdür. 1998''den beri uluslararası öneme sahip Ramsar alanıdır; nilüferleri, sazlıkları ve kuşlarıyla Türkiye''nin önemli sulak alanlarındandır.

Göl kıyısındaki Gölyazı ve leylekleriyle bilinen Eskikaraağaç köyü, gölü görmek için en iyi noktalardır. Yaz başında nilüferlerin açtığı dönem ve kuş göçü mevsimleri özellikle güzeldir. Tekne turlarıyla gölün adalarına ve sazlıklarına gidilebilir.'),
  ('uluabat-golu-sulak-alani', 'en', 'Lake Uluabat (Apolyont), west of Bursa, is a large freshwater lake whose area varies between 135 and 160 km² with the water level. A Ramsar site of international importance since 1998, it is one of Turkey''s important wetlands with its water lilies, reed beds and birds.

Gölyazı on the shore and the village of Eskikaraağaç, known for its storks, are the best places to see the lake. The early-summer period when the water lilies bloom and the bird migration seasons are especially lovely. Boat trips take you to the lake''s islands and reed beds.'),
  ('resat-oyal-kultur-parki', 'tr', 'Reşat Oyal Kültür Parkı, 1955''te Belediye Başkanı Reşat Oyal tarafından Kültürpark adıyla açıldı ve Bursa''nın en eski parklarındandır. Şehrin merkezinde, yaklaşık 39 hektarlık bir alana yayılır.

Ağaçlık yürüyüş yolları, göleti, açık hava tiyatrosu ve çay bahçeleriyle şehrin nefes alma yeridir; Bursa Arkeoloji Müzesi de parkın içindedir. Yazın akşamları konser ve etkinliklerle canlanır. Müze ziyaretini bir park yürüyüşüyle birleştirin.'),
  ('resat-oyal-kultur-parki', 'en', 'Reşat Oyal Cultural Park was opened in 1955 by Mayor Reşat Oyal under the name Kültürpark and is one of Bursa''s oldest parks. It covers about 39 hectares in the centre of the city.

With tree-lined paths, a pond, an open-air theatre and tea gardens, it is the city''s breathing space, and the Bursa Archaeological Museum is inside the park. On summer evenings it comes alive with concerts and events. Combine a museum visit with a walk in the park.'),
  ('merinos-parki', 'tr', 'Merinos Parkı, Cumhuriyet döneminde sanayileşmenin simgelerinden olan Sümerbank Merinos Fabrikası''nın arazisinde kuruldu. Bursa''nın en büyük kent parklarından biridir.

Geniş çimenlik alanları, göletleri ve yürüyüş yollarının yanında, fabrikanın tarihi binalarında açılan Tekstil Sanayi Müzesi, Enerji Müzesi ve Atatürk Kongre Kültür Merkezi parkın içindedir. Hafta sonları aileler ve sporcularla dolar. İçindeki müzeler ayrıca işaretlenebilir.'),
  ('merinos-parki', 'en', 'Merinos Park was laid out on the grounds of the Sümerbank Merinos Factory, a symbol of the Republic''s industrialisation. It is one of Bursa''s largest city parks.

Besides wide lawns, ponds and walking paths, the Textile Industry Museum, the Energy Museum and the Atatürk Congress and Culture Centre, housed in the factory''s historic buildings, are inside the park. At weekends it fills with families and people exercising. The museums inside can be checked off separately.'),
  ('mudanya-sahili', 'tr', 'Mudanya''nın deniz kıyısı, tarihi evlerin, balık restoranlarının ve kafelerin sıralandığı canlı bir sahil şerididir. Mudanya, Osmanlı döneminde Bursa''nın limanıydı ve 19. yüzyılın sonunda Bursa''ya demiryoluyla bağlandı.

Sahil yolunda yürüyüş yaparken Mütareke Evi''ni, eski tren istasyonu binalarını ve cumbalı taş evleri görebilirsiniz. Gün batımında balık yemek ya da iskelede deniz otobüslerini izlemek Mudanya''nın keyfidir. Hafta sonları kalabalık olur.'),
  ('mudanya-sahili', 'en', 'Mudanya''s waterfront is a lively seaside strip lined with historic houses, fish restaurants and cafés. In Ottoman times Mudanya was Bursa''s port, and at the end of the 19th century it was linked to Bursa by railway.

Walking along the seafront you can see the Armistice House, the old railway station buildings and stone houses with bay windows. Eating fish at sunset or watching the sea buses at the pier is the pleasure of Mudanya. It gets busy at weekends.'),
  ('kursunlu-plaji', 'tr', 'Karacabey''e bağlı Kurşunlu''daki plaj, Marmara Denizi kıyısında uzanan uzun ve kumlu bir halk plajıdır. Son yıllardaki düzenlemelerle Bursa''nın en çok tercih edilen yaz noktalarından biri haline geldi.

Geniş kumsalı sayesinde kalabalık günlerde bile yer bulmak kolaydır. Bursa merkezine yaklaşık bir saatlik sürüş uzaklığındadır; Karacabey''den sonra Kurşunlu tabelalarını izleyin. Gemlik''teki aynı adlı Kurşunlu ile karıştırmayın.'),
  ('kursunlu-plaji', 'en', 'The beach at Kurşunlu in Karacabey district is a long, sandy public beach on the Sea of Marmara. Recent improvements have made it one of Bursa''s most popular summer spots.

Its wide sands make it easy to find space even on busy days. It is about an hour''s drive from central Bursa; after Karacabey, follow the signs for Kurşunlu. Do not confuse it with the Kurşunlu of the same name in Gemlik.'),
  ('gemlik-kursunlu-plaji', 'tr', 'Gemlik''e bağlı Kurşunlu''daki halk plajı, Gemlik Körfezi kıyısında yaklaşık 3,5 kilometre boyunca uzanır ve ücretsizdir. Plajın arkasındaki defne ve ıhlamur ağaçlarıyla kaplı orman, sıcak yaz günlerinde gölge sağlar.

Belediyenin yaptığı düzenlemelerle sahil yeşil alanlar, yürüyüş yolu ve aydınlatmayla bir kordona dönüştü; yalnızca kadınlara ayrılmış bir plaj bölümü de vardır. Hafta sonları Bursalıların akınına uğrar, erken gidin. Karacabey''deki aynı adlı Kurşunlu ile karıştırmayın.'),
  ('gemlik-kursunlu-plaji', 'en', 'The public beach at Kurşunlu in Gemlik district stretches for about 3.5 kilometres along the Gulf of Gemlik and is free of charge. The woods of laurel and linden behind the beach give shade on hot summer days.

Municipal improvements have turned the shore into a promenade with green areas, a walking path and lighting, and there is also a women-only section. It is packed with people from Bursa at weekends, so go early. Do not confuse it with the Kurşunlu of the same name in Karacabey.'),
  ('suuctu-selalesi', 'tr', 'Mustafakemalpaşa''ya yaklaşık 18 km uzaklıktaki Suuçtu Şelalesi, ormanın içinde yaklaşık 38 metre yükseklikten dökülür. Şelaleyi besleyen su, ilçenin içme suyu ihtiyacını da karşılar.

Şelalenin dibine kısa bir yürüyüşle inilir; çevresi piknik ve mesire alanı olarak düzenlenmiştir. Su en bol halini ilkbaharda alır. Kayalar ıslak ve kaygan olabilir, dikkatli olun ve doğal alanı temiz bırakın.'),
  ('suuctu-selalesi', 'en', 'About 18 km from Mustafakemalpaşa, Suuçtu Waterfall drops about 38 metres in the middle of the forest. The water that feeds it also supplies the district''s drinking water.

A short walk takes you down to the foot of the falls, and the surroundings are laid out as a picnic and recreation area. The water is at its fullest in spring. The rocks can be wet and slippery, so take care and leave the natural area clean.'),
  ('saitabat-selalesi', 'tr', 'Bursa''nın doğusunda, Uludağ''ın eteğindeki Saitabat köyünün yakınındaki şelale, ormanlık bir vadide yer alır. Çevresi mesire yeri olarak kullanılır ve şehirden kısa bir sürüşle ulaşılan serin bir kaçış noktasıdır.

Şelaleye giden patika orman içinden geçer; su ilkbahar aylarında en coşkulu halindedir. Köydeki kahvaltı yerleri ve dere kenarındaki çay ocaklarıyla birlikte yarım günlük bir doğa gezisi yapılabilir. Patika yer yer kaygan olabilir.'),
  ('saitabat-selalesi', 'en', 'East of Bursa, near the village of Saitabat on the slopes of Uludağ, this waterfall lies in a wooded valley. The area around it is used for picnics and is a cool escape a short drive from the city.

The path to the falls runs through the forest, and the water is at its most vigorous in spring. With the village''s breakfast places and tea stalls by the stream, it makes a half-day nature outing. The path can be slippery in places.'),
  ('oylat-selalesi', 'tr', 'İnegöl''e bağlı Oylat''taki şelale, Uludağ''ın güneydoğu uzantılarında, çam ve kayın ormanlarıyla kaplı bir vadide yer alır. Oylat Kaplıcaları''ndan başlayan yaklaşık 2-3 kilometrelik orman yürüyüşüyle ulaşılır.

Kolay sayılabilecek patika, dere boyunca ilerleyerek şelalenin önündeki küçük havuza varır. Kaplıca ziyareti ve yakındaki Oylat Mağarası ile birlikte bir gün planlanabilir. Yağışlı havalarda patika çamurlu olur, uygun ayakkabı giyin.'),
  ('oylat-selalesi', 'en', 'The waterfall at Oylat in İnegöl district lies in a valley covered with pine and beech forest on the south-eastern spurs of Uludağ. It is reached by a forest walk of about 2-3 kilometres starting from the Oylat thermal springs.

The fairly easy path follows the stream to a small pool in front of the falls. A day can be planned around a visit to the springs and the nearby Oylat Cave. The path gets muddy in wet weather, so wear suitable shoes.')
  ) v(slug, lang, long_desc)
  join public.places p on p.slug = v.slug
 where t.place_id = p.id and t.lang = v.lang;
