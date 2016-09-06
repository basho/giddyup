BEGIN;

-- Insert new tests for 2.2.0+ needs
WITH t as (INSERT INTO tests (name, platform, min_version_a) VALUES
    
    ('yz_solr_upgrade_downgrade', 'centos-5-64','{2,2,0}'),
    ('yz_solr_upgrade_downgrade', 'centos-6-64','{2,2,0}'),
    ('yz_solr_upgrade_downgrade', 'fedora-17-64','{2,2,0}'),
    ('yz_solr_upgrade_downgrade', 'freebsd-9-64','{2,2,0}'),
    ('yz_solr_upgrade_downgrade', 'osx-64','{2,2,0}'),
    ('yz_solr_upgrade_downgrade', 'solaris-10u9-64','{2,2,0}'),
    ('yz_solr_upgrade_downgrade', 'ubuntu-1004-64','{2,2,0}'),
    ('yz_solr_upgrade_downgrade', 'ubuntu-1204-64','{2,2,0}'),

    ('test_hll', 'centos-5-64','{2,2,0}'),
    ('test_hll', 'centos-6-64','{2,2,0}'),
    ('test_hll', 'fedora-17-64','{2,2,0}'),
    ('test_hll', 'freebsd-9-64','{2,2,0}'),
    ('test_hll', 'osx-64','{2,2,0}'),
    ('test_hll', 'solaris-10u9-64','{2,2,0}'),
    ('test_hll', 'ubuntu-1004-64','{2,2,0}'),
    ('test_hll', 'ubuntu-1204-64','{2,2,0}'),

    ('verify_job_enable_ac', 'centos-5-64','{2,2,0}'),
    ('verify_job_enable_ac', 'centos-6-64','{2,2,0}'),
    ('verify_job_enable_ac', 'fedora-17-64','{2,2,0}'),
    ('verify_job_enable_ac', 'freebsd-9-64','{2,2,0}'),
    ('verify_job_enable_ac', 'osx-64','{2,2,0}'),
    ('verify_job_enable_ac', 'solaris-10u9-64','{2,2,0}'),
    ('verify_job_enable_ac', 'ubuntu-1004-64','{2,2,0}'),
    ('verify_job_enable_ac', 'ubuntu-1204-64','{2,2,0}'),

    ('verify_job_enable_rc', 'centos-5-64','{2,2,0}'),
    ('verify_job_enable_rc', 'centos-6-64','{2,2,0}'),
    ('verify_job_enable_rc', 'fedora-17-64','{2,2,0}'),
    ('verify_job_enable_rc', 'freebsd-9-64','{2,2,0}'),
    ('verify_job_enable_rc', 'osx-64','{2,2,0}'),
    ('verify_job_enable_rc', 'solaris-10u9-64','{2,2,0}'),
    ('verify_job_enable_rc', 'ubuntu-1004-64','{2,2,0}'),
    ('verify_job_enable_rc', 'ubuntu-1204-64','{2,2,0}'),

    ('verify_job_switch_defaults', 'centos-5-64','{2,2,0}'),
    ('verify_job_switch_defaults', 'centos-6-64','{2,2,0}'),
    ('verify_job_switch_defaults', 'fedora-17-64','{2,2,0}'),
    ('verify_job_switch_defaults', 'freebsd-9-64','{2,2,0}'),
    ('verify_job_switch_defaults', 'osx-64','{2,2,0}'),
    ('verify_job_switch_defaults', 'solaris-10u9-64','{2,2,0}'),
    ('verify_job_switch_defaults', 'ubuntu-1004-64','{2,2,0}'),
    ('verify_job_switch_defaults', 'ubuntu-1204-64','{2,2,0}')
    
    RETURNING id)

INSERT INTO projects_tests (project_id, test_id)
    SELECT projects.id, t.id FROM projects, t
     WHERE (projects.name = 'riak' OR projects.name = 'riak_ee');

COMMIT;
