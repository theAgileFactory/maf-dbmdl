--preference for package

INSERT INTO `preference`
(
`last_update`,
`uuid`,
`system_preference`)
VALUES
(
NOW(),
'PACKAGE_STATUS_ON_GOING_FULFILLMENT_PERCENTAGE_PREFERENCE',
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
'default.value=50',
'INTEGER',
'PACKAGE_STATUS_ON_GOING_FULFILLMENT_PERCENTAGE_PREFERENCE',
'preference.package_status_on_going_fulfillment_percentage.name',
'preference.package_status_on_going_fulfillment_percentage.description',
NOW()
);
--//@UNDO

DELETE FROM `custom_attribute_definition` WHERE `uuid`='PACKAGE_STATUS_ON_GOING_FULFILLMENT_PERCENTAGE_PREFERENCE' LIMIT 1;

DELETE FROM `preference` WHERE `uuid`='PACKAGE_STATUS_ON_GOING_FULFILLMENT_PERCENTAGE_PREFERENCE' LIMIT 1;
