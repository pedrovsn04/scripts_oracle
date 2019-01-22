Select SUBSTR((vs.SID),1,4) SID_,
       vp.spid, vs.inst_id,
       vs.SERIAL#,
       SUBSTR((vs.USERNAME),1,20) USUARIO,
       vs.STATUS STATUS_,
       SUBSTR((vs.MACHINE),1,22) MAQUINA,
       SUBSTR((vs.PROGRAM),1,25) PROGRAMA,
       SUBSTR(to_char(vs.LOGON_TIME, 'DD-MM-YY HH24:MI:SS'),1,17) DT_HR_INICIAL,
       SUBSTR(to_char(sysdate, 'DD-MM-YY HH24:MI:SS'),1,17) DT_HR_ATUAL,
       vs.process
FROM gv$process vp, gV$SESSION vs
WHERE (SID = '&SId_ou' OR VP.SPID='&SPID')
and vp.addr = vs.paddr
and vp.inst_id=vs.inst_id
and vp.inst_id='&id'
and vp.addr = vs.paddr
/