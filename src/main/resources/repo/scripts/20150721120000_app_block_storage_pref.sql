--storage preference for the application block filter

INSERT INTO `preference`
(
`last_update`,
`uuid`,
`system_preference`)
VALUES
(
NOW(),
'APPLICATION_BLOCK_FILTER_STORAGE_PREFERENCE',
'0'
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
'models.framework_models.account.Principal',
'',
'TEXT',
'APPLICATION_BLOCK_FILTER_STORAGE_PREFERENCE',
'Stores the JSON configuration for the application block table',
'',
NOW()
);

--//@UNDO

DELETE FROM `custom_attribute_definition` WHERE `uuid`='APPLICATION_BLOCK_FILTER_STORAGE_PREFERENCE' LIMIT 1;

DELETE FROM `preference` WHERE `uuid`='APPLICATION_BLOCK_FILTER_STORAGE_PREFERENCE' LIMIT 1;





