CREATE OR REPLACE PACKAGE KPIAPL.KKPI_KPICB IS

   ----------------------------------------------------------------------------------------------------------------------------
   -- CRIAÇÃO:    ELIANE BALESTRA
   -- DATA:       26/10/2012
   -- OBJETIVO:   Processos que serão chamados pelo front-end do KPI, e gravarão os dados do KPICB
   ----------------------------------------------------------------------------------------------------------------------------
   -- ALTERAÇÃO:  ROGERIO IAQUINTO
   -- DATA:       24/07/2013
   -- OBJETIVO:   ALTERAÇÃO DA PKPI_SMP1 ATÉ A SMP14 - ADICIONADO A TABELA DE CNs
   --             E ADICIONADO O TYPE PARA RANGE DE DATAS ESPECIFICAS.
   ----------------------------------------------------------------------------------------------------------------------------
   -- ALTERAÇÃO:  ROGERIO IAQUINTO
   -- DATA:       06/08/2013
   -- OBJETIVO:   ALTERAÇÃO DA PKPI_PARAMETER - NÃO EXECUTAVA UPDATE DE VA_PARAMETER
   ----------------------------------------------------------------------------------------------------------------------------

   -- Procedure para associação de usuários X indicadores
   PROCEDURE pkpi_user_indicator(p_user_id      IN VARCHAR2,
                                 p_indicator_id IN VARCHAR2,
                                 p_retorno      OUT VARCHAR2);

   -- Procedure para manutenção de Parâmetros
   PROCEDURE pkpi_parameter(p_parameter_id          IN NUMBER,
                            p_parameter_description IN VARCHAR2,
                            p_parameter_value       IN VARCHAR2,
                            p_user_id               IN VARCHAR2,
                            p_retorno               OUT VARCHAR2);

   -- Procedure para Exclusão de Parâmetros
   PROCEDURE pkpi_delete_parameter(p_parameter_id IN NUMBER,
                                   p_retorno      OUT VARCHAR2);

   -- Procedure para manutenção de métricas
   PROCEDURE pkpi_metric(p_metric_type          IN VARCHAR2,
                         p_indicator_id         IN VARCHAR2,
                         p_metric_inicial_value IN NUMBER,
                         p_metric_final_value   IN NUMBER,
                         p_valid_inicial_date   IN DATE,
                         p_valid_final_date     IN DATE,
                         p_status_metric_id     IN NUMBER,
                         p_user_id              IN VARCHAR2,
                         p_retorno              OUT VARCHAR2);

   -- Procedure para guardar histórico de usuários X ações X indicadores
   PROCEDURE pkpi_history_action(p_user_id      IN VARCHAR2,
                                 p_action_id    IN NUMBER,
                                 p_indicator_id IN VARCHAR2,
                                 p_retorno      OUT VARCHAR2);

   -- Função para verificar se o indicador pode ser aprovado para o período
   FUNCTION fkpi_check_approvation(p_indicator_id   IN VARCHAR2,
                                   p_reference_date IN VARCHAR2) RETURN VARCHAR2;

   -- Função para verificar se é possível a retificação
   FUNCTION fkpi_check_correct(p_reference_date IN VARCHAR2) RETURN VARCHAR2;

   -- Procedure para aprovação de indicadores
   PROCEDURE pkpi_indicator_approved(p_indicator_id           IN VARCHAR2,
                                     p_reference_date         IN VARCHAR2,
                                     p_approved_user          IN VARCHAR2,
                                     p_approved_percent_value IN NUMBER,
                                     p_metric_inicial_value   IN NUMBER,
                                     p_metric_final_value     IN NUMBER,
                                     p_metric_status_approved IN VARCHAR2,
                                     p_metric_goal_value      IN NUMBER,
                                     p_retorno                OUT VARCHAR2);

   -- Procedure para gerar o indicador SMP1
   PROCEDURE pkpi_smp1(p_reference_date IN VARCHAR2,
                       p_user_id        IN VARCHAR2,
                       p_retorno        OUT VARCHAR2);

   -- Procedure para gerar o indicador SMP2
   PROCEDURE pkpi_smp2(p_reference_date IN VARCHAR2,
                       p_varchar_array  IN kpi.varchar_array,
                       p_user_id        IN VARCHAR2,
                       p_retorno        OUT VARCHAR2);

   -- Procedure para gerar o indicador SMP3
   PROCEDURE pkpi_smp3(p_reference_date IN VARCHAR2,
                       p_varchar_array  IN kpi.varchar_array,
                       p_user_id        IN VARCHAR2,
                       p_retorno        OUT VARCHAR2);

   -- Procedure para gerar o indicador SMP4
   PROCEDURE pkpi_smp4(p_reference_date IN VARCHAR2,
                       p_varchar_array  IN kpi.varchar_array,
                       p_user_id        IN VARCHAR2,
                       p_retorno        OUT VARCHAR2);

   -- Procedure para gerar o indicador SMP5
   PROCEDURE pkpi_smp5(p_reference_date IN VARCHAR2,
                       p_varchar_array  IN kpi.varchar_array,
                       p_user_id        IN VARCHAR2,
                       p_retorno        OUT VARCHAR2);

   -- Procedure para gerar o indicador SMP6
   PROCEDURE pkpi_smp6(p_reference_date IN VARCHAR2,
                       p_varchar_array  IN kpi.varchar_array,
                       p_user_id        IN VARCHAR2,
                       p_retorno        OUT VARCHAR2);

   -- Procedure para gerar o indicador SMP7
   PROCEDURE pkpi_smp7(p_reference_date IN VARCHAR2,
                       p_varchar_array  IN kpi.varchar_array,
                       p_user_id        IN VARCHAR2,
                       p_retorno        OUT VARCHAR2);

   -- Procedure para gerar o indicador SMP8
   PROCEDURE pkpi_smp8(p_reference_date IN VARCHAR2,
                       p_varchar_array  IN kpi.varchar_array,
                       p_user_id        IN VARCHAR2,
                       p_retorno        OUT VARCHAR2);

   -- Procedure para gerar o indicador SMP9
   PROCEDURE pkpi_smp9(p_reference_date IN VARCHAR2,
                       p_varchar_array  IN kpi.varchar_array,
                       p_user_id        IN VARCHAR2,
                       p_retorno        OUT VARCHAR2);

   -- Procedure para gerar o indicador SMP12
   PROCEDURE pkpi_smp12(p_reference_date IN VARCHAR2,
                        p_varchar_array  IN kpi.varchar_array,
                        p_user_id        IN VARCHAR2,
                        p_retorno        OUT VARCHAR2);

   -- Procedure para gerar o indicador SMP13
   PROCEDURE pkpi_smp13(p_reference_date IN VARCHAR2,
                        p_user_id        IN VARCHAR2,
                        p_retorno        OUT VARCHAR2);

   -- Procedure para gerar o indicador SMP14
   PROCEDURE pkpi_smp14(p_reference_date IN VARCHAR2,
                        p_varchar_array  IN kpi.varchar_array,
                        p_user_id        IN VARCHAR2,
                        p_retorno        OUT VARCHAR2);

   -- Procedure para gerar todos os indicadores para envio
   PROCEDURE pkpi_save_to_send(p_reference_date IN VARCHAR2,
                               p_varchar_array  IN kpi.varchar_array,
                               p_user_id        IN VARCHAR2,
                               p_retorno        OUT VARCHAR2);

   -- Procedure para enviar todos os indicadores para a Anatel
   PROCEDURE pkpi_send(p_reference_date IN VARCHAR2,
                       p_user_id        IN VARCHAR2,
                       p_id_file        OUT VARCHAR2,
                       p_retorno        OUT VARCHAR2);

   -- Procedure para retificação
   PROCEDURE pkpi_correct(p_reference_date IN VARCHAR2,
                          p_retorno        OUT VARCHAR2);

END kkpi_kpicb;
/

