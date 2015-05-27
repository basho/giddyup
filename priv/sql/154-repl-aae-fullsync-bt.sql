BEGIN;

-- Update existing tests to 2.0.6
UPDATE tests SET min_version_a = '{2,0,6}', max_version_a = '{2,0,99}'
 WHERE name = 'repl_aae_fullsync_bt' AND min_version_a = '{2,2,0}';

-- Insert new tests starting at 2.1.2
WITH t as (INSERT INTO tests (name, platform, min_version_a) VALUES
       ('repl_aae_fullsync_bt', 'centos-5-64', '{2,1,2}'),
       ('repl_aae_fullsync_bt', 'centos-6-64', '{2,1,2}'),
       ('repl_aae_fullsync_bt', 'fedora-17-64', '{2,1,2}'),
       ('repl_aae_fullsync_bt', 'freebsd-9-64', '{2,1,2}'),
       ('repl_aae_fullsync_bt', 'osx-64', '{2,1,2}'),
       ('repl_aae_fullsync_bt', 'solaris-10u9-64', '{2,1,2}'),
       ('repl_aae_fullsync_bt', 'ubuntu-1004-64', '{2,1,2}'),
       ('repl_aae_fullsync_bt', 'ubuntu-1204-64', '{2,1,2}')
       RETURNING id)

INSERT INTO projects_tests (project_id, test_id)
   SELECT projects.id, t.id FROM projects, t
    WHERE projects.name = 'riak_ee';

COMMIT;
