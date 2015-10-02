BEGIN;

UPDATE tests set name = 'ts_A_select_pass_2' where name = 'ts_A_put_fail_3';

COMMIT;
