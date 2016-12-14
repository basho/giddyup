
BEGIN;

UPDATE tests set name = 'ts_cluster_riak_shell_sql_SUITE' where name = 'ts_cluster_riak_shell_basic_sql';

COMMIT;