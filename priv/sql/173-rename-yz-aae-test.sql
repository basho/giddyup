BEGIN;

-- From https://github.com/basho/yokozuna/pull/593
UPDATE tests set name = 'yz_aae_test' where name = 'aae_test';

COMMIT;
