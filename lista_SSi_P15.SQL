accept SSi prompt   'Entre com a SSI ou lista de SSI ex 123,124,125 .: '
col BANCO format a20 
col PROFILE FORMAT A15
prompt " LISTANDO SSI de SOLICITACAO DE ANALISTAS " 
          SELECT C.CD_SERVICE_REQUEST "ID SSI",
                    TRIM(CASE WHEN instr(G.NM_SYSTEM,'(') > 0 THEN substr(G.NM_SYSTEM,1,instr(G.NM_SYSTEM,'(')-1) ELSE G.NM_SYSTEM END) BANCO,
                    DECODE(B.NM_SYSTEM_MODULE_PROFILE,'SYSADM (BSCS)','SYSADM',B.NM_SYSTEM_MODULE_PROFILE) PROFILE,
                    'IT_'||D.CD_LOGIN_USER "LOGIN BANCO",
                    substr(c.DE_SERVICE_REQUEST_REMARK,1,100)  REMARK,
                    substr(RTRIM(c.DE_SERVICE_REQUEST_JUSTIFY),1,50)  JUSTIFY                   
              FROM WBR.TWBR_ADD_INF_PROFILE_SYSTEM  A,
                   WBR.TWBR_PROFILE_SYSTEM_MODULE  B,
                   WBR.TWBR_SERVICE_REQUEST  C,
                   WBR.REPL_VWBR_USER_NEXTEL  D,
                   WBR.TWBR_USER_ANSWERED  E,
                   WBR.REPL_VWBR_USER_NEXTEL  F,
                   WBR.TWBR_SYSTEM  G,
                   WBR.TWBR_SYSTEM_MODULE  H
             WHERE A.CD_SERVICE_REQUEST = C.CD_SERVICE_REQUEST AND
                   E.CD_SERVICE_REQUEST = C.CD_SERVICE_REQUEST AND
                   E.CD_SERVICE_REQUEST = C.CD_SERVICE_REQUEST  AND
                   A.CD_SYSTEM_MODULE_PROFILE = B.CD_SYSTEM_MODULE_PROFILE AND
                   E.ID_USER = D.ID_USER AND
                   D.ID_USER_GESTOR = F.ID_USER AND
                   A.ID_SYSTEM = H.ID_SYSTEM AND
--                   A.ID_SYSTEM = H.ID_SYSTEM_MODULE AND
                   G.ID_SYSTEM = H.ID_SYSTEM AND
                   C.CD_SERVICE_REQUEST in (&SSi)
 GROUP BY C.CD_SERVICE_REQUEST ,
                   G.NM_SYSTEM ,
                   B.NM_SYSTEM_MODULE_PROFILE,
c.DE_SERVICE_REQUEST_REMARK,
c.DE_SERVICE_REQUEST_JUSTIFY,
                    D.CD_LOGIN_USER
         order by 1,4;
prompt  "  => Listando se é login GENERICO   owner , USR , ou o ARSUSR "
SELECT C.CD_SERVICE_REQUEST "ID SSI",   G.NM_SYSTEM "BANCO", substr(upper(A.id_new_system_generic_login),1,15)  "LOGIN GENERICO"
--,substr(DE_SERVICE_REQUEST_EXECUTION,1,150)
,substr(DE_SERVICE_REQUEST_JUSTIFY,1,100)
  FROM WBR.TWBR_ADD_INF_GENERIC_LOGIN  A,
       WBR.TWBR_SERVICE_REQUEST  C,
       WBR.TWBR_SYSTEM  G,
       WBR.TWBR_SYSTEM_MODULE  H
 WHERE A.CD_SERVICE_REQUEST = C.CD_SERVICE_REQUEST AND
       A.id_system_module_to_new_login = H.ID_SYSTEM_MODULE AND
       G.ID_SYSTEM = H.ID_SYSTEM AND
       C.CD_SERVICE_REQUEST in (&SSi)
/
