18:19:37 D3NXTL15.OP_PNET2>
18:19:38 D3NXTL15.OP_PNET2>/
from dba_tables where owner = 'GRT'
*
ERROR at line 2:
ORA-00936: missing expression


18:19:39 D3NXTL15.OP_PNET2>ed
Wrote file LIXO.SQL

  1  select 'drop table grt.' || table_name || ';'
  2* from dba_tables where owner = 'GRT'
18:19:49 D3NXTL15.OP_PNET2>
18:19:49 D3NXTL15.OP_PNET2>/

'DROPTABLEGRT.'||TABLE_NAME||';'
----------------------------------------------
drop table grt.ACCESS_PRICE;
drop table grt.ACCESS_PRICE_ITEMS;
drop table grt.ADDRESS;
drop table grt.ANSWERABLE_CONTRACT_UNIT;
drop table grt.ANSWERABLE_UNIT;
drop table grt.ANSWERABLE_USER_EMPLOYEE;
drop table grt.AREA_CODE;
drop table grt.ATTACHMENT_FILES;
drop table grt.ATUALIZATION_TYPE;
drop table grt.AVERAGE;
drop table grt.AVERAGE_CC;
drop table grt.BAND_BRANCH;
drop table grt.BKP_CRM_SETUP;
drop table grt.BULLETIN_TYPE;
drop table grt.CARACTERISTIC;
drop table grt.COMPANY;
drop table grt.COMPANY_CODE_CONVERTION;
drop table grt.COMPANY_INVOLVED;
drop table grt.COMPANY_TYPE;
drop table grt.COMPANY_TYPE_CATEGORY;
drop table grt.COMPETITIVE;
drop table grt.COMPONENT;
drop table grt.COMPONENT_RULES;
drop table grt.CONCESSION_AREA;
drop table grt.CONNECTOR;
drop table grt.CONTRACT;
drop table grt.CONTRACT_APPEND;
drop table grt.CONTRACT_FORM;
drop table grt.CONTRACT_PRODUCT;
drop table grt.CONTRACT_PRODUCT_APPEND;
drop table grt.CONTRACT_PRODUCT_TYPE;
drop table grt.CONTRACT_SERVICE;
drop table grt.CONTRACT_TYPE;
drop table grt.CONTR_PRODUCT_ASSOC_EQUIP;
drop table grt.CONTR_PRODUCT_ASSOC_VALUES;
drop table grt.COST_CENTER;
drop table grt.CRM_SETUP;
drop table grt.DATA;
drop table grt.DELIN;
drop table grt.DUE_DATE;
drop table grt.EBP_LOGGED_USER_PROFILE;
drop table grt.EBP_PROFILE;
drop table grt.EBP_SYSTEMPARAM;
drop table grt.EBP_UEPROFILE;
drop table grt.EBP_VALIDITYPROFILE_EMPLOYEE;
drop table grt.EILD_DATA;
drop table grt.EILD_INDICATORS;
drop table grt.EILD_INDICATORS_IDLIST;
drop table grt.EILD_TAX;
drop table grt.EILD_TAX_TYPE;
drop table grt.EMPLOYEE;
drop table grt.EMPLOYEE_TYPE;
drop table grt.EMPLOYEE_UNIT;
drop table grt.EQUIPAMENT;
drop table grt.EQUIPAMENT_TYPE;
drop table grt.ERRO_EVENTO_CADASTRO;
drop table grt.FATURA;
drop table grt.FILE_NAME;
drop table grt.FINALITY;
drop table grt.FINALITY_DETAIL;
drop table grt.FINALITY_PRODUCT_TYPE;
drop table grt.FREQUENCY;
drop table grt.GOAL_INDICATOR;
drop table grt.HIST_GOAL_VALUE;
drop table grt.INDICATOR;
drop table grt.INTENTION;
drop table grt.INTERFACE;
drop table grt.LIMIT;
drop table grt.LINE_TYPE;
drop table grt.LOCALITY;
drop table grt.LOCAL_CALL_PERCENT;
drop table grt.MOBILE;
drop table grt.MODALITY;
drop table grt.NET_SETUP;
drop table grt.OCCUPATION;
drop table grt.OCCUPATION_LINK;
drop table grt.OCCURRENCE_TYPE;
drop table grt.ORGANIZATION_UNIT;
drop table grt.ORGANIZATION_UNIT_PERCENT;
drop table grt.ORG_UNIT_X_ORG_UNIT;
drop table grt.PABX;
drop table grt.PAYMENT_TYPE;
drop table grt.POINT;
drop table grt.POINT_EQUIPAMENT;
drop table grt.PRICE_TYPE;
drop table grt.PRODUCT;
drop table grt.PRODUCT_CENTRAL;
drop table grt.PRODUCT_CLASS;
drop table grt.PRODUCT_EQUIPAMENT;
drop table grt.PRODUCT_TYPE;
drop table grt.PRODUCT_TYPE_ACCESS_TYPE;
drop table grt.PRODUCT_TYPE_COMPONENT;
drop table grt.PRODUCT_TYPE_EQUIPAMENT_TYPE;
drop table grt.PROPERTY;
drop table grt.QUALITY;
drop table grt.RECURRENT_PRODUCT_TYPE;
drop table grt.RECURRENT_SERVICE_TAX;
drop table grt.RECURRENT_TYPE;
drop table grt.ROUTE;
drop table grt.SECURITY_HISTORIC;
drop table grt.SEQUENCE_SERVICE;
drop table grt.SEQUENCE_TABLE;
drop table grt.SERVICE;
drop table grt.SERVICE_EXTRACTION_CONTROL;
drop table grt.SERVICE_TYPE_BILL_CONVERTION;
drop table grt.SLA;
drop table grt.SLA_CLOSING;
drop table grt.SLA_EVENT_TYPE;
drop table grt.SLA_FINANC;
drop table grt.SLA_FORNEC;
drop table grt.SLA_FORNEC_X_EILD;
drop table grt.SLA_TEC;
drop table grt.SPEED;
drop table grt.STATE;
drop table grt.STATUS;
drop table grt.STEP;
drop table grt.STREET;
drop table grt.STREET_TYPE;
drop table grt.SUBSIDIARY;
drop table grt.SUM_DELIN;
drop table grt.SUM_SLA_CLOSING;
drop table grt.TABLE_LOG;
drop table grt.TAX_TYPE;
drop table grt.TICKET;
drop table grt.TMP_CONF;
drop table grt.TMP_CORRECAO;
drop table grt.TMP_CPQD_EILD_DATA;
drop table grt.TMP_LOG_UNIQUE_LINK;
drop table grt.TMP_MIGRACAO;
drop table grt.TMP_MIGRACAO_PONTA_A;
drop table grt.TMP_NEW_MIGRACAO;
drop table grt.TMP_PLAN_NOVO_ENDERECO;
drop table grt.TRANSMISSION;
drop table grt.TWE_PRODUTO_DEFAULT;
drop table grt.T_SEC_AUDITORIA;
drop table grt.T_SEC_AUD_HABILITACAO;
drop table grt.T_SEC_CHAVES;
drop table grt.T_SEC_CHAVE_COMPONENTE;
drop table grt.T_SEC_DOMINIO;
drop table grt.T_SEC_ERRO_LOGIN;
drop table grt.T_SEC_HISTORICO_SENHA;
drop table grt.T_SEC_LOGIN;
drop table grt.T_SEC_PERFIL;
drop table grt.T_SEC_PERFIL_PERMISSAO;
drop table grt.T_SEC_PERIODO_DATA;
drop table grt.T_SEC_PERIODO_HORA;
drop table grt.T_SEC_PERMISSAO;
drop table grt.T_SEC_USUARIO;
drop table grt.T_SEC_USUARIO_DOMINIO;
drop table grt.T_SEC_USUARIO_PERFIL;
drop table grt.T_SEC_USUARIO_PERFIL_DOMINIO;
drop table grt.UNAVAILABLE;
drop table grt.UNION_TYPE;
drop table grt.UNIT_TYPE;
drop table grt.VALUE_NEGOCIATED;
drop table grt.VERSION_DB;
drop table grt.VERSION_DB_COMP;
drop table grt.VIABILITY;
drop table grt.VOICE;
drop table grt.WIRED;

160 rows selected.

18:19:53 D3NXTL15.OP_PNET2>spool off
