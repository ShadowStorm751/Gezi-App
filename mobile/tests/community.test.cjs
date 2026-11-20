const test = require('node:test');
const assert = require('node:assert/strict');
const {contributionPayload,deleteConfirmedAccount} = require('../communityLogic.js');

test('Sadece konum bildirimi ve yeni yer önerisi koordinat içerir',()=>{
  const request={placeId:'p',kind:'closed',pin:{latitude:41,longitude:29},note:' ',lang:'tr'};
  assert.deepEqual(contributionPayload(request),{place_id:'p',kind:'closed',note:null,lang:'tr'});
  assert.deepEqual(contributionPayload({...request,kind:'wrong_location'}),{place_id:'p',kind:'wrong_location',lat:41,lng:29,note:null,lang:'tr'});
  assert.deepEqual(contributionPayload({...request,placeId:null,name:' Koru ',category:'forest',note:' yeni '}),
    {name:'Koru',category:'forest',lat:41,lng:29,note:'yeni',lang:'tr'});
});

function account(result={data:{ok:true}}) {
  const events=[];
  const client={auth:{getSession:async()=>({data:{session:{user:{id:'a'},access_token:'test'}}}),
    signOut:async options=>{events.push(['logout',options]);return {};}},functions:{invoke:async (...args)=>{events.push(args);return result;}}};
  return {events,client,clear:async id=>{events.push(['clear',id]);}};
}
test('Silme isteği onaylanan oturuma bağlanır ve yalnız o hesabı temizler',async()=>{
  const a=account();
  await deleteConfirmedAccount(a.client,'a',a.clear,()=> 'a');
  assert.deepEqual(a.events,[['delete-account',{headers:{Authorization:'Bearer test'},body:{confirm:'DELETE'}}],['clear','a'],['logout',{scope:'local'}]]);
});
test('Hesap değiştiyse silme isteği gönderilmez',async()=>{
  const a=account();
  await assert.rejects(deleteConfirmedAccount(a.client,'b',a.clear,()=> 'b'));
  assert.equal(a.events.length,0);
});
test('Sunucu reddederse oturum ve yerel veriler korunur',async()=>{
  const a=account({data:{ok:false}});
  await assert.rejects(deleteConfirmedAccount(a.client,'a',a.clear,()=> 'a'));
  assert.equal(a.events.length,1);
});
test('Yanıt beklerken açılan başka bir oturum kapatılmaz',async()=>{
  const a=account();
  let owner='a';
  await deleteConfirmedAccount(a.client,'a',async id=>{await a.clear(id);owner='b';},()=>owner);
  assert.deepEqual(a.events.map(e=>e[0]),['delete-account','clear']);
});
