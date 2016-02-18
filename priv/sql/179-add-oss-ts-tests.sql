BEGIN;

-- Add riak tests for all EE Time Series tests
INSERT INTO projects_tests (project_id, test_id)
   SELECT projects.id, tests.id FROM projects, tests
   WHERE (projects.name = 'riak') AND tests.name LIKE 'ts_%';

-- Add in the new ones
WITH newtests AS (INSERT INTO tests (name, platform, backend) VALUES
    ('ts_simple_single_key_ops','centos-6-64','eleveldb'),
    ('ts_simple_div_by_zero','centos-6-64','eleveldb'),
    ('ts_simple_select_double_in_key','centos-6-64','eleveldb')
RETURNING id)

INSERT INTO projects_tests (project_id, test_id)
    SELECT projects.id, newtests.id FROM projects, newtests
    WHERE (projects.name = 'riak' OR projects.name = 'riak_ee');

COMMIT;
