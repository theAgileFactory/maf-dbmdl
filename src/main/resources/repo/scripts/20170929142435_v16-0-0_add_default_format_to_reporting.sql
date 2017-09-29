-- // v16-0-0_add_default_format_to_reporting
-- Migration SQL that makes the change goes here.

ALTER TABLE reporting
ADD COLUMN default_format VARCHAR(256);

-- //@UNDO
-- SQL to undo the change goes here.

ALTER TABLE reporting
DROP COLUMN default_format ;

