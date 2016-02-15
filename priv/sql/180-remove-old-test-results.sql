BEGIN;

-- Remove test results from bad tests:
DELETE FROM artifacts where test_result_id in (SELECT id FROM test_results WHERE scorecard_id in (SELECT sc.id FROM scorecards AS sc WHERE project_id=2 AND name IN ('riak_ee-ts_pb1','object_ttl_a1','43c71d91e4b92aa053716c7535914467905ab981','0.0.2')));
DELETE FROM test_results WHERE scorecard_id in (SELECT sc.id FROM scorecards AS sc WHERE project_id=2 AND name IN ('riak_ee-ts_pb1','object_ttl_a1','43c71d91e4b92aa053716c7535914467905ab981','0.0.2'));
DELETE FROM scorecards WHERE id IN (SELECT sc.id FROM scorecards AS sc WHERE project_id=2 AND name IN ('riak_ee-ts_pb1','object_ttl_a1','43c71d91e4b92aa053716c7535914467905ab981','0.0.2'));

COMMIT;
