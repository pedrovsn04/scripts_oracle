COL "SID - SERIAL" for a20
COL machine for a40

 select             
			substr('kill -9 '||p.spid,1,16) "KILL",
            vs.inst_id,
            vs.sid || ',' || vs.serial# as "SID - SERIAL",
            vs.machine,
            vs.sql_address,
            vs.sql_hash_value,
            vs.last_call_et,
            vsw.seconds_in_wait,
            vsw.event,
            vsw.state
 from gv$session_wait vsw, gv$session vs, gv$process p
 where vsw.sid = vs.sid
 and vs.paddr = p.addr(+)
 and vsw.inst_id = vs.inst_id
 and vs.type <> 'BACKGROUND'
 and vsw.event
 NOT IN ('rdbms ipc message'
      ,'smon timer'
      ,'pmon timer'
      ,'SQL*Net message from client'
      ,'lock manager wait for remote message'
      ,'ges remote message'
      ,'gcs remote message'
      ,'gcs for action'
      ,'client message'
      ,'pipe get'
      ,'Null event'
      ,'PX Idle Wait'
      ,'single-task message'
      ,'PX Deq: Execution Msg'
      ,'KXFQ: kxfqdeq - normal deqeue'
      ,'listen endpoint status'
      ,'slave wait'
      ,'wakeup time manager')
/