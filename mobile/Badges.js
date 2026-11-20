import {c} from './theme';
import React, {useEffect, useRef, useState} from 'react';
import {ActivityIndicator, Animated, KeyboardAvoidingView, Modal, Platform, Pressable,
  ScrollView, StyleSheet, Text, TextInput, View} from 'react-native';
import Svg, {Defs, FeColorMatrix, Filter, G, Image as SvgImage} from 'react-native-svg';
import {SafeAreaView} from 'react-native-safe-area-context';
import {AsyncStorage, client, lang, project, t} from './client';
import {badgeImages} from './badgeImages';

function Button({label,onPress,disabled}) {
  return <Pressable accessibilityRole="button" onPress={onPress} disabled={disabled} style={styles.button}>
    <Text style={styles.link}>{label}</Text></Pressable>;
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
    <Button label={t('Giriş yap','Sign in')} disabled={disabled} onPress={() => submit(false)}/>
    <Button label={t('Hesap oluştur','Create account')} disabled={disabled} onPress={() => submit(true)}/>
    {busy && <ActivityIndicator/>}
    {!!message && <Text accessibilityLiveRegion="polite">{message}</Text>}
  </View>;
}

export function BadgeArt({badge}) {
  const local = badgeImages[badge.slug];
  const remote = badge.badge_path && client.storage.from('badges').getPublicUrl(badge.badge_path).data.publicUrl;
  const source = local || remote;
  const [loaded,setLoaded] = useState(false);
  const locked = !badge.earned_at;
  return <View accessible={false} style={[styles.art,locked && {opacity:0.4}]}>
    {!loaded && <Text style={styles.star}>✦</Text>}
    {!!source && <Svg width={76} height={76}>
      <Defs><Filter id="gray" x="0%" y="0%" width="100%" height="100%">
        <FeColorMatrix type="saturate" values="0"/>
      </Filter></Defs>
      <G filter={locked ? 'url(#gray)' : undefined}>
        <SvgImage href={source} x={0} y={0} width={76} height={76} onLoad={() => setLoaded(true)}/>
      </G>
    </Svg>}
  </View>;
}

function BadgeRow({badge,celebrate}) {
  const scale = useRef(new Animated.Value(1)).current;
  useEffect(() => {
    if (!celebrate) return;
    const motion = Animated.sequence([
      Animated.timing(scale,{toValue:1.15,duration:200,useNativeDriver:true}),
      Animated.spring(scale,{toValue:1,useNativeDriver:true})
    ]);
    motion.start();
    return () => motion.stop();
  },[celebrate,scale]);
  return <View style={styles.row}>
    <Animated.View style={{transform:[{scale}]}}><BadgeArt key={badge.slug + ':' + badge.badge_path} badge={badge}/></Animated.View>
    <View style={styles.copy}><Text style={styles.name}>{badge.name}</Text>
      {!!badge.description && <Text style={styles.body}>{badge.description}</Text>}
      <Text style={styles.progress}>{badge.earned_at ? t('Kazanıldı','Earned') : badge.progress + ' / ' + badge.target}</Text>
    </View>
  </View>;
}

function Collection({userId,visitRevision}) {
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
  return <>
    {!failed && !result && <ActivityIndicator/>}
    {failed && <Text>{t('Rozetler yüklenemedi.','Could not load badges.')}</Text>}
    {!!result && !result.badges.length && <Text>{t('Henüz rozet yok.','No badges yet.')}</Text>}
    {result?.badges.map(badge => <BadgeRow key={badge.slug} badge={badge} celebrate={result.fresh.includes(badge.slug)}/>)}
    <Button label={t('Yenile','Refresh')} onPress={() => setVersion(n => n+1)}/>
    <Button label={t('Çıkış yap','Sign out')} onPress={logout}/>
    {logoutError && <Text>{t('Çıkış yapılamadı. Tekrar dene.','Could not sign out. Try again.')}</Text>}
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
  title:{fontSize:32,color:c.ink,fontFamily:Platform.select({ios:'Georgia',android:'serif'})},
  stack:{padding:10,gap:12}, button:{minHeight:44,padding:10,justifyContent:'center'},
  link:{color:c.primary,fontWeight:'700',fontSize:16}, body:{color:c.inkMuted,fontSize:15,lineHeight:21},
  input:{backgroundColor:c.surfaceRaised,borderRadius:8,padding:12,color:c.ink,borderWidth:1,borderColor:c.line},
  row:{flexDirection:'row',alignItems:'center',gap:12,paddingVertical:12,borderBottomWidth:1,borderColor:c.line},
  art:{width:76,height:76,alignItems:'center',justifyContent:'center'}, star:{position:'absolute',fontSize:38,color:c.inkMuted},
  copy:{flex:1,gap:4}, name:{fontSize:18,fontWeight:'700',color:c.ink}, progress:{color:c.primary,fontWeight:'600'}
});
