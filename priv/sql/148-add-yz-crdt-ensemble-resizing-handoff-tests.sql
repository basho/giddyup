BEGIN;

WITH t as (INSERT INTO tests (name, platform, min_version_a) VALUES
       ('yz_ring_resizing', 'centos-5-64', '{2,1,0}'),
       ('yz_ring_resizing', 'centos-6-64', '{2,1,0}'),
       ('yz_ring_resizing', 'fedora-17-64', '{2,1,0}'),
       ('yz_ring_resizing', 'freebsd-9-64', '{2,1,0}'),
       ('yz_ring_resizing', 'osx-64', '{2,1,0}'),
       ('yz_ring_resizing', 'solaris-10u9-64', '{2,1,0}'),
       ('yz_ring_resizing', 'ubuntu-1004-64', '{2,1,0}'),
       ('yz_ring_resizing', 'ubuntu-1204-64', '{2,1,0}'),
       ('yz_handoff_blocking', 'centos-5-64', '{2,1,0}'),
       ('yz_handoff_blocking', 'centos-6-64', '{2,1,0}'),
       ('yz_handoff_blocking', 'fedora-17-64', '{2,1,0}'),
       ('yz_handoff_blocking', 'freebsd-9-64', '{2,1,0}'),
       ('yz_handoff_blocking', 'osx-64', '{2,1,0}'),
       ('yz_handoff_blocking', 'solaris-10u9-64', '{2,1,0}'),
       ('yz_handoff_blocking', 'ubuntu-1004-64', '{2,1,0}'),
       ('yz_handoff_blocking', 'ubuntu-1204-64', '{2,1,0}'),
       ('yz_handoff', 'centos-5-64', '{2,1,0}'),
       ('yz_handoff', 'centos-6-64', '{2,1,0}'),
       ('yz_handoff', 'fedora-17-64', '{2,1,0}'),
       ('yz_handoff', 'freebsd-9-64', '{2,1,0}'),
       ('yz_handoff', 'osx-64', '{2,1,0}'),
       ('yz_handoff', 'solaris-10u9-64', '{2,1,0}'),
       ('yz_handoff', 'ubuntu-1004-64', '{2,1,0}'),
       ('yz_handoff', 'ubuntu-1204-64', '{2,1,0}'),
       ('yz_crdt', 'centos-5-64', '{2,1,0}'),
       ('yz_crdt', 'centos-6-64', '{2,1,0}'),
       ('yz_crdt', 'fedora-17-64', '{2,1,0}'),
       ('yz_crdt', 'freebsd-9-64', '{2,1,0}'),
       ('yz_crdt', 'osx-64', '{2,1,0}'),
       ('yz_crdt', 'solaris-10u9-64', '{2,1,0}'),
       ('yz_crdt', 'ubuntu-1004-64', '{2,1,0}'),
       ('yz_crdt', 'ubuntu-1204-64', '{2,1,0}'),
       ('yz_ensemble', 'centos-5-64', '{2,1,0}'),
       ('yz_ensemble', 'centos-6-64', '{2,1,0}'),
       ('yz_ensemble', 'fedora-17-64', '{2,1,0}'),
       ('yz_ensemble', 'freebsd-9-64', '{2,1,0}'),
       ('yz_ensemble', 'osx-64', '{2,1,0}'),
       ('yz_ensemble', 'solaris-10u9-64', '{2,1,0}'),
       ('yz_ensemble', 'ubuntu-1004-64', '{2,1,0}'),
       ('yz_ensemble', 'ubuntu-1204-64', '{2,1,0}') RETURNING id)

INSERT INTO projects_tests (project_id, test_id)
   SELECT projects.id, t.id FROM projects, t
    WHERE (projects.name = 'riak' OR projects.name = 'riak_ee');

COMMIT;
