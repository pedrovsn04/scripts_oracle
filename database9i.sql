col name format a15
col instance_name format a15
col host_name format a15
col log_mode format a17
col nls_characterset format a20
set feedback off
set serveroutput on

-- create table db_temp(host_name varchar2(64),
--		     instance_name varchar2(16),
--		     version varchar2(17),
--		     db_name varchar2(9),
--		     created date,
--		     log_mode varchar2(12),
--		     nls_characterset varchar2(40)
--		     sga number(20))
-- tablespace users;

declare

    hostnameName varchar2(64);
    instanceName varchar2(16);
    version varchar2(17);
    dbName varchar2(9);
    created date;
    thisDate date;
    logMode varchar2(12);
    nlsCharacterset varchar2(40);
    SGA number(20);
    sgaMaxSize number(20);
    SharedPool number(20,2):=0;
    largePool number(20,2):=0;
    javaPool number(20,2):=0;
    logBuffer number(20,2):=0;
    bufferCache number(20,2):=0;
    keepBufferCache number(20,2):=0;
    recycleBufferCache number(20,2):=0;
    twokBufferCache number(20,2):=0;
    fourkBufferCache number(20,2):=0;
    eightkBufferCache number(20,2):=0;
    sixteenkBufferCache number(20,2):=0;
    thirtytwokBufferCache number(20,2):=0;
    dataFiles number(20,2):=0;
    tempFiles number(20,2):=0;
    redoLogs number(20,2):=0;
    totalSize number(20,2):=0;
    blockSize number(20,2):=0;
    dbBlockBuffers number(20,2):=0;
    pgaSize number(20,2):=0;
    workArea varchar2(6);

    
begin

select sysdate into thisDate
from dual;

select 
		host_name, instance_name, version, name "DB_NAME", created, log_mode
into hostnameName, instanceName, version, dbName, created, logMode
from v$database, v$instance;

select 
		value into nlsCharacterset
from NLS_DATABASE_PARAMETERS
where upper(parameter) = 'NLS_CHARACTERSET';

select 
		UPPER(value) into workArea
from v$parameter
where upper(name) = 'WORKAREA_SIZE_POLICY';

if (workArea = 'AUTO') THEN
   select value/1024/1024 into pgaSize
   from v$parameter
   where upper(name) = 'PGA_AGGREGATE_TARGET';
END IF;

select 
	value/1024/1024 into sgaMaxSize
from v$parameter
where upper(name) = 'SGA_MAX_SIZE';

select 
	value into blockSize
from v$parameter
where upper(name) = 'DB_BLOCK_SIZE';

select 
	value into dbBlockBuffers
from v$parameter
where upper(name) = 'DB_BLOCK_BUFFERS';

IF ( dbBlockBuffers = 0 ) THEN

   select 
		value/1024/1024 into bufferCache
   from v$parameter
   where upper(name) = 'DB_CACHE_SIZE';

   select 
		sum(bytes)/1024/1024 into SGA 
   from v$sgastat;

ELSE

   bufferCache := (dbBlockBuffers * blockSize)/1024/1024;

   select sum(bytes)/1024/1024 into SGA 
   from v$sgastat;

   SGA := SGA + bufferCache;

END IF;


select value/1024/1024 into SharedPool 
from v$parameter
where upper(name) = 'SHARED_POOL_SIZE';

select value/1024/1024 into largePool
from v$parameter
where upper(name) = 'LARGE_POOL_SIZE';

select value/1024/1024 into keepBufferCache
from v$parameter
where upper(name) = 'DB_KEEP_CACHE_SIZE';

select value/1024/1024 into recycleBufferCache
from v$parameter
where upper(name) = 'DB_RECYCLE_CACHE_SIZE';

select value/1024/1024 into twokBufferCache
from v$parameter
where upper(name) = 'DB_2K_CACHE_SIZE';

select value/1024/1024 into fourkBufferCache
from v$parameter
where upper(name) = 'DB_4K_CACHE_SIZE';

select value/1024/1024 into eightkBufferCache
from v$parameter
where upper(name) = 'DB_8K_CACHE_SIZE';

select value/1024/1024 into sixteenkBufferCache
from v$parameter
where upper(name) = 'DB_16K_CACHE_SIZE';

select value/1024/1024 into thirtytwokBufferCache
from v$parameter
where upper(name) = 'DB_32K_CACHE_SIZE';

