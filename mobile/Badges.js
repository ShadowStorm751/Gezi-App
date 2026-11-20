import Animated,{useSharedValue,useAnimatedStyle,useReducedMotion,withSequence,withSpring,withTiming} from 'react-native-reanimated';
import {Press,Progress,Reveal,Skeleton} from './Motion';
import {Chips,muted} from './PlaceUI';
import {panel} from './TabPage';
import {c,radius,space,type} from './theme';
import React, {useEffect, useState} from 'react';
import {ActivityIndicator, KeyboardAvoidingView, Modal, Platform, useWindowDimensions,
  ScrollView, StyleSheet, Text, TextInput, View} from 'react-native';
import Svg, {Defs, FeColorMatrix, Filter, G, Image as SvgImage} from 'react-native-svg';
import {SafeAreaView} from 'react-native-safe-area-context';
import {AsyncStorage, client, lang, project, t} from './client';
import {badgeImages} from './badgeImages';

function Button({label,onPress,disabled,primary=false}) {
  return <Press accessibilityRole="button" onPress={onPress} disabled={disabled} accessibilityState={{disabled:!!disabled}}
    style={[styles.button,primary && styles.primaryButton,disabled && {opacity:0.55}]}>
    <Text style={[styles.link,primary && {color:c.onPrimary}]}>{label}</Text></Press>;
}

export function Login({onSignedIn, prompt}) {
  const [email,setEmail] = useState('');
  const [password,setPassword] = useState('');
  const [busy,setBusy] = useState(false);
  const [message,setMessage] = useState('');
  async function submit(register) {
    setBusy(true);
    setMessage('');
    try {
      const credentials = {email:email.trim(),password};
      const result = register ? await client.auth.signUp(credentials) : await client.auth.signInWithPassword(credentials);
      if (result.error) throw result.error;
      setPassword('');
      if (result.data.session) onSignedIn?.(result.data.session.user.id);
      if (register && !result.data.session) setMessage(t('E-postandaki bağlantıyı onayladıktan sonra giriş yap.',
        'Confirm the link in your email, then sign in.'));
    } catch {
      setMessage(register ? t('Kayıt tamamlanamadı. E-postanı ve parolanı kontrol et.','Could not register. Check your email and password.') :
        t('Giriş yapılamadı. Bilgilerini ve bağlantını kontrol et.','Could not sign in. Check your credentials and connection.'));
    } finally { setBusy(false); }
  }
  const disabled = busy || !email.trim() || !password;
  return <View style={styles.stack}>
    <Text style={styles.body}>{prompt || t('Rozetlerini ve ilerlemeni görmek için giriş yap.','Sign in to see your badges and progress.')}</Text>
    <TextInput value={email} onChangeText={setEmail} placeholder={t('E-posta','Email')} accessibilityLabel={t('E-posta','Email')}
      keyboardType="email-address" autoCapitalize="none" autoCorrect={false} autoComplete="email" style={styles.input}/>
    <TextInput value={password} onChangeText={setPassword} placeholder={t('Parola','Password')} accessibilityLabel={t('Parola','Password')}
      secureTextEntry autoCapitalize="none" style={styles.input}/>
    <Button primary label={t('Giriş yap','Sign in')} disabled={disabled} onPress={() => submit(false)}/>
    <Button label={t('Hesap oluştur','Create account')} disabled={disabled} onPress={() => submit(true)}/>
    {busy && <ActivityIndicator/>}
    {!!message && <Text accessibilityLiveRegion="polite">{message}</Text>}
  </View>;
}

export function BadgeArt({badge,size=76}) {
  const local = badgeImages[badge.slug];
  const remote = badge.badge_path && client?.storage.from('badges').getPublicUrl(badge.badge_path).data.publicUrl;
  const source = local || remote;
  const [loaded,setLoaded] = useState(false);
  const locked = !badge.earned_at;
  return <View accessible={false} style={[styles.art,{width:size,height:size},locked && {opacity:0.4}]}>
    {!loaded && <Text style={styles.star}>✦</Text>}
    {!!source && <Svg width={size} height={size}>
      <Defs><Filter id="gray" x="0%" y="0%" width="100%" height="100%">
        <FeColorMatrix type="saturate" values="0"/>
      </Filter></Defs>
      <G filter={locked ? 'url(#gray)' : undefined}>
        <SvgImage href={source} x={0} y={0} width={size} height={size} onLoad={() => setLoaded(true)}/>
      </G>
    </Svg>}
  </View>;
}

