12:15:24 H6NXTL08.IT_PPNETO>SET LINES 2000
12:15:26 H6NXTL08.IT_PPNETO>SET PAGES 2000
12:15:29 H6NXTL08.IT_PPNETO>SELECT DBMS_METADATA.GET_DDL('PACKAGE', 'KBIX_MULTA_CARENCIA','BIX') FROM DUAL;

DBMS_METADATA.GET_DDL('PACKAGE','KBIX_MULTA_CARENCIA','BIX')
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

  CREATE OR REPLACE PACKAGE "BIX"."KBIX_MULTA_CARENCIA" IS

  --
  -- MODIFICATION HISTORY
  -- Person                Date    Comments
  -- ----------------    --------  ------------------------------------------
  -- ROBERTSON BARQUEIRO   07.09.10  A rotina vai verificar o dia de desativação dos serviços
  --                               de multa Ii e BIS/BES e aplicar a multa conforme regra
  --                               definida pelo marketing.
  -- ROBERTSON BARQUEIRO     10.09.11     Inclusão da procedure pbix_check_prf.
  -- ROBERTSON BARQUEIRO     11.09.11     Inclusão da procedure pbix_check_takeover.
  -- ROBERTSON BARQUEIRO     17.09.11     Inclusão da função fbix_calcula_multa_entry_date.
  -- FABIO ROSA              30.11.11     Novas funcionalidades , projeto multas e travas.
  -- BRUNO COLLI BOATTO      07.12.11     Inclusão da procedure pbix_import_exceptions
  -- BRUNO COLLI BOATTO      02.07.13     Inclusão function create_xml_3g_EPS

FUNCTION fbix_calcula_multa_entry_date(p_filelog IN sys.utl_file.file_type,
                                         p_co_id   IN INTEGER,
                                         p_sncode_multa  IN INTEGER,
                                         p_sncode_base  IN INTEGER,
                                         p_entry_date IN DATE,
                                         p_valid_from_date in DATE) RETURN DATE;

  --

  --
    PROCEDURE pbix_check_prf (p_filelog           IN sys.utl_file.file_type,
                                 p_co_id             IN profile_service.co_id%TYPE,
                                 p_entry_date IN profile_service.entry_date%TYPE,
                              --  p_sncode IN profile_service.sncode%TYPE,
                                p_valid_from_date IN pr_serv_status_hist.valid_from_date%TYPE,
                               p_multa_entry_date OUT date
                                 );
  --

  PROCEDURE pbix_tickler_records(p_filelog           IN sys.utl_file.file_type,
                                 p_customer_id       IN tickler_records.customer_id%TYPE,
                                 p_co_id             IN tickler_records.co_id%TYPE,
                                 p_short_description IN tickler_records.short_description%TYPE,
                                 p_long_description  IN tickler_records.long_description%TYPE);

  PROCEDURE pbix_multa_carencia;

  PROCEDURE pbix_multa_carencia_combo (p_filelog         IN sys.utl_file.file_type,
                                       p_file            IN sys.utl_file.file_type,
                                       p_filexml         IN sys.utl_file.file_type);

  PROCEDURE pbix_relatorio_carencia(p_filelog         IN sys.utl_file.file_type,
                                    p_file            IN sys.utl_file.file_type,
                                    p_custcode        IN customer_all.custcode%TYPE,
                                    p_co_id           IN contract_all.co_id%TYPE,
                                    p_sncode          IN mpusntab.sncode%TYPE,
                                    p_billcycle       IN VARCHAR2,
                                    p_entry_date      IN profile_service.entry_date%TYPE,
                                    p_valid_from_date IN pr_serv_status_hist.valid_from_date%TYPE,
                                    p_perm_dias       IN NUMBER,
                                    p_carencia_dias   IN NUMBER,
                                    p_valor_multa     IN FLOAT,
                                    p_acao            IN VARCHAR2);

  FUNCTION create_xml_3g_EPS(   pFilelog               IN sys.utl_file.file_type,
                                pIdCustomer              IN NUMBER,
                                pIdContract            IN NUMBER,
                                pTmcodeFee             IN NUMBER,
                                pTmcodeFeeVersion      IN NUMBER,
                                pSpcodeFee             IN NUMBER,
                                pSncodeFee             IN NUMBER,
                                pFeeDate               IN DATE,
                                pFeeValue              IN FLOAT,
                                pFeeRemark             IN VARCHAR2,
                                pIdExternalApp         IN NUMBER,
                                pXML                   OUT CLOB) RETURN NUMBER;

  PROCEDURE pbix_cria_xml(p_filelog         IN sys.utl_file.file_type,
                          p_filexml         IN sys.utl_file.file_type,
                          p_custcode        IN customer_all.custcode%TYPE,
                          p_customer_id     IN customer_all.customer_id%TYPE,
                          p_rowid_customer  IN ROWID ,
                          p_co_id           IN contract_all.co_id%TYPE,
                          p_valor_multa     IN FLOAT,
                          p_remark          IN VARCHAR2,
                          p_glcode          IN VARCHAR2);

  PROCEDURE pbix_nrotel_ciclo_ativo(p_filelog          IN  sys.utl_file.file_type,
                                    p_co_id            IN  INTEGER,
                                    p_customer_id      IN  INTEGER,
                                    p_dn_num           OUT VARCHAR2,
                                    p_billcycle        OUT VARCHAR2);

  PROCEDURE pbix_nrotel_ciclo_desat(p_filelog          IN  sys.utl_file.file_type,
                                    p_co_id            IN  INTEGER,
                                    p_customer_id      IN  INTEGER,
                                    p_dn_num           OUT VARCHAR2,
                                    p_billcycle        OUT VARCHAR2);
  -- PROCEDURE pbix_ajusta_carga;

  FUNCTION fbix_troca_simcard(p_filelog          IN sys.utl_file.file_type,
                              p_co_id            IN INTEGER,
                              p_multa_entry_date IN DATE) RETURN NUMBER;

  FUNCTION fbix_motivo_desativa_7dias(p_filelog         IN sys.utl_file.file_type,
                                      p_co_id           IN INTEGER) RETURN NUMBER;



END kbix_multa_carencia;
CREATE OR REPLACE PACKAGE BODY "BIX"."KBIX_MULTA_CARENCIA" IS

  --
  -- MODIFICATION HISTORY
  -- Person                     Date       Comments
  -- ----------------         --------     ------------------------------------------
  -- ROBERTSON BARQUEIRO     07.09.10     A rotina vai verificar o dia de desativação dos serviços
  --                                      de multa Ii e BIS/BES e aplicar a multa conforme regra
  --                                      definida pelo marketing.
  -- ROBERTSON BARQUEIRO     23.09.10     Não aplicar multa para contratos de takeover.
  -- ROBERTSON BARQUEIRO     27.09.10     Não aplicar multa para contratos de desativação involuntária.
  -- ROBERTSON BARQUEIRO     07.10.10     Correção do relatorio de billchechout.
  -- ROBERTSON BARQUEIRO     08.10.10     Ajuste no tratamento do contrato de takeover ativo.
  -- ROBERTSON BARQUEIRO     11.10.10     Ajuste no relatório mensal.
  -- ROBERTSON BARQUEIRO     25.11.10     Tratamento de duplicidade.
  -- ROBERTSON BARQUEIRO     23.07.11     Inclusão da multa Titanium (sncode 863).
  -- ROBERTSON BARQUEIRO     08.09.11     Correção do cenário (A,S,A,S,D).
  -- ROBERTSON BARQUEIRO     10.09.11     Inclusão da procedure pbix_check_prf.
  -- ROBERTSON BARQUEIRO     11.09.11     Inclusão da procedure pbix_check_takeover.
  -- ROBERTSON BARQUEIRO     12.09.11     Inclusão da procedure pbix_calcula_multa.
  -- ROBERTSON BARQUEIRO     17.09.11     Inclusão da função fbix_calcula_multa_entry_date.
  -- ROBERTSON BARQUEIRO     19.10.11     Ajuste no "IF" do modelo dos aparelhos.
  -- FABIO ROSA              30.11.11     Novas funcionalidades , projeto multas e travas.
  -- BRUNO BOATTO            07.12.11     Inclusão da procedure pbix_import_exceptions
  -- FABIO ROSA              22.03.12     Novas funcionalidade ,matriz de plano.
  -- FABIO ROSA              21.06.12     Tratamento o cruzamento de plano.
  -- FABIO ROSA              20.09.12     Tratamento do serviço ironrock
  -- BRUNO COLLI BOATTO      24.06.13     Tratamento para funcionar também no 3g
  -- BRUNO COLLI BOATTO      01.07.13     Tratamento para a conta contábil do 3g


  v_sysdate      date    := trunc(SYSDATE)-1;
  v_total_co_id  integer := 0;
  v_ind_cruz    NUMBER;
  v_ind_multa   NUMBER;
  v_rowid_multa VARCHAR2(100);
  v_valid_from  DATE;
  v_customer_id NUMBER;
  v_transf      NUMBER;
 type ttt_co_id is record (
                            co_id        integer,
                            tmcode       integer,
                            seqno        integer,
                            tmcode_date  date,
                            co_activated date
                           );

 type tt_co_id is table of ttt_co_id index by binary_integer;
 v_vet_co_id tt_co_id;

 type ttt_tmcode_preco is record (
                                   tmcode   integer,
                                   accessfee number
                                  );

 type tt_tmcode_preco is table of ttt_tmcode_preco index by binary_integer;

 v_vet_tm_preco    tt_tmcode_preco;
 v_co_moddate      sysadm.contract_all.CO_MODDATE%type;
 v_co_activated    sysadm.contract_all.co_activated%type;

 TYPE ttt_cruza_plano IS RECORD (
                                  co_id_a      NUMBER,
                                  tmcode_old_a NUMBER,
                                  tmcode_new_a NUMBER,
                                  co_id_b      NUMBER,
                                  tmcode_old_b NUMBER,
                                  tmcode_new_b NUMBER
                                  );
 TYPE tt_cruza_plano IS TABLE OF ttt_cruza_plano INDEX BY BINARY_INTEGER;
 v_vet_cruza_plano  tt_cruza_plano;



 procedure sp_carga_contrato_plano is

 type tt_tmcode is table of number index by binary_integer;
 v_vet_tmcode tt_tmcode;
 v_count_co_id number;


 procedure sp_carga_tm_preco is
   begin
      for c_tmcode in (
                       select distinct tmcode, nvl(ACCESSFEE,0) accessfee
                       from sysadm.mpulktmb tm
                       where tm.sncode in (30,2069)
                       )
      loop
         v_vet_tm_preco(c_tmcode.tmcode).tmcode    := c_tmcode.tmcode;
         v_vet_tm_preco(c_tmcode.tmcode).accessfee := c_tmcode.accessfee;
      end loop;

   end;

 procedure sp_carga_tmcode is

   begin
      for c_tmcode in (
                       select tmcode_fidelity
                       from fne.tfne_fine fn
                       where tmcode_fidelity is not NULL
                        AND fn.type = 2
                       )
      loop
         v_vet_tmcode(c_tmcode.tmcode_fidelity):= c_tmcode.tmcode_fidelity;
      end loop;
   end;

begin

   sp_carga_tmcode;
   sp_carga_tm_preco;


 for c_ativo in (
                   select RH1.TMCODE, RH1.TMCODE_DATE,CO.CUSTOMER_ID,RH1.CO_ID , rh1.seqno ,co_activated
                    from  sysadm.contract_all co,
                          sysadm.rateplan_hist rh1
                    where trunc(rh1.tmcode_date) = v_sysdate
                     and seqno = (select max(seqno)
                                  from sysadm.rateplan_hist rh2
                                  where rh2.co_id = rh1.co_id
                                    AND trunc(rh2.tmcode_date) = v_sysdate
                                  )
                    and co.co_id = rh1.co_id

                )
  loop

     IF v_vet_cruza_plano.exists(c_ativo.co_id)= FALSE THEN

         v_vet_co_id(c_ativo.co_id).co_id        := c_ativo.co_id;
         v_vet_co_id(c_ativo.co_id).tmcode       := c_ativo.tmcode;
         v_vet_co_id(c_ativo.co_id).seqno        := c_ativo.seqno;
         v_vet_co_id(c_ativo.co_id).tmcode_date  := c_ativo.TMCODE_DATE;
         v_vet_co_id(c_ativo.co_id).co_activated := c_ativo.co_activated;
     END IF;

     v_count_co_id := 0;
     select count(*)
     into v_count_co_id
     from fne.tfne_customer_control_fine ccf
     where ccf.cd_contract = c_ativo.co_id
      and fg_fine_calculated ='I';


     IF  v_count_co_id = 0 and v_vet_tmcode.exists(c_ativo.tmcode) AND v_vet_cruza_plano.exists(c_ativo.co_id)= FALSE THEN

        v_total_co_id := v_total_co_id + 1;
        fneapl.FNE_PK_CONTROL.fne_carga_contrato_plano   (  p_co_id       => c_ativo.co_id,
                                                            p_customer_id => c_ativo.customer_id,
                                                            p_tmcode      => c_ativo.tmcode,
                                                            p_tmcode_new  => 0,
                                                            p_sncode      => c_ativo.seqno,
                                                            p_valid_from  => trunc(c_ativo.tmcode_date)
                                                          );

     END IF;

  end loop;


 exception
    when others then
      dbms_output.put_line(' - Erro na carga inicial de planos ');

