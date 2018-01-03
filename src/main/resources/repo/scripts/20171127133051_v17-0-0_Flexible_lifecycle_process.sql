-- // v17-0-0_Flexible_lifecycle_process
-- Migration SQL that makes the change goes here.

ALTER TABLE life_cycle_process
ADD COLUMN `is_flexible` TINYINT(1) NOT NULL DEFAULT 0;

ALTER TABLE life_cycle_milestone
ADD COLUMN `sub_order` INT(5) DEFAULT 0 AFTER `order`,
ADD COLUMN `is_additional` TINYINT(1) DEFAULT 0 AFTER is_active,
MODIFY `life_cycle_process_id` BIGINT(20) NULL;

-- //@UNDO
-- SQL to undo the change goes here.

ALTER TABLE life_cycle_process DROP COLUMN is_flexible;

ALTER TABLE life_cycle_milestone
DROP COLUMN sub_order,
DROP COLUMN is_additional,
MODIFY life_cycle_process_id BIGINT(20) NOT NULL;