import React, {useState} from 'react';
import {Alert, Image, StyleSheet, Switch, Text, TextInput, View} from 'react-native';
import * as ImagePicker from 'expo-image-picker';
import {ImageManipulator, SaveFormat} from 'expo-image-manipulator';
import {Camera,ChevronDown,ChevronRight,ChevronUp,Image as PhotoIcon,MapPinPlus,Settings2,Star,UserRound,UsersRound} from 'lucide-react-native';
import {client,t} from './client';
import {Press} from './Motion';
import {GuestSignIn} from './Badges';
import {heading,muted} from './PlaceUI';
import {panel} from './TabPage';
import {c,radius,space,type} from './theme';
import {Action,Feedback,rpc,ui,useAction,useQuery} from './ScreenUI';
import {Submissions} from './Contributions';
import {deleteConfirmedAccount} from './communityLogic';

export function Avatar({path,size=48}) {
  if (!path) return null;
  return <Image source={{uri:client.storage.from('avatars').getPublicUrl(path).data.publicUrl}}
    style={{width:size,height:size,borderRadius:size/2}}/>;
}

function MenuRow({icon:Icon,label,onPress,expanded,disabled=false}) {
  const Arrow=expanded==null ? ChevronRight : expanded ? ChevronUp : ChevronDown;
  return <Press accessibilityRole="button" accessibilityState={{expanded,disabled}}
    disabled={disabled} onPress={onPress} style={styles.menuRow}>
    <View style={styles.icon}><Icon size={19} color={c.primary}/></View>
    <Text style={styles.menuLabel}>{label}</Text>
    <Arrow size={18} color={c.inkMuted}/>
  </Press>;
}

function ProfileMenu({onPhotos,onReviews,onSocial,onSuggest}) {
  return (
    <View style={styles.menu}>
      <MenuRow icon={PhotoIcon} label={t('Fotoğraflarım','My photos')} onPress={onPhotos}/>
      <MenuRow icon={Star} label={t('Değerlendirmelerim','My reviews')} onPress={onReviews}/>
      <MenuRow icon={UsersRound} label={t('Arkadaşlar ve sıralama','Friends and rankings')} onPress={onSocial}/>
      <MenuRow icon={MapPinPlus} label={t('Yer öner','Suggest a place')} onPress={onSuggest}/>
    </View>
  );
}

export function GuestProfile({onSuggest}) {
  const [section,setSection]=useState(null);
  const toggle=value=>setSection(current=>current===value ? null : value);
  const examples={
    photos:[t('Fotoğraflarım','My photos'),t('İlk ziyaret fotoğrafını yüklediğinde burada görünecek.','Your first visit photo will appear here after you upload it.')],
    reviews:[t('Örnek değerlendirme','Sample review'),t('Galata Kulesi · 4 / 5','Galata Tower · 4 / 5'),t('Gün batımında Haliç manzarası çok güzeldi.','The view of the Golden Horn at sunset was beautiful.')],
    social:[t('Örnek arkadaş sıralaması','Sample friends ranking'),t('1. Deniz · 6 ziyaret','1. Deniz · 6 visits'),t('2. Gezgin · 4 ziyaret','2. Explorer · 4 visits')],
    suggest:[t('Yer öner','Suggest a place'),t('Bağlandığında haritada bir konum seçip yer önerebilirsin.','When connected, you can suggest a place by choosing its location on the map.')],
  };
  return <>
    <View style={styles.identity}>
      <View style={styles.avatar}><UserRound size={32} color={c.primary}/></View>
      <View style={styles.identityCopy}>
        <Text style={styles.name}>{t('Misafir gezgin','Guest explorer')}</Text>
        <Text style={muted}>{t('Örnek profil','Sample profile')}</Text>
      </View>
    </View>
    <ProfileMenu onPhotos={()=>toggle('photos')} onReviews={()=>toggle('reviews')}
      onSocial={()=>toggle('social')} onSuggest={onSuggest || (()=>toggle('suggest'))}/>
    {examples[section] && <View style={panel}>
      {examples[section].map((line,index)=><Text key={line} style={index===0 ? heading : muted}>{line}</Text>)}
    </View>}
    <View style={styles.menu}>
      <MenuRow icon={Settings2} label={t('Hesap ayarları','Account settings')} expanded={section==='settings'} onPress={()=>toggle('settings')}/>
      {section==='settings' && <View style={styles.settings}>
        <Text style={muted}>{t('Giriş yaptığında kullanıcı adını, fotoğrafını ve profil görünürlüğünü buradan değiştirebilirsin.',
          'After signing in, you can change your username, photo and profile visibility here.')}</Text>
      </View>}
    </View>
    <GuestSignIn prompt={t('Kendi profilini açmak için giriş yap.','Sign in to open your own profile.')}/>
  </>;
}

