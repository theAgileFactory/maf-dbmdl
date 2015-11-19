
ALTER TABLE `portfolio_entry_type` ADD COLUMN `is_release` TINYINT(1) NOT NULL DEFAULT 0  AFTER `last_update` ;

ALTER TABLE `life_cycle_process` ADD COLUMN `is_release` TINYINT(1) NOT NULL DEFAULT 0  AFTER `last_update` ;

ALTER TABLE `life_cycle_milestone` ADD COLUMN `type` VARCHAR(64) NULL DEFAULT NULL  AFTER `is_active` ;

ALTER TABLE `iteration` DROP FOREIGN KEY `fk_iteration_2` ;
ALTER TABLE `iteration` DROP COLUMN `release_id` 
, DROP INDEX `fk_iteration_2_idx` ;

drop table `release_portfolio_entry`;

ALTER TABLE `requirement` DROP FOREIGN KEY `fk_requirement_7` ;
ALTER TABLE `requirement` DROP COLUMN `release_id` 
, DROP INDEX `fk_requirement_7_idx` ;

drop table `release`;

ALTER TABLE `requirement` DROP FOREIGN KEY `fk_requirement_2` ;
ALTER TABLE `requirement` CHANGE COLUMN `portfolio_entry_id` `portfolio_entry_id` BIGINT(20) NULL DEFAULT NULL  , 
  ADD CONSTRAINT `fk_requirement_2`
  FOREIGN KEY (`portfolio_entry_id` )
  REFERENCES `portfolio_entry` (`id` )
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

CREATE TABLE `deliverable` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `deleted` tinyint(1) DEFAULT '0',
  `last_update` datetime NOT NULL,
  `name` varchar(64) NOT NULL,
  `description` varchar(1500) DEFAULT NULL,
  PRIMARY KEY (`id`)
);

CREATE TABLE `deliverable_has_requirement` (
  `deliverable_id` bigint(20) NOT NULL,
  `requirement_id` bigint(20) NOT NULL,
  PRIMARY KEY (`deliverable_id`,`requirement_id`),
  KEY `fk_deliverable_has_requirement_1_idx` (`deliverable_id`),
  KEY `fk_deliverable_has_requirement_2_idx` (`requirement_id`),
  CONSTRAINT `fk_deliverable_has_requirement_2` FOREIGN KEY (`requirement_id`) REFERENCES `requirement` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_deliverable_has_requirement_1` FOREIGN KEY (`deliverable_id`) REFERENCES `deliverable` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
);

CREATE TABLE `portfolio_entry_deliverable` (
  `portfolio_entry_id` bigint(20) NOT NULL,
  `deliverable_id` bigint(20) NOT NULL,
  `type` varchar(64) NOT NULL,
  `portfolio_entry_planning_package_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`portfolio_entry_id`,`deliverable_id`),
  KEY `fk_portfolio_entry_deliverable_1_idx` (`portfolio_entry_id`),
  KEY `fk_portfolio_entry_deliverable_2_idx` (`deliverable_id`),
  KEY `fk_portfolio_entry_deliverable_3_idx` (`portfolio_entry_planning_package_id`),
  CONSTRAINT `fk_portfolio_entry_deliverable_3` FOREIGN KEY (`portfolio_entry_planning_package_id`) REFERENCES `portfolio_entry_planning_package` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_portfolio_entry_deliverable_1` FOREIGN KEY (`portfolio_entry_id`) REFERENCES `portfolio_entry` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_portfolio_entry_deliverable_2` FOREIGN KEY (`deliverable_id`) REFERENCES `deliverable` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
);

DELETE FROM system_level_role_type_has_system_permission WHERE system_permission_id=
	(SELECT id FROM system_permission WHERE name='RELEASE_VIEW_ALL_PERMISSION');

DELETE FROM system_level_role_type_has_system_permission WHERE system_permission_id=
	(SELECT id FROM system_permission WHERE name='RELEASE_VIEW_AS_MANAGER_PERMISSION');

DELETE FROM system_level_role_type_has_system_permission WHERE system_permission_id=
	(SELECT id FROM system_permission WHERE name='RELEASE_EDIT_ALL_PERMISSION');

DELETE FROM system_level_role_type_has_system_permission WHERE system_permission_id=
	(SELECT id FROM system_permission WHERE name='RELEASE_EDIT_AS_MANAGER_PERMISSION');

DELETE FROM system_permission WHERE name='RELEASE_VIEW_ALL_PERMISSION' LIMIT 1;

DELETE FROM system_permission WHERE name='RELEASE_VIEW_AS_MANAGER_PERMISSION' LIMIT 1;

DELETE FROM system_permission WHERE name='RELEASE_EDIT_ALL_PERMISSION' LIMIT 1;

DELETE FROM system_permission WHERE name='RELEASE_EDIT_AS_MANAGER_PERMISSION' LIMIT 1;

DELETE FROM custom_attribute_definition WHERE uuid='REPORT_RELEASE_REQUIREMENTS_RELEASE' LIMIT 1;

DELETE FROM principal_reporting_authorization WHERE reporting_authorization_id=
	(SELECT id FROM reporting_authorization WHERE expression='reporting.release_requirements');

DELETE FROM reporting WHERE name='report.release_requirements.name' LIMIT 1;

DELETE FROM reporting_authorization WHERE expression='reporting.release_requirements' LIMIT 1;

--//@UNDO

