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
COL SPID 				FORMAT A10
COL USER_CONCURRENT_PROGRAM_NAME 	FORMAT A50 TRUNCATE
COL USER_NAME 				FORMAT A15
COL ACTUAL_START_DATE			HEADING "Actual|Start Date"
COL ACTUAL_COMPLETION_DATE		HEADING "Actual|Completion Date"
COL CONCURRENT_PROGRAM_ID		HEADING "PROGRAM_ID"
COL TEMPO_EXECUCAO			FORMAT A12	HEADING "Tempo|de Execução"

Select fcr.request_id "REQ_ID"
     , fcr.parent_request_id "PAR_ID"
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
--     , fcr.oracle_session_id audsid
     , fcpt.concurrent_program_id CONCURRENT_PROGRAM_ID
      , FLOOR ((NVL(FCR.ACTUAL_COMPLETION_DATE, sysdate) - fcr.actual_start_date) * 24 ) || ':'
       || LPAD(TO_CHAR(FLOOR(MOD((NVL(FCR.ACTUAL_COMPLETION_DATE, sysdate) - fcr.actual_start_date)*24, 1)*60)), 2, '0') || ':'
       || LPAD(TO_CHAR(FLOOR(MOD((NVL(FCR.ACTUAL_COMPLETION_DATE, sysdate) - fcr.actual_start_date)*24*60, 1)*60)), 2, '0')  tempo_execucao
     , to_char(fcr.actual_start_date, 'dd/mon hh24:mi:ss') ACTUAL_START_DATE
     , to_char(fcr.actual_completion_date, 'dd/mon hh24:mi:ss') ACTUAL_COMPLETION_DATE
     , fcpt.user_concurrent_program_name
     , fcr.requested_by
     , to_char(fcr.requested_start_date, 'dd/mon/yy hh24:mi:ss') "REQ_START_DATE"
     , fcr.argument_text
     , fcr.RESUBMIT_INTERVAL
     , fcr.RESUBMIT_INTERVAL_UNIT_CODE
     , fcr.RESUBMIT_INTERVAL_TYPE_CODE
     , fcr.RESUBMIT_TIME
     , fcr.RESUBMIT_END_DATE
  from dbascon.NXT_FND_CONC_REQ_HISTORY fcr
     , apps.fnd_concurrent_programs_tl@DBL_PNXTL03.WORLD fcpt
 Where request_id in (&req_id)
   And fcr.concurrent_program_id = fcpt.concurrent_program_id
   And fcpt.language = NVL(UPPER('&&Language'),'PTB')
Order by actual_start_date
/
