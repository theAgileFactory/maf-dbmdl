--Budget tracking

INSERT INTO `preference`
(
`last_update`,
`uuid`,
`system_preference`)
VALUES
(
NOW(),
'BUDGET_TRACKING_EFFORT_BASED_PREFERENCE',
'1'
);
INSERT INTO `custom_attribute_definition`
(`object_type`,
`configuration`,
`attribute_type`,
`uuid`,
`name`,
`description`,
`last_update`)
VALUES
(
'java.lang.Object',
'default.value=false',
'BOOLEAN',
'BUDGET_TRACKING_EFFORT_BASED_PREFERENCE',
'preference.budget_tracking_effort_based_preference.name',
'preference.budget_tracking_effort_based_preference.description',
NOW()
);

ALTER TABLE `portfolio_entry_budget_line` ADD COLUMN `resource_object_type` VARCHAR(256) NULL DEFAULT NULL  AFTER `portfolio_entry_budget_id` , ADD COLUMN `resource_object_id` BIGINT(20) NULL DEFAULT NULL  AFTER `resource_object_type` ;

ALTER TABLE `work_order` ADD COLUMN `resource_object_type` VARCHAR(256) NULL DEFAULT NULL  AFTER `follow_package_dates` , ADD COLUMN `resource_object_id` BIGINT(20) NULL DEFAULT NULL  AFTER `resource_object_type` ;

ALTER TABLE `timesheet_report` ADD COLUMN `org_unit_id` BIGINT(20) NULL DEFAULT NULL  AFTER `status` , 
  ADD CONSTRAINT `fk_timesheet_report_2`
  FOREIGN KEY (`org_unit_id` )
  REFERENCES `org_unit` (`id` )
  ON DELETE NO ACTION
  ON UPDATE NO ACTION
, ADD INDEX `fk_timesheet_report_2_idx` (`org_unit_id` ASC) ;

ALTER TABLE `portfolio_entry_resource_plan_allocated_actor` ADD COLUMN `daily_rate` DECIMAL(12,2) NOT NULL DEFAULT 0  AFTER `follow_package_dates` , ADD COLUMN `forecast_days` DECIMAL(12,2) NOT NULL DEFAULT 0  AFTER `daily_rate` ;

ALTER TABLE `portfolio_entry_resource_plan_allocated_org_unit` ADD COLUMN `daily_rate` DECIMAL(12,2) NOT NULL DEFAULT 0  AFTER `follow_package_dates` , ADD COLUMN `forecast_days` DECIMAL(12,2) NOT NULL DEFAULT 0  AFTER `daily_rate` ;

ALTER TABLE `portfolio_entry_resource_plan_allocated_competency` ADD COLUMN `daily_rate` DECIMAL(12,2) NOT NULL DEFAULT 0  AFTER `follow_package_dates` , ADD COLUMN `forecast_days` DECIMAL(12,2) NOT NULL DEFAULT 0  AFTER `daily_rate` ;

ALTER TABLE `portfolio_entry` ADD COLUMN `default_is_opex` TINYINT(1) NOT NULL DEFAULT 0  AFTER `is_syndicated` ;

ALTER TABLE `portfolio_entry_planning_package` ADD COLUMN `is_opex` TINYINT(1) NOT NULL DEFAULT 0  AFTER `portfolio_entry_planning_package_type_id` ;

ALTER TABLE `portfolio_entry_planning_package_pattern` ADD COLUMN `is_opex` TINYINT(1) NOT NULL DEFAULT 0  AFTER `portfolio_entry_planning_package_type_id` ;


--//@UNDO

ALTER TABLE `portfolio_entry_planning_package_pattern` DROP COLUMN `is_opex` ;

ALTER TABLE `portfolio_entry_planning_package` DROP COLUMN `is_opex` ;

ALTER TABLE `portfolio_entry` DROP COLUMN `default_is_opex` ;

ALTER TABLE `portfolio_entry_resource_plan_allocated_competency` DROP COLUMN `forecast_days` , DROP COLUMN `daily_rate` ;

ALTER TABLE `portfolio_entry_resource_plan_allocated_org_unit` DROP COLUMN `forecast_days` , DROP COLUMN `daily_rate` ;

ALTER TABLE `portfolio_entry_resource_plan_allocated_actor` DROP COLUMN `forecast_days` , DROP COLUMN `daily_rate` ;

ALTER TABLE `timesheet_report` DROP FOREIGN KEY `fk_timesheet_report_2` ;
ALTER TABLE `timesheet_report` DROP COLUMN `org_unit_id` 
, DROP INDEX `fk_timesheet_report_2_idx` ;

ALTER TABLE `work_order` DROP COLUMN `resource_object_id` , DROP COLUMN `resource_object_type` ;

ALTER TABLE `portfolio_entry_budget_line` DROP COLUMN `resource_object_id` , DROP COLUMN `resource_object_type` ;

DELETE FROM `custom_attribute_definition` WHERE `uuid`='BUDGET_TRACKING_EFFORT_BASED_PREFERENCE' LIMIT 1;

DELETE FROM `preference` WHERE `uuid`='BUDGET_TRACKING_EFFORT_BASED_PREFERENCE' LIMIT 1;


