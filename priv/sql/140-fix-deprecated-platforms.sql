BEGIN;

UPDATE tests
SET max_version = '1.4.99'
WHERE max_version IS NULL AND
      (platform = 'smartos-64' OR platform = 'ubuntu-1104-64');

COMMIT;
