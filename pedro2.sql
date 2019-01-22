04:11:17 E2NXTL03.IT_PNET3>select dbms_metadata.get_ddl('PACKAGE','FND_XDFDICTIONARY_PKG','APPS') from dual;

DBMS_METADATA.GET_DDL('PACKAGE','FND_XDFDICTIONARY_PKG','APPS')
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

  CREATE OR REPLACE PACKAGE "APPS"."FND_XDFDICTIONARY_PKG" AUTHID CURRENT_USER as
/* $Header: fndpxdts.pls 120.2 2007/12/03 13:12:31 vkhatri ship $ */


--
-- UploadTable (PUBLIC))
--   Public procedure for afdict.lct to call when uploading tables using
--   using afdict.lct. It calls InsertTable() when needed.
--
procedure UploadTable (
  x_application_short_name       in varchar2,
  x_table_name                   in varchar2,
  x_user_table_name              in varchar2,
  x_table_type                   in varchar2,
  x_description                  in varchar2,
  x_auto_size                    in varchar2,
  x_initial_extent               in varchar2,
  x_next_extent                  in varchar2,
  x_min_extents                  in varchar2,
  x_max_extents                  in varchar2,
  x_ini_trans                    in varchar2,
  x_max_trans                    in varchar2,
  x_pct_free                     in varchar2,
  x_pct_increase                 in varchar2,
  x_pct_used                     in varchar2,
  x_hosted_support_style         in varchar2,
  x_user_id                      in varchar2);


--
-- UploadColumn (PUBLIC))
--   Public procedure for afdict.lct to call when uploading columns using
--   using afdict.lct. It calls InsertColumn() when needed.
--

procedure UploadColumn (
  x_application_short_name       in varchar2,
  x_table_name                   in varchar2,
  x_column_name                  in varchar2,
  x_user_column_name             in varchar2,
  x_column_sequence              in varchar2,
  x_column_type                  in varchar2,
  x_width                        in varchar2,
  x_null_allowed_flag            in varchar2,
  x_description                  in varchar2,
  x_default_value                in varchar2,
  x_translate_flag               in varchar2,
  x_precision                    in varchar2,
  x_scale                        in varchar2,
  x_flexfield_usage_code         in varchar2,
  x_flexfield_application_id     in varchar2,
  x_flexfield_name               in varchar2,
  x_flex_value_set_app_id        in varchar2,
  x_flex_value_set_id            in varchar2,
  x_user_id                      in varchar2);


--
-- UploadHistColumn (PUBLIC))
--   Public procedure for afdict.lct to call when uploading hist columns using
--   using afdict.lct. It calls InsertHistColumn() when needed.
--

procedure UploadHistColumn (
  x_application_short_name       in varchar2,
  x_table_name                   in varchar2,
  x_column_name                  in varchar2,
  x_partition                    in varchar2,
  x_hsize                        in varchar2,
  x_user_id                      in varchar2);

--
-- UploadIndex (PUBLIC))
--   Public procedure for afdict.lct to call when uploading indexes using
--   using afdict.lct. It calls InsertIndex() when needed.
--
procedure UploadIndex (
  x_application_short_name       in varchar2,
  x_table_name                   in varchar2,
  x_index_name                   in varchar2,
  x_uniqueness                   in varchar2,
  x_auto_size                    in varchar2,
  x_description                  in varchar2,
  x_initial_extent               in varchar2,
  x_next_extent                  in varchar2,
  x_min_extents                  in varchar2,
  x_max_extents                  in varchar2,
  x_ini_trans                    in varchar2,
  x_max_trans                    in varchar2,
  x_pct_free                     in varchar2,
  x_pct_increase                 in varchar2,
  x_user_id                      in varchar2);

--
-- UploadIndexColumn (PUBLIC))
--   Public procedure for afdict.lct to call when uploading index columns using
--   using afdict.lct.
--
procedure UploadIndexColumn (
  x_application_short_name       in varchar2,
  x_table_name                   in varchar2,
  x_index_name                   in varchar2,
  x_index_column_name            in varchar2,
  x_index_column_sequence        in varchar2,
  x_user_id                      in varchar2);

--
-- UploadPrimaryKey (PUBLIC))
--   Public procedure for afdict.lct to call when uploading primary key using
--   using afdict.lct.  It calls InsertPrimary() when needed.
--
procedure UploadPrimaryKey (
  x_application_short_name       in varchar2,
  x_table_name                   in varchar2,
  x_primary_key_name             in varchar2,
  x_primary_key_type             in varchar2,
  x_audit_key_flag               in varchar2,
  x_description                  in varchar2,
  x_enabled_flag                 in varchar2,
  x_user_id                      in varchar2);

--
-- UploadPrimaryKeyColumn (PUBLIC))
--   Public procedure for afdict.lct to call when uploading primary key column
--   using afdict.lct.
--
procedure UploadPrimaryKeyColumn (
  x_application_short_name       in varchar2,
  x_table_name                   in varchar2,
  x_primary_key_name             in varchar2,
  x_primary_key_column_name      in varchar2,
  x_primary_key_column_sequence  in varchar2,
  x_user_id                      in varchar2);

--
-- UploadForeignKey (PUBLIC))
--   Public procedure for afdict.lct to call when uploading foreign key using
--   using afdict.lct.  It calls InsertForeign() when needed.
--
procedure UploadForeignKey (
  x_application_short_name       in varchar2,
  x_table_name                   in varchar2,
  x_foreign_key_name             in varchar2,
  x_primary_key_application_name in varchar2,
  x_primary_key_table_name       in varchar2,
  x_primary_key_name             in varchar2,
  x_description                  in varchar2,
  x_cascade_behavior             in varchar2,
  x_foreign_key_relation         in varchar2,
  x_condition                    in varchar2,
  x_enabled_flag                 in varchar2,
  x_user_id                      in varchar2);

--
-- UploadForeignKeyColumn (PUBLIC))
--   Public procedure for afdict.lct to call when uploading foreign key column
--   using afdict.lct.
--
procedure UploadForeignKeyColumn (
  x_application_short_name       in varchar2,
  x_table_name                   in varchar2,
  x_foreign_key_name             in varchar2,
  x_foreign_key_column_name      in varchar2,
  x_foreign_key_column_sequence  in varchar2,
  x_cascade_value                in varchar2,
  x_user_id                      in varchar2);

--
-- UploadSequence (PUBLIC))
--   Public procedure for afdict.lct to call when uploading sequence
--   using afdict.lct. It calls InsertSequence when needed.
--
procedure UploadSequence (
  x_application_short_name       in varchar2,
  x_sequence_name                in varchar2,
  x_start_value                  in varchar2,
  x_description                  in varchar2,
  x_increment_by                 in varchar2,
  x_min_value                    in varchar2,
  x_max_value                    in varchar2,
  x_cache_size                   in varchar2,
  x_cycle_flag                   in varchar2,
  x_order_flag                   in varchar2,
  x_user_id                      in varchar2);

--
-- UploadView (PUBLIC))
--   Public procedure for afdict.lct to call when uploading view
--   using afdict.lct. It calls InsertView when needed.
--
procedure UploadView (
  x_application_short_name       in varchar2,
  x_view_name                    in varchar2,
  x_text                         in varchar2,
  x_description                  in varchar2,
  x_user_id                      in varchar2);

--
-- UploadViewColumn (PUBLIC))
--   Public procedure for afdict.lct to call when uploading view column
--   using afdict.lct.
--
procedure UploadViewColumn (
  x_application_short_name       in varchar2,
  x_view_name                    in varchar2,
  x_view_column_name             in varchar2,
  x_view_column_sequence         in varchar2,
  x_user_id                      in varchar2);

--
-- ViewTextLength (PUBLIC)
--   Return the view text length.
--   This is a helper function as length() function can not be used
--   directly in sql but is ok to used on a variable in PL/SQL.
--
function ViewTextLength (
  x_application_id               in number,
  x_view_name                    in varchar2) return number;
pragma restrict_references(ViewTextLength, WNDS);

--
-- RemoveColumn (PUBLIC)
--   Remove column from FND_COLUMNS table.
--   Before removing this column, make sure that there is no index,
--   primary key or foreign key is using this column
--
procedure RemoveColumn(
  x_application_short_name       in varchar2,
  x_table_name                   in varchar2,
  x_column_name                  in varchar2);

--
-- RemoveIndex (PUBLIC)
--   Remove index from FND_INDEXES and FND_INDEX_COLUMNS table.
--
procedure RemoveIndex(
  x_application_short_name       in varchar2,
  x_table_name                   in varchar2,
  x_index_name                   in varchar2);

--
-- RemovePrimaryKey (PUBLIC)
--   Remove primary key from FND_PRIMARY_KEYS and FND_PRIMARY_KEY_COLUMNS table.
--   Before deleting primary key, make sure that there is no foreign key
--   pointing to this primary key
--
procedure RemovePrimaryKey(
  x_application_short_name       in varchar2,
  x_table_name                   in varchar2,
  x_primary_key_name             in varchar2);

--
-- RemoveForeignKey (PUBLIC)
--   Remove foreign key from FND_FOREIGN_KEYS and FND_FOREIGN_KEY_COLUMNS table.
--
procedure RemoveForeignKey(
  x_application_short_name       in varchar2,
  x_table_name                   in varchar2,
  x_foreign_key_name             in varchar2);

--
-- RemoveSequence (PUBLIC)
--   Remove sequence from FND_SEQUENCES table.
--
procedure RemoveSequence(
  x_application_short_name       in varchar2,
  x_sequence_name                in varchar2);

--
-- RemoveView (PUBLIC)
--   Remove view from FND_VIEWS and FND_VIEW_COLUMNS table.
--
procedure RemoveView(
  x_application_short_name       in varchar2,
  x_view_name                    in varchar2);

--
-- RemoveTable (PUBLIC)
--   Remove table from FND_TABLES and all its columns, indexes, primary
--   keys and foreign keys.
--
procedure RemoveTable(
  x_application_short_name       in varchar2,
  x_table_name                   in varchar2);

--
-- UploadTable (PUBLIC)) - Overloaded
--   Public procedure for afdict.lct to call when uploading tables using
--   using afdict.lct. It calls InsertTable() when needed.
--
procedure UploadTable (
  x_application_short_name       in varchar2,
  x_table_name                   in varchar2,
  x_user_table_name              in varchar2,
  x_table_type                   in varchar2,
  x_description                  in varchar2,
  x_auto_size                    in varchar2,
  x_initial_extent               in varchar2,
  x_next_extent                  in varchar2,
  x_min_extents                  in varchar2,
  x_max_extents                  in varchar2,
  x_ini_trans                    in varchar2,
  x_max_trans                    in varchar2,
  x_pct_free                     in varchar2,
  x_pct_increase                 in varchar2,
  x_pct_used                     in varchar2,
  x_hosted_support_style         in varchar2,
  x_user_id                      in varchar2,
  x_custom_mode 			   in varchar2,
  x_last_update_date 		   in varchar2);

--
-- UploadColumn (PUBLIC))- Overloaded
--   Public procedure for afdict.lct to call when uploading columns using
--   using afdict.lct. It calls InsertColumn() when needed.
--

procedure UploadColumn (
  x_application_short_name       in varchar2,
  x_table_name                   in varchar2,
  x_column_name                  in varchar2,
  x_user_column_name             in varchar2,
  x_column_sequence              in varchar2,
  x_column_type                  in varchar2,
  x_width                        in varchar2,
  x_null_allowed_flag            in varchar2,
  x_description                  in varchar2,
  x_default_value                in varchar2,
  x_translate_flag               in varchar2,
  x_precision                    in varchar2,
  x_scale                        in varchar2,
  x_flexfield_usage_code         in varchar2,
  x_flexfield_application_id     in varchar2,
  x_flexfield_name               in varchar2,
  x_flex_value_set_app_id        in varchar2,
  x_flex_value_set_id            in varchar2,
  x_user_id                      in varchar2,
  x_custom_mode 			   in varchar2,
  x_last_update_date 		   in varchar2);

--
-- UploadHistColumn (PUBLIC)) - Overloaded
--   Public procedure for afdict.lct to call when uploading hist columns using
--   using afdict.lct. It calls InsertHistColumn() when needed.
--

procedure UploadHistColumn (
  x_application_short_name       in varchar2,
  x_table_name                   in varchar2,
  x_column_name                  in varchar2,
  x_partition                    in varchar2,
  x_hsize                        in varchar2,
  x_user_id                      in varchar2,
  x_custom_mode 			   in varchar2,
  x_last_update_date 		   in varchar2);

--
-- Public procedure UploadHistColumn_MV () -
-- upload MVIEW metadata

procedure UploadHistColumn_MV (
  x_application_short_name       in varchar2,
  x_table_name                   in varchar2,
  x_column_name                  in varchar2,
  x_partition                    in varchar2,
  x_hsize                        in varchar2,
  x_user_id                      in varchar2,
  x_custom_mode 		  in varchar2,
  x_last_update_date 		   in varchar2,
  x_mview_owner                    in varchar2
) ;

--
-- UploadIndex (PUBLIC)) - Overloaded
--   Public procedure for afdict.lct to call when uploading indexes using
--   using afdict.lct. It calls InsertIndex() when needed.
--
procedure UploadIndex (
  x_application_short_name       in varchar2,
  x_table_name                   in varchar2,
  x_index_name                   in varchar2,
  x_uniqueness                   in varchar2,
  x_auto_size                    in varchar2,
  x_description                  in varchar2,
  x_initial_extent               in varchar2,
  x_next_extent                  in varchar2,
  x_min_extents                  in varchar2,
  x_max_extents                  in varchar2,
  x_ini_trans                    in varchar2,
  x_max_trans                    in varchar2,
  x_pct_free                     in varchar2,
  x_pct_increase                 in varchar2,
  x_user_id                      in varchar2,
  x_custom_mode 		 in varchar2,
  x_last_update_date 		 in varchar2,
  x_phase_mode                   in varchar2);

--
-- UploadIndexColumn (PUBLIC)) - Overloaded
--   Public procedure for afdict.lct to call when uploading index columns using
--   using afdict.lct.
--
procedure UploadIndexColumn (
  x_application_short_name       in varchar2,
  x_table_name                   in varchar2,
  x_index_name                   in varchar2,
  x_index_column_name            in varchar2,
  x_index_column_sequence        in varchar2,
  x_user_id                      in varchar2,
  x_custom_mode 			   in varchar2,
  x_last_update_date 		   in varchar2);

--
-- UploadPrimaryKey (PUBLIC)) - Overloaded
--   Public procedure for afdict.lct to call when uploading primary key using
--   using afdict.lct.  It calls InsertPrimary() when needed.
--
procedure UploadPrimaryKey (
  x_application_short_name       in varchar2,
  x_table_name                   in varchar2,
  x_primary_key_name             in varchar2,
  x_primary_key_type             in varchar2,
  x_audit_key_flag               in varchar2,
  x_description                  in varchar2,
  x_enabled_flag                 in varchar2,
  x_user_id                      in varchar2,
  x_custom_mode 			   in varchar2,
  x_last_update_date 		   in varchar2,
  x_phase_mode			 in varchar2,
  x_overwrite_PK		   in varchar2 DEFAULT 'N'
  );

--
-- UploadPrimaryKeyColumn (PUBLIC)) - Overloaded
--   Public procedure for afdict.lct to call when uploading primary key column
--   using afdict.lct.
--
procedure UploadPrimaryKeyColumn (
  x_application_short_name       in varchar2,
  x_table_name                   in varchar2,
  x_primary_key_name             in varchar2,
  x_primary_key_column_name      in varchar2,
  x_primary_key_column_sequence  in varchar2,
  x_user_id                      in varchar2,
  x_custom_mode 			   in varchar2,
  x_last_update_date 		   in varchar2);

--
-- UploadForeignKey (PUBLIC)) - Overloaded
--   Public procedure for afdict.lct to call when uploading foreign key using
--   using afdict.lct.  It calls InsertForeign() when needed.
--
procedure UploadForeignKey (
  x_application_short_name       in varchar2,
  x_table_name                   in varchar2,
  x_foreign_key_name             in varchar2,
  x_primary_key_application_name in varchar2,
  x_primary_key_table_name       in varchar2,
  x_primary_key_name             in varchar2,
  x_description                  in varchar2,
  x_cascade_behavior             in varchar2,
  x_foreign_key_relation         in varchar2,
  x_condition                    in varchar2,
  x_enabled_flag                 in varchar2,
  x_user_id                      in varchar2,
  x_custom_mode 			   in varchar2,
  x_last_update_date 		   in varchar2,
  x_phase_mode			 in varchar2);

--
-- UploadForeignKeyColumn (PUBLIC)) - Overloaded
--   Public procedure for afdict.lct to call when uploading foreign key column
--   using afdict.lct.
--
procedure UploadForeignKeyColumn (
  x_application_short_name       in varchar2,
  x_table_name                   in varchar2,
  x_foreign_key_name             in varchar2,
  x_foreign_key_column_name      in varchar2,
  x_foreign_key_column_sequence  in varchar2,
  x_cascade_value                in varchar2,
  x_user_id                      in varchar2,
  x_custom_mode 			   in varchar2,
  x_last_update_date 		   in varchar2);

--
-- UploadSequence (PUBLIC)) - Overloaded
--   Public procedure for afdict.lct to call when uploading sequence
--   using afdict.lct. It calls InsertSequence when needed.
--
procedure UploadSequence (
  x_application_short_name       in varchar2,
  x_sequence_name                in varchar2,
  x_start_value                  in varchar2,
  x_description                  in varchar2,
  x_increment_by                 in varchar2,
  x_min_value                    in varchar2,
  x_max_value                    in varchar2,
  x_cache_size                   in varchar2,
  x_cycle_flag                   in varchar2,
  x_order_flag                   in varchar2,
  x_user_id                      in varchar2,
  x_custom_mode 			   in varchar2,
  x_last_update_date 		   in varchar2);

--
-- UploadView (PUBLIC))- Overloaded
--   Public procedure for afdict.lct to call when uploading view
--   using afdict.lct. It calls InsertView when needed.
--
procedure UploadView (
  x_application_short_name       in varchar2,
  x_view_name                    in varchar2,
  x_text                         in varchar2,
  x_description                  in varchar2,
  x_user_id                      in varchar2,
  x_custom_mode 			   in varchar2,
  x_last_update_date 		   in varchar2,
  x_phase_mode			 in varchar2);

--
-- UploadViewColumn (PUBLIC))- Overloaded
--   Public procedure for afdict.lct to call when uploading view column
--   using afdict.lct.
--
procedure UploadViewColumn (
  x_application_short_name       in varchar2,
  x_view_name                    in varchar2,
  x_view_column_name             in varchar2,
  x_view_column_sequence         in varchar2,
  x_user_id                      in varchar2,
  x_custom_mode 			   in varchar2,
  x_last_update_date 		   in varchar2);

  --
