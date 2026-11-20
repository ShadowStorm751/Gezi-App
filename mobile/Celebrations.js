import {badgeForPlace} from './badgeProgress';
import React,{useEffect} from 'react';
import {Pressable,ScrollView,Share,StyleSheet,Text,View,useWindowDimensions} from 'react-native';
import {SafeAreaView} from 'react-native-safe-area-context';
import Animated,{Easing,cancelAnimation,useAnimatedProps,useAnimatedStyle,useReducedMotion,useSharedValue,withDelay,withRepeat,withSequence,withSpring,withTiming} from 'react-native-reanimated';
import Svg,{Path} from 'react-native-svg';
import {Award,Camera,Share2,TriangleAlert,X} from 'lucide-react-native';
import * as Haptics from 'expo-haptics';
import {BadgeArt} from './Badges';
import {Press,Progress,Reveal,ease} from './Motion';
import {useQuery} from './ScreenUI';
import {lang,t} from './client';
import {c,type,radius} from './theme';

const APath=Animated.createAnimatedComponent(Path);
const center={alignItems:'center',justifyContent:'center'};
const copy={...type.body,color:c.inkMuted,textAlign:'center'};
const spring={damping:12,stiffness:180};
function haptic(success){Haptics.notificationAsync(success?Haptics.NotificationFeedbackType.Success:Haptics.NotificationFeedbackType.Warning).catch(()=>{});}
function Btn({label,onPress,icon:Icon,color=c.onPrimary,bg=c.primary,outline=false,style}) {
  return <Press accessibilityRole="button" onPress={onPress} style={[center,{flexDirection:'row',gap:8,minHeight:52,paddingHorizontal:12,borderRadius:radius.md,backgroundColor:bg,borderWidth:outline?1:0,borderColor:c.inkMuted},style]}>
    {Icon&&<Icon size={17} color={color}/>}<Text style={{...type.label,fontSize:15,color}}>{label}</Text></Press>;
}
function Pulse({size,delay=800,count=2}) {
  const reduce=useReducedMotion(),p=useSharedValue(0);
  useEffect(()=>{if(!reduce)p.value=withDelay(delay,withRepeat(withTiming(1,{duration:count===1?700:600}),count,false));return ()=>cancelAnimation(p);},[p,reduce,delay,count]);
  const motion=useAnimatedStyle(()=>({opacity:reduce?0:(p.value>0?(1-p.value)*.65:0),transform:[{scale:1+.4*p.value}]}));
  return <Animated.View pointerEvents="none" style={[{position:'absolute',width:size,height:size,borderRadius:size/2,borderWidth:3,borderColor:c.ring},motion]}/>;
}
function Seal({success}) {
  const reduce=useReducedMotion(),scale=useSharedValue(reduce||!success?1:.4),x=useSharedValue(0),stroke=useSharedValue(reduce?0:24);
  useEffect(()=>{if(reduce)return;if(success){scale.value=withDelay(260,withSequence(withTiming(1.12,{duration:230,easing:ease}),withSpring(1,spring)));stroke.value=withDelay(560,withTiming(0,{duration:300}));}else{x.value=withSequence(withRepeat(withSequence(withTiming(-6,{duration:25}),withTiming(6,{duration:50}),withTiming(0,{duration:25})),3,false),withTiming(0));}},[success,reduce]);
  const move=useAnimatedStyle(()=>({transform:[{scale:scale.value},{translateX:x.value}]})),props=useAnimatedProps(()=>({strokeDashoffset:stroke.value}));
  return <Animated.View style={[center,{alignSelf:'center',width:84,height:84,borderRadius:42,backgroundColor:success?c.primarySoft:c.accentSoft},move]}><View style={[center,{width:60,height:60,borderRadius:30,backgroundColor:success?c.primary:c.accent}]}>
    {success?<Svg width={30} height={30} viewBox="0 0 24 24"><APath d="m4 12 5 5 11-11" fill="none" stroke={c.onPrimary} strokeWidth={2.6} strokeLinecap="round" strokeLinejoin="round" strokeDasharray="24 24" animatedProps={props}/></Svg>:<TriangleAlert color={c.onAccent}/>}</View></Animated.View>;
}
export function VisitSheet({result,place,onClose,onAward,onPhoto}) {
  const {height}=useWindowDimensions(),success=result.action==='record',award=result.awards?.[0];
  const query=useQuery(success&&result.userId?'my_achievements':null,{lang},result.userId);
  const slug=award?.slug || badgeForPlace(place);
  const badge=query.data?.find(b=>b.slug===slug);
  const oldBadge=result.previousBadges?.find(b=>b.slug===slug);
  const progress=badge||result.progress;
  const value=badge?badge.progress:progress?.visited,target=badge?badge.target:progress?.total;
  const previous=badge?(oldBadge?.progress??value):value;
  useEffect(()=>{haptic(success);if(!award)return;const timer=setTimeout(()=>Haptics.impactAsync(Haptics.ImpactFeedbackStyle.Medium).catch(()=>{}),1480);return ()=>clearTimeout(timer);},[success,award]);
  return <View accessibilityViewIsModal style={[StyleSheet.absoluteFill,{justifyContent:'flex-end'}]}>
    <Reveal duration={220} offset={0} style={[StyleSheet.absoluteFill,{backgroundColor:c.scrim}]}><Pressable accessibilityLabel={t('Kapat','Close')} onPress={onClose} style={{flex:1}}/></Reveal>
    <Reveal offset={height*.75} duration={320} style={{maxHeight:'92%',backgroundColor:c.surfaceRaised,borderTopLeftRadius:28,borderTopRightRadius:28}}><SafeAreaView edges={['bottom']}><ScrollView contentContainerStyle={{padding:20,gap:14}}>
      <View style={{alignSelf:'center',width:40,height:5,borderRadius:3,backgroundColor:c.line}}/><Seal success={success}/>
      <Reveal delay={success?640:0} offset={10} duration={260}><Text style={{...type.title,color:c.ink,textAlign:'center'}}>{success?t('Buradasın','You’re here'):t('Ziyaret bilgisi','Visit update')}</Text><Text style={copy}>{success?t(place.name+' ziyaretin kaydedildi.','Your visit to '+place.name+' was saved.'):result.message}</Text>{success && result.progress && (badge||award) && <Text style={copy}>{result.cityName||t('Şehir ilerlemesi','City progress')} · {result.progress.visited}/{result.progress.total}</Text>}</Reveal>
      {success && (progress||award) && <Reveal delay={760} offset={10} style={{backgroundColor:c.goldSoft,borderRadius:20,padding:16,flexDirection:'row',alignItems:'center',gap:12}}>
        {(award||badge) && <View style={center}>{award && <Pulse size={52} delay={1480} count={1}/>}<BadgeArt badge={badge||{...award,earned_at:true}} size={52}/></View>}
        <View style={{flex:1,gap:7}}><Text style={{...type.label,color:c.goldInk}}>{award?.name||badge?.name||result.cityName||t('Şehir ilerlemesi','City progress')}{target && (!award||badge)?' · '+value+' / '+target:''}</Text>
        {!!target && (!award||badge) && <Progress key={badge?.slug||'city'} from={previous/target} value={value/target} delay={960}/>}
        {!!award && <Text style={{...type.caption,color:c.goldInk}}>{t('Yeni rozet kazandın.','You earned a badge.')}</Text>}</View></Reveal>}
      <Reveal delay={success?1100:0} style={{gap:4}}><Btn label={award?t('Rozeti gör','View badge'):t('Devam et','Continue')} onPress={award?onAward:onClose}/>{success && onPhoto && <Btn label={t('Bu ziyarete fotoğraf ekle','Add a visit photo')} icon={Camera} color={c.primary} bg={c.surfaceRaised} onPress={onPhoto}/>}</Reveal>
    </ScrollView></SafeAreaView></Reveal></View>;
}
function Medal({badge,size}) {
  const reduce=useReducedMotion(),s=useSharedValue(reduce?1:.3),angle=useSharedValue(reduce?0:-12),spin=useSharedValue(0),ring=useSharedValue(reduce?1:.6);
  useEffect(()=>{if(reduce)return;s.value=withDelay(150,withSequence(withTiming(1.08,{duration:350,easing:ease}),withTiming(.97,{duration:150}),withTiming(1,{duration:150})));angle.value=withDelay(150,withSequence(withTiming(3,{duration:380}),withTiming(0,{duration:270})));spin.value=withRepeat(withTiming(360,{duration:40000,easing:Easing.linear}),-1,false);ring.value=withDelay(350,withTiming(1,{duration:600}));return ()=>cancelAnimation(spin);},[reduce]);
  const medal=useAnimatedStyle(()=>({transform:[{scale:s.value},{rotate:angle.value+'deg'}]})),rays=useAnimatedStyle(()=>({transform:[{rotate:spin.value+'deg'}]})),rings=useAnimatedStyle(()=>({transform:[{scale:ring.value}],opacity:ring.value}));
  return <View accessible={false} style={[center,{height:size*1.5}]}>
    <Reveal delay={200} duration={600} offset={0} style={[StyleSheet.absoluteFill,center]}><Animated.View style={[center,rays]}>{Array.from({length:8},(_,i)=><View key={i} style={{position:'absolute',width:18,height:size*2,backgroundColor:c.gold,opacity:.09,transform:[{rotate:i*22.5+'deg'}]}}/>)}</Animated.View></Reveal>
    <Animated.View style={[StyleSheet.absoluteFill,center,rings]}>{[1.27,1.56].map(r=><View key={r} style={{position:'absolute',height:size*r,width:size*r,borderRadius:size*r,borderWidth:1,borderColor:c.gold,opacity:.35}}/>)}</Animated.View>
    {Array.from({length:8},(_,i)=><Reveal key={i} delay={700+i*20} offset={8} style={{position:'absolute',left:(50+43*Math.cos(i*.785))+'%',top:(48+43*Math.sin(i*.785))+'%',height:6+i%3,width:6+i%3,borderRadius:6,backgroundColor:[c.ring,c.accent,c.celebrationText][i%3]}}/>)}
    <Pulse size={size}/><Animated.View style={[center,{width:size,height:size,borderRadius:size/2,borderWidth:6,borderColor:c.ring,backgroundColor:c.goldSoft},medal]}><BadgeArt size={size*.8} badge={{...badge,earned_at:true}}/></Animated.View>
  </View>;
}
export function Ceremony({badge,onNext,onClose,onBadges,userId}) {
  const {width,height}=useWindowDimensions(),query=useQuery('my_achievements',{lang},[badge.slug,userId]);
  const earned=(query.data||[]).filter(b=>b.earned_at).sort((a,b)=>a.earned_at.localeCompare(b.earned_at)),index=earned.findIndex(b=>b.slug===badge.slug);
  useEffect(()=>haptic(true),[badge.slug]);
  return <Reveal offset={0} duration={300} style={[StyleSheet.absoluteFill,{backgroundColor:c.ink}]}><SafeAreaView accessibilityViewIsModal style={{flex:1}}><ScrollView contentContainerStyle={{flexGrow:1,padding:20,justifyContent:'space-between',gap:14}}>
    <Press accessibilityRole="button" accessibilityLabel={t('Kapat','Close')} onPress={onClose} style={[center,{alignSelf:'flex-end',height:44,width:44,borderRadius:22,backgroundColor:c.primary}]}><X color={c.surface}/></Press>
    <View style={{gap:8}}><Medal badge={badge} size={Math.min(220,width*.56,height*.27)}/>
      {[t('YENİ ROZET','NEW BADGE'),badge.name,badge.description].map((line,i)=>!!line && <Reveal key={i} delay={650+i*110} offset={12}><Text style={[{textAlign:'center'},i===0?{...type.eyebrow,color:c.ring}:i===1?{...type.display,fontSize:38,lineHeight:44,color:c.surface}:{...type.bodyLg,color:c.celebrationText}]}>{line}</Text></Reveal>)}
      <Reveal delay={980} offset={12} style={{flexDirection:'row',justifyContent:'center',gap:8}}>{[index>=0?(lang==='tr'?query.data.length+' rozetten '+(index+1)+'.':'Badge '+(index+1)+' of '+query.data.length):null,new Date(index>=0?earned[index].earned_at:Date.now()).toLocaleDateString(lang,{day:'numeric',month:'long',year:'numeric'})].filter(Boolean).map(v=><Text key={v} style={{...type.caption,color:c.surface,backgroundColor:c.primary,borderRadius:14,overflow:'hidden',padding:8}}>{v}</Text>)}</Reveal></View>
    <Reveal delay={1150} style={{gap:10}}><Btn label={t('Devam et','Continue')} color={c.ink} bg={c.ring} onPress={onNext}/><View style={{flexDirection:'row',gap:10}}>
      <Btn style={{flex:1}} outline bg={c.clear} icon={Award} label={t('Rozetlerim','My badges')} onPress={onBadges}/><Btn style={{flex:1}} outline bg={c.clear} icon={Share2} label={t('Paylaş','Share')} onPress={()=>Share.share({message:[badge.name,badge.description].filter(Boolean).join('\n')}).catch(()=>{})}/></View></Reveal>
  </ScrollView></SafeAreaView></Reveal>;
}
