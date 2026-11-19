import {useEffect,useRef,useState} from 'react';
import {AsyncStorage,client,lang,project} from './client';
import {fetchVisitDates} from './visitLogic';

export default function useVisits() {
  const [userId,setUserId] = useState(null);
  const [history,setHistory] = useState(null);
  const [revision,setRevision] = useState(0);
  const owner = useRef(null);
  const epoch = useRef(0);
  const writes = useRef(Promise.resolve());

  useEffect(() => {
    if (!client) return;
    const {data} = client.auth.onAuthStateChange((_event,session) => {
      const id = session?.user.id ?? null;
      owner.current = id;
      setUserId(id);
    });
    return () => data.subscription.unsubscribe();
  },[]);

  useEffect(() => {
    if (!userId) { setHistory(null); return; }
    let active = true;
    const generation = epoch.current;
    const current = () => active && owner.current === userId && epoch.current === generation;
    async function sync() {
      const key = 'gezi:visits:'+project+':'+userId;
      let cached = {};
      try {
        const stored = JSON.parse(await AsyncStorage.getItem(key));
        if (stored && typeof stored === 'object' && !Array.isArray(stored)) cached = stored;
      } catch { /* The live response can still populate the history. */ }
      if (!current()) return;
      setHistory(old => ({userId,ready:true,dates:{...cached,...(old?.userId === userId ? old.dates : {})}}));
      try {
        const dates = await fetchVisitDates((name,args) => client.rpc(name,args),lang,current);
        if (current()) setHistory({userId,dates,ready:true});
      } catch { /* Keep the last known visits when offline. */ }
    }
    sync();
    return () => { active = false; };
  },[userId,revision]);

  useEffect(() => {
    if (!history?.ready || history.userId !== owner.current) return;
    const key = 'gezi:visits:'+project+':'+history.userId;
    writes.current = writes.current.then(() => AsyncStorage.setItem(key,JSON.stringify(history.dates))).catch(() => {});
  },[history]);

  function record(id,placeId,when) {
    if (!id || owner.current !== id) return;
    epoch.current++;
    setHistory(old => {
      const dates = old?.userId === id ? old.dates : {};
      return {userId:id,ready:old?.userId === id && old.ready,dates:{...dates,[placeId]:dates[placeId] || when}};
    });
    setRevision(n => n+1);
  }
  return {userId,owner,revision,record,dates:history?.userId === userId ? history.dates : {}};
}
