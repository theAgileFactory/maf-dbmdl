--report and preference for status report

INSERT INTO `preference`
(
`last_update`,
`uuid`,
`system_preference`)
VALUES
(
NOW(),
'CUSTOM_REPORT_TEMPLATE_FOR_STATUS_REPORT_PREFERENCE',
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
'default.value=',
'STRING',
'CUSTOM_REPORT_TEMPLATE_FOR_STATUS_REPORT_PREFERENCE',
'',
'',
NOW()
);

INSERT INTO `reporting_authorization` (`expression`, `type`, `deleted`, `last_update`) 
	VALUES ('reporting.status_report', '0', '0', NOW());

INSERT INTO `reporting` (`deleted`, `last_update`, `reporting_category_id`, `reporting_authorization_id`, `name`, `description`, `is_public`, `is_active`, `is_standard`, `template`) 
	VALUES ('0', NOW(), (SELECT `id` FROM `reporting_category` WHERE `name`='reporting_category.default.name'), 
		(SELECT `id` FROM `reporting_authorization` WHERE `expression`='reporting.status_report'), 
		'report.status_report.name', 'report.status_report.description', '0', '1', '1', 'status_report');

INSERT INTO `custom_attribute_definition` 
  (`object_type`, `configuration`, `order`, `attribute_type`, `uuid`, `name`, `description`, `deleted`, `last_update`, `is_displayed`) 
  VALUES ('utils.form.ReportingParamsFormData:status_report','constraint.required=true\ninput.field.type=AUTOCOMPLETE\nselection.query=SELECT id AS value, name FROM portfolio_entry WHERE deleted = 0\nfilter.where.clause=AND (name like :searchstring OR governance_id like :searchstring)\nname.from.value.where.clause=AND id = :valuetofind',1,'DYNAMIC_SINGLE_ITEM','REPORT_STATUS_REPORT_PORTFOLIO_ENTRY','report.status_report.initiative.name','',0,NOW(),0);
  
--//@UNDO

DELETE FROM `custom_attribute_definition` WHERE `uuid`='CUSTOM_REPORT_TEMPLATE_FOR_STATUS_REPORT_PREFERENCE' LIMIT 1;

DELETE FROM `preference` WHERE `uuid`='CUSTOM_REPORT_TEMPLATE_FOR_STATUS_REPORT_PREFERENCE' LIMIT 1;

DELETE FROM `custom_attribute_definition` WHERE `uuid`='REPORT_STATUS_REPORT_PORTFOLIO_ENTRY' LIMIT 1;

DELETE FROM `reporting` WHERE `name`='report.status_report.name' LIMIT 1;

DELETE FROM `principal_reporting_authorization` WHERE `reporting_authorization_id`=(SELECT `id` FROM `reporting_authorization` WHERE `expression`='reporting.status_report');

DELETE FROM `reporting_authorization` WHERE `expression`='reporting.status_report' LIMIT 1;
