 CREATE OR REPLACE PACKAGE "SNG"."KSNG_CREDIT_CONCESS_INTERFACE" is

  -- Purpose : Credit Concession Interface Process

  -- Rogério Iaquinto
  -- 18/09/2014
  -- Migração EBS R11 - R12
  -- Alteração devida ao objeto ar_location_values ter ficado obsoleto
  --------------------------------------------------------------------
  -- Author  : Jose Brugiolo F. Passos
  -- Created : 22/08/2006
  -- **************************************************
  -- Alteracao em 03/03/2008 - Jose Brugiolo
  -- Implementacao do QAT Lojas  Creditos Pendentes
  -- Alteradas PROCESSA_NC e PROCESSA_NUMERARIO
  -- criada rotina PROCESSA_OCC
  -- **************************************************
  -- Alteracao em 15/10/2008 - Jose Brugiolo
  -- Implementacao Fechamento Numerarios Ordem Pagamento
  -- Alterada PROCESSA_NUMERARIO
  -- **************************************************
  -- Alteracao em 05/03/2009 - Jose Brugiolo
  -- Otimização da rotina retorno de Nota de Credito
  -- Alterada PROCESSA_RETORNO_OFS
  -- **************************************************
  -- Alteracao em 29/06/2009 - Claudio J Oliveira
  -- Recomendações-TATA retirada de recurso distinct
  -- Alterada proc. VALIDA_FORNECEDOR
  -- **************************************************
  -- Alteracao em 05/11/2009 - Ricardo de Ramos Penha
  -- Objetivo : Adequação ao novo modelo das tabelas do MIT
  -- Alterada Cursor cur_bond_data
  -- **************************************************
  -- Alteracao: 12/04/2011 - Flavio Rossiter
  -- Objetivo : Retirado parametro que identifica o ambiente
  -- Alterada proc send_mail
  -- **************************************************
  -- Alteracao em 29/06/2012 - Ezequiel Cordeiro
  -- Objetivo : Adequac?o das variaveis p_cd_project e v_cd_project para vers?o 11G.
  -- De tsng_concession_reason_rev_typ.cd_project%type
  -- Para: VARCHAR2
  -- **************************************************
--||============================================================================||==
--||  Project: MIGRAÇÃO DO EBS R11 PARA EBS R12                                 ||==
--||  Author : Bressan                                                          ||==
--||  Created: 09/05/2014                                                       ||==
--||  Purpose: Modificar das chamadas de owners CAI para owners NXTISV          ||==
--||             Modificar os objetos @lnk.ofs por sinonimos em NXTISV          ||==
--||     Substituir strings CAIBR_ para seus objetos core default               ||==
--||============================================================================||==

  -- define constantes
  C_TIPO_PAGTO_DEPOSITO_CTA CONSTANT INTEGER := 1;
  C_TIPO_PAGTO_ORDEM_PGTO   CONSTANT INTEGER := 2;
  --
  C_NUMERARIO CONSTANT NUMBER := 1;
  C_NC        CONSTANT NUMBER := 2;
  C_OCC       CONSTANT NUMBER := 3;
  --
  C_CRLF      CONSTANT VARCHAR2(2)   := chr(13) || chr(10);
  --
  -- processa as concessoes OFS de um chamado
  -- parametros:
  --  p_id_attendance          Id do Atendimento
  --  p_sq_attendance_register Id do Chamado
  --  p_status_concessao       Status das concessoes a serem processadas:
  --                           'A' - Concessoes aprovadas nao processadas
  --                           'E' - Concessoes processadas com erro de Interface
  --                                 Efetuar reprocessamento
  procedure processa_concessoes(
    p_id_attendance          in tsng_attendance_register.id_attendance%type,
    p_sq_attendance_register in tsng_attendance_register.sq_attendance_register%type
  );

  -- processa interface para nota de credito
  procedure processa_nc(
    p_rec_adjustment in tsng_concession_credit%rowtype
  );

  -- processa o retorno da geracao da nota de credito do OFS
  procedure processa_retorno_ofs;

  -- processa interface para numerario
  procedure processa_numerario(
    p_rec_adjustment in tsng_concession_credit%rowtype
  );

  -- processa interface credito pendente para OCC
  -- diferentemente das rotinas de numerario e nota de credito
  -- recebe o chamado para verificar se trata-se de credito pendente ou nao
  procedure processa_occ(
    p_id_attendance          in tsng_concession_credit.id_attendance%type,
    p_sq_attendance_register in tsng_concession_credit.sq_attendance_register%type,
    p_id_concession_credit   in tsng_concession_credit.id_concession_credit%type
  );

  -- verifica se cliente possui cadastro como fornecedor, para um recebimento de numerario
  -- efetuado o cadastro caso nao exista
  procedure valida_fornecedor(
    p_cnpj                   in  varchar2,
    p_vendor_id              out number,
    p_vendor_site_id         out number
  );

  -- monta conta contabil
  procedure get_conta_contabil(
    p_cd_company                 in  tsng_concession_bond.cd_company%type,
    p_cd_company_unit            in  tsng_concession_bond.cd_company_unit%type,
    p_cd_concession_reason       in  tsng_concession_reason_rev_typ.cd_concession_reason%type,
    p_cd_concession_revenue_type in  tsng_concession_reason_rev_typ.cd_concession_revenue_type%type,
    p_concession_type            in  varchar2,
    p_cd_natural_account         out tsng_concession_reason_rev_typ.cd_natural_account%type,
    p_cd_costcenter              out tsng_concession_reason_rev_typ.cd_costcenter%type,
    p_cd_product                 out tsng_concession_reason_rev_typ.cd_product%type,
    p_cd_project                 out varchar2,
    p_id_natural_acount          out tsng_concession_ofs_interface.id_natural_account%type,
    p_cost_accounting            out varchar2
  ) ;

  -- obtem tag OFS
  function get_tag(
    p_lookup_code in varchar2,
    p_lookup_type in varchar2
  ) return varchar2;

  -- procedure de envio de email
  procedure send_mail(
    p_sender    in varchar2,
    p_recipient in varchar2,
    p_subject   in varchar2,
    p_message   in varchar2
  );

end ksng_credit_concess_interface;
/

