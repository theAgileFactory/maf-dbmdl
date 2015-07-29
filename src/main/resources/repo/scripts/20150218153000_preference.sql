--planning preference

INSERT INTO `preference`
(
`last_update`,
`uuid`,
`system_preference`)
VALUES
(
NOW(),
'PORTFOLIO_ENTRY_PLANNING_OVERVIEW_PREFERENCE',
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
'PORTFOLIO_ENTRY_PLANNING_OVERVIEW_PREFERENCE',
'Stores the JSON configuration of the planning overview',
'',
NOW()
);

--//@UNDO

DELETE FROM `custom_attribute_definition` WHERE `uuid`='PORTFOLIO_ENTRY_PLANNING_OVERVIEW_PREFERENCE' LIMIT 1;

DELETE FROM `preference` WHERE `uuid`='PORTFOLIO_ENTRY_PLANNING_OVERVIEW_PREFERENCE' LIMIT 1;





