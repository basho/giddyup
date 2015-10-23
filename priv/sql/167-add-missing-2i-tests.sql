BEGIN;

-- Add a couple of 2i tests to EE for 2.1.2+
WITH t as (INSERT INTO tests (name, platform, min_version_a) VALUES
       ('verify_2i_eqc', 'centos-5-64', '{2,1,2}'),
       ('verify_2i_eqc', 'centos-6-64', '{2,1,2}'),
       ('verify_2i_eqc', 'fedora-17-64', '{2,1,2}'),
       ('verify_2i_eqc', 'freebsd-9-64', '{2,1,2}'),
       ('verify_2i_eqc', 'osx-64', '{2,1,2}'),
       ('verify_2i_eqc', 'solaris-10u9-64', '{2,1,2}'),
       ('verify_2i_eqc', 'ubuntu-1004-64', '{2,1,2}'),
       ('verify_2i_eqc', 'ubuntu-1204-64', '{2,1,2}'),
       ('verify_2i_returnbody', 'centos-5-64', '{2,1,2}'),
       ('verify_2i_returnbody', 'centos-6-64', '{2,1,2}'),
       ('verify_2i_returnbody', 'fedora-17-64', '{2,1,2}'),
       ('verify_2i_returnbody', 'freebsd-9-64', '{2,1,2}'),
       ('verify_2i_returnbody', 'osx-64', '{2,1,2}'),
       ('verify_2i_returnbody', 'solaris-10u9-64', '{2,1,2}'),
       ('verify_2i_returnbody', 'ubuntu-1004-64', '{2,1,2}'),
       ('verify_2i_returnbody', 'ubuntu-1204-64', '{2,1,2}')
       RETURNING id)

INSERT INTO projects_tests (project_id, test_id)
    SELECT projects.id, t.id FROM projects, t
     WHERE (projects.name = 'riak' OR projects.name = 'riak_ee');

COMMIT;
