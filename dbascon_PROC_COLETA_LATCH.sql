11:28:22 PNXTL04.IT_PPNETO>select dbms_metadata.get_ddl('PROCEDURE','PROC_COLETA_LATCH', 'DBASCON') from dual;

DBMS_METADATA.GET_DDL('PROCEDURE','PROC_COLETA_LATCH','DBASCON')
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

  CREATE OR REPLACE PROCEDURE "DBASCON"."PROC_COLETA_LATCH" IS
v_seq             number;
v_date            date;
v_particao        number;
v_particao_trunc_atual  varchar2(30);
v_particao_trunc_prox   varchar2(30);
v_sql             varchar2(4000);
v_sqlerrm         varchar2(60);
v_particao_part_01_status   varchar2(30);
v_particao_part_02_status   varchar2(30);
v_particao_part_03_status   varchar2(30);
v_particao_part_04_status   varchar2(30);

--
cursor sessao_ativo is select USERNAME, MODULE, ACTION
                         from v$session
                        where username='DBASCON'
                        and   MODULE='dbascon.coleta_status'
                        and   ACTION='inicio coleta';
r_sessao_ativo        sessao_ativo%rowtype;
--
cursor coleta_particao_status
                     is select NVL(particao_part_01_status, 'NULL'),
                               NVL(particao_part_02_status, 'NULL'),
                               NVL(particao_part_03_status, 'NULL'),
                               NVL(particao_part_04_status, 'NULL')
                          from dbascon.coleta_particao_status;
--
cursor c1 is select count(1) qtde
               from v$session_wait
              where event='enqueue'
              having count(1)>11
              group by event;
r1     c1%rowtype;
--
cursor c2 is select 'S'
               from v$session_wait w, dbascon.coleta_latch_lock c
              where w.event='enqueue'
              and   c.sid = w.sid
              and   c.seq_coleta > v_seq-10;
r2     c2%rowtype;
--
BEGIN
--
-- Verifica partição que deve ser usada
--
select seq_COLETA_LATCH.nextval into v_seq from dual;
v_date := sysdate+180;
v_particao := to_number(to_char(sysdate+180, 'mm'));
if    v_particao in (1,5,9) then
      v_particao := 1;
elsif v_particao in (2,6,10) then
      v_particao := 2;
elsif v_particao in (3,7,11) then
      v_particao := 3;
elsif v_particao in (4,8,12) then
      v_particao := 4;
ELSE
      v_particao := 9;
end if;


--
-- Verifica se existe uma execução de coleta rodando, se sim, não dispara nova execução
--
open sessao_ativo;
fetch sessao_ativo into r_sessao_ativo;
if  sessao_ativo%found then
    close sessao_ativo;
    insert into dbascon.coleta_status (cod_particao, seq_coleta, data_coleta_inicio, EXECUTADO)
                        values
	                             (v_particao, v_seq, v_date, 'NAO');
	  commit;
	  GOTO NAO_EXECUTA_COLETA;
else
    DBMS_APPLICATION_INFO.SET_MODULE( module_name => 'dbascon.coleta_status', action_name => 'inicio coleta');
    commit;
    close sessao_ativo;
end if;

--dbms_lock.sleep(120);
--
-- Captura status das partições
--
v_particao_part_01_status := 'NULL';
v_particao_part_02_status := 'NULL';
v_particao_part_03_status := 'NULL';
v_particao_part_04_status := 'NULL';
open coleta_particao_status;
fetch coleta_particao_status into v_particao_part_01_status,
                                  v_particao_part_02_status,
                                  v_particao_part_03_status,
                                  v_particao_part_04_status;
if  coleta_particao_status%notfound then
    insert into dbascon.coleta_particao_status
                (particao_part_01_status, particao_part_02_status,
                 particao_part_03_status, particao_part_04_status)
           values
                ('NULL', 'NULL', 'NULL', 'NULL');
    COMMIT;
end if;
close coleta_particao_status;

