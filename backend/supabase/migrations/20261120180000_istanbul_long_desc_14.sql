-- İstanbul uzun açıklamaları, 14. parti (13 yer, TR + EN).
-- Üreten: data-pipeline/content/build_long_desc.py (kaynak: content/istanbul_long_descriptions.py).
-- Metinler kendi cümlelerimizdir; Vikipedi/Wikidata yalnızca bilgi kontrolü için kullanıldı.

update public.place_translations t
   set long_desc = v.long_desc
  from (values
  ('garipce-kalesi', 'tr', 'Boğaz''ın Karadeniz''e açıldığı noktada, Avrupa yakasındaki Garipçe köyünün üzerinde duran Garipçe Kalesi, 18. yüzyılın ikinci yarısında III. Mustafa döneminde Boğaz''ın girişini korumak için yapıldı. Yapımında Osmanlı hizmetindeki Fransız subay Baron de Tott''un rol aldığı bilinir.

Kayalıklar üzerindeki kale kalıntılarından Karadeniz''in girişi, karşı kıyı ve Yavuz Sultan Selim Köprüsü görülür. Aşağıdaki küçük balıkçı köyü, kahvaltı ve balık restoranlarıyla sakin bir mola yeri sunar. Kayalıklarda dikkatli yürüyün; şehirden uzak olduğu için ulaşımı önceden planlayın.'),
  ('garipce-kalesi', 'en', 'At the point where the Bosphorus opens to the Black Sea, above the village of Garipçe on the European shore, Garipçe Castle was built in the second half of the 18th century under Mustafa III to guard the entrance to the strait. The French officer Baron de Tott, then in Ottoman service, is known to have played a role in building it.

From the castle ruins on the rocks you see the mouth of the Black Sea, the opposite shore and the Yavuz Sultan Selim Bridge. The small fishing village below, with breakfast and fish restaurants, offers a quiet stop. Walk carefully on the rocks; it is far from the city, so plan your transport in advance.'),
  ('turhan-sultan-turbesi', 'tr', 'Eminönü''de Yeni Cami''nin hemen yanındaki Turhan Sultan Türbesi, 1663''te Sultan İbrahim''in eşi ve IV. Mehmed''in annesi Turhan Hatice Sultan için yapıldı. Yarım kalan Yeni Cami''yi tamamlatan da odur.

Türbede Turhan Sultan''ın yanı sıra IV. Mehmed, II. Mustafa, III. Ahmed, I. Mahmud ve III. Osman olmak üzere beş padişah yatar; bu yönüyle İstanbul''un en kalabalık padişah türbelerinden biridir. Mısır Çarşısı''nın girişine çok yakın olduğundan Eminönü gezisi sırasında kısa bir durak olarak görülebilir; sessiz ve saygılı olunmalıdır.'),
  ('turhan-sultan-turbesi', 'en', 'In Eminönü, right beside the New Mosque, the Tomb of Turhan Sultan was built in 1663 for Turhan Hatice Sultan, consort of Sultan İbrahim and mother of Mehmed IV. She was also the one who completed the unfinished New Mosque.

Besides Turhan Sultan, five sultans lie here: Mehmed IV, Mustafa II, Ahmed III, Mahmud I and Osman III, making it one of the most crowded imperial tombs in Istanbul. Very close to the entrance of the Spice Bazaar, it makes a short stop during a walk around Eminönü; visitors should be quiet and respectful.'),
  ('bebek-parki', 'tr', 'Boğaz''ın en güzel koylarından birinde, Bebek sahilindeki Bebek Parkı, 18. yüzyılda Hümayunabad Kasrı''nın bahçesiydi. Sabancı Vakfı''nın yenilemesinin ardından 2008''den bu yana Türkan Sabancı Bebek Parkı adını taşır.

Ağaçlar altındaki banklar ve çimenlik alanlardan Bebek koyunun ve demirli teknelerin manzarası görülür. Hemen yanında Mimar Kemaleddin''in tasarladığı Bebek Camii bulunur. Sahildeki kafeler ve Arnavutköy''e uzanan yürüyüş yolu ile birlikte keyifli bir Boğaz günü geçirilebilir.'),
  ('bebek-parki', 'en', 'On one of the loveliest bays of the Bosphorus, Bebek Park on the Bebek waterfront was the garden of the Hümayunabad Pavilion in the 18th century. Since a renovation by the Sabancı Foundation it has been called Türkan Sabancı Bebek Park, from 2008.

Its benches under the trees and lawns look out over Bebek bay and the moored boats. Right beside it stands the Bebek Mosque designed by the architect Kemaleddin. Together with the waterfront cafés and the promenade towards Arnavutköy, it makes for a pleasant Bosphorus day.'),
  ('nakkastepe-millet-bahcesi', 'tr', 'Üsküdar''da Kuzguncuk ile Altunizade arasındaki sırtlarda bulunan Nakkaştepe Millet Bahçesi, Boğaz''a bakan geniş bir kent parkıdır. Yakın dönemde millet bahçesi olarak düzenlenerek halka açıldı.

Geniş çimenlikleri, yürüyüş yolları ve seyir noktalarından 15 Temmuz Şehitler Köprüsü, Boğaz''ın iki yakası ve karşı kıyıdaki siluet görülür; manzara özellikle gün batımında güzeldir. Piknik ve aile gezileri için uygundur. Aşağıdaki Kuzguncuk sokaklarıyla aynı gezide birleştirilebilir.'),
  ('nakkastepe-millet-bahcesi', 'en', 'On the hills between Kuzguncuk and Altunizade in Üsküdar, Nakkaştepe Nation''s Garden is a large city park overlooking the Bosphorus. It was recently landscaped as a nation''s garden and opened to the public.

From its wide lawns, paths and viewpoints you see the 15 July Martyrs Bridge, both shores of the Bosphorus and the skyline opposite; the view is especially beautiful at sunset. It is good for picnics and family outings. It combines well with the streets of Kuzguncuk below.'),
  ('sile-feneri', 'tr', 'Şile''de denize bakan yüksek bir burunda duran Şile Feneri, Osmanlı döneminde 19. yüzyılın ortasında, Fransız asıllı Mişel Paşa''nın yönettiği Fenerler İdaresi tarafından yapıldı. Türkiye''nin en büyük deniz fenerlerinden biri olarak bilinir ve bugün de çalışır.

Sekizgen taş kulesi Karadeniz kıyısında uzaktan seçilir. Çevresinden Şile Kalesi, Ocaklı Ada ve Şile''nin kumsalları görülür; gün batımı için güzel bir noktadır. Fenerin içinin ziyaret koşulları değişebildiğinden gitmeden önce kontrol edin.'),
  ('sile-feneri', 'en', 'On a high headland overlooking the sea at Şile, Şile Lighthouse was built in the mid-19th century, in Ottoman times, by the Lighthouse Administration run by the French-born Michel Pasha. It is known as one of the largest lighthouses in Turkey and is still in service.

Its octagonal stone tower can be seen from far along the Black Sea coast. From around it you see Şile Castle, Ocaklı Island and Şile''s beaches; it is a fine spot for sunset. Visiting arrangements for the interior can change, so check before you go.'),
  ('anadolu-feneri', 'tr', 'Boğaz''ın Karadeniz''e açıldığı noktada, Anadolu yakasının kuzey ucundaki Yum Burnu''nda duran Anadolu Feneri, 19. yüzyılın ortasında yapıldı ve bugün de çalışır. Karşı kıyıdaki Rumeli Feneri ile birlikte Boğaz''ın girişini işaretler.

Fenerle aynı adı taşıyan küçük köy, Karadeniz''e bakan yamaçları ve sakin havasıyla şehirden kaçmak için güzel bir yerdir. Çevrede askeri alanlar bulunduğundan bazı bölümlere giriş kısıtlıdır; tabelalara dikkat edin. Ulaşım ve erişim koşullarını gitmeden önce kontrol edin.'),
  ('anadolu-feneri', 'en', 'At the point where the Bosphorus opens to the Black Sea, on Yum Point at the northern tip of the Asian side, Anadolu Lighthouse was built in the mid-19th century and is still in service. Together with Rumeli Lighthouse on the opposite shore, it marks the entrance to the strait.

The small village of the same name, with its slopes facing the Black Sea and its calm atmosphere, is a lovely escape from the city. There are military zones in the area, so access to some parts is restricted; watch the signs. Check transport and access before you go.'),
  ('otagtepe', 'tr', 'Beykoz''da Kavacık''ın üzerindeki Otağtepe, Fatih Sultan Mehmet Köprüsü''nün Anadolu ayağına bakan ağaçlık bir tepe ve kent parkıdır. Rivayete göre adını, Fatih Sultan Mehmed''in Rumeli Hisarı''nın yapımı sırasında burada otağ kurmasından alır.

Seyir terasından köprü, Rumeli Hisarı ve Boğaz''ın kuşbakışı manzarası görülür; özellikle gece ışıklandırılmış köprü etkileyicidir. Kafe ve yürüyüş yollarıyla kısa bir mola için uygundur. Toplu taşımayla ulaşmak zor olabilir.'),
  ('otagtepe', 'en', 'Above Kavacık in Beykoz, Otağtepe is a wooded hill and city park facing the Asian end of the Fatih Sultan Mehmet Bridge. Legend has it that it takes its name, ''tent hill'', from the imperial tent Mehmed II pitched here while Rumeli Fortress was being built.

Its viewing terrace offers a bird''s-eye view of the bridge, Rumeli Fortress and the Bosphorus; the bridge lit up at night is especially striking. With a café and walking paths, it is good for a short break. Getting there by public transport can be difficult.'),
  ('validebag-korusu', 'tr', 'Üsküdar''da Altunizade ile Koşuyolu arasında yer alan Validebağ Korusu, yaklaşık 35 hektarlık alanıyla Anadolu yakasının en büyük yeşil alanlarından biridir. Osmanlı döneminde saray ailesine ait bir mesire ve av alanıydı; içinde 19. yüzyıldan kalma tarihi bir kasır bulunur.

Ulu ağaçlar arasındaki yürüyüş ve koşu yolları, çevredeki yoğun yapılaşmanın ortasında beklenmedik bir doğa sunar. Koru, kuş türleri ve bitki örtüsüyle doğal sit alanı olarak korunur. Sabah yürüyüşleri ve sakin bir hafta sonu gezintisi için idealdir.'),
  ('validebag-korusu', 'en', 'In Üsküdar, between Altunizade and Koşuyolu, Validebağ Grove covers about 35 hectares and is one of the largest green spaces on the Asian side. In Ottoman times it was a pleasure ground and hunting area of the imperial family, and it contains a historic 19th-century pavilion.

Its walking and running paths among great trees offer unexpected nature in the middle of a densely built area. With its birds and plant life, the grove is protected as a natural heritage site. It is ideal for morning walks and quiet weekend strolls.'),
  ('fenerbahce-parki', 'tr', 'Kadıköy''de Marmara''ya uzanan Fenerbahçe burnunun büyük bölümünü kaplayan Fenerbahçe Parkı, adını burunda 19. yüzyıldan beri çalışan deniz fenerinden alır. Park, 1990''larda Çelik Gülersoy''un öncülüğünde bugünkü haline getirildi.

Çam ağaçları altındaki piknik alanları, kafeler ve denize inen merdivenlerden Adalar ve Marmara''nın geniş manzarası görülür. Gün batımında ve hafta sonları çok sevilir. Kalamış ve Caddebostan''a uzanan sahil yürüyüş yoluyla birleştirilebilir.'),
  ('fenerbahce-parki', 'en', 'In Kadıköy, covering most of the Fenerbahçe headland jutting into the Marmara, Fenerbahçe Park takes its name from the lighthouse that has worked on the point since the 19th century. It was given its present form in the 1990s under the lead of Çelik Gülersoy.

From its picnic areas under the pines, cafés and steps down to the sea there are wide views of the Princes'' Islands and the Marmara. It is much loved at sunset and at weekends. It combines with the coastal path towards Kalamış and Caddebostan.'),
  ('alemdag', 'tr', 'Çekmeköy sınırlarındaki Alemdağ, 442 metre yüksekliğiyle Aydos Tepesi''nden sonra İstanbul''un en yüksek ikinci noktası olarak bilinir. Çevresi geniş ormanlarla kaplıdır ve Bizans döneminde Meludion adıyla anılırdı.

Ormanlık alandaki mesire yerleri ve yürüyüş yolları, hafta sonu piknik ve doğa yürüyüşü için Anadolu yakasının sevilen adreslerindendir. Açık havalarda tepelerden geniş bir manzara görülür. Rahat ayakkabı ve su almak, piknik kurallarını önceden kontrol etmek iyi olur.'),
  ('alemdag', 'en', 'Within Çekmeköy, Alemdağ rises to 442 metres and is known as Istanbul''s second-highest point after Aydos Hill. Its surroundings are covered with wide forests, and in Byzantine times it was known as Meludion.

Its picnic grounds and forest trails are favourites on the Asian side for weekend picnics and nature walks. On clear days the hills offer wide views. Comfortable shoes and water are a good idea, and it is worth checking picnic rules in advance.'),
  ('alfred-heilbronn-botanik-bahcesi', 'tr', 'Süleymaniye''de İstanbul Üniversitesi Fen Fakültesi''nin yanındaki Alfred Heilbronn Botanik Bahçesi, 1935''te kuruldu ve Türkiye''nin en eski botanik bahçesidir. Nazi Almanyası''ndan kaçarak İstanbul Üniversitesi''nde çalışan botanikçiler Alfred Heilbronn ve Leo Brauner tarafından kuruldu.

Bahçede Türkiye''nin ve dünyanın farklı bölgelerinden binlerce bitki türü, seralar ve bilimsel koleksiyonlar bulunur. Tarihi yarımadanın ortasında az bilinen, sakin bir yeşil alandır. Bir üniversite birimi olduğundan ziyaret saatleri sınırlıdır; gitmeden önce kontrol edin.'),
  ('alfred-heilbronn-botanik-bahcesi', 'en', 'In Süleymaniye, beside Istanbul University''s Faculty of Science, the Alfred Heilbronn Botanical Garden was founded in 1935 and is Turkey''s oldest botanical garden. It was established by the botanists Alfred Heilbronn and Leo Brauner, who had fled Nazi Germany to work at Istanbul University.

The garden holds thousands of plant species from Turkey and around the world, along with greenhouses and scientific collections. It is a little-known, quiet green space in the middle of the historic peninsula. As a university unit it has limited opening hours; check before you go.'),
  ('aydos-ormani', 'tr', 'Kartal''ın kuzeyinde, Aydos Tepesi''nin çevresine yayılan Aydos Ormanı, Anadolu yakasında bir zamanlar geniş bir alanı kaplayan güney ormanlarının günümüze ulaşan parçalarından biridir. Kayışdağı ormanlarıyla birlikte bir yeşil kuşak oluşturur.

Ormandaki gölet, piknik alanları ve yürüyüş yolları hafta sonları ailelerin ve doğa yürüyüşçülerinin uğrak yeridir. Aydos Tepesi''ne çıkarak Marmara ve Adalar manzarasıyla gezi tamamlanabilir. Piknik ve giriş kurallarını gitmeden önce kontrol edin.'),
  ('aydos-ormani', 'en', 'North of Kartal, spreading around Aydos Hill, Aydos Forest is one of the surviving pieces of the southern forests that once covered a large area of the Asian side. Together with the Kayışdağı woods it forms a green belt.

Its pond, picnic areas and trails are popular with families and hikers at weekends. You can finish with a climb to Aydos Hill for views of the Marmara and the Princes'' Islands. Check picnic and entry rules before you go.'),
  ('beykoz-cayiri', 'tr', 'Beykoz merkezindeki Beykoz Çayırı, Osmanlı padişahlarının av yeri olarak kullanıldığı için Hünkâr Çayırı diye de anılırdı. Zamanla şehir dokusu içinde kalarak alanının bir kısmını kaybetse de bugün de ilçenin en sevilen açık alanlarından biridir.

Geniş çimenliği ve ulu ağaçlarıyla piknik ve dinlenme için uygundur. Yakınındaki Beykoz meydanında 18. yüzyıldan kalma İshak Ağa Çeşmesi görülebilir; Beykoz sahili ve korusuyla aynı gezide birleştirilebilir.'),
  ('beykoz-cayiri', 'en', 'In the centre of Beykoz, Beykoz Meadow was also known as the Sultan''s Meadow because the Ottoman sultans used it as a hunting ground. Although it has lost part of its area as the town grew around it, it remains one of the district''s best-loved open spaces.

Its wide lawn and great trees make it good for picnics and relaxing. In nearby Beykoz square you can see the 18th-century İshak Ağa Fountain, and it combines with the Beykoz shore and grove.')
  ) v(slug, lang, long_desc)
  join public.places p on p.slug = v.slug
 where t.place_id = p.id and t.lang = v.lang;
