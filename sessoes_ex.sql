SET LINESIZE 500                                                       
SET PAGESIZE 1000                                                      
                                                                       
COLUMN username FORMAT A15                                             
COLUMN machine FORMAT A25                                              
COLUMN logon_time FORMAT A15                                           
col lockwait for a20                                                   
col status for a8                                                      
col spid for a5                                                        
col sid for 99999                                                       
col program for a40                                                    
                                                                       
   
SELECT s.username, count(*), s.status
FROM  gv$session s,
       gv$process p
WHERE  s.paddr = p.addr and  type = 'USER' and s.inst_id=p.inst_id
group by s.status, s.username order by 3, 2, 1 desc;

SELECT count(*), s.status
FROM   gv$session s,
       gv$process p
WHERE  s.paddr = p.addr and  type = 'USER'  and s.inst_id=p.inst_id
group by s.status order by 2 desc;

                                                                    
SELECT NVL(s.username, '(oracle)') AS username, 
       s.inst_id,                      
       s.osuser,
       s.sql_hash_value , 
       s.PREV_HASH_VALUE,  
       s.sql_id,                                                    
       s.sid,                                                          
       s.serial#,                                                      
       p.spid,  
substr(floor(s.last_call_et/3600)||':'||
 floor(mod(s.last_call_et,3600)/60)||':'||
 mod(mod(s.last_call_et,3600),60),1,8) "IDLE",                                                             
       s.lockwait,                                                     
      s.status,                                                        
       s.module,                                                       
       s.machine,                                                      
       s.program,                                                      
       TO_CHAR(s.logon_Time,'DD-MON-YY HH24:MI') AS logon_time         
FROM   gv$session s,                                                    
       gv$process p                                                     
WHERE  s.paddr = p.addr and  s.inst_id=p.inst_id and type = 'USER' and s.status='ACTIVE'
ORDER BY  logon_time, username, s.osuser;                             

