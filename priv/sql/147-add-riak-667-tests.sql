BEGIN;

WITH t as (INSERT INTO tests (name, platform, min_version_a) VALUES
       ('riak667_safe', 'centos-5-64', '{2,0,5}'),
       ('riak667_safe', 'centos-6-64', '{2,0,5}'),
       ('riak667_safe', 'fedora-17-64', '{2,0,5}'),
       ('riak667_safe', 'freebsd-9-64', '{2,0,5}'),
       ('riak667_safe', 'osx-64', '{2,0,5}'),
       ('riak667_safe', 'solaris-10u9-64', '{2,0,5}'),
       ('riak667_safe', 'ubuntu-1004-64', '{2,0,5}'),
       ('riak667_safe', 'ubuntu-1204-64', '{2,0,5}'),
       ('riak667_mixed', 'centos-5-64', '{2,0,5}'),
       ('riak667_mixed', 'centos-6-64', '{2,0,5}'),
       ('riak667_mixed', 'fedora-17-64', '{2,0,5}'),
       ('riak667_mixed', 'freebsd-9-64', '{2,0,5}'),
       ('riak667_mixed', 'osx-64', '{2,0,5}'),
       ('riak667_mixed', 'solaris-10u9-64', '{2,0,5}'),
       ('riak667_mixed', 'ubuntu-1004-64', '{2,0,5}'),
       ('riak667_mixed', 'ubuntu-1204-64', '{2,0,5}') RETURNING id)

INSERT INTO projects_tests (project_id, test_id)
   SELECT projects.id, t.id FROM projects, t
    WHERE (projects.name = 'riak' OR projects.name = 'riak_ee');

COMMIT;
