
ALTER TABLE `portfolio_entry_planning_package` ADD COLUMN `ref_id` VARCHAR(64) NULL;

--//@UNDO

ALTER TABLE `portfolio_entry_planning_package` DROP COLUMN `ref_id` ;





