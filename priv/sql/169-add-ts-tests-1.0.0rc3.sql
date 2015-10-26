BEGIN;

-- Add in the new ones
WITH newtests AS (INSERT INTO tests (name, platform, backend) VALUES
    ('ts_api','centos-6-64','eleveldb'),
    ('ts_unicode','centos-6-64','eleveldb')
RETURNING id)

-- Patch up the tests/projects
INSERT INTO projects_tests (project_id, test_id)
   SELECT projects.id, newtests.id FROM projects, newtests
    WHERE projects.name = 'riak_ts';

COMMIT;
