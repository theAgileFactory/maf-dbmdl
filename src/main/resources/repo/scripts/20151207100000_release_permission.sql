--Create release permission

INSERT INTO `system_permission` (`name`,`description`,`deleted`,`selectable`,`last_update`) VALUES ('RELEASE_SUBMISSION_PERMISSION','permission.release_submission_permission.description',0,1,NOW());

--//@UNDO

DELETE FROM `system_level_role_type_has_system_permission` WHERE `system_permission_id` =
(select `system_permission`.`id` from `system_permission` where `system_permission`.`name`='RELEASE_SUBMISSION_PERMISSION');

DELETE FROM `system_permission` WHERE `name`='RELEASE_SUBMISSION_PERMISSION';
