BEGIN;
    delete from artifacts using test_results, tests where test_result_id = test_results.id AND test_id = tests.id AND tests.name = 'yz_handoff';
    delete from test_results using tests where test_id = tests.id AND tests.name = 'yz_handoff';
    update tests set min_version_a = '{2,2,0}' where name='yz_handoff';
COMMIT;
