--------------------------------------------------------------------------------
-- 
--------------------------------------------------------------------------------

col spid format a10
col USER_CONCURRENT_PROGRAM_NAME format a60
col user_name format a15

Select fcr.concurrent_program_id "CONC_PROD_ID"
     , fcpt.user_concurrent_program_name
     , ROUND(avg(fcr.actual_completion_date - fcr.actual_start_date)*24*60,2) "AVG (min)"
     , ROUND(min(fcr.actual_completion_date - fcr.actual_start_date)*24*60,2) "MIN (min)"
     , ROUND(max(fcr.actual_completion_date - fcr.actual_start_date)*24*60,2) "MAX (min)"
--     , to_char(fcr.requested_start_date, 'dd/mm/yy hh24:mi:ss') requested_start_date
--     , to_char(fcr.actual_start_date, 'dd/mm/yy hh24:mi:ss') actual_start_date
--     , to_char(fcr.actual_completion_date, 'dd/mm/yy hh24:mi:ss') actual_completion_date
--     , ROUND (DECODE(fcr.actual_completion_date, NULL, sysdate, fcr.actual_completion_date) - fcr.actual_start_date, 2) * 24 * 60 "T (min)"
--     , fu.user_name
--     , fcpt.user_concurrent_program_name
  from apps.fnd_concurrent_requests fcr
     , apps.fnd_concurrent_programs_tl fcpt
     , apps.fnd_user fu
 Where fcr.concurrent_program_id = &concurrent_program_id
   And fcr.concurrent_program_id = fcpt.concurrent_program_id
   And fcpt.language = 'PTB'
   And fu.user_id = fcr.requested_by
   And fcr.actual_start_date > (sysdate - &ndias)
   And fcr.phase_code = 'C'
   And fcr.status_code = 'C'
   And fcr.actual_completion_date is not null
 Group by fcr.concurrent_program_id, fcpt.user_concurrent_program_name;