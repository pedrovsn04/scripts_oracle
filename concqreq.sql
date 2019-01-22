--------------------------------------------------------------------------------
-- Informações de solicitações
--    Para mais de um request_id, separar por virgula
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
COL SPID FORMAT A10
COL USER_CONCURRENT_PROGRAM_NAME FORMAT A50 TRUNCATE
COL USER_NAME FORMAT A15
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
     , fcpt.concurrent_program_id conc_prog_id
     , to_char(fcr.requested_start_date, 'dd/mon/yy hh24:mi:ss') "REQ_START_DATE"
     , to_char(fcr.actual_start_date, 'dd/mon/yy hh24:mi:ss') "ACT_START_DATE"
     , to_char(fcr.actual_completion_date, 'dd/mon/yy hh24:mi:ss') "ACT_COMPLETION_DATE"
     , fcpt.user_concurrent_program_name
     , ROUND (sysdate - fcr.actual_start_date, 2) * 24 * 60 "t (min)"
     , fcr.requested_by
--     , fu.user_name
     , fcr.argument_text
  from apps.fnd_concurrent_requests fcr
     , apps.fnd_concurrent_programs_tl fcpt
--     , apps.fnd_user fu
 Where request_id in (&req_id)
--   And phase_code = 'R'
   And fcr.concurrent_program_id = fcpt.concurrent_program_id
   And fcpt.language = NVL(UPPER('&Language'),'PTB')
--   And fu.user_id = fcr.requested_by
Order by actual_start_date;