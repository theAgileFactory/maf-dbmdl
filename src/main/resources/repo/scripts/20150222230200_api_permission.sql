--API permission

INSERT INTO `system_permission` (`name`,`description`,`deleted`,`selectable`,`last_update`) VALUES ('API_MANAGER_PERMISSION','permission.api_manager_permission.description',0,1,NOW());

--//@UNDO

DELETE FROM `system_permission` WHERE `name`='API_MANAGER_PERMISSION';