--kpi

INSERT INTO `kpi_value_definition` (`last_update`, `name`, `render_type`, `render_pattern`, `computation_js_code`, `is_trend_displayed`) 
	VALUES (NOW(), 'kpi.release_burndown.main.name', 'VALUE', NULL, NULL, '1');
INSERT INTO `kpi_value_definition` (`last_update`, `name`, `render_type`, `render_pattern`, `computation_js_code`, `is_trend_displayed`) 
	VALUES (NOW(), 'kpi.release_burndown.additional1.name', 'VALUE', NULL, NULL, '1');
INSERT INTO `kpi_value_definition` (`last_update`, `name`, `render_type`, `render_pattern`, `computation_js_code`, `is_trend_displayed`) 
	VALUES (NOW(), 'kpi.release_burndown.additional2.name', 'VALUE', NULL, NULL, '0');

INSERT INTO `kpi_definition` (`last_update`, `uid`, `css_glyphicon`, `is_active`, `is_displayed`, `order`, `object_type`, `is_external`, `is_standard`, `clazz`, `scheduler_start_time`, `scheduler_frequency`, `scheduler_real_time`, `parameters`, `main_kpi_value_definition_id`, `additional1kpi_value_definition_id`, `additional2kpi_value_definition_id`) 
	VALUES (NOW(), 'KPI_RELEASE_BURNDOWN', 'glyphicons glyphicons-scale-classic', '1', '1', '0', 'models.delivery.Release', '0', '1', 'services.kpi.ReleaseBurndownKpi', '03h00', '1440', '0', NULL, (SELECT id FROM kpi_value_definition WHERE name='kpi.release_burndown.main.name' LIMIT 1), (SELECT id FROM kpi_value_definition WHERE name='kpi.release_burndown.additional1.name' LIMIT 1), (SELECT id FROM kpi_value_definition WHERE name='kpi.release_burndown.additional2.name' LIMIT 1));

INSERT INTO `kpi_color_rule` (`last_update`, `order`, `rule`, `css_color`, `render_label`, `kpi_definition_id`) 
	VALUES (NOW(), '0', 'true;', 'primary', NULL, (SELECT id FROM kpi_definition WHERE uid='KPI_RELEASE_BURNDOWN' LIMIT 1));


ALTER TABLE `requirement` ADD COLUMN `effort` INT(11) NULL DEFAULT NULL  AFTER `release_id` , ADD COLUMN `remaining_effort` INT(11) NULL DEFAULT NULL  AFTER `effort` ;

--//@UNDO

ALTER TABLE `requirement` DROP COLUMN `remaining_effort` , DROP COLUMN `effort` ;


DELETE FROM `kpi_data` WHERE `kpi_value_definition_id`=(SELECT id FROM kpi_value_definition WHERE name='kpi.release_burndown.main.name' LIMIT 1);
DELETE FROM `kpi_data` WHERE `kpi_value_definition_id`=(SELECT id FROM kpi_value_definition WHERE name='kpi.release_burndown.additional1.name' LIMIT 1);
DELETE FROM `kpi_data` WHERE `kpi_value_definition_id`=(SELECT id FROM kpi_value_definition WHERE name='kpi.release_burndown.additional2.name' LIMIT 1);

DELETE FROM `kpi_color_rule` WHERE `kpi_definition_id`=(SELECT id FROM kpi_definition WHERE uid='KPI_RELEASE_BURNDOWN' LIMIT 1);

DELETE FROM `kpi_definition` WHERE `uid`='KPI_RELEASE_BURNDOWN' LIMIT 1;

DELETE FROM `kpi_value_definition` WHERE `name`='kpi.release_burndown.main.name' LIMIT 1;
DELETE FROM `kpi_value_definition` WHERE `name`='kpi.release_burndown.additional1.name' LIMIT 1;
DELETE FROM `kpi_value_definition` WHERE `name`='kpi.release_burndown.additional2.name' LIMIT 1;

