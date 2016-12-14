BEGIN;

-- Obsolete this test
UPDATE tests SET max_version_a='{2,2,0}'
FROM projects_tests, projects
WHERE tests.name='replication_object_reformat'
AND tests.id = projects_tests.test_id
AND projects_tests.project_id = projects.id
AND projects.name IN ('riak', 'riak_ee');

UPDATE tests SET max_version_a='{1,4,0}'
FROM projects_tests, projects
WHERE tests.name='replication_object_reformat'
AND tests.id = projects_tests.test_id
AND projects_tests.project_id = projects.id
AND projects.name IN ('riak_ts', 'riak_ts_ee');

COMMIT;
