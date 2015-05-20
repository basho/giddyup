BEGIN;

WITH t as (INSERT INTO tests (name, platform, min_version_a) VALUES
       ('repl_aae_fullsync_bt', 'centos-5-64', '{2,2,0}'),
       ('repl_aae_fullsync_bt', 'centos-6-64', '{2,2,0}'),
       ('repl_aae_fullsync_bt', 'fedora-17-64', '{2,2,0}'),
       ('repl_aae_fullsync_bt', 'freebsd-9-64', '{2,2,0}'),
       ('repl_aae_fullsync_bt', 'osx-64', '{2,2,0}'),
       ('repl_aae_fullsync_bt', 'solaris-10u9-64', '{2,2,0}'),
       ('repl_aae_fullsync_bt', 'ubuntu-1004-64', '{2,2,0}'),
       ('repl_aae_fullsync_bt', 'ubuntu-1204-64', '{2,2,0}')
       RETURNING id)

INSERT INTO projects_tests (project_id, test_id)
   SELECT projects.id, t.id FROM projects, t
    WHERE projects.name = 'riak_ee';

COMMIT;
