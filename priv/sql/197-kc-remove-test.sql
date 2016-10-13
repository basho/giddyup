BEGIN;
    delete from artifacts using test_results, tests where test_result_id = test_results.id AND test_id = tests.id AND tests.name = 'AAAAAAA';
    delete from test_results using tests where test_id = tests.id AND tests.name = 'AAAAAAA';    
    delete from projects_tests using tests where test_id = tests.id and tests.name='AAAAAAA';
    delete from tests where name='AAAAAAA';
COMMIT;