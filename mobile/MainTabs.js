import React from 'react';
import {Text,View,StyleSheet} from 'react-native';
import {NavigationContainer} from '@react-navigation/native';
import {createBottomTabNavigator} from '@react-navigation/bottom-tabs';
import {Compass,Map,Route,Award,UserRound} from 'lucide-react-native';
import Animated,{useAnimatedStyle,useReducedMotion,withTiming} from 'react-native-reanimated';
import {c,fonts,radius} from './theme';
import {Press} from './Motion';
import {t} from './client';

const Tab=createBottomTabNavigator();
const tabs={explore:[Compass,t('Keşfet','Explore')],map:[Map,t('Harita','Map')],routes:[Route,t('Rotalar','Routes')],badges:[Award,t('Rozetler','Badges')],profile:[UserRound,t('Profil','Profile')]};
function Item({name,active,onPress}) {
  const [Icon,label]=tabs[name], reduce=useReducedMotion();
  const motion=useAnimatedStyle(()=>({transform:[{scaleX:withTiming(active?1:0,{duration:reduce?0:200})}]}));
  const color=active?c.primary:c.inkMuted;
  return <Press accessibilityRole="tab" accessibilityState={{selected:active}} onPress={onPress} style={styles.item}>
    <View style={styles.icon}><Animated.View style={[styles.pill,motion]}/><Icon size={24} strokeWidth={1.8} color={color}/></View>
    <Text numberOfLines={1} style={{fontFamily:fonts.semibold,fontSize:11,color}}>{label}</Text>
  </Press>;
}
export default function MainTabs({pages,initial,onTab,navigationRef}) {
  return <NavigationContainer ref={navigationRef}><Tab.Navigator initialRouteName={initial} screenOptions={{headerShown:false,sceneStyle:{backgroundColor:c.surface}}}
    tabBar={({state,navigation})=><View style={styles.bar}>{state.routes.map((r,i)=><Item key={r.key} name={r.name} active={i===state.index}
      onPress={()=>{onTab(r.name);navigation.navigate(r.name);}}/>)}</View>}>
    {Object.keys(tabs).map(name=><Tab.Screen key={name} name={name}>{()=>pages[name]}</Tab.Screen>)}
  </Tab.Navigator></NavigationContainer>;
}
const styles=StyleSheet.create({bar:{flexDirection:'row',backgroundColor:c.surfaceRaised,borderTopWidth:1,borderColor:c.line,paddingVertical:6},
  item:{flex:1,minHeight:49,alignItems:'center',justifyContent:'center',gap:2},icon:{width:52,height:30,alignItems:'center',justifyContent:'center'},
  pill:{...StyleSheet.absoluteFillObject,borderRadius:radius.pill,backgroundColor:c.primarySoft}});
