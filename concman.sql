--------------------------------------------------------------------------------
-- Concurrent Managers
--
-- Usage:
--    @concman
--
-- Pra que serve?
--    Para verificar se os gerenciadores estão ativos.
--    Lista os Gerenciadores de concurrent e o no. de processos ativos.
--
--------------------------------------------------------------------------------

col target_node format a12
col USER_CONCURRENT_QUEUE_NAME format a40 truncate

Select target_node, user_concurrent_queue_name
     , target_processes
     , max_processes
     , running_processes
  From apps.fnd_concurrent_queues_vl
 Where enabled_flag = 'Y'
   And target_processes > 0
 Order by Decode(application_id, 0, Decode(concurrent_queue_id, 1, 1, 4, 2))
        , sign(max_processes) desc
        , concurrent_queue_name
        , application_id;