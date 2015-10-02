
DELETE FROM `text_custom_attribute_value` WHERE `custom_attribute_definition_id`= (SELECT `id` FROM custom_attribute_definition WHERE `uuid`='ROADMAP_FILTER_STORAGE_PREFERENCE');
DELETE FROM `custom_attribute_definition` WHERE `uuid`='ROADMAP_FILTER_STORAGE_PREFERENCE' LIMIT 1;
DELETE FROM `preference` WHERE `uuid`='ROADMAP_FILTER_STORAGE_PREFERENCE' LIMIT 1;

DELETE FROM `text_custom_attribute_value` WHERE `custom_attribute_definition_id`= (SELECT `id` FROM custom_attribute_definition WHERE `uuid`='REQUIREMENTS_FILTER_STORAGE_PREFERENCE');
DELETE FROM `custom_attribute_definition` WHERE `uuid`='REQUIREMENTS_FILTER_STORAGE_PREFERENCE' LIMIT 1;
DELETE FROM `preference` WHERE `uuid`='REQUIREMENTS_FILTER_STORAGE_PREFERENCE' LIMIT 1;

DELETE FROM `text_custom_attribute_value` WHERE `custom_attribute_definition_id`= (SELECT `id` FROM custom_attribute_definition WHERE `uuid`='PACKAGES_FILTER_STORAGE_PREFERENCE');
DELETE FROM `custom_attribute_definition` WHERE `uuid`='PACKAGES_FILTER_STORAGE_PREFERENCE' LIMIT 1;
DELETE FROM `preference` WHERE `uuid`='PACKAGES_FILTER_STORAGE_PREFERENCE' LIMIT 1;

DELETE FROM `text_custom_attribute_value` WHERE `custom_attribute_definition_id`= (SELECT `id` FROM custom_attribute_definition WHERE `uuid`='EVENTS_FILTER_STORAGE_PREFERENCE');
DELETE FROM `custom_attribute_definition` WHERE `uuid`='EVENTS_FILTER_STORAGE_PREFERENCE' LIMIT 1;
DELETE FROM `preference` WHERE `uuid`='EVENTS_FILTER_STORAGE_PREFERENCE' LIMIT 1;

DELETE FROM `text_custom_attribute_value` WHERE `custom_attribute_definition_id`= (SELECT `id` FROM custom_attribute_definition WHERE `uuid`='ITERATIONS_FILTER_STORAGE_PREFERENCE');
DELETE FROM `custom_attribute_definition` WHERE `uuid`='ITERATIONS_FILTER_STORAGE_PREFERENCE' LIMIT 1;
DELETE FROM `preference` WHERE `uuid`='ITERATIONS_FILTER_STORAGE_PREFERENCE' LIMIT 1;

DELETE FROM `text_custom_attribute_value` WHERE `custom_attribute_definition_id`= (SELECT `id` FROM custom_attribute_definition WHERE `uuid`='RELEASES_FILTER_STORAGE_PREFERENCE');
DELETE FROM `custom_attribute_definition` WHERE `uuid`='RELEASES_FILTER_STORAGE_PREFERENCE' LIMIT 1;
DELETE FROM `preference` WHERE `uuid`='RELEASES_FILTER_STORAGE_PREFERENCE' LIMIT 1;

DELETE FROM `text_custom_attribute_value` WHERE `custom_attribute_definition_id`= (SELECT `id` FROM custom_attribute_definition WHERE `uuid`='APPLICATION_BLOCK_FILTER_STORAGE_PREFERENCE');
DELETE FROM `custom_attribute_definition` WHERE `uuid`='APPLICATION_BLOCK_FILTER_STORAGE_PREFERENCE' LIMIT 1;
DELETE FROM `preference` WHERE `uuid`='APPLICATION_BLOCK_FILTER_STORAGE_PREFERENCE' LIMIT 1;

DELETE FROM `text_custom_attribute_value` WHERE `custom_attribute_definition_id`= (SELECT `id` FROM custom_attribute_definition WHERE `uuid`='PORTFOLIO_ENTRY_TIMESHEETS_FILTER_STORAGE_PREFERENCE');
DELETE FROM `custom_attribute_definition` WHERE `uuid`='PORTFOLIO_ENTRY_TIMESHEETS_FILTER_STORAGE_PREFERENCE' LIMIT 1;
DELETE FROM `preference` WHERE `uuid`='PORTFOLIO_ENTRY_TIMESHEETS_FILTER_STORAGE_PREFERENCE' LIMIT 1;

--//@UNDO



