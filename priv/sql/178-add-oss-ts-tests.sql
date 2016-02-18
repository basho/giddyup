BEGIN;

-- Expect the next in the sequence, which currently is "7"
INSERT INTO projects (name) VALUES ('riak_ts_ee');

-- Move all existing riak_ts tests over to riak_ts_ee
UPDATE projects_tests SET project_id=(SELECT id FROM projects WHERE name='riak_ts_ee')
WHERE project_id=(select id FROM projects WHERE name='riak_ts');
UPDATE scorecards SET project_id=(SELECT id FROM projects WHERE name='riak_ts_ee')
WHERE project_id=(select id FROM projects WHERE name='riak_ts');

-- Add OSS riak tests for CentOS 6
INSERT INTO projects_tests (project_id, test_id)
   SELECT (select id FROM projects WHERE name='riak_ts'),
          tests.id FROM projects_tests, projects, tests
   WHERE (projects.name = 'riak') AND tests.platform = 'centos-6-64'
   AND projects_tests.project_id=projects.id
   AND projects_tests.test_id=tests.id;

-- Add all Time Series tests for all EE Time Series tests
INSERT INTO projects_tests (project_id, test_id)
   SELECT (select id FROM projects WHERE name='riak_ts'),
          tests.id FROM projects_tests, projects, tests
   WHERE (projects.name = 'riak_ts_ee') AND tests.name LIKE 'ts_%'
   AND projects_tests.project_id=projects.id
   AND projects_tests.test_id=tests.id;

-- Add in the new ones
WITH newtests AS (INSERT INTO tests (name, platform, backend) VALUES
    ('ts_simple_single_key_ops','centos-6-64','eleveldb'),
    ('ts_simple_div_by_zero','centos-6-64','eleveldb'),
    ('ts_simple_select_double_in_key','centos-6-64','eleveldb')
RETURNING id)

INSERT INTO projects_tests (project_id, test_id)
    SELECT projects.id, newtests.id FROM projects, newtests
    WHERE (projects.name = 'riak_ts' OR projects.name = 'riak_ts_ee');

COMMIT;