-- OWNER_ID
--   Return the user_id of the OWNER attribute
-- IN
--   p_name - OWNER attribute value from FNDLOAD data file
-- RETURNS
--   user_id of owner to use in who columns
--
function OWNER_ID(
  p_name in varchar2)
return number;


--
-- UPLOAD_TEST
--   Test whether or not to over-write database row when uploading
--   data from FNDLOAD data file, based on owner attributes of both
--   database row and row in file being uploaded.
-- IN
--   p_file_id - OWNER_ID(<OWNER attribute from data file>)
--   p_file_lud - LAST_UPDATE_DATE attribute from data file
--   p_db_id - LAST_UPDATED_BY of db row
--   p_db_lud - LAST_UPDATE_DATE of db row
--   p_custom_mode - CUSTOM_MODE FNDLOAD parameter value
-- RETURNS
--   TRUE if safe to over-write.
--
function UPLOAD_TEST(
  p_file_id     in number,
  p_file_lud    in date,
  p_db_id       in number,
  p_db_lud      in date,
  p_custom_mode in varchar2)
return boolean;

procedure INSERT_ROW (
  X_ROWID in out  NOCOPY VARCHAR2,
  P_APPLICATION_ID in NUMBER,
  P_OBJECT_NAME in VARCHAR2,
  P_OBJECT_TYPE in VARCHAR2,
  P_TABLESPACE_TYPE in VARCHAR2,
  P_CUSTOM_TABLESPACE_TYPE in VARCHAR2,
  P_OBJECT_SOURCE   in  VARCHAR2,
  P_ORACLE_USERNAME  in VARCHAR2,
  P_CUSTOM_FLAG in VARCHAR2,
  P_CREATION_DATE in DATE,
  P_CREATED_BY in NUMBER,
  P_LAST_UPDATE_DATE in DATE,
  P_LAST_UPDATED_BY in NUMBER,
  P_LAST_UPDATE_LOGIN in NUMBER);

procedure LOCK_ROW (
  P_APPLICATION_ID in NUMBER,
  P_OBJECT_NAME in VARCHAR2,
  P_OBJECT_TYPE in VARCHAR2,
  P_TABLESPACE_TYPE in VARCHAR2);

procedure UPDATE_ROW (
  P_APPLICATION_ID in NUMBER,
  P_OBJECT_NAME in VARCHAR2,
  P_OBJECT_TYPE in VARCHAR2,
  P_TABLESPACE_TYPE in VARCHAR2,
  P_CUSTOM_TABLESPACE_TYPE in VARCHAR2,
  P_OBJECT_SOURCE   in  VARCHAR2,
  P_ORACLE_USERNAME  in VARCHAR2,
  P_CUSTOM_FLAG in VARCHAR2,
  P_LAST_UPDATE_DATE in DATE,
  P_LAST_UPDATED_BY in NUMBER,
  P_LAST_UPDATE_LOGIN in NUMBER);

procedure LOAD_ROW (
   P_APPLICATION_ID  in NUMBER,
   P_OBJECT_NAME     in VARCHAR2,
   P_OBJECT_TYPE      in VARCHAR2,
   P_TABLESPACE_TYPE  in VARCHAR2,
   P_CUSTOM_TABLESPACE_TYPE  in VARCHAR2,
   P_OBJECT_SOURCE    in VARCHAR2,
   P_ORACLE_USERNAME in VARCHAR2,
   P_CUSTOM_FLAG in VARCHAR2,
   P_LAST_UPDATED_BY  in VARCHAR2,
   P_CUSTOM_MODE      in VARCHAR2,
   P_LAST_UPDATE_DATE in VARCHAR2);

end Fnd_XdfDictionary_Pkg;

CREATE OR REPLACE PACKAGE BODY "APPS"."FND_XDFDICTIONARY_PKG" as
/* $Header: fndpxdtb.pls 120.6 2007/12/03 13:15:25 vkhatri ship $ */


--
-- MultipleDeveloperKeys (PRIVATE))
--   Check if there are more than one Developer key for this table
--
function MultipleDeveloperKeys (
  x_application_id               in number,
  x_table_id                     in number,
  x_primary_key_name             in varchar2) return boolean
is
  l_tmp  number;
begin
   select count(*)
   into   l_tmp
   from   FND_PRIMARY_KEYS
   where  APPLICATION_ID = x_application_id
   and    TABLE_ID       = x_table_id
   and    PRIMARY_KEY_NAME  <> upper(x_primary_key_name)
   and    PRIMARY_KEY_TYPE = 'D';

   if (l_tmp > 0) then
      return(TRUE);
   else
      return(FALSE);
   end if;
end MultipleDeveloperKeys;

--
-- ValidatePrimaryKey (PRIVATE))
--   Check if this primary key is already exist
--
procedure ValidatePrimaryKey (
  x_application_short_name       in varchar2,
  x_table_name                   in varchar2,
  x_primary_key_name             in varchar2,
  x_pk_application_id            in out nocopy number,
  x_pk_table_id                  in out nocopy number,
  x_pk_id                        in out nocopy number)
is
begin
   begin
     select P.APPLICATION_ID, P.TABLE_ID, P.PRIMARY_KEY_ID
     into   x_pk_application_id, x_pk_table_id, x_pk_id
     from   FND_PRIMARY_KEYS P,
            FND_TABLES T,
            FND_APPLICATION A
     where  A.APPLICATION_SHORT_NAME = x_application_short_name
     and    A.APPLICATION_ID = T.APPLICATION_ID
     and    T.TABLE_NAME = x_table_name
     and    T.TABLE_ID = P.TABLE_ID
     and    T.APPLICATION_ID = P.APPLICATION_ID
     and    P.PRIMARY_KEY_NAME  = upper(x_primary_key_name);
   exception
     when no_data_found then
       x_pk_id := -1;
   end;

end ValidatePrimaryKey;


--
-- ResolveConflictColumn (PRIVATE))
--   If there is a column has the same USER_COLUMN_NAME or COLUMN_SEQUENCE
--   bump it away by prepend '@' for USER_COLUMN_NAME and big number for
--   COLUMN_SEQUENCE.
--
procedure ResolveConflictColumn (
  x_application_id               in number,
  x_table_id                     in number,
  x_column_name                  in varchar2,
  x_user_column_name             in varchar2,
  x_column_sequence              in varchar2
) is
  maxseq number;
begin

  -- If there is no row updated, no exception will be raise.
  update FND_COLUMNS
  set USER_COLUMN_NAME = '@'||USER_COLUMN_NAME
  where APPLICATION_ID = x_application_id
  and 	TABLE_ID = x_table_id
  and   COLUMN_NAME <> x_column_name
  and   USER_COLUMN_NAME = x_user_column_name;

  select max(column_sequence)
  into maxseq
  from FND_COLUMNS
  where APPLICATION_ID = x_application_id
  and   TABLE_ID = x_table_id;

  update FND_COLUMNS
  set COLUMN_SEQUENCE = to_number('200001') + maxseq
  where APPLICATION_ID = x_application_id
  and 	TABLE_ID = x_table_id
  and   COLUMN_NAME <> x_column_name
  and   COLUMN_SEQUENCE = to_number(x_column_sequence);

end ResolveConflictColumn;

--
-- InsertTable (PRIVATE))
--   Add a new table into FND_TABLES. This is only called after checking
--   there is no such table exists in UploadTable().
--
procedure InsertTable (
  x_application_id               in number,
  x_table_name                   in varchar2,
  x_user_table_name              in varchar2,
  x_table_type                   in varchar2,
  x_description                  in varchar2,
  x_auto_size                    in varchar2,
  x_initial_extent               in varchar2,
  x_next_extent                  in varchar2,
  x_min_extents                  in varchar2,
  x_max_extents                  in varchar2,
  x_ini_trans                    in varchar2,
  x_max_trans                    in varchar2,
  x_pct_free                     in varchar2,
  x_pct_increase                 in varchar2,
  x_pct_used                     in varchar2,
  x_hosted_support_style         in varchar2,
  x_creation_date                in date,
  x_created_by                   in number,
  x_last_update_date             in date,
  x_last_updated_by              in number,
  x_last_update_login            in number
) is
begin
  insert into FND_TABLES (
    APPLICATION_ID,
    TABLE_ID,
    TABLE_NAME,
    USER_TABLE_NAME,
    TABLE_TYPE,
    DESCRIPTION,
    AUTO_SIZE,
    INITIAL_EXTENT,
    NEXT_EXTENT,
    MIN_EXTENTS,
    MAX_EXTENTS,
    INI_TRANS,
    MAX_TRANS,
    PCT_FREE,
    PCT_INCREASE,
    PCT_USED,
    HOSTED_SUPPORT_STYLE,
    LAST_UPDATED_BY,
    LAST_UPDATE_DATE,
    LAST_UPDATE_LOGIN,
    CREATION_DATE,
    CREATED_BY)
    values (
    x_application_id,
    FND_TABLES_S.NEXTVAL,
    x_table_name,
    x_user_table_name,
    x_table_type,
    x_description,
    x_auto_size,
    x_initial_extent,
    x_next_extent,
    x_min_extents,
    x_max_extents,
    x_ini_trans,
    x_max_trans,
    x_pct_free,
    x_pct_increase,
    x_pct_used,
    x_hosted_support_style,
    x_last_updated_by,
    x_last_update_date,
    x_last_update_login,
    x_last_update_date,
    x_last_updated_by);

end InsertTable;

--
-- InsertColumn (PRIVATE))
--   Add a new column into FND_COLUMNS. This is only called after checking
--   there is no such column exists in UploadColumn().
--
procedure InsertColumn (
  x_application_id               in number,
  x_table_id                     in number,
  x_column_name                  in varchar2,
  x_user_column_name             in varchar2,
  x_column_sequence              in varchar2,
  x_column_type                  in varchar2,
  x_width                        in varchar2,
  x_null_allowed_flag            in varchar2,
  x_description                  in varchar2,
  x_default_value                in varchar2,
  x_translate_flag               in varchar2,
  x_precision                    in varchar2,
  x_scale                        in varchar2,
  x_flexfield_usage_code         in varchar2,
  x_flexfield_application_id     in varchar2,
  x_flexfield_name               in varchar2,
  x_flex_value_set_app_id        in varchar2,
  x_flex_value_set_id            in varchar2,
  x_creation_date                in date,
  x_created_by                   in number,
  x_last_update_date             in date,
  x_last_updated_by              in number,
  x_last_update_login            in number
) is

begin

  insert into FND_COLUMNS (
      APPLICATION_ID,
      TABLE_ID,
      COLUMN_ID,
      COLUMN_NAME,
      USER_COLUMN_NAME,
      COLUMN_SEQUENCE,
      COLUMN_TYPE,
      WIDTH,
      NULL_ALLOWED_FLAG,
      DESCRIPTION,
      DEFAULT_VALUE,
      TRANSLATE_FLAG,
      PRECISION,
      SCALE,
      FLEXFIELD_USAGE_CODE,
      FLEXFIELD_APPLICATION_ID,
      FLEXFIELD_NAME,
      FLEX_VALUE_SET_APPLICATION_ID,
      FLEX_VALUE_SET_ID,
      CREATION_DATE,
      CREATED_BY,
      LAST_UPDATED_BY,
      LAST_UPDATE_DATE,
      LAST_UPDATE_LOGIN)
      values (
      x_application_id,
      x_table_id,
      FND_COLUMNS_S.NEXTVAL,
      x_column_name,
      x_user_column_name,
      x_column_sequence,
      x_column_type,
      x_width,
      x_null_allowed_flag,
      x_description,
      x_default_value,
      x_translate_flag,
      x_precision,
      x_scale,
      x_flexfield_usage_code,
      x_flexfield_application_id,
      x_flexfield_name,
      x_flex_value_set_app_id,
      x_flex_value_set_id,
      x_last_update_date,
      x_last_updated_by,
      x_last_updated_by,
      x_last_update_date,
      x_last_update_login);

end InsertColumn;

--
-- InsertIndex (PRIVATE))
--   Add a new index into FND_INDEXES. This is only called after checking
--   there is no such index exists in UploadIndex().
--
procedure InsertIndex (
  x_application_id               in number,
  x_table_id                     in number,
  x_index_name                   in varchar2,
  x_uniqueness                   in varchar2,
  x_auto_size                    in varchar2,
  x_description                  in varchar2,
  x_initial_extent               in varchar2,
  x_next_extent                  in varchar2,
  x_min_extents                  in varchar2,
  x_max_extents                  in varchar2,
  x_ini_trans                    in varchar2,
  x_max_trans                    in varchar2,
  x_pct_free                     in varchar2,
  x_pct_increase                 in varchar2,
  x_creation_date                in date,
  x_created_by                   in number,
  x_last_update_date             in date,
  x_last_updated_by              in number,
  x_last_update_login            in number

) is

begin

  insert into FND_INDEXES (
      APPLICATION_ID,
      TABLE_ID,
      INDEX_ID,
      INDEX_NAME,
      UNIQUENESS,
      AUTO_SIZE,
      DESCRIPTION,
      INITIAL_EXTENT,
      NEXT_EXTENT,
      MIN_EXTENTS,
      MAX_EXTENTS,
      INI_TRANS,
      MAX_TRANS,
      PCT_FREE,
      PCT_INCREASE,
      LAST_UPDATED_BY,
      LAST_UPDATE_DATE,
      LAST_UPDATE_LOGIN,
      CREATION_DATE,
      CREATED_BY)
      values (
      x_application_id,
      x_table_id,
      FND_INDEXES_S.NEXTVAL,
      x_index_name,
      x_uniqueness,
      x_auto_size,
      x_description,
      x_initial_extent,
      x_next_extent,
      x_min_extents,
      x_max_extents,
      x_ini_trans,
      x_max_trans,
      x_pct_free,
      x_pct_increase,
      x_last_updated_by,
      x_last_update_date,
      x_last_update_login,
      x_last_update_date,
      x_last_updated_by);
end InsertIndex;

--
-- InsertPrimaryKey (PRIVATE))
--   Add a new primary key into FND_PRIMARY_KEYS.
--   This is only called after checking
--   there is no such primary key exists in UploadPrimaryKey().
--
procedure InsertPrimaryKey(
  x_application_id               in number,
  x_table_id                     in number,
  x_primary_key_name             in varchar2,
  x_primary_key_type             in varchar2,
  x_audit_key_flag               in varchar2,
  x_enabled_flag                 in varchar2,
  x_description                  in varchar2,
  x_creation_date                in date,
  x_created_by                   in number,
  x_last_update_date             in date,
  x_last_updated_by              in number,
  x_last_update_login            in number
) is

begin

  insert into FND_PRIMARY_KEYS(
      APPLICATION_ID,
      TABLE_ID,
      PRIMARY_KEY_NAME,
      PRIMARY_KEY_ID,
      PRIMARY_KEY_TYPE,
      AUDIT_KEY_FLAG,
      ENABLED_FLAG,
      DESCRIPTION,
      LAST_UPDATED_BY,
      LAST_UPDATE_DATE,
      LAST_UPDATE_LOGIN,
      CREATION_DATE,
      CREATED_BY)
      values (
      x_application_id,
      x_table_id,
      x_primary_key_name,
      FND_PRIMARY_KEYS_S.NEXTVAL,
      x_primary_key_type,
      x_audit_key_flag,
      x_enabled_flag,
      x_description,
      x_last_updated_by,
      x_last_update_date,
      x_last_update_login,
      x_last_update_date,
      x_last_updated_by);
end InsertPrimaryKey;

--
-- InsertForeignKey (PRIVATE))
--   Add a new foreign key into FND_FOREIGN_KEYS.
--   This is only called after checking
--   there is no such foreign key exists in UploadForeignKey().
--
procedure InsertForeignKey(
  x_application_id               in number,
  x_table_id                     in number,
  x_foreign_key_name             in varchar2,
  x_primary_key_application_id   in number,
  x_primary_key_table_id         in number,
  x_primary_key_id               in number,
  x_description                  in varchar2,
  x_cascade_behavior             in varchar2,
  x_foreign_key_relation         in varchar2,
  x_condition                    in varchar2,
  x_enabled_flag                 in varchar2,
  x_creation_date                in date,
  x_created_by                   in number,
  x_last_update_date             in date,
  x_last_updated_by              in number,
  x_last_update_login            in number
) is

begin

  insert into FND_FOREIGN_KEYS(
      APPLICATION_ID,
      TABLE_ID,
      FOREIGN_KEY_ID,
      FOREIGN_KEY_NAME,
      PRIMARY_KEY_APPLICATION_ID,
      PRIMARY_KEY_TABLE_ID,
      PRIMARY_KEY_ID,
      DESCRIPTION,
      CASCADE_BEHAVIOR,
      FOREIGN_KEY_RELATION,
      CONDITION,
      ENABLED_FLAG,
      LAST_UPDATED_BY,
      LAST_UPDATE_DATE,
      LAST_UPDATE_LOGIN,
      CREATION_DATE,
      CREATED_BY)
      values (
      x_application_id,
      x_table_id,
      FND_FOREIGN_KEYS_S.NEXTVAL,
      x_foreign_key_name,
      x_primary_key_application_id,
      x_primary_key_table_id,
      x_primary_key_id,
      x_description,
      x_cascade_behavior,
      x_foreign_key_relation,
      x_condition,
      x_enabled_flag,
      x_last_updated_by,
      x_last_update_date,
      x_last_update_login,
      x_last_update_date,
      x_last_updated_by);
end InsertForeignKey;

--
-- InsertSequence (PRIVATE))
--   Add a new sequence into FND_SEQUENCES. This is only called after checking
--   there is no such sequence exists in UploadSequence().
--
procedure InsertSequence (
  x_application_id               in number,
  x_sequence_name                in varchar2,
  x_start_value                  in varchar2,
  x_description                  in varchar2,
  x_increment_by                 in varchar2,
  x_min_value                    in varchar2,
  x_max_value                    in varchar2,
  x_cache_size                   in varchar2,
  x_cycle_flag                   in varchar2,
  x_order_flag                   in varchar2,
  x_creation_date                in date,
  x_created_by                   in number,
  x_last_update_date             in date,
  x_last_updated_by              in number,
  x_last_update_login            in number
) is
begin
  insert into FND_SEQUENCES (
    APPLICATION_ID,
    SEQUENCE_ID,
    SEQUENCE_NAME,
    START_VALUE,
    DESCRIPTION,
    INCREMENT_BY,
    MIN_VALUE,
    MAX_VALUE,
    CACHE_SIZE,
    CYCLE_FLAG,
    ORDER_FLAG,
    LAST_UPDATED_BY,
    LAST_UPDATE_DATE,
    LAST_UPDATE_LOGIN,
    CREATION_DATE,
    CREATED_BY)
    values (
    x_application_id,
    FND_SEQUENCES_S.NEXTVAL,
    x_sequence_name,
    x_start_value,
    x_description,
    x_increment_by,
    x_min_value,
    x_max_value,
    x_cache_size,
    x_cycle_flag,
    x_order_flag,
    x_last_updated_by,
    x_last_update_date,
    x_last_update_login,
    x_last_update_date,
    x_last_updated_by);

