BEGIN;

-- Set backend for async job switch tests, which use 2i
UPDATE tests set backend = 'eleveldb' where name = 'verify_job_enable_ac';
UPDATE tests set backend = 'eleveldb' where name = 'verify_job_enable_rc';

COMMIT;
