-- İstanbul uzun açıklamaları, 7. parti (10 yer, TR + EN).
-- Üreten: data-pipeline/content/build_long_desc.py (kaynak: content/istanbul_long_descriptions.py).
-- Metinler kendi cümlelerimizdir; Vikipedi/Wikidata yalnızca bilgi kontrolü için kullanıldı.

update public.place_translations t
   set long_desc = v.long_desc
  from (values
  ('ihlamur-kasri', 'tr', 'Beşiktaş ile Nişantaşı arasındaki yeşil vadide bulunan Ihlamur Kasrı, Sultan Abdülmecid''in isteğiyle Nigoğos Balyan tarafından 1850''lerde yapıldı. Padişahların gezinti ve dinlenme için kullandığı mesirede, tören için kullanılan Merasim Köşkü ile maiyetin kaldığı Maiyet Köşkü olmak üzere iki yapı bulunur.

Barok süslemeli kesme taş cepheleri ve zengin döşenmiş salonlarıyla küçük ama zarif bir kasırdır. Adını aldığı ıhlamur ağaçlarının gölgelediği bahçe ve havuz, şehrin ortasında sakin bir mola yeri sunar. Milli Saraylar''a bağlı müze olarak hizmet verir; ziyaret günlerini gitmeden önce kontrol edin.'),
  ('ihlamur-kasri', 'en', 'In a green valley between Beşiktaş and Nişantaşı, Ihlamur Pavilion was built in the 1850s by Nigoğos Balyan at the request of Sultan Abdülmecid. The sultans'' pleasure ground has two buildings: the Ceremonial Pavilion and the Retinue Pavilion, where the entourage stayed.

With its baroque-decorated cut-stone façades and richly furnished rooms, it is small but elegant. The garden and pool, shaded by the linden trees that give it its name, offer a quiet break in the middle of the city. It is run as a museum by the National Palaces administration; check opening days before you go.'),
  ('st-antuan-katolik-kilisesi', 'tr', 'İstiklal Caddesi üzerindeki St. Antuan Kilisesi, İstanbul''un en büyük ve cemaati en kalabalık Katolik kilisesidir. Fransisken rahiplerine bağlıdır; bugünkü yapı mimar Giulio Mongeri tarafından 1906-1912 yılları arasında Venedik neo-Gotik üslubunda inşa edildi.

Kırmızı tuğla cephesi ve avlusuyla caddenin kalabalığı içinde hemen dikkat çeker; içerideki renkli vitraylar ve yüksek kemerler sakin bir atmosfer yaratır. Sonradan Papa XXIII. Ioannes olacak Angelo Roncalli, İstanbul''daki görevi sırasında burada vaaz vermiştir. Ayinler sırasında ziyaretçilerin sessiz olması beklenir.'),
  ('st-antuan-katolik-kilisesi', 'en', 'On İstiklal Avenue, the Church of St Anthony of Padua is the largest Catholic church in Istanbul and has the biggest congregation. It is run by Franciscan friars; the present building was erected between 1906 and 1912 by the architect Giulio Mongeri in Venetian neo-Gothic style.

Its red-brick façade and courtyard stand out amid the busy avenue, while the stained glass and tall arches inside create a calm atmosphere. Angelo Roncalli, later Pope John XXIII, preached here during his posting in Istanbul. Visitors are asked to be quiet during Mass.'),
  ('ayasofya-turbeleri', 'tr', 'Ayasofya''nın güney tarafındaki bahçede yer alan türbeler, 16. ve 17. yüzyılda beş Osmanlı padişahının ve ailelerinin yattığı yapılardır. II. Selim''in türbesi Mimar Sinan''ın eseridir; III. Murad ve III. Mehmed''in türbeleri de buradadır. Ayasofya''nın eski vaftizhanesi de I. Mustafa ve Sultan İbrahim için türbeye dönüştürülmüştür.

Türbelerin iç duvarları Osmanlı çini sanatının en güzel örnekleri arasında sayılan İznik çinileriyle kaplıdır; kalem işi kubbeler ve sedef kakmalı kapılar da dikkat çeker. Ayasofya ziyaretiyle birleştirilebilir; giriş düzeni değişebildiği için gitmeden önce kontrol edin.'),
  ('ayasofya-turbeleri', 'en', 'In the garden on the south side of Hagia Sophia, these tombs hold five Ottoman sultans of the 16th and 17th centuries and their families. The tomb of Selim II is the work of Mimar Sinan, and the tombs of Murad III and Mehmed III are here too. Hagia Sophia''s former baptistery was also turned into a tomb for Mustafa I and Sultan İbrahim.

Their interiors are lined with İznik tiles counted among the finest examples of Ottoman tile art, and the painted domes and mother-of-pearl inlaid doors are striking too. They can be combined with a visit to Hagia Sophia; entry arrangements can change, so check before you go.'),
  ('fatih-sultan-mehmed-turbesi', 'tr', 'İstanbul''u 1453''te fetheden Fatih Sultan Mehmed''in türbesi, Fatih Camii''nin kıble duvarının arkasındaki hazirededir. Özgün türbe 1766 depreminde yıkıldı ve III. Mustafa döneminde barok üslupta yeniden yapıldı.

Zengin süslemeli iç mekânında padişahın sandukası, kavuğu ve dönemin hat levhaları bulunur. Hemen yanında eşi Gülbahar Hatun''un türbesi yer alır. Özellikle cuma günleri ve fetih yıldönümü olan 29 Mayıs''ta çok sayıda ziyaretçi gelir; ziyaret sırasında sessiz ve saygılı olunmalıdır. Fatih Camii ziyaretinin doğal bir parçasıdır.'),
  ('fatih-sultan-mehmed-turbesi', 'en', 'The tomb of Mehmed II, who conquered Istanbul in 1453, stands in the graveyard behind the qibla wall of the Fatih Mosque. The original tomb collapsed in the earthquake of 1766 and was rebuilt in baroque style under Mustafa III.

Its richly decorated interior holds the sultan''s cenotaph, his turban and calligraphic panels. The tomb of his consort Gülbahar Hatun stands right beside it. Many visitors come, especially on Fridays and on 29 May, the anniversary of the conquest; visitors should be quiet and respectful. It is a natural part of a visit to the Fatih Mosque.'),
  ('hurrem-sultan-turbesi', 'tr', 'Süleymaniye Camii''nin arkasındaki hazirede, Kanuni Sultan Süleyman''ın türbesinin yakınında bulunan Hürrem Sultan Türbesi, 1558''de ölen Hürrem Sultan için Mimar Sinan tarafından yapıldı. Kanuni''nin eşi olan Hürrem, Osmanlı tarihinin en etkili kadınlarından biri sayılır.

Sekizgen planlı türbenin iç duvarları, cennet bahçesini anımsatan çiçek ve ağaç motifli İznik çinileriyle kaplıdır ve Kanuni''nin türbesiyle birlikte Sinan''ın en zarif türbelerinden biridir. Süleymaniye Camii ziyaretinin ardından avludan kolayca ulaşılır; ziyaret düzenini gitmeden önce kontrol edin.'),
  ('hurrem-sultan-turbesi', 'en', 'In the graveyard behind the Süleymaniye Mosque, near the tomb of Suleiman the Magnificent, the Tomb of Hürrem Sultan was built by Mimar Sinan for Hürrem, who died in 1558. Suleiman''s wife, known in Europe as Roxelana, is counted among the most influential women in Ottoman history.

The interior of the octagonal tomb is lined with İznik tiles whose flowers and trees evoke the garden of paradise, and together with Suleiman''s tomb it is one of Sinan''s most graceful. It is easily reached from the courtyard after a visit to the Süleymaniye Mosque; check visiting arrangements before you go.'),
  ('i-abdulhamid-turbesi', 'tr', 'Eminönü''nde, Bahçekapı''daki I. Abdülhamid Türbesi, padişahın 1770''lerde yaptırdığı külliyenin bir parçasıdır. Burada 27. Osmanlı padişahı I. Abdülhamid ile oğlu IV. Mustafa yatar.

Kesme taştan, barok süslemeli yapı 18. yüzyılda Osmanlı mimarisine giren Avrupa etkilerinin güzel bir örneğidir. Sirkeci ile Mısır Çarşısı arasındaki kalabalık ticaret sokaklarının ortasında kalan sakin bir duraktır ve bölgede dolaşırken kısa bir ziyaret için uygundur.'),
  ('i-abdulhamid-turbesi', 'en', 'At Bahçekapı in Eminönü, the Tomb of Abdülhamid I is part of the complex the sultan built in the 1770s. It holds Abdülhamid I, the 27th Ottoman sultan, and his son Mustafa IV.

Built of cut stone with baroque decoration, it is a fine example of the European influences that entered Ottoman architecture in the 18th century. It is a quiet stop in the middle of the busy shopping streets between Sirkeci and the Spice Bazaar, ideal for a short visit while exploring the area.'),
  ('ii-mahmud-turbesi', 'tr', 'Divanyolu Caddesi üzerindeki II. Mahmud Türbesi, Sultan Abdülmecid''in 1839''da ölen babası için yaptırdığı ve 1840''ta tamamlanan anıtsal bir türbedir. Burada II. Mahmud''un yanı sıra Sultan Abdülaziz ve II. Abdülhamid de yatar.

Sekizgen planlı, ampir üslubundaki türbe büyük pencereleri ve parlak iç süslemesiyle dikkat çeker. Çevresindeki hazirede, Osmanlı''nın son döneminden birçok devlet adamı, yazar ve sanatçının mezarı bulunur; işlemeli mezar taşları arasında dolaşmak ilginçtir. Çemberlitaş ve Kapalıçarşı''ya birkaç dakika yürüme mesafesindedir.'),
  ('ii-mahmud-turbesi', 'en', 'On Divanyolu, the Tomb of Mahmud II is a monumental mausoleum built by Sultan Abdülmecid for his father, who died in 1839, and completed in 1840. Besides Mahmud II, Sultans Abdülaziz and Abdülhamid II are buried here.

Octagonal and in Empire style, the tomb stands out for its large windows and bright interior decoration. The surrounding cemetery holds the graves of many statesmen, writers and artists of the late Ottoman period, and wandering among the carved headstones is fascinating. The Column of Constantine and the Grand Bazaar are a few minutes'' walk away.'),
  ('kanuni-sultan-suleyman-turbesi', 'tr', 'Süleymaniye Camii''nin kıble tarafındaki hazirede bulunan Kanuni Sultan Süleyman Türbesi, 1566''da ölen padişah için Mimar Sinan tarafından yapıldı. Türbede Kanuni''nin yanı sıra II. Süleyman ve II. Ahmed de yatar.

Sütunlu bir revakla çevrili sekizgen yapının içi, İznik çinileri, kalem işi süslemeler ve kubbeyi süsleyen değerli taşlarla Osmanlı''nın klasik döneminin en görkemli türbelerinden biridir. Hemen yakınında Hürrem Sultan''ın türbesi bulunur. Süleymaniye ziyaretine eklenmeli; ziyaret düzenini gitmeden önce kontrol edin.'),
  ('kanuni-sultan-suleyman-turbesi', 'en', 'In the graveyard on the qibla side of the Süleymaniye Mosque, the Tomb of Suleiman the Magnificent was built by Mimar Sinan for the sultan, who died in 1566. Besides Suleiman, Suleiman II and Ahmed II are buried here.

Surrounded by a colonnaded portico, the octagonal building''s interior, with İznik tiles, painted decoration and precious stones in the dome, makes it one of the most magnificent tombs of the classical Ottoman era. The tomb of Hürrem Sultan is close by. Add it to a visit to the Süleymaniye; check visiting arrangements before you go.'),
  ('malta-kosku', 'tr', 'Yıldız Parkı''nın içindeki Malta Köşkü, Sultan Abdülaziz döneminde yapıldı ve adını yapımında kullanılan, Malta''dan getirildiği anlatılan taşlardan alır. Köşk Osmanlı tarihinin bazı önemli olaylarına sahne oldu; 1881''de Mithat Paşa''nın yargılandığı Yıldız Mahkemesi köşkün yakınında kurulan bir çadırda toplandı.

Bugün kafe ve restoran olarak hizmet veren köşkün terasından park ağaçlarının arasından Boğaz görülür. Yıldız Parkı''nda yürüyüş yaparken mola vermek için güzel bir yerdir; Çadır Köşkü de yakındadır.'),
  ('malta-kosku', 'en', 'Inside Yıldız Park, Malta Pavilion was built in the reign of Sultan Abdülaziz and is said to take its name from stone brought from Malta for its construction. It witnessed some important events in Ottoman history; in 1881 the Yıldız Court that tried Midhat Pasha sat in a tent set up near the pavilion.

Now a café and restaurant, its terrace looks out to the Bosphorus through the park''s trees. It is a lovely place to stop while walking in Yıldız Park, and Çadır Pavilion is nearby.'),
  ('sultan-ahmed-turbesi', 'tr', 'Sultanahmet Camii''nin kuzeyinde, Sultanahmet Meydanı''na bakan Sultan Ahmed Türbesi, 1617''de ölen I. Ahmed için caminin mimarı Sedefkâr Mehmed Ağa tarafından yapıldı. Burada I. Ahmed''in yanı sıra oğulları Genç Osman ve IV. Murad da yatar.

Kare planlı, kubbeli türbenin iç duvarları 17. yüzyıl İznik çinileriyle kaplıdır ve sedef kakmalı ahşap işçiliği dikkat çeker. Sultanahmet Camii ziyaretinin hemen ardından birkaç dakikada görülebilir; sessiz ve saygılı olmak gerekir.'),
  ('sultan-ahmed-turbesi', 'en', 'North of the Blue Mosque, facing Sultanahmet Square, the Tomb of Sultan Ahmed was built for Ahmed I, who died in 1617, by Sedefkâr Mehmed Agha, the mosque''s architect. Besides Ahmed I, his sons Osman II and Murad IV are buried here.

The interior of the square, domed tomb is lined with 17th-century İznik tiles, and its mother-of-pearl inlaid woodwork is striking. It takes only a few minutes to see right after a visit to the Blue Mosque; visitors should be quiet and respectful.')
  ) v(slug, lang, long_desc)
  join public.places p on p.slug = v.slug
 where t.place_id = p.id and t.lang = v.lang;