end InsertSequence;

--
-- InsertView (PRIVATE))
--   Add a new view into FND_VIEWS. This is only called after checking
--   there is no such view key exists in UploadView().
--
procedure InsertView (
  x_application_id               in number,
  x_view_name                    in varchar2,
  x_text                         in varchar2,
  x_description                  in varchar2,
  x_creation_date                in date,
  x_created_by                   in number,
  x_last_update_date             in date,
  x_last_updated_by              in number,
  x_last_update_login            in number
) is
begin
  insert into FND_VIEWS (
    APPLICATION_ID,
    VIEW_ID,
    VIEW_NAME,
    TEXT,
    DESCRIPTION,
    LAST_UPDATED_BY,
    LAST_UPDATE_DATE,
    LAST_UPDATE_LOGIN,
    CREATION_DATE,
    CREATED_BY)
    values (
    x_application_id,
    FND_VIEWS_S.NEXTVAL,
    x_view_name,
    x_text,
    x_description,
    x_last_updated_by,
    x_last_update_date,
    x_last_update_login,
    x_last_update_date,
    x_last_updated_by);

end InsertView;

--
-- UploadTable (PUBLIC))
--   Public procedure for afdict.lct to call when uploading tables using
--   using afdict.lct. It calls InsertTable() when needed.
--
procedure UploadTable (
  x_application_short_name       in varchar2,
  x_table_name                   in varchar2,
  x_user_table_name              in varchar2,
  x_table_type                   in varchar2,
  x_description                  in varchar2,
  x_auto_size                    in varchar2,
  x_initial_extent               in varchar2,
  x_next_extent                  in varchar2,
  x_min_extents                  in varchar2,
  x_max_extents                  in varchar2,
  x_ini_trans                    in varchar2,
  x_max_trans                    in varchar2,
  x_pct_free                     in varchar2,
  x_pct_increase                 in varchar2,
  x_pct_used                     in varchar2,
  x_hosted_support_style         in varchar2,
  x_user_id                      in varchar2
) is
begin

UploadTable (
  x_application_short_name => x_application_short_name,
  x_table_name => 		x_table_name,
  x_user_table_name =>       	x_user_table_name,
  x_table_type => 		x_table_type,
  x_description =>		x_description,
  x_auto_size =>              x_auto_size,
  x_initial_extent=>   		x_initial_extent,
  x_next_extent =>            x_next_extent,
  x_min_extents =>            x_min_extents,
  x_max_extents =>            x_max_extents,
  x_ini_trans  =>             x_ini_trans,
  x_max_trans =>              x_max_trans,
  x_pct_free =>               x_pct_free,
  x_pct_increase =>           x_pct_increase,
  x_pct_used =>               x_pct_used,
  x_hosted_support_style =>   x_hosted_support_style,
  x_user_id =>                x_user_id,
  x_custom_mode =>		null,
  x_last_update_date =>		null);

end UploadTable;

--
-- UploadColumn (PUBLIC))
--   Public procedure for afdict.lct to call when uploading columns using
--   using afdict.lct. It calls InsertColumn() when needed.
--
procedure UploadColumn (
  x_application_short_name       in varchar2,
  x_table_name                   in varchar2,
  x_column_name                  in varchar2,
  x_user_column_name             in varchar2,
  x_column_sequence              in varchar2,
  x_column_type                  in varchar2,
  x_width                        in varchar2,
  x_null_allowed_flag            in varchar2,
  x_description                  in varchar2,
  x_default_value                in varchar2,
  x_translate_flag               in varchar2,
  x_precision                    in varchar2,
  x_scale                        in varchar2,
  x_flexfield_usage_code         in varchar2,
  x_flexfield_application_id     in varchar2,
  x_flexfield_name               in varchar2,
  x_flex_value_set_app_id        in varchar2,
  x_flex_value_set_id            in varchar2,
  x_user_id                      in varchar2
) is
begin

UploadColumn (
  x_application_short_name =>    x_application_short_name,
  x_table_name =>                x_table_name,
  x_column_name =>               x_column_name,
  x_user_column_name =>          x_user_column_name,
  x_column_sequence =>           x_column_sequence,
  x_column_type =>               x_column_type,
  x_width =>                     x_width,
  x_null_allowed_flag =>         x_null_allowed_flag,
  x_description =>               x_description,
  x_default_value =>             x_default_value,
  x_translate_flag =>            x_translate_flag,
  x_precision =>                 x_precision,
  x_scale =>                     x_scale,
  x_flexfield_usage_code =>      x_flexfield_usage_code,
  x_flexfield_application_id =>  x_flexfield_application_id,
  x_flexfield_name =>            x_flexfield_name,
  x_flex_value_set_app_id =>     x_flex_value_set_app_id,
  x_flex_value_set_id =>         x_flex_value_set_id,
  x_user_id =>                   x_user_id,
  x_custom_mode =>		   null,
  x_last_update_date =>		   null);

end UploadColumn;

--
-- UploadHistColumn (PUBLIC))
--   Public procedure for afdict.lct to call when uploading columns using
--   using afdict.lct. It calls InsertHistColumn() when needed.
--
procedure UploadHistColumn (
  x_application_short_name       in varchar2,
  x_table_name                   in varchar2,
  x_column_name                  in varchar2,
  x_partition                    in varchar2,
  x_hsize                        in varchar2,
  x_user_id                      in varchar2
) is
begin
UploadHistColumn (
  x_application_short_name => x_application_short_name,
  x_table_name =>       	x_table_name,
  x_column_name =>     		x_column_name,
  x_partition =>         	x_partition,
  x_hsize  =>        		x_hsize,
  x_user_id =>        		x_user_id,
  x_custom_mode =>    		null,
  x_last_update_date => 	null);
end UploadHistColumn;



--
-- UploadIndex (PUBLIC))
--   Public procedure for afdict.lct to call when uploading indexes using
--   using afdict.lct. It calls InsertIndex() when needed.
--
procedure UploadIndex (
  x_application_short_name       in varchar2,
  x_table_name                   in varchar2,
  x_index_name                   in varchar2,
  x_uniqueness                   in varchar2,
  x_auto_size                    in varchar2,
  x_description                  in varchar2,
  x_initial_extent               in varchar2,
  x_next_extent                  in varchar2,
  x_min_extents                  in varchar2,
  x_max_extents                  in varchar2,
  x_ini_trans                    in varchar2,
  x_max_trans                    in varchar2,
  x_pct_free                     in varchar2,
  x_pct_increase                 in varchar2,
  x_user_id                      in varchar2
) is
begin

UploadIndex (
  x_application_short_name =>	x_application_short_name,
  x_table_name => 		x_table_name,
  x_index_name =>		x_index_name,
  x_uniqueness =>   		x_uniqueness,
  x_auto_size =>  		x_auto_size,
  x_description =>		x_description,
  x_initial_extent => 		x_initial_extent,
  x_next_extent => 		x_next_extent,
  x_min_extents =>  		x_min_extents,
  x_max_extents => 		x_max_extents,
  x_ini_trans => 		x_ini_trans,
  x_max_trans =>		x_max_trans,
  x_pct_free =>			x_pct_free,
  x_pct_increase =>  		x_pct_increase,
  x_user_id  =>  		x_user_id,
  x_custom_mode => 		null,
  x_last_update_date => 	null,
  x_phase_mode =>		'BEGIN');


UploadIndex (
  x_application_short_name =>   x_application_short_name,
  x_table_name =>               x_table_name,
  x_index_name =>               x_index_name,
  x_uniqueness =>               x_uniqueness,
  x_auto_size =>                x_auto_size,
  x_description =>              x_description,
  x_initial_extent =>           x_initial_extent,
  x_next_extent =>              x_next_extent,
  x_min_extents =>              x_min_extents,
  x_max_extents =>              x_max_extents,
  x_ini_trans =>                x_ini_trans,
  x_max_trans =>                x_max_trans,
  x_pct_free =>                 x_pct_free,
  x_pct_increase =>             x_pct_increase,
  x_user_id  =>                 x_user_id,
  x_custom_mode =>              null,
  x_last_update_date =>         null,
  x_phase_mode =>               'END');

end UploadIndex;


--
-- UploadIndexColumn (PUBLIC))
--   Public procedure for afdict.lct to call when uploading index columns using
--   using afdict.lct.
--
procedure UploadIndexColumn (
  x_application_short_name       in varchar2,
  x_table_name                   in varchar2,
  x_index_name                   in varchar2,
  x_index_column_name            in varchar2,
  x_index_column_sequence        in varchar2,
  x_user_id                      in varchar2
) is
begin

UploadIndexColumn (
  x_application_short_name =>	x_application_short_name,
  x_table_name => 		x_table_name,
  x_index_name => 		x_index_name,
  x_index_column_name => 	x_index_column_name,
  x_index_column_sequence =>	x_index_column_sequence,
  x_user_id  => 			x_user_id,
  x_custom_mode => 		null,
  x_last_update_date => 	null);
end UploadIndexColumn;

--
-- UploadPrimaryKey (PUBLIC))
--   Public procedure for afdict.lct to call when uploading primary key using
--   using afdict.lct. It calls InsertPrimary() when needed.
--
procedure UploadPrimaryKey (
  x_application_short_name       in varchar2,
  x_table_name                   in varchar2,
  x_primary_key_name             in varchar2,
  x_primary_key_type             in varchar2,
  x_audit_key_flag               in varchar2,
  x_description                  in varchar2,
  x_enabled_flag                 in varchar2,
  x_user_id                      in varchar2
) is
begin

UploadPrimaryKey (
  x_application_short_name =>	x_application_short_name,
  x_table_name => 		x_table_name,
  x_primary_key_name => 	x_primary_key_name,
  x_primary_key_type =>		x_primary_key_type,
  x_audit_key_flag => 		x_audit_key_flag,
  x_description=> 		x_description,
  x_enabled_flag =>		x_enabled_flag,
  x_user_id =>			x_user_id,
  x_custom_mode => 		null,
  x_last_update_date => 	null,
  x_phase_mode =>		'BEGIN',
  x_overwrite_PK =>		'N');

UploadPrimaryKey (
  x_application_short_name =>   x_application_short_name,
  x_table_name =>               x_table_name,
  x_primary_key_name =>         x_primary_key_name,
  x_primary_key_type =>         x_primary_key_type,
  x_audit_key_flag =>           x_audit_key_flag,
  x_description=>               x_description,
  x_enabled_flag =>             x_enabled_flag,
  x_user_id =>                  x_user_id,
  x_custom_mode =>              null,
  x_last_update_date =>         null,
  x_phase_mode =>               'END',
  x_overwrite_PK =>		'N');

end UploadPrimaryKey;

--
-- UploadPrimaryKeyColumn (PUBLIC))
--   Public procedure for afdict.lct to call when uploading primary key column
--   using afdict.lct.
--
procedure UploadPrimaryKeyColumn (
  x_application_short_name       in varchar2,
  x_table_name                   in varchar2,
  x_primary_key_name             in varchar2,
  x_primary_key_column_name      in varchar2,
  x_primary_key_column_sequence  in varchar2,
  x_user_id                      in varchar2
) is
begin

UploadPrimaryKeyColumn (
  x_application_short_name =>	x_application_short_name,
  x_table_name => 		x_table_name,
  x_primary_key_name => 	x_primary_key_name,
  x_primary_key_column_name =>x_primary_key_column_name,
  x_primary_key_column_sequence =>x_primary_key_column_sequence,
  x_user_id  => 			x_user_id,
  x_custom_mode =>		null,
  x_last_update_date =>		null);

end UploadPrimaryKeyColumn;

--
-- UploadForeignKey (PUBLIC))
--   Public procedure for afdict.lct to call when uploading foreign key using
--   using afdict.lct.  It calls InsertForeign() when needed.
--
procedure UploadForeignKey (
  x_application_short_name       in varchar2,
  x_table_name                   in varchar2,
  x_foreign_key_name             in varchar2,
  x_primary_key_application_name in varchar2,
  x_primary_key_table_name       in varchar2,
  x_primary_key_name             in varchar2,
  x_description                  in varchar2,
  x_cascade_behavior             in varchar2,
  x_foreign_key_relation         in varchar2,
  x_condition                    in varchar2,
  x_enabled_flag                 in varchar2,
  x_user_id                      in varchar2
) is
begin

 UploadForeignKey (
  x_application_short_name =>	x_application_short_name,
  x_table_name  =>     		x_table_name,
  x_foreign_key_name =>     	x_foreign_key_name,
  x_primary_key_application_name => x_primary_key_application_name,
  x_primary_key_table_name =>   x_primary_key_table_name,
  x_primary_key_name =>        	x_primary_key_name,
  x_description =>       	x_description,
  x_cascade_behavior =>       	x_cascade_behavior,
  x_foreign_key_relation =>    	x_foreign_key_relation,
  x_condition =>     		x_condition,
  x_enabled_flag =>     	x_enabled_flag,
  x_user_id =>      		x_user_id,
  x_custom_mode =>              null,
  x_last_update_date =>         null,
  x_phase_mode =>		'BEGIN');

 UploadForeignKey (
  x_application_short_name =>   x_application_short_name,
  x_table_name  =>              x_table_name,
  x_foreign_key_name =>         x_foreign_key_name,
  x_primary_key_application_name => x_primary_key_application_name,
  x_primary_key_table_name =>   x_primary_key_table_name,
  x_primary_key_name =>         x_primary_key_name,
  x_description =>              x_description,
  x_cascade_behavior =>         x_cascade_behavior,
  x_foreign_key_relation =>     x_foreign_key_relation,
  x_condition =>                x_condition,
  x_enabled_flag =>             x_enabled_flag,
  x_user_id =>                  x_user_id,
  x_custom_mode =>              null,
  x_last_update_date =>         null,
  x_phase_mode =>               'END');


end UploadForeignKey;

--
-- UploadForeignKeyColumn (PUBLIC))
--   Public procedure for afdict.lct to call when uploading foreign key column
--   using afdict.lct.
--
procedure UploadForeignKeyColumn (
  x_application_short_name       in varchar2,
  x_table_name                   in varchar2,
  x_foreign_key_name             in varchar2,
  x_foreign_key_column_name      in varchar2,
  x_foreign_key_column_sequence  in varchar2,
  x_cascade_value                in varchar2,
  x_user_id                      in varchar2
) is
begin
 UploadForeignKeyColumn (
  x_application_short_name =>	x_application_short_name,
  x_table_name => 		x_table_name,
  x_foreign_key_name => 	x_foreign_key_name,
  x_foreign_key_column_name =>  x_foreign_key_column_name,
  x_foreign_key_column_sequence => x_foreign_key_column_sequence,
  x_cascade_value => 		x_cascade_value,
  x_user_id =>			x_user_id,
  x_custom_mode => 		null,
  x_last_update_date =>		null);

end UploadForeignKeyColumn;


--
-- UploadSequence (PUBLIC))
--   Public procedure for afdict.lct to call when uploading sequence
--   using afdict.lct. It calls InsertSequence when needed.
--
procedure UploadSequence (
  x_application_short_name       in varchar2,
  x_sequence_name                in varchar2,
  x_start_value                  in varchar2,
  x_description                  in varchar2,
  x_increment_by                 in varchar2,
  x_min_value                    in varchar2,
  x_max_value                    in varchar2,
  x_cache_size                   in varchar2,
  x_cycle_flag                   in varchar2,
  x_order_flag                   in varchar2,
  x_user_id                      in varchar2
) is
begin
 UploadSequence (
  x_application_short_name => 	x_application_short_name,
  x_sequence_name => 		x_sequence_name,
  x_start_value => 		x_start_value,
  x_description => 		x_description,
  x_increment_by => 		x_increment_by,
  x_min_value => 		x_min_value,
  x_max_value => 		x_max_value,
  x_cache_size => 		x_cache_size,
  x_cycle_flag => 		x_cycle_flag,
  x_order_flag => 		x_order_flag,
  x_user_id => 			x_user_id,
  x_custom_mode =>  		null,
  x_last_update_date => 	null);

end UploadSequence;

--
-- UploadView (PUBLIC))
--   Public procedure for afdict.lct to call when uploading view
--   using afdict.lct. It calls InsertView when needed.
--
procedure UploadView (
  x_application_short_name       in varchar2,
  x_view_name                    in varchar2,
  x_text                         in varchar2,
  x_description                  in varchar2,
  x_user_id                      in varchar2
) is
begin
 UploadView (
  x_application_short_name => 	x_application_short_name,
  x_view_name => 		x_view_name,
  x_text => 			x_text,
  x_description => 		x_description,
  x_user_id => 			x_user_id,
  x_custom_mode => 		null,
  x_last_update_date => 	null,
  x_phase_mode =>		'BEGIN');

 UploadView (
  x_application_short_name =>   x_application_short_name,
  x_view_name =>                x_view_name,
  x_text =>                     x_text,
  x_description =>              x_description,
  x_user_id =>                  x_user_id,
  x_custom_mode =>              null,
  x_last_update_date =>         null,
  x_phase_mode =>               'END');


end UploadView;

--
-- UploadViewColumn (PUBLIC))
--   Public procedure for afdict.lct to call when uploading view column
--   using afdict.lct.
--
procedure UploadViewColumn (
  x_application_short_name       in varchar2,
  x_view_name                    in varchar2,
  x_view_column_name             in varchar2,
  x_view_column_sequence         in varchar2,
  x_user_id                      in varchar2
) is
begin
UploadViewColumn (
  x_application_short_name =>	x_application_short_name,
  x_view_name => 		x_view_name,
  x_view_column_name => 	x_view_column_name,
  x_view_column_sequence => 	x_view_column_sequence,
  x_user_id => 			x_user_id,
  x_custom_mode => 		null,
  x_last_update_date => 	null);

end UploadViewColumn;

--
-- ViewTextLength (PUBLIC)
--   Return the view text length.
--   This is a helper function as length() function can not be used
--   directly in sql but is ok to used on a variable in PL/SQL.
--
/*
function ViewTextLength (
  x_application_id               in number,
  x_view_name                    in varchar2) return number
is
  len  number;
begin
   for r in (select text from fnd_views
             where application_id = x_application_id
             and   view_name = x_view_name) loop
     len := length(r.text);

   end loop;

   return(len);
end ViewTextLength;
*/
-- There is no way we can figure out the lenght of a LONG column, so
-- just have to trap that ORA-1406.
function ViewTextLength (
  x_application_id               in number,
  x_view_name                    in varchar2) return number
is
  len  number;
  vtext varchar2(32000);
begin
   begin
     select text
     into vtext
     from fnd_views
     where application_id = x_application_id
     and   view_name = x_view_name;
     len := 200;
     return(len);
   exception
     when others then
       if (SQLCODE = -1406) then
         len := 33000;
       end if;
       return(len);
   end;

end ViewTextLength;

--
-- RemoveColumn (PUBLIC)
--   Remove column from FND_COLUMNS table.
--   Before removing this column, make sure that there is no index,
--   primary key or foreign key is using this column
--
procedure RemoveColumn(
  x_application_short_name       in varchar2,
  x_table_name                   in varchar2,
  x_column_name                  in varchar2) is
  appl_id number;
  tab_id number;
  col_id number;
  cnt number;
