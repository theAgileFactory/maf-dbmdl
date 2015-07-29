--Report: competency

INSERT INTO `reporting_authorization` (`expression`, `type`, `deleted`, `last_update`) 
	VALUES ('reporting.competency', '0', '0', NOW());

INSERT INTO `reporting` (`deleted`, `last_update`, `reporting_category_id`, `reporting_authorization_id`, `name`, `description`, `is_public`, `is_active`, `is_standard`, `template`) 
	VALUES ('0', NOW(), (SELECT `id` FROM `reporting_category` WHERE `name`='reporting_category.default.name'), 
		(SELECT `id` FROM `reporting_authorization` WHERE `expression`='reporting.competency'), 
		'report.competency.name', 'report.competency.description', '0', '1', '1', 'competency');

INSERT INTO `custom_attribute_definition` 
  (`object_type`, `configuration`, `order`, `attribute_type`, `uuid`, `name`, `description`, `deleted`, `last_update`, `is_displayed`) 
  VALUES ('utils.form.ReportingParamsFormData:competency','constraint.required=true\ninput.field.type=AUTOCOMPLETE\nselection.query=SELECT c.id AS value, c_i18n.value AS name FROM competency c JOIN i18n_messages c_i18n ON c.name = c_i18n.key AND c_i18n.language = :lang WHERE c.deleted = 0\nfilter.where.clause=AND (c_i18n.value like :searchstring)\nname.from.value.where.clause=AND c.id = :valuetofind',1,'DYNAMIC_SINGLE_ITEM','REPORT_COMPETENCY_COMPETENCY','report.competency.competency.name','',0,NOW(),0);
  
--//@UNDO

DELETE FROM `custom_attribute_definition` WHERE `uuid`='REPORT_COMPETENCY_COMPETENCY' LIMIT 1;

DELETE FROM `reporting` WHERE `name`='report.competency.name' LIMIT 1;

DELETE FROM `principal_reporting_authorization` WHERE `reporting_authorization_id`=(SELECT `id` FROM `reporting_authorization` WHERE `expression`='reporting.competency');

DELETE FROM `reporting_authorization` WHERE `expression`='reporting.competency' LIMIT 1;