CREATE OR REPLACE PACKAGE BODY "SNG"."KSNG_CREDIT_CONCESS_INTERFACE" is
--||============================================================================||==
--||  Project: MIGRAÇÃO DO EBS R11 PARA EBS R12                                 ||==
--||  Author : Bressan                                                          ||==
--||  Created: 09/05/2014                                                       ||==
--||  Purpose: Modificar das chamadas de owners CAI para owners NXTISV          ||==
--||             Modificar os objetos @lnk.ofs por sinonimos em NXTISV          ||==
--||     Substituir strings CAIBR_ para seus objetos core default               ||==
--||============================================================================||==
  -- VARIAVEIS GLOBAIS
  g_sender                 varchar2(500);
  g_recipient              varchar2(500);
  g_email_subject          varchar2(500);
  g_email_message          varchar2(3000);
  g_envia_email            boolean := false;
  g_org_id                 varchar2(100);
  g_user_id                number;
  --
  g_id_attendance             tsng_attendance_register.id_attendance%type;
  g_sq_attendance_register    tsng_attendance_register.sq_attendance_register%type;
  g_cd_attendance_register_id tsng_attendance_register.cd_attendance_register_id%type;
  --
  g_nome_cliente              tbgn_customer_main.nm_customer_main%type;

  -- CURSORES GLOBAIS
  -- Dados  dos titulos

  /*cursor cur_bond_data(
   pc_id_attendance          in number,
   pc_sq_attendance_register in number,
   pc_id_concession_credit   in number
  )is

   select a.cd_company,
          a.cd_company_unit,
          a.cd_customer_bond_kind,
          a.nr_customer_bond,
          a.nr_customer_item,
          b.va_customer_bond_original,
          b.dt_customer_bond_issue        as dt_emissao,
          b.dt_customer_bond_payment      as dt_pagto,
          b.dt_customer_bond_original_due as dt_vcto,
          b.nr_erp_customer_bond
   from  tsng_concession_bond a,
         tmit_customer_bond   b
   where id_attendance             = pc_id_attendance
   and   sq_attendance_register    = pc_sq_attendance_register
   and   id_concession_credit      = pc_id_concession_credit
   and   a.cd_company              = b.cd_company
   and   a.cd_company_unit         = b.cd_company_unit
   and   a.cd_customer_bond_kind   = b.cd_customer_bond_kind
   and   a.nr_customer_bond        = b.nr_customer_bond
   and   a.nr_customer_item        = b.nr_customer_item
   and   a.cd_serie_bond           = b.cd_serie_bond
   and   a.cd_supplier             = b.cd_supplier; */

           -- Alteração Implementada por Ricardo de Ramos Penha
           -- Data : 05/11/2009
           -- Objetivo : Adequação ao novo modelo das tabelas do MIT

   cursor cur_bond_data(
       pc_id_attendance          in number,
       pc_sq_attendance_register in number,
       pc_id_concession_credit   in number
    )is
  /*
   select a.cd_company,
          a.cd_company_unit,
          a.cd_customer_bond_kind,
          a.nr_customer_bond,
          a.nr_customer_item,
          b.va_bond_original,
          b.dt_bond_issue        as dt_emissao,
          b.dt_bond_payment      as dt_pagto,
          b.dt_bond_original_due as dt_vcto,
          b.nr_erp_bond
   from  tsng_concession_bond a,
         mit.tmit_bond   b,
         mit.tmit_general_fiscal_note c
   where a.id_attendance           = pc_id_attendance
   and   a.sq_attendance_register  = pc_sq_attendance_register
   and   a.id_concession_credit    = pc_id_concession_credit
   and   a.cd_company              = b.cd_company
   and   a.nr_customer_bond        = b.nr_bond
   and   a.nr_customer_item        = b.nr_item
   and   a.cd_serie_bond           = b.cd_serie_bond
   and   a.cd_supplier             = b.cd_supplier
   and   b.id_fiscal_note          = c.id_fiscal_note
   and   b.dt_fiscal_note_emission = c.dt_fiscal_note_emission
   and   a.cd_company_unit         = c.cd_company_unit
   and   a.cd_customer_bond_kind   = c.cd_customer_bond_kind;
   */

   -- Atualizado BRUGIOLO
   select a.cd_company
         ,a.cd_company_unit
         ,a.cd_customer_bond_kind
         ,a.nr_customer_bond
         ,a.nr_customer_item
         ,b.va_bond_original
         ,b.dt_bond_issue as dt_emissao
         ,b.dt_bond_payment as dt_pagto
         ,b.dt_bond_original_due as dt_vcto
         ,b.nr_erp_bond
     from tsng_concession_bond         a
         ,mit.tmit_bond                b
         ,mit.tmit_general_fiscal_note c
    where a.nr_erp_bond             = b.nr_erp_bond
      and b.id_fiscal_note          = c.id_fiscal_note
      and b.dt_fiscal_note_emission = c.dt_fiscal_note_emission
      and a.id_attendance           = pc_id_attendance
      and a.sq_attendance_register  = pc_sq_attendance_register
      and a.id_concession_credit    = pc_id_concession_credit;

  -- cursor que obtem os dados bancarios
  cursor c_dados_bancarios(
   pc_id_attendance          in number,
   pc_sq_attendance_register in number,
   pc_id_concession_credit   in number
  )is
    select a.id_attendance,
           a.sq_attendance_register,
           a.id_concession_credit,
           a.cd_concession_payment_detail,
           lpad(a.cd_bank,3,'0') cd_bank,
           a.cd_bank_agency,
           a.cd_bank_account,
           trim(a.cd_bank_account_digit) as cd_bank_account_digit,
           b.nm_bank
    from   tsng_concession_bank_detail a,
           tbgn_bank                   b
    where  a.cd_bank = b.cd_bank (+)
    and    id_attendance          = pc_id_attendance
    and    sq_attendance_register = pc_sq_attendance_register
    and    id_concession_credit   = pc_id_concession_credit;
    rec_dados_bancarios c_dados_bancarios%rowtype;

  procedure inicializa_variaveis is

   begin
      -- inicializa variaveis globais
      g_sender                    := null;
      g_recipient                 := null;
      g_email_subject             := null;
      g_email_message             := null;
      g_envia_email               := false;
      g_org_id                    := null;
      g_user_id                   := null;
      g_id_attendance             := null;
      g_sq_attendance_register    := null;
      g_cd_attendance_register_id := null;
      g_nome_cliente              := null;
      rec_dados_bancarios         := NULL;

  end inicializa_variaveis;

  procedure processa_concessoes(
    p_id_attendance          in tsng_attendance_register.id_attendance%type,
    p_sq_attendance_register in tsng_attendance_register.sq_attendance_register%type
  ) is

    -- Cursor que obtem os ajustes a serem
    -- processados para um determinado chamado
    cursor c_concession_credit is
      select id_attendance
            ,sq_attendance_register
            ,id_concession_credit
            ,cd_concession_payment_mode
            ,cd_concession_reason
            ,cd_concession_revenue_type
            ,va_concession_credit
            ,de_justificative
            ,tp_concession
            ,nm_created_by
            ,nm_responsible_error
            ,st_concession_credit
            ,dt_status_concession_credit
            ,dt_created
            ,dt_approval
            ,cd_concession_respons_area
            ,id_pending_credit
            ,va_pending_credit_original
            ,tp_pending_credit
        from tsng_concession_credit
       where id_attendance               = p_id_attendance
         and sq_attendance_register      = p_sq_attendance_register
         and st_concession_credit       in ('A','E')
         and cd_concession_payment_mode in (C_NUMERARIO,C_NC)
         for update nowait;
      rec_concession_credit tsng_concession_credit%rowtype;

    cursor c_numero_chamado is
      select cd_attendance_register_id
      from   tsng_attendance_register
      where id_attendance              = p_id_attendance
      and   sq_attendance_register     = p_sq_attendance_register;

    cursor cur_nome_cliente is
      select b.nm_customer_main
      from  tsng_attendance a,
            tbgn_customer_main b
      where a.id_customer_main = b.id_customer_main
        and a.id_attendance    = p_id_attendance;

    i integer;
    v_error_message  varchar2(4000);
    v_fase           varchar2(500);
    v_fecha_chamados integer := 1;
    v_erro           varchar2(4000);
  begin

     inicializa_variaveis;

     v_fase := 'Carrega variaveis globais 01';
     -- obtem emails para notificacoes
     begin
        select va_parameter
          into g_sender
          from tsng_parameter
         where cd_parameter = 'CREDIT_CONCESS_EMAIL_SENDER';
     exception
         when others then
            g_sender := 'nextel.atendimento@nextel.com.br';
     end;

     v_fase := 'Carrega variaveis globais 02';
     begin
        select va_parameter
          into g_recipient
          from tsng_parameter
         where cd_parameter = 'CREDIT_CONCESS_EMAIL_RECIPIENT';
      exception
         when others then
            g_recipient := 'nextel.atendimento@nextel.com.br';
     end;

     -- atribui valores as variaveis globais de atendimento e chamado
     g_id_attendance          := p_id_attendance;
     g_sq_attendance_register := p_sq_attendance_register;

     -- obtem o numero do chamado
     open c_numero_chamado;
       fetch c_numero_chamado into g_cd_attendance_register_id;
     close c_numero_chamado;

     v_fase := 'Carrega variaveis globais 03';
     -- carrega variaveis globais
     g_org_id   := get_tag('ORG_ID','NXT_BR_INTERFACES');
     g_user_id  := get_tag('USER_ID','NXT_BR_INTERFACES');

     -- obtem o nome do cliente
     open cur_nome_cliente;
       fetch cur_nome_cliente into g_nome_cliente;
     close cur_nome_cliente;

      v_fase := 'Obtem Ajustes';
      -- abre cursor com os ajustes
      open c_concession_credit;
      loop
          begin
            fetch c_concession_credit into rec_concession_credit;
            exit when c_concession_credit%notfound;

            g_envia_email := false;

            v_fase := 'Processa Interfaces';
            -- invoca processamento das interfaces
            if rec_concession_credit.cd_concession_payment_mode = C_NUMERARIO then
               processa_numerario(p_rec_adjustment => rec_concession_credit);
            elsif rec_concession_credit.cd_concession_payment_mode = C_NC then
               processa_nc(p_rec_adjustment => rec_concession_credit);
            end if;

            -- atualiza status concessao de credito
            update tsng_concession_credit
               set st_concession_credit        = 'P'
                  ,dt_status_concession_credit = sysdate
             where id_attendance          = rec_concession_credit.id_attendance
               and sq_attendance_register = rec_concession_credit.sq_attendance_register
               and id_concession_credit   = rec_concession_credit.id_concession_credit;

          exception
             when others then
                -- se ocorreu erro, nao chama rotina de fechamento do chamado
                v_fecha_chamados := 0;

                -- altera status da concessao para ERRO INTERFACE
                  update tsng_concession_credit
                     set st_concession_credit        = 'E'
                        ,dt_status_concession_credit = sysdate
                   where id_attendance          = rec_concession_credit.id_attendance
                     and sq_attendance_register = rec_concession_credit.sq_attendance_register
                     and id_concession_credit   = rec_concession_credit.id_concession_credit;

                -- envia e-mail para Suporte Sistemas Customer Care
                if g_envia_email = true then
                    send_mail(
                       p_sender    => g_sender
                      ,p_recipient => g_recipient
                      ,p_subject   => g_email_subject
                      ,p_message   => g_email_message
                    );
                end if;

                v_error_message :=  substr(g_email_message || ' - ' || sqlerrm,1,4000);

                -- grava log do erro na tabela
                ksng_credit_conces_maintain.add_concession_error_log(
                    p_id_attendance           => rec_concession_credit.id_attendance
                   ,p_sq_attendance_register  => rec_concession_credit.sq_attendance_register
                   ,p_id_concession_credit    => rec_concession_credit.id_concession_credit
                   ,p_tp_concession_error_log => 'E'
                   ,p_de_concession_error_log => v_error_message
                );

                -- verifica se erro eh ORA-02041 "client database did not begin a transaction"
                -- e em caso positivo força saida do loop pois esse erro estava ocasionando
                -- loop infinito
                i := 0;
                select instr(g_email_message,'ORA-02041') into i from dual;
                if i > 0 then
                    -- altera status das concessoes nao processadas para erro de interface
                    update tsng_concession_credit
                       set st_concession_credit        = 'E'
                          ,dt_status_concession_credit = sysdate
                     where id_attendance          = p_id_attendance
                       and sq_attendance_register = p_sq_attendance_register
                       and st_concession_credit   = 'A';

                    exit;
                end if;
          end;
          --commit work;
      end loop;
      close c_concession_credit;
     -- Raphael Cremasco 09/04/2012
     commit work;
     -- Alterac?o do bloco com commit work fora do cursor... devera ser verificado se n?o havera problemas no desempenho.

      begin
          if v_fecha_chamados = 1 then
            v_fase := 'Fecha chamados';
            -- invoca procedure que efetua o fechamento do chamado caso seja possivel
            ksng_credit_conces_maintain.close_attendance_register(
               p_id_attendance          => p_id_attendance
              ,p_sq_attendance_register => p_sq_attendance_register
            );
          end if;

      exception
         when others then
            null;
      end;
      commit work;

  exception
      when others then
          v_erro := substr(sqlerrm,200);
          -- Envia email do erro.
          rollback work;
          if c_concession_credit%isopen then
             close c_concession_credit;
          end if;
          v_error_message := 'Fase: ' || v_fase || ' #Erro: ' || v_erro;
          send_mail(
             p_sender    => g_sender
            ,p_recipient => g_recipient
            ,p_subject   => 'ERRO PROCESSAMENTO INTERFACE CONCESSAO CREDITO'
            ,p_message   => v_error_message
          );

  end processa_concessoes;

  procedure processa_nc(
    p_rec_adjustment in tsng_concession_credit%rowtype
  ) is
  --
  v_cost_accounting      varchar2(50);
  v_cd_natural_account   tsng_concession_reason_rev_typ.cd_natural_account%type;
  v_cd_costcenter        tsng_concession_reason_rev_typ.cd_costcenter%type;
  v_cd_product           tsng_concession_reason_rev_typ.cd_product%type;
  v_cd_project           Varchar2(10);
  v_id_natural_acount    tsng_concession_ofs_interface.id_natural_account%type;
  --
  v_cont                 number;
  --
  v_nc_comments     varchar2(500);
  -- variaveis para execucao de procedure no OFS
  v_ret_code        number :=0;
  v_return_status   varchar2(1);
  v_msg_count       number;
  v_msg_data        varchar2(2000);
  v_adj_rec         nxtisv.nxt_ar_create_adjust%rowtype;
  v_customer_trx_id nxtisv.ar_payment_schedules_all.customer_trx_id%type;
  --
  v_pending_credit  tsng_concession_reason.fg_credit_pending_check%type := 'N';
  v_attr4           varchar2(200) := null;
  v_attr5           varchar2(200) := null;

  rec_bond_data cur_bond_data%rowtype;
  begin

      -- obtem titulo referente a concessao
      open cur_bond_data(p_rec_adjustment.id_attendance,
                         p_rec_adjustment.sq_attendance_register,
                         p_rec_adjustment.id_concession_credit);

          fetch cur_bond_data into rec_bond_data;

          -- verifica se encontrou titulo associado a concessao
          if cur_bond_data%notfound then
             close cur_bond_data;
             g_envia_email := true;
             g_email_subject := 'Alerta Concessao - Titulo nao Encontrado';
             g_email_message := 'Não ha um titulo associado a essa concessao de credit. ID_CONCESSION_CREDIT#' || p_rec_adjustment.id_concession_credit || C_CRLF;
             raise_application_error(-20547,'Não ha um titulo associado a essa concessao de credit. ID_CONCESSION_CREDIT#' || p_rec_adjustment.id_concession_credit);
          end if;

      close cur_bond_data;

      -- gera string para campo comments do OFS
      v_nc_comments := 'Titulo:'   || rec_bond_data.nr_customer_bond ||
                       ' Esp:'     || rec_bond_data.cd_customer_bond_kind ||
                       ' Parcela:' || rec_bond_data.nr_customer_item ||
                       ' Emissao:' || to_char(rec_bond_data.dt_emissao,'dd/mm/yyyy') ||
                       ' Vencto:'  || to_char(rec_bond_data.dt_vcto,'dd/mm/yyyy');

      -- obtem dados da conta contabil
      get_conta_contabil(
          p_cd_company                 => rec_bond_data.cd_company,
          p_cd_company_unit            => rec_bond_data.cd_company_unit,
          p_cd_concession_reason       => p_rec_adjustment.cd_concession_reason,
          p_cd_concession_revenue_type => p_rec_adjustment.cd_concession_revenue_type,
          p_concession_type            => 'NC',
          p_cd_natural_account         => v_cd_natural_account,
          p_cd_costcenter              => v_cd_costcenter,
          p_cd_product                 => v_cd_product,
          p_cd_project                 => v_cd_project,
          p_id_natural_acount          => v_id_natural_acount,
          p_cost_accounting            => v_cost_accounting
      );

      -- grava campos tsng_concession_ofs_interface
      begin
          insert into tsng_concession_ofs_interface(
                 id_attendance,
                 sq_attendance_register,
                 id_concession_credit,
                 cd_natural_account,
                 id_natural_account,
                 id_ofs_credit_note,
                 cd_cost_accounting,
                 id_vendor_site,
                 id_invoice)
          values(
                 p_rec_adjustment.id_attendance,
                 p_rec_adjustment.sq_attendance_register,
                 p_rec_adjustment.id_concession_credit,
                 v_cd_natural_account,
                 v_id_natural_acount,
                 null,
                 v_cost_accounting,
                 null,
                 null);
       exception
          when dup_val_on_index then
            update tsng_concession_ofs_interface
               set cd_natural_account = v_cd_natural_account
                  ,id_natural_account = v_id_natural_acount
                  ,cd_cost_accounting = v_cost_accounting
             where id_attendance          = p_rec_adjustment.id_attendance
               and sq_attendance_register = p_rec_adjustment.sq_attendance_register
               and id_concession_credit   = p_rec_adjustment.id_concession_credit;
          when others then
             raise_application_error(-21540,sqlerrm);
       end;

      -- verifica se titulo esta no OFS
      select count(payment_schedule_id)
      into   v_cont
      from  nxtisv.nxt_ar_paym_sched_nobank_v
      where payment_schedule_id = rec_bond_data.nr_erp_bond;

      -- se titulo nao encontrado gera erro para concessao
      if v_cont = 0 then
         -- TODO verificar envio email
         g_email_subject := 'Alerta Concessao - Titulo nao Encontrado';
         g_email_message := 'Titulo referente ao ajuste nao foi encontrado no OFS: payment_schedule_id=' ||  to_char(rec_bond_data.nr_erp_bond) || C_CRLF ||
                            'Chamado  nro: ' || g_cd_attendance_register_id || ' - Cliente: ' ||  g_nome_cliente;
         g_envia_email := true;
         raise_application_error(-20101,'Titulo nao encontrado no OFS: ' ||  to_char(rec_bond_data.nr_erp_bond));
      end if;

      -- obtem o customer_trx_id referente ao titulo
      select customer_trx_id
        into v_customer_trx_id
        from nxtisv.ar_payment_schedules_all
       where payment_schedule_id = rec_bond_data.nr_erp_bond;

      -- verifica se trata-se de uma concessao com credito pendente
      begin
         select fg_credit_pending_check
           into v_pending_credit
           from tsng_concession_reason
          where cd_concession_reason = p_rec_adjustment.cd_concession_reason;
      exception
         when others then
             v_pending_credit := 'N';
      end;

      if v_pending_credit = 'Y' and p_rec_adjustment.id_pending_credit is not null then
         v_attr4 := to_char(p_rec_adjustment.id_pending_credit);
         v_adj_rec.attribute6          := 'N';
         v_adj_rec.attribute7          := p_rec_adjustment.cd_concession_payment_mode;
         if p_rec_adjustment.tp_pending_credit = 'C' then
            v_attr5 :=  'CASH';
         else
            v_attr5 :=  'SCHEDULE';
         end if;
      end if;

      -- gera ajuste do titulo no OFS
      begin

         v_adj_rec.type                := 'LINE'; -- type
         v_adj_rec.adjustment_type     := 'M';    -- adjustment_type
         v_adj_rec.status              := 'A';    -- status
         v_adj_rec.posting_control_id  := -3;     -- posting_control_id
         v_adj_rec.amount              := p_rec_adjustment.va_concession_credit * -1; -- Passa valor negativo da concessao para o OFS.
         v_adj_rec.acctd_amount        := rec_bond_data.va_bond_original;
         v_adj_rec.gl_date             := sysdate;
         v_adj_rec.created_from        := 'ADJ-API';
         v_adj_rec.process_flag        := 'N';
         v_adj_rec.postable            := 'Y';
         v_adj_rec.apply_date          := sysdate;
         v_adj_rec.code_combination_id := v_id_natural_acount; -- code_combination_id
         v_adj_rec.comments            := v_nc_comments;       -- p_rec_adjustment.de_justificative;
         v_adj_rec.attribute1          := p_rec_adjustment.sq_attendance_register;
         v_adj_rec.attribute2          := p_rec_adjustment.cd_concession_reason;
         v_adj_rec.attribute3          := p_rec_adjustment.id_concession_credit;

         -- Alteracao Credito pendente / JBrugiolo
         v_adj_rec.attribute4          := v_attr4;
         v_adj_rec.attribute5          := v_attr5;
         -----

         v_adj_rec.payment_schedule_id := rec_bond_data.nr_erp_bond;
         v_adj_rec.customer_trx_id     := v_customer_trx_id;
         v_adj_rec.receivables_trx_id  := get_tag('AR_ABAT_REC_TRX_ID','NXT_BR_INTERFACES');

         nxtisv.nxt_ar_concess_credit_inter.add_adjustment(
             p_adj_rec   => v_adj_rec
            ,p_ret_code  => v_ret_code
            ,p_message   => v_msg_data
         );

         if v_ret_code != 0 then
             --erro na geracao do registro
             g_email_subject := 'Alerta Concessao - Ajuste nao gerado no OFS';
             g_email_message := 'Houve um erro inesperado na geracao do ajuste de Nota de Credito no OFS. ' || C_CRLF ||
                                'Chamado  nro: ' || g_cd_attendance_register_id || ' - Cliente: ' ||  g_nome_cliente || C_CRLF ||
                                'Motivo .: ' || v_msg_data||' return status '||v_return_status ||' v_msg_count ' ||v_msg_count;
             g_envia_email := true;

             raise_application_error(-20521,'Titulo nao criado no OFS');
         end if;

         begin
             -- executa a prorrogacao do titulo no OFS
             nxtisv.nxt_ar_concess_credit_inter.prc_edit_ar_payment_sched_all(
                  p_due_date            => trunc(sysdate + get_tag('AR_DD_PRORROG_VANTIVE','NXT_BR_INTERFACES'))
                 ,p_last_updated_by     => g_user_id
                 ,p_payment_schedule_id => rec_bond_data.nr_erp_bond
             );
         exception
            when others then
               null;
         end;
      end;

  end processa_nc;

  procedure processa_retorno_ofs is

   cursor c_nc_ofs is
      select a.id_attendance
            ,a.sq_attendance_register
            ,a.id_concession_credit
            ,a.cd_concession_reason
        from tsng_concession_credit   a
       where a.cd_concession_payment_mode = 2
         and a.st_concession_credit       = 'P'
         for update nowait;
       rec_nc_ofs c_nc_ofs%rowtype;

    v_adj_id   number;
    v_ret_code number;
    v_message  varchar2(2000);
    v_status   char(1);
    v_nm_customer_main varchar2(200);

  begin

    -- inicializa variaveis globais
    inicializa_variaveis;

    -- obtem emails para possiveis notificacoes
    begin
      select va_parameter
        into g_sender
        from tsng_parameter
       where cd_parameter = 'CREDIT_CONCESS_EMAIL_SENDER';
    exception
       when others then
          g_sender := 'nextel.atendimento@nextel.com.br';
    end;

    begin
      select va_parameter
        into g_recipient
        from tsng_parameter
       where cd_parameter = 'CREDIT_CONCESS_EMAIL_RECIPIENT';
    exception
       when others then
          g_recipient := 'nextel.atendimento@nextel.com.br';
    end;

    open c_nc_ofs;
    loop
      fetch c_nc_ofs into rec_nc_ofs;
      exit when c_nc_ofs%notfound;

        nxtisv.nxt_ar_concess_credit_inter.get_adjustment_id(
           p_attribute1    => rec_nc_ofs.sq_attendance_register
          ,p_attribute2    => rec_nc_ofs.cd_concession_reason
          ,p_attribute3    => rec_nc_ofs.id_concession_credit
          ,p_adj_id        => v_adj_id
          ,p_ret_code      => v_ret_code
          ,p_message       => v_message);

        if v_ret_code < 0 then
            -- erro interface
            v_status := 'E';

            -- obtem nome cliente
            begin
              select b.nm_customer_main
                into v_nm_customer_main
               from  tsng_attendance a,
                     tbgn_customer_main b
               where a.id_customer_main = b.id_customer_main
                 and a.id_attendance    = rec_nc_ofs.id_attendance;
            exception
               when others then
               v_nm_customer_main := null;
            end;

            g_email_subject := 'Alerta Concessao - Ajuste nao gerado no OFS';
            g_email_message := 'Houve um erro inesperado na geracao do ajuste de Nota de Credito no OFS. ' || C_CRLF ||
                               'Chamado  nro: ' || rec_nc_ofs.sq_attendance_register || ' - Cliente: ' ||  v_nm_customer_main || C_CRLF ||
                               'Motivo .: ' || v_message ;

            -- envia email usuario
            send_mail(p_sender    => g_sender
                     ,p_recipient => g_recipient
                     ,p_subject   => g_email_subject
                     ,p_message   => g_email_message);

            -- grava log do erro na tabela
            ksng_credit_conces_maintain.add_concession_error_log(
                  p_id_attendance           => rec_nc_ofs.id_attendance
                 ,p_sq_attendance_register  => rec_nc_ofs.sq_attendance_register
                 ,p_id_concession_credit    => rec_nc_ofs.id_concession_credit
                 ,p_tp_concession_error_log => 'E'
                 ,p_de_concession_error_log => 'ERRO PROCESSAMENTO RETORNO OFS:' ||  g_email_message
            );
        elsif  v_ret_code = 1 then
            -- nao processada ofs
            v_status := 'P';
        elsif  v_ret_code = 0 then
            -- processada
            v_status := 'F';

            -- grava id_ajuste gerado no OFS
            update tsng_concession_ofs_interface
               set id_ofs_credit_note     = v_adj_id
             where id_attendance          = rec_nc_ofs.id_attendance
               and sq_attendance_register = rec_nc_ofs.sq_attendance_register
               and id_concession_credit   = rec_nc_ofs.id_concession_credit;

             -- Verifica se gravacao ocorreu com sucesso
             if sql%notfound then
                  g_email_subject := 'Alerta Concessao - ERRO PROCESSO DE RETORNO OFS';
                  g_email_message := 'Registro nao encontrado na tabela TSNG_CONCESSION_OFS_INTERFACE.' || C_CRLF ||
                                     'Chamado  nro: ' || rec_nc_ofs.sq_attendance_register;

                  -- envia email usuario
                  send_mail(p_sender    => g_sender
                           ,p_recipient => g_recipient
                           ,p_subject   => g_email_subject
                           ,p_message   => g_email_message);

                  -- grava log do erro na tabela
                  ksng_credit_conces_maintain.add_concession_error_log(
                        p_id_attendance           => rec_nc_ofs.id_attendance
                       ,p_sq_attendance_register  => rec_nc_ofs.sq_attendance_register
                       ,p_id_concession_credit    => rec_nc_ofs.id_concession_credit
                       ,p_tp_concession_error_log => 'E'
                       ,p_de_concession_error_log => 'ERRO PROCESSAMENTO RETORNO OFS:' ||  g_email_message
                  );

                  v_status := 'P';
             end if;
             ------

        end if;

        if v_status is not null then
          update tsng_concession_credit
          set   st_concession_credit        = v_status
               ,dt_status_concession_credit = sysdate
          where id_attendance          = rec_nc_ofs.id_attendance
          and   sq_attendance_register = rec_nc_ofs.sq_attendance_register
          and   id_concession_credit   = rec_nc_ofs.id_concession_credit;

          -- chama rotina que fecha o Chamado
          if v_status = 'F' then
             ksng_credit_conces_maintain.close_attendance_register(
                p_id_attendance          => rec_nc_ofs.id_attendance
               ,p_sq_attendance_register => rec_nc_ofs.sq_attendance_register
             );
          end if;
        end if;

    end loop;
    close c_nc_ofs;
    commit work;

  exception
       when others then
          rollback work;
          if c_nc_ofs%isopen then
             close c_nc_ofs;
          end if;
          raise_application_error(-20104,sqlerrm);
  end processa_retorno_ofs;

  procedure processa_numerario(
    p_rec_adjustment in tsng_concession_credit%rowtype
  ) is

  -- cursor para obter o CNPJ do cliente
  cursor c_cnpj is
    select cd_federal_tax
    from   tsng_attendance a,
           tbgn_customer_main b
    where a.id_customer_main = b.id_customer_main
    and   a.id_attendance    = p_rec_adjustment.id_attendance;
    v_cnpj           varchar2(15);

  --
  v_cost_accounting      varchar2(50);
  v_cd_natural_account   tsng_concession_reason_rev_typ.cd_natural_account%type;
  v_cd_costcenter        tsng_concession_reason_rev_typ.cd_costcenter%type;
  v_cd_product           tsng_concession_reason_rev_typ.cd_product%type;
  v_cd_project           varchar2(10);
  v_id_natural_acount    tsng_concession_ofs_interface.id_natural_account%type;
  --
  v_vendor_id       number;
  v_vendor_site_id  number;
  v_retorno         varchar2(1000);
  --
  v_invoice_id      number;
  v_inv_line_id     number;
  v_descricao       varchar2(255);
  v_tipo_pagto      varchar2(60);
  --
  v_set_of_books_id varchar2(100);
  v_bank_name       varchar2(500);
  v_bank_account    varchar2(500);
  --
  v_pending_credit  tsng_concession_reason.fg_credit_pending_check%type := 'N';
  v_attr5           varchar2(200) := null;
  v_attr6           varchar2(200) := null;
  v_id_customer_ofs tbgn_customer_fromto.cd_customer_control%type;
  w_org_id                   number := 0;

  begin

    -- obtem CNPJ
    open c_cnpj;
      fetch c_cnpj into v_cnpj;
    close c_cnpj;

    -- obtem dados bancarios
    rec_dados_bancarios := null;
    open c_dados_bancarios(
        p_rec_adjustment.id_attendance
       ,p_rec_adjustment.sq_attendance_register
       ,p_rec_adjustment.id_concession_credit);
      fetch c_dados_bancarios into rec_dados_bancarios;
    close c_dados_bancarios;

    -- checa se dados bancários estao cadastrados
    if rec_dados_bancarios.cd_concession_payment_detail = C_TIPO_PAGTO_DEPOSITO_CTA then
        if nvl(rec_dados_bancarios.cd_bank,'0') = '0' or
           nvl(rec_dados_bancarios.cd_bank_agency,0) = 0 or
           rec_dados_bancarios.cd_bank_account is null then

              g_envia_email := true;
              g_email_subject := 'Alerta Fornecedor !!';
              g_email_message := 'Erro ao cadastrar fornecedor: ' || g_nome_cliente|| ' no OFS. ' || C_CRLF ||
                                 'Chamado  nro: ' || g_cd_attendance_register_id || ' - Cliente: ' ||  g_nome_cliente || C_CRLF ||
                                 'Motivo : Dados bancarios nao cadastrados na concessao';
              raise_application_error(-20503,'Erro ao obter dados bancarios concessao ' || sqlerrm);

        end if;
    end if;

    -- obtem dados da conta contabil
    get_conta_contabil(
           p_cd_company                 => '120',
           p_cd_company_unit            => '0000',
           p_cd_concession_reason       => p_rec_adjustment.cd_concession_reason,
           p_cd_concession_revenue_type => p_rec_adjustment.cd_concession_revenue_type,
           p_concession_type            => 'NU',
           p_cd_natural_account         => v_cd_natural_account,
           p_cd_costcenter              => v_cd_costcenter,
           p_cd_product                 => v_cd_product,
           p_cd_project                 => v_cd_project,
           p_id_natural_acount          => v_id_natural_acount,
           p_cost_accounting            => v_cost_accounting);

    -- valida fornecedor
    valida_fornecedor(
        p_cnpj                   => v_cnpj
       ,p_vendor_id              => v_vendor_id
       ,p_vendor_site_id         => v_vendor_site_id);

    -- insere dados bancarios para o fornecedor
    v_set_of_books_id   := get_tag('SET_OF_BOOKS_ID','NXT_BR_INTERFACES');
    v_bank_name         := rec_dados_bancarios.cd_bank ||' BR AG '||
                           rec_dados_bancarios.cd_bank_agency ||' C/C '||
                           ltrim(rec_dados_bancarios.cd_bank_account,'0') || '-' ||
                           rec_dados_bancarios.cd_bank_account_digit;

    v_bank_account := rec_dados_bancarios.cd_bank_account || '-' ||
                      rec_dados_bancarios.cd_bank_account_digit;

    -- retira possívels zeros a esquerda e espacos a direita
    v_bank_name    :=  rtrim(v_bank_name);
    v_bank_account :=  ltrim(rtrim(v_bank_account),'0');

    if rec_dados_bancarios.cd_concession_payment_detail = C_TIPO_PAGTO_ORDEM_PGTO then

        w_org_id := g_org_id;

        -- chama procedure de associação de conta bancaria com cliente
        nxtisv.nxt_ar_concess_credit_inter.prc_link_vendor_bank_account(
           p_vendor_id       => v_vendor_id
          ,p_vendor_site_id  => v_vendor_site_id
          ,p_org_id          => w_org_id
          ,p_retorno         => v_retorno
        );

        if v_retorno is not null then
            g_email_subject := 'Alerta Concessao de Credito!';
            g_email_message := 'Ocorreu um erro na inclusao de Conta Bancaria do Fornecedor.' || C_CRLF ||
                               'Objeto: nxt_po_vendors_iface_k.link_accounts_uses_p' || C_CRLF ||
                               'Chamado  nro: ' || g_cd_attendance_register_id || ' - Cliente: ' ||  g_nome_cliente || C_CRLF ||
                               'Motivo : ' || v_retorno;
            g_envia_email := true;
            raise_application_error(-20085,v_retorno);
        end if;

    else
        nxtisv.nxt_ap_vendors_bank_accounts_p (
           p_org_id            => g_org_id
          ,p_set_of_books_id   => v_set_of_books_id
          ,p_vendor_id         => v_vendor_id
          ,p_vendor_site_id    => v_vendor_site_id
          ,p_bank_number       => rec_dados_bancarios.cd_bank
          ,p_bank_branch_num   => rec_dados_bancarios.cd_bank_agency
          ,p_bank_account_num  => v_bank_account
          ,p_bank_account_name => v_bank_account
          ,p_bank_name         => v_bank_name
          ,p_bank_branch_name  => rec_dados_bancarios.cd_bank_agency
          ,p_retorno           => v_retorno);

        if v_retorno is not null then
            g_email_subject := 'Alerta Concessao de Credito!';
            g_email_message := 'Ocorreu um erro na inclusao de Conta Bancaria do Fornecedor.' || C_CRLF ||
                               'Objeto: nxt_ap_vendors_bank_accounts_p' || C_CRLF ||
                               'Chamado  nro: ' || g_cd_attendance_register_id || ' - Cliente: ' ||  g_nome_cliente || C_CRLF ||
                               'Motivo : ' || v_retorno;
              g_envia_email := true;
              raise_application_error(-20086,v_retorno);
        end if;
    end if;

    -- obtem sequence necessaria para inclusao do titulo
    select nxtisv.ap_invoices_interface_s.nextval
      into v_invoice_id
      from dual;

    -- atualiza tabela TSNG_CONCESSION_OFS_INTERFACE
    begin
        insert into tsng_concession_ofs_interface(
               id_attendance,
               sq_attendance_register,
               id_concession_credit,
               cd_natural_account,
               id_natural_account,
               id_ofs_credit_note,
               cd_cost_accounting,
               id_vendor_site,
               id_invoice)
        values(
               p_rec_adjustment.id_attendance,
               p_rec_adjustment.sq_attendance_register,
               p_rec_adjustment.id_concession_credit,
               v_cd_natural_account,
               v_id_natural_acount,
               null,
               v_cost_accounting,
               v_vendor_site_id,
               v_invoice_id);
    exception
        when dup_val_on_index then
            begin
                update tsng_concession_ofs_interface
                   set cd_natural_account = v_cd_natural_account
                      ,id_natural_account = v_id_natural_acount
                      ,cd_cost_accounting = v_cost_accounting
                      ,id_vendor_site     = v_vendor_site_id
                      ,id_invoice         = v_invoice_id
                 where id_attendance          = p_rec_adjustment.id_attendance
                   and sq_attendance_register = p_rec_adjustment.sq_attendance_register
                   and id_concession_credit   = p_rec_adjustment.id_concession_credit;
            exception
                when others then
                    -- Monta mensagem email
                    g_email_subject := 'Alerta Concessao de Credito!';
                    g_email_message := 'Ocorreu um erro na alteracao do registro na tabela tsng_concession_ofs_interface.' || C_CRLF ||
                                       'Chamado  nro: ' || g_cd_attendance_register_id || ' - Cliente: ' ||  g_nome_cliente || C_CRLF ||
                                       'Motivo : ' || sqlerrm;
                    g_envia_email := true;
                    raise_application_error(-20088,sqlerrm);
            end;
        when others then
            -- Monta mensagem email
            g_email_subject := 'Alerta Concessao de Credito!';
            g_email_message := 'Ocorreu um erro na inclusao de registro na tabela tsng_concession_ofs_interface.' || C_CRLF ||
                               'Chamado  nro: ' || g_cd_attendance_register_id || ' - Cliente: ' ||  g_nome_cliente || C_CRLF ||
                               'Motivo : ' || sqlerrm;
            g_envia_email := true;
            raise_application_error(-20087,sqlerrm);
    end;

    -- monta descricao do ajuste
    v_descricao := 'Reembolso do Cliente, Chamado Nro :' || g_cd_attendance_register_id;

    -- identifica o tipo de pagamento
    if rec_dados_bancarios.cd_concession_payment_detail = C_TIPO_PAGTO_ORDEM_PGTO then
       v_tipo_pagto := 'ORDEM DE PAGAMENTO';
    else
       v_tipo_pagto := null;
    end if;

    -- Alteracao Credito pendente / JBrugiolo - 03/03/2008
    -- verifica se trata-se de uma concessao com credito pendente
    begin
       select fg_credit_pending_check
         into v_pending_credit
         from tsng_concession_reason
        where cd_concession_reason = p_rec_adjustment.cd_concession_reason;
    exception
       when others then
           v_pending_credit := 'N';
    end;

    if v_pending_credit = 'Y' and p_rec_adjustment.id_pending_credit is not null then
       v_attr5 := to_char(p_rec_adjustment.id_pending_credit);

       if p_rec_adjustment.tp_pending_credit = 'C' then
          v_attr6 :=  'CASH';
       else
          v_attr6 :=  'SCHEDULE';
       end if;

        begin
           select customer_id
             into v_id_customer_ofs
             from nxtisv.nxt_iex_credit_v
            where credit_id = p_rec_adjustment.id_pending_credit;
             --
             exception
           when others then
              v_id_customer_ofs := 0;
        end;

       -- Para Credito Pendente. Inclusao tabela NXT_AR_ADJ_CREDIT do OFS
       begin
       nxtisv.nxt_ar_concess_credit_inter.add_nxt_ar_adj_credit(
             p_customer_id        => v_id_customer_ofs
            ,p_credit_id          => p_rec_adjustment.id_pending_credit
            ,p_vlr_aplicado       => p_rec_adjustment.va_concession_credit
            ,p_credit_type        => v_attr6
            ,p_creation_date      => sysdate
            ,p_process_date       => null
            ,p_process_flag       => 'N'
            ,p_return_status      => null
            ,p_receivables_trx_id => null
            ,p_created_by         => null
            ,p_last_update_date   => null
            ,p_approved_by        => null
            ,p_msg_data           => null
            ,p_adjust_number      => null
            ,p_adjust_id          => null
            ,p_credit_code        => p_rec_adjustment.cd_concession_payment_mode
            ,p_concessao_id       => p_rec_adjustment.id_concession_credit);
       exception
           when others then
            -- Monta mensagem email
            g_email_subject := 'Alerta Concessao de Credito!';
            g_email_message := 'Ocorreu um erro na inclusao do Credito Pendente.' || C_CRLF ||
                               'Objeto: nxt_ar_concess_credit_inter.add_nxt_ar_adj_credit' || C_CRLF ||
                               'Chamado  nro: ' || g_cd_attendance_register_id || ' - Cliente: ' ||  g_nome_cliente || C_CRLF ||
                               'Motivo : ' || sqlerrm;
            g_envia_email := true;
            raise_application_error(-20198,sqlerrm);
       end;
    end if;

    -- Alteracao Credito pendente / JBrugiolo
    begin
        -- inclusao do titulo no contas a pagar
        nxtisv.nxt_ar_concess_credit_inter.prc_add_ap_invoices_interface(
              p_invoice_id               => v_invoice_id
            , p_invoice_num              => p_rec_adjustment.id_concession_credit
            , p_invoice_type_lookup_code => 'STANDARD'
            , p_invoice_date             => sysdate
            , p_vendor_id                => v_vendor_id
            , p_vendor_site_id           => v_vendor_site_id
            , p_invoice_amount           => p_rec_adjustment.va_concession_credit
            , p_invoice_currency_code    => 'BRL'
            , p_terms_id                 => get_tag('AP_TERMS_ID','NXT_BR_INTERFACES')
            , p_description              => v_descricao
            , p_last_update_date         => sysdate
            , p_last_updated_by          => -1
            , p_last_update_login        => -1
            , p_creation_date            => sysdate
            , p_created_by               => g_user_id
            , p_attribute_category       => get_tag('AP_INVOICES_ATTRIBUTE_CATEGORY','NXT_BR_INTERFACES')
            , p_attribute1               => '120'
            , p_attribute2               => get_tag('AP_INVOICES_ATTRIBUTE2','NXT_BR_INTERFACES')
            , p_attribute3               => get_tag('AP_INVOICES_ATTRIBUTE3','NXT_BR_INTERFACES')
            , p_attribute4               => get_tag('AP_INVOICES_ATTRIBUTE4','NXT_BR_INTERFACES')

            -- Alteracao Credito pendente / JBrugiolo
            , p_attribute5               => v_attr5
            , p_attribute6               => v_attr6
            ------

            , p_source                   => 'REEMBOLSO A CLIENTES'
            , p_goods_received_date      => sysdate
            , p_invoice_received_date    => sysdate
            , p_gl_date                  => sysdate
            , p_org_id                   => g_org_id
            , p_terms_date               => sysdate
            , p_pay_group_lookup_code    => v_tipo_pagto
        );
    exception
         when others then
            -- Monta mensagem email
            g_email_subject := 'Alerta Concessao de Credito!';
            g_email_message := 'Ocorreu um erro na inclusao de titulo no Contas a Pagar.' || C_CRLF ||
                               'Objecto: nxt_ar_concess_credit_inter.prc_add_ap_invoices_interface' || C_CRLF ||
                               'Chamado  nro: ' || g_cd_attendance_register_id || ' - Cliente: ' ||  g_nome_cliente || C_CRLF ||
                               'Motivo : ' || sqlerrm;
            g_envia_email := true;
            raise_application_error(-20087,sqlerrm);
    end;

    begin
      -- insere detalhes do titulo
      nxtisv.nxt_ar_concess_credit_inter.prc_add_ap_invoice_lines_inter(
            p_invoice_id                => v_invoice_id
          , p_invoice_line_id           => v_inv_line_id
          , p_line_number               => 1
          , p_line_type_lookup_code     => 'ITEM'
          , p_amount                    => p_rec_adjustment.va_concession_credit
          , p_accounting_date           => sysdate
          , p_description               => v_descricao
          , p_dist_code_combination_id  => v_id_natural_acount
          , p_last_updated_by           => 1
          , p_last_update_date          => sysdate
          , p_last_update_login         => -1
          , p_created_by                => g_user_id
          , p_creation_date             => sysdate
          , p_org_id                    => g_org_id
          , p_attribute3                => p_rec_adjustment.id_pending_credit
      );

    exception
       when others then
            -- Monta mensagem email
            g_email_subject := 'Alerta Concessao de Credito!';
            g_email_message := 'Ocorreu um erro na inclusao do detalhe do titulo no Contas a Pagar.' || C_CRLF ||
                               'Objecto: nxt_ar_concess_credit_inter.prc_add_ap_invoice_lines_inter' || C_CRLF ||
                               'Chamado  nro: ' || g_cd_attendance_register_id || ' - Cliente: ' ||  g_nome_cliente || C_CRLF ||
                               'Motivo : ' || sqlerrm;
            g_envia_email := true;
            raise_application_error(-20087,sqlerrm);
    end;

  exception
       when others then
          if v_invoice_id is not null and v_invoice_id != 0 then
              -- exclui registros das tabelas de interface
              nxtisv.nxt_ar_concess_credit_inter.del_ap_invoices_interface(v_invoice_id);
          end if;
          raise_application_error(-20103,sqlerrm);
  end processa_numerario;


  procedure processa_occ(
    p_id_attendance          in tsng_concession_credit.id_attendance%type,
    p_sq_attendance_register in tsng_concession_credit.sq_attendance_register%type,
    p_id_concession_credit   in tsng_concession_credit.id_concession_credit%type

  ) is

    cursor c_concession_credit is
      select id_attendance
            ,sq_attendance_register
            ,id_concession_credit
            ,cd_concession_payment_mode
            ,cd_concession_reason
            ,cd_concession_revenue_type
            ,va_concession_credit
            ,de_justificative
            ,tp_concession
            ,nm_created_by
            ,nm_responsible_error
            ,st_concession_credit
            ,dt_status_concession_credit
            ,dt_created
            ,dt_approval
            ,cd_concession_respons_area
            ,id_pending_credit
            ,va_pending_credit_original
            ,tp_pending_credit
        from tsng_concession_credit
       where id_attendance              = p_id_attendance
         and sq_attendance_register     = p_sq_attendance_register
         and id_concession_credit       = p_id_concession_credit
         and cd_concession_payment_mode = C_OCC;
      rec_concession_credit tsng_concession_credit%rowtype;

      v_pending_credit  tsng_concession_reason.fg_credit_pending_check%type;
      v_attr6           varchar2(200);
      v_id_customer_ofs varchar2(40);

      v_tipo_pagto      varchar2(50) := null;

  begin

    open c_concession_credit;
      fetch c_concession_credit into rec_concession_credit;
    close c_concession_credit;

    if rec_concession_credit.id_attendance is null then
       raise_application_error(-20001,'Concessao nao encontrada. #ID_ATTENDANCE=' ||  p_id_attendance || '#SQ_ATTENDANCE_REGISTER=' || p_sq_attendance_register || '#ID_CREDIT_CONCESSION=' || p_id_concession_credit || '#');
    end if;

    -- Alteracao Credito pendente / JBrugiolo - 03/03/2008
    -- verifica se trata-se de uma concessao com credito pendente
    begin
       select fg_credit_pending_check
         into v_pending_credit
         from tsng_concession_reason
        where cd_concession_reason = rec_concession_credit.cd_concession_reason;
    exception
       when others then
           v_pending_credit := 'N';
    end;

    if v_pending_credit = 'Y' then

           if rec_concession_credit.tp_pending_credit = 'C' then
              v_attr6 :=  'CASH';
           else
              v_attr6 :=  'SCHEDULE';
           end if;

        begin
           select customer_id
             into v_id_customer_ofs
             from nxtisv.nxt_iex_credit_v
            where credit_id = rec_concession_credit.id_pending_credit;
             --
             exception
           when others then
              v_id_customer_ofs := 0;
        end;

           -- identifica o tipo de pagamento
           begin
              select decode(cd_concession_payment_detail,C_TIPO_PAGTO_ORDEM_PGTO,'ORDEM DE PAGAMENTO',null)
                into v_tipo_pagto
                from tsng_concession_bank_detail
               where id_attendance              = p_id_attendance
                 and sq_attendance_register     = p_sq_attendance_register
                 and id_concession_credit       = p_id_concession_credit;
           exception
              when others then null;
           end;

            -- Para Credito Pendente. Inclusao tabela NXT_AR_ADJ_CREDIT do OFS
            nxtisv.nxt_ar_concess_credit_inter.add_nxt_ar_adj_credit(
                 p_customer_id        => v_id_customer_ofs
                ,p_credit_id          => rec_concession_credit.id_pending_credit
                ,p_vlr_aplicado       => rec_concession_credit.va_concession_credit
                ,p_credit_type        => v_attr6
                ,p_creation_date      => sysdate
                ,p_process_date       => null
                ,p_process_flag       => 'N'
                ,p_return_status      => null
                ,p_receivables_trx_id => null
                ,p_created_by         => null
                ,p_last_update_date   => null
                ,p_approved_by        => null
                ,p_msg_data           => null
                ,p_adjust_number      => null
                ,p_adjust_id          => null
                ,p_credit_code        => rec_concession_credit.cd_concession_payment_mode
                ,p_concessao_id       => rec_concession_credit.id_concession_credit
            );
       end if;

      exception
         when others then
            raise_application_error(-20002,sqlerrm);

  end processa_occ;

  procedure valida_fornecedor(
    p_cnpj                   in  varchar2,
    p_vendor_id              out number,
    p_vendor_site_id         out number
  ) is

    -- dados do cliente
    cursor c_customer is
      select --distinct
             address,
             nvl(district,'  ') as district,
             state,
             city,
             phone_number,
             fax_number,
             nvl(state_inscription,'ISENTO') as state_inscription,
             city_inscription,
             inscription_type,
             customer_name_phonetic,
             zip_code,
             inscription_number,
             inscription_branch,
             inscription_digit,
             customer_name
      from  nxtisv.nxt_ar_customers_v
      where site_number = p_cnpj;
    rec_customer c_customer%rowtype;
    --
    v_gov              number :=0;
    v_count            number :=0;
    v_vendor_id        number;
    v_vendor_site_id   number;
    v_vendor_name      varchar2(240);
    v_found            boolean := false;
    v_vendor_site_code varchar2(100);
    --
    v_cd_bank               varchar2(3);
    v_cd_bank_agency        tsng_concession_bank_detail.cd_bank_agency%type;
    v_cd_bank_account       tsng_concession_bank_detail.cd_bank_account%type;
    v_cd_bank_account_digit tsng_concession_bank_detail.cd_bank_account_digit%type;
    v_nm_bank               tbgn_bank.nm_bank%type;
    --
    v_set_of_books_id       number;

  begin

     -- obtem dados do cliente
     open c_customer;
       fetch c_customer into rec_customer;
     close c_customer;

     -- obtem nome do cliente
     v_vendor_name := rec_customer.customer_name;

     -- verifica se cliente eh Governo
     select count(a.id_customer_main)
     into v_gov
     from tbgn_customer_main a,
          tbgn_customer_classification b,
          tbgn_customer_type c
     where a.id_customer_main = b.id_customer_main
     and   b.cd_customer_type = c.cd_customer_type
     and   c.de_customer_type = 'GOVERNO'
     and   a.cd_federal_tax   = p_cnpj;

     -- verifica se cliente esta cadastrado como fornecedor
     begin
         select vendor_id,
                vendor_site_id
         into   v_vendor_id,
                v_vendor_site_id
         from  nxtisv.nxt_po_vendor_sites_all_v
         where inscription_type   = rec_customer.inscription_type
         and   inscription_number = rec_customer.inscription_number
         and   inscription_branch = rec_customer.inscription_branch
         and   inscription_digit  = rec_customer.inscription_digit
         and   ((address          = rec_customer.address and v_gov != 0) or v_gov = 0)
		 and rownum = 1;

         v_found := true;

     exception
         when no_data_found then
            -- fornecedor nao encontrado.
            -- efetua o cadastro do novo fornecedor
            --
            -- verifica se ha algum fornecedor cadastrado com o mesmo nome
            while true loop
              select count(vendor_name)
              into   v_count
              from nxtisv.nxt_po_vendor_sites_all_v
              where vendor_name  =  v_vendor_name;

              if v_count != 0 then
                 v_vendor_name := v_vendor_name || '.';
              else
                 exit;
              end if;
            end loop;

         when too_many_rows then
            raise_application_error(-20501,'Encontrado mais que um fornecedor ' || rec_customer.customer_name || ' no OFS');
         when others then
            -- Monta mensagem email
            g_envia_email := true;
            g_email_subject := 'Alerta Fornecedor !!';
            g_email_message := 'Erro ao localizar fornecedor: ' || rec_customer.customer_name || ' no OFS. ' || C_CRLF ||
                               'Chamado  nro: ' || g_cd_attendance_register_id || ' - Cliente: ' ||  g_nome_cliente || C_CRLF ||
                               'Motivo : ' || sqlerrm;
            raise_application_error(-20502,'Erro ao criar fornecedor ' || sqlerrm);
     end;

     if v_found = false then
        -- fornecedor nao encontrado
        if  rec_customer.inscription_type   = 1 then
            -- pessoa fisica
            v_vendor_site_code := rec_customer.inscription_number || rec_customer.inscription_digit;
        elsif rec_customer.inscription_type = 2 then
            --pessoa juridica
            v_vendor_site_code := rec_customer.inscription_branch || '-' || rec_customer.inscription_digit;
        end if;

        select count(*)
        into  v_count
        from  nxtisv.nxt_po_vendor_sites_all_v
        where inscription_type = rec_customer.inscription_type
        and   inscription_number = rec_customer.inscription_number
        and   ((inscription_branch = rec_customer.inscription_branch
                and rec_customer.inscription_type = 2)
                or rec_customer.inscription_type != 2)
        and inscription_digit  = rec_customer.inscription_digit;

        if v_count > 0 then
           v_vendor_site_code := v_vendor_site_code || ' - ' ||  lpad(trim(to_char(v_count+1)),2,'0');
        end if;

        -- obtem dados bancarios para o pagamento
        v_nm_bank               := rec_dados_bancarios.nm_bank;
        v_cd_bank               := rec_dados_bancarios.cd_bank;
        v_cd_bank_agency        := rec_dados_bancarios.cd_bank_agency;
        v_cd_bank_account       := rec_dados_bancarios.cd_bank_account;
        v_cd_bank_account_digit := rec_dados_bancarios.cd_bank_account_digit;

        -- verifica se cidade do cliente esta cadastrada no OFS

		/*
		-- Rogério Iaquinto
		-- 18/09/2014
		-- Migração EBS 11 - 12
		-- Alteração devida ao objeto ar_location_values ter ficado obsoleto
		select count(*)
        into v_count
        from nxtisv.ar_location_values
        where location_segment_qualifier ='CITY'
        and location_segment_value = rec_customer.city
        and parent_segment_id in (select --distinct
                                         location_segment_id
                                  from nxtisv.ar_location_values
                                  where location_segment_value = rec_customer.state
                                  and parent_segment_id = (select --distinct
                                                                  location_segment_id
                                                           from  nxtisv.ar_location_values
                                                           where parent_segment_id is null
                                                           and   location_segment_value='BR'));
														   */
		select count(1)
        into v_count
        from  nxtisv.HZ_GEOGRAPHIES
        where GEOGRAPHY_TYPE = 'CITY'
        and   GEOGRAPHY_NAME = rec_customer.city
        and   GEOGRAPHY_ELEMENT2_ID in (select --distinct
                                               GEOGRAPHY_Id
                                          from nxtisv.HZ_GEOGRAPHIES
                                         where GEOGRAPHY_CODE = rec_customer.state
                                           and GEOGRAPHY_ELEMENT1_ID = (select --distinct
                                                                               GEOGRAPHY_Id
                                                                         from  nxtisv.HZ_GEOGRAPHIES
                                                                         where GEOGRAPHY_Id   = GEOGRAPHY_ELEMENT1_ID
                                                                         and   GEOGRAPHY_CODE ='BR'));


        if v_count = 0 then
           -- Monta mensagem email
           g_email_subject := 'Alarme! Fornecedor nao inserido.';
           g_email_message := 'Ocorreu um erro na criacao do fornecedor.' || C_CRLF ||
                              'Fase: Verificacao da cidade do cliente. '  || C_CRLF ||
                              'Chamado  nro: ' || g_cd_attendance_register_id || '  - Cliente: ' ||  g_nome_cliente || C_CRLF ||
                              'Motivo: Cidade: ' || rec_customer.city || '/' || rec_customer.state || ' do fornecedor nao localizada no OFS.';
           g_envia_email := true;
           --
           raise_application_error(-20504,'Erro ao cadastrar fornecedor ' || rec_customer.customer_name  || '. Cidade ' ||  rec_customer.city  || ' nao encontrada');
        end if;

        v_set_of_books_id := get_tag('SET_OF_BOOKS_ID','NXT_BR_INTERFACES');

        begin

              -- insere novo fornecedor em tabela transitoria do OFS
              nxtisv.nxt_ar_concess_credit_inter.prc_add_nxt_po_vend_iface_all(
                p_organization_code    => 'NEXTEL BRASIL'
              , p_global_attribute9    => rec_customer.inscription_type
              , p_global_attribute10   => rec_customer.inscription_number
              , p_global_attribute11   => rec_customer.inscription_branch
              , p_global_attribute12   => rec_customer.inscription_digit
              , p_vendor_type          => 'VENDOR'
              , p_vendor_name          => v_vendor_name
              , p_vendor_name_alt      => trim(rec_customer.customer_name_phonetic)
              , p_vendor_site_code     => v_vendor_site_code
              , p_global_attribute13   => trim(rec_customer.state_inscription)
              , p_global_attribute14   => trim(rec_customer.city_inscription)
              , p_global_attribute15   => 'COMERCIAL'
              , p_address_line1        => substr(rec_customer.address,1,35)
              , p_address_line2        => substr(rec_customer.district,1,30)
              , p_address_line3        => 'BR'
              , p_address_line4        => trim(rec_customer.state)
              , p_city                 => substr(trim(rec_customer.city),1,25)
              , p_zip                  => trim(rec_customer.zip_code)
              , p_vendor_site_phone    => trim(rec_customer.phone_number)
              , p_bank_branch_name     => v_cd_bank_agency
              , p_fax                  => trim(rec_customer.fax_number)
              , p_bank_number          => v_cd_bank
              , p_bank_name            => substr(v_nm_bank,1,30)
              , p_bank_num             => v_cd_bank_agency
              , p_bank_account_name    => to_char(v_cd_bank) || ' BR AG ' || to_char(v_cd_bank_agency) || ' C/C ' || to_char(v_cd_bank_account) || '-' || to_char(v_cd_bank_account_digit) -- 341 BR AG 2000 C/C 564-1
              , p_segment1             => rec_customer.inscription_number
              , p_bank_account_num     => to_char(v_cd_bank_account) || '-' || to_char(v_cd_bank_account_digit)
              , p_contact_phone        => trim(rec_customer.phone_number)
              , p_org_id               => g_org_id
              , p_created_by           => g_user_id
              , p_set_of_books_id      => v_set_of_books_id
            );
        exception
           when others then

              -- gera erro do nao cadastramento
              -- Monta mensagem email
              g_email_subject := 'Alarme! Fornecedor nao inserido.';
              g_email_message := 'Erro ao inserir fornecedor no Oracle Financial.' || C_CRLF ||
                                 'Chamado  nro: ' || g_cd_attendance_register_id || ' - Cliente: ' ||  g_nome_cliente || C_CRLF ||
                                 'Motivo: ' || sqlerrm;
              g_envia_email := true;
              --
              raise_application_error(-20509,'Fornecedor ' || rec_customer.customer_name || ' nao cadastrado no OFS');
        end;

        -- verifica se inclusao foi efetuada com secesso
        begin
           select vendor_id,
                  vendor_site_id
           into   v_vendor_id,
                  v_vendor_site_id
           from  nxtisv.nxt_po_vendor_sites_all_v
           where inscription_type     = rec_customer.inscription_type
           and   inscription_number   = rec_customer.inscription_number
           and   inscription_branch   = rec_customer.inscription_branch
           and   inscription_digit    = rec_customer.inscription_digit;
        exception
            when others then
              -- exclui registro da tabela transitoria do OFS
              nxtisv.nxt_ar_concess_credit_inter.prc_del_nxt_po_vend_iface_all(
                   p_global_attribute10 => rec_customer.inscription_number
                 , p_global_attribute11 => rec_customer.inscription_branch
                 , p_global_attribute12 => rec_customer.inscription_digit
              );

              -- gera erro do nao cadastramento
              -- Monta mensagem email
              g_email_subject := 'Alarme! Fornecedor nao inserido.';
              g_email_message := 'Ocorreu um erro na criacao do fornecedor.' || C_CRLF ||
                                 'Fase: Selecao do codigo do novo fornecedor gerado. '  || C_CRLF ||
                                 'Chamado  nro: ' || g_cd_attendance_register_id || ' - Cliente: ' ||  g_nome_cliente || C_CRLF ||
                                 'Motivo: ' || sqlerrm;
              g_envia_email := true;
              --
              raise_application_error(-20505,'Fornecedor ' || rec_customer.customer_name || ' nao cadastrado no OFS');
        end;
     end if;

     -- retorna o codigo do fornecedor
     p_vendor_id      := v_vendor_id;
     p_vendor_site_id := v_vendor_site_id;

  end valida_fornecedor;

  procedure get_conta_contabil(
    p_cd_company                 in  tsng_concession_bond.cd_company%type,
    p_cd_company_unit            in  tsng_concession_bond.cd_company_unit%type,
    p_cd_concession_reason       in  tsng_concession_reason_rev_typ.cd_concession_reason%type,
    p_cd_concession_revenue_type in  tsng_concession_reason_rev_typ.cd_concession_revenue_type%type,
    p_concession_type            in  varchar2,
    p_cd_natural_account         out tsng_concession_reason_rev_typ.cd_natural_account%type,
    p_cd_costcenter              out tsng_concession_reason_rev_typ.cd_costcenter%type,
    p_cd_product                 out tsng_concession_reason_rev_typ.cd_product%type,
    p_cd_project                 out Varchar2,
    p_id_natural_acount          out tsng_concession_ofs_interface.id_natural_account%type,
    p_cost_accounting            out varchar2
  ) is

  v_cd_business_entity  varchar2(4);
  --
  v_code_combination_id number;
  v_fase                varchar2(500);
  r_saida               exception;

  begin

    v_fase := ' obtem business_entity cd_company_unit=' ||p_cd_company_unit;
    -- obtem business entity associada a company unit
    if p_concession_type = 'NU' then
      -- para numerario fixa o cd_business_entity
      v_cd_business_entity := '0001';
    else
      select lpad(cd_business_entity,4,'0')
        into v_cd_business_entity
        from tsng_company_business_entity
       where cd_company_unit = p_cd_company_unit;
    end if;

    -- obtem os dados para geracao da conta contabil
    v_fase := 'obtem os dados para geracao da conta contabil';
    select cd_natural_account,
           cd_costcenter,
           cd_product,
           cd_project
    into   p_cd_natural_account,
           p_cd_costcenter,
           p_cd_product,
           p_cd_project
    from  tsng_concession_reason_rev_typ
    where cd_concession_reason       = p_cd_concession_reason
    and   cd_concession_revenue_type = p_cd_concession_revenue_type;

    -- monta conta contabil
    p_cost_accounting := lpad(p_cd_company,3,'0') ||
                         lpad(v_cd_business_entity,4,'0') ||
                         lpad(p_cd_natural_account,4,'0') ||
                         lpad(p_cd_costcenter,3,'0')  ||
                         lpad(p_cd_product,2,'0') ||
                         lpad(p_cd_project,6,'0');

    -- verifica se conta esta cadastrada no OFS
    begin
          v_fase := 'Verifica se conta esta cadastrada no OFS';
          select code_combination_id -- id_natural_acount
          into v_code_combination_id
          from nxtisv.nxt_gl_code_combinations_v
          where legal_entity    = p_cd_company
          and   business_entity = v_cd_business_entity
          and   natural_account = p_cd_natural_account
          and   cost_center     = p_cd_costcenter
          and   product         = p_cd_product
          and   project         = lpad(p_cd_project,6,'0')
          and   enabled_flag    = 'Y'
          and   sysdate between nvl(start_date_active,sysdate - 1)
                            and nvl(end_date_active,sysdate)
          and   rownum < 2;

    exception
       when no_data_found then
          -- atualiza flag para enviar email do erro
          g_email_subject := 'Alerta Concessao - Conta Contabli nao encontrada';
          g_email_message := 'Ocorreu um erro ao processar uma Concessao de Credito.' || C_CRLF ||
                             'Chamado  nro: ' || g_cd_attendance_register_id || ' - Cliente: ' ||  g_nome_cliente || C_CRLF ||
                             'Motivo: Conta contabil '  || p_cost_accounting || ' nao encontrada no OFS';
          g_envia_email := true;
          raise r_saida;

       when others then
          -- atualiza flag para enviar email do erro
          g_email_subject := 'Alerta Concessao - Erro ao obter Conta Contabli no OFS';
          g_email_message := 'Ocorreu um erro ao processar uma Concessao de Credito.' || C_CRLF ||
                             'Chamado  nro: ' || g_cd_attendance_register_id || ' - Cliente: ' ||  g_nome_cliente || C_CRLF ||
                             'Motivo: Conta contabil '  || p_cost_accounting || ' => ' ||  substr(sqlerrm,1,100);
          g_envia_email := true;
          raise r_saida;
    end;

    p_id_natural_acount := v_code_combination_id;

  exception
     when r_saida then
        raise_application_error(-20703,'Erro ao gerar conta contabil.');
     when others then
        -- atualiza flag para enviar email do erro
        g_email_subject := 'Alerta Concessao - Erro ao gerar conta contabil';
        g_email_message := 'Ocorreu um erro ao processar uma Concessao de Credito.' || C_CRLF ||
                           'Chamado  nro: ' || g_cd_attendance_register_id || ' - Cliente: ' ||  g_nome_cliente || C_CRLF ||
                           'Fase: ' || v_fase || ' Erro: ' || substr(sqlerrm,1,200);
        g_envia_email := true;
        raise_application_error(-20702,'Erro ao gerar conta contabil ' || sqlerrm);

  end get_conta_contabil;

  function get_tag(
    p_lookup_code in varchar2,
    p_lookup_type in varchar2
  ) return varchar2 is

    v_tag varchar2(150);
  begin

      select tag
        into v_tag
        from nxtisv.fnd_lookup_values
       where language    = 'PTB'
         and lookup_type = p_lookup_type
         and lookup_code = p_lookup_code;

      return v_tag;

  exception
     when others then return null;
  end get_tag;

  procedure send_mail(
    p_sender    in varchar2,
    p_recipient in varchar2,
    p_subject   in varchar2,
    p_message   in varchar2
  ) is

    v_mailhost     varchar2(30);
    v_mail_conn    utl_smtp.connection;
    v_mesg         varchar2( 3000 );
    v_data_process varchar2(500);
    v_global_name  varchar2(100);


    type addresslist_tab is table of varchar2(200) index by binary_integer;
    lista addresslist_tab;
    lista_n binary_integer := 0;

    x int := 1;
    i int := 0;

    mailto varchar(2000);

    begin
