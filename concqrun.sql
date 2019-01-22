--------------------------------------------------------------------------------
-- Solicita��es em execu��o
--
-- Uso:  @concrun
--------------------------------------------------------------------------------
-- Pra que serve:
--    Lista as solicita��es em execu��o, em ordem descrescente de tempo de execu��o
--
-- Informa��es adicionais
-- 
--    Descri��es do phase_code 
--
--    SELECT LOOKUP_CODE, MEANING 
--      FROM APPS.fnd_lookups 
--     WHERE lookup_type = 'CP_PHASE_CODE'
-- 
--    Descri��es do status_code 
--
--    SELECT LOOKUP_CODE, MEANING 
--      FROM APPS.fnd_lookups 
--     WHERE lookup_type = 'CP_STATUS_CODE'
-- 
--------------------------------------------------------------------------------
UNDEF CONCURRENT_QUEUE_NAME

COL REQ_ID FORMAT 99999999
COL PAR_REQ_ID FORMAT A10
COL USER_CONCURRENT_QUEUE_NAME FORMAT A30 TRUNCATE
COL SPID FORMAT A10
COL STATUS FORMAT A10 TRUNCATE
COL "T (min)" FORMAT 99999.9
COL USER_CONCURRENT_PROGRAM_NAME FORMAT A60
COL USER_NAME FORMAT A12 
COL TEMPO FORMAT A8

Select fcwr.request_id "REQ_ID"
     , DECODE(fcwr.parent_request_id, -1, '', fcwr.parent_request_id) "PAR_REQ_ID"
     , DECODE( fcwr.status_code
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
             , fcwr.status_code) "STATUS"
     , fcwr.oracle_process_id SPID
--     , fcwr.oracle_session_id audsid
     , fcwr.concurrent_program_id "CONC_PROG_ID"
     , to_char(fcwr.actual_start_date, 'dd/mon/yy hh24:mi:ss') "ACT_START_DATE"
--     , ROUND ((sysdate - fcwr.actual_start_date) * 24 * 60, 1) "T (min)"
     , FLOOR ((sysdate - fcwr.actual_start_date) * 24 ) || ':'
       || LPAD(TO_CHAR(FLOOR(MOD((sysdate - fcwr.actual_start_date)*24, 1)*60)), 2, '0') || ':'
       || LPAD(TO_CHAR(FLOOR(MOD((sysdate - fcwr.actual_start_date)*24*60, 1)*60)), 2, '0')  "TEMPO"
     , fu.user_name
     , fcwr.user_concurrent_program_name
     , fcqt.USER_CONCURRENT_QUEUE_NAME
     , fcwr.concurrent_program_name
     , fcwr.argument_text
  from apps.fnd_concurrent_worker_requests fcwr
     , apps.fnd_concurrent_queues_Vl fcqt
     , apps.fnd_user fu
 Where phase_code = 'R'
   And 
      fcqt.concurrent_queue_id = fcwr.concurrent_queue_id
   And fu.user_id = fcwr.requested_by
--   And fcwr.concurrent_program_id = 44363
   And UPPER(fcqt.CONCURRENT_QUEUE_NAME) like UPPER('&&CONCURRENT_QUEUE_NAME')
Order by actual_start_date;
