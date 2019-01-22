--------------------------------------------------------------------------------
-- Programas Concorrentes Incompat�veis
--
-- Uso:  @concconfr
--------------------------------------------------------------------------------
-- Pra que serve:
--    Lista as solicita��es em execu��o que confitam com a solicita��o informada
--
-- Informa��es adicionais
-- 
-- 
--------------------------------------------------------------------------------
UNDEF REQUEST_ID_WAITING


SELECT fcps.running_concurrent_program_id, fcrrun.request_id
  FROM apps.fnd_concurrent_requests fcrwait
     , apps.fnd_concurrent_program_serial fcps
     , apps.fnd_concurrent_requests fcrrun
 WHERE fcrwait.request_id = &&REQUEST_ID_WAITING
   AND fcps.to_run_concurrent_program_id = fcrrun.concurrent_program_id
--   AND fcrrun.phase_code = 'R'
   AND fcrrun.status_code = 'R'
   AND fcrwait.status_code = 'Q'
/