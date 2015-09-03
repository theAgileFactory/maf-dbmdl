--storage preference for the portfolio entry timesheets filter

INSERT INTO `preference`
(
`last_update`,
`uuid`,
`system_preference`)
VALUES
(
NOW(),
'PORTFOLIO_ENTRY_TIMESHEETS_FILTER_STORAGE_PREFERENCE',
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
'PORTFOLIO_ENTRY_TIMESHEETS_FILTER_STORAGE_PREFERENCE',
'Stores the JSON configuration for the PE timesheets table',
'',
NOW()
);

--//@UNDO

DELETE FROM `custom_attribute_definition` WHERE `uuid`='PORTFOLIO_ENTRY_TIMESHEETS_FILTER_STORAGE_PREFERENCE' LIMIT 1;

DELETE FROM `preference` WHERE `uuid`='PORTFOLIO_ENTRY_TIMESHEETS_FILTER_STORAGE_PREFERENCE' LIMIT 1;