export function BadgeLogin() {
  return <View style={panel}>
    <View style={styles.preview} accessible={false} accessibilityElementsHidden importantForAccessibility="no-hide-descendants">
      {['first-step','ottoman-heritage','first-view'].map(slug=><View key={slug} style={styles.previewRing}>
        <BadgeArt badge={{slug,earned_at:true}} size={48}/>
      </View>)}
    </View>
    <Login/>
  </View>;
}

function BadgeTile({badge,celebrate,width}) {
  const scale=useSharedValue(1),reduce=useReducedMotion();
  useEffect(()=>{
    scale.value=celebrate&&!reduce ? withSequence(withTiming(1.12,{duration:200}),withSpring(1)) : 1;
  },[celebrate,reduce,scale]);
  const motion=useAnimatedStyle(()=>({transform:[{scale:scale.value}]}));
  const earned=!!badge.earned_at;
  return <View style={[styles.tile,{width}]}>
    <Animated.View style={[styles.medal,earned && styles.earnedMedal,motion]}>
      <BadgeArt badge={badge}/>
    </Animated.View>
    <Text style={styles.name}>{badge.name}</Text>
    {!!badge.description && <Text style={styles.description}>{badge.description}</Text>}
    <View style={styles.tileFooter}>
      {!earned && badge.target>0 && <Progress value={badge.progress/badge.target}/>}
      <Text style={[styles.status,earned && {color:c.goldInk}]}>
        {earned ? t('Kazanıldı','Earned') : badge.target>0 ? badge.progress+' / '+badge.target : t('Kilitli','Locked')}
      </Text>
    </View>
  </View>;
}

export function Collection({userId,visitRevision}) {
  const {width,fontScale}=useWindowDimensions();
  const [filter,setFilter]=useState('all');
  const [version,setVersion] = useState(0);
  const [result,setResult] = useState(null);
  const [failed,setFailed] = useState(false);
  const [logoutError,setLogoutError] = useState(false);
  useEffect(() => {
    let active = true;
    setFailed(false);
    setResult(null);
    const key = 'gezi:earned:' + project + ':' + userId;
    async function load() {
      const {data,error} = await client.rpc('my_achievements',{lang});
      if (error || !Array.isArray(data)) throw new Error('my_achievements');
      const earned = data.filter(badge => badge.earned_at).map(badge => badge.slug);
      let previous;
      try { previous = JSON.parse(await AsyncStorage.getItem(key)); } catch {}
      if (!active) return;
      const fresh = Array.isArray(previous) ? earned.filter(slug => !previous.includes(slug)) : [];
      setResult({badges:data,fresh});
      await AsyncStorage.setItem(key,JSON.stringify(earned)).catch(() => {});
    }
    load().catch(() => { if (active) setFailed(true); });
    return () => { active=false; };
  },[userId,version,visitRevision]);
  async function logout() {
    try { const {error} = await client.auth.signOut({scope:'local'}); setLogoutError(!!error); }
    catch { setLogoutError(true); }
  }
  const badges=result?.badges || [];
  const earned=badges.filter(b=>b.earned_at).length;
  const visible=badges.filter(b=>filter==='all' || (filter==='earned' ? !!b.earned_at : !b.earned_at));
  const filters=[['all',t('Tümü','All')],['earned',t('Kazanılan','Earned')],['locked',t('Kilitli','Locked')]];
  const tileWidth=width<350 || fontScale>1.35 ? '100%' : width>=720 ? '32%' : '48.5%';
  return <>
    {!failed && !result && <Skeleton/>}
    {failed && <Text accessibilityLiveRegion="polite" style={muted}>{t('Rozetler yüklenemedi.','Could not load badges.')}</Text>}
    {result && (badges.length ? <>
      <Reveal style={styles.collectionSummary}>
        <Text style={styles.count}>{earned} / {badges.length}</Text>
        <Text style={styles.summaryLabel}>{t('Kazanılan rozetler','Badges earned')}</Text>
        <Progress value={earned/badges.length}/>
      </Reveal>
      <Chips items={filters} value={filter} onChange={setFilter}/>
      {visible.length ? <View style={styles.grid}>{visible.map(badge=>
        <BadgeTile key={badge.slug} badge={badge} width={tileWidth} celebrate={result.fresh.includes(badge.slug)}/>
      )}</View> : <Text style={muted}>{filter==='earned'
        ? t('Henüz rozet kazanmadın.','You haven’t earned a badge yet.')
        : t('Tüm rozetleri kazandın.','You’ve earned every badge.')}</Text>}
    </> : <Text style={muted}>{t('Henüz rozet yok.','No badges yet.')}</Text>)}
    <View style={styles.tools}>
      <Button label={t('Yenile','Refresh')} onPress={()=>setVersion(n=>n+1)}/>
      <Button label={t('Çıkış yap','Sign out')} onPress={logout}/>
    </View>
    {logoutError && <Text style={muted}>{t('Çıkış yapılamadı. Tekrar dene.','Could not sign out. Try again.')}</Text>}
  </>;
}

