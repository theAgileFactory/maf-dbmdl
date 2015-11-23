
ALTER TABLE `portfolio_entry_planning_package` DROP COLUMN `is_important` ;

ALTER TABLE `portfolio_entry_planning_package_pattern` DROP COLUMN `is_important` ;

--//@UNDO

ALTER TABLE `portfolio_entry_planning_package` ADD COLUMN `is_important` TINYINT(1) NULL DEFAULT 0  AFTER `portfolio_entry_planning_package_type_id` ;

ALTER TABLE `portfolio_entry_planning_package_pattern` ADD COLUMN `is_important` TINYINT(1) NULL DEFAULT 0  AFTER `portfolio_entry_planning_package_type_id` ;







