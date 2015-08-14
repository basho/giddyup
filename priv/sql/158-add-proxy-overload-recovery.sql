BEGIN;


-- Insert new tests for 2.0.7+ needs
WITH s as (INSERT INTO tests (name, platform, min_version_a, max_version_a) VALUES
       ('proxy_overload_recovery', 'centos-5-64', '{2,0,7}', '{2,0,99}'),
       ('proxy_overload_recovery', 'centos-6-64', '{2,0,7}', '{2,0,99}'),
       ('proxy_overload_recovery', 'fedora-17-64', '{2,0,7}', '{2,0,99}'),
       ('proxy_overload_recovery', 'freebsd-9-64', '{2,0,7}', '{2,0,99}'),
       ('proxy_overload_recovery', 'osx-64', '{2,0,7}', '{2,0,99}'),
       ('proxy_overload_recovery', 'solaris-10u9-64', '{2,0,7}', '{2,0,99}'),
       ('proxy_overload_recovery', 'ubuntu-1004-64', '{2,0,7}', '{2,0,99}'),
       ('proxy_overload_recovery', 'ubuntu-1204-64', '{2,0,7}', '{2,0,99}')
       RETURNING id)

INSERT INTO projects_tests (project_id, test_id)
   SELECT projects.id, s.id FROM projects, s
    WHERE (projects.name = 'riak' OR projects.name = 'riak_ee');

-- Insert new tests for 2.1.2+ needs
WITH t as (INSERT INTO tests (name, platform, min_version_a) VALUES
       ('proxy_overload_recovery', 'centos-5-64', '{2,1,2}'),
       ('proxy_overload_recovery', 'centos-6-64', '{2,1,2}'),
       ('proxy_overload_recovery', 'fedora-17-64', '{2,1,2}'),
       ('proxy_overload_recovery', 'freebsd-9-64', '{2,1,2}'),
       ('proxy_overload_recovery', 'osx-64', '{2,1,2}'),
       ('proxy_overload_recovery', 'solaris-10u9-64', '{2,1,2}'),
       ('proxy_overload_recovery', 'ubuntu-1004-64', '{2,1,2}'),
       ('proxy_overload_recovery', 'ubuntu-1204-64', '{2,1,2}')
       RETURNING id)

INSERT INTO projects_tests (project_id, test_id)
    SELECT projects.id, t.id FROM projects, t
     WHERE (projects.name = 'riak' OR projects.name = 'riak_ee');

COMMIT;
