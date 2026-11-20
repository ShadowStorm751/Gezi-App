-- İzmir uzun açıklamaları, 2. parti (22 yer, TR + EN).
-- Üreten: data-pipeline/content/build_long_desc.py (kaynak: content/izmir_long_descriptions.py).
-- Metinler kendi cümlelerimizdir; Vikipedi/Wikidata yalnızca bilgi kontrolü için kullanıldı.

update public.place_translations t
   set long_desc = v.long_desc
  from (values
  ('latife-hanim-kosku-ani-evi', 'tr', 'Karşıyaka''da, Bahriye Üçok Bulvarı üzerindeki bu köşk, Latife Hanım''ın ailesi Uşakizadelerin yazlık eviydi ve 1860''larda yapıldığı düşünülür. Atatürk''ün annesi Zübeyde Hanım, hastalığı nedeniyle 1922''nin sonunda İzmir''e geldi ve son günlerini burada geçirerek bu evde hayatını kaybetti. Köşk sonraki yıllarda adliye ve dershane olarak kullanıldı; belediyenin restorasyonunun ardından 2008''de anı evi olarak açıldı.

Odalarda dönemin mobilyaları ve eşyalarının yanı sıra Atatürk, Latife Hanım ve Zübeyde Hanım''ın balmumu heykelleri yer alır. Köşk, 2020 Ege Denizi depreminde hasar görünce güçlendirme için geçici olarak kapatılmıştı; gitmeden önce açık olup olmadığını kontrol edin. Karşıyaka sahili ve çarşısı yakındadır.'),
  ('latife-hanim-kosku-ani-evi', 'en', 'On Bahriye Üçok Boulevard in Karşıyaka, this mansion was the summer house of the Uşakizade family, Latife Hanım''s relatives, and is thought to date from the 1860s. Atatürk''s mother Zübeyde Hanım came to İzmir because of illness at the end of 1922, spent her last days here and died in this house. Later used as a courthouse and a tutoring school, it was restored by the municipality and opened as a memorial house in 2008.

The rooms show period furniture and belongings, along with wax figures of Atatürk, Latife Hanım and Zübeyde Hanım. The mansion was closed temporarily for strengthening after damage in the 2020 Aegean Sea earthquake, so check whether it is open before you go. The Karşıyaka waterfront and market are close by.'),
  ('forbes-kosku', 'tr', 'Buca''daki Forbes Köşkü, ilçede yaşayan Levanten Forbes ailesi tarafından 1908''de yaptırıldı. Bir yıl sonra çıkan yangında tamamen yandı ve 1910''da yeniden inşa edildi. Forbes''lardan sonra Whittall ailesi burada yaşadı; 1950''den itibaren uzun yıllar poliklinik olarak kullanıldı ve 1999''da restorasyonuna başlandı.

Bugün Buca Devlet Hastanesi''nin bahçesinde duran köşk, yakındaki Rees Köşkü''ne benzeyen ama daha karışık bir üslubu yansıtan cephesiyle Buca''nın Levanten mirasının örneklerindendir. Şirinyer''deki ünlü Forbes Caddesi adını bu aileden alır. Buca''daki diğer Levanten köşkleriyle birlikte bir yürüyüşe eklenebilir.'),
  ('forbes-kosku', 'en', 'Forbes Mansion in Buca was built in 1908 by the Levantine Forbes family who lived in the district. A year later it burned down completely and was rebuilt in 1910. After the Forbes family the Whittalls lived here; from 1950 it served for many years as an outpatient clinic, and restoration began in 1999.

Standing today in the garden of Buca State Hospital, it is an example of Buca''s Levantine heritage, with a façade similar to the nearby Rees Mansion but in a more mixed style. The well-known Forbes Street in Şirinyer takes its name from the family. Add it to a walk past Buca''s other Levantine mansions.'),
  ('bizans-sarayi', 'tr', 'Efes ören yerinin kuzey kesiminde kalan bu büyük yapı kalıntısı, Bizans Sarayı olarak anılır. Geç antik çağda, kentin önemli bir yöneticisine ya da din adamına ait konut ve kabul mekânı olduğu düşünülür; büyük salonları ve kalın tuğla duvarları, Efes''in Hristiyanlık döneminde de önemli bir merkez olduğunu gösterir.

Ana gezi yolunun biraz dışında kaldığı için çoğu ziyaretçi uğramaz; kalabalıktan uzak bir köşe arıyorsanız Meryem Kilisesi ve Liman Hamamı yönüne doğru yürürken görebilirsiniz. Kalıntıların üzerine çıkmayın ve işaretli yollarda kalın.'),
  ('bizans-sarayi', 'en', 'This large ruined building in the northern part of the Ephesus site is known as the Byzantine Palace. It is thought to have been the residence and reception hall of an important official or churchman in late antiquity; its great halls and thick brick walls show that Ephesus remained a major centre in the Christian era.

Lying a little off the main route, it is skipped by most visitors; if you want a quieter corner, you can see it while walking towards the Church of Mary and the Harbour Baths. Do not climb on the ruins and stay on the marked paths.'),
  ('v-sarayi', 'tr', 'Pergamon akropolünün tepesinde, Bergama krallarının saraylarının bulunduğu bölümde yer alan V Sarayı, bunların en büyüğüdür. Kral II. Eumenes''e ait olduğu düşünülür. Ortasında sütunlu bir avlu bulunan sarayın odaları mozaiklerle süslüydü; buradan çıkan mozaiklerin bir kısmı bugün Berlin''dedir.

Bugün görülenler temel duvarları ve avlunun planıdır; buna karşın krallığın gücünü hissettiren bir konumdadır. Akropolde Trajan Tapınağı, tiyatro ve Athena Kutsal Alanı''na giderken yolunuzun üzerindedir. Teleferikle çıkılan akropol rüzgârlı ve gölgesizdir; şapka ve su almayı unutmayın.'),
  ('v-sarayi', 'en', 'On the summit of the Pergamon acropolis, in the area where the Attalid kings'' palaces stood, Palace V is the largest of them. It is thought to have belonged to King Eumenes II. Its rooms, arranged around a colonnaded courtyard, were decorated with mosaics, some of which are now in Berlin.

What you see today are the foundation walls and the courtyard plan, yet the setting still conveys the power of the kingdom. It lies on your way to the Temple of Trajan, the theatre and the Sanctuary of Athena. The acropolis, reached by cable car, is windy and has little shade, so bring a hat and water.'),
  ('efes-muzesi', 'tr', 'Selçuk''taki Efes Müzesi, Efes ve çevresindeki kazılardan çıkan eserleri sergiler. Müzenin en ünlü parçaları, Artemis''in göğsü yumurta ya da boğa testisi biçiminde süslemelerle kaplı heykelleridir. 2012 sonunda yenileme için kapanan müze, düzenlemesi yenilenerek yeniden açıldı.

Yamaç evlerden çıkan eşyalar, yunus üzerindeki Eros heykeli, fildişi kabartmalar ve gladyatör mezarlarına ayrılan bölüm görülmeye değer. Ören yerinden önce ya da sonra gezilmesi, Efes''te gördüklerinizi tamamlar; Selçuk merkezde, İsa Bey Camii ve Aziz Yuhanna Bazilikası''na yürüme mesafesindedir.'),
  ('efes-muzesi', 'en', 'The Ephesus Museum in Selçuk displays finds from the excavations at Ephesus and the surrounding area. Its most famous pieces are the statues of Artemis covered with egg- or bull-testicle-shaped ornaments on the chest. Closed for renovation at the end of 2012, it reopened with a new display.

Objects from the Terrace Houses, the statue of Eros on a dolphin, the ivory reliefs and the section on the gladiators'' graves are worth seeing. Visiting before or after the ruins completes what you see at Ephesus; it is in central Selçuk, within walking distance of the İsa Bey Mosque and the Basilica of St John.'),
  ('izmir-arkeoloji-muzesi', 'tr', 'Konak''ta, Bahribaba Parkı''nın içindeki İzmir Arkeoloji Müzesi, kökeni 1920''lere uzanan kentin en köklü müzelerindendir; bugünkü binasına 1980''lerde taşındı. İzmir ve Batı Anadolu''daki kazılardan çıkan, Tunç Çağı''ndan Roma ve Bizans dönemlerine uzanan eserleri sergiler.

Bahçede ve salonlarda lahitler, heykeller ve mimari parçalar; içeride küçük buluntular, cam eserler ve sikke ile takıların yer aldığı hazine bölümü vardır. Antik Smyrna''yı anlamak için Agora ile birlikte gezilmesi önerilir. Hemen karşısındaki Etnografya Müzesi aynı ziyarete eklenebilir.'),
  ('izmir-arkeoloji-muzesi', 'en', 'Set in Bahribaba Park in Konak, the İzmir Archaeological Museum is one of the city''s oldest museums, with roots in the 1920s; it moved to its present building in the 1980s. It displays finds from excavations in İzmir and western Anatolia, from the Bronze Age to the Roman and Byzantine periods.

Sarcophagi, statues and architectural pieces fill the garden and halls, while inside are small finds, glass and a treasury section with coins and jewellery. Visit it together with the Agora to understand ancient Smyrna. The Ethnography Museum just across the way makes an easy addition.'),
  ('izmir-agorasi', 'tr', 'Konak''taki İzmir Agorası, antik Smyrna''nın devlet agorasıydı. MÖ 4. yüzyılda kurulan agora, MS 178 depreminde yıkılınca Roma İmparatoru Marcus Aurelius''un desteğiyle yeniden yapıldı. Osmanlı döneminde üzerinde mezarlık ve namazgâh bulunuyordu; kazılar 20. yüzyılda başladı ve bugün de sürüyor.

Ayakta kalan sütun dizileri, Faustina Kapısı ve büyük bazilikanın tonozlu bodrum katı en etkileyici bölümleridir. Bodrumda, kaynak sularının aktığı kanallar ve antik duvar yazıları (grafitiler) görülebilir. Kemeraltı''na çok yakın olduğundan çarşı gezisiyle birleştirmek kolaydır.'),
  ('izmir-agorasi', 'en', 'The Agora in Konak was the state agora of ancient Smyrna. Founded in the 4th century BC, it was destroyed by the earthquake of AD 178 and rebuilt with the support of the Roman Emperor Marcus Aurelius. In Ottoman times a cemetery and an open-air prayer place stood on top of it; excavations began in the 20th century and continue today.

The standing colonnades, the Faustina Gate and the vaulted basement of the great basilica are the most impressive parts. In the basement you can see channels where spring water still runs and ancient wall graffiti. Being very close to Kemeraltı, it is easy to combine with a walk through the bazaar.'),
  ('tcg-pirireis-s-343', 'tr', 'İnciraltı''nda müze gemisi olarak sergilenen TCG Pirireis, 1949''da ABD''de USS Tang adıyla denize indirilen bir denizaltıdır. 1980''de Türk Deniz Kuvvetleri''ne katılarak TCG Pirireis adını aldı ve uzun yıllar hizmet verdi; görevden ayrıldıktan sonra müzeye dönüştürüldü.

İçeride torpido odaları, makine dairesi, kumanda bölümü ve mürettebatın dar yatakhaneleri gezilir; bir denizaltıda yaşamın ne kadar sıkışık olduğunu yakından görürsünüz. Geçitler dar ve basamaklar dik olduğu için rahat ayakkabı giyin. İnciraltı sahili ve kent ormanıyla aynı gün gezilebilir.'),
  ('tcg-pirireis-s-343', 'en', 'Displayed as a museum ship at İnciraltı, TCG Pirireis is a submarine launched in the United States in 1949 as USS Tang. She joined the Turkish Navy in 1980 under the name TCG Pirireis and served for many years, and was turned into a museum after being decommissioned.

Inside you walk through the torpedo rooms, engine room, control room and the crew''s narrow bunks, and see first-hand how cramped life on a submarine was. Passages are tight and the steps steep, so wear comfortable shoes. It can be combined with the İnciraltı seafront and city forest on the same day.'),
  ('izmir-kadin-muzesi', 'tr', 'Basmane yakınlarında, cumbalı tipik bir İzmir evinde bulunan İzmir Kadın Müzesi, 2014''te Konak Belediyesi tarafından açıldı. Türkiye''de kendi binasında kurulan ilk kadın müzesidir.

Üç katlı evde İzmir''in ilk kadın sanatçıları, sporcuları, öğretmenleri ve siyasetçileri gibi öncü kadınların hikâyeleri fotoğraf ve eşyalarla anlatılır. Küçük ve sakin bir müzedir; Kemeraltı''nın üst kısmından ya da Agora''dan kısa bir yürüyüşle ulaşılabilir.'),
  ('izmir-kadin-muzesi', 'en', 'Housed in a typical İzmir house with a bay window near Basmane, the İzmir Women''s Museum was opened by Konak Municipality in 2014. It was the first women''s museum in Turkey to have its own building.

Across three floors, photographs and belongings tell the stories of pioneering women of İzmir, including the city''s first female artists, athletes, teachers and politicians. It is a small, quiet museum, reached on a short walk from the upper end of Kemeraltı or from the Agora.'),
  ('bergama-muzesi', 'tr', 'Bergama Müzesi, 1936''dan beri ilçenin merkezinde hizmet veren arkeoloji ve etnografya müzesidir. Pergamon''da 1878''de başlayan kazılardan ve Asklepion''da 1920''lerde başlayan çalışmalardan çıkan eserler burada korunur.

Heykeller, kabartmalar, sikkeler ve küçük buluntuların yanında, bugün Berlin''deki Zeus Sunağı''nın maketi ziyaretçilere sunağın asıl görünüşünü gösterir. Etnografya bölümünde yöre halılarından ve gündelik eşyalardan örnekler vardır. Akropol ve Asklepion''u gezmeden önce uğramak, kalıntıları anlamayı kolaylaştırır.'),
  ('bergama-muzesi', 'en', 'The Bergama Museum has served as the town''s archaeology and ethnography museum since 1936. It keeps finds from the excavations at Pergamon, begun in 1878, and from the work at the Asklepion that started in the 1920s.

Alongside sculptures, reliefs, coins and small finds, a model of the Altar of Zeus, now in Berlin, shows how the altar originally looked. The ethnography section has examples of local carpets and everyday objects. A visit before the acropolis and the Asklepion makes the ruins easier to understand.'),
  ('izmir-ataturk-muzesi', 'tr', 'Kordon''daki İzmir Atatürk Müzesi, 1880''de halı tüccarı Agop Ispartalıyan tarafından ailesi için yaptırılan bir köşkte bulunur. Köşk sonradan Atatürk''e armağan edildi; Atatürk İzmir''e geldiğinde burada kaldı. Müze, Atatürk''ün İzmir''e gelişinin yıl dönümü olan 11 Eylül 1941''de açıldı.

Odalarda Atatürk''ün kullandığı eşyalar, giysiler ve dönemin fotoğrafları sergilenir. Denize bakan cephesiyle Kordon''un en tanınmış yapılarındandır. Ziyaret kısa sürer; Kordon boyunca Alsancak''a yürüyüşle birleştirilebilir.'),
  ('izmir-ataturk-muzesi', 'en', 'The İzmir Atatürk Museum on the Kordon is housed in a mansion built in 1880 by the carpet merchant Agop Ispartalıyan for his family. The house was later presented to Atatürk, who stayed here on his visits to İzmir. The museum opened on 11 September 1941, the anniversary of his arrival in the city.

The rooms display Atatürk''s belongings, clothes and photographs from the period. With its façade facing the sea it is one of the best-known buildings on the Kordon. A visit is short and combines well with a walk along the seafront to Alsancak.'),
  ('izmir-etnografya-muzesi', 'tr', 'Bahribaba''daki İzmir Etnografya Müzesi, 1831''de neoklasik üslupta yapılan taş bir binadadır. Yapı, Fransızlar tarafından veba hastaları için St. Roch Hastanesi olarak inşa edildi; sonraki dönemlerde de hastane olarak kullanıldı ve 1980''lerde müzeye dönüştürüldü.

İki katta keçe, kalaycılık, çömlekçilik, nalın ve dokuma gibi geleneksel zanaatlar; canlandırılmış bir İzmir evi odası, gelin odası ve eski bir eczane gibi bölümler yer alır. Arkeoloji Müzesi''nin hemen karşısında olduğundan ikisi aynı ziyarette gezilebilir.'),
  ('izmir-etnografya-muzesi', 'en', 'The İzmir Ethnography Museum in Bahribaba occupies a stone building in the Neoclassical style built in 1831. It was erected by the French as St Roch Hospital for plague patients, continued to serve as a hospital in later periods and was turned into a museum in the 1980s.

Across two floors are traditional crafts such as felt-making, tinsmithing, pottery, clog-making and weaving, along with a recreated İzmir house room, a bridal chamber and an old pharmacy. It stands just across from the Archaeological Museum, so the two can be seen in one visit.'),
  ('umran-baradan-oyun-ve-oyuncak-muzesi', 'tr', 'Konak''taki Ümran Baradan Oyun ve Oyuncak Müzesi, seramik sanatçısı Ümran Baradan''ın bağışladığı iki katlı ev ve oyuncak koleksiyonuyla kuruldu. Konak Belediyesi tarafından işletilen küçük bir müzedir.

Dünyanın farklı ülkelerinden ve farklı dönemlerden bebekler, tahta ve teneke oyuncaklar ile çocuk oyunlarına ait eşyalar sergilenir. Çocuklu aileler kadar, kendi çocukluğunun oyuncaklarını görmek isteyen büyükler için de keyifli bir duraktır. Kısa bir ziyaret için planlayın.'),
  ('umran-baradan-oyun-ve-oyuncak-muzesi', 'en', 'The Ümran Baradan Play and Toy Museum in Konak was founded with the two-storey house and toy collection donated by the ceramic artist Ümran Baradan. It is a small museum run by Konak Municipality.

Dolls, wooden and tin toys and objects from children''s games from many countries and periods are on display. It is an enjoyable stop for families with children as well as for adults who want to see the toys of their own childhood. Plan for a short visit.'),
  ('arkas-sanat-merkezi', 'tr', 'Alsancak''ta, Kordon üzerindeki Arkas Sanat Merkezi Kasım 2011''de açıldı. Uzun süre Fransa Fahri Konsolosluğu olarak kullanılan tarihi bir köşkte yer alır ve Lucien Arkas''ın oluşturduğu Arkas Koleksiyonu''na ev sahipliği yapar.

Müze, koleksiyondan seçkilerin yanı sıra Türk ve Avrupalı sanatçıların eserlerinden oluşan dönemsel sergiler düzenler; sergiler değiştiği için gitmeden önce güncel programa bakın. Denize bakan konumu nedeniyle Kordon yürüyüşünde rahatça uğranabilecek bir duraktır.'),
  ('arkas-sanat-merkezi', 'en', 'On the Kordon in Alsancak, the Arkas Art Center opened in November 2011. It occupies a historic mansion long used by the Honorary Consulate of France and houses the Arkas Collection assembled by Lucien Arkas.

Besides selections from the collection, the museum holds temporary exhibitions of Turkish and European artists; check the current programme before you go, as shows change. Facing the sea, it is an easy stop on a walk along the Kordon.'),
  ('bostanli-acik-hava-arkeoloji-muzesi', 'tr', 'Karşıyaka''nın Bostanlı semtindeki açık hava arkeoloji müzesi 1987''de kuruldu. Körfezin kuzey kıyısındaki antik yerleşimlerden çıkan, MÖ 10. yüzyıldan MS 3. yüzyıla uzanan eserleri bir arada sergiler.

Lahitler, mezar stelleri, sütun başlıkları ve yazıtlı taşlar açık havada, yeşillik bir alanda yer alır. Küçük bir alan olduğu için ziyaret kısa sürer; Bostanlı sahil yolundaki yürüyüş ve bisiklet rotasıyla birleştirilebilir.'),
  ('bostanli-acik-hava-arkeoloji-muzesi', 'en', 'The open-air archaeological museum in the Bostanlı quarter of Karşıyaka was founded in 1987. It brings together finds from ancient settlements on the northern shore of the gulf, ranging from the 10th century BC to the 3rd century AD.

Sarcophagi, grave stelae, column capitals and inscribed stones stand outdoors in a green area. The site is small, so a visit is short; combine it with the walking and cycling route along the Bostanlı seafront.'),
  ('cakiraga-konagi', 'tr', 'Birgi''deki Çakırağa Konağı, 1761-1764 yılları arasında zengin bir tüccar olan Çakıroğlu Mehmet Bey tarafından yaptırıldı. Geniş bir bahçe içindeki üç katlı ahşap konak, Osmanlı sivil mimarisinin en iyi korunmuş örneklerindendir ve restorasyonun ardından müze olarak açıldı.

Duvarları ve tavanları süsleyen kalem işleri, ahşap oymalar ve özellikle İstanbul ile İzmir''i gösteren manzara resimleri konağın en ünlü bölümleridir. Odaları gezerken başınızı kaldırıp tavanlara bakmayı unutmayın. Birgi Ulu Camii ve köyün taş sokaklarıyla birlikte gezilir.'),
  ('cakiraga-konagi', 'en', 'Çakırağa Mansion in Birgi was built between 1761 and 1764 by Çakıroğlu Mehmet Bey, a wealthy merchant. Set in a large garden, the three-storey timber mansion is one of the best-preserved examples of Ottoman domestic architecture and opened as a museum after restoration.

The painted decoration and wood carving on the walls and ceilings, and especially the landscape paintings of Istanbul and İzmir, are its most famous features. Remember to look up at the ceilings as you go through the rooms. It is visited together with Birgi''s Grand Mosque and the village''s stone streets.'),
  ('cesme-muzesi', 'tr', 'Çeşme Kalesi''nin içindeki Çeşme Müzesi, 1965''te silah müzesi olarak kuruldu; nem nedeniyle silahlar başka müzelere taşınınca 1984''te genel bir müze olarak yeniden düzenlendi.

Erythrai başta olmak üzere çevredeki antik kentlerden çıkan eserler ile 1770 Çeşme Deniz Savaşı''na ayrılan bölüm görülebilir. Kale surlarının üzerinden limanı ve kasabayı izlemek ziyaretin en güzel anlarındandır. Kalenin önündeki Cezayirli Gazi Hasan Paşa heykeli ve kervansaray aynı gezide görülür.'),
  ('cesme-muzesi', 'en', 'Çeşme Museum, inside Çeşme Castle, was founded in 1965 as a weapons museum; when the weapons were moved to other museums because of the humidity, it was reorganised as a general museum in 1984.

You can see finds from the ancient cities around, above all Erythrai, and a section on the Battle of Çeşme of 1770. Watching the harbour and the town from the castle walls is one of the highlights. The statue of Cezayirli Gazi Hasan Pasha in front of the castle and the caravanserai fit into the same visit.'),
  ('odemis-muzesi', 'tr', 'Ödemiş Müzesi, arsasını 1976''da koleksiyoncu Mutahhar Başoğlu''nun bağışlamasıyla kuruldu ve 1983''te açıldı. Kent merkezinin biraz doğusunda, ana yol üzerinde yer alan bir arkeoloji ve etnografya müzesidir.

Antik Hypaipa başta olmak üzere Küçük Menderes havzasındaki yerleşimlerden çıkan heykeller, sikkeler, cam ve seramik eserler sergilenir; etnografya bölümünde yöreye özgü giysi ve eşyalar vardır. Birgi''ye giderken ya da dönüşte kısa bir durak olarak planlanabilir.'),
  ('odemis-muzesi', 'en', 'Ödemiş Museum was founded on land donated in 1976 by the collector Mutahhar Başoğlu and opened in 1983. It is an archaeology and ethnography museum on the main road just east of the town centre.

It displays sculptures, coins, glass and pottery from settlements in the Küçük Menderes valley, above all ancient Hypaipa, while the ethnography section shows local costumes and objects. It makes a short stop on the way to or from Birgi.'),
  ('ahmet-piristina-kent-arsivi-ve-muzesi', 'tr', 'Ahmet Piriştina Kent Arşivi ve Müzesi, adını fikri ortaya atan Büyükşehir Belediye Başkanı Ahmet Piriştina''dan alır. Yapımına 1930''da başlanan ve 1932-2001 arasında itfaiye merkezi olarak kullanılan bina, restore edilerek 2004''te müze olarak açıldı.

Fotoğraflar, haritalar, belgeler ve maketlerle İzmir''in antik çağdan Cumhuriyet''e uzanan kent tarihi anlatılır; 1922 yangını öncesi şehri gösteren görseller özellikle ilgi çeker. Arşiv bölümü araştırmacılara açıktır. Kültürpark ve Basmane''ye yakındır.'),
  ('ahmet-piristina-kent-arsivi-ve-muzesi', 'en', 'The Ahmet Piriştina City Archives and Museum is named after the metropolitan mayor who proposed it. Its building, begun in 1930 and used as a fire station from 1932 to 2001, was restored and opened as a museum in 2004.

Photographs, maps, documents and models tell the story of İzmir from antiquity to the Republic; images of the city before the fire of 1922 are especially interesting. The archive is open to researchers. It is close to Kültürpark and Basmane.'),
  ('key-museum', 'tr', 'Torbalı''daki Key Museum, 2015''te açılan büyük bir otomobil ve motosiklet müzesidir. Türkiye''nin bu alandaki en kapsamlı koleksiyonlarından birine sahiptir ve araçların model yılları 19. yüzyılın sonundan 2000''lere uzanır.

Klasik otomobiller, yarış arabaları ve motosikletler geniş bir salonda, dönemlerine göre sergilenir; bazı araçların hikâyeleri de anlatılır. Otomobil meraklıları için birkaç saat ayırmaya değer. İzmir merkezinden Selçuk-Efes yönüne giderken yol üstünde bir durak olarak planlanabilir.'),
  ('key-museum', 'en', 'Key Museum in Torbalı is a large car and motorcycle museum opened in 2015. It holds one of the most extensive collections of its kind in Turkey, with model years ranging from the late 19th century to the 2000s.

Classic cars, racing cars and motorcycles are arranged by period in a large hall, and the stories of some vehicles are told. Car lovers should set aside a couple of hours. It makes a stop on the way from central İzmir towards Selçuk and Ephesus.'),
  ('kadifekale', 'tr', 'Kadifekale, körfeze hâkim 186 metre yüksekliğindeki Pagos Tepesi''nde yer alır ve antik Smyrna''nın akropolüdür. Rivayete göre Büyük İskender burada uyurken gördüğü rüya üzerine kentin bu tepenin eteğine taşınmasını istedi. Kale MÖ 3. yüzyılda kuruldu; Roma, Bizans ve Osmanlı dönemlerinde onarıldı.

Surların bir bölümü ve kulelerden biri ayaktadır, ama asıl neden manzaradır: körfezin, Konak''ın ve karşı kıyının en geniş görüntüsü buradan görülür. Gün batımına doğru gidin; çevredeki çay bahçelerinde oturabilirsiniz. Kemeraltı''ndan yokuş yukarı yürüyüş dik olduğundan taksi ya da otobüs tercih edilebilir.'),
  ('kadifekale', 'en', 'Kadifekale stands on Mount Pagos, 186 metres above the gulf, and was the acropolis of ancient Smyrna. Legend says that Alexander the Great, after a dream he had while sleeping here, called for the city to be moved to the foot of this hill. The castle was founded in the 3rd century BC and repaired in the Roman, Byzantine and Ottoman periods.

Parts of the walls and one of the towers still stand, but the real reason to come is the view: the widest panorama of the gulf, Konak and the far shore. Go towards sunset and sit in one of the tea gardens around. The walk up from Kemeraltı is steep, so you may prefer a taxi or a bus.'),
  ('izmir-kultur-sanat-fabrikasi', 'tr', 'Alsancak''taki İzmir Kültür Sanat Fabrikası, kentin eski Tekel tütün fabrikasının restore edilmesiyle oluşturulan büyük bir kültür kompleksidir. İzmir Resim ve Heykel Müzesi 2023''te buraya taşındı; Kültürpark''taki İzmir Tarih ve Sanat Müzesi''nin eserleri de buraya aktarıldı ve kompleks içinde bir arkeoloji ve etnografya müzesi açıldı.

Müze, İzmir ve çevresinin 8.500 yılı aşan tarihini tematik salonlarda anlatır; yanında resim ve heykel koleksiyonları, dönemsel sergiler ve konserler yer alır. Endüstri yapısının yüksek tavanlı salonları da görülmeye değer. Kültürpark''ın kuzey kenarına ve Alsancak''a yürüme mesafesindedir.'),
  ('izmir-kultur-sanat-fabrikasi', 'en', 'The İzmir Culture and Art Factory in Alsancak is a large cultural complex created by restoring the city''s old Tekel tobacco factory. The İzmir Museum of Painting and Sculpture moved here in 2023; the collections of the İzmir Museum of History and Art in Kültürpark were also transferred here, and an archaeology and ethnography museum opened within the complex.

The museum tells more than 8,500 years of the history of İzmir and its region in themed halls, alongside painting and sculpture collections, temporary exhibitions and concerts. The high-ceilinged halls of the industrial building are worth seeing in themselves. It is within walking distance of the north edge of Kültürpark and of Alsancak.')
  ) v(slug, lang, long_desc)
  join public.places p on p.slug = v.slug
 where t.place_id = p.id and t.lang = v.lang;