CREATE OR REPLACE PACKAGE BODY "KPIAPL"."KKPI_KPICB" IS

   /**************************************************************************************/
   /*               Procedure para associação de usuários X indicadores                  */
   /**************************************************************************************/
   PROCEDURE pkpi_user_indicator(p_user_id      IN VARCHAR2,
                                 p_indicator_id IN VARCHAR2,
                                 p_retorno      OUT VARCHAR2) IS

      /**************************************************************************************/
      /*                                 Declaração das variáveis                           */
      /**************************************************************************************/
      v_existe_registro     NUMBER(10) := 0;
      v_cd_process_control  kpi.tkpi_process_control.cd_process_control%TYPE;
      v_process_termination kpi.tkpi_process_control.de_process_termination%TYPE;

      v_sq_process_control kpi.tkpi_process_control.sq_process_control%TYPE;
      v_process_error EXCEPTION;
      v_error_code    NUMBER(10);
      v_error_message VARCHAR2(500);

   BEGIN

      BEGIN

         /******************************************************************/
         /*    Setar variáveis para o controle de processamento do KPI     */
         /******************************************************************/

         v_cd_process_control  := 'PKPI_USER_INDICATOR';
         v_process_termination := 'OK';

         /*****************************************************************************************************************/
         /*    Gravar início do processamento na tabela de controle de processamento do kpi (KPI.TKPI_PROCESS_CONTROL)    */
         /*****************************************************************************************************************/
         kkpi_util.pkpi_start_process(v_cd_process_control, v_sq_process_control);

         kkpi_util.pkpi_update_status(v_cd_process_control,
                                      v_sq_process_control,
                                      'PROCESSING PKPI_USER_INDICATOR');

         SELECT nvl(COUNT(1), 0)
           INTO v_existe_registro
           FROM kpi.lu_kpi_user_indicator
          WHERE upper(user_id) = upper(p_user_id)
            AND indicator_id = p_indicator_id;

         IF v_existe_registro = 0 THEN

            BEGIN
               INSERT INTO kpi.lu_kpi_user_indicator
                  (user_id,
                   indicator_id)
               VALUES
                  (upper(p_user_id),
                   p_indicator_id);
            EXCEPTION
               WHEN OTHERS THEN
                  /***************************************************************************************************/
                  /*    Gravar o erro na tabela de controle de erros de processamento do kpi (TKPI_PROCESS_ERROR)    */
                  /***************************************************************************************************/
                  v_process_termination := 'NOT OK';
                  v_error_code          := SQLCODE;
                  v_error_message       := SQLERRM || ' # ID_USER = ' || upper(p_user_id) ||
                                           ' # ID_INDICATOR = ' || p_indicator_id;
                  kkpi_util.pkpi_error(v_cd_process_control,
                                       v_sq_process_control,
                                       v_error_code,
                                       v_error_message,
                                       'N');
            END;

         ELSE

            BEGIN
               DELETE kpi.lu_kpi_user_indicator
                WHERE upper(user_id) = upper(p_user_id)
                  AND indicator_id = p_indicator_id;
            EXCEPTION
               WHEN OTHERS THEN
                  /***************************************************************************************************/
                  /*    Gravar o erro na tabela de controle de erros de processamento do kpi (TKPI_PROCESS_ERROR)    */
                  /***************************************************************************************************/
                  v_process_termination := 'NOT OK';
                  v_error_code          := SQLCODE;
                  v_error_message       := SQLERRM || ' # ID_USER = ' || upper(p_user_id) ||
                                           ' # ID_INDICATOR = ' || p_indicator_id;
                  kkpi_util.pkpi_error(v_cd_process_control,
                                       v_sq_process_control,
                                       v_error_code,
                                       v_error_message,
                                       'N');
            END;

         END IF;

         /**********************************************************************************************************************/
         /*   Atualizar finalização do processamento na tabela de controle de processamento do kpi (KPI.TKPI_PROCESS_CONTROL)  */
         /**********************************************************************************************************************/
         kkpi_util.pkpi_update_status(v_cd_process_control,
                                      v_sq_process_control,
                                      'PROCESS ENDED ' || v_process_termination);

         /**************************************************************/
         /*    Verifica se o processo finalizou com erro ou sucesso    */
         /**************************************************************/
         IF v_process_termination = 'OK' THEN
            kkpi_util.pkpi_terminate_process(v_cd_process_control, v_sq_process_control, 'Y');
            p_retorno := 'E0000';
         ELSE
            kkpi_util.pkpi_terminate_process(v_cd_process_control, v_sq_process_control, 'N');
            p_retorno := v_error_message;
         END IF;
         --
      EXCEPTION
         WHEN v_process_error THEN
            /*************************************/
            /*    Registrar ABORT do processo    */
            /*************************************/
            kkpi_util.pkpi_update_status(v_cd_process_control,
                                         v_sq_process_control,
                                         'PROCESS ABORTED');
            kkpi_util.pkpi_terminate_process(v_cd_process_control, v_sq_process_control, 'X');

      END;

   END pkpi_user_indicator;

   /**************************************************************************************/
   /*                    Procedure para manutenção de parâmetros                         */
   /**************************************************************************************/
   PROCEDURE pkpi_parameter(p_parameter_id          IN NUMBER,
                            p_parameter_description IN VARCHAR2,
                            p_parameter_value       IN VARCHAR2,
                            p_user_id               IN VARCHAR2,
                            p_retorno               OUT VARCHAR2) IS

      /**************************************************************************************/
      /*                                 Declaração das variáveis                           */
      /**************************************************************************************/
      --V_CONTADOR                         NUMBER(10) := 0;
      v_cd_process_control  kpi.tkpi_process_control.cd_process_control%TYPE;
      v_process_termination kpi.tkpi_process_control.de_process_termination%TYPE;

      v_sq_process_control kpi.tkpi_process_control.sq_process_control%TYPE;
      v_process_error EXCEPTION;
      v_error_code            NUMBER(10);
      v_error_message         VARCHAR2(500);
      v_parameter_id          NUMBER; --KPI.TKPI_PARAMETER.ID_PARAMETER%TYPE;
      v_existe_nome_parametro NUMBER(10) := 0;

   BEGIN

      BEGIN

         /******************************************************************/
         /*    Setar variáveis para o controle de processamento do KPI     */
         /******************************************************************/

         v_cd_process_control  := 'PKPI_PARAMETER';
         v_process_termination := 'OK';

         /*****************************************************************************************************************/
         /*    Gravar início do processamento na tabela de controle de processamento do kpi (KPI.TKPI_PROCESS_CONTROL)    */
         /*****************************************************************************************************************/
         kkpi_util.pkpi_start_process(v_cd_process_control, v_sq_process_control);

         kkpi_util.pkpi_update_status(v_cd_process_control,
                                      v_sq_process_control,
                                      'PROCESSING PKPI_PARAMETER');

         v_parameter_id := p_parameter_id;

         IF v_parameter_id IS NULL THEN

            SELECT nvl(COUNT(1), 0)
              INTO v_existe_nome_parametro
              FROM kpi.tkpi_parameter
             WHERE upper(de_parameter) = upper(p_parameter_description);

            IF v_existe_nome_parametro <> 0 THEN
               v_process_termination := 'NOT OK';
               v_error_message       := 'PARAMETRO COM ESSE NOME JÁ EXISTE !';

            ELSE
               SELECT nvl(MAX(id_parameter), 0) + 1 INTO v_parameter_id FROM kpi.tkpi_parameter;

               BEGIN
                  INSERT INTO kpi.tkpi_parameter
                     (id_parameter,
                      de_parameter,
                      va_parameter,
                      dt_create,
                      id_user_create,
                      dt_last_modificate,
                      id_user_last_modificate)
                  VALUES
                     (v_parameter_id,
                      upper(p_parameter_description),
                      p_parameter_value,
                      SYSDATE,
                      p_user_id,
                      NULL,
                      NULL);
               EXCEPTION
                  WHEN OTHERS THEN
                     /***************************************************************************************************/
                     /*    Gravar o erro na tabela de controle de erros de processamento do kpi (TKPI_PROCESS_ERROR)    */
                     /***************************************************************************************************/
                     v_process_termination := 'NOT OK';
                     v_error_code          := SQLCODE;
                     v_error_message       := SQLERRM || ' # ID_PARAMETER = ' || v_parameter_id ||
                                              ' # DS_PARAMETER = ' ||
                                              upper(p_parameter_description) ||
                                              ' # VA_PARAMETER = ' || p_parameter_value ||
                                              ' # ID_USER = ' || p_user_id;
                     kkpi_util.pkpi_error(v_cd_process_control,
                                          v_sq_process_control,
                                          v_error_code,
                                          v_error_message,
                                          'N');
               END;
            END IF;
         ELSE

            BEGIN
               UPDATE kpi.tkpi_parameter
                  SET va_parameter            = p_parameter_value,
                      dt_last_modificate      = SYSDATE,
                      id_user_last_modificate = p_user_id
                WHERE id_parameter = v_parameter_id;

            EXCEPTION
               WHEN OTHERS THEN
                  /***************************************************************************************************/
                  /*    Gravar o erro na tabela de controle de erros de processamento do kpi (TKPI_PROCESS_ERROR)    */
                  /***************************************************************************************************/
                  v_process_termination := 'NOT OK';
                  v_error_code          := SQLCODE;
                  v_error_message       := SQLERRM || ' # ID_PARAMETER = ' || v_parameter_id ||
                                           ' # DS_PARAMETER = ' || upper(p_parameter_description) ||
                                           ' # VA_PARAMETER = ' || p_parameter_value ||
                                           ' # ID_USER = ' || p_user_id;
                  kkpi_util.pkpi_error(v_cd_process_control,
                                       v_sq_process_control,
                                       v_error_code,
                                       v_error_message,
                                       'N');
            END;

         END IF;

         /**********************************************************************************************************************/
         /*   Atualizar finalização do processamento na tabela de controle de processamento do kpi (KPI.TKPI_PROCESS_CONTROL)  */
         /**********************************************************************************************************************/
         kkpi_util.pkpi_update_status(v_cd_process_control,
                                      v_sq_process_control,
                                      'PROCESS ENDED ' || v_process_termination);

         /**************************************************************/
         /*    Verifica se o processo finalizou com erro ou sucesso    */
         /**************************************************************/
         IF v_process_termination = 'OK' THEN
            kkpi_util.pkpi_terminate_process(v_cd_process_control, v_sq_process_control, 'Y');
            p_retorno := 'E0000';
         ELSE
            kkpi_util.pkpi_terminate_process(v_cd_process_control, v_sq_process_control, 'N');
            p_retorno := v_error_message;
         END IF;
         --
      EXCEPTION
         WHEN v_process_error THEN
            /*************************************/
            /*    Registrar ABORT do processo    */
            /*************************************/
            kkpi_util.pkpi_update_status(v_cd_process_control,
                                         v_sq_process_control,
                                         'PROCESS ABORTED');
            kkpi_util.pkpi_terminate_process(v_cd_process_control, v_sq_process_control, 'X');

      END;

   END pkpi_parameter;

   /**************************************************************************************/
   /*                    Procedure para exclusão de parâmetros                           */
   /**************************************************************************************/
   PROCEDURE pkpi_delete_parameter(p_parameter_id IN NUMBER,
                                   p_retorno      OUT VARCHAR2) IS

      /**************************************************************************************/
      /*                                 Declaração das variáveis                           */
      /**************************************************************************************/
      v_cd_process_control  kpi.tkpi_process_control.cd_process_control%TYPE;
      v_process_termination kpi.tkpi_process_control.de_process_termination%TYPE;

      v_sq_process_control kpi.tkpi_process_control.sq_process_control%TYPE;
      v_process_error EXCEPTION;
      v_error_code    NUMBER(10);
      v_error_message VARCHAR2(500);

   BEGIN

      BEGIN

         /******************************************************************/
         /*    Setar variáveis para o controle de processamento do KPI     */
         /******************************************************************/

         v_cd_process_control  := 'PKPI_DELETE_PARAMETER';
         v_process_termination := 'OK';

         /*****************************************************************************************************************/
         /*    Gravar início do processamento na tabela de controle de processamento do kpi (KPI.TKPI_PROCESS_CONTROL)    */
         /*****************************************************************************************************************/
         kkpi_util.pkpi_start_process(v_cd_process_control, v_sq_process_control);

         kkpi_util.pkpi_update_status(v_cd_process_control,
                                      v_sq_process_control,
                                      'PROCESSING PKPI_DELETE_PARAMETER');

         BEGIN
            DELETE kpi.tkpi_parameter WHERE id_parameter = p_parameter_id;
         EXCEPTION
            WHEN OTHERS THEN
               /***************************************************************************************************/
               /*    Gravar o erro na tabela de controle de erros de processamento do kpi (TKPI_PROCESS_ERROR)    */
               /***************************************************************************************************/
               v_process_termination := 'NOT OK';
               v_error_code          := SQLCODE;
               v_error_message       := SQLERRM || ' # ID_PARAMETER = ' || p_parameter_id;
               kkpi_util.pkpi_error(v_cd_process_control,
                                    v_sq_process_control,
                                    v_error_code,
                                    v_error_message,
                                    'N');
         END;

         /**********************************************************************************************************************/
         /*   Atualizar finalização do processamento na tabela de controle de processamento do kpi (KPI.TKPI_PROCESS_CONTROL)  */
         /**********************************************************************************************************************/
         kkpi_util.pkpi_update_status(v_cd_process_control,
                                      v_sq_process_control,
                                      'PROCESS ENDED ' || v_process_termination);

         /**************************************************************/
         /*    Verifica se o processo finalizou com erro ou sucesso    */
         /**************************************************************/
         IF v_process_termination = 'OK' THEN
            kkpi_util.pkpi_terminate_process(v_cd_process_control, v_sq_process_control, 'Y');
            p_retorno := 'E0000';
         ELSE
            kkpi_util.pkpi_terminate_process(v_cd_process_control, v_sq_process_control, 'N');
            p_retorno := v_error_message;
         END IF;
         --
      EXCEPTION
         WHEN v_process_error THEN
            /*************************************/
            /*    Registrar ABORT do processo    */
            /*************************************/
            kkpi_util.pkpi_update_status(v_cd_process_control,
                                         v_sq_process_control,
                                         'PROCESS ABORTED');
            kkpi_util.pkpi_terminate_process(v_cd_process_control, v_sq_process_control, 'X');

      END;

   END pkpi_delete_parameter;

   /**************************************************************************************/
   /*                    Procedure para manutenção de métricas                           */
   /**************************************************************************************/
   PROCEDURE pkpi_metric(p_metric_type          IN VARCHAR2,
                         p_indicator_id         IN VARCHAR2,
                         p_metric_inicial_value IN NUMBER,
                         p_metric_final_value   IN NUMBER,
                         p_valid_inicial_date   IN DATE,
                         p_valid_final_date     IN DATE,
                         p_status_metric_id     IN NUMBER,
                         p_user_id              IN VARCHAR2,
                         p_retorno              OUT VARCHAR2) IS

      /**************************************************************************************/
      /*                                 Declaração das variáveis                           */
      /**************************************************************************************/
      --V_CONTADOR                       NUMBER(10) := 0;
      v_existe_registro     NUMBER(10) := 0;
      v_cd_process_control  kpi.tkpi_process_control.cd_process_control%TYPE;
      v_process_termination kpi.tkpi_process_control.de_process_termination%TYPE;

      v_sq_process_control kpi.tkpi_process_control.sq_process_control%TYPE;
      v_process_error EXCEPTION;
      v_error_code    NUMBER(10);
      v_error_message VARCHAR2(500);

   BEGIN

      BEGIN

         /******************************************************************/
         /*    Setar variáveis para o controle de processamento do KPI     */
         /******************************************************************/

         v_cd_process_control  := 'PKPI_METRIC';
         v_process_termination := 'OK';

         /*****************************************************************************************************************/
         /*    Gravar início do processamento na tabela de controle de processamento do kpi (KPI.TKPI_PROCESS_CONTROL)    */
         /*****************************************************************************************************************/
         kkpi_util.pkpi_start_process(v_cd_process_control, v_sq_process_control);

         kkpi_util.pkpi_update_status(v_cd_process_control,
                                      v_sq_process_control,
                                      'PROCESSING PKPI_METRIC');

         SELECT nvl(COUNT(1), 0)
           INTO v_existe_registro
           FROM kpi.lu_kpi_metric
          WHERE metric_type_id = p_metric_type
            AND indicator_id = p_indicator_id
            AND metric_inicial_value = p_metric_inicial_value
            AND metric_final_value = p_metric_final_value
            AND valid_inicial_date = p_valid_inicial_date;

         IF v_existe_registro = 0 THEN

            BEGIN
               INSERT INTO kpi.lu_kpi_metric
                  (metric_type_id,
                   indicator_id,
                   metric_inicial_value,
                   metric_final_value,
                   valid_inicial_date,
                   valid_final_date,
                   status_metric_id,
                   create_date,
                   user_create_id,
                   last_modification_date,
                   last_user_modification_id)
               VALUES
                  (p_metric_type,
                   p_indicator_id,
                   p_metric_inicial_value,
                   p_metric_final_value,
                   p_valid_inicial_date,
                   p_valid_final_date,
                   p_status_metric_id,
                   SYSDATE,
                   p_user_id,
                   NULL,
                   NULL);
            EXCEPTION
               WHEN OTHERS THEN
                  /***************************************************************************************************/
                  /*    Gravar o erro na tabela de controle de erros de processamento do kpi (TKPI_PROCESS_ERROR)    */
                  /***************************************************************************************************/
                  v_process_termination := 'NOT OK';
                  v_error_code          := SQLCODE;
                  v_error_message       := SQLERRM || ' # TP_METRIC = ' || p_metric_type ||
                                           ' # ID_INDICATOR = ' || p_indicator_id ||
                                           ' # VA_METRIC_INICIAL = ' || p_metric_inicial_value ||
                                           ' # VA_METRIC_FINAL = ' || p_metric_final_value ||
                                           ' # DT_VALID_INICIAL = ' || p_valid_inicial_date ||
                                           ' # DT_VALID_FINAL = ' || p_valid_final_date ||
                                           ' # ID_STATUS_METRIC = ' || p_status_metric_id ||
                                           ' # ID_USER_CREATE = ' || p_user_id;
                  kkpi_util.pkpi_error(v_cd_process_control,
                                       v_sq_process_control,
                                       v_error_code,
                                       v_error_message,
                                       'N');
            END;

         ELSE

            BEGIN
               UPDATE kpi.lu_kpi_metric
                  SET valid_final_date          = p_valid_final_date,
                      status_metric_id          = p_status_metric_id,
                      last_modification_date    = SYSDATE,
                      last_user_modification_id = p_user_id
                WHERE metric_type_id = p_metric_type
                  AND indicator_id = p_indicator_id
                  AND metric_inicial_value = p_metric_inicial_value
                  AND metric_final_value = p_metric_final_value
                  AND valid_inicial_date = p_valid_inicial_date;
            EXCEPTION
               WHEN OTHERS THEN
                  /***************************************************************************************************/
                  /*    Gravar o erro na tabela de controle de erros de processamento do kpi (TKPI_PROCESS_ERROR)    */
                  /***************************************************************************************************/
                  v_process_termination := 'NOT OK';
                  v_error_code          := SQLCODE;
                  v_error_message       := SQLERRM || ' # TP_METRIC = ' || p_metric_type ||
                                           ' # ID_INDICATOR = ' || p_indicator_id ||
                                           ' # VA_METRIC_INICIAL = ' || p_metric_inicial_value ||
                                           ' # VA_METRIC_FINAL = ' || p_metric_final_value ||
                                           ' # DT_VALID_INICIAL = ' || p_valid_inicial_date ||
                                           ' # DT_VALID_FINAL = ' || p_valid_final_date ||
                                           ' # ID_STATUS_METRIC = ' || p_status_metric_id ||
                                           ' # ID_USER_LAST_MODIFICATE = ' || p_user_id;
                  kkpi_util.pkpi_error(v_cd_process_control,
                                       v_sq_process_control,
                                       v_error_code,
                                       v_error_message,
                                       'N');
            END;

         END IF;

         /**********************************************************************************************************************/
         /*   Atualizar finalização do processamento na tabela de controle de processamento do kpi (KPI.TKPI_PROCESS_CONTROL)  */
         /**********************************************************************************************************************/
         kkpi_util.pkpi_update_status(v_cd_process_control,
                                      v_sq_process_control,
                                      'PROCESS ENDED ' || v_process_termination);

         /**************************************************************/
         /*    Verifica se o processo finalizou com erro ou sucesso    */
         /**************************************************************/
         IF v_process_termination = 'OK' THEN
            kkpi_util.pkpi_terminate_process(v_cd_process_control, v_sq_process_control, 'Y');
            p_retorno := 'E0000';
         ELSE
            kkpi_util.pkpi_terminate_process(v_cd_process_control, v_sq_process_control, 'N');
            p_retorno := v_error_message;
         END IF;
         --
      EXCEPTION
         WHEN v_process_error THEN
            /*************************************/
            /*    Registrar ABORT do processo    */
            /*************************************/
            kkpi_util.pkpi_update_status(v_cd_process_control,
                                         v_sq_process_control,
                                         'PROCESS ABORTED');
            kkpi_util.pkpi_terminate_process(v_cd_process_control, v_sq_process_control, 'X');

      END;

   END pkpi_metric;

   /**************************************************************************************/
   /*       Procedure para guardar histórico de usuários X ações X indicadores           */
   /**************************************************************************************/
   PROCEDURE pkpi_history_action(p_user_id      IN VARCHAR2,
                                 p_action_id    IN NUMBER,
                                 p_indicator_id IN VARCHAR2,
                                 p_retorno      OUT VARCHAR2) IS

      /**************************************************************************************/
      /*                                 Declaração das variáveis                           */
      /**************************************************************************************/
      v_cd_process_control  kpi.tkpi_process_control.cd_process_control%TYPE;
      v_process_termination kpi.tkpi_process_control.de_process_termination%TYPE;

      v_sq_process_control kpi.tkpi_process_control.sq_process_control%TYPE;
      v_process_error EXCEPTION;
      v_error_code        NUMBER(10);
      v_error_message     VARCHAR2(500);
      v_history_action_id kpi.ft_kpi_history_action.history_action_id%TYPE;

   BEGIN

      BEGIN

         /******************************************************************/
         /*    Setar variáveis para o controle de processamento do KPI     */
         /******************************************************************/

         v_cd_process_control  := 'PKPI_HISTORY_ACTION';
         v_process_termination := 'OK';

         /*****************************************************************************************************************/
         /*    Gravar início do processamento na tabela de controle de processamento do kpi (KPI.TKPI_PROCESS_CONTROL)    */
         /*****************************************************************************************************************/
         kkpi_util.pkpi_start_process(v_cd_process_control, v_sq_process_control);

         kkpi_util.pkpi_update_status(v_cd_process_control,
                                      v_sq_process_control,
                                      'PROCESSING PKPI_HISTORY_ACTION');

         BEGIN
            SELECT kpi.skpi_history_action_id.nextval INTO v_history_action_id FROM dual;
         EXCEPTION
            WHEN OTHERS THEN
               /***************************************************************************************************/
               /*    Gravar o erro na tabela de controle de erros de processamento do kpi (TKPI_PROCESS_ERROR)    */
               /***************************************************************************************************/
               v_process_termination := 'NOT OK';
               v_error_code          := SQLCODE;
               v_error_message       := SQLERRM || ' # SKPI_HISTORY_ACTION = ' ||
                                        v_history_action_id;
               kkpi_util.pkpi_error(v_cd_process_control,
                                    v_sq_process_control,
                                    v_error_code,
                                    v_error_message,
                                    'N');
         END;

         BEGIN
            INSERT INTO kpi.ft_kpi_history_action
               (history_action_id,
                user_id,
                action_id,
                indicator_id,
                action_date)
            VALUES
               (v_history_action_id,
                p_user_id,
                p_action_id,
                p_indicator_id,
                SYSDATE);
         EXCEPTION
            WHEN OTHERS THEN
               /***************************************************************************************************/
               /*    Gravar o erro na tabela de controle de erros de processamento do kpi (TKPI_PROCESS_ERROR)    */
               /***************************************************************************************************/
               v_process_termination := 'NOT OK';
               v_error_code          := SQLCODE;
               v_error_message       := SQLERRM || ' # ID_HISTORY_ACTION = ' || v_history_action_id ||
                                        ' # ID_USER = ' || p_user_id || ' # ID_ACTION = ' ||
                                        p_action_id || ' # ID_INDICATOR = ' || p_indicator_id;
               kkpi_util.pkpi_error(v_cd_process_control,
                                    v_sq_process_control,
                                    v_error_code,
                                    v_error_message,
                                    'N');
         END;

         /**********************************************************************************************************************/
         /*   Atualizar finalização do processamento na tabela de controle de processamento do kpi (KPI.TKPI_PROCESS_CONTROL)  */
         /**********************************************************************************************************************/
         kkpi_util.pkpi_update_status(v_cd_process_control,
                                      v_sq_process_control,
                                      'PROCESS ENDED ' || v_process_termination);

         /**************************************************************/
         /*    Verifica se o processo finalizou com erro ou sucesso    */
         /**************************************************************/
         IF v_process_termination = 'OK' THEN
            kkpi_util.pkpi_terminate_process(v_cd_process_control, v_sq_process_control, 'Y');
            p_retorno := 'E0000';
         ELSE
            kkpi_util.pkpi_terminate_process(v_cd_process_control, v_sq_process_control, 'N');
            p_retorno := v_error_message;
         END IF;
         --
      EXCEPTION
         WHEN v_process_error THEN
            /*************************************/
            /*    Registrar ABORT do processo    */
            /*************************************/
            kkpi_util.pkpi_update_status(v_cd_process_control,
                                         v_sq_process_control,
                                         'PROCESS ABORTED');
            kkpi_util.pkpi_terminate_process(v_cd_process_control, v_sq_process_control, 'X');

      END;

   END pkpi_history_action;

   FUNCTION fkpi_check_approvation(p_indicator_id   IN VARCHAR2,
                                   p_reference_date IN VARCHAR2) RETURN VARCHAR2 IS

      v_tot_send_anatel        NUMBER(10) := 0;
      v_tot_indicator_approved NUMBER(10) := 0;
      v_tot_smp                NUMBER(10) := 0;

   BEGIN

      SELECT nvl(COUNT(1), 0)
        INTO v_tot_send_anatel
        FROM tkpi_send_anatel
       WHERE p_reference_date BETWEEN to_char(dt_start_competence, 'YYYYMM') AND
             to_char(dt_end_competence, 'YYYYMM');

      SELECT nvl(COUNT(1), 0)
        INTO v_tot_indicator_approved
        FROM ft_kpi_indicator_approved
       WHERE indicator_id = p_indicator_id
         AND reference_date = p_reference_date;

      IF p_indicator_id = 'SMP1' THEN
         SELECT nvl(COUNT(1), 0)
           INTO v_tot_smp
           FROM kpi.ft_kpi_smp1
          WHERE indicator_id = p_indicator_id
            AND reference_date = p_reference_date;
      ELSIF p_indicator_id = 'SMP2' THEN
         SELECT nvl(COUNT(1), 0)
           INTO v_tot_smp
           FROM kpi.ft_kpi_smp2
          WHERE indicator_id = p_indicator_id
            AND reference_date = p_reference_date;
      ELSIF p_indicator_id = 'SMP3' THEN
         SELECT nvl(COUNT(1), 0)
           INTO v_tot_smp
           FROM kpi.ft_kpi_smp3
          WHERE indicator_id = p_indicator_id
            AND reference_date = p_reference_date;
      ELSIF p_indicator_id = 'SMP4' THEN
         SELECT nvl(COUNT(1), 0)
           INTO v_tot_smp
           FROM kpi.ft_kpi_smp4
          WHERE indicator_id = p_indicator_id
            AND reference_date = p_reference_date;
      ELSIF p_indicator_id = 'SMP5' THEN
         SELECT nvl(COUNT(1), 0)
           INTO v_tot_smp
           FROM kpi.ft_kpi_smp5
          WHERE indicator_id = p_indicator_id
            AND reference_date = p_reference_date;
      ELSIF p_indicator_id = 'SMP6' THEN
         SELECT nvl(COUNT(1), 0)
           INTO v_tot_smp
           FROM kpi.ft_kpi_smp6
          WHERE indicator_id = p_indicator_id
            AND reference_date = p_reference_date;
      ELSIF p_indicator_id = 'SMP7' THEN
         SELECT nvl(COUNT(1), 0)
           INTO v_tot_smp
           FROM kpi.ft_kpi_smp7
          WHERE indicator_id = p_indicator_id
            AND reference_date = p_reference_date;
      ELSIF p_indicator_id = 'SMP8' THEN
         SELECT nvl(COUNT(1), 0)
           INTO v_tot_smp
           FROM kpi.ft_kpi_smp8
          WHERE indicator_id = p_indicator_id
            AND reference_date = p_reference_date;
      ELSIF p_indicator_id = 'SMP9' THEN
         SELECT nvl(COUNT(1), 0)
           INTO v_tot_smp
           FROM kpi.ft_kpi_smp9
          WHERE indicator_id = p_indicator_id
            AND reference_date = p_reference_date;
      ELSIF p_indicator_id = 'SMP12' THEN
         SELECT nvl(COUNT(1), 0)
           INTO v_tot_smp
           FROM kpi.ft_kpi_smp12
          WHERE indicator_id = p_indicator_id
            AND reference_date = p_reference_date;
      ELSIF p_indicator_id = 'SMP13' THEN
         SELECT nvl(COUNT(1), 0)
           INTO v_tot_smp
           FROM kpi.ft_kpi_smp13
          WHERE indicator_id = p_indicator_id
            AND reference_date = p_reference_date;
      ELSIF p_indicator_id = 'SMP14' THEN
         SELECT nvl(COUNT(1), 0)
           INTO v_tot_smp
           FROM kpi.ft_kpi_smp14
          WHERE indicator_id = p_indicator_id
            AND reference_date = p_reference_date;
      END IF;

      IF v_tot_send_anatel = 0 OR (v_tot_send_anatel <> 0 AND v_tot_indicator_approved = 0) OR
         (v_tot_send_anatel <> 0 AND v_tot_smp = 0) THEN
         RETURN('OK');
      ELSE
         RETURN('NOT OK');
      END IF;

   END fkpi_check_approvation;

   FUNCTION fkpi_check_correct(p_reference_date IN VARCHAR2) RETURN VARCHAR2 IS

      v_tot_send_anatel        NUMBER(10) := 0;
      v_tot_indicator_approved NUMBER(10) := 0;
      v_tot_smp1               NUMBER(10) := 0;
      v_tot_smp2               NUMBER(10) := 0;
      v_tot_smp3               NUMBER(10) := 0;
      v_tot_smp4               NUMBER(10) := 0;
      v_tot_smp5               NUMBER(10) := 0;
      v_tot_smp6               NUMBER(10) := 0;
      v_tot_smp7               NUMBER(10) := 0;
      v_tot_smp8               NUMBER(10) := 0;
      v_tot_smp9               NUMBER(10) := 0;
      v_tot_smp12              NUMBER(10) := 0;
      v_tot_smp13              NUMBER(10) := 0;
      v_tot_smp14              NUMBER(10) := 0;
      v_indicator_id           kpi.ft_kpi_indicator_approved.indicator_id%TYPE;

   BEGIN

      SELECT nvl(COUNT(1), 0)
        INTO v_tot_send_anatel
        FROM tkpi_send_anatel
       WHERE p_reference_date BETWEEN to_char(dt_start_competence, 'YYYYMM') AND
             to_char(dt_end_competence, 'YYYYMM');

      FOR i IN 1 .. 14
      LOOP

         v_indicator_id           := 'SMP' || i;
         v_tot_indicator_approved := 0;

         IF v_indicator_id NOT IN ('SMP10', 'SMP11') THEN

            SELECT nvl(COUNT(1), 0)
              INTO v_tot_indicator_approved
              FROM ft_kpi_indicator_approved
             WHERE indicator_id = v_indicator_id
               AND reference_date = p_reference_date;

            IF v_tot_indicator_approved = 0 THEN
               EXIT;
               RETURN('NOT OK');
            END IF;

         END IF;

      END LOOP;

      SELECT nvl(COUNT(1), 0)
        INTO v_tot_smp1
        FROM kpi.ft_kpi_smp1
       WHERE indicator_id = 'SMP1'
         AND reference_date = p_reference_date;

      SELECT nvl(COUNT(1), 0)
        INTO v_tot_smp2
        FROM kpi.ft_kpi_smp2
       WHERE indicator_id = 'SMP2'
         AND reference_date = p_reference_date;

      SELECT nvl(COUNT(1), 0)
        INTO v_tot_smp3
        FROM kpi.ft_kpi_smp3
       WHERE indicator_id = 'SMP3'
         AND reference_date = p_reference_date;

      SELECT nvl(COUNT(1), 0)
        INTO v_tot_smp4
        FROM kpi.ft_kpi_smp4
       WHERE indicator_id = 'SMP4'
         AND reference_date = p_reference_date;

      SELECT nvl(COUNT(1), 0)
        INTO v_tot_smp5
        FROM kpi.ft_kpi_smp5
       WHERE indicator_id = 'SMP5'
         AND reference_date = p_reference_date;

      SELECT nvl(COUNT(1), 0)
        INTO v_tot_smp6
        FROM kpi.ft_kpi_smp6
       WHERE indicator_id = 'SMP6'
         AND reference_date = p_reference_date;

      SELECT nvl(COUNT(1), 0)
        INTO v_tot_smp7
        FROM kpi.ft_kpi_smp7
       WHERE indicator_id = 'SMP7'
         AND reference_date = p_reference_date;

      SELECT nvl(COUNT(1), 0)
        INTO v_tot_smp8
        FROM kpi.ft_kpi_smp8
       WHERE indicator_id = 'SMP8'
         AND reference_date = p_reference_date;

      SELECT nvl(COUNT(1), 0)
        INTO v_tot_smp9
        FROM kpi.ft_kpi_smp9
       WHERE indicator_id = 'SMP9'
         AND reference_date = p_reference_date;

      SELECT nvl(COUNT(1), 0)
        INTO v_tot_smp12
        FROM kpi.ft_kpi_smp12
       WHERE indicator_id = 'SMP12'
         AND reference_date = p_reference_date;

      SELECT nvl(COUNT(1), 0)
        INTO v_tot_smp13
        FROM kpi.ft_kpi_smp13
       WHERE indicator_id = 'SMP13'
         AND reference_date = p_reference_date;

      SELECT nvl(COUNT(1), 0)
        INTO v_tot_smp14
        FROM kpi.ft_kpi_smp14
       WHERE indicator_id = 'SMP14'
         AND reference_date = p_reference_date;

      IF v_tot_send_anatel <> 0 AND v_tot_indicator_approved <> 0 AND v_tot_smp1 <> 0 AND
         v_tot_smp2 <> 0 AND v_tot_smp3 <> 0 AND v_tot_smp4 <> 0 AND v_tot_smp5 <> 0 AND
         v_tot_smp6 <> 0 AND v_tot_smp7 <> 0 AND v_tot_smp8 <> 0 AND v_tot_smp9 <> 0 AND
         v_tot_smp12 <> 0 AND v_tot_smp13 <> 0 AND v_tot_smp14 <> 0 THEN
         RETURN('OK');
      ELSE
         RETURN('NOT OK');
      END IF;

   END fkpi_check_correct;

   /**************************************************************************************/
   /*                    Procedure para aprovação de indicadores                         */
   /**************************************************************************************/
   PROCEDURE pkpi_indicator_approved(p_indicator_id           IN VARCHAR2,
                                     p_reference_date         IN VARCHAR2,
                                     p_approved_user          IN VARCHAR2,
                                     p_approved_percent_value IN NUMBER,
                                     p_metric_inicial_value   IN NUMBER,
                                     p_metric_final_value     IN NUMBER,
                                     p_metric_status_approved IN VARCHAR2,
                                     p_metric_goal_value      IN NUMBER,
                                     p_retorno                OUT VARCHAR2) IS

      /**************************************************************************************/
      /*                                 Declaração das variáveis                           */
      /**************************************************************************************/
      --V_CONTADOR                         NUMBER(10) := 0;
      v_existe_registro     NUMBER(10) := 0;
      v_cd_process_control  kpi.tkpi_process_control.cd_process_control%TYPE;
      v_process_termination kpi.tkpi_process_control.de_process_termination%TYPE;

      v_sq_process_control kpi.tkpi_process_control.sq_process_control%TYPE;
      v_process_error EXCEPTION;
      v_error_code                 NUMBER(10);
      v_error_message              VARCHAR2(500);
      v_hist_indicator_approved_id kpi.ft_kpi_hist_indicator_approved.hist_indicator_approved_id%TYPE;

   BEGIN

      BEGIN

         /******************************************************************/
         /*    Setar variáveis para o controle de processamento do KPI     */
         /******************************************************************/

         v_cd_process_control  := 'PKPI_INDICATOR_APPROVED';
         v_process_termination := 'OK';

         /*****************************************************************************************************************/
         /*    Gravar início do processamento na tabela de controle de processamento do kpi (KPI.TKPI_PROCESS_CONTROL)    */
         /*****************************************************************************************************************/
         kkpi_util.pkpi_start_process(v_cd_process_control, v_sq_process_control);

         kkpi_util.pkpi_update_status(v_cd_process_control,
                                      v_sq_process_control,
                                      'PROCESSING PKPI_INDICATOR_APPROVED');

         --IF P_INDICATOR_ID = 'SMP1' THEN

         BEGIN
            DELETE kpi.ft_kpi_smp1
             WHERE indicator_id = p_indicator_id
               AND reference_date = p_reference_date;
         EXCEPTION
            WHEN OTHERS THEN
               /***************************************************************************************************/
               /*    Gravar o erro na tabela de controle de erros de processamento do kpi (TKPI_PROCESS_ERROR)    */
               /***************************************************************************************************/
               v_process_termination := 'NOT OK';
               v_error_code          := SQLCODE;
               v_error_message       := SQLERRM || ' # INDICATOR_ID = ' || p_indicator_id ||
                                        ' # REFERENCE_DATE = ' || p_reference_date;
               kkpi_util.pkpi_error(v_cd_process_control,
                                    v_sq_process_control,
                                    v_error_code,
                                    v_error_message,
                                    'N');
         END;

         --ELSIF P_INDICATOR_ID = 'SMP2' THEN

         BEGIN
            DELETE kpi.ft_kpi_smp2
             WHERE indicator_id = p_indicator_id
               AND reference_date = p_reference_date;
         EXCEPTION
            WHEN OTHERS THEN
               /***************************************************************************************************/
               /*    Gravar o erro na tabela de controle de erros de processamento do kpi (TKPI_PROCESS_ERROR)    */
               /***************************************************************************************************/
               v_process_termination := 'NOT OK';
               v_error_code          := SQLCODE;
               v_error_message       := SQLERRM || ' # INDICATOR_ID = ' || p_indicator_id ||
                                        ' # REFERENCE_DATE = ' || p_reference_date;
               kkpi_util.pkpi_error(v_cd_process_control,
                                    v_sq_process_control,
                                    v_error_code,
                                    v_error_message,
                                    'N');
         END;

         --ELSIF P_INDICATOR_ID = 'SMP3' THEN

         BEGIN
            DELETE kpi.ft_kpi_smp3
             WHERE indicator_id = p_indicator_id
               AND reference_date = p_reference_date;
         EXCEPTION
            WHEN OTHERS THEN
               /***************************************************************************************************/
               /*    Gravar o erro na tabela de controle de erros de processamento do kpi (TKPI_PROCESS_ERROR)    */
               /***************************************************************************************************/
               v_process_termination := 'NOT OK';
               v_error_code          := SQLCODE;
               v_error_message       := SQLERRM || ' # INDICATOR_ID = ' || p_indicator_id ||
                                        ' # REFERENCE_DATE = ' || p_reference_date;
               kkpi_util.pkpi_error(v_cd_process_control,
                                    v_sq_process_control,
                                    v_error_code,
                                    v_error_message,
                                    'N');
         END;

         --ELSIF P_INDICATOR_ID = 'SMP4' THEN

         BEGIN
            DELETE kpi.ft_kpi_smp4
             WHERE indicator_id = p_indicator_id
               AND reference_date = p_reference_date;
         EXCEPTION
            WHEN OTHERS THEN
               /***************************************************************************************************/
               /*    Gravar o erro na tabela de controle de erros de processamento do kpi (TKPI_PROCESS_ERROR)    */
               /***************************************************************************************************/
               v_process_termination := 'NOT OK';
               v_error_code          := SQLCODE;
               v_error_message       := SQLERRM || ' # INDICATOR_ID = ' || p_indicator_id ||
                                        ' # REFERENCE_DATE = ' || p_reference_date;
               kkpi_util.pkpi_error(v_cd_process_control,
                                    v_sq_process_control,
                                    v_error_code,
                                    v_error_message,
                                    'N');
         END;

         --ELSIF P_INDICATOR_ID = 'SMP5' THEN

         BEGIN
            DELETE kpi.ft_kpi_smp5
             WHERE indicator_id = p_indicator_id
               AND reference_date = p_reference_date;
         EXCEPTION
            WHEN OTHERS THEN
               /***************************************************************************************************/
               /*    Gravar o erro na tabela de controle de erros de processamento do kpi (TKPI_PROCESS_ERROR)    */
               /***************************************************************************************************/
               v_process_termination := 'NOT OK';
               v_error_code          := SQLCODE;
               v_error_message       := SQLERRM || ' # INDICATOR_ID = ' || p_indicator_id ||
                                        ' # REFERENCE_DATE = ' || p_reference_date;
               kkpi_util.pkpi_error(v_cd_process_control,
                                    v_sq_process_control,
                                    v_error_code,
                                    v_error_message,
                                    'N');
         END;

         --ELSIF P_INDICATOR_ID = 'SMP6' THEN

         BEGIN
            DELETE kpi.ft_kpi_smp6
             WHERE indicator_id = p_indicator_id
               AND reference_date = p_reference_date;
         EXCEPTION
            WHEN OTHERS THEN
               /***************************************************************************************************/
               /*    Gravar o erro na tabela de controle de erros de processamento do kpi (TKPI_PROCESS_ERROR)    */
               /***************************************************************************************************/
               v_process_termination := 'NOT OK';
               v_error_code          := SQLCODE;
               v_error_message       := SQLERRM || ' # INDICATOR_ID = ' || p_indicator_id ||
                                        ' # REFERENCE_DATE = ' || p_reference_date;
               kkpi_util.pkpi_error(v_cd_process_control,
                                    v_sq_process_control,
                                    v_error_code,
                                    v_error_message,
                                    'N');
         END;

         --ELSIF P_INDICATOR_ID = 'SMP7' THEN

         BEGIN
            DELETE kpi.ft_kpi_smp7
             WHERE indicator_id = p_indicator_id
               AND reference_date = p_reference_date;
         EXCEPTION
            WHEN OTHERS THEN
               /***************************************************************************************************/
               /*    Gravar o erro na tabela de controle de erros de processamento do kpi (TKPI_PROCESS_ERROR)    */
               /***************************************************************************************************/
               v_process_termination := 'NOT OK';
               v_error_code          := SQLCODE;
               v_error_message       := SQLERRM || ' # INDICATOR_ID = ' || p_indicator_id ||
                                        ' # REFERENCE_DATE = ' || p_reference_date;
               kkpi_util.pkpi_error(v_cd_process_control,
                                    v_sq_process_control,
                                    v_error_code,
                                    v_error_message,
                                    'N');
         END;

         --ELSIF P_INDICATOR_ID = 'SMP8' THEN

         BEGIN
            DELETE kpi.ft_kpi_smp8
             WHERE indicator_id = p_indicator_id
               AND reference_date = p_reference_date;
         EXCEPTION
            WHEN OTHERS THEN
               /***************************************************************************************************/
               /*    Gravar o erro na tabela de controle de erros de processamento do kpi (TKPI_PROCESS_ERROR)    */
               /***************************************************************************************************/
               v_process_termination := 'NOT OK';
               v_error_code          := SQLCODE;
               v_error_message       := SQLERRM || ' # INDICATOR_ID = ' || p_indicator_id ||
                                        ' # REFERENCE_DATE = ' || p_reference_date;
               kkpi_util.pkpi_error(v_cd_process_control,
                                    v_sq_process_control,
                                    v_error_code,
                                    v_error_message,
                                    'N');
         END;

         --ELSIF P_INDICATOR_ID = 'SMP9' THEN

         BEGIN
            DELETE kpi.ft_kpi_smp9
             WHERE indicator_id = p_indicator_id
               AND reference_date = p_reference_date;
         EXCEPTION
            WHEN OTHERS THEN
               /***************************************************************************************************/
               /*    Gravar o erro na tabela de controle de erros de processamento do kpi (TKPI_PROCESS_ERROR)    */
               /***************************************************************************************************/
               v_process_termination := 'NOT OK';
               v_error_code          := SQLCODE;
               v_error_message       := SQLERRM || ' # INDICATOR_ID = ' || p_indicator_id ||
                                        ' # REFERENCE_DATE = ' || p_reference_date;
               kkpi_util.pkpi_error(v_cd_process_control,
                                    v_sq_process_control,
                                    v_error_code,
                                    v_error_message,
                                    'N');
         END;

         --ELSIF P_INDICATOR_ID = 'SMP12' THEN

         BEGIN
            DELETE kpi.ft_kpi_smp12
             WHERE indicator_id = p_indicator_id
               AND reference_date = p_reference_date;
         EXCEPTION
            WHEN OTHERS THEN
               /***************************************************************************************************/
               /*    Gravar o erro na tabela de controle de erros de processamento do kpi (TKPI_PROCESS_ERROR)    */
               /***************************************************************************************************/
               v_process_termination := 'NOT OK';
               v_error_code          := SQLCODE;
               v_error_message       := SQLERRM || ' # INDICATOR_ID = ' || p_indicator_id ||
                                        ' # REFERENCE_DATE = ' || p_reference_date;
               kkpi_util.pkpi_error(v_cd_process_control,
                                    v_sq_process_control,
                                    v_error_code,
                                    v_error_message,
                                    'N');
         END;

         --ELSIF P_INDICATOR_ID = 'SMP13' THEN

         BEGIN
            DELETE kpi.ft_kpi_smp13
             WHERE indicator_id = p_indicator_id
               AND reference_date = p_reference_date;
         EXCEPTION
            WHEN OTHERS THEN
               /***************************************************************************************************/
               /*    Gravar o erro na tabela de controle de erros de processamento do kpi (TKPI_PROCESS_ERROR)    */
               /***************************************************************************************************/
               v_process_termination := 'NOT OK';
               v_error_code          := SQLCODE;
               v_error_message       := SQLERRM || ' # INDICATOR_ID = ' || p_indicator_id ||
                                        ' # REFERENCE_DATE = ' || p_reference_date;
               kkpi_util.pkpi_error(v_cd_process_control,
                                    v_sq_process_control,
                                    v_error_code,
                                    v_error_message,
                                    'N');
         END;

         --ELSIF P_INDICATOR_ID = 'SMP14' THEN

         BEGIN
            DELETE kpi.ft_kpi_smp14
             WHERE indicator_id = p_indicator_id
               AND reference_date = p_reference_date;
         EXCEPTION
            WHEN OTHERS THEN
               /***************************************************************************************************/
               /*    Gravar o erro na tabela de controle de erros de processamento do kpi (TKPI_PROCESS_ERROR)    */
               /***************************************************************************************************/
               v_process_termination := 'NOT OK';
               v_error_code          := SQLCODE;
               v_error_message       := SQLERRM || ' # INDICATOR_ID = ' || p_indicator_id ||
                                        ' # REFERENCE_DATE = ' || p_reference_date;
               kkpi_util.pkpi_error(v_cd_process_control,
                                    v_sq_process_control,
                                    v_error_code,
                                    v_error_message,
                                    'N');
         END;

         --END IF;

         SELECT nvl(COUNT(1), 0)
           INTO v_existe_registro
           FROM kpi.ft_kpi_indicator_approved
          WHERE indicator_id = p_indicator_id
            AND reference_date = p_reference_date;

         IF v_existe_registro = 0 THEN

            BEGIN
               INSERT INTO kpi.ft_kpi_indicator_approved
                  (indicator_id,
                   reference_date,
                   approved_date,
                   approved_user,
                   approved_percent_value,
                   metric_inicial_value,
                   metric_final_value,
                   metric_status_approved,
                   metric_goal_value,
                   last_modification_date,
                   last_modification_user)
               VALUES
                  (p_indicator_id,
                   p_reference_date,
                   SYSDATE,
                   p_approved_user,
                   p_approved_percent_value,
                   p_metric_inicial_value,
                   p_metric_final_value,
                   p_metric_status_approved,
                   p_metric_goal_value,
                   NULL,
                   NULL);
            EXCEPTION
               WHEN OTHERS THEN
                  /***************************************************************************************************/
                  /*    Gravar o erro na tabela de controle de erros de processamento do kpi (TKPI_PROCESS_ERROR)    */
                  /***************************************************************************************************/
                  v_process_termination := 'NOT OK';
                  v_error_code          := SQLCODE;
                  v_error_message       := SQLERRM || ' # INDICATOR_ID = ' || p_indicator_id ||
                                           ' # REFERENCE_DATE = ' || p_reference_date ||
                                           ' # APPROVED_USER = ' || p_approved_user ||
                                           ' # APPROVED_PERCENT_VALUE = ' ||
                                           p_approved_percent_value || ' # METRIC_INICIAL_VALUE = ' ||
                                           p_metric_inicial_value || ' # METRIC_FINAL_VALUE = ' ||
                                           p_metric_final_value || ' # METRIC_STATUS_APPROVED = ' ||
                                           p_metric_status_approved || ' # METRIC_GOAL_VALUE = ' ||
                                           p_metric_goal_value;
                  kkpi_util.pkpi_error(v_cd_process_control,
                                       v_sq_process_control,
                                       v_error_code,
                                       v_error_message,
                                       'N');
            END;

         ELSE

            BEGIN
               UPDATE kpi.ft_kpi_indicator_approved
                  SET approved_percent_value = p_approved_percent_value,
                      metric_inicial_value   = p_metric_inicial_value,
                      metric_final_value     = p_metric_final_value,
                      metric_status_approved = p_metric_status_approved,
                      metric_goal_value      = p_metric_goal_value,
                      last_modification_date = SYSDATE,
                      last_modification_user = p_approved_user
                WHERE indicator_id = p_indicator_id
                  AND reference_date = p_reference_date;
            EXCEPTION
               WHEN OTHERS THEN
                  /***************************************************************************************************/
                  /*    Gravar o erro na tabela de controle de erros de processamento do kpi (TKPI_PROCESS_ERROR)    */
                  /***************************************************************************************************/
                  v_process_termination := 'NOT OK';
                  v_error_code          := SQLCODE;
                  v_error_message       := SQLERRM || ' # INDICATOR_ID = ' || p_indicator_id ||
                                           ' # REFERENCE_DATE = ' || p_reference_date ||
                                           ' # APPROVED_USER = ' || p_approved_user ||
                                           ' # APPROVED_PERCENT_VALUE = ' ||
                                           p_approved_percent_value || ' # METRIC_INICIAL_VALUE = ' ||
                                           p_metric_inicial_value || ' # METRIC_FINAL_VALUE = ' ||
                                           p_metric_final_value || ' # METRIC_STATUS_APPROVED = ' ||
                                           p_metric_status_approved || ' # METRIC_GOAL_VALUE = ' ||
                                           p_metric_goal_value;
                  kkpi_util.pkpi_error(v_cd_process_control,
                                       v_sq_process_control,
                                       v_error_code,
                                       v_error_message,
                                       'N');
            END;

         END IF;

         BEGIN
            SELECT kpi.skpi_hist_indicator_approv_id.nextval
              INTO v_hist_indicator_approved_id
              FROM dual;
         EXCEPTION
            WHEN OTHERS THEN
               /***************************************************************************************************/
               /*    Gravar o erro na tabela de controle de erros de processamento do kpi (TKPI_PROCESS_ERROR)    */
               /***************************************************************************************************/
               v_process_termination := 'NOT OK';
               v_error_code          := SQLCODE;
               v_error_message       := SQLERRM || ' # SKPI_HIST_INDICATOR_APPROVED = ' ||
                                        v_hist_indicator_approved_id;
               kkpi_util.pkpi_error(v_cd_process_control,
                                    v_sq_process_control,
                                    v_error_code,
                                    v_error_message,
                                    'N');
         END;

         BEGIN
            INSERT INTO kpi.ft_kpi_hist_indicator_approved
               (hist_indicator_approved_id,
                indicator_id,
                reference_date,
                approved_date,
                user_approved_id,
                approved_percent_value,
                metric_inicial_value,
                metric_final_value,
                metric_approved_status,
                metric_goal_value)
            VALUES
               (v_hist_indicator_approved_id,
                p_indicator_id,
                p_reference_date,
                SYSDATE,
                p_approved_user,
                p_approved_percent_value,
                p_metric_inicial_value,
                p_metric_final_value,
                p_metric_status_approved,
                p_metric_goal_value);
         EXCEPTION
            WHEN OTHERS THEN
               /***************************************************************************************************/
               /*    Gravar o erro na tabela de controle de erros de processamento do kpi (TKPI_PROCESS_ERROR)    */
               /***************************************************************************************************/
               v_process_termination := 'NOT OK';
               v_error_code          := SQLCODE;
               v_error_message       := SQLERRM || ' # ID_HIST_INDICATOR_APPROVED = ' ||
                                        v_hist_indicator_approved_id || ' # ID_INDICATOR = ' ||
                                        p_indicator_id || ' # DT_REFERENCE = ' || p_reference_date ||
                                        ' # ID_USER_APPROVED = ' || p_approved_user ||
                                        ' # VA_APPROVED_PERCENT = ' || p_approved_percent_value ||
                                        ' # VA_METRIC_INICIAL = ' || p_metric_inicial_value ||
                                        ' # VA_METRIC_FINAL = ' || p_metric_final_value ||
                                        ' # ST_METRIC_APPROVED = ' || p_metric_status_approved ||
                                        ' # VA_METRIC_GOAL = ' || p_metric_goal_value;
               kkpi_util.pkpi_error(v_cd_process_control,
                                    v_sq_process_control,
                                    v_error_code,
                                    v_error_message,
                                    'N');
         END;

         /**********************************************************************************************************************/
         /*   Atualizar finalização do processamento na tabela de controle de processamento do kpi (KPI.TKPI_PROCESS_CONTROL)  */
         /**********************************************************************************************************************/
         kkpi_util.pkpi_update_status(v_cd_process_control,
                                      v_sq_process_control,
                                      'PROCESS ENDED ' || v_process_termination);

         /**************************************************************/
         /*    Verifica se o processo finalizou com erro ou sucesso    */
         /**************************************************************/
         IF v_process_termination = 'OK' THEN
            kkpi_util.pkpi_terminate_process(v_cd_process_control, v_sq_process_control, 'Y');
            p_retorno := 'E0000';
         ELSE
            kkpi_util.pkpi_terminate_process(v_cd_process_control, v_sq_process_control, 'N');
            p_retorno := v_error_message;
         END IF;
         --
      EXCEPTION
         WHEN v_process_error THEN
            /*************************************/
            /*    Registrar ABORT do processo    */
            /*************************************/
            kkpi_util.pkpi_update_status(v_cd_process_control,
                                         v_sq_process_control,
                                         'PROCESS ABORTED');
            kkpi_util.pkpi_terminate_process(v_cd_process_control, v_sq_process_control, 'X');

      END;

   END pkpi_indicator_approved;

   /**************************************************************************************/
   /*                        Procedure gerar o indicador SMP1                            */
   /**************************************************************************************/
   PROCEDURE pkpi_smp1(p_reference_date IN VARCHAR2,
                       p_user_id        IN VARCHAR2,
                       p_retorno        OUT VARCHAR2) IS

      /**************************************************************************************/
      /*                                 Declaração das variáveis                           */
      /**************************************************************************************/
      v_cd_process_control  kpi.tkpi_process_control.cd_process_control%TYPE;
      v_process_termination kpi.tkpi_process_control.de_process_termination%TYPE;

      v_sq_process_control kpi.tkpi_process_control.sq_process_control%TYPE;
      v_process_error EXCEPTION;
      v_error_code           NUMBER(10);
      v_error_message        VARCHAR2(500);
      v_access_operation_qty kpi.ft_kpi_smp1.access_operation_qty%TYPE;

      CURSOR c IS
         SELECT crm.area_billing_address_code ddd_area_code,
                mot.attendance_reason_id attendance_reason_id,
                nvl(SUM(crm.ticket_trouble_qty), 0) complaint_qty
           FROM kpi.lu_kpi_attendance_reason mot,
                kpi.ft_kpi_crm_ticket_detail crm
          WHERE mot.attendance_reason_id = crm.ticket_reason_id
            AND crm.attendance_group_code <> 56 -- CANAL DE ENTRADA DIFERENTE DE 'SHU'
            AND crm.contact_type_id NOT IN (7, 36, 37, 38, 39) -- FORMA DE ACESSO DIFERENTE DE ANATEL
            AND EXISTS
          (SELECT 1
                   FROM kpi.tkpi_national_code cn
                  WHERE cn.cd_national_code = crm.area_billing_address_code
                    AND cn.fg_xml = 'Y'
                    AND cn.fg_excluded_register = 'N')

            AND crm.reference_date = last_day(to_date('01' || p_reference_date, 'DDYYYYMM'))
          GROUP BY crm.area_billing_address_code,
                   mot.attendance_reason_id;

   BEGIN

      BEGIN

         /******************************************************************/
         /*    Setar variáveis para o controle de processamento do KPI     */
         /******************************************************************/

         v_cd_process_control  := 'PKPI_SMP1';
         v_process_termination := 'OK';

         /*****************************************************************************************************************/
         /*    Gravar início do processamento na tabela de controle de processamento do kpi (KPI.TKPI_PROCESS_CONTROL)    */
         /*****************************************************************************************************************/
         kkpi_util.pkpi_start_process(v_cd_process_control, v_sq_process_control);

         kkpi_util.pkpi_update_status(v_cd_process_control,
                                      v_sq_process_control,
                                      'PROCESSING PKPI_SMP1');

         FOR r IN c
         LOOP

            v_access_operation_qty := 0;

            SELECT nvl(SUM(b.customer_qty), 0)
              INTO v_access_operation_qty
              FROM kpi.ft_kpi_bscs_detail b
             WHERE b.reference_date = last_day(to_date('01' || p_reference_date, 'DDYYYYMM'))
               AND b.ddd_area_code = r.ddd_area_code
               AND EXISTS (SELECT 1
                      FROM kpi.tkpi_national_code cn
                     WHERE cn.cd_national_code = b.ddd_area_code
                       AND cn.fg_xml = 'Y'
                       AND cn.fg_excluded_register = 'N');

            BEGIN
               INSERT INTO kpi.ft_kpi_smp1
                  (indicator_id,
                   reference_date,
                   ddd_area_code,
                   attendance_reason_id,
                   complaint_qty,
                   access_operation_qty,
                   creating_date,
                   creating_user)
               VALUES
                  ('SMP1',
                   p_reference_date,
                   r.ddd_area_code,
                   r.attendance_reason_id,
                   r.complaint_qty,
                   v_access_operation_qty,
                   SYSDATE,
                   p_user_id);
            EXCEPTION
               WHEN OTHERS THEN
                  /***************************************************************************************************/
                  /*    Gravar o erro na tabela de controle de erros de processamento do kpi (TKPI_PROCESS_ERROR)    */
                  /***************************************************************************************************/
                  v_process_termination := 'NOT OK';
                  v_error_code          := SQLCODE;
                  v_error_message       := SQLERRM || ' # INDICATOR_ID = ' || 'SMP1' ||
                                           ' # REFERENCE_DATE = ' || p_reference_date ||
                                           ' # DDD_AREA_CODE = ' || r.ddd_area_code ||
                                           ' # ATTENDANCE_REASON_ID = ' || r.attendance_reason_id ||
                                           ' # COMPLAINT_QTY = ' || r.complaint_qty ||
                                           ' # ACCESS_OPERATION_QTY = ' || v_access_operation_qty ||
                                           ' # CREATING_USER = ' || p_user_id;
                  kkpi_util.pkpi_error(v_cd_process_control,
                                       v_sq_process_control,
                                       v_error_code,
                                       v_error_message,
                                       'N');
            END;

         END LOOP;

         /**********************************************************************************************************************/
         /*   Atualizar finalização do processamento na tabela de controle de processamento do kpi (KPI.TKPI_PROCESS_CONTROL)  */
         /**********************************************************************************************************************/
         kkpi_util.pkpi_update_status(v_cd_process_control,
                                      v_sq_process_control,
                                      'PROCESS ENDED ' || v_process_termination);

         /**************************************************************/
         /*    Verifica se o processo finalizou com erro ou sucesso    */
         /**************************************************************/
         IF v_process_termination = 'OK' THEN
            kkpi_util.pkpi_terminate_process(v_cd_process_control, v_sq_process_control, 'Y');
            p_retorno := 'E0000';
         ELSE
            kkpi_util.pkpi_terminate_process(v_cd_process_control, v_sq_process_control, 'N');
            p_retorno := v_error_message;
         END IF;
         --
      EXCEPTION
         WHEN v_process_error THEN
            /*************************************/
            /*    Registrar ABORT do processo    */
            /*************************************/
            kkpi_util.pkpi_update_status(v_cd_process_control,
                                         v_sq_process_control,
                                         'PROCESS ABORTED');
            kkpi_util.pkpi_terminate_process(v_cd_process_control, v_sq_process_control, 'X');

      END;

   END pkpi_smp1;

   /**************************************************************************************/
   /*                        Procedure gerar o indicador SMP2                            */
   /**************************************************************************************/
   PROCEDURE pkpi_smp2(p_reference_date IN VARCHAR2,
                       p_varchar_array  IN kpi.varchar_array,
                       p_user_id        IN VARCHAR2,
                       p_retorno        OUT VARCHAR2) IS

      /**************************************************************************************/
      /*                                 Declaração das variáveis                           */
      /**************************************************************************************/
      v_cd_process_control  kpi.tkpi_process_control.cd_process_control%TYPE;
      v_process_termination kpi.tkpi_process_control.de_process_termination%TYPE;

      v_sq_process_control kpi.tkpi_process_control.sq_process_control%TYPE;
      v_process_error EXCEPTION;
      v_error_code    NUMBER(10);
      v_error_message VARCHAR2(500);

      CURSOR c IS
         SELECT crm.area_billing_address_code ddd_area_code,
                mot.attendance_reason_id attendance_reason_id,
                nvl(SUM(crm.ticket_anatel_qty), 0) complaint_regulatory_qty,
                nvl(SUM(crm.ticket_trouble_qty), 0) complaint_qty
           FROM kpi.lu_kpi_attendance_reason mot,
                kpi.ft_kpi_crm_ticket_detail crm,
                TABLE(p_varchar_array) va
          WHERE mot.attendance_reason_id = crm.ticket_reason_id
            AND ((crm.reference_date BETWEEN to_date('01' || p_reference_date, 'DDYYYYMM') AND
                last_day(to_date('01' || p_reference_date, 'DDYYYYMM')) AND
                p_varchar_array IS NULL) OR crm.reference_date = va.column_value)
            AND EXISTS (SELECT 1
                   FROM kpi.tkpi_national_code cn
                  WHERE cn.cd_national_code = crm.area_billing_address_code
                    AND cn.fg_xml = 'Y'
                    AND cn.fg_excluded_register = 'N')
          GROUP BY crm.area_billing_address_code,
                   mot.attendance_reason_id;

   BEGIN

      BEGIN

         /******************************************************************/
         /*    Setar variáveis para o controle de processamento do KPI     */
         /******************************************************************/

         v_cd_process_control  := 'PKPI_SMP2';
         v_process_termination := 'OK';

         /*****************************************************************************************************************/
         /*    Gravar início do processamento na tabela de controle de processamento do kpi (KPI.TKPI_PROCESS_CONTROL)    */
         /*****************************************************************************************************************/
         kkpi_util.pkpi_start_process(v_cd_process_control, v_sq_process_control);

         kkpi_util.pkpi_update_status(v_cd_process_control,
                                      v_sq_process_control,
                                      'PROCESSING PKPI_SMP2');

         FOR r IN c
         LOOP

            BEGIN
               INSERT INTO kpi.ft_kpi_smp2
                  (indicator_id,
                   reference_date,
                   ddd_area_code,
                   attendance_reason_id,
                   complaint_regulatory_qty,
                   complaint_qty,
                   creating_date,
                   creating_user)
               VALUES
                  ('SMP2',
                   p_reference_date,
                   r.ddd_area_code,
                   r.attendance_reason_id,
                   r.complaint_regulatory_qty,
                   r.complaint_qty,
                   SYSDATE,
                   p_user_id);
            EXCEPTION
               WHEN OTHERS THEN
                  /***************************************************************************************************/
                  /*    Gravar o erro na tabela de controle de erros de processamento do kpi (TKPI_PROCESS_ERROR)    */
                  /***************************************************************************************************/
                  v_process_termination := 'NOT OK';
                  v_error_code          := SQLCODE;
                  v_error_message       := SQLERRM || ' # INDICATOR_ID = ' || 'SMP2' ||
                                           ' # REFERENCE_DATE = ' || p_reference_date ||
                                           ' # DDD_AREA_CODE = ' || r.ddd_area_code ||
                                           ' # ATTENDANCE_REASON_ID = ' || r.attendance_reason_id ||
                                           ' # COMPLAINT_REGULATORY_QTY = ' ||
                                           r.complaint_regulatory_qty || ' # COMPLAINT_QTY = ' ||
                                           r.complaint_qty || ' # CREATING_USER = ' || p_user_id;
                  kkpi_util.pkpi_error(v_cd_process_control,
                                       v_sq_process_control,
                                       v_error_code,
                                       v_error_message,
                                       'N');
            END;

         END LOOP;

         /**********************************************************************************************************************/
         /*   Atualizar finalização do processamento na tabela de controle de processamento do kpi (KPI.TKPI_PROCESS_CONTROL)  */
         /**********************************************************************************************************************/
         kkpi_util.pkpi_update_status(v_cd_process_control,
                                      v_sq_process_control,
                                      'PROCESS ENDED ' || v_process_termination);

         /**************************************************************/
         /*    Verifica se o processo finalizou com erro ou sucesso    */
         /**************************************************************/
         IF v_process_termination = 'OK' THEN
            kkpi_util.pkpi_terminate_process(v_cd_process_control, v_sq_process_control, 'Y');
            p_retorno := 'E0000';
         ELSE
            kkpi_util.pkpi_terminate_process(v_cd_process_control, v_sq_process_control, 'N');
            p_retorno := v_error_message;
         END IF;
         --
      EXCEPTION
         WHEN v_process_error THEN
            /*************************************/
            /*    Registrar ABORT do processo    */
            /*************************************/
            kkpi_util.pkpi_update_status(v_cd_process_control,
                                         v_sq_process_control,
                                         'PROCESS ABORTED');
            kkpi_util.pkpi_terminate_process(v_cd_process_control, v_sq_process_control, 'X');

      END;

   END pkpi_smp2;

   /**************************************************************************************/
   /*                        Procedure gerar o indicador SMP3                            */
   /**************************************************************************************/
   PROCEDURE pkpi_smp3(p_reference_date IN VARCHAR2,
                       p_varchar_array  IN kpi.varchar_array,
                       p_user_id        IN VARCHAR2,
                       p_retorno        OUT VARCHAR2) IS

      /**************************************************************************************/
      /*                                 Declaração das variáveis                           */
      /**************************************************************************************/
      v_cd_process_control  kpi.tkpi_process_control.cd_process_control%TYPE;
      v_process_termination kpi.tkpi_process_control.de_process_termination%TYPE;

      v_sq_process_control kpi.tkpi_process_control.sq_process_control%TYPE;
      v_process_error EXCEPTION;
      v_error_code    NUMBER(10);
      v_error_message VARCHAR2(500);

      CURSOR c IS
         SELECT c.ddd_area_code,
                fc.ccc_code,
                fc.major_movement_period_code,
                nvl(SUM(fc.call_nextel_qty), 0) call_center_qty,
                nvl(SUM(fc.call_nextel_attempt_qty), 0) call_attempt_center_qty
           FROM kpi.lu_kpi_city c,
                kpi.lu_kpi_nodeb n,
                kpi.ft_kpi_call_detail fc,
                TABLE(p_varchar_array) va
          WHERE c.city_code = n.city_code
            AND n.nodeb_code = fc.nodeb_code
            AND n.rnc_code = fc.rnc_code
            AND n.ccc_code = fc.ccc_code
            AND ((fc.reference_date BETWEEN to_date('01' || p_reference_date, 'DDYYYYMM') AND
                last_day(to_date('01' || p_reference_date, 'DDYYYYMM')) AND
                p_varchar_array IS NULL) OR fc.reference_date = va.column_value)
            AND EXISTS (SELECT 1
                   FROM kpi.tkpi_national_code cn
                  WHERE cn.cd_national_code = n.ddd_area_code
                    AND cn.fg_xml = 'Y'
                    AND cn.fg_excluded_register = 'N')

          GROUP BY c.ddd_area_code,
                   fc.ccc_code,
                   fc.major_movement_period_code;

   BEGIN

      BEGIN

         /******************************************************************/
         /*    Setar variáveis para o controle de processamento do KPI     */
         /******************************************************************/

         v_cd_process_control  := 'PKPI_SMP3';
         v_process_termination := 'OK';

         /*****************************************************************************************************************/
         /*    Gravar início do processamento na tabela de controle de processamento do kpi (KPI.TKPI_PROCESS_CONTROL)    */
         /*****************************************************************************************************************/
         kkpi_util.pkpi_start_process(v_cd_process_control, v_sq_process_control);

         kkpi_util.pkpi_update_status(v_cd_process_control,
                                      v_sq_process_control,
                                      'PROCESSING PKPI_SMP3');

         FOR r IN c
         LOOP

            BEGIN
               INSERT INTO kpi.ft_kpi_smp3
                  (indicator_id,
                   reference_date,
                   ddd_area_code,
                   ccc_code,
                   major_movement_period_code,
                   call_center_qty,
                   call_attempt_center_qty,
                   creating_date,
                   creating_user)
               VALUES
                  ('SMP3',
                   p_reference_date,
                   r.ddd_area_code,
                   r.ccc_code,
                   r.major_movement_period_code,
                   r.call_center_qty,
                   r.call_attempt_center_qty,
                   SYSDATE,
                   p_user_id);
            EXCEPTION
               WHEN OTHERS THEN
                  /***************************************************************************************************/
                  /*    Gravar o erro na tabela de controle de erros de processamento do kpi (TKPI_PROCESS_ERROR)    */
                  /***************************************************************************************************/
                  v_process_termination := 'NOT OK';
                  v_error_code          := SQLCODE;
                  v_error_message       := SQLERRM || ' # INDICATOR_ID = ' || 'SMP3' ||
                                           ' # REFERENCE_DATE = ' || p_reference_date ||
                                           ' # DDD_AREA_CODE = ' || r.ddd_area_code ||
                                           ' # CCC_CODE = ' || r.ccc_code ||
                                           ' # MAJOR_MOVEMENT_PERIOD_CODE = ' ||
                                           r.major_movement_period_code || ' # CALL_CENTER_QTY = ' ||
                                           r.call_center_qty || ' # CALL_ATTEMPT_CENTER_QTY = ' ||
                                           r.call_attempt_center_qty || ' # CREATING_USER = ' ||
                                           p_user_id;
                  kkpi_util.pkpi_error(v_cd_process_control,
                                       v_sq_process_control,
                                       v_error_code,
                                       v_error_message,
                                       'N');
            END;

         END LOOP;

         /**********************************************************************************************************************/
         /*   Atualizar finalização do processamento na tabela de controle de processamento do kpi (KPI.TKPI_PROCESS_CONTROL)  */
         /**********************************************************************************************************************/
         kkpi_util.pkpi_update_status(v_cd_process_control,
                                      v_sq_process_control,
                                      'PROCESS ENDED ' || v_process_termination);

         /**************************************************************/
         /*    Verifica se o processo finalizou com erro ou sucesso    */
         /**************************************************************/
         IF v_process_termination = 'OK' THEN
            kkpi_util.pkpi_terminate_process(v_cd_process_control, v_sq_process_control, 'Y');
            p_retorno := 'E0000';
         ELSE
            kkpi_util.pkpi_terminate_process(v_cd_process_control, v_sq_process_control, 'N');
            p_retorno := v_error_message;
         END IF;
         --
      EXCEPTION
         WHEN v_process_error THEN
            /*************************************/
            /*    Registrar ABORT do processo    */
            /*************************************/
            kkpi_util.pkpi_update_status(v_cd_process_control,
                                         v_sq_process_control,
                                         'PROCESS ABORTED');
            kkpi_util.pkpi_terminate_process(v_cd_process_control, v_sq_process_control, 'X');

      END;

   END pkpi_smp3;

   /**************************************************************************************/
   /*                        Procedure gerar o indicador SMP4                            */
   /**************************************************************************************/
   PROCEDURE pkpi_smp4(p_reference_date IN VARCHAR2,
                       p_varchar_array  IN kpi.varchar_array,
                       p_user_id        IN VARCHAR2,
                       p_retorno        OUT VARCHAR2) IS

      /**************************************************************************************/
      /*                                 Declaração das variáveis                           */
      /**************************************************************************************/
      v_cd_process_control  kpi.tkpi_process_control.cd_process_control%TYPE;
      v_process_termination kpi.tkpi_process_control.de_process_termination%TYPE;

      v_sq_process_control kpi.tkpi_process_control.sq_process_control%TYPE;
      v_process_error EXCEPTION;
      v_error_code    NUMBER(10);
      v_error_message VARCHAR2(500);

      CURSOR c IS
         SELECT c.ddd_area_code,
                fc.ccc_code,
                fc.major_movement_period_code,
                nvl(SUM(fc.call_qty), 0) call_qty,
                nvl(SUM(fc.call_attempt_qty), 0) call_attempt_qty,
                nvl(SUM(fc.call_forwarded_answered), 0) call_forwarded_answered,
                nvl(SUM(fc.call_forwarded_unanswered), 0) call_forwarded_unanswered
           FROM kpi.lu_kpi_city c,
                kpi.lu_kpi_nodeb n,
                kpi.ft_kpi_call_detail fc,
                TABLE(p_varchar_array) va
          WHERE c.city_code = n.city_code
            AND n.nodeb_code = fc.nodeb_code
            AND n.rnc_code = fc.rnc_code
            AND n.ccc_code = fc.ccc_code
            AND ((fc.reference_date BETWEEN to_date('01' || p_reference_date, 'DDYYYYMM') AND
                last_day(to_date('01' || p_reference_date, 'DDYYYYMM')) AND
                p_varchar_array IS NULL) OR fc.reference_date = va.column_value)
            AND EXISTS (SELECT 1
                   FROM kpi.tkpi_national_code cn
                  WHERE cn.cd_national_code = n.ddd_area_code
                    AND cn.fg_xml = 'Y'
                    AND cn.fg_excluded_register = 'N')
          GROUP BY c.ddd_area_code,
                   fc.ccc_code,
                   fc.major_movement_period_code;

   BEGIN

      BEGIN

         /******************************************************************/
         /*    Setar variáveis para o controle de processamento do KPI     */
         /******************************************************************/

         v_cd_process_control  := 'PKPI_SMP4';
         v_process_termination := 'OK';

         /*****************************************************************************************************************/
         /*    Gravar início do processamento na tabela de controle de processamento do kpi (KPI.TKPI_PROCESS_CONTROL)    */
         /*****************************************************************************************************************/
         kkpi_util.pkpi_start_process(v_cd_process_control, v_sq_process_control);

         kkpi_util.pkpi_update_status(v_cd_process_control,
                                      v_sq_process_control,
                                      'PROCESSING PKPI_SMP4');

         FOR r IN c
         LOOP

            BEGIN
               INSERT INTO kpi.ft_kpi_smp4
                  (indicator_id,
                   reference_date,
                   ddd_area_code,
                   ccc_code,
                   major_movement_period_code,
                   call_qty,
                   call_attempt_qty,
                   call_forwarded_answered,
                   call_forwarded_unanswered,
                   creating_date,
                   creating_user)
               VALUES
                  ('SMP4',
                   p_reference_date,
                   r.ddd_area_code,
                   r.ccc_code,
                   r.major_movement_period_code,
                   r.call_qty,
                   r.call_attempt_qty,
                   r.call_forwarded_answered,
                   r.call_forwarded_unanswered,
                   SYSDATE,
                   p_user_id);
            EXCEPTION
               WHEN OTHERS THEN
                  /***************************************************************************************************/
                  /*    Gravar o erro na tabela de controle de erros de processamento do kpi (TKPI_PROCESS_ERROR)    */
                  /***************************************************************************************************/
                  v_process_termination := 'NOT OK';
                  v_error_code          := SQLCODE;
                  v_error_message       := SQLERRM || ' # INDICATOR_ID = ' || 'SMP4' ||
                                           ' # REFERENCE_DATE = ' || p_reference_date ||
                                           ' # DDD_AREA_CODE = ' || r.ddd_area_code ||
                                           ' # CCC_CODE = ' || r.ccc_code ||
                                           ' # MAJOR_MOVEMENT_PERIOD_CODE = ' ||
                                           r.major_movement_period_code || ' # CALL_QTY = ' ||
                                           r.call_qty || ' # CALL_ATTEMPT_QTY = ' ||
                                           r.call_attempt_qty || ' # CALL_FORWARDED_ANSWERED = ' ||
                                           r.call_forwarded_answered ||
                                           ' # CALL_FORWARDED_UNANSWERED = ' ||
                                           r.call_forwarded_unanswered || ' # CREATING_USER = ' ||
                                           p_user_id;
                  kkpi_util.pkpi_error(v_cd_process_control,
                                       v_sq_process_control,
                                       v_error_code,
                                       v_error_message,
                                       'N');
            END;

         END LOOP;

         /**********************************************************************************************************************/
         /*   Atualizar finalização do processamento na tabela de controle de processamento do kpi (KPI.TKPI_PROCESS_CONTROL)  */
         /**********************************************************************************************************************/
         kkpi_util.pkpi_update_status(v_cd_process_control,
                                      v_sq_process_control,
                                      'PROCESS ENDED ' || v_process_termination);

         /**************************************************************/
         /*    Verifica se o processo finalizou com erro ou sucesso    */
         /**************************************************************/
         IF v_process_termination = 'OK' THEN
            kkpi_util.pkpi_terminate_process(v_cd_process_control, v_sq_process_control, 'Y');
            p_retorno := 'E0000';
         ELSE
            kkpi_util.pkpi_terminate_process(v_cd_process_control, v_sq_process_control, 'N');
            p_retorno := v_error_message;
         END IF;
         --
      EXCEPTION
         WHEN v_process_error THEN
            /*************************************/
            /*    Registrar ABORT do processo    */
            /*************************************/
            kkpi_util.pkpi_update_status(v_cd_process_control,
                                         v_sq_process_control,
                                         'PROCESS ABORTED');
            kkpi_util.pkpi_terminate_process(v_cd_process_control, v_sq_process_control, 'X');

      END;

   END pkpi_smp4;

   /**************************************************************************************/
   /*                        Procedure gerar o indicador SMP5                            */
   /**************************************************************************************/
   PROCEDURE pkpi_smp5(p_reference_date IN VARCHAR2,
                       p_varchar_array  IN kpi.varchar_array,
                       p_user_id        IN VARCHAR2,
                       p_retorno        OUT VARCHAR2) IS

      /**************************************************************************************/
      /*                                 Declaração das variáveis                           */
      /**************************************************************************************/
      v_cd_process_control  kpi.tkpi_process_control.cd_process_control%TYPE;
      v_process_termination kpi.tkpi_process_control.de_process_termination%TYPE;

      v_sq_process_control kpi.tkpi_process_control.sq_process_control%TYPE;
      v_process_error EXCEPTION;
      v_error_code    NUMBER(10);
      v_error_message VARCHAR2(500);

      CURSOR c IS
         SELECT n.ddd_area_code,
                fst.ccc_code,
                mmp.major_movement_period_code,
                SUM(fst.signaling_qty) signaling_qty,
                SUM(fst.signaling_attempt_qty) signaling_attempt_qty,
                SUM(fst.traffic_qty) traffic_qty,
                SUM(fst.traffic_attempt_qty) traffic_attempt_qty
           FROM kpi.lu_kpi_major_movement_period mmp,
                kpi.lu_kpi_nodeb n,
                kpi.ft_kpi_sign_traffic_detail fst,
                TABLE(p_varchar_array) va
          WHERE mmp.major_movement_period_code = fst.major_movement_period_code
            AND n.nodeb_code = fst.nodeb_code
            AND n.rnc_code = fst.rnc_code
            AND n.ccc_code = fst.ccc_code
            AND ((fst.reference_date BETWEEN to_date('01' || p_reference_date, 'DDYYYYMM') AND
                last_day(to_date('01' || p_reference_date, 'DDYYYYMM')) AND
                p_varchar_array IS NULL) OR fst.reference_date = va.column_value)

            AND EXISTS (SELECT 1
                   FROM kpi.tkpi_national_code cn
                  WHERE cn.cd_national_code = n.ddd_area_code
                    AND cn.fg_xml = 'Y'
                    AND cn.fg_excluded_register = 'N')
          GROUP BY n.ddd_area_code,
                   fst.ccc_code,
                   mmp.major_movement_period_code;

   BEGIN

      BEGIN

         /******************************************************************/
         /*    Setar variáveis para o controle de processamento do KPI     */
         /******************************************************************/

         v_cd_process_control  := 'PKPI_SMP5';
         v_process_termination := 'OK';

         /*****************************************************************************************************************/
         /*    Gravar início do processamento na tabela de controle de processamento do kpi (KPI.TKPI_PROCESS_CONTROL)    */
         /*****************************************************************************************************************/
         kkpi_util.pkpi_start_process(v_cd_process_control, v_sq_process_control);

         kkpi_util.pkpi_update_status(v_cd_process_control,
                                      v_sq_process_control,
                                      'PROCESSING PKPI_SMP5');

         FOR r IN c
         LOOP

            BEGIN
               INSERT INTO kpi.ft_kpi_smp5
                  (indicator_id,
                   reference_date,
                   ddd_area_code,
                   ccc_code,
                   major_movement_period_code,
                   signaling_qty,
                   signaling_attempt_qty,
                   traffic_qty,
                   traffic_attempt_qty,
                   creating_date,
                   creating_user)
               VALUES
                  ('SMP5',
                   p_reference_date,
                   r.ddd_area_code,
                   r.ccc_code,
                   r.major_movement_period_code,
                   r.signaling_qty,
                   r.signaling_attempt_qty,
                   r.traffic_qty,
                   r.traffic_attempt_qty,
                   SYSDATE,
                   p_user_id);
            EXCEPTION
               WHEN OTHERS THEN
                  /***************************************************************************************************/
                  /*    Gravar o erro na tabela de controle de erros de processamento do kpi (TKPI_PROCESS_ERROR)    */
                  /***************************************************************************************************/
                  v_process_termination := 'NOT OK';
                  v_error_code          := SQLCODE;
                  v_error_message       := SQLERRM || ' # INDICATOR_ID = ' || 'SMP5' ||
                                           ' # REFERENCE_DATE = ' || p_reference_date ||
                                           ' # DDD_AREA_CODE = ' || r.ddd_area_code ||
                                           ' # CCC_CODE = ' || r.ccc_code ||
                                           ' # MAJOR_MOVEMENT_PERIOD_CODE = ' ||
                                           r.major_movement_period_code || ' # SIGNALING_QTY = ' ||
                                           r.signaling_qty || ' # SIGNALING_ATTEMPT_QTY = ' ||
                                           r.signaling_attempt_qty || ' # TRAFFIC_QTY = ' ||
                                           r.traffic_qty || ' # TRAFFIC_ATTEMPT_QTY = ' ||
                                           r.traffic_attempt_qty || ' # CREATING_USER = ' ||
                                           p_user_id;
                  kkpi_util.pkpi_error(v_cd_process_control,
                                       v_sq_process_control,
                                       v_error_code,
                                       v_error_message,
                                       'N');
            END;

         END LOOP;

         /**********************************************************************************************************************/
         /*   Atualizar finalização do processamento na tabela de controle de processamento do kpi (KPI.TKPI_PROCESS_CONTROL)  */
         /**********************************************************************************************************************/
         kkpi_util.pkpi_update_status(v_cd_process_control,
                                      v_sq_process_control,
                                      'PROCESS ENDED ' || v_process_termination);

         /**************************************************************/
         /*    Verifica se o processo finalizou com erro ou sucesso    */
         /**************************************************************/
         IF v_process_termination = 'OK' THEN
            kkpi_util.pkpi_terminate_process(v_cd_process_control, v_sq_process_control, 'Y');
            p_retorno := 'E0000';
         ELSE
            kkpi_util.pkpi_terminate_process(v_cd_process_control, v_sq_process_control, 'N');
            p_retorno := v_error_message;
         END IF;
         --
      EXCEPTION
         WHEN v_process_error THEN
            /*************************************/
            /*    Registrar ABORT do processo    */
            /*************************************/
            kkpi_util.pkpi_update_status(v_cd_process_control,
                                         v_sq_process_control,
                                         'PROCESS ABORTED');
            kkpi_util.pkpi_terminate_process(v_cd_process_control, v_sq_process_control, 'X');

      END;

   END pkpi_smp5;

   /**************************************************************************************/
   /*                        Procedure gerar o indicador SMP6                            */
   /**************************************************************************************/
   PROCEDURE pkpi_smp6(p_reference_date IN VARCHAR2,
                       p_varchar_array  IN kpi.varchar_array,
                       p_user_id        IN VARCHAR2,
                       p_retorno        OUT VARCHAR2) IS

      /**************************************************************************************/
      /*                                 Declaração das variáveis                           */
      /**************************************************************************************/
      v_cd_process_control  kpi.tkpi_process_control.cd_process_control%TYPE;
      v_process_termination kpi.tkpi_process_control.de_process_termination%TYPE;

      v_sq_process_control kpi.tkpi_process_control.sq_process_control%TYPE;
      v_process_error EXCEPTION;
      v_error_code    NUMBER(10);
      v_error_message VARCHAR2(500);

      CURSOR c IS
         SELECT fs.ddd_area_code,
                fs.plataform_sms_code,
                SUM(fs.sms_attempt_sec_qty) sms_attempt_qty,
                SUM(fs.sms_attempt_qty) sms_send_qty
           FROM kpi.ft_kpi_sms_detail fs,
                TABLE(p_varchar_array) va
          WHERE ((fs.reference_date BETWEEN to_date('01' || p_reference_date, 'DDYYYYMM') AND
                last_day(to_date('01' || p_reference_date, 'DDYYYYMM')) AND
                p_varchar_array IS NULL) OR fs.reference_date = va.column_value)
            AND EXISTS (SELECT 1
                   FROM kpi.tkpi_national_code cn
                  WHERE cn.cd_national_code = fs.ddd_area_code
                    AND cn.fg_xml = 'Y'
                    AND cn.fg_excluded_register = 'N')
          GROUP BY fs.ddd_area_code,
                   fs.plataform_sms_code;

   BEGIN

      BEGIN

         /******************************************************************/
         /*    Setar variáveis para o controle de processamento do KPI     */
         /******************************************************************/

         v_cd_process_control  := 'PKPI_SMP6';
         v_process_termination := 'OK';

         /*****************************************************************************************************************/
         /*    Gravar início do processamento na tabela de controle de processamento do kpi (KPI.TKPI_PROCESS_CONTROL)    */
         /*****************************************************************************************************************/
         kkpi_util.pkpi_start_process(v_cd_process_control, v_sq_process_control);

         kkpi_util.pkpi_update_status(v_cd_process_control,
                                      v_sq_process_control,
                                      'PROCESSING PKPI_SMP6');

         FOR r IN c
         LOOP

            BEGIN
               INSERT INTO kpi.ft_kpi_smp6
                  (indicator_id,
                   reference_date,
                   ddd_area_code,
                   plataform_sms_code,
                   sms_send_qty,
                   sms_attempt_qty,
                   creating_date,
                   creating_user)
               VALUES
                  ('SMP6',
                   p_reference_date,
                   r.ddd_area_code,
                   r.plataform_sms_code,
                   r.sms_send_qty,
                   r.sms_attempt_qty,
                   SYSDATE,
                   p_user_id);
            EXCEPTION
               WHEN OTHERS THEN
                  /***************************************************************************************************/
                  /*    Gravar o erro na tabela de controle de erros de processamento do kpi (TKPI_PROCESS_ERROR)    */
                  /***************************************************************************************************/
                  v_process_termination := 'NOT OK';
                  v_error_code          := SQLCODE;
                  v_error_message       := SQLERRM || ' # INDICATOR_ID = ' || 'SMP6' ||
                                           ' # REFERENCE_DATE = ' || p_reference_date ||
                                           ' # DDD_AREA_CODE = ' || r.ddd_area_code ||
                                           ' # PLATAFORM_SMS_CODE = ' || r.plataform_sms_code ||
                                           ' # SMS_SEND_QTY = ' || r.sms_send_qty ||
                                           ' # SMS_ATTEMPT_QTY = ' || r.sms_attempt_qty ||
                                           ' # CREATING_USER = ' || p_user_id;
                  kkpi_util.pkpi_error(v_cd_process_control,
                                       v_sq_process_control,
                                       v_error_code,
                                       v_error_message,
                                       'N');
            END;

         END LOOP;

         /**********************************************************************************************************************/
         /*   Atualizar finalização do processamento na tabela de controle de processamento do kpi (KPI.TKPI_PROCESS_CONTROL)  */
         /**********************************************************************************************************************/
         kkpi_util.pkpi_update_status(v_cd_process_control,
                                      v_sq_process_control,
                                      'PROCESS ENDED ' || v_process_termination);

         /**************************************************************/
         /*    Verifica se o processo finalizou com erro ou sucesso    */
         /**************************************************************/
         IF v_process_termination = 'OK' THEN
            kkpi_util.pkpi_terminate_process(v_cd_process_control, v_sq_process_control, 'Y');
            p_retorno := 'E0000';
         ELSE
            kkpi_util.pkpi_terminate_process(v_cd_process_control, v_sq_process_control, 'N');
            p_retorno := v_error_message;
         END IF;
         --
      EXCEPTION
         WHEN v_process_error THEN
            /*************************************/
            /*    Registrar ABORT do processo    */
            /*************************************/
            kkpi_util.pkpi_update_status(v_cd_process_control,
                                         v_sq_process_control,
                                         'PROCESS ABORTED');
            kkpi_util.pkpi_terminate_process(v_cd_process_control, v_sq_process_control, 'X');

      END;

   END pkpi_smp6;

   /**************************************************************************************/
   /*                        Procedure gerar o indicador SMP7                            */
   /**************************************************************************************/
   PROCEDURE pkpi_smp7(p_reference_date IN VARCHAR2,
                       p_varchar_array  IN kpi.varchar_array,
                       p_user_id        IN VARCHAR2,
                       p_retorno        OUT VARCHAR2) IS

      /**************************************************************************************/
      /*                                 Declaração das variáveis                           */
      /**************************************************************************************/
      v_cd_process_control  kpi.tkpi_process_control.cd_process_control%TYPE;
      v_process_termination kpi.tkpi_process_control.de_process_termination%TYPE;

      v_sq_process_control kpi.tkpi_process_control.sq_process_control%TYPE;
      v_process_error EXCEPTION;
      v_error_code    NUMBER(10);
      v_error_message VARCHAR2(500);

      CURSOR c IS
         SELECT n.ddd_area_code,
                fc.ccc_code,
                mmp.major_movement_period_code,
                SUM(fc.call_interrupted_qty) call_interrupted_qty,
                SUM(fc.call_qty) call_qty
           FROM kpi.lu_kpi_major_movement_period mmp,
                kpi.lu_kpi_nodeb n,
                kpi.ft_kpi_call_detail fc,
                TABLE(p_varchar_array) va
          WHERE mmp.major_movement_period_code = fc.major_movement_period_code
            AND n.nodeb_code = fc.nodeb_code
            AND n.rnc_code = fc.rnc_code
            AND n.ccc_code = fc.ccc_code
            AND ((fc.reference_date BETWEEN to_date('01' || p_reference_date, 'DDYYYYMM') AND
                last_day(to_date('01' || p_reference_date, 'DDYYYYMM')) AND
                p_varchar_array IS NULL) OR fc.reference_date = va.column_value)
            AND EXISTS (SELECT 1
                   FROM kpi.tkpi_national_code cn
                  WHERE cn.cd_national_code = n.ddd_area_code
                    AND cn.fg_xml = 'Y'
                    AND cn.fg_excluded_register = 'N')
          GROUP BY n.ddd_area_code,
                   fc.ccc_code,
                   mmp.major_movement_period_code;

   BEGIN

      BEGIN

         /******************************************************************/
         /*    Setar variáveis para o controle de processamento do KPI     */
         /******************************************************************/

         v_cd_process_control  := 'PKPI_SMP7';
         v_process_termination := 'OK';

         /*****************************************************************************************************************/
         /*    Gravar início do processamento na tabela de controle de processamento do kpi (KPI.TKPI_PROCESS_CONTROL)    */
         /*****************************************************************************************************************/
         kkpi_util.pkpi_start_process(v_cd_process_control, v_sq_process_control);

         kkpi_util.pkpi_update_status(v_cd_process_control,
                                      v_sq_process_control,
                                      'PROCESSING PKPI_SMP7');

         FOR r IN c
         LOOP

            BEGIN
               INSERT INTO kpi.ft_kpi_smp7
                  (indicator_id,
                   reference_date,
                   ddd_area_code,
                   ccc_code,
                   major_movement_period_code,
                   call_interrupted_qty,
                   call_qty,
                   creating_date,
                   creating_user)
               VALUES
                  ('SMP7',
                   p_reference_date,
                   r.ddd_area_code,
                   r.ccc_code,
                   r.major_movement_period_code,
                   r.call_interrupted_qty,
                   r.call_qty,
                   SYSDATE,
                   p_user_id);
            EXCEPTION
               WHEN OTHERS THEN
                  /***************************************************************************************************/
                  /*    Gravar o erro na tabela de controle de erros de processamento do kpi (TKPI_PROCESS_ERROR)    */
                  /***************************************************************************************************/
                  v_process_termination := 'NOT OK';
                  v_error_code          := SQLCODE;
                  v_error_message       := SQLERRM || ' # INDICATOR_ID = ' || 'SMP7' ||
                                           ' # REFERENCE_DATE = ' || p_reference_date ||
                                           ' # DDD_AREA_CODE = ' || r.ddd_area_code ||
                                           ' # CCC_CODE = ' || r.ccc_code ||
                                           ' # MAJOR_MOVEMENT_PERIOD_CODE = ' ||
                                           r.major_movement_period_code ||
                                           ' # CALL_INTERRUPTED_QTY = ' || r.call_interrupted_qty ||
                                           ' # CALL_QTY = ' || r.call_qty || ' # CREATING_USER = ' ||
                                           p_user_id;
                  kkpi_util.pkpi_error(v_cd_process_control,
                                       v_sq_process_control,
                                       v_error_code,
                                       v_error_message,
                                       'N');
            END;

         END LOOP;

         /**********************************************************************************************************************/
         /*   Atualizar finalização do processamento na tabela de controle de processamento do kpi (KPI.TKPI_PROCESS_CONTROL)  */
         /**********************************************************************************************************************/
         kkpi_util.pkpi_update_status(v_cd_process_control,
                                      v_sq_process_control,
                                      'PROCESS ENDED ' || v_process_termination);

         /**************************************************************/
         /*    Verifica se o processo finalizou com erro ou sucesso    */
         /**************************************************************/
         IF v_process_termination = 'OK' THEN
            kkpi_util.pkpi_terminate_process(v_cd_process_control, v_sq_process_control, 'Y');
            p_retorno := 'E0000';
         ELSE
            kkpi_util.pkpi_terminate_process(v_cd_process_control, v_sq_process_control, 'N');
            p_retorno := v_error_message;
         END IF;
         --
      EXCEPTION
         WHEN v_process_error THEN
            /*************************************/
            /*    Registrar ABORT do processo    */
            /*************************************/
            kkpi_util.pkpi_update_status(v_cd_process_control,
                                         v_sq_process_control,
                                         'PROCESS ABORTED');
            kkpi_util.pkpi_terminate_process(v_cd_process_control, v_sq_process_control, 'X');

      END;

   END pkpi_smp7;

   /**************************************************************************************/
   /*                        Procedure gerar o indicador SMP8                            */
   /**************************************************************************************/
   PROCEDURE pkpi_smp8(p_reference_date IN VARCHAR2,
                       p_varchar_array  IN kpi.varchar_array,
                       p_user_id        IN VARCHAR2,
                       p_retorno        OUT VARCHAR2) IS

      /**************************************************************************************/
      /*                                 Declaração das variáveis                           */
      /**************************************************************************************/
      v_cd_process_control  kpi.tkpi_process_control.cd_process_control%TYPE;
      v_process_termination kpi.tkpi_process_control.de_process_termination%TYPE;

      v_sq_process_control kpi.tkpi_process_control.sq_process_control%TYPE;
      v_process_error EXCEPTION;
      v_error_code    NUMBER(10);
      v_error_message VARCHAR2(500);

      CURSOR c IS
         SELECT c.state_code,
                fd.ccc_code,
                mtp.major_traffic_period_code,
                SUM(fd.connection_qty) connection_qty,
                SUM(fd.connection_attempt_qty) connection_attempt_qty,
                rn.ggsn_code,
                c.ddd_area_code

           FROM kpi.lu_kpi_major_traffic_period mtp,
                kpi.lu_kpi_city c,
                kpi.lu_kpi_nodeb n,
                kpi.ft_kpi_data_detail fd,
                kpi.lu_kpi_rnc rn,
                TABLE(p_varchar_array) va
          WHERE mtp.major_traffic_period_code = fd.major_traffic_period_code
            AND c.city_code = n.city_code
            AND n.nodeb_code = fd.nodeb_code
            AND n.rnc_code = fd.rnc_code
            AND n.ccc_code = fd.ccc_code
            AND n.rnc_code = rn.rnc_code
            AND n.ccc_code = rn.ccc_code
            AND ((fd.reference_date BETWEEN to_date('01' || p_reference_date, 'DDYYYYMM') AND
                last_day(to_date('01' || p_reference_date, 'DDYYYYMM')) AND
                p_varchar_array IS NULL) OR fd.reference_date = va.column_value)
            AND EXISTS (SELECT 1
                   FROM kpi.tkpi_national_code cn
                  WHERE cn.cd_national_code = n.ddd_area_code
                    AND cn.fg_xml = 'Y'
                    AND cn.fg_excluded_register = 'N')
          GROUP BY c.state_code,
                   fd.ccc_code,
                   mtp.major_traffic_period_code,
                   rn.ggsn_code,
                   c.ddd_area_code;

   BEGIN

      BEGIN

         /******************************************************************/
         /*    Setar variáveis para o controle de processamento do KPI     */
         /******************************************************************/

         v_cd_process_control  := 'PKPI_SMP8';
         v_process_termination := 'OK';

         /*****************************************************************************************************************/
         /*    Gravar início do processamento na tabela de controle de processamento do kpi (KPI.TKPI_PROCESS_CONTROL)    */
         /*****************************************************************************************************************/
         kkpi_util.pkpi_start_process(v_cd_process_control, v_sq_process_control);

         kkpi_util.pkpi_update_status(v_cd_process_control,
                                      v_sq_process_control,
                                      'PROCESSING PKPI_SMP8');

         FOR r IN c
         LOOP

            BEGIN
               INSERT INTO kpi.ft_kpi_smp8
                  (indicator_id,
                   reference_date,
                   state_code,
                   ccc_code,
                   major_traffic_period_code,
                   connection_qty,
                   connection_attempt_qty,
                   creating_date,
                   creating_user,
                   ggsn_code,
                   ddd_area_code)
               VALUES
                  ('SMP8',
                   p_reference_date,
                   r.state_code,
                   r.ccc_code,
                   r.major_traffic_period_code,
                   r.connection_qty,
                   r.connection_attempt_qty,
                   SYSDATE,
                   p_user_id,
                   r.ggsn_code,
                   r.ddd_area_code);
            EXCEPTION
               WHEN OTHERS THEN
                  /***************************************************************************************************/
                  /*    Gravar o erro na tabela de controle de erros de processamento do kpi (TKPI_PROCESS_ERROR)    */
                  /***************************************************************************************************/
                  v_process_termination := 'NOT OK';
                  v_error_code          := SQLCODE;
                  v_error_message       := SQLERRM || ' # INDICATOR_ID = ' || 'SMP8' ||
                                           ' # REFERENCE_DATE = ' || p_reference_date ||
                                           ' # STATE_CODE = ' || r.state_code || ' # CCC_CODE = ' ||
                                           r.ccc_code || ' # MAJOR_TRAFFIC_PERIOD_CODE = ' ||
                                           r.major_traffic_period_code || ' # CONNECTION_QTY = ' ||
                                           r.connection_qty || ' # CONNECTION_ATTEMPT_QTY = ' ||
                                           r.connection_attempt_qty || ' # CREATING_USER = ' ||
                                           p_user_id;
                  kkpi_util.pkpi_error(v_cd_process_control,
                                       v_sq_process_control,
                                       v_error_code,
                                       v_error_message,
                                       'N');
            END;

         END LOOP;

         /**********************************************************************************************************************/
         /*   Atualizar finalização do processamento na tabela de controle de processamento do kpi (KPI.TKPI_PROCESS_CONTROL)  */
         /**********************************************************************************************************************/
         kkpi_util.pkpi_update_status(v_cd_process_control,
                                      v_sq_process_control,
                                      'PROCESS ENDED ' || v_process_termination);

         /**************************************************************/
         /*    Verifica se o processo finalizou com erro ou sucesso    */
         /**************************************************************/
         IF v_process_termination = 'OK' THEN
            kkpi_util.pkpi_terminate_process(v_cd_process_control, v_sq_process_control, 'Y');
            p_retorno := 'E0000';
         ELSE
            kkpi_util.pkpi_terminate_process(v_cd_process_control, v_sq_process_control, 'N');
            p_retorno := v_error_message;
         END IF;
         --
      EXCEPTION
         WHEN v_process_error THEN
            /*************************************/
            /*    Registrar ABORT do processo    */
            /*************************************/
            kkpi_util.pkpi_update_status(v_cd_process_control,
                                         v_sq_process_control,
                                         'PROCESS ABORTED');
            kkpi_util.pkpi_terminate_process(v_cd_process_control, v_sq_process_control, 'X');

      END;

   END pkpi_smp8;

   /**************************************************************************************/
   /*                        Procedure gerar o indicador SMP9                            */
   /**************************************************************************************/
   PROCEDURE pkpi_smp9(p_reference_date IN VARCHAR2,
                       p_varchar_array  IN kpi.varchar_array,
                       p_user_id        IN VARCHAR2,
                       p_retorno        OUT VARCHAR2) IS

      /**************************************************************************************/
      /*                                 Declaração das variáveis                           */
      /**************************************************************************************/
      v_cd_process_control  kpi.tkpi_process_control.cd_process_control%TYPE;
      v_process_termination kpi.tkpi_process_control.de_process_termination%TYPE;

      v_sq_process_control kpi.tkpi_process_control.sq_process_control%TYPE;
      v_process_error EXCEPTION;
      v_error_code    NUMBER(10);
      v_error_message VARCHAR2(500);

      CURSOR c IS
         SELECT c.state_code,
                fd.ccc_code,
                mtp.major_traffic_period_code,
                SUM(fd.drop_connection_qty) drop_connection_qty,
                SUM(fd.connection_attempt_qty) connection_attempt_qty,
                SUM(fd.connection_qty) connection_qty,
                rn.ggsn_code,
                c.ddd_area_code
           FROM kpi.lu_kpi_major_traffic_period mtp,
                kpi.lu_kpi_city c,
                kpi.lu_kpi_nodeb n,
                kpi.ft_kpi_data_detail fd,
                kpi.lu_kpi_rnc rn,
                TABLE(p_varchar_array) va
          WHERE mtp.major_traffic_period_code = fd.major_traffic_period_code
            AND c.city_code = n.city_code
            AND n.nodeb_code = fd.nodeb_code
            AND n.rnc_code = fd.rnc_code
            AND n.ccc_code = fd.ccc_code
            AND n.ccc_code = rn.ccc_code
            AND n.rnc_code = rn.rnc_code
            AND ((fd.reference_date BETWEEN to_date('01' || p_reference_date, 'DDYYYYMM') AND
                last_day(to_date('01' || p_reference_date, 'DDYYYYMM')) AND
                p_varchar_array IS NULL) OR fd.reference_date = va.column_value)
            AND EXISTS (SELECT 1
                   FROM kpi.tkpi_national_code cn
                  WHERE cn.cd_national_code = n.ddd_area_code
                    AND cn.fg_xml = 'Y'
                    AND cn.fg_excluded_register = 'N')
          GROUP BY c.state_code,
                   fd.ccc_code,
                   mtp.major_traffic_period_code,
                   rn.ggsn_code,
                   c.ddd_area_code;

   BEGIN

      BEGIN

         /******************************************************************/
         /*    Setar variáveis para o controle de processamento do KPI     */
         /******************************************************************/

         v_cd_process_control  := 'PKPI_SMP9';
         v_process_termination := 'OK';

         /*****************************************************************************************************************/
         /*    Gravar início do processamento na tabela de controle de processamento do kpi (KPI.TKPI_PROCESS_CONTROL)    */
         /*****************************************************************************************************************/
         kkpi_util.pkpi_start_process(v_cd_process_control, v_sq_process_control);

         kkpi_util.pkpi_update_status(v_cd_process_control,
                                      v_sq_process_control,
                                      'PROCESSING PKPI_SMP9');

         FOR r IN c
         LOOP

            BEGIN
               INSERT INTO kpi.ft_kpi_smp9
                  (indicator_id,
                   reference_date,
                   state_code,
                   ccc_code,
                   major_traffic_period_code,
                   drop_connection_qty,
                   connection_attempt_qty,
                   creating_date,
                   creating_user,
                   connection_qty,
                   ggsn_code,
                   ddd_area_code)
               VALUES
                  ('SMP9',
                   p_reference_date,
                   r.state_code,
                   r.ccc_code,
                   r.major_traffic_period_code,
                   r.drop_connection_qty,
                   r.connection_attempt_qty,
                   SYSDATE,
                   p_user_id,
                   r.connection_qty,
                   r.ggsn_code,
                   r.ddd_area_code);
            EXCEPTION
               WHEN OTHERS THEN
                  /***************************************************************************************************/
                  /*    Gravar o erro na tabela de controle de erros de processamento do kpi (TKPI_PROCESS_ERROR)    */
                  /***************************************************************************************************/
                  v_process_termination := 'NOT OK';
                  v_error_code          := SQLCODE;
                  v_error_message       := SQLERRM || ' # INDICATOR_ID = ' || 'SMP9' ||
                                           ' # REFERENCE_DATE = ' || p_reference_date ||
                                           ' # STATE_CODE = ' || r.state_code || ' # CCC_CODE = ' ||
                                           r.ccc_code || ' # MAJOR_TRAFFIC_PERIOD_CODE = ' ||
                                           r.major_traffic_period_code ||
                                           ' # DROP_CONNECTION_QTY = ' || r.drop_connection_qty ||
                                           ' # CONNECTION_ATTEMPT_QTY = ' ||
                                           r.connection_attempt_qty || ' # CREATING_USER = ' ||
                                           p_user_id;
                  kkpi_util.pkpi_error(v_cd_process_control,
                                       v_sq_process_control,
                                       v_error_code,
                                       v_error_message,
                                       'N');
            END;

         END LOOP;

         /**********************************************************************************************************************/
         /*   Atualizar finalização do processamento na tabela de controle de processamento do kpi (KPI.TKPI_PROCESS_CONTROL)  */
         /**********************************************************************************************************************/
         kkpi_util.pkpi_update_status(v_cd_process_control,
                                      v_sq_process_control,
                                      'PROCESS ENDED ' || v_process_termination);

         /**************************************************************/
         /*    Verifica se o processo finalizou com erro ou sucesso    */
         /**************************************************************/
         IF v_process_termination = 'OK' THEN
            kkpi_util.pkpi_terminate_process(v_cd_process_control, v_sq_process_control, 'Y');
            p_retorno := 'E0000';
         ELSE
            kkpi_util.pkpi_terminate_process(v_cd_process_control, v_sq_process_control, 'N');
            p_retorno := v_error_message;
         END IF;
         --
      EXCEPTION
         WHEN v_process_error THEN
            /*************************************/
            /*    Registrar ABORT do processo    */
            /*************************************/
            kkpi_util.pkpi_update_status(v_cd_process_control,
                                         v_sq_process_control,
                                         'PROCESS ABORTED');
            kkpi_util.pkpi_terminate_process(v_cd_process_control, v_sq_process_control, 'X');

      END;

   END pkpi_smp9;

   /**************************************************************************************/
   /*                        Procedure gerar o indicador SMP12                           */
   /**************************************************************************************/
   PROCEDURE pkpi_smp12(p_reference_date IN VARCHAR2,
                        p_varchar_array  IN kpi.varchar_array,
                        p_user_id        IN VARCHAR2,
                        p_retorno        OUT VARCHAR2) IS

      /**************************************************************************************/
      /*                                 Declaração das variáveis                           */
      /**************************************************************************************/
      v_cd_process_control  kpi.tkpi_process_control.cd_process_control%TYPE;
      v_process_termination kpi.tkpi_process_control.de_process_termination%TYPE;

      v_sq_process_control kpi.tkpi_process_control.sq_process_control%TYPE;
      v_process_error EXCEPTION;
      v_error_code    NUMBER(10);
      v_error_message VARCHAR2(500);

      CURSOR c IS
         SELECT ddd_area_code,
                attendance_center_id,
                nvl(SUM(call_answered_operator_qty), 0) call_answered_operator_qty,
                nvl(SUM(call_attempt_operator_qty), 0) call_attempt_operator_qty,
                nvl(SUM(call_answered_bigger_60sec_qty), 0) call_answered_bigger_60sec_qty
           FROM (SELECT u.ddd_area_code,
                        ac.attendance_center_id,
                        1 call_attempt_operator_qty,
                        (((to_number(to_char(u.attendance_date, 'J')) -
                        to_number(to_char(u.selection_date, 'J'))) * 86400) +
                        (to_number(to_char(u.attendance_date, 'SSSSS')) -
                        to_number(to_char(u.selection_date, 'SSSSS')))) tempo_atend_segundos,
                        CASE
                           WHEN (((to_number(to_char(u.attendance_date, 'J')) -
                                to_number(to_char(u.selection_date, 'J'))) * 86400) +
                                (to_number(to_char(u.attendance_date, 'SSSSS')) -
                                to_number(to_char(u.selection_date, 'SSSSS')))) <= 20 THEN
                            1
                           ELSE
                            0
                        END call_answered_operator_qty,
                        CASE
                           WHEN (((to_number(to_char(u.attendance_date, 'J')) -
                                to_number(to_char(u.selection_date, 'J'))) * 86400) +
                                (to_number(to_char(u.attendance_date, 'SSSSS')) -
                                to_number(to_char(u.selection_date, 'SSSSS')))) > 60 THEN
                            1
                           ELSE
                            0
                        END call_answered_bigger_60sec_qty
                   FROM kpi.lu_kpi_attendance_center ac,
                        kpi.ft_kpi_ura_detail u,
                        TABLE(p_varchar_array) va
                  WHERE ac.attendance_center_id = u.attendance_center_id
                    AND ((u.call_date BETWEEN to_date('01' || p_reference_date, 'DDYYYYMM') AND
                        last_day(to_date('01' || p_reference_date, 'DDYYYYMM')) AND
                        p_varchar_array IS NULL) OR u.call_date = va.column_value)

                    AND EXISTS (SELECT 1
                           FROM kpi.tkpi_national_code cn
                          WHERE cn.cd_national_code = u.ddd_area_code
                            AND cn.fg_xml = 'Y'
                            AND cn.fg_excluded_register = 'N'))
          GROUP BY ddd_area_code,
                   attendance_center_id;

   BEGIN

      BEGIN

         /******************************************************************/
         /*    Setar variáveis para o controle de processamento do KPI     */
         /******************************************************************/

         v_cd_process_control  := 'PKPI_SMP12';
         v_process_termination := 'OK';

         /*****************************************************************************************************************/
         /*    Gravar início do processamento na tabela de controle de processamento do kpi (KPI.TKPI_PROCESS_CONTROL)    */
         /*****************************************************************************************************************/
         kkpi_util.pkpi_start_process(v_cd_process_control, v_sq_process_control);

         kkpi_util.pkpi_update_status(v_cd_process_control,
                                      v_sq_process_control,
                                      'PROCESSING PKPI_SMP12');

         FOR r IN c
         LOOP

            BEGIN
               INSERT INTO kpi.ft_kpi_smp12
                  (indicator_id,
                   reference_date,
                   ddd_area_code,
                   attendance_center_id,
                   call_answered_operator_qty,
                   call_attempt_operator_qty,
                   call_answered_bigger_60sec_qty,
                   creating_date,
                   creating_user)
               VALUES
                  ('SMP12',
                   p_reference_date,
                   r.ddd_area_code,
                   r.attendance_center_id,
                   r.call_answered_operator_qty,
                   r.call_attempt_operator_qty,
                   r.call_answered_bigger_60sec_qty,
                   SYSDATE,
                   p_user_id);
            EXCEPTION
               WHEN OTHERS THEN
                  /***************************************************************************************************/
                  /*    Gravar o erro na tabela de controle de erros de processamento do kpi (TKPI_PROCESS_ERROR)    */
                  /***************************************************************************************************/
                  v_process_termination := 'NOT OK';
                  v_error_code          := SQLCODE;
                  v_error_message       := SQLERRM || ' # INDICATOR_ID = ' || 'SMP12' ||
                                           ' # REFERENCE_DATE = ' || p_reference_date ||
                                           ' # DDD_AREA_CODE = ' || r.ddd_area_code ||
                                           ' # ATTENDANCE_CENTER_ID = ' || r.attendance_center_id ||
                                           ' # CALL_ANSWERED_OPERATOR_QTY = ' ||
                                           r.call_answered_operator_qty ||
                                           ' # CALL_ATTEMPT_OPERATOR_QTY = ' ||
                                           r.call_attempt_operator_qty ||
                                           ' # CALL_ANSWERED_BIGGER_60SEC_QTY = ' ||
                                           r.call_answered_bigger_60sec_qty ||
                                           ' # CREATING_USER = ' || p_user_id;
                  kkpi_util.pkpi_error(v_cd_process_control,
                                       v_sq_process_control,
                                       v_error_code,
                                       v_error_message,
                                       'N');
            END;

         END LOOP;

         /**********************************************************************************************************************/
         /*   Atualizar finalização do processamento na tabela de controle de processamento do kpi (KPI.TKPI_PROCESS_CONTROL)  */
         /**********************************************************************************************************************/
         kkpi_util.pkpi_update_status(v_cd_process_control,
                                      v_sq_process_control,
                                      'PROCESS ENDED ' || v_process_termination);

         /**************************************************************/
         /*    Verifica se o processo finalizou com erro ou sucesso    */
         /**************************************************************/
         IF v_process_termination = 'OK' THEN
            kkpi_util.pkpi_terminate_process(v_cd_process_control, v_sq_process_control, 'Y');
            p_retorno := 'E0000';
         ELSE
            kkpi_util.pkpi_terminate_process(v_cd_process_control, v_sq_process_control, 'N');
            p_retorno := v_error_message;
         END IF;
         --
      EXCEPTION
         WHEN v_process_error THEN
            /*************************************/
            /*    Registrar ABORT do processo    */
            /*************************************/
            kkpi_util.pkpi_update_status(v_cd_process_control,
                                         v_sq_process_control,
                                         'PROCESS ABORTED');
            kkpi_util.pkpi_terminate_process(v_cd_process_control, v_sq_process_control, 'X');

      END;

   END pkpi_smp12;

   /**************************************************************************************/
   /*                        Procedure gerar o indicador SMP13                           */
   /**************************************************************************************/
   PROCEDURE pkpi_smp13(p_reference_date IN VARCHAR2,
                        p_user_id        IN VARCHAR2,
                        p_retorno        OUT VARCHAR2) IS

      /**************************************************************************************/
      /*                                 Declaração das variáveis                           */
      /**************************************************************************************/
      v_cd_process_control  kpi.tkpi_process_control.cd_process_control%TYPE;
      v_process_termination kpi.tkpi_process_control.de_process_termination%TYPE;

      v_sq_process_control kpi.tkpi_process_control.sq_process_control%TYPE;
      v_process_error EXCEPTION;
      v_error_code    NUMBER(10);
      v_error_message VARCHAR2(500);

      CURSOR c IS
         SELECT crm.area_billing_address_code ddd_area_code,
                nvl(SUM(crm.ticket_request_five_days_qty), 0) ticket_request_five_days_qty,
                0 ticket_request_qty,
                0 ticket_request_last_months_qty,
                nvl(SUM(crm.ticket_request_ten_days_qty), 0) ticket_request_ten_days_qty
           FROM kpi.ft_kpi_crm_ticket_detail crm
          WHERE crm.reference_date = last_day(to_date('01' || p_reference_date, 'DDYYYYMM'))
            AND EXISTS (SELECT 1
                   FROM kpi.tkpi_national_code cn
                  WHERE cn.cd_national_code = crm.area_billing_address_code
                    AND cn.fg_xml = 'Y'
                    AND cn.fg_excluded_register = 'N')
          GROUP BY crm.area_billing_address_code
         UNION
         SELECT crm.area_billing_address_code ddd_area_code,
                0 ticket_request_five_days_qty,
                nvl(SUM(crm.ticket_request_qty), 0) ticket_request_qty,
                0 ticket_request_last_months_qty,
                nvl(SUM(crm.ticket_request_ten_days_qty), 0) ticket_request_ten_days_qty
           FROM kpi.ft_kpi_crm_ticket_detail crm
          WHERE crm.reference_date BETWEEN to_date('01' || p_reference_date, 'DDYYYYMM') AND
                last_day(to_date('01' || p_reference_date, 'DDYYYYMM'))
            AND EXISTS (SELECT 1
                   FROM kpi.tkpi_national_code cn
                  WHERE cn.cd_national_code = crm.area_billing_address_code
                    AND cn.fg_xml = 'Y'
                    AND cn.fg_excluded_register = 'N')
          GROUP BY crm.area_billing_address_code
         UNION
         SELECT crmo.area_billing_address_code ddd_area_code,
                0 ticket_request_five_days_qty,
                0 ticket_request_qty,
                SUM(crmo.ticket_request_last_months_qty) ticket_request_last_months_qty,
                0 ticket_request_ten_days_qty
           FROM kpi.ft_kpi_crm_open_ticket_detail crmo
          WHERE crmo.reference_date = last_day(to_date('01' || p_reference_date, 'DDYYYYMM'))
            AND EXISTS (SELECT 1
                   FROM kpi.tkpi_national_code cn
                  WHERE cn.cd_national_code = crmo.area_billing_address_code
                    AND cn.fg_xml = 'Y'
                    AND cn.fg_excluded_register = 'N')
          GROUP BY crmo.area_billing_address_code;

   BEGIN

      BEGIN

         /******************************************************************/
         /*    Setar variáveis para o controle de processamento do KPI     */
         /******************************************************************/

         v_cd_process_control  := 'PKPI_SMP13';
         v_process_termination := 'OK';

         /*****************************************************************************************************************/
         /*    Gravar início do processamento na tabela de controle de processamento do kpi (KPI.TKPI_PROCESS_CONTROL)    */
         /*****************************************************************************************************************/
         kkpi_util.pkpi_start_process(v_cd_process_control, v_sq_process_control);

         kkpi_util.pkpi_update_status(v_cd_process_control,
                                      v_sq_process_control,
                                      'PROCESSING PKPI_SMP13');

         FOR r IN c
         LOOP

            BEGIN
               INSERT INTO kpi.ft_kpi_smp13
                  (indicator_id,
                   reference_date,
                   ddd_area_code,
                   ticket_request_five_days_qty,
                   ticket_request_qty,
                   ticket_request_last_months_qty,
                   ticket_request_ten_days_qty,
                   creating_date,
                   creating_user)
               VALUES
                  ('SMP13',
                   p_reference_date,
                   r.ddd_area_code,
                   r.ticket_request_five_days_qty,
                   r.ticket_request_qty,
                   r.ticket_request_last_months_qty,
                   r.ticket_request_ten_days_qty,
                   SYSDATE,
                   p_user_id);
            EXCEPTION
               WHEN OTHERS THEN
                  /***************************************************************************************************/
                  /*    Gravar o erro na tabela de controle de erros de processamento do kpi (TKPI_PROCESS_ERROR)    */
                  /***************************************************************************************************/
                  v_process_termination := 'NOT OK';
                  v_error_code          := SQLCODE;
                  v_error_message       := SQLERRM || ' # INDICATOR_ID = ' || 'SMP13' ||
                                           ' # REFERENCE_DATE = ' || p_reference_date ||
                                           ' # DDD_AREA_CODE = ' || r.ddd_area_code ||
                                           ' # TICKET_REQUEST_FIVE_DAYS_QTY = ' ||
                                           r.ticket_request_five_days_qty ||
                                           ' # TICKET_REQUEST_QTY = ' || r.ticket_request_qty ||
                                           ' # TICKET_REQUEST_LAST_MONTHS_QTY = ' ||
                                           r.ticket_request_last_months_qty ||
                                           ' # TICKET_REQUEST_TEN_DAYS_QTY = ' ||
                                           r.ticket_request_ten_days_qty || ' # CREATING_USER = ' ||
                                           p_user_id;
                  kkpi_util.pkpi_error(v_cd_process_control,
                                       v_sq_process_control,
                                       v_error_code,
                                       v_error_message,
                                       'N');
            END;

         END LOOP;

         /**********************************************************************************************************************/
         /*   Atualizar finalização do processamento na tabela de controle de processamento do kpi (KPI.TKPI_PROCESS_CONTROL)  */
         /**********************************************************************************************************************/
         kkpi_util.pkpi_update_status(v_cd_process_control,
                                      v_sq_process_control,
                                      'PROCESS ENDED ' || v_process_termination);

         /**************************************************************/
         /*    Verifica se o processo finalizou com erro ou sucesso    */
         /**************************************************************/
         IF v_process_termination = 'OK' THEN
            kkpi_util.pkpi_terminate_process(v_cd_process_control, v_sq_process_control, 'Y');
            p_retorno := 'E0000';
         ELSE
            kkpi_util.pkpi_terminate_process(v_cd_process_control, v_sq_process_control, 'N');
            p_retorno := v_error_message;
         END IF;
         --
      EXCEPTION
         WHEN v_process_error THEN
            /*************************************/
            /*    Registrar ABORT do processo    */
            /*************************************/
            kkpi_util.pkpi_update_status(v_cd_process_control,
                                         v_sq_process_control,
                                         'PROCESS ABORTED');
            kkpi_util.pkpi_terminate_process(v_cd_process_control, v_sq_process_control, 'X');

      END;

   END pkpi_smp13;

   /**************************************************************************************/
   /*                        Procedure gerar o indicador SMP14                           */
   /**************************************************************************************/
   PROCEDURE pkpi_smp14(p_reference_date IN VARCHAR2,
                        p_varchar_array  IN kpi.varchar_array,
                        p_user_id        IN VARCHAR2,
                        p_retorno        OUT VARCHAR2) IS

      /**************************************************************************************/
      /*                                 Declaração das variáveis                           */
      /**************************************************************************************/
      v_cd_process_control  kpi.tkpi_process_control.cd_process_control%TYPE;
      v_process_termination kpi.tkpi_process_control.de_process_termination%TYPE;

      v_sq_process_control kpi.tkpi_process_control.sq_process_control%TYPE;
      v_process_error EXCEPTION;
      v_error_code    NUMBER(10);
      v_error_message VARCHAR2(500);

      CURSOR c IS
         SELECT ddd_area_code,
                area_delivery_id,
                SUM(user_served_time_qty) user_served_time_qty,
                SUM(user_qty) user_qty
           FROM (SELECT c.ddd_area_code,
                        kads.area_delivery_id,
                        CASE
                           WHEN ((((to_number(to_char(fs.attendance_date, 'J')) -
                                to_number(to_char(fs.emission_date, 'J'))) * 86400) +
                                (to_number(to_char(fs.attendance_date, 'SSSSS')) -
                                to_number(to_char(fs.emission_date, 'SSSSS')))) / 60) <= 30 THEN
                            1
                           ELSE
                            0
                        END user_served_time_qty,
                        1 user_qty
                   FROM kpi.lu_kpi_area_delivery_state kads,
                        kpi.lu_kpi_city c,
                        kpi.lu_kpi_store s,
                        kpi.ft_kpi_store_ticket_detail fs,
                        TABLE(p_varchar_array) va
                  WHERE kads.state_code = c.state_code
                    AND c.city_code = s.city_code
                    AND s.store_id = fs.store_id
                    AND ((fs.reference_date BETWEEN to_date('01' || p_reference_date, 'DDYYYYMM') AND
                        last_day(to_date('01' || p_reference_date, 'DDYYYYMM')) AND
                        p_varchar_array IS NULL) OR fs.reference_date = va.column_value)
                    AND EXISTS (SELECT 1
                           FROM kpi.tkpi_national_code cn
                          WHERE cn.cd_national_code = c.ddd_area_code
                            AND cn.fg_xml = 'Y'
                            AND cn.fg_excluded_register = 'N'))
          GROUP BY ddd_area_code,
                   area_delivery_id;

   BEGIN

      BEGIN

         /******************************************************************/
         /*    Setar variáveis para o controle de processamento do KPI     */
         /******************************************************************/

         v_cd_process_control  := 'PKPI_SMP14';
         v_process_termination := 'OK';

         /*****************************************************************************************************************/
         /*    Gravar início do processamento na tabela de controle de processamento do kpi (KPI.TKPI_PROCESS_CONTROL)    */
         /*****************************************************************************************************************/
         kkpi_util.pkpi_start_process(v_cd_process_control, v_sq_process_control);

         kkpi_util.pkpi_update_status(v_cd_process_control,
                                      v_sq_process_control,
                                      'PROCESSING PKPI_SMP14');

         FOR r IN c
         LOOP

            BEGIN
               INSERT INTO kpi.ft_kpi_smp14
                  (indicator_id,
                   reference_date,
                   ddd_area_code,
                   area_delivery_id,
                   user_served_time_qty,
                   user_qty,
                   creating_date,
                   creating_user)
               VALUES
                  ('SMP14',
                   p_reference_date,
                   r.ddd_area_code,
                   r.area_delivery_id,
                   r.user_served_time_qty,
                   r.user_qty,
                   SYSDATE,
                   p_user_id);
            EXCEPTION
               WHEN OTHERS THEN
                  /***************************************************************************************************/
                  /*    Gravar o erro na tabela de controle de erros de processamento do kpi (TKPI_PROCESS_ERROR)    */
                  /***************************************************************************************************/
                  v_process_termination := 'NOT OK';
                  v_error_code          := SQLCODE;
                  v_error_message       := SQLERRM || ' # INDICATOR_ID = ' || 'SMP14' ||
                                           ' # REFERENCE_DATE = ' || p_reference_date ||
                                           ' # DDD_AREA_CODE = ' || r.ddd_area_code ||
                                           ' # AREA_DELIVERY_ID = ' || r.area_delivery_id ||
                                           ' # USER_SERVED_TIME_QTY = ' || r.user_served_time_qty ||
                                           ' # USER_QTY = ' || r.user_qty || ' # CREATING_USER = ' ||
                                           p_user_id;
                  kkpi_util.pkpi_error(v_cd_process_control,
                                       v_sq_process_control,
                                       v_error_code,
                                       v_error_message,
                                       'N');
            END;

         END LOOP;

         /**********************************************************************************************************************/
         /*   Atualizar finalização do processamento na tabela de controle de processamento do kpi (KPI.TKPI_PROCESS_CONTROL)  */
         /**********************************************************************************************************************/
         kkpi_util.pkpi_update_status(v_cd_process_control,
                                      v_sq_process_control,
                                      'PROCESS ENDED ' || v_process_termination);

         /**************************************************************/
         /*    Verifica se o processo finalizou com erro ou sucesso    */
         /**************************************************************/
         IF v_process_termination = 'OK' THEN
            kkpi_util.pkpi_terminate_process(v_cd_process_control, v_sq_process_control, 'Y');
            p_retorno := 'E0000';
         ELSE
            kkpi_util.pkpi_terminate_process(v_cd_process_control, v_sq_process_control, 'N');
            p_retorno := v_error_message;
         END IF;
         --
      EXCEPTION
         WHEN v_process_error THEN
            /*************************************/
            /*    Registrar ABORT do processo    */
            /*************************************/
            kkpi_util.pkpi_update_status(v_cd_process_control,
                                         v_sq_process_control,
                                         'PROCESS ABORTED');
            kkpi_util.pkpi_terminate_process(v_cd_process_control, v_sq_process_control, 'X');

      END;

   END pkpi_smp14;

   /*****************************************************************************************/
   /*               Procedure para gerar todos os indicadores para envio                    */
   /*****************************************************************************************/
   PROCEDURE pkpi_save_to_send(p_reference_date IN VARCHAR2,
                               p_varchar_array  IN kpi.varchar_array,
                               p_user_id        IN VARCHAR2,
                               p_retorno        OUT VARCHAR2) IS

      /**************************************************************************************/
      /*                                 Declaração das variáveis                           */
      /**************************************************************************************/
      v_cd_process_control  kpi.tkpi_process_control.cd_process_control%TYPE;
      v_process_termination kpi.tkpi_process_control.de_process_termination%TYPE;

      v_sq_process_control kpi.tkpi_process_control.sq_process_control%TYPE;
      v_process_error EXCEPTION;

   BEGIN

      BEGIN

         /******************************************************************/
         /*    Setar variáveis para o controle de processamento do KPI     */
         /******************************************************************/

         v_cd_process_control  := 'PKPI_SAVE_TO_SEND';
         v_process_termination := 'OK';

         /*************************************************************************************************************/
         /*    Gravar início do processamento na tabela de controle de processamento do kpi (KPI.TKPI_PROCESS_CONTROL)    */
         /*************************************************************************************************************/
         kkpi_util.pkpi_start_process(v_cd_process_control, v_sq_process_control);

         kkpi_util.pkpi_update_status(v_cd_process_control,
                                      v_sq_process_control,
                                      'PROCESSING PKPI_SAVE_TO_SEND');

         pkpi_smp1(p_reference_date, p_user_id, p_retorno);
         pkpi_smp2(p_reference_date, p_varchar_array, p_user_id, p_retorno);
         pkpi_smp3(p_reference_date, p_varchar_array, p_user_id, p_retorno);
         pkpi_smp4(p_reference_date, p_varchar_array, p_user_id, p_retorno);
         pkpi_smp5(p_reference_date, p_varchar_array, p_user_id, p_retorno);
         pkpi_smp6(p_reference_date, p_varchar_array, p_user_id, p_retorno);
         pkpi_smp7(p_reference_date, p_varchar_array, p_user_id, p_retorno);
         pkpi_smp8(p_reference_date, p_varchar_array, p_user_id, p_retorno);
         pkpi_smp9(p_reference_date, p_varchar_array, p_user_id, p_retorno);
         pkpi_smp12(p_reference_date, p_varchar_array, p_user_id, p_retorno);
         pkpi_smp13(p_reference_date, p_user_id, p_retorno);
         pkpi_smp14(p_reference_date, p_varchar_array, p_user_id, p_retorno);

         /******************************************************************************************************************/
         /*   Atualizar finalização do processamento na tabela de controle de processamento do kpi (KPI.TKPI_PROCESS_CONTROL)  */
         /******************************************************************************************************************/
         kkpi_util.pkpi_update_status(v_cd_process_control,
                                      v_sq_process_control,
                                      'PROCESS ENDED ' || v_process_termination);

         /**************************************************************/
         /*    Verifica se o processo finalizou com erro ou sucesso    */
         /**************************************************************/
         IF v_process_termination = 'OK' THEN
            kkpi_util.pkpi_terminate_process(v_cd_process_control, v_sq_process_control, 'Y');
            p_retorno := 'E0000';
         ELSE
            kkpi_util.pkpi_terminate_process(v_cd_process_control, v_sq_process_control, 'N');
            p_retorno := 'ERRO - SEQUENCE: ' || v_sq_process_control;
         END IF;

      EXCEPTION
         WHEN v_process_error THEN
            /*************************************/
            /*    Registrar ABORT do processo    */
            /*************************************/
            kkpi_util.pkpi_update_status(v_cd_process_control,
                                         v_sq_process_control,
                                         'PROCESS ABORTED');
            kkpi_util.pkpi_terminate_process(v_cd_process_control, v_sq_process_control, 'X');

      END;

   END pkpi_save_to_send;

   /**************************************************************************************/
   /*              Procedure para enviar todos os indicadores para a Anatel              */
   /**************************************************************************************/
   PROCEDURE pkpi_send(p_reference_date IN VARCHAR2,
                       p_user_id        IN VARCHAR2,
                       p_id_file        OUT VARCHAR2,
                       p_retorno        OUT VARCHAR2) IS

      /**************************************************************************************/
      /*                                 Declaração das variáveis                           */
      /**************************************************************************************/
      v_cd_process_control  kpi.tkpi_process_control.cd_process_control%TYPE;
      v_process_termination kpi.tkpi_process_control.de_process_termination%TYPE;

      v_sq_process_control kpi.tkpi_process_control.sq_process_control%TYPE;
      v_process_error EXCEPTION;
      v_error_code          NUMBER(10);
      v_error_message       VARCHAR2(500);
      v_id_send_anatel      kpi.tkpi_send_anatel.id_send_anatel%TYPE;
      v_dt_start_competence kpi.tkpi_send_anatel.dt_start_competence%TYPE;
      v_dt_end_competence   kpi.tkpi_send_anatel.dt_end_competence%TYPE;
      v_id_file             kpi.tkpi_send_anatel.id_file%TYPE;

   BEGIN

      BEGIN

         /******************************************************************/
         /*    Setar variáveis para o controle de processamento do KPI     */
         /******************************************************************/

         v_cd_process_control  := 'PKPI_SEND';
         v_process_termination := 'OK';

         /*****************************************************************************************************************/
         /*    Gravar início do processamento na tabela de controle de processamento do kpi (KPI.TKPI_PROCESS_CONTROL)    */
         /*****************************************************************************************************************/
         kkpi_util.pkpi_start_process(v_cd_process_control, v_sq_process_control);

         kkpi_util.pkpi_update_status(v_cd_process_control,
                                      v_sq_process_control,
                                      'PROCESSING PKPI_SEND');

         BEGIN
            SELECT kpi.skpi_id_send_anatel.nextval INTO v_id_send_anatel FROM dual;
         EXCEPTION
            WHEN OTHERS THEN
               /***************************************************************************************************/
               /*    Gravar o erro na tabela de controle de erros de processamento do kpi (TKPI_PROCESS_ERROR)    */
               /***************************************************************************************************/
               v_process_termination := 'NOT OK';
               v_error_code          := SQLCODE;
               v_error_message       := SQLERRM || ' # SKPI_ID_SEND_ANATEL = ' || v_id_send_anatel;
               kkpi_util.pkpi_error(v_cd_process_control,
                                    v_sq_process_control,
                                    v_error_code,
                                    v_error_message,
                                    'N');
         END;

         v_dt_start_competence := to_date('01' || p_reference_date, 'DDYYYYMM');
         v_dt_end_competence   := last_day(to_date('01' || p_reference_date, 'DDYYYYMM'));

         v_id_file := 'NXT' || substr(p_reference_date, 1, 4) ||
                      lpad(TRIM(v_id_send_anatel), 4, '0');

         BEGIN
            INSERT INTO kpi.tkpi_send_anatel
               (id_send_anatel,
                dt_start_competence,
                dt_end_competence,
                dt_send_anatel,
                id_user_send_anatel,
                id_file)
            VALUES
               (v_id_send_anatel,
                v_dt_start_competence,
                v_dt_end_competence,
                SYSDATE,
                p_user_id,
                v_id_file);
         EXCEPTION
            WHEN OTHERS THEN
               /***************************************************************************************************/
               /*    Gravar o erro na tabela de controle de erros de processamento do kpi (TKPI_PROCESS_ERROR)    */
               /***************************************************************************************************/
               v_process_termination := 'NOT OK';
               v_error_code          := SQLCODE;
               v_error_message       := SQLERRM || ' # ID_SEND_ANATEL = ' || v_id_send_anatel ||
                                        ' # DT_START_COMPETENCE = ' || v_dt_start_competence ||
                                        ' # DT_END_COMPETENCE = ' || v_dt_end_competence ||
                                        ' # ID_USER_SEND_ANATEL = ' || p_user_id || ' # ID_FILE = ' ||
                                        v_id_file;
               kkpi_util.pkpi_error(v_cd_process_control,
                                    v_sq_process_control,
                                    v_error_code,
                                    v_error_message,
                                    'N');
         END;

         -- Após envio, atualizar a próxima competência a ser enviada
         BEGIN
            UPDATE kpi.tkpi_parameter
               SET va_parameter = to_char(add_months(to_date('01' || va_parameter, 'DDYYYYMM'), 1),
                                          'YYYYMM')
             WHERE de_parameter = 'PROXIMA_COMPETENCIA';
         EXCEPTION
            WHEN OTHERS THEN
               /***************************************************************************************************/
               /*    Gravar o erro na tabela de controle de erros de processamento do kpi (TKPI_PROCESS_ERROR)    */
               /***************************************************************************************************/
               v_process_termination := 'NOT OK';
               v_error_code          := SQLCODE;
               v_error_message       := SQLERRM || ' # DE_PARAMETER = ' || 'PROXIMA_COMPETENCIA';
               kkpi_util.pkpi_error(v_cd_process_control,
                                    v_sq_process_control,
                                    v_error_code,
                                    v_error_message,
                                    'N');
         END;

         /**********************************************************************************************************************/
         /*   Atualizar finalização do processamento na tabela de controle de processamento do kpi (KPI.TKPI_PROCESS_CONTROL)  */
         /**********************************************************************************************************************/
         kkpi_util.pkpi_update_status(v_cd_process_control,
                                      v_sq_process_control,
                                      'PROCESS ENDED ' || v_process_termination);

         /**************************************************************/
         /*    Verifica se o processo finalizou com erro ou sucesso    */
         /**************************************************************/
         IF v_process_termination = 'OK' THEN
            kkpi_util.pkpi_terminate_process(v_cd_process_control, v_sq_process_control, 'Y');
            p_id_file := v_id_file;
            p_retorno := 'E0000';
         ELSE
            kkpi_util.pkpi_terminate_process(v_cd_process_control, v_sq_process_control, 'N');
            p_id_file := NULL;
            p_retorno := v_error_message;
         END IF;
         --
      EXCEPTION
         WHEN v_process_error THEN
            /*************************************/
            /*    Registrar ABORT do processo    */
            /*************************************/
            kkpi_util.pkpi_update_status(v_cd_process_control,
                                         v_sq_process_control,
                                         'PROCESS ABORTED');
            kkpi_util.pkpi_terminate_process(v_cd_process_control, v_sq_process_control, 'X');

      END;

   END pkpi_send;

   /**************************************************************************************/
   /*                            Procedure para retificação                              */
   /**************************************************************************************/
   PROCEDURE pkpi_correct(p_reference_date IN VARCHAR2,
                          p_retorno        OUT VARCHAR2) IS

      /**************************************************************************************/
      /*                                 Declaração das variáveis                           */
      /**************************************************************************************/
      v_cd_process_control  kpi.tkpi_process_control.cd_process_control%TYPE;
      v_process_termination kpi.tkpi_process_control.de_process_termination%TYPE;

      v_sq_process_control kpi.tkpi_process_control.sq_process_control%TYPE;
      v_process_error EXCEPTION;
      v_error_code    NUMBER(10);
      v_error_message VARCHAR2(500);
      v_indicator_id  kpi.ft_kpi_indicator_approved.indicator_id%TYPE;

   BEGIN

      BEGIN

         /******************************************************************/
         /*    Setar variáveis para o controle de processamento do KPI     */
         /******************************************************************/

         v_cd_process_control  := 'PKPI_CORRECT';
         v_process_termination := 'OK';

         /*****************************************************************************************************************/
         /*    Gravar início do processamento na tabela de controle de processamento do kpi (KPI.TKPI_PROCESS_CONTROL)    */
         /*****************************************************************************************************************/
         kkpi_util.pkpi_start_process(v_cd_process_control, v_sq_process_control);

         kkpi_util.pkpi_update_status(v_cd_process_control,
                                      v_sq_process_control,
                                      'PROCESSING PKPI_CORRECT');

         BEGIN
            DELETE kpi.ft_kpi_smp1
             WHERE indicator_id = 'SMP1'
               AND reference_date = p_reference_date;
         EXCEPTION
            WHEN OTHERS THEN
               /*************************************************************************************************/
               /*    Gravar o erro na tabela de controle de erros de processamento do kpi (TKPI_PROCESS_ERROR)  */
               /*************************************************************************************************/
               v_process_termination := 'NOT OK';
               v_error_code          := SQLCODE;
               v_error_message       := SQLERRM || ' # INDICATOR_ID = ' || 'SMP1' ||
                                        ' # REFERENCE_DATE = ' || p_reference_date;
               kkpi_util.pkpi_error(v_cd_process_control,
                                    v_sq_process_control,
                                    v_error_code,
                                    v_error_message,
                                    'N');
         END;

         BEGIN
            DELETE kpi.ft_kpi_smp2
             WHERE indicator_id = 'SMP2'
               AND reference_date = p_reference_date;
         EXCEPTION
            WHEN OTHERS THEN
               /*************************************************************************************************/
               /*    Gravar o erro na tabela de controle de erros de processamento do kpi (TKPI_PROCESS_ERROR)  */
               /*************************************************************************************************/
               v_process_termination := 'NOT OK';
               v_error_code          := SQLCODE;
               v_error_message       := SQLERRM || ' # INDICATOR_ID = ' || 'SMP2' ||
                                        ' # REFERENCE_DATE = ' || p_reference_date;
               kkpi_util.pkpi_error(v_cd_process_control,
                                    v_sq_process_control,
                                    v_error_code,
                                    v_error_message,
                                    'N');
         END;

         BEGIN
            DELETE kpi.ft_kpi_smp3
             WHERE indicator_id = 'SMP3'
               AND reference_date = p_reference_date;
         EXCEPTION
            WHEN OTHERS THEN
               /*************************************************************************************************/
               /*    Gravar o erro na tabela de controle de erros de processamento do kpi (TKPI_PROCESS_ERROR)  */
               /*************************************************************************************************/
               v_process_termination := 'NOT OK';
               v_error_code          := SQLCODE;
               v_error_message       := SQLERRM || ' # INDICATOR_ID = ' || 'SMP3' ||
                                        ' # REFERENCE_DATE = ' || p_reference_date;
               kkpi_util.pkpi_error(v_cd_process_control,
                                    v_sq_process_control,
                                    v_error_code,
                                    v_error_message,
                                    'N');
         END;

         BEGIN
            DELETE kpi.ft_kpi_smp4
             WHERE indicator_id = 'SMP4'
               AND reference_date = p_reference_date;
         EXCEPTION
            WHEN OTHERS THEN
               /*************************************************************************************************/
               /*    Gravar o erro na tabela de controle de erros de processamento do kpi (TKPI_PROCESS_ERROR)  */
               /*************************************************************************************************/
               v_process_termination := 'NOT OK';
               v_error_code          := SQLCODE;
               v_error_message       := SQLERRM || ' # INDICATOR_ID = ' || 'SMP4' ||
                                        ' # REFERENCE_DATE = ' || p_reference_date;
               kkpi_util.pkpi_error(v_cd_process_control,
                                    v_sq_process_control,
                                    v_error_code,
                                    v_error_message,
                                    'N');
         END;

         BEGIN
            DELETE kpi.ft_kpi_smp5
             WHERE indicator_id = 'SMP5'
               AND reference_date = p_reference_date;
         EXCEPTION
            WHEN OTHERS THEN
               /*************************************************************************************************/
               /*    Gravar o erro na tabela de controle de erros de processamento do kpi (TKPI_PROCESS_ERROR)  */
               /*************************************************************************************************/
               v_process_termination := 'NOT OK';
               v_error_code          := SQLCODE;
               v_error_message       := SQLERRM || ' # INDICATOR_ID = ' || 'SMP5' ||
                                        ' # REFERENCE_DATE = ' || p_reference_date;
               kkpi_util.pkpi_error(v_cd_process_control,
                                    v_sq_process_control,
                                    v_error_code,
                                    v_error_message,
                                    'N');
         END;

         BEGIN
            DELETE kpi.ft_kpi_smp6
             WHERE indicator_id = 'SMP6'
               AND reference_date = p_reference_date;
         EXCEPTION
            WHEN OTHERS THEN
               /*************************************************************************************************/
               /*    Gravar o erro na tabela de controle de erros de processamento do kpi (TKPI_PROCESS_ERROR)  */
               /*************************************************************************************************/
               v_process_termination := 'NOT OK';
               v_error_code          := SQLCODE;
               v_error_message       := SQLERRM || ' # INDICATOR_ID = ' || 'SMP6' ||
                                        ' # REFERENCE_DATE = ' || p_reference_date;
               kkpi_util.pkpi_error(v_cd_process_control,
                                    v_sq_process_control,
                                    v_error_code,
                                    v_error_message,
                                    'N');
         END;

         BEGIN
            DELETE kpi.ft_kpi_smp7
             WHERE indicator_id = 'SMP7'
               AND reference_date = p_reference_date;
         EXCEPTION
            WHEN OTHERS THEN
               /*************************************************************************************************/
               /*    Gravar o erro na tabela de controle de erros de processamento do kpi (TKPI_PROCESS_ERROR)  */
               /*************************************************************************************************/
               v_process_termination := 'NOT OK';
               v_error_code          := SQLCODE;
               v_error_message       := SQLERRM || ' # INDICATOR_ID = ' || 'SMP7' ||
                                        ' # REFERENCE_DATE = ' || p_reference_date;
               kkpi_util.pkpi_error(v_cd_process_control,
                                    v_sq_process_control,
                                    v_error_code,
                                    v_error_message,
                                    'N');
         END;

         BEGIN
            DELETE kpi.ft_kpi_smp8
             WHERE indicator_id = 'SMP8'
               AND reference_date = p_reference_date;
         EXCEPTION
            WHEN OTHERS THEN
               /*************************************************************************************************/
               /*    Gravar o erro na tabela de controle de erros de processamento do kpi (TKPI_PROCESS_ERROR)  */
               /*************************************************************************************************/
               v_process_termination := 'NOT OK';
               v_error_code          := SQLCODE;
               v_error_message       := SQLERRM || ' # INDICATOR_ID = ' || 'SMP8' ||
                                        ' # REFERENCE_DATE = ' || p_reference_date;
               kkpi_util.pkpi_error(v_cd_process_control,
                                    v_sq_process_control,
                                    v_error_code,
                                    v_error_message,
                                    'N');
         END;

         BEGIN
            DELETE kpi.ft_kpi_smp9
             WHERE indicator_id = 'SMP9'
               AND reference_date = p_reference_date;
         EXCEPTION
            WHEN OTHERS THEN
               /*************************************************************************************************/
               /*    Gravar o erro na tabela de controle de erros de processamento do kpi (TKPI_PROCESS_ERROR)  */
               /*************************************************************************************************/
               v_process_termination := 'NOT OK';
               v_error_code          := SQLCODE;
               v_error_message       := SQLERRM || ' # INDICATOR_ID = ' || 'SMP9' ||
                                        ' # REFERENCE_DATE = ' || p_reference_date;
               kkpi_util.pkpi_error(v_cd_process_control,
                                    v_sq_process_control,
                                    v_error_code,
                                    v_error_message,
                                    'N');
         END;

         BEGIN
            DELETE kpi.ft_kpi_smp12
             WHERE indicator_id = 'SMP12'
               AND reference_date = p_reference_date;
         EXCEPTION
            WHEN OTHERS THEN
               /*************************************************************************************************/
               /*    Gravar o erro na tabela de controle de erros de processamento do kpi (TKPI_PROCESS_ERROR)  */
               /*************************************************************************************************/
               v_process_termination := 'NOT OK';
               v_error_code          := SQLCODE;
               v_error_message       := SQLERRM || ' # INDICATOR_ID = ' || 'SMP12' ||
                                        ' # REFERENCE_DATE = ' || p_reference_date;
               kkpi_util.pkpi_error(v_cd_process_control,
                                    v_sq_process_control,
                                    v_error_code,
                                    v_error_message,
                                    'N');
         END;

         BEGIN
            DELETE kpi.ft_kpi_smp13
             WHERE indicator_id = 'SMP13'
               AND reference_date = p_reference_date;
         EXCEPTION
            WHEN OTHERS THEN
               /*************************************************************************************************/
               /*    Gravar o erro na tabela de controle de erros de processamento do kpi (TKPI_PROCESS_ERROR)  */
               /*************************************************************************************************/
               v_process_termination := 'NOT OK';
               v_error_code          := SQLCODE;
               v_error_message       := SQLERRM || ' # INDICATOR_ID = ' || 'SMP13' ||
                                        ' # REFERENCE_DATE = ' || p_reference_date;
               kkpi_util.pkpi_error(v_cd_process_control,
                                    v_sq_process_control,
                                    v_error_code,
                                    v_error_message,
                                    'N');
         END;

         BEGIN
            DELETE kpi.ft_kpi_smp14
             WHERE indicator_id = 'SMP14'
               AND reference_date = p_reference_date;
         EXCEPTION
            WHEN OTHERS THEN
               /*************************************************************************************************/
               /*    Gravar o erro na tabela de controle de erros de processamento do kpi (TKPI_PROCESS_ERROR)  */
               /*************************************************************************************************/
               v_process_termination := 'NOT OK';
               v_error_code          := SQLCODE;
               v_error_message       := SQLERRM || ' # INDICATOR_ID = ' || 'SMP14' ||
                                        ' # REFERENCE_DATE = ' || p_reference_date;
               kkpi_util.pkpi_error(v_cd_process_control,
                                    v_sq_process_control,
                                    v_error_code,
                                    v_error_message,
                                    'N');
         END;

         FOR i IN 1 .. 14
         LOOP

            v_indicator_id := 'SMP' || i;

            IF v_indicator_id NOT IN ('SMP10', 'SMP11') THEN

               BEGIN
                  DELETE kpi.ft_kpi_indicator_approved
                   WHERE indicator_id = v_indicator_id
                     AND reference_date = p_reference_date;
               EXCEPTION
                  WHEN OTHERS THEN
                     /***************************************************************************************************/
                     /*    Gravar o erro na tabela de controle de erros de processamento do kpi (TKPI_PROCESS_ERROR)    */
                     /***************************************************************************************************/
                     v_process_termination := 'NOT OK';
                     v_error_code          := SQLCODE;
                     v_error_message       := SQLERRM || ' # V_INDICATOR_ID = ' || v_indicator_id ||
                                              ' # REFERENCE_DATE = ' || p_reference_date;
                     kkpi_util.pkpi_error(v_cd_process_control,
                                          v_sq_process_control,
                                          v_error_code,
                                          v_error_message,
                                          'N');
               END;

            END IF;

         END LOOP;

         /**********************************************************************************************************************/
         /*   Atualizar finalização do processamento na tabela de controle de processamento do kpi (KPI.TKPI_PROCESS_CONTROL)  */
         /**********************************************************************************************************************/
         kkpi_util.pkpi_update_status(v_cd_process_control,
                                      v_sq_process_control,
                                      'PROCESS ENDED ' || v_process_termination);

         /**************************************************************/
         /*    Verifica se o processo finalizou com erro ou sucesso    */
         /**************************************************************/
         IF v_process_termination = 'OK' THEN
            kkpi_util.pkpi_terminate_process(v_cd_process_control, v_sq_process_control, 'Y');
            p_retorno := 'E0000';
         ELSE
            kkpi_util.pkpi_terminate_process(v_cd_process_control, v_sq_process_control, 'N');
            p_retorno := v_error_message;
         END IF;
         --
      EXCEPTION
         WHEN v_process_error THEN
            /*************************************/
            /*    Registrar ABORT do processo    */
            /*************************************/
            kkpi_util.pkpi_update_status(v_cd_process_control,
                                         v_sq_process_control,
                                         'PROCESS ABORTED');
            kkpi_util.pkpi_terminate_process(v_cd_process_control, v_sq_process_control, 'X');

      END;

   END pkpi_correct;

END kkpi_kpicb;
/
