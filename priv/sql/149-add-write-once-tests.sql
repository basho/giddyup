BEGIN;

WITH t as (INSERT INTO tests (name, platform, min_version_a) VALUES
       ('verify_write_once', 'centos-5-64', '{2,1,0}'),
       ('verify_write_once', 'centos-6-64', '{2,1,0}'),
       ('verify_write_once', 'fedora-17-64', '{2,1,0}'),
       ('verify_write_once', 'freebsd-9-64', '{2,1,0}'),
       ('verify_write_once', 'osx-64', '{2,1,0}'),
       ('verify_write_once', 'solaris-10u9-64', '{2,1,0}'),
       ('verify_write_once', 'ubuntu-1004-64', '{2,1,0}'),
       ('verify_write_once', 'ubuntu-1204-64', '{2,1,0}'),
       ('verify_handoff_write_once', 'centos-5-64', '{2,1,0}'),
       ('verify_handoff_write_once', 'centos-6-64', '{2,1,0}'),
       ('verify_handoff_write_once', 'fedora-17-64', '{2,1,0}'),
       ('verify_handoff_write_once', 'freebsd-9-64', '{2,1,0}'),
       ('verify_handoff_write_once', 'osx-64', '{2,1,0}'),
       ('verify_handoff_write_once', 'solaris-10u9-64', '{2,1,0}'),
       ('verify_handoff_write_once', 'ubuntu-1004-64', '{2,1,0}'),
       ('verify_handoff_write_once', 'ubuntu-1204-64', '{2,1,0}')
       RETURNING id)

INSERT INTO projects_tests (project_id, test_id)
   SELECT projects.id, t.id FROM projects, t
    WHERE (projects.name = 'riak' OR projects.name = 'riak_ee');

COMMIT;
