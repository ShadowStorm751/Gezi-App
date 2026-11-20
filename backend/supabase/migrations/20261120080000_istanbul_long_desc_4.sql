-- İstanbul uzun açıklamaları, 4. parti (10 yer, TR + EN).
-- Üreten: data-pipeline/content/build_long_desc.py (kaynak: content/istanbul_long_descriptions.py).
-- Metinler kendi cümlelerimizdir; Vikipedi/Wikidata yalnızca bilgi kontrolü için kullanıldı.

update public.place_translations t
   set long_desc = v.long_desc
  from (values
  ('ortakoy-camii', 'tr', 'Ortaköy iskelesinin hemen yanında, Boğaz''ın kıyısında yükselen Büyük Mecidiye Camii, Sultan Abdülmecid''in isteğiyle Balyan ailesinden mimarlara yaptırıldı ve 1856''da tamamlandı. Neobarok üslubu, beyaz kesme taş cepheleri ve iki ince minaresiyle küçük ama son derece zarif bir yapıdır.

Büyük pencerelerinden giren deniz ışığı iç mekânı aydınlatır. Arkasında 15 Temmuz Şehitler Köprüsü''nün yükseldiği manzarası İstanbul''un en çok fotoğraflanan karelerinden biridir. Meydandaki kafeler, kumpir ve waffle tezgâhları ile hafta sonları kurulan küçük pazar, Ortaköy''ü akşam yürüyüşleri için canlı bir buluşma noktası yapar.'),
  ('ortakoy-camii', 'en', 'Right beside the Ortaköy pier on the shore of the Bosphorus, the Grand Mecidiye Mosque was built at the request of Sultan Abdülmecid by architects of the Balyan family and completed in 1856. With its neo-baroque style, white cut-stone façades and two slender minarets, it is small but exceptionally elegant.

Light from the water pours in through its large windows. With the Bosphorus bridge rising behind it, the view is one of the most photographed in Istanbul. The cafés, baked-potato (kumpir) and waffle stalls on the square and the small weekend market make Ortaköy a lively meeting point for evening strolls.'),
  ('anadolu-hisari', 'tr', 'Göksu Deresi''nin Boğaz''a döküldüğü noktada, Boğaz''ın en dar yerlerinden birinde duran Anadolu Hisarı, 14. yüzyılın sonunda Yıldırım Bayezid tarafından yaptırıldı ve İstanbul''daki en eski Osmanlı yapılarından biridir. Fatih Sultan Mehmed 1452''de karşı kıyıya Rumeli Hisarı''nı inşa ederken bu kaleyi de güçlendirdi.

Rumeli Hisarı''na göre çok daha küçük olan kale, Boğaz vapurlarından ve karşı kıyıdan bakıldığında en güzel görünür. Çevresindeki tarihi yalılar ve Göksu Deresi boyunca uzanan sahil, sakin bir yürüyüş için idealdir; Küçüksu Kasrı da yakındadır. Kalenin iç kısmının ziyaret düzeni için gitmeden önce kontrol etmekte yarar var.'),
  ('anadolu-hisari', 'en', 'Standing where the Göksu stream meets the Bosphorus, at one of the narrowest points of the strait, Anadolu Fortress was built by Sultan Bayezid I in the late 14th century and is one of the oldest Ottoman structures in Istanbul. When Mehmed II built Rumeli Fortress on the opposite shore in 1452, he strengthened this castle too.

Much smaller than Rumeli Fortress, it looks its best from Bosphorus ferries and the opposite shore. The historic waterside mansions around it and the banks of the Göksu make for a peaceful walk, and Küçüksu Pavilion is nearby. Check visiting arrangements for the interior before you go.'),
  ('fatih-camii', 'tr', 'Fatih Sultan Mehmed''in 1463-1470 yılları arasında Mimar Atik Sinan''a yaptırdığı Fatih Camii, fetihten sonra İstanbul''da inşa edilen ilk büyük selatin camisidir. Bizans döneminde imparatorların gömüldüğü Havariyun Kilisesi''nin bulunduğu tepeye kurulmuştur. Özgün cami 1766 depreminde yıkıldı ve 1771''de III. Mustafa döneminde bugünkü haliyle yeniden inşa edildi.

Medreseleri, darüşşifası ve imaretiyle büyük bir külliyenin merkezi olan caminin bahçesinde Fatih Sultan Mehmed''in türbesi bulunur. Çevresi, geleneksel havasını koruyan canlı bir mahalledir; çarşamba günleri caminin etrafındaki sokaklarda kurulan büyük semt pazarı da görülmeye değer.'),
  ('fatih-camii', 'en', 'Built for Sultan Mehmed II between 1463 and 1470 by the architect Atik Sinan, the Fatih Mosque was the first great imperial mosque raised in Istanbul after the conquest. It stands on the hill once occupied by the Byzantine Church of the Holy Apostles, where emperors were buried. The original mosque collapsed in the earthquake of 1766 and was rebuilt in its present form in 1771 under Mustafa III.

At the heart of a large complex of schools, a hospital and a soup kitchen, its garden holds the tomb of Mehmed the Conqueror. The surrounding area is a lively, traditional neighbourhood, and the big street market held around the mosque on Wednesdays is well worth seeing.'),
  ('yildiz-parki', 'tr', 'Beşiktaş''ta Çırağan Caddesi''nden yamaç boyunca yükselen Yıldız Parkı, bir zamanlar Yıldız Sarayı''nın has bahçesiydi. Özellikle Sultan II. Abdülhamid döneminde sarayın bir parçası olarak düzenlenen koru, bugün İstanbul''un en büyük ve en yeşil kent parklarından biridir.

Yüzyıllık ağaçların gölgesindeki patikalar, gölet ve köşkler arasında dolaşabilirsiniz; Malta Köşkü ve Çadır Köşkü bugün kafe ve restoran olarak hizmet verir, Boğaz''a bakan bölümlerden manzara açılır. Yokuşlu bir park olduğundan rahat ayakkabı iyi olur. Çırağan Sarayı ve Ortaköy''e yürüme mesafesindedir.'),
  ('yildiz-parki', 'en', 'Rising up the hillside from Çırağan Avenue in Beşiktaş, Yıldız Park was once the private garden of Yıldız Palace. Landscaped as part of the palace, especially in the reign of Sultan Abdülhamid II, it is today one of Istanbul''s largest and greenest city parks.

You can wander paths shaded by century-old trees, past a pond and pavilions; the Malta and Çadır pavilions now serve as cafés and restaurants, and the upper parts open onto views of the Bosphorus. The park is hilly, so comfortable shoes help. Çırağan Palace and Ortaköy are within walking distance.'),
  ('sedef-adasi', 'tr', 'Büyükada''nın güneydoğusundaki Sedef Adası, Prens Adaları''nın yerleşim olan en küçüğüdür. Uzaktan bakıldığında bitki örtüsünün sedefe benzetilmesinden adını alır; eskiden tavşanların bolluğu nedeniyle Tavşanadası diye de anılırdı. Bizans döneminde burada da bir manastır bulunuyordu.

Bugün çoğunlukla yazlık evlerden oluşan sakin bir yerleşimdir ve yapılaşma sıkı kurallarla sınırlandırılmıştır. Berrak suyu ve küçük plajıyla yaz aylarında denize girmek için tercih edilir. Ulaşım çoğunlukla Büyükada''dan kalkan küçük teknelerle sağlanır; seferler mevsime göre değiştiği için önceden kontrol edin.'),
  ('sedef-adasi', 'en', 'South-east of Büyükada, Sedef Island is the smallest inhabited of the Princes'' Islands. It takes its name, ''mother-of-pearl'', from the way its vegetation looks from afar, and was once also called Rabbit Island for its many rabbits. In Byzantine times it too had a monastery.

Today it is a quiet settlement made up mostly of summer houses, with building strictly limited. Its clear water and small beach make it a summer favourite for swimming. It is usually reached by small boats from Büyükada; services vary by season, so check in advance.'),
  ('yassiada', 'tr', 'Burgazada''nın güneybatısındaki küçük ve düz Yassıada, Bizans döneminde manastırlara ve sürgünlere ev sahipliği yaptı. Ada en çok, 1960 darbesinin ardından Başbakan Adnan Menderes ve arkadaşlarının yargılandığı Yassıada duruşmalarıyla bilinir.

Kapsamlı bir yeniden düzenlemenin ardından 2020''de Demokrasi ve Özgürlükler Adası adıyla ziyarete açıldı; adada duruşmaların yapıldığı salonu ve dönemi anlatan bir müze, cami ve konaklama tesisleri bulunur. Adaya yalnızca belirli seferlerle ulaşılabildiği için gitmeden önce ulaşım ve ziyaret bilgilerini kontrol edin.'),
  ('yassiada', 'en', 'South-west of Burgazada, the small, flat island of Yassıada hosted monasteries and exiles in Byzantine times. It is best known for the Yassıada trials, in which Prime Minister Adnan Menderes and his colleagues were tried after the 1960 military coup.

After an extensive redevelopment it opened to visitors in 2020 as the Island of Democracy and Freedoms; it has a museum telling the story of the period, including the hall where the trials were held, a mosque and accommodation. It can only be reached by certain boat services, so check transport and visiting details before you go.'),
  ('bodrum-camii', 'tr', 'Laleli''nin arka sokaklarındaki Bodrum Mesih Paşa Camii, 10. yüzyılda İmparator Romanos Lekapenos''un yaptırdığı Myrelaion Manastırı''nın kilisesidir. Fetihten sonra 15. yüzyılın sonunda Sadrazam Mesih Paşa tarafından camiye çevrildi.

Kırmızı tuğla ve taş sıralarıyla örülmüş cepheleri orta Bizans mimarisinin küçük ama tipik bir örneğidir. Adındaki ''bodrum'', yapının altındaki alt yapıdan gelir; hemen yanında 5. yüzyıldan kalan büyük bir rotundanın kalıntıları bulunur. Kapalıçarşı ve Laleli arasında dolaşırken kısa bir mola için uygundur.'),
  ('bodrum-camii', 'en', 'In the backstreets of Laleli, the Bodrum Mesih Pasha Mosque was the church of the Myrelaion Monastery, built in the 10th century by Emperor Romanos Lekapenos. After the conquest it was converted into a mosque at the end of the 15th century by Grand Vizier Mesih Pasha.

Its façades of alternating red brick and stone make it a small but typical example of middle Byzantine architecture. The word ''bodrum'', basement, refers to the substructure beneath it, and right beside it are the remains of a large 5th-century rotunda. It makes a short stop while exploring between the Grand Bazaar and Laleli.'),
  ('bozdogan-kemeri', 'tr', 'Roma İmparatoru Valens döneminde 4. yüzyılın sonunda tamamlanan Bozdoğan Kemeri, şehrin tepeleri arasındaki vadiyi aşarak suyu tarihi yarımadaya taşıyan su yolunun en görkemli parçasıdır. Bizans ve Osmanlı dönemlerinde defalarca onarılarak yüzyıllar boyunca kullanıldı.

Bugün yaklaşık 900 metresi ayakta duran iki katlı kemerlerin altından Atatürk Bulvarı geçer; özellikle Saraçhane tarafındaki parktan ve akşam ışıklandırıldığında çok etkileyici görünür. Şehzade Camii ve Fatih yönüne giderken kolayca görülebilir.'),
  ('bozdogan-kemeri', 'en', 'Completed under the Roman Emperor Valens at the end of the 4th century, the Valens Aqueduct is the most impressive surviving part of the water supply that carried water across the valley between the city''s hills to the historic peninsula. Repaired many times by the Byzantines and the Ottomans, it stayed in use for centuries.

Today about 900 metres of its two-tiered arches still stand, with Atatürk Boulevard running beneath them; it looks especially striking from the park on the Saraçhane side and when lit up in the evening. It is easy to see on the way to the Şehzade Mosque or Fatih.'),
  ('pierre-loti-tepesi', 'tr', 'Eyüp''te Haliç''e bakan tepe, 19. yüzyılın sonlarında burada sık sık oturduğu söylenen Fransız yazar Pierre Loti''nin adını taşır. Loti, İstanbul''u anlattığı romanlarıyla tanınır ve tepedeki kahvehane onun adıyla anılmaya başladı.

Kahvehanenin terasından Haliç''in tamamı, köprüler ve uzakta Tarihi Yarımada görülür; gün batımında manzara özellikle güzeldir. Eyüp Sultan Camii''nin yakınından kalkan teleferikle çıkılabilir ya da tarihi mezarlığın içinden geçen patikadan yürünebilir. Hafta sonları çok kalabalık olduğundan hafta içi daha keyiflidir.'),
  ('pierre-loti-tepesi', 'en', 'The hill above the Golden Horn in Eyüp is named after the French writer Pierre Loti, who is said to have often sat here in the late 19th century. Loti is known for novels set in Istanbul, and the café on the hill came to bear his name.

From the café terrace you see the whole Golden Horn, its bridges and, in the distance, the historic peninsula; the view is especially beautiful at sunset. You can ride the cable car from near the Eyüp Sultan Mosque or walk up the path through the historic cemetery. Weekends get very crowded, so weekdays are more enjoyable.'),
  ('tekfur-sarayi', 'tr', 'Edirnekapı''da kara surlarına bitişik Tekfur Sarayı, son dönem Bizans imparatorlarının yaşadığı Blakhernai Saray Kompleksi''nden günümüze sağlam ulaşan tek bölümdür ve 13.-14. yüzyıllara tarihlenir. Renkli tuğla ve taş süslemeli cephesi geç Bizans saray mimarisinin ender örneklerindendir.

Osmanlı döneminde yapı bir süre çini atölyesi ve cam imalathanesi olarak kullanıldı; burada üretilen 18. yüzyıl Tekfur Sarayı çinileri bu yüzden ayrı bir isimle anılır. Restorasyonun ardından müze olarak açılan sarayda bu çiniler ve kazı buluntuları sergilenir. Kariye ve Mihrimah Sultan Camii ile aynı gezide görülebilir.'),
  ('tekfur-sarayi', 'en', 'Against the land walls at Edirnekapı, Tekfur Palace is the only part of the Blachernae Palace complex, home of the late Byzantine emperors, to survive intact, dating to the 13th-14th centuries. Its façade decorated with coloured brick and stone is a rare example of late Byzantine palace architecture.

In Ottoman times the building served for a while as a tile workshop and glassworks, which is why the 18th-century tiles made here are known by its name. After restoration it opened as a museum displaying these tiles and finds from excavations. It can be combined with Chora and the Mihrimah Sultan Mosque.')
  ) v(slug, lang, long_desc)
  join public.places p on p.slug = v.slug
 where t.place_id = p.id and t.lang = v.lang;
