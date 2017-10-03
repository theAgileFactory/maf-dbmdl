-- // v16-0-0_new_timesheet_reports
-- Migration SQL that makes the change goes here.

INSERT INTO `reporting_authorization` (`expression`, `type`, `deleted`, `last_update`) VALUES 
('reporting.timesheet_per_type', 0, 0, Now()),
('reporting.timesheet_per_actor', 0, 0, Now()),
('reporting.timesheet_per_project', 0, 0, Now());

INSERT INTO `reporting` (`deleted`, `last_update`, `reporting_category_id`, `reporting_authorization_id`, `name`, `description`, `is_public`, `is_active`, `is_standard`, `template`, `languages`, `formats`, `default_format`) VALUES
(0, Now(), (select id from reporting_category where name = 'reporting_category.default.name'), (select id from reporting_authorization where expression = 'reporting.timesheet_per_type'), 'reporting.timesheet_per_type.name', 'reporting.timesheet_per_type.description', 1, 0, 1, 'timesheet_per_type', 'fr-CH,en,de', 'EXCEL,PDF', 'EXCEL'),
(0, Now(), (select id from reporting_category where name = 'reporting_category.default.name'), (select id from reporting_authorization where expression = 'reporting.timesheet_per_actor'), 'reporting.timesheet_per_actor.name', 'reporting.timesheet_per_actor.description', 1, 0, 1, 'timesheet_per_actor', 'fr-CH,en,de', 'EXCEL,PDF', 'EXCEL'),
(0, Now(), (select id from reporting_category where name = 'reporting_category.default.name'), (select id from reporting_authorization where expression = 'reporting.timesheet_per_project'), 'reporting.timesheet_per_project.name', 'reporting.timesheet_per_project.description', 1, 0, 1, 'timesheet_per_project', 'fr-CH,en,de', 'EXCEL,PDF', 'EXCEL');

INSERT INTO `i18n_messages` (`key`, `language`, `value`) VALUES ('reporting.timesheet_per_type.name', 'de', 'Timesheet-Einträge nach Aktivitäten');
INSERT INTO `i18n_messages` (`key`, `language`, `value`) VALUES ('reporting.timesheet_per_type.name', 'en', 'Timesheet entries by activity type');
INSERT INTO `i18n_messages` (`key`, `language`, `value`) VALUES ('reporting.timesheet_per_type.name', 'fr-CH', 'Entrées de feuilles de temps par type d''activité');

INSERT INTO `i18n_messages` (`key`, `language`, `value`) VALUES ('reporting.timesheet_per_type.description', 'de', 'Sämtliche Timesheet-Einträge in diesem Zeitraum. Zusammengefasst nach Mitarbeiter und Aktivitättyp.');
INSERT INTO `i18n_messages` (`key`, `language`, `value`) VALUES ('reporting.timesheet_per_type.description', 'en', 'List of all timesheet entries for a given period. The entries are grouped by activity type and employee.');
INSERT INTO `i18n_messages` (`key`, `language`, `value`) VALUES ('reporting.timesheet_per_type.description', 'fr-CH', 'Liste de toutes les entrées de feuilles de temps pour une période donnée. Les entrées sont groupées par type d''activité et par employé.');

INSERT INTO `i18n_messages` (`key`, `language`, `value`) VALUES ('reporting.timesheet_per_actor.name', 'de', 'Timesheet-Einträge nach Mitarbeiter');
INSERT INTO `i18n_messages` (`key`, `language`, `value`) VALUES ('reporting.timesheet_per_actor.name', 'en', 'Timesheet entries by employee');
INSERT INTO `i18n_messages` (`key`, `language`, `value`) VALUES ('reporting.timesheet_per_actor.name', 'fr-CH', 'Entrées de feuilles de temps par employé');

INSERT INTO `i18n_messages` (`key`, `language`, `value`) VALUES ('reporting.timesheet_per_actor.description', 'de', 'Sämtliche Timesheet-Einträge in diesem Projekt. Zusammengefasst nach Mitarbeiter.');
INSERT INTO `i18n_messages` (`key`, `language`, `value`) VALUES ('reporting.timesheet_per_actor.description', 'en', 'List of all timesheet entries for a given initiative. The entries are grouped by employee.');
INSERT INTO `i18n_messages` (`key`, `language`, `value`) VALUES ('reporting.timesheet_per_actor.description', 'fr-CH', 'Liste de toutes les entrées de feuilles de temps pour une initiative donnée. Les entrées sont groupées par employé.');

INSERT INTO `i18n_messages` (`key`, `language`, `value`) VALUES ('reporting.timesheet_per_project.name', 'de', 'Timesheet-Einträge nach Initiative');
INSERT INTO `i18n_messages` (`key`, `language`, `value`) VALUES ('reporting.timesheet_per_project.name', 'en', 'Timesheet entries by initiative');
INSERT INTO `i18n_messages` (`key`, `language`, `value`) VALUES ('reporting.timesheet_per_project.name', 'fr-CH', 'Entrées de feuilles de temps par initiative');

INSERT INTO `i18n_messages` (`key`, `language`, `value`) VALUES ('reporting.timesheet_per_project.description', 'de', 'Sämtliche Timesheet-Einträge in diesem Zeitraum. Zusammengefasst nach Initiative und Mitarbeiter.');
INSERT INTO `i18n_messages` (`key`, `language`, `value`) VALUES ('reporting.timesheet_per_project.description', 'en', 'List of all timesheet entries for a given period. The entries are grouped by initiative and employee.');
INSERT INTO `i18n_messages` (`key`, `language`, `value`) VALUES ('reporting.timesheet_per_project.description', 'fr-CH', 'Liste de toutes les entrées de feuilles de temps pour une période donnée. Les entrées sont groupées par initiative et employé.');

