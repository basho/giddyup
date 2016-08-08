BEGIN;

-- Add in the new ones
WITH newtests AS (INSERT INTO tests (name, platform, backend) VALUES
    ('ts_cluster_capabilities_SUITE','centos-6-64','eleveldb'),
    ('ts_cluster_group_by_SUITE','centos-6-64','eleveldb'),
    ('ts_cluster_updowngrade_select_aggregation_SUITE','centos-6-64','eleveldb'),
    ('ts_simple_explain_query','centos-6-64','eleveldb'),
    ('ts_simple_insert_iso8601','centos-6-64','eleveldb'),
    ('ts_simple_select_iso8601','centos-6-64','eleveldb')
RETURNING id)

-- Patch up the tests/projects
INSERT INTO projects_tests (project_id, test_id)
   SELECT projects.id, newtests.id FROM projects, newtests
    WHERE projects.name IN ('riak_ts','riak_ts_ee');

COMMIT;
