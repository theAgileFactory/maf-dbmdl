--timesheet period report

INSERT INTO `reporting_authorization` (`expression`, `type`, `deleted`, `last_update`) 
	VALUES ('reporting.timesheet_period', '0', '0', NOW());

INSERT INTO `reporting` (`deleted`, `last_update`, `reporting_category_id`, `reporting_authorization_id`, `name`, `description`, `is_public`, `is_active`, `is_standard`, `template`, `languages`, `formats`) 
	VALUES ('0', NOW(), (SELECT `id` FROM `reporting_category` WHERE `name`='reporting_category.default.name'), 
		(SELECT `id` FROM `reporting_authorization` WHERE `expression`='reporting.timesheet_period'), 
		'report.timesheet_period.name', 'report.timesheet_period.description', '0', '1', '1', 'timesheet_period', 'en,fr,de', 'PDF,EXCEL,CSV');

INSERT INTO `custom_attribute_definition` 
  (`object_type`, `configuration`, `order`, `attribute_type`, `uuid`, `name`, `description`, `deleted`, `last_update`, `is_displayed`) 
  VALUES ('utils.form.ReportingParamsFormData:timesheet_period','constraint.required=true',1,'DATE','REPORT_TIMESHEET_PERIOD_START_DATE','report.timesheet_period.start_date.name','',0,NOW(),0);
  
INSERT INTO `custom_attribute_definition` 
  (`object_type`, `configuration`, `order`, `attribute_type`, `uuid`, `name`, `description`, `deleted`, `last_update`, `is_displayed`) 
  VALUES ('utils.form.ReportingParamsFormData:timesheet_period','constraint.required=true',2,'DATE','REPORT_TIMESHEET_PERIOD_END_DATE','report.timesheet_period.end_date.name','',0,NOW(),0);

--//@UNDO

DELETE FROM `custom_attribute_definition` WHERE `uuid`='REPORT_TIMESHEET_PERIOD_START_DATE' LIMIT 1;
DELETE FROM `custom_attribute_definition` WHERE `uuid`='REPORT_TIMESHEET_PERIOD_END_DATE' LIMIT 1;

DELETE FROM `reporting` WHERE `name`='report.timesheet_period.name' LIMIT 1;

DELETE FROM `principal_reporting_authorization` WHERE `reporting_authorization_id`=(SELECT `id` FROM `reporting_authorization` WHERE `expression`='reporting.timesheet_period');

DELETE FROM `reporting_authorization` WHERE `expression`='reporting.timesheet_period' LIMIT 1;
