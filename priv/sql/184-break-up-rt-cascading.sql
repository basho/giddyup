BEGIN;

-- From https://github.com/basho/riak_test/pull/1050
UPDATE tests set name = 'rt_cascading_simple' where name = 'rt_cascading';

-- Insert new tests
WITH t as (INSERT INTO tests (name, platform) VALUES
       ('rt_cascading_big_circle', 'centos-5-64'),
       ('rt_cascading_big_circle', 'centos-6-64'),
       ('rt_cascading_big_circle', 'fedora-17-64'),
       ('rt_cascading_big_circle', 'freebsd-9-64'),
       ('rt_cascading_big_circle', 'osx-64'),
       ('rt_cascading_big_circle', 'solaris-10u9-64'),
       ('rt_cascading_big_circle', 'ubuntu-1004-64'),
       ('rt_cascading_big_circle', 'ubuntu-1204-64'),
       ('rt_cascading_circle', 'centos-5-64'),
       ('rt_cascading_circle', 'centos-6-64'),
       ('rt_cascading_circle', 'fedora-17-64'),
       ('rt_cascading_circle', 'freebsd-9-64'),
       ('rt_cascading_circle', 'osx-64'),
       ('rt_cascading_circle', 'solaris-10u9-64'),
       ('rt_cascading_circle', 'ubuntu-1004-64'),
       ('rt_cascading_circle', 'ubuntu-1204-64'),
       ('rt_cascading_circle_and_spurs', 'centos-5-64'),
       ('rt_cascading_circle_and_spurs', 'centos-6-64'),
       ('rt_cascading_circle_and_spurs', 'fedora-17-64'),
       ('rt_cascading_circle_and_spurs', 'freebsd-9-64'),
       ('rt_cascading_circle_and_spurs', 'osx-64'),
       ('rt_cascading_circle_and_spurs', 'solaris-10u9-64'),
       ('rt_cascading_circle_and_spurs', 'ubuntu-1004-64'),
       ('rt_cascading_circle_and_spurs', 'ubuntu-1204-64'),
       ('rt_cascading_diamond', 'centos-5-64'),
       ('rt_cascading_diamond', 'centos-6-64'),
       ('rt_cascading_diamond', 'fedora-17-64'),
       ('rt_cascading_diamond', 'freebsd-9-64'),
       ('rt_cascading_diamond', 'osx-64'),
       ('rt_cascading_diamond', 'solaris-10u9-64'),
       ('rt_cascading_diamond', 'ubuntu-1004-64'),
       ('rt_cascading_diamond', 'ubuntu-1204-64'),
       ('rt_cascading_ensure_ack', 'centos-5-64'),
       ('rt_cascading_ensure_ack', 'centos-6-64'),
       ('rt_cascading_ensure_ack', 'fedora-17-64'),
       ('rt_cascading_ensure_ack', 'freebsd-9-64'),
       ('rt_cascading_ensure_ack', 'osx-64'),
       ('rt_cascading_ensure_ack', 'solaris-10u9-64'),
       ('rt_cascading_ensure_ack', 'ubuntu-1004-64'),
       ('rt_cascading_ensure_ack', 'ubuntu-1204-64'),
       ('rt_cascading_mixed_clusters', 'centos-5-64'),
       ('rt_cascading_mixed_clusters', 'centos-6-64'),
       ('rt_cascading_mixed_clusters', 'fedora-17-64'),
       ('rt_cascading_mixed_clusters', 'freebsd-9-64'),
       ('rt_cascading_mixed_clusters', 'osx-64'),
       ('rt_cascading_mixed_clusters', 'solaris-10u9-64'),
       ('rt_cascading_mixed_clusters', 'ubuntu-1004-64'),
       ('rt_cascading_mixed_clusters', 'ubuntu-1204-64'),
       ('rt_cascading_new_to_old', 'centos-5-64'),
       ('rt_cascading_new_to_old', 'centos-6-64'),
       ('rt_cascading_new_to_old', 'fedora-17-64'),
       ('rt_cascading_new_to_old', 'freebsd-9-64'),
       ('rt_cascading_new_to_old', 'osx-64'),
       ('rt_cascading_new_to_old', 'solaris-10u9-64'),
       ('rt_cascading_new_to_old', 'ubuntu-1004-64'),
       ('rt_cascading_new_to_old', 'ubuntu-1204-64'),
       ('rt_cascading_pyramid', 'centos-5-64'),
       ('rt_cascading_pyramid', 'centos-6-64'),
       ('rt_cascading_pyramid', 'fedora-17-64'),
       ('rt_cascading_pyramid', 'freebsd-9-64'),
       ('rt_cascading_pyramid', 'osx-64'),
       ('rt_cascading_pyramid', 'solaris-10u9-64'),
       ('rt_cascading_pyramid', 'ubuntu-1004-64'),
       ('rt_cascading_pyramid', 'ubuntu-1204-64'),
       ('rt_cascading_unacked_and_queue', 'centos-5-64'),
       ('rt_cascading_unacked_and_queue', 'centos-6-64'),
       ('rt_cascading_unacked_and_queue', 'fedora-17-64'),
       ('rt_cascading_unacked_and_queue', 'freebsd-9-64'),
       ('rt_cascading_unacked_and_queue', 'osx-64'),
       ('rt_cascading_unacked_and_queue', 'solaris-10u9-64'),
       ('rt_cascading_unacked_and_queue', 'ubuntu-1004-64'),
       ('rt_cascading_unacked_and_queue', 'ubuntu-1204-64')
       RETURNING id)

INSERT INTO projects_tests (project_id, test_id)
   SELECT projects.id, t.id FROM projects, t
    WHERE projects.name='riak_ee';

-- Insert new TS tests
WITH t as (INSERT INTO tests (name, platform) VALUES
       ('rt_cascading_big_circle', 'centos-6-64'),
       ('rt_cascading_circle', 'centos-6-64'),
       ('rt_cascading_circle_and_spurs', 'centos-6-64'),
       ('rt_cascading_diamond', 'centos-6-64'),
       ('rt_cascading_ensure_ack', 'centos-6-64'),
       ('rt_cascading_mixed_clusters', 'centos-6-64'),
       ('rt_cascading_new_to_old', 'centos-6-64'),
       ('rt_cascading_pyramid', 'centos-6-64'),
       ('rt_cascading_unacked_and_queue', 'centos-6-64')
       RETURNING id)

INSERT INTO projects_tests (project_id, test_id)
   SELECT projects.id, t.id FROM projects, t
    WHERE projects.name='riak_ts_ee';

COMMIT;
