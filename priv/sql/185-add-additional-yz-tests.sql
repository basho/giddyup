BEGIN;

-- Insert new tests for 2.0.7+ needs
WITH s as (INSERT INTO tests (name, platform, min_version_a, max_version_a) VALUES
       ('yz_faceted_search', 'centos-5-64', '{2,0,7}', '{2,0,99}'),
       ('yz_faceted_search', 'centos-6-64', '{2,0,7}', '{2,0,99}'),
       ('yz_faceted_search', 'fedora-17-64', '{2,0,7}', '{2,0,99}'),
       ('yz_faceted_search', 'freebsd-9-64', '{2,0,7}', '{2,0,99}'),
       ('yz_faceted_search', 'osx-64', '{2,0,7}', '{2,0,99}'),
       ('yz_faceted_search', 'solaris-10u9-64', '{2,0,7}', '{2,0,99}'),
       ('yz_faceted_search', 'ubuntu-1004-64', '{2,0,7}', '{2,0,99}'),
       ('yz_faceted_search', 'ubuntu-1204-64', '{2,0,7}', '{2,0,99}'),
       ('yz_fuse_upgrade', 'centos-5-64', '{2,0,7}', '{2,0,99}'),
       ('yz_fuse_upgrade', 'centos-6-64', '{2,0,7}', '{2,0,99}'),
       ('yz_fuse_upgrade', 'fedora-17-64', '{2,0,7}', '{2,0,99}'),
       ('yz_fuse_upgrade', 'freebsd-9-64', '{2,0,7}', '{2,0,99}'),
       ('yz_fuse_upgrade', 'osx-64', '{2,0,7}', '{2,0,99}'),
       ('yz_fuse_upgrade', 'solaris-10u9-64', '{2,0,7}', '{2,0,99}'),
       ('yz_fuse_upgrade', 'ubuntu-1004-64', '{2,0,7}', '{2,0,99}'),
       ('yz_fuse_upgrade', 'ubuntu-1204-64', '{2,0,7}', '{2,0,99}'),
       ('yz_solrq_test', 'centos-5-64', '{2,0,7}', '{2,0,99}'),
       ('yz_solrq_test', 'centos-6-64', '{2,0,7}', '{2,0,99}'),
       ('yz_solrq_test', 'fedora-17-64', '{2,0,7}', '{2,0,99}'),
       ('yz_solrq_test', 'freebsd-9-64', '{2,0,7}', '{2,0,99}'),
       ('yz_solrq_test', 'osx-64', '{2,0,7}', '{2,0,99}'),
       ('yz_solrq_test', 'solaris-10u9-64', '{2,0,7}', '{2,0,99}'),
       ('yz_solrq_test', 'ubuntu-1004-64', '{2,0,7}', '{2,0,99}'),
       ('yz_solrq_test', 'ubuntu-1204-64', '{2,0,7}', '{2,0,99}'),
       ('yz_startup_shutdown', 'centos-5-64', '{2,0,7}', '{2,0,99}'),
       ('yz_startup_shutdown', 'centos-6-64', '{2,0,7}', '{2,0,99}'),
       ('yz_startup_shutdown', 'fedora-17-64', '{2,0,7}', '{2,0,99}'),
       ('yz_startup_shutdown', 'freebsd-9-64', '{2,0,7}', '{2,0,99}'),
       ('yz_startup_shutdown', 'osx-64', '{2,0,7}', '{2,0,99}'),
       ('yz_startup_shutdown', 'solaris-10u9-64', '{2,0,7}', '{2,0,99}'),
       ('yz_startup_shutdown', 'ubuntu-1004-64', '{2,0,7}', '{2,0,99}'),
       ('yz_startup_shutdown', 'ubuntu-1204-64', '{2,0,7}', '{2,0,99}')
       RETURNING id)

INSERT INTO projects_tests (project_id, test_id)
   SELECT projects.id, s.id FROM projects, s
    WHERE (projects.name = 'riak' OR projects.name = 'riak_ee');

-- Insert new tests for 2.1.2+ needs
WITH t as (INSERT INTO tests (name, platform, min_version_a) VALUES
       ('yz_faceted_search', 'centos-5-64','{2,2,0}'),
       ('yz_faceted_search', 'centos-6-64','{2,2,0}'),
       ('yz_faceted_search', 'fedora-17-64','{2,2,0}'),
       ('yz_faceted_search', 'freebsd-9-64','{2,2,0}'),
       ('yz_faceted_search', 'osx-64','{2,2,0}'),
       ('yz_faceted_search', 'solaris-10u9-64','{2,2,0}'),
       ('yz_faceted_search', 'ubuntu-1004-64','{2,2,0}'),
       ('yz_faceted_search', 'ubuntu-1204-64','{2,2,0}'),
       ('yz_fuse_upgrade', 'centos-5-64','{2,2,0}'),
       ('yz_fuse_upgrade', 'centos-6-64','{2,2,0}'),
       ('yz_fuse_upgrade', 'fedora-17-64','{2,2,0}'),
       ('yz_fuse_upgrade', 'freebsd-9-64','{2,2,0}'),
       ('yz_fuse_upgrade', 'osx-64','{2,2,0}'),
       ('yz_fuse_upgrade', 'solaris-10u9-64','{2,2,0}'),
       ('yz_fuse_upgrade', 'ubuntu-1004-64','{2,2,0}'),
       ('yz_fuse_upgrade', 'ubuntu-1204-64','{2,2,0}'),
       ('yz_solrq_test', 'centos-5-64','{2,2,0}'),
       ('yz_solrq_test', 'centos-6-64','{2,2,0}'),
       ('yz_solrq_test', 'fedora-17-64','{2,2,0}'),
       ('yz_solrq_test', 'freebsd-9-64','{2,2,0}'),
       ('yz_solrq_test', 'osx-64','{2,2,0}'),
       ('yz_solrq_test', 'solaris-10u9-64','{2,2,0}'),
       ('yz_solrq_test', 'ubuntu-1004-64','{2,2,0}'),
       ('yz_solrq_test', 'ubuntu-1204-64','{2,2,0}'),
       ('yz_startup_shutdown', 'centos-5-64','{2,2,0}'),
       ('yz_startup_shutdown', 'centos-6-64','{2,2,0}'),
       ('yz_startup_shutdown', 'fedora-17-64','{2,2,0}'),
       ('yz_startup_shutdown', 'freebsd-9-64','{2,2,0}'),
       ('yz_startup_shutdown', 'osx-64','{2,2,0}'),
       ('yz_startup_shutdown', 'solaris-10u9-64','{2,2,0}'),
       ('yz_startup_shutdown', 'ubuntu-1004-64','{2,2,0}'),
       ('yz_startup_shutdown', 'ubuntu-1204-64','{2,2,0}')
         RETURNING id)

INSERT INTO projects_tests (project_id, test_id)
    SELECT projects.id, t.id FROM projects, t
     WHERE (projects.name = 'riak' OR projects.name = 'riak_ee');

COMMIT;
