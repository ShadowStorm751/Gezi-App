-- Kapadokya uzun açıklamaları, 1. parti (22 yer, TR + EN).
-- Üreten: data-pipeline/content/build_long_desc.py (kaynak: content/kapadokya_long_descriptions.py).
-- Metinler kendi cümlelerimizdir; Vikipedi/Wikidata yalnızca bilgi kontrolü için kullanıldı.

update public.place_translations t
   set long_desc = v.long_desc
  from (values
  ('karamanoglu-camii', 'tr', 'Ürgüp''ün merkezindeki Karamanoğlu Camii, İbrahim Bey Camii ya da Ürgüp Ulu Camii olarak da bilinir. Karamanoğulları Beyliği''nden İbrahim Bey tarafından yaptırıldığı kabul edilir ve kasabanın en eski camilerindendir.

Taş işçiliği ve ahşap ayrıntılarıyla sade ama özenli bir yapıdır; Ürgüp''ün tarihi çarşı bölgesinde, peribacaları ve kaya evlerin arasında kalır. Temenni Tepe''ye çıkarken ya da kasaba merkezinde dolaşırken kısa bir durak olarak görülebilir.'),
  ('karamanoglu-camii', 'en', 'The Karamanoğlu Mosque in central Ürgüp is also known as the İbrahim Bey Mosque or the Grand Mosque of Ürgüp. It is believed to have been built by İbrahim Bey of the Karamanid principality and is one of the oldest mosques in the town.

With its stonework and wooden details it is a simple but carefully made building, set in Ürgüp''s historic market area among fairy chimneys and cave houses. It makes a short stop on the way up Temenni Hill or while wandering the town centre.'),
  ('karsi-kilise', 'tr', 'Gülşehir''deki Karşı Kilise, Aziz Yahya Kilisesi olarak da bilinir ve koni biçimli bir kaya kütlesinin içine oyulmuştur. İki katlı yapının alt katı daha eskidir; üst kat, bir yazıta göre 1212''de eklendi ve zengin fresklerle süslendi.

Üst kattaki Son Yargı, Müjde ve İsa''nın hayatından sahneler, Kapadokya''nın en iyi korunmuş 13. yüzyıl resimlerindendir. Katlar arasında modern bir merdiven vardır. Kalabalık turların uğramadığı sakin bir kilisedir; Açıksaray ile aynı gezide görülebilir.'),
  ('karsi-kilise', 'en', 'Karşı Kilise in Gülşehir, also known as the Church of St John, is carved into a cone-shaped rock mass. The lower floor of the two-storey building is older; according to an inscription, the upper floor was added in 1212 and decorated with rich frescoes.

The Last Judgement, the Annunciation and scenes from the life of Christ on the upper floor are among the best-preserved 13th-century paintings in Cappadocia. A modern staircase connects the floors. It is a quiet church skipped by most tour groups, and can be seen on the same trip as Açıksaray.'),
  ('aziz-nikolas-manastiri', 'tr', 'Mustafapaşa''nın yaklaşık bir kilometre güneyinde, Manastır Vadisi''ndeki Aziz Nikolaos Manastırı, Myra Piskoposu Aziz Nikolaos''a adanmıştır. Bir kısmı kâgir, büyük bölümü kayaya oyulmuş bitişik mekânlardan oluşur; ana kilisenin yanında Azize Barbara, Aziz Savvas ve Aziz Menas''a adanmış şapeller, hücreler ve bir çeşme bulunur. 19. yüzyılda Sinasos''un hem Hristiyan hem Müslüman halkının saygı gösterdiği bir merkezdi.

Restorasyonun ardından ziyarete açılan manastır, vadinin kaya oluşumları arasında huzurlu bir konumdadır. Köyden Dere Sokak üzerinden yürüyerek ulaşılır; Mustafapaşa''nın taş konakları ve Konstantin-Helena Kilisesi ile birlikte gezilir.'),
  ('aziz-nikolas-manastiri', 'en', 'About a kilometre south of Mustafapaşa, in the Monastery Valley, the Monastery of St Nicholas is dedicated to St Nicholas, Bishop of Myra. It consists of adjoining spaces, partly built of masonry and mostly carved into the rock; besides the main church there are chapels dedicated to St Barbara, St Sabbas and St Menas, cells and a fountain. In the 19th century it was a centre respected by both the Christian and Muslim people of Sinasos.

Reopened after restoration, the monastery sits peacefully among the valley''s rock formations. It is reached on foot from the village via Dere Street, and is seen together with Mustafapaşa''s stone mansions and the Church of Constantine and Helena.'),
  ('kutsal-hac-kilisesi', 'tr', 'Mustafapaşa''nın yaklaşık 2 km güneybatısında, Üzengi Vadisi''ndeki Kutsal Haç Kilisesi, Rumca adıyla Timios Stavros olarak bilinir. 9. yüzyıla tarihlenen beş nefli bu büyük kaya kilisesi, adını duvarlarındaki ortaçağ yazıtlarında geçen ''Kutsal Haç'' ifadesinden alır.

Apsisin üzerinde, Kilise Babaları''nı gösteren iri figürlü freskler ve kubbe tepesindeki yeşil haç dikkat çeker. Vadide oyulmuş yerleşimin üzerinde, yürüyüş yoluyla ulaşılan sessiz bir noktadır; patika yer yer dik olduğundan rahat ayakkabı giyin ve yanınıza su alın.'),
  ('kutsal-hac-kilisesi', 'en', 'About 2 km south-west of Mustafapaşa, in the Üzengi Valley, the Church of the Holy Cross is known by its Greek name, Timios Stavros. Dated to the 9th century, this large five-aisled rock church takes its name from the words ''Holy Cross'' that appear in medieval inscriptions on its walls.

Above the apse, frescoes with large figures of the Church Fathers and the green cross at the top of the vault stand out. It is a quiet spot above a carved settlement in the valley, reached by a footpath; the trail is steep in places, so wear comfortable shoes and bring water.'),
  ('agacalti-kilisesi', 'tr', 'Ihlara Vadisi''ndeki Ağaçaltı Kilisesi, vadiye ana merdivenlerden inenlerin ilk karşılaştığı kiliselerdendir. Haç planlı kaya kilisesinin fresklerinde, Daniel''in aslanlar arasındaki sahnesi ve İsa''nın hayatından bölümler yer alır.

Kilisenin asıl girişi toprak altında kaldığından bugün başka bir açıklıktan girilir; freskleri görmek için gözlerinizin loş ışığa alışmasını bekleyin. Merdivenlerin yarısında sağa dönen patikadan ulaşılır. Vadideki yürüyüşün başlangıcında kısa bir duraktır.'),
  ('agacalti-kilisesi', 'en', 'The Ağaçaltı Church in the Ihlara Valley is one of the first churches you meet after descending the main stairs into the valley. The frescoes of this cross-plan rock church include Daniel in the lions'' den and scenes from the life of Christ.

Because the original entrance is buried, you enter today through another opening; let your eyes adjust to the dim light to see the frescoes. It is reached by a path turning right halfway down the stairs. It is a short stop at the start of a walk through the valley.'),
  ('karanlik-kilise', 'tr', 'Göreme Açık Hava Müzesi''ndeki Karanlık Kilise, 11. yüzyılda yapılmış küçük bir manastır kilisesidir. Adını, içeriye çok az ışık girmesinden alır; bu sayede freskleri güneşten korunmuş ve renkleri şaşırtıcı biçimde canlı kalmıştır.

Kubbedeki Pantokrator İsa, Müjde, Doğum ve Çarmıha Geriliş sahneleri, Kapadokya''nın en iyi korunmuş freskleri arasındadır. Kiliseye müze biletine ek olarak ayrı bir biletle girilir; freskleri korumak için fotoğraf çekmek yasaktır. Kalabalığa kalmamak için sabah erken gidin.'),
  ('karanlik-kilise', 'en', 'The Dark Church in the Göreme Open-Air Museum is a small 11th-century monastery church. It takes its name from the very little light that reaches inside, which has protected its frescoes from the sun and kept their colours astonishingly vivid.

Christ Pantocrator in the dome and the scenes of the Annunciation, the Nativity and the Crucifixion are among the best-preserved frescoes in Cappadocia. Entry requires a separate ticket on top of the museum ticket, and photography is forbidden to protect the paintings. Go early in the morning to avoid the crowds.'),
  ('kokar-kilise-aksaray', 'tr', 'Ihlara Vadisi''ndeki Kokar Kilise, 9. yüzyıla ait, tek nefli ve beşik tonozlu bir kaya kilisesidir. Bugün yıkılmış olan apsis tarafından içeri girilir. Adının, eskiden içinde biriken kötü kokudan geldiği anlatılır.

Duvarlarındaki fresklerde Müjde, Doğum, Son Akşam Yemeği ve Çarmıha Geriliş gibi İncil sahneleri bulunur; tavandaki büyük haç süslemesi de dikkat çeker. Vadinin ana merdivenlerine yakındır ve yürüyüşün ilk kilometresinde görülebilir.'),
  ('kokar-kilise-aksaray', 'en', 'The Kokar Church in the Ihlara Valley is a 9th-century rock church with a single barrel-vaulted nave. You enter through the side of the now-collapsed apse. Its name, meaning ''smelly'', is said to come from a bad odour that once lingered inside.

The frescoes on its walls show Gospel scenes such as the Annunciation, the Nativity, the Last Supper and the Crucifixion, and the large cross on the ceiling also stands out. It is close to the valley''s main stairs and can be seen in the first kilometre of the walk.'),
  ('yilanli-kilise-aksaray', 'tr', 'Ihlara Vadisi''ndeki Yılanlı Kilise, 9. yüzyılın sonlarına tarihlenir. Adını, günahkârların yılanlarla cezalandırıldığını gösteren Son Yargı freskinden alır; bu sahne, Bizans sanatında ender görülen ayrıntılar içerir.

Kiliseye, ana merdivenlerden indikten sonra Selime yönüne biraz yürüyüp köprüyle karşı yakaya geçerek ve kısa bir merdivenle çıkarak ulaşılır. Freskleri koruyan loş iç mekânda flaş kullanmayın. Vadinin en çok ziyaret edilen kiliselerindendir.'),
  ('yilanli-kilise-aksaray', 'en', 'The Snake Church in the Ihlara Valley dates from the late 9th century. It takes its name from its Last Judgement fresco showing sinners punished by snakes, a scene with details rarely seen in Byzantine art.

To reach it, walk a little towards Selime after descending the main stairs, cross the bridge to the opposite bank and climb a short flight of steps. Do not use flash in the dim interior that protects the frescoes. It is one of the most visited churches in the valley.'),
  ('aciksaray', 'tr', 'Gülşehir yakınlarındaki Açıksaray, kayalara oyulmuş, saray cephesini andıran yapılardan oluşan bir ören yeridir. 9-11. yüzyıllara tarihlenen yapıların bir manastır, bir konaklama yeri ya da büyük bir çiftlik yerleşimi olduğu düşünülür.

Kemerli ve sütun süslemeli cepheler, avlular ve mantar biçimli ünlü peribacası alanın en dikkat çekici bölümleridir. Göreme''deki kalabalıktan uzak, rahat gezilebilen bir açık hava müzesidir. Gülşehir''deki Karşı Kilise ile birlikte yarım gün ayırın.'),
  ('aciksaray', 'en', 'Near Gülşehir, Açıksaray is a site of rock-cut buildings whose façades resemble palaces. Dated to the 9th-11th centuries, the buildings are thought to have been a monastery, a lodging place or a large farming settlement.

Arched façades decorated with carved columns, courtyards and a famous mushroom-shaped fairy chimney are the most striking parts of the site. It is an open-air museum that is easy to explore, away from the crowds of Göreme. Set aside half a day for it together with Karşı Kilise in Gülşehir.'),
  ('aziz-yuhanna-vaftizci-kilisesi-cavusin', 'tr', 'Çavuşin''in eski köyünün bulunduğu kayalığın tepesine oyulmuş Vaftizci Yahya Kilisesi, Kapadokya''nın bilinen en eski ve en büyük kaya kiliselerinden biridir. Kökeninin 5. yüzyıla kadar uzandığı düşünülür ve uzun süre önemli bir hac yeri olmuştur.

Kilisenin ön cephesi kaya düşmeleriyle büyük ölçüde yıkılmış, fresklerin çoğu solmuştur; yine de bazilika planı ve büyüklüğü etkileyicidir. Kiliseye eski köyün içinden dik bir patikayla tırmanılır; yukarıdan Çavuşin ve Gül Vadisi''nin manzarası görülür. Kayalık zeminde dikkatli olun.'),
  ('aziz-yuhanna-vaftizci-kilisesi-cavusin', 'en', 'Carved near the top of the cliff where Çavuşin''s old village stands, the Church of St John the Baptist is one of the oldest and largest known rock churches in Cappadocia. Its origins are thought to go back to the 5th century, and it was long an important place of pilgrimage.

Its front has largely collapsed in rockfalls and most of its frescoes have faded, yet its basilica plan and size remain impressive. You reach it by a steep path through the old village, with views over Çavuşin and the Rose Valley from above. Take care on the rocky ground.'),
  ('keslik-manastiri', 'tr', 'Mustafapaşa ile Cemil köyü arasındaki Keşlik Manastırı, kayaya oyulmuş kiliseler, yemekhane ve keşiş hücrelerinden oluşan bir yapı topluluğudur. Bizans döneminde bölgedeki manastır yaşamının iyi bir örneğidir.

Ana kilisenin duvarlarındaki fresklerin bir kısmı, sonraki yüzyıllarda burada yakılan ateşlerin isiyle kararmıştır; görevli genellikle fenerle ayrıntıları gösterir. Bahçesi ve sakin çevresiyle Mustafapaşa ve Soğanlı yönündeki bir gezide kısa bir durak olarak uygundur.'),
  ('keslik-manastiri', 'en', 'Between Mustafapaşa and the village of Cemil, Keşlik Monastery is a group of rock-cut churches, a refectory and monks'' cells. It is a good example of monastic life in the region in the Byzantine period.

Some of the frescoes on the walls of the main church have been blackened by the smoke of fires lit here in later centuries; the attendant usually shows the details with a torch. With its garden and quiet setting, it makes a short stop on a trip towards Mustafapaşa and Soğanlı.'),
  ('tokali-kilise', 'tr', 'Göreme Açık Hava Müzesi''nin girişindeki Tokalı Kilise, bölgenin en büyük ve en zengin süslü kaya kilisesidir. 10. yüzyılda iki aşamada yapıldı: önce Eski Tokalı olarak bilinen tek nefli kilise, ardından ona eklenen geniş Yeni Tokalı.

Yeni Tokalı''daki derin lacivert zemin üzerine yapılmış freskler, İsa''nın hayatını ve azizlerin hikâyelerini anlatır; Kapadokya resim sanatının doruk noktası sayılır. Kilise ana müze alanının hemen dışında, yolun karşısında kalır; aynı biletle girildiği için atlamayın.'),
  ('tokali-kilise', 'en', 'At the entrance to the Göreme Open-Air Museum, Tokalı Kilise (the Church of the Buckle) is the largest and most richly decorated rock church in the region. It was built in two phases in the 10th century: first the single-nave church known as the Old Tokalı, then the spacious New Tokalı added to it.

The frescoes of the New Tokalı, painted on a deep blue ground, tell the life of Christ and the stories of saints and are considered the high point of Cappadocian painting. The church lies just outside the main museum area, across the road; it is included in the same ticket, so do not miss it.'),
  ('selime-katedrali', 'tr', 'Ihlara Vadisi''nin kuzey ucunda, Selime köyünün üzerindeki kayalıklara oyulmuş Selime Katedrali, Kapadokya''nın en büyük kaya manastırlarından biridir. Kilise, mutfak, ahır, odalar ve avlulardan oluşan yapı topluluğu, Bizans döneminde önemli bir dini ve idari merkez olduğunu düşündürür.

Katedral olarak anılan büyük kilisenin sütunlu iç mekânı, mutfaktaki yüksek baca ve tünellerle birbirine bağlanan odalar gezilebilir. Yamaca tırmanış dik ve kayalıktır; rahat ayakkabı giyin. Köydeki Selime Sultan Türbesi ve Ihlara yürüyüşünün bitiş noktası hemen aşağıdadır.'),
  ('selime-katedrali', 'en', 'At the northern end of the Ihlara Valley, carved into the cliffs above the village of Selime, Selime Cathedral is one of the largest rock monasteries in Cappadocia. The complex of church, kitchen, stables, rooms and courtyards suggests it was an important religious and administrative centre in the Byzantine period.

You can explore the columned interior of the large church known as the cathedral, the tall chimney in the kitchen and rooms linked by tunnels. The climb up the slope is steep and rocky; wear comfortable shoes. The Selime Sultan Tomb in the village and the end point of the Ihlara walk are just below.'),
  ('sumbullu-kilise', 'tr', 'Ihlara Vadisi''ndeki Sümbüllü Kilise, kaya kütlesine iki kat halinde oyulmuş bir manastır kilisesidir. Vadinin en dikkat çekici cephelerinden birine sahiptir; kemerli nişler ve süslemeler kayaya ustaca işlenmiştir.

İçerideki fresklerde Başmelekler Mikail ve Cebrail arasında Meryem, İsa, fırına atılan üç İbrani genç ve azizler tasvir edilir. Vadinin ana merdivenlerine yakın, kısa bir tırmanışla ulaşılır. Cephesini görmek için biraz geri çekilip bakın.'),
  ('sumbullu-kilise', 'en', 'The Jacinth Church in the Ihlara Valley is a monastery church carved into the rock on two levels. It has one of the most striking façades in the valley, with arched niches and decoration skilfully worked into the rock.

The frescoes inside show Mary between the Archangels Michael and Gabriel, Christ, the three Hebrew youths in the furnace, and saints. It is close to the valley''s main stairs, reached by a short climb. Step back a little to take in its façade.'),
  ('purenli-seki-kilisesi', 'tr', 'Ihlara Vadisi''ndeki Pürenli Seki Kilisesi, kayaya oyulmuş dört bölümden oluşur. Fresklerinin 10. yüzyılın başlarından 12. yüzyıla kadar farklı dönemlerde yapıldığı düşünülür; narteksin zemininde mezarlar bulunur.

Peygamberlerin kehanetleri, Meryem ve İsa''nın hayatından sahneler en iyi korunmuş resimlerdendir. Kilise, vadinin yamacında, yürüyüş yolundan biraz yukarıda kalır; kısa ama dik bir tırmanış gerekir. Kalabalıktan uzak, sakin bir duraktır.'),
  ('purenli-seki-kilisesi', 'en', 'The Pürenli Seki Church in the Ihlara Valley consists of four rock-cut sections. Its frescoes are thought to have been painted at different times between the early 10th and the 12th centuries, and there are graves in the floor of the narthex.

The prophecies of the prophets and scenes from the lives of Mary and Christ are among the best-preserved paintings. The church sits on the valley slope a little above the walking path, reached by a short but steep climb. It is a quiet stop away from the crowds.'),
  ('azize-barbara-kilisesi', 'tr', 'Göreme Açık Hava Müzesi''ndeki Azize Barbara Kilisesi, 11. yüzyıla tarihlenen küçük bir kaya kilisesidir ve adını duvarında tasvir edilen Azize Barbara''dan alır.

Duvarları ve tavanı kaplayan, doğrudan kayaya kırmızı aşı boyasıyla yapılmış geometrik desenler ve sembolik figürler en ilgi çekici yanıdır; bazı figürlerin anlamı hâlâ tartışılır. Müze alanının içinde, Elmalı ve Yılanlı kiliselerine yakındır.'),
  ('azize-barbara-kilisesi', 'en', 'The Church of St Barbara in the Göreme Open-Air Museum is a small 11th-century rock church named after St Barbara, who is depicted on its wall.

Its most interesting feature is the geometric patterns and symbolic figures painted in red ochre directly onto the rock across the walls and ceiling; the meaning of some figures is still debated. It is inside the museum area, close to the Apple and Snake churches.'),
  ('azize-catherine-sapeli', 'tr', 'Göreme Açık Hava Müzesi''ndeki Azize Catherine Şapeli, İskenderiyeli Azize Katerina''ya adanmış küçük bir kaya şapelidir. Müze alanındaki diğer şapeller gibi Bizans döneminde, manastır topluluğunun ibadet ve anma yeri olarak oyuldu.

Duvarlarında aziz tasvirleri ve süsleme kalıntıları görülebilir. Küçük olduğu için içeri girmek için sıra beklemek gerekebilir. Karanlık Kilise ve Çarıklı Kilise''ye giden yolun üzerindedir.'),
  ('azize-catherine-sapeli', 'en', 'The Chapel of St Catherine in the Göreme Open-Air Museum is a small rock chapel dedicated to St Catherine of Alexandria. Like the other chapels on the site, it was carved in the Byzantine period as a place of worship and commemoration for the monastic community.

Depictions of saints and remains of decoration can be seen on its walls. As it is small, you may have to queue to go in. It lies on the path to the Dark Church and the Church with Sandals.'),
  ('basil-sapeli', 'tr', 'Göreme Açık Hava Müzesi''nin girişine yakın Aziz Basil Şapeli, Kapadokyalı kilise babalarından Kayserili Aziz Basil''e adanmıştır. Bölgenin manastır yaşamını düzenleyen kurallar büyük ölçüde onun öğretilerine dayanır.

Şapelin narteksinde mezarlar, duvarlarında Aziz Basil, Aziz Georgios ve Aziz Theodoros tasvirleri bulunur. Müzeye girdikten sonra ilk görülecek yapılardandır; kısa bir ziyaret yeterlidir.'),
  ('basil-sapeli', 'en', 'Near the entrance of the Göreme Open-Air Museum, the Chapel of St Basil is dedicated to St Basil of Caesarea, one of the Cappadocian Church Fathers. The rules that shaped monastic life in the region rest largely on his teachings.

There are graves in the chapel''s narthex, and depictions of St Basil, St George and St Theodore on its walls. It is one of the first buildings you see after entering the museum; a short visit is enough.'),
  ('elmali-kilise', 'tr', 'Göreme Açık Hava Müzesi''ndeki Elmalı Kilise, 11. yüzyıla tarihlenen, dört sütunlu ve kubbeli bir kaya kilisesidir. Adının, kilisenin önünde bir zamanlar bulunan elma ağacından ya da Başmelek Cebrail''in elinde tuttuğu küreden geldiği anlatılır.

Kubbedeki Pantokrator İsa ve duvarları kaplayan İncil sahneleri, müzenin en güzel fresk dizilerindendir. İçerisi küçük ve kalabalık olabilir; sırayı beklerken çevredeki peribacalarına oyulmuş hücrelere bakın.'),
  ('elmali-kilise', 'en', 'The Apple Church in the Göreme Open-Air Museum is an 11th-century rock church with four columns and domes. Its name is said to come either from an apple tree that once stood in front of it or from the orb held by the Archangel Gabriel.

Christ Pantocrator in the dome and the Gospel scenes covering the walls make up one of the finest fresco cycles in the museum. The interior is small and can get crowded; while you wait, look at the cells carved into the fairy chimneys around it.'),
  ('pantokrator-kilisesi', 'tr', 'Göreme Açık Hava Müzesi''ndeki bu küçük kilise, adını Bizans sanatının en önemli tasvirlerinden olan Pantokrator İsa''dan, yani ''Her Şeyin Hâkimi'' olarak resmedilen İsa''dan alır.

Müze alanındaki kayaya oyulmuş yapıların çoğu gibi bir manastır topluluğunun parçasıydı. Ana gezi yolunun üzerinde, diğer kiliselerle birlikte kısa bir durak olarak görülebilir; fresklere dokunmayın ve flaş kullanmayın.'),
  ('pantokrator-kilisesi', 'en', 'This small church in the Göreme Open-Air Museum takes its name from Christ Pantocrator, ''the Ruler of All'', one of the most important images in Byzantine art.

Like most of the rock-cut buildings on the site, it was part of a monastic community. It lies on the main route and can be seen as a short stop together with the other churches; do not touch the frescoes or use flash.'),
  ('yilanli-kilise', 'tr', 'Göreme Açık Hava Müzesi''ndeki Yılanlı Kilise, uzun ve tonozlu tek bir salondan oluşur. Adını, Aziz Georgios ve Aziz Theodoros''un bir yılanı (ejderhayı) öldürdüğü freskten alır.

Freskler arasında İmparator Konstantin ile annesi Helena''nın Kutsal Haç''ı tutan tasviri ve uzun beyaz sakallı keşiş Onuphrios''un figürü de dikkat çeker. Resimler daha sade bir üslupla yapılmıştır; Karanlık ve Elmalı kiliselerle karşılaştırınca farkı görebilirsiniz.'),
  ('yilanli-kilise', 'en', 'The Snake Church in the Göreme Open-Air Museum consists of a single long, vaulted hall. It takes its name from the fresco of St George and St Theodore killing a snake (dragon).

Among the frescoes, the Emperor Constantine and his mother Helena holding the True Cross and the figure of the long-bearded hermit Onuphrius also stand out. The paintings are in a simpler style; compare them with the Dark and Apple churches to see the difference.'),
  ('carikli-kilise', 'tr', 'Göreme Açık Hava Müzesi''ndeki Çarıklı Kilise, 11. yüzyıla tarihlenen, dört sütunlu bir kaya kilisesidir. Adını, İsa''nın Göğe Yükselişi sahnesinin altında zemindeki ayak izi biçimli oyuklardan alır.

Kubbe ve duvarları kaplayan freskler, Karanlık ve Elmalı kiliselerdekilere benzer bir üslupla yapılmıştır. Kiliseye kısa bir metal merdivenle çıkılır; müze alanının yukarı kesiminde, Karanlık Kilise''nin yakınındadır.'),
  ('carikli-kilise', 'en', 'The Church with Sandals in the Göreme Open-Air Museum is an 11th-century rock church with four columns. It takes its name from the footprint-shaped hollows in the floor beneath the scene of Christ''s Ascension.

The frescoes covering its domes and walls are in a style similar to those of the Dark and Apple churches. You climb up to it by a short metal staircase; it is in the upper part of the museum area, near the Dark Church.')
  ) v(slug, lang, long_desc)
  join public.places p on p.slug = v.slug
 where t.place_id = p.id and t.lang = v.lang;