export default function Badges({onClose,visitRevision}) {
  const [user,setUser] = useState(undefined);
  useEffect(() => {
    if (!client) return;
    const {data} = client.auth.onAuthStateChange((_event,session) => setUser(session?.user.id ?? null));
    return () => data.subscription.unsubscribe();
  },[]);
  return <Modal visible animationType="slide" onRequestClose={onClose}><SafeAreaView style={styles.page}>
    <View style={styles.header}><Text accessibilityRole="header" style={styles.title}>{t('Rozetler','Badges')}</Text>
      <Button label={t('Kapat','Close')} onPress={onClose}/></View>
    <KeyboardAvoidingView style={{flex:1}} behavior={Platform.OS === 'ios' ? 'padding' : undefined}>
      <ScrollView keyboardShouldPersistTaps="handled" contentContainerStyle={styles.stack}>
        {!client ? <Text>{t('Rozetler için Supabase bağlantısı gerekiyor.','Connect to Supabase to view badges.')}</Text> :
          user === undefined ? <ActivityIndicator/> : user ? <Collection key={user} userId={user} visitRevision={visitRevision}/> : <Login/>}
      </ScrollView>
    </KeyboardAvoidingView>
  </SafeAreaView></Modal>;
}

const styles = StyleSheet.create({
  page:{flex:1,backgroundColor:c.surface,padding:18}, header:{flexDirection:'row',justifyContent:'space-between',alignItems:'center'},
  title:{...type.display,color:c.ink},
  stack:{gap:space[2]}, button:{minHeight:44,padding:space[2],alignItems:'center',justifyContent:'center',borderRadius:radius.md},
  primaryButton:{backgroundColor:c.primary},link:{...type.label,color:c.primary},body:{...type.body,color:c.inkMuted},
  input:{...type.body,backgroundColor:c.surfaceRaised,borderRadius:radius.md,padding:space[3],color:c.ink,borderWidth:1,borderColor:c.line},
  preview:{flexDirection:'row',justifyContent:'center',gap:space[2],paddingVertical:space[3],backgroundColor:c.goldSoft,borderRadius:radius.md},
  previewRing:{borderWidth:2,borderColor:c.gold,borderRadius:30,padding:2,backgroundColor:c.surface},
  collectionSummary:{backgroundColor:c.goldSoft,padding:space[5],borderRadius:radius.lg,gap:space[2]},
  count:{...type.display,color:c.goldInk},summaryLabel:{...type.label,color:c.goldInk},
  grid:{flexDirection:'row',flexWrap:'wrap',justifyContent:'space-between',rowGap:space[3]},
  tile:{...panel,alignItems:'center',gap:space[2]},
  medal:{width:84,height:84,borderRadius:42,borderWidth:3,borderColor:c.line,backgroundColor:c.surfaceSunken,alignItems:'center',justifyContent:'center'},
  earnedMedal:{borderColor:c.gold,backgroundColor:c.goldSoft},
  art:{alignItems:'center',justifyContent:'center'},star:{position:'absolute',fontSize:38,color:c.inkMuted},
  name:{...type.cardTitle,color:c.ink,textAlign:'center'},
  description:{...type.caption,color:c.inkMuted,textAlign:'center'},
  tileFooter:{marginTop:'auto',alignSelf:'stretch',paddingTop:4,gap:4},
  status:{...type.caption,color:c.inkMuted,textAlign:'center'},
  tools:{flexDirection:'row',justifyContent:'space-between'},
});
