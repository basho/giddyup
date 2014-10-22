BEGIN;

WITH t as (INSERT INTO tests (name, platform, min_version) VALUES
       ('kv679_uid', 'centos-5-64', '2.0.2'),
       ('kv679_uid', 'centos-6-64', '2.0.2'),
       ('kv679_uid', 'fedora-17-64', '2.0.2'),
       ('kv679_uid', 'freebsd-9-64', '2.0.2'),
       ('kv679_uid', 'osx-64', '2.0.2'),
       ('kv679_uid', 'solaris-10u9-64', '2.0.2'),
       ('kv679_uid', 'ubuntu-1004-64', '2.0.2'),
       ('kv679_uid', 'ubuntu-1204-64', '2.0.2') RETURNING id)

INSERT INTO projects_tests (project_id, test_id)
   SELECT projects.id, t.id FROM projects, t
    WHERE (projects.name = 'riak' OR projects.name = 'riak_ee');

COMMIT;
