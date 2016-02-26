BEGIN;

-- Start over with riak_ts tests
DELETE FROM projects_tests WHERE project_id=(SELECT id FROM projects WHERE name='riak_ts');
-- Copy all of the tests from riak_ts_ee into riak_ts, except those which are EE-specific
INSERT INTO projects_tests
SELECT (SELECT id FROM projects WHERE name='riak_ts'),tests.id
FROM projects_tests, tests, projects
WHERE projects_tests.project_id=projects.id
AND tests.id=projects_tests.test_id
AND projects.name='riak_ts_ee'
AND tests.name NOT IN
(SELECT tests.name FROM tests, projects_tests, projects WHERE projects_tests.test_id=tests.id
AND projects_tests.project_id=projects.id
AND projects.name='riak_ee'
EXCEPT
SELECT tests.name FROM tests, projects_tests, projects WHERE projects_tests.test_id=tests.id
AND projects_tests.project_id=projects.id
AND projects.name='riak');

-- Fix typo
UPDATE tests SET name='riak_shell_test_connecting'
WHERE name='riak_shell_test_connecting.';

COMMIT;
