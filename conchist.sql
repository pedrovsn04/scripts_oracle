--------------------------------------------------------------------------------
-- conchist.sql
--
--    Parametos: 
--       concurrent_program_id     --> id do programa concorrente
--       ndias                     --> 1 a 3 dias anteriores ao sysdatea
----------------------------------------------------------------------------------
UNDEF concurrent_program_id

COL SPID 				FORMAT A10
COL USER_CONCURRENT_PROGRAM_NAME 	FORMAT A60
COL USER_NAME 				FORMAT A10
COL concurrent_program_id		FORMAT 999999 	HEADING "PROGRAM ID"
COL TEMPO_EXECUCAO			FORMAT a10 	HEADING "Tempo de|Execução"

Select DECODE( fcr.phase_code
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
     , to_char(fcr.actual_start_date, 'dd/mon hh24:mi:ss') actual_start_date
     , to_char(fcr.actual_completion_date, 'dd/mon hh24:mi:ss') actual_completion_date
     , FLOOR ((NVL(FCR.ACTUAL_COMPLETION_DATE, sysdate) - fcr.actual_start_date) * 24 ) || ':'
       || LPAD(TO_CHAR(FLOOR(MOD((NVL(FCR.ACTUAL_COMPLETION_DATE, sysdate) - fcr.actual_start_date)*24, 1)*60)), 2, '0') || ':'
       || LPAD(TO_CHAR(FLOOR(MOD((NVL(FCR.ACTUAL_COMPLETION_DATE, sysdate) - fcr.actual_start_date)*24*60, 1)*60)), 2, '0')  tempo_execucao
     , fu.user_name
     , fcr.concurrent_program_id
     , fcr.argument_text
     , fcr.request_id
     , to_char(fcr.requested_start_date, 'dd/mon/yy hh24:mi:ss') "req_start_date"
     , fcpt.user_concurrent_program_name
  from apps.fnd_concurrent_requests fcr
     , apps.fnd_concurrent_programs_tl fcpt
     , apps.fnd_user fu
 Where fcr.concurrent_program_id = &&concurrent_program_id
   And fcr.concurrent_program_id = fcpt.concurrent_program_id
   And fcpt.language = 'PTB'
   And fu.user_id = fcr.requested_by
   And fcr.actual_start_date > (sysdate - &ndias)
--   And fu.user_name LIKE 'IROSS'
 Order by fcr.phase_code, fcr.actual_start_date
/