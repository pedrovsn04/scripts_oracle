CREATE OR REPLACE PACKAGE "DBASCON"."CONTROLE_ANALISTA" is
  PROCEDURE carrega_usuarios;
  PROCEDURE verifica_validade;
  FUNCTION autoriza (vusername in varchar2,
                     vdatalimite in varchar2,
                     vrole in varchar2,
                     vjustificativa in varchar2,
                     vautorizacao varchar2) RETURN NUMBER;
end;
/

CREATE OR REPLACE PACKAGE BODY "DBASCON"."CONTROLE_ANALISTA" is
  PROCEDURE carrega_usuarios
  is
  begin
    delete AUD_USERS a
     where username not in(select username
                             from dba_users b
                            where b.username = a.username);
    --INICIO - Correções para a versao 11g - Vitor - 21/05/2012
    /*insert into AUD_USERS (USERNAME,PASSWORD)
                    select USERNAME,PASSWORD
                      from dba_users a
                     where substr(a.username,1,3) in ('AS_','TE_','SU_','OP_','IT_')
                       and a.username not in (select b.username
                                                from DBASCON.AUD_USERS b
                                               where b.username = a.username);*/
    insert into AUD_USERS (USERNAME,PASSWORD)
                    select NAME,PASSWORD
                      from sys.user$ a
                     where substr(a.name,1,3) in ('AS_','TE_','SU_','OP_','IT_')
                       and a.name not in (select b.username
                                            from DBASCON.AUD_USERS b
                                           where b.username = a.name);
    --FIM - Correções para a versao 11g - Vitor - 21/05/2012

    -- Este processo irá inserir todos os DBAS cadastrano no banco PNXTL04
    -- Dener Roberto - 19022013  - para não darem rode DBA ou RDBA_PRIVS para ANALISTAS
    insert into TMON_DBA_LOGIN (LOGIN_BANCO,NOME_DBA,CREATED)
	                    select a.LOGIN_BANCO,a.NOME_DBA,a.CREATED
	                      from dbascon.TMON_DBA_LOGIN_PNXTL04 a
	                     where a.LOGIN_BANCO not in (select distinct b.LOGIN_BANCO
	                                            from DBASCON.TMON_DBA_LOGIN b
	                                           where b.LOGIN_BANCO = a.LOGIN_BANCO);
     commit;

  end;

  PROCEDURE verifica_validade
  IS
    CURSOR CC IS
      SELECT USERNAME,ROLE,EXPIRY_DATE,ROWID RID
        FROM AUD_USERS_LOG
       WHERE EXPIRY_DATE <= SYSDATE
         and FLAG = '0';
    reg cc%rowtype;
    ccomando    varchar2(100);
    vcontinua number:=0;
  BEGIN
    carrega_usuarios;
    for reg in cc loop
       update AUD_USERS_LOG
          set FLAG   = '1'
        where rowid = reg.rid;
       select count(*)
         into vcontinua
         from AUD_USERS_LOG
        where username = reg.username
          and EXPIRY_DATE > reg.EXPIRY_DATE
          and ROLE = reg.ROLE
          and FLAG = '0';
       IF vcontinua = 0 THEN
          ccomando := 'revoke '||reg.ROLE||' from '||reg.username;
          execute immediate ccomando;
       END IF;
       commit;
    end loop;
  END;

 FUNCTION autoriza (vusername in varchar2,
                     vdatalimite in varchar2,
                     vrole in varchar2,
                     vjustificativa in varchar2,
                     vautorizacao varchar2)
  RETURN NUMBER
  is
    cdatalimite date;
    ccontinua   NUMBER:=1;
    creg        AUD_USERS_LOG%ROWTYPE;
    csid        number;
    ccomando    varchar2(100);
    vbanco      VARCHAR2(100);
    -- Dener
    Vaux        number:=0;
    VOK         number:=1;

  begin
    begin
      cdatalimite := to_date(vdatalimite,'DD/MM/YYYY HH24:MI');
      if cdatalimite <= sysdate then
         dbms_output.put_line('Data informada é menor que data atual.');
         ccontinua := 0;
      elsif cdatalimite >= sysdate+5 then
         dbms_output.put_line('Data informada é muito grande.');
         ccontinua := 0;
      end if;
    exception
      when others then
        dbms_output.put_line('O formato da String de data tem que ser DD/MM/YYYY HH24:MI.');
        ccontinua := 0;
    end;
    if ccontinua = 1 then
       begin
         creg.USERNAME         := upper(vusername);
         creg.EXPIRY_DATE      := cdatalimite;
         creg.ROLE             := upper(vrole);
         creg.MOTIVO_LIBERACAO := vjustificativa;
         creg.QUEM_AUTORIZOU   := vautorizacao;

      --   select distinct sid into csid from V$MYSTAT;
      select distinct sid , GLOBAL_NAME  into csid, VBANCO from V$MYSTAT, GLOBAL_NAME ;

         select USERNAME,
                MACHINE,
                TERMINAL,
                PROGRAM,
                OSUSER,
                MODULE
           into creg.USERNAME_EXEC,
                creg.MACHINE_EXEC,
                creg.TERMINAL_EXEC,
                creg.PROGRAM_EXEC,
                creg.OSUSER_EXEC,
                creg.MODULE_EXEC
           from v$session
          where sid = csid;
          insert into AUD_USERS_LOG
                     (USERNAME,
                      EXPIRY_DATE,
                      MOTIVO_LIBERACAO,
                      USERNAME_EXEC,
                      MACHINE_EXEC,
                      TERMINAL_EXEC,
                      PROGRAM_EXEC,
                      OSUSER_EXEC,
                      MODULE_EXEC,
                      QUEM_AUTORIZOU,
                      ROLE,FLAG,dt_execucao)
               values(creg.USERNAME,
                      creg.EXPIRY_DATE,
                      creg.MOTIVO_LIBERACAO,
                      creg.USERNAME_EXEC,
                      creg.MACHINE_EXEC,
                      creg.TERMINAL_EXEC,
                      creg.PROGRAM_EXEC,
                      creg.OSUSER_EXEC,
                      creg.MODULE_EXEC,
                      creg.QUEM_AUTORIZOU,
                      creg.ROLE,'0',sysdate);
          update AUD_USERS
             set LOCK_DATE   = cdatalimite
                ,EXPIRY_DATE = cdatalimite
           where username = vusername;

