--alter allocation tables

ALTER TABLE `portfolio_entry_resource_plan_allocated_actor` ADD COLUMN `follow_package_dates` TINYINT(1) NULL DEFAULT NULL  AFTER `is_confirmed` ;
ALTER TABLE `portfolio_entry_resource_plan_allocated_org_unit` ADD COLUMN `follow_package_dates` TINYINT(1) NULL DEFAULT NULL  AFTER `is_confirmed` ;


--//@UNDO

ALTER TABLE `portfolio_entry_resource_plan_allocated_org_unit` DROP COLUMN `follow_package_dates` ;
ALTER TABLE `portfolio_entry_resource_plan_allocated_actor` DROP COLUMN `follow_package_dates` ;


