BEGIN;

-- Rename existing tests
UPDATE tests set name = 'ts_cluster_riak_shell_basic_sql' WHERE name = 'ts_riak_shell_basic_sql';
UPDATE tests set name = 'ts_cluster_keys_SUITE' WHERE name = 'ts_simple_create_table_short_key';
UPDATE tests set name = 'ts_cluster_create_table_via_sql_SUITE' WHERE name = 'ts_cluster_create_table_via_sql';

-- Add in the new ones
WITH newtests AS (INSERT INTO tests (name, platform, backend) VALUES
    ('ts_cluster_riak_shell_regression_log','centos-6-64','eleveldb'),
    ('ts_simple_insert','centos-6-64','eleveldb'),
    ('ts_simple_insert_incorrect_columns','centos-6-64','eleveldb'),
    ('ts_simple_activate_table_pass_2','centos-6-64','eleveldb'),
    ('ts_cluster_http','centos-6-64','eleveldb'),
    ('ts_simple_recompile_ddl','centos-6-64','eleveldb'),
    ('ts_http_api_SUITE','centos-6-64','eleveldb'),
    ('ts_cluster_quantum_boundaries_SUITE','centos-6-64','eleveldb'),
    ('ts_updown_select_SUITE','centos-6-64','eleveldb'),
    ('ts_simple_batch','centos-6-64','eleveldb'),
    ('ts_simple_create_table_eqc','centos-6-64','eleveldb')
RETURNING id)


-- Patch up the tests/projects
INSERT INTO projects_tests (project_id, test_id)
   SELECT projects.id, newtests.id FROM projects, newtests
    WHERE projects.name IN ('riak_ts','riak_ts_ee');

COMMIT;
