-- İstanbul uzun açıklamaları, 11. parti (10 yer, TR + EN).
-- Üreten: data-pipeline/content/build_long_desc.py (kaynak: content/istanbul_long_descriptions.py).
-- Metinler kendi cümlelerimizdir; Vikipedi/Wikidata yalnızca bilgi kontrolü için kullanıldı.

update public.place_translations t
   set long_desc = v.long_desc
  from (values
  ('askeri-muze', 'tr', 'Harbiye''deki Askeri Müze, Osmanlı ordusuna subay yetiştiren Mekteb-i Harbiye''nin 19. yüzyıldan kalma binasında yer alır. Mustafa Kemal Atatürk de bu okulda öğrenim görmüştür. Türkiye''nin en kapsamlı askeri tarih müzelerinden biridir.

Müzede Osmanlı ve Cumhuriyet dönemlerine ait silahlar, zırhlar, üniformalar, sancaklar ve padişahların sefer çadırları sergilenir; Atatürk''ün okuduğu sınıf da korunmuştur. Belirli saatlerde verilen mehter konserleri ziyaretin en sevilen bölümüdür; program ve ziyaret günlerini önceden kontrol edin.'),
  ('askeri-muze', 'en', 'In Harbiye, the Military Museum occupies the 19th-century building of the Mekteb-i Harbiye, the academy that trained officers for the Ottoman army. Mustafa Kemal Atatürk also studied here. It is one of Turkey''s most comprehensive museums of military history.

It displays weapons, armour, uniforms and banners from the Ottoman and Republican periods, as well as the sultans'' campaign tents; the classroom where Atatürk studied is preserved. The Ottoman military band (mehter) concerts held at certain times are the favourite part of a visit; check the programme and opening days in advance.'),
  ('aydos-tepesi', 'tr', 'Anadolu yakasında, Kartal, Pendik, Sultanbeyli ve Sancaktepe arasındaki Aydos Tepesi, 537 metreyle İstanbul''un en yüksek noktasıdır. Adını tepede kalıntıları bulunan, Roma ve Bizans dönemlerine ait Aydos Kalesi''nden alır.

Çevresindeki Aydos Ormanı yürüyüş ve piknik için geniş alanlar sunar. Açık havada tepeden Marmara Denizi, Adalar ve Anadolu yakasının panoraması görülür. Kalenin kazı çalışmaları nedeniyle bazı bölümlere erişim kısıtlanabilir; rahat ayakkabı ve su almak iyi olur.'),
  ('aydos-tepesi', 'en', 'On the Asian side, between Kartal, Pendik, Sultanbeyli and Sancaktepe, Aydos Hill is Istanbul''s highest point at 537 metres. It takes its name from Aydos Castle, a Roman and Byzantine fortress whose ruins stand near the top.

The surrounding Aydos Forest offers plenty of space for walking and picnics. On clear days the summit gives a panorama of the Sea of Marmara, the Princes'' Islands and the Asian side. Excavation work at the castle may restrict access to some parts; comfortable shoes and water are a good idea.'),
  ('balikli-meryem-ana-rum-manastiri', 'tr', 'Kara surlarının dışında, Silivrikapı yakınındaki Balıklı Meryem Ana Rum Manastırı, 6. yüzyılda İmparator Justinianus döneminde kutsal bir su kaynağının üzerine kurulan bir manastırın yerindedir. Bugünkü kilise 1835''te yeniden inşa edildi.

Kilisenin altındaki ayazmada yüzen balıklar yere adını verir; anlatılan efsaneye göre 1453''te şehrin düştüğü haberi geldiğinde tavada kızartılan balıklar suya atlayıp canlanmıştır. Avludaki mezarlıkta Rum Ortodoks patriklerinin mezarları bulunur. İbadet yeri olduğu için uygun giyinilmelidir.'),
  ('balikli-meryem-ana-rum-manastiri', 'en', 'Outside the land walls near Silivrikapı, the Greek Orthodox Monastery of St Mary of the Spring stands on the site of a monastery founded over a holy spring in the 6th century under Emperor Justinian. The present church was rebuilt in 1835.

The fish swimming in the holy spring beneath the church give the place its Turkish name; legend says that when news of the city''s fall came in 1453, fish frying in a pan leapt into the water and came back to life. The cemetery in the courtyard holds the graves of Orthodox patriarchs. As a place of worship it calls for modest dress.'),
  ('florya-ataturk-deniz-kosku', 'tr', 'Florya sahilinde denizin üzerine kurulan Atatürk Deniz Köşkü, İstanbul Belediyesi tarafından Atatürk''e armağan edilmek üzere mimar Seyfi Arkan''a yaptırıldı ve 1935''te tamamlandı. Atatürk yaz aylarında burada dinlenmiş ve çalışmıştır.

Kazıklar üzerinde denize uzanan ve kıyıya bir iskeleyle bağlanan yapı, erken Cumhuriyet döneminin modernist mimarisinin önemli örneklerindendir. 1993''ten bu yana müze olarak hizmet verir ve özgün eşyalarıyla korunur. Ziyaret günleri değişebileceğinden gitmeden önce kontrol edin.'),
  ('florya-ataturk-deniz-kosku', 'en', 'Built over the sea on the Florya shore, the Atatürk Sea Pavilion was commissioned by the Istanbul municipality from the architect Seyfi Arkan as a gift to Atatürk and completed in 1935. Atatürk rested and worked here in the summer months.

Standing on piles over the water and joined to the shore by a pier, it is an important example of early Republican modernist architecture. It has been a museum since 1993 and is preserved with its original furnishings. Opening days can change, so check before you go.'),
  ('kanli-kilise', 'tr', 'Fener''in yokuşlarındaki Kanlı Kilise, Moğolların Meryem''i (Mouhliotissa) adıyla bilinen bir Bizans kilisesidir. 13. yüzyılın sonunda, bir Moğol hanıyla evlendirilen İmparatorluk prensesi Maria Palaiologina tarafından yeniden kuruldu.

Fetihten sonra camiye çevrilmeden Rum Ortodoks cemaatine bırakılan tek Bizans kilisesi olarak bilinir. ''Kanlı'' adının, fetih sırasında bu tepede yaşanan çatışmalardan geldiği anlatılır. Yüksek duvarların arkasındaki kilisenin ziyareti sınırlı olabilir; Fener ve Balat gezisi sırasında kapı açıksa uğrayın.'),
  ('kanli-kilise', 'en', 'On the slopes of Fener, the Church of St Mary of the Mongols (Mouchliotissa) is a Byzantine church refounded in the late 13th century by the imperial princess Maria Palaiologina, who had been married to a Mongol khan.

It is known as the only Byzantine church in the city never converted into a mosque after the conquest, remaining with the Greek Orthodox community. Its Turkish name, the Bloody Church, is said to come from fighting on this hill during the conquest. Behind high walls, it may have limited access; drop by if the gate is open during a walk through Fener and Balat.'),
  ('muze-gazhane', 'tr', 'Kadıköy Hasanpaşa''daki Müze Gazhane, 1892''de Anadolu yakasına havagazı sağlamak için kurulan tarihi gazhanenin yapılarında yer alır. Doğal gazın gelmesiyle 1993''te kapanan tesis, uzun bir dönüşüm sürecinin ardından 2021''de kültür merkezi olarak açıldı.

Eski fırınlar, bacalar ve gaz depoları; iklim müzesi, karikatür müzesi, sergi salonları, kütüphane ve kafelere dönüştürülmüştür. Endüstriyel mimarisi fotoğrafçıların ilgisini çeker; konserler ve festivaller düzenlenir. Programı önceden kontrol edin. Yoğurtçu Parkı ve Moda''ya yakındır.'),
  ('muze-gazhane', 'en', 'In Hasanpaşa, Kadıköy, Müze Gazhane occupies the buildings of the historic gasworks built in 1892 to supply gas to the Asian side. Closed in 1993 with the arrival of natural gas, it reopened as a cultural centre in 2021 after a long transformation.

Its old furnaces, chimneys and gas holders have become a climate museum, a cartoon museum, exhibition halls, a library and cafés. Its industrial architecture draws photographers, and it hosts concerts and festivals. Check the programme in advance. It is close to Yoğurtçu Park and Moda.'),
  ('sveti-stefan-kilisesi', 'tr', 'Balat ile Fener arasında Haliç kıyısındaki Sveti Stefan Kilisesi, Bulgar Ortodoks cemaatine aittir ve halk arasında Demir Kilise diye bilinir. Bugünkü yapı, Viyana''da üretilip parçalar halinde getirilen döküm demir elemanlarla kurulmuş ve 1898''de tamamlanmıştır.

Dünyada önceden üretilmiş demir parçalarla kurulan sayılı kiliselerden biridir; neo-Gotik cephesi ve altın yaldızlı iç süslemeleriyle dikkat çeker. Yedi yıllık restorasyonun ardından 2018''de yeniden açıldı. Haliç sahilindeki parkın içinde olduğundan Balat yürüyüşüne kolayca eklenebilir.'),
  ('sveti-stefan-kilisesi', 'en', 'On the Golden Horn between Balat and Fener, St Stephen''s Church belongs to the Bulgarian Orthodox community and is popularly known as the Iron Church. The present building was assembled from cast-iron parts made in Vienna and shipped in pieces, and was completed in 1898.

It is one of the few churches in the world built from prefabricated iron parts, and stands out for its neo-Gothic façade and gilded interior. It reopened in 2018 after seven years of restoration. Set in the waterfront park, it is an easy addition to a walk around Balat.'),
  ('kiztasi', 'tr', 'Fatih''te, Saraçhane yakınındaki bir meydanda duran Kıztaşı, Bizans İmparatoru Markianos onuruna 5. yüzyılın ortasında dikilen bir anıt sütundur. Bizans döneminden büyük ölçüde sağlam ulaşan az sayıdaki imparatorluk anıtından biridir.

Granit gövdesinin kaidesinde kanatlı zafer tanrıçası Nike''ların kabartmaları bulunur; sütunun Türkçe adının bu kadın figürlerinden geldiği düşünülür. Mahallenin içinde kısa bir durak olarak görülebilir; Fatih Camii ve Bozdoğan Kemeri''ne yürüme mesafesindedir.'),
  ('kiztasi', 'en', 'In Fatih, standing in a small square near Saraçhane, the Column of Marcian was raised in honour of the Byzantine Emperor Marcian in the mid-5th century. It is one of the few imperial monuments from the Byzantine era to survive largely intact.

The base of its granite shaft bears reliefs of winged Victories (Nike), and the column''s Turkish name, the ''Maiden''s Stone'', is thought to come from these female figures. It makes a short stop in the neighbourhood and is within walking distance of the Fatih Mosque and the Valens Aqueduct.'),
  ('buyuk-camlica-tepesi', 'tr', 'Üsküdar''daki Büyük Çamlıca Tepesi, Anadolu yakasının şehre en yakın ve en bilinen seyir tepelerinden biridir. Osmanlı döneminde de mesire yeri olarak sevilen tepe, 1980''lerde Turing''in başkanı Çelik Gülersoy tarafından düzenlenerek çay bahçeleriyle yeniden halka kazandırıldı.

Tepeden Boğaz''ın iki yakası, köprüler, Tarihi Yarımada ve Marmara Denizi geniş bir panorama halinde görülür; manzara özellikle gün batımında ve açık havalarda etkileyicidir. Yakındaki Çamlıca Kulesi ve Büyük Çamlıca Camii ile aynı gezide görülebilir.'),
  ('buyuk-camlica-tepesi', 'en', 'In Üsküdar, Büyük Çamlıca Hill is one of the best-known viewpoints on the Asian side close to the city centre. Already a favourite excursion spot in Ottoman times, it was landscaped with tea gardens and given back to the public in the 1980s by Çelik Gülersoy, head of the Touring Club.

From the top you see both shores of the Bosphorus, the bridges, the historic peninsula and the Sea of Marmara in a wide panorama, especially striking at sunset and on clear days. It can be combined with the nearby Çamlıca Tower and the Grand Çamlıca Mosque.'),
  ('gotlar-sutunu', 'tr', 'Gülhane Parkı''nın Sarayburnu ucunda, ağaçların arasında duran Gotlar Sütunu, şehirde Roma döneminden kalan en eski anıtlardan biridir. Yaklaşık 18,5 metre yüksekliğindeki mermer sütunun 3. ya da 4. yüzyılda dikildiği düşünülür.

Kaidesindeki Latince yazıt, Gotlara karşı kazanılan bir zaferi anar ve sütun adını buradan alır. Korint başlığı hâlâ yerindedir. Gülhane Parkı''nda Boğaz''a bakan çay bahçesine doğru yürürken kolayca görülebilir.'),
  ('gotlar-sutunu', 'en', 'At the Sarayburnu end of Gülhane Park, standing among the trees, the Column of the Goths is one of the oldest Roman-era monuments in the city. The marble column, about 18.5 metres high, is thought to have been erected in the 3rd or 4th century.

The Latin inscription on its base commemorates a victory over the Goths, which gives the column its name. Its Corinthian capital is still in place. It is easy to see while walking through Gülhane Park towards the tea garden overlooking the Bosphorus.')
  ) v(slug, lang, long_desc)
  join public.places p on p.slug = v.slug
 where t.place_id = p.id and t.lang = v.lang;
