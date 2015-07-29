--new permissions for architecture

INSERT INTO `system_permission` (`name`,`description`,`deleted`,`selectable`,`last_update`) 
VALUES ('ARCHITECTURE_PERMISSION','permission.architecture_permission.description',0,1,NOW());

INSERT INTO `system_permission` (`name`,`description`,`deleted`,`selectable`,`last_update`) 
VALUES ('APPLICATION_BLOCK_EDIT_ALL_PERMISSION','permission.application_block_edit_all_permission.description',0,1,NOW());
	
--//@UNDO

DELETE FROM `system_level_role_type_has_system_permission` WHERE `system_permission_id` =
(select `system_permission`.`id` from `system_permission` where `system_permission`.`name`='ARCHITECTURE_PERMISSION');
DELETE FROM `system_permission` WHERE `name`='ARCHITECTURE_PERMISSION' LIMIT 1;

DELETE FROM `system_level_role_type_has_system_permission` WHERE `system_permission_id` =
(select `system_permission`.`id` from `system_permission` where `system_permission`.`name`='APPLICATION_BLOCK_EDIT_ALL_PERMISSION');
DELETE FROM `system_permission` WHERE `name`='APPLICATION_BLOCK_EDIT_ALL_PERMISSION' LIMIT 1;




