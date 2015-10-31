BEGIN;

UPDATE tests set name = 'ts_A_create_table_short_key' where name = 'ts_A_create_table_fail_1';
UPDATE tests set name = 'ts_A_create_table_split_key' where name = 'ts_A_create_table_fail_2';
UPDATE tests set name = 'ts_A_create_table_already_created' where name = 'ts_A_create_table_fail_4';

COMMIT;