--
-- Valida status da partição
--
v_particao_trunc_atual := null;
v_particao_trunc_prox  := null;
if    v_particao = 1 then
      if  v_particao_part_01_status <> 'ATIVO' THEN
          v_particao_trunc_atual := 'PART_01';
          UPDATE dbascon.coleta_particao_status set particao_part_01_status = 'ATIVO';
      end if;
      if  v_particao_part_02_status <> 'NULL' THEN
          v_particao_trunc_prox := 'PART_02';
          UPDATE dbascon.coleta_particao_status set particao_part_02_status = 'NULL';
      end if;
elsif v_particao = 2 then
      if  v_particao_part_02_status <> 'ATIVO' THEN
          v_particao_trunc_atual := 'PART_02';
          UPDATE dbascon.coleta_particao_status set particao_part_02_status = 'ATIVO';
      end if;
      if  v_particao_part_03_status <> 'NULL' THEN
          v_particao_trunc_prox := 'PART_03';
          UPDATE dbascon.coleta_particao_status set particao_part_03_status = 'NULL';
      end if;
elsif v_particao = 3 then
      if  v_particao_part_03_status <> 'ATIVO' THEN
          v_particao_trunc_atual := 'PART_03';
          UPDATE dbascon.coleta_particao_status set particao_part_03_status = 'ATIVO';
      end if;
      if  v_particao_part_04_status <> 'NULL' THEN
          v_particao_trunc_prox := 'PART_04';
          UPDATE dbascon.coleta_particao_status set particao_part_04_status = 'NULL';
      end if;
elsif v_particao = 4 then
      if  v_particao_part_04_status <> 'ATIVO' THEN
          v_particao_trunc_atual := 'PART_04';
          UPDATE dbascon.coleta_particao_status set particao_part_04_status = 'ATIVO';
      end if;
      if  v_particao_part_01_status <> 'NULL' THEN
          v_particao_trunc_prox := 'PART_01';
          UPDATE dbascon.coleta_particao_status set particao_part_01_status = 'NULL';
      end if;
end if;
--
-- Trunca a partição corrente caso a mesma estiver com status diferente de ATIVO
if  v_particao_trunc_atual is not null then
    v_sql := 'ALTER TABLE COLETA_status TRUNCATE PARTITION '||v_particao_trunc_atual;
    EXECUTE IMMEDIATE v_sql;
    v_sql := 'ALTER TABLE coleta_objeto_invalido TRUNCATE PARTITION '||v_particao_trunc_atual;
    EXECUTE IMMEDIATE v_sql;
    v_sql := 'ALTER TABLE coleta_indice_unusable TRUNCATE PARTITION '||v_particao_trunc_atual;
    EXECUTE IMMEDIATE v_sql;
    v_sql := 'ALTER TABLE COLETA_LATCH TRUNCATE PARTITION '||v_particao_trunc_atual;
    EXECUTE IMMEDIATE v_sql;
    v_sql := 'ALTER TABLE coleta_latch_sid TRUNCATE PARTITION '||v_particao_trunc_atual;
    EXECUTE IMMEDIATE v_sql;
    v_sql := 'ALTER TABLE coleta_latch_lock TRUNCATE PARTITION '||v_particao_trunc_atual;
    EXECUTE IMMEDIATE v_sql;
    v_sql := 'ALTER TABLE coleta_qtde_sessao TRUNCATE PARTITION '||v_particao_trunc_atual;
    EXECUTE IMMEDIATE v_sql;
end if;
--
-- Trunca a proxima partição caso a mesma estiver com status diferente de NULL
if  v_particao_trunc_prox is not null then
    v_sql := 'ALTER TABLE COLETA_status TRUNCATE PARTITION '||v_particao_trunc_prox;
    EXECUTE IMMEDIATE v_sql;
    v_sql := 'ALTER TABLE coleta_objeto_invalido TRUNCATE PARTITION '||v_particao_trunc_prox;
    EXECUTE IMMEDIATE v_sql;
    v_sql := 'ALTER TABLE coleta_indice_unusable TRUNCATE PARTITION '||v_particao_trunc_prox;
    EXECUTE IMMEDIATE v_sql;
    v_sql := 'ALTER TABLE COLETA_LATCH TRUNCATE PARTITION '||v_particao_trunc_prox;
    EXECUTE IMMEDIATE v_sql;
    v_sql := 'ALTER TABLE coleta_latch_sid TRUNCATE PARTITION '||v_particao_trunc_prox;
    EXECUTE IMMEDIATE v_sql;
    v_sql := 'ALTER TABLE coleta_latch_lock TRUNCATE PARTITION '||v_particao_trunc_prox;
    EXECUTE IMMEDIATE v_sql;
    v_sql := 'ALTER TABLE coleta_qtde_sessao TRUNCATE PARTITION '||v_particao_trunc_prox;
    EXECUTE IMMEDIATE v_sql;
