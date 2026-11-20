import React from 'react';
import {View} from 'react-native';
import Svg, {Circle, G, Line, Path, Text as SvgText} from 'react-native-svg';
import {t} from './client';

const directions = [
  {angle:0, label:t('K','N')}, {angle:90, label:t('D','E')},
  {angle:180, label:t('G','S')}, {angle:270, label:t('B','W')}
];
const ticks = Array.from({length:36}, (_,i) =>
  <Line key={i} x1={40} y1={7} x2={40} y2={i % 3 === 0 ? 12 : 9}
    stroke={i % 3 === 0 ? '#D9E9E1' : '#88A69D'} strokeWidth={1.4}
    transform={'rotate('+i*10+' 40 40)'}/>);

export default function CameraCompass({heading}) {
  if (!Number.isFinite(heading)) return null;
  return <View accessible accessibilityRole="image" pointerEvents="none"
    accessibilityLabel={t('Pusula','Compass')+', '+Math.round(heading)%360+'°'}>
    <Svg width={80} height={80} viewBox="0 0 80 80" accessible={false}>
      <Circle cx={40} cy={40} r={36} fill="#102D2B" fillOpacity={0.92} stroke="#91AFA4"/>
      <G rotation={-heading} originX={40} originY={40}>
        {ticks}
        <Path d="M40 22 L44 40 L36 40 Z" fill="#FF8773"/>
        <Path d="M36 40 L44 40 L40 58 Z" fill="#D5E5DE"/>
      </G>
      {directions.map(({angle,label}) => {
        const radians = (angle-heading)*Math.PI/180;
        return <SvgText key={angle} x={40+23*Math.sin(radians)} y={44-23*Math.cos(radians)}
          textAnchor="middle" fontSize={11} fontWeight="bold" fill={angle === 0 ? '#FFA391' : '#F4F8F2'}>{label}</SvgText>;
      })}
      <Circle cx={40} cy={40} r={2.6} fill="#F8F6E9"/>
      <Path d="M36 1 H44 L40 7 Z" fill="#F8F6E9"/>
    </Svg>
  </View>;
}
