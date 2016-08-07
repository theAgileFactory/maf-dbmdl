--Budget tracking

INSERT INTO `preference`
(
`last_update`,
`uuid`,
`system_preference`)
VALUES
(
NOW(),
'READONLY_GOVERNANCE_ID_PREFERENCE',
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
'default.value=false',
'BOOLEAN',
'READONLY_GOVERNANCE_ID_PREFERENCE',
'preference.read_only_governance_id_preference.name',
'preference.read_only_governance_id_preference.description',
NOW()
);

--//@UNDO

DELETE FROM `preference` WHERE `uuid`='READONLY_GOVERNANCE_ID_PREFERENCE' LIMIT 1;


