--API permission

INSERT INTO `system_permission` (`name`,`description`,`deleted`,`selectable`,`last_update`) VALUES ('API_TESTER_PERMISSION','permission.api_tester_permission.description',0,1,NOW());
ALTER TABLE `api_registration` ADD COLUMN `testable` TINYINT(1) NULL DEFAULT '0'  AFTER `description` ;

--//@UNDO

DELETE FROM `system_permission` WHERE `name`='API_TESTER_PERMISSION';
ALTER TABLE `api_registration` DROP COLUMN `testable` ;