begin
  begin
    select application_id
    into appl_id
    from fnd_application
    where application_short_name = upper(x_application_short_name);
  exception
    when no_data_found then
      RAISE_APPLICATION_ERROR(
                   -20001, 'Fnd Application value '
				   || x_application_short_name
				   || ' not found in the table fnd_application ', TRUE);
      return;
  end;

  begin
    select table_id
    into tab_id
    from fnd_tables
    where application_id = appl_id
    and table_name = upper(x_table_name);
  exception
    when no_data_found then
      RAISE_APPLICATION_ERROR(
                   -20001, 'Fnd table '
				   || x_table_name
				   || ' not found in the table fnd_tables ', TRUE);
      return;
  end;

  begin
    select column_id
    into col_id
    from fnd_columns
    where application_id = appl_id
    and table_id = tab_id
    and column_name = upper(x_column_name);
  exception
    when no_data_found then
      RAISE_APPLICATION_ERROR(
                   -20001, 'Fnd columns '
				   || x_column_name
				   || ' not found in the table fnd_columns ', TRUE);
      return;
  end;

  -- Before removing this column, make sure that there is no index,
  -- primary key or foreign key is using this column

  -- Check index column
  cnt := 0;
  select count(*) into cnt
  from fnd_index_columns
  where application_id = appl_id
  and table_id = tab_id
  and column_id = col_id;
  if (cnt > 0) then
	RAISE_APPLICATION_ERROR(
                   -20001, 'FND-CHILD EXISTS - Application '
				   || x_application_short_name || ', Table '
				   || x_table_name || ', Column '
				   || x_column_name || ', child'
				   || ' index column ', TRUE);
    return;
  end if;

  -- Check primary key column
  cnt := 0;
  select count(*) into cnt
  from fnd_primary_key_columns
  where application_id = appl_id
  and table_id = tab_id
  and column_id = col_id;
  if (cnt > 0) then
	RAISE_APPLICATION_ERROR(
                   -20001, 'FND-CHILD EXISTS - Application '
				   || x_application_short_name || ', Table '
				   || x_table_name || ', Column '
				   || x_column_name || ', child'
				   || ' primary key column ', TRUE);
    return;
  end if;

  -- Check foreign key column
  cnt := 0;
  select count(*) into cnt
  from fnd_foreign_key_columns
  where application_id = appl_id
  and table_id = tab_id
  and column_id = col_id;
  if (cnt > 0) then
	RAISE_APPLICATION_ERROR(
                   -20001, 'FND-CHILD EXISTS - Application '
				   || x_application_short_name || ', Table '
				   || x_table_name || ', Column '
				   || x_column_name || ', child'
				   || ' foreign key column ', TRUE);
    return;
  end if;

  delete from fnd_columns
  where application_id = appl_id
  and table_id = tab_id
  and column_id = col_id;

end RemoveColumn;

--
-- RemoveIndex (PUBLIC)
--   Remove index from FND_INDEXES and FND_INDEX_COLUMNS table.
--
procedure RemoveIndex(
  x_application_short_name       in varchar2,
  x_table_name                   in varchar2,
  x_index_name                   in varchar2) is
  appl_id number;
  tab_id number;
  ind_id number;
begin
  begin
    select application_id
    into appl_id
    from fnd_application
    where application_short_name = upper(x_application_short_name);
  exception
    when no_data_found then
	  RAISE_APPLICATION_ERROR(
                   -20001, 'No data found in fnd_application for short name '
				   || x_application_short_name , TRUE);
      return;
  end;

  begin
    select table_id
    into tab_id
    from fnd_tables
    where application_id = appl_id
    and table_name = upper(x_table_name);
  exception
    when no_data_found then
	  RAISE_APPLICATION_ERROR(
                   -20001, 'No data found in fnd_tables for table name '
				   || x_table_name , TRUE);
      return;
  end;

  begin
    select index_id
    into ind_id
    from fnd_indexes
    where application_id = appl_id
    and table_id = tab_id
    and index_name = upper(x_index_name);
  exception
    when no_data_found then
	  RAISE_APPLICATION_ERROR(
                   -20001, 'No data found in fnd_indexes for index name '
				   || x_index_name , TRUE);
      return;
  end;

  -- Delete index columns
  delete from fnd_index_columns
  where application_id = appl_id
  and table_id = tab_id
  and index_id = ind_id;

  delete from fnd_indexes
  where application_id = appl_id
  and table_id = tab_id
  and index_id = ind_id;

end RemoveIndex;

--
-- RemovePrimaryKey (PUBLIC)
--   Remove primary key from FND_PRIMARY_KEYS and FND_PRIMARY_KEY_COLUMNS table.
--   Before deleting primary key, make sure that there is no foreign key
--   pointing to this primary key
--
procedure RemovePrimaryKey(
  x_application_short_name       in varchar2,
  x_table_name                   in varchar2,
  x_primary_key_name             in varchar2) is
  appl_id number;
  tab_id number;
  pk_id number;
  cnt number;
begin
  begin
    select application_id
    into appl_id
    from fnd_application
    where application_short_name = upper(x_application_short_name);
  exception
    when no_data_found then
	  RAISE_APPLICATION_ERROR(
                   -20001, 'No data found in fnd_application for short name '
				   || x_application_short_name , TRUE);
      return;
  end;

  begin
    select table_id
    into tab_id
    from fnd_tables
    where application_id = appl_id
    and table_name = upper(x_table_name);
  exception
    when no_data_found then
	  RAISE_APPLICATION_ERROR(
                   -20001, 'No data found in fnd_tables for table name '
				   || x_table_name , TRUE);
      return;
  end;

  begin
    select primary_key_id
    into pk_id
    from fnd_primary_keys
    where application_id = appl_id
    and table_id = tab_id
    and primary_key_name = upper(x_primary_key_name);
  exception
    when no_data_found then
	  RAISE_APPLICATION_ERROR(
                   -20001, 'No data found in fnd_primary_keys for primary key name '
				   || x_primary_key_name , TRUE);
      return;
  end;

  -- Before deleting primary key, make sure that there is no foreign key
  -- pointing to this primary key

  cnt := 0;
  select count(*) into cnt
  from fnd_foreign_keys
  where primary_key_application_id = appl_id
  and primary_key_table_id = tab_id
  and primary_key_id = pk_id;

  if (cnt = 0) then
    delete from fnd_primary_key_columns
    where application_id = appl_id
    and table_id = tab_id
    and primary_key_id = pk_id;

    delete from fnd_primary_keys
    where application_id = appl_id
    and table_id = tab_id
    and primary_key_id = pk_id;

  else
    -- There are foreign keys pointing to this primary key.
    -- Removing the foreign key before removing this primary key
    RAISE_APPLICATION_ERROR(
                   -20001, 'Fnd Foreign key exists for primary key name '
				   || x_primary_key_name , TRUE);
    return;
  end if;

end RemovePrimaryKey;

--
-- RemoveForeignKey (PUBLIC)
--   Remove foreign key from FND_FOREIGN_KEYS and FND_FOREIGN_KEY_COLUMNS table.
--
procedure RemoveForeignKey(
  x_application_short_name       in varchar2,
  x_table_name                   in varchar2,
  x_foreign_key_name             in varchar2) is
  appl_id number;
  tab_id number;
  fk_id number;
begin
  begin
    select application_id
    into appl_id
    from fnd_application
    where application_short_name = upper(x_application_short_name);
  exception
    when no_data_found then
	  RAISE_APPLICATION_ERROR(
                   -20001, 'Sql no data found in fnd_application for application short name '
				   || x_application_short_name , TRUE);
      return;
  end;

  begin
    select table_id
    into tab_id
    from fnd_tables
    where application_id = appl_id
    and table_name = upper(x_table_name);
  exception
    when no_data_found then
	  RAISE_APPLICATION_ERROR(
                   -20001, 'Sql no data found in fnd_tables for table name '
				   || x_table_name , TRUE);
      return;
  end;

  begin
    select foreign_key_id
    into fk_id
    from fnd_foreign_keys
    where application_id = appl_id
    and table_id = tab_id
    and foreign_key_name = upper(x_foreign_key_name);
  exception
    when no_data_found then
	  RAISE_APPLICATION_ERROR(
                   -20001, 'Sql no data found in fnd_foreign_keys for for foreign key name '
				   || x_foreign_key_name , TRUE);
      return;
  end;

  -- Nothing pointing to foreign key so is safe to delete
  delete from fnd_foreign_key_columns
  where application_id = appl_id
  and table_id = tab_id
  and foreign_key_id = fk_id;

  delete from fnd_foreign_keys
  where application_id = appl_id
  and table_id = tab_id
  and foreign_key_id = fk_id;

end RemoveForeignKey;

--
-- RemoveSequence (PUBLIC)
--   Remove sequence from FND_SEQUENCES table.
--
procedure RemoveSequence(
  x_application_short_name       in varchar2,
  x_sequence_name                in varchar2) is
  appl_id number;
begin
  begin
    select application_id
    into appl_id
    from fnd_application
    where application_short_name = upper(x_application_short_name);
  exception
    when no_data_found then
      RAISE_APPLICATION_ERROR(
                   -20001, 'Sql no data found in fnd_application for application short name '
				   || x_application_short_name , TRUE);
      return;
  end;

  delete from fnd_sequences
  where application_id = appl_id
  and sequence_name = upper(x_sequence_name);
  if (SQL%ROWCOUNT = 0) then
    RAISE_APPLICATION_ERROR(
                   -20001, 'Sql no data found in fnd_sequences for sequence name '
				   || x_sequence_name , TRUE);
    return;
  end if;

end RemoveSequence;

--
-- RemoveView (PUBLIC)
--   Remove view from FND_VIEWS and FND_VIEW_COLUMNS table.
--
procedure RemoveView(
  x_application_short_name       in varchar2,
  x_view_name                    in varchar2) is
  appl_id number;
  vw_id number;
begin
  begin
    select application_id
    into appl_id
    from fnd_application
    where application_short_name = upper(x_application_short_name);
  exception
    when no_data_found then
	  RAISE_APPLICATION_ERROR(
                   -20001, 'Sql no data found in fnd_application for application short name '
				   || x_application_short_name , TRUE);
      return;
  end;

  begin
    select view_id into vw_id
    from fnd_views
    where application_id = appl_id
    and view_name = upper(x_view_name);
  exception
    when no_data_found then
	  RAISE_APPLICATION_ERROR(
                   -20001, 'Sql no data found in fnd_views for view name '
				   || x_view_name , TRUE);
      return;
  end;

  -- Nothing pointing to view, so is safe to delete
  delete from fnd_view_columns
  where application_id = appl_id
  and view_id = vw_id;

  delete from fnd_views
  where application_id = appl_id
  and view_id = vw_id;

end RemoveView;

--
-- RemoveTable (PUBLIC)
--   Remove table from FND_TABLES and all its columns, indexes, primary
--   keys and foreign keys.
--
procedure RemoveTable(
  x_application_short_name       in varchar2,
  x_table_name                   in varchar2) is
  appl_id number;
  tab_id number;

  cursor ind is
  select index_name
  from fnd_indexes
  where application_id = appl_id
  and table_id = tab_id;

  cursor fk is
  select foreign_key_name
  from fnd_foreign_keys
  where application_id = appl_id
  and table_id = tab_id;

  cursor pk is
  select primary_key_name
  from fnd_primary_keys
  where application_id = appl_id
  and table_id = tab_id;

begin

  begin
    select application_id
    into appl_id
    from fnd_application
    where application_short_name = upper(x_application_short_name);
  exception
    when no_data_found then
	  RAISE_APPLICATION_ERROR(
                   -20001, 'Sql no data found in fnd_application for application short name '
				   || x_application_short_name , TRUE);
      return;
  end;

  begin
    select table_id
    into tab_id
    from fnd_tables
    where application_id = appl_id
    and table_name = upper(x_table_name);
  exception
    when no_data_found then
	  RAISE_APPLICATION_ERROR(
                   -20001, 'Sql no data found in fnd_tables for table name '
				   || x_table_name , TRUE);
      return;
  end;

  -- Before removing this table, remove all the children.

  -- Remove indexes
  for c_ind in ind loop
    RemoveIndex(x_application_short_name, x_table_name, c_ind.index_name);
  end loop;

  -- Remove foreign keys
  for c_fk in fk loop
    RemoveForeignKey(x_application_short_name, x_table_name,
                     c_fk.foreign_key_name);
  end loop;

  -- Remove primary keys
  for c_pk in pk loop
    RemovePrimaryKey(x_application_short_name, x_table_name,
                     c_pk.primary_key_name);
  end loop;

  -- Remove columns
  delete from fnd_columns
  where application_id = appl_id
  and table_id = tab_id;

  -- Remove table itself
  delete from fnd_tables
  where application_id = appl_id
  and table_id = tab_id;

end RemoveTable;

--
-- UploadTable (PUBLIC)) - Overloaded
--   Public procedure for afdict.lct to call when uploading tables using
--   using afdict.lct. It calls InsertTable() when needed.
--
procedure UploadTable (
  x_application_short_name       in varchar2,
  x_table_name                   in varchar2,
  x_user_table_name              in varchar2,
  x_table_type                   in varchar2,
  x_description                  in varchar2,
  x_auto_size                    in varchar2,
  x_initial_extent               in varchar2,
  x_next_extent                  in varchar2,
  x_min_extents                  in varchar2,
  x_max_extents                  in varchar2,
  x_ini_trans                    in varchar2,
  x_max_trans                    in varchar2,
  x_pct_free                     in varchar2,
  x_pct_increase                 in varchar2,
  x_pct_used                     in varchar2,
  x_hosted_support_style         in varchar2,
  x_user_id                      in varchar2,
  x_custom_mode 			   in varchar2,
  x_last_update_date 		   in varchar2
) is
  appl_id number;
  dummy varchar2(1);
  f_luby    number;  -- entity owner in file
  f_ludate  date;    -- entity update date in file
  db_luby   number;  -- entity owner in db
  db_ludate date;    -- entity update date in db
begin

  -- Validate application
  begin
  select A.APPLICATION_ID
  into appl_id
  from FND_APPLICATION A
  where A.APPLICATION_SHORT_NAME = x_application_short_name;
  exception
    when no_data_found then
	  RAISE_APPLICATION_ERROR(
                   -20001, 'Sql no data found in fnd_application for application short name '
				   || x_application_short_name , TRUE);
  end;

  -- Validate hosted support style
/*
  begin
    if (x_hosted_support_style <> 'LOCAL') then
      select 'X' into dummy
        from fnd_lookups
       where lookup_type = 'HOSTED_SUPPORT_STYLE'
         and lookup_code = x_hosted_support_style;
    end if;
  exception
    when no_data_found then
	RAISE_APPLICATION_ERROR(
                   -20001, 'Sql no data found for hosted support style '
				   || x_hosted_support_style , TRUE);
  end;
*/

  -- Translate owner to file_last_updated_by
  f_luby := owner_id(x_user_id);

  -- Translate char last_update_date to date
  f_ludate := nvl(to_date(x_last_update_date, 'YYYY/MM/DD'), sysdate);

  begin
    select LAST_UPDATED_BY, LAST_UPDATE_DATE
    into db_luby, db_ludate
    from FND_TABLES
    where APPLICATION_ID = appl_id
    and TABLE_NAME = x_table_name;

    if (upload_test(f_luby, f_ludate, db_luby,
                                  db_ludate, X_CUSTOM_MODE)) then

-- Resolve USER_TABLE_NAME by pre-pending '@'
  update FND_TABLES
  set USER_TABLE_NAME = '@'||USER_TABLE_NAME
  where APPLICATION_ID = appl_id
  and 	TABLE_NAME <> x_table_name
  and   USER_TABLE_NAME = x_user_table_name;

  update FND_TABLES set
      USER_TABLE_NAME = x_user_table_name,
      TABLE_TYPE = x_table_type,
      DESCRIPTION = x_description,
      AUTO_SIZE = x_auto_size,
      INITIAL_EXTENT = x_initial_extent,
      NEXT_EXTENT = x_next_extent,
      MIN_EXTENTS = x_min_extents,
      MAX_EXTENTS = x_max_extents,
      INI_TRANS = x_ini_trans,
      MAX_TRANS = x_max_trans,
      PCT_FREE = x_pct_free,
      PCT_INCREASE = x_pct_increase,
      PCT_USED = x_pct_used,
      HOSTED_SUPPORT_STYLE = x_hosted_support_style,
      LAST_UPDATED_BY = f_luby,
      LAST_UPDATE_DATE = f_ludate,
      LAST_UPDATE_LOGIN = f_luby
  where APPLICATION_ID = appl_id
  and   TABLE_NAME = x_table_name;
 end if;
exception
 when no_data_found then
    Fnd_XdfDictionary_Pkg.InsertTable(
        appl_id,
        x_table_name,
        x_user_table_name,
        x_table_type,
        x_description,
        x_auto_size,
        x_initial_extent,
        x_next_extent,
        x_min_extents,
        x_max_extents,
        x_ini_trans,
        x_max_trans,
        x_pct_free,
        x_pct_increase,
        x_pct_used,
        x_hosted_support_style,
        f_ludate,
        f_luby,
        f_ludate,
        f_luby,
        0);
end;
end UploadTable;

--
-- UploadColumn (PUBLIC)) - Overloaded
--   Public procedure for afdict.lct to call when uploading columns using
--   using afdict.lct. It calls InsertColumn() when needed.
--
procedure UploadColumn (
  x_application_short_name       in varchar2,
  x_table_name                   in varchar2,
  x_column_name                  in varchar2,
  x_user_column_name             in varchar2,
  x_column_sequence              in varchar2,
  x_column_type                  in varchar2,
  x_width                        in varchar2,
  x_null_allowed_flag            in varchar2,
  x_description                  in varchar2,
  x_default_value                in varchar2,
  x_translate_flag               in varchar2,
  x_precision                    in varchar2,
  x_scale                        in varchar2,
  x_flexfield_usage_code         in varchar2,
  x_flexfield_application_id     in varchar2,
  x_flexfield_name               in varchar2,
  x_flex_value_set_app_id        in varchar2,
  x_flex_value_set_id            in varchar2,
  x_user_id                      in varchar2,
  x_custom_mode 			   in varchar2,
  x_last_update_date 		   in varchar2
) is
  tab_id number;
  appl_id number;
  f_luby    number;  -- entity owner in file
  f_ludate  date;    -- entity update date in file
  db_luby   number;  -- entity owner in db
  db_ludate date;    -- entity update date in db
