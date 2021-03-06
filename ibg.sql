03:30:08 PNXTL37.IT_PPNETO>select 'grant select on ' || owner || '.'|| view_name || ' to rIGB_select;'
03:30:10   2  from dba_views
03:30:10   3  where owner = 'IGB'
03:30:10   4  order by view_name
03:30:10   5  /

'GRANTSELECTON'||OWNER||'.'||VIEW_NAME||'TORIGB_SELECT;'
---------------------------------------------------------------------------------------------
grant select on IGB.GIM_GCX_AGENT_PLACE_CTS to rIGB_select;
grant select on IGB.GIM_GCX_AGENT_PLACE_DTS to rIGB_select;
grant select on IGB.GIM_GCX_CAMPGROUP_INFO_CTS to rIGB_select;
grant select on IGB.GIM_GCX_CAMPGROUP_INFO_DTS to rIGB_select;
grant select on IGB.GIM_GCX_CAMPLIST_INFO_CTS to rIGB_select;
grant select on IGB.GIM_GCX_CAMPLIST_INFO_DTS to rIGB_select;
grant select on IGB.GIM_GCX_ENDPOINT_PLACE_CTS to rIGB_select;
grant select on IGB.GIM_GCX_ENDPOINT_PLACE_DTS to rIGB_select;
grant select on IGB.GIM_GCX_FORMAT_FIELD_CTS to rIGB_select;
grant select on IGB.GIM_GCX_FORMAT_FIELD_DTS to rIGB_select;
grant select on IGB.GIM_GCX_GROUP_AGENT_CTS to rIGB_select;
grant select on IGB.GIM_GCX_GROUP_AGENT_DTS to rIGB_select;
grant select on IGB.GIM_GCX_GROUP_ENDPOINT_CTS to rIGB_select;
grant select on IGB.GIM_GCX_GROUP_ENDPOINT_DTS to rIGB_select;
grant select on IGB.GIM_GCX_GROUP_PLACE_CTS to rIGB_select;
grant select on IGB.GIM_GCX_GROUP_PLACE_DTS to rIGB_select;
grant select on IGB.GIM_GCX_GROUP_ROUTEDN_CTS to rIGB_select;
grant select on IGB.GIM_GCX_GROUP_ROUTEDN_DTS to rIGB_select;
grant select on IGB.GIM_GCX_LIST_TREATMENT_CTS to rIGB_select;
grant select on IGB.GIM_GCX_LIST_TREATMENT_DTS to rIGB_select;
grant select on IGB.GIM_GCX_LOGIN_INFO_CTS to rIGB_select;
grant select on IGB.GIM_GCX_LOGIN_INFO_DTS to rIGB_select;
grant select on IGB.GIM_GCX_SKILL_LEVEL_CTS to rIGB_select;
grant select on IGB.GIM_GCX_SKILL_LEVEL_DTS to rIGB_select;
grant select on IGB.GIM_GCX_SUBCODE_CTS to rIGB_select;
grant select on IGB.GIM_GCX_SUBCODE_DTS to rIGB_select;
grant select on IGB.GIM_GC_ACTION_CODE_CTS to rIGB_select;
grant select on IGB.GIM_GC_ACTION_CODE_LTS to rIGB_select;
grant select on IGB.GIM_GC_AGENT_CTS to rIGB_select;
grant select on IGB.GIM_GC_AGENT_LTS to rIGB_select;
grant select on IGB.GIM_GC_APPLICATION_CTS to rIGB_select;
grant select on IGB.GIM_GC_APPLICATION_LTS to rIGB_select;
grant select on IGB.GIM_GC_ATTR_VALUE_CTS to rIGB_select;
grant select on IGB.GIM_GC_ATTR_VALUE_LTS to rIGB_select;
grant select on IGB.GIM_GC_BUS_ATTRIBUTE_CTS to rIGB_select;
grant select on IGB.GIM_GC_BUS_ATTRIBUTE_LTS to rIGB_select;
grant select on IGB.GIM_GC_CALLING_LIST_CTS to rIGB_select;
grant select on IGB.GIM_GC_CALLING_LIST_LTS to rIGB_select;
grant select on IGB.GIM_GC_CAMPAIGN_CTS to rIGB_select;
grant select on IGB.GIM_GC_CAMPAIGN_LTS to rIGB_select;
grant select on IGB.GIM_GC_ENDPOINT_CTS to rIGB_select;
grant select on IGB.GIM_GC_ENDPOINT_LTS to rIGB_select;
grant select on IGB.GIM_GC_FIELD_CTS to rIGB_select;
grant select on IGB.GIM_GC_FIELD_LTS to rIGB_select;
grant select on IGB.GIM_GC_FILTER_CTS to rIGB_select;
grant select on IGB.GIM_GC_FILTER_LTS to rIGB_select;
grant select on IGB.GIM_GC_FOLDER_CTS to rIGB_select;
grant select on IGB.GIM_GC_FOLDER_LTS to rIGB_select;
grant select on IGB.GIM_GC_FORMAT_CTS to rIGB_select;
grant select on IGB.GIM_GC_FORMAT_LTS to rIGB_select;
grant select on IGB.GIM_GC_GROUP_CTS to rIGB_select;
grant select on IGB.GIM_GC_GROUP_LTS to rIGB_select;
grant select on IGB.GIM_GC_IVRPORT_CTS to rIGB_select;
grant select on IGB.GIM_GC_IVRPORT_LTS to rIGB_select;
grant select on IGB.GIM_GC_IVR_CTS to rIGB_select;
grant select on IGB.GIM_GC_IVR_LTS to rIGB_select;
grant select on IGB.GIM_GC_LOGIN_CTS to rIGB_select;
grant select on IGB.GIM_GC_LOGIN_LTS to rIGB_select;
grant select on IGB.GIM_GC_OBJ_TABLE_CTS to rIGB_select;
grant select on IGB.GIM_GC_OBJ_TABLE_LTS to rIGB_select;
grant select on IGB.GIM_GC_PLACE_CTS to rIGB_select;
grant select on IGB.GIM_GC_PLACE_LTS to rIGB_select;
grant select on IGB.GIM_GC_SCRIPT_CTS to rIGB_select;
grant select on IGB.GIM_GC_SCRIPT_LTS to rIGB_select;
grant select on IGB.GIM_GC_SKILL_CTS to rIGB_select;
grant select on IGB.GIM_GC_SKILL_LTS to rIGB_select;
grant select on IGB.GIM_GC_SWITCH_CTS to rIGB_select;
grant select on IGB.GIM_GC_SWITCH_LTS to rIGB_select;
grant select on IGB.GIM_GC_TABLE_ACCESS_CTS to rIGB_select;
grant select on IGB.GIM_GC_TABLE_ACCESS_LTS to rIGB_select;
grant select on IGB.GIM_GC_TENANT_CTS to rIGB_select;
grant select on IGB.GIM_GC_TENANT_LTS to rIGB_select;
grant select on IGB.GIM_GC_TIME_ZONE_CTS to rIGB_select;
grant select on IGB.GIM_GC_TIME_ZONE_LTS to rIGB_select;
grant select on IGB.GIM_GC_TREATMENT_CTS to rIGB_select;
grant select on IGB.GIM_GC_TREATMENT_LTS to rIGB_select;
grant select on IGB.GIM_GC_VOICE_PROMPT_CTS to rIGB_select;
grant select on IGB.GIM_GC_VOICE_PROMPT_LTS to rIGB_select;
grant select on IGB.GIM_GOX_CHAIN_CALL_TS to rIGB_select;
grant select on IGB.GIM_GO_CAMPAIGNHISTORY_ATS to rIGB_select;
grant select on IGB.GIM_GO_CAMPAIGN_CTS to rIGB_select;
grant select on IGB.GIM_GO_CAMPAIGN_LTS to rIGB_select;
grant select on IGB.GIM_GO_CHAINREC_HIST_TS to rIGB_select;
grant select on IGB.GIM_GO_CHAIN_TS to rIGB_select;
grant select on IGB.GIM_GO_FIELDHIST_TS to rIGB_select;
grant select on IGB.GIM_GO_METRICS_TS to rIGB_select;
grant select on IGB.GIM_GO_SEC_FIELDHIST_TS to rIGB_select;
grant select on IGB.GIM_GX_SESSION_ENDPOINT_TS to rIGB_select;
grant select on IGB.GIM_GX_SESSION_ENDPOINT_TTS to rIGB_select;
grant select on IGB.GIM_G_AGENT_STATE_HISTORY_TS to rIGB_select;
grant select on IGB.GIM_G_AGENT_STATE_RC_TS to rIGB_select;
grant select on IGB.GIM_G_AGENT_STATE_RC_TTS to rIGB_select;
grant select on IGB.GIM_G_CALL_STAT_LTS to rIGB_select;
grant select on IGB.GIM_G_CALL_TTS to rIGB_select;
grant select on IGB.GIM_G_CUSTOM_DATA_S_ATS to rIGB_select;
grant select on IGB.GIM_G_DND_HISTORY_TS to rIGB_select;
grant select on IGB.GIM_G_IR_HISTORY_ATS to rIGB_select;
grant select on IGB.GIM_G_IR_TTS to rIGB_select;
grant select on IGB.GIM_G_IS_LINK_HISTORY_ATS to rIGB_select;
grant select on IGB.GIM_G_IS_LINK_ITS to rIGB_select;
grant select on IGB.GIM_G_LOGIN_SESSION_TS to rIGB_select;
grant select on IGB.GIM_G_LOGIN_SESSION_TTS to rIGB_select;
grant select on IGB.GIM_G_PARTY_HISTORY_ATS to rIGB_select;
grant select on IGB.GIM_G_PARTY_TTS to rIGB_select;
grant select on IGB.GIM_G_ROUTE_RESULT_TTS to rIGB_select;
grant select on IGB.GIM_G_ROUTE_RES_VQ_HIST_ATS to rIGB_select;
grant select on IGB.GIM_G_SECURE_UD_HISTORY_TS to rIGB_select;
grant select on IGB.GIM_G_USERDATA_HISTORY_TS to rIGB_select;
grant select on IGB.GIM_G_VIRTUAL_QUEUE_TTS to rIGB_select;

109 rows selected.

03:30:20 PNXTL37.IT_PPNETO>spool off;
