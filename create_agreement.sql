CREATE OR REPLACE PROCEDURE "SYSADM"."CREATE_AGREEMENT" (vinputfile in varchar2) is
--===================================================================================================================================
-- Nextel
-- Project    : 3G - BSCS Configurations Related to 3G (Roaming Agreement)
-- Date       : 16/09/2013
-- Author     : Daniel Souza
-- Date       : 09/03/2014
-- Author     : Bruno Cavalcanti
-- Comments   : Adequacoes para o PRIP - Capos removidos da tabela thsfttab

--===================================================================================================================================
    v_fcid              integer;
    v_customer_id       integer;
    v_custcode          integer;
    v_custnum           varchar2(30);
    v_billing_acc_id    integer;
    v_bacode            varchar2(50);
    v_cocode            varchar2(50);
    v_co_id             integer;
    v_trans             integer;
    v_tmcode            integer;
    v_plcode            integer;
    v_sthist            integer;
    v_sphist            integer;
    v_spcode            integer;
    v_spcogr            integer;
    v_ftid              integer;
    v_request           integer;
    v_count             integer:=0;
    v_geo               integer;
    v_refvalue          integer;
    v_error             varchar2(400);
    v_action            varchar2(150);
    v_operation         varchar2(1);
    v_check             varchar2(1):='Y';
    v_env               varchar2(15);
    v_zocode    sysadm.mpuzotab.zocode%type;
    v_zoorig    sysadm.mpuzotab.zocode%type;
    v_seqno integer;

    type tpchar is table of varchar2 (2000) index by binary_integer;
--    vinputfile          VARCHAR2 (100) := 'test_agreement.csv';
    vutl_directory      VARCHAR2(500) := 'BSCSUTL';
    ainputfile          tpchar;
    alineitem           tpchar;
    arquivo_saida       utl_file.file_type;

    type network_rec is record(v_plnetid    varchar2(5),
                               v_country        varchar2(20),
                               v_operator       varchar2(12),
                               v_mcc_1          varchar2(3),
                               v_mnc_1          varchar2(3),
                               v_mcc_60         varchar2(3),
                               v_mnc_60         varchar2(3),
                               v_utc            varchar2(7),
                               v_grupo          varchar2(7),
                               v_plnetid_new    varchar2(5),
                               v_origin         varchar2(30),
                               v_grupo_out      varchar2(7));

    type tpnetwork is table of network_rec index by binary_integer;
    v_network       tpnetwork;

    procedure SplitToArray (p_str_piped in varchar2, p_ch_pipe in varchar2, p_table out tpchar) is
        i        binary_integer;
        p_ini    binary_integer;
        p_fim    binary_integer;
    begin
        if p_str_piped is null then
            return;
        end if;

        i        := 1;
        p_ini    := 1;
        p_fim    := 1;

        loop
            p_fim          := instr (p_str_piped, p_ch_pipe, p_ini);

            if p_fim = 0 then
                p_fim    := length (p_str_piped) + 1;
            end if;

            p_table (i)   := substr (p_str_piped, p_ini, p_fim - p_ini);
            i              := i + 1;
            p_ini          := p_fim + 1;
            exit when p_ini >= length (p_str_piped);
        end loop;

        if substr (p_str_piped, -1) = p_ch_pipe then
            p_table (i)   := '';
        end if;
    exception
        when others then
            raise;
    end splittoarray;

    procedure OpenFile (p_tlinhas out tpchar, p_filename in varchar, p_directory in varchar2) is
        in_file          utl_file.file_type;
        vinline          varchar2 (4000);
        vidx             number := 0;
        i                 pls_integer;
        v_tlinhas_null     tpchar;
    begin
        in_file     := utl_file.fopen (p_directory, p_filename, 'r');
        p_tlinhas    := v_tlinhas_null;

        loop
            begin
                utl_file.get_line (in_file, vinline);

                if substr (vinline, 1, 1) != '#' then
                    i                  := utl_file.fgetpos (in_file);
                    vidx               := vidx + 1;
                    p_tlinhas (vidx)   := vinline;
                end if;
            exception
                when no_data_found then
                    exit;
                when others then
                    raise;
            end;
        end loop;

        utl_file.fclose (in_file);
    exception when others then
            raise;
    end OpenFile;

