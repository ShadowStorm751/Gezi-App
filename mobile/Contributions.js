import React, {useState} from 'react';
import {Text, TextInput, View} from 'react-native';
import MapView, {Marker} from 'react-native-maps';
import {categoryNames} from './catalog';
import {lang,t} from './client';
import {Login} from './Badges';
import {contributionPayload} from './communityLogic';
import {Action, Feedback, rpc, ui, useAction, useQuery} from './ScreenUI';

const reasons = {
  wrong_location:['Konum yanlış','Wrong location'], wrong_info:['Bilgi yanlış','Incorrect information'],
  closed:['Kapanmış','Permanently closed'], duplicate:['Listede iki kez var','Duplicate listing']
};
const statuses = {open:['Bekliyor','Pending'],accepted:['Kabul edildi','Accepted'],rejected:['Reddedildi','Rejected']};

export function ContributionForm({place,coordinate,userId,onClose}) {
  const [pin,setPin] = useState(coordinate);
  const [kind,setKind] = useState('wrong_info');
  const [category,setCategory] = useState(null);
  const [name,setName] = useState('');
  const [note,setNote] = useState('');
  const [receipt,setReceipt] = useState(null);
  const action = useAction();
  if (!userId) return <Login prompt={t('Katkıda bulunmak için giriş yap.','Sign in to contribute.')}/>;
  if (receipt) return <View style={ui.card}><Text style={ui.heading}>{t('Katkın incelemeye gönderildi.','Submitted for review.')}</Text>
    {!!receipt.possible_duplicates?.length && <><Text>{t('Bunlardan biri mi?','Could it be one of these?')}</Text>
      {receipt.possible_duplicates.map(p => <Text key={p.id}>{p.name} · {Math.round(p.distance_m)} m</Text>)}</>}
    <Action onPress={onClose}>{t('Bitti','Done')}</Action></View>;
  const showMap = !place || kind === 'wrong_location';
  function submit() {
    action.run(async () => {
      const args = contributionPayload({placeId:place?.id,kind,name,category,pin,note,lang});
      const result = await rpc(place ? 'report_place' : 'suggest_place',args);
      if (!result?.ok) throw new Error('submission');
      setReceipt(result);
    });
  }
  return <View style={ui.card}>
    <Text style={ui.heading}>{place ? t('Bir sorun mu var?','Report a problem') : t('Yer öner','Suggest a place')}</Text>
    {place ? <View style={ui.row}>{Object.entries(reasons).map(([id,label]) =>
      <Action key={id} selected={kind === id} onPress={() => setKind(id)}>{t(...label)}</Action>)}</View> :
    <><TextInput style={ui.input} placeholder={t('Yer adı','Place name')} value={name} onChangeText={setName} maxLength={120}/>
      <Text>{t('Kategori','Category')}</Text><View style={ui.row}>{Object.entries(categoryNames).map(([id,label]) =>
        <Action key={id} selected={id === category} onPress={() => setCategory(id)}>{t(...label)}</Action>)}</View></>}
    {showMap && <><Text>{t('Konumu seçmek için haritaya dokun veya iğneyi sürükle.','Tap the map or drag the pin to choose a location.')}</Text>
      <MapView style={ui.map} initialRegion={{...pin,latitudeDelta:0.012,longitudeDelta:0.012}} onPress={e => setPin(e.nativeEvent.coordinate)}>
        <Marker draggable coordinate={pin} onDragEnd={e => setPin(e.nativeEvent.coordinate)}/></MapView></>}
    <TextInput style={ui.input} multiline maxLength={1000} value={note} onChangeText={setNote} placeholder={t('Not (isteğe bağlı)','Note (optional)')}/>
    <Action disabled={action.busy || (!place && (name.trim().length < 2 || !category))} onPress={submit}>{t('Gönder','Submit')}</Action>
    {!!action.message && <Text accessibilityLiveRegion="polite">{action.message}</Text>}
    <Action onPress={onClose} disabled={action.busy}>{t('Vazgeç','Cancel')}</Action>
  </View>;
}

export function Submissions({userId}) {
  const query = useQuery('my_submissions',{lang},userId);
  return <><Text style={ui.heading}>{t('Katkılarım','My contributions')}</Text><Feedback query={query}/>
    {query.data?.length === 0 && <Text>{t('Henüz katkın yok.','No submissions yet.')}</Text>}
    {query.data?.map(row => <View key={row.id} style={ui.card}><Text style={ui.label}>{row.place_name || row.suggested_name || t('Yer bildirimi','Place report')}</Text>
      <Text>{t(...statuses[row.status])} · {new Date(row.created_at).toLocaleDateString(lang)}</Text>
      {!!row.admin_note && <Text>{t('Yönetici notu','Reviewer note')} · {row.admin_note}</Text>}</View>)}
  </>;
}
