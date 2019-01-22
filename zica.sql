20:18:18 U2NXTL01.IT_PNET3>select dbms_metadata.get_ddl('PACKAGE'.'KSNG_FINE_I','SNG') FROM DUAL;
select dbms_metadata.get_ddl('PACKAGE'.'KSNG_FINE_I','SNG') FROM DUAL
                                      *
ERRO na linha 1:
ORA-00907: parêntese direito não encontrado


20:19:17 U2NXTL01.IT_PNET3>select dbms_metadata.get_ddl('PACKAGE','KSNG_FINE_I','SNG') FROM DUAL;

DBMS_METADATA.GET_DDL('PACKAGE','KSNG_FINE_I','SNG')
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

  CREATE OR REPLACE PACKAGE "SNG"."KSNG_FINE_I" IS

   -- Author  : Jose Brugiolo Fernandes Passos
   -- Created : 15/03/2007
   -- Purpose : Calculo dos valores de Multa de um determinada contrato
   --
   -- Alteracao em 17-Jul-2008 - Jose Brugiolo
   -- Inclusao da procedure ADD_FINE_CONTRACT_EVENT que
   -- efetua inclusao na tabela tsng_fine_contract_event
   --
   -- Alteracao em 28-May-2012 - Alexandre Borges - TS507/D529
   -- Inclusao de novos campos da TSNG_TMP_FINE_DATA
   -- referentes a data de expiracao e valor da multa de fidelizacao

   --------------------------------------------------------------------------------
   -- ALTERADO     : Romilda Rosa
   -- DATA         : 11/06/2012
   -- TRACEABILITY : 3G Project - TS000507/D000529
   -- OBJETIVO     : Ajuste da PROCEDURE get_fine ao chamar funcao
   --                bix.ksng_contract_i.fsng_get_technology_contract(p_cd_contract)
   --                que passa a retornar o subm_id e nao o
   --                sng.tsng_technology_type.cd_technology_type
   --------------------------------------------------------------------------------
   -- Alterado por : Rogério Iaquinto
   -- Data         : 12/04/2013
   -- Projeto      : Adelantados
   -- Procedure    : get_fine
   --------------------------------------------------------------------------------
   TYPE t_cursor IS REF CURSOR;

   --
   -- procedure que retorna o valor e o tipo de multa devida
   -- por um contrato no momento de sua execução.
   PROCEDURE get_fine(p_cd_contract       IN NUMBER,
                      p_tp_fine           OUT VARCHAR2,
                      p_total_fine_value  OUT NUMBER,
                      p_qa_validity_fine  OUT NUMBER,
                      p_tp_validity_fine  OUT VARCHAR2,
                      p_start_date        OUT DATE,
                      p_end_date          OUT DATE,
                      p_suspension_days   OUT NUMBER,
                      p_diary_fine_value  OUT NUMBER,
                      p_fine_value        OUT NUMBER,
                      p_fine_days_charged OUT NUMBER);

   -- procedure que calcula a multa para um contrato
   PROCEDURE calculate_fine(p_cd_contract       IN NUMBER,
                            p_start_date        IN DATE,
                            p_va_fine           IN NUMBER,
                            p_tp_validity       IN VARCHAR2,
                            p_qa_validity       IN NUMBER,
                            p_proportional_fine IN VARCHAR2,
                            p_fine_value        OUT NUMBER,
                            p_suspension_days   OUT NUMBER,
                            p_diary_fine_value  OUT NUMBER,
                            p_end_date          OUT DATE,
                            p_fine_days_charged OUT NUMBER);

   -- verifica se houve contratos ativos nos ultimos seis meses
   -- excluido o contrato processado
   FUNCTION contract_active_6_months_ago(p_customer_id IN NUMBER,
                                         p_cd_contract IN NUMBER) RETURN NUMBER;

   -- verifica se contrato ja era STN
   -- antes da data
   FUNCTION contract_stn_verify(p_cd_contract IN NUMBER,
                                p_order_date  IN DATE) RETURN BOOLEAN;

   -- trata string do campo BSC.CONTR_SERVICES.CS_STAT_CHNG
   -- extraindo a primeira e a ultima data.
   -- Ex conteudo do campo: '060330a|060916s|060918a|070208s|070208d'
   PROCEDURE extract_stn_dates(p_str  IN VARCHAR2,
                               p_dt_1 OUT DATE,
                               p_dt_2 OUT DATE);

   -- verifica se houve take-over
   -- para um contrato
   FUNCTION get_take_over(p_cd_contract IN NUMBER) RETURN DATE;

   -- obtem o novo cd_customer
   -- de um take over a partir do campo
   -- bsc.tickler_records.short_description
   FUNCTION get_subscriber_take_over(p_str_take_over IN VARCHAR2) RETURN VARCHAR2;

   -- obtem o id_customer_family a partir
   -- do cd_customer
   FUNCTION get_customer_family(p_cd_customer IN VARCHAR2) RETURN NUMBER;

   -- verifica se um determinado caracter eh um
   -- numero ou nao
   FUNCTION is_number(p_1 IN VARCHAR2) RETURN BOOLEAN;

   -- procedure que retorna cursor (tabela temporaria)
   -- com dados de multa
   PROCEDURE get_fine_data(p_cd_contract IN number_array,
                           p_cursor      OUT t_cursor);

   -- function que retorna o valor para uma multa de fidelizacao
   FUNCTION get_matrix_loyalty_fine(p_modelo       IN VARCHAR2,
                                    p_cd_rate_plan IN NUMBER,
                                    p_id_rate_plan IN NUMBER) RETURN NUMBER;

   -- function que retorno o imei a partir do contrato
   FUNCTION get_imei_by_contract(p_cd_contract IN NUMBER) RETURN VARCHAR2;

   -- function que retorna o id_rate_plan de um contrato
   FUNCTION get_id_rate_plan_by_contr(p_cd_contract IN NUMBER) RETURN NUMBER;

   PROCEDURE add_fine_contract_event(p_cd_contract          IN tsng_fine_contract_event.cd_contract%TYPE,
                                     p_tp_event             IN tsng_fine_contract_event.tp_event%TYPE,
                                     p_tp_fine              IN tsng_fine_contract_event.tp_fine%TYPE,
                                     p_cd_previous_contract IN tsng_fine_contract_event.cd_previous_contract%TYPE,
                                     p_va_fine              IN tsng_fine_contract_event.va_fine%TYPE,
                                     p_tp_validity          IN tsng_fine_contract_event.tp_validity%TYPE,
                                     p_qa_validity          IN tsng_fine_contract_event.qa_validity%TYPE,
                                     p_fg_proportional_fine IN tsng_fine_contract_event.fg_proportional_fine%TYPE);

