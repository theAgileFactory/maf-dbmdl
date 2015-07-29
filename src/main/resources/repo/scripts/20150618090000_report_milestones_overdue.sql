--Report: milestones overdue

INSERT INTO `reporting_authorization` (`expression`, `type`, `deleted`, `last_update`) 
	VALUES ('reporting.milestones_overdue', '0', '0', NOW());

INSERT INTO `reporting` (`deleted`, `last_update`, `reporting_category_id`, `reporting_authorization_id`, `name`, `description`, `is_public`, `is_active`, `is_standard`, `template`) 
	VALUES ('0', NOW(), (SELECT `id` FROM `reporting_category` WHERE `name`='reporting_category.default.name'), 
		(SELECT `id` FROM `reporting_authorization` WHERE `expression`='reporting.milestones_overdue'), 
		'report.milestones_overdue.name', 'report.milestones_overdue.description', '0', '1', '1', 'milestones_overdue');

--//@UNDO

DELETE FROM `reporting` WHERE `name`='report.milestones_overdue.name' LIMIT 1;

DELETE FROM `principal_reporting_authorization` WHERE `reporting_authorization_id`=(SELECT `id` FROM `reporting_authorization` WHERE `expression`='reporting.milestones_overdue');

DELETE FROM `reporting_authorization` WHERE `expression`='reporting.milestones_overdue' LIMIT 1;






