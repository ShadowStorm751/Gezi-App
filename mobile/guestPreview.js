import {t} from './client';
import places from './places.json';

function badge(slug,name,description,progress,target) {
  return {slug,name,description,progress,target,earned_at:progress === target};
}

export const sampleBadges = [
  badge('first-step',t('İlk Adım','First Step'),t('İlk yerini gez.','Visit your first place.'),1,1),
  badge('first-view',t('İlk Manzara','First View'),t('İlk seyir noktanı gez.','Visit your first viewpoint.'),1,1),
  badge('explorer-10',t('Kâşif','Explorer'),t('10 yer gez.','Visit 10 places.'),4,10),
  badge('museum-lover',t('Müze Sever','Museum Lover'),t('5 müze gez.','Visit 5 museums.'),1,5),
  badge('ottoman-heritage',t('Osmanlı Mirası','Ottoman Heritage'),t('Osmanlı döneminden 10 yer gez.','Visit 10 Ottoman-era places.'),2,10),
  badge('route-first',t('Rotacı','Route Explorer'),t('İlk rotanı tamamla.','Complete your first route.'),0,1),
];

const stopCopy = {
  'galata-kulesi':['Galata Tower','The streets of Galata meet around this medieval Genoese tower.'],
  'galata-mevlevihanesi':['Galata Mevlevi Lodge Museum','This former lodge on Galip Dede Street traces the Mevlevi heritage of Beyoğlu.'],
};
const stops = places.filter(place=>stopCopy[place.id]).map((place,index)=>({
  position:index+1, name:t(place.name,stopCopy[place.id][0]), description:t(place.description,stopCopy[place.id][1]),
  ...place.coordinate,
}));

export const sampleRoute = {
  slug:'preview:galata',title:t('Galata sokakları','Streets of Galata'),
  summary:t('Galata Kulesi’nden Mevlevihane’ye uzanan iki duraklı bir yürüyüş.',
    'A two-stop walk from Galata Tower to the Mevlevi Lodge.'),
  travel_mode:'walking',kind:'historical',stop_count:stops.length,stops,
};
