-- İstanbul uzun açıklamaları, 9. parti (10 yer, TR + EN).
-- Üreten: data-pipeline/content/build_long_desc.py (kaynak: content/istanbul_long_descriptions.py).
-- Metinler kendi cümlelerimizdir; Vikipedi/Wikidata yalnızca bilgi kontrolü için kullanıldı.

update public.place_translations t
   set long_desc = v.long_desc
  from (values
  ('istanbul-deniz-muzesi', 'tr', 'Beşiktaş iskelesinin yanındaki İstanbul Deniz Müzesi, Deniz Kuvvetleri Komutanlığı''na bağlı olarak hizmet veren ve kökleri 1897''ye uzanan Türkiye''nin en büyük denizcilik müzesidir. Koleksiyonunda yaklaşık 20.000 eser bulunur; 2013''te modern bir binaya taşınmıştır.

Müzenin en etkileyici bölümü, padişahların Boğaz''da kullandığı saltanat kayıklarının sergilendiği salondur. Osmanlı donanmasına ait haritalar, silahlar, gemi modelleri ve Barbaros Hayreddin Paşa ile ilgili eserler de görülebilir. Hemen yanındaki parkta Barbaros''un türbesi ve heykeli bulunur.'),
  ('istanbul-deniz-muzesi', 'en', 'Beside the Beşiktaş pier, the Istanbul Naval Museum is Turkey''s largest maritime museum, run by the Naval Forces Command with roots going back to 1897. Its collection numbers around 20,000 items, and in 2013 it moved into a modern building.

Its most impressive section is the hall of imperial caiques that the sultans used on the Bosphorus. Maps, weapons and ship models of the Ottoman navy and objects relating to Admiral Barbaros Hayreddin Pasha can also be seen. The park right beside it holds Barbaros''s tomb and statue.'),
  ('maslak-kasri', 'tr', 'Maslak''ta, Büyükdere Caddesi''nin kenarındaki geniş korunun içinde yer alan Maslak Kasırları, 19. yüzyılda padişahların av ve dinlenme için kullandığı köşklerden oluşur. Bugünkü yapılar büyük ölçüde Sultan Abdülaziz dönemine aittir; II. Abdülhamid de şehzadeliğinde burada vakit geçirmiştir.

Kasr-ı Hümayun, Mabeyn Köşkü, Limonluk ve Çadır Köşkü gibi yapılar, gökdelenlerle çevrili bir bölgede beklenmedik sakinlikte bir koru içinde dağılmıştır. Milli Saraylar''a bağlı müze olarak hizmet verir; ziyaret günleri değişebileceğinden gitmeden önce kontrol edin.'),
  ('maslak-kasri', 'en', 'In Maslak, inside a large wooded grounds beside Büyükdere Avenue, the Maslak Pavilions are a group of 19th-century kiosks the sultans used for hunting and rest. The present buildings mostly date from the reign of Sultan Abdülaziz; Abdülhamid II also spent time here as a prince.

Buildings such as the Imperial Pavilion, the Mabeyn Kiosk, the Orangery and the Tent Kiosk are scattered through a grove of unexpected calm in a district surrounded by skyscrapers. It is run as a museum by the National Palaces administration; opening days can change, so check before you go.'),
  ('meryem-ana-kilisesi', 'tr', 'Ayvansaray''daki Vlaherna Meryem Ana Kilisesi ve ayazması, Bizans''ın en kutsal yerlerinden biri sayılan bir Meryem Ana kilisesinin bulunduğu yerdedir. İlk kilise 5. yüzyılda yapılmış ve Meryem Ana''ya ait olduğuna inanılan kutsal emanetleri barındırmıştır. Bu büyük kilise 15. yüzyılda bir yangında yok oldu; bugünkü küçük kilise 19. yüzyılda yapıldı.

Yüksek duvarlarla çevrili sakin avludaki ayazma, hâlâ ziyaretçilerin şifa aradığı bir su kaynağıdır. İçerideki ikonalar ve duvar resimleri görülmeye değer. İbadet yeri olduğu için uygun giyinilmeli ve sessiz olunmalıdır. Balat ve Fener''e yürüme mesafesindedir.'),
  ('meryem-ana-kilisesi', 'en', 'In Ayvansaray, the Church of St Mary of Blachernae and its holy spring stand on the site of one of Byzantium''s most sacred churches of the Virgin. The first church was built in the 5th century and housed relics believed to belong to the Virgin Mary. That great church was lost to fire in the 15th century; the present small church dates from the 19th century.

The holy spring in the quiet courtyard, enclosed by high walls, is still a source where visitors seek healing. The icons and wall paintings inside are worth seeing. As a place of worship it calls for modest dress and quiet. Balat and Fener are within walking distance.'),
  ('mihrimah-sultan-camii-uskudar', 'tr', 'Üsküdar iskelesinin hemen karşısındaki Mihrimah Sultan Camii, Kanuni Sultan Süleyman''ın kızı Mihrimah Sultan için Mimar Sinan tarafından 1548''de yapıldı ve Sinan''ın erken dönem eserlerindendir. Halk arasında İskele Camii diye de anılır.

Yüksek bir set üzerine oturan cami, ön cephesindeki geniş son cemaat yeri ve şadırvanıyla meydana hâkimdir; kubbesi üç yandan yarım kubbelerle desteklenir. Rivayete göre Edirnekapı''daki Mihrimah Sultan Camii ile arasında güneşin batışı ve ayın doğuşuna dair romantik bir hikâye anlatılır. Vapurdan inince ilk görülen yapılardan biridir.'),
  ('mihrimah-sultan-camii-uskudar', 'en', 'Right across from the Üsküdar pier, the Mihrimah Sultan Mosque was built by Mimar Sinan in 1548 for Mihrimah Sultan, daughter of Suleiman the Magnificent, and is one of Sinan''s early works. Locals also call it the Pier Mosque.

Raised on a high terrace, the mosque dominates the square with its broad front portico and fountain; its dome is supported by half-domes on three sides. Legend links it with the Mihrimah Sultan Mosque at Edirnekapı through a romantic story about the setting of the sun and the rising of the moon. It is one of the first buildings you see as you step off the ferry.'),
  ('orme-dikilitas', 'tr', 'Sultanahmet Meydanı''nın güney ucundaki Örme Dikilitaş, yaklaşık 32 metre yüksekliğinde, kaba kesme taştan örülmüş bir anıttır. Yapım tarihi kesin olarak bilinmez; 10. yüzyılda İmparator VII. Konstantinos tarafından onarıldığını belirten bir yazıt taşır.

Bir zamanlar yüzeyi yaldızlı bronz levhalarla kaplıydı; bu levhalar 1204''te Haçlılar tarafından sökülüp götürüldü ve bugün taşlardaki tutturma delikleri hâlâ görülebilir. Hipodrom''un orta setinde, Dikilitaş ve Yılanlı Sütun ile aynı çizgide durur.'),
  ('orme-dikilitas', 'en', 'At the southern end of Sultanahmet Square, the Walled Obelisk is a monument about 32 metres high built of roughly cut stone. Its construction date is not known for certain; an inscription records its restoration by Emperor Constantine VII in the 10th century.

It was once sheathed in gilded bronze plates, which were stripped away by the Crusaders in 1204, and the holes that held them can still be seen in the stones. It stands on the central spine of the Hippodrome, in line with the Obelisk of Theodosius and the Serpent Column.'),
  ('kilic-ali-pasa-camii', 'tr', 'Tophane''deki Kılıç Ali Paşa Camii, Osmanlı donanmasının kaptan-ı deryası Kılıç Ali Paşa için Mimar Sinan tarafından yapıldı ve 1580 civarında tamamlandı. Sinan''ın ileri yaşındaki eserlerindendir ve planı Ayasofya''nın küçültülmüş bir yorumu gibidir.

Külliyedeki türbe, medrese ve hamam da korunmuştur; restore edilen Kılıç Ali Paşa Hamamı bugün yeniden hizmet verir. Cami Karaköy ile Tophane arasındaki sahile yakın olduğundan İstanbul Modern ve Galataport gezisine kolayca eklenebilir.'),
  ('kilic-ali-pasa-camii', 'en', 'In Tophane, the Kılıç Ali Pasha Mosque was built by Mimar Sinan for Kılıç Ali Pasha, grand admiral of the Ottoman fleet, and completed around 1580. One of the works of Sinan''s later years, its plan reads like a scaled-down interpretation of Hagia Sophia.

The tomb, madrasa and bath of the complex also survive; the restored Kılıç Ali Pasha Bath is in use again today. Close to the waterfront between Karaköy and Tophane, the mosque is an easy addition to a visit to Istanbul Modern and Galataport.'),
  ('milyon-tasi', 'tr', 'Ayasofya''nın karşısında, Yerebatan Sarnıcı''nın yakınında duran Milyon Taşı, 4. yüzyılda dikilen ve Bizans İmparatorluğu''nda tüm yol mesafelerinin ölçüldüğü başlangıç noktasıdır. Roma''daki altın mil taşının karşılığı olarak düşünülmüştür.

Özgün anıt, üzeri kubbeli, dört yöne açılan görkemli bir kemerli yapıydı; bugün ondan yalnızca mermer bir sütun parçası kalmıştır. Sultanahmet''te Ayasofya ile Yerebatan arasında yürürken birkaç dakikalık bir durak olarak görülebilir.'),
  ('milyon-tasi', 'en', 'Opposite Hagia Sophia, near the Basilica Cistern, the Milion stone was set up in the 4th century as the zero point from which all road distances in the Byzantine Empire were measured. It was conceived as the counterpart of Rome''s Golden Milestone.

The original monument was an imposing domed arch opening on four sides; today only a fragment of a marble pillar remains. It makes a stop of a few minutes while walking between Hagia Sophia and the Basilica Cistern in Sultanahmet.'),
  ('yoros-kalesi', 'tr', 'Anadolu Kavağı''nın üzerindeki tepede, Boğaz''ın Karadeniz''e açıldığı noktaya hâkim olan Yoros Kalesi, Bizans döneminde Boğaz''ı denetlemek için yapılmış bir kaledir. Daha sonra uzun süre Cenevizlilerin elinde kaldığı için halk arasında Ceneviz Kalesi diye de bilinir.

Surların kalıntıları arasından Karadeniz''in girişi, Boğaz''ın iki yakası ve Yavuz Sultan Selim Köprüsü görülür; manzara özellikle gün batımında etkileyicidir. Köyden yokuşlu bir yolla yürünerek çıkılır. Kazı çalışmaları nedeniyle bazı bölümlere giriş kısıtlanabilir; aşağıdaki balık restoranları da bilinen bir duraktır.'),
  ('yoros-kalesi', 'en', 'On the hill above Anadolu Kavağı, commanding the point where the Bosphorus opens to the Black Sea, Yoros Castle was built in the Byzantine period to control the strait. Because it was later held for a long time by the Genoese, it is popularly known as the Genoese Castle.

From among the ruins of its walls you can see the entrance to the Black Sea, both shores of the Bosphorus and the Yavuz Sultan Selim Bridge; the view is especially striking at sunset. It is reached on foot by a steep path from the village. Excavation work may restrict access to some parts, and the fish restaurants below are a well-known stop.'),
  ('neve-salom-sinagogu', 'tr', 'Galata''daki Neve Şalom Sinagogu 1951''de açıldı ve İstanbul''un en büyük sinagogudur. Adı İbranice ''barış vahası'' anlamına gelir. Şehrin Yahudi toplumunun dini ve toplumsal hayatında önemli bir yere sahiptir.

Geniş ibadet salonu ve büyük avizesiyle dikkat çeker. Sinagogda 1986 ve 2003''te düzenlenen saldırılarda hayatını kaybedenler anılır. Güvenlik nedeniyle ziyaretler önceden başvuru ve kimlik kontrolüyle yapılır; koşulları gitmeden önce kontrol edin. Galata Kulesi''ne birkaç dakika uzaklıktadır.'),
  ('neve-salom-sinagogu', 'en', 'In Galata, the Neve Shalom Synagogue opened in 1951 and is Istanbul''s largest synagogue. Its name means ''oasis of peace'' in Hebrew. It holds an important place in the religious and community life of the city''s Jewish community.

It is notable for its spacious prayer hall and great chandelier. The synagogue commemorates those who lost their lives in the attacks of 1986 and 2003. For security, visits require advance application and an ID check; check the conditions before you go. Galata Tower is a few minutes away.'),
  ('saint-esprit-kilisesi', 'tr', 'Harbiye''de Cumhuriyet Caddesi üzerindeki Saint Esprit Katedrali, 1846''da ibadete açılan bir Latin Katolik katedralidir. Mimarı, Ayasofya''nın 19. yüzyıldaki restorasyonunu da yapan İsviçreli mimar Gaspare Fossati''dir.

Notre Dame de Sion Lisesi''nin avlusundaki kilisenin sakin iç mekânı, yüksek sütunları ve vitraylarıyla barok canlandırmacı bir atmosfer taşır. Avludaki Papa XV. Benedictus heykeli, Birinci Dünya Savaşı sırasındaki yardım çalışmaları anısına dikilmiştir. Ayin saatlerinde sessiz olunmalıdır. Taksim''e kısa yürüme mesafesindedir.'),
  ('saint-esprit-kilisesi', 'en', 'On Cumhuriyet Avenue in Harbiye, the Cathedral of the Holy Spirit is a Latin Catholic cathedral opened for worship in 1846. It was designed by the Swiss architect Gaspare Fossati, who also carried out the 19th-century restoration of Hagia Sophia.

Set in the courtyard of the Notre Dame de Sion school, the church has a calm interior in Baroque Revival style, with tall columns and stained glass. The statue of Pope Benedict XV in the courtyard was raised in memory of his relief work during the First World War. Visitors should be quiet during Mass. It is a short walk from Taksim.')
  ) v(slug, lang, long_desc)
  join public.places p on p.slug = v.slug
 where t.place_id = p.id and t.lang = v.lang;
