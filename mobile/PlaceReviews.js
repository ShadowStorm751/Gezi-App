import React,{useState} from 'react';
import {Alert,Image,Text,TextInput,View} from 'react-native';
import {Star,UserRound} from 'lucide-react-native';
import {client,lang,t} from './client';
import {Action,Feedback,rpc,ui,useAction,useQuery} from './ScreenUI';
import {Press,Progress} from './Motion';
import {heading,muted,row} from './PlaceUI';
import {ContributionPage,Status,confirmRemove} from './VisitPhotos';
import {ratingLabel} from './PlaceDetail';
import {c,type} from './theme';

function Editor({placeId,mine,visits,onRefresh}) {
  const [rating,setRating]=useState(mine?.rating||0),[note,setNote]=useState(mine?.comment||'');
  const action=useAction(),id=visits.userId;
  async function save(){
    if(!id||visits.owner.current!==id)return;
    const res=await rpc('review_place',{place_id:placeId,rating,comment:note.trim()||null,lang});
    if(visits.owner.current!==id)return;
    Alert.alert(res.comment_status==='pending'?t('Notun incelemeden sonra yayınlanacak.','Your note will appear after review.'):t('Puanın kaydedildi.','Your rating was saved.'));
    onRefresh(res.rating);
  }
  async function remove(){
    if(visits.owner.current!==id)return;
    await rpc('delete_my_review',{place_id:placeId});if(visits.owner.current===id)onRefresh();
  }
  return <View style={[ui.card,{gap:10}]}><Text style={heading}>{mine?t('Değerlendirmen','Your review'):t('Değerlendir','Rate this place')}</Text>
    <View style={row}>{[1,2,3,4,5].map(v=><Press key={v} accessibilityRole="button" accessibilityLabel={v+' '+t('yıldız','stars')} accessibilityState={{selected:rating===v}} disabled={action.busy} onPress={()=>setRating(v)} style={{minWidth:38,minHeight:44,justifyContent:'center'}}><Star size={26} color={c.goldInk} fill={v<=rating?c.gold:c.clear}/></Press>)}</View>
    <TextInput accessibilityLabel={t('Değerlendirme notu','Review note')} placeholder={t('Kısa not (isteğe bağlı)','Short note (optional)')} value={note} onChangeText={setNote} editable={!action.busy} multiline maxLength={300} style={ui.input}/>
    {mine && <Status value={mine.comment_status} note={mine.admin_note}/>}
    <Action selected disabled={!rating||action.busy} onPress={()=>action.run(save)}>{t('Kaydet','Save')}</Action>
    {mine && <Action disabled={action.busy} danger onPress={()=>confirmRemove(t('Değerlendirme silinsin mi?','Delete review?'),()=>action.run(remove))}>{t('Değerlendirmemi sil','Delete my review')}</Action>}
    {!!action.message && <Text style={ui.notice}>{action.message}</Text>}</View>;
}
export function Reviews({place,visits,onBack,onChanged}) {
  const query=useQuery('reviews_for_place',{place_id:place.id,lang,max_results:40},[visits.userId,visits.revision]),data=query.data;
  return <ContributionPage title={t('Değerlendirmeler','Reviews')} onBack={onBack}><Text style={heading}>{place.name}</Text><Feedback query={query}/>
    {data && <><Text style={{...type.title,color:c.goldInk}}>{ratingLabel(data.rating)}</Text>
    <View style={{gap:6}}>{[5,4,3,2,1].map(v=><View key={v} style={row}><Text style={ui.label}>{v} ★</Text><View style={{flex:1}}><Progress value={(data.distribution?.[v]||0)/Math.max(1,data.rating.count)}/></View><Text style={muted}>{data.distribution?.[v]||0}</Text></View>)}</View>
    {data.can_review?<Editor key={visits.userId+':'+(data.my_review?.updated_at||'new')} placeId={place.id} mine={data.my_review} visits={visits} onRefresh={rating=>{query.retry();onChanged?.(rating);}}/>:<Text style={muted}>{t('Değerlendirmek için önce burayı gez.','Check in here before rating this place.')}</Text>}
    {(data.reviews||[]).map((r,i)=><View key={r.username+':'+i} style={ui.card}><View style={row}>{r.avatar_path?<Image source={{uri:client.storage.from('avatars').getPublicUrl(r.avatar_path).data.publicUrl}} style={{width:36,height:36,borderRadius:18}}/>:<UserRound color={c.inkMuted}/>}<View style={{flex:1}}><Text style={ui.label}>@{r.username}</Text><Text style={{...type.caption,color:c.inkMuted}}>{new Date(r.updated_at).toLocaleDateString(lang)}</Text></View><Text style={{color:c.goldInk}}>{r.rating} ★</Text></View><Text style={muted}>{r.comment}</Text></View>)}</>}
  </ContributionPage>;
}
export function MyReviews({visits,onSelect,revision}) {
  const query=useQuery('my_reviews',{lang},[visits.userId,revision]);
  return <><Text style={heading}>{t('Değerlendirmelerim','My reviews')}</Text><Feedback query={query}/>{query.data?.length===0 && <Text style={muted}>{t('Henüz bir yeri değerlendirmedin.','You haven’t rated a place yet.')}</Text>}
  {query.data?.map(r=><View key={r.place_id} style={ui.card}><Text style={heading}>{r.place_name} · {r.rating} ★</Text>{!!r.comment && <Text style={muted}>{r.comment}</Text>}<Status value={r.comment_status} note={r.admin_note}/><Action onPress={()=>onSelect({id:r.place_id,name:r.place_name})}>{t('Değerlendirmeyi aç','Open review')}</Action></View>)}</>;
}
