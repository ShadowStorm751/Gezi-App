import {useEffect,useRef,useState} from 'react';
import * as Location from 'expo-location';
import {distanceMeters} from './geo';

function inCity(point,box) {
  return !!point && !!box && point.latitude>=box.min_lat && point.latitude<=box.max_lat &&
    point.longitude>=box.min_lng && point.longitude<=box.max_lng;
}
export function useDistrictName(origin,city) {
  const [district,setDistrict]=useState('');
  const lat=origin?.latitude,lng=origin?.longitude,box=city.bbox;
  useEffect(()=>{
    let active=true;
    setDistrict('');
    if(inCity(origin,box)){
      Location.reverseGeocodeAsync({latitude:lat,longitude:lng}).then(([address])=>{
        if(active)setDistrict(address?.district||address?.subregion||'');
      }).catch(()=>{});
    }
    return ()=>{active=false;};
  },[lat,lng,city.slug,box]);
  return district;
}
// The system geocoder returns a point. Label its 2 km radius explicitly.
export function useDistrictSearch(term,city) {
  const [area,setArea]=useState(null),generation=useRef(0);
  useEffect(()=>{generation.current++;setArea(null);return ()=>{generation.current++;};},[term,city.slug]);
  async function submit() {
    const q=term.trim();
    if(q.length<2||!city.bbox)return;
    const token=++generation.current;
    try{
      const points=await Location.geocodeAsync(q+', '+city.name);
      if(generation.current!==token)return;
      const center=points.find(p=>inCity(p,city.bbox));
      if(center)setArea({name:q,center});
    }catch{/* Name, description and route search still work offline. */}
  }
  return {area,submit,matchesArea:p=>!!area && distanceMeters(area.center,p.coordinate)<=2000};
}
