BEGIN;

-- Add in the new ones
WITH newtests AS (INSERT INTO tests (name, platform, backend) VALUES
    ('ts_A_create_table_fail_3a','centos-6-64','eleveldb'),
    ('ts_A_put_fail_3_bad_date','centos-6-64','eleveldb'),
    ('ts_A_put_pass_2','centos-6-64','eleveldb'),
    ('ts_A_select_fail_7_where_has_no_lower_bounds','centos-6-64','eleveldb'),
    ('ts_A_select_fail_8_where_has_no_upper_bounds','centos-6-64','eleveldb'),
    ('ts_B_select_pass_2','centos-6-64','eleveldb'),
    ('ts_B_select_pass_3_sorted_on_key','centos-6-64','eleveldb'),
    ('ts_C_select_pass_1','centos-6-64','eleveldb'),
    ('ts_C_select_pass_2','centos-6-64','eleveldb')
RETURNING id)

-- Patch up the tests/projects
INSERT INTO projects_tests (project_id, test_id)
   SELECT projects.id, newtests.id FROM projects, newtests
    WHERE projects.name = 'riak_ts';

COMMIT;