export default function Profile({visits,onSocial,onPhotos,onReviews,onSuggest,onClose}) {
  const [settings,setSettings] = useState(false);
  const account = useQuery('update_profile',{},visits.userId);
  const [edited,setEdited] = useState(null);
  const [username,setUsername] = useState(null);
  const action = useAction();
  const profile = edited ?? account.data;
  const currentName = username ?? profile?.username ?? '';
  async function save(change) {
    const updated = await rpc('update_profile',change);
    if (!updated?.id) throw new Error('profile');
    setEdited(updated);
    setUsername(null);
  }
  function photo() {
    action.run(async () => {
      const picked = await ImagePicker.launchImageLibraryAsync({mediaTypes:['images'],allowsEditing:true,aspect:[1,1]});
      if (picked.canceled) return;
      const asset = picked.assets[0];
      const edge = Math.min(asset.width,asset.height);
      const context = ImageManipulator.manipulate(asset.uri);
      context.crop({originX:Math.floor((asset.width-edge)/2),originY:Math.floor((asset.height-edge)/2),width:edge,height:edge});
      context.resize({width:512,height:512});
      const rendering = await context.renderAsync();
      const jpg = await rendering.saveAsync({format:SaveFormat.JPEG,compress:0.82,base64:true});
      const bytes = Uint8Array.from(atob(jpg.base64),c => c.charCodeAt(0));
      const path = visits.userId+'/avatar-'+Date.now()+'.jpg';
      if (visits.owner.current !== visits.userId) return;
      const bucket = client.storage.from('avatars');
      const upload = await bucket.upload(path,bytes.buffer,{contentType:'image/jpeg'});
      if (upload.error) throw upload.error;
      await save({avatar_path:path});
    });
  }
  function confirmDelete() {
    Alert.alert(t('Hesabını silmek istiyor musun?','Delete your account?'),
      t('Profilin, fotoğrafın, rozetlerin ve ziyaretlerin kalıcı olarak silinecek. Bu işlem geri alınamaz.',
        'Your profile, avatar, badges and visits will be permanently deleted. This cannot be undone.'),
      [{text:t('Vazgeç','Cancel'),style:'cancel'},{text:t('Hesabımı sil','Delete my account'),style:'destructive',onPress:() => action.run(async () => {
        await deleteConfirmedAccount(client,visits.userId,visits.clearLocal,() => visits.owner.current);
        onClose();
        Alert.alert(t('Hesabın silindi.','Your account was deleted.'));
      })}]);
  }
  return <>
    <Feedback query={account}/>
    {profile && <View style={styles.identity}>
      <Press accessibilityRole="button" accessibilityLabel={t('Profil fotoğrafı seç','Choose profile photo')}
        disabled={action.busy} onPress={photo} style={styles.avatar}>
        {profile.avatar_path ? <Avatar path={profile.avatar_path} size={64}/> : <UserRound size={32} color={c.primary}/>}
        <View style={styles.camera}><Camera size={14} color={c.onPrimary}/></View>
      </Press>
      <View style={styles.identityCopy}>
        <Text style={styles.name}>{profile.username ? '@'+profile.username : t('Gezgin','Explorer')}</Text>
        <Text style={muted}>{profile.is_public ? t('Herkese açık profil','Public profile') : t('Gizli profil','Private profile')}</Text>
      </View>
    </View>}
    <ProfileMenu onPhotos={onPhotos} onReviews={onReviews} onSocial={onSocial} onSuggest={onSuggest}/>
    <Submissions userId={visits.userId}/>
    <View style={styles.menu}>
      <MenuRow icon={Settings2} label={t('Hesap ayarları','Account settings')} expanded={settings}
        onPress={()=>setSettings(open=>!open)}/>
      {settings && <View style={styles.settings}>
        {profile && <>
          <Text style={heading}>{t('Kullanıcı adı','Username')}</Text>
          <Text style={muted}>{t('3–20 küçük harf, rakam veya alt çizgi.','3–20 lowercase letters, numbers or underscores.')}</Text>
          <TextInput accessibilityLabel={t('Kullanıcı adı','Username')} value={currentName}
            onChangeText={setUsername} editable={!action.busy} style={ui.input}
            autoCapitalize="none" autoCorrect={false} maxLength={20}/>
          <Action selected disabled={action.busy || !/^[a-z0-9_]{3,20}$/.test(currentName) || currentName===profile.username}
            onPress={()=>action.run(()=>save({username:currentName}))}>{t('Kullanıcı adını kaydet','Save username')}</Action>
          <View style={styles.visibility}>
            <Text style={styles.menuLabel}>{t('Profilim herkese açık','Public profile')}</Text>
            <Switch accessibilityLabel={t('Profilim herkese açık','Public profile')} value={!!profile.is_public}
              disabled={action.busy} onValueChange={value=>action.run(()=>save({is_public:value}))}/>
          </View>
          <Text style={muted}>{t('Kapalıysa seni yalnızca tam kullanıcı adınla bulabilirler.','When off, people can only find you by your exact username.')}</Text>
        </>}
        <Action danger disabled={action.busy} onPress={confirmDelete}>{t('Hesabımı sil','Delete my account')}</Action>
      </View>}
    </View>
    {!!action.message && <Text accessibilityLiveRegion="polite" style={muted}>{action.message}</Text>}
  </>;
}

const styles=StyleSheet.create({
  identity:{...panel,flexDirection:'row',alignItems:'center',backgroundColor:c.primarySoft,borderColor:c.primarySoft},
  identityCopy:{flex:1,gap:space[1]},name:{...type.title,color:c.ink},
  avatar:{width:64,height:64,alignItems:'center',justifyContent:'center',borderRadius:32,backgroundColor:c.surfaceRaised},
  camera:{position:'absolute',bottom:-1,right:-1,padding:4,borderRadius:14,backgroundColor:c.primary,borderColor:c.surfaceRaised,borderWidth:2},
  menu:{backgroundColor:c.surfaceRaised,borderRadius:radius.lg,borderColor:c.line,borderWidth:1,overflow:'hidden'},
  menuRow:{flexDirection:'row',alignItems:'center',paddingHorizontal:space[4],paddingVertical:space[3],gap:space[3]},
  icon:{width:36,height:36,borderRadius:radius.md,backgroundColor:c.primarySoft,alignItems:'center',justifyContent:'center'},
  menuLabel:{flex:1,...type.label,color:c.ink},
  settings:{borderTopWidth:1,borderColor:c.line,padding:space[4],gap:space[2]},
  visibility:{flexDirection:'row',alignItems:'center',gap:space[2],paddingTop:space[3]},
});
