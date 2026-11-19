const {test} = require('node:test');
const assert = require('node:assert/strict');
const {distanceHint,sendCheckin,checkinOutcome,fetchVisitDates} = require('../visitLogic');
const {mapPlace} = require('../catalog.ts');

const place = mapPlace({id:'tower',name:'Galata Kulesi',category:'tower',latitude:41.0256,longitude:28.9742,
  checkin_radius_m:60,has_area:false},'tr');
const far = {latitude:41.02344,longitude:28.9742,accuracy:5};
const result = data => ({data,error:null});

test('240 m mesafe bir ipucudur; alan, eski paket veya yarıçap içi için gösterilmez',()=>{
  assert.equal(distanceHint(place,far),240);
  assert.equal(distanceHint({...place,hasArea:true},far),null);
  assert.equal(distanceHint({...place,hasArea:undefined},far),null);
  assert.equal(distanceHint(place,{...far,latitude:41.0247,accuracy:50}),null);
  assert.equal(distanceHint(place,{...far,latitude:41.0244,accuracy:200}),133);
});
test('uzaktayken de Edge Function çağrılır ve sunucunun mesafesi iki dilde gösterilir',async()=>{
  const data = await sendCheckin(async(name,{body})=>{
    assert.equal(name,'checkin');
    assert.deepEqual(body,{place_id:'tower',lat:far.latitude,lng:far.longitude,accuracy_m:5,lang:'tr'});
    return result({ok:false,error:'too_far',distance_m:237});
  },place.id,far,'tr');
  for (const lang of ['tr','en']) {
    const outcome = checkinOutcome(data,lang);
    assert.equal(outcome.action,'retry');
    assert.match(outcome.message,/237 m/);
  }
});
test('GPS doğruluğu eksikse 999, sıfır ise 0 gönderilir',async()=>{
  for (const value of [null,0]) {
    await sendCheckin(async(_name,{body})=>{
      assert.equal(body.accuracy_m,value ?? 999);
      return result({ok:false,error:'low_accuracy'});
    },place.id,{...far,accuracy:value},'en');
  }
});
test('başarı, işaretli ziyaret ve birden çok rozet',()=>{
  const awards = [{slug:'first-step'},{slug:'sultans-rest'}];
  const progress = {visited:12,total:156};
  const success = checkinOutcome({ok:true,new_achievements:awards,city_progress:progress},'tr');
  assert.equal(success.action,'record');
  assert.deepEqual(success.awards,awards);
  assert.deepEqual(success.progress,progress);
  const flagged = checkinOutcome({ok:true,flagged:true,new_achievements:[],city_progress:progress},'tr');
  assert.equal(flagged.message,success.message);
  assert.deepEqual(flagged.awards,[]);
});
test('ret kodları doğru buton durumuna ve anlaşılır TR/EN mesaja dönüşür',()=>{
  for (const [code,action] of Object.entries({low_accuracy:'retry',rate_limited:'retry',already_visited:'visited',
    place_not_found:'refresh',not_authenticated:'login',server_error:'retry',invalid_input:'retry'})) {
    const tr = checkinOutcome({ok:false,error:code},'tr');
    const en = checkinOutcome({ok:false,error:code},'en');
    assert.equal(tr.action,action);
    assert.equal(en.action,action);
    assert.notEqual(tr.message,en.message);
  }
});
test('HTTP 401, boş gateway yanıtı, HTTP 500 ve ağ hatası',async()=>{
  for (const status of [401,500]) {
    const response = await sendCheckin(async()=>({error:{context:{status,json:async()=>{throw Error('empty')}}}}),place.id,far,'en');
    assert.equal(checkinOutcome(response,'en').action,status===401?'login':'retry');
  }
  const http = await sendCheckin(async()=>({error:{context:{status:400,json:async()=>({error:'invalid_input'})}}}),place.id,far,'tr');
  assert.equal(http.error,'invalid_input');
  const offline = await sendCheckin(async()=>{throw Error('offline')},place.id,far,'tr');
  assert.equal(checkinOutcome(offline,'tr').action,'retry');
});
test('ziyaret geçmişinin tüm sayfalarını tarih imleciyle okur',async()=>{
  const rows = Array.from({length:100},(_,i)=>({place_id:'place'+i,visited_at:new Date(1e12-i*1000).toISOString()}));
  const dates = await fetchVisitDates(async(name,args)=>{
    assert.equal(name,'my_visits');
    assert.equal(args.page_size,100);
    assert.equal(args.lang,'en');
    if (!args.before_time) return result(rows);
    assert.equal(args.before_time,rows[99].visited_at);
    return result([{place_id:'old',visited_at:'2001-01-01'}]);
  },'en',()=>true);
  assert.equal(Object.keys(dates).length,101);
  assert.equal(dates.old,'2001-01-01');
  await assert.rejects(fetchVisitDates(async()=>({error:{}}),'tr',()=>true));
});
