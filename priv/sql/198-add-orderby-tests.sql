BEGIN;
WITH newtests as (INSERT INTO tests (name, platform, backend) VALUES
       ('ts_cluster_updowngrade_order_by_SUITE','centos-6-64','eleveldb'),
       ('ts_cluster_updowngrade_group_by_SUITE','centos-6-64','eleveldb')
       RETURNING id)

INSERT INTO projects_tests (project_id, test_id)
   SELECT projects.id, newtests.id FROM projects, newtests
    WHERE projects.name IN ('riak_ts','riak_ts_ee');

COMMIT;