begin

  -- Because Column is in the same entity as Table, no need to validate
  -- Application and Table again.
  select A.APPLICATION_ID
  into appl_id
  from FND_APPLICATION A
  where A.APPLICATION_SHORT_NAME = x_application_short_name;

  select T.TABLE_ID into tab_id from FND_TABLES T
  where T.APPLICATION_ID = appl_id
  and T.TABLE_NAME = x_table_name;

  ResolveConflictColumn(appl_id, tab_id, x_column_name, x_user_column_name,
                       x_column_sequence);

    -- Translate owner to file_last_updated_by
  f_luby := owner_id(x_user_id);

  -- Translate char last_update_date to date
  f_ludate := nvl(to_date(x_last_update_date, 'YYYY/MM/DD'), sysdate);

  begin
    select LAST_UPDATED_BY, LAST_UPDATE_DATE
    into db_luby, db_ludate
    from FND_COLUMNS
    where APPLICATION_ID = appl_id
    and TABLE_ID = tab_id
    and COLUMN_NAME = x_column_name;

    if (upload_test(f_luby, f_ludate, db_luby,
                                  db_ludate, X_CUSTOM_MODE)) then

      update FND_COLUMNS set
      USER_COLUMN_NAME = x_user_column_name,
      COLUMN_SEQUENCE = x_column_sequence,
      COLUMN_TYPE = x_column_type,
      WIDTH = x_width,
      NULL_ALLOWED_FLAG = x_null_allowed_flag,
      DESCRIPTION = x_description,
      DEFAULT_VALUE = x_default_value,
      TRANSLATE_FLAG = x_translate_flag,
      PRECISION = x_precision,
      SCALE = x_scale,
      FLEXFIELD_USAGE_CODE = x_flexfield_usage_code,
      FLEXFIELD_APPLICATION_ID = x_flexfield_application_id,
      FLEXFIELD_NAME = x_flexfield_name,
      FLEX_VALUE_SET_APPLICATION_ID = x_flex_value_set_app_id,
      FLEX_VALUE_SET_ID = x_flex_value_set_id,
      LAST_UPDATED_BY = f_luby,
      LAST_UPDATE_DATE = f_ludate,
      LAST_UPDATE_LOGIN = f_luby
  where APPLICATION_ID = appl_id
  and   TABLE_ID = tab_id
  and   COLUMN_NAME = x_column_name;
 end if;
exception
 when no_data_found then
    Fnd_XdfDictionary_Pkg.InsertColumn(
        appl_id,
        tab_id,
        x_column_name,
        x_user_column_name,
        x_column_sequence,
        x_column_type,
        x_width,
        x_null_allowed_flag,
        x_description,
        x_default_value,
        x_translate_flag,
        x_precision,
        x_scale,
        x_flexfield_usage_code,
        x_flexfield_application_id,
        x_flexfield_name,
        x_flex_value_set_app_id,
        x_flex_value_set_id,
        f_ludate,
        f_luby,
        f_ludate,
        f_luby,
        0);
end;
end UploadColumn;

--
-- UploadHistColumn (PUBLIC))
--   Public procedure for afdict.lct to call when uploading columns using
--   using afdict.lct. It calls InsertHistColumn() when needed.
--
procedure UploadHistColumn (
  x_application_short_name       in varchar2,
  x_table_name                   in varchar2,
  x_column_name                  in varchar2,
  x_partition                    in varchar2,
  x_hsize                        in varchar2,
  x_user_id                      in varchar2,
  x_custom_mode 			   in varchar2,
  x_last_update_date 		   in varchar2
) is
  appl_id number;
  f_luby    number;  -- entity owner in file
  f_ludate  date;    -- entity update date in file
  db_luby   number;  -- entity owner in db
  db_ludate date;    -- entity update date in db
begin

  -- Because Column is in the same entity as Table, no need to validate
  -- Application and Table again.
  select A.APPLICATION_ID
  into appl_id
  from FND_APPLICATION A
  where A.APPLICATION_SHORT_NAME = x_application_short_name;

  -- Translate owner to file_last_updated_by
  f_luby := owner_id(x_user_id);

  -- Translate char last_update_date to date
  f_ludate := nvl(to_date(x_last_update_date, 'YYYY/MM/DD'), sysdate);

  begin
    select LAST_UPDATED_BY, LAST_UPDATE_DATE
    into db_luby, db_ludate
    from FND_HISTOGRAM_COLS
    where APPLICATION_ID = appl_id
    and TABLE_NAME = x_table_name
    and COLUMN_NAME = x_column_name;

 if (upload_test(f_luby, f_ludate, db_luby,
                                  db_ludate, X_CUSTOM_MODE)) then

  update FND_HISTOGRAM_COLS set
      PARTITION = x_partition,
      HSIZE = x_hsize,
      LAST_UPDATED_BY = f_luby,
      LAST_UPDATE_DATE = f_ludate,
      LAST_UPDATE_LOGIN = f_luby
  where APPLICATION_ID = appl_id
  and   TABLE_NAME = x_table_name
  and   COLUMN_NAME = x_column_name;
 end if;
 exception
   when no_data_found then
    insert into FND_HISTOGRAM_COLS (
      APPLICATION_ID,
      TABLE_NAME,
      COLUMN_NAME,
      PARTITION,
      HSIZE,
      CREATION_DATE,
      CREATED_BY,
      LAST_UPDATED_BY,
      LAST_UPDATE_DATE,
      LAST_UPDATE_LOGIN)
      values (
      appl_id,
      x_table_name,
      x_column_name,
      x_partition,
      x_hsize,
      f_ludate,
      f_luby,
      f_luby,
      f_ludate,
      f_luby);
end;
end UploadHistColumn;


--
-- UploadHistColumn_MV (PUBLIC))
-- Added for MV histogram DATA

procedure UploadHistColumn_MV (
  x_application_short_name       in varchar2,
  x_table_name                   in varchar2,
  x_column_name                  in varchar2,
  x_partition                    in varchar2,
  x_hsize                        in varchar2,
  x_user_id                      in varchar2,
  x_custom_mode 		  in varchar2,
  x_last_update_date 		   in varchar2,
  x_mview_owner                    in varchar2
) is
  appl_id number;
  f_luby    number;  -- entity owner in file
  f_ludate  date;    -- entity update date in file
  db_luby   number;  -- entity owner in db
  db_ludate date;    -- entity update date in db
begin

-- Because Column is in the same entity as Table, no need to validate
  -- Application and Table again.
  select A.APPLICATION_ID
  into appl_id
  from FND_APPLICATION A
  where A.APPLICATION_SHORT_NAME = x_application_short_name;


   -- Translate owner to file_last_updated_by
  f_luby := owner_id(x_user_id);

  -- Translate char last_update_date to date
  f_ludate := nvl(to_date(x_last_update_date, 'YYYY/MM/DD'), sysdate);

  -- application_id is  set to -1 if the owner of MV is apps.

 if(UPPER(x_mview_owner)='APPS')then
  appl_id:=-1;
  end if;

  begin
    select LAST_UPDATED_BY, LAST_UPDATE_DATE
    into db_luby, db_ludate
    from FND_HISTOGRAM_COLS
    where APPLICATION_ID = appl_id
    and TABLE_NAME = x_table_name
    and COLUMN_NAME = x_column_name
    and OWNER =x_mview_owner;


 if (upload_test(f_luby, f_ludate, db_luby,
                                  db_ludate, X_CUSTOM_MODE)) then

  update FND_HISTOGRAM_COLS set
      PARTITION = x_partition,
      HSIZE = x_hsize,
      LAST_UPDATED_BY = f_luby,
      LAST_UPDATE_DATE = f_ludate,
      LAST_UPDATE_LOGIN = f_luby
  where APPLICATION_ID = appl_id
    and TABLE_NAME = x_table_name
    and COLUMN_NAME = x_column_name
    and OWNER =x_mview_owner;
 end if;
 exception
   when no_data_found then
    insert into FND_HISTOGRAM_COLS (
      APPLICATION_ID,
      TABLE_NAME,
      COLUMN_NAME,
      PARTITION,
      HSIZE,
      CREATION_DATE,
      CREATED_BY,
      LAST_UPDATED_BY,
      LAST_UPDATE_DATE,
      LAST_UPDATE_LOGIN,
      OWNER
      )
      values (
      appl_id,
      x_table_name,
      x_column_name,
      x_partition,
      x_hsize,
      f_ludate,
      f_luby,
      f_luby,
      f_ludate,
      f_luby,
      x_mview_owner
      );
end;
end UploadHistColumn_MV;


--
-- UploadIndex (PUBLIC))
--   Public procedure for afdict.lct to call when uploading indexes using
--   using afdict.lct. It calls InsertIndex() when needed.
--
procedure UploadIndex (
  x_application_short_name       in varchar2,
  x_table_name                   in varchar2,
  x_index_name                   in varchar2,
  x_uniqueness                   in varchar2,
  x_auto_size                    in varchar2,
  x_description                  in varchar2,
  x_initial_extent               in varchar2,
  x_next_extent                  in varchar2,
  x_min_extents                  in varchar2,
  x_max_extents                  in varchar2,
  x_ini_trans                    in varchar2,
  x_max_trans                    in varchar2,
  x_pct_free                     in varchar2,
  x_pct_increase                 in varchar2,
  x_user_id                      in varchar2,
  x_custom_mode 			   in varchar2,
  x_last_update_date 		   in varchar2,
  x_phase_mode			   in varchar2
) is
  tab_id number;
  appl_id number;
  f_luby    number;  -- entity owner in file
  f_ludate  date;    -- entity update date in file
  db_luby   number;  -- entity owner in db
  db_ludate date;    -- entity update date in db
                     -- Bug2631776 new variables to handle update.
  child_file_ludate date;   -- child entity update date in file
  child_file_luby   number; -- child owner in file
  child_db_ludate   date;   -- child update date in db
  child_db_luby     number; -- child owner in db
  ind_id	number;

begin

  -- Because Index is in the same entity as Table, no need to validate
  -- Application and Table again.

  select A.APPLICATION_ID
  into appl_id
  from FND_APPLICATION A
  where A.APPLICATION_SHORT_NAME = x_application_short_name;

  select T.TABLE_ID into tab_id from FND_TABLES T
  where T.APPLICATION_ID = appl_id
  and T.TABLE_NAME = x_table_name;

  -- Bug2631776 In this section handle the parent entity
  -- and update the child entity so that constraints do not occur.

  if (x_phase_mode = 'BEGIN') then

    -- Translate owner to file_last_updated_by
    f_luby := owner_id(x_user_id);

    -- Translate char last_update_date to date
    f_ludate := nvl(to_date(x_last_update_date, 'YYYY/MM/DD'), sysdate);

   begin

     select INDEX_ID
     into ind_id
      from FND_INDEXES
     where APPLICATION_ID = appl_id
     and TABLE_ID = tab_id
     and INDEX_NAME = x_index_name;

    select LAST_UPDATED_BY, LAST_UPDATE_DATE
    into db_luby, db_ludate
    from FND_INDEXES
    where APPLICATION_ID = appl_id
    and TABLE_ID = tab_id
    and INDEX_NAME = x_index_name;

    if (upload_test(f_luby, f_ludate, db_luby,
                                  db_ludate, X_CUSTOM_MODE)) then

     update FND_INDEXES set
      UNIQUENESS = x_uniqueness,
      AUTO_SIZE = x_auto_size,
      DESCRIPTION = x_description,
      INITIAL_EXTENT = x_initial_extent,
      NEXT_EXTENT = x_next_extent,
      MIN_EXTENTS = x_min_extents,
      MAX_EXTENTS = x_max_extents,
      INI_TRANS = x_ini_trans,
      MAX_TRANS = x_max_trans,
      PCT_FREE = x_pct_free,
      PCT_INCREASE = x_pct_increase,
      LAST_UPDATED_BY = f_luby,
      LAST_UPDATE_DATE = f_ludate,
      LAST_UPDATE_LOGIN = f_luby
     where APPLICATION_ID = appl_id
     and   TABLE_ID = tab_id
     and   INDEX_NAME = x_index_name;

    end if;

      -- Bug3230044 Delete any child records with a negative
      -- value for COLUMN_ID.

      delete from FND_INDEX_COLUMNS
       where APPLICATION_ID = appl_id
       and TABLE_ID = tab_id
       and INDEX_ID = ind_id
       and COLUMN_ID < 0;

      -- BUG2631776 rename the child record's COLUMN_SEQUENCE
      -- and COLUMN_ID values to a negative value in order to
      -- prevent unique constraints while processing the
      -- PARENT/CHILD entity.

     update FND_INDEX_COLUMNS
      set COLUMN_SEQUENCE = -1 * COLUMN_SEQUENCE,
          COLUMN_ID = -1 * COLUMN_ID
     where APPLICATION_ID = appl_id
     and   TABLE_ID = tab_id
     and   INDEX_ID = ind_id;

      /*Bug2773876 - Handle special case where COLUMN_SEQUENCE = 0 */

     update FND_INDEX_COLUMNS
      set COLUMN_SEQUENCE = -1000
     where APPLICATION_ID = appl_id
     and   TABLE_ID = tab_id
     and   INDEX_ID = ind_id
     and COLUMN_SEQUENCE = 0;

    exception
      when no_data_found then
       Fnd_XdfDictionary_Pkg.InsertIndex(
        appl_id,
        tab_id,
        x_index_name,
        x_uniqueness,
        x_auto_size,
        x_description,
        x_initial_extent,
        x_next_extent,
        x_min_extents,
        x_max_extents,
        x_ini_trans,
        x_max_trans,
        x_pct_free,
        x_pct_increase,
        f_ludate,
        f_luby,
        f_ludate,
        f_luby,
        0);
   end;

 else -- phase_mode = 'END'

     select INDEX_ID
     into ind_id
      from FND_INDEXES
     where APPLICATION_ID = appl_id
     and TABLE_ID = tab_id
     and INDEX_NAME = x_index_name;

  -- Bug2631776 get the latest value for the last update for the db entity
  -- and the file entity.

  select max(last_update_date)
    into child_db_ludate
    from fnd_index_columns
    where application_id = appl_id
    and table_id = tab_id
    and index_id = ind_id
    and column_sequence < 0
    and column_id < 0;

  -- Bug3139883 changed select to also include value if column_sequence =0

  select max(last_update_date)
    into child_file_ludate
    from fnd_index_columns
    where application_id = appl_id
    and table_id = tab_id
    and index_id = ind_id
    and column_sequence >= 0
    and column_id > 0;

   -- If no value which means there were no existing child records
   -- in the database therefore  skip to the end  since the new child
   -- records have been updated.

   if (child_db_ludate IS NULL) or (child_file_ludate IS NULL) then
      GOTO done_label;
   end if;

   -- Continue on to check the owner value since both have columns.

   -- Bug2631776 get the maximum value for the userid that made the
   -- last update for the db entity and the file entity.

       -- If any non-seed owners, set owner to user
       select max(-1)
       into child_db_luby
       from fnd_index_columns
         where application_id = appl_id
         and table_id = tab_id
         and index_id = ind_id
         and column_sequence < 0
         and column_id < 0
         and last_updated_by not in (0,1,2);

       if child_db_luby IS NULL then
         child_db_luby := 2;  -- All rows are seed data, set seed data owner
       end if;

       -- If any non-seed owners, set owner to user
       select max(-1)
       into child_file_luby
       from fnd_index_columns
         where application_id = appl_id
         and table_id = tab_id
         and index_id = ind_id
         and column_sequence > 0
         and column_id > 0
         and last_updated_by not in (0,1,2);

       if child_file_luby IS NULL then
         child_file_luby := 2;  -- All rows are seed data, set seed data owner
       end if;

   -- Bug2631776 perform check to see if update occurs or not.

   if (upload_test(child_file_luby, child_file_ludate, child_db_luby, child_db_ludate, x_custom_mode)) then

      -- The new child entity rows from the data file are  kept so
      -- delete the existing db child entity rows.

         delete from fnd_index_columns
            where application_id = appl_id
            and table_id = tab_id
            and index_id = ind_id
            and column_sequence < 0
            and column_id < 0;

     else

      -- The existing db child entity rows are kept so delete the new child
      -- entity rows from the data file
      -- Bug3139883 - Modified delete to include the value column_sequence = 0

            delete from fnd_index_columns
            where application_id = appl_id
            and table_id = tab_id
            and index_id = ind_id
            and column_sequence >= 0
            and column_id > 0;

	-- Rename the existing db entity rows back to normal since
        -- it was not replaced by the new child entity rows
        -- from the data file.

         update FND_INDEX_COLUMNS
             set COLUMN_SEQUENCE = -1 * COLUMN_SEQUENCE,
                  COLUMN_ID = -1 * COLUMN_ID
    		where APPLICATION_ID = appl_id
    		and   TABLE_ID = tab_id
    		and   INDEX_ID = ind_id;

        /*Bug2773876 - Handle special case where COLUMN_SEQUENCE = 0 */

         update FND_INDEX_COLUMNS
             set COLUMN_SEQUENCE = 0
                where APPLICATION_ID = appl_id
                and   TABLE_ID = tab_id
                and   INDEX_ID = ind_id
                and COLUMN_SEQUENCE = 1000;

     end if;
    <<done_label>>

     -- check if the file has no child entries to clean up database.

     if (child_file_ludate IS NULL) then

        if (child_db_ludate IS NOT NULL) then

	  -- Rename the existing db entity rows back to normal since
        -- it was not replaced by the new child entity rows
        -- from the data file.

         update FND_INDEX_COLUMNS
             set COLUMN_SEQUENCE = -1 * COLUMN_SEQUENCE,
                  COLUMN_ID = -1 * COLUMN_ID
    		where APPLICATION_ID = appl_id
    		and   TABLE_ID = tab_id
    		and   INDEX_ID = ind_id;

       /*Bug2773876 - Handle special case where COLUMN_SEQUENCE = 0 */

         update FND_INDEX_COLUMNS
             set COLUMN_SEQUENCE = 0
                where APPLICATION_ID = appl_id
                and   TABLE_ID = tab_id
                and   INDEX_ID = ind_id
                and COLUMN_SEQUENCE = 1000;

	 end if;
    end if;
  end if;
end UploadIndex;

--
-- UploadIndexColumn (PUBLIC))
--   Public procedure for afdict.lct to call when uploading index columns using
--   using afdict.lct.
--
procedure UploadIndexColumn (
  x_application_short_name       in varchar2,
  x_table_name                   in varchar2,
  x_index_name                   in varchar2,
  x_index_column_name            in varchar2,
  x_index_column_sequence        in varchar2,
  x_user_id                      in varchar2,
  x_custom_mode 			   in varchar2,
  x_last_update_date 		   in varchar2
) is
  tab_id number;
  appl_id number;
  idx_id number;
  col_id number;
  f_luby    number;  -- entity owner in file
  f_ludate  date;    -- entity update date in file
