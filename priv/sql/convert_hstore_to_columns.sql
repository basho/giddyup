-- BEGIN;

-- First add columns for all the used hstore entries.
ALTER TABLE tests
ADD COLUMN platform character varying(255) NOT NULL DEFAULT 'default',
ADD COLUMN backend character varying(255),
ADD COLUMN min_version character varying(255),
ADD COLUMN max_version character varying(255),
ADD COLUMN upgrade_version character varying(255);

-- Now convert the hstore into actual columns
UPDATE tests
SET platform = tags->'platform',
    backend = tags->'backend',
    min_version = tags->'min_version',
    max_version = tags->'max_version',
    upgrade_version = tags->'upgrade_version';

-- Now drop the hstore column
ALTER TABLE tests DROP COLUMN tags;

-- index important fields
CREATE INDEX index_tests_on_platform ON tests (platform);
CREATE INDEX index_tests_on_version ON tests (min_version, max_version);
-- COMMIT;
