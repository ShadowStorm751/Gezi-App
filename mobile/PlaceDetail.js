import React,{useEffect,useRef,useState} from 'react';
import {Alert,KeyboardAvoidingView,Linking,Platform,ScrollView,Share,Text,View,useWindowDimensions} from 'react-native';
import {SafeAreaView,useSafeAreaInsets} from 'react-native-safe-area-context';
import {Camera,ChevronLeft,Clock,Footprints,Heart,Share2,Star} from 'lucide-react-native';
import {AsyncStorage,client,lang,project,t} from './client';
import {webUrl} from './catalog';
import {Circle,Photo,eyebrow,heading,km,meta,muted,row} from './PlaceUI';
import {c,type,radius,shadow} from './theme';
import {Press} from './Motion';
import {useQuery} from './ScreenUI';

function HeroPhoto({photo,place,width}) {
  const [index,setIndex]=useState(0);
  const bucket=photo?.license==='Gezi App'?'user-photos':'place-photos';
  const storage=photo?.storage_path && client?.storage.from(bucket).getPublicUrl(photo.storage_path).data.publicUrl;
  const choices=[...new Set([photo?.url,photo?.thumb_url,storage,place.thumbnail].map(webUrl).filter(Boolean))];
  return <Photo place={place} uri={choices[index]||null} onError={()=>setIndex(i=>i+1)} style={{width,height:320}}/>;
}
function Credit({photo}) {
  if(!photo) return null;
  const link=(url,label)=>webUrl(url)?<Text accessibilityRole="link" onPress={()=>Linking.openURL(url).catch(()=>Alert.alert(t('Bağlantı açılamadı','Could not open link')))} style={{color:c.primary,textDecorationLine:'underline'}}>{label}</Text>:label;
  return <Text numberOfLines={1} accessibilityLabel={[photo.author,photo.license].join(' · ')} style={{...type.caption,color:c.inkMuted}}>
    {t('Fotoğraf: ','Photo: ')}{link(photo.source_url,photo.author)} · {link(photo.license_url,photo.license)}{photo.license!=='Gezi App' && photo.source_url?.includes('commons.wikimedia.org')?' · Wikimedia Commons':''}</Text>;
}
export function ratingLabel(rating) {
  return rating?.average!=null?Number(rating.average).toLocaleString(lang,{maximumFractionDigits:1})+' ('+rating.count+')':rating?.count?rating.count+' '+t('değerlendirme','ratings'):t('Henüz değerlendirme yok','No ratings yet');
}
export default function PlaceDetail({place,distance,userId,onBack,onTrack,footer,children,onReviews,live=true,revision}) {
  const {width}=useWindowDimensions(),insets=useSafeAreaInsets(), [index,setIndex]=useState(0),[saved,setSaved]=useState(null);
  const key='gezi:saved:'+project+':'+(userId||'guest'),lock=useRef(false);
  const badges=useQuery(userId && live?'my_achievements':null,{lang},[userId,revision]);
  const badgeSlug=place.periodCode==='Osmanlı'?'ottoman-heritage':place.periodCode==='Bizans'?'byzantine-traveler':({tomb:'sultans-rest',mosque:'mosque-wanderer',museum:'museum-lover',palace:'palace-life'})[place.category];
  const badge=badges.data?.find(b=>b.slug===badgeSlug);
  useEffect(()=>{let active=true;setSaved(null);AsyncStorage.getItem(key).then(raw=>{if(active)setSaved((JSON.parse(raw)||[]).includes(place.id));}).catch(()=>{if(active)setSaved(false);});return ()=>{active=false;};},[key,place.id]);
  async function toggle() {
    if(lock.current||saved===null)return;
    lock.current=true;
    try {const ids=new Set(JSON.parse(await AsyncStorage.getItem(key))||[]);if(saved)ids.delete(place.id);else ids.add(place.id);await AsyncStorage.setItem(key,JSON.stringify([...ids]));setSaved(!saved);}
    catch{Alert.alert(t('Kaydedilemedi. Tekrar dene.','Could not save. Try again.'));}finally{lock.current=false;}
  }
  const photos=place.photos?.length?place.photos:[null];
  const century=place.builtYear>0?Math.ceil(place.builtYear/100):null;
  return <KeyboardAvoidingView behavior={Platform.OS==='ios'?'padding':undefined} style={{flex:1,backgroundColor:c.surface}}>
    <ScrollView keyboardShouldPersistTaps="handled"><View>
      <ScrollView horizontal pagingEnabled showsHorizontalScrollIndicator={false} onMomentumScrollEnd={e=>setIndex(Math.round(e.nativeEvent.contentOffset.x/width))}>{photos.map((p,i)=><HeroPhoto key={p?.url||p?.storage_path||i} photo={p} place={place} width={width}/>)}</ScrollView>
      <View style={[row,{position:'absolute',top:insets.top+8,left:20,right:20}]}><Circle icon={ChevronLeft} label={t('Geri','Back')} onPress={onBack}/><View style={{flex:1}}/><Circle icon={Heart} label={saved?t('Kaydı kaldır','Unsave'):t('Kaydet','Save')} active={saved} onPress={toggle}/><Circle icon={Share2} label={t('Paylaş','Share')} onPress={()=>Share.share({message:[place.name,place.source].filter(Boolean).join('\n')}).catch(()=>{})}/></View>
      {!!photos[0] && <Text style={{...type.caption,color:c.onPrimary,position:'absolute',bottom:36,right:20,paddingHorizontal:10,paddingVertical:4,borderRadius:16,overflow:'hidden',backgroundColor:c.scrim}}>{index+1} / {photos.length}</Text>}
    </View><View style={{marginTop:-28,padding:20,paddingTop:22,gap:12,borderTopLeftRadius:radius.xl,borderTopRightRadius:radius.xl,backgroundColor:c.surface}}>
      <Credit photo={photos[index]}/><Text style={eyebrow}>{meta(place)}</Text><Text accessibilityRole="header" style={{...type.title,fontSize:28,lineHeight:35,color:c.ink}}>{place.name}</Text>
      <View style={[row,{flexWrap:'wrap'}]}>{Number.isFinite(distance)&&!place.hasArea && <View style={row}><Footprints size={16} color={c.ink}/><Text style={muted}>{km(distance)} · ~{Math.max(1,Math.round(distance/80))} {t('dk','min')}</Text></View>}
      {live && <Press onPress={onReviews} disabled={!onReviews} accessibilityRole={onReviews?'button':'text'} style={row}><Star size={16} color={c.gold}/><Text style={muted}>{ratingLabel(place.rating)}</Text></Press>}
      {!!place.bestTime && <View style={row}><Clock size={16} color={c.inkMuted}/><Text style={muted}>{place.bestTime}</Text></View>}</View>
      <View style={[row,{flexWrap:'wrap'}]}>{century && <Text style={{...type.eyebrow,color:c.accentInk,backgroundColor:c.accentSoft,padding:7,borderRadius:12,overflow:'hidden'}}>{lang==='tr'?century+'. YÜZYIL':t('','CENTURY ')+century}</Text>}{!!badge && <Text style={{...type.caption,color:c.goldInk,backgroundColor:c.goldSoft,padding:7,borderRadius:12,overflow:'hidden'}}>{badge.name} {badge.progress}/{badge.target}</Text>}</View>
      {!!place.description && <><Text style={heading}>{t('Hakkında','About')}</Text>{place.description.split(/\n\s*\n/).map((p,i)=><Text key={i} style={{...type.bodyLg,color:c.ink,marginBottom:2}}>{p.trim()}</Text>)}</>}
      {children}</View></ScrollView>
    <SafeAreaView edges={['bottom']} style={{backgroundColor:c.surfaceRaised,...shadow.sheet}}><View style={[row,{paddingHorizontal:16,paddingVertical:10,alignItems:'flex-start'}]}>
      <Circle size={52} icon={Camera} label={t('Kamerada takip et','Track in camera')} onPress={onTrack}/><View style={{flex:1}}>{footer}</View></View></SafeAreaView>
  </KeyboardAvoidingView>;
}
