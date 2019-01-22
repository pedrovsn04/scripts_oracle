--------------------------------------------------------------------------------
-- Incompatibilidade
--
-- Uso:  @concconfr
--------------------------------------------------------------------------------
-- Pra que serve:
--    Lista as solicitações em execução que tem incompatibilidade com a
--    solicitação informada.
--
-- Informações adicionais
-- 
--    Descrições do phase_code 
--
--    SELECT LOOKUP_CODE, MEANING 
--      FROM APPS.fnd_lookups 
--     WHERE lookup_type = 'CP_PHASE_CODE'
-- 
--    Descrições do status_code 
--
--    SELECT LOOKUP_CODE, MEANING 
--      FROM APPS.fnd_lookups 
--     WHERE lookup_type = 'CP_STATUS_CODE'
-- 
--------------------------------------------------------------------------------
UNDEF LANGUAGE
UNDEF REQUEST_ID_WAITING

COL REQ_ID 				FORMAT 99999999
COL PAR_REQ_ID 				FORMAT A10
COL USER_CONCURRENT_QUEUE_NAME 		FORMAT A30 	TRUNCATE
COL SPID 				FORMAT A10
COL ACTUAL_START_DATE 			HEADING "Actual|Start Date"
COL STATUS 				FORMAT A10 TRUNCATE
COL "T (min)" 				FORMAT 99999.9
COL USER_CONCURRENT_PROGRAM_NAME 	FORMAT A60
COL USER_NAME 				FORMAT A12 
COL TEMPO 				FORMAT A10 HEADING "Tempo de|Execução"
COL ARGUMENT_TEXT 			FORMAT A40 TRUNCATE
COL CONC_PROG_ID 			HEADING "Program|ID" JUSTIFY LEFT
COL PAR_REQ_ID 				HEADING "Parent|req_id"


Select fcrrun.request_id "REQ_ID"
     , DECODE( fcrrun.phase_code
             , 'R', '(R)Running'
             , 'P', '(P)Pending'
             , 'I', '(I)Inactive'
             , 'C', '(C)Completed'
             , fcrrun.phase_code) phase
     , DECODE( fcrrun.status_code
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
             , fcrrun.status_code) "Status"
     , fcrrun.oracle_process_id SPID
     , fcptrun.concurrent_program_id "ProgID"
     , to_char(fcrrun.actual_start_date, 'dd/mon/yy hh24:mi:ss') ACTUAL_START_DATE
     , to_char(fcrrun.actual_completion_date, 'dd/mon/yy hh24:mi:ss') ACTUAL_COMPLETION_DATE
     , fcptrun.user_concurrent_program_name
     , ROUND (sysdate - fcrrun.actual_start_date, 2) * 24 * 60 "t (min)"
     , fcrrun.requested_by
     , to_char(fcrrun.requested_start_date, 'dd/mon/yy hh24:mi:ss') "REQ_START_DATE"
     , fcrrun.argument_text
  FROM apps.fnd_concurrent_requests fcrwait
     , apps.fnd_concurrent_program_serial fcps
     , apps.fnd_concurrent_requests fcrrun
     , apps.fnd_concurrent_programs_tl fcptrun
 WHERE fcrwait.request_id = &REQUEST_ID_WAITING
   AND fcps.to_run_concurrent_program_id = fcrrun.concurrent_program_id
--   AND fcrrun.status_code = 'R'
--   AND fcrwait.status_code = 'Q'
   And fcrrun.concurrent_program_id = fcptrun.concurrent_program_id
   And fcptrun.language = NVL(UPPER('&&Language'),'PTB')
   And fcrrun.actual_start_date > sysdate - 1/24
Order by fcrrun.actual_start_date
/