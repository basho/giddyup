BEGIN;

-- From https://github.com/basho/riak_test/pull/1037
UPDATE tests set name = 'ts_simple_http_api_SUITE' where name = 'ts_http_api_SUITE';

COMMIT;
