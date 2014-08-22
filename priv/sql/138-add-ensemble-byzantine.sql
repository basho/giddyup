BEGIN;

WITH t as (INSERT INTO tests (name, platform, min_version) VALUES
       ('ensemble_byzantine', 'centos-5-64', '2.0.0'),
       ('ensemble_byzantine', 'centos-6-64', '2.0.0'),
       ('ensemble_byzantine', 'fedora-17-64', '2.0.0'),
       ('ensemble_byzantine', 'freebsd-9-64', '2.0.0'),
       ('ensemble_byzantine', 'osx-64', '2.0.0'),
       ('ensemble_byzantine', 'solaris-10u9-64', '2.0.0'),
       ('ensemble_byzantine', 'ubuntu-1004-64', '2.0.0'),
       ('ensemble_byzantine', 'ubuntu-1204-64', '2.0.0') RETURNING id)

INSERT INTO projects_tests (project_id, test_id)
   SELECT projects.id, t.id FROM projects, t
    WHERE (projects.name = 'riak' OR projects.name = 'riak_ee');

COMMIT;
