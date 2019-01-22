--------------------------------------------------------------------------------
-- Programas Concorrentes Incompatíveis
--
-- Uso:  @concconfr
--------------------------------------------------------------------------------
-- Pra que serve:
--    Lista as solicitações em execução que confitam com a solicitação informada
--
-- Informações adicionais
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