begin

  -- Because Index Column is in the same entity as Table and Index,
  -- no need to validate them again.
  select A.APPLICATION_ID
  into appl_id
  from FND_APPLICATION A
  where A.APPLICATION_SHORT_NAME = x_application_short_name;

  select T.TABLE_ID into tab_id from FND_TABLES T
  where T.APPLICATION_ID = appl_id
  and T.TABLE_NAME = x_table_name;

  select I.INDEX_ID into idx_id from FND_INDEXES I
  where I.APPLICATION_ID = appl_id
  and   I.TABLE_ID = tab_id
  and   I.INDEX_NAME = x_index_name;

  begin
    select C.COLUMN_ID into col_id from FND_COLUMNS C
    where C.APPLICATION_ID = appl_id
    and   C.TABLE_ID = tab_id
    and   C.COLUMN_NAME = x_index_column_name;
  exception
    when no_data_found then
	  RAISE_APPLICATION_ERROR(
                   -20001, 'No data found for fnd column name '
				   || x_index_column_name || ' object type Index '
				   || ' Index Name ' ||
				    x_index_name, TRUE);
  end;

  -- Translate owner to file_last_updated_by
  f_luby := owner_id(x_user_id);

  -- Translate char last_update_date to date
  f_ludate := nvl(to_date(x_last_update_date, 'YYYY/MM/DD'), sysdate);

  -- NOTE: no "UPDATE" case as we have renamed all the existing
  -- index columns so that they can be compared against the new
  -- index columns from the data file to determine which will be
  -- updated into the database based on the date and custom factirs.

     begin
     insert into FND_INDEX_COLUMNS(
      APPLICATION_ID,
      TABLE_ID,
      INDEX_ID,
      COLUMN_ID,
      COLUMN_SEQUENCE,
      LAST_UPDATED_BY,
      LAST_UPDATE_DATE,
      LAST_UPDATE_LOGIN,
      CREATION_DATE,
      CREATED_BY)
      values (
      appl_id,
      tab_id,
      idx_id,
      col_id,
      x_index_column_sequence,
      f_luby,
      f_ludate,
      f_luby,
      f_ludate,
      f_luby);

     exception
      when dup_val_on_index then
    	RAISE_APPLICATION_ERROR(
                   -20001, 'Duplicate value on index for column sequence'
				   || x_index_column_sequence || ' index name '
				   || ' Index Name ' ||
				    x_index_name, TRUE);
     end;

end UploadIndexColumn;

--
-- UploadPrimaryKey (PUBLIC))
--   Public procedure for afdict.lct to call when uploading primary key using
--   using afdict.lct. It calls InsertPrimary() when needed.
--
procedure UploadPrimaryKey (
  x_application_short_name       in varchar2,
  x_table_name                   in varchar2,
  x_primary_key_name             in varchar2,
  x_primary_key_type             in varchar2,
  x_audit_key_flag               in varchar2,
  x_description                  in varchar2,
  x_enabled_flag                 in varchar2,
  x_user_id                      in varchar2,
  x_custom_mode 			   in varchar2,
  x_last_update_date 		   in varchar2,
  x_phase_mode			   in varchar2,
  x_overwrite_PK		   in varchar2 DEFAULT 'N'
) is
  tab_id number;
  appl_id number;
  pk_id number;
  tmpid number;
  pkmode varchar2(10);
  f_luby    number;  -- entity owner in file
  f_ludate  date;    -- entity update date in file
  db_luby   number;  -- entity owner in db
  db_ludate date;    -- entity update date in db

                     -- Bug2631776 new variables to handle update.
  child_file_ludate date;   -- child entity update date in file
  child_file_luby   number; -- child owner in file
  child_db_ludate   date;   -- child update date in db
  child_db_luby     number; -- child owner in db

begin

  -- Because Primary Key is in the same entity as Table, no need to validate
  -- Application and Table again.
  select A.APPLICATION_ID
  into appl_id
  from FND_APPLICATION A
  where A.APPLICATION_SHORT_NAME = x_application_short_name;

  select T.TABLE_ID into tab_id from FND_TABLES T
  where T.APPLICATION_ID = appl_id
  and T.TABLE_NAME = x_table_name;

  -- Validation on primary_key_type, audit_flag and enabled_flag

  pk_id := -1;
  ValidatePrimaryKey(x_application_short_name,
                     x_table_name, x_primary_key_name, tmpid, tmpid, pk_id);
  if (pk_id = -1) then
    pkmode := 'INSERT';
  else
    pkmode := 'UPDATE';
  end if;

  if ((pkmode = 'INSERT' and x_primary_key_type not in ('S', 'D')) or
      (pkmode = 'UPDATE' and nvl(x_primary_key_type, 'S') not in ('S', 'D'))) then
       RAISE_APPLICATION_ERROR(
                   -20001, 'Invalid primary key attribute - type, attribute value '
				   || x_primary_key_type || ' primary key name '
				   || x_primary_key_name, TRUE);
  end if;

  if ((pkmode = 'INSERT' and x_audit_key_flag not in ('Y', 'N')) or
      (pkmode = 'UPDATE' and nvl(x_audit_key_flag, 'Y') not in ('Y', 'N'))) then
	  RAISE_APPLICATION_ERROR(
                   -20001, 'Invalid primary key attribute - audit key, attribute value '
				   || x_audit_key_flag || ' primary key name '
				   || x_primary_key_name, TRUE);
  end if;

  if ((pkmode = 'INSERT' and x_enabled_flag not in ('Y', 'N')) or
      (pkmode = 'UPDATE' and nvl(x_enabled_flag, 'Y') not in ('Y', 'N'))) then
	  RAISE_APPLICATION_ERROR(
                   -20001, 'Invalid primary key attribute - Enabled flag , attribute value '
				   || x_enabled_flag|| ' primary key name '
				   || x_primary_key_name, TRUE);
  end if;

  if (x_primary_key_type = 'D' and
      MultipleDeveloperKeys(appl_id, tab_id, x_primary_key_name)) then
	   if(x_overwrite_PK = 'Y') then
	        delete from FND_PRIMARY_KEY_COLUMNS
		  where APPLICATION_ID = appl_id
   	          and TABLE_ID = tab_id
		  and PRIMARY_KEY_ID IN (select PRIMARY_KEY_ID from FND_PRIMARY_KEYS
		   where  APPLICATION_ID = appl_id
		   and    TABLE_ID       = tab_id
		   and    PRIMARY_KEY_NAME  <> upper(x_primary_key_name)
                   and    PRIMARY_KEY_TYPE = 'D'
		  );
		delete from   FND_PRIMARY_KEYS
		   where  APPLICATION_ID = appl_id
		   and    TABLE_ID       = tab_id
		   and    PRIMARY_KEY_NAME  <> upper(x_primary_key_name)
         	   and    PRIMARY_KEY_TYPE = 'D';
	  else
	  RAISE_APPLICATION_ERROR(
                   -20001, 'Multiple developer PK table name '
				   || x_table_name, TRUE);
          end if;
  end if;

  -- Bug2631776 In this section handle the parent entity
  -- and update the child entity so that constraints do not occur.

if (x_phase_mode = 'BEGIN') then

    -- Translate owner to file_last_updated_by
  f_luby := owner_id(x_user_id);

  -- Translate char last_update_date to date
  f_ludate := nvl(to_date(x_last_update_date, 'YYYY/MM/DD'), sysdate);


  begin
    select LAST_UPDATED_BY, LAST_UPDATE_DATE
    into db_luby, db_ludate
    from FND_PRIMARY_KEYS
    where APPLICATION_ID = appl_id
    and TABLE_ID = tab_id
    and PRIMARY_KEY_NAME = x_primary_key_name;

  if (pkmode = 'UPDATE') then

  if (upload_test(f_luby, f_ludate, db_luby,
                                  db_ludate, X_CUSTOM_MODE)) then
    update FND_PRIMARY_KEYS set
      PRIMARY_KEY_TYPE = x_primary_key_type,
      AUDIT_KEY_FLAG = x_audit_key_flag,
      ENABLED_FLAG = x_enabled_flag,
      DESCRIPTION = x_description,
      LAST_UPDATED_BY = f_luby,
      LAST_UPDATE_DATE = f_ludate,
      LAST_UPDATE_LOGIN = f_luby
    where APPLICATION_ID = appl_id
    and   TABLE_ID = tab_id
    and   PRIMARY_KEY_NAME = x_primary_key_name;
  end if;

     -- Bug3230044 Delete any child records with a negative
      -- value for COLUMN_ID.

      delete from FND_PRIMARY_KEY_COLUMNS
       where APPLICATION_ID = appl_id
       and TABLE_ID = tab_id
       and PRIMARY_KEY_ID = pk_id
       and COLUMN_ID < 0;


      -- BUG2631776 rename the child record's PRIMARY_KEY_SEQUENCE
      -- and COLUMN_ID values to a negative value in order to
      -- prevent unique constraints while processing the
      -- PARENT/CHILD entity.

     update FND_PRIMARY_KEY_COLUMNS
      set PRIMARY_KEY_SEQUENCE = -1 * PRIMARY_KEY_SEQUENCE,
          COLUMN_ID = -1 * COLUMN_ID
     where APPLICATION_ID = appl_id
     and   TABLE_ID = tab_id
     and   PRIMARY_KEY_ID = pk_id;

    /*Bug3139883 - Handle special case where PRIMARY_KEY_SEQUENCE = 0 */

     update FND_PRIMARY_KEY_COLUMNS
      set PRIMARY_KEY_SEQUENCE = -1000
     where APPLICATION_ID = appl_id
     and   TABLE_ID = tab_id
     and   PRIMARY_KEY_ID = pk_id
     and PRIMARY_KEY_SEQUENCE = 0;

  else
    Fnd_XdfDictionary_Pkg.InsertPrimaryKey(
        appl_id,
        tab_id,
        x_primary_key_name,
        x_primary_key_type,
        x_audit_key_flag,
        x_enabled_flag,
        x_description,
        f_ludate,
        f_luby,
        f_ludate,
        f_luby,
        0);
  end if;

exception
  when no_data_found then
       Fnd_XdfDictionary_Pkg.InsertPrimaryKey(
        appl_id,
        tab_id,
        x_primary_key_name,
        x_primary_key_type,
        x_audit_key_flag,
        x_enabled_flag,
        x_description,
        f_ludate,
        f_luby,
        f_ludate,
        f_luby,
        0);

end;

else -- phase_mode = 'END'

  -- Bug2631776 get the latest value for the last update for the db entity
  -- and the file entity.

  select max(last_update_date)
    into child_db_ludate
    from fnd_primary_key_columns
    where application_id = appl_id
    and table_id = tab_id
    and primary_key_id = pk_id
    and primary_key_sequence < 0
    and column_id < 0;

 -- Bug3139883 changed select to also include value if primary_key_sequence =0

  select max(last_update_date)
    into child_file_ludate
    from fnd_primary_key_columns
    where application_id = appl_id
    and table_id = tab_id
    and primary_key_id = pk_id
    and PRIMARY_KEY_SEQUENCE >= 0
    and column_id > 0;

   -- If no value which means there were no existing child records
   -- in the database therefore  skip to the end  since the new child
   -- records have been updated.

   if (child_db_ludate IS NULL) or (child_file_ludate IS NULL) then
      GOTO done_label;
   end if;

   -- Continue on to check the owner value since both have columns.

   -- Bug2631776 get the maximum value for the userid that made the
   -- last update for the db entity and the file entity.

       -- If any non-seed owners, set owner to user
       select max(-1)
       into child_db_luby
       from fnd_primary_key_columns
         where application_id = appl_id
         and table_id = tab_id
         and primary_key_id = pk_id
         and PRIMARY_KEY_SEQUENCE < 0
         and column_id < 0
         and last_updated_by not in (0,1,2);

       if child_db_luby IS NULL then
         child_db_luby := 2;  -- All rows are seed data, set seed data owner
       end if;

       -- If any non-seed owners, set owner to user
       select max(-1)
       into child_file_luby
       from fnd_primary_key_columns
	 where application_id = appl_id
         and table_id = tab_id
         and primary_key_id = pk_id
         and PRIMARY_KEY_SEQUENCE > 0
         and column_id > 0
        and last_updated_by not in (0,1,2);

      if child_file_luby IS NULL then
         child_file_luby := 2;  -- All rows are seed data, set seed data owner
      end if;

   -- Bug2631776 perform check to see if update occurs or not.

   if (upload_test(child_file_luby, child_file_ludate, child_db_luby, child_db_ludate, x_custom_mode)) then

      -- The new child entity rows from the data file are  kept so
      -- delete the existing db child entity rows.

         delete from fnd_primary_key_columns
    		where application_id = appl_id
    		and table_id = tab_id
    		and primary_key_id = pk_id
            and PRIMARY_KEY_SEQUENCE < 0
            and column_id < 0;

     else

      -- The existing db child entity rows are kept so delete the new child
      -- entity rows from the data file
      -- Bug3139883 - Modified delete to include the value column_sequence = 0

         delete from fnd_primary_key_columns
	    	where application_id = appl_id
    		and table_id = tab_id
    		and primary_key_id = pk_id
            and PRIMARY_KEY_SEQUENCE >= 0
            and column_id > 0;

	-- Rename the existing db entity rows back to normal since
        -- it was not replaced by the new child entity rows
        -- from the data file.

         update FND_PRIMARY_KEY_COLUMNS
             set PRIMARY_KEY_SEQUENCE = -1 * PRIMARY_KEY_SEQUENCE,
                  COLUMN_ID = -1 * COLUMN_ID
    		where APPLICATION_ID = appl_id
    		and   TABLE_ID = tab_id
    		and   PRIMARY_KEY_ID = pk_id;

        /*Bug3139883 - Handle special case where PRIMARY_KEY_SEQUENCE = 0 */

         update FND_PRIMARY_KEY_COLUMNS
             set PRIMARY_KEY_SEQUENCE = 0
                where APPLICATION_ID = appl_id
                and   TABLE_ID = tab_id
                and   PRIMARY_KEY_ID = pk_id
                and PRIMARY_KEY_SEQUENCE = 1000;

     end if;
    <<done_label>>

     -- check if the file has no child entries to clean up database.

     if (child_file_ludate IS NULL) then

        if (child_db_ludate IS NOT NULL) then

	  -- Rename the existing db entity rows back to normal since
        -- it was not replaced by the new child entity rows
        -- from the data file.

         update FND_PRIMARY_KEY_COLUMNS
             set PRIMARY_KEY_SEQUENCE = -1 * PRIMARY_KEY_SEQUENCE,
                  COLUMN_ID = -1 * COLUMN_ID
    		where APPLICATION_ID = appl_id
    		and   TABLE_ID = tab_id
    		and   PRIMARY_KEY_ID = pk_id;

       /*Bug3139883 - Handle special case where PRIMARY_KEY_SEQUENCE = 0 */

         update FND_PRIMARY_KEY_COLUMNS
             set PRIMARY_KEY_SEQUENCE = 0
                where APPLICATION_ID = appl_id
                and   TABLE_ID = tab_id
                and   PRIMARY_KEY_ID = pk_id
                and PRIMARY_KEY_SEQUENCE = 1000;

	 end if;
    end if;
  end if;

end UploadPrimaryKey;

--
-- UploadPrimaryKeyColumn (PUBLIC))
--   Public procedure for afdict.lct to call when uploading primary key column
--   using afdict.lct.
--
procedure UploadPrimaryKeyColumn (
  x_application_short_name       in varchar2,
  x_table_name                   in varchar2,
  x_primary_key_name             in varchar2,
  x_primary_key_column_name      in varchar2,
  x_primary_key_column_sequence  in varchar2,
  x_user_id                      in varchar2,
  x_custom_mode 			   in varchar2,
  x_last_update_date 		   in varchar2
) is
  tab_id number;
  appl_id number;
  pk_id number;
  col_id number;
  f_luby    number;  -- entity owner in file
  f_ludate  date;    -- entity update date in file

begin

  -- No need to validate/check Application, Table or Primary Key.
  -- Within the same entity.
  select A.APPLICATION_ID
  into appl_id
  from FND_APPLICATION A
  where A.APPLICATION_SHORT_NAME = x_application_short_name;

  select T.TABLE_ID into tab_id from FND_TABLES T
  where T.APPLICATION_ID = appl_id
  and T.TABLE_NAME = x_table_name;

  select P.PRIMARY_KEY_ID into pk_id from FND_PRIMARY_KEYS P
  where P.APPLICATION_ID = appl_id
  and   P.TABLE_ID = tab_id
  and   P.PRIMARY_KEY_NAME = x_primary_key_name;

  begin
    select C.COLUMN_ID into col_id from FND_COLUMNS C
    where C.APPLICATION_ID = appl_id
    and   C.TABLE_ID = tab_id
    and   C.COLUMN_NAME = x_primary_key_column_name;
  exception
    when no_data_found then
      RAISE_APPLICATION_ERROR(
                   -20001, 'No data found Fnd columns column name  '
				   || x_primary_key_column_name || ' object type - primary key '
				   || x_primary_key_name, TRUE);
  end;

  -- Translate owner to file_last_updated_by
  f_luby := owner_id(x_user_id);

  -- Translate char last_update_date to date
  f_ludate := nvl(to_date(x_last_update_date, 'YYYY/MM/DD'), sysdate);

  -- NOTE: no "UPDATE" case as we have renamed all the existing
  -- primary key columns so that they can be compared against the new
  -- primary key columns from the data file to determine which will be
  -- updated into the database based on the date and custom factirs.

    begin
     insert into FND_PRIMARY_KEY_COLUMNS(
      APPLICATION_ID,
      TABLE_ID,
      PRIMARY_KEY_ID,
      COLUMN_ID,
      PRIMARY_KEY_SEQUENCE,
      LAST_UPDATED_BY,
      LAST_UPDATE_DATE,
      LAST_UPDATE_LOGIN,
      CREATION_DATE,
      CREATED_BY)
      values (
      appl_id,
      tab_id,
      pk_id,
      col_id,
      x_primary_key_column_sequence,
      f_luby,
      f_ludate,
      f_luby,
      f_ludate,
      f_luby);
     exception
      when dup_val_on_index then
	   RAISE_APPLICATION_ERROR(
                   -20001, 'Duplicate value on index - column sequence  '
				   || x_primary_key_column_name || ' object name - primary key name'
				   || x_primary_key_name, TRUE);
     end;

end UploadPrimaryKeyColumn;

--
-- UploadForeignKey (PUBLIC))
--   Public procedure for afdict.lct to call when uploading foreign key using
--   using afdict.lct.  It calls InsertForeign() when needed.
--
procedure UploadForeignKey (
  x_application_short_name       in varchar2,
  x_table_name                   in varchar2,
  x_foreign_key_name             in varchar2,
  x_primary_key_application_name in varchar2,
  x_primary_key_table_name       in varchar2,
  x_primary_key_name             in varchar2,
  x_description                  in varchar2,
  x_cascade_behavior             in varchar2,
  x_foreign_key_relation         in varchar2,
  x_condition                    in varchar2,
  x_enabled_flag                 in varchar2,
  x_user_id                      in varchar2,
  x_custom_mode 			   in varchar2,
  x_last_update_date 		   in varchar2,
  x_phase_mode			 in varchar2
) is
  tab_id number;
  appl_id number;
  pk_appl_id number;
  pk_tab_id number;
  pk_id number;
  f_luby    number;  -- entity owner in file
  f_ludate  date;    -- entity update date in file
  db_luby   number;  -- entity owner in db
  db_ludate date;    -- entity update date in db

                     -- Bug2631776 new variables to handle update.
  child_file_ludate date;   -- child entity update date in file
  child_file_luby   number; -- child owner in file
  child_db_ludate   date;   -- child update date in db
  child_db_luby     number; -- child owner in db
  fk_id	number;

