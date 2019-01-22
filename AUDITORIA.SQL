
column  USERNAME format a15
column  MACHINE format a25
column  PROGRAM  format a18
column  OSUSER  format a10
column   MODULE  format a20
column  GRANTED_ROLE format a20

prompt "#######################################" 
prompt "  RELACAO DE SOLICITACOES DE ACESSO    "

select USERNAME,DT_EXECUCAO ,EXPIRY_DATE,substr( MOTIVO_LIBERACAO,1,150) MOTIVO
from dbascon.AUD_USERS_LOG  where EXPIRY_DATE>= trunc(sysdate) 
order by USERNAME,DT_EXECUCAO;



prompt "#######################################" 
prompt "  RELACAO DE ACESSO INDEVIDOS          "


select STATUS,INSTANCE_NAME,LOGON_TIME    ,IDLE,USERNAME   ,MACHINE, PROGRAM, OSUSER    ,MODULE       ,GRANTED_ROLE,   DT_LAST_TIME
  from dbascon.aud_users_sessao_indevida where DT_LAST_TIME >= trunc(sysdate)
 order by USERNAME, LOGON_TIME;
 