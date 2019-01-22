declare
        vSQL                    Varchar2(32767);
        vSQL1                   Varchar2(32767);
        vSQL2                   Varchar2(32767);
        vSQL3                   Varchar2(32767);
        vSQL4                   Varchar2(32767);
        Vtablespace_dat         Varchar2(30);
        Vtablespace_idx         Varchar2(30);
        Vpartition              Varchar2(30);
        Vtablespace_part        Varchar2(30);
        Vlastpartition          Varchar2(30);
        VLESS                   Varchar2(30);
        VBANCO                  Varchar2(30);
        Vnrdias                 Number:=0;
        Vaux                    Number:=0;
        Vaux2                   Number:=1;
        achou_dat               Number:=0;
        achou_idx               Number:=0;
        Vachou_particao         Number:=0;
        VBlock                                  Varchar2(30);
		VSYSDATE                date:=SYSDATE+30;
--
BEGIN
/*
        Criado.: Dener Roberto
        Data    .: 25/10/2007
    Este devera ser executado todo dia 15 de cada mes para criacao de particoes diarias
        Exemplo.:
    No dia 15/08/05 devera ser criado a partigco para  P200509 COM VALUE LESS 2005-10-01 ate ultimo dia do mes
    Define a tablespace , PARTICAO e VLESS a serem criadas
    As tabelas tratadas sao
        'TMIT_STMN_INTERCONNECTION'
        'TMIT_GENERAL_DISPATCH_CALL'
        'TMIT_INTERCONNECTION_CALL'
    'TMIT_CONTRACT_STMN_INTERCONN'    incluido DENER   21/05/10
        Caminho: /amb/scripts/oracle/sql
*/
dbms_output.put_line( '#============================================================================#');
dbms_output.put_line( '#       Data de Execucao - '||to_char(VSYSDATE,'DD-MON-YYYY hh:mi:ss'));
dbms_output.put_line( '#                                                                            #');
dbms_output.put_line( '#               INICIANDO A CRIACAO DE PARTICOES DIARIAS MIT                 #');
dbms_output.put_line( '#============================================================================#');
-- =============================================================
--  Retorna o nzmero de dias do mes a ser criado as Partigues
--
        select
               -- to_number(to_char(last_day(VSYSDATE+20),'DD')),
                to_number(to_char(last_day(add_months(VSYSDATE,+1)),'DD')),
                'p'||To_Char(last_day(VSYSDATE)+1,'YYYYMM') ,
        DECODE(INSTR(GLOBAL_NAME,'.'),0,rtrim(lower(GLOBAL_NAME)),rtrim(lower(SUBSTR(GLOBAL_NAME,1,INSTR(GLOBAL_NAME,'.')-1))))
        into
                Vnrdias ,Vtablespace_part , VBANCO
        from global_name;
--
-- =============================================================
--  Este cursor retorna as Tabelas e Tablespaces a serem utilizadas
--
        FOR C1 IN (
                      select owner, table_name ,
                         'GCOB_DAT'  Vtablespace_dat,
                        'GCOB_IDX' Vtablespace_idx
             from dba_tables
                where
                        owner = 'GCOB_OW'   and
                        table_name  in  ('TRD_RESUMO_SALDO_LOTE','TRD_SERVCO_PRSTDO_SAIDA','TRD_SERVCO_PRSTDO_FISCAL','TRD_SERVCO_PRSTDO_CENRIO','TRD_CRITCA_INTERF','TRD_RSULTD_PRE','TRD_RESUMO_PRCMTO','TRD_SERVCO_PRSTDO_ULTIMA','TRD_RESUMO_REP','TRD_SERVCO_PRSTDO_PRE','TRD_SERVCO_PRSTDO')
                ) loop
--
-- =============================================================
-- Verifica se tablespace ja existe
--
                select count(*) into achou_dat
                  from  dba_tablespaces
                 where  tablespace_name= upper(c1.Vtablespace_dat);
--
                select count(*) into achou_idx
                  from  dba_tablespaces
                where  tablespace_name= upper(c1.Vtablespace_idx);
