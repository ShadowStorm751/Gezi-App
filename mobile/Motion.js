import React, {useEffect} from 'react';
import {Pressable,View} from 'react-native';
import Animated,{Easing,useSharedValue,useAnimatedStyle,useReducedMotion,withTiming,withDelay,withRepeat,cancelAnimation} from 'react-native-reanimated';
import {c,radius} from './theme';

export const ease = Easing.bezier(.2,.8,.2,1);
const Touch = Animated.createAnimatedComponent(Pressable);
export function Press({style,onPressIn,onPressOut,...props}) {
  const reduce=useReducedMotion(), scale=useSharedValue(1);
  const motion=useAnimatedStyle(()=>({transform:[{scale:scale.value}]}));
  return <Touch {...props} style={[style,motion]} onPressIn={e=>{if(!reduce) scale.value=withTiming(.97,{duration:120});onPressIn?.(e);}}
    onPressOut={e=>{scale.value=withTiming(1,{duration:reduce?0:120});onPressOut?.(e);}}/>;
}
export function Reveal({children,delay=0,offset=8,duration=220,style}) {
  const reduce=useReducedMotion(), p=useSharedValue(reduce?1:0);
  useEffect(()=>{p.value=reduce?1:withDelay(delay,withTiming(1,{duration,easing:ease}));return ()=>cancelAnimation(p);},[delay,duration,reduce,p]);
  const motion=useAnimatedStyle(()=>({opacity:p.value,transform:[{translateY:(1-p.value)*offset}]}));
  return <Animated.View style={[style,motion]}>{children}</Animated.View>;
}
export function Skeleton() {
  const reduce=useReducedMotion(), p=useSharedValue(0);
  useEffect(()=>{if(!reduce)p.value=withRepeat(withTiming(1,{duration:1200}),-1,false);return ()=>cancelAnimation(p);},[reduce,p]);
  const motion=useAnimatedStyle(()=>({transform:[{translateX:p.value*560-160}]}));
  return <View accessible accessibilityRole="progressbar" style={{height:72,overflow:'hidden',backgroundColor:c.surfaceSunken,borderRadius:radius.md}}>
    {!reduce && <Animated.View style={[{width:110,height:'100%',backgroundColor:c.surface,opacity:.65},motion]}/>}</View>;
}
export function Progress({value,from=value,delay=0}) {
  const reduce=useReducedMotion(), p=useSharedValue(reduce?value:from);
  useEffect(()=>{p.value=reduce?value:withDelay(delay,withTiming(value,{duration:520,easing:ease}));},[p,reduce,value,delay]);
  const motion=useAnimatedStyle(()=>({transform:[{scaleX:Math.min(1,Math.max(0,p.value))}]}));
  return <View style={{height:7,overflow:'hidden',borderRadius:radius.pill,backgroundColor:c.line}}>
    <Animated.View style={[{height:7,backgroundColor:c.gold,transformOrigin:'left'},motion]}/></View>;
}
