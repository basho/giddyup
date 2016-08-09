BEGIN;

-- Insert new tests for 2.2.0+ for riak KV
WITH t as (INSERT INTO tests (name, platform, min_version_a) VALUES
       ('verify_removed_capability', 'centos-5-64','{2,2,0}'),
       ('verify_removed_capability', 'centos-6-64','{2,2,0}'),
       ('verify_removed_capability', 'fedora-17-64','{2,2,0}'),
       ('verify_removed_capability', 'freebsd-9-64','{2,2,0}'),
       ('verify_removed_capability', 'osx-64','{2,2,0}'),
       ('verify_removed_capability', 'solaris-10u9-64','{2,2,0}'),
       ('verify_removed_capability', 'ubuntu-1004-64','{2,2,0}'),
       ('verify_removed_capability', 'ubuntu-1204-64','{2,2,0}')
         RETURNING id)

INSERT INTO projects_tests (project_id, test_id)
    SELECT projects.id, t.id FROM projects, t
     WHERE projects.name IN ('riak', 'riak_ee');

-- Add in for riak TS
WITH newtests AS (INSERT INTO tests (name, platform, backend) VALUES
    ('verify_removed_capability','centos-6-64','eleveldb')
RETURNING id)

-- Patch up the tests/projects
INSERT INTO projects_tests (project_id, test_id)
   SELECT projects.id, newtests.id FROM projects, newtests
    WHERE projects.name IN ('riak_ts','riak_ts_ee');

COMMIT;
