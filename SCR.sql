set pages 0
set feed off
set lines 180
SELECT substr(A.TS_ISSUEID||': '||A.TS_TITLE||' - Solicitado por: '||B.TS_NAME,1,130) AS "SCR - MUDANÇA",
       'Data de Execução: '||((A.TS_DT_E_HR_INICIAIS_EXEC-10800)/24/60/60 + TO_DATE('01/01/1970 00:00:00')) AS "DATA DE EXECUÇÃO",
        CHR(10)||'Procedimento: '||CHR(10)||A.TS_PROC_BD_TX||CHR(10)||CHR(10)||'################################################################################'
  FROM TTK.USR_PROGRAMADA A, TTK.TS_USERS B
 WHERE A.TS_STATE IN (111,89)
   AND A.TS_SUBMITTER = B.TS_ID
   AND A.TS_PROC_BD_TX IS NOT NULL
   AND TRUNC((A.TS_DT_E_HR_INICIAIS_EXEC-10800)/24/60/60 + TO_DATE('01/01/1970 00:00:00')) > TRUNC(SYSDATE-1)
 ORDER BY 2;