INSERT INTO `custom_attribute_definition` (`object_type`, `configuration`, `order`, `attribute_type`, `uuid`, `name`, `description`, `deleted`, `last_update`, `is_displayed`, `conditional_rule`)
VALUES ('utils.form.ReportingParamsFormData:timesheet_per_type', 0x636F6E73747261696E742E72657175697265643D74727565, 1, 'DATE', 'TS_TYPE_START_DATE', 'report.timesheet.start_date.name', '', 0, Now(), 0, NULL);

INSERT INTO `custom_attribute_definition` (`object_type`, `configuration`, `order`, `attribute_type`, `uuid`, `name`, `description`, `deleted`, `last_update`, `is_displayed`, `conditional_rule`)
VALUES ('utils.form.ReportingParamsFormData:timesheet_per_type', 0x636F6E73747261696E742E72657175697265643D74727565, 1, 'DATE', 'TS_TYPE_END_DATE', 'report.timesheet.end_date.name', '', 0, Now(), 0, NULL);

INSERT INTO `custom_attribute_definition` (`object_type`, `configuration`, `order`, `attribute_type`, `uuid`, `name`, `description`, `deleted`, `last_update`, `is_displayed`, `conditional_rule`)
VALUES ('utils.form.ReportingParamsFormData:timesheet_per_actor', 0x636F6E73747261696E742E72657175697265643D74727565, 1, 'DATE', 'TS_ACTOR_START_DATE', 'report.timesheet.start_date.name', '', 0, Now(), 0, NULL);

INSERT INTO `custom_attribute_definition` (`object_type`, `configuration`, `order`, `attribute_type`, `uuid`, `name`, `description`, `deleted`, `last_update`, `is_displayed`, `conditional_rule`)
VALUES ('utils.form.ReportingParamsFormData:timesheet_per_actor', 0x636F6E73747261696E742E72657175697265643D74727565, 1, 'DATE', 'TS_ACTOR_END_DATE', 'report.timesheet.end_date.name', '', 0, Now(), 0, NULL);

INSERT INTO `custom_attribute_definition` (`object_type`, `configuration`, `order`, `attribute_type`, `uuid`, `name`, `description`, `deleted`, `last_update`, `is_displayed`, `conditional_rule`)
VALUES ('utils.form.ReportingParamsFormData:timesheet_per_actor', 0x636F6E73747261696E742E72657175697265643D747275650A696E7075742E6669656C642E747970653D4155544F434F4D504C4554450A73656C656374696F6E2E71756572793D53454C4543542069642041532076616C75652C206E616D652046524F4D20706F7274666F6C696F5F656E7472792057484552452064656C65746564203D20300A66696C7465722E77686572652E636C617573653D414E4420286E616D65206C696B65203A736561726368737472696E67204F5220676F7665726E616E63655F6964206C696B65203A736561726368737472696E67290A6E616D652E66726F6D2E76616C75652E77686572652E636C617573653D414E44206964203D203A76616C7565746F66696E64, 1, 'DYNAMIC_SINGLE_ITEM', 'TS_ACTOR_PROJECT_PORTFOLIO_ENTRY', 'report.status_report.initiative.name', '', 0, Now(), 0, NULL);

INSERT INTO `custom_attribute_definition` (`object_type`, `configuration`, `order`, `attribute_type`, `uuid`, `name`, `description`, `deleted`, `last_update`, `is_displayed`, `conditional_rule`)
VALUES ('utils.form.ReportingParamsFormData:timesheet_per_project', 0x636F6E73747261696E742E72657175697265643D74727565, 1, 'DATE', 'TS_PROJECT_START_DATE', 'report.timesheet.start_date.name', '', 0, Now(), 0, NULL);

INSERT INTO `custom_attribute_definition` (`object_type`, `configuration`, `order`, `attribute_type`, `uuid`, `name`, `description`, `deleted`, `last_update`, `is_displayed`, `conditional_rule`)
VALUES ('utils.form.ReportingParamsFormData:timesheet_per_project', 0x636F6E73747261696E742E72657175697265643D74727565, 1, 'DATE', 'TS_PROJECT_END_DATE', 'report.timesheet.end_date.name', '', 0, Now(), 0, NULL);

INSERT INTO `i18n_messages` (`key`, `language`, `value`) VALUES ('report.timesheet.start_date.name', 'de', 'Startdatum');
INSERT INTO `i18n_messages` (`key`, `language`, `value`) VALUES ('report.timesheet.start_date.name', 'en', 'Start date');
INSERT INTO `i18n_messages` (`key`, `language`, `value`) VALUES ('report.timesheet.start_date.name', 'fr-CH', 'Date de début');

INSERT INTO `i18n_messages` (`key`, `language`, `value`) VALUES ('report.timesheet.end_date.name', 'de', 'Enddatum');
INSERT INTO `i18n_messages` (`key`, `language`, `value`) VALUES ('report.timesheet.end_date.name', 'en', 'End date');
INSERT INTO `i18n_messages` (`key`, `language`, `value`) VALUES ('report.timesheet.end_date.name', 'fr-CH', 'Date de fin');

-- //@UNDO
-- SQL to undo the change goes here.


