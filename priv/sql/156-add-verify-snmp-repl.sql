BEGIN;

WITH t as (INSERT INTO tests (name, platform, min_version_a, max_version_a) VALUES
       ('verify_snmp_repl', 'centos-5-64', '{2,0,7}', '{2,0,99}'),
       ('verify_snmp_repl', 'centos-6-64', '{2,0,7}', '{2,0,99}'),
       ('verify_snmp_repl', 'fedora-17-64', '{2,0,7}', '{2,0,99}'),
       ('verify_snmp_repl', 'freebsd-9-64', '{2,0,7}', '{2,0,99}'),
       ('verify_snmp_repl', 'osx-64', '{2,0,7}', '{2,0,99}'),
       ('verify_snmp_repl', 'solaris-10u9-64', '{2,0,7}', '{2,0,99}'),
       ('verify_snmp_repl', 'ubuntu-1004-64', '{2,0,7}', '{2,0,99}'),
       ('verify_snmp_repl', 'ubuntu-1204-64', '{2,0,7}', '{2,0,99}'),
       ('verify_snmp_repl', 'centos-5-64', '{2,1,2}', NULL),
       ('verify_snmp_repl', 'centos-6-64', '{2,1,2}', NULL),
       ('verify_snmp_repl', 'fedora-17-64', '{2,1,2}', NULL),
       ('verify_snmp_repl', 'freebsd-9-64', '{2,1,2}', NULL),
       ('verify_snmp_repl', 'osx-64', '{2,1,2}', NULL),
       ('verify_snmp_repl', 'solaris-10u9-64', '{2,1,2}', NULL),
       ('verify_snmp_repl', 'ubuntu-1004-64', '{2,1,2}', NULL)
       RETURNING id)

INSERT INTO projects_tests (project_id, test_id)
   SELECT projects.id, t.id FROM projects, t
    WHERE projects.name = 'riak_ee';

COMMIT;
