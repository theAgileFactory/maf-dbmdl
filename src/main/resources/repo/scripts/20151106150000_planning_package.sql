ALTER TABLE `portfolio_entry_planning_package` DROP COLUMN `css_class`;

ALTER TABLE `portfolio_entry_planning_package_pattern` DROP COLUMN `css_class`;

--//@UNDO


ALTER TABLE `portfolio_entry_planning_package` ADD COLUMN `css_class` VARCHAR(64) NULL DEFAULT NULL  AFTER `portfolio_entry_planning_package_type_id` ;

ALTER TABLE `portfolio_entry_planning_package_pattern` ADD COLUMN `css_class` VARCHAR(64) NULL DEFAULT NULL  AFTER `portfolio_entry_planning_package_type_id` ;

