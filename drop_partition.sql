16:36:03 PNXTL08R.IT_PNET3>/

'ALTERTABLE'||A.TABLE_OWNER||'.'||A.TABLE_NAME||'DROPPARTITION'||A.PARTITION_NAME||';'
------------------------------------------------------------------------------------------------------------------------
alter table SYSADM.UDR_LT drop partition P2014W26;

1 linha selecionada.

16:36:16 PNXTL08R.IT_PNET3>select '@?/rdbms/admin/utlrp.sql' from dual;

'@?/RDBMS/ADMIN/UTLRP.SQ
------------------------
@?/rdbms/admin/utlrp.sql

1 linha selecionada.

16:36:23 PNXTL08R.IT_PNET3>spool off;
