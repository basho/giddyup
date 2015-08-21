BEGIN;

-- Remove test results from bad tests:
DELETE FROM artifacts where test_result_id in (SELECT id FROM test_results WHERE scorecard_id in (SELECT id FROM scorecards WHERE name LIKE '1.4.%' AND name <> '1.4.12' OR name IN ('unknown','current')));
DELETE FROM test_results WHERE scorecard_id in (SELECT id FROM scorecards WHERE name LIKE '1.4.%' AND name <> '1.4.12' OR name IN ('unknown','current'));
DELETE FROM artifacts where test_result_id in (SELECT id FROM test_results WHERE long_version='riak_ee-2.1.2pre2');
DELETE FROM test_results where id in (SELECT id FROM test_results WHERE long_version='riak_ee-2.1.2pre2');
DELETE FROM scorecards WHERE id IN (SELECT id FROM scorecards WHERE name LIKE '1.4.%' AND name <> '1.4.12' OR name IN ('unknown','current'));

COMMIT;
