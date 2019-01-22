select fcrwait.concurrent_program_id, fcps.RUNNING_CONCURRENT_PROGRAM_ID
from apps.fnd_concurrent_requests fcrwait
   , apps.fnd_concurrent_program_serial fcps
   , apps.fnd_concurrent_requests fcrrun
where fcrwait.request_id = &Request_id_waiting
  and fcps.to_run_concurrent_program_id = fcrwait.concurrent_program_id
  and fcrrun.concurrent_program_id= fcps.RUNNING_CONCURRENT_PROGRAM_ID
  and fcrrun.status_code = 'R'
  and fcrrun.status_code = 'R'
/