end if;
COMMIT;

--
-- Coleta quantidade de sessões
INSERT INTO dbascon.coleta_qtde_sessao
            (cod_particao, seq_coleta, DaTa_COLETA,
             USERNAME, osuser, status, qtde)
       select v_particao, v_seq, v_date,
              s.USERNAME, s.osuser, s.status, COUNT(1) qtde
         from gv$session s
        GROUP BY s.status, s.USERNAME, s.osuser;
COMMIT;


--
-- Coleta sessões com latch´s
INSERT INTO dbascon.COLETA_LATCH
            (cod_particao, seq_coleta, DaTa_COLETA, p2, EVENT, QTDE)
       select v_particao, v_seq, v_date, w.p2 p2, w.event event, count(1)
         from v$session_wait w
        group by w.event, w.p2;
COMMIT;

--
-- Coleta infomações de sessões com latch´s
-- (quando o tipo de latch tiver mais de 23 sessão presas no mesmo latch)
insert into dbascon.coleta_latch_sid
        (cod_particao, SEQ_COLETA, DATA_COLETA, SID, USERNAME, status, OSUSER
        ,SQL_HASH_VALUE, SQL_ADDRESS, IDLE, MACHINE
        ,TERMINAL, PROGRAM, LOGON_TIME, WAIT_TIME, SECONDS_IN_WAIT
        ,LATCH#, EVENT, P1, P2, STATE)
select v_particao, v_seq, v_date, w.sid, s.username, s.status, s.osuser, s.sql_hash_value, s.SQL_ADDRESS,
       substr(floor(s.last_call_et/3600)||':'||
       floor(mod(s.last_call_et,3600)/60)||':'||
       mod(mod(s.last_call_et,3600),60),1,8) IDLE,
       s.MACHINE, s.TERMINAL, s.PROGRAM, s.LOGON_TIME,
       W.WAIT_TIME, W.SECONDS_IN_WAIT,
       w.p2 latch#, w.event, to_char(w.p1) p1, w.p2, w.state
from v$session_wait w, v$session s
where s.sid        = w.sid
  AND w.event in (select event
                    from v$session_wait
                    where event <> 'SQL*Net message from client'
                    and   event <> 'db file sequential read'
                    and   event <> 'SQL*Net message from dblink'
                    and   event <> 'rdbms ipc message'
                    and   event <> 'gcs remote message'
                    and   event <> 'HS message to agent'
                    and   event <> 'jobq slave wait'
                    having count(1)>23
                   group by event)
  order by s.username;
commit;


--
-- Coleta infomações de objetos invalidos
-- (não traz os objetos que estiverem na tabela coleta_objeto_invalido_inicio)
insert into dbascon.coleta_objeto_invalido
        (cod_particao, SEQ_COLETA, DATA_COLETA,
         OWNER, OBJECT_NAME, SUBOBJECT_NAME,
         OBJECT_ID, OBJECT_TYPE, CREATED,
         LAST_DDL_TIME, TIMESTAMP, STATUS)
select v_particao, v_seq, v_date,
       sys.OWNER, sys.OBJECT_NAME, sys.SUBOBJECT_NAME,
       sys.OBJECT_ID, sys.OBJECT_TYPE, sys.CREATED,
       sys.LAST_DDL_TIME, sys.TIMESTAMP, sys.STATUS
  from sys.dba_objects sys
 where sys.status = 'INVALID'
 and   not exists (select 1 from dbascon.coleta_objeto_invalido_inicio dbascon
                    where dbascon.OBJECT_ID=sys.OBJECT_ID);
commit;


--
-- Coleta infomações de indices unusable
insert into dbascon.coleta_indice_unusable
        (cod_particao, SEQ_COLETA, DATA_COLETA,
         owner, INDEX_NAME, index_type,
         table_name, PARTITION_NAME, TABLESPACE_NAME)
select v_particao, v_seq, v_date,
       INDEX_OWNER owner, INDEX_NAME, ' ' index_type,
       ' ' table_name, PARTITION_NAME, TABLESPACE_NAME
  from dba_ind_partitions
 where status='UNUSABLE'
union all
select v_particao, v_seq, v_date,
       OWNER, INDEX_NAME, INDEX_TYPE,
       TABLE_NAME, ' ' partition_name, TABLESPACE_NAME
  from dba_indexes
 where status='UNUSABLE';
commit;


--
-- Coleta infomações de sessões em lock
-- (quando tiver mais de 12 sessão presas no lock)
open c1; -- Este cursor verificar se exitem sessões em lock
fetch c1 into r1;
if  c1%found then
    open c2;  -- Este cursor verificar se a sessão que está em lock já foi gravado, na ultima 10 coletas a traz.
    fetch c2 into r2;
    if  c2%notfound then
        begin
        insert into dbascon.coleta_latch_lock
                   (cod_particao, SEQ_COLETA, DATA_COLETA, STATUS_SESS, LOCKWAIT
                   ,SID, USERNAME, status, OSUSER,  SQL_HASH_VALUE, SQL_ADDRESS
                   ,IDLE, MACHINE, TERMINAL, PROGRAM, LOGON_TIME)
            select  distinct v_particao, v_seq, v_date, decode(s.lockwait, NULL,'*BLOCKER   ', '==WAITER  ') STATUS_SESS,
                   s.lockwait, s.sid, s.username, s.status,
                   s.osuser, s.sql_hash_value, s.SQL_ADDRESS,
                   substr(floor(s.last_call_et/3600)||':'||
                   floor(mod(s.last_call_et,3600)/60)||':'||
                   mod(mod(s.last_call_et,3600),60),1,8) IDLE,
                   s.MACHINE, s.TERMINAL, s.PROGRAM, s.LOGON_TIME
            from
                 ( select unique raddr, saddr, request from v$_lock where request > 0 ) waiter,
                 ( select raddr, saddr, request  from v$_lock where request = 0 ) blocker,
                   v$session s
            where waiter.raddr = blocker.raddr
              and ( waiter.saddr = s.saddr or blocker.saddr = s.saddr );
        exception
            when others then
                 v_sqlerrm := substr(sqlerrm,1,60);
                 insert into dbascon.coleta_latch_lock
                   (SEQ_COLETA, DATA_COLETA, STATUS_SESS, LOCKWAIT,
                    SID, USERNAME, OSUSER, SQL_HASH_VALUE, SQL_ADDRESS,
                    IDLE, MACHINE, TERMINAL, PROGRAM, LOGON_TIME)
                   values
                   (v_seq, v_date, null, null
                   ,null,null,null,null,null
                   ,null, v_sqlerrm, null, null, null);
        end;
    end if;
    close c2;
end if;
close c1;

--
-- Finaliza a execução da coleta
--
insert into dbascon.coleta_status (cod_particao, seq_coleta, data_coleta_inicio, data_coleta_fim, EXECUTADO)
                     values
                           (v_particao, v_seq, v_date, sysdate, 'SIM');
DBMS_APPLICATION_INFO.SET_MODULE( module_name => 'dbascon.coleta_status', action_name => 'null');
commit;

-- Existe uma coleta em execução
<<NAO_EXECUTA_COLETA>>
null;
exception
   when others then
        rollback;
        DBMS_APPLICATION_INFO.SET_MODULE( module_name => 'dbascon.coleta_status', action_name => 'null');
        commit;

END;


1 row selected.

11:29:01 PNXTL04.IT_PPNETO>@jobs

LOG_USER                              JOB B   FAILURES LAST_DATE        NEXT_DATE        PROCEDURE                                                                                                                                                                  INTERVALO
------------------------------ ---------- - ---------- ---------------- ---------------- -------------------------------------------------------------------------------------------------------------------------------------------------------------------------- ----------------------------------------
DBASCON                                65 N          0 31/07/2012 09:00 01/08/2012 09:00 AUD_ALTERACAO_SFA_PRODUCAO;                                                                                                                                                trunc(SYSDATE)+ 1 + 9/24
DBASCON                                66 Y         16                  01/01/4000 00:00 AUD_EXECUTA_OPERACAO(1);                                                                                                                                                   trunc(sysdate)+1 + 17/48
DBASCON                                67 N          0 31/07/2012 10:00 01/08/2012 10:00 AUD_EXECUTA_OPERACAO(12);                                                                                                                                                  trunc(SYSDATE)+ 1 + 10/24
DBASCON                                68 N          0 31/07/2012 11:00 01/08/2012 11:00 AUD_EXECUTA_OPERACAO(13);                                                                                                                                                  trunc(SYSDATE)+ 1 + 11/24
DBASCON                                69 N          0 31/07/2012 11:00 01/08/2012 11:00 AUD_EXECUTA_OPERACAO(14);                                                                                                                                                  trunc(SYSDATE)+ 1 + 11/24
DBASCON                                70 N          0 31/07/2012 08:30 01/08/2012 08:30 AUD_EXECUTA_OPERACAO(16);                                                                                                                                                  trunc(SYSDATE)+ 1 + 17/48
DBASCON                                71 N          0 31/07/2012 06:00 01/08/2012 06:00 AUD_EXECUTA_OPERACAO(18);                                                                                                                                                  trunc(SYSDATE)+ 1 + 6/24
DBASCON                                72 N          0 31/07/2012 08:00 01/08/2012 08:00 AUD_EXECUTA_OPERACAO(2);                                                                                                                                                   trunc(sysdate)+1 + 16/48
DBASCON                                73 N          0 31/07/2012 05:00 01/08/2012 05:00 AUD_EXECUTA_OPERACAO(24);                                                                                                                                                  trunc(SYSDATE)+ 1 + 5/24
DBASCON                                74 N          0 31/07/2012 06:00 01/08/2012 06:00 AUD_EXECUTA_OPERACAO(25);                                                                                                                                                  trunc(sysdate)+1 + 06/24
DBASCON                                75 N          0 31/07/2012 08:16 31/07/2012 14:16 AUD_EXECUTA_OPERACAO(28);                                                                                                                                                  sysdate + 6/24
DBASCON                                76 N          0 31/07/2012 08:00 01/08/2012 08:00 AUD_EXECUTA_OPERACAO(5);                                                                                                                                                   trunc(SYSDATE)+ 1 + 8/24
DBASCON                                77 N          0 30/07/2012 19:00 31/07/2012 19:00 AUD_EXECUTA_OPERACAO(6);                                                                                                                                                   trunc(SYSDATE)+ 1 + 19/24
DBASCON                                78 N          0 30/07/2012 19:00 31/07/2012 19:00 AUD_EXECUTA_OPERACAO(7);                                                                                                                                                   trunc(SYSDATE)+ 1 + 19/24
DBASCON                                79 Y         16                  01/01/4000 00:00 AUD_EXECUTA_OPERACAO(8);                                                                                                                                                   trunc(sysdate)+1 + 07/24
DBASCON                                80 N          0 31/07/2012 10:00 01/08/2012 10:00 AUD_EXECUTA_OPERACAO(9);                                                                                                                                                   trunc(SYSDATE)+ 1 + 10/24
DBASCON                                81 N          0 31/07/2012 09:00 01/08/2012 09:00 AUD_LIMPA_AUDPAR;                                                                                                                                                          trunc(SYSDATE)+ 1 + 9/24
DBASCON                                82 N          0 31/07/2012 07:30 01/08/2012 07:30 AUD_VERIFICA_INDISPONIBILIDADE;                                                                                                                                            trunc(SYSDATE)+ 1 + 15/48
SYSMAN                                 18 N          0 31/07/2012 11:00 31/07/2012 12:00 BEGIN MGMT_BSLN.SET_ALL_THRESHOLDS;/*GC*/END;                                                                                                                              trunc(sysdate,'HH24')+1/24
SYSMAN                                 17 N          0 30/07/2012 23:30 31/07/2012 23:30 BEGIN MGMT_BSLN_INTERNAL.PURGE_EXTRACT_RAWDATA;MGMT_BSLN.COMPUTE_ALL_STATISTICS;/*GC*/END;                                                                                 trunc(sysdate+1/2) + 47/48
DBASCON                                83 Y         16                  01/01/4000 00:00 DBASCON.NXT_ADM_USUARIOS.DEMITIDOS;                                                                                                                                        SYSDATE + 1
SYS                                     1 N          0 31/07/2012 11:15 31/07/2012 12:15 E2E_ROLLUP.ROLLUP();                                                                                                                                                       SYSDATE + (1/24)
SYSMAN                                 13 N          0 31/07/2012 11:13 31/07/2012 12:13 EMD_E2E_ROLLUP.ROLLUP();                                                                                                                                                   sysdate + (1/24)
SYSMAN                                  5 N          0 31/07/2012 11:13 31/07/2012 12:13 EMD_LOADER.ROLLUP();                                                                                                                                                       sysdate + (1/24)
SYSMAN                                  6 N          0 31/07/2012 11:30 31/07/2012 11:31 EMD_NOTIFICATION.CHECK_FOR_SEVERITIES();                                                                                                                                   sysdate + (1/(24*60*2))
SYSMAN                                 12 N          0 31/07/2012 11:14 31/07/2012 12:14 EMD_RT_ROLLUP.ROLLUP();                                                                                                                                                    sysdate + (1/24)
SYSMAN                                 10 N          0 31/07/2012 09:32 01/08/2012 09:32 EM_AUDIT_EXTERNALIZATION.audit_externalization_proc();                                                                                                                     sysdate + 1
SYSMAN                                  7 N          0 31/07/2012 11:31 31/07/2012 11:31 EM_PING.MARK_NODE_STATUS();                                                                                                                                                sysdate + (1/(24*60*2))
SYSMAN                                 19 N          0 31/07/2012 00:01 01/08/2012 00:01 EM_POLICY.CLEAR_EXPIRED_SUPPRESSIONS;                                                                                                                                      trunc(SYSDATE + 1)+(1/60/24)
SYSMAN                                 15 N          0 31/07/2012 00:00 01/08/2012 00:00 EM_PURGE.APPLY_PURGE_POLICIES();                                                                                                                                           trunc(sysdate + 1)
SYSMAN                                  8 N          0 31/07/2012 11:30 31/07/2012 11:31 EM_SEVERITY_REPOS.EXECUTE_REPOS_SEVERITY_EVAL();                                                                                                                           sysdate + 1 / (24 * 60)
SYSMAN                                 20 N          0 31/07/2012 11:14 31/07/2012 12:14 EM_TASK.RESUBMIT_FAILED_TASK();                                                                                                                                            SYSDATE+1/24
SYSMAN                                  3 N          0 31/07/2012 11:30 31/07/2012 11:31 EM_TASK.WORKER(1);                                                                                                                                                         SYSDATE + 1/1440
SYSMAN                                  4 N          0 31/07/2012 11:30 31/07/2012 11:31 EM_TASK.WORKER(2);                                                                                                                                                         SYSDATE + 1/1440
SYS                                    21 N          0 31/07/2012 01:00 01/08/2012 01:00 MGMT_EMREP_METRICS.collect_config_metrics('EMREP_DIR_NAME');                                                                                                               TRUNC(SYSDATE) + 1 + 1/24
SYS                                    22 N          0 01/07/2012 01:00 01/08/2012 01:00 MGMT_EMREP_METRICS.collect_stats_metrics('EMREP_DIR_NAME');                                                                                                                TRUNC(LAST_DAY(SYSDATE) + 1) + 1/24
SYSMAN                                 14 N          0 31/07/2012 11:30 31/07/2012 11:31 MGMT_GENSVC_AVAIL.EXEC_AVAIL_JOB();                                                                                                                                        sysdate + (1/1440)
SYSMAN                                  9 N          0 31/07/2012 09:31 01/08/2012 09:31 MGMT_JOB_ENGINE.apply_purge_policies();                                                                                                                                    sysdate + 1
SYSMAN                                 16 N          0 31/07/2012 09:32 01/08/2012 09:32 MGMT_RCA.PURGE_RCA_RESULTS();                                                                                                                                              sysdate + 1
DBASCON                               146 N          0 02/07/2012 19:35 10/08/2012 02:00 PMON_OPERATION('ASM_DISK');                                                                                                                                                trunc(last_day(sysdate)+10)+(2/24)
DBASCON                               145 N          0 02/07/2012 19:30 10/08/2012 01:00 PMON_OPERATION('ASM_DISKGROUP');                                                                                                                                           trunc(last_day(sysdate)+10)+(1/24)
DBASCON                               144 N          0 31/07/2012 11:15 31/07/2012 11:45 PMON_OPERATION('OBJECT_INVALID');                                                                                                                                          sysdate+(0.5/24)
DBASCON                               147 N          0 02/07/2012 19:30 10/08/2012 03:00 PMON_OPERATION('PARAMETER_INFO');                                                                                                                                          trunc(last_day(sysdate)+10)+(3/24)
DBASCON                               103 Y         16 03/06/2012 08:00 01/01/4000 00:00 begin AUD_INVALID_OBJECTS_PRC('DBL_PNXTL01'); AUD_INVALID_OBJECTS_PRC('DBL_PNXTL03'); AUD_INVALID_OBJECTS_PRC('DBL_PNXTL04'); AUD_INVALID_OBJECTS_PRC('DBL_PNXTL05'); AUD_ trunc(sysdate + 1) + 8/24
DBASCON                               123 N          0 31/07/2012 11:30 31/07/2012 11:32 dbascon.aud_users_indevido;                                                                                                                                                sysdate+1/1000
DBASCON                               124 N          0 31/07/2012 11:30 31/07/2012 11:34 dbascon.controle_analista.verifica_validade;                                                                                                                               sysdate+1/380
DBASCON                                84 N          0 31/07/2012 06:30 01/08/2012 06:30 dbascon.crescimento_owner;                                                                                                                                                 trunc(sysdate)+1 + 13/48
SYS                                    44 Y         16 18/12/2011 00:40 01/01/4000 00:00 dbms_refresh.refresh('DBASCON.VWBR_USER_NEXTEL');                                                                                                                          sysdate+(1/12)
SYSMAN                                 11 N          0 31/07/2012 03:10 01/08/2012 03:10 emd_maintenance.analyze_emd_schema('SYSMAN');                                                                                                                              trunc(sysdate + 1) + 3/24 + 10/60/24
DBASCON                                85 Y         16 22/03/2012 00:30 01/01/4000 00:00 nxt_fnd_concurrent.BACKUP_CONCURRENT_REQUESTS;                                                                                                                             trunc(sysdate)+1 + 1/48

50 rows selected.


OWNER      JOB_NAME                       JOB_CREATOR    ACTION                                                                                                                             INTERVAL                       ENABL RESTA STATE            RUN_COUNT FAILURE_COUNT LAST_START_DATE                                                             LAST_RUN_DURATION
---------- ------------------------------ -------------- ---------------------------------------------------------------------------------------------------------------------------------- ------------------------------ ----- ----- --------------- ---------- ------------- --------------------------------------------------------------------------- ---------------------------------------------------------------------------
SYS        XMLDB_NFS_CLEANUP_JOB          SYS            xdb.dbms_xdbutil_int.cleanup_expired_nfsclients                                                                                    Freq=minutely;interval=5       FALSE FALSE DISABLED                 0             0
SYS        SM$CLEAN_AUTO_SPLIT_MERGE      SYS            sys.dbms_streams_auto_int.clean_auto_split_merge;                                                                                  freq=daily;byhour=0;byminute=0 TRUE  FALSE SCHEDULED              358             0 31-JUL-12 12.00.00.211408 AM BRAZIL/EAST                                    +000000000 00:00:00.007429
SYS        RSE$CLEAN_RECOVERABLE_SCRIPT   SYS            sys.dbms_streams_auto_int.clean_recoverable_script;                                                                                freq=daily;byhour=0;byminute=0 TRUE  FALSE SCHEDULED              358             0 31-JUL-12 12.00.00.206108 AM BRAZIL/EAST                                    +000000000 00:00:00.006899
SYS        FGR$AUTOPURGE_JOB              SYS            sys.dbms_file_group.purge_file_group(NULL);                                                                                        freq=daily;byhour=0;byminute=0 FALSE FALSE DISABLED                 0             0
SYS        BSLN_MAINTAIN_STATS_JOB        SYS                                                                                                                                                                              TRUE  FALSE SCHEDULED               52             0 29-JUL-12 12.00.00.896177 AM -03:00                                         +000000000 00:00:11.374093
SYS        DRA_REEVALUATE_OPEN_FAILURES   SYS            dbms_ir.reevaluateopenfailures                                                                                                                                    TRUE  FALSE SCHEDULED              357             0 30-JUL-12 10.00.02.118682 PM BRAZIL/EAST                                    +000000000 00:00:00.029419
SYS        HM_CREATE_OFFLINE_DICTIONARY   SYS            dbms_hm.create_offline_dictionary                                                                                                                                 FALSE FALSE DISABLED                 0             0
SYS        ORA$AUTOTASK_CLEAN             SYS                                                                                                                                                                              TRUE  FALSE SCHEDULED              359             0 31-JUL-12 03.00.00.312851 AM BRAZIL/EAST                                    +000000000 00:00:00.005530
SYS        FILE_WATCHER                   SYS                                                                                                                                                                              FALSE FALSE DISABLED                 0             0
SYS        PURGE_LOG                      SYS                                                                                                                                                                              TRUE  FALSE SCHEDULED              359             0 31-JUL-12 03.00.00.313190 AM BRAZIL/EAST                                    +000000000 00:00:00.109007
EXFSYS     RLM$SCHDNEGACTION              SYS            begin dbms_rlmgr_dr.execschdactions('RLM$SCHDNEGACTION'); end;                                                                     FREQ=MINUTELY;INTERVAL=60      TRUE  FALSE SCHEDULED             8909             0 31-JUL-12 10.56.10.007275 AM -03:00                                         +000000000 00:00:00.015877
EXFSYS     RLM$EVTCLEANUP                 SYS            begin dbms_rlmgr_dr.cleanup_events; end;                                                                                           FREQ = HOURLY; INTERVAL = 1    TRUE  FALSE SCHEDULED             8558             0 31-JUL-12 11.30.09.509319 AM -03:00                                         +000000000 00:00:00.006089
ORACLE_OCM MGMT_CONFIG_JOB                SYS            ORACLE_OCM.MGMT_CONFIG.collect_config                                                                                                                             TRUE  FALSE SCHEDULED               85             0 30-JUL-12 10.00.02.118091 PM BRAZIL/EAST                                    +000000000 00:00:00.056917
ORACLE_OCM MGMT_STATS_CONFIG_JOB          SYS            ORACLE_OCM.MGMT_CONFIG.collect_stats                                                                                               freq=monthly;interval=1;bymont TRUE  FALSE SCHEDULED                2             0 01-JUL-12 01.01.01.812642 AM -03:00                                         +000000000 00:00:00.151844

14 rows selected.

11:30:25 PNXTL04.IT_PPNETO>
11:30:42 PNXTL04.IT_PPNETO>
11:30:42 PNXTL04.IT_PPNETO>@obj
Enter value for objeto: PROC_COLETA_LATCH
Enter value for owner: DBACON

no rows selected

11:30:48 PNXTL04.IT_PPNETO>/
Enter value for objeto: PROC_COLETA_LATCH
Enter value for owner: DBASCON

OWNER      OBJECT_NAME                    OBJECT_TYPE      CREATED             LAST_DDL_TIME       TIMESTAMP           STATUS
---------- ------------------------------ ---------------- ------------------- ------------------- ------------------- -------
DBASCON    PROC_COLETA_LATCH              PROCEDURE        10/01/2012 13:22:04 10/01/2012 14:42:49 2012-01-10:14:42:49 VALID

1 row selected.

11:30:55 PNXTL04.IT_PPNETO>@conn
Enter value for banco: pnxtl12
ERROR:
ORA-12170: TNS:Connect timeout occurred


Warning: You are no longer connected to ORACLE.
13:26:49 PNXTL04.IT_PPNETO>conn dbascon/nextel_flir#tacia*0987@pnxtl12
Connected.