END ksng_fine_i;
CREATE OR REPLACE PACKAGE BODY "SNG"."KSNG_FINE_I" IS

   ------------------------------------------------------------------------------------------------------
   -- ALTERADO  : Romilda Rosa
   -- DATA      : 10/05/2012
   -- PROJETO   : 3G Project - TS000507/D000529
   -- OBJETIVO  : - Acrescentar validacao de tecnologia e ainda do parametro de geração de  multa  para a
   --               a teconologia 3G.
   --             1) Acrescentar a funcao LOCAL obtem_fl_gera_multa_3g
   --             2) Acrescentar a obtenção de tecnologia  pela execução da funcao:
   --                bix.ksng_contract_i.fsng_get_technology_contract
   --             3) Acrescentar a validação de tecnologia e flag de geração de multa no  caso do 3G antes
   --                da execução da calculate_fine.
   -------------------------------------------------------------------------------------------------------
   -- ALTERADO     : Romilda Rosa
   -- DATA         : 11/06/2012
   -- TRACEABILITY : 3G Project - TS000507/D000529
   -- OBJETIVO     : Ajuste da PROCEDURE get_fine ao chamar funcao
   --                bix.ksng_contract_i.fsng_get_technology_contract(p_cd_contract)
   --                que passa a retornar o subm_id e nao o
   --                sng.tsng_technology_type.cd_technology_type
   -------------------------------------------------------------------------------------------------------
   PROCEDURE get_fine(p_cd_contract       IN NUMBER,
                      p_tp_fine           OUT VARCHAR2,
                      p_total_fine_value  OUT NUMBER,
                      p_qa_validity_fine  OUT NUMBER,
                      p_tp_validity_fine  OUT VARCHAR2,
                      p_start_date        OUT DATE,
                      p_end_date          OUT DATE,
                      p_suspension_days   OUT NUMBER,
                      p_diary_fine_value  OUT NUMBER,
                      p_fine_value        OUT NUMBER,
                      p_fine_days_charged OUT NUMBER) IS

      CURSOR c_contract IS
         SELECT cd_sm_num,
                customer_id,
                tmcode,
                cd_activ_date
           FROM TABLE(bix.ksng_fine_i.fsng_select_01(p_cd_contract));
      rec_contract c_contract%ROWTYPE;

      -- informacoes de configuracao de multa
      CURSOR c_fine_config(pc_start_date IN DATE,
                           pc_tp_fine    IN VARCHAR2) IS
         SELECT va_fine,
                tp_fine,
                tp_validity,
                qa_validity,
                fg_proportional_fine
           FROM tsng_fine_config
          WHERE trunc(pc_start_date) BETWEEN dt_start_fine_config AND
                nvl(dt_end_fine_config, to_date('31/12/3000', 'dd/mm/yyyy'))
            AND tp_fine = pc_tp_fine
            AND fg_excluded_register = 'N';
      rec_fine_config c_fine_config%ROWTYPE;

      -- informacoes de excecoes de multa
      CURSOR c_fine_exception_config(pc_cd_product   IN VARCHAR,
                                     pc_cd_rate_plan IN NUMBER,
                                     pc_tp_fine      IN VARCHAR2,
                                     pc_start_date   IN DATE) IS
         SELECT tp_fine,
                fg_apply_fine,
                va_fine,
                tp_validity,
                qa_validity,
                fg_proportional_fine,
                cd_product,
                cd_rate_plan
           FROM tsng_fine_exception_config
          WHERE trunc(pc_start_date) BETWEEN dt_start_fine_exception_config AND
                nvl(dt_end_fine_exception_config, to_date('29/09/2068', 'dd/mm/yyyy'))
            AND fg_excluded_register = 'N'
            AND tp_fine = pc_tp_fine
            AND (((upper(cd_product) LIKE '%' || upper(pc_cd_product) || '%' AND
                 pc_cd_product IS NOT NULL) OR
                 (upper(pc_cd_product) LIKE '%' || upper(cd_product) || '%' AND
                 cd_product IS NOT NULL)) OR (cd_rate_plan = pc_cd_rate_plan))
          ORDER BY va_fine DESC;
      rec_fine_exception_config c_fine_exception_config%ROWTYPE;

      -- cursor que retorna ocorrencias geradoras de multa.
      CURSOR c_fine_event IS
         SELECT tp_event,
                tp_fine,
                dt_event,
                cd_previous_contract,
                va_fine,
                tp_validity,
                qa_validity,
                fg_proportional_fine
           FROM tsng_fine_contract_event
          WHERE cd_contract = p_cd_contract
          ORDER BY dt_event DESC;
      rec_fine_event c_fine_event%ROWTYPE;

      -- cursor que retorna os pedidos que geram multa contratual
      CURSOR c_order_event IS
         SELECT a.dt_order,
                a.id_order_type,
                b.cd_product,
                cd_imei_replaced
           FROM tsng_order      a,
                tsng_order_item b,
                tsng_order_type c
          WHERE a.cd_order = b.cd_order
            AND a.id_order_type = c.id_order_type
            AND a.id_order_type IN (16, 135, 158, 159)
            AND b.cd_contract = p_cd_contract
            AND NOT EXISTS (SELECT 1
                   FROM tsng_order_status_history y
                  WHERE y.cd_order = a.cd_order
                    AND y.cd_order_status IN
                        (SELECT to_number(va_parameter)
                           FROM tbgn_parameter
                          WHERE cd_parameter LIKE 'FINE_ORDER_CANCELED'
                            AND fg_excluded_register = 'N'))

          ORDER BY dt_order DESC;

      rec_order_event c_order_event%ROWTYPE;
      --
      v_dt_aux             DATE;
      v_activ_date         DATE;
      v_take_over_date     DATE;
      v_de_model           VARCHAR2(50);
      v_active_contract    NUMBER := 0;
      v_was_stn            BOOLEAN := FALSE;
      v_subm_id            sng.tsng_technology_type.cd_technology_type_bscs%TYPE;
      v_cd_technology_type sng.tsng_technology_type.cd_technology_type%TYPE;

      v_tp_multa_contratual  CHAR(1);
      v_tp_multa_fidelizacao CHAR(1);
      --
      r_config_not_found EXCEPTION;

      FUNCTION obtem_fl_gera_multa_3g(p_tp_fine IN VARCHAR) RETURN VARCHAR IS
         v_cd_parameter sng.tsng_parameter.cd_parameter%TYPE;
         v_va_parameter sng.tsng_parameter.va_parameter%TYPE;
      BEGIN
         IF p_tp_fine = 'A' THEN
            v_cd_parameter := 'GERA_MULTA_CONTRATUAL_3G';
         ELSIF p_tp_fine = 'B' THEN
            v_cd_parameter := 'GERA_MULTA_FIDELIZACAO_3G';
         ELSE
            raise_application_error(-20001, 'Tipo multa ' || p_tp_fine || ' nao previsto ');
         END IF;

         SELECT va_parameter
           INTO v_va_parameter
           FROM sng.tsng_parameter
          WHERE cd_parameter = v_cd_parameter;

         RETURN v_va_parameter;
      EXCEPTION
         WHEN OTHERS THEN
            raise_application_error(-20001,
                                    SQLERRM ||
                                    ' ao obter parametro na tabela SNG.TSNG_PARAMETER para o cd_parameter = ' ||
                                    v_cd_parameter);
      END;

   BEGIN

      -- Romilda -- Obter a tecnologia do contrato
      v_subm_id := bix.ksng_contract_i.fsng_get_technology_contract(p_cd_contract);
      IF v_subm_id IS NOT NULL THEN
         BEGIN
            SELECT cd_technology_type
              INTO v_cd_technology_type
              FROM sng.tsng_technology_type
             WHERE cd_technology_type_bscs = v_subm_id;
         EXCEPTION
            WHEN no_data_found THEN
               v_cd_technology_type := 0;
         END;
      ELSE
         v_cd_technology_type := 0;
      END IF;

      IF (v_cd_technology_type = 3) THEN
         v_tp_multa_contratual  := 'B';
         v_tp_multa_fidelizacao := 'A';
      ELSE
         v_tp_multa_contratual  := 'C';
         v_tp_multa_fidelizacao := 'L';
      END IF;

      p_tp_fine           := v_tp_multa_fidelizacao;
      p_total_fine_value  := 0;
      p_qa_validity_fine  := 0;
      p_tp_validity_fine  := 0;
      p_start_date        := NULL;
      p_end_date          := NULL;
      p_suspension_days   := 0;
      p_diary_fine_value  := 0;
      p_fine_value        := 0;
      p_fine_days_charged := 0;

      IF (v_cd_technology_type = 3) AND (obtem_fl_gera_multa_3g(v_tp_multa_contratual) = 'N') AND
         (obtem_fl_gera_multa_3g(v_tp_multa_fidelizacao) = 'N') THEN
         RETURN;
      END IF;

      -- obtem dados do contrato
      OPEN c_contract;
      FETCH c_contract
         INTO rec_contract;
      CLOSE c_contract;

      -- obtem ocorrencias geradoras de multa.
      OPEN c_fine_event;
      FETCH c_fine_event
         INTO rec_fine_event;
      CLOSE c_fine_event;

      -- obtem modelo do contrato tratado
      v_de_model := upper(bgn.fbgn_get_model_by_imei(rec_contract.cd_sm_num));

     -- verifica se encontrou ocorrencia
      IF rec_fine_event.dt_event IS NOT NULL THEN
         -- se sim processa multa
         -- calcula multa
