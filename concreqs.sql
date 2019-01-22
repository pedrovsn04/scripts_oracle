--------------------------------------------------------------------------
-- Requests by phase
--
-- Parametros: phase_code: R, P, I C
--------------------------------------------------------------------------

COL USER_CONCURRENT_PROGRAM_NAME FORMAT A60 TRUNCATE


Select fcr.request_id
     , DECODE( fcr.phase_code
             , 'R', '(R)Running'
             , 'P', '(P)Pending'
             , 'I', '(I)INACTIVE'
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
     , to_char(fcr.requested_start_date, 'dd/mm/yy hh24:mi:ss') "REQUESTED_START_DATE"
     , to_char(fcr.actual_start_date, 'dd/mm/yy hh24:mi:ss') "ACTUAL_START_DATE"
     , ROUND (sysdate - fcr.actual_start_date, 2) * 24 * 60 "T (min)"
     , fu.user_name
     , fcpt.user_concurrent_program_name
     , fcp.concurrent_program_name
     , fcpt.concurrent_program_id
  from apps.fnd_concurrent_requests fcr
     , apps.fnd_concurrent_programs_tl fcpt
     , apps.fnd_concurrent_programs fcp
     , apps.fnd_user fu
 Where phase_code = UPPER(NVL('&phase_code','R'))
   And fcr.concurrent_program_id = fcpt.concurrent_program_id
   And fcpt.language = 'PTB'
   And fu.user_id = fcr.requested_by
   And fcp.concurrent_program_id = fcpt.concurrent_program_id
Order by actual_start_date
/
