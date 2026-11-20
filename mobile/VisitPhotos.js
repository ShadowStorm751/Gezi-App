import React,{useRef,useState} from 'react';
import {Alert,Image,ScrollView,StyleSheet,Switch,Text,TextInput,View} from 'react-native';
import {SafeAreaView} from 'react-native-safe-area-context';
import {ChevronLeft} from 'lucide-react-native';
import * as Picker from 'expo-image-picker';
import {ImageManipulator,SaveFormat} from 'expo-image-manipulator';
import {randomUUID} from 'expo-crypto';
import {client,lang,t} from './client';
import {Action,Feedback,rpc,ui,useAction,useQuery} from './ScreenUI';
import {Circle,heading,muted,row} from './PlaceUI';
import {c,type} from './theme';

export function ContributionPage({title,onBack,children}) {
  return <SafeAreaView accessibilityViewIsModal style={[StyleSheet.absoluteFill,{backgroundColor:c.surface}]}><ScrollView keyboardShouldPersistTaps="handled" contentContainerStyle={{padding:20,gap:16}}>
    <View style={row}><Circle icon={ChevronLeft} label={t('Geri','Back')} onPress={onBack}/><Text style={{...type.title,color:c.ink,flex:1}}>{title}</Text></View>{children}</ScrollView></SafeAreaView>;
}
export function Status({value,note}) {
  const labels={none:t('Yalnızca puan','Rating only'),approved:t('Yayında','Published'),pending:t('İnceleniyor','Under review'),rejected:t('Reddedildi','Rejected')};
  return <View style={{alignItems:'flex-start',gap:4}}><Text style={{...type.caption,color:value==='rejected'?c.accentInk:c.primaryInk,backgroundColor:value==='rejected'?c.accentSoft:c.primarySoft,padding:6,borderRadius:8,overflow:'hidden'}}>{labels[value]||value}</Text>{!!note && <Text style={muted}>{note}</Text>}</View>;
}
export function confirmRemove(label,work) {
  Alert.alert(label,undefined,[{text:t('Vazgeç','Cancel'),style:'cancel'},{text:t('Sil','Delete'),style:'destructive',onPress:work}]);
}
export function AddPhoto({place,visits,onBack}) {
  const [asset,setAsset]=useState(null),[caption,setCaption]=useState(''),[consent,setConsent]=useState(false),[done,setDone]=useState(false);
  const action=useAction(),pending=useRef(null),id=visits.userId;
  async function pick(camera) {
    const access=camera?await Picker.requestCameraPermissionsAsync():await Picker.requestMediaLibraryPermissionsAsync();
    if(!access.granted){action.setMessage(t('Fotoğraf seçmek için izin vermelisin.','Allow access to choose a photo.'));return;}
    const options={mediaTypes:['images'],quality:1};
    const res=camera?await Picker.launchCameraAsync(options):await Picker.launchImageLibraryAsync(options);
    if(!res.canceled){setAsset(res.assets[0]);setConsent(false);pending.current=null;}
  }
  async function send() {
    if(!asset||!id||!consent||visits.owner.current!==id)return;
    const bucket=client.storage.from('user-photos');
    if(!pending.current) pending.current={path:id+'/'+randomUUID()+'.jpg',uploaded:false};
    const staged=pending.current;
    if(!staged.uploaded){
      const ctx=ImageManipulator.manipulate(asset.uri);
      if(Math.max(asset.width,asset.height)>1600)ctx.resize(asset.width>=asset.height?{width:1600}:{height:1600});
      const img=await ctx.renderAsync();
      const jpg=await img.saveAsync({format:SaveFormat.JPEG,compress:.8,base64:true});
      const bytes=Uint8Array.from(atob(jpg.base64),ch=>ch.charCodeAt(0));
      if(bytes.byteLength>5*1024*1024){action.setMessage(t('Fotoğraf 5 MB sınırını aşıyor. Daha küçük bir fotoğraf seç.','Photo exceeds 5 MB. Choose a smaller photo.'));return;}
      if(visits.owner.current!==id)return;
      const upload=await bucket.upload(staged.path,bytes.buffer,{contentType:'image/jpeg',upsert:false});
      if(upload.error && String(upload.error.statusCode)!=='409' && upload.error.error!=='Duplicate')throw upload.error;
      staged.uploaded=true;
    }
    if(visits.owner.current!==id)return;
    try{await rpc('submit_place_photo',{place_id:place.id,storage_path:staged.path,caption:caption.trim()||null});}
    catch(e){
      if(e.code==='file_not_found')pending.current=null;
      if(e.code==='rate_limited'){action.setMessage(t('Bugünlük yeterince fotoğraf gönderdin. Yarın tekrar dene.','Daily photo limit reached. Try again tomorrow.'));return;}
      if(e.code!=='already_submitted')throw e;
    }
    if(visits.owner.current===id)setDone(true);
  }
  return <ContributionPage title={t('Fotoğraf ekle','Add a photo')} onBack={onBack}><Text style={heading}>{place.name}</Text>
    {done?<><Text accessibilityLiveRegion="polite" style={muted}>{t('Fotoğrafın incelemeye gönderildi. Durumunu Profil → Fotoğraflarım’da görebilirsin.','Your photo was submitted for review. Check its status in Profile → My photos.')}</Text><Action selected onPress={onBack}>{t('Tamam','Done')}</Action></>:<>
    <View style={row}><Action disabled={action.busy} onPress={()=>action.run(()=>pick(false))}>{t('Galeriden seç','Choose from gallery')}</Action><Action disabled={action.busy} onPress={()=>action.run(()=>pick(true))}>{t('Fotoğraf çek','Take a photo')}</Action></View>
    {asset && <Image source={{uri:asset.uri}} style={{height:190,borderRadius:14}}/>}
    <TextInput accessibilityLabel={t('Fotoğraf açıklaması','Photo caption')} placeholder={t('Açıklama (isteğe bağlı)','Caption (optional)')} maxLength={200} value={caption} onChangeText={setCaption} editable={!action.busy} style={ui.input}/>
    <View style={row}><Switch accessibilityLabel={t('Yayın izni','Publication consent')} value={consent} disabled={action.busy} onValueChange={setConsent}/><Text style={[muted,{flex:1}]}>{t('Fotoğrafı kendim çektim. Uygulamada adımla yayınlanmasını kabul ediyorum. Yüzü tanınır kişiler olmamasına dikkat ettim.','I took this photo and agree to have it published under my name. I checked that no identifiable faces appear.')}</Text></View>
    <Action selected disabled={action.busy||!asset||!consent} onPress={()=>action.run(send)}>{action.busy?t('Gönderiliyor…','Sending…'):t('İncelemeye gönder','Submit for review')}</Action></>}
    {!!action.message && <Text accessibilityLiveRegion="polite" style={ui.notice}>{action.message}</Text>}</ContributionPage>;
}
export function MyPhotos({visits}) {
  const id=visits.userId,query=useQuery('my_photos',{lang},id),action=useAction();
  async function remove(item){
    if(visits.owner.current!==id)return;
    const res=await rpc('delete_my_photo',{photo_id:item.id});query.retry();
    if(res.storage_path && visits.owner.current===id){const removed=await client.storage.from('user-photos').remove([res.storage_path]);if(removed.error)action.setMessage(t('Kayıt silindi. Dosya temizliği bekliyor.','Photo entry deleted. File cleanup is pending.'));}
  }
  return <><Text style={heading}>{t('Fotoğraflarım','My photos')}</Text><Feedback query={query}/>
    {query.data?.length===0 && <Text style={muted}>{t('Henüz fotoğraf göndermedin.','You haven’t submitted any photos yet.')}</Text>}
    {query.data?.map(item=><View key={item.id} style={ui.card}><Image source={{uri:client.storage.from('user-photos').getPublicUrl(item.storage_path).data.publicUrl}} style={{height:150,borderRadius:12}}/><Text style={heading}>{item.place_name}</Text>{!!item.caption&&<Text style={muted}>{item.caption}</Text>}<Status value={item.status} note={item.admin_note}/><Action disabled={action.busy} danger onPress={()=>confirmRemove(t('Fotoğraf silinsin mi?','Delete photo?'),()=>action.run(()=>remove(item)))}>{t('Sil','Delete')}</Action></View>)}
    {!!action.message && <Text style={ui.notice}>{action.message}</Text>}</>;
}
