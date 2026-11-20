const test = require('node:test');
const assert = require('node:assert/strict');
const {loadDetail} = require('../catalog.ts');
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
