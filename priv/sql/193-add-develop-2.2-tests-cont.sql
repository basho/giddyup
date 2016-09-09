BEGIN;

-- Insert new tests for 2.2.0+ needs
WITH t as (INSERT INTO tests (name, platform, min_version_a) VALUES

    ('verify_dt_data_upgrade', 'centos-5-64','{2,2,0}'),
    ('verify_dt_data_upgrade', 'centos-6-64','{2,2,0}'),
    ('verify_dt_data_upgrade', 'fedora-17-64','{2,2,0}'),
    ('verify_dt_data_upgrade', 'freebsd-9-64','{2,2,0}'),
    ('verify_dt_data_upgrade', 'osx-64','{2,2,0}'),
    ('verify_dt_data_upgrade', 'solaris-10u9-64','{2,2,0}'),
    ('verify_dt_data_upgrade', 'ubuntu-1004-64','{2,2,0}'),
    ('verify_dt_data_upgrade', 'ubuntu-1204-64','{2,2,0}')

    RETURNING id)

INSERT INTO projects_tests (project_id, test_id)
    SELECT projects.id, t.id FROM projects, t
     WHERE (projects.name = 'riak' OR projects.name = 'riak_ee');

COMMIT;
