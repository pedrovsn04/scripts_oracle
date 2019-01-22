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
Select fcr.request_id "REQ_ID"
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
             , fcr.status_code) "Status"
     , fcr.oracle_process_id SPID
     , fcr.oracle_session_id audsid
     , fcpt.concurrent_program_id "ProgID"
     , to_char(fcr.actual_start_date, 'dd/mon/yy hh24:mi:ss') "Inicio"
     , to_char(fcr.actual_completion_date, 'dd/mon/yy hh24:mi:ss') "Fim"
     , to_char(fcr.requested_start_date, 'dd/mon/yy hh24:mi:ss') "REQ_START_DATE"
     , fcpt.user_concurrent_program_name
     , ROUND (sysdate - fcr.actual_start_date, 2) * 24 * 60 "t (min)"
     , fcr.requested_by
     , fcr.argument_text
  from apps.fnd_concurrent_requests fcr
     , apps.fnd_concurrent_programs_tl fcpt
 Where fcr.concurrent_program_id = fcpt.concurrent_program_id
   And fcpt.language = NVL(UPPER('&Language'),'PTB')
   And fcr.requested_by  = &USER_ID
Order by actual_start_date;
/