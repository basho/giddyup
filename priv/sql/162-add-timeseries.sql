BEGIN;

-- Expect the next in the sequence, which currently is "6"
INSERT INTO projects (name) VALUES ('riak_ts');

-- Copy all of the existing riak_tests, skipping version numbers
WITH oldtests AS (INSERT INTO tests (name, platform, backend, upgrade_version)
SELECT tests.name, platform, backend, upgrade_version
FROM tests, projects_tests, projects
WHERE platform='centos-6-64'
AND (max_version_a IS NULL OR max_version_a >= to_version('{2,1,2}'))
AND projects_tests.project_id = projects.id
AND projects.name = 'riak'
AND projects_tests.test_id = tests.id
RETURNING id)

-- Patch up the tests/projects
INSERT INTO projects_tests (project_id, test_id)
   SELECT projects.id, oldtests.id FROM projects, oldtests
    WHERE projects.name = 'riak_ts';

-- Add in the new ones
WITH newtests AS (INSERT INTO tests (name, platform, backend) VALUES
    ('ts_basic','centos-6-64','eleveldb'),
    ('ts_activate_table_pass_1','centos-6-64','eleveldb'),
    ('ts_create_table_fail_1','centos-6-64','eleveldb'),
    ('ts_create_table_pass_1','centos-6-64','eleveldb'),
    ('ts_put_fail_1','centos-6-64','eleveldb'),
    ('ts_put_fail_2','centos-6-64','eleveldb'),
    ('ts_put_fail_3','centos-6-64','eleveldb'),
    ('ts_put_pass_1','centos-6-64','eleveldb'),
    ('ts_select_pass_1','centos-6-64','eleveldb')
RETURNING id)

-- Patch up the tests/projects
INSERT INTO projects_tests (project_id, test_id)
   SELECT projects.id, newtests.id FROM projects, newtests
    WHERE projects.name = 'riak_ts';

COMMIT;
