BEGIN;

-- Update existing tests that were set to 2.1.0 or 2.2.0 to 2.0.6
UPDATE tests SET min_version_a = '{2,0,6}', max_version_a = '{2,0,99}'
 WHERE name LIKE 'yz_%' AND (min_version_a = '{2,1,0}' OR min_version_a = '{2,2,0}');

-- Insert new tests for 2.0.6/2.1.2 with max needs
WITH s as (INSERT INTO tests (name, platform, min_version_a, max_version_a) VALUES
       ('yz_extractors', 'centos-5-64', '{2,0,6}', '{2,0,6}'),
       ('yz_extractors', 'centos-6-64', '{2,0,6}', '{2,0,6}'),
       ('yz_extractors', 'fedora-17-64', '{2,0,6}', '{2,0,6}'),
       ('yz_extractors', 'freebsd-9-64', '{2,0,6}', '{2,0,6}'),
       ('yz_extractors', 'osx-64', '{2,0,6}', '{2,0,6}'),
       ('yz_extractors', 'solaris-10u9-64', '{2,0,6}', '{2,0,6}'),
       ('yz_extractors', 'ubuntu-1004-64', '{2,0,6}', '{2,0,6}'),
       ('yz_extractors', 'ubuntu-1204-64', '{2,0,6}', '{2,0,6}'),
       ('yz_extractors', 'centos-5-64', '{2,1,2}', '{2,1,2}'),
       ('yz_extractors', 'centos-6-64', '{2,1,2}', '{2,1,2}'),
       ('yz_extractors', 'fedora-17-64', '{2,1,2}', '{2,1,2}'),
       ('yz_extractors', 'freebsd-9-64', '{2,1,2}', '{2,1,2}'),
       ('yz_extractors', 'osx-64', '{2,1,2}', '{2,1,2}'),
       ('yz_extractors', 'solaris-10u9-64', '{2,1,2}', '{2,1,2}'),
       ('yz_extractors', 'ubuntu-1004-64', '{2,1,2}', '{2,1,2}'),
       ('yz_extractors', 'ubuntu-1204-64', '{2,1,2}', '{2,1,2}'),
       ('yz_core_properties_create_unload', 'centos-5-64', '{2,0,6}', '{2,0,99}'),
       ('yz_core_properties_create_unload', 'centos-6-64', '{2,0,6}', '{2,0,99}'),
       ('yz_core_properties_create_unload', 'fedora-17-64', '{2,0,6}', '{2,0,99}'),
       ('yz_core_properties_create_unload', 'freebsd-9-64', '{2,0,6}', '{2,0,99}'),
       ('yz_core_properties_create_unload', 'osx-64', '{2,0,6}', '{2,0,99}'),
       ('yz_core_properties_create_unload', 'solaris-10u9-64', '{2,0,6}', '{2,0,99}'),
       ('yz_core_properties_create_unload', 'ubuntu-1004-64', '{2,0,6}', '{2,0,99}'),
       ('yz_core_properties_create_unload', 'ubuntu-1204-64', '{2,0,6}', '{2,0,99}'),
       ('yz_default_bucket_type_upgrade', 'centos-5-64', '{2,0,6}', '{2,0,6}'),
       ('yz_default_bucket_type_upgrade', 'centos-6-64', '{2,0,6}', '{2,0,6}'),
       ('yz_default_bucket_type_upgrade', 'fedora-17-64', '{2,0,6}', '{2,0,6}'),
       ('yz_default_bucket_type_upgrade', 'freebsd-9-64', '{2,0,6}', '{2,0,6}'),
       ('yz_default_bucket_type_upgrade', 'osx-64', '{2,0,6}', '{2,0,6}'),
       ('yz_default_bucket_type_upgrade', 'solaris-10u9-64', '{2,0,6}', '{2,0,6}'),
       ('yz_default_bucket_type_upgrade', 'ubuntu-1004-64', '{2,0,6}', '{2,0,6}'),
       ('yz_default_bucket_type_upgrade', 'ubuntu-1204-64', '{2,0,6}', '{2,0,6}'),
       ('yz_default_bucket_type_upgrade', 'centos-5-64', '{2,1,2}', '{2,1,2}'),
       ('yz_default_bucket_type_upgrade', 'centos-6-64', '{2,1,2}', '{2,1,2}'),
       ('yz_default_bucket_type_upgrade', 'fedora-17-64', '{2,1,2}', '{2,1,2}'),
       ('yz_default_bucket_type_upgrade', 'freebsd-9-64', '{2,1,2}', '{2,1,2}'),
       ('yz_default_bucket_type_upgrade', 'osx-64', '{2,1,2}', '{2,1,2}'),
       ('yz_default_bucket_type_upgrade', 'solaris-10u9-64', '{2,1,2}', '{2,1,2}'),
       ('yz_default_bucket_type_upgrade', 'ubuntu-1004-64', '{2,1,2}', '{2,1,2}'),
       ('yz_default_bucket_type_upgrade', 'ubuntu-1204-64', '{2,1,2}', '{2,1,2}')
       RETURNING id)

INSERT INTO projects_tests (project_id, test_id)
   SELECT projects.id, s.id FROM projects, s
    WHERE (projects.name = 'riak' OR projects.name = 'riak_ee');

-- Insert new tests for 2.0.6/2.1.2 without max needs
WITH t as (INSERT INTO tests (name, platform, min_version_a) VALUES
       ('yz_core_properties_create_unload', 'centos-5-64', '{2,1,2}'),
       ('yz_core_properties_create_unload', 'centos-6-64', '{2,1,2}'),
       ('yz_core_properties_create_unload', 'fedora-17-64', '{2,1,2}'),
       ('yz_core_properties_create_unload', 'freebsd-9-64', '{2,1,2}'),
       ('yz_core_properties_create_unload', 'osx-64', '{2,1,2}'),
       ('yz_core_properties_create_unload', 'solaris-10u9-64', '{2,1,2}'),
       ('yz_core_properties_create_unload', 'ubuntu-1004-64', '{2,1,2}'),
       ('yz_core_properties_create_unload', 'ubuntu-1204-64', '{2,1,2}'),
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
       ('yz_handoff', 'centos-5-64', '{2,1,2}'),
       ('yz_handoff', 'centos-6-64', '{2,1,2}'),
       ('yz_handoff', 'fedora-17-64', '{2,1,2}'),
       ('yz_handoff', 'freebsd-9-64', '{2,1,2}'),
       ('yz_handoff', 'osx-64', '{2,1,2}'),
       ('yz_handoff', 'solaris-10u9-64', '{2,1,2}'),
       ('yz_handoff', 'ubuntu-1004-64', '{2,1,2}'),
       ('yz_handoff', 'ubuntu-1204-64', '{2,1,2}'),
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
       ('yz_ensemble', 'ubuntu-1204-64', '{2,1,0}')
       RETURNING id)

INSERT INTO projects_tests (project_id, test_id)
   SELECT projects.id, t.id FROM projects, t
    WHERE (projects.name = 'riak' OR projects.name = 'riak_ee');

COMMIT;