INSERT INTO `reporting_authorization` (`expression`, `type`, `deleted`, `last_update`) 
	VALUES ('reporting.release_requirements', '0', '0', NOW());

INSERT INTO `reporting` (`deleted`, `last_update`, `reporting_category_id`, `reporting_authorization_id`, `name`, `description`, `is_public`, `is_active`, `is_standard`, `template`) 
	VALUES ('0', NOW(), (SELECT `id` FROM `reporting_category` WHERE `name`='reporting_category.default.name'), 
		(SELECT `id` FROM `reporting_authorization` WHERE `expression`='report.release_requirements'), 
		'report.release_requirements.name', 'report.release_requirements.description', '0', '1', '1', 'release_requirements');

INSERT INTO `custom_attribute_definition` (`object_type`,`configuration`,`order`,`attribute_type`,`uuid`,`name`,`description`,`deleted`,`last_update`,`is_displayed`) VALUES ('utils.form.ReportingParamsFormData:release_requirements','constraint.required=true\ninput.field.type=AUTOCOMPLETE\nselection.query=SELECT id AS value, name FROM `release` WHERE deleted=0\nfilter.where.clause=AND (name like :searchstring)\nname.from.value.where.clause=AND id = :valuetofind',1,'DYNAMIC_SINGLE_ITEM','REPORT_RELEASE_REQUIREMENTS_RELEASE','report.release_requirements.release.name','',0,NOW(),0);

INSERT INTO `system_permission` (`name`, `description`, `deleted`, `selectable`, `last_update`) VALUES
 ('RELEASE_VIEW_ALL_PERMISSION', 'permission.release_view_all_permission.description', '0', '1', NOW());

INSERT INTO `system_permission` (`name`, `description`, `deleted`, `selectable`, `last_update`) VALUES
 ('RELEASE_VIEW_AS_MANAGER_PERMISSION', 'permission.release_view_as_manager_permission.description', '0', '1', NOW());

INSERT INTO `system_permission` (`name`, `description`, `deleted`, `selectable`, `last_update`) VALUES
 ('RELEASE_EDIT_ALL_PERMISSION', 'permission.release_edit_all_permission.description', '0', '1', NOW());

INSERT INTO `system_permission` (`name`, `description`, `deleted`, `selectable`, `last_update`) VALUES
 ('RELEASE_EDIT_AS_MANAGER_PERMISSION', 'permission.release_edit_as_manager_permission.description', '0', '1', NOW());

drop table `portfolio_entry_deliverable`;

drop table `deliverable_has_requirement`;

drop table `deliverable`;

ALTER TABLE `requirement` DROP FOREIGN KEY `fk_requirement_2` ;
ALTER TABLE `requirement` CHANGE COLUMN `portfolio_entry_id` `portfolio_entry_id` BIGINT(20) NOT NULL  , 
  ADD CONSTRAINT `fk_requirement_2`
  FOREIGN KEY (`portfolio_entry_id` )
  REFERENCES `portfolio_entry` (`id` )
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

CREATE TABLE `release` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `deleted` tinyint(1) DEFAULT '0',
  `last_update` datetime NOT NULL,
  `name` varchar(256) NOT NULL,
  `description` longtext,
  `capacity` int(11) DEFAULT NULL,
  `cut_off_date` datetime DEFAULT NULL,
  `end_tests_date` datetime DEFAULT NULL,
  `deployment_date` datetime DEFAULT NULL,
  `manager_id` bigint(20) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `fk_release_1_idx` (`manager_id`),
  CONSTRAINT `fk_release_1` FOREIGN KEY (`manager_id`) REFERENCES `actor` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
);

ALTER TABLE `requirement` ADD COLUMN `release_id` BIGINT(20) NULL  AFTER `remaining_effort` , 
  ADD CONSTRAINT `fk_requirement_7`
  FOREIGN KEY (`release_id` )
  REFERENCES `release` (`id` )
  ON DELETE NO ACTION
  ON UPDATE NO ACTION
, ADD INDEX `fk_requirement_7_idx` (`release_id` ASC) ;


CREATE TABLE `release_portfolio_entry` (
  `portfolio_entry_id` bigint(20) NOT NULL,
  `release_id` bigint(20) NOT NULL,
  `type` varchar(64) NOT NULL,
  PRIMARY KEY (`portfolio_entry_id`,`release_id`),
  KEY `fk_release_has_portfolio_entry_1_idx` (`portfolio_entry_id`),
  KEY `fk_release_has_portfolio_entry_2_idx` (`release_id`),
  CONSTRAINT `fk_release_has_portfolio_entry_1` FOREIGN KEY (`portfolio_entry_id`) REFERENCES `portfolio_entry` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_release_has_portfolio_entry_2` FOREIGN KEY (`release_id`) REFERENCES `release` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
);

ALTER TABLE `iteration` ADD COLUMN `release_id` BIGINT(20) NULL DEFAULT NULL  AFTER `source` , 
  ADD CONSTRAINT `fk_iteration_2`
  FOREIGN KEY (`release_id` )
  REFERENCES `release` (`id` )
  ON DELETE NO ACTION
  ON UPDATE NO ACTION
, ADD INDEX `fk_iteration_2_idx` (`release_id` ASC) ;

ALTER TABLE `life_cycle_milestone` DROP COLUMN `type` ;

ALTER TABLE `life_cycle_process` DROP COLUMN `is_release` ;

ALTER TABLE `portfolio_entry_type` DROP COLUMN `is_release` ;





