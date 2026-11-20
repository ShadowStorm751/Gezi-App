import {c,type,radius} from './theme';
import {Press,Skeleton} from './Motion';
import React, {useEffect, useRef, useState} from 'react';
import {ActivityIndicator, Pressable, StyleSheet, Text, View} from 'react-native';
import {client, t} from './client';

export async function rpc(name, args) {
  const {data, error} = await client.rpc(name, args);
  if (error) throw error;
  if (data?.ok === false) throw Object.assign(new Error(name), {code:data.error});
  return data;
}

const errors = {
  username_required:['Önce profilden kullanıcı adını seç.','Choose a username in your profile first.'],
  '23505':['Bu kullanıcı adı alınmış.','This username is taken.'],
  '23514':['Kullanıcı adını kontrol et.','Check your username.'],
  user_not_found:['Kullanıcı bulunamadı.','User not found.'],
  already_requested:['İsteğin bekliyor.','Your request is pending.'],
  already_friends:['Zaten arkadaşsınız.','You are already friends.'],
  cannot_add_self:['Kendini ekleyemezsin.','You cannot add yourself.'],
  request_not_found:['İstek artık geçerli değil.','This request is no longer available.'],
  not_friends:['Arkadaşlık veya istek bulunamadı.','Friendship or request not found.'],
  friend_limit:['Arkadaş sınırına ulaştın.','Friend limit reached.'],
  already_reported:['Bunu zaten bildirdin, inceliyoruz.','Your previous submission is under review.'],
  outside_service_area:['Bu bölge henüz uygulamada yok.','This area is not supported yet.'],
  invalid_input:['Bilgileri kontrol et.','Check the information you entered.'],
  unknown_category:['Geçerli bir kategori seç.','Select a valid category.'],
  place_not_found:['Bu yer bulunamadı.','Place not found.'],
  rate_limited:['Gönderim sınırına ulaştın. Daha sonra tekrar dene.','Submission limit reached. Try again later.'],
  not_authenticated:['Devam etmek için giriş yap.','Sign in to continue.'],
};
export function errorText(e) {
  return t(...(errors[e?.code] || ['İşlem tamamlanamadı. Tekrar dene.','Could not complete the request. Try again.']));
}

// Ignore late responses after navigation, account changes, or a newer request.
export function useQuery(name, args, revision = 0) {
  const key = JSON.stringify([name, args, revision]);
  const [attempt, retry] = useState(0);
  const [state, set] = useState(null);
  useEffect(() => {
    if (!name || !client) return;
    let active = true;
    const [, params] = JSON.parse(key);
    rpc(name, params).then(data => { if (active) set({key, attempt, data}); })
      .catch(error => { if (active) set({key, attempt, error}); });
    return () => { active = false; };
  }, [key, attempt, name]);
  const current = state?.key === key && state?.attempt === attempt ? state : null;
  return {...current, loading:!!name && !!client && !current, retry:() => retry(n => n+1)};
}

export function useAction() {
  const lock = useRef(false);
  const [busy,setBusy] = useState(false);
  const [message,setMessage] = useState('');
  async function run(work) {
    if (lock.current) return;
    lock.current = true;
    setBusy(true);
    setMessage('');
    try { await work(); } catch (error) { setMessage(errorText(error)); }
    finally { lock.current = false; setBusy(false); }
  }
  return {busy,message,run,setMessage};
}

export function Action({children,onPress,disabled,selected,danger}) {
  return <Press accessibilityRole="button" accessibilityState={{disabled:!!disabled,selected:!!selected}}
    disabled={disabled} onPress={onPress} style={[ui.button,selected && ui.selected,disabled && {opacity:0.5}]}>
    <Text style={[ui.label,selected && {color:c.surfaceRaised},danger && {color:c.danger}]}>{children}</Text>
  </Press>;
}
export function Feedback({query}) {
  if (query.loading) return <Skeleton/>;
  if (!query.error) return null;
  return <View><Text>{errorText(query.error)}</Text><Action onPress={query.retry}>{t('Tekrar dene','Retry')}</Action></View>;
}
export const ui = StyleSheet.create({
  page:{flex:1,backgroundColor:c.surface}, content:{padding:18,gap:12,paddingBottom:40},
  title:{...type.title,color:c.ink}, heading:{...type.heading,color:c.ink},
  row:{flexDirection:'row',flexWrap:'wrap',alignItems:'center',gap:6},
  card:{backgroundColor:c.surfaceSunken,borderRadius:14,padding:14,gap:6},
  button:{minHeight:48,justifyContent:'center',paddingHorizontal:12,paddingVertical:8,borderRadius:10,backgroundColor:c.surfaceRaised,borderWidth:1,borderColor:c.line},
  selected:{backgroundColor:c.primary},label:{...type.label,color:c.ink},
  input:{minHeight:44,borderColor:c.line,borderWidth:1,borderRadius:10,padding:10,color:c.ink,backgroundColor:c.surfaceRaised},
  map:{height:215,borderRadius:12}, muted:{color:c.inkMuted}, notice:{color:c.accentInk}
});
