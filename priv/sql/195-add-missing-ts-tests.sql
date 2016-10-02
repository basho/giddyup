BEGIN;
-- Copy all of the remaining EE riak_tests, skipping version numbers
WITH oldtests AS (INSERT INTO tests (name, platform, backend)
SELECT tests.name, platform, backend
FROM tests, projects_tests, projects
WHERE platform='centos-6-64'
AND (max_version_a IS NULL OR max_version_a >= to_version('{2,2,0}'))
AND projects_tests.project_id = projects.id
AND projects.name = 'riak_ee'
AND projects_tests.test_id = tests.id
AND tests.name NOT IN
(SELECT t.name
FROM tests AS t, projects_tests AS pt, projects AS p
WHERE t.id=pt.test_id
AND p.id=pt.project_id
AND p.name='riak_ts_ee')
RETURNING id)

-- Patch up the tests/projects
INSERT INTO projects_tests (project_id, test_id)
   SELECT projects.id, oldtests.id FROM projects, oldtests
    WHERE projects.name = 'riak_ts_ee';

-- Copy all of the remaining OSS riak_tests, skipping version numbers
WITH oldosstests AS (INSERT INTO tests (name, platform, backend)
SELECT tests.name, platform, backend
FROM tests, projects_tests, projects
WHERE platform='centos-6-64'
AND (max_version_a IS NULL OR max_version_a >= to_version('{2,2,0}'))
AND projects_tests.project_id = projects.id
AND projects.name = 'riak'
AND projects_tests.test_id = tests.id
AND tests.name NOT IN
(SELECT t.name
FROM tests AS t, projects_tests AS pt, projects AS p
WHERE t.id=pt.test_id
AND p.id=pt.project_id
AND p.name='riak_ts')
RETURNING id)

-- Patch up the tests/projects
INSERT INTO projects_tests (project_id, test_id)
   SELECT projects.id, oldosstests.id FROM projects, oldosstests
    WHERE projects.name = 'riak_ts';

COMMIT;
