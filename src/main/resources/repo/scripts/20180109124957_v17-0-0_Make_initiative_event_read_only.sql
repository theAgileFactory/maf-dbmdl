-- // v17-0-0_Make_initiative_event_read_only
-- Migration SQL that makes the change goes here.

ALTER TABLE portfolio_entry_event_type ADD COLUMN `read_only` TINYINT(1) DEFAULT 0;

-- //@UNDO
-- SQL to undo the change goes here.

ALTER TABLE portfolio_entry_event_type DROP COLUMN `read_only`;
