import React, {useState} from 'react';
import {Alert, Modal, Text, TextInput, View} from 'react-native';
import {lang,t} from './client';
import {Ceremony} from './Celebrations';
import {Avatar} from './Profile';
import {Action,Feedback,rpc,ui,useAction,useQuery} from './ScreenUI';

const periods = {week:['Bu hafta','This week'],month:['Bu ay','This month'],year:['Bu yıl','This year'],all:['Tüm zamanlar','All time']};
const awardNames = {'first-friend':['Gezi Arkadaşı','Travel Buddy'],'travel-crew':['Gezi Ekibi','Travel Crew']};

export default function Friends({onProfile,onBadges,userId}) {
  const [tab,setTab] = useState('friends');
  const [period,setPeriod] = useState('week');
  const [input,setInput] = useState('');
  const [search,setSearch] = useState('');
  const [revision,setRevision] = useState(0);
  const [awards,setAwards] = useState([]);
  const action = useAction();
  const friends = useQuery('my_friends',{},revision);
  const results = useQuery(search ? 'search_users' : null,{query:search,max_results:10},revision);
  const board = useQuery(tab === 'rank' ? 'friends_leaderboard' : null,{period,city_slug:null},revision);
  const badge = awards[0];
  async function change(call,username,extra={}) {
    await action.run(async () => {
      let result;
      try { result = await rpc(call,{username,...extra}); }
      catch (error) {
        if (error.code === 'username_required') {
          Alert.alert(t('Önce bir kullanıcı adı seç.','Choose your username first.'));
          onProfile();
          return;
        }
        throw error;
      }
      setRevision(n => n+1);
      if (result.new_achievements?.length) setAwards(result.new_achievements);
    });
  }
  function remove(username) {
    Alert.alert(t('Arkadaşlıktan çıkarılsın mı?','Remove friend?'),username,[
      {text:t('Vazgeç','Cancel'),style:'cancel'},
      {text:t('Çıkar','Remove'),style:'destructive',onPress:() => change('remove_friend',username)}]);
  }
  function actions(person,relation) {
    const username = person.username;
    if (relation === 'request_received') return <View style={ui.row}>
      <Action disabled={action.busy} onPress={() => change('respond_friend_request',username,{accept:true})}>{t('Kabul et','Accept')}</Action>
      <Action disabled={action.busy} onPress={() => change('respond_friend_request',username,{accept:false})}>{t('Reddet','Decline')}</Action></View>;
    if (relation === 'friend') return <Action disabled={action.busy} onPress={() => remove(username)}>{t('Arkadaş · Çıkar','Friend · Remove')}</Action>;
    if (relation === 'request_sent') return <Action disabled={action.busy} onPress={() => change('remove_friend',username)}>{t('İstek gönderildi · Geri al','Request sent · Cancel')}</Action>;
    return <Action disabled={action.busy} onPress={() => change('send_friend_request',username)}>{t('Ekle','Add')}</Action>;
  }
  function personRow(person,relation) {
    return <View key={person.username} style={ui.card}><View style={ui.row}><Avatar path={person.avatar_path}/>
      <Text style={ui.label}>@{person.username}</Text></View>
      {person.total_places != null && <Text>{person.total_places} {t('yer','places')} · {person.badges} {t('rozet','badges')}</Text>}
      {actions(person,relation)}</View>;
  }
  const collection=useQuery(badge?'my_achievements':null,{lang},[userId,revision]);
  if (badge) {
    const earned=collection.data?.find(entry=>entry.slug===badge) || {slug:badge,name:awardNames[badge]?t(...awardNames[badge]):badge};
    return <Modal visible onRequestClose={()=>setAwards([])}><Ceremony key={badge} badge={earned} userId={userId} onNext={()=>setAwards(list=>list.slice(1))} onClose={()=>setAwards([])} onBadges={onBadges}/></Modal>;
  }
  return <><View style={ui.row}><Action selected={tab === 'friends'} onPress={() => setTab('friends')}>{t('Arkadaşlar','Friends')}</Action>
    <Action selected={tab === 'rank'} onPress={() => setTab('rank')}>{t('Sıralama','Rankings')}</Action></View>
    {!!action.message && <Text accessibilityLiveRegion="polite">{action.message}</Text>}
    <Feedback query={friends}/>
    {tab === 'friends' ? <>
      {!!friends.data?.incoming.length && <Text style={ui.heading}>{t('Gelen istekler','Incoming requests')}</Text>}
      {friends.data?.incoming.map(p => personRow(p,'request_received'))}
      <TextInput style={ui.input} placeholder={t('Kullanıcı adıyla ara','Search by username')} value={input} autoCapitalize="none"
        onChangeText={v => {setInput(v);setSearch('');}} onSubmitEditing={() => input.trim().length >= 2 && setSearch(input.trim())}/>
      <Action disabled={input.trim().length < 2} onPress={() => setSearch(input.trim())}>{t('Ara','Search')}</Action><Feedback query={results}/>
      {results.data?.users.length === 0 && <Text>{t('Kullanıcı bulunamadı.','No users found.')}</Text>}
      {results.data?.users.map(p => personRow(p,p.relation))}
      {!!friends.data?.outgoing.length && <Text style={ui.heading}>{t('Gönderilen istekler','Sent requests')}</Text>}
      {friends.data?.outgoing.map(p => personRow(p,'request_sent'))}
      <Text style={ui.heading}>{t('Arkadaşlarım','My friends')}</Text>{friends.data?.friends.map(p => personRow(p,'friend'))}
      <Action onPress={onProfile}>{t('Profil ve kullanıcı adı','Profile and username')}</Action>
    </> : <>
      <View style={ui.row}>{Object.entries(periods).map(([id,label]) =>
        <Action key={id} selected={id === period} onPress={() => setPeriod(id)}>{t(...label)}</Action>)}</View><Feedback query={board}/>
      {board.data?.entries.map((p,i) => <View key={p.username || i} style={[ui.card,p.is_me && {borderColor:c.primary,borderWidth:2}]}>
        <View style={ui.row}><Avatar path={p.avatar_path}/><Text style={ui.label}>{p.rank}. {p.username}{p.is_me ? t(' (sen)',' (you)') : ''}</Text></View>
        <Text>{p.places} {t('yer','places')}</Text></View>)}</>}
    {friends.data?.friends.length === 0 && <Text>{t('Arkadaşlarını ekle, kim daha çok geziyor görün.','Add friends to see who explores the most.')}</Text>}
    <Action onPress={() => setRevision(n => n+1)}>{t('Yenile','Refresh')}</Action>
  </>;
}
