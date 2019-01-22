UNDEF REQUESTOR

COL REQUEST_ID			HEADING "REQ_ID"
COL PARENT_REQUEST_ID		HEADING	"PAR_REQ_ID"
COL REQUESTED_START_DATE	HEADING "Req Start"
COL ACTUAL_START_DATE		HEADING	"Start"
COL ACTUAL_COMPLETION_DATE	HEADING "End"
COL DESCRIPTION 		FORMAT A15 TRUNCATE
COL PROGRAM			FORMAT A80 TRUNCATE
COL REQUESTOR			FORMAT A10
COL ARGUMENT_TEXT		FORMAT A30
COL COMPLETION_TEXT		FORMAT A20

ACCEPT vrequest_id 	number PROMPT "Informe o request_id ou <ENTER>: "
ACCEPT vdays		number PROMPT "Informe o no. de dias para verificação (default 3): "
ACCEPT vrequestor 	char PROMPT "Informe o username do solicitante ou <ENTER>: "

DEF REQUESTOR=&vrequestor
DEF REQUEST_ID=&vrequest_id
DEF DAYS=&vdays

Select   /*+ use_concat */
         request_id
       , parent_request_id
       , phase_code
       , status_code
       , requested_start_date
       , TO_CHAR ( actual_start_date, 'HH24:MI:SS' ) actual_start_date
       , TO_CHAR ( actual_completion_date, 'HH24:MI:SS' ) actual_completion_date
       , program
       , requestor
       , argument_text
       , completion_text
       , program_short_name
       , description
       , request_type
       , responsibility_id
    From apps.fnd_conc_req_summary_v
   Where (    ( parent_request_id = NVL ( &&request_id, parent_request_id ) And request_type = 'S' )
           Or (    request_id = NVL ( &&request_id, request_id )
                Or (    ( priority_request_id = NVL ( &&request_id, priority_request_id ) And request_type = 'P' )
                     Or ( parent_request_id = NVL ( &&request_id, parent_request_id ) And request_type = 'P' )
                   )
                Or (     priority_request_id = NVL ( &&request_id, priority_request_id )
                     And ( has_sub_request = 'Y' Or is_sub_request = 'Y' )
                   )
              )
         )
     And ( requestor = NVL ( '&&requestor', requestor ))
     And TRUNC ( request_date ) >= TRUNC ( SYSDATE - &days)
Order By 1 Desc
/