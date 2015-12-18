BEGIN;

-- Add in the new ones
WITH newtests AS (INSERT INTO tests (name, platform, backend) VALUES
    ('ts_aggregation_cluster','centos-6-64','eleveldb'),
    ('ts_aggregation_fail','centos-6-64','eleveldb'),
    ('ts_aggregation_math','centos-6-64','eleveldb'),
    ('ts_aggregation_simple','centos-6-64','eleveldb'),
    ('ts_describe_table','centos-6-64','eleveldb')
RETURNING id)

-- Patch up the tests/projects
INSERT INTO projects_tests (project_id, test_id)
   SELECT projects.id, newtests.id FROM projects, newtests
    WHERE projects.name = 'riak_ts';

COMMIT;