select nvl(sum(bytes)/1024,0) into javaPool
from v$sgastat
where upper(pool) = 'JAVA POOL';

select value/1024 into logBuffer
from v$parameter
where upper(name) = 'LOG_BUFFER';

select nvl(sum(bytes)/1024/1024/1024/1024,0) into dataFiles
from dba_data_files;

select nvl(sum(bytes)/1024/1024/1024/1024,0) into tempFiles
from dba_temp_files;

select nvl(sum(bytes)/1024/1024/1024/1024,0) into redoLogs
from v$log;

totalSize := dataFiles + tempFiles + redoLogs;



-- insert into db_temp values(hostnameName, instanceName, version, dbName, created, logMode, nlsCharacterset);
-- commit;


              dbms_output.put_line('---------------------------------------');
	      dbms_output.put_line('Servidor ; '                ||  hostnameName                               || chr(10) ||
                                   'Nome da Instância ; '       ||  instanceName                               || chr(10) ||
                                   'Versão ; '                  ||  version                                    || chr(10) ||
                                   'NomedoDB ; '                ||  dbName                                     || chr(10) ||
                                   'Data da Criação ; '         ||  to_char(created, 'dd-mon-yyyy-hh24:mi:ss') || chr(10) ||
                                   'Data do Levantamento ; '    ||  to_char(thisDate,'dd-mon-yyyy-hh24:mi:ss') || chr(10) ||
                                   'Tamanho do Bloco (Bytes) ; '||  blockSize				  || chr(10) ||
                                   'Log Mode ; '                ||  logMode);
              dbms_output.put_line('SGA Max Size (MB) ; '       ||  sgaMaxSize                                 || chr(10) || 
                                   'SGA (MB) ; '                ||  SGA                                        || chr(10) ||
                                   'Shared Pool (MB) ; '        ||  sharedPool                                 || chr(10) ||
                                   'Large Pool (MB) ; '         ||  largePool                                  || chr(10) ||
                                   'Java Pool (KB) ; '          ||  javaPool                                   || chr(10) ||
                                   'Log Buffer (KB) ; '         ||  logBuffer);
              dbms_output.put_line('Buffer Cache (MB) ; '       ||  bufferCache);
                            
                                   IF ( twokBufferCache > 0 ) THEN
                                      dbms_output.put_line('Buffer Cache 2K (MB) ; '    ||  twokBufferCache);
                                   END IF;

                                   IF ( fourkBufferCache > 0 ) THEN
                                      dbms_output.put_line('Buffer Cache 4K (MB) ; '    ||  fourkBufferCache);
                                   END IF;
                                
                                   IF ( eightkBufferCache > 0 ) THEN
                                      dbms_output.put_line('Buffer Cache 8K (MB) ; '    ||  eightkBufferCache);
                                   END IF;

                                   IF ( sixteenkBufferCache > 0 ) THEN
                                       dbms_output.put_line('Buffer Cache 16K (MB) ; '  ||  sixteenkBufferCache);
                                   END IF;


                                   IF ( thirtytwokBufferCache > 0 ) THEN
                                       dbms_output.put_line('Buffer Cache 32K (MB) ; '  ||  thirtytwokBufferCache);
                                   END IF;

                                   IF ( keepBufferCache > 0 ) THEN
                                       dbms_output.put_line('KeepCache (MB) ;  '        ||  keepBufferCache);
                                   END IF;


                                   IF ( recycleBufferCache > 0 ) THEN
                                       dbms_output.put_line('Recycle Cache (MB) ; '     ||  recycleBufferCache);
                                   END IF;


            IF (workArea = 'AUTO') THEN
              dbms_output.put_line('Workarea Size Policy ; '      ||  workArea                                 || chr(10) ||
                                   'Pga Aggregate Target (MB) ; ' ||  pgaSize);
            ELSE
              dbms_output.put_line('Workarea Size Policy ; '      ||  workArea);
            END IF;

              dbms_output.put_line('Tamanho Fisico (TB) ; '       ||  totalSize                                  || chr(10) ||
                                   '---------------------------------------');


END;
/

-- select host_name, instance_name, version, db_name, to_char(created,'dd-mon-yyyy hh24:mi:ss') "CREATED", log_mode, nls_characterset
-- from db_temp;

-- drop table db_temp
-- /
