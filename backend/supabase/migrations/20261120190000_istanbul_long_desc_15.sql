-- İstanbul uzun açıklamaları, 15. parti (13 yer, TR + EN).
-- Üreten: data-pipeline/content/build_long_desc.py (kaynak: content/istanbul_long_descriptions.py).
-- Metinler kendi cümlelerimizdir; Vikipedi/Wikidata yalnızca bilgi kontrolü için kullanıldı.

update public.place_translations t
   set long_desc = v.long_desc
  from (values
  ('kucukcamlica-korusu', 'tr', 'Üsküdar''daki Küçük Çamlıca Korusu, Boğaz çevresinin en yüksek tepelerinden Küçük Çamlıca''nın eteklerinden yaklaşık 227 metrelik zirvesine kadar uzanır. Büyük Çamlıca''ya göre daha sakin ve ağaçlık bir alandır.

Tepede bugün şehrin yeni simgelerinden Çamlıca Kulesi yükselir. Korunun yürüyüş yolları ve seyir noktalarından Boğaz, Tarihi Yarımada ve Marmara manzarası görülür. Büyük Çamlıca Tepesi ve Çamlıca Camii ile aynı gezide birleştirilebilir.'),
  ('kucukcamlica-korusu', 'en', 'In Üsküdar, Küçük Çamlıca Grove stretches from the foot of Küçük Çamlıca, one of the highest hills around the Bosphorus, up to its summit at about 227 metres. It is quieter and more wooded than Büyük Çamlıca.

The summit is now crowned by Çamlıca Tower, one of the city''s new landmarks. The grove''s paths and viewpoints overlook the Bosphorus, the historic peninsula and the Marmara. It combines with Büyük Çamlıca Hill and the Çamlıca Mosque.'),
  ('menekse-plaji', 'tr', 'Küçükçekmece''deki Menekşe Plajı, İstanbul Büyükşehir Belediyesi tarafından işletilen ücretsiz bir halk plajıdır. Marmara kıyısında yaklaşık 630 metre uzunluğunda bir kumsala sahiptir.

Yaz aylarında Avrupa yakasının batısında yaşayanlar için yakın bir deniz ve güneşlenme noktasıdır; sahil boyunca yürüyüş yolu ve kafeler bulunur. Denize girmeden önce belediyenin plaj ve deniz suyu kalitesi duyurularını kontrol edin, yalnızca cankurtaran bulunan alanlarda yüzün.'),
  ('menekse-plaji', 'en', 'In Küçükçekmece, Menekşe Beach is a free public beach run by the Istanbul Metropolitan Municipality. It has a sandy shore about 630 metres long on the Sea of Marmara.

In summer it is a nearby spot for swimming and sunbathing for those living on the western side of the European shore, with a promenade and cafés along the coast. Before swimming, check the municipality''s notices on beaches and water quality, and swim only where lifeguards are present.'),
  ('anadolu-kavagi-manzara-seyir-noktasi', 'tr', 'Anadolu Kavağı, Boğaz''ın Anadolu yakasında Karadeniz girişine en yakın balıkçı köylerinden biridir ve Boğaz turu vapurlarının son durağı olarak bilinir. Köyün üzerindeki yamaçlar, Boğaz''ın Karadeniz''e açılan ağzını gören seyir noktaları sunar.

Buradan Boğaz''ın kuzey kesimi, karşı kıyıdaki köyler ve Yavuz Sultan Selim Köprüsü görülür. Yokuş yukarı yürüyüşle Yoros Kalesi''ne kadar çıkılabilir; iskele çevresindeki balık restoranları da bilinen bir duraktır. Vapur saatleri mevsime göre değiştiği için önceden kontrol edin.'),
  ('anadolu-kavagi-manzara-seyir-noktasi', 'en', 'Anadolu Kavağı is one of the fishing villages closest to the Black Sea entrance on the Asian side of the Bosphorus and is known as the last stop of the Bosphorus cruise ferries. The slopes above the village offer viewpoints over the mouth of the strait.

From here you see the northern Bosphorus, the villages on the opposite shore and the Yavuz Sultan Selim Bridge. An uphill walk leads on to Yoros Castle, and the fish restaurants around the pier are a well-known stop. Ferry times vary by season, so check in advance.'),
  ('sarayburnu-manzarasi', 'tr', 'Tarihi Yarımada''nın en ucundaki Sarayburnu, Boğaz''ın, Haliç''in ve Marmara Denizi''nin buluştuğu noktaya bakar. Bizans döneminden beri şehrin en stratejik yerlerinden biri olan burun, Osmanlı döneminde Topkapı Sarayı''nın bahçelerinin bir parçasıydı.

Sahil yolundan ve Gülhane Parkı''nın ucundan Üsküdar, Kız Kulesi, Kadıköy ve Boğaz''a giren gemiler görülür. Burunda 1926''da dikilen ve İstanbul''daki ilk Atatürk heykellerinden biri olan anıt bulunur. Gün batımında manzara özellikle etkileyicidir.'),
  ('sarayburnu-manzarasi', 'en', 'At the very tip of the historic peninsula, Sarayburnu looks out over the meeting point of the Bosphorus, the Golden Horn and the Sea of Marmara. One of the city''s most strategic spots since Byzantine times, the point was part of the gardens of Topkapı Palace in the Ottoman era.

From the coastal road and the end of Gülhane Park you see Üsküdar, the Maiden''s Tower, Kadıköy and ships entering the Bosphorus. On the point stands a monument erected in 1926, one of the first statues of Atatürk in Istanbul. The view is especially striking at sunset.'),
  ('yenikoy-seyir-terasi', 'tr', 'Arnavutköy ilçesine bağlı Yeniköy, Avrupa yakasının Karadeniz kıyısında yer alan sakin bir köydür. Köy çevresindeki yüksek noktalar, Karadeniz''in geniş ve açık manzarasını gören bir seyir terası sunar.

Kalabalıktan uzak bu noktada dalgalar, kıyı şeridi ve özellikle gün batımı izlenebilir. Çevrede düzenlenmiş hizmetler sınırlı olabileceğinden su ve ihtiyaçlarınızı yanınızda getirin; ulaşım ve erişim koşullarını gitmeden önce kontrol edin.'),
  ('yenikoy-seyir-terasi', 'en', 'Part of the Arnavutköy district, Yeniköy is a quiet village on the Black Sea coast of the European side. The high ground around the village offers a viewing terrace with wide, open views over the Black Sea.

Away from the crowds, it is a place to watch the waves, the coastline and especially the sunset. Facilities in the area may be limited, so bring water and what you need; check transport and access before you go.'),
  ('beykoz-korusu', 'tr', 'Beykoz merkezinde, sahilin hemen gerisinden yamaç boyunca yükselen Beykoz Korusu, Boğaz''a hâkim konumda büyük bir ağaçlık alandır. Toplu taşımayla kolayca ulaşılabilmesi onu ilçenin en çok kullanılan yeşil alanlarından biri yapar.

Ağaçlar arasındaki yürüyüş yolları, dinlenme alanları ve Boğaz''a bakan noktaları sakin bir gezinti sunar. Beykoz Çayırı ve sahil ile aynı gezide birleştirilebilir; hafta sonları piknikçiler ve aileler tarafından çok tercih edilir.'),
  ('beykoz-korusu', 'en', 'In central Beykoz, rising up the slope just behind the shore, Beykoz Grove is a large wooded area overlooking the Bosphorus. Easy to reach by public transport, it is one of the district''s most used green spaces.

Its paths among the trees, rest areas and spots overlooking the Bosphorus offer a peaceful stroll. It combines with Beykoz Meadow and the shore, and is popular with picnickers and families at weekends.'),
  ('ciroz-plaji', 'tr', 'Çiroz Plajı, Bakırköy''ün Yeşilköy kıyılarında, Marmara Denizi''ne bakan bir sahil alanıdır. Yeşilköy, tarihi köşkleri ve ağaçlı sokaklarıyla Marmara kıyısının sakin semtlerinden biridir.

Sahil boyunca deniz kenarında yürüyüş yapılabilir ve güneşlenilebilir. Denize girmeden önce belediyenin plaj ve deniz suyu kalitesi duyurularını kontrol edin, yalnızca yüzmenin serbest olduğu ve cankurtaran bulunan alanlarda denize girin.'),
  ('ciroz-plaji', 'en', 'Çiroz Beach is a stretch of shore on the Yeşilköy coast of Bakırköy, facing the Sea of Marmara. Yeşilköy, with its historic mansions and tree-lined streets, is one of the quiet districts of the Marmara coast.

You can walk and sunbathe along the seafront. Before swimming, check the municipality''s notices on beaches and water quality, and swim only where swimming is allowed and lifeguards are present.'),
  ('hacilli-selalesi', 'tr', 'Şile ilçesinin ormanlık iç kesimlerinde bulunan Hacıllı Şelalesi, orman içinde yürüyüşle ulaşılan küçük bir şelaledir. İstanbul''un kalabalığından uzakta, doğa yürüyüşü sevenlerin keşfettiği sakin bir noktadır.

Suyun miktarı mevsime göre değişir; kış ve ilkbahar aylarında daha gürdür. Patikalar kaygan ve işaretsiz olabileceğinden uygun ayakkabı giyin, yanınıza su alın ve mümkünse grupla ya da bölgeyi bilen biriyle gidin. Ulaşım ve erişim koşullarını gitmeden önce kontrol edin.'),
  ('hacilli-selalesi', 'en', 'In the wooded interior of the Şile district, Hacıllı Waterfall is a small waterfall reached on foot through the forest. Far from the crowds of Istanbul, it is a quiet spot discovered by hiking lovers.

Its flow varies with the season and is strongest in winter and spring. Paths can be slippery and unmarked, so wear suitable shoes, bring water and, if possible, go with a group or someone who knows the area. Check transport and access before you go.'),
  ('barbaros-hayreddin-pasa-turbesi', 'tr', 'Beşiktaş iskelesinin yanındaki parkta bulunan Barbaros Hayreddin Paşa Türbesi, Osmanlı donanmasının ünlü kaptan-ı deryası için Mimar Sinan tarafından yapıldı. Barbaros 1546''da öldüğünde, kendi seçtiği bu yere gömüldü.

Sekizgen planlı, tek kubbeli türbenin önündeki parkta 1944''te dikilen Barbaros heykeli bulunur. Denizcilik geleneğinde türbenin özel bir yeri vardır; önünden geçen deniz kuvvetleri gemilerinin onu selamladığı anlatılır. Deniz Müzesi''nin hemen yanında olduğundan birlikte gezilebilir.'),
  ('barbaros-hayreddin-pasa-turbesi', 'en', 'In the park beside the Beşiktaş pier, the Tomb of Barbaros Hayreddin Pasha was built by Mimar Sinan for the famous grand admiral of the Ottoman fleet. When Barbaros died in 1546, he was buried in this spot he had chosen himself.

In the park in front of the octagonal, single-domed tomb stands a statue of Barbaros erected in 1944. The tomb holds a special place in naval tradition; navy ships passing by are said to salute it. Right beside the Naval Museum, the two can be visited together.'),
  ('yahya-efendi-turbesi', 'tr', 'Beşiktaş''ta Çırağan Sarayı''nın karşısındaki yamaçta bulunan Yahya Efendi Türbesi, Kanuni Sultan Süleyman''ın süt kardeşi olan âlim ve şair Yahya Efendi için yapıldı. Türbe ve yanındaki tekke Mimar Sinan''ın eseridir.

Yeşillikler içindeki hazirede Osmanlı hanedanının çeşitli üyelerine ve devlet adamlarına ait zarif mezar taşları bulunur. Boğaz''ın kalabalığından birkaç adım uzakta, ağaçların gölgesinde huzurlu bir yerdir. Ziyaret sırasında sessiz ve saygılı olunmalıdır.'),
  ('yahya-efendi-turbesi', 'en', 'In Beşiktaş, on the slope opposite Çırağan Palace, the Tomb of Yahya Efendi was built for the scholar and poet Yahya Efendi, foster brother of Suleiman the Magnificent. The tomb and the lodge beside it are works of Mimar Sinan.

The green graveyard holds elegant headstones of members of the Ottoman dynasty and statesmen. A few steps from the bustle of the Bosphorus, it is a peaceful place in the shade of trees. Visitors should be quiet and respectful.'),
  ('aziz-mahmud-hudayi-turbesi', 'tr', 'Üsküdar''daki Aziz Mahmud Hüdayi Türbesi, 17. yüzyılın önemli mutasavvıflarından ve Celvetiyye tarikatının kurucusu Aziz Mahmud Hüdayi''nin türbesidir. Hüdayi 1628''de öldüğünde, yanında 16. yüzyılın sonunda yapımına başlanan cami ve külliyeye defnedildi.

Türbe, İstanbul''un en çok ziyaret edilen manevi mekânlarından biridir ve özellikle cuma günleri kalabalık olur. Avludaki çeşmeler ve hazire de görülmeye değer. Ziyaret sırasında sessiz ve saygılı olunmalıdır. Üsküdar merkezinden yürüme mesafesindedir.'),
  ('aziz-mahmud-hudayi-turbesi', 'en', 'In Üsküdar, the Tomb of Aziz Mahmud Hüdayi belongs to one of the leading Sufis of the 17th century and founder of the Celvetiyye order. When Hüdayi died in 1628, he was buried beside the mosque and complex begun at the end of the 16th century.

The tomb is one of Istanbul''s most visited spiritual sites and gets busy, especially on Fridays. The fountains and graveyard in the courtyard are also worth seeing. Visitors should be quiet and respectful. It is within walking distance of central Üsküdar.'),
  ('merkez-efendi-turbesi', 'tr', 'Zeytinburnu''nda, kara surlarının Mevlanakapı''sının karşısındaki Merkez Efendi Türbesi, 16. yüzyıl mutasavvıfı ve hekimi Merkez Efendi''nin türbesidir. Merkez Efendi, Manisa''da hazırladığı şifalı karışımla mesir macununun ortaya çıkışıyla anılır.

Türbe, cami, kuyu ve geniş tarihi mezarlıktan oluşan külliye sakin bir ziyaret yeridir; ziyaretçilerin kutsal saydığı kuyunun suyu ilgi görür. Ziyaret sırasında sessiz ve saygılı olunmalıdır. Kara surları boyunca yapılacak bir yürüyüşe eklenebilir.'),
  ('merkez-efendi-turbesi', 'en', 'In Zeytinburnu, opposite the Mevlanakapı gate of the land walls, the Tomb of Merkez Efendi belongs to the 16th-century Sufi and physician Merkez Efendi. He is remembered for the healing paste he prepared in Manisa, from which the tradition of mesir paste arose.

The complex, with its tomb, mosque, well and large historic cemetery, is a quiet place to visit, and the water of the well, regarded as blessed by visitors, draws interest. Visitors should be quiet and respectful. It can be added to a walk along the land walls.'),
  ('telli-baba-turbesi', 'tr', 'Sarıyer''de Boğaz kıyısında, Rumelikavağı yolunun kenarındaki Telli Baba Türbesi, halk arasında çok sevilen bir ziyaret yeridir. Türbede yatan zatın kimliği hakkında farklı rivayetler anlatılır.

Geleneğe göre ziyaretçiler, özellikle evlenmek isteyenler, dilek dileyerek türbenin parmaklığına tel bağlar; dileği gerçekleşenlerin gelin teliyle geri döndüğü anlatılır. Türbe adını bu gelenekten alır. Ziyaret sırasında sessiz ve saygılı olunmalıdır; Boğaz kıyısındaki sahil yolu üzerinde kısa bir durak olarak görülebilir.'),
  ('telli-baba-turbesi', 'en', 'On the Bosphorus shore in Sarıyer, beside the road to Rumelikavağı, the Tomb of Telli Baba is a much-loved place of popular pilgrimage. Different stories are told about the identity of the person buried there.

By tradition, visitors, especially those hoping to marry, tie a wire to the tomb''s railing as they make a wish, and those whose wishes come true are said to return with a bride''s tinsel. The tomb takes its name, ''father of the wire'', from this custom. Visitors should be quiet and respectful; it makes a short stop on the coastal road along the Bosphorus.')
  ) v(slug, lang, long_desc)
  join public.places p on p.slug = v.slug
 where t.place_id = p.id and t.lang = v.lang;
