import {c} from './theme';
import React, {useEffect,useRef,useState} from 'react';
import {ActivityIndicator, AppState, Linking, Pressable, StyleSheet, Text, View} from 'react-native';
import * as Location from 'expo-location';
import {client,lang,t} from './client';
import {Login} from './Badges';
import {checkinOutcome,distanceHint,sendCheckin} from './visitLogic';

export default function CheckIn({place,origin,visits,visited,onMissing,onAwards,cities}) {
  const [permission,setPermission] = useState(null);
  const [fix,setFix] = useState(null);
  const [busy,setBusy] = useState(false);
  const [login,setLogin] = useState(false);
  const [result,setResult] = useState(null);
  const lock = useRef(false);
  const mounted = useRef(true);
  const pendingLogin = useRef(false);
  const submitRef = useRef(null);
  const lastUser = useRef(visits.userId);

  useEffect(() => {
    mounted.current = true;
    let read = 0;
    async function inspectPermission() {
      const generation = ++read;
      try {
        const access = await Location.getForegroundPermissionsAsync();
        if (!mounted.current || generation !== read) return;
        setPermission(access);
        if (access.granted) {
          const last = await Location.getLastKnownPositionAsync({maxAge:60000});
          if (mounted.current && generation === read && last) setFix(last.coords);
        }
      } catch { /* The button can request a fresh reading. */ }
    }
    inspectPermission();
    const sub = AppState.addEventListener('change',state => { if (state === 'active') inspectPermission(); });
    return () => { mounted.current = false; sub.remove(); };
  },[]);

  function resume(id) {
    if (!pendingLogin.current || !id || !mounted.current) return;
    pendingLogin.current = false;
    setLogin(false);
    submitRef.current(id);
  }
  useEffect(() => {
    if (lastUser.current !== visits.userId) {
      lastUser.current = visits.userId;
      setResult(null);
      if (visits.userId) resume(visits.userId);
    }
  },[visits.userId]);

  function askLogin() {
    pendingLogin.current = true;
    setLogin(true);
  }

  async function submit(signedInId) {
    if (lock.current || !mounted.current) return;
    lock.current = true;
    setBusy(true);
    setResult(null);
    try {
      if (!client) {
        setResult({message:t('Ziyaret kaydı için canlı bağlantı gerekli.','Connect to the live service to check in.')});
        return;
      }
      let access = await Location.getForegroundPermissionsAsync();
      if (!mounted.current) return;
      if (!access.granted) {
        if (access.canAskAgain) access = await Location.requestForegroundPermissionsAsync();
        else { await Linking.openSettings(); return; }
      }
      if (!mounted.current) return;
      setPermission(access);
      if (!access.granted) {
        setResult({message:t('Ziyaretini doğrulamak için konum izni gerekli.','Location permission is needed to verify your visit.')});
        return;
      }
      const id = signedInId || visits.owner.current;
      if (!id) { askLogin(); return; }
      const {coords} = await Location.getCurrentPositionAsync({accuracy:Location.Accuracy.High});
      if (!mounted.current || visits.owner.current !== id) return;
      setFix(coords);
      const data = await sendCheckin((name,args) => client.functions.invoke(name,args),place.id,coords,lang);
      if (visits.owner.current !== id) return;
      const outcome = checkinOutcome(data,lang);
      if (outcome.action === 'record' || outcome.action === 'visited') {
        visits.record(id,place.id,outcome.action === 'record' ? new Date().toISOString() : null);
      }
      if (!mounted.current) return;
      setResult(outcome);
      if (outcome.action === 'login') askLogin();
      if (outcome.action === 'refresh') onMissing();
      if (outcome.awards?.length) onAwards(outcome.awards,id);
    } catch {
      if (mounted.current) setResult({message:t('Konum veya bağlantı alınamadı. Tekrar dene.','Location or connection unavailable. Try again.')});
    } finally {
      lock.current = false;
      if (mounted.current) setBusy(false);
    }
  }
  submitRef.current = submit;
  const date = visits.dates[place.id];
  const hint = permission?.granted && !visited ? distanceHint(place,fix || origin) : null;
  return <View style={styles.group}>
    {visited ? <Text style={styles.visited}>{t('Gezildi ✓','Visited ✓')}{date ? ' · '+new Date(date).toLocaleDateString(lang) : ''}</Text> :
      login ? <Login onSignedIn={resume} prompt={t('Devam etmek için giriş yap.','Sign in to continue.')}/> :
      <Pressable accessibilityRole="button" accessibilityState={{disabled:busy,busy}} disabled={busy}
        onPress={() => submit()} style={styles.button}>
        {busy ? <ActivityIndicator color={c.surfaceRaised}/> : <Text style={styles.buttonText}>
          {permission && !permission.granted ? t('Konumu aç','Turn on location') : t('Buradayım',"I'm here")}
        </Text>}
      </Pressable>}
    {hint !== null && <Text style={styles.note}>
      {t('Yaklaşık '+hint+' m uzaktasın.','You are about '+hint+' m away.')}
    </Text>}
    {!!result?.message && <Text accessibilityLiveRegion="polite" style={styles.note}>{result.message}</Text>}
    {!!result?.progress && <Text style={styles.visited}>{cities?.find(c => c.slug === result.progress.city)?.name || t('Şehir ilerlemesi','City progress')} · {result.progress.visited} / {result.progress.total}</Text>}
  </View>;
}

const styles = StyleSheet.create({
  group:{gap:7}, button:{backgroundColor:c.ink,padding:16,borderRadius:14,alignItems:'center',minHeight:50},
  buttonText:{fontSize:18,fontWeight:'700',color:c.surface}, visited:{fontWeight:'700',fontSize:17,color:c.primary},
  note:{fontSize:15,color:c.inkMuted}
});
