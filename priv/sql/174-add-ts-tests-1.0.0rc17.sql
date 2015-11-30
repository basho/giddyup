BEGIN;

-- Add in the new ones
WITH newtests AS (INSERT INTO tests (name, platform, backend) VALUES
    ('ts_unicode_create_table_not_allowed','centos-6-64','eleveldb'),
    ('ts_A_create_table_dup_primary_key','centos-6-64','eleveldb'),
    ('ts_A_create_table_no_primary_key','centos-6-64','eleveldb'),
    ('ts_A_create_table_not_null_pk_fields','centos-6-64','eleveldb')
RETURNING id)

-- Patch up the tests/projects
INSERT INTO projects_tests (project_id, test_id)
   SELECT projects.id, newtests.id FROM projects, newtests
    WHERE projects.name = 'riak_ts';

-- See https://github.com/basho/riak_test/pull/940
UPDATE tests set name = 'ts_latin1_create_table_not_allowed' where name = 'ts_A_select_fail_1';

COMMIT;