-- Alterado por Rogério Iaquinto
-- Data 11/04/2013
-- Alteração para ajuste de multa de fidelização

        /* calculate_fine(p_cd_contract       => p_cd_contract,
                        p_start_date        => rec_fine_event.dt_event,
                        p_va_fine           => rec_fine_event.va_fine,
                        p_tp_validity       => rec_fine_event.tp_validity,
                        p_qa_validity       => rec_fine_event.qa_validity,
                        p_proportional_fine => rec_fine_event.fg_proportional_fine,
                        p_fine_value        => p_fine_value,
                        p_suspension_days   => p_suspension_days,
                        p_diary_fine_value  => p_diary_fine_value,
                        p_end_date          => p_end_date,
                        p_fine_days_charged => p_fine_days_charged);

         p_tp_fine          := rec_fine_event.tp_fine;
         p_total_fine_value := rec_fine_event.va_fine;
         p_qa_validity_fine := rec_fine_event.qa_validity;
         p_tp_validity_fine := rec_fine_event.tp_validity;
         p_start_date       := rec_fine_event.dt_event;
    --     RETURN;

    --     END IF;

*/
               -- busca eventos geradores de multa por plano

               -- verifica se ha excecao de cobranca para o evento de multa encontrado
               OPEN c_fine_exception_config(pc_cd_product   => NULL,
                                            pc_cd_rate_plan => rec_contract.tmcode,
--                                            pc_tp_fine      => v_tp_multa_contratual,
                                            pc_tp_fine      => p_tp_fine,
                                            pc_start_date   => rec_contract.cd_activ_date);
               FETCH c_fine_exception_config
                  INTO rec_fine_exception_config;
               CLOSE c_fine_exception_config;

               -- se encontrou excecao processa multa
               IF rec_fine_exception_config.tp_fine IS NOT NULL THEN
                  IF rec_fine_exception_config.fg_apply_fine = 'N' THEN
                     -- nao cobrar multa
                     p_fine_value        := 0;
                     p_tp_fine           := v_tp_multa_contratual;
                     p_diary_fine_value  := 0;
                     p_fine_days_charged := 0;
                     RETURN;
                  ELSE
                     -- calcula multa
                     calculate_fine(p_cd_contract       => p_cd_contract,
                                    p_start_date        => rec_fine_event.dt_event,
                                    p_va_fine           => rec_fine_exception_config.va_fine,
                                    p_tp_validity       => rec_fine_exception_config.tp_validity,
                                    p_qa_validity       => rec_fine_exception_config.qa_validity,
                                    p_proportional_fine => rec_fine_exception_config.fg_proportional_fine,
                                    p_fine_value        => p_fine_value,
                                    p_suspension_days   => p_suspension_days,
                                    p_diary_fine_value  => p_diary_fine_value,
                                    p_end_date          => p_end_date,
                                    p_fine_days_charged => p_fine_days_charged);

                     p_tp_fine          := rec_fine_exception_config.tp_fine;
                     p_total_fine_value := rec_fine_exception_config.va_fine;
                     p_qa_validity_fine := rec_fine_exception_config.qa_validity;
                     p_tp_validity_fine := rec_fine_exception_config.tp_validity;
                   --  p_start_date       := rec_order_event.dt_order; -- alterado por Rogério Iaquinto
                     p_start_date       := rec_fine_event.dt_event;
                     RETURN;
                  END IF;

               END IF;

               calculate_fine(p_cd_contract       => p_cd_contract,
                        p_start_date        => rec_fine_event.dt_event,
                        p_va_fine           => rec_fine_event.va_fine,
                        p_tp_validity       => rec_fine_event.tp_validity,
                        p_qa_validity       => rec_fine_event.qa_validity,
                        p_proportional_fine => rec_fine_event.fg_proportional_fine,
                        p_fine_value        => p_fine_value,
                        p_suspension_days   => p_suspension_days,
                        p_diary_fine_value  => p_diary_fine_value,
                        p_end_date          => p_end_date,
                        p_fine_days_charged => p_fine_days_charged);

                 p_tp_fine          := rec_fine_event.tp_fine;
                 p_total_fine_value := rec_fine_event.va_fine;
                 p_qa_validity_fine := rec_fine_event.qa_validity;
                 p_tp_validity_fine := rec_fine_event.tp_validity;
                 p_start_date       := rec_fine_event.dt_event;

               RETURN;

      END IF;

