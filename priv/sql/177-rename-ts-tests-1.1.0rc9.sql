BEGIN;

-- Add in the new ones
WITH newtests AS (INSERT INTO tests (name, platform, backend) VALUES
    ('ts_degraded_aggregation','centos-6-64','eleveldb'),
    ('ts_cluster_create_table_via_sql','centos-6-64','eleveldb'),
    ('ts_cluster_coverage','centos-6-64','eleveldb')
RETURNING id)

-- Patch up the tests/projects
INSERT INTO projects_tests (project_id, test_id)
   SELECT projects.id, newtests.id FROM projects, newtests
    WHERE projects.name = 'riak_ts';

-- From https://github.com/basho/riak_test/pull/973
UPDATE tests set name = 'ts_cluster_activate_table_pass_1' where name = 'ts_B_activate_table_pass_1';
UPDATE tests set name = 'ts_cluster_aggregation' where name = 'ts_aggregation_cluster';
UPDATE tests set name = 'ts_cluster_comprehensive' where name = 'ts_basic';
UPDATE tests set name = 'ts_cluster_create_table_pass_1' where name = 'ts_B_create_table_pass_1';
UPDATE tests set name = 'ts_cluster_put_pass_1' where name = 'ts_B_put_pass_1';
UPDATE tests set name = 'ts_cluster_random_query_pass_eqc' where name = 'ts_B_random_query_pass_eqc';
UPDATE tests set name = 'ts_cluster_select_pass_1' where name = 'ts_B_select_pass_1';
UPDATE tests set name = 'ts_cluster_select_pass_2' where name = 'ts_B_select_pass_2';
UPDATE tests set name = 'ts_cluster_select_pass_3_sorted_on_key' where name = 'ts_B_select_pass_3_sorted_on_key';
UPDATE tests set name = 'ts_cluster_unicode' where name = 'ts_unicode';
UPDATE tests set name = 'ts_degraded_activate_table_fail_1' where name = 'ts_C_activate_table_fail_1';
UPDATE tests set name = 'ts_degraded_select_pass_1' where name = 'ts_C_select_pass_1';
UPDATE tests set name = 'ts_degraded_select_pass_2' where name = 'ts_C_select_pass_2';
UPDATE tests set name = 'ts_simple_activate_table_pass_1' where name = 'ts_A_activate_table_pass_1';
UPDATE tests set name = 'ts_simple_activate_table_pass_2' where name = 'ts_A_activate_table_pass_2';
UPDATE tests set name = 'ts_simple_aggregation' where name = 'ts_aggregation_simple';
UPDATE tests set name = 'ts_simple_aggregation_fail' where name = 'ts_aggregation_fail';
UPDATE tests set name = 'ts_simple_aggregation_math' where name = 'ts_aggregation_math';
UPDATE tests set name = 'ts_simple_api' where name = 'ts_api';
UPDATE tests set name = 'ts_simple_create_table_already_created' where name = 'ts_A_create_table_already_created';
UPDATE tests set name = 'ts_simple_create_table_dup_primary_key' where name = 'ts_A_create_table_dup_primary_key';
UPDATE tests set name = 'ts_simple_create_table_no_primary_key' where name = 'ts_A_create_table_no_primary_key';
UPDATE tests set name = 'ts_simple_create_table_not_null_pk_fields' where name = 'ts_A_create_table_not_null_pk_fields';
UPDATE tests set name = 'ts_simple_create_table_pass_1' where name = 'ts_A_create_table_pass_1';
UPDATE tests set name = 'ts_simple_create_table_short_key' where name = 'ts_A_create_table_short_key';
UPDATE tests set name = 'ts_simple_create_table_split_key' where name = 'ts_A_create_table_split_key';
UPDATE tests set name = 'ts_simple_describe_table' where name = 'ts_describe_table';
UPDATE tests set name = 'ts_simple_get' where name = 'ts_A_get_simple';
UPDATE tests set name = 'ts_simple_get_not_found' where name = 'ts_A_get_not_found';
UPDATE tests set name = 'ts_simple_latin1_create_table_not_allowed' where name = 'ts_latin1_create_table_not_allowed';
UPDATE tests set name = 'ts_simple_put' where name = 'ts_A_put_simple';
UPDATE tests set name = 'ts_simple_put_all_datatypes' where name = 'ts_A_put_all_datatypes';
UPDATE tests set name = 'ts_simple_put_all_null_datatypes' where name = 'ts_A_put_all_null_datatypes';
UPDATE tests set name = 'ts_simple_put_bad_date' where name = 'ts_A_put_bad_date';
UPDATE tests set name = 'ts_simple_put_invalid_data' where name = 'ts_A_put_invalid_data';
UPDATE tests set name = 'ts_simple_put_non_existent_bucket' where name = 'ts_A_put_non_existent_bucket';
UPDATE tests set name = 'ts_simple_select' where name = 'ts_A_select_simple';
UPDATE tests set name = 'ts_simple_select_compare_two_fields_not_allowed' where name = 'ts_A_select_compare_two_fields_not_allowed';
UPDATE tests set name = 'ts_simple_select_double_in_key' where name = 'ts_A_select_double_in_key';
UPDATE tests set name = 'ts_simple_select_incompatible_type_float_not_allowed' where name = 'ts_A_select_incompatible_type_float_not_allowed';
UPDATE tests set name = 'ts_simple_select_incompatible_type_integer_not_allowed' where name = 'ts_A_select_incompatible_type_integer_not_allowed';
UPDATE tests set name = 'ts_simple_select_missing_field_in_pk_not_allowed' where name = 'ts_A_select_missing_field_in_pk_not_allowed';
UPDATE tests set name = 'ts_simple_select_not_found' where name = 'ts_A_select_not_found';
UPDATE tests set name = 'ts_simple_select_unexpected_token_not_allowed' where name = 'ts_A_select_unexpected_token_not_allowed';
UPDATE tests set name = 'ts_simple_select_where_has_no_lower_bounds_not_allowed' where name = 'ts_A_select_where_has_no_lower_bounds_not_allowed';
UPDATE tests set name = 'ts_simple_select_where_has_no_upper_bounds_not_allowed' where name = 'ts_A_select_where_has_no_upper_bounds_not_allowed';
UPDATE tests set name = 'ts_simple_unicode_create_table_not_allowed' where name = 'ts_unicode_create_table_not_allowed';

COMMIT;
