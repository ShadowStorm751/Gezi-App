const test = require('node:test');
const assert = require('node:assert/strict');
const {loadCity,loadNearby,loadDetail,mapPlace} = require('../catalog.ts');
const {cameraTargets} = require('../geo');
const tower = {id:'b490bb1c-9aa3-44a7-8535-300000000001',slug:'galata-kulesi',name:'Galata Kulesi',
  short_desc:null,kind:'historical',category:'tower',latitude:41.0256556,longitude:28.9741556,checkin_radius_m:80};
const pack = {city:'istanbul',name:'İstanbul',version:'2026-11-18',places:[tower]};
function memory(){
  const values=new Map();
  return {getItem:async key=>values.get(key)??null,setItem:async(key,value)=>values.set(key,value),values};
}
test('Şehir paketi şeması haritaya ve 1 km kamera hedefine aynı kimliği verir',async()=>{
  const store=memory();
  const p=await loadCity(async(name,args)=>{
    assert.equal(name,'city_pack');assert.deepEqual(args,{city_slug:'istanbul',lang:'tr'});
    return {data:pack,error:null};
  },store,'project','tr',()=>assert.fail());
  const place=mapPlace(p.places[0],'tr');
  const target=cameraTargets([place],{latitude:tower.latitude-0.009,longitude:tower.longitude},0)[0];
  assert.equal(target.id,tower.id);assert.ok(target.visible);assert.ok(Math.abs(target.distance-1000)<2);
  assert.equal(place.categoryLabel,'Kule');assert.equal(mapPlace(tower,'en').categoryLabel,'Tower');
});
test('Çevrimdışı açılış yalnızca doğru proje ve dildeki kayıtlı paketi gösterir',async()=>{
  const store=memory();const ok=async()=>({data:pack,error:null});
  await loadCity(ok,store,'project','tr',()=>{});
  const fail=async()=>({error:{code:'unavailable'},data:null});
  let shown;
  await assert.rejects(loadCity(fail,store,'project','tr',v=>shown=v));assert.deepEqual(shown,pack);
  for (const [project,lang] of [['project','en'],['other','tr']])
    await assert.rejects(loadCity(fail,store,project,lang,()=>assert.fail()));
});
test('Boş paket ve aynı sürümde değişen çeviri önbelleğe yansır',async()=>{
  const store=memory(); const send=p=>loadCity(async()=>({data:p,error:null}),store,'a','tr',()=>{});
  await send(pack); const revised={...pack,places:[{...tower,name:'Düzeltilmiş ad'}]};
  await send(revised);assert.deepEqual(JSON.parse([...store.values.values()][0]),revised);
  const empty={...pack,places:[],version:null};await send(empty);assert.deepEqual(JSON.parse([...store.values.values()][0]),empty);
});
test('Yakın sorgu konumu, iki kilometreyi, dili ve UUID bilgisini korur',async()=>{
  const origin={latitude:41.01,longitude:28.97};
  const list=await loadNearby(async(name,args)=>{
    assert.equal(name,'nearby_places');assert.deepEqual(args,{lat:41.01,lng:28.97,radius_m:2000,kinds:null,lang:'en',max_results:100});
    return {data:[{...tower,distance_m:1000,bearing_deg:null,visited:false}],error:null};
  },origin,'en');
  assert.equal(list[0].id,tower.id);assert.equal(list[0].distance,1000);assert.equal(list[0].bearing,null);
  assert.deepEqual(await loadNearby(async()=>({data:[],error:null}),origin,'en'),[]);
  await assert.rejects(loadNearby(async()=>({error:{code:'42501'}}),origin,'en'));
});
test('Yer kartı doğru UUID ve dili kullanır, bulunamayan yer ile bağlantı hatası ayrılır',async()=>{
  const result=await loadDetail(async(name,args)=>{
    assert.equal(name,'place_detail');assert.deepEqual(args,{place_id:tower.id,lang:'en'});
    return {data:{...tower,name:'Galata Tower',category_name:'Tower',long_desc:'History',period:null,best_time:null},error:null};
  },tower.id,'en');assert.equal(result.description,'History');
  assert.equal(await loadDetail(async()=>({data:null,error:null}),tower.id,'tr'),null);
  await assert.rejects(loadDetail(async()=>({data:null,error:{code:'42501'}}),tower.id,'tr'));
});
