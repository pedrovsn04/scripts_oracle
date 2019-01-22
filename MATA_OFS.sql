col MODULE  format a15
 select
  'kill -9 '||p.spid kill,
 s.status,
 s.SID,
        substr(to_char(s.LOGON_TIME,'dd/mm/yyyy hh24:mi:ss'),1,20) "Data Ini.",
       s.MODULE,
        substr(floor(s.last_call_et/3600)||':'||
        floor(mod(s.last_call_et,3600)/60)||':'||
        mod(mod(s.last_call_et,3600),60),1,8) "IDLE",
        decode(s.MODULE,'WSHASCSRS','ATIVO MAIS DE 20Hs ** PODE MATAR *** !!' ,'ATIVO MAIS DE 30 Min.  **** PODE MATAR **** '),
        s.action
 from gv$session s,
      gv$process p,
      sys.GV_$INSTANCE i
 WHERE s.paddr = p.addr(+)
   and i.inst_id = s.inst_id
   and s.username is not null
--  and s.sid not in (2032 ,1754,5267)
 and  s.MODULE in ('ARXCWMAI''ARXRWMAI','ARXTWMAI','WSHASCSRS') 
 --AND s.USERNAME like  'MBSU%'
 -- and s.osuser = 'dolivei2'
 --and s.program like '%kv_2.exe%'
 --and s.program like '%sfiscm.exe%'
 --and s.action like '%LGARCI4%'
 -- and s.status ='SNIPED'
 -- and s.status ='KILLED'
 order by 2,5
/
