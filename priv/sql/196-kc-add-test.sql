BEGIN;
WITH t as (INSERT INTO tests (name, platform, min_version_a) VALUES
       ('AAAAAAA', 'centos-5-64', '{0,8,0}')
       RETURNING id)

INSERT INTO projects_tests (project_id, test_id)
    SELECT projects.id, t.id FROM projects, t
     WHERE (projects.name = 'riak');

COMMIT;