-- // v16-0-0_add_request_comment_in_life_cycle_milestone_instance
-- Migration SQL that makes the change goes here.

ALTER TABLE life_cycle_milestone_instance
ADD COLUMN request_comments VARCHAR(1500);

-- //@UNDO
-- SQL to undo the change goes here.

ALTER TABLE life_cycle_milestone_instance
DROP COLUMN request_comments;
