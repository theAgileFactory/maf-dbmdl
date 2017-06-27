-- // v15-0-0 Add capacity planning report
-- Migration SQL that makes the change goes here.

INSERT INTO `reporting_authorization` (`expression`, `type`, `deleted`, `last_update`)
VALUES ('reporting.capacity_report', 0, 0, Now());

INSERT INTO `reporting` (`deleted`, `last_update`, `reporting_category_id`, `reporting_authorization_id`, `name`, `description`, `is_public`, `is_active`, `is_standard`, `template`, `languages`, `formats`)
VALUES (0, Now(), 3, (select id from reporting_authorization where expression = 'reporting.capacity_report'), 'reporting.capacity_report.name', 'reporting.capacity_report.description', 1, 1, 0, 'capacity_report', 'en,fr,de', 'PDF,EXCEL');

INSERT INTO `i18n_messages` (`key`, `language`, `value`) VALUES ('reporting.capacity_report.name', 'de', 'Capacity report');
INSERT INTO `i18n_messages` (`key`, `language`, `value`) VALUES ('reporting.capacity_report.name', 'en', 'Capacity report');
INSERT INTO `i18n_messages` (`key`, `language`, `value`) VALUES ('reporting.capacity_report.name', 'fr', 'Rapport de capacité');

INSERT INTO `i18n_messages` (`key`, `language`, `value`) VALUES ('reporting.capacity_report.description', 'de', 'Capacity report');
INSERT INTO `i18n_messages` (`key`, `language`, `value`) VALUES ('reporting.capacity_report.description', 'en', 'Capacity report');
INSERT INTO `i18n_messages` (`key`, `language`, `value`) VALUES ('reporting.capacity_report.description', 'fr', 'Rapport de capacité');

INSERT INTO `custom_attribute_definition` (`object_type`, `configuration`, `order`, `attribute_type`, `uuid`, `name`, `description`, `deleted`, `last_update`, `is_displayed`, `conditional_rule`)
VALUES ('utils.form.ReportingParamsFormData:capacity_report', 0x636F6E73747261696E742E72657175697265643D74727565, 1, 'DATE', 'date_report_parameter', 'report.capacity_report.date.name', '', 0, Now(), 0, NULL);

INSERT INTO `i18n_messages` (`key`, `language`, `value`) VALUES ('report.capacity_report.date.name', 'de', 'Datum');
INSERT INTO `i18n_messages` (`key`, `language`, `value`) VALUES ('report.capacity_report.date.name', 'en', 'Date');
INSERT INTO `i18n_messages` (`key`, `language`, `value`) VALUES ('report.capacity_report.date.name', 'fr', 'Date');

-- //@UNDO
-- SQL to undo the change goes here.

DELETE FROM reporting_authorization
WHERE expression = 'reporting.capacity_report';

DELETE FROM reporting
WHERE template = 'capacity_report';

DELETE FROM i18n_messages
WHERE `key` IN ('reporting.capacity_report.name', 'reporting.capacity_report.description', 'report.capacity_report.date.name');

DELETE FROM custom_attribute_definition
WHERE object_type = 'utils.form.ReportingParamsFormData:capacity_report';
