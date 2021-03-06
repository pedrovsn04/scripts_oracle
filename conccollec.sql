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
     , fcwr.concurrent_program_id "CONC_PROG_ID"
--     , ROUND ((sysdate - fcwr.actual_start_date) * 24 * 60, 1) "T (min)"
     , FLOOR ((sysdate - fcwr.actual_start_date) * 24 ) || ':'
       || LPAD(TO_CHAR(FLOOR(MOD((sysdate - fcwr.actual_start_date)*24, 1)*60)), 2, '0') || ':'
       || LPAD(TO_CHAR(FLOOR(MOD((sysdate - fcwr.actual_start_date)*24*60, 1)*60)), 2, '0')  "TEMPO"
     , to_char(fcwr.actual_start_date, 'dd/mon/yy hh24:mi:ss') ACTUAL_START_DATE
     , fu.user_name
     , fcwr.user_concurrent_program_name
     , fcqt.USER_CONCURRENT_QUEUE_NAME
     , fcwr.oracle_session_id audsid
     , fcwr.concurrent_program_name
     , fcwr.argument_text
  from apps.fnd_concurrent_worker_requests fcwr
     , apps.fnd_concurrent_queues_Vl fcqt
     , apps.fnd_user fu
 Where phase_code = 'R'
   And fcqt.concurrent_queue_id = fcwr.concurrent_queue_id
   And fu.user_id = fcwr.requested_by
--   And fcwr.concurrent_program_id = 44363
--   And fu.user_id = 3157
   And fcwr.concurrent_program_name like '%IEX%'
Order by actual_start_date
/
