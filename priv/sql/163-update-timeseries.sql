BEGIN;

-- Add in the new ones
WITH newtests AS (INSERT INTO tests (name, platform, backend) VALUES
    ('ts_A_create_table_fail_2','centos-6-64','eleveldb'),
    ('ts_A_create_table_fail_3','centos-6-64','eleveldb'),
    ('ts_A_create_table_fail_4','centos-6-64','eleveldb'),
    ('ts_A_select_fail_1','centos-6-64','eleveldb'),
    ('ts_A_select_fail_2','centos-6-64','eleveldb'),
    ('ts_A_select_fail_3','centos-6-64','eleveldb'),
    ('ts_A_select_fail_4','centos-6-64','eleveldb'),
    ('ts_A_select_fail_5','centos-6-64','eleveldb'),
    ('ts_A_select_fail_6','centos-6-64','eleveldb'),
    ('ts_B_activate_table_pass_1','centos-6-64','eleveldb'),
    ('ts_B_create_table_pass_1','centos-6-64','eleveldb'),
    ('ts_B_put_pass_1','centos-6-64','eleveldb'),
    ('ts_B_select_pass_1','centos-6-64','eleveldb'),
    ('ts_C_activate_table_fail_1','centos-6-64','eleveldb')
RETURNING id)

-- Patch up the tests/projects
INSERT INTO projects_tests (project_id, test_id)
   SELECT projects.id, newtests.id FROM projects, newtests
    WHERE projects.name = 'riak_ts';

UPDATE tests set name = 'ts_A_activate_table_pass_1' where name = 'ts_activate_table_pass_1';
UPDATE tests set name = 'ts_A_create_table_fail_1' where name = 'ts_create_table_fail_1';
UPDATE tests set name = 'ts_A_create_table_pass_1' where name = 'ts_create_table_pass_1';
UPDATE tests set name = 'ts_A_put_fail_1' where name = 'ts_put_fail_1';
UPDATE tests set name = 'ts_A_put_fail_2' where name = 'ts_put_fail_2';
UPDATE tests set name = 'ts_A_put_fail_3' where name = 'ts_put_fail_3';
UPDATE tests set name = 'ts_A_put_pass_1' where name = 'ts_put_pass_1';
UPDATE tests set name = 'ts_A_select_pass_1' where name = 'ts_select_pass_1';

COMMIT;
