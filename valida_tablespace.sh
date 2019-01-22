#!/bin/ksh
sqlplus /nolog' <<EOF
spool valida_tablespace.lst
prompt PNXTL01
conn it_pdcamarg/x@pnxtl01
spool valida_tablespace.lst
@valida_tablespace.sql
prompt PNXTL19
conn it_pdcamarg/x@pnxtl19
@valida_tablespace.sql
prompt PNXTL05
conn it_pdcamarg/x@pnxtl05
@valida_tablespace.sql
prompt PNXTL07
conn it_pdcamarg/x@pnxtl07
@valida_tablespace.sql
prompt PNXTL12
conn it_pdcamarg/x@PNXTL122.WORLD
@valida_tablespace.sql
prompt PNXTL15
conn it_pdcamarg/x@pnxtl15
@valida_tablespace.sql
prompt PNXTL08
conn it_pdcamarg/x@pnxtl08
@valida_tablespace.sql
prompt PNXTL08R
conn it_pdcamarg/x@pnxtl08r
@valida_tablespace.sql
conn it_pdcamarg/x@pnxtl25
prompt pnxtl25
@valida_tablespace.sql
spool off


EOF
mailx -s "Monitor Tablespace dos bancos de Produção 01,05,07,08,08r,12,15,19,25" darcio.camargo@hp.com <valida_tablespace.lst
