--report and preference for timesheet project

INSERT INTO `reporting_authorization` (`expression`, `type`, `deleted`, `last_update`) 
	VALUES ('reporting.timesheet_project', '0', '0', NOW());

INSERT INTO `reporting` (`deleted`, `last_update`, `reporting_category_id`, `reporting_authorization_id`, `name`, `description`, `is_public`, `is_active`, `is_standard`, `template`) 
	VALUES ('0', NOW(), (SELECT `id` FROM `reporting_category` WHERE `name`='reporting_category.default.name'), 
		(SELECT `id` FROM `reporting_authorization` WHERE `expression`='reporting.timesheet_project'), 
		'report.timesheet_project.name', 'report.timesheet_project.description', '0', '1', '1', 'timesheet_project');

INSERT INTO `custom_attribute_definition` 
  (`object_type`, `configuration`, `order`, `attribute_type`, `uuid`, `name`, `description`, `deleted`, `last_update`, `is_displayed`) 
  VALUES ('utils.form.ReportingParamsFormData:timesheet_project','constraint.required=true\ninput.field.type=AUTOCOMPLETE\nselection.query=SELECT id AS value, name FROM portfolio_entry WHERE deleted = 0\nfilter.where.clause=AND (name like :searchstring OR governance_id like :searchstring)\nname.from.value.where.clause=AND id = :valuetofind',1,'DYNAMIC_SINGLE_ITEM','REPORT_TIMESHEET_PROJECT_PORTFOLIO_ENTRY','report.timesheet_project.initiative.name','',0,NOW(),0);
  
--//@UNDO

DELETE FROM `custom_attribute_definition` WHERE `uuid`='REPORT_TIMESHEET_PROJECT_PORTFOLIO_ENTRY' LIMIT 1;

DELETE FROM `reporting` WHERE `name`='report.timesheet_project.name' LIMIT 1;

DELETE FROM `principal_reporting_authorization` WHERE `reporting_authorization_id`=(SELECT `id` FROM `reporting_authorization` WHERE `expression`='reporting.timesheet_project');

DELETE FROM `reporting_authorization` WHERE `expression`='reporting.timesheet_project' LIMIT 1;
