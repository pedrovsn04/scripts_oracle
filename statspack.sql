== Installing and Configuring STATSPACK
== Create PERFSTAT Tablespace
CREATE TABLESPACE perfstat 
     DATAFILE '/datafiles/fnxtl03/dat/perfstat_01.dbf' SIZE 10000M autoextend on next 200M 
;


== Remove STATSPACK from the Database
SQL> @?/rdbms/admin/spdrop.sql
SQL> DROP TABLESPACE perfstat INCLUDING CONTENTS AND DATAFILES;

== Run the Create Scripts
/as sysdba

@?/rdbms/admin/catdbsyn.sql

@?/rdbms/admin/dbmspool.sql


$ cd $ORACLE_HOME/rdbms/admin
$ sqlplus "/ as sysdba"
SQL> @?/rdbms/admin/spcreate.sql


SQL> @?/rdbms/admin/spauto.sql
