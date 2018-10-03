-- // Separate risk and issues
-- Migration SQL that makes the change goes here.

INSERT INTO `custom_attribute_definition` (`object_type`, `configuration`, `order`, `attribute_type`, `uuid`, `name`, `description`, `deleted`, `last_update`, `is_displayed`, `conditional_rule`)
VALUES ('utils.form.ReportingParamsFormData:timesheet_period', null, 3, 'BOOLEAN', 'GROUP_BY_MONTH', 'report.timesheet_period.date.name', '', 0, Now(), 0, NULL);

INSERT INTO `i18n_messages` (`key`, `language`, `value`) VALUES ('report.timesheet_period.group_by_month.name', 'de', 'Gruppieren nach Monat');
INSERT INTO `i18n_messages` (`key`, `language`, `value`) VALUES ('report.timesheet_period.group_by_month.name', 'en', 'Group by month');
INSERT INTO `i18n_messages` (`key`, `language`, `value`) VALUES ('report.timesheet_period.group_by_month.name', 'fr', 'Grouper par mois');

-- //@UNDO
-- SQL to undo the change goes here.

DELETE FROM `i18n_messages` where `key` = 'report.timesheet_period.group_by_month.name';
DELETE FROM `custom_attribute_definition` WHERE `uuid` = 'GROUP_BY_MONTH';


select * from custom_attribute_definition where object_type = 'utils.form.ReportingParamsFormData:timesheet_period';
