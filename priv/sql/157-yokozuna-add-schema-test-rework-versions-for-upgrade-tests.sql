BEGIN;

-- Update existing tests that were set to only run on 2.0.6 to run on the rest
-- rest of the 2.0.x series
UPDATE tests SET min_version_a = '{2,0,6}', max_version_a = '{2,0,99}'
 WHERE name LIKE 'yz_%' AND (min_version_a = '{2,0,6}' AND max_version_a = '{2,0,6}');

-- Update existing tests that were set to only run on 2.1.2 to run beyond that
UPDATE tests SET min_version_a = '{2,1,2}', max_version_a = NULL
 WHERE name LIKE 'yz_%' AND (min_version_a = '{2,1,2}' AND max_version_a = '{2,1,2}');

-- Insert new tests for 2.0.7+ needs
WITH s as (INSERT INTO tests (name, platform, min_version_a, max_version_a) VALUES
       ('yz_schema_change_reset', 'centos-5-64', '{2,0,7}', '{2,0,99}'),
       ('yz_schema_change_reset', 'centos-6-64', '{2,0,7}', '{2,0,99}'),
       ('yz_schema_change_reset', 'fedora-17-64', '{2,0,7}', '{2,0,99}'),
       ('yz_schema_change_reset', 'freebsd-9-64', '{2,0,7}', '{2,0,99}'),
       ('yz_schema_change_reset', 'osx-64', '{2,0,7}', '{2,0,99}'),
       ('yz_schema_change_reset', 'solaris-10u9-64', '{2,0,7}', '{2,0,99}'),
       ('yz_schema_change_reset', 'ubuntu-1004-64', '{2,0,7}', '{2,0,99}'),
       ('yz_schema_change_reset', 'ubuntu-1204-64', '{2,0,7}', '{2,0,99}'),
       ('yz_search_http', 'centos-5-64', '{2,0,7}', '{2,0,99}'),
       ('yz_search_http', 'centos-6-64', '{2,0,7}', '{2,0,99}'),
       ('yz_search_http', 'fedora-17-64', '{2,0,7}', '{2,0,99}'),
       ('yz_search_http', 'freebsd-9-64', '{2,0,7}', '{2,0,99}'),
       ('yz_search_http', 'osx-64', '{2,0,7}', '{2,0,99}'),
       ('yz_search_http', 'solaris-10u9-64', '{2,0,7}', '{2,0,99}'),
       ('yz_search_http', 'ubuntu-1004-64', '{2,0,7}', '{2,0,99}'),
       ('yz_search_http', 'ubuntu-1204-64', '{2,0,7}', '{2,0,99}')
       RETURNING id)

INSERT INTO projects_tests (project_id, test_id)
   SELECT projects.id, s.id FROM projects, s
    WHERE (projects.name = 'riak' OR projects.name = 'riak_ee');

-- Insert new tests for 2.1.2+ needs
WITH t as (INSERT INTO tests (name, platform, min_version_a) VALUES
       ('yz_schema_change_reset', 'centos-5-64', '{2,1,2}'),
       ('yz_schema_change_reset', 'centos-6-64', '{2,1,2}'),
       ('yz_schema_change_reset', 'fedora-17-64', '{2,1,2}'),
       ('yz_schema_change_reset', 'freebsd-9-64', '{2,1,2}'),
       ('yz_schema_change_reset', 'osx-64', '{2,1,2}'),
       ('yz_schema_change_reset', 'solaris-10u9-64', '{2,1,2}'),
       ('yz_schema_change_reset', 'ubuntu-1004-64', '{2,1,2}'),
       ('yz_schema_change_reset', 'ubuntu-1204-64', '{2,1,2}'),
       ('yz_search_http', 'centos-5-64', '{2,1,2}'),
       ('yz_search_http', 'centos-6-64', '{2,1,2}'),
       ('yz_search_http', 'fedora-17-64', '{2,1,2}'),
       ('yz_search_http', 'freebsd-9-64', '{2,1,2}'),
       ('yz_search_http', 'osx-64', '{2,1,2}'),
       ('yz_search_http', 'solaris-10u9-64', '{2,1,2}'),
       ('yz_search_http', 'ubuntu-1004-64', '{2,1,2}'),
       ('yz_search_http', 'ubuntu-1204-64', '{2,1,2}')
       RETURNING id)

INSERT INTO projects_tests (project_id, test_id)
    SELECT projects.id, t.id FROM projects, t
     WHERE (projects.name = 'riak' OR projects.name = 'riak_ee');

COMMIT;
