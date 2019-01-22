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
COL TEMPO_EXECUCAO HEADING 'Tempo|Execução'
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
     , fcpt.concurrent_program_id conc_prog_id
     , to_char(fcr.actual_start_date, 'dd/mon/yy hh24:mi:ss') "ACT_START_DATE"
     , to_char(fcr.actual_completion_date, 'dd/mon/yy hh24:mi:ss') "ACT_COMPLETION_DATE"
     , fcpt.user_concurrent_program_name
     , ROUND((NVL(fcr.actual_completion_date, sysdate) - fcr.actual_start_date) * 24 * 60 ) TEMPO_EXECUCAO
     , fcr.requested_by
     , fcr.argument_text
  from apps.fnd_concurrent_requests fcr
     , apps.fnd_concurrent_programs_tl fcpt
 Where fcpt.user_concurrent_program_name like '&USER_CONCURRENT_PROGRAM_NAME'
   And fcr.concurrent_program_id = fcpt.concurrent_program_id
   And fcpt.language = NVL(UPPER('&Language'),'PTB')
Order by actual_start_date;