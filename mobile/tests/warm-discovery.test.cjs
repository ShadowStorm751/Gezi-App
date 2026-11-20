const test = require('node:test');
const assert = require('node:assert/strict');
const {loadDetail, mapPlace, mergeNearbyPlace} = require('../catalog.ts');
const {checkinOutcome} = require('../visitLogic');
const {badgeForPlace} = require('../badgeProgress');

test('uzak ziyaret uyarısı her iki dilde kilometre kullanır', () => {
  const result = {ok:false,error:'too_far',distance_m:231251};
  assert.match(checkinOutcome(result,'tr').message,/231,3 km/);
  assert.match(checkinOutcome(result,'en').message,/231\.3 km/);
});

test('yer detayı ziyaret, kullanıcı fotoğrafı, puan ve dönem bilgisini korur', async () => {
  const photo = {author:'@gezgin',license:'Gezi App',storage_path:'owner/photo.jpg'};
  const data = {id:'bazaar',name:'Mısır Çarşısı',category_name:'Çarşı',period_code:'Osmanlı',
    built_year:1664,visited_at:'2026-11-20T12:00:00Z',rating:{count:2,average:null},photos:[photo]};
  const detail = await loadDetail(async () => ({data,error:null}),data.id,'tr');
  assert.deepEqual(detail.photos,[photo]);
  assert.deepEqual(detail.rating,{count:2,average:null});
  assert.equal(detail.visitedAt,data.visited_at);
  assert.equal(detail.builtYear,1664);
  assert.equal(badgeForPlace(detail),'ottoman-heritage');
  assert.equal(badgeForPlace({category:'tomb'}),'sultans-rest');
  assert.equal(badgeForPlace({category:'beach'}),undefined);
});

test('şehir paketi ve yakındaki yer birleşince dönem rozeti her iki dilde korunur', () => {
  const row = {id:'bazaar', name:'Bazaar', category:'market', kind:'historical', latitude:41, longitude:29};
  const nearby = {...mapPlace(row,'en'), distance:150, visited:true};
  for (const [code,en,badge] of [['Osmanlı','Ottoman','ottoman-heritage'],['Bizans','Byzantine','byzantine-traveler']]) {
    for (const [lang,period] of [['tr',code],['en',en]]) {
      const packed = mapPlace({...row,period,period_code:code},lang);
      const merged = mergeNearbyPlace(nearby,packed);
      assert.equal(badgeForPlace(packed),badge);
      assert.equal(merged.period,period);
      assert.equal(badgeForPlace(merged),badge);
      assert.equal(merged.distance,150);
      assert.equal(merged.visited,true);
    }
  }
});

test('dönemsiz doğa yeri ve eski paket dönem rozeti üretmez', () => {
  const row = {category:'park',kind:'nature',latitude:41,longitude:29};
  const legacy = mapPlace(row,'tr');
  const park = mapPlace({...row,period:null,period_code:null},'tr');
  assert.equal(mergeNearbyPlace(legacy,park).periodCode,null);
  assert.equal(badgeForPlace(park),undefined);
  assert.equal(badgeForPlace(mergeNearbyPlace(legacy)),undefined);
});
