--license

INSERT INTO `preference`
(
`last_update`,
`uuid`,
`system_preference`)
VALUES
(
NOW(),
'LICENSE_CAN_MANAGE_ARCHIVED_PORTFOLIO_ENTRY_PREFERENCE',
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
'default.value=true',
'BOOLEAN',
'LICENSE_CAN_MANAGE_ARCHIVED_PORTFOLIO_ENTRY_PREFERENCE',
'Define if it is possible to manage an archive pe.',
'',
NOW()
);

INSERT INTO `preference`
(
`last_update`,
`uuid`,
`system_preference`)
VALUES
(
NOW(),
'LICENSE_ECHANNEL_API_SECRET_KEY_PREFERENCE',
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
'',
'STRING',
'LICENSE_ECHANNEL_API_SECRET_KEY_PREFERENCE',
'API secret key for echannel calls.',
'',
NOW()
);

INSERT INTO `preference`
(
`last_update`,
`uuid`,
`system_preference`)
VALUES
(
NOW(),
'LICENSE_INSTANCE_DOMAIN_PREFERENCE',
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
'',
'STRING',
'LICENSE_INSTANCE_DOMAIN_PREFERENCE',
'Domain of the instance.',
'',
NOW()
);

INSERT INTO `system_permission` (`name`,`description`,`deleted`,`selectable`,`last_update`) VALUES ('ADMIN_CUSTOM_ATTRIBUTE_PERMISSION','permission.admin_custom_attribute_permission.description',0,1,NOW());

--//@UNDO

DELETE FROM `custom_attribute_definition` WHERE `uuid`='LICENSE_CAN_MANAGE_ARCHIVED_PORTFOLIO_ENTRY_PREFERENCE' LIMIT 1;

DELETE FROM `preference` WHERE `uuid`='LICENSE_CAN_MANAGE_ARCHIVED_PORTFOLIO_ENTRY_PREFERENCE' LIMIT 1;

DELETE FROM `custom_attribute_definition` WHERE `uuid`='LICENSE_ECHANNEL_API_SECRET_KEY_PREFERENCE' LIMIT 1;

DELETE FROM `preference` WHERE `uuid`='LICENSE_ECHANNEL_API_SECRET_KEY_PREFERENCE' LIMIT 1;

DELETE FROM `custom_attribute_definition` WHERE `uuid`='LICENSE_INSTANCE_DOMAIN_PREFERENCE' LIMIT 1;

DELETE FROM `preference` WHERE `uuid`='LICENSE_INSTANCE_DOMAIN_PREFERENCE' LIMIT 1;

DELETE FROM `system_level_role_type_has_system_permission` WHERE `system_permission_id` =
(select `system_permission`.`id` from `system_permission` where `system_permission`.`name`='ADMIN_CUSTOM_ATTRIBUTE_PERMISSION');

DELETE FROM `system_permission` WHERE `name`='ADMIN_CUSTOM_ATTRIBUTE_PERMISSION';

