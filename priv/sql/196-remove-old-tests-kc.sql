BEGIN;
-- riak-0.8.0

    delete from artifacts using test_results where test_result_id = test_results.id and test_results.scorecard_id = 139;
    delete from test_results where test_results.scorecard_id = 139;
    delete from scorecards where project_id=1 and name='0.8.0';    

-- riak_ee-2.2.0-merge1

    delete from artifacts using test_results where test_result_id = test_results.id and test_results.long_version = 'riak_ee-2.2.0-merge1';
    delete from scorecards where id=(select distinct scorecard_id from test_results where long_version = 'riak_ee-2.2.0-merge1');
    delete from test_results where long_version = 'riak_ee-2.2.0-merge1';    

-- riak_ee-2.2.0-devtest1

    delete from artifacts using test_results where test_result_id = test_results.id and test_results.long_version = 'riak_ee-2.2.0-devtest1';
    delete from scorecards where id=(select distinct scorecard_id from test_results where long_version = 'riak_ee-2.2.0-devtest1');
    delete from test_results where long_version = 'riak_ee-2.2.0-devtest1'; 

-- smoke_tests

    delete from artifacts using test_results where test_result_id = test_results.id and test_results.scorecard_id in (select distinct id from scorecards where project_id=5);
    delete from test_results where scorecard_id in (select distinct id from scorecards where project_id=5); 
    delete from scorecards where project_id=5;   
    delete from projects where id=5;
    delete from projects_tests where project_id=5;

-- riak_ts_ee before version 1.0.0

    delete from artifacts using test_results where test_result_id = test_results.id and test_results.scorecard_id in ('134','135','136','137','138','140','141');
    delete from test_results where scorecard_id in ('134','135','136','137','138','140','141');
    delete from scorecards where id in ('134','135','136','137','138','140','141');    

COMMIT;