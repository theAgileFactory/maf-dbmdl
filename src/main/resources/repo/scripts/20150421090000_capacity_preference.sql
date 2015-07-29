--preference for capacity simulator

INSERT INTO `preference`
(
`last_update`,
`uuid`,
`system_preference`)
VALUES
(
NOW(),
'ROADMAP_CAPACITY_SIMULATOR_WARNING_LIMIT_PREFERENCE',
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
'default.value=10',
'INTEGER',
'ROADMAP_CAPACITY_SIMULATOR_WARNING_LIMIT_PREFERENCE',
'preference.roadmap_capacity_simulator_warning_limit.name',
'preference.roadmap_capacity_simulator_warning_limit.description',
NOW()
);
--//@UNDO

DELETE FROM `custom_attribute_definition` WHERE `uuid`='ROADMAP_CAPACITY_SIMULATOR_WARNING_LIMIT_PREFERENCE' LIMIT 1;

DELETE FROM `preference` WHERE `uuid`='ROADMAP_CAPACITY_SIMULATOR_WARNING_LIMIT_PREFERENCE' LIMIT 1;
