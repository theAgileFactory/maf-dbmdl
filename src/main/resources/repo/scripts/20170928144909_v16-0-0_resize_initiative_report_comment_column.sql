-- // v16-0-0_resize_initiative_report_comment_column
-- Migration SQL that makes the change goes here.

ALTER TABLE portfolio_entry_report
MODIFY COLUMN comments VARCHAR(5000);

-- //@UNDO
-- SQL to undo the change goes here.

ALTER TABLE portfolio_entry_report
MODIFY COLUMN comments VARCHAR(2500);

