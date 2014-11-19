-- This migration adds integer-array versions that are directly
-- comparable. Previously, this used string comparisons, meaning that
-- 1.4.10 < 1.4.9, making some tests not appear on later scorecards
-- when they should have.
BEGIN;

-- Add columns for integer-array versions
ALTER TABLE tests
      ADD COLUMN min_version_a integer[3],
      ADD COLUMN max_version_a integer[3];

-- Add an index
CREATE INDEX tests_by_version_a on tests (min_version_a, max_version_a);

-- Define a reusable function for converting strings to version arrays
CREATE OR REPLACE FUNCTION to_version(version text) RETURNS integer[] AS
   $$ BEGIN RETURN CAST(regexp_matches(version, E'(\\d+).(\\d+).(\\d+)') AS integer[]); END; $$
   LANGUAGE plpgsql
   RETURNS NULL ON NULL INPUT;

-- Convert the columns
UPDATE tests
SET min_version_a = to_version(min_version),
    max_version_a = to_version(max_version);

COMMIT;
