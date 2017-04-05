BEGIN;
WITH newtests as (INSERT INTO tests (name, platform, min_version_a) VALUES
       ('kv679_dataloss_fb', 'centos-5-64','{2,3,0}'),
       ('kv679_dataloss_fb', 'centos-6-64','{2,3,0}'),
       ('kv679_dataloss_fb', 'fedora-17-64','{2,3,0}'),
       ('kv679_dataloss_fb', 'freebsd-9-64','{2,3,0}'),
       ('kv679_dataloss_fb', 'osx-64','{2,3,0}'),
       ('kv679_dataloss_fb', 'solaris-10u9-64','{2,3,0}'),
       ('kv679_dataloss_fb', 'ubuntu-1004-64','{2,3,0}'),
       ('kv679_dataloss_fb', 'ubuntu-1204-64','{2,3,0}'),

       ('kv679_dataloss_fb2', 'centos-5-64','{2,3,0}'),
       ('kv679_dataloss_fb2', 'centos-6-64','{2,3,0}'),
       ('kv679_dataloss_fb2', 'fedora-17-64','{2,3,0}'),
       ('kv679_dataloss_fb2', 'freebsd-9-64','{2,3,0}'),
       ('kv679_dataloss_fb2', 'osx-64','{2,3,0}'),
       ('kv679_dataloss_fb2', 'solaris-10u9-64','{2,3,0}'),
       ('kv679_dataloss_fb2', 'ubuntu-1004-64','{2,3,0}'),
       ('kv679_dataloss_fb2', 'ubuntu-1204-64','{2,3,0}')
       RETURNING id)

INSERT INTO projects_tests (project_id, test_id)
   SELECT projects.id, newtests.id FROM projects, newtests
    WHERE projects.name IN ('riak','riak_ee');

COMMIT;

