BEGIN;

-- Remove obsolete tests
DELETE FROM projects_tests WHERE test_id IN
    (SELECT id FROM tests WHERE name IN ('ts_cluster_http', 'ts_http_api_SUITE', 'ts_updown_select_SUITE'));
DELETE FROM tests WHERE name IN ('ts_cluster_http', 'ts_http_api_SUITE', 'ts_updown_select_SUITE');

-- Add in the new ones
WITH newtests AS (INSERT INTO tests (name, platform, backend) VALUES
    ('ts_cluster_list_irreg_keys_SUITE','centos-6-64','eleveldb'),
    ('ts_cluster_stream_list_keys_SUITE','centos-6-64','eleveldb'),
    ('ts_cluster_stream_query_SUITE','centos-6-64','eleveldb'),
    ('ts_simple_describe_table_SUITE','centos-6-64','eleveldb'),
    ('ts_simple_http_security_SUITE','centos-6-64','eleveldb'),
    ('ts_simple_pb_security_SUITE','centos-6-64','eleveldb'),
    ('yz_entropy_data','centos-6-64',NULL),
    ('yz_faceted_search','centos-6-64',NULL),
    ('yz_fuse_upgrade','centos-6-64',NULL),
    ('yz_solrq_test','centos-6-64',NULL),
    ('yz_startup_shutdown','centos-6-64',NULL)
RETURNING id)

-- Patch up the tests/projects
INSERT INTO projects_tests (project_id, test_id)
   SELECT projects.id, newtests.id FROM projects, newtests
    WHERE projects.name IN ('riak_ts','riak_ts_ee');

-- Add a single EE-only test
WITH neweetests AS (INSERT INTO tests (name, platform, backend) VALUES
    ('ts_cluster_replication','centos-6-64','eleveldb')
RETURNING id)

-- Patch up the tests/projects
INSERT INTO projects_tests (project_id, test_id)
   SELECT projects.id, neweetests.id FROM projects, neweetests
    WHERE projects.name ='riak_ts_ee';

COMMIT;