--
-- =============================================================
--  Se nco encotrar cria as TABLESPACES  DAT e IDX
--
        if ( achou_dat = 0) then
                if c1.table_name='TMIT_GENERAL_DISPATCH_CALL' then
             vSQL:='CREATE TABLESPACE '|| c1.Vtablespace_dat ||' datafile ''+DG_DATA01'' size 501M reuse AUTOEXTEND ON NEXT 200M MAXSIZE UNLIMITED ,''+DG_DATA01'' size 501M reuse AUTOEXTEND ON NEXT 200M MAXSIZE UNLIMITED ,''+DG_DATA01'' size 501M reuse AUTOEXTEND ON NEXT 200M  MAXSIZE UNLIMITED,''+DG_DATA01'' size 501M reuse AUTOEXTEND ON NEXT 200M MAXSIZE UNLIMITED ,''+DG_DATA01'' size 501M reuse AUTOEXTEND ON NEXT 200M  MAXSIZE UNLIMITED,''+DG_DATA01'' size 501M reuse AUTOEXTEND ON NEXT 200M  MAXSIZE UNLIMITED,''+DG_DATA01'' size 501M reuse AUTOEXTEND ON NEXT 200M  MAXSIZE UNLIMITED,''+DG_DATA01'' size 501M reuse AUTOEXTEND ON NEXT 200M  MAXSIZE UNLIMITED,''+DG_DATA01'' size 501M reuse AUTOEXTEND ON NEXT 200M  MAXSIZE UNLIMITED EXTENT MANAGEMENT LOCAL  uniform size 200m ';
            else
             vSQL:='CREATE TABLESPACE '|| c1.Vtablespace_dat ||' datafile ''+DG_DATA01'' size 101M AUTOEXTEND ON  NEXT 100M MAXSIZE UNLIMITED ,''+DG_DATA01'' size 101M AUTOEXTEND ON NEXT 100M MAXSIZE UNLIMITED, ''+DG_DATA01'' size 101M AUTOEXTEND ON NEXT 100M MAXSIZE UNLIMITED,''+DG_DATA01'' size 101M AUTOEXTEND ON NEXT 100M MAXSIZE UNLIMITED,''+DG_DATA01'' size 101M AUTOEXTEND ON NEXT 100M MAXSIZE UNLIMITED EXTENT MANAGEMENT LOCAL  uniform size 100m ';
            end if;
             VSQL2:='alter user MIT quota unlimited on '||c1.Vtablespace_dat;
            -- VSQL3:='alter table '||c1.owner||'.'||c1.table_name ||' modify default attributes tablespace '||c1.Vtablespace_dat;
                begin
           dbms_output.put_line(substr(VSQL,1,255));
        end;
        else
        dbms_output.put_line( '#=============================================================#');
        dbms_output.put_line( '#  TABLESPACE ja existe para nome  : '|| C1.Vtablespace_dat);
        dbms_output.put_line( '#=============================================================#');
    end if;
