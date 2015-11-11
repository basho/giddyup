BEGIN;

-- From https://github.com/basho/riak_test/pull/927
UPDATE tests set name = 'ts_A_select_unexpected_token_not_allowed' where name = 'ts_A_select_fail_2';
UPDATE tests set name = 'ts_A_select_missing_field_in_pk_not_allowed' where name = 'ts_A_select_fail_3';
UPDATE tests set name = 'ts_A_select_incompatible_type_integer_not_allowed' where name = 'ts_A_select_fail_4';
UPDATE tests set name = 'ts_A_select_compare_two_fields_not_allowed' where name = 'ts_A_select_fail_5';
UPDATE tests set name = 'ts_A_select_incompatible_type_float_not_allowed' where name = 'ts_A_select_fail_6';
UPDATE tests set name = 'ts_A_select_where_has_no_lower_bounds_not_allowed' where name = 'ts_A_select_fail_7_where_has_no_lower_bounds';
UPDATE tests set name = 'ts_A_select_where_has_no_upper_bounds_not_allowed' where name = 'ts_A_select_fail_8_where_has_no_upper_bounds';

COMMIT;
