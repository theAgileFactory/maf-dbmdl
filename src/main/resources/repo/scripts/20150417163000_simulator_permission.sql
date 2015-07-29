--API permission

INSERT INTO `system_permission` (`name`,`description`,`deleted`,`selectable`,`last_update`) VALUES ('ROADMAP_SIMULATOR_PERMISSION','permission.roadmap_simulator_permission.description',0,1,NOW());

--//@UNDO

DELETE FROM `system_level_role_type_has_system_permission` WHERE `system_permission_id` =
(select `system_permission`.`id` from `system_permission` where `system_permission`.`name`='ROADMAP_SIMULATOR_PERMISSION');

DELETE FROM `system_permission` WHERE `name`='ROADMAP_SIMULATOR_PERMISSION';
