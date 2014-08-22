BEGIN;

WITH t as (INSERT INTO tests (name, platform, min_version) VALUES
       ('ensemble_ring_changes', 'centos-5-64', '2.0.0'),
       ('ensemble_ring_changes', 'centos-6-64', '2.0.0'),
       ('ensemble_ring_changes', 'fedora-17-64', '2.0.0'),
       ('ensemble_ring_changes', 'freebsd-9-64', '2.0.0'),
       ('ensemble_ring_changes', 'osx-64', '2.0.0'),
       ('ensemble_ring_changes', 'solaris-10u9-64', '2.0.0'),
       ('ensemble_ring_changes', 'ubuntu-1004-64', '2.0.0'),
       ('ensemble_ring_changes', 'ubuntu-1204-64', '2.0.0') RETURNING id)

INSERT INTO projects_tests (project_id, test_id)
   SELECT projects.id, t.id FROM projects, t
    WHERE (projects.name = 'riak' OR projects.name = 'riak_ee');

COMMIT;
