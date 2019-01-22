--------------------------------------------------------------------------------
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

COL REQ_ID FORMAT 99999999
COL PAR_REQ_ID FORMAT A10
COL SPID FORMAT A10
COL STATUS FORMAT A10 TRUNCATE
COL USER_CONCURRENT_PROGRAM_NAME FORMAT A60
COL USER_NAME FORMAT A12 

Select fcr.request_id "REQ_ID"
--     , DECODE(fcr.parent_request_id, -1, '', fcr.parent_request_id) "PAR_REQ_ID"
--     , DECODE( fcr.phase_code
--             , 'R', '(R)Running'
--             , 'P', '(P)Pending'
--             , 'I', '(I)INACTIVE'
--             , 'C', '(C)Completed'
--             , fcr.phase_code) phase
--     , DECODE( fcr.status_code
--             , 'A', '(A)Waiting'
--             , 'B', '(B)Resuming'
--             , 'C', '(C)Normal'
--             , 'D', '(D)Cancelled'
--             , 'E', '(E)Error'
--             , 'G', '(G)Warning'
--             , 'H', '(H)On Hold'
--             , 'I', '(I)Normal'
--             , 'M', '(M)No Manager'
--             , 'P', '(P)Scheduled'
--             , 'Q', '(Q)Standby'
--             , 'R', '(R)Normal'
--             , 'S', '(S)Suspended'
--             , 'T', '(T)Terminating'
--             , 'U', '(U)Disabled'
--             , 'W', '(W)Paused'
--             , 'X', '(X)Terminated'
--             , 'Z', '(Z)Waiting'
--             , fcr.status_code) "STATUS"
--     , fcr.oracle_process_id SPID
--     , fcr.oracle_session_id audsid
     , to_char(fcr.requested_start_date, 'dd/mm/yy hh24:mi:ss') "REQ_START_DATE"
--     , to_char(fcr.actual_start_date, 'dd/mon hh24:mi:ss') "ACT_START_DATE"
--     , ROUND (sysdate - fcr.actual_start_date, 2) * 24 * 60 "T (min)"
     , fu.user_name
     , fcpt.user_concurrent_program_name
     , fcp.concurrent_program_name
     , fcpt.concurrent_program_id "CONC_PROG_ID"
  from apps.fnd_concurrent_requests fcr
     , apps.fnd_concurrent_programs_tl fcpt
     , apps.fnd_concurrent_programs fcp
     , apps.fnd_user fu
 Where fcr.phase_code = 'P'
   And fcr.status_code In ( 'I', 'Q' )
   And fcr.concurrent_program_id = fcpt.concurrent_program_id
   And fcpt.language = 'PTB'
   And ( NVL ( fcr.request_type, 'X' ) != 'S' )
   And fu.user_id = fcr.requested_by
   And fcp.concurrent_program_id = fcpt.concurrent_program_id
Order by fcr.requested_start_date;