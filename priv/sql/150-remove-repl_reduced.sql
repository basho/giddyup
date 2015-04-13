BEGIN;
    delete from projects_tests where test_id in (select id from tests where name='repl_reduced');
COMMIT;