------ Fim alteração Rogério Iaquinto

      -- busca eventos geradores de multa na tabela de pedidos
      OPEN c_order_event;
      LOOP
         FETCH c_order_event
            INTO rec_order_event;
         EXIT WHEN c_order_event%NOTFOUND;

         v_active_contract := 0;
         IF rec_order_event.id_order_type IN (16, 158, 159) THEN
            -- Processa Pedidos de Transferencia

            -- verifica se ha algun contrato ativo
            -- para esse cliente nos ultimos 6 meses
            v_active_contract := contract_active_6_months_ago(p_customer_id => rec_contract.customer_id,
                                                              p_cd_contract => p_cd_contract);

            IF v_active_contract = 0 THEN
               -- se nao encontrou contrato ativo
               -- calcula multa com data do pedido tratado

               -- verifica se ha excecao de cobranca para o evento de multa encontrado
               OPEN c_fine_exception_config(pc_cd_product   => v_de_model,
                                            pc_cd_rate_plan => rec_contract.tmcode,
                                            pc_tp_fine      => v_tp_multa_contratual,
                                            pc_start_date   => rec_order_event.dt_order);
               FETCH c_fine_exception_config
                  INTO rec_fine_exception_config;
               CLOSE c_fine_exception_config;

               -- se encontrou excecao processa multa
               IF rec_fine_exception_config.tp_fine IS NOT NULL THEN
                  IF rec_fine_exception_config.fg_apply_fine = 'N' THEN
                     -- nao cobrar multa
                     p_fine_value := 0;
                     p_tp_fine    := v_tp_multa_contratual;
                     CLOSE c_order_event;
                     RETURN;
                  ELSE
                     -- calcula multa
                     calculate_fine(p_cd_contract       => p_cd_contract,
                                    p_start_date        => rec_order_event.dt_order,
                                    p_va_fine           => rec_fine_exception_config.va_fine,
                                    p_tp_validity       => rec_fine_exception_config.tp_validity,
                                    p_qa_validity       => rec_fine_exception_config.qa_validity,
                                    p_proportional_fine => rec_fine_exception_config.fg_proportional_fine,
                                    p_fine_value        => p_fine_value,
                                    p_suspension_days   => p_suspension_days,
                                    p_diary_fine_value  => p_diary_fine_value,
                                    p_end_date          => p_end_date,
                                    p_fine_days_charged => p_fine_days_charged);

                     p_tp_fine          := rec_fine_exception_config.tp_fine;
                     p_total_fine_value := rec_fine_exception_config.va_fine;
                     p_qa_validity_fine := rec_fine_exception_config.qa_validity;
                     p_tp_validity_fine := rec_fine_exception_config.tp_validity;
                     p_start_date       := rec_order_event.dt_order;
                     CLOSE c_order_event;
                     RETURN;
                  END IF;
               ELSE

                  OPEN c_fine_config(pc_start_date => rec_order_event.dt_order,
                                     pc_tp_fine    => v_tp_multa_contratual);
                  FETCH c_fine_config
                     INTO rec_fine_config;
                  CLOSE c_fine_config;

                  IF rec_fine_config.va_fine IS NULL THEN
                     -- *** Erro ***
                     -- nao encontrada configuracao de multa
                     CLOSE c_order_event;
                     v_dt_aux := rec_order_event.dt_order;
                     RAISE r_config_not_found;
                  END IF;

                  -- se nao encontrou excecao processa regra padrao de multa
                  -- calcula multa
                  calculate_fine(p_cd_contract       => p_cd_contract,
                                 p_start_date        => rec_order_event.dt_order,
                                 p_va_fine           => rec_fine_config.va_fine,
                                 p_tp_validity       => rec_fine_config.tp_validity,
                                 p_qa_validity       => rec_fine_config.qa_validity,
                                 p_proportional_fine => rec_fine_config.fg_proportional_fine,
                                 p_fine_value        => p_fine_value,
                                 p_suspension_days   => p_suspension_days,
                                 p_diary_fine_value  => p_diary_fine_value,
                                 p_end_date          => p_end_date,
                                 p_fine_days_charged => p_fine_days_charged);

                  p_tp_fine          := rec_fine_config.tp_fine;
                  p_total_fine_value := rec_fine_config.va_fine;
                  p_qa_validity_fine := rec_fine_config.qa_validity;
                  p_tp_validity_fine := rec_fine_config.tp_validity;
                  p_start_date       := rec_order_event.dt_order;
                  CLOSE c_order_event;
                  RETURN;
               END IF;
            END IF;

         ELSE
            -- Processa Pedidos de Migracao STN

            -- verifica se contrato ja era STN antes deste pedido de migracao
            v_was_stn := contract_stn_verify(p_cd_contract => p_cd_contract,
                                             p_order_date  => rec_order_event.dt_order);

            IF v_was_stn = FALSE THEN
               -- se contrato nao era stn calcula multa a partir deste evento

               -- verifica se ha excecao de cobranca para o evento de multa encontrado
               OPEN c_fine_exception_config(pc_cd_product   => v_de_model,
                                            pc_cd_rate_plan => rec_contract.tmcode,
                                            pc_tp_fine      => v_tp_multa_contratual,
                                            pc_start_date   => rec_order_event.dt_order);
               FETCH c_fine_exception_config
                  INTO rec_fine_exception_config;
               CLOSE c_fine_exception_config;

               -- se encontrou excecao processa multa
               IF rec_fine_exception_config.tp_fine IS NOT NULL THEN
                  IF rec_fine_exception_config.fg_apply_fine = 'N' THEN
                     -- nao cobrar multa
                     p_fine_value := 0;
                     p_tp_fine    := v_tp_multa_contratual;
                     CLOSE c_order_event;
                     RETURN;
                  ELSE
                     -- calcula multa
                     calculate_fine(p_cd_contract       => p_cd_contract,
                                    p_start_date        => rec_order_event.dt_order,
                                    p_va_fine           => rec_fine_exception_config.va_fine,
                                    p_tp_validity       => rec_fine_exception_config.tp_validity,
                                    p_qa_validity       => rec_fine_exception_config.qa_validity,
                                    p_proportional_fine => rec_fine_exception_config.fg_proportional_fine,
                                    p_fine_value        => p_fine_value,
                                    p_suspension_days   => p_suspension_days,
                                    p_diary_fine_value  => p_diary_fine_value,
                                    p_end_date          => p_end_date,
                                    p_fine_days_charged => p_fine_days_charged);

                     p_tp_fine          := rec_fine_exception_config.tp_fine;
                     p_total_fine_value := rec_fine_exception_config.va_fine;
                     p_qa_validity_fine := rec_fine_exception_config.qa_validity;
                     p_tp_validity_fine := rec_fine_exception_config.tp_validity;
                     p_start_date       := rec_order_event.dt_order;
                     CLOSE c_order_event;
                     RETURN;
                  END IF;
               ELSE

                  OPEN c_fine_config(pc_start_date => rec_order_event.dt_order,
                                     pc_tp_fine    => v_tp_multa_contratual);
                  FETCH c_fine_config
                     INTO rec_fine_config;
                  CLOSE c_fine_config;

                  IF rec_fine_config.va_fine IS NULL THEN
                     -- *** Erro ***
                     -- nao encontrada configuracao de multa
                     v_dt_aux := rec_order_event.dt_order;
                     CLOSE c_order_event;
                     RAISE r_config_not_found;
                  END IF;

                  -- se nao encontrou excecao processa regra padrao de multa
                  -- calcula multa
                  calculate_fine(p_cd_contract       => p_cd_contract,
                                 p_start_date        => rec_order_event.dt_order,
                                 p_va_fine           => rec_fine_config.va_fine,
                                 p_tp_validity       => rec_fine_config.tp_validity,
                                 p_qa_validity       => rec_fine_config.qa_validity,
                                 p_proportional_fine => rec_fine_config.fg_proportional_fine,
                                 p_fine_value        => p_fine_value,
                                 p_suspension_days   => p_suspension_days,
                                 p_diary_fine_value  => p_diary_fine_value,
                                 p_end_date          => p_end_date,
                                 p_fine_days_charged => p_fine_days_charged);

                  p_tp_fine          := rec_fine_config.tp_fine;
                  p_total_fine_value := rec_fine_config.va_fine;
                  p_qa_validity_fine := rec_fine_config.qa_validity;
                  p_tp_validity_fine := rec_fine_config.tp_validity;
                  p_start_date       := rec_order_event.dt_order;
                  CLOSE c_order_event;
                  RETURN;
               END IF;
            END IF;
         END IF;
      END LOOP;
      CLOSE c_order_event;

      -- se nenhuma multa foi cobrada
      -- calcula multa a partir da data de ativacao do contrato

      -- verifica take_over de contratos
      v_take_over_date := get_take_over(p_cd_contract => p_cd_contract);

      IF v_take_over_date < rec_contract.cd_activ_date THEN
         v_activ_date := v_take_over_date;
      ELSE
         v_activ_date := rec_contract.cd_activ_date;
      END IF;

      -- verifica se ha excecao de cobranca para o evento de multa encontrado
      OPEN c_fine_exception_config(pc_cd_product   => v_de_model,
                                   pc_cd_rate_plan => rec_contract.tmcode,
                                   pc_tp_fine      => v_tp_multa_contratual,
                                   pc_start_date   => v_activ_date);
      FETCH c_fine_exception_config
         INTO rec_fine_exception_config;
      CLOSE c_fine_exception_config;

      -- se encontrou excecao processa multa
      IF rec_fine_exception_config.tp_fine IS NOT NULL THEN
         IF rec_fine_exception_config.fg_apply_fine = 'N' THEN
            -- nao cobrar multa
            p_fine_value := 0;
            p_tp_fine    := rec_fine_exception_config.tp_fine;
            RETURN;
         ELSE

            -- calcula multa
            calculate_fine(p_cd_contract       => p_cd_contract,
                           p_start_date        => rec_contract.cd_activ_date,
                           p_va_fine           => rec_fine_exception_config.va_fine,
                           p_tp_validity       => rec_fine_exception_config.tp_validity,
                           p_qa_validity       => rec_fine_exception_config.qa_validity,
                           p_proportional_fine => rec_fine_exception_config.fg_proportional_fine,
                           p_fine_value        => p_fine_value,
                           p_suspension_days   => p_suspension_days,
                           p_diary_fine_value  => p_diary_fine_value,
                           p_end_date          => p_end_date,
                           p_fine_days_charged => p_fine_days_charged);

            p_tp_fine          := rec_fine_exception_config.tp_fine;
            p_total_fine_value := rec_fine_exception_config.va_fine;
            p_qa_validity_fine := rec_fine_exception_config.qa_validity;
            p_tp_validity_fine := rec_fine_exception_config.tp_validity;
            p_start_date       := rec_contract.cd_activ_date;
            RETURN;
         END IF;
      ELSE
         OPEN c_fine_config(pc_start_date => rec_contract.cd_activ_date,
                            pc_tp_fine    => v_tp_multa_contratual);
         FETCH c_fine_config
            INTO rec_fine_config;
         CLOSE c_fine_config;

         IF rec_fine_config.va_fine IS NULL THEN
            -- *** Erro ***
            -- nao encontrada configuracao de multa
            v_dt_aux := rec_contract.cd_activ_date;
            RAISE r_config_not_found;
         END IF;

         -- se nao encontrou excecao processa regra padrao de multa
         -- calcula multa
         calculate_fine(p_cd_contract       => p_cd_contract,
                        p_start_date        => rec_contract.cd_activ_date,
                        p_va_fine           => rec_fine_config.va_fine,
                        p_tp_validity       => rec_fine_config.tp_validity,
                        p_qa_validity       => rec_fine_config.qa_validity,
                        p_proportional_fine => rec_fine_config.fg_proportional_fine,
                        p_fine_value        => p_fine_value,
                        p_suspension_days   => p_suspension_days,
                        p_diary_fine_value  => p_diary_fine_value,
                        p_end_date          => p_end_date,
                        p_fine_days_charged => p_fine_days_charged);
      END IF;
      p_tp_fine          := rec_fine_config.tp_fine;
      p_total_fine_value := rec_fine_config.va_fine;
      p_qa_validity_fine := rec_fine_config.qa_validity;
      p_tp_validity_fine := rec_fine_config.tp_validity;
      p_start_date       := rec_contract.cd_activ_date;
      RETURN;
   EXCEPTION
      WHEN r_config_not_found THEN
         raise_application_error(-20598,
                                 'Registro de configuracao de multa nao encontrado. Data ativacao = ' ||
                                 to_char(v_dt_aux, 'dd/mm/yyyy'));
   END get_fine;

   PROCEDURE calculate_fine(p_cd_contract       IN NUMBER,
                            p_start_date        IN DATE,
                            p_va_fine           IN NUMBER,
                            p_tp_validity       IN VARCHAR2,
                            p_qa_validity       IN NUMBER,
                            p_proportional_fine IN VARCHAR2,
                            p_fine_value        OUT NUMBER,
                            p_suspension_days   OUT NUMBER,
                            p_diary_fine_value  OUT NUMBER,
                            p_end_date          OUT DATE,
                            p_fine_days_charged OUT NUMBER) IS

      v_qt_months INTEGER;
   BEGIN

      -- obtem quntidade de meses para calculo da suspensao
      SELECT round(months_between(SYSDATE, p_start_date)) INTO v_qt_months FROM dual;

      -- obtem dias de suspensao do contrato
      p_suspension_days := ksng_contract.fsng_get_qt_dias_susp_temp(p_num_contrato => p_cd_contract,
                                                                    p_qt_meses     => v_qt_months);

      -- se nao eh pro-rata retorna o valor integral
      IF p_proportional_fine = 'N' THEN
         p_fine_value       := p_va_fine;
         p_diary_fine_value := 0;
         RETURN;
      END IF;

      --
      IF p_tp_validity = 'D' THEN
         p_end_date          := p_start_date + p_qa_validity + p_suspension_days;
         p_fine_days_charged := round(p_end_date - SYSDATE);
         p_diary_fine_value  := p_va_fine / p_qa_validity;
      ELSE
         p_end_date          := add_months(p_start_date, p_qa_validity);
         p_diary_fine_value  := p_va_fine / (p_end_date - p_start_date);
         p_end_date          := p_end_date + p_suspension_days;
         p_fine_days_charged := round(p_end_date - SYSDATE);
      END IF;

      IF p_fine_days_charged <= 0 THEN
         p_fine_days_charged := 0;
         p_fine_value        := 0;
      ELSE
         p_fine_value := round(p_fine_days_charged * p_diary_fine_value, 2);
      END IF;

   END calculate_fine;

   FUNCTION contract_active_6_months_ago(p_customer_id IN NUMBER,
                                         p_cd_contract IN NUMBER) RETURN NUMBER IS

      v_ret NUMBER;
   BEGIN
      /*************************************************************************************************
        Migração para BSCS iX - Query antiga da versão BSCS 5.23
       *************************************************************************************************
            select count(b.co_id)
              into v_ret
              from bsc.customer_all a
                  ,bsc.contract_all b
             where a.customer_id = b.customer_id
               and a.customer_id = p_customer_id
               and b.co_activated between sysdate-180 and sysdate-1
               and b.co_id      != p_cd_contract;
      **************************************************************************************************/
      bix.ksng_fine_i.psng_select_02(p_customer_id, p_cd_contract, v_ret);

      RETURN v_ret;

   END contract_active_6_months_ago;

   FUNCTION contract_stn_verify(p_cd_contract IN NUMBER,
                                p_order_date  IN DATE) RETURN BOOLEAN IS

      /*************************************************************************************************
        Migração para BSCS iX - Query antiga da versão BSCS 5.23
       *************************************************************************************************
        cursor c_stn is
          select cs_stat_chng from bsc.contr_services
           where co_id  = p_cd_contract
             and sncode in (select sncode from bsc.mpusntab where upper(des) like 'PROG LOCA%')
           order by cs_seqno;
      **************************************************************************************************/
      CURSOR c_stn IS
         SELECT cs_stat_chng FROM TABLE(bix.ksng_fine_i.fsng_select_03(p_cd_contract));

      v_cs_stat_chng VARCHAR2(4000);
      v_data_1       DATE;
      v_data_2       DATE;
      v_aux          NUMBER;
   BEGIN
      OPEN c_stn;
      LOOP
         FETCH c_stn
            INTO v_cs_stat_chng;
         EXIT WHEN c_stn%NOTFOUND;
         extract_stn_dates(v_cs_stat_chng, v_data_1, v_data_2);

         BEGIN
            SELECT 1 INTO v_aux FROM dual WHERE p_order_date BETWEEN v_data_1 AND v_data_2;
         EXCEPTION
            WHEN OTHERS THEN
               NULL;
         END;

         IF v_aux IS NOT NULL THEN
            EXIT;
         END IF;
      END LOOP;
      CLOSE c_stn;
      IF v_aux IS NOT NULL THEN
         RETURN TRUE;
      ELSE
         RETURN FALSE;
      END IF;
   EXCEPTION
      WHEN OTHERS THEN
         IF c_stn%ISOPEN THEN
            CLOSE c_stn;
         END IF;
         RETURN FALSE;
   END;

   PROCEDURE extract_stn_dates(p_str  IN VARCHAR2,
                               p_dt_1 OUT DATE,
                               p_dt_2 OUT DATE) IS

      i       INTEGER := 1;
      j       INTEGER := 1;
      l       INTEGER := 0;
      v_1     VARCHAR2(10);
      v_2     VARCHAR2(10);
      v_act_1 VARCHAR2(1);
      v_act_2 VARCHAR2(1);

   BEGIN

      IF p_str IS NULL THEN
         RETURN;
      END IF;

      l := length(p_str);

      IF l <= 7 THEN
         v_act_1 := substr(p_str, 7, 1);
         v_1     := substr(p_str, 1, 6);
         IF v_act_1 = 'd' THEN
            p_dt_1 := to_date(v_1, 'rrmmdd');
            p_dt_2 := to_date(v_1, 'rrmmdd');
         ELSE
            p_dt_1 := to_date(v_1, 'rrmmdd');
            p_dt_2 := trunc(SYSDATE);
         END IF;
         RETURN;
      END IF;

      LOOP
         EXIT WHEN i = 0;
         i := instr(p_str, '|', j);

         IF j = 1 THEN
            IF i != 0 THEN
               v_1     := substr(p_str, j, i - j - 1);
               v_act_1 := substr(p_str, j + 6, 1);
            ELSE
               v_1 := substr(p_str, j, l - j);
            END IF;
         END IF;

         IF i = 0 THEN
            v_2     := substr(p_str, j, l - j);
            v_act_2 := substr(p_str, j + 6, 1);
         END IF;

         j := i + 1;
      END LOOP;

      IF v_1 IS NOT NULL THEN
         p_dt_1 := to_date(v_1, 'rrmmdd');
      END IF;

      IF v_2 IS NOT NULL THEN
         IF v_act_2 = 'd' THEN
            p_dt_2 := to_date(v_2, 'rrmmdd');
         ELSE
            p_dt_2 := trunc(SYSDATE);
         END IF;

         IF p_dt_1 IS NULL THEN
            p_dt_1 := p_dt_2;
         END IF;
      END IF;

   EXCEPTION
      WHEN OTHERS THEN
         p_dt_1 := NULL;
         p_dt_2 := NULL;

   END extract_stn_dates;

   FUNCTION get_take_over(p_cd_contract IN NUMBER

                          ) RETURN DATE IS

      v_active_date    DATE := NULL;
      v_new_subscriber VARCHAR2(100);
      v_id_family_new  NUMBER;
      v_id_family_old  NUMBER;
      v_str            VARCHAR2(4000);

      v_custcode         VARCHAR2(100);
      v_cs_activ_date    DATE;
      v_long_description VARCHAR2(500);
      c1                 t_cursor;
   BEGIN

      /*************************************************************************************************
        Migração para BSCS iX - Query antiga da versão BSCS 5.23
       *************************************************************************************************
             v_str := 'select ca.custcode ' ||
                      '       ,trunc(cs.cs_activ_date) cs_activ_date ' ||
                      '       ,tr.long_description ' ||
                      '  from (select a.co_id ' ||
                      '              ,a.long_description ' ||
                      '          from bsc.tickler_records a ' ||
                      '              ,bsc.contr_services  b ' ||
                      '              ,bsc.contr_services  c ' ||
                      '         where upper(a.short_description) = ''CO TAKEOVER FROM''' ||
                      '           and a.co_id             = b.co_id ' ||
                      '           and b.dn_id             = c.dn_id  ' ||
                      '           and c.co_id             = ' || p_cd_contract ||
                      '           and c.dn_id            is not null) tr,  ' ||
                      '        bsc.customer_all ca, ' ||
                      '        bsc.contract_all co, ' ||
                      '        bsc.contr_services cs ' ||
                      '  where cs.dn_id in (select dn_id ' ||
                      '                       from bsc.contr_services ' ||
                      '                      where co_id = ' || p_cd_contract ||
                      '                        and dn_id is not null) ' ||
                      '    and co.co_id       = cs.co_id ' ||
                      '    and ca.customer_id = co.customer_id ' ||
                      '    and co.co_id       = tr.co_id ' ||
                      '  order by cs_activ_date desc ';
      **************************************************************************************************/
      v_str := ' select distinct ' || '        custcode ' ||
               '       ,trunc(cd_activ_date) cs_activ_date ' ||
               '       ,replace(replace(long_description,chr(10),'' ''),chr(13),'' '') long_description ' ||
               '   from table(bix.ksng_fine_i.fsng_select_04(' || p_cd_contract || '))';

      OPEN c1 FOR v_str;
      LOOP
         FETCH c1
            INTO v_custcode,
                 v_cs_activ_date,
                 v_long_description;

         EXIT WHEN c1%NOTFOUND;

         -- get new subscriber
         v_new_subscriber := get_subscriber_take_over(v_long_description);
         v_id_family_new  := get_customer_family(v_new_subscriber);

         IF v_id_family_new IS NULL THEN
            CLOSE c1;
            RETURN NULL;
         END IF;

         v_id_family_old := get_customer_family(v_custcode);

         IF v_id_family_new != v_id_family_old THEN
            v_active_date := v_cs_activ_date;
            EXIT;
         END IF;


