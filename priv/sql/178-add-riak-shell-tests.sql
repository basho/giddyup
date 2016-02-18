BEGIN;

-- Add in the new riak_shell ones
WITH newtests AS (INSERT INTO tests (name, platform, backend) VALUES
    ('ts_simple_single_key_ops','centos-6-64','eleveldb'),
    ('ts_simple_div_by_zero','centos-6-64','eleveldb'),
    ('ts_simple_select_double_in_key','centos-6-64','eleveldb'),
    ('riak_shell_test_connecting.','centos-6-64','eleveldb'),
    ('riak_shell_test_connecting_error','centos-6-64','eleveldb'),
    ('riak_shell_test_disconnecting','centos-6-64','eleveldb'),
    ('riak_shell_test_reconnecting','centos-6-64','eleveldb'),
    ('ts_riak_shell_basic_sql','centos-6-64','eleveldb')
RETURNING id)

-- Patch up the tests/projects
INSERT INTO projects_tests (project_id, test_id)
   SELECT projects.id, newtests.id FROM projects, newtests
    WHERE projects.name = 'riak_ts';

COMMIT;
