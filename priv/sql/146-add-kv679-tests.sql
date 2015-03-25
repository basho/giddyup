BEGIN;

WITH t as (INSERT INTO tests (name, platform, min_version_a) VALUES
       ('kv679_dataloss', 'centos-5-64', '{2,1,0}'),
       ('kv679_dataloss', 'centos-6-64', '{2,1,0}'),
       ('kv679_dataloss', 'fedora-17-64', '{2,1,0}'),
       ('kv679_dataloss', 'freebsd-9-64', '{2,1,0}'),
       ('kv679_dataloss', 'osx-64', '{2,1,0}'),
       ('kv679_dataloss', 'solaris-10u9-64', '{2,1,0}'),
       ('kv679_dataloss', 'ubuntu-1004-64', '{2,1,0}'),
       ('kv679_dataloss', 'ubuntu-1204-64', '{2,1,0}'),
       ('kv679_tombstone', 'centos-5-64', '{2,1,0}'),
       ('kv679_tombstone', 'centos-6-64', '{2,1,0}'),
       ('kv679_tombstone', 'fedora-17-64', '{2,1,0}'),
       ('kv679_tombstone', 'freebsd-9-64', '{2,1,0}'),
       ('kv679_tombstone', 'osx-64', '{2,1,0}'),
       ('kv679_tombstone', 'solaris-10u9-64', '{2,1,0}'),
       ('kv679_tombstone', 'ubuntu-1004-64', '{2,1,0}'),
       ('kv679_tombstone', 'ubuntu-1204-64', '{2,1,0}'),
       ('kv679_tombstone2', 'centos-5-64', '{2,1,0}'),
       ('kv679_tombstone2', 'centos-6-64', '{2,1,0}'),
       ('kv679_tombstone2', 'fedora-17-64', '{2,1,0}'),
       ('kv679_tombstone2', 'freebsd-9-64', '{2,1,0}'),
       ('kv679_tombstone2', 'osx-64', '{2,1,0}'),
       ('kv679_tombstone2', 'solaris-10u9-64', '{2,1,0}'),
       ('kv679_tombstone2', 'ubuntu-1004-64', '{2,1,0}'),
       ('kv679_tombstone2', 'ubuntu-1204-64', '{2,1,0}')
       RETURNING id)

INSERT INTO projects_tests (project_id, test_id)
   SELECT projects.id, t.id FROM projects, t
    WHERE (projects.name = 'riak' OR projects.name = 'riak_ee');

COMMIT;
