BEGIN;

WITH t as (INSERT INTO tests (name, platform, min_version_a) VALUES
       ('yz_crdt', 'centos-5-64', '{2,0,0}'),
       ('yz_crdt', 'centos-6-64', '{2,0,0}'),
       ('yz_crdt', 'fedora-17-64', '{2,0,0}'),
       ('yz_crdt', 'freebsd-9-64', '{2,0,0}'),
       ('yz_crdt', 'osx-64', '{2,0,0}'),
       ('yz_crdt', 'solaris-10u9-64', '{2,0,0}'),
       ('yz_crdt', 'ubuntu-1004-64', '{2,0,0}'),
       ('yz_crdt', 'ubuntu-1204-64', '{2,0,0}')
       RETURNING id)

INSERT INTO projects_tests (project_id, test_id)
   SELECT projects.id, t.id FROM projects, t
    WHERE (projects.name = 'riak' OR projects.name = 'riak_ee');

COMMIT;
