BEGIN;

UPDATE tests set name = 'ts_cluster_riak_shell_basic_sql' where name = 'ts_cluster_riak_shell_sql_SUITE';

COMMIT;
