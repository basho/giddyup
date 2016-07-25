BEGIN;

-- Remove test results from bad tests:
DELETE FROM artifacts where test_result_id in (SELECT id FROM test_results WHERE scorecard_id = 252);
DELETE FROM test_results WHERE scorecard_id = 252;
DELETE FROM scorecards WHERE id = 252;

COMMIT;