DBMS_METADATA.GET_DDL('PACKAGE','KSNG_FINE_I','SNG')
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
      END LOOP;
      CLOSE c1;

      RETURN v_active_date;

   END get_take_over;

   FUNCTION get_subscriber_take_over(p_str_take_over IN VARCHAR2) RETURN VARCHAR2 IS

      i                 INTEGER;
      s                 VARCHAR2(1);
      v_cd_customer_new VARCHAR2(100);
      -- exemple of string
      --'Subscription :  2043008 -->
      --Subscriber :  5.11904.10.00.100000
      --Subscription :  2119685';

   BEGIN
      -- extract new subscriber from the string
      i := instr(p_str_take_over, 'Subscriber');

      i := i + 10;

      LOOP
         s := substr(p_str_take_over, i, 1);
         i := i + 1;
         EXIT WHEN is_number(s) OR s IS NULL;
      END LOOP;
      v_cd_customer_new := s;

      LOOP
         s                 := substr(p_str_take_over, i, 1);
         i                 := i + 1;
         v_cd_customer_new := v_cd_customer_new || s;
         EXIT WHEN NOT is_number(s) OR s IS NULL;
      END LOOP;

      RETURN TRIM(v_cd_customer_new);

   END get_subscriber_take_over;

   FUNCTION get_customer_family(p_cd_customer IN VARCHAR2) RETURN NUMBER IS

      CURSOR c IS
         SELECT id_customer_family
           FROM tbgn_customer_main a,
                tbgn_customer      b
          WHERE a.id_customer_main = b.id_customer_main
            AND b.cd_customer = p_cd_customer;

      v_id_customer_family NUMBER;

   BEGIN
      OPEN c;
      FETCH c
         INTO v_id_customer_family;
      CLOSE c;

      RETURN v_id_customer_family;

   END get_customer_family;

   FUNCTION is_number(p_1 IN VARCHAR2) RETURN BOOLEAN IS
   BEGIN
      IF p_1 = '1' OR p_1 = '2' OR p_1 = '3' OR p_1 = '4' OR p_1 = '5' OR p_1 = '6' OR p_1 = '7' OR
         p_1 = '8' OR p_1 = '9' OR p_1 = '0' OR p_1 = '.' THEN
         RETURN TRUE;
      ELSE
         RETURN FALSE;
      END IF;
   END is_number;

   PROCEDURE get_fine_data(p_cd_contract IN number_array,
                           p_cursor      OUT t_cursor) IS

      v_cd_contract        NUMBER;
      v_cd_imei_simcard    VARCHAR2(100);
      v_cd_activ_date      DATE;
      v_cd_rate_plan       NUMBER;
      v_cd_contract_status VARCHAR2(1);

      v_tp_fine            VARCHAR2(1);
      v_total_fine_value   NUMBER;
      v_qa_validity_fine   NUMBER;
      v_tp_validity_fine   VARCHAR2(1);
      v_start_date         DATE;
      v_end_date           DATE;
      v_suspension_days    NUMBER;
      v_diary_fine_value   NUMBER;
      v_fine_value         NUMBER;
      v_fine_days_charged  NUMBER;
      v_id_ofs_fine        VARCHAR2(20);
      v_de_technology_type VARCHAR2(50) := NULL;
      v_dt_fine_loyalty    DATE;
      v_va_fine_loyalty    NUMBER;

      -- j       INTEGER := 0;
      -- str_sql VARCHAR2(32767);
      c1      t_cursor;

      v_array_contract bix.number_array := bix.number_array(NULL);

   BEGIN

      FOR i IN 1 .. p_cd_contract.count
      LOOP
         IF i <> 1 THEN
            v_array_contract.extend;
         END IF;
         v_array_contract(i) := p_cd_contract(i);
      END LOOP;

      /*22/03/12 - TS000237 - Ricardo F. de araujo
          Alterada a pipelined para retornar o id tecnologia para o cursor
      */

      -- processa cursor
      FOR c1 IN (SELECT co_id,
                        cd_sm_num,
                        cd_activ_date,
                        tmcode,
                        ch_status,
                        subm_id
                   FROM TABLE(CAST(bix.ksng_fine_i.fsng_select_05(v_array_contract) AS
                                   bix.t_tab_sng_fine)))
      LOOP
         v_cd_contract        := c1.co_id;
         v_cd_imei_simcard    := c1.cd_sm_num;
         v_cd_activ_date      := c1.cd_activ_date;
         v_cd_rate_plan       := c1.tmcode;
         v_cd_contract_status := c1.ch_status;

         -- obtem dados da multa
         sng.ksng_fine_i.get_fine(p_cd_contract       => v_cd_contract,
                                  p_tp_fine           => v_tp_fine,
                                  p_total_fine_value  => v_total_fine_value,
                                  p_qa_validity_fine  => v_qa_validity_fine,
                                  p_tp_validity_fine  => v_tp_validity_fine,
                                  p_start_date        => v_start_date,
                                  p_end_date          => v_end_date,
                                  p_suspension_days   => v_suspension_days,
                                  p_diary_fine_value  => v_diary_fine_value,
                                  p_fine_value        => v_fine_value,
                                  p_fine_days_charged => v_fine_days_charged);

         -- obtem id do boleto do OFS caso tenha sido gerado
         BEGIN
            SELECT a.id_ofs_fine
              INTO v_id_ofs_fine
              FROM tsng_fine_occurrence a
             WHERE a.cd_contract = v_cd_contract
               AND a.dt_fine_occurrence =
                   (SELECT MAX(dt_fine_occurrence)
                      FROM tsng_fine_occurrence b
                     WHERE a.cd_contract = b.cd_contract);
         EXCEPTION
            WHEN OTHERS THEN
               v_id_ofs_fine := NULL;
         END;

         --obtem a data de expiracao e valor da multa de fedelizacao
         bix.kbix_contract.pbix_get_fine_loyalty(v_cd_contract,
                                                 v_dt_fine_loyalty,
                                                 v_va_fine_loyalty);

         /*22/03/12 - TS000237 - Ricardo F. de araujo
             Retorna a descrição da tecnologia
         */
         SELECT MAX(de_technology_type)
           INTO v_de_technology_type
           FROM tsng_technology_type
          WHERE cd_technology_type_bscs = c1.subm_id;

         /*22/03/12 - TS000237 - Ricardo F. de araujo
             Inclusão do novo campo para guardar a descrição da tecnologia
         */
         INSERT INTO tsng_tmp_fine_data
            (cd_contract,
             cd_contract_status,
             dt_contract_activation,
             cd_mobile,
             cd_imei_simcard,
             cd_rate_plan,
             de_rate_plan,
             tp_fine,
             fg_proportional_fine,
             va_total_fine,
             dt_start_fine,
             dt_end_fine,
             dt_fine_calculate,
             qa_fine_validity,
             tp_fine_validity,
             qa_days_suspension,
             va_fine_daily,
             va_fine_charged,
             qa_days_charged,
             id_ofs_fine,
             de_technology_type,
             dt_fine_loyalty,
             va_fine_loyalty)
         VALUES
            (v_cd_contract,
             v_cd_contract_status,
             v_cd_activ_date,
             NULL,
             v_cd_imei_simcard,
             v_cd_rate_plan,
             NULL,
             v_tp_fine,
             NULL,
             v_total_fine_value,
             v_start_date,
             v_end_date,
             trunc(SYSDATE),
             v_qa_validity_fine,
             v_tp_validity_fine,
             v_suspension_days,
             v_diary_fine_value,
             v_fine_value,
             v_fine_days_charged,
             v_id_ofs_fine,
             v_de_technology_type,
             v_dt_fine_loyalty,
             v_va_fine_loyalty);
      END LOOP;
      --    CLOSE c1;

      -- obtem nm_rate_plan
      UPDATE tsng_tmp_fine_data a
         SET (de_rate_plan) =
             (SELECT nm_rate_plan
                FROM tsng_rate_plan b
               WHERE b.cd_rate_plan = a.cd_rate_plan
                 AND b.cd_rate_plan_version =
                     (SELECT MAX(cd_rate_plan_version)
                        FROM tsng_rate_plan z
                       WHERE z.cd_rate_plan = b.cd_rate_plan));
      -- obtem phone number
      /*************************************************************************************************
        Migração para BSCS iX - Query antiga da versão BSCS 5.23
       *************************************************************************************************
          update tsng_tmp_fine_data z
          set    (cd_mobile) =
             (select d.part_2 || ' ' || d.part_1 ddd_e_tel
              from   mbs.t006_subscriber a,
                     mbs.t221_subscriber_addressing b,
                     mbs.t004_fleet c,
                     mbs.t221_subscriber_addressing d
              where  a.subscriber_ref = b.subscriber_ref
                and  a.subscriber_ref = d.subscriber_ref
                and  b.part_1 = c.fleet_ref
                and  b.addressing_type = 2
                and  d.addressing_type = 1
                and  d.addressing_ref  = 1
                and  a.device_id       = z.cd_imei_simcard )
          where  cd_contract = z.cd_contract;
      **************************************************************************************************/
      UPDATE tsng_tmp_fine_data z
         SET (cd_mobile) = bix.ksng_fine_i.fsng_select_06(z.cd_imei_simcard)
       WHERE cd_contract = z.cd_contract;

      /*22/03/12 - TS000237 - Ricardo F. de araujo
          Inclusão do novo campo de retorno no cursor.
      */

      OPEN p_cursor FOR
         SELECT cd_contract,
                cd_contract_status,
                dt_contract_activation,
                cd_mobile,
                cd_imei_simcard,
                cd_rate_plan,
                de_rate_plan,
                decode(tp_fine,
                       'L',
                       'Fidelizacao',
                       'C',
                       'Contratual',
                       'A',
                       'Beneficio',
                       'B',
                       'Contratual',
                       NULL) AS tp_fine,
                va_total_fine,
                dt_start_fine,
                dt_end_fine,
                dt_fine_calculate,
                qa_fine_validity,
                tp_fine_validity,
                qa_days_suspension,
                va_fine_daily,
                va_fine_charged,
                qa_days_charged,
                id_ofs_fine,
                de_technology_type,
                dt_fine_loyalty,
                va_fine_loyalty
           FROM tsng_tmp_fine_data;

   END get_fine_data;

   FUNCTION get_matrix_loyalty_fine(p_modelo       IN VARCHAR2,
                                    p_cd_rate_plan IN NUMBER,
                                    p_id_rate_plan IN NUMBER) RETURN NUMBER IS

      v_va_fine      NUMBER;
      v_cd_rate_plan NUMBER;

   BEGIN
      IF p_cd_rate_plan IS NULL THEN
         SELECT cd_rate_plan
           INTO v_cd_rate_plan
           FROM tsng_rate_plan
          WHERE id_rate_plan = p_id_rate_plan;
      ELSE
         v_cd_rate_plan := p_cd_rate_plan;
      END IF;

      BEGIN
         SELECT va_fine
           INTO v_va_fine
           FROM tsng_fine_exception_config
          WHERE trunc(SYSDATE) BETWEEN dt_start_fine_exception_config AND
                nvl(dt_end_fine_exception_config, to_date('29/09/2068', 'dd/mm/yyyy'))
            AND fg_excluded_register = 'N'
            AND tp_fine = 'L'
            AND (((upper(cd_product) LIKE '%' || upper(p_modelo) || '%' AND p_modelo IS NOT NULL) OR
                 (upper(p_modelo) LIKE '%' || upper(cd_product) || '%' AND cd_product IS NOT NULL)) OR
                 (cd_rate_plan = v_cd_rate_plan));
      EXCEPTION
         WHEN OTHERS THEN
            v_va_fine := NULL;
      END;

      IF v_va_fine IS NULL THEN
         SELECT va_fine
           INTO v_va_fine
           FROM tsng_fine_config
          WHERE trunc(SYSDATE) BETWEEN dt_start_fine_config AND
                nvl(dt_end_fine_config, to_date('29/09/2068', 'dd/mm/yyyy'))
            AND tp_fine = 'L'
            AND rownum = 1;

      END IF;

      RETURN v_va_fine;
   END get_matrix_loyalty_fine;

   -- function que retorno o imei a partir do contrato
   FUNCTION get_imei_by_contract(p_cd_contract IN NUMBER) RETURN VARCHAR2 IS

      v_ret VARCHAR2(50);
   BEGIN

      /*************************************************************************************************
        Migração para BSCS iX - Query antiga da versão BSCS 5.23
       *************************************************************************************************
            select a.cd_sm_num
              into v_ret
              from bsc.contr_devices    a
             where a.cd_validfrom = (select max(s.cd_validfrom) from bsc.contr_devices s where s.co_id = a.co_id)
               and a.cd_seqno     = (select max(y.cd_seqno) from bsc.contr_devices y where y.co_id = a.co_id)
               and a.co_id        = p_cd_contract;
      **************************************************************************************************/
      bix.ksng_fine_i.psng_select_07(p_cd_contract, v_ret);

      RETURN v_ret;

   END get_imei_by_contract;

   -- function que retorna o id_rate_plan de um contrato
   FUNCTION get_id_rate_plan_by_contr(p_cd_contract IN NUMBER) RETURN NUMBER IS

      v_tm_code NUMBER;
      v_ret     NUMBER;
   BEGIN

      /*************************************************************************************************
        Migração para BSCS iX - Query antiga da versão BSCS 5.23
       *************************************************************************************************
         select c.tmcode
           into v_tm_code
           from bsc.contract_all c
          where c.co_id = p_cd_contract
            and rownum = 1;
      **************************************************************************************************/
      bix.ksng_fine_i.psng_select_08(p_cd_contract, v_tm_code);

      SELECT r.id_rate_plan
        INTO v_ret
        FROM tsng_rate_plan r
       WHERE r.cd_rate_plan = v_tm_code
         AND r.cd_rate_plan_version =
             (SELECT MAX(cd_rate_plan_version)
                FROM tsng_rate_plan z
               WHERE z.cd_rate_plan = r.cd_rate_plan);
      RETURN v_ret;
   EXCEPTION
      WHEN OTHERS THEN
         RETURN NULL;
   END get_id_rate_plan_by_contr;

   -- insere registro tabela tsng_fine_contract_event
   PROCEDURE add_fine_contract_event(p_cd_contract          IN tsng_fine_contract_event.cd_contract%TYPE,
                                     p_tp_event             IN tsng_fine_contract_event.tp_event%TYPE,
                                     p_tp_fine              IN tsng_fine_contract_event.tp_fine%TYPE,
                                     p_cd_previous_contract IN tsng_fine_contract_event.cd_previous_contract%TYPE,
                                     p_va_fine              IN tsng_fine_contract_event.va_fine%TYPE,
                                     p_tp_validity          IN tsng_fine_contract_event.tp_validity%TYPE,
                                     p_qa_validity          IN tsng_fine_contract_event.qa_validity%TYPE,
                                     p_fg_proportional_fine IN tsng_fine_contract_event.fg_proportional_fine%TYPE) IS

      v_valorsegundo NUMBER := (((1 / 24) / 60) / 60);
      v_dt_event     DATE := SYSDATE;

   BEGIN
      WHILE TRUE
      LOOP
         BEGIN
            -- caso ocorra erro chave duplicada
            -- incrementa variavel data e tenta novamente
            INSERT INTO tsng_fine_contract_event
               (cd_contract,
                tp_event,
                tp_fine,
                dt_event,
                cd_previous_contract,
                va_fine,
                tp_validity,
                qa_validity,
                fg_proportional_fine)
            VALUES
               (p_cd_contract,
                p_tp_event,
                p_tp_fine,
                v_dt_event,
                p_cd_previous_contract,
                p_va_fine,
                p_tp_validity,
                p_qa_validity,
                p_fg_proportional_fine);
            EXIT;
         EXCEPTION
            WHEN dup_val_on_index THEN
               v_dt_event := v_dt_event + v_valorsegundo;
         END;
      END LOOP;

   EXCEPTION
      WHEN OTHERS THEN
         raise_application_error(-20007, SQLERRM);
   END add_fine_contract_event;
END ksng_fine_i;


1 linha selecionada.

20:19:41 U2NXTL01.IT_PNET3>
20:19:41 U2NXTL01.IT_PNET3>
20:19:41 U2NXTL01.IT_PNET3>
20:19:41 U2NXTL01.IT_PNET3>SPOOL OFF;