begin
    -- Fix sequences
    sysadm.nextfree.getstringvalue('MAX_DEALER_NUM',sysdate,v_custnum);
    select max(to_number(substr(custnum,4))) into v_count from sysadm.customer_all where custnum like 'BUS%';

    if v_count > to_number(substr(v_custnum,4)) then
        update sysadm.app_sequence_value
        set next_free_value     = v_count + 1
        where app_sequence_id = (select app_sequence_id
                                    from sysadm.app_sequence
                                   where app_sequence_key = 'MAX_DEALER_NUM');
        commit;
    end if;

    sysadm.nextfree.getvalue ('MAX_CUSTOMER_ID', v_customer_id);
    select max(customer_id) into v_count from sysadm.customer_base;

    if v_count > v_customer_id then
        update sysadm.app_sequence_value
        set next_free_value     = v_count + 1
        where app_sequence_id = (select app_sequence_id
                                    from sysadm.app_sequence
                                   where app_sequence_key = 'MAX_CUSTOMER_ID');
        commit;
    end if;

    sysadm.nextfree.getvalue ('MAX_TL_CODE', v_custcode);
    SELECT to_number(max(substr(custcode,3))) into v_count FROM sysadm.CUSTOMER_all WHERE  CUSTCODE LIKE '1.%';

    if v_count > v_custcode then
        update sysadm.app_sequence_value
        set next_free_value     = v_count + 1
        where app_sequence_id = (select app_sequence_id
                                    from sysadm.app_sequence
                                   where app_sequence_key = 'MAX_TL_CODE');
        commit;
    end if;

    sysadm.nextfree.getvalue ('MAX_BILLING_ACCOUNT_ID', v_billing_acc_id);
    SELECT MAX(BILLING_ACCOUNT_ID) into v_count FROM sysadm.BILLING_ACCOUNT;

    if v_count > v_billing_acc_id then
        update sysadm.app_sequence_value
        set next_free_value     = v_count + 1
        where app_sequence_id = (select app_sequence_id
                                    from sysadm.app_sequence
                                   where app_sequence_key = 'MAX_BILLING_ACCOUNT_ID');
        commit;
    end if;

    sysadm.nextfree.getstringvalue('MAX_BILLING_ACCNT_CODE',sysdate,v_bacode);
    SELECT MAX(to_number(substr(BILLING_ACCOUNT_code,3))) into v_count FROM sysadm.BILLING_ACCOUNT;

    if v_count > to_number(substr(v_bacode,3)) then
        update sysadm.app_sequence_value
        set next_free_value     = v_count + 1
        where app_sequence_id = (select app_sequence_id
                                    from sysadm.app_sequence
                                   where app_sequence_key = 'MAX_BILLING_ACCNT_CODE');
        commit;
    end if;

    sysadm.nextfree.getvalue ('MAX_REF_VALUE_ID', v_refvalue);
    SELECT MAX(REF_VALUE_ID) into v_count FROM sysadm.UDC_REFERENCE_VALUE;

    if v_count > v_refvalue then
        update sysadm.app_sequence_value
        set next_free_value     = v_count + 1
        where app_sequence_id = (select app_sequence_id
                                    from sysadm.app_sequence
                                   where app_sequence_key = 'MAX_REF_VALUE_ID');
        commit;
    end if;

    sysadm.nextfree.getvalue('MAX_CONTRACT_ID', v_co_id);
    SELECT MAX(co_ID) into v_count FROM sysadm.contract_all;

    if v_count > v_co_id then
        update sysadm.app_sequence_value
        set next_free_value     = v_count + 1
        where app_sequence_id = (select app_sequence_id
                                    from sysadm.app_sequence
                                   where app_sequence_key = 'MAX_CONTRACT_ID');
        commit;
    end if;

    sysadm.nextfree.getstringvalue('MAX_CO_CODE',sysdate,v_cocode);
    SELECT MAX(to_number(substr(co_code,6))) into v_count FROM sysadm.contract_all;

    if v_count > to_number(substr(v_cocode,6)) then
        update sysadm.app_sequence_value
        set next_free_value     = v_count + 1
        where app_sequence_id = (select app_sequence_id
                                    from sysadm.app_sequence
                                   where app_sequence_key = 'MAX_CO_CODE');
        commit;
    end if;


    OpenFile (ainputfile, vinputfile, vutl_directory);

    select substr(global_name,1,instr(global_name,'.')-1) into v_env from global_name;

    arquivo_saida := utl_file.fopen (vutl_directory, 'Agreement_'||to_char(sysdate,'yyyymmdd_hh24miss')||'.log', 'w');

    utl_file.put_line(arquivo_saida, '##################################################');
    utl_file.put_line(arquivo_saida, '#   Script to create/update Roaming Agreements   #');
    utl_file.put_line(arquivo_saida, '#                                                #');
    utl_file.put_line(arquivo_saida, '# Executed on: '||to_char(sysdate,'dd/mm/yyyy hh24:mi:ss')||'               #');
    utl_file.put_line(arquivo_saida, '# Environment: '||v_env||'                          #');
    utl_file.put_line(arquivo_saida, '# Executed by: '||user||'                            #');
    utl_file.put_line(arquivo_saida, '##################################################');
    utl_file.put_line(arquivo_saida, '    ');

    for i in 1 .. nvl (ainputfile.last, 0) loop
        SplitToArray (ainputfile (i), ',', alineitem);

        begin
            -- Get values from file
            v_action := 'Get values from file - Error: ';
            v_operation                 := alineitem (1);
            v_network(i).v_plnetid      := alineitem (2);
            v_network(i).v_country      := alineitem (3);
            v_network(i).v_operator     := alineitem (4);
            v_network(i).v_mcc_1        := alineitem (5);
            v_network(i).v_mnc_1        := alineitem (6);
            v_network(i).v_mcc_60       := alineitem (7);
            v_network(i).v_mnc_60       := alineitem (8);
            v_network(i).v_utc          := alineitem (9);
            v_network(i).v_grupo        := alineitem (10);
            v_network(i).v_plnetid_new  := alineitem (11);
            v_network(i).v_origin       := alineitem (12);
            v_network(i).v_grupo_out    := alineitem (13);
        exception when others then
            raise;
        end;

        -- Check if the Operator exists
        dbms_output.put_line('##### Starting operator '||v_network(i).v_plnetid||' #####');
        utl_file.put_line(arquivo_saida, '##### Starting operator '||v_network(i).v_plnetid||' #####');

        select count(1) into v_count from sysadm.mpdpltab where plnetid = v_network(i).v_plnetid;

        select request_id into v_request from sysadm.gmd_request_base where rownum =1;

        if v_count = 0 then
            if v_operation = 'C' then
                -- Create Operator
                dbms_output.put_line('--- Creating Operator '||v_network(i).v_plnetid||' ---');
                utl_file.put_line(arquivo_saida, '--- Creating Operator '||v_network(i).v_plnetid||' ---');
                select max(plcode) + 1 into v_plcode from sysadm.mpdpltab;

                begin
                    v_action := 'Create Operator - Error inserting MPDPLTAB: ';
                    insert into sysadm.mpdpltab (plcode,sccode,plmnname,plmntype,shdes,country,reconind,plnetid,network_type,rec_version,call_dest)
                    values (v_plcode,1,v_network(i).v_operator,'V',v_network(i).v_plnetid,v_network(i).v_country,'N',v_network(i).v_plnetid,'C',0,'IV');

                    v_action := 'Create Operator - Error inserting MPDLKPXN 1: ';
                    insert into sysadm.mpdlkpxn (plcode, npcode, country_code,national_access_code)
                    values (v_plcode, 1,v_network(i).v_mcc_1,v_network(i).v_mnc_1);

                    v_action := 'Create Operator - Error inserting MPDLKPXN 2: ';
                    insert into sysadm.mpdlkpxn (plcode, npcode, country_code)
                    values (v_plcode, 60,v_network(i).v_mcc_60);

                    v_action := 'Create Operator - Error inserting NETWORK_DESTINATION_TABLE 1: ';
                    insert into sysadm.network_destination_table (network_destination_id,national_destination_code,npcode,plcode)
                    values ((select max(network_destination_id)+1 from sysadm.network_destination_table),v_network(i).v_mnc_60,60,v_plcode);

                    v_action := 'Create Operator - Error inserting NETWORK_DESTINATION_TABLE 2: ';
                    insert into sysadm.network_destination_table (network_destination_id,npcode,plcode)
                    values ((select max(network_destination_id)+1 from sysadm.network_destination_table),1,v_plcode);

                    v_action := 'Create Operator - Error inserting MPDIATAB: ';
                    insert into sysadm.mpdiatab (network_access_id,plcode,npcode,iac,primary_flag,rec_version)
                    values ((select max(network_access_id)+1 from sysadm.mpdiatab),v_plcode,1,'0','X',0);

                    v_action := 'Create Operator - Error inserting MPULKVXT 1: ';
                    insert into sysadm.mpulkvxt (plcode, tvcode, source, rec_version) values (v_plcode, 0, v_network(i).v_plnetid, 0);
                    v_action := 'Create Operator - Error inserting MPULKVXT 2: ';
                    insert into sysadm.mpulkvxt (plcode, tvcode, source, rec_version) values (v_plcode, 2, v_network(i).v_plnetid, 0);
                    v_action := 'Create Operator - Error inserting MPULKVXT 3: ';
                    insert into sysadm.mpulkvxt (plcode, tvcode, source, rec_version) values (v_plcode, 5, v_network(i).v_plnetid, 0);
                    v_action := 'Create Operator - Error inserting MPULKVXT 4: ';
                    insert into sysadm.mpulkvxt (plcode, tvcode, source, rec_version) values (v_plcode, 16, v_network(i).v_plnetid, 0);

                    select geotimezone into v_geo from sysadm.mpdgmtab where des = v_network(i).v_utc;

                    v_action := 'Create Operator - Error inserting MPUGMTAB: ';
                    insert into sysadm.mpugmtab (plcode, vsdate, geotimezone, rec_version)
                    values (v_plcode, to_date('01/01/1998 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), v_geo, 0);
                    dbms_output.put_line('--- Operator '||v_network(i).v_plnetid||' was created ---');
                    utl_file.put_line(arquivo_saida, '--- Operator '||v_network(i).v_plnetid||' was created ---');

                    -- Crete Exchange
                    dbms_output.put_line('--- Creating Exchange for '||v_network(i).v_plnetid||' ---');
                    utl_file.put_line(arquivo_saida, '--- Creating Exchange for '||v_network(i).v_plnetid||' ---');
                    select max(ft_id)+1 into v_ftid from sysadm.thsfttab;

                    v_action := 'Crete Exchange - Error inserting THSFTTAB 1: ';
                    insert into sysadm.thsfttab (ft_id, io, description, type, directory, process, recycling_ind,  rec_version, exchange_format_id, imp_channel_id, source_network_code, home_network_code)
                    values (v_ftid, 'O', 'TRAC Records', 'TRAC', '/MP/3G/TRAC/OUT/'||v_network(i).v_plnetid||'/', 'foh', 'C',  0, 16, 3, v_plcode, 1004);

                    v_action := 'Crete Exchange - Error inserting IMP_FUNCTION_CONTROL 1: ';
                    insert into sysadm.imp_function_control (import_function_id, file_type_id, import_directory, import_filename_pattern, description, process_priority, transfer_mode)
                    values ((select max(import_function_id)+1 from sysadm.imp_function_control), v_ftid, '/INPUT3G/TRAC/IN/'||v_network(i).v_plnetid||'/TAP/', '^(CD)[A-Z0-9]{10}[0-9]{5}$', v_network(i).v_operator||' TAP records', 1, 1);

                    select max(ft_id)+1 into v_ftid from sysadm.thsfttab;

                    v_action := 'Crete Exchange - Error inserting THSFTTAB 2: ';
                    insert into sysadm.thsfttab (ft_id, io, description, type, directory, process, recycling_ind,  rec_version, exchange_format_id, imp_channel_id, source_network_code, home_network_code)
                    values (v_ftid, 'I', 'TRAC Records', 'TRAC', '/MP/3G/TRAC/IN/'||v_network(i).v_plnetid||'/', 'fih', 'C', 0, 16, 3, v_plcode, 1004);

                    v_action := 'Crete Exchange - Error inserting IMP_FUNCTION_CONTROL 2: ';
                    insert into sysadm.imp_function_control (import_function_id, file_type_id, import_directory, import_filename_pattern, description, process_priority, transfer_mode)
                    values ((select max(import_function_id)+1 from sysadm.imp_function_control), v_ftid, '/INPUT3G/TRAC/IN/'||v_network(i).v_plnetid||'/TAP/', '^(CD)[A-Z0-9]{10}[0-9]{5}$', v_network(i).v_operator||' TAP records', 1, 1);
                    dbms_output.put_line('--- Exchange for '||v_network(i).v_plnetid||' was created ---');
                    utl_file.put_line(arquivo_saida, '--- Exchange for '||v_network(i).v_plnetid||' was created ---');
                exception when others then
                    raise;
                end;

                -- Create rating Origin
                dbms_output.put_line('--- Create rating Origin for '||v_network(i).v_plnetid||' ---');
                utl_file.put_line(arquivo_saida, '--- Create rating Origin for '||v_network(i).v_plnetid||' ---');

                -- Check if Origin already exists
                select count(1) into v_count from sysadm.mpuzotab where des = v_network(i).v_origin;

                if v_count = 0 then
                    -- Create new Origin
                    v_action := 'Create Origin - Error inserting MPUZOTAB: ';
                    sysadm.nextfree.getvalue ('MAX_ZOCODE', v_zocode);
                    insert into sysadm.mpuzotab values(v_zocode, v_network(i).v_origin, v_network(i).v_mcc_60||v_network(i).v_mnc_60, 1, 0, 51, 'RO'||v_zocode, 0);

                    -- Using this Origin as source
                    select zocode into v_zoorig  from sysadm.mpuzotab where des = 'DIGICEL Panana';

                    for rec in (select * from sysadm.mpulkgvm where zocode = v_zoorig  order by gvcode) loop

                        select max(seqno) + 1 into v_seqno
                        from sysadm.mpulkgvm
                        where gvcode = rec.gvcode
                        and vscode = rec.vscode;

                        v_action := 'Create Origin - Error inserting MPULKGVM: ';
                        insert into sysadm.mpulkgvm (gvcode, vscode, vsdate, zncode, zocode, zpcode, gzcode, gzncode, zodes, cgi, zpdes, digits,
                                                    override_gz, dest_npcode, rec_version, origin_npcode, import_export_flag, seqno)
                        values (rec.gvcode, rec.vscode, rec.vsdate, rec.zncode, v_zocode, rec.zpcode, rec.gzcode, rec.gzncode,
                                v_network(i).v_origin, v_network(i).v_mcc_60||v_network(i).v_mnc_60, rec.zpdes, rec.digits,
                                rec.override_gz, rec.dest_npcode, rec.rec_version, rec.origin_npcode, rec.import_export_flag, v_seqno);

                        select max(seqno) + 1 into v_seqno
                        from sysadm.mpulkgv2
                        where gvcode = rec.gvcode
                        and vscode = 0;

                        v_action := 'Create Origin - Error inserting MPULKGV2: ';
                        insert into sysadm.mpulkgv2 (gvcode, vscode, vsdate, zncode, zocode, zpcode, gzcode, gzncode, zodes, cgi, zpdes, digits,
                                                    override_gz, dest_npcode, rec_version, origin_npcode,  seqno)
                        values (rec.gvcode, 0, rec.vsdate, rec.zncode, v_zocode, rec.zpcode, rec.gzcode, rec.gzncode,
                                v_network(i).v_origin, v_network(i).v_mcc_60||v_network(i).v_mnc_60, rec.zpdes, rec.digits,
                                rec.override_gz, rec.dest_npcode, rec.rec_version, rec.origin_npcode,  v_seqno);
                    end loop;
                end if;

                -- Add condition in Complex Condition for TAPIN
                dbms_output.put_line('--- Add condition in Complex Cond for operator '||v_network(i).v_plnetid||' ---');
                utl_file.put_line(arquivo_saida, '--- Add condition in Complex Cond for operator '||v_network(i).v_plnetid||' ---');

                for rec in (select sc.simple_cond_id from sysadm.udc_complex_cond cc, sysadm.udc_chain ch, sysadm.udc_simple_cond sc
                where cc.complex_cond_id = ch.complex_cond_id
                and ch.chain_id = sc.chain_id
                and sc.uds_member_code = 15
                and sc.uds_element_code = 14
                and cc.short_des like '%TAPIN%'||v_network(i).v_grupo||'%') loop
                    select count(1) into v_count from sysadm.udc_reference_value where simple_cond_id = rec.simple_cond_id and ref_integer = v_plcode;

                    if v_count = 0 then
                        begin
                            sysadm.nextfree.getvalue ('MAX_REF_VALUE_ID', v_refvalue);
                            v_action := 'Add condition in Complex Condition - Error inserrindo UDC_REFERENCE_VALUE: ';

                            insert into sysadm.udc_reference_value values(v_refvalue, rec.simple_cond_id, v_plcode, null, null, null, null);
                            dbms_output.put_line('--- Condition in Complex Cond for operator '||v_network(i).v_plnetid||' was inserted ---');
                            utl_file.put_line(arquivo_saida, '--- Condition in Complex Cond for operator '||v_network(i).v_plnetid||' was inserted ---');
                        exception when others then
                            raise;
                        end;
                    else
                        dbms_output.put_line('--- Condition in Complex Cond for operator '||v_network(i).v_plnetid||' already exist ---');
                        utl_file.put_line(arquivo_saida, '--- Condition in Complex Cond for operator '||v_network(i).v_plnetid||' already exist ---');
                    end if;
                end loop;

                -- Add condition in Complex Condition for TAPOUT
                dbms_output.put_line('--- Add condition in Complex Cond for operator '||v_network(i).v_plnetid||' ---');
                utl_file.put_line(arquivo_saida, '--- Add condition in Complex Cond for operator '||v_network(i).v_plnetid||' ---');

                for rec in (select sc.simple_cond_id from sysadm.udc_complex_cond cc, sysadm.udc_chain ch, sysadm.udc_simple_cond sc
                where cc.complex_cond_id = ch.complex_cond_id
                and ch.chain_id = sc.chain_id
                and sc.uds_member_code = 15
                and sc.uds_element_code = 14
                and cc.short_des like '%OUT%'||nvl(v_network(i).v_grupo_out,'-----')||'%') loop
                    select count(1) into v_count from sysadm.udc_reference_value where simple_cond_id = rec.simple_cond_id and ref_integer = v_plcode;

                    if v_count = 0 then
                        begin
                            sysadm.nextfree.getvalue ('MAX_REF_VALUE_ID', v_refvalue);
                            v_action := 'Add condition in Complex Condition - Error inserrindo UDC_REFERENCE_VALUE: ';

                            insert into sysadm.udc_reference_value values(v_refvalue, rec.simple_cond_id, v_plcode, null, null, null, null);
                            dbms_output.put_line('--- Condition in Complex Cond for operator '||v_network(i).v_plnetid||' was inserted ---');
                            utl_file.put_line(arquivo_saida, '--- Condition in Complex Cond for operator '||v_network(i).v_plnetid||' was inserted ---');
                        exception when others then
                            raise;
                        end;
                    else
                        dbms_output.put_line('--- Condition in Complex Cond for operator '||v_network(i).v_plnetid||' already exist ---');
                        utl_file.put_line(arquivo_saida, '--- Condition in Complex Cond for operator '||v_network(i).v_plnetid||' already exist ---');
                    end if;
                end loop;

            else
                dbms_output.put_line('--- Operator '||v_network(i).v_plnetid||' doesnt exist, so, not updated ---');
                utl_file.put_line(arquivo_saida, '--- Operator '||v_network(i).v_plnetid||' doesnt exist, so, not updated ---');
                v_check := 'N';
            end if;
        else
            select plcode into v_plcode from sysadm.mpdpltab where plnetid = v_network(i).v_plnetid;
            if v_operation = 'C' then
                dbms_output.put_line('--- Operator '||v_network(i).v_plnetid||' already exist ---');
                utl_file.put_line(arquivo_saida, '--- Operator '||v_network(i).v_plnetid||' already exist ---');
            else
                begin
                    -- Update Operator
                    v_action := 'Update Operator - Error updating MPULKVXT: ';
                    dbms_output.put_line('--- Updating Operator '||v_network(i).v_plnetid||' ---');
                    utl_file.put_line(arquivo_saida, '--- Updating Operator '||v_network(i).v_plnetid||' ---');
                    update sysadm.mpulkvxt
                    set source   = v_network(i).v_plnetid_new
                    where plcode = v_plcode;

                    v_action := 'Update Operator - Error updating MPDPLTAB: ';
                    update sysadm.mpdpltab
                    set plmnname    = v_network(i).v_operator,
                        country     = v_network(i).v_country,
                        shdes       = v_network(i).v_plnetid_new,
                        plnetid     = v_network(i).v_plnetid_new
                    where plcode    = v_plcode;

                    v_action := 'Update Operator - Error updating MPDLKPXN 1: ';
                    update sysadm.mpdlkpxn
                    set country_code         = v_network(i).v_mcc_1,
                        national_access_code = v_network(i).v_mnc_1
                    where plcode = v_plcode
                    and npcode = 1;

                    v_action := 'Update Operator - Error updating MPDLKPXN 2: ';
                    update sysadm.mpdlkpxn
                    set country_code         = v_network(i).v_mcc_60
                    where plcode = v_plcode
                    and npcode = 60;

                    v_action := 'Update Operator - Error updating NETWORK_DESTINATION_TABLE 1: ';
                    update sysadm.network_destination_table
                    set national_destination_code = v_network(i).v_mnc_60
                    where plcode = v_plcode
                    and npcode = 60;

                    select geotimezone into v_geo from sysadm.mpdgmtab where des = v_network(i).v_utc;

                    v_action := 'Update Operator - Error updating MPUGMTAB: ';
                    update  sysadm.mpugmtab
                    set geotimezone = v_geo
                    where plcode = v_plcode;

                    dbms_output.put_line('--- Operator '||v_network(i).v_plnetid||' was updated ---');
                    utl_file.put_line(arquivo_saida, '--- Operator '||v_network(i).v_plnetid||' was updated ---');

                    -- Update Exchange
                    dbms_output.put_line('--- Updating Exchange for '||v_network(i).v_plnetid||' ---');
                    utl_file.put_line(arquivo_saida, '--- Updating Exchange for '||v_network(i).v_plnetid||' ---');

                    v_action := 'Update Exchange - Error updating THSFTTAB 1: ';
                    update sysadm.thsfttab
                    set directory = '/MP/3G/TRAC/OUT/'||v_network(i).v_plnetid_new||'/'
                    where source_network_code = v_plcode
                    and home_network_code = 1004
                    and io = 'O';

                    select ft_id into v_ftid
                    from sysadm.thsfttab
                    where source_network_code = v_plcode
                    and home_network_code = 1004
                    and io = 'O';

                    v_action := 'Update Exchange - Error updating IMP_FUNCTION_CONTROL 1: ';
                    update sysadm.imp_function_control
                    set import_directory = '/INPUT3G/TRAC/IN/'||v_network(i).v_plnetid_new||'/TAP/',
                        description = v_network(i).v_operator||' TAP records'
                    where file_type_id = v_ftid;

                    v_action := 'Update Exchange - Error updating THSFTTAB 2: ';
                    update sysadm.thsfttab
                    set directory = '/MP/3G/TRAC/IN/'||v_network(i).v_plnetid_new||'/'
                    where source_network_code = v_plcode
                    and home_network_code = 1004
                    and io = 'I';

                    select ft_id into v_ftid
                    from sysadm.thsfttab
                    where source_network_code = v_plcode
                    and home_network_code = 1004
                    and io = 'I';

                    v_action := 'Update Exchange - Error updating IMP_FUNCTION_CONTROL 2: ';
                    update sysadm.imp_function_control
                    set import_directory = '/INPUT3G/TRAC/IN/'||v_network(i).v_plnetid_new||'/TAP/',
                        description = v_network(i).v_operator||' TAP records'
                    where file_type_id = v_ftid;

                    dbms_output.put_line('--- Exchange for '||v_network(i).v_plnetid||' was updated ---');
                    utl_file.put_line(arquivo_saida, '--- Exchange for '||v_network(i).v_plnetid||' was updated ---');
                exception when others then
                    raise;
                end;
            end if;
        end if;

        if v_operation = 'C' then
            -- Check if the Customer exists
            select count(1) into v_count
            from sysadm.contract_all
            where plcode = 1004
            and tmcode in (select tmcode from sysadm.rateplan where shdes in ('3TO01','3TI01'))
            and remote_plcode = v_plcode;

            if v_count = 0 then
                select count(1) into v_count from sysadm.ccontact_all where ccname = v_network(i).v_operator;

                if v_count = 0 then
                    begin
                        -- create Roaming Agreement
                        -- Create Customer
                        dbms_output.put_line('--- Creating Customer for operator '||v_network(i).v_plnetid||' ---');
                        utl_file.put_line(arquivo_saida, '--- Creating Customer for operator '||v_network(i).v_plnetid||' ---');

                        sysadm.nextfree.getvalue ('MAX_CUSTOMER_ID', v_customer_id);
                        sysadm.nextfree.getvalue ('MAX_TL_CODE', v_custcode);
                        sysadm.nextfree.getvalue ('MAX_BILLING_ACCOUNT_ID', v_billing_acc_id);
                        sysadm.nextfree.getstringvalue('MAX_BILLING_ACCNT_CODE',sysdate,v_bacode);
                        sysadm.nextfree.getstringvalue('MAX_DEALER_NUM',sysdate,v_custnum);

                        v_action := 'Create Customer - Error inserting CUSTOMER_BASE: ';
                        insert into sysadm.customer_base (customer_id, customer_set_id)
                        values (v_customer_id, 1);

                        v_action := 'Create Customer - Error inserting CUSTOMER_ALL: ';
                        insert into sysadm.customer_all (customer_id, custcode, cstype, csactivated, cstype_date, cscusttype, tmcode, prgcode, csclimit, cscurbalance, paymntresp, csreason, cscontresp, csdeposit, prev_balance, area_id, costcenter_id, id_type, user_lastmod, csentdate, csmoddate, csmod, wpid, expect_pay_curr_id, convratetype_payment, refund_curr_id, convratetype_refund, currency, rec_version, custnum, business_unit_id, party_type_id, restriction_fleet_flag, restriction_ihlr_flag, created_by_user)
                        values (v_customer_id, '1.'||v_custcode, 'a', to_date('01/01/1998 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), to_date('01/01/1998 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 'B', 11, '5', 0, 0, 'X', 1, 'X', 0, 0, 1, 1, 1, 'SYSADM', to_date('01/01/1998 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), to_date('01/01/1998 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 'X', 1, 176, 1, 176, 1, 176, 1, v_custnum, 2, 2, 'N', 'N', 'SYSADM');

                        v_action := 'Create Customer - Error inserting CCONTACT_ALL: ';
                        insert into sysadm.ccontact_all (customer_id, ccseq, ccname, ccfname, cclname, ccline3, ccline6, ccuser, ccbill, ccbilldetails, cccontract, ccship, ccmagazine, ccdirectory, country, cclanguage, sort_criteria, ccentdate, ccbill_previous, ccemail, ccbilltemp, userlastmod, rec_version, id_type, cscusttype, area_id, entry_user)
                        values (v_customer_id, 1, v_network(i).v_operator, v_network(i).v_operator, v_network(i).v_country, v_network(i).v_operator, v_network(i).v_country, 'X', 'X', 'X', 'X', 'X', 'X', 'X', 32, 5, '0000000000000000000000000000000000000000', to_date('01/01/1998 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 'X', 'tadig@tadig.org', 'X', 'SYSADM', 1, 1, 'B', 1, 'SYSADM');

                        v_action := 'Create Customer - Error inserting CUSTOMER_FAMILY: ';
                        insert into sysadm.customer_family (customer_id, histno, family_id, valid_from, completion_status, request_id, entry_user, entry_date)
                        values (v_customer_id, 1, 10, to_date('01/01/1998 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 0, v_request, 'SYSADM', to_date('01/01/1998 00:00:00', 'MM/DD/YYYY HH24:MI:SS'));

                        v_action := 'Create Customer - Error inserting CUSTOMER_ROLE: ';
                        insert into sysadm.customer_role (customer_id, party_role_id)
                        values (v_customer_id, 4);

                        v_action := 'Create Customer - Error inserting RATEPLAN_HIST_OCC: ';
                        insert into sysadm.rateplan_hist_occ (customer_id, seqno, tmcode, tmcode_date, userlastmod, rec_version)
                        values (v_customer_id, 1, 11, to_date('01/01/1998 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 'SYSADM', 1);

                        v_action := 'Create Customer - Error inserting INDIVIDUAL_TAXATION: ';
                        insert into sysadm.individual_taxation (customer_id, valid_from, customercat_code, rec_version, entry_user, entry_date)
                        values (v_customer_id, to_date('01/01/1998 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 227, 1, 'SYSADM', to_date('01/01/1998 00:00:00', 'MM/DD/YYYY HH24:MI:SS'));

                        v_action := 'Create Customer - Error inserting PAYMENT_ALL: ';
                        insert into sysadm.payment_all (customer_id, seq_id, ceilingamt, act_used, payment_type, entdate, moddate, userlastmod, currency, rec_version, entry_user)
                        values (v_customer_id, 1, 0, 'X', -3, to_date('01/01/1998 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), to_date('01/01/1998 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 'SYSADM', 176, 1, 'SYSADM');

                        v_action := 'Create Customer - Error inserting PRICEGROUP_ALL_CUST: ';
                        insert into sysadm.pricegroup_all_cust (prgcode, customer_id)
                        values ('5', v_customer_id);

                        v_action := 'Create Customer - Error inserting BILLCYCLE_ASSIGNMENT_HISTORY: ';
                        insert into sysadm.billcycle_assignment_history (customer_id, seqno, billcycle, valid_from, reason_id, username)
                        values (v_customer_id, 1, '09', to_date('01/01/1998 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 1, 'SYSADM');
                        dbms_output.put_line('--- Customer for operator '||v_network(i).v_plnetid||' was created ---');
                        utl_file.put_line(arquivo_saida, '--- Customer for operator '||v_network(i).v_plnetid||' was created ---');

                        -- Create Billling Account
                        dbms_output.put_line('--- Creating Billing Account for operator '||v_network(i).v_plnetid||' ---');
                        utl_file.put_line(arquivo_saida, '--- Creating Billing Account for operator'||v_network(i).v_plnetid||' ---');
                        v_action := 'Billling Account - Error inserting BILLING_ACCOUNT: ';
                        insert into sysadm.billing_account (billing_account_id, billing_account_code, billing_account_name, customer_id, primary_flag, termcode, csbillmedium, primary_doc_currency, prim_convratetype_doc, copies, forcurr_level, contact_seqno_temp, contact_seqno, payment_seqno, invoicing_ind, entry_date, rec_version)
                        values (v_billing_acc_id, v_bacode, 'Nm_'||v_customer_id, v_customer_id, 'X', 1, 5, 176, 1, 1, 1, 1, 1, 1, 'I', to_date('01/01/1998 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 1);

                        v_action := 'Billling Account - Error inserting BILLING_ACCOUNT_VERSION: ';
                        insert into sysadm.billing_account_version (billing_account_id, billing_account_version, valid_from, status, individualtax_from_ind, tax_exemption_from_ind, rec_version)
                        values (v_billing_acc_id, 1, to_date('01/01/1998 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 'A', 'C', 'C', 1);
                        dbms_output.put_line('--- Billing Account for operator '||v_network(i).v_plnetid||' was created ---');
                        utl_file.put_line(arquivo_saida, '--- Billing Account for operator '||v_network(i).v_plnetid||' was created ---');
                    exception when others then
                        raise;
                    end;
                else
                    dbms_output.put_line('--- Customer for operator '||v_network(i).v_plnetid||' already exist ---');
                    utl_file.put_line(arquivo_saida, '--- Customer for operator '||v_network(i).v_plnetid||' already exist ---');
                    select customer_id into v_customer_id from sysadm.ccontact_all where ccname = v_network(i).v_operator;
                    select billing_account_id into v_billing_acc_id from sysadm.billing_account where customer_id = v_customer_id;
                end if;
            else
                dbms_output.put_line('--- Customer for operator '||v_network(i).v_plnetid||' already exist ---');
                utl_file.put_line(arquivo_saida, '--- Customer for operator '||v_network(i).v_plnetid||' already exist ---');
                select distinct customer_id into v_customer_id
                from sysadm.contract_all
                where plcode = 1004
                and tmcode in (select tmcode from sysadm.rateplan where shdes in ('3TO01','3TI01'))
                and remote_plcode = v_plcode;

                select billing_account_id into v_billing_acc_id from sysadm.billing_account where customer_id = v_customer_id;
            end if;

            v_action := 'Get SPCODE TAPOUT - Error Getting SPCODE: ';
            select spcode into v_spcode from sysadm.mpusptab where shdes = '3GTAP';

            if v_network(i).v_grupo_out is not null then
                select spcode into v_spcogr from sysadm.mpusptab where des like '%TAP-OUT%'||v_network(i).v_grupo_out||'%';
            else
                select spcode into v_spcogr from sysadm.mpusptab where shdes = '3GTAP';
            end if;

            select count(1) into v_count
            from sysadm.contract_all
            where plcode = 1004
            and tmcode = (select tmcode from sysadm.rateplan where shdes = '3TO01')
            and remote_plcode = v_plcode;

            if v_count = 0 then
                begin
                    -- Create TAP-OUT Contract
                    dbms_output.put_line('--- Creating TAP-OUT contract for operator '||v_network(i).v_plnetid||' ---');
                    utl_file.put_line(arquivo_saida, '--- Creating TAP-OUT contract for operator '||v_network(i).v_plnetid||' ---');
                    sysadm.nextfree.getvalue('MAX_CONTRACT_ID', v_co_id);
                    sysadm.nextfree.getstringvalue('MAX_CO_CODE',sysdate,v_cocode);
                    select sysadm.max_transaction_id_seq.nextval into v_trans from dual;
                    select tmcode into v_tmcode from sysadm.rateplan where shdes = '3TO01';

                    v_action := 'Create TAP-OUT Contract - Error inserting CONTRACT_ALL: ';
                    insert into sysadm.contract_all (co_id, customer_id, type, plcode, sccode, subm_id, co_signed, co_installed, co_archive, co_activated, co_entdate, co_moddate, co_userlastmod, tmcode, tmcode_date, currency, rec_version, co_code, business_unit_id, agreement_type, remote_plcode, home_party_id, contract_type_id, cds_bill_medium, cds_generation, ch_status, ch_status_validfrom)
                    values (v_co_id, v_customer_id, 'A', 1004, 1, 24, to_date('01/01/1998 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), to_date('01/01/1998 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 'X', to_date('01/01/1998 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), to_date('01/01/1998 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), to_date('01/01/1998 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 'SYSADM', v_tmcode, to_date('01/01/1998 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 176, 1, v_cocode, 2, 'RA', v_plcode, 1, 5, 5, 'R', 'a', to_date('01/01/1998 00:00:00', 'MM/DD/YYYY HH24:MI:SS'));

                    v_action := 'Create TAP-OUT Contract - Error inserting CONTRACT_HISTORY 1: ';
                    insert into sysadm.contract_history (co_id, ch_seqno, ch_status, ch_reason, ch_validfrom, entdate, userlastmod, rec_version)
                    values (v_co_id, 1, 'o', 6, to_date('01/01/1998 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), to_date('01/01/1998 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 'SYSADM', 1);

                    v_action := 'Create TAP-OUT Contract - Error inserting CONTRACT_HISTORY 2: ';
                    insert into sysadm.contract_history (co_id, ch_seqno, ch_status, ch_reason, ch_validfrom, entdate, userlastmod, request, rec_version)
                    values (v_co_id, 2, 'a', 1, to_date('01/01/1998 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), to_date('01/01/1998 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 'SYSADM', v_request, 2);

                    v_action := 'Create TAP-OUT Contract - Error inserting RATEPLAN_HIST: ';
                    insert into sysadm.rateplan_hist (co_id, seqno, tmcode, tmcode_date, userlastmod, rec_version, request_id, transactionno)
                    values (v_co_id, 1, v_tmcode, to_date('01/01/1998 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 'SYSADM', 1, v_request, v_trans);

                    v_action := 'Create TAP-OUT Contract - Error inserting CONTRACT_CARRY_OVER_HIST: ';
                    insert into sysadm.contract_carry_over_hist (co_id, seq_no, carry_over_contr_ind, valid_from)
                    values (v_co_id, 1, 'N', to_date('01/01/1998 00:00:00', 'MM/DD/YYYY HH24:MI:SS'));

                    v_action := 'Create TAP-OUT Contract - Error inserting CONTR_TARIFF_OPTIONS: ';
                    insert into sysadm.contr_tariff_options (co_id, seqno, valid_from, rec_version, prerated_tap_rp_ind, non_expl_serv_paymenttype, request_id, entry_user, entry_date)
                    values (v_co_id, 1, to_date('01/01/1998 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 1, 'N', 'O', v_request, 'SYSADM', to_date('01/01/1998 00:00:00', 'MM/DD/YYYY HH24:MI:SS'));

                    for rec in (select distinct sncode from mpulktmb where tmcode = v_tmcode) loop
                        v_action := 'Create TAP-OUT Contract - Error inserting CONTRACT_SERVICE sncode '||rec.sncode||': ';
                        insert into sysadm.contract_service (co_id, sncode) values (v_co_id, rec.sncode);

                        select sysadm.pr_serv_spcode_histno_seq.nextval into v_sphist from dual;
                        select sysadm.pr_serv_status_histno_seq.nextval into v_sthist from dual;

                        v_action := 'Create TAP-OUT Contract - Error inserting PROFILE_SERVICE sncode '||rec.sncode||': ';
                        insert into sysadm.profile_service (profile_id, co_id, sncode, spcode_histno, status_histno, entry_date, sn_class, ovw_acc_prd,currency, ovw_adv_charge, adv_charge_prd, rec_version)
                        values(0, v_co_id, rec.sncode, v_sphist, v_sthist, to_date('01/01/1998 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), rec.sncode, 0, 176, 'N', 0, 1);

                        v_action := 'Create TAP-OUT Contract - Error inserting PR_SERV_STATUS_HIST 1 sncode '||rec.sncode||': ';
                        insert into sysadm.pr_serv_status_hist (profile_id, co_id, sncode, histno, status, reason, transactionno, valid_from_date, entry_date, rec_version, entry_user)
                        values(0, v_co_id, rec.sncode, v_sthist, 'O', 1, v_trans, to_date('01/01/1998 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), to_date('01/01/1998 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 0, 'SYSADM');

                        select sysadm.pr_serv_status_histno_seq.nextval into v_sthist from dual;
                        v_action := 'Create TAP-OUT Contract - Error inserting PR_SERV_STATUS_HIST 2 sncode '||rec.sncode||': ';
                        insert into sysadm.pr_serv_status_hist (profile_id, co_id, sncode, histno, status, reason, transactionno, valid_from_date, entry_date, rec_version, rs_id, entry_user)
                        values(0, v_co_id, rec.sncode, v_sthist, 'A', 0, v_trans, to_date('01/01/1998 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), to_date('01/01/1998 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 0, 315, 'SYSADM');

                        if rec.sncode in (2016,2124,2143) then
                            v_action := 'Create TAP-OUT Contract - Error inserting PR_SERV_SPCODE_HIST sncode '||rec.sncode||': ';
                            insert into sysadm.pr_serv_spcode_hist values(0,v_co_id,rec.sncode,v_sphist,v_spcogr,v_trans,to_date('01/01/1998 00:00:00', 'MM/DD/YYYY HH24:MI:SS'),to_date('01/01/1998 00:00:00', 'MM/DD/YYYY HH24:MI:SS'),null,1,'SYSADM');
                        else
                            v_action := 'Create TAP-OUT Contract - Error inserting PR_SERV_SPCODE_HIST sncode '||rec.sncode||': ';
                            insert into sysadm.pr_serv_spcode_hist values(0,v_co_id,rec.sncode,v_sphist,v_spcode,v_trans,to_date('01/01/1998 00:00:00', 'MM/DD/YYYY HH24:MI:SS'),to_date('01/01/1998 00:00:00', 'MM/DD/YYYY HH24:MI:SS'),null,1,'SYSADM');
                        end if;

                        v_action := 'Create TAP-OUT Contract - Error updating PROFILE_SERVICE sncode '||rec.sncode||': ';
                        update sysadm.profile_service set spcode_histno = v_sphist, status_histno = v_sthist
                        where profile_id = 0 and co_id = v_co_id and sncode =rec.sncode;

                    end loop;

                    v_action := 'Create TAP-OUT Contract - Error inserrindo BILLING_ACCOUNT_ASSIGNMENT: ';
                    insert into sysadm.billing_account_assignment (billing_account_id, contract_id, seqno, valid_from)
                    values (v_billing_acc_id, v_co_id, 0, to_date('01/01/1998 00:00:00', 'MM/DD/YYYY HH24:MI:SS'));

                    v_action := 'Create TAP-OUT Contract - Error inserrindo CONTRACT_DATA_EXCHANGE: ';
                    insert into sysadm.contract_data_exchange (co_id, version, valid_from_date, exchange_format_id, exchange_format_rls_id, return_format_id, return_format_rls_id, empty_file_support_flag, separate_air_land_flag, file_receive_hours, file_return_hours, file_resubmit_hours, currency_id, convratetype_id, pegged_xchng_ind, include_tax_flag, charge_term_sms_flag, jurisdiction_origin_type_ind, tax_calculation_type, last_mod_date, last_mod_user)
                    values (v_co_id, 1,  to_date('01/01/1998 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 16, 11, 23, 1, 'X', 'X', 720, 720, 720, 176, 1, 'P', 'X', 'X', 'C', 'N',  to_date('01/01/1998 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 'SYSADM');

                    v_action := 'Create TAP-OUT Contract - Error inserrindo CONTRACT_DATA_EXCHANGE_RECTYPE 1: ';
                    insert into sysadm.contract_data_exchange_rectype (co_id, version, tap_record_type_id) values (v_co_id, 1, 1);
                    v_action := 'Create TAP-OUT Contract - Error inserrindo CONTRACT_DATA_EXCHANGE_RECTYPE 2: ';
                    insert into sysadm.contract_data_exchange_rectype (co_id, version, tap_record_type_id) values (v_co_id, 1, 2);
                    v_action := 'Create TAP-OUT Contract - Error inserrindo CONTRACT_DATA_EXCHANGE_RECTYPE 3: ';
                    insert into sysadm.contract_data_exchange_rectype (co_id, version, tap_record_type_id) values (v_co_id, 1, 3);
                    v_action := 'Create TAP-OUT Contract - Error inserrindo CONTRACT_DATA_EXCHANGE_RECTYPE 4: ';
                    insert into sysadm.contract_data_exchange_rectype (co_id, version, tap_record_type_id) values (v_co_id, 1, 4);
                    v_action := 'Create TAP-OUT Contract - Error inserrindo CONTRACT_DATA_EXCHANGE_RECTYPE 5: ';
                    insert into sysadm.contract_data_exchange_rectype (co_id, version, tap_record_type_id) values (v_co_id, 1, 5);
                    v_action := 'Create TAP-OUT Contract - Error inserrindo CONTRACT_DATA_EXCHANGE_RECTYPE 6: ';
                    insert into sysadm.contract_data_exchange_rectype (co_id, version, tap_record_type_id) values (v_co_id, 1, 6);
                    dbms_output.put_line('--- TAP-OUT contract for operator '||v_network(i).v_plnetid||' was created ---');
                    utl_file.put_line(arquivo_saida, '--- TAP-OUT contract for operator '||v_network(i).v_plnetid||' was created ---');
                exception when others then
                    raise;
                end;
            else
                dbms_output.put_line('--- TAP-OUT contract for operator '||v_network(i).v_plnetid||' already exist ---');
                utl_file.put_line(arquivo_saida, '--- TAP-OUT contract for operator '||v_network(i).v_plnetid||' already exist ---');
            end if;

            v_action := 'Get SPCODE TAPIN - Error Getting SPCODE: ';
            select spcode into v_spcogr from sysadm.mpusptab where des like '%TAPIN%'||v_network(i).v_grupo||'%';

            select count(1) into v_count from sysadm.contract_all
            where plcode = 1004
            and tmcode = (select tmcode from sysadm.rateplan where shdes = '3TI01')
            and remote_plcode = v_plcode;

            if v_count = 0 then
                begin
                    -- Create TAP-IN Contract
                    sysadm.nextfree.getvalue('MAX_CONTRACT_ID', v_co_id);
                    sysadm.nextfree.getstringvalue('MAX_CO_CODE',sysdate,v_cocode);
                    select sysadm.max_transaction_id_seq.nextval into v_trans from dual;
                    select tmcode into v_tmcode from sysadm.rateplan where shdes = '3TI01';

                    dbms_output.put_line('--- Creating TAP-IN contract for operator '||v_network(i).v_plnetid||' ---');
                    utl_file.put_line(arquivo_saida, '--- Creating TAP-IN contract for operator '||v_network(i).v_plnetid||' ---');
                    v_action := 'Create TAP-IN Contract - Error inserting CONTRACT_ALL: ';
                    insert into sysadm.contract_all (co_id, customer_id, type, plcode, sccode, subm_id, co_signed, co_installed, co_archive, co_activated, co_entdate, co_moddate, co_userlastmod, tmcode, tmcode_date, currency, rec_version, co_code, business_unit_id, agreement_type, remote_plcode, home_party_id, contract_type_id, cds_bill_medium, cds_generation, ch_status, ch_status_validfrom)
                    values (v_co_id, v_customer_id, 'A', 1004, 1, 24, to_date('01/01/1998 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), to_date('01/01/1998 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 'X', to_date('01/01/1998 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), to_date('01/01/1998 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), to_date('01/01/1998 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 'SYSADM', v_tmcode, to_date('01/01/1998 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 176, 1, v_cocode, 2, 'RA', v_plcode, 1, 4, 5, 'R', 'a', to_date('01/01/1998 00:00:00', 'MM/DD/YYYY HH24:MI:SS'));

                    v_action := 'Create TAP-IN Contract - Error inserting CONTRACT_HISTORY 1: ';
                    insert into sysadm.contract_history (co_id, ch_seqno, ch_status, ch_reason, ch_validfrom, entdate, userlastmod, rec_version)
                    values (v_co_id, 1, 'o', 6, to_date('01/01/1998 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), to_date('01/01/1998 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 'SYSADM', 1);

                    v_action := 'Create TAP-IN Contract - Error inserting CONTRACT_HISTORY 2: ';
                    insert into sysadm.contract_history (co_id, ch_seqno, ch_status, ch_reason, ch_validfrom, entdate, userlastmod, request, rec_version)
                    values (v_co_id, 2, 'a', 1, to_date('01/01/1998 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), to_date('01/01/1998 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 'SYSADM', v_request, 2);

                    v_action := 'Create TAP-IN Contract - Error inserting RATEPLAN_HIST: ';
                    insert into sysadm.rateplan_hist (co_id, seqno, tmcode, tmcode_date, userlastmod, rec_version, request_id, transactionno)
                    values (v_co_id, 1, v_tmcode, to_date('01/01/1998 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 'SYSADM', 1, v_request, v_trans);

                    v_action := 'Create TAP-IN Contract - Error inserting CONTRACT_CARRY_OVER_HIST: ';
                    insert into sysadm.contract_carry_over_hist (co_id, seq_no, carry_over_contr_ind, valid_from)
                    values (v_co_id, 1, 'N', to_date('01/01/1998 00:00:00', 'MM/DD/YYYY HH24:MI:SS'));

                    v_action := 'Create TAP-IN Contract - Error inserting CONTR_TARIFF_OPTIONS: ';
                    insert into sysadm.contr_tariff_options (co_id, seqno, valid_from, rec_version, prerated_tap_rp_ind, non_expl_serv_paymenttype, request_id, entry_user, entry_date)
                    values (v_co_id, 1, to_date('01/01/1998 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 1, 'N', 'O', v_request, 'SYSADM', to_date('01/01/1998 00:00:00', 'MM/DD/YYYY HH24:MI:SS'));

                    for rec in (select distinct sncode from sysadm.mpulktmb where tmcode = v_tmcode) loop
                        v_action := 'Create TAP-IN Contract - Error inserting CONTRACT_SERVICE sncode '||rec.sncode||': ';
                        insert into sysadm.contract_service (co_id, sncode) values (v_co_id, rec.sncode);

                        select sysadm.pr_serv_spcode_histno_seq.nextval into v_sphist from dual;
                        select sysadm.pr_serv_status_histno_seq.nextval into v_sthist from dual;

                        v_action := 'Create TAP-IN Contract - Error inserting PROFILE_SERVICE sncode '||rec.sncode||': ';
                        insert into sysadm.profile_service (profile_id, co_id, sncode, spcode_histno, status_histno, entry_date, sn_class, ovw_acc_prd,currency, ovw_adv_charge, adv_charge_prd, rec_version)
                        values(0, v_co_id, rec.sncode, v_sphist, v_sthist, to_date('01/01/1998 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), rec.sncode, 0, 176, 'N', 0, 1);

                        v_action := 'Create TAP-IN Contract - Error inserting PR_SERV_STATUS_HIST 1 sncode '||rec.sncode||': ';
                        insert into sysadm.pr_serv_status_hist (profile_id, co_id, sncode, histno, status, reason, transactionno, valid_from_date, entry_date, rec_version, entry_user)
                        values(0, v_co_id, rec.sncode, v_sthist, 'O', 1, v_trans, to_date('01/01/1998 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), to_date('01/01/1998 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 0, 'SYSADM');

                        select sysadm.pr_serv_status_histno_seq.nextval into v_sthist from dual;
                        v_action := 'Create TAP-IN Contract - Error inserting PR_SERV_STATUS_HIST 2 sncode '||rec.sncode||': ';
                        insert into sysadm.pr_serv_status_hist (profile_id, co_id, sncode, histno, status, reason, transactionno, valid_from_date, entry_date, rec_version, rs_id, entry_user)
                        values(0, v_co_id, rec.sncode, v_sthist, 'A', 0, v_trans, to_date('01/01/1998 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), to_date('01/01/1998 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 0, 315, 'SYSADM');

                        if rec.sncode in (2016,2124,2143) then
                            v_action := 'Create TAP-IN Contract - Error inserting PR_SERV_SPCODE_HIST sncode '||rec.sncode||': ';
                            insert into sysadm.pr_serv_spcode_hist values(0,v_co_id,rec.sncode,v_sphist,v_spcogr,v_trans,to_date('01/01/1998 00:00:00', 'MM/DD/YYYY HH24:MI:SS'),to_date('01/01/1998 00:00:00', 'MM/DD/YYYY HH24:MI:SS'),null,1,'SYSADM');
                        else
                            v_action := 'Create TAP-IN Contract - Error inserting PR_SERV_SPCODE_HIST sncode '||rec.sncode||': ';
                            insert into sysadm.pr_serv_spcode_hist values(0,v_co_id,rec.sncode,v_sphist,v_spcode,v_trans,to_date('01/01/1998 00:00:00', 'MM/DD/YYYY HH24:MI:SS'),to_date('01/01/1998 00:00:00', 'MM/DD/YYYY HH24:MI:SS'),null,1,'SYSADM');
                        end if;

                        v_action := 'Create TAP-IN Contract - Error updating PROFILE_SERVICE sncode '||rec.sncode||': ';
                        update sysadm.profile_service set spcode_histno = v_sphist, status_histno = v_sthist
                        where profile_id = 0 and co_id = v_co_id and sncode =rec.sncode;
                    end loop;

                    v_action := 'Create TAP-IN Contract - Error inserrindo BILLING_ACCOUNT_ASSIGNMENT: ';
                    insert into sysadm.billing_account_assignment (billing_account_id, contract_id, seqno, valid_from)
                    values (v_billing_acc_id, v_co_id, 0, to_date('01/01/1998 00:00:00', 'MM/DD/YYYY HH24:MI:SS'));

                    v_action := 'Create TAP-IN Contract - Error inserrindo CONTRACT_DATA_EXCHANGE: ';
                    insert into sysadm. contract_data_exchange (co_id, version, valid_from_date, exchange_format_id, exchange_format_rls_id, return_format_id, return_format_rls_id, empty_file_support_flag, separate_air_land_flag, file_receive_hours, file_return_hours, file_resubmit_hours, currency_id, convratetype_id, pegged_xchng_ind, include_tax_flag, charge_term_sms_flag, jurisdiction_origin_type_ind, tax_calculation_type, last_mod_date, last_mod_user)
                    values (v_co_id, 1,  to_date('01/01/1998 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 16, 11, 23, 1, 'X', 'X', 720, 720, 720, 25, 1, 'P', 'X', 'X', 'C', 'N',  to_date('01/01/1998 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 'SYSADM');

                    v_action := 'Create TAP-IN Contract - Error inserrindo CONTRACT_DATA_EXCHANGE_RECTYPE 1: ';
                    insert into sysadm.contract_data_exchange_rectype (co_id, version, tap_record_type_id) values (v_co_id, 1, 1);
                    v_action := 'Create TAP-IN Contract - Error inserrindo CONTRACT_DATA_EXCHANGE_RECTYPE 2: ';
                    insert into sysadm.contract_data_exchange_rectype (co_id, version, tap_record_type_id) values (v_co_id, 1, 2);
                    v_action := 'Create TAP-IN Contract - Error inserrindo CONTRACT_DATA_EXCHANGE_RECTYPE 3: ';
                    insert into sysadm.contract_data_exchange_rectype (co_id, version, tap_record_type_id) values (v_co_id, 1, 3);
                    v_action := 'Create TAP-IN Contract - Error inserrindo CONTRACT_DATA_EXCHANGE_RECTYPE 4: ';
                    insert into sysadm.contract_data_exchange_rectype (co_id, version, tap_record_type_id) values (v_co_id, 1, 4);
                    v_action := 'Create TAP-IN Contract - Error inserrindo CONTRACT_DATA_EXCHANGE_RECTYPE 5: ';
                    insert into sysadm.contract_data_exchange_rectype (co_id, version, tap_record_type_id) values (v_co_id, 1, 5);
                    v_action := 'Create TAP-IN Contract - Error inserrindo CONTRACT_DATA_EXCHANGE_RECTYPE 6: ';
                    insert into sysadm.contract_data_exchange_rectype (co_id, version, tap_record_type_id) values (v_co_id, 1, 6);
                    dbms_output.put_line('--- TAP-IN contract for operator '||v_network(i).v_plnetid||' was created ---');
                    utl_file.put_line(arquivo_saida, '--- TAP-IN contract for operator '||v_network(i).v_plnetid||' was created ---');
                exception when others then
                    raise;
                end;

            else
                dbms_output.put_line('--- TAP-IN contract for operator '||v_network(i).v_plnetid||' already exist ---');
                utl_file.put_line(arquivo_saida, '--- TAP-IN contract for operator '||v_network(i).v_plnetid||' already exist ---');
            end if;
        else
            if v_check = 'Y' then
                -- Update TAP-IN Contract
                select count(1) into v_count from sysadm.contract_all
                where plcode = 1004
                and tmcode = (select tmcode from sysadm.rateplan where shdes = '3TI01')
                and remote_plcode = v_plcode;

                if v_count > 0 then
                    v_action := 'Get SPCODE TAPIN - Error Getting SPCODE: ';
                    select spcode into v_spcogr from sysadm.mpusptab where des like '%TAPIN%'||v_network(i).v_grupo||'%';

                    dbms_output.put_line('--- Updating TAP-IN Contract for '||v_network(i).v_plnetid||' ---');
                    utl_file.put_line(arquivo_saida, '--- Updating TAP-IN Contract for '||v_network(i).v_plnetid||' ---');
                    v_action := 'Update TAP-IN Contract - Error updating PR_SERV_SPCODE_HIST: ';
                    update sysadm.pr_serv_spcode_hist
                    set spcode = v_spcogr
                    where co_id in (select co_id from sysadm.contract_all where plcode = 1004
                                    and tmcode = (select tmcode from sysadm.rateplan where shdes = '3TI01')
                                    and remote_plcode = v_plcode)
                    and sncode in (2016,2124,2143);

                    dbms_output.put_line('--- TAP-IN Contract for '||v_network(i).v_plnetid||' was updated ---');
                    utl_file.put_line(arquivo_saida, '--- TAP-IN Contract for '||v_network(i).v_plnetid||' was updated ---');

                end if;

                -- Update TAP-OUT Contract
                select count(1) into v_count from sysadm.contract_all
                where plcode = 1004
                and tmcode = (select tmcode from sysadm.rateplan where shdes = '3TO01')
                and remote_plcode = v_plcode;

                if v_count > 0 then
                    v_action := 'Get SPCODE TAPOUT - Error Getting SPCODE: ';
                    if v_network(i).v_grupo_out is not null then
                        select spcode into v_spcogr from sysadm.mpusptab where des like '%TAP-OUT%'||v_network(i).v_grupo_out||'%';
                    else
                        select spcode into v_spcogr from sysadm.mpusptab where shdes = '3GTAP';
                    end if;

                    dbms_output.put_line('--- Updating TAP-OUT Contract for '||v_network(i).v_plnetid||' ---');
                    utl_file.put_line(arquivo_saida, '--- Updating TAP-OUT Contract for '||v_network(i).v_plnetid||' ---');
                    v_action := 'Update TAP-OUT Contract - Error updating PR_SERV_SPCODE_HIST: ';
                    update sysadm.pr_serv_spcode_hist
                    set spcode = v_spcogr
                    where co_id in (select co_id from sysadm.contract_all where plcode = 1004
                                    and tmcode = (select tmcode from sysadm.rateplan where shdes = '3TO01')
                                    and remote_plcode = v_plcode)
                    and sncode in (2016,2124,2143);

                    dbms_output.put_line('--- TAP-OUT Contract for '||v_network(i).v_plnetid||' was updated ---');
                    utl_file.put_line(arquivo_saida, '--- TAP-OUT Contract for '||v_network(i).v_plnetid||' was updated ---');

                end if;

                -- Remove condition in TAPIN Complex Condition
                dbms_output.put_line('--- Remove condition in Complex Cond for operator '||v_network(i).v_plnetid||' ---');
                utl_file.put_line(arquivo_saida, '--- Remove condition in TAPIN Complex Cond for operator '||v_network(i).v_plnetid||' ---');
                v_action := 'Remove condition - Error deleting UDC_REFERENCE_VALUE: ';
                delete sysadm.udc_reference_value
                where ref_value_id in (select rf.ref_value_id
                                    from sysadm.udc_complex_cond cc, sysadm.udc_chain ch,
                                    sysadm.udc_simple_cond sc, sysadm.udc_reference_value rf
                                    where cc.complex_cond_id = ch.complex_cond_id
                                    and ch.chain_id = sc.chain_id
                                    and sc.simple_cond_id = rf.simple_cond_id
                                    and sc.uds_member_code = 15
                                    and sc.uds_element_code = 14
                                    and cc.short_des like '%TAPIN%Grupo%'
                                    and rf.ref_integer = v_plcode);

                dbms_output.put_line('--- Condition in TAPIN Complex Cond for operator '||v_network(i).v_plnetid||' was removed ---');
                utl_file.put_line(arquivo_saida, '--- Condition in TAPIN Complex Cond for operator '||v_network(i).v_plnetid||' was removed ---');

                -- Add condition in Complex TAPIN Condition
                dbms_output.put_line('--- Add condition in TAPIN Complex Cond for operator '||v_network(i).v_plnetid||' ---');
                utl_file.put_line(arquivo_saida, '--- Add condition in TAPIN Complex Cond for operator '||v_network(i).v_plnetid||' ---');
                for rec in (select sc.simple_cond_id from sysadm.udc_complex_cond cc, sysadm.udc_chain ch, sysadm.udc_simple_cond sc
                where cc.complex_cond_id = ch.complex_cond_id
                and ch.chain_id = sc.chain_id
                and sc.uds_member_code = 15
                and sc.uds_element_code = 14
                and cc.short_des like '%TAPIN%'||v_network(i).v_grupo||'%') loop
                    select count(1) into v_count from sysadm.udc_reference_value where simple_cond_id = rec.simple_cond_id and ref_integer = v_plcode;

                    if v_count = 0 then
                        begin
                            sysadm.nextfree.getvalue ('MAX_REF_VALUE_ID', v_refvalue);
                            v_action := 'Add condition in TAPIN Complex Condition - Error inserting UDC_REFERENCE_VALUE: ';

                            insert into sysadm.udc_reference_value values(v_refvalue, rec.simple_cond_id, v_plcode, null, null, null, null);
                            dbms_output.put_line('--- Condition in TAPIN Complex Cond for operator '||v_network(i).v_plnetid||' was inserted ---');
                            utl_file.put_line(arquivo_saida, '--- Condition in TAPIN Complex Cond for operator '||v_network(i).v_plnetid||' was inserted ---');
                        exception when others then
                            raise;
                        end;
                    else
                        dbms_output.put_line('--- Condition in TAPIN Complex Cond for operator '||v_network(i).v_plnetid||' already exist ---');
                        utl_file.put_line(arquivo_saida, '--- Condition in TAPIN Complex Cond for operator '||v_network(i).v_plnetid||' already exist ---');
                    end if;
                end loop;

                -- Remove condition in TAPOUT Complex Condition
                dbms_output.put_line('--- Remove condition in TAPOUT Complex Cond for operator '||v_network(i).v_plnetid||' ---');
                utl_file.put_line(arquivo_saida, '--- Remove condition in TAPOUT Complex Cond for operator '||v_network(i).v_plnetid||' ---');
                v_action := 'Remove condition - Error deleting UDC_REFERENCE_VALUE: ';
                delete sysadm.udc_reference_value
                where ref_value_id in (select rf.ref_value_id
                                    from sysadm.udc_complex_cond cc, sysadm.udc_chain ch,
                                    sysadm.udc_simple_cond sc, sysadm.udc_reference_value rf
                                    where cc.complex_cond_id = ch.complex_cond_id
                                    and ch.chain_id = sc.chain_id
                                    and sc.simple_cond_id = rf.simple_cond_id
                                    and sc.uds_member_code = 15
                                    and sc.uds_element_code = 14
                                    and cc.short_des like '%OUT%Grupo%'
                                    and rf.ref_integer = v_plcode);

                dbms_output.put_line('--- Condition in TAPOUT Complex Cond for operator '||v_network(i).v_plnetid||' was removed ---');
                utl_file.put_line(arquivo_saida, '--- Condition in TAPOUT Complex Cond for operator '||v_network(i).v_plnetid||' was removed ---');

                -- Add condition in TAPOUT Complex Condition
                dbms_output.put_line('--- Add condition in TAPOUT Complex Cond for operator '||v_network(i).v_plnetid||' ---');
                utl_file.put_line(arquivo_saida, '--- Add condition in TAPOUT Complex Cond for operator '||v_network(i).v_plnetid||' ---');
                for rec in (select sc.simple_cond_id from sysadm.udc_complex_cond cc, sysadm.udc_chain ch, sysadm.udc_simple_cond sc
                where cc.complex_cond_id = ch.complex_cond_id
                and ch.chain_id = sc.chain_id
                and sc.uds_member_code = 15
                and sc.uds_element_code = 14
                and cc.short_des like '%OUT%'||nvl(v_network(i).v_grupo_out,'-----')||'%') loop
                    select count(1) into v_count from sysadm.udc_reference_value where simple_cond_id = rec.simple_cond_id and ref_integer = v_plcode;

                    if v_count = 0 then
                        begin
                            sysadm.nextfree.getvalue ('MAX_REF_VALUE_ID', v_refvalue);
                            v_action := 'Add condition in TAPOUT Complex Condition - Error inserting UDC_REFERENCE_VALUE: ';

                            insert into sysadm.udc_reference_value values(v_refvalue, rec.simple_cond_id, v_plcode, null, null, null, null);
                            dbms_output.put_line('--- Condition in TAPOUT Complex Cond for operator '||v_network(i).v_plnetid||' was inserted ---');
                            utl_file.put_line(arquivo_saida, '--- Condition in TAPOUT Complex Cond for operator '||v_network(i).v_plnetid||' was inserted ---');
                        exception when others then
                            raise;
                        end;
                    else
                        dbms_output.put_line('--- Condition in TAPOUT Complex Cond for operator '||v_network(i).v_plnetid||' already exist ---');
                        utl_file.put_line(arquivo_saida, '--- Condition in TAPOUT Complex Cond for operator '||v_network(i).v_plnetid||' already exist ---');
                    end if;
                end loop;
            end if;
        end if;

        dbms_output.put_line('##### End operator '||v_network(i).v_plnetid||' #####');
        utl_file.put_line(arquivo_saida, '##### End operator '||v_network(i).v_plnetid||' #####');
    end loop;

    utl_file.fclose(arquivo_saida);
    commit;
exception
    when OTHERS then
        v_error:= v_action||SQLERRM(SQLCODE);
        dbms_output.put_line(v_error);
        utl_file.put_line(arquivo_saida, v_error);
        utl_file.fclose(arquivo_saida);
        rollback;
end;
/