end;


  PROCEDURE sp_carga_cruzamento_plano IS
    BEGIN
       FOR c_co_id IN (


              SELECT   item.cd_contract co_id_a,

               DECODE (
                        XMLType(tx_order_item_change_list).existsNode('//rateplanChange[' || 1 ||'][@other="true"]/@to'),0,
                        XMLType(tx_order_item_change_list).extract('//rateplanChange[' || 1 ||']/@to').getStringVal(),
                        XMLType(tx_order_item_change_list).extract('//rateplanChange[' || 2 ||']/@to').getStringVal()
                       ) tmcode_new_a,
               DECODE (
                        XMLType(tx_order_item_change_list).existsNode('//rateplanChange[' || 1 ||'][@other="true"]/@from'),0,
                        XMLType(tx_order_item_change_list).extract('//rateplanChange[' || 1 ||']/@from').getStringVal(),
                        XMLType(tx_order_item_change_list).extract('//rateplanChange[' || 2 ||']/@from').getStringVal()
                       ) tmcode_old_A,

              XMLType(tx_order_item_change_list).extract('//contract[' || 1 ||']/@otherIdNumber').getStringVal()co_id_b ,
              XMLType(tx_order_item_change_list).extract('//rateplanChange[@other="true"]/@to').getStringVal()tmcode_new_B,
              XMLType(tx_order_item_change_list).extract('//rateplanChange[@other="true"]/@from').getStringVal()tmcode_old_B
              FROM  crp.tcrp_chgrplan_ordr_item@LNK.CRP01 item,
                    crp.tcrp_chgrplan_ordr@LNK.CRP01 ord
              WHERE dt_chgrplan_ordr_creation >=v_sysdate
               AND dt_chgrplan_ordr_creation <= v_sysdate + 1
               AND tp_operation = 8
               AND cd_chgrplan_order_status = 2
               AND item.sq_chgrplan_ordr = ord.sq_chgrplan_ordr
               AND EXISTS (SELECT '1'
                          FROM sysadm.rateplan_hist rh1
                          WHERE co_id IN (item.cd_contract)
                           AND tmcode IN (  XMLType(tx_order_item_change_list).extract('//rateplanChange[' || 1 ||']/@to').getStringVal(),
                                            XMLType(tx_order_item_change_list).extract('//rateplanChange[' || 1 ||']/@from').getStringVal()
                                          )
                           AND trunc(tmcode_date) = trunc(v_sysdate)
                           and seqno = (select max(seqno)
                                        from sysadm.rateplan_hist rh2
                                        where rh2.co_id = rh1.co_id
                                          AND trunc(rh2.tmcode_date) = trunc(v_sysdate)
                                       )
                           )
               AND EXISTS (SELECT '1'
                          FROM sysadm.rateplan_hist rh1
                          WHERE co_id IN (XMLType(tx_order_item_change_list).extract('//contract[' || 1 ||']/@otherIdNumber').getStringVal())--
                         --  AND trunc(tmcode_date) = trunc(v_sysdate)
                           AND tmcode IN ( XMLType(tx_order_item_change_list).extract('//rateplanChange[' || 2 ||']/@to').getStringVal(),
                                           XMLType(tx_order_item_change_list).extract('//rateplanChange[' || 2 ||']/@from').getStringVal()
                                         )
                           and seqno = (select max(seqno) -1
                                        from sysadm.rateplan_hist rh2
                                        where rh2.co_id = rh1.co_id
                                          AND trunc(rh2.tmcode_date) = trunc(v_sysdate)
                                       )
                           )


                       )
       LOOP

         IF  c_co_id.tmcode_old_a IS NOT NULL AND c_co_id.tmcode_old_b IS NOT NULL
             AND c_co_id.tmcode_new_a IS NOT NULL
             AND c_co_id.tmcode_old_a IS NOT NULL THEN

          v_vet_cruza_plano(c_co_id.co_id_a).co_id_a := c_co_id.co_id_a;
          v_vet_cruza_plano(c_co_id.co_id_a).tmcode_old_a := c_co_id.tmcode_old_a;
          v_vet_cruza_plano(c_co_id.co_id_a).tmcode_new_a := c_co_id.tmcode_new_a;
          v_vet_cruza_plano(c_co_id.co_id_a).co_id_b := c_co_id.co_id_b;

          v_vet_cruza_plano(c_co_id.co_id_b).tmcode_old_a := c_co_id.tmcode_old_b;
          v_vet_cruza_plano(c_co_id.co_id_b).tmcode_new_a := c_co_id.tmcode_new_b;

          v_vet_cruza_plano(c_co_id.co_id_b).co_id_a := c_co_id.co_id_b;
          v_vet_cruza_plano(c_co_id.co_id_b).co_id_b := c_co_id.co_id_a;

         END IF;


       END LOOP;
       EXCEPTION
        WHEN OTHERS THEN
           NULL;
    END;


  FUNCTION fc_serv_except(p_filelog IN sys.utl_file.file_type,
                          p_co_id   IN INTEGER
                          ) RETURN NUMBER IS


    v_ind_ativo NUMBER := 0;

  BEGIN

    --verifica se o contrato tem o serviço iron_rock.
    SELECT COUNT(*)
      INTO v_ind_ativo
      FROM sysadm.pr_serv_status_hist pssh
     WHERE pssh.co_id = p_co_id
      and  sncode = (select sncode
                     from sysadm.mpusntab sn
                     where (sn.shdes = (SELECT fne.description
                                       from fne.tfne_fine fne
                                        where fne.fine_id = 0
                                       )
                            OR sn.shdes ='PDIR' )
                    )
      and pssh.valid_from_date = (select max(valid_from_date)
                                  from sysadm.pr_serv_status_hist pssh2
                                  where pssh2.co_id = pssh.co_id
                                    and pssh2.sncode = pssh.sncode
                                  )
      and pssh.status in ('A','S');

    RETURN v_ind_ativo;

  EXCEPTION
    WHEN OTHERS THEN
      ROLLBACK;
      sys.utl_file.put_line(p_filelog, 'ERRO AO OBTER MOTIVO DESATIVACAO 7 DIAS.' || SQLERRM || ' ****');
      sys.utl_file.put_line(p_filelog, 'ROLLBACK EFETUADO.');

  END ;

  PROCEDURE pbix_nrotel_ciclo_ativo(p_filelog          IN  sys.utl_file.file_type,
                                    p_co_id            IN  INTEGER,
                                    p_customer_id      IN  INTEGER,
                                    p_dn_num           OUT VARCHAR2,
                                    p_billcycle        OUT VARCHAR2) IS

    --variáveis
    v_billcycle             VARCHAR2(2);
    v_dn_num                VARCHAR2(100);

  BEGIN

  select decode( length(trim(dn.dn_num)),
                        12, (substr(dn.dn_num, 3, 2) || '-' || substr(dn.dn_num, 5, 4) || '-' || substr(dn.dn_num, 9, 4) ),
                        13, (substr(dn.dn_num, 3, 2) || '-' || substr(dn.dn_num, 5, 5) || '-' || substr(dn.dn_num, 10, 4) ),
                      nvl(dn.dn_num,0) ) as dn_n
      INTO v_dn_num
      FROM contr_services_cap cp,
           directory_number dn
     WHERE cp.dn_id = dn.dn_id
       AND cp.co_id = p_co_id
       AND cp.sncode in (1, 191, 2124)
       AND cp.cs_deactiv_date IS NULL
       AND Rownum < 2;

    --localizando o ciclo
    SELECT billcycle
      INTO v_billcycle
      FROM customer_bch
     WHERE customer_id = p_customer_id;

   --retorno
   p_dn_num := v_dn_num;
   p_billcycle := v_billcycle;

  EXCEPTION
    WHEN OTHERS THEN
      ROLLBACK;
      sys.utl_file.put_line(p_filelog, 'ERRO AO OBTER NRO TELEFONE E CICLO.' || SQLERRM || ' ****');
      sys.utl_file.put_line(p_filelog, ' CO_ID    => ' || p_co_id);
      sys.utl_file.put_line(p_filelog, ' CUSTOMER => ' || p_customer_id);
      sys.utl_file.put_line(p_filelog, 'ROLLBACK EFETUADO.');

  END pbix_nrotel_ciclo_ativo;

  --
  PROCEDURE pbix_nrotel_ciclo_desat(p_filelog          IN  sys.utl_file.file_type,
                                    p_co_id            IN  INTEGER,
                                    p_customer_id      IN  INTEGER,
                                    p_dn_num           OUT VARCHAR2,
                                    p_billcycle        OUT VARCHAR2) IS

    --variáveis
    v_billcycle             VARCHAR2(2);
    v_dn_num                VARCHAR2(100);

  BEGIN
    select decode( length(trim(dn.dn_num)),
                    12, (substr(dn.dn_num, 3, 2) || '-' || substr(dn.dn_num, 5, 4) || '-' || substr(dn.dn_num, 9, 4) ),
                    13, (substr(dn.dn_num, 3, 2) || '-' || substr(dn.dn_num, 5, 5) || '-' || substr(dn.dn_num, 10, 4) ),
                    nvl(dn.dn_num, 0) ) as dn_n
      INTO v_dn_num
      FROM contr_services_cap cp,
           directory_number dn
     WHERE cp.dn_id = dn.dn_id
       AND cp.co_id = p_co_id
       AND cp.sncode IN (SELECT sncode
                           FROM pr_serv_status_hist pr
                          WHERE pr.co_id = cp.co_id
                            AND pr.sncode IN (1, 191, 2124)
                            AND pr.valid_from_date IN (SELECT MAX(pr1.valid_from_date)
                                                         FROM pr_serv_status_hist pr1
                                                        WHERE pr1.co_id = pr.co_id
                                                          AND pr1.sncode IN (1, 191, 2124)))
       AND cp.cs_activ_date IN (SELECT MAX(cs_activ_date)
                                  FROM contr_services_cap
                                 WHERE co_id = cp.co_id
                                   AND sncode = cp.sncode)
       AND cp.cs_deactiv_date IN (SELECT MAX(cs_deactiv_date)
                                    FROM contr_services_cap
                                   WHERE co_id = cp.co_id
                                     AND sncode = cp.sncode);

    --localizando o ciclo
    SELECT billcycle
      INTO v_billcycle
      FROM customer_bch
     WHERE customer_id = p_customer_id;

   --retorno
   p_dn_num := v_dn_num;
   p_billcycle := v_billcycle;

  EXCEPTION
    WHEN OTHERS THEN
      ROLLBACK;
      sys.utl_file.put_line(p_filelog, 'ERRO AO OBTER NRO TELEFONE E CICLO.' || SQLERRM || ' ****');
      sys.utl_file.put_line(p_filelog, 'ROLLBACK EFETUADO.');

  END pbix_nrotel_ciclo_desat;
  --

  --
  FUNCTION fbix_troca_simcard(p_filelog          IN sys.utl_file.file_type,
                              p_co_id            IN INTEGER,
                              p_multa_entry_date IN DATE) RETURN NUMBER IS


    v_7dias_ind NUMBER := 0;

  BEGIN

    SELECT COUNT(*)
      INTO v_7dias_ind
      FROM contr_devices cd
     WHERE cd.co_id = p_co_id
       AND cd.cd_activ_date = (SELECT MAX(cd1.cd_activ_date)
                                 FROM contr_devices cd1
                                WHERE cd1.co_id = cd.co_id)
       AND cd.cd_sm_num <> (SELECT cd_sm_num
                              FROM contr_devices cd2
                             WHERE cd2.co_id = cd.co_id
                               AND trunc(cd2.cd_activ_date) <= trunc(p_multa_entry_date)
                               AND cd2.cd_activ_date = (SELECT MAX(cd3.cd_activ_date)
                                                          FROM contr_devices cd3
                                                         WHERE cd3.co_id = cd2.co_id
                                                           AND trunc(cd3.cd_activ_date) <= trunc(p_multa_entry_date)));

    RETURN v_7dias_ind;

  EXCEPTION
    WHEN OTHERS THEN
      ROLLBACK;
      sys.utl_file.put_line(p_filelog, 'ERRO AO OBTER TROCA DO SIMCARD.' || SQLERRM || ' ****');
      sys.utl_file.put_line(p_filelog, 'ROLLBACK EFETUADO.');

  END fbix_troca_simcard;
  --

  --
  FUNCTION fbix_motivo_desativa_7dias(p_filelog         IN sys.utl_file.file_type,
                                      p_co_id           IN INTEGER) RETURN NUMBER IS

    --variáveis
    v_7dias_ind NUMBER := 0;

  BEGIN

    --verifica o motivo de desativação.
    SELECT COUNT(*)
      INTO v_7dias_ind
      FROM contract_history
     WHERE ch_reason IN  ( SELECT rf.cd_reason_fine
                            FROM FNE.tfne_reason_fine rf
                            WHERE  rf.TYPE = 1
                          ) -- RV-Devoluçao entrega/Recusa entrega
       AND ch_status = 'd'
       AND co_id = p_co_id;

    RETURN v_7dias_ind;

  EXCEPTION
    WHEN OTHERS THEN
      ROLLBACK;
      sys.utl_file.put_line(p_filelog, 'ERRO AO OBTER MOTIVO DESATIVACAO 7 DIAS.' || SQLERRM || ' ****');
      sys.utl_file.put_line(p_filelog, 'ROLLBACK EFETUADO.');

  END fbix_motivo_desativa_7dias;
  --


  FUNCTION fbix_calcula_multa_entry_date(p_filelog         IN sys.utl_file.file_type,
                                         p_co_id           IN INTEGER,
                                         p_sncode_multa    IN INTEGER,
                                         p_sncode_base     IN INTEGER,
                                         p_entry_date      IN DATE,
                                         p_valid_from_date IN DATE) RETURN DATE IS

    --variáveis
    v_multa_entry_date DATE := NULL;
    v_sncode_base_des  NUMBER := 0;
    v_max_des          DATE := NULL;
    v_min_ativ         DATE := NULL;

  BEGIN

    --Verificando se teve alguma desativação anterior

    SELECT MAX(pr.valid_from_date)
      INTO v_max_des
      FROM pr_serv_status_hist pr
     WHERE co_id = p_co_id
       AND sncode IN (p_sncode_multa)
       AND pr.valid_from_date IN (SELECT MAX(pr1.valid_from_date)
                                    FROM pr_serv_status_hist pr1
                                   WHERE pr1.co_id = pr.co_id
                                     AND pr.sncode = pr1.sncode
                                     AND trunc(pr.valid_from_date) = trunc(pr1.valid_from_date))
       AND status = 'D'
       AND pr.valid_from_date < p_valid_from_date;

    IF v_max_des IS NULL
    THEN

      v_multa_entry_date := p_entry_date;

    ELSE

      SELECT MIN(pr.valid_from_date)
        INTO v_min_ativ
        FROM pr_serv_status_hist pr
       WHERE co_id = p_co_id
         AND sncode IN (p_sncode_multa)
         AND pr.valid_from_date IN (SELECT MAX(pr1.valid_from_date)
                                      FROM pr_serv_status_hist pr1
                                     WHERE pr1.co_id = pr.co_id
                                       AND pr.sncode = pr1.sncode
                                       AND trunc(pr.valid_from_date) = trunc(pr1.valid_from_date))
         AND status = 'A'
         AND pr.valid_from_date > v_max_des;

      -- verifica se o serviço base foi desativado no período que não tinha o serviço de multa
      SELECT nvl(COUNT(*), 0)
        INTO v_sncode_base_des
        FROM pr_serv_status_hist pr
       WHERE pr.co_id = p_co_id
         AND pr.sncode = p_sncode_base
         AND pr.valid_from_date IN (SELECT MAX(pr1.valid_from_date)
                                      FROM pr_serv_status_hist pr1
                                     WHERE pr1.co_id = pr.co_id
                                       AND pr.sncode = pr1.sncode
                                       AND trunc(pr.valid_from_date) = trunc(pr1.valid_from_date))
         AND pr.status = 'D'
         AND pr.valid_from_date >= v_max_des
         AND pr.valid_from_date < v_min_ativ;

      IF v_sncode_base_des <> 0
      THEN

        v_multa_entry_date := v_min_ativ;

      ELSE

        v_multa_entry_date := p_entry_date;

      END IF;

    END IF;

    RETURN v_multa_entry_date;

  EXCEPTION
    WHEN OTHERS THEN
      ROLLBACK;
      sys.utl_file.put_line(p_filelog, 'ERRO AO CALCULAR DIA DE ATIVACAO DA MULTA.' || SQLERRM || ' ****');
      sys.utl_file.put_line(p_filelog, 'ROLLBACK EFETUADO.');
  END;
  --

  FUNCTION fbix_obter_multa_entry_date(p_filelog         IN sys.utl_file.file_type,
                                       p_co_id           IN INTEGER,
                                       p_tmcode          IN INTEGER) RETURN DATE IS

    --variáveis
    v_multa_entry_date DATE := NULL;
    v_exitloop         BOOLEAN := False;

  BEGIN

    --variavel de controle do loop
    v_exitloop := False;

    -- abrir curso - plano pode ter varios no mesmo dia considerar somente o ultimo de cada dia
    FOR r2 IN ((SELECT TRUNC(a.tmcode_date) tmcode_date, a.tmcode
                  FROM RATEPLAN_HIST a
                 WHERE co_id = p_co_id
                 GROUP BY trunc(a.tmcode_date), a.tmcode)
                 ORDER BY tmcode_date desc)
    LOOP

      IF p_tmcode = r2.tmcode THEN
         -- obter a data de inicio do plano
         v_multa_entry_date := r2.tmcode_date;

      ELSE
         IF TRUNC(v_multa_entry_date) !=  r2.tmcode_date THEN
            --sair do loop pois mudou de plano
            v_exitloop := True;
            EXIT;

         END IF;

      END IF;

    END LOOP;

    RETURN v_multa_entry_date;

  EXCEPTION
    WHEN OTHERS THEN
      ROLLBACK;
      sys.utl_file.put_line(p_filelog, 'ERRO AO OBTER DIA DE ATIVACAO DA MULTA.' || SQLERRM || ' ****');
      sys.utl_file.put_line(p_filelog, 'ROLLBACK EFETUADO.');
  END fbix_obter_multa_entry_date;
  --

     PROCEDURE pbix_check_takeover(p_filelog          IN sys.utl_file.file_type,
                                p_co_id            IN profile_service.co_id%TYPE,
                                p_entry_date       IN profile_service.entry_date%TYPE,
                                p_sncode           IN profile_service.sncode%TYPE,
                                p_tmcode           IN contract_all.tmcode%TYPE,
                                p_multa_entry_date OUT DATE,
                                p_multa_ind        OUT VARCHAR2) IS

    --variáveis de entrada
    v_entry_date DATE;
    v_co_id      INTEGER;

    --variáveis de saída
    v_multa_ind        VARCHAR2(1) := NULL;

    --variáveis auxiliares
    v_takeover_des NUMBER := 0;
    v_exitloop     BOOLEAN := False;

  BEGIN

    v_entry_date := p_entry_date;
    v_co_id      := p_co_id;


    --verifica se é uma desativação por takeover
    SELECT nvl(COUNT(*), 0)
      INTO v_takeover_des
      FROM sysadm.contract_takeover_history
     WHERE old_contract_id = v_co_id;

    --contrato desativado por takeover, não deve aplicar multa.
    IF v_takeover_des <> 0
    THEN

      --nao deve aplicar multa
      v_multa_ind := 'N';

    ELSE

      --deve aplicar multa
      v_multa_ind := 'Y';

      --verifica se é um contrato originado de takeover e localiza data de início da multa
   v_entry_date := null;

   for c_co_id in (
                  SELECT old_contract_id,new_contract_id,
                        takeover_date
                   FROM sysadm.contract_takeover_history h
                  START WITH new_contract_id = p_co_id
                  CONNECT BY PRIOR old_contract_id = new_contract_id
                   order by  h.takeover_date
                 )
   loop

           v_entry_date := null;
           IF p_sncode IS NOT NULL THEN

             begin

              SELECT entry_date
                INTO v_entry_date
                FROM profile_service ps
               WHERE co_id = c_co_id.old_contract_id
                 AND sncode = p_sncode;
              exception
                when others then
                   null;

             end;

           elsif  p_tmcode is not null then
             begin

              SELECT min(tmcode_date)
                INTO v_entry_date
                FROM sysadm.rateplan_hist
               WHERE co_id = c_co_id.old_contract_id
                 AND tmcode = p_tmcode;
              exception
                when others then
                   null;

             end;
           end if;

           if v_entry_date is not null then
              exit;
           end if;
  end loop;

  end if;

    p_multa_entry_date := v_entry_date;


    if  p_multa_entry_date is null then
        p_multa_entry_date :=p_entry_date;
    end if;

    --parâmetros de saída
    p_multa_ind        := v_multa_ind;

  EXCEPTION

    WHEN OTHERS THEN
      ROLLBACK;
      sys.utl_file.put_line(p_filelog, 'ERRO AO VERIFICAR CONTRATOS COM TAKEOVER.' || SQLERRM || ' ****');
      sys.utl_file.put_line(p_filelog, 'ROLLBACK EFETUADO.');
  END pbix_check_takeover;

  --
  PROCEDURE pbix_check_prf(p_filelog          IN sys.utl_file.file_type,
                           p_co_id            IN profile_service.co_id%TYPE,
                           p_entry_date       IN profile_service.entry_date%TYPE,
                           p_valid_from_date  IN pr_serv_status_hist.valid_from_date%TYPE,
                           p_multa_entry_date OUT DATE) IS

    --variáveis de entrada
    v_entry_date      DATE;
    v_co_id           INTEGER;
    v_valid_from_date DATE;


    --variável de saída
    v_multa_entry_date DATE := NULL;

  BEGIN

    v_entry_date      := p_entry_date;
    v_co_id           := p_co_id;
    v_valid_from_date := p_valid_from_date;


    --verifica se o contrato teve uma suspensão por PRF depois da ativação da multa,
    --verifica se foi inserido um novo simcard que não seja fictício e
    --verifica se o sim card não é o mesmo do dia da entrada da multa
    SELECT MIN(cd.cd_activ_date)
      INTO v_multa_entry_date
      FROM contract_history ch,
           contr_devices cd
     WHERE ch.co_id = v_co_id
       AND ch.co_id = cd.co_id
       AND ch.ch_reason IN (SELECT rf.cd_reason_fine
                            FROM FNE.tfne_reason_fine rf
                            WHERE  rf.TYPE = 2
                            )
       AND ch.ch_status = 's'
       AND ch.ch_validfrom IN (SELECT MAX(ch2.ch_validfrom)
                                 FROM contract_history ch2
                                WHERE ch2.co_id = ch.co_id
                                  AND ch2.ch_status = ch.ch_status
                                  AND ch2.ch_reason IN (SELECT rf.cd_reason_fine
                                                        FROM FNE.tfne_reason_fine rf
                                                        WHERE  rf.TYPE = 2
                                                        ))
       AND ch.ch_validfrom < cd.cd_activ_date
       AND ch.ch_validfrom > v_entry_date
       AND cd.cd_sm_num NOT LIKE '201%' --sim cards fictícios iniciam com 201
       AND cd.cd_sm_num NOT IN (SELECT cd1.cd_sm_num
                                  FROM contr_devices cd1
                                 WHERE cd1.co_id = cd.co_id
                                   AND trunc(cd.cd_activ_date) = trunc(v_entry_date))
       AND cd.cd_activ_date < v_valid_from_date;


    IF (v_multa_entry_date IS NULL OR trunc(v_multa_entry_date) = trunc(v_valid_from_date))
    THEN

      v_multa_entry_date := v_entry_date;

    END IF;

    --parâmetro de saída.
    p_multa_entry_date := v_multa_entry_date;

  EXCEPTION

    WHEN OTHERS THEN
      ROLLBACK;
      sys.utl_file.put_line(p_filelog, 'ERRO AO VERIFICAR CONTRATOS COM SUSPENSÃO POR PRF.' || SQLERRM || ' ****');
      sys.utl_file.put_line(p_filelog, 'ROLLBACK EFETUADO.');
  END pbix_check_prf;
  --

  --
  PROCEDURE pbix_tickler_records(p_filelog           IN sys.utl_file.file_type,
                                 p_customer_id       IN tickler_records.customer_id%TYPE,
                                 p_co_id             IN tickler_records.co_id%TYPE,
                                 p_short_description IN tickler_records.short_description%TYPE,
                                 p_long_description  IN tickler_records.long_description%TYPE) IS

    v_tickler_number INTEGER;

  BEGIN

    --encontra o novo código para o tickler_number
    SELECT MAX(tickler_number) + 1
      INTO v_tickler_number
      FROM tickler_records;

    --insere registro para controle na tickler_records
    INSERT INTO tickler_records
      (customer_id,
       tickler_number,
       tickler_code,
       tickler_status,
       priority,
       follow_up_code,
       follow_up_date,
       follow_up_user,
       x_coordinate,
       y_coordinate,
       distribution_user1,
       distribution_user2,
       distribution_user3,
       created_by,
       created_date,
       modified_by,
       modified_date,
       closed_by,
       closed_date,
       short_description,
       long_description,
       co_id,
       msg_user,
       msg_date,
       mkt_id,
       msg_id,
       equ_id,
       usg_id,
       src_id,
       typ_id,
       act_id,
       tr_code,
       rec_version,
       follow_up_status,
       request_id,
       resources)
    VALUES
      (p_customer_id,
       v_tickler_number,
       'SYSTEM',
       'NOTE',
       4,
       NULL,
       SYSDATE,
       'SYSADM',
       NULL,
       NULL,
       NULL,
       NULL,
       NULL,
       'SYSADM',
       SYSDATE,
       NULL,
       NULL,
       NULL,
       NULL,
       p_short_description,
       p_long_description,
       p_co_id,
       NULL,
       NULL,
       NULL,
       NULL,
       NULL,
       NULL,
       NULL,
       NULL,
       NULL,
       NULL,
       1,
       'N',
       NULL,
       NULL);

  EXCEPTION

    WHEN OTHERS THEN
      ROLLBACK;
      sys.utl_file.put_line(p_filelog, 'ERRO AO INSERIR NA TICKLER RECORDS.' || SQLERRM || ' ****');
      sys.utl_file.put_line(p_filelog, 'ROLLBACK EFETUADO.');
  END pbix_tickler_records;
  --

  --
  PROCEDURE pbix_relatorio_carencia(p_filelog         IN sys.utl_file.file_type,
                                    p_file            IN sys.utl_file.file_type,
                                    p_custcode        IN customer_all.custcode%TYPE,
                                    p_co_id           IN contract_all.co_id%TYPE,
                                    p_sncode          IN mpusntab.sncode%TYPE,
                                    p_billcycle       IN VARCHAR2,
                                    p_entry_date      IN profile_service.entry_date%TYPE,
                                    p_valid_from_date IN pr_serv_status_hist.valid_from_date%TYPE,
                                    p_perm_dias       IN NUMBER,
                                    p_carencia_dias   IN NUMBER,
                                    p_valor_multa     IN FLOAT,
                                    p_acao            IN VARCHAR2) IS

  BEGIN

    --Cria relatório de Billcheckout.
    sys.utl_file.put_line(p_file,
                          p_custcode || chr(09) || p_co_id || chr(09) || p_sncode || chr(09) || p_billcycle || chr(09) || to_date(p_entry_date, 'dd/mm/yyyy') || chr(09) || to_date(p_valid_from_date, 'dd/mm/yyyy') || chr(09) || p_perm_dias || chr(09) || p_carencia_dias || chr(09) ||
                          ltrim(to_char(round(p_valor_multa, 2), '9G990D99')) || chr(09) || p_acao);

  EXCEPTION

    WHEN OTHERS THEN
      ROLLBACK;
      sys.utl_file.put_line(p_filelog, 'ERRO AO GERAR RELATORIO.' || SQLERRM || ' ****');
      sys.utl_file.put_line(p_filelog, 'ROLLBACK EFETUADO.');

  END pbix_relatorio_carencia;
  --

  --
  FUNCTION create_xml_3g_EPS(   pFilelog               IN sys.utl_file.file_type,
                                pIdCustomer            IN NUMBER,
                                pIdContract            IN NUMBER,
                                pTmcodeFee             IN NUMBER,
                                pTmcodeFeeVersion      IN NUMBER,
                                pSpcodeFee             IN NUMBER,
                                pSncodeFee             IN NUMBER,
                                pFeeDate               IN DATE,
                                pFeeValue              IN FLOAT,
                                pFeeRemark             IN VARCHAR2,
                                pIdExternalApp         IN NUMBER,
                                pXML                   OUT CLOB) RETURN NUMBER
    IS

        sCustcode                  VARCHAR2(50);
        sServiceCatCode            VARCHAR2(30);
        sServCode                  VARCHAR2(30);
        sServType                  VARCHAR2(30);
        sGlAccount                 VARCHAR2(30);
        nSubMId                    NUMBER;
        sFeeValue                  VARCHAR2(30);
        vErrorMsg                  VARCHAR2(500);

    BEGIN

        pXML := NULL;

        vErrorMsg := 'create_xml_3g_EPS - Não foi possível selecionar os dados do contrato '||pIdContract||'.';
        SELECT SUBM_ID INTO nSubMId FROM SYSADM.CONTRACT_ALL WHERE CO_ID = pIdContract;

        vErrorMsg := 'create_xml_3g_EPS - Não foi possível identificar o custcode do cliente '||pIdCustomer||'.';
        SELECT custcode INTO sCustcode
        FROM customer_all where customer_id = pIdCustomer;

        vErrorMsg := 'create_xml_3g_EPS - Não foi possível identificar as informações do plano '||ptmcodeFee||'.';
        SELECT    tmb.accserv_catcode,
                tmb.accserv_code,
                tmb.accserv_type,
                tmb.accglcode
          INTO    sServiceCatCode,
                sServCode,
                sServType,
                sGlAccount
        FROM sysadm.mpulktmb tmb
            WHERE tmb.tmcode = ptmcodeFee
              AND tmb.spcode = pspcodeFee
              AND tmb.sncode = psncodeFee
              AND tmb.vscode = pTmcodeFeeVersion;
        --
        vErrorMsg := null;

        IF ( sServiceCatCode    IS NULL OR
             sServCode    IS NULL OR
             sServType    IS NULL OR
             sGlAccount IS NULL)
        THEN
                vErrorMsg := 'create_xml_3g_EPS - BSCS incorreto: MPULKTMB (ACCSERV_CATCODE,ACCSERV_CODE,ACCSERV_TYPE,ACCGLCODE)- TM:'||pTmcodeFee||'-SP:'||pSpcodeFee||'-SN:'||pSncodeFee;
                sys.utl_file.put_line(pFilelog, vErrorMsg);
                sys.utl_file.fflush(pFilelog);
            RETURN 1;
        END IF;

        /* Alteração solicitada pela Nextel em 02/04/2013.
        "<amount>'||pFeeValue||'</amount>" alterado para "<amount>'||REPLACE(TO_CHAR(pFeeValue),'.',',')||'</amount> "
        Obs.: A base de produção tem o ambiente configurado de forma diferente dos ambientes de testes e por esta razão o problema não foi verificado antes.
        */
        SELECT REPLACE(TO_CHAR(pFeeValue),'.',',') INTO sFeeValue FROM DUAL;

        pXML :=    '<fee>
                    <actionCode>I</actionCode>
                    <customerCode>'||sCustcode||'</customerCode>
                    <feeType>N</feeType>
                    <rpCode>'||pTmcodeFee||'</rpCode>
                    <spCode>'||pSpcodeFee||'</spCode>
                    <snCode>'||pSncodeFee||'</snCode>
                    <rpvsCode>'||pTmcodeFeeVersion||'</rpvsCode>
                    <serviceCategoryCode>'||sServiceCatCode||'</serviceCategoryCode>
                    <serviceCode>'||sServCode||'</serviceCode>
                    <serviceType>'||sServType||'</serviceType>
                    <feeClass>3</feeClass>
                    <amount>'||sFeeValue||'</amount>
                    <remark>'||pFeeRemark||'</remark>
                    <glCode>'||sGlAccount||'</glCode>
                    <period>1</period>
                    <validFrom>'||pFeeDate||'</validFrom>
                    <requestSystemName>BSCS</requestSystemName>
                    <requestSystemControlNumber>'||pIdExternalApp||'</requestSystemControlNumber>
                    <operatorId></operatorId>
                    <submId>'||nSubMId||'</submId>
                    <coId>'||pIdContract||'</coId>
                </fee>';

        RETURN 0;
    EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
      --Log
      sys.utl_file.put_line(pFilelog, '**** PROCESSO FINALIZADO COM ERRO - create_xml_3g_EPS - ' || SQLERRM || ' co_id:' || pIdContract || ' ****');
      sys.utl_file.put_line(pFilelog, vErrorMsg);
      sys.utl_file.put_line(pFilelog, '**** PROCESSO FINALIZADO COM ERROS! AVALIAR LOGS! ****');
      sys.utl_file.fflush(pFilelog);
      Raise_application_error(-20001,'**** PROCESSO FINALIZADO COM ERRO - create_xml_3g_EPS - '||SQLERRM);
    END create_xml_3g_EPS;
  --

  --
  PROCEDURE pbix_cria_xml(p_filelog        IN sys.utl_file.file_type,
                          p_filexml        IN sys.utl_file.file_type,
                          p_custcode       IN customer_all.custcode%TYPE,
                          p_customer_id    IN customer_all.customer_id%TYPE,
                          p_rowid_customer IN ROWID ,
                          p_co_id           IN contract_all.co_id%TYPE,
                          p_valor_multa    IN FLOAT,
                          p_remark         IN VARCHAR2,
                          p_glcode         IN VARCHAR2) IS

    v_seqno            INTEGER;
    v_sncode_fee       INTEGER;
    v_fees_control     NUMBER;
    v_co_id_control    NUMBER;
    v_accserv_catcode  sysadm.mpulktmb.accserv_catcode%type;
    v_accserv_code     sysadm.mpulktmb.accserv_code%type;
    v_accserv_type     sysadm.mpulktmb.accserv_type%type;

    v_error               NUMBER;
    v_spcode           sysadm.mpulktmb.spcode%type;
    v_tmcode           sysadm.mpulktmb.tmcode%type;
    v_tmcode_version   sysadm.mpulktmb.vscode%type;

    v_xml               CLOB;
    v_nIdExternalTask   NUMBER;
    v_nIdExternalApp    NUMBER;

  BEGIN

    --localiza o máximo seqno da fees
    SELECT nvl(MAX(seqno), 0) + 1
      INTO v_seqno
      FROM sysadm.fees
     WHERE customer_id = p_customer_id;

    --localiza o sncode do respectivo glcode
    IF (p_glcode = 'MULTAUPGRA' OR p_glcode = '3GMULTA')
    THEN

      v_sncode_fee := 857;

    ELSE

      v_sncode_fee := 858;

    END IF;

    --Verifica se já foi criado o XML para o contrato.
    v_fees_control := 0;

    SELECT nvl(COUNT(*), 0)
      INTO v_fees_control
      FROM sysadm.fees
     WHERE customer_id = p_customer_id
       AND glcode = p_glcode
       AND remark = p_remark;

    v_co_id_control := fneapl.FNE_PK_CONTROL.fc_count_customer(p_customer_id,p_remark);

    IF v_fees_control = 0 AND  v_co_id_control = 0
    THEN

        IF (p_glcode ='3GMULTA' OR p_glcode = '3GMULTAGROSS') --multa e planos 3g
        THEN

            select tmcode into v_tmcode from sysadm.contract_all where co_id = p_co_id;

            select spcode, vscode
            into   v_spcode, v_tmcode_version
            from sysadm.mpulktmb
            where tmcode = v_tmcode
            and sncode = v_sncode_fee
            and rownum < 2;

           --Executar a procedure - Interface com aplicação local da Nextel;
            BEGIN
                EPSAPL.KEPS_EVENT_PROCESSING.insert_action (2,1,'BSCS',NULL,NULL,NULL,v_nIdExternalApp);

                IF v_nIdExternalApp IS NULL THEN
                        sys.utl_file.put_line(p_filelog,TO_CHAR(SYSDATE,'dd/mm/yyyy hh24:mi:ss')||'EPSAPL.KEPS_EVENT_PROCESSING.insert_action - Nenhum valor retornado no parâmetro p_ID_ACTION');
                        sys.utl_file.fflush(p_filelog);
                END IF;
                EXCEPTION
                    WHEN OTHERS THEN
                        sys.utl_file.put_line(p_filelog,TO_CHAR(SYSDATE,'dd/mm/yyyy hh24:mi:ss')||'EPSAPL.KEPS_EVENT_PROCESSING.insert_action - '||SQLCODE||': '||SQLERRM);
                        sys.utl_file.fflush(p_filelog);
                        raise_application_error(-20001,' - Erro ao inserir XML - EPS '||SQLERRM );
            END;

            v_error := 0;
            v_error := create_xml_3g_EPS(   p_filelog,
                                            p_customer_id,                           --pIdCustomer IN NUMBER,
                                            p_co_id,                                 --pIdContract IN NUMBER,
                                            v_tmcode,                                --pTmcodeFee IN NUMBER,
                                            v_tmcode_version,                        --pTmcodeFeeVersion IN NUMBER,
                                            v_spcode,                                --pSpcodeFee IN NUMBER,
                                            v_sncode_fee,                            --pSncodeFee IN NUMBER,
                                            (to_date(SYSDATE, 'dd/mm/yyyy') - 1),    --pFeeDate IN DATE,
                                            p_valor_multa,                           --pFeeValue IN FLOAT,
                                            p_remark,                                --pFeeRemark IN VARCHAR2,
                                            v_nIdExternalApp,                        --pIdExternalApp IN NUMBER,
                                            v_xml);                                  --pXML OUT CLOB);

            IF v_error = 0 THEN

                BEGIN

                    -- envia o XML para o EPS inserir na fee
                    EPSAPL.KEPS_EVENT_PROCESSING.insert_task(401,1,v_nIdExternalApp,v_xml,v_nIdExternalTask);

                    IF v_nIdExternalTask IS NULL
                    THEN
                        sys.utl_file.put_line(p_filelog,TO_CHAR(SYSDATE,'dd/mm/yyyy hh24:mi:ss')||'EPSAPL.KEPS_EVENT_PROCESSING.insert_task - Nenhum valor retornado no parâmetro p_ID_TASK.');
                        sys.utl_file.fflush(p_filelog);

                    END IF;
                    EXCEPTION

                        WHEN OTHERS THEN
                            ROLLBACK;
                            sys.utl_file.put_line(p_filelog,TO_CHAR(SYSDATE,'dd/mm/yyyy hh24:mi:ss')||'EPSAPL.KEPS_EVENT_PROCESSING.insert_task - '||SQLCODE||': '||SQLERRM);
                            sys.utl_file.fflush(p_filelog);
                            raise_application_error(-20001,' - Erro ao inserir XML - EPS '||SQLERRM );
                END;

                sys.utl_file.put_line(p_filelog,TO_CHAR(SYSDATE,'dd/mm/yyyy hh24:mi:ss')||' - '||p_customer_id||';'||p_co_id||';'||p_valor_multa||';'||p_remark||';'||v_seqno);
                sys.utl_file.fflush(p_filelog);


                fneapl.FNE_PK_CONTROL.sp_atualiza_customer ( p_rowid_customer  => p_rowid_customer,
                                                               p_remark          => p_remark,
                                                               p_seqno           =>v_seqno,
                                                               p_fg_fine_calculated => 'S'
                                                             );

            END IF;

        ELSE --multa 2g

            --localiza a trinca de impostos
            v_accserv_catcode := null;
            v_accserv_code    := NULL;
            v_accserv_type    := NULL;

            select accserv_catcode, accserv_code, accserv_type
                into v_accserv_catcode, v_accserv_code, v_accserv_type
                 from sysadm.mpulktmb
                where sncode = v_sncode_fee
                and tmcode = 11; --rownum <2;

            -- Incluido para gerar o XML para consumo do banking integration.

            sys.utl_file.put_line(p_filexml,
                                '<fee>' || ' <actionCode>' || 'I' || '</actionCode>' || ' <customerCode>' || p_custcode || '</customerCode>' || ' <feeType>' || 'N' || '</feeType>' || ' <rpCode>' || 11 || '</rpCode>' || ' <spCode>' || 7 || '</spCode>' || ' <snCode>' || v_sncode_fee || '</snCode>' ||
                                ' <rpvsCode>' || 1 || '</rpvsCode>' || ' <serviceCategoryCode>' || v_accserv_catcode || '</serviceCategoryCode>' || ' <serviceCode>' || v_accserv_code || '</serviceCode>' || ' <serviceType>' || v_accserv_type || '</serviceType>' || ' <feeClass>' || 3 || '</feeClass>' || ' <amount>' || p_valor_multa ||
                                '</amount>' || ' <remark>' || p_remark || '</remark>' || ' <glCode>' || p_glcode || '</glCode>' || ' <period>' || '1' || '</period>' || ' <validFrom>' || (to_date(SYSDATE, 'dd/mm/yyyy') - 1) || '</validFrom>' || ' <requestSystemName>' || 'BSCS' || '</requestSystemName>' ||
                                ' <requestSystemControlNumber>' || v_seqno || '</requestSystemControlNumber>' || ' </fee>');

    /*      sys.utl_file.put_line(p_filexml,
                                '<fee>' || ' <actionCode>' || 'I' || '</actionCode>' || ' <customerCode>' || p_custcode || '</customerCode>' || ' <feeType>' || 'N' || '</feeType>' || ' <rpCode>' || 11 || '</rpCode>' || ' <spCode>' || 7 || '</spCode>' || ' <snCode>' || v_sncode_fee || '</snCode>' ||
                                ' <rpvsCode>' || 1 || '</rpvsCode>' || ' <serviceCategoryCode>' || 'SEM' || '</serviceCategoryCode>' || ' <serviceCode>' || 'SEM' || '</serviceCode>' || ' <serviceType>' || 'SEM' || '</serviceType>' || ' <feeClass>' || 3 || '</feeClass>' || ' <amount>' || p_valor_multa ||
                                '</amount>' || ' <remark>' || p_remark || '</remark>' || ' <glCode>' || p_glcode || '</glCode>' || ' <period>' || '1' || '</period>' || ' <validFrom>' || (to_date(SYSDATE, 'dd/mm/yyyy') - 1) || '</validFrom>' || ' <requestSystemName>' || 'BSCS' || '</requestSystemName>' ||
                                ' <requestSystemControlNumber>' || v_seqno || '</requestSystemControlNumber>' || ' </fee>');

                          */
            sys.utl_file.put_line(p_filelog,TO_CHAR(SYSDATE,'dd/mm/yyyy hh24:mi:ss')||' - '||p_custcode||';'||p_customer_id||';'||p_valor_multa||';'||p_remark||';'||v_seqno);
            sys.utl_file.fflush(p_filelog);


            fneapl.FNE_PK_CONTROL.sp_atualiza_customer ( p_rowid_customer  => p_rowid_customer,
                                                               p_remark          => p_remark,
                                                               p_seqno           =>v_seqno,
                                                               p_fg_fine_calculated => 'S'
                                                             );

        END IF;

    ELSIF  v_fees_control > 0 THEN

         fneapl.FNE_PK_CONTROL.sp_atualiza_customer ( p_rowid_customer  => p_rowid_customer,
                                                      p_remark          => 'Fim da fidelização do contrato(duplicidade)',
                                                      p_seqno           =>v_seqno,
                                                      p_fg_fine_calculated => 'D'
                                                             );

    END IF;

  EXCEPTION

    WHEN OTHERS THEN
      ROLLBACK;
      sys.utl_file.put_line(p_filelog, 'ERRO AO GERAR ARQUIVO XML.' || SQLERRM || ' ****');
      sys.utl_file.put_line(p_filelog, 'ROLLBACK EFETUADO.');

  END pbix_cria_xml;

  PROCEDURE pbix_multa_carencia_combo (p_filelog         IN sys.utl_file.file_type,
                                       p_file            IN sys.utl_file.file_type,
                                       p_filexml         IN sys.utl_file.file_type)IS



   --ativação por pedido de ajuste

   --identifica contratos de reativação por pedido de ajuste com planos combo
    CURSOR c_contratos_ajuste_plano IS
      SELECT /*+ parallel (ca,15) */
             ca.co_id,
             ca.co_activated,
             ca.customer_id,
             c.custcode,
             ca.tmcode,
             CA.CO_MODDATE
     FROM  contract_all ca,
           customer_all c
       WHERE ca.customer_id = c.customer_id
         AND ca.ch_status = 'a'
         AND trunc(ca.co_activated) = trunc(SYSDATE - 1)
         AND ca.tmcode in (SELECT DISTINCT tmcode_old
                            FROM fne.tfne_criteria_fine
                            WHERE tmcode_old IS NOT NULL
               ) --planos combos
         ;

    c5 c_contratos_ajuste_plano%ROWTYPE;


    vfile        sys.utl_file.file_type := NULL;
    vfilelog     sys.utl_file.file_type := NULL;
    vfilexml     sys.utl_file.file_type := NULL; --  Arquivo XML para inserir da Fees

    -- variáveis auxiliares
    v_valor_multa           FLOAT;
    v_perm_dias             NUMBER;
    v_carencia_dias         NUMBER;
    v_seqno                 INTEGER;
    v_dn_num                VARCHAR2(100);
    v_dn_id                 INTEGER;
    v_billcycle             VARCHAR2(2);
    v_glcode                VARCHAR2(30);
    v_ajuste_control        NUMBER;
    v_contrato_anterior     INTEGER;
    v_short_description     VARCHAR2(20);
    v_long_description      VARCHAR2(2000);
    v_remark                VARCHAR2(2000);
    v_7dias_ind             NUMBER;
    v_des_inv_ind           NUMBER;
    v_multa_entry_date      DATE;
    v_multa_ind             VARCHAR2(1);
    v_co_id_log             INTEGER;
    v_custcode              VARCHAR(50);
    v_tipo_cliente          VARCHAR2(5);
    v_ind_ativo             number;

    v_SubMId                 number;-- 3g ou 2g

  BEGIN

    --Inicia os arquivos.
    vfile        := p_file;
    vfilelog     := p_filelog;
    vfilexml     := p_filexml;

    sys.utl_file.put_line(vfilelog,to_char(SYSDATE,'dd/mm/yyyy hh24:mi:ss')|| '<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>' );
    sys.utl_file.put_line(vfilelog,to_char(SYSDATE,'dd/mm/yyyy hh24:mi:ss')|| ' --------------------------------------------- ');
    sys.utl_file.put_line(vfilelog,to_char(SYSDATE,'dd/mm/yyyy hh24:mi:ss')|| ' - Inicio tratamento processo combo ' );
    sys.utl_file.fflush(vfilelog);


    BEGIN

      sp_carga_cruzamento_plano;


     exception
        when others then
          sys.utl_file.put_line(vfilelog,to_char(SYSDATE,'dd/mm/yyyy hh24:mi:ss')|| ' - Erro na carga dos clientes.  '||SQLERRM );
          sys.utl_file.fflush(vfilelog);
          raise_application_error(-20001,' - Erro na carga de cruzamento de planos sp_carga_cruzamento_plano '||SQLERRM );

    end;

    sys.utl_file.put_line(vfilelog,to_char(SYSDATE,'dd/mm/yyyy hh24:mi:ss')|| ' - Total de contratos com cruzamento carregados '||v_vet_cruza_plano.count );
    sys.utl_file.fflush(vfilelog);

   v_ind_cruz := v_vet_cruza_plano.first;

    WHILE v_ind_cruz IS NOT NULL
      LOOP
      v_ind_multa := 0;
      v_rowid_multa := NULL;
      v_valid_from  := NULL;

   BEGIN

     SELECT ROWID  , valid_from , ccf.customer_id
      INTO v_rowid_multa , v_valid_from ,v_customer_id
      FROM fne.tfne_customer_control_fine ccf
      WHERE ccf.cd_contract = v_vet_cruza_plano(v_ind_cruz).co_id_a --8234001
       AND tmcode = v_vet_cruza_plano(v_ind_cruz).tmcode_old_a--1340
       AND fg_fine_calculated = 'I'
       AND ROWNUM < 2;

      EXCEPTION
       WHEN OTHERS THEN
         v_rowid_multa := NULL;

  END ;
    IF v_rowid_multa IS NOT NULL THEN

      sys.utl_file.put_line(vfilelog,to_char(SYSDATE,'dd/mm/yyyy hh24:mi:ss')|| ' - Cruzando contrato A/B TMCODE_A/TMCODE_B '||v_vet_cruza_plano(v_ind_cruz).co_id_a     ||'/'||
                                                                                                                               v_vet_cruza_plano(v_ind_cruz).co_id_b     ||'/'||
                                                                                                                               v_vet_cruza_plano(v_ind_cruz).tmcode_old_a||'/'||
                                                                                                                               v_vet_cruza_plano(v_ind_cruz).tmcode_new_a);
      sys.utl_file.fflush(vfilelog);

     fneapl.FNE_PK_CONTROL.sp_atualiza_customer ( p_rowid_customer  => v_rowid_multa,
                                                  p_remark          => 'Cruzamento de planos para contrato => '||v_vet_cruza_plano(v_ind_cruz).co_id_b,
                                                  p_seqno           =>1,
                                                  p_fg_fine_calculated => 'D'
                                                );

        fneapl.FNE_PK_CONTROL.fne_carga_contrato_plano   (  p_co_id       => v_vet_cruza_plano(v_ind_cruz).co_id_b,
                                                            p_customer_id => v_customer_id,
                                                            p_tmcode      => v_vet_cruza_plano(v_ind_cruz).tmcode_old_a,
                                                            p_tmcode_new  => 0,
                                                            p_sncode      => 1,
                                                            p_valid_from  => trunc(v_valid_from)
                                                          );


    END IF;

      v_ind_cruz :=   v_vet_cruza_plano.next(v_ind_cruz);
  END LOOP;



    BEGIN

     sp_carga_contrato_plano;


     exception
        when others then
          sys.utl_file.put_line(vfilelog,to_char(SYSDATE,'dd/mm/yyyy hh24:mi:ss')|| ' - Erro na carga dos clientes.  '||SQLERRM );
          sys.utl_file.fflush(vfilelog);
          raise_application_error(-20001,' - Erro na carga de planos sp_carga_contrato_plano '||SQLERRM );

    end;


   -- sys.utl_file.put_line(vfilelog,to_char(SYSDATE,'dd/mm/yyyy hh24:mi:ss')|| ' - Total de contratos carregados '||v_total_co_id );
    sys.utl_file.put_line(vfilelog,to_char(SYSDATE,'dd/mm/yyyy hh24:mi:ss')|| ' - Total de contratos carregados '||v_vet_co_id.count );
    sys.utl_file.fflush(vfilelog);



    for c_co_id_carga in (
                          select ccf.tmcode, ccf.cd_contract co_id ,ccf.valid_from,ccf.customer_id,
                          rowid rowid_customer , sncode , null tipo
                          from FNE.TFNE_CUSTOMER_CONTROL_FINE ccf
                          where ccf.fg_fine_calculated = 'I'

                          )
    LOOP

      BEGIN

         v_ind_ativo := 0;

         select count(*)
         into v_ind_ativo
         from sysadm.contract_all co
         where co.co_id = c_co_id_carga.co_id
          and co.ch_status = 'd';

         v_custcode := NULL;
         v_tipo_cliente :=NULL;

         SELECT custcode , decode(length(ca.cssocialsecno),11,0,14,1)
         INTO v_custcode , v_tipo_cliente
         FROM sysadm.customer_all ca
         WHERE ca.customer_id = c_co_id_carga.customer_id;

         v_dn_num := NULL;

        SELECT substr(dn_num, 3, 2) || '-' || substr(dn_num, 5, 4) || '-' || substr(dn_num, 9, 4)
          INTO v_dn_num
          FROM sysadm.contr_services_cap cp,
               sysadm.directory_number dn
         WHERE cp.dn_id = dn.dn_id
           AND cp.co_id = c_co_id_carga.co_id
           AND cp.main_dirnum  = 'X'
           AND (cp.cs_deactiv_date IS NULL
            OR cp.cs_deactiv_date =(SELECT MAX(cs_deactiv_date)
                                    FROM  sysadm.contr_services_cap cap
                                    WHERE cap.co_id = cp.co_id
                                      AND cap.sncode = cp.sncode
                                   )
              )
           AND Rownum < 2;
           exception
              when others  then
                sys.utl_file.put_line(vfilelog,to_char(SYSDATE,'dd/mm/yyyy hh24:mi:ss')|| ' Erro na busca do do acesso para contrato => '|| c_co_id_carga.co_id);
                raise_application_error(-20001,' - Erro na busca do do acesso para contrato => '|| c_co_id_carga.co_id);
         END;

      if  v_ind_ativo = 0  and v_vet_co_id.exists(c_co_id_carga.co_id) and v_vet_co_id(c_co_id_carga.co_id).seqno <> c_co_id_carga.sncode
        then



      sys.utl_file.put_line(vfilelog,to_char(SYSDATE,'dd/mm/yyyy hh24:mi:ss')|| ' --------------------------------------------- ');
      sys.utl_file.put_line(vfilelog,to_char(SYSDATE,'dd/mm/yyyy hh24:mi:ss')|| ' - Contratos ativos co_id/tmcode/tmcode_new/sncode/valid_from/dta_saida '||c_co_id_carga.co_id||'/'||c_co_id_carga.tmcode||'/'||v_vet_co_id(c_co_id_carga.co_id).tmcode||'/'||c_co_id_carga.sncode||'/'||to_char(c_co_id_carga.valid_from,'yyyymmdd')||'/'||to_char(v_vet_co_id(c_co_id_carga.co_id).tmcode_date,'yyyymmdd'));
      sys.utl_file.put_line(vfilelog,to_char(SYSDATE,'dd/mm/yyyy hh24:mi:ss')|| ' - Valor planos plano/valor '||c_co_id_carga.tmcode||'/'||v_vet_tm_preco(c_co_id_carga.tmcode).accessfee||'/'||v_vet_co_id(c_co_id_carga.co_id).tmcode||'/'||v_vet_tm_preco(v_vet_co_id(c_co_id_carga.co_id).tmcode).accessfee);
      sys.utl_file.fflush(vfilelog);

      v_co_id_log := c_co_id_carga.co_id;

      v_valor_multa       := 0;
      v_perm_dias         := 0;
      v_carencia_dias     := 0;
      v_short_description := NULL;
      v_long_description  := NULL;
      v_remark            := NULL;

   FOR c_conf IN  fneapl.FNE_PK_CONTROL.c_config_plano  (NULL ,
                                                         c_co_id_carga.tmcode,
                                                         v_vet_co_id(c_co_id_carga.co_id).tmcode,
                                                         v_tipo_cliente ,
                                                         c_co_id_carga.valid_from,
                                                         c_co_id_carga.tipo,
                                                         v_dn_num
                                                          )
   LOOP



      --Calcula a máxima entrada do serviço de multa e verifica se o serviço base foi desativado anteriormente.
      -- item 2 - rastrear o plano
      --v_multa_entry_date := fbix_calcula_multa_entry_date(vfilelog, c1.co_id, c1.sncode, c3.sncode, c1.entry_date, c1.valid_from_date);

      v_multa_entry_date := c_co_id_carga.valid_from;


      --verifica se o contrato teve uma suspensão PRF e devolve a data a ser considerada no cálculo da carência
      pbix_check_prf(vfilelog, c_co_id_carga.co_id, v_multa_entry_date, v_vet_co_id(c_co_id_carga.co_id).tmcode_date, v_multa_entry_date);

      -- verifica se existe takeover para o contrato, indica se devemos aplicar a multa e devolve a data a ser considerada no cálculo da carência
      -- verificar takeover
      pbix_check_takeover(vfilelog, c_co_id_carga.co_id, v_multa_entry_date, null, c_co_id_carga.tmcode, v_multa_entry_date, v_multa_ind);

      -- No cursor de contratos ativos com troca de plano incluir uma nova validação para verificar se o contrato foi uma reativação por ajuste
      --Se for uma reativação por ajuste, cliente que foi desativado por não pagamento e voltou para a base com um novo contrato, não aplicar multa.

      SELECT  nvl(COUNT(*), 0)
        INTO  v_des_inv_ind
        FROM  sysadm.tickler_records
       WHERE  co_id = c_co_id_carga.co_id
         and  short_description  = 'REATIV AJUSTE PLANOS'
         and  trunc(created_date) - 1 = trunc(v_multa_entry_date);   -- Diferente porque o cliente pode entrar com plano combo, sair e depois voltar,
                                                                      -- ai não será considerado uma ativação por reajuste
                                                                      -- sysdate - 1 porque a procedure insere sysdate na tickler_records e olhamos
                                                                       -- contratos com sysdate-1 no cursor contratos_ajuste

       sys.utl_file.put_line(vfilelog,to_char(SYSDATE,'dd/mm/yyyy hh24:mi:ss')|| ' - Detalhe multa fine_id/verion/valid_from/sncode_service/tmcode/invoice_desc/ind_multa => '||c_conf.fine_id                ||'/'||
                                                                                                                                                                                c_conf.version                          ||'/'||
                                                                                                                                                                                to_char(c_conf.valid_from,'yyyymmdd')   ||'/'||
                                                                                                                                                                                c_conf.invoice_desc                     ||'/'||
                                                                                                                                                                                v_multa_ind
                                                                                                                                                                    );
       sys.utl_file.fflush(vfilelog);


      IF v_multa_ind = 'Y' AND v_des_inv_ind = 0
        AND (v_vet_tm_preco(c_co_id_carga.tmcode).accessfee > v_vet_tm_preco(v_vet_co_id(c_co_id_carga.co_id).tmcode).accessfee)

      THEN

        --Calculando os dias de permanência e carência.
         v_perm_dias     :=  trunc(v_vet_co_id(c_co_id_carga.co_id).tmcode_date) - trunc(v_multa_entry_date) ;

        v_carencia_dias := c_conf.duration - v_perm_dias;

        IF  v_carencia_dias < 0 then

            sys.utl_file.put_line(vfilelog,to_char(SYSDATE,'dd/mm/yyyy hh24:mi:ss')|| ' - Fim da fidelização do contrato(vinculo expirou) '||c_co_id_carga.co_id);
            sys.utl_file.fflush(vfilelog);

           fneapl.FNE_PK_CONTROL.sp_atualiza_customer ( p_rowid_customer     => c_co_id_carga.rowid_customer,
                                                        p_remark             => 'Fim da fidelização do contrato(vinculo expirou)',
                                                        p_seqno              =>v_seqno,
                                                        p_fg_fine_calculated =>  'D'
                                                               );
            exit;

        end if;

        --verificando devolução dentro de 7 dias
        v_7dias_ind := 0;

        IF v_perm_dias <= 7
        THEN

          --verifica se houve troca de SIMCARD que caracteriza uma devolução dentro de 7 dias.
          v_7dias_ind := fbix_troca_simcard(vfilelog, c_co_id_carga.co_id, v_multa_entry_date);

        END IF;

        IF v_perm_dias < c_conf.duration AND v_perm_dias > 0 AND v_7dias_ind = 0
        THEN

          --Calcula o valor da multa e o modelo do aparelho(I1, BB ou Titanium);

           v_valor_multa := 0;
           v_valor_multa := round(c_conf.max_access_fee - ((c_conf.max_access_fee / c_conf.duration ) * (v_perm_dias)), 2);

        --  pbix_calcula_multa(vfilelog, c1.co_id, null, c1.tmcode_old, v_multa_entry_date, c_co_id_carga.duration, v_perm_dias,c_co_id_carga.max_access_fee, v_aparelho, v_valor_multa);

          --verifica se é uma nova ativação ou "upgrade" e escolhe o glcode.
          -- Adicionado tratamento para multas 3g (3GMULTA = MULTAUPGRA, 3GMULTAGROSS = MULTAGROSS)
          SELECT SUBM_ID INTO v_SubMId FROM SYSADM.CONTRACT_ALL WHERE CO_ID = c_co_id_carga.co_id;

          IF (trunc(v_vet_co_id(c_co_id_carga.co_id).co_activated) = trunc(v_multa_entry_date) OR trunc(v_vet_co_id(c_co_id_carga.co_id).co_activated) = trunc(v_multa_entry_date) + 1)
          THEN
            IF (v_SubMId = 1) THEN
                v_glcode := 'MULTAGROSS'; -- Novo contrato
            ELSE
                v_glcode := '3GMULTAGROSS'; -- Novo contrato;
            END IF;
          ELSE
            IF (v_SubMId = 1) THEN
                v_glcode := 'MULTAUPGRA'; -- "Upgrade"
            ELSE
                v_glcode := '3GMULTA'; -- Upgrade
            END IF;
          END IF;

          --Informações para o relatório e descrição.
          --localizando número de telefone
          pbix_nrotel_ciclo_ativo(vfilelog, c_co_id_carga.co_id, c_co_id_carga.customer_id, v_dn_num, v_billcycle);

          -- Incluido para gerar o XML para consumo do banking integration.
         -- v_remark := 'Multa Combo ' || v_aparelho || '(' || v_carencia_dias || 'dias) - Tel: ' || v_dn_num || '.';
          v_remark := c_conf.invoice_desc || '(' || v_carencia_dias || 'dias)-Tel: ' || v_dn_num || '.';

          pbix_cria_xml(vfilelog, vfilexml, v_custcode, c_co_id_carga.customer_id,c_co_id_carga.rowid_customer, c_co_id_carga.co_id, v_valor_multa, v_remark, v_glcode);

          --Insere na tickler records
          v_short_description := 'MULTA COMBO';
          v_long_description  := 'Aplicação de multa combo: Contract No.:' || c_co_id_carga.co_id || ' Plano:' || c_co_id_carga.tmcode || ' Valor:' || v_valor_multa || ' - Referente a carência de ' || v_carencia_dias || ' dias.';

          pbix_tickler_records(vfilelog, c_co_id_carga.customer_id, c_co_id_carga.co_id, v_short_description, v_long_description);

          --Cria relatório.
          pbix_relatorio_carencia(vfilelog, vfile, v_custcode, c_co_id_carga.co_id, c_co_id_carga.tmcode, v_billcycle,to_date(c_co_id_carga.valid_from, 'dd/mm/yyyy'), to_date(v_multa_entry_date, 'dd/mm/yyyy'),  v_perm_dias, v_carencia_dias, v_valor_multa, v_long_description);

          END IF;

      END IF;


     END LOOP;



     elsif v_ind_ativo > 0 then

      sys.utl_file.put_line(vfilelog,to_char(SYSDATE,'dd/mm/yyyy hh24:mi:ss')|| ' --------------------------------------------- ');
      sys.utl_file.put_line(vfilelog,to_char(SYSDATE,'dd/mm/yyyy hh24:mi:ss')|| ' - Contratos desativados co_id/tmcode/sncode/valid_from/dta_saida '||c_co_id_carga.co_id||'/'||c_co_id_carga.tmcode||'/'||'/'||c_co_id_carga.sncode||'/'||to_char(c_co_id_carga.valid_from,'yyyymmdd'));
      sys.utl_file.fflush(vfilelog);

      v_co_id_log := c_co_id_carga.co_id;

      v_valor_multa       := 0;
      v_perm_dias         := 0;
      v_carencia_dias     := 0;
      v_short_description := NULL;
      v_long_description  := NULL;
      v_remark            := NULL;


   FOR c_conf IN  fneapl.FNE_PK_CONTROL.c_config_plano  (c_co_id_carga.sncode ,
                                                   c_co_id_carga.tmcode,
                                                   NULL,
                                                   v_tipo_cliente ,
                                                   c_co_id_carga.valid_from,
                                                   c_co_id_carga.tipo,
                                                   v_dn_num
                                                   )
   LOOP

       sys.utl_file.put_line(vfilelog,to_char(SYSDATE,'dd/mm/yyyy hh24:mi:ss')|| ' - Detalhe multa fine_id/verion/valid_from/sncode_service/tmcode/invoice_desc => '||c_conf.fine_id                       ||'/'||
                                                                                                                                         c_conf.version                       ||'/'||
                                                                                                                                         to_char(c_conf.valid_from,'yyyymmdd')||'/'||
                                                                                                                                         c_conf.sncode_fidelity               ||'/'||
                                                                                                                                         c_conf.tmcode_fidelity               ||'/'||
                                                                                                                                         c_conf.invoice_desc
                                                                                                                                        );
       sys.utl_file.fflush(vfilelog);

      v_co_moddate := null;
      v_co_activated := null;
      select co_moddate , co_activated
      into v_co_moddate , v_co_activated
      from sysadm.contract_all co
      where co.co_id = c_co_id_carga.co_id;

      v_co_id_log := c_co_id_carga.co_id;

      --Verifica inicio do combo
      v_multa_entry_date := c_co_id_carga.valid_from; --fbix_obter_multa_entry_date(vfilelog, c_co_id_carga.co_id, c_co_id_carga.tmcode);

      --verifica se o contrato teve uma suspensão PRF e devolve a data a ser considerada no cálculo da carência
      pbix_check_prf(vfilelog, c_co_id_carga.co_id, v_multa_entry_date,v_co_moddate, v_multa_entry_date);

      --verifica se existe takeover para o contrato, indica se devemos aplicar a multa e devolve a data a ser considerada no cálculo da carência
      pbix_check_takeover(vfilelog, c_co_id_carga.co_id, v_multa_entry_date, null, c_co_id_carga.tmcode, v_multa_entry_date, v_multa_ind);

      --verifica se é uma desativação involuntária por não pagamento. (não aplicar multa)
      SELECT nvl(COUNT(*), 0)
        INTO v_des_inv_ind
        FROM sysadm.contract_history
       WHERE co_id = c_co_id_carga.co_id
         AND ch_status = 'd'
         AND ch_reason IN  (SELECT rf.cd_reason_fine
                            FROM FNE.tfne_reason_fine rf
                            WHERE  rf.TYPE = 3);

      --verifica se é uma desativação por transferencia de plano . (não aplicar multa)
      v_transf := 0;
      SELECT nvl(COUNT(*), 0)
        INTO v_transf
        FROM sysadm.contract_history
       WHERE co_id = c_co_id_carga.co_id
         AND ch_status = 'd'
         AND ch_reason IN  (SELECT rf.cd_reason_fine
                            FROM FNE.tfne_reason_fine rf
                            WHERE  rf.TYPE = 4
                            );

      if  v_des_inv_ind > 0 or v_multa_ind = 'N' OR v_transf > 0 then

           IF v_multa_ind = 'N' then
            sys.utl_file.put_line(vfilelog,to_char(SYSDATE,'dd/mm/yyyy hh24:mi:ss')|| ' - Fim da fidelização do contrato (desativação takeover) '||c_co_id_carga.co_id);
            sys.utl_file.fflush(vfilelog);

           fneapl.FNE_PK_CONTROL.sp_atualiza_customer ( p_rowid_customer     => c_co_id_carga.rowid_customer,
                                                        p_remark             => 'Fim da fidelização do contrato (desativação takeover)',
                                                        p_seqno              =>v_seqno,
                                                        p_fg_fine_calculated =>  'D'
                                                       );
           ELSIF v_transf > 0 AND v_multa_ind <> 'N' THEN
           fneapl.FNE_PK_CONTROL.sp_atualiza_customer ( p_rowid_customer     => c_co_id_carga.rowid_customer,
                                                        p_remark             => 'Fim da fidelização do contrato (Transferencia de plano)',
                                                        p_seqno              =>v_seqno,
                                                        p_fg_fine_calculated =>  'D'
                                                       );

           else

            sys.utl_file.put_line(vfilelog,to_char(SYSDATE,'dd/mm/yyyy hh24:mi:ss')|| ' - Fim da fidelização do contrato (desativação involuntária) '||c_co_id_carga.co_id);
            sys.utl_file.fflush(vfilelog);

           fneapl.FNE_PK_CONTROL.sp_atualiza_customer ( p_rowid_customer     => c_co_id_carga.rowid_customer,
                                                        p_remark             => 'Fim da fidelização do contrato (desativação involuntária)',
                                                        p_seqno              =>v_seqno,
                                                        p_fg_fine_calculated =>  'D'
                                                       );
           end if;

           exit;

      end if;

      --Verifica se não é uma desativação por takeover ou não é uma desativação involuntária
      IF (v_multa_ind = 'Y' AND v_des_inv_ind = 0)
      THEN

        v_valor_multa       := 0;
        v_perm_dias         := 0;
        v_carencia_dias     := 0;
        v_short_description := NULL;
        v_long_description  := NULL;
        v_remark            := NULL;

        --Calculando os dias de permanência e carência.
        v_perm_dias     := trunc(v_co_moddate) - trunc(v_multa_entry_date);
        v_carencia_dias := c_conf.duration - v_perm_dias;

        IF  v_carencia_dias < 0 then

            sys.utl_file.put_line(vfilelog,to_char(SYSDATE,'dd/mm/yyyy hh24:mi:ss')|| ' - Fim da fidelização do contrato(vinculo expirou) '||c_co_id_carga.co_id);
            sys.utl_file.fflush(vfilelog);

           fneapl.FNE_PK_CONTROL.sp_atualiza_customer ( p_rowid_customer     => c_co_id_carga.rowid_customer,
                                                        p_remark             => 'Fim da fidelização do contrato(vinculo expirou)',
                                                        p_seqno              =>v_seqno,
                                                        p_fg_fine_calculated =>  'D'
                                                       );
           exit;

        end if;

        --verificando devolução dentro de 7 dias
        v_7dias_ind := 0;

        IF v_perm_dias <= 7
        THEN

          --verifica o motivo de desativação.
          v_7dias_ind := fbix_motivo_desativa_7dias(vfilelog, c_co_id_carga.co_id);

        END IF;


      if  v_7dias_ind > 0 then

            sys.utl_file.put_line(vfilelog,to_char(SYSDATE,'dd/mm/yyyy hh24:mi:ss')|| ' - Fim da fidelização do contrato (desativação 7 dias ) '||c_co_id_carga.co_id);
            sys.utl_file.fflush(vfilelog);

           fneapl.FNE_PK_CONTROL.sp_atualiza_customer ( p_rowid_customer     => c_co_id_carga.rowid_customer,
                                                        p_remark             => 'Fim da fidelização do contrato (desativação 7 dias)',
                                                        p_seqno              =>v_seqno,
                                                        p_fg_fine_calculated =>  'D'
                                                       );
           exit;

      end if;


        IF v_perm_dias < c_conf.duration AND v_perm_dias > 0 AND v_7dias_ind = 0
        THEN

          --Calcula o valor da multa e o modelo do aparelho(I1, BB ou Titanium);
           v_valor_multa := 0;
           v_valor_multa := round(c_conf.max_access_fee - ((c_conf.max_access_fee / c_conf.duration ) * (v_perm_dias)), 2);

         -- pbix_calcula_multa(vfilelog, c2.co_id, null, c2.tmcode, v_multa_entry_date, c_co_id_carga.duration, v_perm_dias,c_co_id_carga.max_access_fee, v_aparelho, v_valor_multa);

          --verifica se é uma nova ativação ou "upgrade" e escolhe o glcode.
          -- Adicionado tratamento para multas 3g (3GMULTA = MULTAUPGRA, 3GMULTAGROSS = MULTAGROSS)
          SELECT SUBM_ID INTO v_SubMId FROM SYSADM.CONTRACT_ALL WHERE CO_ID = c_co_id_carga.co_id;

          IF (trunc(v_co_activated) = trunc(v_multa_entry_date) OR trunc(v_co_activated) = trunc(v_multa_entry_date) + 1)
          THEN
            IF (v_SubMId = 1) THEN
                v_glcode := 'MULTAGROSS'; -- Novo contrato
            ELSE
                v_glcode := '3GMULTAGROSS'; -- Novo contrato;
            END IF;
          ELSE
            IF (v_SubMId = 1) THEN
                v_glcode := 'MULTAUPGRA'; -- "Upgrade"
            ELSE
                v_glcode := '3GMULTA'; -- Upgrade
            END IF;
          END IF;

          --Informações para o relatório e descrição
          --localizando número de telefone
          pbix_nrotel_ciclo_desat(vfilelog, c_co_id_carga.co_id, c_co_id_carga.customer_id, v_dn_num, v_billcycle);

          -- Incluido para gerar o XML para consumo do banking integration.

          v_remark := c_conf.invoice_desc || '(' || v_carencia_dias || 'dias)-Tel: ' || v_dn_num || '.';
         -- v_remark := 'Multa Combo ' || v_aparelho || '(' || v_carencia_dias || 'dias) - Tel: ' || v_dn_num || '.';


          pbix_cria_xml(vfilelog, vfilexml, v_custcode, c_co_id_carga.customer_id,c_co_id_carga.rowid_customer, c_co_id_carga.co_id, v_valor_multa, v_remark, v_glcode);

          --Insere na tickler records
          v_short_description := 'MULTA COMBO';
          v_long_description  := 'Aplicação de multa combo: Contract No.:' || c_co_id_carga.co_id || ' Plano:' || c_co_id_carga.tmcode || ' Valor:' || v_valor_multa || ' - Referente a carência de ' || v_carencia_dias || ' dias.';

          pbix_tickler_records(vfilelog, c_co_id_carga.customer_id, c_co_id_carga.co_id, v_short_description, v_long_description);

          --Cria relatório.
          pbix_relatorio_carencia(vfilelog, vfile, v_custcode, c_co_id_carga.co_id, c_co_id_carga.tmcode, v_billcycle, to_date(v_multa_entry_date, 'dd/mm/yyyy'),trunc(v_co_moddate), v_perm_dias, v_carencia_dias, v_valor_multa, v_long_description);
         END IF;
      END IF;
     END LOOP; --carga config


   elsif v_ind_ativo = 0 and v_vet_co_id.exists(c_co_id_carga.co_id)= false
        then
      v_co_id_log := c_co_id_carga.co_id;

      v_valor_multa       := 0;
      v_perm_dias         := 0;
      v_carencia_dias     := 0;
      v_short_description := NULL;
      v_long_description  := NULL;
      v_remark            := NULL;

   FOR c_conf IN  fneapl.FNE_PK_CONTROL.c_config_plano  (NULL ,
                                                         c_co_id_carga.tmcode,
                                                         null,
                                                         v_tipo_cliente ,
                                                         c_co_id_carga.valid_from,
                                                         c_co_id_carga.tipo,
                                                         v_dn_num
                                                          )
   LOOP

        --Calcula a máxima entrada do serviço de multa e verifica se o serviço base foi desativado anteriormente.
      -- item 2 - rastrear o plano
      --v_multa_entry_date := fbix_calcula_multa_entry_date(vfilelog, c1.co_id, c1.sncode, c3.sncode, c1.entry_date, c1.valid_from_date);
      v_multa_entry_date := v_sysdate;--trunc(sysdate);

      --verifica se o contrato teve uma suspensão PRF e devolve a data a ser considerada no cálculo da carência
    --  pbix_check_prf(vfilelog, c_co_id_carga.co_id, v_multa_entry_date, null,c_co_id_carga.valid_from, v_multa_entry_date);

      -- verifica se existe takeover para o contrato, indica se devemos aplicar a multa e devolve a data a ser considerada no cálculo da carência
      -- verificar takeover
    --  pbix_check_takeover(vfilelog, c_co_id_carga.co_id, v_multa_entry_date, null, c_co_id_carga.tmcode, v_multa_entry_date, v_multa_ind);

        v_perm_dias     := trunc(v_multa_entry_date) - trunc(c_co_id_carga.valid_from);
        v_carencia_dias := c_conf.duration - v_perm_dias;

        IF  v_carencia_dias < 0 then

            sys.utl_file.put_line(vfilelog,to_char(SYSDATE,'dd/mm/yyyy hh24:mi:ss')|| ' -----------------------------------------------------------------------');
            sys.utl_file.put_line(vfilelog,to_char(SYSDATE,'dd/mm/yyyy hh24:mi:ss')|| ' - Fim da fidelização do contrato(vinculo expirou) '||c_co_id_carga.co_id);
            sys.utl_file.fflush(vfilelog);

           fneapl.FNE_PK_CONTROL.sp_atualiza_customer ( p_rowid_customer     => c_co_id_carga.rowid_customer,
                                                        p_remark             => 'Fim da fidelização do contrato(vinculo expirou)',
                                                        p_seqno              =>v_seqno,
                                                        p_fg_fine_calculated =>  'D'
                                                               );
            exit;

        end if;

   end loop;

    end if;

  END LOOP;   --carga contrato tabela multa


    --cursor dos contratos reativados por pedido de ajuste planos combo
    FOR c5 IN c_contratos_ajuste_plano
    LOOP

    sys.utl_file.put_line(vfilelog,to_char(SYSDATE,'dd/mm/yyyy hh24:mi:ss')|| ' --------------------------------------------- ');
    sys.utl_file.put_line(vfilelog,to_char(SYSDATE,'dd/mm/yyyy hh24:mi:ss')|| ' - Inicio tratamento contratos reativados ' );
    sys.utl_file.put_line(vfilelog,to_char(SYSDATE,'dd/mm/yyyy hh24:mi:ss')|| ' --------------------------------------------- ');
     utl_file.fflush(vfilelog);

      v_co_id_log := c5.co_id;

      v_valor_multa    := 0;
      v_perm_dias      := 0;
      v_carencia_dias  := 0;
      v_ajuste_control := 0;

      --localizando dn_id
      SELECT dn_id
        INTO v_dn_id
        FROM contr_services_cap cp
       WHERE cp.co_id = c5.co_id
         AND cp.sncode IN (1, 191, 2124)
         AND cp.cs_deactiv_date IS NULL;

