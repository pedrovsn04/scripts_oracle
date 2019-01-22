select /*+ Rule */
       a.log_user,
       a.job,
       a.broken,
       a.failures,
       Decode(b.job,null,null,'Running')  Running ,
       substr(to_char(a.last_date,'dd/mm/yyyy hh24:mi'),1,17) last_date,
       substr(to_char(a.NEXT_DATE,'dd/mm/yyyy hh24:mi'),1,17) next_date,
       substr(a.what,1,170) procedure,
       substr(a.interval,1,40) intervalo
from DBA_jobs a
 ,DBA_JOBS_RUNNING b
  WHERE   a.job = b.job
ORDER BY  a.what,a.JOB,a.failures, a.broken
/