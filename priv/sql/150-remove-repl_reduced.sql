BEGIN;
    delete from artifacts using test_results, tests where test_result_id = test_results.id AND test_id = tests.id AND tests.name = 'repl_reduced';
    delete from test_results using tests where test_id = tests.id AND tests.name = 'repl_reduced';    
    delete from projects_tests using tests where test_id = tests.id and tests.name='repl_reduced';
    delete from tests where name='repl_reduced';
COMMIT;
