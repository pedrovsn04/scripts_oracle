--------------------------------------------------------------------------------
-- 
--------------------------------------------------------------------------------

col spid format a10
col USER_CONCURRENT_PROGRAM_NAME format a80
col user_name format a15

Select fcr.request_id
--     , fcr.oracle_process_id SPID
--     , fcr.oracle_session_id audsid
     , DECODE( fcr.phase_code
             , 'R', '(R) Running'
             , 'P', '(P) Pending'
             , 'I', '(I) *** INACTIVE ***'
             , 'C', '(C) Completed'
             , fcr.phase_code) phase
     , DECODE( fcr.status_code
             , 'A', '(A) Waiting'
             , 'B', '(B) Resuming'
             , 'C', '(C) Normal'
             , 'D', '(D) Cancelled'
             , 'E', '(E) Error'
             , 'G', '(G) Warning'
             , 'H', '(H) On Hold'
             , 'I', '(I) Normal'
             , 'M', '(M) No Manager'
             , 'P', '(P) Scheduled'
             , 'Q', '(Q) Standby'
             , 'R', '(R) Normal'
             , 'S', '(S) Suspended'
             , 'T', '(T) Terminating'
             , 'U', '(U) Disabled'
             , 'W', '(W) Paused'
             , 'X', '(X) Terminated'
             , 'Z', '(Z) Waiting'
             , fcr.status_code) status
     , to_char(fcr.request_date, 'dd/mm/yy hh24:mi:ss') "request_date"
     , to_char(fcr.actual_start_date, 'dd/mm/yy hh24:mi:ss') actual_start_date
     , ROUND (sysdate - fcr.actual_start_date, 2) * 24 * 60 "Duracao (min)"
     , fu.user_name
     , fcpt.user_concurrent_program_name
  from apps.fnd_concurrent_requests fcr
     , apps.fnd_concurrent_programs_tl fcpt
     , apps.fnd_user fu
 Where fcr.concurrent_program_id = &concurrent_program_id
   And fcr.concurrent_program_id = fcpt.concurrent_program_id
   And fcpt.language = 'PTB'
   And fu.user_id = fcr.requested_by
Order by actual_start_date;
