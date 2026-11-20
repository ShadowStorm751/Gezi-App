import React,{useState} from 'react';
import {Image,ScrollView,Text,TextInput,View} from 'react-native';
import {Landmark,Search,Trees} from 'lucide-react-native';
import {lang,t} from './client';
import {Press} from './Motion';
import {c,type,radius,shadow} from './theme';

export const row={flexDirection:'row',alignItems:'center',gap:10};
export const muted={...type.body,color:c.inkMuted};
export const eyebrow={...type.eyebrow,color:c.inkMuted};
export const heading={...type.heading,color:c.ink};
export const title={...type.cardTitle,color:c.ink};
export const upper=s=>(s||'').toLocaleUpperCase(lang);
export const km=m=>!Number.isFinite(m)?'':m<1000?Math.round(m)+' m':(m/1000).toLocaleString(lang,{maximumFractionDigits:1})+' km';
export const meta=p=>upper([p.period,p.categoryLabel||p.category].filter(Boolean).join(' · '));
export function Photo({place,uri=place.thumbnail,style,credit=false,onError}) {
  const [failed,setFailed]=useState(null);
  const Icon=place.kind==='nature'?Trees:Landmark;
  return <View style={[{overflow:'hidden',alignItems:'center',justifyContent:'center',backgroundColor:c.surfaceSunken},style]}>
    {uri && failed!==uri ? <><Image accessibilityLabel={place.name} source={{uri}} resizeMode="cover" style={{width:'100%',height:'100%'}} onError={()=>{setFailed(uri);onError?.();}}/>
      {credit && <Text numberOfLines={1} style={{position:'absolute',bottom:2,left:2,color:c.onPrimary,backgroundColor:c.scrim,fontSize:9}}>{uri.includes('user-photos')?'Gezi App':'Wikimedia Commons'}</Text>}</>:<Icon size={30} color={c.accent}/>}</View>;
}
export function Circle({icon:Icon,label,onPress,accent=false,active=false,size=44}) {
  return <Press accessibilityRole="button" accessibilityLabel={label} onPress={onPress} style={{width:size,height:size,borderRadius:size/2,alignItems:'center',justifyContent:'center',backgroundColor:accent?c.accent:c.surfaceRaised,...shadow.card}}>
    <Icon size={size>44?24:20} color={accent?c.onAccent:active?c.accent:c.ink} fill={active?c.accent:c.clear}/></Press>;
}
export function SearchBox({value,onChangeText,onSubmitEditing,label,floating}) {
  return <View style={[row,{height:48,paddingHorizontal:16,borderRadius:floating?radius.pill:radius.md,backgroundColor:floating?c.surfaceRaised:c.surfaceSunken},floating&&shadow.card]}>
    <Search size={19} color={c.inkMuted}/><TextInput accessibilityLabel={label} placeholder={label} placeholderTextColor={c.inkMuted} value={value} onChangeText={onChangeText} returnKeyType="search" onSubmitEditing={onSubmitEditing} clearButtonMode="while-editing" style={{...type.body,flex:1,color:c.ink}}/></View>;
}
export function Chips({items,value,onChange}) {
  return <ScrollView horizontal showsHorizontalScrollIndicator={false} keyboardShouldPersistTaps="handled" contentContainerStyle={{gap:8}}>
    {items.map(([id,label])=><Press key={id} accessibilityRole="button" accessibilityState={{selected:id===value}} onPress={()=>onChange(id)} style={{height:36,paddingHorizontal:16,borderRadius:radius.pill,justifyContent:'center',borderWidth:1,borderColor:id===value?c.ink:c.line,backgroundColor:id===value?c.ink:c.surfaceRaised}}>
      <Text style={{...type.label,color:id===value?c.surface:c.ink}}>{label}</Text></Press>)}</ScrollView>;
}
export function PlaceCard({place,onPress}) {
  return <Press accessibilityRole="button" onPress={onPress} style={{width:250,borderRadius:radius.lg,backgroundColor:c.surfaceRaised,...shadow.card}}>
    <Photo place={place} credit style={{height:160,borderTopLeftRadius:radius.lg,borderTopRightRadius:radius.lg}}/>
    {!!km(place.distance) && <Text style={{...type.caption,color:c.ink,position:'absolute',right:12,top:12,backgroundColor:c.surfaceRaised,borderRadius:16,overflow:'hidden',paddingHorizontal:10,paddingVertical:4}}>{km(place.distance)}</Text>}
    <View style={{padding:16,gap:5}}><Text numberOfLines={1} style={eyebrow}>{meta(place)}</Text><Text numberOfLines={2} style={title}>{place.name}</Text><Text numberOfLines={2} style={muted}>{place.description}</Text></View></Press>;
}
export function PlaceRow({place,visited,onPress}) {
  return <Press accessibilityRole="button" onPress={onPress} style={[row,{minHeight:76,paddingVertical:8,borderBottomColor:c.line,borderBottomWidth:1}]}>
    <Photo place={place} credit style={{width:64,height:64,borderRadius:radius.sm}}/>
    <View style={{flex:1,gap:4}}><Text numberOfLines={1} style={eyebrow}>{meta(place)}</Text><Text style={title}>{place.name}{visited?' ✓':''}</Text></View>
    <Text style={{...type.label,color:c.ink}}>{km(place.distance)}</Text></Press>;
}
