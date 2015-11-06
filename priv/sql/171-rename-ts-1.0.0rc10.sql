BEGIN;

-- From https://github.com/basho/riak_test/pull/923
UPDATE tests set name = 'ts_A_get_simple' where name = 'ts_A_create_table_fail_3';
UPDATE tests set name = 'ts_A_get_not_found' where name = 'ts_A_create_table_fail_3a';
UPDATE tests set name = 'ts_A_put_simple' where name = 'ts_A_put_pass_1';
UPDATE tests set name = 'ts_A_put_all_datatypes' where name = 'ts_A_put_pass_2';
UPDATE tests set name = 'ts_A_put_non_existent_bucket' where name = 'ts_A_put_fail_1';
UPDATE tests set name = 'ts_A_put_invalid_data' where name = 'ts_A_put_fail_2';
UPDATE tests set name = 'ts_A_put_bad_date' where name = 'ts_A_put_fail_3_bad_date';
UPDATE tests set name = 'ts_A_select_simple' where name = 'ts_A_select_pass_1';
UPDATE tests set name = 'ts_A_select_not_found' where name = 'ts_A_select_pass_2';

COMMIT;
