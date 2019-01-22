22:12:08 E2NXTL03.IT_PNET3>select dbms_metadata.get_ddl('PACKAGE','FND_REQUEST','APPS) from dual;
ERROR:
ORA-01756: string entre aspas não finalizada adequadamente


22:12:29 E2NXTL03.IT_PNET3>select dbms_metadata.get_ddl('PACKAGE','FND_REQUEST','APPS') from dual;

DBMS_METADATA.GET_DDL('PACKAGE','FND_REQUEST','APPS')
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

  CREATE OR REPLACE PACKAGE "APPS"."FND_REQUEST" AUTHID CURRENT_USER as
/* $Header: AFCPREQS.pls 120.7.12010000.5 2010/04/10 15:27:16 pferguso ship $ */
/*#
 * Contains concurrent processing related utilities
 * @rep:scope public
 * @rep:product FND
 * @rep:displayname Concurrent Request
 * @rep:category BUSINESS_ENTITY FND_CP_REQUEST
 * @rep:lifecycle active
 * @rep:compatibility S
 */

--
-- Package
--   FND_REQUEST
--
-- Purpose
--   Concurrent processing related utilities
--
-- History
--   XX-XXX-93	Ram Bhoopalam		Created
--   08-FEB-94	H Pelimuhandiram	Gave life
--

  --
  -- PUBLIC VARIABLES
  --

  -- Exceptions

  -- Exception Pragmas

  --
  -- PUBLIC FUNCTIONS
  --

  --
  -- Name
  --   set_mode
  -- Purpose
  --   Called before submitting request to set mode to 'database trigger'
  --
  -- Arguments
  --   db_trigger	- Set to TRUE for database trigger mode
  --
/*#
 * Called before submitting a request to set the database trigger mode
 * @param db_trigger Set to TRUE if the request is submitted from a database trigger
 * @return Returns TRUE on successful completion
 * @rep:displayname Set database trigger mode
 * @rep:scope public
 * @rep:lifecycle active
 */
  function set_mode (db_trigger  IN boolean) return boolean;
  pragma restrict_references (set_mode, WNDS, RNDS);

  --
  -- Name
  --   set_options
  -- Purpose
  --   Called before submitting request to set request attributes
  --
  -- Arguments
  --   implicit		- nature of the request to be submitted
  --			- NO/YES/ERROR/WARNING
  --   protected	- Is the request protected against updates
  --			- YES/NO  default is NO
  --   language		- NLS language
  --   territory	- Language territory
  --   datagroup
  --   numeric_characters - NLS Numeric Characters
  --
/*#
 * Sets miscellaneous request options
 * @param implicit Determines whether to display the concurrent request in the end user's concurrent request form.
 * Takes values 'NO', 'YES','ERROR','WARNING'.
 * @param protected Specify 'YES' if the request is protected against updates, otherwise specify 'NO'
 * @param language Indicates NLS languages. Defaults to the current language if left NULL
 * @param territory Indicates language territory. Defaults to the current language territory if left NULL
 * @return Returns TRUE on successful completion,FALSE otherwise
 * @rep:displayname Set Request Options
 * @rep:scope public
 * @rep:lifecycle active
 * @rep:compatibility S
 */
  function set_options (implicit  IN varchar2 default 'NO',
		        protected IN varchar2 default 'NO',
		        language  IN varchar2 default NULL,
		        territory IN varchar2 default NULL,
		        datagroup IN varchar2 default NULL,
		        numeric_characters IN varchar2 default NULL)
			return boolean;
  pragma restrict_references (set_options, WNDS);


procedure set_dest_ops(ops_id IN number default NULL);

procedure set_org_id(org_id IN number default NULL);

  --
  -- Name
  --   set_repeat_options
  -- Purpose
  --   Called before submitting request if the request to be submitted
  --   is a repeating request.
  --
  -- Arguments
  --   repeat_time	- Time of day at which it has to be repeated
  --   repeat_interval  - Frequency at which it has to be repeated
  --			- This will be used/applied only when repeat_time
  --			- is NULL
  --   repeat_unit	- Unit for repeat interval. Default is DAYS
  --			- MONTHS/DAYS/HOURS/MINUTES
  --   repeat_type	- Apply repeat interval from START or END of request
  --			- default is START. START/END
  --   repeat_end_time  - Time at which the repetition should be stopped
  --
/*#
 * Sets scheduling options for the concurrent request
 * @param repeat_time The time of the day to repeat the concurrent request
 * @param repeat_interval Interval between the re-submissions of the request
 * @param repeat_unit The unit of time used along with repeat_interval to specify the time between resubmissions of the request.
 * This parameter applies only when repeat_time is NULL.
 * @param repeat_type Determines whether to apply the re-submission interval from either the 'START' or the 'END' of the request's
 * execution. This parameter applies only when repeat_time is NULL.
 * @param repeat_end_time The date and time to stop resubmitting the concurrent request,
 * formatted as either 'DD-MON-YYYY HH24:MI:SS' or 'DD-MON-RR HH24:MI:SS'
 * @return Returns TRUE on successful completion, otherwise FALSE
 * @rep:displayname Set Repeat Options
 * @rep:scope public
 * @rep:lifecycle active
 * @rep:compatibility S
 */
  function set_repeat_options (repeat_time      IN varchar2 default NULL,
			       repeat_interval  IN number   default NULL,
			       repeat_unit      IN varchar2 default 'DAYS',
			       repeat_type      IN varchar2 default 'START',
			       repeat_end_time  IN varchar2 default NULL,
			       increment_dates IN varchar2 default NULL)
			       return boolean;
  pragma restrict_references (set_repeat_options, WNDS);

  --
  -- Name
  --   set_rel_class_options
  -- Purpose
  --   Called before submitting request if the request to be submitted
  --   is using the new scheduler functionality.
  --
  -- Arguments
  --   application      - Application Name of Release Class
  --   class_name       - (Developer) Name of Release Class
  --   cancel_or_hold   - Cancel or hold flag
  --   stale_date       - Cancel request on or after this time if not run
  --
  function set_rel_class_options (application    IN varchar2 default NULL,
                                  class_name     IN varchar2 default NULL,
                                  cancel_or_hold IN varchar2 default 'H',
                                  stale_date     IN varchar2 default NULL)
                                  return boolean;
  pragma restrict_references (set_rel_class_options, WNDS);

  -- Name
  --   set_target_options
  -- Purpose
  --   Called before submitting request to set target node and or connect
  --   string (instance) for the request.  Currently only primary target
  --   node and connect string are honored and the connect string must be
  --   the name of a RAC instance.
  --
  -- Arguments
  --   node_name1	- primary target node
  --   instance1        - primary target instance (connect string)
  --   node_name2	- secondary target node
  --   instance2        - secondary target instance (connect string)
  --
  -- --
  function set_target_options (node_name1  IN varchar2 default NULL,
		        instance1 IN varchar2 default NULL,
		        node_name2    IN varchar2 default NULL,
		        instance2 IN varchar2 default NULL)
			return boolean;

  --
  -- Name
  --   set_print_options
  -- Purpose
  --   Called before submitting request if the printing of output has
  --   to be controlled with specific printer/style/copies etc.,
  --
  -- Arguments
  --   printer		- Printer name where the request o/p should be sent
  --   style		- Print style that needs to be used for printing
  --   copies		- Number of copies to print
  --   save_output	- Should the output file be saved after printing
  --   			- Default is TRUE.  TRUE/FALSE
  --   print_together   - Applies only for sub requests. If 'Y', output
  --			- will not be printed until all the sub requests
  --			- complete. Default is 'N'. ( Y/N )
  --   validate_printer - Once submit function is called
  --                    - with a specific program, if the printer specified
  --                    - here conflicts with a printer setting at the
  --                    - program level, one of three options is available:
  --                    - FAIL - raise an error and fail to submit
  --                    - SKIP - skip this print pp action, but submit anyway
  --                    - RESOLVE - switch to the valid printer, if printer
  --                    - and style are compatible
  --                    - Default is RESOLVE
  --
/*#
 * Sets the print options for the concurrent request
 * @param printer The name of the printer to which the concurrent request output should to be sent
 * @param style Style used to print request output
 * @param copies Number of copies of the request output to print
 * @param save_output Indicates whether to save the output file
 * @param print_together This parameter applies only to those requests containing sub-requests.
 * 'Y' indicates that output of the sub-request should not be printed until all sub-requests complete.
 * 'N' indicates that output of the sub-request should be printed as it completes.
 * @param validate_printer Once submit function is called with a specific program, if the printer specified here conflicts with a printer setting at the program level, one of three options is available, with a default of RESOLVE
 * FAIL - raise an error and fail to submit
 * SKIP - skip this print pp action, but submit anyway
 * RESOLVE - switch to the valid printer, if printer and style are compatible
 * @return TRUE on successful completion, otherwise FALSE
 * @rep:displayname Set Print Options
 * @rep:scope public
 * @rep:lifecycle active
 * @rep:compatibility S
 */
  function set_print_options (printer	     IN varchar2 default NULL,
			      style	     IN varchar2 default NULL,
			      copies	     IN number	 default NULL,
			      save_output    IN boolean	 default TRUE,
                              print_together IN varchar2 default 'N',
                              validate_printer IN varchar2 default 'RESOLVE')
			      return boolean;
  pragma restrict_references (set_print_options, WNDS);


  --
  -- Name
  --   use_current_notification
  -- Purpose
  --   Called before submitting a sub-request to reuse the same notification
  --   options as the current request
  --
  -- Arguments
  --   none
  function use_current_notification return boolean;
  pragma restrict_references (use_current_notification, WNDS);


  --
  -- Name
  --   add_printer
  -- Purpose
  --   Called after set print options to add a printer to the
  --   print list.
  --
  -- Arguments
  --   printer		- Printer name where the request o/p should be sent
  --   copies		- Number of copies to print
  function add_printer (printer in varchar2 default null,
                        copies  in number default null,
			lang    in varchar2 default null) return boolean;
  pragma restrict_references (add_printer, WNDS);

  --
  -- Name
  --   add_notification
  -- Purpose
  --   Called before submission to add a user to the notify list.
  --
  -- Arguments
  --	User		- User name.
  function add_notification (user          in varchar2,
		             nls_language  in varchar2 default null) return boolean;
  pragma restrict_references (add_notification, WNDS);

  --
  -- Name
  --   add_layout
  -- Purpose
  --   Called before submission to add layout options for request output.
  --
  -- Arguments
  --    Template_APPL_Name            - Template Application Short name.
  --    Template_code                 - Template code
  --    Template_Language             - Template File language (iso value)
  --    Template_Territory            - Template File Territory (iso value)
  --    Output Format                 - Output Format
  --
  function add_layout (template_appl_name in varchar2,
                        template_code     in varchar2,
                        template_language in varchar2,
                        template_territory in varchar2,
                        output_format     in varchar2,
		        nls_language      in varchar2 default null) return boolean;



  --
  -- Name
  --   add_language
  -- Purpose
  --   Called before submission to submit a request in a particular language
  --   Can be called multiple times to submit a request in multiple languages
  --
  -- Arguments
  --	Lang		- Language
  --    Territory       - Territory
  --    Num_char        - Numeric characters
  --
  function add_language (
               lang IN VARCHAR2,
               territory IN VARCHAR2,
               num_char IN VARCHAR2) return boolean;



  --
  -- Name
  --   add_delivery_option
  -- Purpose
  --   Called before submission to add a delivery option
  --
  -- Arguments
  --	Type		- Delivery type, see FND_DELIVERY
  --    p_argument1 - p_argument9 - Options specific to the delivery type
  --    nls_language    - Add only for this language
  function add_delivery_option ( type in varchar2,
				 p_argument1 in varchar2 default null,
				 p_argument2 in varchar2 default null,
                                 p_argument3 in varchar2 default null,
				 p_argument4 in varchar2 default null,
				 p_argument5 in varchar2 default null,
				 p_argument6 in varchar2 default null,
                                 p_argument7 in varchar2 default null,
				 p_argument8 in varchar2 default null,
				 p_argument9 in varchar2 default null,
				 nls_language in varchar2 default null) return boolean;
  --
  -- Name
  --   submit_request
  -- Purpose
  --   Submits concurrent request to be processed by a concurrent manager
  --
  -- Arguments
  --   application	- Short name of application under which the program
  --			- is registered
  --   program		- concurrent program name for which the request has
  --			- to be submitted
  --   description	- Optional. Will be displayed along with user
  --			- concurrent program name
  --   start_time	- Optional. Time at which the request has to start
  --			- running
  --   sub_request	- Optional. Set to TRUE if the request is submitted
  --   			- from another running request and has to be treated
  --			- as a sub request. Default is FALSE
  --   argument1..100	- Optional. Arguments for the concurrent request
  --
/*#
 * Submits a request for processing by a concurrent manager
 * @param application Short name of the application associated with the concurrent request to be submitted
 * @param program Short name of the concurrent program for which the request should be submitted
 * @param description Description of the request that is displayed in the concurrent request's form
 * @param start_time Time at which the request should start running
 * @param sub_request Set to TRUE if the request is submitted from another request and should be treated as a sub-request
 * @param argument1 Argument for concurrent request
 * @param argument2 Argument for concurrent request
 * @param argument3 Argument for concurrent request
 * @param argument4 Argument for concurrent request
 * @param argument5 Argument for concurrent request
 * @param argument6 Argument for concurrent request
 * @param argument7 Argument for concurrent request
 * @param argument8 Argument for concurrent request
 * @param argument9 Argument for concurrent request
 * @param argument10 Argument for concurrent request
 * @param argument11 Argument for concurrent request
 * @param argument12 Argument for concurrent request
 * @param argument13 Argument for concurrent request
 * @param argument14 Argument for concurrent request
 * @param argument15 Argument for concurrent request
 * @param argument16 Argument for concurrent request
 * @param argument17 Argument for concurrent request
 * @param argument18 Argument for concurrent request
 * @param argument19 Argument for concurrent request
 * @param argument20 Argument for concurrent request
 * @param argument21 Argument for concurrent request
 * @param argument22 Argument for concurrent request
 * @param argument23 Argument for concurrent request
 * @param argument24 Argument for concurrent request
 * @param argument25 Argument for concurrent request
 * @param argument26 Argument for concurrent request
 * @param argument27 Argument for concurrent request
 * @param argument28 Argument for concurrent request
 * @param argument29 Argument for concurrent request
 * @param argument30 Argument for concurrent request
 * @param argument31 Argument for concurrent request
 * @param argument32 Argument for concurrent request
 * @param argument33 Argument for concurrent request
 * @param argument34 Argument for concurrent request
 * @param argument35 Argument for concurrent request
 * @param argument36 Argument for concurrent request
 * @param argument37 Argument for concurrent request
 * @param argument38 Argument for concurrent request
 * @param argument39 Argument for concurrent request
 * @param argument40 Argument for concurrent request
 * @param argument41 Argument for concurrent request
 * @param argument42 Argument for concurrent request
 * @param argument43 Argument for concurrent request
 * @param argument44 Argument for concurrent request
 * @param argument45 Argument for concurrent request
 * @param argument46 Argument for concurrent request
 * @param argument47 Argument for concurrent request
 * @param argument48 Argument for concurrent request
 * @param argument49 Argument for concurrent request
 * @param argument50 Argument for concurrent request
 * @param argument51 Argument for concurrent request
 * @param argument52 Argument for concurrent request
 * @param argument53 Argument for concurrent request
 * @param argument54 Argument for concurrent request
 * @param argument55 Argument for concurrent request
 * @param argument56 Argument for concurrent request
 * @param argument57 Argument for concurrent request
 * @param argument58 Argument for concurrent request
 * @param argument59 Argument for concurrent request
 * @param argument60 Argument for concurrent request
 * @param argument61 Argument for concurrent request
 * @param argument62 Argument for concurrent request
 * @param argument63 Argument for concurrent request
 * @param argument64 Argument for concurrent request
 * @param argument65 Argument for concurrent request
 * @param argument66 Argument for concurrent request
 * @param argument67 Argument for concurrent request
 * @param argument68 Argument for concurrent request
 * @param argument69 Argument for concurrent request
 * @param argument70 Argument for concurrent request
 * @param argument71 Argument for concurrent request
 * @param argument72 Argument for concurrent request
 * @param argument73 Argument for concurrent request
 * @param argument74 Argument for concurrent request
 * @param argument75 Argument for concurrent request
 * @param argument76 Argument for concurrent request
 * @param argument77 Argument for concurrent request
 * @param argument78 Argument for concurrent request
 * @param argument79 Argument for concurrent request
 * @param argument80 Argument for concurrent request
 * @param argument81 Argument for concurrent request
 * @param argument82 Argument for concurrent request
 * @param argument83 Argument for concurrent request
 * @param argument84 Argument for concurrent request
 * @param argument85 Argument for concurrent request
 * @param argument86 Argument for concurrent request
 * @param argument87 Argument for concurrent request
 * @param argument88 Argument for concurrent request
 * @param argument89 Argument for concurrent request
 * @param argument90 Argument for concurrent request
 * @param argument91 Argument for concurrent request
 * @param argument92 Argument for concurrent request
 * @param argument93 Argument for concurrent request
 * @param argument94 Argument for concurrent request
 * @param argument95 Argument for concurrent request
 * @param argument96 Argument for concurrent request
 * @param argument97 Argument for concurrent request
 * @param argument98 Argument for concurrent request
 * @param argument99 Argument for concurrent request
 * @param argument100 Argument for concurrent request
 * @return Returns requestid of submitted request, 0 if submission fails
 * @rep:displayname Submit Request
 * @rep:scope public
 * @rep:lifecycle active
 * @rep:compatibility S
 */
  function submit_request (
			  application IN varchar2 default NULL,
			  program     IN varchar2 default NULL,
			  description IN varchar2 default NULL,
			  start_time  IN varchar2 default NULL,
			  sub_request IN boolean  default FALSE,
			  argument1   IN varchar2 default CHR(0),
			  argument2   IN varchar2 default CHR(0),
  			  argument3   IN varchar2 default CHR(0),
			  argument4   IN varchar2 default CHR(0),
			  argument5   IN varchar2 default CHR(0),
			  argument6   IN varchar2 default CHR(0),
			  argument7   IN varchar2 default CHR(0),
			  argument8   IN varchar2 default CHR(0),
			  argument9   IN varchar2 default CHR(0),
			  argument10  IN varchar2 default CHR(0),
			  argument11  IN varchar2 default CHR(0),
			  argument12  IN varchar2 default CHR(0),
  			  argument13  IN varchar2 default CHR(0),
			  argument14  IN varchar2 default CHR(0),
			  argument15  IN varchar2 default CHR(0),
			  argument16  IN varchar2 default CHR(0),
			  argument17  IN varchar2 default CHR(0),
			  argument18  IN varchar2 default CHR(0),
			  argument19  IN varchar2 default CHR(0),
			  argument20  IN varchar2 default CHR(0),
			  argument21  IN varchar2 default CHR(0),
			  argument22  IN varchar2 default CHR(0),
  			  argument23  IN varchar2 default CHR(0),
			  argument24  IN varchar2 default CHR(0),
			  argument25  IN varchar2 default CHR(0),
			  argument26  IN varchar2 default CHR(0),
			  argument27  IN varchar2 default CHR(0),
			  argument28  IN varchar2 default CHR(0),
			  argument29  IN varchar2 default CHR(0),
			  argument30  IN varchar2 default CHR(0),
			  argument31  IN varchar2 default CHR(0),
			  argument32  IN varchar2 default CHR(0),
  			  argument33  IN varchar2 default CHR(0),
			  argument34  IN varchar2 default CHR(0),
			  argument35  IN varchar2 default CHR(0),
			  argument36  IN varchar2 default CHR(0),
			  argument37  IN varchar2 default CHR(0),
  			  argument38  IN varchar2 default CHR(0),
			  argument39  IN varchar2 default CHR(0),
			  argument40  IN varchar2 default CHR(0),
			  argument41  IN varchar2 default CHR(0),
  			  argument42  IN varchar2 default CHR(0),
			  argument43  IN varchar2 default CHR(0),
			  argument44  IN varchar2 default CHR(0),
			  argument45  IN varchar2 default CHR(0),
			  argument46  IN varchar2 default CHR(0),
			  argument47  IN varchar2 default CHR(0),
  			  argument48  IN varchar2 default CHR(0),
			  argument49  IN varchar2 default CHR(0),
			  argument50  IN varchar2 default CHR(0),
			  argument51  IN varchar2 default CHR(0),
  			  argument52  IN varchar2 default CHR(0),
			  argument53  IN varchar2 default CHR(0),
			  argument54  IN varchar2 default CHR(0),
			  argument55  IN varchar2 default CHR(0),
			  argument56  IN varchar2 default CHR(0),
			  argument57  IN varchar2 default CHR(0),
			  argument58  IN varchar2 default CHR(0),
			  argument59  IN varchar2 default CHR(0),
			  argument60  IN varchar2 default CHR(0),
			  argument61  IN varchar2 default CHR(0),
			  argument62  IN varchar2 default CHR(0),
  			  argument63  IN varchar2 default CHR(0),
			  argument64  IN varchar2 default CHR(0),
			  argument65  IN varchar2 default CHR(0),
			  argument66  IN varchar2 default CHR(0),
			  argument67  IN varchar2 default CHR(0),
			  argument68  IN varchar2 default CHR(0),
			  argument69  IN varchar2 default CHR(0),
			  argument70  IN varchar2 default CHR(0),
			  argument71  IN varchar2 default CHR(0),
			  argument72  IN varchar2 default CHR(0),
  			  argument73  IN varchar2 default CHR(0),
			  argument74  IN varchar2 default CHR(0),
			  argument75  IN varchar2 default CHR(0),
			  argument76  IN varchar2 default CHR(0),
			  argument77  IN varchar2 default CHR(0),
			  argument78  IN varchar2 default CHR(0),
			  argument79  IN varchar2 default CHR(0),
			  argument80  IN varchar2 default CHR(0),
			  argument81  IN varchar2 default CHR(0),
			  argument82  IN varchar2 default CHR(0),
  			  argument83  IN varchar2 default CHR(0),
			  argument84  IN varchar2 default CHR(0),
			  argument85  IN varchar2 default CHR(0),
			  argument86  IN varchar2 default CHR(0),
			  argument87  IN varchar2 default CHR(0),
			  argument88  IN varchar2 default CHR(0),
			  argument89  IN varchar2 default CHR(0),
			  argument90  IN varchar2 default CHR(0),
			  argument91  IN varchar2 default CHR(0),
			  argument92  IN varchar2 default CHR(0),
  			  argument93  IN varchar2 default CHR(0),
			  argument94  IN varchar2 default CHR(0),
			  argument95  IN varchar2 default CHR(0),
			  argument96  IN varchar2 default CHR(0),
			  argument97  IN varchar2 default CHR(0),
			  argument98  IN varchar2 default CHR(0),
			  argument99  IN varchar2 default CHR(0),
			  argument100  IN varchar2 default CHR(0))
			  return number;

-- This function is for AOL internal use only:
procedure internal(critical IN varchar2 default null,
                   type IN varchar2     default null);

  --
  -- Name
  --   add_notification
  -- Purpose
  --   Called before submission to add a user to the notify list.
  --
  -- Arguments
  --    User            - User name.
  --    on_normal       - Notify when normal completion (Values Y/N)
  --    on_warning      - Notify when request completes with warning (Y/N)
  --    on_error	- Notify when request completed with error (Y/N)
  function add_notification (user       in varchar2,
                             on_normal  in varchar2 ,
                             on_warning in varchar2 ,
                             on_error   in varchar2 ) return boolean;
  pragma restrict_references (add_notification, WNDS);

  --
  -- Name
  --   submit_svc_ctl_request
  -- Purpose
  --   Submits Queue Control Request
  --   WARNING PERFORMS A COMMIT!!!
  --
  -- Arguments
  --   command		- concurrent program name for which the request has
  --			- to be submitted: ACTIVATE, DEACTIVATE, RESTART,
  --			- ABORT (ie. terminate), VERIFY, SUSPEND, or RESUME
  --   service		- Service instance or manager developer name.
  --   service_app	- manager or service instance's application short name

  function submit_svc_ctl_request (
			  command     IN varchar2,
			  service     IN varchar2,
			  service_app IN varchar2)
			  return number;

  --
  -- Name
  --   submit_svc_ctl_by_app
  -- Purpose
  --   Submits Queue Control Request
  --   WARNING PERFORMS A COMMIT!!!
  --
  -- Arguments
  --   command		- concurrent program name for which the request has
  --			- to be submitted: ACTIVATE, DEACTIVATE, RESTART,
  --			- ABORT (ie. terminate), VERIFY, SUSPEND, or RESUME
  --   service_app	- manager or service instance's application short name
  --   svc_type		- 0 = mgrs, 1= svcs, 2= both

  function submit_svc_ctl_by_app (
			  command     IN varchar2,
			  application IN varchar2,
			  svc_type    in NUMBER default 2)
			  return number;

  --
  -- Name
  --   submit_svc_ctl_by_svc
  -- Purpose
  --   Submits Queue Control Request
  --   WARNING PERFORMS A COMMIT!!!
  --
  -- Arguments
  --   command		- concurrent program name for which the request has
  --			- to be submitted: ACTIVATE, DEACTIVATE, RESTART,
  --			- ABORT (ie. terminate), VERIFY, SUSPEND, or RESUME
  --   service		- Service instance or manager developer name.

  function submit_svc_ctl_by_svc (
			  command     IN varchar2,
			  service     IN varchar2)
			  return number;

  --
  -- Name
  --   submit_svc_ctl_cpinfra
  -- Purpose
  --   Submits Queue Control Request
  --   WARNING PERFORMS A COMMIT!!!
  --
  -- Arguments
  --   command		- concurrent program name for which the request has
  --			- to be submitted: ACTIVATE, DEACTIVATE, RESTART,
  --			- ABORT (ie. terminate), VERIFY, SUSPEND, or RESUME
  --   service		- Service instance or manager developer name.
  --   service_app	- manager or service instance's application short name

  function submit_svc_ctl_cpinfra (
			  command     IN varchar2)
			  return number;

  --
  -- Name
  --   submit_svc_ctl_cpall
  -- Purpose
  --   Submits Queue Control Request
  --   WARNING PERFORMS A COMMIT!!!
  --
  -- Arguments
  --   command		- concurrent program name for which the request has
  --			- to be submitted: ACTIVATE, DEACTIVATE, RESTART,
  --			- ABORT (ie. terminate), VERIFY, SUSPEND, or RESUME

  function submit_svc_ctl_cpall (
			  command     IN varchar2)
			  return number;


  -- Name
  --   set_deferred
  -- Purpose
  --   Called before calling request submission page by other product teams
  --
  -- Arguments
  -- 	none
  --
  function set_deferred
  	return boolean;



  -- Name
  --   set_def_request_id
  -- Purpose
  --   Called for setting global request id and the request id will be used while creating actual request
  --
  -- Arguments
  -- 	request_id - used while creating actual request in fnd_concurrent_request
  --
  function set_def_request_id (
  					request_id IN number)
  	return boolean;


  -- Name
  --   get_fnd_debug_rules_sequence
  -- Purpose
  --   Called to obtain the next sequence value for fnd_debug_rules table
  --
  -- Arguments
  -- 	none
  --
  function get_fnd_debug_rules_sequence
        return number;


  -- Name
  --   update_fnd_debug_rules_req_id
  -- Purpose
  --   Called to set the request id for the specific fnd_debug_rule_id
  --
  -- Arguments
  -- 	debug_rule_id - the specific row in fnd_debug_rules to get updated
  -- 	request_id - the actual request id that debug options is being set for.
  --
  function update_fnd_debug_rules_req_id (
               req_id             IN number,
               fnd_debug_rule_id  IN number )
        return boolean;


  -- Name
  --   delete_fnd_debug_rules_id
  -- Purpose
  --   Called to delete the specific fnd_debug_rule_id from fnd_debug_rules
  --   and fnd_debug_rules_options
  --
  -- Arguments
  -- 	debug_rule_id - the specific sequence number to be deleted
  --
  function delete_fnd_debug_rules_id (
               fnd_debug_rule_id  IN number )
        return boolean;

  -- NAME
  --    get_num_char_for_terr
  -- Purpose
  --    Called to retrieve the num char associated with a territory
  --
  -- Arguments
  --    original_terr
  --    check_terr
  --
  function get_num_char_for_terr (
               original_terr  IN varchar2,
               check_terr     IN varchar2 )
        return varchar2;

  -- NAME
  --    validate_num_char_for_terr
  -- Purpose
  --    Called to validate the num char associated with a territory
  --
  -- Arguments
  --    num_char
  --
  function validate_num_char_for_terr (
               num_char  IN varchar2 )
        return boolean;

 FUNCTION INSERT_USER_SCHEDULE(P_RELEASE_CLASS_NAME IN VARCHAR2,
                              P_REQUESTED_START_DATE IN VARCHAR2,
                              P_REQUESTED_END_DATE IN VARCHAR2,
                              P_REPEAT_INTERVAL IN NUMBER,
                              P_REPEAT_INTERVAL_UNIT IN VARCHAR2,
                              P_REPEAT_INTERVAL_TYPE IN VARCHAR2,
                              P_CLASS_TYPE IN VARCHAR2,
                              P_CLASS_INFO IN VARCHAR2,
                              P_DESCRIPTION IN VARCHAR2
                              ) return boolean;

FUNCTION UPDATE_USER_SCHEDULE(P_RELEASE_CLASS_NAME IN VARCHAR2,
                              P_REQUESTED_START_DATE IN VARCHAR2,
                              P_REQUESTED_END_DATE IN VARCHAR2,
                              P_REPEAT_INTERVAL IN NUMBER,
                              P_REPEAT_INTERVAL_UNIT IN VARCHAR2,
                              P_REPEAT_INTERVAL_TYPE IN VARCHAR2,
                              P_CLASS_TYPE IN VARCHAR2,
                              P_CLASS_INFO IN VARCHAR2,
                              P_DESCRIPTION IN VARCHAR2
                              ) return boolean;

function delete_user_schedule(schName varchar2)
RETURN BOOLEAN;

end FND_REQUEST;

CREATE OR REPLACE PACKAGE BODY "APPS"."FND_REQUEST" as
/* $Header: AFCPREQB.pls 120.15.12010000.9 2010/05/19 17:34:30 pferguso ship $ */

--
-- Package
--   FND_REQUEST
--
-- Purpose
--   Concurrent processing related utilities
--
-- History
--   XX-XXX-93	Ram Bhoopalam		Created
--   08-FEB-94	H Pelimuhandiram	Gave life
--

  --
  -- PRIVATE VARIABLES
  --
	P_OPS_ID		integer		:= null;
	P_REL_CLASS_APP_ID	integer		:= null;
	P_REL_CLASS_ID		integer		:= null;
	P_REL_STALE_DATE	date		:= null;
	P_REL_CANCEL_OR_HOLD	varchar2(1)	:= 'H';
	P_USES_REL_CLASS	integer		:= 0;
	P_ON_PP_ERR_NOTIFY	varchar2(255)	:= null;
	P_REPEAT_TIME		varchar2(10)	:= null;
	P_REPEAT_INTERVAL	number(15,10)	:= null;
	P_REPEAT_INTERVAL_UNIT	varchar2(10)	:= null;
	P_REPEAT_INTERVAL_TYPE	varchar2(10)	:= null;
	P_REPEAT_END		date		:= null;
	P_INCREMENT_DATES	varchar2(1)	:= null;
	P_PRINT_STYLE		varchar2(30)	:= null;
	P_SAVE_OUTPUT		char		:= null;
	P_PRINT_TOGETHER	char		:= null;
	P_PROTECTED		char		:= 'N';
	P_IMPLICIT 		varchar2(10)	:= 'N';
	P_LANGUAGE		varchar2(30)	:= null;
	P_TERRITORY		varchar2(30)	:= null;
        /* NLS Project */
	P_NUMERIC_CHARACTERS	varchar2(2)	:= null;
	P_DATAGROUP		varchar2(30)	:= null;
	P_DB_TRIGGER_MODE	boolean		:= FALSE;
	P_CRITICAL_REQUEST	varchar2(1)	:= null;
	P_REQUEST_TYPE		varchar2(1)	:= NULL;
	P_DEFERRED_MODE		boolean		:= FALSE;
	P_DEF_REQUEST_ID	number		:= 0;
        P_ORG_ID                integer         := null;
        SQL_WAITS               NUMBER :=  8 ;
        P_VALIDATE_PRINTER      varchar2(10) := 'RESOLVE';
        P_NODE_NAME1            varchar2(30)    := null;
        P_CONNSTR1              varchar2(255)   := null;


	TYPE printer_record_type is record
		( printer varchar2(30),
		  copies  number,
		  lang    varchar2(30));

	TYPE printer_tab_type is table of printer_record_type
		index by binary_integer;

	TYPE notification_record_type is record
		( name 		 varchar2(100),
		  orig_system 	 varchar2(48),
		  orig_system_id number,
		  on_normal      varchar2(1),
		  on_warning     varchar2(1),
		  on_error       varchar2(1),
		  lang           varchar2(30));

	TYPE notification_tab_type is table of notification_record_type
		index by binary_integer;


        TYPE nls_parameters_record_type is record
                ( nls_lang      varchar2(10),
                  nls_territory varchar2(30),
                  nls_num_char  varchar2(2));

        TYPE nls_parameters_tab_type is table of nls_parameters_record_type
                index by binary_integer;

        TYPE layout_record_type is record
		( template_appl_name varchar2(255),
		  template_code      varchar2(255),
	 	  template_language  varchar2(255),
 		  template_territory varchar2(255),
		  output_format      varchar2(255),
		  nls_language       varchar2(30));

        TYPE layout_tab_type is table of layout_record_type
		index by binary_integer;

        TYPE delivery_record_type is record
                ( argument1          varchar2(255),
		  argument2          varchar2(255),
		  argument3          varchar2(255),
		  argument4          varchar2(255),
		  argument5          varchar2(255),
		  argument6          varchar2(255),
		  argument7          varchar2(255),
		  argument8          varchar2(255),
		  argument9          varchar2(255),
		  argument10         varchar2(255),
		  lang               varchar2(30));

        TYPE delivery_tab_type is table of delivery_record_type
		index by binary_integer;


	P_PRINTERS printer_tab_type;
	P_PRINTER_COUNT number := 0;

	P_NOTIFICATIONS notification_tab_type;
	P_NOTIFICATION_COUNT number := 0;

        P_NLS_PARAMETERS nls_parameters_tab_type;
        P_NLS_PARAMETERS_COUNT number := 0;

        P_LAYOUTS layout_tab_type;
	P_LAYOUT_COUNT number := 0;

        P_DELIVERY_OPTIONS  delivery_tab_type;
        P_DELIV_OPTS_COUNT  number := 0;


  -- Exception info.

  --
  -- PRIVATE FUNCTIONS
  --
  -- --

  -- Name
  --   init_pvt_vars
  -- Purpose
  --   Called after submitting request to re-initialize repeat options
  --
  -- --

  procedure init_pvt_vars is
	empty_array        printer_tab_type;
	empty_notify_array notification_tab_type;
	empty_nls_params   nls_parameters_tab_type;
	empty_layouts      layout_tab_type;
	empty_delivery     delivery_tab_type;

	begin
		P_OPS_ID			:= null;
		P_REL_CLASS_APP_ID		:= null;
		P_REL_CLASS_ID			:= null;
		P_REL_STALE_DATE		:= null;
		P_REL_CANCEL_OR_HOLD		:= 'H';
		P_USES_REL_CLASS		:= 0;
		P_ON_PP_ERR_NOTIFY		:= null;
		P_REPEAT_TIME			:= null;
		P_REPEAT_INTERVAL		:= null;
		P_REPEAT_INTERVAL_UNIT		:= null;
		P_REPEAT_INTERVAL_TYPE		:= null;
		P_REPEAT_END			:= null;
		P_PRINT_STYLE			:= null;
		P_SAVE_OUTPUT			:= null;
		P_PRINT_TOGETHER		:= null;
		P_PROTECTED			:= 'N';
		P_IMPLICIT			:= 'N';
		P_LANGUAGE			:= null;
		P_TERRITORY			:= null;
                /* NLS Project */
	        P_NUMERIC_CHARACTERS		:= null;
		P_DATAGROUP			:= null;
		P_DB_TRIGGER_MODE		:= FALSE;
		P_CRITICAL_REQUEST		:= null;
		P_REQUEST_TYPE			:= NULL;
		P_PRINTERS			:= empty_array;
		P_PRINTER_COUNT			:= 0;
		P_NOTIFICATIONS			:= empty_notify_array;
		P_NOTIFICATION_COUNT		:= 0;
		P_DEFERRED_MODE			:= FALSE;
		P_DEF_REQUEST_ID		:= 0;
                P_ORG_ID                        := null;
		P_NLS_PARAMETERS_COUNT          := 0;
		P_NLS_PARAMETERS                := empty_nls_params;
		P_LAYOUT_COUNT                  := 0;
		P_LAYOUTS                       := empty_layouts;
                P_DELIV_OPTS_COUNT              := 0;
		P_DELIVERY_OPTIONS              := empty_delivery;

	end init_pvt_vars;

  -- Name
  --  get_request_set_priority
  -- Purpose
  --  The priority of a request set is
  --  equal to the priority of its highest
  --  priority member.
  --
  -- --
  function get_request_set_priority (
                 app_id IN number,
                 set_id IN number
                                    ) return number is
    program_priority number;
    profile_priority_char varchar2(3);
    profile_priority_number number;
  begin
     FND_PROFILE.GET ('CONC_PRIORITY', profile_priority_char);
     profile_priority_number := to_number(profile_priority_char);

     Select min(nvl(request_priority, profile_priority_number))
       Into program_priority
       From Fnd_Concurrent_Programs P,
            Fnd_Request_Set_Programs S
      Where S.set_application_id = app_id
        and S.request_set_id = set_id
        and P.concurrent_program_id = S.concurrent_program_id
        and P.application_id = S.program_application_id;

      return program_priority;
  exception
    when NO_DATA_FOUND then
      return null;
  end;

procedure set_dest_ops(ops_id IN number default NULL) is

begin
   P_OPS_ID := ops_id;
end;


procedure set_org_id(org_id IN number default NULL) is

begin
   P_ORG_ID := org_id;
end;

  -- Name
  --   is_trace_enabled
  -- Purpose
  --   Check whether the trace is enabled for the current db session
  -- Added this function to fix 4438376

function is_trace_enabled(trace_type in number) return boolean is
 event_level number;
 trace_on boolean;
 begin
   if(trace_type < 20) then
    dbms_system.read_ev(10046,event_level);
   else
    dbms_system.read_ev(trace_type,event_level);
   end if;

   if event_level > 0 then
     trace_on:= true;
   else
     trace_on:= false;
   end if;
 return trace_on;
 end;

  -- Name
  --   submit
  -- Purpose
  --   Submit concurrent request
  --
  -- --

  function submit (
		  application IN varchar2,
		  program     IN varchar2,
		  description IN varchar2,
		  start_time  IN varchar2,
		  sub_request IN boolean,
		  argument1   IN varchar2,
		  argument2   IN varchar2,
  		  argument3   IN varchar2,
		  argument4   IN varchar2,
		  argument5   IN varchar2,
		  argument6   IN varchar2,
		  argument7   IN varchar2,
		  argument8   IN varchar2,
		  argument9   IN varchar2,
		  argument10  IN varchar2,
		  argument11  IN varchar2,
		  argument12  IN varchar2,
  		  argument13  IN varchar2,
		  argument14  IN varchar2,
		  argument15  IN varchar2,
		  argument16  IN varchar2,
		  argument17  IN varchar2,
		  argument18  IN varchar2,
		  argument19  IN varchar2,
		  argument20  IN varchar2,
		  argument21  IN varchar2,
		  argument22  IN varchar2,
  		  argument23  IN varchar2,
		  argument24  IN varchar2,
		  argument25  IN varchar2,
		  argument26  IN varchar2,
		  argument27  IN varchar2,
		  argument28  IN varchar2,
		  argument29  IN varchar2,
		  argument30  IN varchar2,
		  argument31  IN varchar2,
		  argument32  IN varchar2,
  		  argument33  IN varchar2,
		  argument34  IN varchar2,
		  argument35  IN varchar2,
		  argument36  IN varchar2,
		  argument37  IN varchar2,
  		  argument38  IN varchar2,
		  argument39  IN varchar2,
		  argument40  IN varchar2,
		  argument41  IN varchar2,
  		  argument42  IN varchar2,
		  argument43  IN varchar2,
		  argument44  IN varchar2,
		  argument45  IN varchar2,
		  argument46  IN varchar2,
		  argument47  IN varchar2,
  		  argument48  IN varchar2,
		  argument49  IN varchar2,
		  argument50  IN varchar2,
		  argument51  IN varchar2,
		  argument52  IN varchar2,
		  argument53  IN varchar2,
		  argument54  IN varchar2,
		  argument55  IN varchar2,
		  argument56  IN varchar2,
		  argument57  IN varchar2,
		  argument58  IN varchar2,
		  argument59  IN varchar2,
		  argument60  IN varchar2,
		  argument61  IN varchar2,
		  argument62  IN varchar2,
		  argument63  IN varchar2,
		  argument64  IN varchar2,
		  argument65  IN varchar2,
		  argument66  IN varchar2,
		  argument67  IN varchar2,
		  argument68  IN varchar2,
		  argument69  IN varchar2,
		  argument70  IN varchar2,
		  argument71  IN varchar2,
		  argument72  IN varchar2,
		  argument73  IN varchar2,
		  argument74  IN varchar2,
		  argument75  IN varchar2,
		  argument76  IN varchar2,
		  argument77  IN varchar2,
		  argument78  IN varchar2,
		  argument79  IN varchar2,
		  argument80  IN varchar2,
		  argument81  IN varchar2,
		  argument82  IN varchar2,
		  argument83  IN varchar2,
		  argument84  IN varchar2,
		  argument85  IN varchar2,
		  argument86  IN varchar2,
		  argument87  IN varchar2,
		  argument88  IN varchar2,
		  argument89  IN varchar2,
		  argument90  IN varchar2,
		  argument91  IN varchar2,
		  argument92  IN varchar2,
		  argument93  IN varchar2,
		  argument94  IN varchar2,
		  argument95  IN varchar2,
		  argument96  IN varchar2,
		  argument97  IN varchar2,
		  argument98  IN varchar2,
		  argument99  IN varchar2,
		  argument100 IN varchar2)
		  return number is

        submit_ops_id	   number;
	cur_request_id     number;
	cur_req_pri_id     number;
	par_request_id     number;
        fgloginid          number;
	pri_request_id     number;
	resp_id		   number := null;
	resp_appl_id	   number := null;
	user_id		   number := null;
	oraclacct          varchar2(30);
	conf_set_id        number;
	prog_appl_id       number;
	conc_prog_id       number;
	loginid		   number := null;
	subloginid	   number := null;
	hold_request       varchar2(3);
	snth_request       varchar2(3);
	language           varchar2(15);
	req_status	   varchar2(15);
	requested_start    date;
	priority	   number  := 50;
	hold_flag          varchar2(3)  := 'N';
	st_flag		   varchar2(3)  := 'N';
	profile_buffer	   varchar2(80) := null;
	request_threshold  number := -1;
	print_copies	   number := 0;
	req_limit          char;
	phase              char     := 'P';
	status		   char     := 'Q';
	issubreq           char     := 'N';
	has_parent         boolean  := FALSE;
        program_priority   number;

        cd_id		   number := -1;	  -- Conf domain id
	cd_param           varchar2(150) := null; -- Conf domain param name

        default_copies     number;
	default_printer    varchar2(30);
        fcr_printer        varchar2(30);
	fcp_printer        varchar2(30);
        curr_printer       varchar2(30);
        curr_copies        number;
        tot_copies         number := 0;
	print_style        varchar2(30);
	valid_style        varchar2(30) := null;
	print_warning	   char := 'N';
        reqrd_flag         char;
	minwid             number(4);           -- bug3205755
	maxwid             number(4) := null;   -- bug3205755
	minlen             number(4);           -- bug3205755
  	maxlen             number(4) := null;   -- bug3205755
	execcode	   char;
	saveout            char;
	prtflg		   char;
	mult_pending_req   char;
	qctlflg		   char;
	styl_ok            boolean  := FALSE;
	nargs		   number := 0;
	argtxt		   varchar2(24200) := null;
	argtxt2		   varchar2(240);
	dummy		   char;
        request_set_flag   varchar2(1);
        base_len           number;
        tz_offset          number(1);
        encoded_msg	   varchar2(4000);
-- bug 1518406 define a local name
        z_security_group_id  number;

        ops_req_mode	   varchar2(30);
        portlet_ref        varchar2(1) := 'N';  -- 'N'ever (no pp plsql actions)
        p_on_success       varchar2(1) := 'N';
        p_on_warning       varchar2(1) := 'N';
        p_on_error         varchar2(1) := 'N';
        pp_plsql_step      number := -1;

	printer_error	   exception;
	style_error	   exception;
	srw_style_error	   exception;
	printer_styl_error exception;
	insert_error	   exception;
	args_insert_error  exception;
	login_insert_error exception;
	relclass_insert_error exception;
	dual_no_rows	   exception;
	dual_too_many_rows exception;
	nls_error	   exception;
	appl_prog_error	   exception;
	start_time_error   exception;
	already_msg	   exception;
	oracle_name_error  exception;
        pp_plsql_exception exception;
	conc_deferred_insert_error exception;
	mult_pending_request_error exception;

	rttestid	   number;
        i                  number;
	new_class  boolean;
        schedule_type      varchar2(1);
        schedule_info      varchar2(64);
        sch_req_date       date;
        sch_end_date       date;

	no_pending_req     number;
	lang_exists	   number;
	adv_sch_ri number(15,10);
	adv_sch_riuc varchar2(30);
	adv_sch_ritc varchar2(30);
       trace_enabled varchar2(1) :='N';
	discard_status		number;

  begin
	-- Get next request ID from sequence
	-- only if it is a normal call without P_DEFERRED_MODE or its deferred call
	if ( (P_DEFERRED_MODE) OR (P_DEF_REQUEST_ID = 0)) then
	begin
		Select Fnd_Concurrent_Requests_S.nextval
		Into cur_request_id
		From Sys.Dual;
	exception
		when no_data_found then
			raise dual_no_rows;
		when too_many_rows then
			raise dual_too_many_rows;
		when others then
			raise;
	end;
	end if;

	if (P_DEFERRED_MODE) then
		Insert Into Fnd_Conc_Deferred_Arguments (
			request_id, Program_Application_Id, Concurrent_Program_Id,
			Argument1, Argument2, Argument3, Argument4, Argument5,
			Argument6,  Argument7,  Argument8,  Argument9,  Argument10,
			Argument11, Argument12, Argument13, Argument14, Argument15,
			Argument16, Argument17, Argument18, Argument19, Argument20,
			Argument21, Argument22, Argument23, Argument24, Argument25,
			Argument26, Argument27, Argument28, Argument29, Argument30,
			Argument31, Argument32, Argument33, Argument34, Argument35,
			Argument36, Argument37, Argument38, Argument39, Argument40,
			Argument41, Argument42, Argument43, Argument44, Argument45,
			Argument46, Argument47, Argument48, Argument49, Argument50,
			Argument51, Argument52, Argument53, Argument54, Argument55,
			Argument56, Argument57, Argument58, Argument59, Argument60,
			Argument61, Argument62, Argument63, Argument64, Argument65,
			Argument66, Argument67, Argument68, Argument69, Argument70,
			Argument71, Argument72, Argument73, Argument74, Argument75,
			Argument76, Argument77, Argument78, Argument79, Argument80,
			Argument81, Argument82, Argument83, Argument84, Argument85,
			Argument86, Argument87, Argument88, Argument89, Argument90,
			Argument91, Argument92, Argument93, Argument94, Argument95,
			Argument96, Argument97, Argument98, Argument99, Argument100,
			Creation_Date, Created_By, Last_Update_Date, Last_Updated_By,
			Last_Update_Login)
			Select cur_request_id, FA.Application_ID, FCP.Concurrent_Program_ID,
				argument1,  argument2,  argument3,  argument4,  argument5,
				argument6,  argument7,  argument8,  argument9,  argument10,
				argument11, argument12, argument13, argument14, argument15,
				argument16, argument17, argument18, argument19, argument20,
				argument21, argument22, argument23, argument24, argument25,
				argument26, argument27, argument28, argument29, argument30,
				argument31, argument32, argument33, argument34, argument35,
				argument36, argument37, argument38, argument39, argument40,
				argument41, argument42, argument43, argument44, argument45,
				argument46, argument47, argument48, argument49, argument50,
				argument51, argument52, argument53, argument54, argument55,
				argument56, argument57, argument58, argument59, argument60,
				argument61, argument62, argument63, argument64, argument65,
				argument66, argument67, argument68, argument69, argument70,
				argument71, argument72, argument73, argument74, argument75,
				argument76, argument77, argument78, argument79, argument80,
				argument81, argument82, argument83, argument84, argument85,
				argument86, argument87, argument88, argument89, argument90,
				argument91, argument92, argument93, argument94, argument95,
				argument96, argument97, argument98, argument99, argument100,
				Sysdate, FND_GLOBAL.conc_login_id, Sysdate,
				FND_GLOBAL.conc_login_id, FND_GLOBAL.conc_login_id
			From Fnd_Application FA,
				Fnd_Concurrent_Programs FCP
			Where
				FCP.Enabled_Flag = 'Y'
				And (FCP.Application_ID = FA.Application_ID And
				Concurrent_Program_Name   = Upper (program))
				And  FA.Application_Short_Name = Upper (application);

			if (sql%rowcount = 0) then
			  raise conc_deferred_insert_error;
			end if;
			--
			--  raising business event for request submitted
			--  bug6623316
			--
                        discard_status:=fnd_concurrent_business_event.raise_cp_bi_event(cur_request_id,fnd_concurrent_business_event.request_submitted);

			return (cur_request_id);
	else
	-- see if it is deferred call or normal call
		if (P_DEF_REQUEST_ID <> 0) then
			cur_request_id := P_DEF_REQUEST_ID;
		end if;
	end if;

	new_class  := FALSE;
	-- Get info. about requests origination
	-- If being submitted from another concurrent request get parent
	-- request information.

	fgloginid := fnd_global.login_id;
	par_request_id := FND_GLOBAL.conc_request_id;

        z_security_group_id := FND_GLOBAL.security_group_id;


	if (par_request_id > 0) then
	  has_parent := TRUE;
	  pri_request_id := FND_GLOBAL.conc_priority_request;

      -- bug 4438376. check whether the trace is enabled for the parent request.
      -- if enabled, then enable the trace for child request also

      if (is_trace_enabled(SQL_WAITS)) then
        trace_enabled := 'Y';
      else
        trace_enabled := 'N';
      end if;

	  loginid := FND_GLOBAL.conc_login_id;

	  if (loginid is null) then
	    loginid := 0;

	  else
	    begin
	      Select Submitted_Login_ID
		Into subloginid
		From Fnd_Logins
	       Where Login_ID = loginid;

	      exception
		when no_data_found then
		  subloginid := 0;

		when others then
		  raise;
	    end;

	  end if; -- (loginid is null)

	else -- request being submitted from forms session
	     -- Get LOGIN_ID
	  subloginid := FND_GLOBAL.login_id;
	  pri_request_id := cur_request_id;

	end if; -- (par_request_id > 0)


	-- Common to both :

	if (sub_request AND pri_request_id > 0) then
	  cur_req_pri_id := pri_request_id;
	else
	  cur_req_pri_id := cur_request_id;
	end if;

	user_id := FND_GLOBAL.user_id;

	if (user_id is null) then
	  user_id := -1;
	end if;

	resp_id := FND_GLOBAL.resp_id;

	if (resp_id is null) then
	  resp_id := -1;
	end if;

	resp_appl_id := FND_GLOBAL.resp_appl_id;

	if (resp_appl_id is null) then
	  resp_appl_id := -1;
	end if;

        FND_PROFILE.GET ('CONC_OPS_REQ_MODE', ops_req_mode);
        if (ops_req_mode is null) then
          ops_req_mode:= 'EXPLICIT';
        end if;

	FND_PROFILE.GET ('CONC_HOLD', hold_flag);
	if (hold_flag is null) then
	  hold_flag := 'N';
	end if;

	FND_PROFILE.GET ('CONC_SINGLE_THREAD', st_flag);
	if (st_flag is null) then
	  st_flag := 'N';
	else
	  st_flag := substr (st_flag, 1, 1);
	end if;

        profile_buffer := NULL;
	FND_PROFILE.GET ('CONC_REQUEST_THRESHOLD_LEVEL', profile_buffer);
	if ( profile_buffer is null) then
	   request_threshold := -1;
	else
	   request_threshold := To_Number (profile_buffer);
	end if;

        profile_buffer := NULL;
	FND_PROFILE.GET ('CONC_REQUEST_LIMIT', profile_buffer);
	if ( profile_buffer is null) then
	   req_limit := 'N';
        elsif   (To_Number(profile_buffer) >= 0 and (P_REQUEST_TYPE IS NULL or P_REQUEST_TYPE <> 'S')) then
	   req_limit := 'Y';
	else
	   req_limit := 'N';
	end if;

	FND_PROFILE.GET ('CONC_STATUS', req_status);
	if (req_status = 'HOLD') then
	  status := 'A';
	elsif (sub_request) then
	  status := 'Z';
	end if;

        profile_buffer := NULL;
        FND_PROFILE.GET('CONC_MULTI_TZ', profile_buffer);

        if (profile_buffer in ('Y', 'y')) then
          tz_offset := 1;
        else
          tz_offset := 0;
        end if;

        profile_buffer := NULL;
	if (start_time is null) then
	  FND_PROFILE.GET ('CONC_REQ_START', profile_buffer);
	else
	  profile_buffer := start_time;
	end if;

        if (profile_buffer is not null) then
          requested_start := fnd_conc_date.string_to_date(profile_buffer);
          if (requested_start is null) then
            raise start_time_error;
          end if;
        else
          requested_start := null;
        end if;


        -- Someone specified a schedule to use.
        -- If it is a Specific schedule, figure out the correct start date to use.
        -- If it is a Periodic schedule, populate the correct fields in FND_CONCURRENT_REQUESTS.
        if (P_USES_REL_CLASS = 1) then
          begin
            select class_type, class_info, date1, date2
            into   schedule_type, schedule_info, sch_req_date, sch_end_date
            from   fnd_conc_release_classes
            where  application_id = P_REL_CLASS_APP_ID
            and    release_class_id = P_REL_CLASS_ID;

            if schedule_type = 'S' then
              -- subtract 1 from sch_req_date to account for the possibility that the
              -- schedule may need to run on sch_req_date.
              requested_start := fnd_conc_release_class_utils.calc_specific_startdate(sch_req_date - 1, schedule_info);

              if requested_start > sch_end_date then
                raise start_time_error;
              end if;
              P_REPEAT_END := sch_end_date;

            elsif schedule_type = 'P' then
              fnd_conc_release_class_utils.parse_periodic_schedule(P_REL_CLASS_APP_ID, P_REL_CLASS_ID,
                                                                   P_REPEAT_INTERVAL,
                                                                   P_REPEAT_INTERVAL_UNIT,
                                                                   P_REPEAT_INTERVAL_TYPE,
                                                                   sch_req_date,
								   P_REPEAT_END);


               if sch_req_date > sch_end_date then
                 raise start_time_error;
               end if;

               requested_start := sch_req_date;
            end if;

          exception
            when no_data_found then
              requested_start := null;

          end;
        end if;

        if (P_NODE_NAME1 is NULL) then
         begin
           select fcpoi.node_name1
             into P_NODE_NAME1
             from fnd_conc_prog_onsite_info fcpoi,
                  fnd_concurrent_programs fcp,
                  fnd_application fa
            where fcp.application_id = fcpoi.program_application_id
              and fcp.concurrent_program_id = fcpoi.concurrent_program_id
              and fa.application_id = fcp.application_id
              and fcp.concurrent_program_name = upper(program)
              and fa.application_short_name = upper(application);
         exception
          when no_data_found then
            P_NODE_NAME1 := null;
         end;
        end if;

        if (P_CONNSTR1 is NULL) then
         begin
           select fcpoi.connstr1
             into P_CONNSTR1
             from fnd_conc_prog_onsite_info fcpoi,
                  fnd_concurrent_programs fcp,
                  fnd_application fa
            where fcp.application_id = fcpoi.program_application_id
              and fcp.concurrent_program_id = fcpoi.concurrent_program_id
              and fa.application_id = fcp.application_id
              and fcp.concurrent_program_name = upper(program)
              and fa.application_short_name = upper(application);
         exception
          when no_data_found then
            P_CONNSTR1 := null;
         end;
        end if;

	if (P_PRINT_TOGETHER is NULL) then
	  FND_PROFILE.GET ('CONC_PRINT_TOGETHER', profile_buffer);
	  if (substr (profile_buffer, 1, 1) = 'Y') then
	    P_PRINT_TOGETHER := 'Y';
	  else
	    P_PRINT_TOGETHER := 'N';
	  end if;
	end if;

	if (sub_request) then
	  issubreq := 'Y';
	end if;

	-- Default NLS language
	if (P_LANGUAGE is NULL) then
	  begin
            select substr(userenv('LANGUAGE'),1,
              instr(userenv('LANGUAGE'), '_') -1)
              into P_LANGUAGE
              from dual;

	    exception
	      when no_data_found then
		raise nls_error;
	      when others then
		raise;
	  end;
	end if;

    	  -- modified by ddhulla to check if the language passed by user is valid language
	  -- if the language specified is invalid raise nls_error
	  begin

		Select count(*) into lang_exists from FND_LANGUAGES L
		where NLS_LANGUAGE = P_LANGUAGE and
		L.INSTALLED_FLAG in ('I', 'B');

		if ( lang_exists = 0 ) then
		   raise nls_error;
		end if;
	  end;

	-- Default NLS territory
	if (P_TERRITORY is NULL) then
	  begin
	    select substr ( userenv('LANGUAGE') ,
			   instr ( userenv('LANGUAGE') , '_') + 1,
			   (instr ( userenv('LANGUAGE') , '.') - 1 -
                            instr ( userenv('LANGUAGE') , '_') ))
	      into P_TERRITORY
	      from dual;

	    exception
	      when no_data_found then
		raise nls_error;
	      when others then
		raise;
	  end;
	end if;

	-- modified by ddhulla to check if the language passed by user is valid language
	begin

		Select count(*) into lang_exists from FND_LANGUAGES L
		where NLS_LANGUAGE = P_LANGUAGE and
		L.INSTALLED_FLAG in ('I', 'B');

		if ( lang_exists = 0 ) then
		   raise nls_error;
		end if;
	end;

        -- TAKE THIS OUT after testing
	-- NLS Project : Default NLS Numeric Characters
        -- VENKAT: indicates we want it to be NULL to start and it will be set
        --         by the Terrirtory default.
	-- if (P_NUMERIC_CHARACTERS is NULL) then
        --   fnd_profile.get('ICX_NUMERIC_CHARACTERS', P_NUMERIC_CHARACTERS);
	-- end if;

	-- Get program's application ID, Concurrent Program Id, cd_param, Printer, Print Style,
	-- Get program's application ID, Concurrent Program Id, cd_param, Printer, Print Style,
	-- Save output flag, priority, submit ops id, request set flag
	-- and Allow Multiple Pending Request Flag
	begin
	  Select A.Application_ID, Concurrent_Program_Id, CD_Parameter,
		 Printer_Name, NVL(Output_Print_Style, 'PORTRAIT'),
		 Required_Style, Minimum_Width,  Minimum_Length,
		 Execution_Method_Code, Save_Output_Flag, Print_Flag,
		 Queue_Control_Flag, request_priority, request_set_flag,
		 DECODE(ops_req_mode,
    'EXPLICIT', NVL(P_OPS_ID,NVL(P.instance_id,fnd_conc_global.ops_inst_num)),
		-1), NVL(Refresh_Portlet, 'N'), NVL(Allow_Multiple_Pending_Request,'Y')
            Into prog_appl_id, conc_prog_id, cd_param,
		 fcp_printer, print_style, reqrd_flag, minwid,
		 minlen, execcode, saveout, prtflg,
		 qctlflg, program_priority, request_set_flag,
		 submit_ops_id, portlet_ref, mult_pending_req
            From Fnd_Concurrent_Programs P, Fnd_Application A
           Where Upper(Concurrent_Program_Name)      = upper(program)
		 And P.Application_ID                = A.Application_ID
		 And Upper(A.Application_Short_Name) = upper(application);

	  exception
	    when no_data_found then
	      raise appl_prog_error;
	    when others then
	      raise;
	end;


	-- check if multiple pending requests are allowed.
	if (mult_pending_req = 'N') then
	-- see if there are some pending requests for this concurrent program
        -- definition of pending: phase_code in P and hold_flag in N and
        -- requested_start_date lessthan sysdate
	begin
          select count(*) into no_pending_req
	    from fnd_concurrent_requests
           where program_application_id = prog_appl_id
	         And concurrent_program_id = conc_prog_id
                 And phase_code = 'P'
                 and hold_flag='N' and requested_start_date <= sysdate;

          exception
            when others then
              raise;
          end;
	end if;

	-- there are some pending requests
	if (no_pending_req <> 0) then
		raise mult_pending_request_error;
	end if;


        -- dishonour request set and stage priority bug #4172967
	if ((P_REQUEST_TYPE = 'M') OR (P_REQUEST_TYPE = 'S')) then
		program_priority := NULL;
	end if;


        if (request_set_flag = 'Y') then
          program_priority := get_request_set_priority(
                                    to_number(argument1),
                                    to_number(argument2));
        end if;

        if (program_priority is null) then
	  profile_buffer := NULL;
	  FND_PROFILE.GET ('CONC_PRIORITY', profile_buffer);
	  priority := to_number(profile_buffer);
        else
          priority := program_priority;
        end if;

	-- Set save output flag.  First look for the token.  Then in FCP,
	-- profiles, and lastly set it to Y

	if (P_SAVE_OUTPUT in ('Y', 'N')) then
	  saveout := P_SAVE_OUTPUT;
	else
	  if (not saveout in ('Y', 'N')) then
	    FND_PROFILE.GET ('CONC_SAVE_OUTPUT', profile_buffer);
	    if (not profile_buffer in ('Y', 'N')) then
	      saveout := 'Y';
	    else
	      saveout := profile_buffer;
	    end if;
	  end if;
	end if;


	-- If submitting an MLS parent request, skip all the post-processing code from here
        if (P_REQUEST_TYPE is null or P_REQUEST_TYPE <> 'B') then

	-- Printer logic

	-- Get default for # of copies
	FND_PROFILE.GET ('CONC_COPIES', profile_buffer);
        if (profile_buffer is not null) then
	  default_copies := To_Number (profile_buffer);
	  if (default_copies < 0) then
	    default_copies := 0;
	  end if;
        else
          default_copies := 0;
        end if;

	-- Is printer specified in FCP?
	if (fcp_printer is null) then
	  FND_PROFILE.GET ('PRINTER', default_printer);
        else
          default_printer := fcp_printer;
	end if;

	-- If style is passed as an argument, use it only if style is
	-- not required in FCP (fcp.required_style = 'N').
        if ((reqrd_flag <> 'Y') and (P_PRINT_STYLE is not null)) then
	  print_style := P_PRINT_STYLE;
	end if;

        -- Get ready for loop.  If no printers were specified, then
        -- we need to set up a default printer if the default copies > 0.
        if ((P_PRINTER_COUNT = 0) and (default_copies >= 0)) then
          P_PRINTERS(1).printer := default_printer;
          P_PRINTERS(1).copies := default_copies;
          P_PRINTER_COUNT := 1;
        end if;

        -- Printer Loop
        for i in 1..P_PRINTER_COUNT loop

          curr_printer := P_PRINTERS(i).printer;
          curr_copies  := P_PRINTERS(i).copies;

          if (curr_copies is null) then
            curr_copies := default_copies;
          end if;

          if (curr_copies >= 0) then
            tot_copies := tot_copies + curr_copies;

            if (curr_printer is null) then
              curr_printer := default_printer;
            end if;

  	    -- Printer validation
	    -- Validate the printer only if we are going to print, which is,
	    -- if the number of copies is > 0, print = Yes, and it is not
	    -- a queue control request (e.g. Deactivate Concurrent Manager).
	    if ((prtflg = 'Y') and (qctlflg <> 'Y')) then
	      -- Error if printer is not specified.
              if (curr_printer is null) then
	        raise printer_error;
	      end if;

              -- If printer is specified in FCP and also passed as an
              -- argument, but they don't match, check
              -- P_VALIDATE_PRINTER
              if ((fcp_printer is not null) and (curr_printer <> fcp_printer)) then
                   if (P_VALIDATE_PRINTER = 'FAIL') then
                      raise printer_error;
                   elsif (P_VALIDATE_PRINTER = 'SKIP') then
                      if (FND_LOG.LEVEL_EVENT >=
                              FND_LOG.G_CURRENT_RUNTIME_LEVEL) then
                        fnd_message.set_name('FND','CONC-Illegal printer spec');
                        fnd_log.message(FND_LOG.LEVEL_EVENT,
                            'fnd.plsql.FND_REQUEST.SUBMIT.printer', FALSE);
                      end if;
                      GOTO next_iteration;
                   else -- P_VALIDATE_PRINTER = 'RESOLVE'
                      if (FND_LOG.LEVEL_EVENT >=
                              FND_LOG.G_CURRENT_RUNTIME_LEVEL) then
                           fnd_message.set_name ('FND',
                                                 'CONC-Illegal printer spec');
                           fnd_log.message(FND_LOG.LEVEL_EVENT,
                               'fnd.plsql.FND_REQUEST.SUBMIT.printer', FALSE);
                           fnd_log.string(FND_LOG.LEVEL_EVENT,
                              'fnd.plsql.FND_REQUEST.SUBMIT.printer',
                              'Invalid printer('||curr_printer||
                              ') specified for program(' ||program||
                              '). Attempting to resolve by using printer: '
                              ||fcp_printer );
                      end if;
                      curr_printer := fcp_printer;
                   end if;
              end if; -- curr_printer <> fcp_printer

	    end if; -- prtflg = 'Y' and qctlflg <> 'Y'

  	    -- Print style logic

	    -- Print style validation

	    if ((prtflg = 'Y') and (print_style is null))
            then
              raise style_error;
            end if;

	    -- We do not need to validate print style if it's a queue
	    -- control request or if the the style is DYNAMIC
	    if ((qctlflg <> 'Y') and (print_style <> 'DYNAMIC')) then
	      styl_ok := fnd_print.get_style (print_style,
					  minwid, maxwid, minlen, maxlen,
					  (reqrd_flag = 'Y'), curr_printer,
					  valid_style);

	      -- If printer and print_style were incompatible, valid_style
	      -- is null.  Also check to see if fnd_printer.get_style failed.
	      if ((valid_style is null) or (not styl_ok)) then

	        -- If we still intend to print, bad news.
	        if (prtflg = 'Y') then

                  -- Check for message on stack
                  encoded_msg := FND_MESSAGE.GET_ENCODED;
                  if (encoded_msg is not null) then
                     FND_MESSAGE.SET_ENCODED(encoded_msg);
                     raise already_msg;
                  end if;

	          raise printer_styl_error;

	        end if; -- ((curr_copies > 0) and (prtflg = 'Y'))
	      end if; -- ((valid_style is null) or (not styl_ok))
	    end if; -- ((qctlflg <> 'Y') and (print_style <> 'DYNAMIC'))

            -- insert the action
            -- (don't print on failure, print on warning only if
            --  CONC_PRINT_WARNING is set to 'Y')

	    profile_buffer := NULL;
	    FND_PROFILE.GET ('CONC_PRINT_WARNING', profile_buffer);
            if (profile_buffer is not null and
                profile_buffer in ('y', 'Y')) then
                print_warning := 'Y';
            end if;


            insert into fnd_conc_pp_actions
               (concurrent_request_id, action_type, status_s_flag,
                status_w_flag, status_f_flag, last_update_date,
                last_updated_by, creation_date, last_update_login,
                created_by, arguments, completed, number_of_copies,
                sequence,ops_instance)
            values
                (cur_request_id, 1, 'Y', print_warning, 'N', sysdate,
                user_id, sysdate, fgloginid, user_id, curr_printer,
                'N', curr_copies, i, submit_ops_id);

          end if; -- Curr_copies > 0
         <<next_iteration>>  --Go to next loop iteration
         null;

        end loop;

        -- The first printer in the list will be written into
        -- fcr.  Reports might use it.  Product teams might also
        -- depend on the printer profile in their requests.
        -- bug 2872883 use default settings when the field is null
        if (P_PRINTER_COUNT > 0) then
           if ( P_PRINTERS(1).printer is null) then
             fcr_printer := default_printer;
           else
             fcr_printer := P_PRINTERS(1).printer;
           end if;
        else
          fcr_printer := fcp_printer;
        end if;

        -- Even if we aren't going to print, we'll populate
        -- the style.  Styles are required by Oracle Reports.
        if (valid_style is null) then
	  -- if it's an Oracle Reports request, we must get
	  -- some (valid) print style
	  if (execcode = 'P') then
	    styl_ok := fnd_print.get_style (print_style,
				            minwid, maxwid,
					    minlen, maxlen,
					    (reqrd_flag = 'Y'),
					    null,
					    valid_style);

	    if ((valid_style is null) or (not styl_ok)) then
              -- Check for message on stack
              encoded_msg := FND_MESSAGE.GET_ENCODED;
              if (encoded_msg is not null) then
                 FND_MESSAGE.SET_ENCODED(encoded_msg);
                 raise already_msg;
              end if;

              raise srw_style_error;
            end if;
          else  -- No need to validate style
            valid_style := print_style;
	  end if; -- (execcode = 'P')
        end if; -- (valid_style is null)


        -- Insert Notifications

        for i in 1..P_NOTIFICATION_COUNT loop
          insert into fnd_conc_pp_actions
             (concurrent_request_id, action_type, status_s_flag,
              status_w_flag, status_f_flag, last_update_date,
              last_updated_by, creation_date, last_update_login,
              created_by, arguments, completed, number_of_copies,
              sequence, orig_system, orig_system_id, ops_instance)
          values
              (cur_request_id, 2,
               P_NOTIFICATIONS(i).on_normal,
               P_NOTIFICATIONS(i).on_warning,
               P_NOTIFICATIONS(i).on_error, sysdate,
              user_id, sysdate, fgloginid, user_id,
              P_NOTIFICATIONS(i).name, 'N', null, i,
	      P_NOTIFICATIONS(i).orig_system,
	      P_NOTIFICATIONS(i).orig_system_id,
	      submit_ops_id);
        end loop;

        -- Insert layout options
        if (P_LAYOUT_COUNT > 0) then

           insert into fnd_conc_pp_actions
              (concurrent_request_id, action_type, status_s_flag,
               status_w_flag, status_f_flag, last_update_date,
               last_updated_by, creation_date, last_update_login,
               created_by, completed, sequence, argument1, argument2,
               argument3, argument4, argument5, ops_instance)
            values
               (cur_request_id, 6, 'Y','Y','Y',
                sysdate, user_id, sysdate, fgloginid, user_id, 'N', 1,
                P_LAYOUTS(1).template_appl_name, P_LAYOUTS(1).template_code, P_LAYOUTS(1).template_language,
		P_LAYOUTS(1).template_territory, P_LAYOUTS(1).output_format, submit_ops_id);

        end if;


	-- Insert delivery options
        if (P_DELIV_OPTS_COUNT > 0) then

	  for i in 1..P_DELIV_OPTS_COUNT loop
          insert into fnd_conc_pp_actions
             (concurrent_request_id, action_type,
	      status_s_flag, status_w_flag, status_f_flag,
	      last_update_date, last_updated_by, creation_date,
	      last_update_login, created_by,
	      completed, sequence,
	      argument1, argument2, argument3, argument4, argument5,
	      argument6, argument7, argument8, argument9, argument10,
	      ops_instance)
          values
              (cur_request_id, 7,
               'Y', 'Y', 'N',
	       sysdate, user_id, sysdate,
	       fgloginid, user_id,
	       'N', i,
	       P_DELIVERY_OPTIONS(i).argument1, P_DELIVERY_OPTIONS(i).argument2,
	       P_DELIVERY_OPTIONS(i).argument3, P_DELIVERY_OPTIONS(i).argument4,
	       P_DELIVERY_OPTIONS(i).argument5, P_DELIVERY_OPTIONS(i).argument6,
	       P_DELIVERY_OPTIONS(i).argument7, P_DELIVERY_OPTIONS(i).argument8,
	       P_DELIVERY_OPTIONS(i).argument9, P_DELIVERY_OPTIONS(i).argument10,
	       submit_ops_id);
          end loop;


	end if;


        end if; -- if (P_REQUEST_TYPE <> 'B')
	-- End skipping MLS requests


	-- Get Oracle ID to run program from
	begin
	  -- First, see if datagroup is set with options
	  if (P_DATAGROUP is not null) then
	    Select Oracle_Username
	      Into oraclacct
	      From Fnd_Data_Group_Units U,
		   Fnd_Data_Groups G,
		   Fnd_Oracle_Userid O
	     Where Data_Group_Name = P_DATAGROUP
	       And U.Data_Group_Id = G.Data_Group_Id
	       And U.Oracle_Id     = O.Oracle_Id
	       And Application_Id  = prog_appl_id;

	  else -- default dgrp
	    Select O.Oracle_Username
	      Into oraclacct
	      From Fnd_Data_Group_Units U,
		   Fnd_Responsibility R,
		   Fnd_Oracle_Userid O
	     Where R.Application_ID        = resp_appl_id
		   And R.Responsibility_ID = resp_id
		   And R.Data_Group_ID     = U.Data_Group_ID
		   And O.Oracle_ID         = U.Oracle_ID
		   And U.Application_ID    = prog_appl_id;
	  end if;

	  exception
	    when no_data_found then
	      raise oracle_name_error;
	    when others then
	      raise;
	end;

	-- Fetch Login ID for the request from the sequnce generator.
	-- Insert the record in Fnd_Logins if the request submission
	-- successful.
	begin
	  Select Fnd_Logins_S.nextval
	    Into loginid
	    From Sys.Dual;

	  exception
	    when no_data_found then
	      raise dual_no_rows;
	    when too_many_rows then
	      raise dual_too_many_rows;
	    when others then
	      raise;
	end;

	-- Count the number of arguments and bulid argstr
	if (argument1 = CHR(0)) then goto end_args; end if;
	nargs := 1;
	argtxt := argtxt||argument1;
	if (argument2 = CHR(0)) then goto end_args; end if;
	nargs := 2;
	argtxt := argtxt|| ', '||argument2;
	if (argument3 = CHR(0)) then goto end_args; end if;
	nargs := 3;
	argtxt := argtxt|| ', '||argument3;
	if (argument4 = CHR(0)) then goto end_args; end if;
	nargs := 4;
	argtxt := argtxt||', '||argument4;
	if (argument5 = CHR(0)) then goto end_args; end if;
	nargs := 5;
	argtxt := argtxt||', '||argument5;
	if (argument6 = CHR(0)) then goto end_args; end if;
	nargs := 6;
	argtxt := argtxt||', '||argument6;
	if (argument7 = CHR(0)) then goto end_args; end if;
	nargs := 7;
	argtxt := argtxt||', '||argument7;
	if (argument8 = CHR(0)) then goto end_args; end if;
	nargs := 8;
	argtxt := argtxt||', '||argument8;
	if (argument9 = CHR(0)) then goto end_args; end if;
	nargs := 9;
	argtxt := argtxt||', '||argument9;
	if (argument10 = CHR(0)) then goto end_args; end if;
	nargs := 10;
	argtxt := argtxt||', '||argument10;
	if (argument11 = CHR(0)) then goto end_args; end if;
	nargs := 11;
	argtxt := argtxt||', '||argument11;
	if (argument12 = CHR(0)) then goto end_args; end if;
	nargs := 12;
	argtxt := argtxt||', '||argument12;
	if (argument13 = CHR(0)) then goto end_args; end if;
	nargs := 13;
	argtxt := argtxt||', '||argument13;
	if (argument14 = CHR(0)) then goto end_args; end if;
	nargs := 14;
	argtxt := argtxt||', '||argument14;
	if (argument15 = CHR(0)) then goto end_args; end if;
	nargs := 15;
	argtxt := argtxt||', '||argument15;
	if (argument16 = CHR(0)) then goto end_args; end if;
	nargs := 16;
	argtxt := argtxt||', '||argument16;
	if (argument17 = CHR(0)) then goto end_args; end if;
	nargs := 17;
	argtxt := argtxt||', '||argument17;
	if (argument18 = CHR(0)) then goto end_args; end if;
	nargs := 18;
	argtxt := argtxt||', '||argument18;
	if (argument19 = CHR(0)) then goto end_args; end if;
	nargs := 19;
	argtxt := argtxt||', '||argument19;
	if (argument20 = CHR(0)) then goto end_args; end if;
	nargs := 20;
	argtxt := argtxt||', '||argument20;
	if (argument21 = CHR(0)) then goto end_args; end if;
	nargs := 21;
	argtxt := argtxt||', '||argument21;
	if (argument22 = CHR(0)) then goto end_args; end if;
	nargs := 22;
	argtxt := argtxt||', '||argument22;
	if (argument23 = CHR(0)) then goto end_args; end if;
	nargs := 23;
	argtxt := argtxt||', '||argument23;
	if (argument24 = CHR(0)) then goto end_args; end if;
	nargs := 24;
	argtxt := argtxt||', '||argument24;
	if (argument25 = CHR(0)) then goto end_args; end if;
	nargs := 25;
	argtxt := argtxt||', '||argument25;
	if (argument26 = CHR(0)) then goto end_args; end if;
	nargs := 26;
	argtxt := argtxt||', '||argument26;
	if (argument27 = CHR(0)) then goto end_args; end if;
	nargs := 27;
	argtxt := argtxt||', '||argument27;
	if (argument28 = CHR(0)) then goto end_args; end if;
	nargs := 28;
	argtxt := argtxt||', '||argument28;
	if (argument29 = CHR(0)) then goto end_args; end if;
	nargs := 29;
	argtxt := argtxt||', '||argument29;
	if (argument30 = CHR(0)) then goto end_args; end if;
	nargs := 30;
	argtxt := argtxt||', '||argument30;
	if (argument31 = CHR(0)) then goto end_args; end if;
	nargs := 31;
	argtxt := argtxt||', '||argument31;
	if (argument32 = CHR(0)) then goto end_args; end if;
	nargs := 32;
	argtxt := argtxt||', '||argument32;
	if (argument33 = CHR(0)) then goto end_args; end if;
	nargs := 33;
	argtxt := argtxt||', '||argument33;
	if (argument34 = CHR(0)) then goto end_args; end if;
	nargs := 34;
	argtxt := argtxt||', '||argument34;
	if (argument35 = CHR(0)) then goto end_args; end if;
	nargs := 35;
	argtxt := argtxt||', '||argument35;
	if (argument36 = CHR(0)) then goto end_args; end if;
	nargs := 36;
	argtxt := argtxt||', '||argument36;
	if (argument37 = CHR(0)) then goto end_args; end if;
	nargs := 37;
	argtxt := argtxt||', '||argument37;
	if (argument38 = CHR(0)) then goto end_args; end if;
	nargs := 38;
	argtxt := argtxt||', '||argument38;
	if (argument39 = CHR(0)) then goto end_args; end if;
	nargs := 39;
	argtxt := argtxt||', '||argument39;
	if (argument40 = CHR(0)) then goto end_args; end if;
	nargs := 40;
	argtxt := argtxt||', '||argument40;
	if (argument41 = CHR(0)) then goto end_args; end if;
	nargs := 41;
	argtxt := argtxt||', '||argument41;
	if (argument42 = CHR(0)) then goto end_args; end if;
	nargs := 42;
	argtxt := argtxt||', '||argument42;
	if (argument43 = CHR(0)) then goto end_args; end if;
	nargs := 43;
	argtxt := argtxt||', '||argument43;
	if (argument44 = CHR(0)) then goto end_args; end if;
	nargs := 44;
	argtxt := argtxt||', '||argument44;
	if (argument45 = CHR(0)) then goto end_args; end if;
	nargs := 45;
	argtxt := argtxt||', '||argument45;
	if (argument46 = CHR(0)) then goto end_args; end if;
	nargs := 46;
	argtxt := argtxt||', '||argument46;
	if (argument47 = CHR(0)) then goto end_args; end if;
	nargs := 47;
	argtxt := argtxt||', '||argument47;
	if (argument48 = CHR(0)) then goto end_args; end if;
	nargs := 48;
	argtxt := argtxt||', '||argument48;
	if (argument49 = CHR(0)) then goto end_args; end if;
	nargs := 49;
	argtxt := argtxt||', '||argument49;
	if (argument50 = CHR(0)) then goto end_args; end if;
	nargs := 50;
	argtxt := argtxt||', '||argument50;
	if (argument51 = CHR(0)) then goto end_args; end if;
	nargs := 51;
	argtxt := argtxt||', '||argument51;
	if (argument52 = CHR(0)) then goto end_args; end if;
	nargs := 52;
	argtxt := argtxt||', '||argument52;
	if (argument53 = CHR(0)) then goto end_args; end if;
	nargs := 53;
	argtxt := argtxt||', '||argument53;
	if (argument54 = CHR(0)) then goto end_args; end if;
	nargs := 54;
	argtxt := argtxt||', '||argument54;
	if (argument55 = CHR(0)) then goto end_args; end if;
	nargs := 55;
	argtxt := argtxt||', '||argument55;
	if (argument56 = CHR(0)) then goto end_args; end if;
	nargs := 56;
	argtxt := argtxt||', '||argument56;
	if (argument57 = CHR(0)) then goto end_args; end if;
	nargs := 57;
	argtxt := argtxt||', '||argument57;
	if (argument58 = CHR(0)) then goto end_args; end if;
	nargs := 58;
	argtxt := argtxt||', '||argument58;
	if (argument59 = CHR(0)) then goto end_args; end if;
	nargs := 59;
	argtxt := argtxt||', '||argument59;
	if (argument60 = CHR(0)) then goto end_args; end if;
	nargs := 60;
	argtxt := argtxt||', '||argument60;
	if (argument61 = CHR(0)) then goto end_args; end if;
	nargs := 61;
	argtxt := argtxt||', '||argument61;
	if (argument62 = CHR(0)) then goto end_args; end if;
	nargs := 62;
	argtxt := argtxt||', '||argument62;
	if (argument63 = CHR(0)) then goto end_args; end if;
	nargs := 63;
	argtxt := argtxt||', '||argument63;
	if (argument64 = CHR(0)) then goto end_args; end if;
	nargs := 64;
	argtxt := argtxt||', '||argument64;
	if (argument65 = CHR(0)) then goto end_args; end if;
	nargs := 65;
	argtxt := argtxt||', '||argument65;
	if (argument66 = CHR(0)) then goto end_args; end if;
	nargs := 66;
	argtxt := argtxt||', '||argument66;
	if (argument67 = CHR(0)) then goto end_args; end if;
	nargs := 67;
	argtxt := argtxt||', '||argument67;
	if (argument68 = CHR(0)) then goto end_args; end if;
	nargs := 68;
	argtxt := argtxt||', '||argument68;
	if (argument69 = CHR(0)) then goto end_args; end if;
	nargs := 69;
	argtxt := argtxt||', '||argument69;
	if (argument70 = CHR(0)) then goto end_args; end if;
	nargs := 70;
	argtxt := argtxt||', '||argument70;
	if (argument71 = CHR(0)) then goto end_args; end if;
	nargs := 71;
	argtxt := argtxt||', '||argument71;
	if (argument72 = CHR(0)) then goto end_args; end if;
	nargs := 72;
	argtxt := argtxt||', '||argument72;
	if (argument73 = CHR(0)) then goto end_args; end if;
	nargs := 73;
	argtxt := argtxt||', '||argument73;
	if (argument74 = CHR(0)) then goto end_args; end if;
	nargs := 74;
	argtxt := argtxt||', '||argument74;
	if (argument75 = CHR(0)) then goto end_args; end if;
	nargs := 75;
	argtxt := argtxt||', '||argument75;
	if (argument76 = CHR(0)) then goto end_args; end if;
	nargs := 76;
	argtxt := argtxt||', '||argument76;
	if (argument77 = CHR(0)) then goto end_args; end if;
	nargs := 77;
	argtxt := argtxt||', '||argument77;
	if (argument78 = CHR(0)) then goto end_args; end if;
	nargs := 78;
	argtxt := argtxt||', '||argument78;
	if (argument79 = CHR(0)) then goto end_args; end if;
	nargs := 79;
	argtxt := argtxt||', '||argument79;
	if (argument80 = CHR(0)) then goto end_args; end if;
	nargs := 80;
	argtxt := argtxt||', '||argument80;
	if (argument81 = CHR(0)) then goto end_args; end if;
	nargs := 81;
	argtxt := argtxt||', '||argument81;
	if (argument82 = CHR(0)) then goto end_args; end if;
	nargs := 82;
	argtxt := argtxt||', '||argument82;
	if (argument83 = CHR(0)) then goto end_args; end if;
	nargs := 83;
	argtxt := argtxt||', '||argument83;
	if (argument84 = CHR(0)) then goto end_args; end if;
	nargs := 84;
	argtxt := argtxt||', '||argument84;
	if (argument85 = CHR(0)) then goto end_args; end if;
	nargs := 85;
	argtxt := argtxt||', '||argument85;
	if (argument86 = CHR(0)) then goto end_args; end if;
	nargs := 86;
	argtxt := argtxt||', '||argument86;
	if (argument87 = CHR(0)) then goto end_args; end if;
	nargs := 87;
	argtxt := argtxt||', '||argument87;
	if (argument88 = CHR(0)) then goto end_args; end if;
	nargs := 88;
	argtxt := argtxt||', '||argument88;
	if (argument89 = CHR(0)) then goto end_args; end if;
	nargs := 89;
	argtxt := argtxt||', '||argument89;
	if (argument90 = CHR(0)) then goto end_args; end if;
	nargs := 90;
	argtxt := argtxt||', '||argument90;
	if (argument91 = CHR(0)) then goto end_args; end if;
	nargs := 91;
	argtxt := argtxt||', '||argument91;
	if (argument92 = CHR(0)) then goto end_args; end if;
	nargs := 92;
	argtxt := argtxt||', '||argument92;
	if (argument93 = CHR(0)) then goto end_args; end if;
	nargs := 93;
	argtxt := argtxt||', '||argument93;
	if (argument94 = CHR(0)) then goto end_args; end if;
	nargs := 94;
	argtxt := argtxt||', '||argument94;
	if (argument95 = CHR(0)) then goto end_args; end if;
	nargs := 95;
	argtxt := argtxt||', '||argument95;
	if (argument96 = CHR(0)) then goto end_args; end if;
	nargs := 96;
	argtxt := argtxt||', '||argument96;
	if (argument97 = CHR(0)) then goto end_args; end if;
	nargs := 97;
	argtxt := argtxt||', '||argument97;
	if (argument98 = CHR(0)) then goto end_args; end if;
	nargs := 98;
	argtxt := argtxt||', '||argument98;
	if (argument99 = CHR(0)) then goto end_args; end if;
	nargs := 99;
	argtxt := argtxt||', '||argument99;
	if (argument100 = CHR(0)) then goto end_args; end if;
	nargs := 100;
	argtxt := argtxt||', '||argument100;

	<<end_args>>

	argtxt2 := substrb(argtxt, 1, 240);

	-- Get conflicts domain - cd_id
	-- First, try program parameter
	if (cd_param is not null) then
	   cd_id := fndcp_crm.get_cd_id (
			      application, program,
			      user_id, user_id,
			      cd_param, nargs,
			      argument1,  argument2,  argument3,  argument4,
			      argument5,  argument6,  argument7,  argument8,
			      argument9,  argument10, argument11, argument12,
			      argument13, argument14, argument15, argument16,
			      argument17, argument18, argument19, argument20,
			      argument21, argument22, argument23, argument24,
			      argument25, argument26, argument27, argument28,
			      argument29, argument30, argument31, argument32,
			      argument33, argument34, argument35, argument36,
			      argument37, argument38, argument39, argument40,
			      argument41, argument42, argument43, argument44,
			      argument45, argument46, argument47, argument48,
			      argument49, argument50, argument51, argument52,
			      argument53, argument54, argument55, argument56,
			      argument57, argument58, argument59, argument60,
			      argument61, argument62, argument63, argument64,
			      argument65, argument66, argument67, argument68,
			      argument69, argument70, argument71, argument72,
			      argument73, argument74, argument75, argument76,
			      argument77, argument78, argument79, argument80,
			      argument81, argument82, argument83, argument84,
			      argument85, argument86, argument87, argument88,
			      argument89, argument90, argument91, argument92,
			      argument93, argument94, argument95, argument96,
			      argument97, argument98, argument99, argument100);
	end if;

	-- Next try profile
	if (cd_id = -1) then
	  profile_buffer := NULL;
	  FND_PROFILE.GET ('CONC_CD_ID', profile_buffer);
	  if (profile_buffer is not null) then
	     cd_id := To_Number (profile_buffer);
	  else
	     cd_id := 0;
	  end if;
	end if;

	-- Create request
	-- Bug8887553: Added condition of P_REPEAT_TIME for request set resubmission
	if (P_REL_CLASS_ID is null) and (P_REPEAT_INTERVAL is not null
	or P_REPEAT_TIME is not null) then
	 new_class := TRUE;
	 begin
	   Select FND_CONC_RELEASE_CLASSES_S.nextval, 0
	     into P_REL_CLASS_ID, P_REL_CLASS_APP_ID from Sys.dual;
	  exception
	    when no_data_found then
	      raise dual_no_rows;
	    when too_many_rows then
	      raise dual_too_many_rows;
	    when others then
	      raise;
	  end;
	end if;

	Insert
	  Into Fnd_Concurrent_Requests (
		Request_Id, security_group_id,
		Phase_Code, Status_Code,
		Priority, Parent_Request_ID, Priority_Request_ID,
		Description, Req_Information,
		Is_Sub_Request, Has_Sub_Request, Update_Protected,
		Hold_Flag, Enforce_Seriality_Flag, Single_Thread_Flag,
		Argument_Input_Method_Code, Implicit_Code,

		Request_Date, Requested_Start_Date, Requested_By,
		Last_Update_Date, Last_Updated_By, Last_Update_Login,

		Oracle_Id, Conc_Login_Id,
		Responsibility_Id, Responsibility_Application_Id,
		Nls_Language, Nls_Territory, Nls_Numeric_Characters,

		Program_Application_Id, Concurrent_Program_Id,
		Queue_Method_Code,
		Request_Class_Application_Id, Concurrent_Request_Class_Id,

		Print_Group, Printer, Print_Style,
		Number_Of_Copies, Save_Output_Flag,  CRM_THRSHLD,

		Resubmit_Time, Resubmit_Interval,
		Resubmit_Interval_Unit_Code, Resubmit_Interval_Type_Code,
		Resubmit_End_Date, Resubmitted, Critical, Request_Type,

                RELEASE_CLASS_APP_ID, RELEASE_CLASS_ID,
		STALE_DATE, CANCEL_OR_HOLD,

                Output_File_Type, nls_compliant,
		CD_ID, Request_Limit, Increment_Dates,
                Enable_Trace, OPS_Instance, ORG_ID,
                Node_Name1, Connstr1,

		Argument_Text, Number_Of_Arguments,
		Argument1,  Argument2,  Argument3,  Argument4,  Argument5,
		Argument6,  Argument7,  Argument8,  Argument9,  Argument10,
		Argument11, Argument12, Argument13, Argument14, Argument15,
		Argument16, Argument17, Argument18, Argument19, Argument20,
		Argument21, Argument22, Argument23, Argument24, Argument25)

	Select cur_request_id, z_security_group_id,
	       Phase, Decode (submit.Status,
			      'A', 'A',
			      'Z', 'Z',
                                   Decode(FCP.Queue_Method_Code,
                                          'B', 'Q',
                                           Decode (st_flag,
                                                    'Y', 'Q',
						Decode(Req_Limit, 'Y', 'Q',
                                                                   'I')))),
	       Decode (FCP.Queue_Control_Flag,
		       'Y', NVL(FCP.Request_Priority, 0),
			    Decode (submit.priority,
				    null, 50,
					  submit.priority)),
	       Decode (par_request_id,
		       0, NULL,
			  par_request_id),
	       cur_req_pri_id,
	       submit.description, NULL,
	       issubreq, 'N', P_PROTECTED,
	       submit.hold_flag, 'Y', st_flag,
	       'S', P_IMPLICIT,

	       SYSDATE,
	       Decode (requested_start,
		       '', (SYSDATE - tz_offset),
			   Greatest (requested_start,
			  	     Decode (par_request_id,
					     0, (SYSDATE - tz_offset),
						fnd_conc_date.string_to_date (
                                                         '01-01-0001')))),
	       submit.user_id,
	       SYSDATE, submit.user_id, loginid,

	       Oracle_ID, loginid,
	       resp_id, resp_appl_id,
	       P_LANGUAGE, P_TERRITORY, P_NUMERIC_CHARACTERS,

	       FA.Application_ID, FCP.Concurrent_Program_ID,
	       Decode(Req_Limit,
		      'Y', 'B',
		      Decode(st_flag,
		             'N', FCP.Queue_Method_Code,
			      'B')),
	       FCP.Class_Application_ID, FCP.Concurrent_Class_ID,

	       P_PRINT_TOGETHER, fcr_printer, valid_style,
	       tot_copies, saveout, request_threshold,
	       Decode (P_REPEAT_TIME,
		       '', NULL,
			   To_Char (fnd_conc_date.string_to_date (
                                        '01-01-0001' || P_REPEAT_TIME),
					      'HH24:MI:SS')),
	       Decode (P_REPEAT_INTERVAL,
		       '', NULL,
			   P_REPEAT_INTERVAL),
	       P_REPEAT_INTERVAL_UNIT, P_REPEAT_INTERVAL_TYPE,
	       P_REPEAT_END,
	       'N', P_CRITICAL_REQUEST, P_REQUEST_TYPE,

	       P_REL_CLASS_APP_ID, P_REL_CLASS_ID,
	       P_REL_STALE_DATE, P_REL_CANCEL_OR_HOLD,

               FCP.Output_File_Type,  FCP.nls_compliant,
 	       CD_ID, Req_limit, P_INCREMENT_DATES,
               decode(trace_enabled, 'Y', 'Y', FCP.Enable_Trace),
               submit_ops_id, P_ORG_ID,
               P_NODE_NAME1, P_CONNSTR1,
	       argtxt2, nargs,
	       submit.argument1,  submit.argument2,
	       submit.argument3,  submit.argument4,
	       submit.argument5,  submit.argument6,
	       submit.argument7,  submit.argument8,
	       submit.argument9,  submit.argument10,
	       submit.argument11, submit.argument12,
	       submit.argument13, submit.argument14,
	       submit.argument15, submit.argument16,
	       submit.argument17, submit.argument18,
	       submit.argument19, submit.argument20,
	       submit.argument21, submit.argument22,
	       submit.argument23, submit.argument24,
	       submit.argument25

	  From Fnd_Application FA,
	       Fnd_Concurrent_Programs FCP,
	       Fnd_Oracle_Userid
	 Where
	       Oracle_Username  = oraclacct
	   And FCP.Enabled_Flag = 'Y'
	   And (FCP.Application_ID = FA.Application_ID And
		Concurrent_Program_Name   = Upper (program))
	   And  FA.Application_Short_Name = Upper (application);

	if (sql%rowcount = 0) then
	  raise insert_error;
	end if;

	if (nargs > 25) then
	  Insert
	    Into Fnd_Conc_Request_Arguments (
		Request_Id,
		Argument26, Argument27, Argument28, Argument29, Argument30,
		Argument31, Argument32, Argument33, Argument34, Argument35,
		Argument36, Argument37, Argument38, Argument39, Argument40,
		Argument41, Argument42, Argument43, Argument44, Argument45,
		Argument46, Argument47, Argument48, Argument49, Argument50,
		Argument51, Argument52, Argument53, Argument54, Argument55,
		Argument56, Argument57, Argument58, Argument59, Argument60,
		Argument61, Argument62, Argument63, Argument64, Argument65,
		Argument66, Argument67, Argument68, Argument69, Argument70,
		Argument71, Argument72, Argument73, Argument74, Argument75,
		Argument76, Argument77, Argument78, Argument79, Argument80,
		Argument81, Argument82, Argument83, Argument84, Argument85,
		Argument86, Argument87, Argument88, Argument89, Argument90,
		Argument91, Argument92, Argument93, Argument94, Argument95,
		Argument96, Argument97, Argument98, Argument99, Argument100)

	  Select cur_request_id,
		submit.argument26,
		submit.argument27, submit.argument28,
		submit.argument29, submit.argument30,
		submit.argument31, submit.argument32,
		submit.argument33, submit.argument34,
		submit.argument35, submit.argument36,
		submit.argument37, submit.argument38,
		submit.argument39, submit.argument40,
		submit.argument41, submit.argument42,
		submit.argument43, submit.argument44,
		submit.argument45, submit.argument46,
		submit.argument47, submit.argument48,
		submit.argument49, submit.argument50,
		submit.argument51, submit.argument52,
		submit.argument53, submit.argument54,
		submit.argument55, submit.argument56,
		submit.argument57, submit.argument58,
		submit.argument59, submit.argument60,
		submit.argument61, submit.argument62,
		submit.argument63, submit.argument64,
		submit.argument65, submit.argument66,
		submit.argument67, submit.argument68,
		submit.argument69, submit.argument70,
		submit.argument71, submit.argument72,
		submit.argument73, submit.argument74,
		submit.argument75, submit.argument76,
		submit.argument77, submit.argument78,
		submit.argument79, submit.argument80,
		submit.argument81, submit.argument82,
		submit.argument83, submit.argument84,
		submit.argument85, submit.argument86,
		submit.argument87, submit.argument88,
		submit.argument89, submit.argument90,
		submit.argument91, submit.argument92,
		submit.argument93, submit.argument94,
		submit.argument95, submit.argument96,
		submit.argument97, submit.argument98,
		submit.argument99, submit.argument100

	    From Sys.Dual;
	end if; -- (nargs > 25)

	if (sql%rowcount = 0) then
	  raise args_insert_error;
	end if;

        -- assign any Post Processing PL/SQL actions
        Begin
           if ( portlet_ref = 'S' ) then  -- on success
              p_on_success := 'Y';
           elsif ( portlet_ref = 'W' ) then  -- on warning (success and warning)
              p_on_success := 'Y';
              p_on_warning := 'Y';
           elsif (portlet_ref = 'A' ) then  -- always (success,warning,error)
              p_on_success := 'Y';
              p_on_warning := 'Y';
              p_on_error   := 'Y';
           end if;

           if ( portlet_ref <> 'N' ) then
              pp_plsql_step := FND_CONC_PP.Assign('FND',
                                 'FNDPRUPD',
                                 cur_request_id,
                                 p_on_success, p_on_warning, p_on_error,
                                 null, null, null, null, null,
                                 null, null, null, null, null );
              if ( pp_plsql_step < 0 ) then
                raise pp_plsql_exception;
              end if;
           end if;

           -- as safe side catching this exception for any fnd_conc_pp.assign
           -- call exception
           exception when others then
              raise pp_plsql_exception;
        end;

	-- Insert into fnd_conc_rel_classes
	if (P_REPEAT_TIME is not NULL) then
	   P_REPEAT_INTERVAL := 1;
	   P_REPEAT_INTERVAL_UNIT := 'DAYS';
	   P_REPEAT_INTERVAL_TYPE := 'START';
	end if;


	if (new_class) then
	  begin
            INSERT INTO Fnd_Conc_Release_Classes
            (APPLICATION_ID,     RELEASE_CLASS_ID,
             RELEASE_CLASS_NAME, OWNER_REQ_ID,
             ENABLED_FLAG,       LAST_UPDATE_DATE,
             LAST_UPDATED_BY,    LAST_UPDATE_LOGIN,
             CREATION_DATE,      CREATED_BY,
             UPDATED_FLAG,       CLASS_TYPE,
             CLASS_INFO,         START_DATE_ACTIVE,
             END_DATE_ACTIVE,    DATE1, DATE2)
                Select 0, P_REL_CLASS_ID,
                        'Request - '|| cur_request_id, cur_request_id,
                        'Y',     Sysdate,
                        submit.user_id, loginid,
                        Sysdate,   submit.user_id,
                        'Y', decode(P_REPEAT_INTERVAL, NULL, 'O', 'P'),
                       Decode(P_REPEAT_INTERVAL_UNIT, NULL, NULL,
                              P_REPEAT_INTERVAL||':'||
                                 Decode(P_REPEAT_INTERVAL_UNIT,
						  'MINUTES', 'N',
                                                  'MONTHS', 'M',
                                                  'HOURS', 'H',
                                                  'DAYS',  'D') || ':' ||
                                     Decode(P_REPEAT_INTERVAL_TYPE,
						  'START', 'S', 'C')),
                       null, null,
                       Requested_start_date, resubmit_end_date
                   From Fnd_Concurrent_Requests
                  Where Request_ID = cur_request_id;

	    if (sql%rowcount = 0) then
	      raise relclass_insert_error;
	    end if;

            INSERT INTO Fnd_Conc_Release_Classes_TL
            (APPLICATION_ID,     RELEASE_CLASS_ID,
             LANGUAGE, SOURCE_LANG, USER_RELEASE_CLASS_NAME,
             LAST_UPDATE_DATE,
             LAST_UPDATED_BY,    LAST_UPDATE_LOGIN,
             CREATION_DATE,      CREATED_BY)
                Select 0, P_REL_CLASS_ID,
                        L.LANGUAGE_CODE,userenv('LANG'),
			'Request - '|| cur_request_id,
                        Sysdate,
                        submit.user_id, loginid,
                        Sysdate,  submit.user_id
             from FND_LANGUAGES L
             where L.INSTALLED_FLAG in ('I', 'B');

	    if (sql%rowcount = 0) then
	      raise relclass_insert_error;
	    end if;

	 end;
       end if;

	-- Insert into Fnd_Logins
	if (subloginid is not null) then
	  begin
	    Insert
	      into Fnd_Logins (
		   Login_Id, User_Id,
		   Start_Time, End_Time,
		   Pid, Spid, Terminal_ID,
		   Login_Name, Submitted_Login_Id)
	    Values (
                   loginid, submit.user_id,
		   Sysdate, Null,
		   Null, Null, 'Concurrent',
		   Null, subloginid);

	    if (sql%rowcount = 0) then
	      raise login_insert_error;
	    end if;
	  end;
	end if; -- (subloginid is not null)

	-- Submitted request successfully

        -- Call FND_GLOBAL.RT_TEST_ID() to see if needs to write the request
        -- id into FND_RT_REQUESTS table.
        rttestid := FND_GLOBAL.RT_TEST_ID;
        if (rttestid <> -1) then
	  FND_RT_REQUEST.LOG_REQUEST(rttestid, cur_request_id);
        end if;
	IF (P_USES_REL_CLASS = 1 AND schedule_type = 'X') THEN
		begin
		select c.resubmit_interval, c.resubmit_interval_unit_code, c.resubmit_interval_type_code
		into adv_sch_ri, adv_sch_riuc, adv_sch_ritc
		from fnd_conc_release_classes c, fnd_concurrent_requests r
		where r.request_id = cur_request_id and r.release_class_id = c.release_class_id
			and r.release_class_app_id = c.application_id;
		exception when others then
			adv_sch_ri := null;
			adv_sch_riuc := null;
			adv_sch_ritc := null;
		end;
		update fnd_concurrent_requests fcr
		set  fcr.resubmit_interval = nvl(adv_sch_ri,1),
			fcr.resubmit_interval_unit_code = nvl(adv_sch_riuc,'DAYS'),
			fcr.resubmit_interval_type_code = nvl(adv_sch_ritc,'START'),
			fcr.status_code = 'P'
		where fcr.request_id = cur_request_id;
	END IF ;
	--
	--  raising business event for request submitted
	--  bug6623316
	--
        discard_status:=fnd_concurrent_business_event.raise_cp_bi_event(cur_request_id,fnd_concurrent_business_event.request_submitted);

	return (cur_request_id);

	exception
	  when printer_error then
	    fnd_message.set_name ('FND', 'CONC-Illegal printer spec');
	    return (0);
	  when style_error then
	    fnd_message.set_name ('FND', 'SRS-Must specify print style');
	    return (0);
	  when printer_styl_error then
	    fnd_message.set_name ('FND', 'CONC-Invalid printer style');
	    fnd_message.set_token ('STYLE', print_style, FALSE);
	    fnd_message.set_token ('PRINTER', curr_printer, FALSE);
	    return (0);
	  when srw_style_error then
	    fnd_message.set_name ('FND', 'SRS-Must specify srw style');
	    return (0);
	  when oracle_name_error then
	    fnd_message.set_name ('FND', 'CONC-Failed to get oracle name');
	    return (0);
	  when start_time_error then
	    fnd_message.set_name ('FND', 'CONC-Invalid Req Start Date');
	    fnd_message.set_token ('START_DATE', requested_start, FALSE);
	    return (0);
	  when dup_val_on_index then
	    fnd_message.set_name ('FND', 'CONC-Duplicate request id');
	    fnd_message.set_token ('REQUEST_ID', cur_request_id, FALSE);
	    return (0);
	  when nls_error then
	    fnd_message.set_name ('FND', 'GLI-Not found');
	    return (0);
	  when appl_prog_error then -- Appl or program invalid
	    begin -- Is the appl short name correct?
	      Select Application_ID
		Into prog_appl_id
		From Fnd_Application
	       Where Application_Short_Name = upper (application);

	      exception
		when no_data_found then
		  fnd_message.set_name ('FND', 'CONC-Invalid Appl Short Name');
		  fnd_message.set_token ('APPLNAME', application, FALSE);
		  return (0);
		when others then
		  fnd_message.set_name ('FND', 'SQL-Generic error');
		  fnd_message.set_token ('ERRNO', sqlcode, FALSE);
		  fnd_message.set_token ('REASON', sqlerrm, FALSE);
		  fnd_message.set_token (
				'ROUTINE', 'SUBMIT: appl_prog_error', FALSE);
		  return (0);
	    end; -- Is the appl short name correct?

	    -- It must be the program
	    fnd_message.set_name ('FND', 'CONC-Invalid Conc program');
	    fnd_message.set_token ('PROGRAM', program, FALSE);
	    return (0);

	  when insert_error then  -- Find the problem
	    begin -- Is the program enabled?
	      Select null
		Into Dummy
		From Fnd_Concurrent_Programs
	       Where Application_ID = prog_appl_id
		 And upper (Concurrent_Program_Name) = upper (program)
		 And Enabled_Flag = 'Y';

	      exception
		when no_data_found then
		  fnd_message.set_name ('FND', 'CONC-Conc program disabled');
		  fnd_message.set_token ('PROGRAM', program, FALSE);
		  return (0);
		when others then
		  fnd_message.set_name ('FND', 'SQL-Generic error');
		  fnd_message.set_token ('ERRNO', sqlcode, FALSE);
		  fnd_message.set_token ('REASON', sqlerrm, FALSE);
		  fnd_message.set_token (
				'ROUTINE', 'SUBMIT: insert_error2', FALSE);
		  return (0);
	    end; -- Is the program enabled?

	  when args_insert_error then
	    fnd_message.set_name ('FND', 'SQL-Generic error');
	    fnd_message.set_token ('ERRNO', sqlcode, FALSE);
	    fnd_message.set_token ('REASON', sqlerrm, FALSE);
	    fnd_message.set_token (
				'ROUTINE', 'SUBMIT: args_insert_error', FALSE);
	    return (0);
	  when login_insert_error then
	    fnd_message.set_name ('FND', 'CONC-Login insert failed');
	    fnd_message.set_token ('LOGIN', loginid, FALSE);
	    return (0);
	  when relclass_insert_error then
	    fnd_message.set_name ('FND', 'CONC-RelClass insert failed');
	    fnd_message.set_token ('APPLICATION', P_REL_CLASS_APP_ID, FALSE);
	    fnd_message.set_token ('CLASS', P_REL_CLASS_ID, FALSE);
	    return (0);
	  when dual_no_rows then
	    fnd_message.set_name ('FND', 'No Rows in Dual');
	    return (0);
	  when dual_too_many_rows then
	    fnd_message.set_name ('FND', 'Too many rows in Dual');
	    return (0);
	  when already_msg then
	    return (0);
          when pp_plsql_exception then
            fnd_message.set_name ('FND', 'CONC-assign pp action failed');
            return (0);
	  when conc_deferred_insert_error then
	    fnd_message.set_name ('FND', 'Conc-def-arg insert failed');
	    fnd_message.set_token ('APPLICATION', application, FALSE);
	    fnd_message.set_token ('PROGRAM', program, FALSE);
		return (0);
          when mult_pending_request_error then
            fnd_message.set_name ('FND', 'CONC-SINGLE PENDING REQUEST');
	    fnd_message.set_token ('PROGRAM', program, FALSE);
		return (0);
	  when others then
	    fnd_message.set_name ('FND', 'SQL-Generic error');
	    fnd_message.set_token ('ERRNO', sqlcode, FALSE);
	    fnd_message.set_token ('REASON', sqlerrm, FALSE);
	    fnd_message.set_token (
				'ROUTINE', 'SUBMIT: others', FALSE);
	    return (0);

  end submit;




  function submit_mls_request (
			  application IN varchar2 default NULL,
			  program     IN varchar2 default NULL,
			  description IN varchar2 default NULL,
			  start_time  IN varchar2 default NULL,
			  sub_request IN boolean  default FALSE,
			  p_argument1   IN varchar2 default CHR(0),
			  p_argument2   IN varchar2 default CHR(0),
  			  p_argument3   IN varchar2 default CHR(0),
			  p_argument4   IN varchar2 default CHR(0),
			  p_argument5   IN varchar2 default CHR(0),
			  p_argument6   IN varchar2 default CHR(0),
			  p_argument7   IN varchar2 default CHR(0),
			  p_argument8   IN varchar2 default CHR(0),
			  p_argument9   IN varchar2 default CHR(0),
			  p_argument10  IN varchar2 default CHR(0),
			  p_argument11  IN varchar2 default CHR(0),
			  p_argument12  IN varchar2 default CHR(0),
  			  p_argument13  IN varchar2 default CHR(0),
			  p_argument14  IN varchar2 default CHR(0),
			  p_argument15  IN varchar2 default CHR(0),
			  p_argument16  IN varchar2 default CHR(0),
			  p_argument17  IN varchar2 default CHR(0),
			  p_argument18  IN varchar2 default CHR(0),
			  p_argument19  IN varchar2 default CHR(0),
			  p_argument20  IN varchar2 default CHR(0),
			  p_argument21  IN varchar2 default CHR(0),
			  p_argument22  IN varchar2 default CHR(0),
  			  p_argument23  IN varchar2 default CHR(0),
			  p_argument24  IN varchar2 default CHR(0),
			  p_argument25  IN varchar2 default CHR(0),
			  p_argument26  IN varchar2 default CHR(0),
			  p_argument27  IN varchar2 default CHR(0),
			  p_argument28  IN varchar2 default CHR(0),
			  p_argument29  IN varchar2 default CHR(0),
			  p_argument30  IN varchar2 default CHR(0),
			  p_argument31  IN varchar2 default CHR(0),
			  p_argument32  IN varchar2 default CHR(0),
  			  p_argument33  IN varchar2 default CHR(0),
			  p_argument34  IN varchar2 default CHR(0),
			  p_argument35  IN varchar2 default CHR(0),
			  p_argument36  IN varchar2 default CHR(0),
			  p_argument37  IN varchar2 default CHR(0),
  			  p_argument38  IN varchar2 default CHR(0),
			  p_argument39  IN varchar2 default CHR(0),
			  p_argument40  IN varchar2 default CHR(0),
			  p_argument41  IN varchar2 default CHR(0),
  			  p_argument42  IN varchar2 default CHR(0),
			  p_argument43  IN varchar2 default CHR(0),
			  p_argument44  IN varchar2 default CHR(0),
			  p_argument45  IN varchar2 default CHR(0),
			  p_argument46  IN varchar2 default CHR(0),
			  p_argument47  IN varchar2 default CHR(0),
  			  p_argument48  IN varchar2 default CHR(0),
			  p_argument49  IN varchar2 default CHR(0),
			  p_argument50  IN varchar2 default CHR(0),
			  p_argument51  IN varchar2 default CHR(0),
  			  p_argument52  IN varchar2 default CHR(0),
			  p_argument53  IN varchar2 default CHR(0),
			  p_argument54  IN varchar2 default CHR(0),
			  p_argument55  IN varchar2 default CHR(0),
			  p_argument56  IN varchar2 default CHR(0),
			  p_argument57  IN varchar2 default CHR(0),
			  p_argument58  IN varchar2 default CHR(0),
			  p_argument59  IN varchar2 default CHR(0),
			  p_argument60  IN varchar2 default CHR(0),
			  p_argument61  IN varchar2 default CHR(0),
			  p_argument62  IN varchar2 default CHR(0),
  			  p_argument63  IN varchar2 default CHR(0),
			  p_argument64  IN varchar2 default CHR(0),
			  p_argument65  IN varchar2 default CHR(0),
			  p_argument66  IN varchar2 default CHR(0),
			  p_argument67  IN varchar2 default CHR(0),
			  p_argument68  IN varchar2 default CHR(0),
			  p_argument69  IN varchar2 default CHR(0),
			  p_argument70  IN varchar2 default CHR(0),
			  p_argument71  IN varchar2 default CHR(0),
			  p_argument72  IN varchar2 default CHR(0),
  			  p_argument73  IN varchar2 default CHR(0),
			  p_argument74  IN varchar2 default CHR(0),
			  p_argument75  IN varchar2 default CHR(0),
			  p_argument76  IN varchar2 default CHR(0),
			  p_argument77  IN varchar2 default CHR(0),
			  p_argument78  IN varchar2 default CHR(0),
			  p_argument79  IN varchar2 default CHR(0),
			  p_argument80  IN varchar2 default CHR(0),
			  p_argument81  IN varchar2 default CHR(0),
			  p_argument82  IN varchar2 default CHR(0),
  			  p_argument83  IN varchar2 default CHR(0),
			  p_argument84  IN varchar2 default CHR(0),
			  p_argument85  IN varchar2 default CHR(0),
			  p_argument86  IN varchar2 default CHR(0),
			  p_argument87  IN varchar2 default CHR(0),
			  p_argument88  IN varchar2 default CHR(0),
			  p_argument89  IN varchar2 default CHR(0),
			  p_argument90  IN varchar2 default CHR(0),
			  p_argument91  IN varchar2 default CHR(0),
			  p_argument92  IN varchar2 default CHR(0),
  			  p_argument93  IN varchar2 default CHR(0),
			  p_argument94  IN varchar2 default CHR(0),
			  p_argument95  IN varchar2 default CHR(0),
			  p_argument96  IN varchar2 default CHR(0),
			  p_argument97  IN varchar2 default CHR(0),
			  p_argument98  IN varchar2 default CHR(0),
			  p_argument99  IN varchar2 default CHR(0),
			  p_argument100 IN varchar2 default CHR(0),
			  func_exists IN varchar2 default 'N')
			  return number is

     user_prog_name            varchar2(240);
     conc_prog_id              number;
     conc_app_id               number;
     fcp_printer               varchar2(30);
     reqid                     number;
     i                         number;
     default_printer           varchar2(30);
     profile_buffer	       varchar2(80) := null;
     default_copies            number;
     curr_printer              varchar2(30);
     curr_copies               number;
     curr_lang                 varchar2(30);

     begin

	 -- Set request type to B before submitting the parent request
         P_REQUEST_TYPE := 'B';

	 select fcpt.user_concurrent_program_name, fcp.concurrent_program_id,
		fa.application_id, printer_name
	     into user_prog_name, conc_prog_id, conc_app_id, fcp_printer
             from fnd_concurrent_programs fcp, fnd_concurrent_programs_tl fcpt, fnd_application fa
             where fcp.concurrent_program_id=fcpt.concurrent_program_id
	     and fcp.application_id=fcpt.application_id
             and fa.application_id=fcp.application_id
	     and fcpt.language = userenv('LANG')
             and fcp.concurrent_program_name= upper(program)
	     and fa.application_short_name = upper(application);


         -- Submit the FNDMLSUB parent request
         reqid := submit(
		          'FND',
			  'FNDMLSUB',
		          user_prog_name,
			  start_time,
			  sub_request,
			  to_char(conc_app_id),
			  to_char(conc_prog_id),
			  func_exists, chr(0),
			  '','','','','','','','','','',
			  '','','','','','','','','','',
			  '','','','','','','','','','',
			  '','','','','','','','','','',
			  '','','','','','','','','','',
			  '','','','','','','','','','',
			  '','','','','','','','','','',
			  '','','','','','','','','','',
			  '','','','','','','','','','',
			  '','','','','',''
			);

	 -- Return if submission failed
	 if (reqid = 0) then
	    return 0;
	 end if;



        -- Insert request details into FND_RUN_REQUESTS
         insert into fnd_run_requests
	  (application_id, concurrent_program_id, parent_request_id,
	  request_set_program_id, set_application_id,  request_set_id,
	  printer, print_style, save_output_flag, number_of_copies,
	  nls_language, nls_territory, numeric_characters, ops_instance, description,
	  argument1, argument2, argument3, argument4, argument5,
	  argument6, argument7, argument8, argument9, argument10,
	  argument11, argument12, argument13, argument14, argument15,
	  argument16, argument17, argument18, argument19, argument20,
	  argument21, argument22, argument23, argument24, argument25,
	  argument26, argument27, argument28, argument29, argument30,
	  argument31, argument32, argument33, argument34, argument35,
	  argument36, argument37, argument38, argument39, argument40,
	  argument41, argument42, argument43, argument44, argument45,
	  argument46, argument47, argument48, argument49, argument50,
	  argument51, argument52, argument53, argument54, argument55,
	  argument56, argument57, argument58, argument59, argument60,
	  argument61, argument62, argument63, argument64, argument65,
	  argument66, argument67, argument68, argument69, argument70,
	  argument71, argument72, argument73, argument74, argument75,
	  argument76, argument77, argument78, argument79, argument80,
	  argument81, argument82, argument83, argument84, argument85,
	  argument86, argument87, argument88, argument89, argument90,
	  argument91, argument92, argument93, argument94, argument95,
	  argument96, argument97, argument98, argument99, argument100, ORG_ID)
	values
	 (conc_app_id, conc_prog_id, reqid,
	  0, 0, 0,
	  null, P_PRINT_STYLE, P_SAVE_OUTPUT, null,
	  P_LANGUAGE, P_TERRITORY, P_NUMERIC_CHARACTERS, -1, submit_mls_request.description,
	  p_argument1, p_argument2, p_argument3, p_argument4, p_argument5,
	  p_argument6, p_argument7, p_argument8, p_argument9, p_argument10,
	  p_argument11, p_argument12, p_argument13, p_argument14, p_argument15,
	  p_argument16, p_argument17, p_argument18, p_argument19, p_argument20,
	  p_argument21, p_argument22, p_argument23, p_argument24, p_argument25,
	  p_argument26, p_argument27, p_argument28, p_argument29, p_argument30,
	  p_argument31, p_argument32, p_argument33, p_argument34, p_argument35,
	  p_argument36, p_argument37, p_argument38, p_argument39, p_argument40,
	  p_argument41, p_argument42, p_argument43, p_argument44, p_argument45,
	  p_argument46, p_argument47, p_argument48, p_argument49, p_argument50,
	  p_argument51, p_argument52, p_argument53, p_argument54, p_argument55,
	  p_argument56, p_argument57, p_argument58, p_argument59, p_argument60,
	  p_argument61, p_argument62, p_argument63, p_argument64, p_argument65,
	  p_argument66, p_argument67, p_argument68, p_argument69, p_argument70,
	  p_argument71, p_argument72, p_argument73, p_argument74, p_argument75,
	  p_argument76, p_argument77, p_argument78, p_argument79, p_argument80,
	  p_argument81, p_argument82, p_argument83, p_argument84, p_argument85,
	  p_argument86, p_argument87, p_argument88, p_argument89, p_argument90,
	  p_argument91, p_argument92, p_argument93, p_argument94, p_argument95,
	  p_argument96, p_argument97, p_argument98, p_argument99, p_argument100, P_ORG_ID);


    -- Insert Languages
     if ( func_exists = 'N' ) then
      for i in 1..P_NLS_PARAMETERS_COUNT loop

        insert into fnd_run_req_languages
        ( parent_request_id,
         nls_language,
         nls_territory,
         numeric_characters,
        created_by,
         creation_date,
         last_updated_by,
         last_update_date,
         last_update_login)
        values
        ( reqid,
          P_NLS_PARAMETERS(i).nls_lang,
          P_NLS_PARAMETERS(i).nls_territory,
          P_NLS_PARAMETERS(i).nls_num_char,
          FND_GLOBAL.USER_ID, sysdate, FND_GLOBAL.USER_ID,
          sysdate, FND_GLOBAL.CONC_LOGIN_ID);

      end loop;
    end if;

    P_NLS_PARAMETERS_COUNT :=0;

   -- Insert Notifications
   if (P_NOTIFICATION_COUNT > 0) then
      for i in 1..P_NOTIFICATION_COUNT loop

        insert into fnd_run_req_pp_actions
                	(parent_request_id,
                         request_set_id,
                         set_application_id,
                 	 request_set_program_id,
                 	 action_type,
                 	 status_s_flag,
                 	 status_w_flag,
                 	 status_f_flag,
                 	 program_application_id,
                 	 program_id,
                 	 arguments,
			 number_of_copies,
                 	 sequence,
                         orig_system,
                         orig_system_id,
                         nls_language,
                         ops_instance)
           	values
                	(reqid,
                 	0, 0, 0,
                 	2,
			P_NOTIFICATIONS(i).on_normal,
			P_NOTIFICATIONS(i).on_warning,
			P_NOTIFICATIONS(i).on_error,
			null, null,
                 	P_NOTIFICATIONS(i).name, null, i,
                        P_NOTIFICATIONS(i).orig_system,
			P_NOTIFICATIONS(i).orig_system_id,
			P_NOTIFICATIONS(i).lang, -1);
      end loop;
   end if;

   P_NOTIFICATION_COUNT :=0;

   -- Insert layout
   if (P_LAYOUT_COUNT > 0) then
	  for i in 1..P_LAYOUT_COUNT loop
               insert into fnd_run_req_pp_actions
                      (parent_request_id,
                        request_set_id,
                        set_application_id,
                        request_set_program_id,
                        action_type,
                        status_s_flag,
                        status_w_flag,
                        status_f_flag,
                        program_application_id,
                        program_id,
                        sequence,
                        argument1,
                        argument2,
                        argument3,
                        argument4,
                        argument5,
                        nls_language,
	                ops_instance)
             values
                       (reqid,
                        0, 0, 0,
                        6, 'Y', 'N', 'N', conc_app_id, conc_prog_id, i,
			P_LAYOUTS(i).template_appl_name,
			P_LAYOUTS(i).template_code,
			P_LAYOUTS(i).template_language,
			P_LAYOUTS(i).template_territory,
			P_LAYOUTS(i).output_format,
			P_LAYOUTS(i).nls_language,
                        -1);
	end loop;
    end if;

    P_LAYOUT_COUNT := 0;


   -- Insert Printers
    if (FCP_PRINTER is null) then
	FND_PROFILE.GET ('PRINTER', default_printer);
    else
        default_printer := fcp_printer;
    end if;

    FND_PROFILE.GET ('CONC_COPIES', profile_buffer);
    if (profile_buffer is not null) then
      default_copies := To_Number (profile_buffer);
      if (default_copies < 0) then
        default_copies := 0;
      end if;
    else
      default_copies := 0;
    end if;

    if ((P_PRINTER_COUNT = 0) and (default_copies >= 0)) then
      P_PRINTERS(1).printer := default_printer;
      P_PRINTERS(1).copies := default_copies;
      P_PRINTERS(1).lang := null;
      P_PRINTER_COUNT := 1;
    end if;

    for i in 1..P_PRINTER_COUNT loop

        curr_printer := P_PRINTERS(i).printer;
        curr_copies  := P_PRINTERS(i).copies;
        curr_lang := P_PRINTERS(i).lang;

        if (curr_copies is null) then
          curr_copies := default_copies;
        end if;

        if (curr_printer is null) then
          curr_printer := default_printer;
        end if;

        insert into fnd_run_req_pp_actions
                	(parent_request_id,
                         request_set_id,
                         set_application_id,
                 	 request_set_program_id,
                 	 action_type,
                 	 status_s_flag,
                 	 status_w_flag,
                 	 status_f_flag,
                 	 program_application_id,
                 	 program_id,
                 	 arguments,
                 	 number_of_copies,
                 	 sequence,
			 nls_language,
			 ops_instance)
           	values
                	(reqid,
                 	0, 0, 0,
                 	1, 'Y', 'N', 'N', null, null,
                 	curr_printer, curr_copies, i, curr_lang, -1);
    end loop;


    -- Insert delivery options
   if (P_DELIV_OPTS_COUNT > 0) then
	  for i in 1..P_DELIV_OPTS_COUNT loop
               insert into fnd_run_req_pp_actions
                      (parent_request_id,
                        request_set_id,set_application_id,request_set_program_id,
                        action_type,status_s_flag,status_w_flag,status_f_flag,
                        program_application_id,program_id,sequence,
                        argument1,argument2,
		        argument3,argument4,
                        argument5,argument6,
                        argument7,argument8,
                        argument9,argument10,
                        nls_language,ops_instance)
             values
                       (reqid,
                        0, 0, 0,
                        7, 'Y', 'Y', 'N',
			conc_app_id, conc_prog_id, i,
			P_DELIVERY_OPTIONS(i).argument1,P_DELIVERY_OPTIONS(i).argument2,
			P_DELIVERY_OPTIONS(i).argument3,P_DELIVERY_OPTIONS(i).argument4,
			P_DELIVERY_OPTIONS(i).argument5,P_DELIVERY_OPTIONS(i).argument6,
			P_DELIVERY_OPTIONS(i).argument7,P_DELIVERY_OPTIONS(i).argument8,
			P_DELIVERY_OPTIONS(i).argument9,P_DELIVERY_OPTIONS(i).argument10,
			P_DELIVERY_OPTIONS(i).lang, -1);
	end loop;
    end if;

    P_DELIV_OPTS_COUNT := 0;


   return reqid;

   exception
      when others then
          fnd_message.set_name ('FND', 'SQL-Generic error');
          fnd_message.set_token ('ERRNO', sqlcode, FALSE);
          fnd_message.set_token ('REASON', sqlerrm, FALSE);
          fnd_message.set_token ('ROUTINE', 'FND_REQUEST.SUBMIT_MLS_REQUEST', FALSE);
          return (0);


  end;

  -- PUBLIC FUNCTIONS
  --
  -- --

  --
  -- Name
  --   set_mode
  -- Purpose
  --   Called before submitting request to set database trigger mode
  --
  -- Arguments
  --   db_trigger	- Set to TRUE for database trigger mode
  --
  function set_mode (db_trigger  IN boolean) return boolean is
  begin
    P_DB_TRIGGER_MODE := db_trigger;
    return TRUE;
  end;


  -- Name
  --   set_options
  -- Purpose
  --   Called before submitting request to set request attributes
  --
  -- Arguments
  --   implicit		- nature of the request to be submitted
  --			- NO/YES/ERROR/WARNING
  --   protected	- Is the request protected against updates
  --			- YES/NO  default is NO
  --   language		- NLS language
  --   territory	- Language territory
  --   datagroup
  --   numeric_characters - NLS Numeric Characters
  --
  -- --
  function set_options (implicit  IN varchar2 default 'NO',
		        protected IN varchar2 default 'NO',
		        language  IN varchar2 default NULL,
		        territory IN varchar2 default NULL,
		        datagroup IN varchar2 default NULL,
                        numeric_characters IN varchar2 default NULL)
			return boolean is
  dummy_val   varchar2(30);
  dummy_count number := 0;
  nls_error   exception;
  begin
	if ((implicit is null) or
	    (upper (implicit)    = 'NO')) then
	  P_IMPLICIT := 'N';
	elsif (upper (implicit) = 'WARNING') then
	  P_IMPLICIT := 'W';
	elsif (upper (implicit) = 'YES') then
	  P_IMPLICIT := 'Y';
	elsif (upper (implicit) = 'ERROR') then
	  P_IMPLICIT := 'E';
	else
	  Fnd_Message.Set_Name ('FND', 'CONC-Bad implicit argument');
	  init_pvt_vars;
	  return (FALSE);
	end if;

	if ( language is not null ) then
	   begin
		select nls_language
	 	  into dummy_val
		  from fnd_languages
		 where nls_language = upper(language);
	   exception
		when no_data_found then
		   raise nls_error;
	   end;
	end if;

	if ( territory is not null ) then
	   begin
		select count(*)
		  into dummy_count
		  from fnd_territories
		 where nls_territory = upper(territory);
	   exception
		when no_data_found then
		   raise nls_error;
	   end;
	   if ( dummy_count < 1 ) then
		raise nls_error;
	   end if;
	end if;

        /* NLS Project */
	if ( numeric_characters is not null ) then
           begin
             select lookup_code
                  into dummy_val
                  from fnd_lookup_values_vl
                 where lookup_type = 'ICX_NUMERIC_CHARACTERS' and
                         lookup_code = numeric_characters;
           exception
                when no_data_found then
                   raise nls_error;
           end;
	end if;

	P_LANGUAGE := language;
	P_TERRITORY := territory;
        /* NLS Project */
        P_NUMERIC_CHARACTERS := numeric_characters;

	if (datagroup is not null) then
	  P_DATAGROUP := datagroup;
	end if;

	return (TRUE);

     exception
	when nls_error then
	    fnd_message.set_name ('FND', 'GLI-Not found');
	    return(FALSE);

  end set_options;


  --
  -- Name
  --   set_repeat_options
  -- Purpose
  --   Called before submitting request if the request to be submitted
  --   is a repeating request.
  --
  -- Arguments
  --   repeat_time	- Time of day at which it has to be repeated
  --   repeat_interval  - Frequency at which it has to be repeated
  --			- This will be used/applied only when repeat_time
  --			- is NULL ( non null repeat_interval overrides )
  --   repeat_unit	- Unit for repeat interval. Default is DAYS.
  --			- MONTHS/DAYS/HOURS/MINUTES
  --   repeat_type	- Apply repeat interval from START or END of request
  --			- default is START. START/END
  --   repeat_end_time  - Time at which the repetition should be stopped
  --   incrment_dates   - 'Y' if dates should be incremented each run,
  --                      otherwise 'N'
  --
  function set_repeat_options (repeat_time      IN varchar2 default NULL,
			       repeat_interval  IN number   default NULL,
			       repeat_unit      IN varchar2 default 'DAYS',
			       repeat_type      IN varchar2 default 'START',
			       repeat_end_time  IN varchar2 default NULL,
			       increment_dates  IN varchar2 default NULL)
			       return boolean is

  rpt_other      exception;
  rpt_time_intvl exception;	  -- Both resub time and interval are set
  rpt_type_error exception;	  -- Bad resub type
  rpt_time_error boolean := TRUE; -- Use this in exception handler to
				  -- determine where the error occurred:
				  -- in resub time or end date.
  base_len number;
  begin
	P_REPEAT_TIME          := NULL;
	P_REPEAT_INTERVAL      := NULL;
	P_REPEAT_INTERVAL_UNIT := NULL;
	P_REPEAT_INTERVAL_TYPE := NULL;
	P_REPEAT_END           := NULL;
	P_INCREMENT_DATES      := NULL;

	if ((repeat_time is not NULL) and
	    (repeat_interval is not NULL)) then
	  raise rpt_time_intvl;

	elsif (repeat_time is not NULL) then

	  Select To_Char (fnd_conc_date.string_to_date (
                              '01-01-0001' || repeat_time),
				    'HH24:MI:SS')
	    Into P_REPEAT_TIME
	    From Sys.Dual;

          if (increment_dates = 'Y') then
              P_INCREMENT_DATES := increment_dates;
          else
              P_INCREMENT_DATES := 'N';
          end if;

	elsif (repeat_interval is not NULL) then
	  P_REPEAT_INTERVAL := repeat_interval;

	  if (repeat_unit is null) then
	    P_REPEAT_INTERVAL_UNIT := 'DAYS';
	  else
	    Select Lookup_Code
	      Into P_REPEAT_INTERVAL_UNIT
	      From Fnd_Lookups
	     Where upper (Lookup_Code) = upper (repeat_unit)
	       And Lookup_Type = 'CP_RESUBMIT_INTERVAL_UNIT';
	  end if;

	  if (repeat_type is null) then
	    P_REPEAT_INTERVAL_TYPE := 'START';
	  elsif (upper (repeat_type) in ('START', 'END')) then
	    P_REPEAT_INTERVAL_TYPE := upper (repeat_type);
	  else
	    raise rpt_type_error;
	  end if;

          if (increment_dates = 'Y') then
              P_INCREMENT_DATES := increment_dates;
          else
              P_INCREMENT_DATES := 'N';
          end if;

	end if; -- ((repeat_time is not NULL) and (repeat_interval is..

	rpt_time_error := FALSE;

	if (repeat_end_time is not null) then
          P_REPEAT_END := fnd_conc_date.string_to_date(repeat_end_time);
          if (P_REPEAT_END is null) then
            raise rpt_other;
          end if;
        end if;

	return (TRUE);

	exception
	  when rpt_time_intvl then
	    fnd_message.set_name ('FND', 'CONC-Time and interval set');
	    init_pvt_vars;
	    return (FALSE);

	  when rpt_type_error then
	    fnd_message.set_name ('FND', 'CONC-Bad resubmit type');
	    init_pvt_vars;
	    return (FALSE);

	  when no_data_found then
	    fnd_message.set_name ('FND', 'CONC-Bad resubmit unit');
	    init_pvt_vars;
	    return (FALSE);

	  when others then
	    if (rpt_time_error) then
	      fnd_message.set_name ('FND', 'CONC-Invalid resubmit time');
	    else
	      fnd_message.set_name ('FND', 'CONC-Invalid Resub End Date');
	    end if;
	    init_pvt_vars;
	    return (FALSE);
  end set_repeat_options;



  --
  -- Name
  --   set_rel_class_options
  -- Purpose
  --   Called before submitting request if the request to be submitted
  --   is using the new scheduler functionality.
  --
  -- Arguments
  --   application	- Application Name of Release Class
  --   class_name	- (Developer) Name of Release Class
  --   cancel_or_hold	- Cancel or hold flag
  --   stale_date	- Cancel request on or after this time if not run
  --
  function set_rel_class_options (application 	 IN varchar2 default NULL,
			          class_name 	 IN varchar2 default NULL,
			          cancel_or_hold IN varchar2 default 'H',
			          stale_date 	 IN varchar2 default NULL)
			          return boolean is

  stale_date_error exception;  -- Stale date couldn't be interpreted
  appl_class_error exception;  -- Couldn't find App or class

  begin
        P_REL_CLASS_APP_ID      := null;
        P_REL_CLASS_ID          := null;
        P_REL_STALE_DATE        := null;
        P_REL_CANCEL_OR_HOLD    := cancel_or_hold;


	if (stale_date is not NULL) then
          P_REL_STALE_DATE := fnd_conc_date.string_to_date(stale_date);
          if (P_REL_STALE_DATE is null) then
            raise stale_date_error;
          end if;
        end if;

        if (class_name is not null) then
         begin
          Select A.Application_ID, C.Release_Class_Id
            Into P_REL_CLASS_APP_ID, P_REL_CLASS_ID
            From Fnd_Conc_Release_Classes C, Fnd_Application A
           Where Upper(Release_class_Name)           = upper(class_name)
                 And C.Application_ID                = A.Application_ID
                 And A.Application_Short_Name = upper(application);

          exception
            when no_data_found then
              raise appl_class_error;
            when others then
              raise;
         end;
        end if;

	P_USES_REL_CLASS := 1;

	return (TRUE);

	exception
	  when stale_date_error then
	    fnd_message.set_name ('FND', 'CONC-Bad Stale Date');
	    init_pvt_vars;
	    return (FALSE);

	  when appl_class_error then
	    fnd_message.set_name ('FND', 'CONC-Bad Release Class');
	    init_pvt_vars;
	    return (FALSE);

	  when others then
	    init_pvt_vars;
	    raise;
	    return (FALSE);
  end set_rel_class_options;

  -- Name
  --   set_target_options
  -- Purpose
  --   Called before submitting request to set target node and or connect
  --   string (instance) for the request.  Currently only primary target
  --   node and connect string are honored and the connect string must be
  --   the name of a RAC instance.
  --
  -- Arguments
  --   node_name1       - primary target node
  --   instance1        - primary target instance (connect string)
  --   node_name2       - secondary target node
  --   instance2        - secondary target instance (connect string)
  --
  -- --
  function set_target_options (node_name1  IN varchar2 default NULL,
		        instance1 IN varchar2 default NULL,
		        node_name2    IN varchar2 default NULL,
		        instance2 IN varchar2 default NULL)
			return boolean is

  dummy_val   varchar2(80);

  begin

	if ( node_name1 is not null ) then
	   begin
		select node_name
	 	  into dummy_val
		  from fnd_nodes
		 where upper(node_name) = upper(node_name1);
	   exception
		when no_data_found then
	           fnd_message.set_name ('FND', 'CONC-Node not found');
	    	   fnd_message.set_token ('NODE_NAME', node_name1, FALSE);
		   raise;
	   end;
	end if;

	if ( instance1 is not null ) then
	   begin
		select instance
	 	  into dummy_val
		  from v$thread
		 where upper(instance) = upper(instance1);
	   exception
		when no_data_found then
	           fnd_message.set_name ('FND', 'CONC-Instance not found');
	    	   fnd_message.set_token ('INSTANCE_NAME', instance1, FALSE);
		   raise;
	   end;
	end if;

	P_NODE_NAME1 := node_name1;
	P_CONNSTR1 := instance1;

	return (TRUE);

     exception
	when others then
	    return(FALSE);

  end set_target_options;


  --
  -- Name
  --   set_print_options
  -- Purpose
  --   Called before submitting request if the printing of output has
  --   to be controlled with specific printer/style/copies etc.,
  --
  -- Arguments
  --   printer		- Printer name where the request o/p should be sent
  --   style		- Print style that needs to be used for printing
  --   copies		- Number of copies to print
  --   save_output	- Should the output file be saved after printing
  --   			- Default is TRUE.  TRUE/FALSE
  --   print_together   - Applies only for sub requests. If 'Y', output
  --			- will not be printed until all the sub requests
  --			- complete. Default is N. Y/N
  --   validate_printer - Once submit function is called
  --                    - with a specific program, if the printer specified
  --                    - here conflicts with a printer setting at the
  --                    - program level, one of three options is available:
  --                    - FAIL - raise an error and fail to submit
  --                    - SKIP - skip this print pp action, but submit anyway
  --                    - RESOLVE - switch to the valid printer, if printer
  --                    - and style are compatible
  --                    - Default is RESOLVE
  function set_print_options (printer	     IN varchar2 default NULL,
			      style	     IN varchar2 default NULL,
			      copies	     IN number	 default NULL,
			      save_output    IN boolean  default TRUE,
                              print_together IN varchar2 default 'N',
                              validate_printer IN varchar2 default 'RESOLVE')
			      return  boolean is

	printer_typ		varchar2 (30) := null;
	dummy_fld		varchar (2);

        validate_printer_error  exception;
	print_together_error	exception;
	printer_error		exception;
	style_error		exception;
	printer_style_error	exception;
        empty_array             printer_tab_type;
        prec  printer_record_type;

  begin
        -- Clear any old printer options
        -- Just in case this was called twice.
        if P_PRINTER_COUNT > 0 then
          P_PRINTERS := empty_array;
          P_PRINTER_COUNT := 0;
          P_VALIDATE_PRINTER := 'RESOLVE';
        end if;

        -- 5645007- set P_VALIDATE_PRINTER to determine
        -- behavior during submit if the printer specified here
        -- conflicts with a printer setting at the program level

        if (UPPER(validate_printer)
                                 in ('FAIL','SKIP','RESOLVE')) then
          P_VALIDATE_PRINTER := UPPER(validate_printer);
        else
          raise validate_printer_error;
        end if;


	if (upper (print_together) not in ('Y', 'N')) then
	  raise print_together_error;
	end if;

	if (upper (print_together) = 'Y') then
	  P_PRINT_TOGETHER   := 'Y';
	elsif (upper (print_together) = 'N') then
	  P_PRINT_TOGETHER   := 'N';
	else
	  P_PRINT_TOGETHER   := NULL;
	end if;

	if (save_output is null) then
	  P_SAVE_OUTPUT      := NULL;
	elsif (save_output) then
	  P_SAVE_OUTPUT      := 'Y';
        else
	  P_SAVE_OUTPUT      := 'N';
	end if;

	if (printer is not null) then -- Verify printer
	  begin
	    Select printer_type
	      Into printer_typ
	      From fnd_printer
	     Where printer_name = printer;

	    exception
	      when no_data_found then
		raise printer_error;

	      when others then
		raise;
	  end;
	end if; -- Verify printer


	if (style is not null) then -- Verify style
	  begin
	    Select Printer_Style_Name
	      Into P_PRINT_STYLE
	      From Fnd_Printer_styles
	     Where Printer_Style_Name = style;

	    exception
	      when no_data_found then
		raise style_error;

	      when others then
		raise;
	  end;
 	end if; -- Verify style

	if ((printer is not null) and
	    (style is not null)) then -- Verify printer/style comination
	  begin
	    Select 'X'
	      Into Dummy_fld
	      From Fnd_Printer_Information
	     Where Printer_Style = P_PRINT_STYLE
	       And Printer_Type  = printer_typ;

	    exception
	      when no_data_found then
		raise printer_style_error;

	      when others then
		raise;
	  end;
	end if; -- Verify printer/style comination

        -- Add printer/copies to the list.
        -- Note that we will attempt to process the defaults
        -- for nulls at submission time.  For now, store the
        -- nulls.

        if (copies is not null or printer is not null) then
          P_PRINTER_COUNT := 1;

          -- The following inderect assignment was required to get
          -- the procedure to compile.  The problem, for some reason
          -- doesn't seem to affect the other procedures in this package.
          prec.printer := printer;
          prec.copies := copies;
          P_PRINTERS(1) := prec;
        end if;


	return (TRUE);

	exception
          when validate_printer_error then
            fnd_message.set_name ('FND', 'CONC-Bad Validate Printer Parm');
            init_pvt_vars;
            return (FALSE);

	  when print_together_error then
	    fnd_message.set_name ('FND', 'CONC-Invalid opt:Print Group');
	    init_pvt_vars;
	    return (FALSE);

	  when printer_error then
	    fnd_message.set_name ('FND', 'PRINTERS-No system printer');
	    fnd_message.set_token ('PRINTER', printer, FALSE);
	    init_pvt_vars;
	    return (FALSE);

	  when style_error then
	    fnd_message.set_name ('FND', 'PRT-Invalid print style');
	    fnd_message.set_token ('STYLE', style, FALSE);
	    init_pvt_vars;
	    return (FALSE);

	  when printer_style_error then
	    fnd_message.set_name ('FND', 'CONC-Invalid printer style');
	    fnd_message.set_token ('STYLE', style, FALSE);
	    fnd_message.set_token ('PRINTER', printer, FALSE);
	    init_pvt_vars;
	    return (FALSE);

	  when others then
	    init_pvt_vars;
	    fnd_message.set_name ('FND', 'SQL-Generic error');
	    fnd_message.set_token ('ERRNO', sqlcode, FALSE);
	    fnd_message.set_token ('REASON', sqlerrm, FALSE);
	    fnd_message.set_token ('ROUTINE', 'SET_PRINT_OPTIONS', FALSE);
	    return (FALSE);
  end set_print_options;


  --
  -- Name
  --   use_current_notification
  -- Purpose
  --   Called before submitting a sub-request to reuse the same notification
  --   options as the current request
  --
  -- Arguments
  --   none
  function use_current_notification return boolean is
  	profile_buffer	varchar2(80);
	reqid		number;
        username	varchar2(255);
	result		boolean;
        empty_notify_array notification_tab_type;

	cursor c_users is
		select arguments
		from fnd_conc_pp_actions
		where concurrent_request_id = reqid
		and action_type = 2
		order by sequence;
  begin
  	-- get current request id
	reqid := FND_GLOBAL.conc_request_id;

  	if ((reqid <= 0) or (reqid is null))
	then
		init_pvt_vars;
		fnd_message.set_name('FND', 'CONC-REQUEST MISSING');
	    	fnd_message.set_token ('ROUTINE', 'USE_CURRENT_NOTIFICATION', FALSE);
		return (FALSE);
	end if;

	-- clear out notifications
	P_NOTIFICATIONS         := empty_notify_array;
        P_NOTIFICATION_COUNT    := 0;

	-- call add_notification for each user
	open c_users;
	loop
		fetch c_users into username;
		exit when c_users%NOTFOUND;

		result := add_notification(username);
	end loop;
        close c_users;

	return (TRUE);

  exception
	when others then
	    init_pvt_vars;
	    fnd_message.set_name ('FND', 'SQL-Generic error');
	    fnd_message.set_token ('ERRNO', sqlcode, FALSE);
	    fnd_message.set_token ('REASON', sqlerrm, FALSE);
	    fnd_message.set_token ('ROUTINE', 'USE_CURRENT_NOTIFICATION', FALSE);
	    return (FALSE);

  end use_current_notification;



  --
  -- Name
  --   add_printer
  -- Purpose
  --   Called after set print options to add a printer to the
  --   print list.
  --
  -- Arguments
  --   printer		- Printer name where the request o/p should be sent
  --   copies		- Number of copies to print
  function add_printer (printer in varchar2 default null,
                        copies  in number default null,
			lang    in varchar2 default null) return boolean is
	printer_typ		varchar2 (30) := null;
	dummy_fld		varchar (2);
	print_together_error	exception;
	printer_error		exception;
	style_error		exception;
	printer_style_error	exception;
  begin
	if (printer is not null) then -- Verify printer
	  begin
	    Select printer_type
	      Into printer_typ
	      From fnd_printer
	     Where printer_name = printer;

	    exception
	      when no_data_found then
		raise printer_error;

	      when others then
		raise;
	  end;
	end if; -- Verify printer


	if ((printer is not null) and
	    (P_PRINT_STYLE is not null)) then -- Verify printer/style combo
	  begin
	    Select 'X'
	      Into Dummy_fld
	      From Fnd_Printer_Information
	     Where Printer_Style = P_PRINT_STYLE
	       And Printer_Type  = printer_typ;

	    exception
	      when no_data_found then
		raise printer_style_error;

	      when others then
		raise;
	  end;
	end if; -- Verify printer/style comination

        -- Add printer/copies to the list.
        -- Note that we will attempt to process the defaults
        -- for nulls at submission time.  For now, store the
        -- nulls.
        P_PRINTER_COUNT := P_PRINTER_COUNT + 1;
        P_PRINTERS(P_PRINTER_COUNT).printer := printer;
        P_PRINTERS(P_PRINTER_COUNT).copies := copies;
        P_PRINTERS(P_PRINTER_COUNT).lang := lang;

	return (TRUE);

	exception
	  when print_together_error then
	    fnd_message.set_name ('FND', 'CONC-Invalid opt:Print Group');
	    init_pvt_vars;
	    return (FALSE);

	  when printer_error then
	    fnd_message.set_name ('FND', 'PRINTERS-No system printer');
	    fnd_message.set_token ('PRINTER', printer, FALSE);
	    init_pvt_vars;
	    return (FALSE);

	  when style_error then
	    fnd_message.set_name ('FND', 'PRT-Invalid print style');
	    fnd_message.set_token ('STYLE', P_PRINT_STYLE, FALSE);
	    init_pvt_vars;
	    return (FALSE);

	  when printer_style_error then
	    fnd_message.set_name ('FND', 'CONC-Invalid printer style');
	    fnd_message.set_token ('STYLE', P_PRINT_STYLE, FALSE);
	    fnd_message.set_token ('PRINTER', printer, FALSE);
	    init_pvt_vars;
	    return (FALSE);

	  when others then
	    init_pvt_vars;
	    fnd_message.set_name ('FND', 'SQL-Generic error');
	    fnd_message.set_token ('ERRNO', sqlcode, FALSE);
	    fnd_message.set_token ('REASON', sqlerrm, FALSE);
	    fnd_message.set_token ('ROUTINE', 'SET_PRINT_OPTIONS', FALSE);
	    return (FALSE);

  end;


  --
  -- Name
  --   add_notification
  -- Purpose
  --   Called before submission to add a user to the notify list.
  --
  -- Arguments
  --	User		- User name.
  function add_notification (user          in varchar2,
			     nls_language  in varchar2 default null) return boolean is
    n_index number;
    cursor c1( user_name varchar2) is
       select name, orig_system, orig_system_id
         from wf_roles
        where name = user_name;
  begin

   -- Same user may exists in different departments(tables).
   -- use cursor because we dont know the given user name will return one row
   -- multiple rows.
   -- we are considering only the first row that matched in wf_roles.

    n_index := P_NOTIFICATION_COUNT + 1;
    open c1( user );
    fetch c1 into P_NOTIFICATIONS(n_index).name,
			P_NOTIFICATIONS(n_index).orig_system,
			P_NOTIFICATIONS(n_index).orig_system_id;

    P_NOTIFICATIONS(n_index).on_normal := 'Y';
    P_NOTIFICATIONS(n_index).on_warning := 'Y';
    P_NOTIFICATIONS(n_index).on_error := 'Y';

    P_NOTIFICATIONS(n_index).lang := nls_language;

    if( c1%notfound ) then
      fnd_message.set_name('FND', 'CONC-INVALID NOTIFY USER');
      close c1;
      return FALSE;
    else
      P_NOTIFICATION_COUNT := P_NOTIFICATION_COUNT + 1;
      close c1;
      return TRUE;
    end if;

  end;

  --
  -- Name
  --   add_layout
  -- Purpose
  --   Called before submission to add layout options for request output.
  --
  -- Arguments
  --    Template_APPL_Name            - Template Application Short name.
  --    Template_code                 - Template code
  --    Template_Language             - Template File language (iso value)
  --    Template_Territory            - Template File Territory (iso value)
  --    Output Format                 - Output Format
  --
  function add_layout (template_appl_name in varchar2,
			template_code     in varchar2,
			template_language in varchar2,
 			template_territory in varchar2,
			output_format     in varchar2,
		        nls_language      in varchar2 default null) return boolean is
  begin

      -- It is callers responsibility to provide valid values.
      P_LAYOUT_COUNT := P_LAYOUT_COUNT + 1;

      P_LAYOUTS(P_LAYOUT_COUNT).template_appl_name := template_appl_name;
      P_LAYOUTS(P_LAYOUT_COUNT).template_code := template_code;
      P_LAYOUTS(P_LAYOUT_COUNT).template_language := template_language;
      P_LAYOUTS(P_LAYOUT_COUNT).template_territory := template_territory;
      P_LAYOUTS(P_LAYOUT_COUNT).output_format := output_format;
      P_LAYOUTS(P_LAYOUT_COUNT).nls_language := nls_language;

      return (TRUE);
  end;

  --
  -- Name
  --   submit_request
  -- Purpose
  --   Submits concurrent request to be processed by a concurrent manager
  --
  -- Arguments
  --   application	- Short name of application under which the program
  --			- is registered
  --   program		- concurrent program name for which the request has
  --			- to be submitted
  --   description	- Optional. Will be displayed along with user
  --			- concurrent program name
  --   start_time	- Optional. Time at which the request has to start
  --			- running
  --   sub_request	- Optional. Set to TRUE if the request is submitted
  --   			- from another running request and has to be treated
  --			- as a sub request. Default is FALSE
  --   argument1..100	- Optional. Arguments for the concurrent request
  --
  function submit_request (
			  application IN varchar2 default NULL,
			  program     IN varchar2 default NULL,
			  description IN varchar2 default NULL,
			  start_time  IN varchar2 default NULL,
			  sub_request IN boolean  default FALSE,
			  argument1   IN varchar2 default CHR(0),
			  argument2   IN varchar2 default CHR(0),
  			  argument3   IN varchar2 default CHR(0),
			  argument4   IN varchar2 default CHR(0),
			  argument5   IN varchar2 default CHR(0),
			  argument6   IN varchar2 default CHR(0),
			  argument7   IN varchar2 default CHR(0),
			  argument8   IN varchar2 default CHR(0),
			  argument9   IN varchar2 default CHR(0),
			  argument10  IN varchar2 default CHR(0),
			  argument11  IN varchar2 default CHR(0),
			  argument12  IN varchar2 default CHR(0),
  			  argument13  IN varchar2 default CHR(0),
			  argument14  IN varchar2 default CHR(0),
			  argument15  IN varchar2 default CHR(0),
			  argument16  IN varchar2 default CHR(0),
			  argument17  IN varchar2 default CHR(0),
			  argument18  IN varchar2 default CHR(0),
			  argument19  IN varchar2 default CHR(0),
			  argument20  IN varchar2 default CHR(0),
			  argument21  IN varchar2 default CHR(0),
			  argument22  IN varchar2 default CHR(0),
  			  argument23  IN varchar2 default CHR(0),
			  argument24  IN varchar2 default CHR(0),
			  argument25  IN varchar2 default CHR(0),
			  argument26  IN varchar2 default CHR(0),
			  argument27  IN varchar2 default CHR(0),
			  argument28  IN varchar2 default CHR(0),
			  argument29  IN varchar2 default CHR(0),
			  argument30  IN varchar2 default CHR(0),
			  argument31  IN varchar2 default CHR(0),
			  argument32  IN varchar2 default CHR(0),
  			  argument33  IN varchar2 default CHR(0),
			  argument34  IN varchar2 default CHR(0),
			  argument35  IN varchar2 default CHR(0),
			  argument36  IN varchar2 default CHR(0),
			  argument37  IN varchar2 default CHR(0),
  			  argument38  IN varchar2 default CHR(0),
			  argument39  IN varchar2 default CHR(0),
			  argument40  IN varchar2 default CHR(0),
			  argument41  IN varchar2 default CHR(0),
  			  argument42  IN varchar2 default CHR(0),
			  argument43  IN varchar2 default CHR(0),
			  argument44  IN varchar2 default CHR(0),
			  argument45  IN varchar2 default CHR(0),
			  argument46  IN varchar2 default CHR(0),
			  argument47  IN varchar2 default CHR(0),
  			  argument48  IN varchar2 default CHR(0),
			  argument49  IN varchar2 default CHR(0),
			  argument50  IN varchar2 default CHR(0),
			  argument51  IN varchar2 default CHR(0),
  			  argument52  IN varchar2 default CHR(0),
			  argument53  IN varchar2 default CHR(0),
			  argument54  IN varchar2 default CHR(0),
			  argument55  IN varchar2 default CHR(0),
			  argument56  IN varchar2 default CHR(0),
			  argument57  IN varchar2 default CHR(0),
			  argument58  IN varchar2 default CHR(0),
			  argument59  IN varchar2 default CHR(0),
			  argument60  IN varchar2 default CHR(0),
			  argument61  IN varchar2 default CHR(0),
			  argument62  IN varchar2 default CHR(0),
  			  argument63  IN varchar2 default CHR(0),
			  argument64  IN varchar2 default CHR(0),
			  argument65  IN varchar2 default CHR(0),
			  argument66  IN varchar2 default CHR(0),
			  argument67  IN varchar2 default CHR(0),
			  argument68  IN varchar2 default CHR(0),
			  argument69  IN varchar2 default CHR(0),
			  argument70  IN varchar2 default CHR(0),
			  argument71  IN varchar2 default CHR(0),
			  argument72  IN varchar2 default CHR(0),
  			  argument73  IN varchar2 default CHR(0),
			  argument74  IN varchar2 default CHR(0),
			  argument75  IN varchar2 default CHR(0),
			  argument76  IN varchar2 default CHR(0),
			  argument77  IN varchar2 default CHR(0),
			  argument78  IN varchar2 default CHR(0),
			  argument79  IN varchar2 default CHR(0),
			  argument80  IN varchar2 default CHR(0),
			  argument81  IN varchar2 default CHR(0),
			  argument82  IN varchar2 default CHR(0),
  			  argument83  IN varchar2 default CHR(0),
			  argument84  IN varchar2 default CHR(0),
			  argument85  IN varchar2 default CHR(0),
			  argument86  IN varchar2 default CHR(0),
			  argument87  IN varchar2 default CHR(0),
			  argument88  IN varchar2 default CHR(0),
			  argument89  IN varchar2 default CHR(0),
			  argument90  IN varchar2 default CHR(0),
			  argument91  IN varchar2 default CHR(0),
			  argument92  IN varchar2 default CHR(0),
  			  argument93  IN varchar2 default CHR(0),
			  argument94  IN varchar2 default CHR(0),
			  argument95  IN varchar2 default CHR(0),
			  argument96  IN varchar2 default CHR(0),
			  argument97  IN varchar2 default CHR(0),
			  argument98  IN varchar2 default CHR(0),
			  argument99  IN varchar2 default CHR(0),
			  argument100  IN varchar2 default CHR(0))
			  return number is

	reqid		number;
        func_exists     varchar2(1);
        srsflag         varchar2(1);

  begin
	-- If not in database trigger mode:
	-- Rollback to start_of_submission if submit() function fails to
	-- submit the request.
	if (not (P_DB_TRIGGER_MODE)) then
		savepoint start_of_submission;
	end if;



        -- Check to see if this is going to be an MLS request
       select decode(nvl(MLS_EXECUTABLE_ID, -1), -1, 'N', 'Y'),
	      srs_flag
	into func_exists, srsflag
        from fnd_concurrent_programs FCP, fnd_application FA
        where FCP.CONCURRENT_PROGRAM_NAME = UPPER(program)
	and FA.APPLICATION_SHORT_NAME = UPPER(application)
        and FCP.APPLICATION_ID = FA.APPLICATION_ID;

        -- If no MLS function and only 1 language then submit normally
        -- Also submit normally if an MLS function exists but srs_flag = N
        -- Also submit normally if P_REQUEST_TYPE = C (child MLS request)
	if (P_REQUEST_TYPE = 'C' or
            (func_exists = 'N' and P_NLS_PARAMETERS_COUNT <= 1) or
	    (func_exists = 'Y' and srsflag = 'N')) then
	  reqid := submit (
		 application, program, description, start_time, sub_request,
		 Argument1,  Argument2,  Argument3,  Argument4,  Argument5,
		 Argument6,  Argument7,  Argument8,  Argument9,  Argument10,
		 Argument11, Argument12, Argument13, Argument14, Argument15,
		 Argument16, Argument17, Argument18, Argument19, Argument20,
		 Argument21, Argument22, Argument23, Argument24, Argument25,
		 Argument26, Argument27, Argument28, Argument29, Argument30,
		 Argument31, Argument32, Argument33, Argument34, Argument35,
		 Argument36, Argument37, Argument38, Argument39, Argument40,
		 Argument41, Argument42, Argument43, Argument44, Argument45,
		 Argument46, Argument47, Argument48, Argument49, Argument50,
		 Argument51, Argument52, Argument53, Argument54, Argument55,
		 Argument56, Argument57, Argument58, Argument59, Argument60,
		 Argument61, Argument62, Argument63, Argument64, Argument65,
		 Argument66, Argument67, Argument68, Argument69, Argument70,
		 Argument71, Argument72, Argument73, Argument74, Argument75,
		 Argument76, Argument77, Argument78, Argument79, Argument80,
		 Argument81, Argument82, Argument83, Argument84, Argument85,
		 Argument86, Argument87, Argument88, Argument89, Argument90,
		 Argument91, Argument92, Argument93, Argument94, Argument95,
		 Argument96, Argument97, Argument98, Argument99, Argument100);

	else

	   -- Else submit an MLS parent program
           reqid := submit_mls_request(
		 application, program, description, start_time, sub_request,
		 Argument1,  Argument2,  Argument3,  Argument4,  Argument5,
		 Argument6,  Argument7,  Argument8,  Argument9,  Argument10,
		 Argument11, Argument12, Argument13, Argument14, Argument15,
		 Argument16, Argument17, Argument18, Argument19, Argument20,
		 Argument21, Argument22, Argument23, Argument24, Argument25,
		 Argument26, Argument27, Argument28, Argument29, Argument30,
		 Argument31, Argument32, Argument33, Argument34, Argument35,
		 Argument36, Argument37, Argument38, Argument39, Argument40,
		 Argument41, Argument42, Argument43, Argument44, Argument45,
		 Argument46, Argument47, Argument48, Argument49, Argument50,
		 Argument51, Argument52, Argument53, Argument54, Argument55,
		 Argument56, Argument57, Argument58, Argument59, Argument60,
		 Argument61, Argument62, Argument63, Argument64, Argument65,
		 Argument66, Argument67, Argument68, Argument69, Argument70,
		 Argument71, Argument72, Argument73, Argument74, Argument75,
		 Argument76, Argument77, Argument78, Argument79, Argument80,
		 Argument81, Argument82, Argument83, Argument84, Argument85,
		 Argument86, Argument87, Argument88, Argument89, Argument90,
		 Argument91, Argument92, Argument93, Argument94, Argument95,
		 Argument96, Argument97, Argument98, Argument99, Argument100,
		 func_exists );


	end if;

	if (not (P_DB_TRIGGER_MODE)) then
		if (reqid = 0) then
			rollback to start_of_submission;
		end if;
	end if;

	init_pvt_vars;

	return (reqid);


    exception
	when no_data_found then
	  fnd_message.set_name ('FND', 'CONC-Invalid Conc program');
	  fnd_message.set_token ('PROGRAM', program, FALSE);
	  return (0);
	when others then
	  fnd_message.set_name ('FND', 'SQL-Generic error');
	  fnd_message.set_token ('ERRNO', sqlcode, FALSE);
	  fnd_message.set_token ('REASON', sqlerrm, FALSE);
	  fnd_message.set_token ('ROUTINE', 'SUBMIT_REQUEST', FALSE);
	  return (0);

  end submit_request;

  --
  -- Name
  --   submit_svc_ctl_request
  -- Purpose
  --   Submits concurrent request to be processed by a concurrent manager
  --
  -- Arguments
  --   command          - concurrent program name for which the request has
  --                    - to be submitted: ACTIVATE, DEACTIVATE, RESTART,
  --                    - ABORT (ie. terminate), VERIFY, SUSPEND, or RESUME
  --   service          - Service instance or manager developer name.
  --   service_app      - manager or service instance's application short name

function submit_svc_ctl_request (
                          command     IN varchar2,
                          service     IN varchar2,
                          service_app IN varchar2)
                          return number is

 mgr_app_id  number;		-- Arg2
 mgr_id      number;		-- Arg1
 my_descr    varchar2(2000);	-- DESCRIPTION
 now	     date;		-- START_TIME
 reqid	     number;
 prog_id     number;


begin
     begin -- Is the program name correct?
         Select concurrent_program_id
                Into prog_id
                From Fnd_concurrent_programs
               Where concurrent_program_name = command
		and application_id = 0;

         exception
             when no_data_found then
                  fnd_message.set_name ('FND', 'CONC-Invalid Conc program');
                  fnd_message.set_token ('PROGRAM', command, FALSE);
                  return (0);
             when others then
                  fnd_message.set_name ('FND', 'SQL-Generic error');
                  fnd_message.set_token ('ERRNO', sqlcode, FALSE);
                  fnd_message.set_token ('REASON', sqlerrm, FALSE);
                  fnd_message.set_token (
                                'ROUTINE', 'submit_svc_ctl_request', FALSE);
                  return (0);
     end; -- Is the program name correct?

     begin -- Is the appl short name correct?
         Select Application_ID, sysdate
                Into mgr_app_id, now
                From Fnd_Application
               Where Application_Short_Name = upper (service_app);

         exception
             when no_data_found then
                  fnd_message.set_name ('FND', 'CONC-Invalid Appl Short Name');
                  fnd_message.set_token ('APPLNAME', service_app, FALSE);
                  return (0);
             when others then
                  fnd_message.set_name ('FND', 'SQL-Generic error');
                  fnd_message.set_token ('ERRNO', sqlcode, FALSE);
                  fnd_message.set_token ('REASON', sqlerrm, FALSE);
                  fnd_message.set_token (
                                'ROUTINE', 'submit_svc_ctl_request', FALSE);
                  return (0);
     end; -- Is the appl short name correct?

     begin -- Is the svc inst short name correct?
         Select Concurrent_queue_id
                Into mgr_id
                From Fnd_Concurrent_queues
               Where Application_id = mgr_app_id
		and Concurrent_queue_name = service;
         exception
             when no_data_found then
                  fnd_message.set_name ('FND', 'CONC-Invalid Queue Name');
                  fnd_message.set_token ('QUEUENAME', service, FALSE);
                  return (0);
             when others then
                  fnd_message.set_name ('FND', 'SQL-Generic error');
                  fnd_message.set_token ('ERRNO', sqlcode, FALSE);
                  fnd_message.set_token ('REASON', sqlerrm, FALSE);
                  fnd_message.set_token (
                                'ROUTINE', 'submit_svc_ctl_request', FALSE);
                  return (0);
     end; -- Is the svc inst short name correct?

     my_descr := fnd_concurrent.Build_Svc_Ctrl_Desc(
		mgr_id, mgr_app_id, null, command);

     if (not (P_DB_TRIGGER_MODE)) then
         savepoint start_of_qc_submission;
     end if;

     reqid := submit_request(
		'FND', command, my_descr, now, FALSE, mgr_id, mgr_app_id);

     if (reqid = 0) then
	return(0);
     end if;

     begin -- Update queue cntrl code
         update fnd_concurrent_queues
            set CONTROL_CODE = decode(prog_id, 0, 'A', 1, 'D', 2, 'V', 3, 'R',
			4, 'T', 5, 'D', 6, 'A', 7, 'O', 8, 'Q', null)
	  where concurrent_queue_id = mgr_id
	    and application_id = mgr_app_id;
     exception
             when others then
		  if (not (P_DB_TRIGGER_MODE)) then
         		rollback to start_of_qc_submission;
		  end if;
                  fnd_message.set_name ('FND', 'SQL-Generic error');
                  fnd_message.set_token ('ERRNO', sqlcode, FALSE);
                  fnd_message.set_token ('REASON', sqlerrm, FALSE);
                  fnd_message.set_token (
                       'ROUTINE', 'submit_svc_ctl_request(update)', FALSE);
                  return (0);
     end; -- update cntl code

     commit;
     return (reqid);
end submit_svc_ctl_request;

function submit_svc_ctl_by_app (
                          command     IN varchar2,
                          application IN varchar2,
			  svc_type    IN NUMBER default 2)
                          return number is

 mgr_app_id  number;		-- Arg2
 my_descr    varchar2(2000);	-- DESCRIPTION
 now	     date;		-- START_TIME
 reqid	     number;
 prog_id     number;


begin
     begin -- Is the program name correct?
         Select concurrent_program_id
                Into prog_id
                From Fnd_concurrent_programs
               Where concurrent_program_name = command
		and application_id = 0;

         exception
             when no_data_found then
                  fnd_message.set_name ('FND', 'CONC-Invalid Conc program');
                  fnd_message.set_token ('PROGRAM', command, FALSE);
                  return (0);
             when others then
                  fnd_message.set_name ('FND', 'SQL-Generic error');
                  fnd_message.set_token ('ERRNO', sqlcode, FALSE);
                  fnd_message.set_token ('REASON', sqlerrm, FALSE);
                  fnd_message.set_token (
                                'ROUTINE', 'submit_svc_ctl_by_app', FALSE);
                  return (0);
     end; -- Is the program name correct?

     begin -- Is the appl short name correct?
         Select Application_ID, sysdate
                Into mgr_app_id, now
                From Fnd_Application
               Where Application_Short_Name = upper (application);

         exception
             when no_data_found then
                  fnd_message.set_name ('FND', 'CONC-Invalid Appl Short Name');
                  fnd_message.set_token ('APPLNAME', application, FALSE);
                  return (0);
             when others then
                  fnd_message.set_name ('FND', 'SQL-Generic error');
                  fnd_message.set_token ('ERRNO', sqlcode, FALSE);
                  fnd_message.set_token ('REASON', sqlerrm, FALSE);
                  fnd_message.set_token (
                                'ROUTINE', 'submit_svc_ctl__by_app', FALSE);
                  return (0);
     end; -- Is the appl short name correct?

     my_descr := fnd_concurrent.Build_Svc_Ctrl_Desc(
		-1, mgr_app_id, svc_type, command);

     if (not (P_DB_TRIGGER_MODE)) then
         savepoint start_of_qc_submission;
     end if;

     reqid := submit_request(
		'FND', command, my_descr, now, FALSE, -1, mgr_app_id, svc_type);

     if (reqid = 0) then
	return(0);
     end if;

     begin -- Update queue cntrl code
         update fnd_concurrent_queues
            set CONTROL_CODE = decode(prog_id, 0, 'A', 1, 'D', 2, 'V', 3, 'R',
			4, 'T', 5, 'D', 6, 'A', 7, 'O', 8, 'Q', null)
	  where
           /* either CM or TM and request is for mgrs (or both) */
           (((manager_type = '1') or (manager_type = '3'))
		and ((svc_type = 0) or (svc_type = 2)))
       or  /* or service and request is for services (or both) */
           ((manager_type > 999) and ((svc_type = 1) or (svc_type = 2)))
	    and application_id = mgr_app_id;
     exception
             when others then
		  if (not (P_DB_TRIGGER_MODE)) then
         		rollback to start_of_qc_submission;
		  end if;
                  fnd_message.set_name ('FND', 'SQL-Generic error');
                  fnd_message.set_token ('ERRNO', sqlcode, FALSE);
                  fnd_message.set_token ('REASON', sqlerrm, FALSE);
                  fnd_message.set_token (
                       'ROUTINE', 'submit_svc_ctl_by_app(update)', FALSE);
                  return (0);
     end; -- update cntl code

     commit;
     return (reqid);
end submit_svc_ctl_by_app;

  --
  -- Name
  --   submit_svc_ctl_by_svc
  -- Purpose
  --   Submits Queue Control Request
  --   WARNING PERFORMS A COMMIT!!!
  --
  -- Arguments
  --   command          - concurrent program name for which the request has
  --                    - to be submitted: ACTIVATE, DEACTIVATE, RESTART,
  --                    - ABORT (ie. terminate), VERIFY, SUSPEND, or RESUME
  --   service          - Service instance or manager developer name.

function submit_svc_ctl_by_svc (
                          command     IN varchar2,
                          service     IN varchar2)
                          return number is

 svc_id      number;		-- Arg2
 my_descr    varchar2(2000);	-- DESCRIPTION
 now	     date;		-- START_TIME
 reqid	     number;
 prog_id     number;


begin
     begin -- Is the program name correct?
         Select concurrent_program_id
                Into prog_id
                From Fnd_concurrent_programs
               Where concurrent_program_name = command
		and application_id = 0;

         exception
             when no_data_found then
                  fnd_message.set_name ('FND', 'CONC-Invalid Conc program');
                  fnd_message.set_token ('PROGRAM', command, FALSE);
                  return (0);
             when others then
                  fnd_message.set_name ('FND', 'SQL-Generic error');
                  fnd_message.set_token ('ERRNO', sqlcode, FALSE);
                  fnd_message.set_token ('REASON', sqlerrm, FALSE);
                  fnd_message.set_token (
                                'ROUTINE', 'submit_svc_ctl_by_svc', FALSE);
                  return (0);
     end; -- Is the program name correct?

     begin -- Is the svc name correct?
         Select service_id
                Into svc_id
                From Fnd_Cp_services
               Where service_handle = service;
         exception
             when no_data_found then
                  fnd_message.set_name ('FND', 'CONC-SM INVALID SVC HANDLE');
                  fnd_message.set_token ('HANDLE', service, FALSE);
                  return (0);
             when others then
                  fnd_message.set_name ('FND', 'SQL-Generic error');
                  fnd_message.set_token ('ERRNO', sqlcode, FALSE);
                  fnd_message.set_token ('REASON', sqlerrm, FALSE);
                  fnd_message.set_token (
                                'ROUTINE', 'submit_svc_ctl_by_svc', FALSE);
                  return (0);
     end; -- Is the svc name correct?

     my_descr := fnd_concurrent.Build_Svc_Ctrl_Desc(-3, svc_id, null, command);

     if (not (P_DB_TRIGGER_MODE)) then
         savepoint start_of_qc_submission;
     end if;

     reqid := submit_request('FND', command, my_descr, now, FALSE, -3, svc_id);

     if (reqid = 0) then
	return(0);
     end if;

     begin -- Update queue cntrl code
         update fnd_concurrent_queues
            set CONTROL_CODE = decode(prog_id, 0, 'A', 1, 'D', 2, 'V', 3, 'R',
			4, 'T', 5, 'D', 6, 'A', 7, 'O', 8, 'Q', null)
	  where manager_type = to_char(svc_id);
     exception
             when others then
		  if (not (P_DB_TRIGGER_MODE)) then
         		rollback to start_of_qc_submission;
		  end if;
                  fnd_message.set_name ('FND', 'SQL-Generic error');
                  fnd_message.set_token ('ERRNO', sqlcode, FALSE);
                  fnd_message.set_token ('REASON', sqlerrm, FALSE);
                  fnd_message.set_token (
                       'ROUTINE', 'submit_svc_ctl_by_svc(update)', FALSE);
                  return (0);
     end; -- update cntl code

     commit;
     return (reqid);
end submit_svc_ctl_by_svc;

  --
  -- Name
  --   submit_svc_ctl_cpinfra
  -- Purpose
  --   Submits Queue Control Request
  --   WARNING PERFORMS A COMMIT!!!
  --
  -- Arguments
  --   command          - concurrent program name for which the request has
  --                    - to be submitted: ACTIVATE, DEACTIVATE, RESTART,
  --                    - ABORT (ie. terminate), VERIFY, SUSPEND, or RESUME

function submit_svc_ctl_cpinfra (
                          command     IN varchar2)
                          return number is

 my_descr    varchar2(2000);	-- DESCRIPTION
 now	     date;		-- START_TIME
 reqid	     number;
 prog_id     number;


begin
     begin -- Is the program name correct?
         Select concurrent_program_id
                Into prog_id
                From Fnd_concurrent_programs
               Where concurrent_program_name = command
		and application_id = 0;

         exception
             when no_data_found then
                  fnd_message.set_name ('FND', 'CONC-Invalid Conc program');
                  fnd_message.set_token ('PROGRAM', command, FALSE);
                  return (0);
             when others then
                  fnd_message.set_name ('FND', 'SQL-Generic error');
                  fnd_message.set_token ('ERRNO', sqlcode, FALSE);
                  fnd_message.set_token ('REASON', sqlerrm, FALSE);
                  fnd_message.set_token (
                                'ROUTINE', 'submit_svc_ctl_cpinfra', FALSE);
                  return (0);
     end; -- Is the program name correct?

     my_descr := fnd_concurrent.Build_Svc_Ctrl_Desc(-2, null, null, command);

     if (not (P_DB_TRIGGER_MODE)) then
         savepoint start_of_qc_submission;
     end if;

     reqid := submit_request('FND', command, my_descr, now, FALSE, -2);

     if (reqid = 0) then
	return(0);
     end if;

     begin -- Update queue cntrl code
         update fnd_concurrent_queues
            set CONTROL_CODE = decode(prog_id, 0, 'A', 1, 'D', 2, 'V', 3, 'R',
			4, 'T', 5, 'D', 6, 'A', 7, 'O', 8, 'Q', null)
	  where manager_type in ('1','3','4','5');
     exception
             when others then
		  if (not (P_DB_TRIGGER_MODE)) then
         		rollback to start_of_qc_submission;
		  end if;
                  fnd_message.set_name ('FND', 'SQL-Generic error');
                  fnd_message.set_token ('ERRNO', sqlcode, FALSE);
                  fnd_message.set_token ('REASON', sqlerrm, FALSE);
                  fnd_message.set_token (
                       'ROUTINE', 'submit_svc_ctl_cpinfra(update)', FALSE);
                  return (0);
     end; -- update cntl code

     commit;
     return (reqid);
end submit_svc_ctl_cpinfra;

  --
  -- Name
  --   submit_svc_ctl_cpall
  -- Purpose
  --   Submits Queue Control Request
  --   WARNING PERFORMS A COMMIT!!!
  --
  -- Arguments
  --   command          - concurrent program name for which the request has
  --                    - to be submitted: ACTIVATE, DEACTIVATE, RESTART,
  --                    - ABORT (ie. terminate), VERIFY, SUSPEND, or RESUME

function submit_svc_ctl_cpall (
                          command     IN varchar2)
                          return number is

 my_descr    varchar2(2000);	-- DESCRIPTION
 now	     date;		-- START_TIME
 reqid	     number;
 prog_id     number;


begin
     begin -- Is the program name correct?
         Select concurrent_program_id
                Into prog_id
                From Fnd_concurrent_programs
               Where concurrent_program_name = command
		and application_id = 0;

         exception
             when no_data_found then
                  fnd_message.set_name ('FND', 'CONC-Invalid Conc program');
                  fnd_message.set_token ('PROGRAM', command, FALSE);
                  return (0);
             when others then
                  fnd_message.set_name ('FND', 'SQL-Generic error');
                  fnd_message.set_token ('ERRNO', sqlcode, FALSE);
                  fnd_message.set_token ('REASON', sqlerrm, FALSE);
                  fnd_message.set_token (
                                'ROUTINE', 'submit_svc_ctl_cpall', FALSE);
                  return (0);
     end; -- Is the program name correct?

     my_descr := fnd_concurrent.Build_Svc_Ctrl_Desc(-4, null, null, command);

     if (not (P_DB_TRIGGER_MODE)) then
         savepoint start_of_qc_submission;
     end if;

     reqid := submit_request('FND', command, my_descr, now, FALSE, -4);

     if (reqid = 0) then
	return(0);
     end if;

     commit;
     return (reqid);
end submit_svc_ctl_cpall;

procedure internal(critical in varchar2 default null,
                   type     in varchar2 default null) is
begin
  P_CRITICAL_REQUEST := critical;
  P_REQUEST_TYPE := type;
end;

  --
  -- Name
  --   add_notification
  -- Purpose
  --   Called before submission to add a user to the notify list.
  --   Added this new method since changing the add_notification will need
  --   generation of all calling forms.
  --   In a major release we can merge this one with previous one with default
  --   values.
  --
  -- Arguments
  --    User            - User name.
  --    on_normal       - Notify when normal completion (Values Y/N)
  --    on_warning      - Notify when request completes with warning (Y/N)
  --    on_error        - Notify when request completed with error (Y/N)
  function add_notification (user       in varchar2,
                             on_normal  in varchar2,
                             on_warning in varchar2,
                             on_error   in varchar2)
            return boolean is
    n_index number;
    ret_val boolean;
  begin

    ret_val := add_notification(user);
    if ( ret_val ) then

       n_index := P_NOTIFICATION_COUNT;

       P_NOTIFICATIONS(n_index).on_normal := add_notification.on_normal;
       P_NOTIFICATIONS(n_index).on_warning := add_notification.on_warning;
       P_NOTIFICATIONS(n_index).on_error := add_notification.on_error;

       return TRUE;
    else
       return FALSE;
    end if;

  end;


  -- Name
  --   set_deferred
  -- Purpose
  --   Called before calling request submission page by other product teams
  --
  -- Arguments
  --
  --
  function set_deferred return boolean is
  begin
    P_DEFERRED_MODE := TRUE;
    return TRUE;
  end;


  -- Name
  --   set_def_request_id
  -- Purpose
  --   Called for setting global request id and the request id will be used while creating actual request
  --
  -- Arguments
  -- 	request_id - used while creating actual request in fnd_concurrent_request
  --
  function set_def_request_id (request_id IN number)
  	return boolean is
  begin
  	P_DEF_REQUEST_ID := request_id;
  	return TRUE;
  end;

  -- Name
  --   get_fnd_debug_rules_sequence
  -- Purpose
  --   Called to obtain the next sequence value for fnd_debug_rules table
  --
  -- Arguments
  --    none
  --
  function get_fnd_debug_rules_sequence return number is

  l_sequence number;
  dual_no_rows	   exception;
  dual_too_many_rows exception;

  begin

     begin
        select fnd_debug_rules_s.nextval
          into l_sequence
          from sys.dual;

        exception
          when no_data_found then
            raise dual_no_rows;
          when too_many_rows then
            raise dual_too_many_rows;
          when others then
            raise;
     end;

     return l_sequence;
  end;


  -- Name
  --   update_fnd_debug_rules_req_id
  -- Purpose
  --   Called to set the request id for the specific fnd_debug_rule_id
  --
  -- Arguments
  --    request_id - the actual request id that debug options is being set for.
  --    fnd_debug_rule_id - the specific row in fnd_debug_rules to get updated
  --
  function update_fnd_debug_rules_req_id (
               req_id             IN number,
               fnd_debug_rule_id  IN number )
        return boolean is
  begin

     begin
        update fnd_debug_rules
           set request_id = req_id
         where debug_rule_id = fnd_debug_rule_id;

        exception
          when others then
            fnd_message.set_name ('FND', 'SQL-Generic error');
            fnd_message.set_token ('ERRNO', sqlcode, FALSE);
            fnd_message.set_token ('REASON', sqlerrm, FALSE);
            fnd_message.set_token (
                'ROUTINE', 'update_fnd_debug_rules_req_id', FALSE);
            return FALSE;
     end;

     commit;
     return TRUE;
  end;

  -- Name
  --   delete_fnd_debug_rules_id
  -- Purpose
  --   Called to delete the specific fnd_debug_rule_id from fnd_debug_rules
  --   and fnd_debug_rules_options
  --
  -- Arguments
  --    fnd_debug_rule_id - the specific sequence number to be deleted
  --
  function delete_fnd_debug_rules_id (
               fnd_debug_rule_id  IN number )
        return boolean is
  l_count_rows  number;
  begin
     select count(*)
       into l_count_rows
       from fnd_debug_rules
      where debug_rule_id = fnd_debug_rule_id;

     if (l_count_rows > 0) then
        delete from fnd_debug_rules
         where debug_rule_id = fnd_debug_rule_id;
     end if;

     select count(*)
       into l_count_rows
       from fnd_debug_rule_options
      where debug_rule_id = fnd_debug_rule_id;

     if (l_count_rows > 0) then
        delete from fnd_debug_rule_options
         where debug_rule_id = fnd_debug_rule_id;
     end if;

     commit;
     return TRUE;

  end;

  -- NAME
  --    get_num_char_for_terr
  -- Purpose
  --    Called to retrieve the num char associated with a territory
  --
  -- Arguments
  --    original_terr
  --    check_terr
  --
  function get_num_char_for_terr (
               original_terr  IN varchar2,
               check_terr     IN varchar2 )
        return varchar2 is
  cursor cparam (param_name in varchar2) is
         select value
           from V$NLS_PARAMETERS
          where parameter = param_name;

  l_num_char  varchar2(3);
  begin

     dbms_session.set_nls('NLS_TERRITORY', ''''||UPPER(check_terr)||'''');

     open cparam('NLS_NUMERIC_CHARACTERS');
     fetch cparam into l_num_char;
     close cparam;

     dbms_session.set_nls('NLS_TERRITORY', ''''||UPPER(original_terr)||'''');

     return (l_num_char);

  end;

  -- NAME
  --    validate_num_char_for_terr
  -- Purpose
  --    Called to validate the num char associated with a territory
  --
  -- Arguments
  --    num_char
  --
  function validate_num_char_for_terr (
               num_char  IN varchar2 )
        return boolean is
  l_lookup_cnt number;
  begin

     select count(*)
       into l_lookup_cnt
       from fnd_lookup_values_vl
      where lookup_type = 'ICX_NUMERIC_CHARACTERS'
        and lookup_code = num_char;

     if ( l_lookup_cnt > 0 ) then
        return TRUE;
     else
        return FALSE;
     end if;
  end;
FUNCTION INSERT_USER_SCHEDULE(P_RELEASE_CLASS_NAME IN VARCHAR2,
                              P_REQUESTED_START_DATE IN VARCHAR2,
                              P_REQUESTED_END_DATE IN VARCHAR2,
                              P_REPEAT_INTERVAL IN NUMBER,
                              P_REPEAT_INTERVAL_UNIT in VARCHAR2,
                              P_REPEAT_INTERVAL_TYPE IN VARCHAR2,
                              P_CLASS_TYPE IN VARCHAR2,
                              P_CLASS_INFO IN VARCHAR2,
                              P_DESCRIPTION IN VARCHAR2
                              ) RETURN BOOLEAN IS


P_REPEAT_VALUE VARCHAR2(10);
RELCLASS_INSERT_ERROR EXCEPTION;
P_RELEASE_CLASS_ID NUMBER;
P_RELEASE_CLASS_APP_ID NUMBER;
P_REPEAT_START_DATE		DATE		:= null;
P_REPEAT_END_DATE		DATE		:= null;

BEGIN

  if(P_REQUESTED_START_DATE is null) then
    P_REPEAT_START_DATE := null;
  else
    P_REPEAT_START_DATE := FND_CONC_DATE.STRING_TO_DATE(P_REQUESTED_START_DATE);
  end if;

  if(P_REQUESTED_END_DATE is null) then
    P_REPEAT_END_DATE := null;
  else
    P_REPEAT_END_DATE := FND_CONC_DATE.STRING_TO_DATE(P_REQUESTED_END_DATE);
  end if;

  Select FND_CONC_RELEASE_CLASSES_S.nextval, 0
	     into P_RELEASE_CLASS_ID, P_RELEASE_CLASS_APP_ID from Sys.dual;

  SELECT (DECODE(P_CLASS_TYPE, 'P', Decode(P_REPEAT_INTERVAL_UNIT, NULL, NULL,
                              P_REPEAT_INTERVAL||':'||
                                 Decode(P_REPEAT_INTERVAL_UNIT,
						                        'MINUTES', 'N',
                                    'MONTHS', 'M',
                                    'HOURS', 'H',
                                    'DAYS',  'D') || ':' ||
                                    Decode(P_REPEAT_INTERVAL_TYPE,
						                        'START', 'S', 'C')), NULL)) INTO P_REPEAT_VALUE FROM SYS.DUAL;

  -- Bug 6808926. Consider repeat start date as SYSDATE if null

  INSERT INTO FND_CONC_RELEASE_CLASSES
    (APPLICATION_ID, RELEASE_CLASS_ID, RELEASE_CLASS_NAME,
    ENABLED_FLAG, LAST_UPDATE_DATE, LAST_UPDATED_BY,
    LAST_UPDATE_LOGIN, CREATION_DATE, CREATED_BY,
    UPDATED_FLAG, DATE1, DATE2,
    CLASS_TYPE, CLASS_INFO)
  VALUES (P_RELEASE_CLASS_APP_ID, P_RELEASE_CLASS_ID, P_RELEASE_CLASS_NAME,
    'Y', SYSDATE, FND_GLOBAL.USER_ID,
    FND_GLOBAL.CONC_LOGIN_ID, SYSDATE, FND_GLOBAL.USER_ID,
    'Y', decode(P_REPEAT_START_DATE, null, SYSDATE, P_REPEAT_START_DATE), P_REPEAT_END_DATE,
    P_CLASS_TYPE, DECODE(P_CLASS_TYPE, 'P', P_REPEAT_VALUE, P_CLASS_INFO));

  if (sql%rowcount = 0) then
	      raise RELCLASS_INSERT_ERROR;
  end if;

  INSERT INTO FND_CONC_RELEASE_CLASSES_TL
    (APPLICATION_ID,     RELEASE_CLASS_ID,
    LANGUAGE, SOURCE_LANG, USER_RELEASE_CLASS_NAME,
    LAST_UPDATE_DATE, LAST_UPDATED_BY, LAST_UPDATE_LOGIN,
    CREATION_DATE, CREATED_BY, DESCRIPTION)
  SELECT P_RELEASE_CLASS_APP_ID, P_RELEASE_CLASS_ID,
    L.LANGUAGE_CODE, USERENV('LANG'),	P_RELEASE_CLASS_NAME,
    SYSDATE, FND_GLOBAL.USER_ID, FND_GLOBAL.CONC_LOGIN_ID,
    SYSDATE, FND_GLOBAL.USER_ID, P_DESCRIPTION
  FROM FND_LANGUAGES L
  WHERE L.INSTALLED_FLAG in ('I', 'B');

  if (sql%rowcount = 0) then
	      raise RELCLASS_INSERT_ERROR;
  end if;
commit;
  return (TRUE);

EXCEPTION

when RELCLASS_INSERT_ERROR then
	    fnd_message.set_name ('FND', 'CONC-RelClass insert failed');
	    fnd_message.set_token ('APPLICATION', P_REL_CLASS_APP_ID, FALSE);
	    fnd_message.set_token ('CLASS', P_REL_CLASS_ID, FALSE);
	    return (FALSE);

when OTHERS then
	    fnd_message.set_name ('FND', 'SQL-Generic error');
	    fnd_message.set_token ('ERRNO', sqlcode, FALSE);
	    fnd_message.set_token ('REASON', sqlerrm, FALSE);
	    fnd_message.set_token (
				'ROUTINE', 'SUBMIT: others', FALSE);
	    return (FALSE);
END;

FUNCTION UPDATE_USER_SCHEDULE(P_RELEASE_CLASS_NAME IN VARCHAR2,
                              P_REQUESTED_START_DATE IN VARCHAR2,
                              P_REQUESTED_END_DATE IN VARCHAR2,
                              P_REPEAT_INTERVAL IN NUMBER,
                              P_REPEAT_INTERVAL_UNIT in VARCHAR2,
                              P_REPEAT_INTERVAL_TYPE IN VARCHAR2,
                              P_CLASS_TYPE IN VARCHAR2,
                              P_CLASS_INFO IN VARCHAR2,
                              P_DESCRIPTION IN VARCHAR2
                              ) RETURN BOOLEAN IS


P_REPEAT_VALUE VARCHAR2(10);
RELCLASS_INSERT_ERROR EXCEPTION;
P_RELEASE_CLASS_ID NUMBER;
P_RELEASE_CLASS_APP_ID NUMBER;
P_REPEAT_START_DATE		DATE		:= null;
P_REPEAT_END_DATE		DATE		:= null;

BEGIN

  if(P_REQUESTED_START_DATE is null) then
    P_REPEAT_START_DATE := null;
  else
    P_REPEAT_START_DATE := FND_CONC_DATE.STRING_TO_DATE(P_REQUESTED_START_DATE);
  end if;

  if(P_REQUESTED_END_DATE is null) then
    P_REPEAT_END_DATE := null;
  else
    P_REPEAT_END_DATE := FND_CONC_DATE.STRING_TO_DATE(P_REQUESTED_END_DATE);
  end if;

begin
select rc.application_id, rc.release_class_id into P_RELEASE_CLASS_APP_ID, P_RELEASE_CLASS_ID
from fnd_conc_release_classes_vl rc, fnd_application_vl a
 where rc.owner_req_id is null
   and rc.application_id = a.application_id
   and rc.user_release_class_name = P_RELEASE_CLASS_NAME;
exception
	when no_data_found then
		return false;
end;

SELECT (DECODE(P_CLASS_TYPE, 'P', Decode(P_REPEAT_INTERVAL_UNIT, NULL, NULL,
                              P_REPEAT_INTERVAL||':'||
                                 Decode(P_REPEAT_INTERVAL_UNIT,
						                        'MINUTES', 'N',
                                    'MONTHS', 'M',
                                    'HOURS', 'H',
                                    'DAYS',  'D') || ':' ||
                                    Decode(P_REPEAT_INTERVAL_TYPE,
						                        'START', 'S', 'C')), NULL)) INTO P_REPEAT_VALUE FROM SYS.DUAL;

  UPDATE FND_CONC_RELEASE_CLASSES
  set LAST_UPDATE_DATE = SYSDATE,
  LAST_UPDATED_BY = FND_GLOBAL.USER_ID,
  LAST_UPDATE_LOGIN = FND_GLOBAL.CONC_LOGIN_ID,
  DATE1 = decode(P_REPEAT_START_DATE, null, SYSDATE, P_REPEAT_START_DATE),
  DATE2 = P_REPEAT_END_DATE,
  CLASS_TYPE = P_CLASS_TYPE,
  CLASS_INFO = DECODE(P_CLASS_TYPE, 'P', P_REPEAT_VALUE, P_CLASS_INFO)
  where APPLICATION_ID = P_RELEASE_CLASS_APP_ID
  and release_class_id = P_RELEASE_CLASS_ID;

commit;
return (TRUE);

EXCEPTION
when OTHERS then
	    fnd_message.set_name ('FND', 'SQL-Generic error');
	    fnd_message.set_token ('ERRNO', sqlcode, FALSE);
	    fnd_message.set_token ('REASON', sqlerrm, FALSE);
	    fnd_message.set_token (
				'ROUTINE', 'SUBMIT: others', FALSE);
	    return (FALSE);
END;

function delete_user_schedule(schName varchar2)
return boolean is
P_RELEASE_CLASS_ID NUMBER;
P_RELEASE_CLASS_APP_ID NUMBER;
begin

begin
select rc.application_id, rc.release_class_id into P_RELEASE_CLASS_APP_ID, P_RELEASE_CLASS_ID
from fnd_conc_release_classes_vl rc, fnd_application_vl a
 where rc.owner_req_id is null
   and rc.application_id = a.application_id
   and rc.user_release_class_name = schName;
exception
	when no_data_found then
		return false;
end;

delete from FND_CONC_RELEASE_CLASSES
where APPLICATION_ID = P_RELEASE_CLASS_APP_ID
  and release_class_id = P_RELEASE_CLASS_ID;

delete from FND_CONC_RELEASE_CLASSES_TL
where APPLICATION_ID = P_RELEASE_CLASS_APP_ID
  and release_class_id = P_RELEASE_CLASS_ID;

commit;
return (TRUE);

EXCEPTION
when OTHERS then
	    fnd_message.set_name ('FND', 'SQL-Generic error');
	    fnd_message.set_token ('ERRNO', sqlcode, FALSE);
	    fnd_message.set_token ('REASON', sqlerrm, FALSE);
	    fnd_message.set_token (
				'ROUTINE', 'SUBMIT: others', FALSE);
	    return (FALSE);
end;




  --
  -- Name
  --   add_language
  -- Purpose
  --   Called before submission to submit a request in a particular language
  --   Can be called multiple times to submit a request in multiple languages
  --
  -- Arguments
  --	Lang		- Language
  --    Territory       - Territory
  --    Num_char        - Numeric characters
  --
  function add_language (
               lang IN VARCHAR2,
               territory IN VARCHAR2,
               num_char IN VARCHAR2) return boolean is

  begin

  P_NLS_PARAMETERS_COUNT := P_NLS_PARAMETERS_COUNT + 1;

  P_NLS_PARAMETERS(P_NLS_PARAMETERS_COUNT).nls_lang := lang;
  P_NLS_PARAMETERS(P_NLS_PARAMETERS_COUNT).nls_territory := territory;
  P_NLS_PARAMETERS(P_NLS_PARAMETERS_COUNT).nls_num_char := num_char;

  return (TRUE);

  exception
    when others then
      fnd_message.set_name ('FND', 'GLI-Not found');
    return(FALSE);

  end add_language;



  --
  -- Name
  --   add_delivery_option
  -- Purpose
  --   Called before submission to add a delivery option
  --
  -- Arguments
  --	Type		- Delivery type, see FND_DELIVERY
  --    p_argument1 - p_argument9 - Options specific to the delivery type
  --    nls_language    - Add only for this language
  --
  function add_delivery_option ( type in varchar2,
				 p_argument1 in varchar2 default null,
				 p_argument2 in varchar2 default null,
                                 p_argument3 in varchar2 default null,
				 p_argument4 in varchar2 default null,
				 p_argument5 in varchar2 default null,
				 p_argument6 in varchar2 default null,
                                 p_argument7 in varchar2 default null,
				 p_argument8 in varchar2 default null,
				 p_argument9 in varchar2 default null,
				 nls_language in varchar2 default null) return boolean is

     begin

	P_DELIV_OPTS_COUNT := P_DELIV_OPTS_COUNT + 1;

	P_DELIVERY_OPTIONS(P_DELIV_OPTS_COUNT).argument1 := type;
	P_DELIVERY_OPTIONS(P_DELIV_OPTS_COUNT).argument2 := p_argument1;
        P_DELIVERY_OPTIONS(P_DELIV_OPTS_COUNT).argument3 := p_argument2;
	P_DELIVERY_OPTIONS(P_DELIV_OPTS_COUNT).argument4 := p_argument3;
	P_DELIVERY_OPTIONS(P_DELIV_OPTS_COUNT).argument5 := p_argument4;
	P_DELIVERY_OPTIONS(P_DELIV_OPTS_COUNT).argument6 := p_argument5;
	P_DELIVERY_OPTIONS(P_DELIV_OPTS_COUNT).argument7 := p_argument6;
	P_DELIVERY_OPTIONS(P_DELIV_OPTS_COUNT).argument8 := p_argument7;
	P_DELIVERY_OPTIONS(P_DELIV_OPTS_COUNT).argument9 := p_argument8;
	P_DELIVERY_OPTIONS(P_DELIV_OPTS_COUNT).argument10 := p_argument9;
        P_DELIVERY_OPTIONS(P_DELIV_OPTS_COUNT).lang := nls_language;

	return (TRUE);

     end add_delivery_option;



end FND_REQUEST;


1 linha selecionada.

22:12:48 E2NXTL03.IT_PNET3>spool off;