--
    if ( achou_idx=0)  then
        if c1.table_name='TMIT_GENERAL_DISPATCH_CALL' then
          vSQL:='CREATE TABLESPACE '|| c1.Vtablespace_idx ||' datafile ''+DG_DATA01'' size 201M reuse AUTOEXTEND ON NEXT 100M MAXSIZE UNLIMITED ,''+DG_DATA01'' size 201M  reuse AUTOEXTEND ON NEXT 100M MAXSIZE UNLIMITED ,''+DG_DATA01'' size 201M reuse AUTOEXTEND ON NEXT 100M MAXSIZE UNLIMITED,''+DG_DATA01'' size 201M reuse AUTOEXTEND ON NEXT 100M MAXSIZE UNLIMITED,''+DG_DATA01'' size 201M reuse AUTOEXTEND ON NEXT 100M MAXSIZE UNLIMITED ,''+DG_DATA01'' size 201M reuse AUTOEXTEND ON NEXT 100M MAXSIZE UNLIMITED,''+DG_DATA01'' size 201M reuse AUTOEXTEND ON NEXT 100M MAXSIZE UNLIMITED,''+DG_DATA01'' size 201M reuse AUTOEXTEND ON NEXT 100M MAXSIZE UNLIMITED ,''+DG_DATA01'' size 201M reuse AUTOEXTEND ON NEXT 100M MAXSIZE UNLIMITED  EXTENT MANAGEMENT LOCAL  uniform size 200m ';
          else
          vSQL:='CREATE TABLESPACE '|| c1.Vtablespace_idx ||' datafile ''+DG_DATA01'' size 101M AUTOEXTEND ON NEXT 100M MAXSIZE UNLIMITED EXTENT MANAGEMENT LOCAL uniform size 100m ';
        end if;
          VSQL2:='alter user MIT quota unlimited on '||c1.Vtablespace_idx ;
        begin
         dbms_output.put_line(substr(VSQL,1,255));
        end;
        else
                dbms_output.put_line( '#=============================================================#');
                dbms_output.put_line( '#  TABLESPACE ja existe para nome  : '|| c1.Vtablespace_idx);
                dbms_output.put_line( '#=============================================================#');
        end if;
-- =============================================================
-- Criando particoes diarias
--
         Vaux :=0;
         Vaux2 :=1;
                FOR x in 1..Vnrdias loop
                  Vaux   :=Vaux+1;
                  Vaux2  :=Vaux2+1;
                select
                       'P_'||to_char(last_day(VSYSDATE)+1 ,'YYYY')||'_'||to_char(last_day(VSYSDATE)+1 ,'MM')||'_'||ltrim(to_char(Vaux,'00') ) ,
                    (to_char(last_day(VSYSDATE)+Vaux2,'YYYY-MM-DD'))||' 00:00:00'
                into
                     Vpartition,
                     VLESS
                from  global_name;
--
-- =============================================================
-- Verifica se ja existe as particoes criadas para as tabelas
--
                Vachou_particao:=0;
                select count(*) into Vachou_particao
                  from dba_tab_partitions
                 where table_name = c1.table_name
                  and   partition_name = Vpartition;
--
-- =============================================================
-- Caso nao encontre, sera criada a particao e feito o rebuild dos indices
--
           if ( Vachou_particao = 0 ) then
            		vSQL:= 'ALTER TABLE '||c1.owner||'.'||c1.table_name||' ADD PARTITION '|| Vpartition || ' VALUES LESS THAN ( TO_DATE('''||VLess ||''',''YYYY-MM-DD HH24:MI:SS'',''NLS_CALENDAR=GREGORIAN'')) TABLESPACE '||c1.Vtablespace_dat ||' PCTFREE 5 PCTUSED 95 ';
                begin
               dbms_output.put_line(substr(VSQL,1,255));
               execute immediate vSQL;
               end;
--
-- =============================================================
--      Faz rebuild dos indices particionados.
--
           For c2 in ( SELECT INDEX_NAME FROM DBA_INDEXES
                     WHERE owner = c1.owner  and status = 'N/A'
                           and TABLE_NAME = c1.table_name  ) loop
          vSQL:='ALTER INDEX '||c1.owner||'.'||c2.index_name ||' REBUILD PARTITION '|| Vpartition ||' TABLESPACE '|| c1.Vtablespace_idx ||'';
                begin
                 dbms_output.put_line(substr(VSQL,1,255));
                 execute immediate vSQL;
               end;
            end loop;
       else
              dbms_output.put_line( '###############################################################');
              dbms_output.put_line( '#  TABELA '||c1.table_name||' JA POSSUI A PARTICAO.: '|| Vpartition);
              dbms_output.put_line( '###############################################################');
       end if;
      end loop;  --- Criando particoes diarias
      end loop;                         --- PRIMEIRO
        dbms_output.put_line( '#============================================================================#');
        dbms_output.put_line( '#================= CRIACAO DE PARTICAO DIARIA DO MIT EXECUTADO ==============#');
        dbms_output.put_line( '#============================================================================#');
end;
/
