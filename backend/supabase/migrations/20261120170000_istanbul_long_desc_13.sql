-- İstanbul uzun açıklamaları, 13. parti (10 yer, TR + EN).
-- Üreten: data-pipeline/content/build_long_desc.py (kaynak: content/istanbul_long_descriptions.py).
-- Metinler kendi cümlelerimizdir; Vikipedi/Wikidata yalnızca bilgi kontrolü için kullanıldı.

update public.place_translations t
   set long_desc = v.long_desc
  from (values
  ('adalar-muzesi', 'tr', 'Büyükada''daki Adalar Müzesi, İstanbul 2010 Avrupa Kültür Başkenti kapsamında açıldı ve İstanbul''un ilk çağdaş kent müzesi olarak bilinir. Adalar Vakfı ile Adalar Belediyesi''nin iş birliğiyle kuruldu.

Müze, Prens Adaları''nın Bizans döneminden günümüze uzanan tarihini, adalarda birlikte yaşayan toplulukları, sayfiye hayatını ve adaların doğasını fotoğraflar, belgeler ve gündelik eşyalarla anlatır. Ziyaret koşulları değişebildiğinden gitmeden önce kontrol edin.'),
  ('adalar-muzesi', 'en', 'On Büyükada, the Islands Museum opened as part of Istanbul''s year as European Capital of Culture in 2010 and is known as Istanbul''s first contemporary city museum. It was created through a partnership between the Islands Foundation and the Islands municipality.

Through photographs, documents and everyday objects, the museum tells the history of the Princes'' Islands from Byzantine times to today, the communities who lived together there, summer-resort life and the islands'' nature. Visiting arrangements can change, so check before you go.'),
  ('ataturk-arboretumu', 'tr', 'Sarıyer''de Bahçeköy yakınında, Belgrad Ormanı''nın doğal bitki örtüsü içinde kurulan Atatürk Arboretumu, ağaç ve odunsu bitkilerin bilimsel amaçla sergilendiği geniş bir alandır. Dünyanın farklı bölgelerinden binlerce bitki türüne ev sahipliği yapar.

Göletler etrafında dolaşan patikalar, özellikle sonbaharda yaprakların renk değiştirdiği dönemde fotoğrafçıların gözdesidir. Bitkileri korumak için ziyaretçi sayısı, piknik ve fotoğraf çekimiyle ilgili kurallar uygulanır. Giriş koşullarını gitmeden önce kontrol edin.'),
  ('ataturk-arboretumu', 'en', 'In Sarıyer near Bahçeköy, set within the natural woodland of Belgrad Forest, the Atatürk Arboretum is a large area where trees and woody plants are displayed for scientific purposes. It is home to thousands of plant species from around the world.

Its paths winding around ponds are a favourite with photographers, especially in autumn when the leaves change colour. To protect the plants, rules apply to visitor numbers, picnics and photography. Check the entry conditions before you go.'),
  ('galata-surp-krikor-lusavoric-kilisesi', 'tr', 'Karaköy''deki Surp Krikor Lusavoriç Kilisesi, kökleri 14. yüzyılın sonuna, Galata''nın Ceneviz dönemine uzanan bir Ermeni Apostolik kilisesidir. Eski kilise 1950''lerde yol genişletme çalışmaları sırasında yıkıldı; bugünkü yapı yakın bir yerde, geleneksel Ermeni kilise mimarisine göre yeniden inşa edildi.

Adını Ermenileri Hristiyanlığa geçiren Aydınlatıcı Aziz Grigor''dan alır. Taş cephesi ve konik kubbesiyle Karaköy''ün kalabalığı içinde kendine özgü bir görünüm sunar. İbadete açık olduğundan kapı açıksa sessizce ziyaret edilebilir.'),
  ('galata-surp-krikor-lusavoric-kilisesi', 'en', 'In Karaköy, the Church of St Gregory the Illuminator is an Armenian Apostolic church whose roots go back to the late 14th century, when Galata was a Genoese colony. The old church was demolished in the 1950s during road widening; the present building was rebuilt nearby following traditional Armenian church architecture.

It is named after St Gregory the Illuminator, who brought Christianity to the Armenians. With its stone façade and conical dome, it has a distinctive look amid the bustle of Karaköy. As a working church, it can be visited quietly when the gate is open.'),
  ('sile-kalesi', 'tr', 'Şile sahilinin hemen açığındaki Ocaklı Ada üzerinde duran Şile Kalesi, Karadeniz kıyısını gözetlemek için yapılmış küçük bir kaledir. En yaygın görüşe göre 14. yüzyılda Cenevizliler tarafından inşa edildi.

2015''teki restorasyonunun ardından aldığı görünüm tartışma yaratsa da, deniz üzerindeki konumuyla Şile''nin simgelerinden biridir. Kalenin karşısındaki kıyıdan ve yakındaki Şile Feneri''nden gün batımında güzel fotoğraflar çekilir. Şile''nin plajları ve ünlü Şile bezi dükkânlarıyla birlikte gezilebilir.'),
  ('sile-kalesi', 'en', 'Just off the Şile shore on Ocaklı Island, Şile Castle is a small fortress built to watch over the Black Sea coast. According to the most widely accepted view, it was built by the Genoese in the 14th century.

Although its look after the 2015 restoration caused controversy, its position on the sea makes it one of Şile''s symbols. The shore opposite the castle and the nearby Şile lighthouse are great spots for sunset photos. It combines well with Şile''s beaches and its shops selling the famous Şile cloth.'),
  ('falih-rifki-atay-tabiat-parki', 'tr', 'Sarıyer''de Belgrad Ormanı içinde bulunan Falih Rıfkı Atay Tabiat Parkı, 2011''de ormandaki tabiat parklarından biri olarak düzenlendi. Adını gazeteci, yazar ve siyasetçi Falih Rıfkı Atay''dan alır.

Ağaçlar arasındaki yürüyüş ve bisiklet yolları, gölet kenarları ve piknik alanları şehrin gürültüsünden uzak bir gün geçirmek için uygundur. Hafta sonları kalabalık olabilir; giriş koşulları ve piknik kurallarını gitmeden önce kontrol edin. Belgrad Ormanı''ndaki diğer parklarla birleştirilebilir.'),
  ('falih-rifki-atay-tabiat-parki', 'en', 'Inside Belgrad Forest in Sarıyer, Falih Rıfkı Atay Nature Park was established in 2011 as one of the forest''s nature parks. It is named after the journalist, writer and politician Falih Rıfkı Atay.

Its walking and cycling trails among the trees, pond-side spots and picnic areas are ideal for a day away from the city''s noise. It can get busy at weekends; check entry conditions and picnic rules before you go. It combines with the forest''s other parks.'),
  ('goztepe-60-yil-parki', 'tr', 'Kadıköy''de Bağdat Caddesi ile Operatör Cemil Topuzlu Caddesi arasında uzanan Göztepe 60. Yıl Parkı, Anadolu yakasının en çok kullanılan kent parklarından biridir. Park 2013''te yenilenerek bugünkü haline kavuştu.

Geniş çimenlikleri, göleti ve yürüyüş yollarıyla aileler için idealdir; nisan ayında çiçek açan laleler parkı rengârenk yapar. Bağdat Caddesi''nde alışveriş ya da Caddebostan sahilinde yürüyüş yaparken mola vermek için uygun bir yerdir.'),
  ('goztepe-60-yil-parki', 'en', 'In Kadıköy, stretching between Bağdat Avenue and Operatör Cemil Topuzlu Avenue, Göztepe 60th Anniversary Park is one of the most used city parks on the Asian side. It was renovated in 2013 into its current form.

With its wide lawns, pond and walking paths it is ideal for families, and the tulips blooming in April fill it with colour. It is a good place for a break while shopping on Bağdat Avenue or walking along the Caddebostan shore.'),
  ('kilyos-plaji', 'tr', 'Sarıyer''in Karadeniz kıyısındaki Kilyos, geniş kumsallarıyla İstanbul''un Avrupa yakasındaki en bilinen sahil beldelerinden biridir. Yaz aylarında şehirden kaçmak isteyenler için gözde bir plaj durağıdır.

Plajların bir kısmı işletmeler tarafından düzenlenmiştir ve şezlong, duş gibi hizmetler sunar. Karadeniz''de dalgalar ve akıntılar zaman zaman çok tehlikeli olabilir; yalnızca cankurtaran bulunan ve yüzmenin serbest olduğu alanlarda denize girin, uyarı bayraklarına dikkat edin. Hafta sonları yoğun trafiğe hazırlıklı olun.'),
  ('kilyos-plaji', 'en', 'On Sarıyer''s Black Sea coast, Kilyos is one of the best-known seaside resorts on Istanbul''s European side, with wide sandy beaches. In summer it is a favourite beach escape from the city.

Some of the beaches are run by businesses offering sunbeds, showers and other services. Waves and currents on the Black Sea can at times be very dangerous; swim only where lifeguards are present and swimming is allowed, and watch the warning flags. Expect heavy traffic at weekends.'),
  ('mihrabat-tabiat-parki', 'tr', 'Beykoz''da Kanlıca''nın üzerindeki tepede bulunan Mihrabat Tabiat Parkı, yaklaşık 20 hektarlık bir korudur ve 2011''de tabiat parkı ilan edildi. Çoğunluğu yaprak döken ağaçlardan oluşan zengin bir bitki örtüsüne sahiptir.

Boğaz''a hâkim konumundan Fatih Sultan Mehmet Köprüsü ve karşı kıyının geniş manzarası görülür; gün batımında özellikle güzeldir. Piknik alanları ve yürüyüş yollarıyla sakin bir hafta sonu durağıdır. Kanlıca''nın ünlü yoğurduyla aynı gezide birleştirilebilir.'),
  ('mihrabat-tabiat-parki', 'en', 'On the hill above Kanlıca in Beykoz, Mihrabat Nature Park is a grove of about 20 hectares declared a nature park in 2011. It has rich vegetation made up mostly of deciduous trees.

From its position over the Bosphorus there are wide views of the Fatih Sultan Mehmet Bridge and the opposite shore, especially lovely at sunset. With picnic areas and walking paths, it is a quiet weekend stop. It combines well with Kanlıca''s famous yoghurt.'),
  ('florya-ataturk-kent-ormani', 'tr', 'Bakırköy''ün Florya semtindeki Atatürk Kent Ormanı, yaklaşık 54 hektarlık bir alana yayılan büyük bir kent ormanıdır. 2021''de yapılan ekolojik restorasyonla doğal malzemeden yürüyüş yolları ve dinlenme alanları düzenlendi.

Ağaçlar arasındaki patikalar, koşu ve yürüyüş için şehrin Avrupa yakasının batısında sakin bir seçenek sunar. Hemen yakınındaki Florya sahili ve Atatürk Deniz Köşkü ile aynı gezide görülebilir. Piknik ve giriş kurallarını gitmeden önce kontrol edin.'),
  ('florya-ataturk-kent-ormani', 'en', 'In the Florya district of Bakırköy, the Atatürk Urban Forest is a large city woodland covering about 54 hectares. An ecological restoration in 2021 added walking paths of natural materials and rest areas.

Its trails among the trees offer a quiet option for running and walking on the western side of the European shore. It can be combined with the nearby Florya shore and the Atatürk Sea Pavilion. Check picnic and entry rules before you go.'),
  ('yogurtcu-parki', 'tr', 'Kadıköy''de Kurbağalıdere boyunca uzanan Yoğurtçu Parkı, semtin en eski ve en sevilen parklarından biridir. Kurbağalıdere''nin denize döküldüğü bölgeye kadar uzanan park, Moda ile Fenerbahçe arasındaki yürüyüş rotasının bir parçasıdır.

Ulu ağaçların gölgesindeki çay bahçeleri, çocuk oyun alanları ve dere kenarındaki yürüyüş yolları gün boyu canlıdır. Yakındaki Müze Gazhane ve Moda sahiliyle aynı gezide birleştirilebilir; Kalamış''a kadar sahil boyunca yürümek de mümkündür.'),
  ('yogurtcu-parki', 'en', 'In Kadıköy, running along the Kurbağalıdere stream, Yoğurtçu Park is one of the district''s oldest and best-loved parks. Stretching down to where the stream meets the sea, it forms part of the walking route between Moda and Fenerbahçe.

Its tea gardens under great trees, playgrounds and streamside paths are lively all day. It combines well with the nearby Müze Gazhane and the Moda shore, and you can walk along the coast to Kalamış.')
  ) v(slug, lang, long_desc)
  join public.places p on p.slug = v.slug
 where t.place_id = p.id and t.lang = v.lang;
