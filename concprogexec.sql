col EXECUTION_FILE_NAME format a40
col EXECUTION_FILE_PATH format a40 truncate

Select EXECUTABLE_NAME
     , EXECUTION_FILE_NAME 
     , EXECUTION_FILE_PATH
 From apps.fnd_executables 
Where executable_name ='&executable_name';