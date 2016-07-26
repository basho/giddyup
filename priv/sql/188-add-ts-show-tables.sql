BEGIN;

-- From https://github.com/basho/riak_test/pull/1110
UPDATE tests set name = 'ts_simple_show_tables' where name = 'ts_simple_create_table_eqc';

COMMIT;