begin

  select A.APPLICATION_ID
  into appl_id
  from FND_APPLICATION A
  where A.APPLICATION_SHORT_NAME = x_application_short_name;

  select T.TABLE_ID into tab_id from FND_TABLES T
  where T.APPLICATION_ID = appl_id
  and T.TABLE_NAME = x_table_name;

  -- Validate if primary key exists

  pk_id := -1;

  ValidatePrimaryKey(x_primary_key_application_name,
                    x_primary_key_table_name,
                    x_primary_key_name, pk_appl_id, pk_tab_id, pk_id);

  if (pk_id = -1) then
    pk_appl_id := -1;
    pk_tab_id := -1;

  end if;

if (x_phase_mode = 'BEGIN') then


  -- Translate owner to file_last_updated_by
  f_luby := owner_id(x_user_id);

  -- Translate char last_update_date to date
  f_ludate := nvl(to_date(x_last_update_date, 'YYYY/MM/DD'), sysdate);

  begin

    select FOREIGN_KEY_ID
    into fk_id
    from FND_FOREIGN_KEYS
    where APPLICATION_ID = appl_id
    and TABLE_ID = tab_id
    and FOREIGN_KEY_NAME = x_foreign_key_name;

    select LAST_UPDATED_BY, LAST_UPDATE_DATE
    into db_luby, db_ludate
    from FND_FOREIGN_KEYS
    where APPLICATION_ID = appl_id
    and TABLE_ID = tab_id
    and FOREIGN_KEY_NAME = x_foreign_key_name;

 if (upload_test(f_luby, f_ludate, db_luby,
                                  db_ludate, X_CUSTOM_MODE)) then

  update FND_FOREIGN_KEYS set
      PRIMARY_KEY_APPLICATION_ID = pk_appl_id,
      PRIMARY_KEY_TABLE_ID = pk_tab_id,
      PRIMARY_KEY_ID = pk_id,
      CASCADE_BEHAVIOR = x_cascade_behavior,
      FOREIGN_KEY_RELATION = x_foreign_key_relation,
      DESCRIPTION = x_description,
      CONDITION = x_condition,
      ENABLED_FLAG = x_enabled_flag,
      LAST_UPDATED_BY = f_luby,
      LAST_UPDATE_DATE = f_ludate,
      LAST_UPDATE_LOGIN = f_luby
  where APPLICATION_ID = appl_id
  and   TABLE_ID = tab_id
  and   FOREIGN_KEY_NAME = x_foreign_key_name;

 end if;

     -- Bug3230044 Delete any child records with a negative
     -- value for COLUMN_ID.

      delete from FND_FOREIGN_KEY_COLUMNS
       where APPLICATION_ID = appl_id
       and TABLE_ID = tab_id
       and FOREIGN_KEY_ID = fk_id
       and COLUMN_ID < 0;


      -- BUG2631776 rename the child record's FOREIGN_KEY_SEQUENCE
      -- and COLUMN_ID values to a negative value in order to
      -- prevent unique constraints while processing the
      -- PARENT/CHILD entity.

     update FND_FOREIGN_KEY_COLUMNS
      set FOREIGN_KEY_SEQUENCE = -1 * FOREIGN_KEY_SEQUENCE,
          COLUMN_ID = -1 * COLUMN_ID
     where APPLICATION_ID = appl_id
     and   TABLE_ID = tab_id
     and   FOREIGN_KEY_ID = fk_id;

      /*Bug3139883 - Handle special case where FOREIGN_KEY_SEQUENCE = 0 */

     update FND_FOREIGN_KEY_COLUMNS
      set FOREIGN_KEY_SEQUENCE = -1000
     where APPLICATION_ID = appl_id
     and   TABLE_ID = tab_id
     and   FOREIGN_KEY_ID = fk_id
     and FOREIGN_KEY_SEQUENCE = 0;

 exception
   when no_data_found then
    Fnd_XdfDictionary_Pkg.InsertForeignKey(
        appl_id,
        tab_id,
        x_foreign_key_name,
        pk_appl_id,
        pk_tab_id,
        pk_id,
        x_description,
        x_cascade_behavior,
        x_foreign_key_relation,
        x_condition,
        x_enabled_flag,
        f_ludate,
        f_luby,
        f_ludate,
        f_luby,
        0);
 end;

 else -- phase_mode = 'END'

    select FOREIGN_KEY_ID
    into fk_id
    from FND_FOREIGN_KEYS
    where APPLICATION_ID = appl_id
    and TABLE_ID = tab_id
    and FOREIGN_KEY_NAME = x_foreign_key_name;


  -- Bug2631776 get the latest value for the last update for the db entity
  -- and the file entity.

  select max(last_update_date)
    into child_db_ludate
    from fnd_foreign_key_columns
    where application_id = appl_id
    and table_id = tab_id
    and foreign_key_id = fk_id
    and foreign_key_sequence < 0
    and column_id < 0;

  -- Bug3139883 changed select to also include value if foreign_key_sequence =0

  select max(last_update_date)
    into child_file_ludate
    from fnd_foreign_key_columns
    where application_id = appl_id
    and table_id = tab_id
    and foreign_key_id = fk_id
    and foreign_key_sequence >= 0
    and column_id > 0;

   -- If no value which means there were no existing child records
   -- in the database therefore  skip to the end  since the new child
   -- records have been updated.

   if (child_db_ludate IS NULL) or (child_file_ludate IS NULL) then
      GOTO done_label;
   end if;

   -- Continue on to check the owner value since both have columns.

   -- Bug2631776 get the maximum value for the userid that made the
   -- last update for the db entity and the file entity.

       -- If any non-seed owners, set owner to user
       select max(-1)
       into child_db_luby
       from fnd_foreign_key_columns
          where application_id = appl_id
          and table_id = tab_id
          and foreign_key_id = fk_id
          and foreign_key_sequence < 0
          and column_id < 0
         and last_updated_by not in (0,1,2);

      if child_db_luby IS NULL then
         child_db_luby := 2;  -- All rows are seed data, set seed data owner
      end if;

       -- If any non-seed owners, set owner to user
       select max(-1)
       into child_file_luby
       from fnd_foreign_key_columns
         where application_id = appl_id
         and table_id = tab_id
         and foreign_key_id = fk_id
         and foreign_key_sequence > 0
         and column_id > 0
         and last_updated_by not in (0,1,2);

       if child_file_luby IS NULL then
         child_file_luby := 2;  -- All rows are seed data, set seed data owner
       end if;

   -- Bug2631776 perform check to see if update occurs or not.

   if (upload_test(child_file_luby, child_file_ludate, child_db_luby, child_db_ludate, x_custom_mode)) then

      -- The new child entity rows from the data file are  kept so
      -- delete the existing db child entity rows.

     delete from fnd_foreign_key_columns
     where application_id = appl_id
     and table_id = tab_id
     and foreign_key_id = fk_id
     and foreign_key_sequence < 0
     and column_id < 0;

    else

      -- The existing db child entity rows are kept so delete the new child
      -- entity rows from the data file
      -- Bug3139883 - Modified delete to include the value column_sequence = 0

     delete from fnd_foreign_key_columns
     where application_id = appl_id
     and table_id = tab_id
     and foreign_key_id = fk_id
     and foreign_key_sequence >= 0
     and column_id > 0;

	-- Rename the existing db entity rows back to normal since
        -- it was not replaced by the new child entity rows
        -- from the data file.

         update FND_FOREIGN_KEY_COLUMNS
             set FOREIGN_KEY_SEQUENCE = -1 * FOREIGN_KEY_SEQUENCE,
                  COLUMN_ID = -1 * COLUMN_ID
    		where APPLICATION_ID = appl_id
    		and   TABLE_ID = tab_id
    		and   FOREIGN_KEY_ID = fk_id;

        /*Bug3139883 - Handle special case where FOREIGN_KEY_SEQUENCE = 0 */

         update FND_FOREIGN_KEY_COLUMNS
             set FOREIGN_KEY_SEQUENCE = 0
                where APPLICATION_ID = appl_id
                and   TABLE_ID = tab_id
                and   FOREIGN_KEY_ID = fk_id
                and FOREIGN_KEY_SEQUENCE = 1000;

     end if;
    <<done_label>>

     -- check if the file has no child entries to clean up database.

     if (child_file_ludate IS NULL) then

        if (child_db_ludate IS NOT NULL) then

	  -- Rename the existing db entity rows back to normal since
        -- it was not replaced by the new child entity rows
        -- from the data file.

         update FND_FOREIGN_KEY_COLUMNS
             set FOREIGN_KEY_SEQUENCE = -1 * FOREIGN_KEY_SEQUENCE,
                  COLUMN_ID = -1 * COLUMN_ID
    		where APPLICATION_ID = appl_id
    		and   TABLE_ID = tab_id
    		and   FOREIGN_KEY_ID = fk_id;

       /*Bug3139883 - Handle special case where FOREIGN_KEY_SEQUENCE = 0 */

         update FND_FOREIGN_KEY_COLUMNS
             set FOREIGN_KEY_SEQUENCE = 0
                where APPLICATION_ID = appl_id
                and   TABLE_ID = tab_id
                and   FOREIGN_KEY_ID = fk_id
                and FOREIGN_KEY_SEQUENCE = 1000;

	 end if;
    end if;
  end if;
end UploadForeignKey;

--
-- UploadForeignKeyColumn (PUBLIC))
--   Public procedure for afdict.lct to call when uploading foreign key column
--   using afdict.lct.
--
procedure UploadForeignKeyColumn (
  x_application_short_name       in varchar2,
  x_table_name                   in varchar2,
  x_foreign_key_name             in varchar2,
  x_foreign_key_column_name      in varchar2,
  x_foreign_key_column_sequence  in varchar2,
  x_cascade_value                in varchar2,
  x_user_id                      in varchar2,
  x_custom_mode 			   in varchar2,
  x_last_update_date 		   in varchar2
) is
  tab_id number;
  appl_id number;
  fk_id number;
  col_id number;
  f_luby    number;  -- entity owner in file
  f_ludate  date;    -- entity update date in file

begin

  -- No need to validate/check Application, Table or Foreign Key.
  -- Within the same entity.
  select A.APPLICATION_ID
  into appl_id
  from FND_APPLICATION A
  where A.APPLICATION_SHORT_NAME = x_application_short_name;

  select T.TABLE_ID into tab_id from FND_TABLES T
  where T.APPLICATION_ID = appl_id
  and T.TABLE_NAME = x_table_name;

  select F.FOREIGN_KEY_ID into fk_id from FND_FOREIGN_KEYS F
  where F.APPLICATION_ID = appl_id
  and   F.TABLE_ID = tab_id
  and   F.FOREIGN_KEY_NAME = x_foreign_key_name;

  begin
    select C.COLUMN_ID into col_id from FND_COLUMNS C
    where C.APPLICATION_ID = appl_id
    and   C.TABLE_ID = tab_id
    and   C.COLUMN_NAME = x_foreign_key_column_name;
  exception
    when no_data_found then
	  RAISE_APPLICATION_ERROR(
                   -20001, 'No data found Fnd columns column name  '
				   || x_foreign_key_column_name || ' object type - foreign key '
				   || x_foreign_key_name, TRUE);
  end;

  -- Translate owner to file_last_updated_by
  f_luby := owner_id(x_user_id);

  -- Translate char last_update_date to date
  f_ludate := nvl(to_date(x_last_update_date, 'YYYY/MM/DD'), sysdate);

  -- NOTE: no "UPDATE" case as we have renamed all the existing
  -- foreign key columns so that they can be compared against the new
  -- foreign key columns from the data file to determine which will be
  -- updated into the database based on the date and custom factirs.


    begin
     insert into FND_FOREIGN_KEY_COLUMNS(
      APPLICATION_ID,
      TABLE_ID,
      FOREIGN_KEY_ID,
      COLUMN_ID,
      FOREIGN_KEY_SEQUENCE,
      CASCADE_VALUE,
      LAST_UPDATED_BY,
      LAST_UPDATE_DATE,
      LAST_UPDATE_LOGIN,
      CREATION_DATE,
      CREATED_BY)
      values (
      appl_id,
      tab_id,
      fk_id,
      col_id,
      x_foreign_key_column_sequence,
      x_cascade_value,
      f_luby,
      f_ludate,
      f_luby,
      f_ludate,
      f_luby);
     exception
      when dup_val_on_index then
	   RAISE_APPLICATION_ERROR(
                   -20001, 'Duplicate value on index column sequence  '
				   || x_foreign_key_column_sequence || ' object type - foreign key '
				   || x_foreign_key_name, TRUE);
     end;
end UploadForeignKeyColumn;


--
-- UploadSequence (PUBLIC))
--   Public procedure for afdict.lct to call when uploading sequence
--   using afdict.lct. It calls InsertSequence when needed.
--
procedure UploadSequence (
  x_application_short_name       in varchar2,
  x_sequence_name                in varchar2,
  x_start_value                  in varchar2,
  x_description                  in varchar2,
  x_increment_by                 in varchar2,
  x_min_value                    in varchar2,
  x_max_value                    in varchar2,
  x_cache_size                   in varchar2,
  x_cycle_flag                   in varchar2,
  x_order_flag                   in varchar2,
  x_user_id                      in varchar2,
  x_custom_mode 			   in varchar2,
  x_last_update_date 		   in varchar2
) is
  appl_id number;
  f_luby    number;  -- entity owner in file
  f_ludate  date;    -- entity update date in file
  db_luby   number;  -- entity owner in db
  db_ludate date;    -- entity update date in db
begin
  -- Validate Application.
  begin
    select A.APPLICATION_ID
    into appl_id
    from FND_APPLICATION A
    where A.APPLICATION_SHORT_NAME = x_application_short_name;

  exception
    when no_data_found then
       RAISE_APPLICATION_ERROR(
                   -20001, 'No data found Fnd application - application name   '
				   || x_application_short_name, TRUE);
  end;

  -- Translate owner to file_last_updated_by
  f_luby := owner_id(x_user_id);

  -- Translate char last_update_date to date
  f_ludate := nvl(to_date(x_last_update_date, 'YYYY/MM/DD'), sysdate);

 begin
    select LAST_UPDATED_BY, LAST_UPDATE_DATE
    into db_luby, db_ludate
    from FND_SEQUENCES
    where APPLICATION_ID = appl_id
    and SEQUENCE_NAME = x_sequence_name;

    if (upload_test(f_luby, f_ludate, db_luby,
                                  db_ludate, X_CUSTOM_MODE)) then


  -- Check if this is a new table or old table
  update FND_SEQUENCES set
      START_VALUE = x_start_value,
      DESCRIPTION = x_description,
      INCREMENT_BY = x_increment_by,
      MIN_VALUE = x_min_value,
      MAX_VALUE = x_max_value,
      CACHE_SIZE = x_cache_size,
      CYCLE_FLAG = x_cycle_flag,
      ORDER_FLAG = x_order_flag,
      LAST_UPDATED_BY = f_luby,
      LAST_UPDATE_DATE = f_ludate,
      LAST_UPDATE_LOGIN = f_luby
  where APPLICATION_ID = appl_id
  and   SEQUENCE_NAME = x_sequence_name;
 end if;
 exception
 when no_data_found then
    Fnd_XdfDictionary_Pkg.InsertSequence(
        appl_id,
        x_sequence_name,
        x_start_value,
        x_description,
        x_increment_by,
        x_min_value,
        x_max_value,
        x_cache_size,
        x_cycle_flag,
        x_order_flag,
        f_ludate,
        f_luby,
        f_ludate,
        f_luby,
        0);
 end;
end UploadSequence;

--
-- UploadView (PUBLIC))
--   Public procedure for afdict.lct to call when uploading view
--   using afdict.lct. It calls InsertView when needed.
--
procedure UploadView (
  x_application_short_name       in varchar2,
  x_view_name                    in varchar2,
  x_text                         in varchar2,
  x_description                  in varchar2,
  x_user_id                      in varchar2,
  x_custom_mode 			   in varchar2,
  x_last_update_date 		   in varchar2,
  x_phase_mode			 in varchar2
) is
  appl_id number;
  f_luby    number;  -- entity owner in file
  f_ludate  date;    -- entity update date in file
  db_luby   number;  -- entity owner in db
  db_ludate date;    -- entity update date in db
                     -- Bug2631776 new variables to handle update.
  child_file_ludate date;   -- child entity update date in file
  child_file_luby   number; -- child owner in file
  child_db_ludate   date;   -- child update date in db
  child_db_luby     number; -- child owner in db
  vw_id	number;
  first_char varchar2(1); -- first character in column_name

