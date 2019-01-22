--------------------------------------------------------------------------------
-- Programas Concorrentes Incompatíveis
--
-- Uso:  @concconfp
--------------------------------------------------------------------------------
-- Pra que serve:
--    Lista os programas concorrentes incompatíveis a partir de um 
--    concurrent_program_id
--
-- Informações adicionais
-- 
-- 
--------------------------------------------------------------------------------

COL user_concurrent_program_name	FORMAT A80 HEADING "Programa Concorrente Incompatível"
COL running_concurrent_program_id	HEADING "PROG ID"

UNDEF VCONCPROG
UNDEF VLANG
UNDEF CONC_PROG_ID_WAITING
UNDEF LANGUAGE

DEF VCONCPROG=&&CONC_PROG_ID_WAITING
DEF VLANG=&LANGUAGE

SELECT fcps.running_concurrent_program_id, fcp.user_concurrent_program_name
  FROM apps.fnd_concurrent_program_serial fcps, apps.fnd_concurrent_programs_tl fcp
 WHERE fcp.concurrent_program_id = fcps.running_concurrent_program_id
   AND fcp.LANGUAGE = UPPER(NVL('&VLANG','US'))
   AND fcps.to_run_concurrent_program_id = &VCONCPROG
/