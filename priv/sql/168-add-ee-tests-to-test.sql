BEGIN;

-- Copy all of the remaining EE riak_tests, skipping version numbers
WITH oldtests AS (INSERT INTO tests (name, platform, backend, upgrade_version)
SELECT tests.name, platform, backend, upgrade_version
FROM tests, projects_tests, projects
WHERE platform='centos-6-64'
AND (max_version_a IS NULL OR max_version_a >= to_version('{2,1,2}'))
AND projects_tests.project_id = projects.id
AND projects.name = 'riak_ee'
AND projects_tests.test_id = tests.id
AND tests.name NOT IN
(SELECT t.name
FROM tests AS t, projects_tests AS pt, projects AS p
WHERE t.id=pt.test_id
AND p.id=pt.project_id
AND p.name='riak')
RETURNING id)

-- Patch up the tests/projects
INSERT INTO projects_tests (project_id, test_id)
   SELECT projects.id, oldtests.id FROM projects, oldtests
    WHERE projects.name = 'riak_ts';

-- Add in the new ones
WITH newtests AS (INSERT INTO tests (name, platform, backend) VALUES
    ('ts_B_random_query_pass_eqc','centos-6-64','eleveldb'),
    ('coverage','centos-6-64','eleveldb'),
    ('verify_2i_eqc', 'centos-6-64', NULL),
    ('verify_2i_returnbody', 'centos-6-64', NULL)
RETURNING id)

-- Patch up the tests/projects
INSERT INTO projects_tests (project_id, test_id)
   SELECT projects.id, newtests.id FROM projects, newtests
    WHERE projects.name = 'riak_ts';

COMMIT;