begin
  -- Validate Application
  begin
    select A.APPLICATION_ID
    into appl_id
    from FND_APPLICATION A
    where A.APPLICATION_SHORT_NAME = x_application_short_name;
  exception
    when no_data_found then
	  RAISE_APPLICATION_ERROR(
                   -20001, 'No data found Fnd application - application name   '
				   || x_application_short_name, TRUE);
  end;

  if (x_phase_mode = 'BEGIN') then

  -- Translate owner to file_last_updated_by
  f_luby := owner_id(x_user_id);

  -- Translate char last_update_date to date
  f_ludate := nvl(to_date(x_last_update_date, 'YYYY/MM/DD'), sysdate);

  begin

    select VIEW_ID
    into vw_id
    from fnd_views
    where application_id = appl_id
    and VIEW_NAME = x_view_name;

    select LAST_UPDATED_BY, LAST_UPDATE_DATE
    into db_luby, db_ludate
    from FND_VIEWS
    where APPLICATION_ID = appl_id
    and VIEW_NAME = x_view_name;

    if (upload_test(f_luby, f_ludate, db_luby,
                                  db_ludate, X_CUSTOM_MODE)) then

       update FND_VIEWS set
         TEXT = x_text,
         DESCRIPTION = x_description,
         LAST_UPDATED_BY = f_luby,
         LAST_UPDATE_DATE = f_ludate,
         LAST_UPDATE_LOGIN = f_luby
      where APPLICATION_ID = appl_id
       and   VIEW_NAME = x_view_name;
    end if;

  -- BUG2631776 rename the child record's COLUMN_SEQUENCE
  -- and COLUMN_NAME to in order to prevent unique
  -- constraints while processing the PARENT/CHILD entity.

     update FND_VIEW_COLUMNS
      set COLUMN_SEQUENCE = -1 * COLUMN_SEQUENCE,
          COLUMN_NAME = decode(instr(COLUMN_NAME,'_'),0,concat('#',COLUMN_NAME),
                                                 replace(COLUMN_NAME, '_','#'))
     where APPLICATION_ID = appl_id
     and   VIEW_ID = vw_id;

 exception
  when no_data_found then
    Fnd_XdfDictionary_Pkg.InsertView(
        appl_id,
        x_view_name,
        x_text,
        x_description,
        f_ludate,
        f_luby,
        f_ludate,
        f_luby,
        0);
 end;

 else -- phase_mode = 'END'

    select VIEW_ID
    into vw_id
    from fnd_views
    where application_id = appl_id
    and VIEW_NAME = x_view_name;

  -- Bug2631776 get the latest value for the last update for the db entity
  -- and the file entity.

  select max(last_update_date)
    into child_db_ludate
    from fnd_view_columns
    where application_id = appl_id
    and VIEW_ID = vw_id
    and column_sequence < 0;

  select max(last_update_date)
    into child_file_ludate
    from fnd_view_columns
    where application_id = appl_id
    and VIEW_ID = vw_id
    and column_sequence > 0;

   -- If no value which means there were no existing child records
   -- in the database therefore  skip to the end  since the new child
   -- records have been updated.

   if (child_db_ludate IS NULL) or (child_file_ludate IS NULL) then
      GOTO done_label;
   end if;

   -- Continue on to check the owner value since both have columns.

   -- Bug2631776 get the maximum value for the userid that made the
   -- last update for the db entity and the file entity.

       -- If any non-seed owners, set owner to user
       select max(-1)
       into child_db_luby
       from fnd_view_columns
         where application_id = appl_id
         and VIEW_ID = vw_id
         and column_sequence < 0
         and last_updated_by not in (0,1,2);

       if child_db_luby IS NULL then
         child_db_luby := 2;  -- All rows are seed data, set seed data owner
       end if;

       -- If any non-seed owners, set owner to user
       select max(-1)
       into child_file_luby
       from fnd_view_columns
          where application_id = appl_id
          and VIEW_ID = vw_id
          and column_sequence > 0
         and last_updated_by not in (0,1,2);

       if child_file_luby IS NULL then
         child_file_luby := 2;  -- All rows are seed data, set seed data owner
       end if;

   -- Bug2631776 perform check to see if update occurs or not.

   if (upload_test(child_file_luby, child_file_ludate, child_db_luby, child_db_ludate, x_custom_mode)) then

      -- The new child entity rows from the data file are  kept so
      -- delete the existing db child entity rows.

         delete from fnd_view_columns
         where application_id = appl_id
         and VIEW_ID = vw_id
         and column_sequence < 0;

     else

      -- The existing db child entity rows are kept so delete the new child
      -- entity rows from the data file

         delete from fnd_view_columns
         where application_id = appl_id
         and VIEW_ID = vw_id
         and column_sequence > 0;

	-- Rename the existing db entity rows back to normal since
        -- it was not replaced by the new child entity rows
        -- from the data file.

        update FND_VIEW_COLUMNS
        set COLUMN_SEQUENCE = -1 * COLUMN_SEQUENCE,
         COLUMN_NAME = decode(instr(COLUMN_NAME, '#'),1,ltrim(COLUMN_NAME, '#'),
                                                  replace(COLUMN_NAME, '#','_'))
         where APPLICATION_ID = appl_id
    	 and   VIEW_ID = vw_id;

     end if;
    <<done_label>>

     -- check if the file has no child entries to clean up database.

     if (child_file_ludate IS NULL) then

        if (child_db_ludate IS NOT NULL) then

	-- Rename the existing db entity rows back to normal since
        -- it was not replaced by the new child entity rows
        -- from the data file.

         update FND_VIEW_COLUMNS
         set COLUMN_SEQUENCE = -1 * COLUMN_SEQUENCE,
         COLUMN_NAME = decode(instr(COLUMN_NAME, '#'),1,ltrim(COLUMN_NAME, '#'),
                                                  replace(COLUMN_NAME, '#','_'))
    	 where APPLICATION_ID = appl_id
    	 and   VIEW_ID = vw_id;
	end if;
    end if;
  end if;
end UploadView;

--
-- UploadViewColumn (PUBLIC))
--   Public procedure for afdict.lct to call when uploading view column
--   using afdict.lct.
--
procedure UploadViewColumn (
  x_application_short_name       in varchar2,
  x_view_name                    in varchar2,
  x_view_column_name             in varchar2,
  x_view_column_sequence         in varchar2,
  x_user_id                      in varchar2,
  x_custom_mode 			   in varchar2,
  x_last_update_date 		   in varchar2
) is
  appl_id number;
  vw_id number;
  f_luby    number;  -- entity owner in file
  f_ludate  date;    -- entity update date in file
begin

  -- No need to validate/check Application and View.
  -- Within the same entity.
  select A.APPLICATION_ID
  into appl_id
  from FND_APPLICATION A
  where A.APPLICATION_SHORT_NAME = x_application_short_name;

  select V.VIEW_ID into vw_id from FND_VIEWS V
  where V.APPLICATION_ID = appl_id
  and V.VIEW_NAME = x_view_name;

  -- Translate owner to file_last_updated_by
  f_luby := owner_id(x_user_id);

  -- Translate char last_update_date to date
  f_ludate := nvl(to_date(x_last_update_date, 'YYYY/MM/DD'), sysdate);

  -- NOTE: no "UPDATE" case as we have renamed all the existing
  -- view columns so that they can be compared against the new
  -- view columns from the data file to determine which will be
  -- updated into the database based on the date and custom factirs.

   begin
    insert into FND_VIEW_COLUMNS(
      APPLICATION_ID,
      VIEW_ID,
      COLUMN_SEQUENCE,
      COLUMN_NAME,
      LAST_UPDATED_BY,
      LAST_UPDATE_DATE,
      LAST_UPDATE_LOGIN,
      CREATION_DATE,
      CREATED_BY)
      values (
      appl_id,
      vw_id,
      x_view_column_sequence,
      x_view_column_name,
      f_luby,
      f_ludate,
      f_luby,
      f_ludate,
      f_luby);
   exception
    when dup_val_on_index then
	  RAISE_APPLICATION_ERROR(
                   -20001, ' Duplicate value on index column sequence -  '
				   || x_view_column_sequence || ' Object Name '
				   || x_view_name, TRUE);
  end;
end UploadViewColumn;

--
-- OWNER_ID
--   Return the user_id of the OWNER attribute
-- IN
--   p_name - OWNER attribute value from FNDLOAD data file
-- RETURNS
--   user_id of owner to use in who columns
--

function OWNER_ID(
  p_name in varchar2)
return number is
l_user_id number;
begin
  if (p_name in ('SEED','CUSTOM')) then
    -- Old loader seed data
    return 1;
  elsif (p_name = 'ORACLE') then
    -- New loader seed data
    return 2;
  elsif (p_name = 'ORACLE12.0.0') then
    -- R12 seed data
    return 120;
  else
   begin
    -- User customized data
    select user_id
     into l_user_id
     from fnd_user
    where p_name = user_name;
     return l_user_id;
    exception
     when no_data_found then
        return -1;
   end;
  end if;
end OWNER_ID;


function UPLOAD_TEST(
  p_file_id     in number,
  p_file_lud    in date,
  p_db_id       in number,
  p_db_lud      in date,
  p_custom_mode in varchar2)
return boolean is
  l_db_id number;
  l_file_id number;
  l_original_seed_data_window date;
  retcode boolean;
begin
  -- CUSTOM_MODE=FORCE trumps all.
  if (p_custom_mode = 'FORCE') then
    retcode := TRUE;
    return retcode;
  end if;

  -- Handle cases where data was previously up/downloaded with
  -- 'SEED'/1 owner instead of 'ORACLE'/2, but DOES have a version
  -- date.  These rows can be distinguished by the lud timestamp;
  -- Rows without versions were uploaded with sysdate, rows with
  -- versions were uploaded with a date (with time truncated) from
  -- the file.

  -- Check file row for SEED/version
  l_file_id := p_file_id;
  if ((l_file_id in (0,1)) and (p_file_lud = trunc(p_file_lud)) and
      (p_file_lud < sysdate - .1)) then
    l_file_id := 2;
  end if;

  -- Check db row for SEED/version.
  -- NOTE: if db ludate < seed_data_window, then consider this to be
  -- original seed data, never touched by FNDLOAD, even if it doesn't
  -- have a timestamp.
  l_db_id := p_db_id;
  l_original_seed_data_window := to_date('01/01/1990','MM/DD/YYYY');
  if ((l_db_id in (0,1)) and (p_db_lud = trunc(p_db_lud)) and
      (p_db_lud > l_original_seed_data_window)) then
    l_db_id := 2;
  end if;

  if (l_file_id in (0,1)) then
    -- File owner is old FNDLOAD.
    if (l_db_id in (0,1)) then
      -- DB owner is also old FNDLOAD.
      -- Over-write, but only if file ludate >= db ludate.
      if (p_file_lud >= p_db_lud) then
        retcode := TRUE;
      else
        retcode := FALSE;
      end if;
    else
      retcode := FALSE;
    end if;
  elsif (l_file_id = 2) then
    -- File owner is new FNDLOAD.  Over-write if:
    -- 1. Db owner is old FNDLOAD, or
    -- 2. Db owner is new FNDLOAD, and file date >= db date
    if ((l_db_id in (0,1)) or
	((l_db_id = 2) and (p_file_lud >= p_db_lud))) then
      retcode :=  TRUE;
    else
      retcode := FALSE;
    end if;
  elsif (l_file_id = 120) then
    -- File owner is R12 seed data, Over-write if:
    -- 1. Db owner is (0, 1, 2), or
    -- 2. Db owner is 120, and file date >= db date
    if ((l_db_id in (0,1,2)) or
	((l_db_id = 120) and (p_file_lud >= p_db_lud))) then
      retcode :=  TRUE;
    else
      retcode := FALSE;
    end if;
  else
    -- File owner is USER.  Over-write if:
    -- 1. Db owner is old or new FNDLOAD, or
    -- 2. File date >= db date
    if ((l_db_id in (0,1,2,120)) or
	(trunc(p_file_lud) >= trunc(p_db_lud))) then
      retcode := TRUE;
    else
      retcode := FALSE;
    end if;
  end if;

  /*
  if (retcode = FALSE) then
    fnd_message.set_name('FND', 'FNDLOAD_CUSTOMIZED');
  end if;
  */
  return retcode;
end UPLOAD_TEST;

/* To load fnd_object_Tablespace */
 Procedure LOAD_ROW (
 P_APPLICATION_ID in NUMBER,
 P_OBJECT_NAME in VARCHAR2,
 P_OBJECT_TYPE in VARCHAR2,
 P_TABLESPACE_TYPE in VARCHAR2,
 P_CUSTOM_TABLESPACE_TYPE in VARCHAR2,
 P_OBJECT_SOURCE   in  VARCHAR2,
 P_ORACLE_USERNAME  in VARCHAR2,
 P_CUSTOM_FLAG in VARCHAR2,
 P_LAST_UPDATED_BY in VARCHAR2,
 P_CUSTOM_MODE in VARCHAR2,
 P_LAST_UPDATE_DATE in VARCHAR2
 ) is
 man_id  number;
 row_id  varchar2(64);
 f_luby    number;  -- entity owner in file
 f_ludate  date;    -- entity update date in file
 db_luby   number;  -- entity owner in db
 db_ludate date;    -- entity update date in db
begin
  -- Translate owner to file_last_updated_by
    f_luby := owner_id(P_LAST_UPDATED_BY);

 -- Translate char last_update_date to date
   f_ludate := nvl(to_date(P_last_update_date, 'YYYY/MM/DD'), sysdate);

  select last_updated_by, last_update_date
  into  db_luby, db_ludate
  from FND_OBJECT_TABLESPACES
  where object_name = P_OBJECT_NAME
  and   application_id =P_application_id
  and   object_type =P_object_type;

 if (upload_test(f_luby, f_ludate, db_luby,db_ludate, P_CUSTOM_MODE)) then

 Fnd_XdfDictionary_pkg.UPDATE_ROW (
    P_APPLICATION_ID      => P_application_id,
    P_OBJECT_NAME       => P_OBJECT_NAME,
    P_OBJECT_TYPE          => P_OBJECT_TYPE,
   P_TABLESPACE_TYPE    => P_TABLESPACE_TYPE,
   P_CUSTOM_TABLESPACE_TYPE    => P_CUSTOM_TABLESPACE_TYPE,
   P_OBJECT_SOURCE    => P_OBJECT_SOURCE ,
   P_ORACLE_USERNAME    =>     P_ORACLE_USERNAME ,
   P_CUSTOM_FLAG =>  P_CUSTOM_FLAG,
   P_LAST_UPDATE_DATE      => f_ludate,
   P_LAST_UPDATED_BY     => f_luby,
   P_LAST_UPDATE_LOGIN => 0 );
  end if;

   exception
when NO_DATA_FOUND then

   -- select fnd_menus_s.nextval into man_id from dual;
 --select FND_OBJECT_TABLESPACES_S.nextval into man_id from duaL;

Fnd_XdfDictionary_pkg.INSERT_ROW(
  X_ROWID => ROW_ID,
  P_APPLICATION_ID         => P_application_id,
  P_OBJECT_NAME            => P_OBJECT_NAME,
  P_OBJECT_TYPE            => P_OBJECT_TYPE,
  P_TABLESPACE_TYPE        => P_TABLESPACE_TYPE,
  P_CUSTOM_TABLESPACE_TYPE => P_CUSTOM_TABLESPACE_TYPE,
  P_OBJECT_SOURCE          => P_OBJECT_SOURCE ,
  P_ORACLE_USERNAME        => P_ORACLE_USERNAME ,
  P_CUSTOM_FLAG          => P_CUSTOM_FLAG,
  P_CREATION_DATE          => f_ludate,
  P_CREATED_BY             => f_luby,
  P_LAST_UPDATE_DATE       => f_ludate,
  P_LAST_UPDATED_BY        => f_luby,
  P_LAST_UPDATE_LOGIN      => 0 );

end LOAD_ROW;

procedure INSERT_ROW (
  X_ROWID IN OUT  NOCOPY VARCHAR2 ,
  P_APPLICATION_ID IN NUMBER,
  P_OBJECT_NAME IN VARCHAR2,
  P_OBJECT_TYPE IN VARCHAR2,
  P_TABLESPACE_TYPE IN VARCHAR2,
  P_CUSTOM_TABLESPACE_TYPE IN VARCHAR2,
  P_OBJECT_SOURCE   IN  VARCHAR2,
  P_ORACLE_USERNAME  IN VARCHAR2,
  P_CUSTOM_FLAG IN VARCHAR2,
  P_CREATION_DATE IN DATE,
  P_CREATED_BY IN NUMBER,
  P_LAST_UPDATE_DATE IN DATE,
  P_LAST_UPDATED_BY IN NUMBER,
  P_LAST_UPDATE_LOGIN IN NUMBER
) is
  cursor C is select ROWID from FND_OBJECT_TABLESPACES
         where APPLICATION_ID = P_APPLICATION_ID
         and  object_name =P_object_name
         and  object_type=P_object_type ;

 begin
   insert into FND_OBJECT_TABLESPACES (
     APPLICATION_ID,
     OBJECT_NAME,
     OBJECT_TYPE,
     TABLESPACE_TYPE,
     CUSTOM_TABLESPACE_TYPE,
     OBJECT_SOURCE ,
     ORACLE_USERNAME,
     CUSTOM_FLAG ,
     CREATION_DATE,
     CREATED_BY,
     LAST_UPDATE_DATE,
     LAST_UPDATED_BY,
     LAST_UPDATE_LOGIN
  ) values (
     P_APPLICATION_ID,
     P_OBJECT_NAME,
     P_OBJECT_TYPE,
     P_TABLESPACE_TYPE,
     P_CUSTOM_TABLESPACE_TYPE,
     P_OBJECT_SOURCE ,
     P_ORACLE_USERNAME,
     P_CUSTOM_FLAG ,
     P_CREATION_DATE,
     P_CREATED_BY,
     P_LAST_UPDATE_DATE,
     P_LAST_UPDATED_BY,
     P_LAST_UPDATE_LOGIN
  );


 end INSERT_ROW;

 procedure LOCK_ROW (
    P_APPLICATION_ID in NUMBER,
    P_OBJECT_NAME in VARCHAR2,
    P_OBJECT_TYPE in VARCHAR2,
    P_TABLESPACE_TYPE in VARCHAR2) is
  cursor c is select OBJECT_NAME, OBJECT_TYPE
            from FND_OBJECT_TABLESPACES
            where APPLICATION_ID = P_APPLICATION_ID
            for update of APPLICATION_ID nowait;
  recinfo c%rowtype;
  begin
      open c;
      fetch c into recinfo;
      if (c%notfound) then
          close c;
           RAISE_APPLICATION_ERROR(
                   -20001, 'Fnd Form record deleted ' , TRUE);
      end if;
      close c;
      if (    (recinfo.OBJECT_NAME = P_OBJECT_NAME)
              AND ((recinfo.OBJECT_TYPE = P_OBJECT_TYPE)
              OR ((recinfo.OBJECT_TYPE is null) AND (P_OBJECT_TYPE is null)))) then
          null;
      else
          RAISE_APPLICATION_ERROR(
                   -20001, 'Form record change ' , TRUE);
      end if;

      return;
  end LOCK_ROW;

  procedure UPDATE_ROW (
  P_APPLICATION_ID in NUMBER,
  P_OBJECT_NAME in VARCHAR2,
  P_OBJECT_TYPE in VARCHAR2,
  P_TABLESPACE_TYPE in VARCHAR2,
  P_CUSTOM_TABLESPACE_TYPE in VARCHAR2,
  P_OBJECT_SOURCE   in  VARCHAR2,
  P_ORACLE_USERNAME  in VARCHAR2,
  P_CUSTOM_FLAG in VARCHAR2,
  P_LAST_UPDATE_DATE in DATE,
  P_LAST_UPDATED_BY in NUMBER,
  P_LAST_UPDATE_LOGIN in NUMBER
  ) is
  begin
 update FND_OBJECT_TABLESPACES set
    OBJECT_NAME = P_OBJECT_NAME,
    OBJECT_TYPE = P_OBJECT_TYPE,
    TABLESPACE_TYPE = P_TABLESPACE_TYPE,
    CUSTOM_TABLESPACE_TYPE = P_CUSTOM_TABLESPACE_TYPE,
    OBJECT_SOURCE= P_OBJECT_SOURCE,
    ORACLE_USERNAME=P_ORACLE_USERNAME,
    CUSTOM_FLAG =  P_CUSTOM_FLAG,
    LAST_UPDATE_DATE = P_LAST_UPDATE_DATE,
    LAST_UPDATED_BY = P_LAST_UPDATED_BY,
    LAST_UPDATE_LOGIN = P_LAST_UPDATE_LOGIN
    where APPLICATION_ID = P_APPLICATION_ID
    and object_name =P_object_name;

  if (sql%notfound) then
     raise no_data_found;
  end if;


end UPDATE_ROW;

end Fnd_XdfDictionary_Pkg;


1 linha selecionada.

04:11:23 E2NXTL03.IT_PNET3>spool off;
