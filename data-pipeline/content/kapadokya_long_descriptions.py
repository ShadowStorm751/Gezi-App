"""Kapadokya yerlerinin uzun açıklamaları (TR + EN). Kurallar istanbul_long_descriptions.py ile aynı:

  * Kendi cümlelerimiz; Vikipedi metni kopyalanmaz (results/kapadokya/wiki-extracts.json.gz yalnızca bilgi kontrolü için).
  * 2 paragraf: (1) ne olduğu ve kısa tarihçe, (2) ne görülmeli + pratik ipucu.
  * Sık değişen bilgi yok: bilet fiyatı, saat, telefon. Tartışmalı ya da doğrulanamayan sayı yazılmaz.
  * Paragraflar "\\n\\n" ile ayrılır.

LONG[slug] = (parti, tr, en). Parti numarası migration'ı belirler (build_long_desc.py --city kapadokya).
"""

LONG = {
    "karamanoglu-camii": (1,
        "Ürgüp'ün merkezindeki Karamanoğlu Camii, İbrahim Bey Camii ya da Ürgüp Ulu Camii olarak da bilinir. "
        "Karamanoğulları Beyliği'nden İbrahim Bey tarafından yaptırıldığı kabul edilir ve kasabanın en eski "
        "camilerindendir.\n\n"
        "Taş işçiliği ve ahşap ayrıntılarıyla sade ama özenli bir yapıdır; Ürgüp'ün tarihi çarşı bölgesinde, peribacaları "
        "ve kaya evlerin arasında kalır. Temenni Tepe'ye çıkarken ya da kasaba merkezinde dolaşırken kısa bir durak "
        "olarak görülebilir.",
        "The Karamanoğlu Mosque in central Ürgüp is also known as the İbrahim Bey Mosque or the Grand Mosque of Ürgüp. "
        "It is believed to have been built by İbrahim Bey of the Karamanid principality and is one of the oldest mosques "
        "in the town.\n\n"
        "With its stonework and wooden details it is a simple but carefully made building, set in Ürgüp's historic market "
        "area among fairy chimneys and cave houses. It makes a short stop on the way up Temenni Hill or while wandering "
        "the town centre."),

    "karsi-kilise": (1,
        "Gülşehir'deki Karşı Kilise, Aziz Yahya Kilisesi olarak da bilinir ve koni biçimli bir kaya kütlesinin içine "
        "oyulmuştur. İki katlı yapının alt katı daha eskidir; üst kat, bir yazıta göre 1212'de eklendi ve zengin "
        "fresklerle süslendi.\n\n"
        "Üst kattaki Son Yargı, Müjde ve İsa'nın hayatından sahneler, Kapadokya'nın en iyi korunmuş 13. yüzyıl "
        "resimlerindendir. Katlar arasında modern bir merdiven vardır. Kalabalık turların uğramadığı sakin bir "
        "kilisedir; Açıksaray ile aynı gezide görülebilir.",
        "Karşı Kilise in Gülşehir, also known as the Church of St John, is carved into a cone-shaped rock mass. The lower "
        "floor of the two-storey building is older; according to an inscription, the upper floor was added in 1212 and "
        "decorated with rich frescoes.\n\n"
        "The Last Judgement, the Annunciation and scenes from the life of Christ on the upper floor are among the "
        "best-preserved 13th-century paintings in Cappadocia. A modern staircase connects the floors. It is a quiet church "
        "skipped by most tour groups, and can be seen on the same trip as Açıksaray."),

    "aziz-nikolas-manastiri": (1,
        "Mustafapaşa'nın yaklaşık bir kilometre güneyinde, Manastır Vadisi'ndeki Aziz Nikolaos Manastırı, Myra Piskoposu "
        "Aziz Nikolaos'a adanmıştır. Bir kısmı kâgir, büyük bölümü kayaya oyulmuş bitişik mekânlardan oluşur; ana "
        "kilisenin yanında Azize Barbara, Aziz Savvas ve Aziz Menas'a adanmış şapeller, hücreler ve bir çeşme bulunur. "
        "19. yüzyılda Sinasos'un hem Hristiyan hem Müslüman halkının saygı gösterdiği bir merkezdi.\n\n"
        "Restorasyonun ardından ziyarete açılan manastır, vadinin kaya oluşumları arasında huzurlu bir konumdadır. "
        "Köyden Dere Sokak üzerinden yürüyerek ulaşılır; Mustafapaşa'nın taş konakları ve Konstantin-Helena Kilisesi "
        "ile birlikte gezilir.",
        "About a kilometre south of Mustafapaşa, in the Monastery Valley, the Monastery of St Nicholas is dedicated to St "
        "Nicholas, Bishop of Myra. It consists of adjoining spaces, partly built of masonry and mostly carved into the "
        "rock; besides the main church there are chapels dedicated to St Barbara, St Sabbas and St Menas, cells and a "
        "fountain. In the 19th century it was a centre respected by both the Christian and Muslim people of Sinasos.\n\n"
        "Reopened after restoration, the monastery sits peacefully among the valley's rock formations. It is reached on "
        "foot from the village via Dere Street, and is seen together with Mustafapaşa's stone mansions and the Church of "
        "Constantine and Helena."),

    "kutsal-hac-kilisesi": (1,
        "Mustafapaşa'nın yaklaşık 2 km güneybatısında, Üzengi Vadisi'ndeki Kutsal Haç Kilisesi, Rumca adıyla Timios "
        "Stavros olarak bilinir. 9. yüzyıla tarihlenen beş nefli bu büyük kaya kilisesi, adını duvarlarındaki ortaçağ "
        "yazıtlarında geçen 'Kutsal Haç' ifadesinden alır.\n\n"
        "Apsisin üzerinde, Kilise Babaları'nı gösteren iri figürlü freskler ve kubbe tepesindeki yeşil haç dikkat "
        "çeker. Vadide oyulmuş yerleşimin üzerinde, yürüyüş yoluyla ulaşılan sessiz bir noktadır; patika yer yer "
        "dik olduğundan rahat ayakkabı giyin ve yanınıza su alın.",
        "About 2 km south-west of Mustafapaşa, in the Üzengi Valley, the Church of the Holy Cross is known by its Greek "
        "name, Timios Stavros. Dated to the 9th century, this large five-aisled rock church takes its name from the words "
        "'Holy Cross' that appear in medieval inscriptions on its walls.\n\n"
        "Above the apse, frescoes with large figures of the Church Fathers and the green cross at the top of the vault "
        "stand out. It is a quiet spot above a carved settlement in the valley, reached by a footpath; the trail is steep "
        "in places, so wear comfortable shoes and bring water."),

    "agacalti-kilisesi": (1,
        "Ihlara Vadisi'ndeki Ağaçaltı Kilisesi, vadiye ana merdivenlerden inenlerin ilk karşılaştığı kiliselerdendir. "
        "Haç planlı kaya kilisesinin fresklerinde, Daniel'in aslanlar arasındaki sahnesi ve İsa'nın hayatından "
        "bölümler yer alır.\n\n"
        "Kilisenin asıl girişi toprak altında kaldığından bugün başka bir açıklıktan girilir; freskleri görmek için "
        "gözlerinizin loş ışığa alışmasını bekleyin. Merdivenlerin yarısında sağa dönen patikadan ulaşılır. Vadideki "
        "yürüyüşün başlangıcında kısa bir duraktır.",
        "The Ağaçaltı Church in the Ihlara Valley is one of the first churches you meet after descending the main stairs "
        "into the valley. The frescoes of this cross-plan rock church include Daniel in the lions' den and scenes from the "
        "life of Christ.\n\n"
        "Because the original entrance is buried, you enter today through another opening; let your eyes adjust to the "
        "dim light to see the frescoes. It is reached by a path turning right halfway down the stairs. It is a short stop "
        "at the start of a walk through the valley."),

    "karanlik-kilise": (1,
        "Göreme Açık Hava Müzesi'ndeki Karanlık Kilise, 11. yüzyılda yapılmış küçük bir manastır kilisesidir. Adını, "
        "içeriye çok az ışık girmesinden alır; bu sayede freskleri güneşten korunmuş ve renkleri şaşırtıcı biçimde canlı "
        "kalmıştır.\n\n"
        "Kubbedeki Pantokrator İsa, Müjde, Doğum ve Çarmıha Geriliş sahneleri, Kapadokya'nın en iyi korunmuş "
        "freskleri arasındadır. Kiliseye müze biletine ek olarak ayrı bir biletle girilir; freskleri korumak için "
        "fotoğraf çekmek yasaktır. Kalabalığa kalmamak için sabah erken gidin.",
        "The Dark Church in the Göreme Open-Air Museum is a small 11th-century monastery church. It takes its name from "
        "the very little light that reaches inside, which has protected its frescoes from the sun and kept their colours "
        "astonishingly vivid.\n\n"
        "Christ Pantocrator in the dome and the scenes of the Annunciation, the Nativity and the Crucifixion are among the "
        "best-preserved frescoes in Cappadocia. Entry requires a separate ticket on top of the museum ticket, and "
        "photography is forbidden to protect the paintings. Go early in the morning to avoid the crowds."),

    "kokar-kilise-aksaray": (1,
        "Ihlara Vadisi'ndeki Kokar Kilise, 9. yüzyıla ait, tek nefli ve beşik tonozlu bir kaya kilisesidir. Bugün "
        "yıkılmış olan apsis tarafından içeri girilir. Adının, eskiden içinde biriken kötü kokudan geldiği "
        "anlatılır.\n\n"
        "Duvarlarındaki fresklerde Müjde, Doğum, Son Akşam Yemeği ve Çarmıha Geriliş gibi İncil sahneleri bulunur; "
        "tavandaki büyük haç süslemesi de dikkat çeker. Vadinin ana merdivenlerine yakındır ve yürüyüşün ilk "
        "kilometresinde görülebilir.",
        "The Kokar Church in the Ihlara Valley is a 9th-century rock church with a single barrel-vaulted nave. You enter "
        "through the side of the now-collapsed apse. Its name, meaning 'smelly', is said to come from a bad odour that "
        "once lingered inside.\n\n"
        "The frescoes on its walls show Gospel scenes such as the Annunciation, the Nativity, the Last Supper and the "
        "Crucifixion, and the large cross on the ceiling also stands out. It is close to the valley's main stairs and can "
        "be seen in the first kilometre of the walk."),

    "yilanli-kilise-aksaray": (1,
        "Ihlara Vadisi'ndeki Yılanlı Kilise, 9. yüzyılın sonlarına tarihlenir. Adını, günahkârların yılanlarla "
        "cezalandırıldığını gösteren Son Yargı freskinden alır; bu sahne, Bizans sanatında ender görülen ayrıntılar "
        "içerir.\n\n"
        "Kiliseye, ana merdivenlerden indikten sonra Selime yönüne biraz yürüyüp köprüyle karşı yakaya geçerek ve kısa "
        "bir merdivenle çıkarak ulaşılır. Freskleri koruyan loş iç mekânda flaş kullanmayın. Vadinin en çok ziyaret "
        "edilen kiliselerindendir.",
        "The Snake Church in the Ihlara Valley dates from the late 9th century. It takes its name from its Last Judgement "
        "fresco showing sinners punished by snakes, a scene with details rarely seen in Byzantine art.\n\n"
        "To reach it, walk a little towards Selime after descending the main stairs, cross the bridge to the opposite bank "
        "and climb a short flight of steps. Do not use flash in the dim interior that protects the frescoes. It is one of "
        "the most visited churches in the valley."),

    "aciksaray": (1,
        "Gülşehir yakınlarındaki Açıksaray, kayalara oyulmuş, saray cephesini andıran yapılardan oluşan bir ören "
        "yeridir. 9-11. yüzyıllara tarihlenen yapıların bir manastır, bir konaklama yeri ya da büyük bir çiftlik "
        "yerleşimi olduğu düşünülür.\n\n"
        "Kemerli ve sütun süslemeli cepheler, avlular ve mantar biçimli ünlü peribacası alanın en dikkat çekici "
        "bölümleridir. Göreme'deki kalabalıktan uzak, rahat gezilebilen bir açık hava müzesidir. Gülşehir'deki Karşı "
        "Kilise ile birlikte yarım gün ayırın.",
        "Near Gülşehir, Açıksaray is a site of rock-cut buildings whose façades resemble palaces. Dated to the 9th-11th "
        "centuries, the buildings are thought to have been a monastery, a lodging place or a large farming settlement.\n\n"
        "Arched façades decorated with carved columns, courtyards and a famous mushroom-shaped fairy chimney are the most "
        "striking parts of the site. It is an open-air museum that is easy to explore, away from the crowds of Göreme. "
        "Set aside half a day for it together with Karşı Kilise in Gülşehir."),

    "aziz-yuhanna-vaftizci-kilisesi-cavusin": (1,
        "Çavuşin'in eski köyünün bulunduğu kayalığın tepesine oyulmuş Vaftizci Yahya Kilisesi, Kapadokya'nın bilinen en "
        "eski ve en büyük kaya kiliselerinden biridir. Kökeninin 5. yüzyıla kadar uzandığı düşünülür ve uzun süre önemli "
        "bir hac yeri olmuştur.\n\n"
        "Kilisenin ön cephesi kaya düşmeleriyle büyük ölçüde yıkılmış, fresklerin çoğu solmuştur; yine de bazilika "
        "planı ve büyüklüğü etkileyicidir. Kiliseye eski köyün içinden dik bir patikayla tırmanılır; yukarıdan Çavuşin "
        "ve Gül Vadisi'nin manzarası görülür. Kayalık zeminde dikkatli olun.",
        "Carved near the top of the cliff where Çavuşin's old village stands, the Church of St John the Baptist is one of "
        "the oldest and largest known rock churches in Cappadocia. Its origins are thought to go back to the 5th century, "
        "and it was long an important place of pilgrimage.\n\n"
        "Its front has largely collapsed in rockfalls and most of its frescoes have faded, yet its basilica plan and size "
        "remain impressive. You reach it by a steep path through the old village, with views over Çavuşin and the Rose "
        "Valley from above. Take care on the rocky ground."),

    "keslik-manastiri": (1,
        "Mustafapaşa ile Cemil köyü arasındaki Keşlik Manastırı, kayaya oyulmuş kiliseler, yemekhane ve keşiş "
        "hücrelerinden oluşan bir yapı topluluğudur. Bizans döneminde bölgedeki manastır yaşamının iyi bir örneğidir.\n\n"
        "Ana kilisenin duvarlarındaki fresklerin bir kısmı, sonraki yüzyıllarda burada yakılan ateşlerin isiyle "
        "kararmıştır; görevli genellikle fenerle ayrıntıları gösterir. Bahçesi ve sakin çevresiyle Mustafapaşa ve "
        "Soğanlı yönündeki bir gezide kısa bir durak olarak uygundur.",
        "Between Mustafapaşa and the village of Cemil, Keşlik Monastery is a group of rock-cut churches, a refectory and "
        "monks' cells. It is a good example of monastic life in the region in the Byzantine period.\n\n"
        "Some of the frescoes on the walls of the main church have been blackened by the smoke of fires lit here in later "
        "centuries; the attendant usually shows the details with a torch. With its garden and quiet setting, it makes a "
        "short stop on a trip towards Mustafapaşa and Soğanlı."),

    "tokali-kilise": (1,
        "Göreme Açık Hava Müzesi'nin girişindeki Tokalı Kilise, bölgenin en büyük ve en zengin süslü kaya kilisesidir. "
        "10. yüzyılda iki aşamada yapıldı: önce Eski Tokalı olarak bilinen tek nefli kilise, ardından ona eklenen "
        "geniş Yeni Tokalı.\n\n"
        "Yeni Tokalı'daki derin lacivert zemin üzerine yapılmış freskler, İsa'nın hayatını ve azizlerin hikâyelerini "
        "anlatır; Kapadokya resim sanatının doruk noktası sayılır. Kilise ana müze alanının hemen dışında, yolun "
        "karşısında kalır; aynı biletle girildiği için atlamayın.",
        "At the entrance to the Göreme Open-Air Museum, Tokalı Kilise (the Church of the Buckle) is the largest and most "
        "richly decorated rock church in the region. It was built in two phases in the 10th century: first the "
        "single-nave church known as the Old Tokalı, then the spacious New Tokalı added to it.\n\n"
        "The frescoes of the New Tokalı, painted on a deep blue ground, tell the life of Christ and the stories of saints "
        "and are considered the high point of Cappadocian painting. The church lies just outside the main museum area, "
        "across the road; it is included in the same ticket, so do not miss it."),

    "selime-katedrali": (1,
        "Ihlara Vadisi'nin kuzey ucunda, Selime köyünün üzerindeki kayalıklara oyulmuş Selime Katedrali, Kapadokya'nın "
        "en büyük kaya manastırlarından biridir. Kilise, mutfak, ahır, odalar ve avlulardan oluşan yapı topluluğu, "
        "Bizans döneminde önemli bir dini ve idari merkez olduğunu düşündürür.\n\n"
        "Katedral olarak anılan büyük kilisenin sütunlu iç mekânı, mutfaktaki yüksek baca ve tünellerle birbirine "
        "bağlanan odalar gezilebilir. Yamaca tırmanış dik ve kayalıktır; rahat ayakkabı giyin. Köydeki Selime Sultan "
        "Türbesi ve Ihlara yürüyüşünün bitiş noktası hemen aşağıdadır.",
        "At the northern end of the Ihlara Valley, carved into the cliffs above the village of Selime, Selime Cathedral "
        "is one of the largest rock monasteries in Cappadocia. The complex of church, kitchen, stables, rooms and "
        "courtyards suggests it was an important religious and administrative centre in the Byzantine period.\n\n"
        "You can explore the columned interior of the large church known as the cathedral, the tall chimney in the "
        "kitchen and rooms linked by tunnels. The climb up the slope is steep and rocky; wear comfortable shoes. The "
        "Selime Sultan Tomb in the village and the end point of the Ihlara walk are just below."),

    "sumbullu-kilise": (1,
        "Ihlara Vadisi'ndeki Sümbüllü Kilise, kaya kütlesine iki kat halinde oyulmuş bir manastır kilisesidir. Vadinin "
        "en dikkat çekici cephelerinden birine sahiptir; kemerli nişler ve süslemeler kayaya ustaca işlenmiştir.\n\n"
        "İçerideki fresklerde Başmelekler Mikail ve Cebrail arasında Meryem, İsa, fırına atılan üç İbrani genç ve "
        "azizler tasvir edilir. Vadinin ana merdivenlerine yakın, kısa bir tırmanışla ulaşılır. Cephesini görmek için "
        "biraz geri çekilip bakın.",
        "The Jacinth Church in the Ihlara Valley is a monastery church carved into the rock on two levels. It has one of "
        "the most striking façades in the valley, with arched niches and decoration skilfully worked into the rock.\n\n"
        "The frescoes inside show Mary between the Archangels Michael and Gabriel, Christ, the three Hebrew youths in the "
        "furnace, and saints. It is close to the valley's main stairs, reached by a short climb. Step back a little to "
        "take in its façade."),

    "purenli-seki-kilisesi": (1,
        "Ihlara Vadisi'ndeki Pürenli Seki Kilisesi, kayaya oyulmuş dört bölümden oluşur. Fresklerinin 10. yüzyılın "
        "başlarından 12. yüzyıla kadar farklı dönemlerde yapıldığı düşünülür; narteksin zemininde mezarlar bulunur.\n\n"
        "Peygamberlerin kehanetleri, Meryem ve İsa'nın hayatından sahneler en iyi korunmuş resimlerdendir. Kilise, "
        "vadinin yamacında, yürüyüş yolundan biraz yukarıda kalır; kısa ama dik bir tırmanış gerekir. Kalabalıktan "
        "uzak, sakin bir duraktır.",
        "The Pürenli Seki Church in the Ihlara Valley consists of four rock-cut sections. Its frescoes are thought to "
        "have been painted at different times between the early 10th and the 12th centuries, and there are graves in the "
        "floor of the narthex.\n\n"
        "The prophecies of the prophets and scenes from the lives of Mary and Christ are among the best-preserved "
        "paintings. The church sits on the valley slope a little above the walking path, reached by a short but steep "
        "climb. It is a quiet stop away from the crowds."),

    "azize-barbara-kilisesi": (1,
        "Göreme Açık Hava Müzesi'ndeki Azize Barbara Kilisesi, 11. yüzyıla tarihlenen küçük bir kaya kilisesidir ve "
        "adını duvarında tasvir edilen Azize Barbara'dan alır.\n\n"
        "Duvarları ve tavanı kaplayan, doğrudan kayaya kırmızı aşı boyasıyla yapılmış geometrik desenler ve sembolik "
        "figürler en ilgi çekici yanıdır; bazı figürlerin anlamı hâlâ tartışılır. Müze alanının içinde, Elmalı ve "
        "Yılanlı kiliselerine yakındır.",
        "The Church of St Barbara in the Göreme Open-Air Museum is a small 11th-century rock church named after St "
        "Barbara, who is depicted on its wall.\n\n"
        "Its most interesting feature is the geometric patterns and symbolic figures painted in red ochre directly onto "
        "the rock across the walls and ceiling; the meaning of some figures is still debated. It is inside the museum "
        "area, close to the Apple and Snake churches."),

    "azize-catherine-sapeli": (1,
        "Göreme Açık Hava Müzesi'ndeki Azize Catherine Şapeli, İskenderiyeli Azize Katerina'ya adanmış küçük bir kaya "
        "şapelidir. Müze alanındaki diğer şapeller gibi Bizans döneminde, manastır topluluğunun ibadet ve anma yeri "
        "olarak oyuldu.\n\n"
        "Duvarlarında aziz tasvirleri ve süsleme kalıntıları görülebilir. Küçük olduğu için içeri girmek için sıra "
        "beklemek gerekebilir. Karanlık Kilise ve Çarıklı Kilise'ye giden yolun üzerindedir.",
        "The Chapel of St Catherine in the Göreme Open-Air Museum is a small rock chapel dedicated to St Catherine of "
        "Alexandria. Like the other chapels on the site, it was carved in the Byzantine period as a place of worship and "
        "commemoration for the monastic community.\n\n"
        "Depictions of saints and remains of decoration can be seen on its walls. As it is small, you may have to queue to "
        "go in. It lies on the path to the Dark Church and the Church with Sandals."),

    "basil-sapeli": (1,
        "Göreme Açık Hava Müzesi'nin girişine yakın Aziz Basil Şapeli, Kapadokyalı kilise babalarından Kayserili Aziz "
        "Basil'e adanmıştır. Bölgenin manastır yaşamını düzenleyen kurallar büyük ölçüde onun öğretilerine dayanır.\n\n"
        "Şapelin narteksinde mezarlar, duvarlarında Aziz Basil, Aziz Georgios ve Aziz Theodoros tasvirleri bulunur. "
        "Müzeye girdikten sonra ilk görülecek yapılardandır; kısa bir ziyaret yeterlidir.",
        "Near the entrance of the Göreme Open-Air Museum, the Chapel of St Basil is dedicated to St Basil of Caesarea, one "
        "of the Cappadocian Church Fathers. The rules that shaped monastic life in the region rest largely on his "
        "teachings.\n\n"
        "There are graves in the chapel's narthex, and depictions of St Basil, St George and St Theodore on its walls. It "
        "is one of the first buildings you see after entering the museum; a short visit is enough."),

    "elmali-kilise": (1,
        "Göreme Açık Hava Müzesi'ndeki Elmalı Kilise, 11. yüzyıla tarihlenen, dört sütunlu ve kubbeli bir kaya "
        "kilisesidir. Adının, kilisenin önünde bir zamanlar bulunan elma ağacından ya da Başmelek Cebrail'in elinde "
        "tuttuğu küreden geldiği anlatılır.\n\n"
        "Kubbedeki Pantokrator İsa ve duvarları kaplayan İncil sahneleri, müzenin en güzel fresk dizilerindendir. "
        "İçerisi küçük ve kalabalık olabilir; sırayı beklerken çevredeki peribacalarına oyulmuş hücrelere bakın.",
        "The Apple Church in the Göreme Open-Air Museum is an 11th-century rock church with four columns and domes. Its "
        "name is said to come either from an apple tree that once stood in front of it or from the orb held by the "
        "Archangel Gabriel.\n\n"
        "Christ Pantocrator in the dome and the Gospel scenes covering the walls make up one of the finest fresco cycles "
        "in the museum. The interior is small and can get crowded; while you wait, look at the cells carved into the "
        "fairy chimneys around it."),

    "pantokrator-kilisesi": (1,
        "Göreme Açık Hava Müzesi'ndeki bu küçük kilise, adını Bizans sanatının en önemli tasvirlerinden olan "
        "Pantokrator İsa'dan, yani 'Her Şeyin Hâkimi' olarak resmedilen İsa'dan alır.\n\n"
        "Müze alanındaki kayaya oyulmuş yapıların çoğu gibi bir manastır topluluğunun parçasıydı. Ana gezi yolunun "
        "üzerinde, diğer kiliselerle birlikte kısa bir durak olarak görülebilir; fresklere dokunmayın ve flaş "
        "kullanmayın.",
        "This small church in the Göreme Open-Air Museum takes its name from Christ Pantocrator, 'the Ruler of All', one "
        "of the most important images in Byzantine art.\n\n"
        "Like most of the rock-cut buildings on the site, it was part of a monastic community. It lies on the main route "
        "and can be seen as a short stop together with the other churches; do not touch the frescoes or use flash."),

    "yilanli-kilise": (1,
        "Göreme Açık Hava Müzesi'ndeki Yılanlı Kilise, uzun ve tonozlu tek bir salondan oluşur. Adını, Aziz Georgios ve "
        "Aziz Theodoros'un bir yılanı (ejderhayı) öldürdüğü freskten alır.\n\n"
        "Freskler arasında İmparator Konstantin ile annesi Helena'nın Kutsal Haç'ı tutan tasviri ve uzun beyaz sakallı "
        "keşiş Onuphrios'un figürü de dikkat çeker. Resimler daha sade bir üslupla yapılmıştır; Karanlık ve Elmalı "
        "kiliselerle karşılaştırınca farkı görebilirsiniz.",
        "The Snake Church in the Göreme Open-Air Museum consists of a single long, vaulted hall. It takes its name from "
        "the fresco of St George and St Theodore killing a snake (dragon).\n\n"
        "Among the frescoes, the Emperor Constantine and his mother Helena holding the True Cross and the figure of the "
        "long-bearded hermit Onuphrius also stand out. The paintings are in a simpler style; compare them with the Dark "
        "and Apple churches to see the difference."),

    "carikli-kilise": (1,
        "Göreme Açık Hava Müzesi'ndeki Çarıklı Kilise, 11. yüzyıla tarihlenen, dört sütunlu bir kaya kilisesidir. "
        "Adını, İsa'nın Göğe Yükselişi sahnesinin altında zemindeki ayak izi biçimli oyuklardan alır.\n\n"
        "Kubbe ve duvarları kaplayan freskler, Karanlık ve Elmalı kiliselerdekilere benzer bir üslupla yapılmıştır. "
        "Kiliseye kısa bir metal merdivenle çıkılır; müze alanının yukarı kesiminde, Karanlık Kilise'nin yakınındadır.",
        "The Church with Sandals in the Göreme Open-Air Museum is an 11th-century rock church with four columns. It takes "
        "its name from the footprint-shaped hollows in the floor beneath the scene of Christ's Ascension.\n\n"
        "The frescoes covering its domes and walls are in a style similar to those of the Dark and Apple churches. You "
        "climb up to it by a short metal staircase; it is in the upper part of the museum area, near the Dark Church."),

    "haci-bektas-i-veli-turbesi": (2,
        "Hacıbektaş ilçesindeki Hacı Bektaş Veli Külliyesi, 13. yüzyılda yaşamış Anadolu erenlerinden Hacı Bektaş "
        "Veli'nin türbesi ve dergâhıdır. Alevi ve Bektaşi inancının en önemli merkezidir ve 16 Ağustos 1964'ten beri "
        "müze olarak ziyarete açıktır.\n\n"
        "Avlulardan geçerek Aslanlı Çeşme, Üçler Sofası, Kırklar Meydanı ve türbeye ulaşılır; dergâh yaşamını anlatan "
        "eşyalar, el yazmaları ve giysiler sergilenir. Her yıl ağustosun ortasında düzenlenen anma törenlerinde ilçe "
        "çok kalabalık olur. Kutsal bir mekân olduğu için saygılı davranın ve uygun giyinin.",
        "The Haji Bektash Veli Complex in the town of Hacıbektaş is the tomb and lodge of Haji Bektash Veli, an Anatolian "
        "mystic of the 13th century. It is the most important centre of the Alevi and Bektashi faith and has been open "
        "as a museum since 16 August 1964.\n\n"
        "Passing through its courtyards you reach the Lion Fountain, the Hall of the Three, the Square of the Forty and the "
        "tomb itself, with objects, manuscripts and garments describing life in the lodge on display. The town gets very "
        "crowded during the commemorations held every year in mid-August. As it is a sacred place, be respectful and "
        "dress appropriately."),

    "goreme-deki-kiliseler-listesi": (2,
        "Göreme Açık Hava Müzesi, kayalara oyulmuş kiliseler, şapeller, yemekhaneler ve keşiş hücrelerinden oluşan bir "
        "manastır yerleşimidir. Kiliselerin çoğu 10-12. yüzyıllarda freskleriyle süslendi. 1985'te UNESCO Dünya Mirası "
        "Listesi'ne alınan 'Göreme Millî Parkı ve Kapadokya Kayalık Alanları'nın en ünlü bölümüdür.\n\n"
        "Karanlık Kilise (ayrı bilet), Elmalı, Yılanlı, Çarıklı ve girişin karşısındaki Tokalı Kilise en önemli "
        "duraklardır. Gün ortasında tur otobüsleriyle çok kalabalık olur; açılışta ya da akşamüstü gidin. İçlerde "
        "fotoğraf kurallarına uyun ve fresklere dokunmayın. İçindeki yapılar ayrıca işaretlenebilir.",
        "The Göreme Open-Air Museum is a monastic settlement of churches, chapels, refectories and monks' cells carved "
        "into the rock. Most of its churches were decorated with frescoes in the 10th-12th centuries. It is the most "
        "famous part of 'Göreme National Park and the Rock Sites of Cappadocia', added to the UNESCO World Heritage List "
        "in 1985.\n\n"
        "The Dark Church (separate ticket), the Apple, Snake and Sandals churches and the Tokalı Church across from the "
        "entrance are the main stops. It gets very crowded with tour buses in the middle of the day; go at opening time "
        "or in the late afternoon. Follow the photo rules inside and do not touch the frescoes. The buildings inside can "
        "be checked off separately."),

    "nevsehir-muzesi": (2,
        "Nevşehir Müzesi, 1987'de kurulan bir arkeoloji ve etnografya müzesidir. Kapadokya bölgesinde yapılan kazılardan "
        "ve araştırmalardan çıkan, tarih öncesinden Bizans ve Osmanlı dönemlerine uzanan eserleri sergiler.\n\n"
        "Pişmiş toprak kaplar, heykelcikler, sikkeler ve takıların yanında etnografya bölümünde yöreye özgü giysiler, "
        "halılar ve ev eşyaları yer alır. Kapadokya'yı gezmeye başlamadan önce bölgenin tarihini toplu olarak görmek "
        "için iyi bir duraktır.",
        "The Nevşehir Museum, founded in 1987, is an archaeology and ethnography museum. It displays finds from "
        "excavations and surveys in the Cappadocia region, ranging from prehistory to the Byzantine and Ottoman periods.\n\n"
        "Alongside pottery, figurines, coins and jewellery, the ethnography section shows local costumes, carpets and "
        "household objects. It is a good stop for an overview of the region's history before you start exploring "
        "Cappadocia."),

    "guray-muze": (2,
        "Avanos'taki Güray Müze, kayaların oyulmasıyla yerin altında oluşturulmuş galerilerde seramik sergileyen bir "
        "müzedir. Avanos'un Kızılırmak'ın kızıl kilinden beslenen yüzyıllık çömlekçilik geleneğini yaşatmak amacıyla "
        "kuruldu.\n\n"
        "Antik dönemlerden kalma seramik örneklerinin yanında, çağdaş sanatçıların eserleri de serin yeraltı "
        "galerilerinde sergilenir. Avanos'taki çömlek atölyelerinden birinde çamurla çalışmayı denemek, müze "
        "ziyaretini tamamlar. Kasaba merkezine ve Kızılırmak kıyısına yakındır.",
        "The Güray Museum in Avanos displays ceramics in galleries carved out of the rock underground. It was founded to "
        "keep alive Avanos's centuries-old pottery tradition, fed by the red clay of the Kızılırmak River.\n\n"
        "Ancient ceramics are shown alongside works by contemporary artists in the cool underground galleries. Trying your "
        "hand at clay in one of Avanos's pottery workshops completes the visit. It is close to the town centre and the "
        "banks of the Kızılırmak."),

    "zelve-acik-hava-muzesi": (2,
        "Avanos'a yaklaşık 5 km, Paşabağları'na 1 km uzaklıktaki Zelve, Aktepe'nin kuzey yamaçlarına yayılan üç vadiden "
        "oluşur. Kayalara oyulmuş evler, kiliseler, manastırlar, bir değirmen ve tünellerle dolu bu yerleşimde 1950'lere "
        "kadar insanlar yaşadı; erozyon tehlikesi nedeniyle köy yakındaki yeni yerleşime taşındı.\n\n"
        "Bugün açık hava müzesi olarak gezilen vadilerde patikalarla dolaşıp kaya evlere, dik merdivenlere ve "
        "tünellere girebilirsiniz. Göreme'ye göre daha sakindir ve gezmek birkaç saat sürer. Bazı bölümler çökme riski "
        "nedeniyle kapalı olabilir; işaretlere uyun.",
        "About 5 km from Avanos and 1 km from Paşabağları, Zelve consists of three valleys spreading over the northern "
        "slopes of Aktepe. People lived in this settlement full of rock-cut houses, churches, monasteries, a mill and "
        "tunnels until the 1950s, when the village was moved to a new site nearby because of the danger of erosion.\n\n"
        "In the valleys, now visited as an open-air museum, you can follow paths and enter cave houses, steep stairways "
        "and tunnels. It is quieter than Göreme and takes a few hours to explore. Some sections may be closed because of "
        "the risk of collapse; follow the signs."),

    "nevsehir-kalesi": (2,
        "Nevşehir'in en yüksek tepesindeki kale, Selçuklu döneminde, 12. yüzyılda kervan yolunu korumak için yapıldığı "
        "düşünülen bir yapıdır. Kale, altında yer alan ve son yıllarda ortaya çıkarılan büyük yeraltı şehrinin "
        "(Kayaşehir) üzerinde yükselir.\n\n"
        "Surların bir bölümü ayaktadır; tepeden Nevşehir'in, Erciyes ve Hasan dağlarının geniş manzarası görülür. "
        "Kalenin çevresindeki tarihi mahallelerde Damat İbrahim Paşa Külliyesi gibi Osmanlı yapıları da gezilebilir.",
        "The castle on the highest hill of Nevşehir is thought to have been built in the Seljuk period, in the 12th "
        "century, to protect the caravan route. It rises above a large underground city (Kayaşehir) uncovered beneath it "
        "in recent years.\n\n"
        "Part of the walls still stands, and the hilltop offers a wide view of Nevşehir and of Mount Erciyes and Mount "
        "Hasan. In the historic neighbourhoods around the castle you can also visit Ottoman buildings such as the Damat "
        "İbrahim Pasha Complex."),

    "ortahisar-kalesi": (2,
        "Ortahisar Kalesi, kasabanın ortasında yükselen, içi odalar, tüneller ve merdivenlerle oyulmuş dev bir kaya "
        "kütlesidir. Bizans döneminde bir savunma ve barınma yeri olarak kullanıldı; adını bölgedeki diğer kaya "
        "kalelerinin ortasında olmasından aldığı anlatılır.\n\n"
        "İçerideki merdivenlerle tepeye çıkılabilir; yukarıdan Ortahisar'ın taş evleri, vadiler ve uzakta Erciyes Dağı "
        "görülür. Ortahisar, kayalara oyulmuş serin depolarında limon ve patates saklanmasıyla da bilinir. Merdivenler "
        "dik ve dar olduğundan dikkatli olun.",
        "Ortahisar Castle is a huge rock mass rising in the middle of the town, hollowed out with rooms, tunnels and "
        "stairs. It was used in the Byzantine period as a place of defence and shelter; its name is said to come from its "
        "position in the middle of the region's other rock castles.\n\n"
        "Stairs inside lead to the top, from where you see Ortahisar's stone houses, the valleys and Mount Erciyes in the "
        "distance. Ortahisar is also known for storing lemons and potatoes in cool stores carved into the rock. The stairs "
        "are steep and narrow, so take care."),

    "uchisar-kalesi": (2,
        "Uçhisar Kalesi, Kapadokya'nın en yüksek noktalarından birinde yükselen, içi yüzlerce odayla oyulmuş dev bir "
        "kaya kütlesidir. Tarih boyunca hem savunma hem barınma yeri olarak kullanıldı; bugün bölgenin simgelerinden "
        "biridir.\n\n"
        "Zirveye çıkan basamaklardan Göreme, Güvercinlik Vadisi ve açık havada Erciyes Dağı'na uzanan geniş bir "
        "manzara açılır; gün batımı en güzel zamanıdır. Kalenin eteğindeki taş evler ve otellerin arasında dolaşmak "
        "da keyiflidir. Tepede rüzgâr sert olabilir, akşamları bir hırka alın.",
        "Uçhisar Castle is a huge rock mass rising at one of the highest points in Cappadocia, honeycombed with hundreds "
        "of rooms. Used through history for both defence and shelter, it is today one of the symbols of the region.\n\n"
        "The steps to the summit open up a wide view over Göreme, Pigeon Valley and, on clear days, Mount Erciyes; sunset "
        "is the best time. Wandering among the stone houses and hotels at its foot is pleasant too. The wind on top can "
        "be strong, so bring a jumper in the evening."),

    "cavusin-kalesi": (2,
        "Çavuşin'deki kale, eski köyün yerleştiği ve yüzlerce kaya oyma evle delik deşik olmuş yüksek kayalıktır. Köy, "
        "20. yüzyılın ortasındaki kaya düşmelerinden sonra büyük ölçüde terk edildi ve halk aşağıdaki yeni yerleşime "
        "taşındı.\n\n"
        "Kayalığın eteğinden başlayan patikayla oyma evlerin arasından tırmanıp tepeye yakın Vaftizci Yahya "
        "Kilisesi'ne ulaşabilirsiniz. Yukarıdan Gül Vadisi ve Çavuşin'in manzarası görülür. Zemin kayalık ve dik "
        "olduğundan rahat ayakkabı giyin ve yıkılmaya yüz tutmuş bölümlere girmeyin.",
        "The 'castle' at Çavuşin is the tall cliff where the old village stood, riddled with hundreds of rock-cut houses. "
        "After rockfalls in the mid-20th century the village was largely abandoned and its people moved to the new "
        "settlement below.\n\n"
        "A path from the foot of the cliff climbs among the cave houses to the Church of St John the Baptist near the "
        "top, with views over the Rose Valley and Çavuşin. The ground is rocky and steep, so wear comfortable shoes and "
        "stay out of crumbling sections."),

    "sarihan-kervansarayi": (2,
        "Avanos'un yaklaşık 5 km güneydoğusundaki Sarıhan, Aksaray ile Kayseri arasındaki kervan yolu üzerinde, 13. "
        "yüzyılda Selçuklular tarafından yapılan bir kervansaraydır. Adını, yapımında kullanılan sarımsı taştan alır.\n\n"
        "Taş işçiliğiyle süslü anıtsal kapısı, avlusu ve kapalı kışlık bölümü restorasyonla korunmuştur. Akşamları "
        "kervansarayda Mevlevi sema gösterileri düzenlenir; izlemek isterseniz önceden bilgi alın. Avanos ile Ürgüp "
        "arasındaki yol üzerindedir.",
        "About 5 km south-east of Avanos, Sarıhan is a caravanserai built by the Seljuks in the 13th century on the "
        "caravan route between Aksaray and Kayseri. It takes its name from the yellowish stone used in its construction.\n\n"
        "Its monumental gateway decorated with carved stonework, its courtyard and its covered winter hall have been "
        "preserved through restoration. In the evenings, Mevlevi whirling ceremonies (sema) are held in the caravanserai; "
        "ask in advance if you would like to watch. It lies on the road between Avanos and Ürgüp."),

    "bahattin-in-samanligi-kilise": (2,
        "Ihlara Vadisi'nde, Belisırma köyü yakınlarındaki bu kaya kilisesi, adını onu uzun süre samanlık olarak "
        "kullanan köylü Bahattin'den alır. Bizans döneminde fresklerle süslenen kilise, sonraki yüzyıllarda gündelik "
        "işlerde kullanıldı.\n\n"
        "İçerideki freskler İsa'nın hayatından sahneleri anlatır; bazı bölümleri zarar görmüş olsa da renkleri hâlâ "
        "seçilebilir. Ihlara yürüyüşünün orta kesiminde, Belisırma'daki dere kenarı restoranlarına yakındır; vadide "
        "mola vermeden önce kısa bir durak olarak görülebilir.",
        "Near the village of Belisırma in the Ihlara Valley, this rock church takes its name from Bahattin, a villager "
        "who used it for a long time as a hay barn. Decorated with frescoes in the Byzantine period, the church was put "
        "to everyday uses in later centuries.\n\n"
        "The frescoes inside tell scenes from the life of Christ; though some parts are damaged, their colours can still "
        "be made out. It is in the middle section of the Ihlara walk, close to the streamside restaurants of Belisırma, "
        "and makes a short stop before taking a break in the valley."),

    "derinkuyu-yeralti-sehri": (2,
        "Nevşehir'e yaklaşık 30 km uzaklıktaki Derinkuyu Yeraltı Şehri, Kapadokya'nın bilinen en derin yeraltı "
        "şehridir. Yumuşak volkanik kayaya kat kat oyulan şehir, tehlike anlarında binlerce insanın hayvanlarıyla "
        "birlikte sığınabileceği büyüklüktedir. 1963'te bir ev yenilenirken yeniden bulundu.\n\n"
        "Gezilebilen katlarda ahırlar, mutfaklar, şarap işlikleri, bir kilise, havalandırma bacaları ve geçitleri kapatan "
        "dev yuvarlak taş kapılar görülür. Tüneller dar ve basıktır; kapalı alan korkusu olanlar dikkatli olmalıdır. "
        "Aşağısı serin olduğundan yazın bile ince bir hırka alın.",
        "About 30 km from Nevşehir, Derinkuyu Underground City is the deepest known underground city in Cappadocia. "
        "Carved level by level into the soft volcanic rock, it was large enough to shelter thousands of people with their "
        "animals in times of danger. It was rediscovered in 1963 during the renovation of a house.\n\n"
        "On the levels open to visitors you see stables, kitchens, wine presses, a church, ventilation shafts and huge "
        "round stone doors that sealed the passages. The tunnels are narrow and low; people with claustrophobia should "
        "be careful. It is cool down below, so bring a light jumper even in summer."),

    "kaymakli": (2,
        "Kaymaklı Yeraltı Şehri, Nevşehir-Niğde yolu üzerindeki Kaymaklı beldesinin altında yer alır ve 1960'lardan beri "
        "ziyarete açıktır. Derinkuyu kadar derin değildir ama daha geniş bir alana yayılır; birbirine dar tünellerle "
        "bağlanan çok sayıda oda ve geçitten oluşur.\n\n"
        "Gezilebilen katlarda depolar, mutfaklar, şarap işlikleri, bir şapel ve geçitleri kapatan taş kapılar görülür. "
        "Bazı tünellerde eğilerek ilerlemek gerekir. Kasabadaki evlerin bir kısmının bodrumları hâlâ yeraltı şehrine "
        "açılır. Derinkuyu ile aynı gün gezilebilir.",
        "Kaymaklı Underground City lies beneath the town of Kaymaklı on the Nevşehir-Niğde road and has been open to "
        "visitors since the 1960s. It is not as deep as Derinkuyu but spreads over a wider area, made up of many rooms and "
        "passages linked by narrow tunnels.\n\n"
        "On the levels open to visitors you see storerooms, kitchens, wine presses, a chapel and stone doors that sealed "
        "the passages. In some tunnels you have to bend down. The cellars of some houses in the town still open into the "
        "underground city. It can be visited on the same day as Derinkuyu."),

    "ozkonak": (2,
        "Avanos'a yaklaşık 17 km uzaklıktaki Özkonak Yeraltı Şehri, 1970'lerde yerel halkın fark etmesiyle ortaya "
        "çıkarıldı. Bir tepenin içine oyulmuş, birbirine tünellerle bağlanan katlardan oluşur.\n\n"
        "Geçitleri kapatan taş kapıların yanında, üst katlardan saldırganlara karşı kullanılmış olabilecek delikler "
        "ilgi çekicidir. Derinkuyu ve Kaymaklı'ya göre daha az kalabalıktır; yeraltı şehirlerini sakin bir ortamda "
        "görmek isteyenler için uygundur. Tüneller dar ve basıktır.",
        "About 17 km from Avanos, Özkonak Underground City was uncovered in the 1970s after local people noticed it. It "
        "consists of levels carved into a hill and linked by tunnels.\n\n"
        "Besides the stone doors that sealed the passages, holes that may have been used against attackers from the upper "
        "levels are intriguing. It is less crowded than Derinkuyu and Kaymaklı, suiting those who want to see an "
        "underground city in a calm setting. The tunnels are narrow and low."),

    "mazi-yeralti-sehri": (2,
        "Ürgüp'e yaklaşık 18 km, Kaymaklı'ya 10 km uzaklıktaki Mazı köyündeki yeraltı şehrinin girişleri, köyün "
        "kenarındaki kayalık yamaçlara açılır. Bölgenin diğer yeraltı şehirleri gibi tehlike anlarında sığınak olarak "
        "kullanıldı.\n\n"
        "İçeride ahırlar, depolar, bir şarap işliği ve şapel ile geçitleri kapatan taş kapılar görülür. Daha az bilinen "
        "bir yer olduğu için sessizdir; ziyaret saatlerini önceden kontrol edin. Köydeki kaya mezarlar ve vadiyle "
        "birlikte gezilebilir.",
        "About 18 km from Ürgüp and 10 km from Kaymaklı, the underground city at the village of Mazı has its entrances in "
        "the rocky slopes at the edge of the village. Like the region's other underground cities, it was used as a refuge "
        "in times of danger.\n\n"
        "Inside are stables, storerooms, a wine press and a chapel, along with stone doors that sealed the passages. Being "
        "less well known, it is quiet; check visiting hours in advance. It can be visited together with the village's "
        "rock tombs and valley."),

    "sobesos-antik-kenti": (2,
        "Ürgüp'e yaklaşık 23 km uzaklıktaki Şahinefendi köyünde yer alan Sobesos, çevredeki kalıntıların tesadüfen fark "
        "edilmesiyle bulundu; kazılar 2000'lerin başında başladı. Roma ve erken Bizans dönemlerine ait bir yerleşimdir.\n\n"
        "Koruyucu bir çatı altında sergilenen, renkli mozaik döşemeli Roma hamamı ve sonradan eklenen şapel alanın en "
        "önemli bölümleridir. Kalabalıktan uzak, sakin bir arkeolojik alandır; Mustafapaşa ya da Soğanlı yönündeki bir "
        "geziye eklenebilir.",
        "Sobesos, at the village of Şahinefendi about 23 km from Ürgüp, was discovered when remains in the area were "
        "noticed by chance; excavations began in the early 2000s. It is a settlement of the Roman and early Byzantine "
        "periods.\n\n"
        "The Roman bath with colourful mosaic floors, displayed under a protective roof, and the chapel added later are "
        "the most important parts of the site. It is a quiet archaeological site away from the crowds and can be added to "
        "a trip towards Mustafapaşa or Soğanlı."),

    "mutfak-ve-kiler": (2,
        "Göreme Açık Hava Müzesi'ndeki mutfak ve kiler, manastır topluluğunun gündelik yaşamına ait bölümlerdir. Kayaya "
        "oyulmuş yemekhanede, keşişlerin birlikte yemek yediği uzun bir taş masa ve sıralar bulunur; yanındaki mutfakta "
        "ocak ve depolama oyukları görülür.\n\n"
        "Kiliselerin fresklerinden sonra burası, manastırda yaşamın nasıl düzenlendiğini anlamak için iyi bir duraktır. "
        "Müze alanının ana yolu üzerindedir; kalabalık kiliselerin önündeki sırayı beklerken kısa bir göz atabilirsiniz.",
        "The kitchen and storerooms in the Göreme Open-Air Museum belonged to the daily life of the monastic community. "
        "In the rock-cut refectory there is a long stone table with benches where the monks ate together, and in the "
        "kitchen next to it you can see the hearth and storage niches.\n\n"
        "After the frescoes of the churches, this is a good stop for understanding how life was organised in the "
        "monastery. It is on the main path of the museum, so you can take a quick look while waiting to enter the "
        "crowded churches."),

    "altikapi-turbesi": (2,
        "Ürgüp'teki Altıkapı Türbesi, Selçuklu dönemine ait bir türbedir. Adını, yapının kenarlarına açılan kemerli "
        "açıklıklardan alır.\n\n"
        "Kasabanın üzerindeki tepelerden birinde yer alır; buradan Ürgüp'ün peribacaları arasındaki eski evlerine ve "
        "çevredeki vadilere bakılabilir. Temenni Tepe ve kasaba merkeziyle birlikte kısa bir yürüyüşe eklenebilir.",
        "The Altıkapı (Six Doors) Tomb in Ürgüp is a tomb from the Seljuk period. It takes its name from the arched "
        "openings around the sides of the building.\n\n"
        "It stands on one of the hills above the town, from where you can look over Ürgüp's old houses among the fairy "
        "chimneys and the surrounding valleys. It can be added to a short walk with Temenni Hill and the town centre."),

    "mustafapasa": (2,
        "Ürgüp'e bağlı Mustafapaşa, eski adıyla Sinasos, 19. yüzyılda zengin Rum tüccarların yaptırdığı, cepheleri taş "
        "oymalarla süslü konaklarıyla tanınır. 1923 nüfus mübadelesinden sonra Rum halk Yunanistan'a göç etti; "
        "kasaba 1980'lerde turizme açıldı.\n\n"
        "Sokaklarda dolaşırken asma dalları ve meleklerle süslü kapılara, Konstantin-Helena Kilisesi'ne ve medreseye "
        "bakın; konakların bir kısmı bugün butik otel olarak kullanılır. Göreme'ye göre çok daha sakindir. Çevredeki "
        "vadilerde Aziz Nikolaos Manastırı ve Kutsal Haç Kilisesi gibi kaya kiliseleri vardır. İçindeki yerler ayrıca "
        "işaretlenebilir.",
        "Mustafapaşa in Ürgüp district, formerly called Sinasos, is known for the mansions built by wealthy Greek "
        "merchants in the 19th century, their façades decorated with stone carving. After the 1923 population exchange the "
        "Greek inhabitants left for Greece; the town opened to tourism in the 1980s.\n\n"
        "As you wander the streets, look at the doorways carved with vines and angels, the Church of Constantine and "
        "Helena and the madrasa; some of the mansions are now boutique hotels. It is much calmer than Göreme. In the "
        "valleys around are rock churches such as the Monastery of St Nicholas and the Church of the Holy Cross. The "
        "places inside can be checked off separately."),

    "cavusin": (2,
        "Göreme ile Avanos arasındaki Çavuşin, adı 16. yüzyıl kayıtlarında da geçen eski bir köydür. Eski yerleşim, "
        "yüksek bir kayalığa oyulmuş evlerden oluşuyordu; 20. yüzyılın ortasındaki kaya düşmelerinden sonra halk "
        "aşağıdaki yeni köye taşındı.\n\n"
        "Kayalığın tepesine yakın Vaftizci Yahya Kilisesi'ne tırmanmak, köyün girişindeki freskli Büyük Güvercinlik "
        "Kilisesi'ni görmek ve Gül Vadisi yürüyüşüne buradan başlamak Çavuşin'de yapılacakların başındadır. Köydeki "
        "küçük kafeler ve el sanatı tezgâhları mola için uygundur. İçindeki yerler ayrıca işaretlenebilir.",
        "Between Göreme and Avanos, Çavuşin is an old village whose name already appears in 16th-century records. The old "
        "settlement consisted of houses carved into a tall cliff; after rockfalls in the mid-20th century its people "
        "moved to the new village below.\n\n"
        "Climbing to the Church of St John the Baptist near the top of the cliff, seeing the frescoed Great Pigeon House "
        "Church at the village entrance and starting the Rose Valley walk from here are the highlights of Çavuşin. The "
        "village's small cafés and craft stalls are good for a break. The places inside can be checked off separately."),

    "guzelyurt": (2,
        "Aksaray'a bağlı Güzelyurt, eski adıyla Gelveri, Ihlara Vadisi'ne yaklaşık 15 km uzaklıkta, Hasan Dağı'nın "
        "eteğinde kurulu eski bir Kapadokya kasabasıdır. Mübadeleye kadar Rum ve Türk halkın birlikte yaşadığı kasaba, "
        "Kapadokyalı kilise babalarından Nazianzoslu Gregorios'la da ilişkilendirilir.\n\n"
        "Taş evler, kayalara oyulmuş yapılar, sonradan camiye çevrilen Aziz Gregorios Kilisesi ve Manastır Vadisi'ndeki "
        "kaya kiliseleri gezilebilir. Göreme bölgesine göre çok daha sakindir. Ihlara Vadisi ve Selime ile aynı gün "
        "planlanabilir.",
        "Güzelyurt in Aksaray province, formerly Gelveri, is an old Cappadocian town at the foot of Mount Hasan, about "
        "15 km from the Ihlara Valley. Home to Greek and Turkish people together until the population exchange, the town "
        "is also associated with the Cappadocian Church Father Gregory of Nazianzus.\n\n"
        "You can explore stone houses, rock-cut buildings, the Church of St Gregory later turned into a mosque, and the "
        "rock churches of the Monastery Valley. It is much quieter than the Göreme area. It can be planned on the same day "
        "as the Ihlara Valley and Selime."),

    "aktepe-hill-sunset-point": (2,
        "Aktepe, Zelve'nin güneyinde yükselen ve kuzey yamaçlarında Zelve vadilerinin bulunduğu tepedir. Tepenin "
        "üzerindeki seyir noktası, aşağıdaki Kızılçukur Vadisi'ne ve çevredeki peribacalarına geniş bir açıyla bakar.\n\n"
        "Gün batımında kızıla dönen kayalar ve sabahın erken saatlerinde vadilerin üzerinde yükselen balonlar en "
        "güzel manzaralardır. Göreme merkezindeki seyir noktasından daha sakindir. Zemin toprak ve kayalıktır; "
        "karanlıkta dönüş için yanınıza bir el feneri alın.",
        "Aktepe is the hill rising south of Zelve, with the Zelve valleys on its northern slopes. The viewpoint on top "
        "looks out widely over the Red Valley (Kızılçukur) below and the fairy chimneys around it.\n\n"
        "The rocks turning red at sunset and the balloons rising over the valleys early in the morning are the finest "
        "views. It is quieter than the viewpoint in central Göreme. The ground is earth and rock; bring a torch for the "
        "walk back after dark."),

    "temenni-tepe": (2,
        "Ürgüp'ün ortasında yükselen Temenni Tepe, adını 'dilek' anlamına gelen temenni sözcüğünden alır. Tepede "
        "Selçuklu dönemine ait bir türbe bulunur ve burası uzun süredir dilek dilenen bir yer olarak bilinir.\n\n"
        "Tepeden Ürgüp'ün kaya oyma evleri, eski Rum konakları ve çevredeki vadiler geniş bir açıyla görülür; gün "
        "batımında manzara özellikle güzeldir. Kasaba merkezinden kısa bir yokuşla çıkılır; çay bahçesinde oturup "
        "manzarayı izleyebilirsiniz.",
        "Rising in the middle of Ürgüp, Temenni Hill takes its name from the word temenni, meaning 'wish'. A tomb from "
        "the Seljuk period stands on the hill, which has long been known as a place for making wishes.\n\n"
        "From the top you get a wide view of Ürgüp's cave houses, old Greek mansions and the surrounding valleys, "
        "especially lovely at sunset. It is a short climb from the town centre, and you can sit in the tea garden and "
        "enjoy the view."),

    "uc-guzeller": (2,
        "Ürgüp'ün hemen dışındaki Üç Güzeller, üzerlerinde bazalt 'şapka' taşıyan üç peribacasından oluşur ve "
        "Kapadokya'nın en tanınmış simgelerindendir. Yöresel bir anlatıya göre bu kayalar bir aileyi temsil eder.\n\n"
        "Peribacaları, sert kayanın altındaki yumuşak volkanik tüfün rüzgâr ve yağmurla aşınmasıyla oluştu; şapkalar "
        "altlarındaki sütunu korur. Seyir terasından özellikle gün batımında fotoğraf çekmek için kalabalık olur. "
        "Ürgüp-Mustafapaşa yolu üzerindedir.",
        "Just outside Ürgüp, the Three Beauties are three fairy chimneys topped with basalt 'caps' and are among the "
        "best-known symbols of Cappadocia. According to a local tale, the rocks represent a family.\n\n"
        "Fairy chimneys formed as wind and rain wore away the soft volcanic tuff beneath harder rock, and the caps protect "
        "the columns below them. The viewing terrace gets busy, especially at sunset, with people taking photographs. It "
        "lies on the Ürgüp-Mustafapaşa road."),

    "ihlara-cam-teras": (2,
        "Ihlara Vadisi'nin ana girişine yakın cam seyir terası, kanyonun kenarından boşluğa doğru uzanan bir "
        "platformdur. Ayaklarınızın altındaki camdan, yaklaşık yüz metre aşağıda kıvrılarak akan Melendiz Çayı'nı ve "
        "vadi tabanını görebilirsiniz.\n\n"
        "Teras, vadiye inmeden önce kanyonun büyüklüğünü görmek için iyi bir noktadır; buradan vadiye inen merdivenler "
        "de yakındır. Rüzgârlı havalarda dikkatli olun ve görevlilerin uyarılarına uyun.",
        "Near the main entrance to the Ihlara Valley, the glass viewing terrace is a platform extending out over the edge "
        "of the canyon. Through the glass beneath your feet you can see the Melendiz stream winding along the valley floor "
        "about a hundred metres below.\n\n"
        "The terrace is a good spot to take in the size of the canyon before descending; the stairs down into the valley "
        "are close by. Take care in windy weather and follow the staff's instructions."),

    "goreme-tarihi-milli-parki": (2,
        "Göreme Tarihî Millî Parkı, yaklaşık 100 km²'lik alanıyla Kapadokya'nın peribacaları, vadileri ve kaya "
        "yerleşimlerinin büyük bölümünü koruma altına alır. Erciyes, Hasan ve Göllüdağ volkanlarının milyonlarca yıl "
        "önce bıraktığı tüf katmanlarının aşınmasıyla oluşan bu eşsiz arazi, 1985'te UNESCO Dünya Mirası Listesi'ne "
        "alındı.\n\n"
        "Park sınırları içinde Göreme, Uçhisar, Çavuşin ve Ortahisar ile Güvercinlik, Gül, Kızılçukur ve Aşk vadileri "
        "yer alır. Sabahın erken saatlerinde yükselen sıcak hava balonları, parkın en ünlü manzarasıdır. Vadilerde "
        "işaretli patikalardan ayrılmayın ve peribacalarına tırmanmayın.",
        "Göreme Historical National Park, covering about 100 km², protects much of Cappadocia's fairy chimneys, valleys "
        "and rock settlements. This unique landscape, formed by the erosion of tuff layers left millions of years ago by "
        "the volcanoes Erciyes, Hasan and Göllüdağ, was added to the UNESCO World Heritage List in 1985.\n\n"
        "Within the park are Göreme, Uçhisar, Çavuşin and Ortahisar, and the Pigeon, Rose, Red and Love valleys. The hot "
        "air balloons rising early in the morning are the park's most famous sight. Stay on the marked paths in the "
        "valleys and do not climb on the fairy chimneys."),

    "bagildere-vadisi": (2,
        "Bağıldere Vadisi, halk arasında Aşk Vadisi olarak bilinir ve Göreme ile Uçhisar arasında yer alır. Vadiyi "
        "ünlü yapan, onlarca metre yüksekliğe ulaşan ince ve uzun peribacalarıdır.\n\n"
        "Vadi tabanındaki patika üzüm bağları ve meyve bahçeleri arasından geçer; yukarıdaki seyir noktasından tüm "
        "vadi görülür. Sabahları balonlar sık sık vadinin üzerinden geçer. Yürüyüş birkaç saat sürebilir; su ve şapka "
        "alın, patikalar yer yer kumlu ve kaygandır.",
        "Bağıldere Valley, popularly known as Love Valley, lies between Göreme and Uçhisar. What makes it famous are its "
        "slender, tall fairy chimneys, some reaching tens of metres in height.\n\n"
        "The path along the valley floor passes vineyards and orchards, and the viewpoint above takes in the whole valley. "
        "In the mornings balloons often drift over it. The walk can take a few hours; bring water and a hat, and note that "
        "paths are sandy and slippery in places."),

    "devrent-vadisi": (2,
        "Avanos ile Ürgüp arasındaki Devrent Vadisi, Hayal Vadisi olarak da bilinir. Diğer vadilerden farklı olarak "
        "burada kilise ya da kaya evi yoktur; vadiyi ünlü yapan, hayvan ve insan biçimlerine benzeyen peribacalarıdır.\n\n"
        "En ünlüsü deve biçimli kayadır; ziyaretçiler diğer kayalarda da yunus, fok ya da Meryem Ana figürü arar. "
        "Pembe tonlu kayalar gün batımında güzelleşir. Yol kenarında olduğundan kısa bir mola için idealdir; Paşabağları "
        "ve Zelve yakındır.",
        "Devrent Valley, between Avanos and Ürgüp, is also known as Imagination Valley. Unlike the other valleys it has no "
        "churches or cave houses; it is famous for fairy chimneys resembling animals and people.\n\n"
        "The best known is the camel-shaped rock, and visitors look for dolphins, seals or a figure of the Virgin Mary in "
        "the other rocks. The pinkish rocks are lovely at sunset. Being right by the road, it is ideal for a short stop; "
        "Paşabağları and Zelve are close by."),

    "gul-vadisi": (2,
        "Göreme ile Çavuşin arasındaki Gül Vadisi, gün batımında pembeye dönen kayaları nedeniyle bu adı alır. Bölgenin "
        "en sevilen yürüyüş vadilerinden biridir ve yol boyunca kayalara oyulmuş kiliseler, güvercinlikler ve bağlar "
        "bulunur.\n\n"
        "Patika Kızılçukur Vadisi ile birleşerek dairesel bir yürüyüşe dönüşebilir. Yol üzerindeki kaya kiliselerinin "
        "bazılarında fresk kalıntıları görülür. Akşamüstü yürüyüp gün batımını vadinin üzerindeki seyir noktalarından "
        "izlemek en güzelidir; dönüş için el feneri alın.",
        "The Rose Valley between Göreme and Çavuşin takes its name from its rocks, which turn pink at sunset. It is one of "
        "the region's favourite walking valleys, with rock-cut churches, dovecotes and vineyards along the way.\n\n"
        "The path can join the Red Valley to make a circular walk. Some of the rock churches along the route still have "
        "remains of frescoes. Walking in the late afternoon and watching the sunset from the viewpoints above the valley "
        "is best; bring a torch for the way back."),

    "guvercinlik-vadisi": (2,
        "Göreme ile Uçhisar arasındaki Güvercinlik Vadisi, kayalara oyulmuş sayısız güvercinlikle tanınır. Bu "
        "güvercinlikler yüzyıllar boyunca, bağlar için gübre olarak kullanılan güvercin dışkısını toplamak amacıyla "
        "oyuldu.\n\n"
        "Göreme ile Uçhisar'ı birbirine bağlayan patika, vadi tabanında yaklaşık birkaç kilometre boyunca ilerler; "
        "Uçhisar tarafındaki seyir noktasında nazar boncuklarıyla süslü ağaç ünlüdür. Yokuş yukarı yürümek "
        "istemiyorsanız Uçhisar'dan başlayıp Göreme'ye inin.",
        "Pigeon Valley, between Göreme and Uçhisar, is known for the countless dovecotes carved into its rocks. For "
        "centuries these were carved to collect pigeon droppings, used as fertiliser for the vineyards.\n\n"
        "The path linking Göreme and Uçhisar runs for a few kilometres along the valley floor, and the tree decorated with "
        "evil-eye beads at the viewpoint on the Uçhisar side is well known. If you prefer not to walk uphill, start in "
        "Uçhisar and walk down to Göreme."),

    "passabag-vadisi": (2,
        "Zelve yakınlarındaki Paşabağları, Keşişler Vadisi olarak da bilinir. Bir gövdeden birden çok başlığın "
        "yükseldiği, Kapadokya'nın en etkileyici peribacaları burada toplanır.\n\n"
        "Peribacalarının bazılarına keşiş hücreleri ve şapeller oyulmuştur; bunlardan biri, inzivaya çekilen Aziz "
        "Simeon'a adanmıştır. Kısa ve düz patikalarla kolay gezilen bir alandır. Gün içinde tur otobüsleriyle "
        "kalabalıklaşır; sabah erken ya da akşamüstü daha sakindir.",
        "Paşabağları, near Zelve, is also known as Monks Valley. Cappadocia's most impressive fairy chimneys, with several "
        "caps rising from a single trunk, are gathered here.\n\n"
        "Monks' cells and chapels are carved into some of the chimneys, one of them dedicated to the hermit St Simeon. It "
        "is an easy site to explore along short, flat paths. It gets busy with tour buses during the day; early morning "
        "and late afternoon are quieter."),

    "meskendir-valley-entrance": (2,
        "Göreme ile Ortahisar arasındaki Meskendir Vadisi, peribacaları, güvercinlikler ve kayalara oyulmuş tüneller "
        "arasından geçen bir yürüyüş vadisidir. Kızılçukur ve Gül vadileriyle bağlantılı patikalar sunar.\n\n"
        "Vadinin bazı bölümlerinde kayaya oyulmuş dar geçitlerden geçmek gerekir; yol işaretleri sınırlı olduğundan bir "
        "harita uygulaması kullanın. Kalabalıktan uzak bir yürüyüş için uygundur; su ve şapka almayı unutmayın.",
        "Meskendir Valley, between Göreme and Ortahisar, is a walking valley that passes among fairy chimneys, dovecotes "
        "and tunnels carved into the rock. Its paths connect with the Red and Rose valleys.\n\n"
        "In some parts of the valley you have to pass through narrow rock-cut passages; signs are limited, so use a map "
        "app. It suits a walk away from the crowds; remember to bring water and a hat."),

    "ihlara-vadisi": (2,
        "Aksaray'daki Ihlara Vadisi, Melendiz Çayı'nın volkanik araziyi yararak oluşturduğu, Ihlara'dan Selime'ye "
        "uzanan yaklaşık 14 km'lik bir kanyondur. Bizans döneminde keşişlerin yerleştiği vadinin yamaçlarında, "
        "fresklerle süslü onlarca kaya kilisesi bulunur.\n\n"
        "Ana girişteki merdivenlerle vadi tabanına inilir; dere boyunca uzanan gölgeli patikada yürüyüş yaparken Ağaçaltı, "
        "Kokar, Yılanlı ve Sümbüllü kiliselerini görebilirsiniz. Ortadaki Belisırma köyünde dere kenarında yemek "
        "molası verilir. Tüm vadiyi yürümek yarım günden fazla sürer; dönüş ulaşımını önceden planlayın. İçindeki "
        "yerler ayrıca işaretlenebilir.",
        "The Ihlara Valley in Aksaray is a canyon about 14 km long, from Ihlara to Selime, cut by the Melendiz stream into "
        "the volcanic terrain. Settled by monks in the Byzantine period, its slopes hold dozens of rock churches decorated "
        "with frescoes.\n\n"
        "Stairs at the main entrance lead down to the valley floor; walking the shady path along the stream you can see "
        "the Ağaçaltı, Kokar, Snake and Jacinth churches. Lunch by the stream is the usual break at Belisırma village in "
        "the middle. Walking the whole valley takes more than half a day, so plan your transport back in advance. The "
        "places inside can be checked off separately."),

    "kizilcukur-vadisi": (2,
        "Ortahisar yakınlarındaki Kızılçukur Vadisi, demir bakımından zengin kayalarının kızıl tonlarıyla tanınır. "
        "Kapadokya'da gün batımının en güzel izlendiği yerlerden biri olarak bilinir.\n\n"
        "Vadinin üzerindeki seyir alanı akşamları kalabalıklaşır; kayaların güneşle birlikte renk değiştirmesini izlemek "
        "için gün batımından önce gelin. Vadiden geçen yürüyüş yolları Gül Vadisi ile birleşir ve yol boyunca Haçlı "
        "Kilise gibi kaya kiliseleri bulunur. Dönüşte karanlıkta kalmamak için el feneri alın.",
        "The Red Valley (Kızılçukur), near Ortahisar, is known for the red tones of its iron-rich rocks. It is famed as "
        "one of the best places in Cappadocia to watch the sunset.\n\n"
        "The viewing area above the valley gets busy in the evenings; arrive before sunset to watch the rocks change colour "
        "with the light. Walking trails through the valley join the Rose Valley, with rock churches such as the Church of "
        "the Cross along the way. Bring a torch so you are not caught in the dark on the way back."),

    "soganli-vadisi": (2,
        "Kayseri'nin Yeşilhisar ilçesine bağlı Soğanlı Vadisi, Kapadokya'nın güneyinde, kalabalıktan uzak kalmış bir "
        "vadidir. Yukarı ve Aşağı Soğanlı olarak ikiye ayrılan vadinin yamaçlarında, Bizans döneminde oyulmuş çok "
        "sayıda kaya kilisesi ve manastır bulunur.\n\n"
        "Kubbeli, Saklı, Karabaş, Yılanlı ve Tahtalı kiliseleri vadi boyunca patikalarla gezilir. Köyde kadınların "
        "elde yaptığı geleneksel Soğanlı bebekleri satılır. Göreme'ye yaklaşık bir saatlik sürüş uzaklığındadır; "
        "Mustafapaşa ve Sobesos ile aynı güne eklenebilir. İçindeki yerler ayrıca işaretlenebilir.",
        "Soğanlı Valley, in the Yeşilhisar district of Kayseri, is a valley in southern Cappadocia that has stayed away "
        "from the crowds. Divided into Upper and Lower Soğanlı, its slopes hold many rock churches and monasteries carved "
        "in the Byzantine period.\n\n"
        "The Domed, Hidden, Karabaş, Snake and Tahtalı churches are visited along paths through the valley. In the "
        "village, women sell the traditional handmade Soğanlı dolls. It is about an hour's drive from Göreme and can be "
        "added to the same day as Mustafapaşa and Sobesos. The places inside can be checked off separately."),

    "soganli-karabas-kilisesi": (2,
        "Soğanlı Vadisi'ndeki Karabaş Kilisesi, vadinin en zengin süslenmiş kaya kiliselerinden biridir. Fresklerinin "
        "önemli bir bölümü 11. yüzyıla tarihlenir ve İsa'nın hayatından sahneleri anlatır.\n\n"
        "Kilise, yan yana oyulmuş birkaç mekândan oluşur; duvarlardaki resimlerde bağışçı tasvirleri ve yazıtlar da "
        "görülür. Vadinin yamacında, kısa bir tırmanışla ulaşılır. Freskleri korumak için dokunmayın ve flaş "
        "kullanmayın.",
        "The Karabaş Church in Soğanlı Valley is one of the most richly decorated rock churches in the valley. Much of its "
        "fresco work dates from the 11th century and tells scenes from the life of Christ.\n\n"
        "The church consists of several spaces carved side by side, and the paintings on its walls also include donor "
        "portraits and inscriptions. It is reached by a short climb up the valley slope. Do not touch the frescoes or use "
        "flash, to protect them."),

    "soganli-kubbeli-kilise": (2,
        "Soğanlı Vadisi'ndeki Kubbeli Kilise, bir peribacasının tepesine kubbe biçiminde oyulmuş olmasıyla Kapadokya'da "
        "benzeri olmayan bir yapıdır. Uzaktan bakınca kayanın üzerinde bir kilise kubbesi yükseliyormuş gibi görünür.\n\n"
        "Kiliseye kayalığa oyulmuş basamaklarla çıkılır; alt katta başka mekânlar da bulunur. Vadinin en çok "
        "fotoğraflanan yapılarındandır; yanındaki Saklı Kilise ile birlikte görülür. Basamaklar dik ve kayalıktır, "
        "dikkatli tırmanın.",
        "The Domed Church in Soğanlı Valley is unique in Cappadocia, carved in the shape of a dome on top of a fairy "
        "chimney. From a distance it looks as though a church dome rises from the rock.\n\n"
        "Steps cut into the cliff lead up to the church, and there are further spaces on the lower level. It is one of the "
        "most photographed buildings in the valley and is seen together with the Hidden Church next to it. The steps are "
        "steep and rocky, so climb carefully."),

    "soganli-sakli-kilise": (2,
        "Soğanlı Vadisi'ndeki Saklı Kilise, adını yamacın içine gizlenmiş olmasından alır; uzaktan bakıldığında "
        "neredeyse fark edilmez. Bu konum, onu yüzyıllar boyunca korumuştur.\n\n"
        "Kiliseye Kubbeli Kilise'nin yakınından ulaşılır; içeride fresk kalıntıları görülebilir. Vadinin bu kesimindeki "
        "kiliseler birbirine yakın olduğundan birkaçını aynı yürüyüşte görebilirsiniz. Zemin kayalıktır, uygun "
        "ayakkabı giyin.",
        "The Hidden Church in Soğanlı Valley takes its name from being tucked into the slope; from a distance it is "
        "barely noticeable. This position has protected it over the centuries.\n\n"
        "It is reached from near the Domed Church, and remains of frescoes can be seen inside. The churches in this part of "
        "the valley are close together, so you can see several on the same walk. The ground is rocky, so wear suitable shoes."),

    "soganli-yilanli-kilise": (2,
        "Soğanlı Vadisi'ndeki Yılanlı Kilise, Aziz Georgios'un ejderhayla (yılanla) savaştığı freskiyle bilinir. Bu "
        "sahne, Kapadokya kiliselerinde sevilen ve sık tekrarlanan konulardandır.\n\n"
        "Kilise vadinin yamacında yer alır; içerideki freskler zamanla yıpranmış olsa da ana sahneler seçilebilir. "
        "Göreme'deki aynı adlı Yılanlı Kilise ile karıştırmayın. Vadideki diğer kiliselerle birlikte kısa bir "
        "tırmanışla gezilir.",
        "The Snake Church in Soğanlı Valley is known for its fresco of St George fighting the dragon (snake), a popular "
        "and often repeated theme in the churches of Cappadocia.\n\n"
        "The church sits on the valley slope; although the frescoes inside have worn over time, the main scenes can still "
        "be made out. Do not confuse it with the Snake Church of the same name in Göreme. It is visited with a short climb "
        "together with the other churches in the valley."),

    "soganli-tahtali-kilise": (2,
        "Soğanlı Vadisi'ndeki Tahtalı Kilise, Azize Barbara'ya adanmıştır. İçerideki freskler, Bizans döneminde bu "
        "uzak vadide de güçlü bir manastır ve resim geleneği olduğunu gösterir.\n\n"
        "Tonozları ve duvarları kaplayan resimlerde İsa, Meryem ve azizlerin tasvirleri görülür; renkler hâlâ oldukça "
        "canlıdır. Kilise, vadinin aşağı kesiminde yer alır. Freskleri korumak için dokunmayın ve flaş kullanmayın.",
        "The Tahtalı Church in Soğanlı Valley is dedicated to St Barbara. Its frescoes show that a strong monastic and "
        "painting tradition flourished even in this remote valley in the Byzantine period.\n\n"
        "The paintings covering its vaults and walls show Christ, Mary and the saints, and their colours are still fairly "
        "vivid. The church is in the lower part of the valley. Do not touch the frescoes or use flash, to protect them."),

    "soganli-geyikli-kilise": (2,
        "Soğanlı Vadisi'ndeki Geyikli Kilise, adını duvarlarındaki geyikli bir aziz tasvirinden alır. Vadideki diğer "
        "kiliseler gibi Bizans döneminde kayaya oyulmuş ve fresklerle süslenmiştir.\n\n"
        "Kilise, vadinin daha sakin bir köşesinde kalır; fresklerin bir bölümü yıpranmış olsa da ana figürler "
        "seçilebilir. Vadideki yürüyüşe eklemek için yerel rehberlere ya da köydekilere yolu sorabilirsiniz.",
        "The Church of the Deer in Soğanlı Valley takes its name from a depiction of a saint with a deer on its walls. Like "
        "the other churches in the valley, it was carved into the rock and decorated with frescoes in the Byzantine "
        "period.\n\n"
        "The church lies in a quieter corner of the valley; although some of the frescoes have worn, the main figures can "
        "still be made out. To add it to your walk through the valley, ask local guides or villagers for the way."),
}
