--------------------------------------------------------------------------------
-- Informações de solicitações
--    Para mais de um spid, separar por virgula
--
-- Descrições do phase_code 
--
-- SELECT LOOKUP_CODE, MEANING 
--   FROM APPS.fnd_lookups 
--  WHERE lookup_type = 'CP_PHASE_CODE'
-- 
-- Descrições do status_code 
--
-- SELECT LOOKUP_CODE, MEANING 
--   FROM APPS.fnd_lookups 
--  WHERE lookup_type = 'CP_STATUS_CODE'
-- 
--------------------------------------------------------------------------------
--
col spid format a10
col USER_CONCURRENT_PROGRAM_NAME format a50 truncate
col user_name format a15
--
Select fcr.request_id
     , DECODE( fcr.phase_code
             , 'R', '(R)Running'
             , 'P', '(P)Pending'
             , 'I', '(I)Inactive'
             , 'C', '(C)Completed'
             , fcr.phase_code) phase
     , DECODE( fcr.status_code
             , 'A', '(A)Waiting'
             , 'B', '(B)Resuming'
             , 'C', '(C)Normal'
             , 'D', '(D)Cancelled'
             , 'E', '(E)Error'
             , 'G', '(G)Warning'
             , 'H', '(H)On Hold'
             , 'I', '(I)Normal'
             , 'M', '(M)No Manager'
             , 'P', '(P)Scheduled'
             , 'Q', '(Q)Standby'
             , 'R', '(R)Normal'
             , 'S', '(S)Suspended'
             , 'T', '(T)Terminating'
             , 'U', '(U)Disabled'
             , 'W', '(W)Paused'
             , 'X', '(X)Terminated'
             , 'Z', '(Z)Waiting'
             , fcr.status_code) status
     , fcr.oracle_process_id SPID
     , fcr.oracle_session_id audsid
     , to_char(fcr.actual_start_date, 'dd/mm/yy hh24:mi:ss') "Start"
     , to_char(fcr.actual_completion_date, 'dd/mm/yy hh24:mi:ss') "Completion"
     , fcp.concurrent_program_name
     , fcpt.user_concurrent_program_name
     , to_char(fcr.requested_start_date, 'dd/mm/yy hh24:mi:ss') requested_start_date
     , ROUND (sysdate - fcr.actual_start_date, 2) * 24 * 60 "t (min)"
     , fu.user_name
     , fcpt.concurrent_program_id conc_prog_id
  from apps.fnd_concurrent_requests fcr
     , apps.fnd_concurrent_programs fcp
     , apps.fnd_concurrent_programs_tl fcpt
     , apps.fnd_user fu
 Where oracle_process_id in ('&spid')
   And fcr.concurrent_program_id = fcpt.concurrent_program_id
   And fcr.concurrent_program_id = fcp.concurrent_program_id
   And fcpt.language = UPPER(NVL('&Language','PTB'))
   And fu.user_id = fcr.requested_by
   And fcr.actual_start_date > ( sysdate - 1 )
Order by actual_start_date;