return;
      -- GET SMTP HOST
      begin
        select va_parameter
        into   v_mailhost
        from   tsng_parameter
        where  cd_parameter = 'SMTP_HOST'
        and    rownum < 2;
      exception
         when others then
           raise_application_error(-20076,'SMTP Host nao encontrado');
      end;

      select to_char(sysdate,'dd/mm/yyyy hh24:mi:ss')
        into v_data_process
        from dual;

      -- obtem ambiente de execucao
      select substr(global_name,1,instr(global_name,'.')-1)
        into v_global_name
        from global_name;

      mailto := replace(p_recipient,' ','') || ';';

      while x <= length(mailto) loop
        if substr(mailto,x,1) = ';' or x = length(mailto) then
            lista_n := lista_n + 1;
            lista(lista_n) := replace(substr(mailto,i,x-i),';','');
            i := x;
        end if;
        x := x + 1;
      end loop;

      v_mail_conn := utl_smtp.open_connection(v_mailhost, 25);

      v_mesg:= 'Date: ' || to_char( sysdate, 'dd mon yyyy hh24:mi:ss' ) || C_CRLF ||
               'From: <' || p_sender || '>' || C_CRLF ||
               'Subject: ' || p_subject || C_CRLF ||
               'To: ' || p_recipient || C_CRLF ||
               ' ' || C_CRLF || 'Data Processamento: ' || v_data_process || C_CRLF ||
               'Ambiente: ' || v_global_name || C_CRLF || p_message;


      utl_smtp.helo(v_mail_conn, v_mailhost);
      utl_smtp.mail(v_mail_conn, p_sender);

      for z in 1 .. lista_n loop
        utl_smtp.rcpt(v_mail_conn,lista(z));
      end loop;

      -- utl_smtp.rcpt(v_mail_conn, p_recipient);
      utl_smtp.data(v_mail_conn, v_mesg);
      utl_smtp.quit(v_mail_conn);

   exception
     when others then
        null;
  end send_mail;


end ksng_credit_concess_interface;
/
