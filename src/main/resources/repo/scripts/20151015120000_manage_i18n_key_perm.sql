
INSERT INTO `system_permission` (`name`,`description`,`deleted`,`selectable`,`last_update`) VALUES ('ADMIN_TRANSLATION_KEY_EDIT_PERMISSION','permission.admin_translation_key_edit_permission.description',0,1,NOW());

--//@UNDO

DELETE FROM `system_permission` WHERE `name`='ADMIN_TRANSLATION_KEY_EDIT_PERMISSION';



