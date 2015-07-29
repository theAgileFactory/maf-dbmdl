--add is active flag

ALTER TABLE `portfolio_entry_planning_package_group` ADD COLUMN `is_active` TINYINT(1) NOT NULL DEFAULT 1  AFTER `description` ;

--//@UNDO

ALTER TABLE `portfolio_entry_planning_package_group` DROP COLUMN `is_active` ;


