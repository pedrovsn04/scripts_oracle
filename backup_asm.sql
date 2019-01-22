Conexão ao banco de dados e catálogo:
## Conectar no banco de dados local (alvo) e no catálogo (que está no banco
## chamado catrman
rman target / rcvcat rman/rman@catrman

Criação do catálogo (caso ainda não exista):
RMAN> create catalog;

Registro do banco de dados no catálogo:
RMAN> register database;

Configuração dos backups:
## Fazer backup de controlfile e spfile automaticamente
configure controlfile autobackup on;

## Fazer backups para fita por default
CONFIGURE DEFAULT DEVICE TYPE TO 'sbt_tape';

## Fazer paralelismo quando utilizar fita
configure device type 'sbt_tape' parallelism 4;

## Fazer backups comprimidos e tipo “backupset”
configure device type 'SBT_TAPE' backup type to compressed backupset;

## Configurar formato para autobackup do controlfile
CONFIGURE CONTROLFILE AUTOBACKUP FORMAT FOR DEVICE TYPE 'SBT_TAPE' TO '%F';

## Configurar format snapshot controlfile
CONFIGURE SNAPSHOT CONTROLFILE NAME TO '/infra/oracle/app/product/11.2.0/dba/snapcf_<nome_banco>.f';

## Configurar retenção dos backups:
CONFIGURE RETENTION POLICY TO REDUNDANCY 4;
## ou
CONFIGURE RETENTION POLICY TO recovery window of 120 days;

## Configurar canais
CONFIGURE CHANNEL DEVICE TYPE 'SBT_TAPE' PARMS 'ENV=(NSR_SERVER=Netbackup)';

Habilitando o block change tracking, no caso de backups incrementais:
## No sqlplus:
alter database enable block change tracking using file '+DATA/oradata/<nome_banco>/rman_change_track.dbf';

============================================================================================================================================

Fazendo backups
Comandos de backups:

## Backup do banco de dados:
backup database;

## Backup do banco de dados e de archives:
backup database plus archivelog delete input;

## Apenas backup de archives:
backup archivelog all delete input;

## Backup tablespaces
Backup tablespace users, tbs01;

## Backup datafiles
Backup datafile 1,2;

## Backups incrementais:
BACKUP INCREMENTAL LEVEL 0 DATABASE filesperset=5;
BACKUP INCREMENTAL LEVEL 1 DATABASE filesperset=5;
BACKUP INCREMENTAL LEVEL 2 DATABASE filesperset=5;

## Backup sem tablespaces read only:
BACKUP INCREMENTAL LEVEL 0 DATABASE filesperset=2 skip readonly;

Expurgo de backups:
## expurgo
delete noprompt obsolete;
Backup e Recover 21 of 25

Backup com retenção diferenciada:
## Retenção de 1 ano
BACKUP DATABASE plus archivelog delete input include current controlfile tag 'Backup 1 ano' KEEP UNTIL TIME 'SYSDATE+365' logs;

Recover completo (perdeu tudo, inclusive controlfile e redo corrente):
## Conectar no banco de dados:
rman target /

## setar dbid:
RMAN> set dbid 963256318;

## startar banco de dados como “nomount”
RMAN> startup nomount;

## conectar no catálogo
RMAN> connect rcvcat rman/rman@test11g

## restaurar spfile:
RMAN> restore spfile;

## Parar banco e subi-lo novamente como “nomount”
RMAN> shutdown immediate;
RMAN> startup nomount;

## restaurar controlfile:
RMAN> restore controlfile;

## montar banco de dados:
RMAN> alter database mount;

## restaurar datafiles do banco de dados:
RMAN> restore database;

## fazer recover do banco de dados:
RMAN> recover database delete archivelog maxsize 5 G;

## abrir banco de dados:
alter database open resetlogs;

Recover tablespace:
## Conectar no banco de dados e catálogo:
rman target / rcvcat rman/rman@test11g/

## restaurar tablespace:
RMAN> restore tablespace users;

## fazer recover da tablespace:
RMAN> recover tablespace users;

Recover datafile:
## Conectar no banco de dados e catálogo:
Backup e Recover 22 of 25
rman target / rcvcat rman/rman@test11g/

## restaurar datafile:
RMAN> restore datafile 4;

## fazer recover do datafile:
RMAN> recover datafile 4;

Recover “until time”:
## formatar data:
export NLS_DATE_FORMAT=YYYY-MM-DD:HH24:MI:SS

## Conectar no banco de dados e catálogo:
rman target / rcvcat rman/rman@test11g/

## montar banco de dados:
RMAN> startup mount;
## fazer restore e recover do banco de dados:
RMAN> run {
set until time '2010-03-02:15:10:00';
restore database;
recover database delete archivelog maxsize 5 G;
alter database open resetlogs;
}