DBMS_METADATA.GET_DDL('PACKAGE','KBIX_MULTA_CARENCIA','BIX')
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

      --verificando se existe esse dn_id em outro contrato do mesmo cliente desativado
      SELECT nvl(COUNT(cp.co_id), 0)
        INTO v_ajuste_control
        FROM contr_services_cap cp,
             contract_all ca
       WHERE cp.co_id = ca.co_id
         AND ca.customer_id = c5.customer_id
         AND cp.dn_id = v_dn_id
         AND trunc(cp.cs_deactiv_date) >= trunc(SYSDATE) - 35;

      IF v_ajuste_control > 0
      THEN

        --Localiza contrato anterior
        SELECT ca.co_id
          INTO v_contrato_anterior
          FROM contr_services_cap cp,
               contract_all ca
         WHERE cp.co_id = ca.co_id
           AND ca.customer_id = c5.customer_id
           AND cp.dn_id = v_dn_id
           AND trunc(cp.cs_deactiv_date) >= trunc(SYSDATE) - 35
           AND rownum = 1;

        --localizando o ciclo
        SELECT billcycle
          INTO v_billcycle
          FROM customer_bch
         WHERE customer_id = c5.customer_id;


        --Insere na tickler records
        v_short_description := 'REATIV AJUSTE PLANOS';
        v_long_description  := 'Contrato reativado por pedido de ajuste com planos combo. Não aplicar multa. Contrato anterior: ' || v_contrato_anterior || '.';

        pbix_tickler_records(vfilelog, c5.customer_id, c5.co_id, v_short_description, v_long_description);

        --Cria relatório.
        --pbix_relatorio_carencia(vfilelog, vfile, c5.custcode, c5.co_id, null, v_billcycle, to_date(c5.entry_date, 'dd/mm/yyyy'), to_date(c5.valid_from_date, 'dd/mm/yyyy'), v_perm_dias, v_carencia_dias, v_valor_multa, v_long_description);
        pbix_relatorio_carencia(vfilelog, vfile, c5.custcode, c5.co_id, null, v_billcycle, to_date(c5.co_activated, 'dd/mm/yyyy'), null, null, null, null, v_long_description);

      END IF;

    END LOOP;
    sys.utl_file.put_line(vfilelog,to_char(SYSDATE,'dd/mm/yyyy hh24:mi:ss')|| ' --------------------------------------------- ');
    sys.utl_file.put_line(vfilelog, '**** PROCESSO COMBO FINALIZADO COM SUCESSO!****');

  EXCEPTION
    WHEN OTHERS THEN
      ROLLBACK;

      --Log
      sys.utl_file.put_line(vfilelog, '**** PROCESSO FINALIZADO COM ERRO - Procedure_Multa_Carencia_Combo - ' || SQLERRM || ' co_id:' || v_co_id_log || ' ****');
      sys.utl_file.put_line(vfilelog, '**** PROCESSO FINALIZADO COM ERROS! AVALIAR LOGS! ****');
      sys.utl_file.fflush(vfilelog);
      Raise_application_error(-20001,'**** PROCESSO FINALIZADO COM ERRO - Procedure_Multa_Carencia_Combo - '||SQLERRM);

  END pbix_multa_carencia_combo;
  --


  --
  PROCEDURE pbix_multa_carencia IS
   -- principal
    --identifica os contratos ativos com o serviço multa desativado.
    CURSOR c_contratos_ativos(p_co_id NUMBER, p_sncode NUMBER,p_valid_from_date DATE ) IS
      SELECT /*+ parallel (ca,15) */
       ca.co_id,
       ca.co_activated,
       ca.customer_id,
       c.custcode,
       ps.entry_date,
       ps.sncode,
       pr.status,
       pr.valid_from_date,
       ps.ovw_access,
       ps.ovw_acc_prd,
       ps.accessfee
        FROM profile_service ps,
             contract_all ca,
             pr_serv_status_hist pr,
             customer_all c
       WHERE ps.co_id = p_co_id
         AND ps.co_id = ca.co_id
         AND ps.co_id = pr.co_id
         AND ps.sncode = pr.sncode
         AND ps.sncode = p_sncode
         AND ps.status_histno = pr.histno
         AND ca.customer_id = c.customer_id
         AND ca.ch_status = 'a'
         AND pr.status = 'D'
         AND pr.valid_from_date IN (SELECT MAX(valid_from_date)
                                      FROM pr_serv_status_hist
                                     WHERE co_id = pr.co_id
                                       AND sncode = pr.sncode)
         AND trunc(pr.valid_from_date) >= trunc(p_valid_from_date);--trunc(SYSDATE - 10);

    c1 c_contratos_ativos%ROWTYPE;

    --identifica os contratos desativados a menos de um mês com o serviço multa desativado.
    CURSOR c_contratos_des (p_co_id NUMBER, p_sncode NUMBER,p_valid_from_date DATE) IS
      SELECT
       ca.co_id,
       ca.co_activated,
       ca.customer_id,
       c.custcode,
       ps.entry_date,
       ps.sncode,
       pr.status,
       pr.valid_from_date,
       ps.ovw_access,
       ps.ovw_acc_prd,
       ps.accessfee
        FROM profile_service ps,
             contract_all ca,
             pr_serv_status_hist pr,
             customer_all c
       WHERE ps.co_id = p_co_id
         AND ps.co_id = ca.co_id
         AND ps.co_id = pr.co_id
         AND ps.sncode = pr.sncode
         AND ps.sncode  = p_sncode
         AND ps.status_histno = pr.histno
         AND ca.customer_id = c.customer_id
         AND ca.ch_status = 'd'
         AND ca.co_moddate >= add_months(trunc(SYSDATE), -1)
         AND pr.status = 'D'
         AND pr.valid_from_date IN (SELECT MAX(valid_from_date)
                                      FROM pr_serv_status_hist
                                     WHERE co_id = pr.co_id
                                       AND sncode = pr.sncode
                                    )
         AND trunc(pr.valid_from_date) >= trunc(p_valid_from_date);--trunc(SYSDATE - 1);

    c2 c_contratos_des%ROWTYPE;

    --identifica se os serviços BIS/BES e I1 foram desativados junto com a multa.
    --incluido os servicos trio ilimitado e sms ilimitado
    CURSOR c_servico_base(p_co_id        INTEGER,
                          p_sncode_multa INTEGER,
                          p_sncode_par   INTEGER

                          ) IS
      SELECT pr.status,
             pr.sncode
        FROM pr_serv_status_hist pr
       WHERE pr.co_id = p_co_id
         AND pr.sncode  = p_sncode_par
        -- AND pr.sncode IN (decode(p_sncode, 855, 839, 856, 612, 863, 839, 904, 657, 905, 884, 0), decode(p_sncode, 855, 839, 856, 613, 863, 839, 904, 657, 905, 884, 0)) --BIS, BES, I1, Titanium
         AND pr.valid_from_date IN (SELECT MAX(valid_from_date)
                                      FROM pr_serv_status_hist pr2
                                     WHERE pr2.co_id = pr.co_id
                                       AND  pr2.sncode = pr.sncode
                                      )
                                      ;

    c3 c_servico_base%ROWTYPE;

    --identifica contratos de reativação por pedido de ajuste
    CURSOR c_contratos_ajuste IS
      SELECT /*+ parallel (ca,15) */
             ca.co_id,
             ca.co_activated,
             ca.customer_id,
             c.custcode,
             ps.entry_date,
             ps.sncode,
             pr.status,
             pr.valid_from_date,
             ps.ovw_access,
             ps.ovw_acc_prd,
             ps.accessfee
        FROM profile_service ps,
             contract_all ca,
             pr_serv_status_hist pr,
             customer_all c
       WHERE ps.co_id = ca.co_id
         AND ps.co_id = pr.co_id
         AND ps.sncode = pr.sncode
         AND ps.sncode IN (SELECT DISTINCT sncode_old
                            FROM fne.tfne_criteria_fine
                            WHERE sncode_old IS NOT NULL
                 ) --serviços de multa
         AND ps.status_histno = pr.histno
         AND ca.customer_id = c.customer_id
         AND ca.ch_status = 'a'
         AND trunc(ca.co_activated) = trunc(SYSDATE - 1)
         AND pr.status = 'A'
         AND pr.valid_from_date IN (SELECT MAX(valid_from_date)
                                      FROM pr_serv_status_hist
                                     WHERE co_id = pr.co_id
                                       AND sncode = pr.sncode
                                       );

    c4 c_contratos_ajuste%ROWTYPE;

    --variáveis do utl file
    vpath        VARCHAR2(1000) := 'BIT_RELATORIO';
    vfile        sys.utl_file.file_type := NULL;
    vfilelog     sys.utl_file.file_type := NULL;
    vfilename    VARCHAR2(2000) := NULL;
    vfilenamelog VARCHAR2(2000) := NULL;
    --vari¿ves do arquivo XML
    vpath_xml    VARCHAR2(1000) :='OCC_XML';
    vfilexml     sys.utl_file.file_type := NULL; --  Arquivo XML para inserir da Fees
    vfilenamexml VARCHAR2(2000) := NULL; --  Nome do arquivo XML para inserir da Fees

    -- variáveis auxiliares
    v_valor_multa       FLOAT;
    v_perm_dias         NUMBER;
    v_carencia_dias     NUMBER;
    v_dn_num            VARCHAR2(100);
    v_dn_id             INTEGER;
    v_billcycle         VARCHAR2(2);
    v_glcode            VARCHAR2(30);
    v_ajuste_control    NUMBER;
    v_contrato_anterior INTEGER;
    v_psrh_seqno        INTEGER;
    v_short_description VARCHAR2(20);
    v_long_description  VARCHAR2(2000);
    v_remark            VARCHAR2(2000);
    v_7dias_ind         NUMBER;
    v_des_inv_ind       NUMBER;
    v_rel_data_corte    VARCHAR2(2);
    v_multa_entry_date  DATE;
    v_multa_ind         VARCHAR2(1);
    v_co_id_log         INTEGER;
    v_custcode          VARCHAR2(50);
    v_tipo_cliente      NUMBER;
    v_ind_serv_except   number;

  BEGIN

    --Inicia os arquivos.
    vfilename    := 'Rel_Multa_Carencia_' || to_char(trunc(SYSDATE), 'ddmmyyyy') || '.XLS';
    vfilenamelog := 'Rel_Multa_Carencia_'||to_char(SYSDATE,'yyyymmdd')||'.log';

    vfile        := sys.utl_file.fopen(vpath, vfilename, 'w');
    vfilelog     := sys.utl_file.fopen(vpath, vfilenamelog, 'w');
    --XML
    vfilenamexml := 'Insert_Multa_' || to_char(trunc(SYSDATE), 'ddmmyyyy') || '.XML';
    vfilexml     := sys.utl_file.fopen(vpath, vfilenamexml, 'w');

    -- Cabeçalhos
    sys.utl_file.put_line(vfile, ' ');
    sys.utl_file.put_line(vfile, 'Centro de Custo' || chr(09) || 'Contrato' || chr(09) || 'serviço/plano' || chr(09) || 'Ciclo' || chr(09) || 'Data de entrada' || chr(09) || 'Data de saída' || chr(09) || 'Dias de Permanência' || chr(09) || 'Dias de carência' || chr(09) || 'Valor R$' || chr(09) || 'Ação');

    sys.utl_file.put_line(vfilexml, '<fees>');


    --Log
    DBMS_OUTPUT.PUT_LINE(to_char(SYSDATE,'dd/mm/yyyy hh24:mi:ss')|| ' - Inicio do processo  TRAVAS e MULTAS ' );
    sys.utl_file.put_line(vfilelog,to_char(SYSDATE,'dd/mm/yyyy hh24:mi:ss')|| ' - Inicio do processo  TRAVAS e MULTAS ' );
    sys.utl_file.put_line(vfilelog,to_char(SYSDATE,'dd/mm/yyyy hh24:mi:ss')|| '<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>' );
    sys.utl_file.put_line(vfilelog,'');
    sys.utl_file.put_line(vfilelog,to_char(SYSDATE,'dd/mm/yyyy hh24:mi:ss')|| ' - Dia de referencia       '||to_char(v_sysdate,'dd/mm/yyyy'));
    sys.utl_file.put_line(vfilelog,to_char(SYSDATE,'dd/mm/yyyy hh24:mi:ss')|| ' --------------------------------------------- ');


    FOR c_co_id_carga IN fneapl.FNE_PK_CONTROL.c_contratos_carga
    LOOP


     v_custcode     := NULL;
     v_tipo_cliente := NULL;


    v_dn_num := NULL;
    BEGIN
      select decode( length(trim(dn.dn_num)),
                      12, (substr(dn.dn_num, 3, 2) || '-' || substr(dn.dn_num, 5, 4) || '-' || substr(dn.dn_num, 9, 4) ),
                      13, (substr(dn.dn_num, 3, 2) || '-' || substr(dn.dn_num, 5, 5) || '-' || substr(dn.dn_num, 10, 4) ),
                      nvl(dn.dn_num, 0) ) as dn_n
          INTO v_dn_num
          FROM contr_services_cap cp,
               directory_number dn
         WHERE cp.dn_id = dn.dn_id
           AND cp.co_id = c_co_id_carga.co_id
           AND cp.sncode in (1, 191, 2124)
           AND (cp.cs_deactiv_date IS NULL OR cp.cs_deactiv_date =(SELECT MAX(cs_deactiv_date)
                                                                   FROM  contr_services_cap cap
                                                                   WHERE cap.co_id = cp.co_id
                                                                     AND cap.sncode = cp.sncode
                                                                  )
              )
           AND Rownum < 2;
       EXCEPTION
         WHEN OTHERS THEN

          pbix_nrotel_ciclo_ativo(vfilelog, c_co_id_carga.co_id, c_co_id_carga.customer_id, v_dn_num, v_billcycle);


    END;

     BEGIN
     v_custcode := NULL;
     v_tipo_cliente :=NULL;

     SELECT custcode , decode(length(ca.cssocialsecno),11,1,14,2,1)
     INTO v_custcode , v_tipo_cliente
     FROM sysadm.customer_all ca
     WHERE ca.customer_id = c_co_id_carga.customer_id;
     EXCEPTION
       WHEN OTHERS THEN
        sys.utl_file.put_line(vfilelog,to_char(SYSDATE,'dd/mm/yyyy hh24:mi:ss')|| 'Erro na busca do tipo de cliente '||SQLERRM||' customer_id => '||c_co_id_carga.customer_id);
        sys.utl_file.fflush(vfilelog);



     END;

    --cursor dos contratos ativos
    FOR c1 IN c_contratos_ativos(c_co_id_carga.co_id,c_co_id_carga.sncode,c_co_id_carga.valid_from)
    LOOP
    sys.utl_file.put_line(vfilelog,to_char(SYSDATE,'dd/mm/yyyy hh24:mi:ss')|| ' --------------------------------------------- ');
    sys.utl_file.put_line(vfilelog,to_char(SYSDATE,'dd/mm/yyyy hh24:mi:ss')|| ' - Inicio tratamento contratos ativos ' );
    sys.utl_file.put_line(vfilelog,to_char(SYSDATE,'dd/mm/yyyy hh24:mi:ss')|| ' --------------------------------------------- ');
    sys.utl_file.fflush(vfilelog);

    sys.utl_file.put_line(vfilelog,to_char(SYSDATE,'dd/mm/yyyy hh24:mi:ss')|| ' co_id/tmcode/sncode/valid_from '||c_co_id_carga.co_id||'/'||c_co_id_carga.tmcode||'/'||c_co_id_carga.sncode||'/'||to_char(c_co_id_carga.valid_from,'yyyymmdd'));
    sys.utl_file.fflush(vfilelog);

      v_co_id_log := c1.co_id;

      v_valor_multa       := 0;
      v_perm_dias         := 0;
      v_carencia_dias     := 0;
      v_short_description := NULL;
      v_long_description  := NULL;
      v_remark            := NULL;



       FOR c_conf IN  fneapl.FNE_PK_CONTROL.C_CONFIG_SERVICO  (c_co_id_carga.sncode ,
                                                       NULL,/*c_co_id_carga.tmcode*/
                                                       NULL,
                                                       v_tipo_cliente ,
                                                       c_co_id_carga.valid_from,
                                                       c_co_id_carga.tipo,
                                                       v_dn_num
                                                                 )
       LOOP

       sys.utl_file.put_line(vfilelog,to_char(SYSDATE,'dd/mm/yyyy hh24:mi:ss')|| ' fine_id/verion/valid_from/sncode_service/tmcode/invoice_desc => '||c_conf.fine_id                       ||'/'||
                                                                                                                                         c_conf.version                       ||'/'||
                                                                                                                                         to_char(c_conf.valid_from,'yyyymmdd')||'/'||
                                                                                                                                         c_conf.sncode_fidelity               ||'/'||
                                                                                                                                         c_conf.tmcode_fidelity               ||'/'||
                                                                                                                                         c_conf.invoice_desc
                                                                                                                                        );
       sys.utl_file.fflush(vfilelog);


      FOR c3 IN c_servico_base(c1.co_id, c1.sncode,c_conf.sncode_service)
      LOOP

        v_ind_serv_except := 0;
        v_ind_serv_except := fc_serv_except(vfilelog, c1.co_id);
        IF c3.status = 'D' and v_ind_serv_except = 0
        THEN

          --Calcula a máxima entrada do serviço de multa e verifica se o serviço base foi desativado anteriormente.
          v_multa_entry_date := fbix_calcula_multa_entry_date(vfilelog, c1.co_id, c1.sncode, c3.sncode, c1.entry_date, c1.valid_from_date);

          --verifica se o contrato teve uma suspensão PRF e devolve a data a ser considerada no cálculo da carência
          pbix_check_prf(vfilelog, c1.co_id, v_multa_entry_date, c1.valid_from_date, v_multa_entry_date);

          --verifica se existe takeover para o contrato, indica se devemos aplicar a multa e devolve a data a ser considerada no cálculo da carência
          pbix_check_takeover(vfilelog, c1.co_id, v_multa_entry_date, c1.sncode, null, v_multa_entry_date, v_multa_ind);


          IF v_multa_ind = 'Y'
          THEN


            --Calculando os dias de permanência e carência.
            v_perm_dias     := trunc(c1.valid_from_date) - trunc(v_multa_entry_date);
            v_carencia_dias := c_conf.duration - v_perm_dias;

            --verificando devolução dentro de 7 dias
            v_7dias_ind := 0;

            IF v_perm_dias <= 7
            THEN

              --verifica se houve troca de SIMCARD que caracteriza uma devolução dentro de 7 dias.
              v_7dias_ind := fbix_troca_simcard(vfilelog, c1.co_id, v_multa_entry_date);

            END IF;

            IF v_perm_dias < c_conf.duration AND v_perm_dias > 0 AND v_7dias_ind = 0
            THEN

              --Calcula o valor da multa e o modelo do aparelho(I1, BB ou Titanium);
               v_valor_multa := 0;
               v_valor_multa := round(c_conf.max_access_fee - ((c_conf.max_access_fee / c_conf.duration ) * (v_perm_dias)), 2);

            --  pbix_calcula_multa(vfilelog, c1.co_id, c1.sncode, null, v_multa_entry_date, c_co_id_carga.duration, v_perm_dias,c_co_id_carga.max_access_fee, v_aparelho, v_valor_multa);

              --verifica se é uma nova ativação ou "upgrade" e escolhe o glcode.
              IF (trunc(c1.co_activated) = trunc(v_multa_entry_date) OR trunc(c1.co_activated) = trunc(v_multa_entry_date) + 1)
              THEN

                v_glcode := 'MULTAGROSS'; -- Novo contrato

              ELSE

                v_glcode := 'MULTAUPGRA'; -- "Upgrade"

              END IF;

              --Informações para o relatório e descrição.
              --localizando número de telefone
              pbix_nrotel_ciclo_ativo(vfilelog, c1.co_id, c1.customer_id, v_dn_num, v_billcycle);

              -- Incluido para gerar o XML para consumo do banking integration.
             -- v_remark := 'Multa de carência ' || v_aparelho || '(' || v_carencia_dias || 'dias) - Tel: ' || v_dn_num || '.';
              v_remark := c_conf.invoice_desc || '(' || v_carencia_dias || 'dias)-Tel: ' || v_dn_num || '.';


              pbix_cria_xml(vfilelog, vfilexml, c1.custcode, c1.customer_id,c_co_id_carga.rowid_customer, c_co_id_carga.co_id, v_valor_multa, v_remark, v_glcode);

              --Insere na tickler records
              v_short_description := 'MULTA DE CARENCIA';
              v_long_description  := 'Aplicação de multa de carência: Contract No.:' || c1.co_id || ' Serviço:' || c1.sncode || ' Valor:' || v_valor_multa || ' - Referente a carência de ' || v_carencia_dias || ' dias.';

              pbix_tickler_records(vfilelog, c1.customer_id, c1.co_id, v_short_description, v_long_description);

              --Cria relatório.
              pbix_relatorio_carencia(vfilelog, vfile, c1.custcode, c1.co_id, c1.sncode, v_billcycle, to_date(v_multa_entry_date, 'dd/mm/yyyy'), to_date(c1.valid_from_date, 'dd/mm/yyyy'), v_perm_dias, v_carencia_dias, v_valor_multa, v_long_description);

            END IF;

          END IF;

        END IF;

      END LOOP; --c_servico_base

     END LOOP;  --c_conf

    END LOOP; -- c_contratos_ativos



    --cursor dos contratos desativados a menos de 1 mês
    FOR c2 IN c_contratos_des(c_co_id_carga.co_id,c_co_id_carga.sncode,c_co_id_carga.valid_from)
    LOOP

    sys.utl_file.put_line(vfilelog,to_char(SYSDATE,'dd/mm/yyyy hh24:mi:ss')|| ' --------------------------------------------- ');
    sys.utl_file.put_line(vfilelog,to_char(SYSDATE,'dd/mm/yyyy hh24:mi:ss')|| ' - Inicio tratamento contratos desativados a menos de 1 mes ' );
    sys.utl_file.put_line(vfilelog,to_char(SYSDATE,'dd/mm/yyyy hh24:mi:ss')|| ' --------------------------------------------- ');
    sys.utl_file.put_line(vfilelog,to_char(SYSDATE,'dd/mm/yyyy hh24:mi:ss')|| ' co_id/tmcode/sncode/valid_from '||c_co_id_carga.co_id||'/'||c_co_id_carga.tmcode||'/'||c_co_id_carga.sncode||'/'||to_char(c_co_id_carga.valid_from,'yyyymmdd'));
    sys.utl_file.fflush(vfilelog);



      v_co_id_log := c2.co_id;

       FOR c_conf IN  fneapl.FNE_PK_CONTROL.C_CONFIG_SERVICO  (c_co_id_carga.sncode ,
                                                       NULL,/*c_co_id_carga.tmcode*/
                                                       NULL,
                                                       v_tipo_cliente ,
                                                       c_co_id_carga.valid_from,
                                                       c_co_id_carga.tipo,
                                                       v_dn_num )
       LOOP

       sys.utl_file.put_line(vfilelog,to_char(SYSDATE,'dd/mm/yyyy hh24:mi:ss')|| ' fine_id/verion/valid_from/sncode_service/tmcode/invoice_desc => '||c_conf.fine_id                       ||'/'||
                                                                                                                                         c_conf.version                       ||'/'||
                                                                                                                                         to_char(c_conf.valid_from,'yyyymmdd')||'/'||
                                                                                                                                         c_conf.sncode_fidelity               ||'/'||
                                                                                                                                         c_conf.tmcode_fidelity               ||'/'||
                                                                                                                                         c_conf.invoice_desc);
       sys.utl_file.fflush(vfilelog);

      FOR c3 IN c_servico_base(c2.co_id, c2.sncode,c_conf.sncode_service)
      LOOP

        IF c3.status = 'D'
        THEN

          --Calcula a máxima entrada do serviço de multa e verifica se o serviço base foi desativado anteriormente.
          v_multa_entry_date := fbix_calcula_multa_entry_date(vfilelog, c2.co_id, c2.sncode, c3.sncode, c2.entry_date, c2.valid_from_date);

          --verifica se o contrato teve uma suspensão PRF e devolve a data a ser considerada no cálculo da carência
          pbix_check_prf(vfilelog, c2.co_id, v_multa_entry_date, c2.valid_from_date, v_multa_entry_date);

          --verifica se existe takeover para o contrato, indica se devemos aplicar a multa e devolve a data a ser considerada no cálculo da carência
          pbix_check_takeover(vfilelog, c2.co_id, v_multa_entry_date, c2.sncode, null, v_multa_entry_date, v_multa_ind);

          --verifica se é uma desativação involuntária por não pagamento. (não aplicar multa)
          SELECT nvl(COUNT(*), 0)
            INTO v_des_inv_ind
            FROM contract_history
           WHERE co_id = c2.co_id
             AND ch_status = 'd'
             AND ch_reason IN (SELECT rf.cd_reason_fine
                                FROM FNE.tfne_reason_fine rf
                                 WHERE  rf.TYPE = 3
                               );

          --Verifica se não é uma desativação por takeover ou não é uma desativação involuntária
          IF (v_multa_ind = 'Y' AND v_des_inv_ind = 0)
          THEN

            v_valor_multa       := 0;
            v_perm_dias         := 0;
            v_carencia_dias     := 0;
            v_short_description := NULL;
            v_long_description  := NULL;
            v_remark            := NULL;

            --Calculando os dias de permanência e carência.
            v_perm_dias     := trunc(c2.valid_from_date) - trunc(v_multa_entry_date);
            v_carencia_dias := c_conf.duration - v_perm_dias;

            --verificando devolução dentro de 7 dias
            v_7dias_ind := 0;

            IF v_perm_dias <= 7
            THEN

              --verifica o motivo de desativação.
              v_7dias_ind := fbix_motivo_desativa_7dias(vfilelog, c2.co_id);

            END IF;

            IF v_perm_dias < c_conf.duration AND v_perm_dias > 0 AND v_7dias_ind = 0
            THEN

              --Calcula o valor da multa e o modelo do aparelho(I1, BB ou Titanium);
                v_valor_multa := 0;
                v_valor_multa := round(c_conf.max_access_fee - ((c_conf.max_access_fee / c_conf.duration ) * (v_perm_dias)), 2);

            --  pbix_calcula_multa(vfilelog, c2.co_id, c2.sncode, null, v_multa_entry_date, c_co_id_carga.duration, v_perm_dias,c_co_id_carga.max_access_fee, v_aparelho, v_valor_multa);

              --verifica se é uma nova ativação ou "upgrade" e escolhe o glcode.
              IF (trunc(c2.co_activated) = trunc(v_multa_entry_date) OR trunc(c2.co_activated) = trunc(v_multa_entry_date) + 1)
              THEN

                v_glcode := 'MULTAGROSS'; -- Novo contrato

              ELSE

                v_glcode := 'MULTAUPGRA'; -- "Upgrade"

              END IF;

              --Informações para o relatório e descrição
              --localizando número de telefone
              pbix_nrotel_ciclo_desat(vfilelog, c2.co_id, c2.customer_id, v_dn_num, v_billcycle);

              -- Incluido para gerar o XML para consumo do banking integration.
              v_remark := c_conf.invoice_desc || '(' || v_carencia_dias || 'dias)- Tel: ' || v_dn_num || '.';

              pbix_cria_xml(vfilelog, vfilexml, c2.custcode, c2.customer_id,c_co_id_carga.rowid_customer, c_co_id_carga.co_id, v_valor_multa, v_remark, v_glcode);

              --Insere na tickler records
              v_short_description := 'MULTA DE CARENCIA';
              v_long_description  := 'Aplicação de multa de carência: Contract No.:' || c2.co_id || ' Serviço:' || c2.sncode || ' Valor:' || v_valor_multa || ' - Referente a carência de ' || v_carencia_dias || ' dias.';

              pbix_tickler_records(vfilelog, c2.customer_id, c2.co_id, v_short_description, v_long_description);

              --Cria relatório.
              pbix_relatorio_carencia(vfilelog, vfile, c2.custcode, c2.co_id, c2.sncode, v_billcycle, to_date(v_multa_entry_date, 'dd/mm/yyyy'), to_date(c2.valid_from_date, 'dd/mm/yyyy'), v_perm_dias, v_carencia_dias, v_valor_multa, v_long_description);
            END IF;

          END IF;
        END IF;

      END LOOP; --FOR c3 IN c_servico_base(c2.co_id, c2.sncode,c_conf.sncode_service)
     END LOOP; -- carga config  FOR c_conf IN  kbix_multa_carencia_nova_carga.c_config

    END LOOP; -- FOR c2 IN c_contratos_des(c_co_id_carga.co_id,c_co_id_carga.sncode,c_co_id_carga.valid_from)
  END LOOP; -- carga


    --cursor dos contratos reativados por pedido de ajuste
    FOR c4 IN c_contratos_ajuste
    LOOP

    sys.utl_file.put_line(vfilelog,to_char(SYSDATE,'dd/mm/yyyy hh24:mi:ss')|| ' --------------------------------------------- ');
    sys.utl_file.put_line(vfilelog,to_char(SYSDATE,'dd/mm/yyyy hh24:mi:ss')|| ' - Inicio tratamento contratos reativados ' );
    sys.utl_file.put_line(vfilelog,to_char(SYSDATE,'dd/mm/yyyy hh24:mi:ss')|| ' --------------------------------------------- ');
    sys.utl_file.fflush(vfilelog);

      v_co_id_log := c4.co_id;

      v_valor_multa    := 0;
      v_perm_dias      := 0;
      v_carencia_dias  := 0;
      v_ajuste_control := 0;

      --localizando dn_id
      SELECT cp.dn_id
        INTO v_dn_id
        FROM contr_services_cap cp
       WHERE cp.co_id = c4.co_id
         AND cp.sncode IN (1, 191, 2124)
         AND cp.cs_deactiv_date IS NULL;

      --verificando se existe esse dn_id em outro contrato do mesmo cliente desativado
      SELECT nvl(COUNT(cp.co_id), 0)
        INTO v_ajuste_control
        FROM contr_services_cap cp,
             contract_all ca
       WHERE cp.co_id = ca.co_id
         AND ca.customer_id = c4.customer_id
         AND cp.dn_id = v_dn_id
         AND trunc(cp.cs_deactiv_date) >= trunc(SYSDATE) - 35;

      IF v_ajuste_control > 0
      THEN

        sys.utl_file.put_line(vfilelog, 'Contrato reativado por pedido de ajuste (L4) ' || c4.co_id);

        --Localiza contrato anterior
        SELECT ca.co_id
          INTO v_contrato_anterior
          FROM contr_services_cap cp,
               contract_all ca
         WHERE cp.co_id = ca.co_id
           AND ca.customer_id = c4.customer_id
           AND cp.dn_id = v_dn_id
           AND trunc(cp.cs_deactiv_date) >= trunc(SYSDATE) - 35
           AND rownum = 1;

        --localizando o ciclo
        SELECT billcycle
          INTO v_billcycle
          FROM customer_bch
         WHERE customer_id = c4.customer_id;

        --Desativa o serviço de multa
        INSERT INTO pr_serv_status_hist
          (profile_id,
           co_id,
           sncode,
           histno,
           status,
           reason,
           transactionno,
           valid_from_date,
           entry_date,
           request_id,
           rec_version,
           rs_id,
           username,
           user_reason,
           entry_user,
           job_id)
        VALUES
          (0,
           c4.co_id,
           c4.sncode,
           pr_serv_status_histno_seq.nextval,
           'D',
           1,
           pr_serv_trans_no_seq.nextval,
           SYSDATE,
           SYSDATE,
           NULL,
           1,
           317,
           NULL,
           NULL,
           'SYSADM',
           NULL);

        --atualiza a profile_service com o novo código de histno
        UPDATE profile_service
           SET status_histno = pr_serv_status_histno_seq.currval
         WHERE co_id = c4.co_id
           AND sncode = c4.sncode;

        --encontra o novo código para o psrh_seqno
        SELECT MAX(psrh_seqno) + 1
          INTO v_psrh_seqno
          FROM sysadm.pr_serv_reasonstatus_history;

        --insere histórico na pr_serv_reasonstatus_history
        INSERT INTO sysadm.pr_serv_reasonstatus_history
          (co_id,
           sncode,
           profile_id,
           histno,
           psrh_seqno,
           rs_id_old,
           rs_id_new,
           change_date,
           username)
        VALUES
          (c4.co_id,
           c4.sncode,
           0,
           pr_serv_status_histno_seq.currval,
           v_psrh_seqno,
           NULL,
           317,
           SYSDATE,
           'SYSADM');

        --Insere na tickler records
        v_short_description := 'REATIVACAO DE AJUSTE';
        v_long_description  := 'Contrato reativado por pedido de ajuste. Multa desativada. Contrato anterior: ' || v_contrato_anterior || '.';

        pbix_tickler_records(vfilelog, c4.customer_id, c4.co_id, v_short_description, v_long_description);

        --Cria relatório.
        pbix_relatorio_carencia(vfilelog, vfile, c4.custcode, c4.co_id, c4.sncode, v_billcycle, to_date(c4.entry_date, 'dd/mm/yyyy'), to_date(c4.valid_from_date, 'dd/mm/yyyy'), v_perm_dias, v_carencia_dias, v_valor_multa, v_long_description);

      END IF;

    END LOOP;

    --chamadas dos combos
    --passar os arquivos por parametros
    pbix_multa_carencia_combo(vfilelog, vfile, vfilexml);


    --Cria relatório mensal para contabilização do total de novas ativações e "Upgrades".
    SELECT to_char(SYSDATE, 'dd')
      INTO v_rel_data_corte
      FROM dual;

    IF v_rel_data_corte = '01'
    THEN

      DECLARE
        --variáveis do utl file
        vpath           VARCHAR2(1000) := 'BIT_RELATORIO';
        vfilemensal     sys.utl_file.file_type := NULL;
        vfilenamemensal VARCHAR2(2000) := NULL;

      BEGIN

        --Inicia os arquivos.
        vfilenamemensal := 'Rel_Multa_Carencia_Mensal_' || to_char(trunc(SYSDATE), 'ddmmyyyy') || '.XLS';
        vfilemensal     := sys.utl_file.fopen(vpath, vfilenamemensal, 'w');

        -- Cabeçalho
        sys.utl_file.put_line(vfilemensal, ' ');
        sys.utl_file.put_line(vfilemensal, 'Centro de Custo' || chr(09) || 'Ciclo' || chr(09) || 'Cliente' || chr(09) || 'Valor' || chr(09) || 'Descrição' || chr(09) || 'Conta contábil' || chr(09) || 'Tipo' || chr(09) || 'Data' || chr(09) || 'Billing account id' || chr(09) || 'Quantidade');

        FOR r IN (SELECT /*+ parallel (f,15) */
                   ca.custcode,
                   cb.billcycle,
                   f.customer_id,
                   f.amount_gross,
                   f.remark,
                   f.glcode,
                   decode(f.sncode, 857, 'UPGRADE', 858, 'GROSS', 'OUTROS') sncode_fee,
                   f.valid_from,
                   f.billing_account_id,
                   f.total_periods
                    FROM fees f,
                         customer_all ca,
                         customer_bch cb
                   WHERE f.customer_id = ca.customer_id
                     AND f.customer_id = cb.customer_id
                     AND f.valid_from >= add_months(trunc(SYSDATE), -1)
                     AND f.valid_from < trunc(SYSDATE)
                     AND f.sncode IN (857, 858))

        LOOP

          sys.utl_file.put_line(vfilemensal,
                                r.custcode || chr(09) || r.billcycle || chr(09) || r.customer_id || chr(09) || r.amount_gross || chr(09) || r.remark || chr(09) || r.glcode || chr(09) || r.sncode_fee || chr(09) || to_date(r.valid_from, 'dd/mm/yyyy') || chr(09) || r.billing_account_id || chr(09) ||
                                r.total_periods);
        END LOOP;

        --Fechando arquivo mensal
        sys.utl_file.fclose(vfilemensal);

      EXCEPTION

        WHEN OTHERS THEN
          ROLLBACK;
          sys.utl_file.put_line(vfilelog, 'ERRO AO GERAR RELATORIO MENSAL.' || SQLERRM || ' ****');
          sys.utl_file.put_line(vfilelog, 'ROLLBACK EFETUADO.');
          sys.utl_file.fflush(vfilelog);

          --Fechando arquivo mensal
          sys.utl_file.fclose(vfilemensal);

      END;

    END IF;

    --Fecha o arquivo XML
    IF sys.utl_file.is_open(vfilexml)
    THEN
      sys.utl_file.put_line(vfilexml, '</fees>');
      sys.utl_file.fclose(vfilexml);
      sys.utl_file.fcopy(vpath, vfilenamexml, vpath_xml, vfilenamexml);
      sys.utl_file.fremove(vpath, vfilenamexml);
    END IF;

    COMMIT;

    sys.utl_file.put_line(vfilelog, '**** PROCESSO FINALIZADO COM SUCESSO!****');
    sys.utl_file.fflush(vfilelog);
    DBMS_OUTPUT.PUT_LINE('**** PROCESSO FINALIZADO COM SUCESSO!****');
    --Fechando arquivos
    sys.utl_file.fclose(vfile);
    sys.utl_file.fclose(vfilelog);

  EXCEPTION
    WHEN OTHERS THEN
      ROLLBACK;

      --Log]
      DBMS_OUTPUT.PUT_LINE('**** PROCESSO FINALIZADO COM ERRO - Procedure_Multa_Carencia - ' || SQLERRM || ' co_id:' || v_co_id_log || ' ****');
      sys.utl_file.put_line(vfilelog, '**** PROCESSO FINALIZADO COM ERRO - Procedure_Multa_Carencia - ' || SQLERRM || ' co_id:' || v_co_id_log || ' ****');
      sys.utl_file.put_line(vfilelog, '**** PROCESSO FINALIZADO COM ERROS! AVALIAR LOGS! ****');

      --Fechando arquivos
      sys.utl_file.fclose(vfile);
      sys.utl_file.fclose(vfilelog);

      IF sys.utl_file.is_open(vfilexml)
      THEN
        sys.utl_file.fclose(vfilexml);
        sys.utl_file.fcopy(vpath, vfilenamexml, vpath, vfilenamexml || '.ERR');
        sys.utl_file.fremove(vpath, vfilenamexml);
      END IF;

  END pbix_multa_carencia;


END kbix_multa_carencia;



1 linha selecionada.

12:15:59 H6NXTL08.IT_PPNETO>SPOOL OFF;
