col SID for 99999
col MAQUINA for a20

Select SUBSTR((vs.SID),1,4) SID,
       vp.spid,
       vs.SERIAL#,
       SUBSTR((vs.USERNAME),1,20) USUARIO,
       vs.STATUS STATUS_,
       SUBSTR((vs.MACHINE),1,22) MAQUINA,
       SUBSTR((vs.PROGRAM),1,25) PROGRAMA,
       SUBSTR(to_char(vs.LOGON_TIME, 'DD-MM-YY HH24:MI:SS'),1,17) DT_HR_INICIAL,
       SUBSTR(to_char(sysdate, 'DD-MM-YY HH24:MI:SS'),1,17) DT_HR_ATUAL,
       vs.process
  FROM v$process vp, V$SESSION vs
 WHERE (vs.SID = '&SId_ou' or VP.SPID='&SPID')
and vs.status = 'ACTIVE'
   and vp.addr = vs.paddr
/