----
       VOK :=1;
       -- Libera acesso apenas nas roles de DBA apenas se estiver cadastrado no banco PXNTL04
       IF upper(vrole) IN ('DBA','RDBA_PRIVS') THEN
          -- verifica se esta cadastrado na tabela do banco PNXTL04
          vaux:=0;
          select count(*) into VAUX from TMON_DBA_LOGIN where LOGIN_BANCO = creg.USERNAME;

          if vaux > 0 then
             DBASCON.SEND_MAIL('" ACESSO DBA VIA MASHUPS "','dener.carvalho@nextel.com.br','" SOLICITADO ACESSO DE DBA ou RDBA_PRIVS."','BANCO =>'||VBANCO||'  USUARIO => '||vusername||' Role =>'||vrole );
           VOK :=1;
            else
            -- Não é DBA solcitando acesso as roles retorna erro para NOC
             VOK:=0;
             ccontinua := 0;
              DBASCON.SEND_MAIL('" ACESSO DBA VIA MASHUPS "','dener.carvalho@nextel.com.br','" WARNING .. ANALISTA SOLICITANDO ACESSO DE DBA ou RDBA_PRIVS."','BANCO =>'||VBANCO||'  USUARIO => '||vusername||' Role =>'||vrole||' ACESSO NAO AUTORIZADO !!!!'	);
              dbms_output.put_line(' #################################################');
              dbms_output.put_line('FAVOR AVISAR O ANALISTA '||creg.USERNAME||'  QUE SEU ACESSO NA ROLE NAO ESTA AUTORIZADA - Role '||upper(vrole) ||' NAO LIBERADA PARA ANALISTAS !!!!!');
              dbms_output.put_line(' OBS.: NAO precisa acionar o DBA ');
              dbms_output.put_line(' #################################################');
           end if;
         END if;
----
          if VOK =1 then
          ccomando := 'grant '||vrole||' to '||vusername;
          execute immediate ccomando;
          end if ;

      commit;
       end;
    end if;
    return(ccontinua);
  end;
end;
/
