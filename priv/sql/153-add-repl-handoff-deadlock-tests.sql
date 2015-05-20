BEGIN;

WITH t as (INSERT INTO tests (name, platform, min_version_a) VALUES
       ('repl_handoff_deadlock_aae', 'centos-5-64', '{2,0,6}'),
       ('repl_handoff_deadlock_aae', 'centos-6-64', '{2,0,6}'),
       ('repl_handoff_deadlock_aae', 'fedora-17-64', '{2,0,6}'),
       ('repl_handoff_deadlock_aae', 'freebsd-9-64', '{2,0,6}'),
       ('repl_handoff_deadlock_aae', 'osx-64', '{2,0,6}'),
       ('repl_handoff_deadlock_aae', 'solaris-10u9-64', '{2,0,6}'),
       ('repl_handoff_deadlock_aae', 'ubuntu-1004-64', '{2,0,6}'),
       ('repl_handoff_deadlock_aae', 'ubuntu-1204-64', '{2,0,6}'),
       ('repl_handoff_deadlock_keylist', 'centos-5-64', '{2,0,6}'),
       ('repl_handoff_deadlock_keylist', 'centos-6-64', '{2,0,6}'),
       ('repl_handoff_deadlock_keylist', 'fedora-17-64', '{2,0,6}'),
       ('repl_handoff_deadlock_keylist', 'freebsd-9-64', '{2,0,6}'),
       ('repl_handoff_deadlock_keylist', 'osx-64', '{2,0,6}'),
       ('repl_handoff_deadlock_keylist', 'solaris-10u9-64', '{2,0,6}'),
       ('repl_handoff_deadlock_keylist', 'ubuntu-1004-64', '{2,0,6}'),
       ('repl_handoff_deadlock_keylist', 'ubuntu-1204-64', '{2,0,6}')

       RETURNING id)

INSERT INTO projects_tests (project_id, test_id)
   SELECT projects.id, t.id FROM projects, t
    WHERE projects.name = 'riak_ee';

COMMIT;
