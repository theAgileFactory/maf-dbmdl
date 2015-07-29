--kpi

INSERT INTO `kpi_value_definition` (`last_update`, `name`, `render_type`, `render_pattern`, `computation_js_code`) 
	VALUES (NOW(), 'kpi.portfolio_entry_progress.main.name', 'PATTERN', ':i %', NULL);
INSERT INTO `kpi_value_definition` (`last_update`, `name`, `render_type`, `render_pattern`, `computation_js_code`) 
	VALUES (NOW(), 'kpi.portfolio_entry_progress.additional1.name', 'VALUE', NULL, NULL);
INSERT INTO `kpi_value_definition` (`last_update`, `name`, `render_type`, `render_pattern`, `computation_js_code`) 
	VALUES (NOW(), 'kpi.portfolio_entry_progress.additional2.name', 'VALUE', NULL, NULL);

INSERT INTO `kpi_definition` (`last_update`, `uid`, `css_glyphicon`, `is_active`, `is_displayed`, `order`, `object_type`, `is_external`, `is_standard`, `clazz`, `scheduler_start_time`, `scheduler_frequency`, `scheduler_real_time`, `parameters`, `main_kpi_value_definition_id`, `additional1kpi_value_definition_id`, `additional2kpi_value_definition_id`) 
	VALUES (NOW(), 'KPI_PORTFOLIO_ENTRY_PROGRESS', 'glyphicons glyphicons-scale-classic', '1', '1', '9', 'models.pmo.PortfolioEntry', '0', '1', 'services.kpi.PortfolioEntryProgressKpi', '03h00', '1440', '0', NULL, (SELECT id FROM kpi_value_definition WHERE name='kpi.portfolio_entry_progress.main.name' LIMIT 1), (SELECT id FROM kpi_value_definition WHERE name='kpi.portfolio_entry_progress.additional1.name' LIMIT 1), (SELECT id FROM kpi_value_definition WHERE name='kpi.portfolio_entry_progress.additional2.name' LIMIT 1));

INSERT INTO `kpi_color_rule` (`last_update`, `order`, `rule`, `css_color`, `render_label`, `kpi_definition_id`) 
	VALUES (NOW(), '0', 'if(additional1 >= additional2) {\n   true;\n} else {\n   false;\n}', 'success', NULL, (SELECT id FROM kpi_definition WHERE uid='KPI_PORTFOLIO_ENTRY_PROGRESS' LIMIT 1));
INSERT INTO `kpi_color_rule` (`last_update`, `order`, `rule`, `css_color`, `render_label`, `kpi_definition_id`) 
	VALUES (NOW(), '1', 'if((additional1 * 1.15) >= additional2) {\n   true;\n} else {\n   false;\n};', 'warning', NULL, (SELECT id FROM kpi_definition WHERE uid='KPI_PORTFOLIO_ENTRY_PROGRESS' LIMIT 1));
INSERT INTO `kpi_color_rule` (`last_update`, `order`, `rule`, `css_color`, `render_label`, `kpi_definition_id`) 
	VALUES (NOW(), '2', 'true;', 'danger', NULL, (SELECT id FROM kpi_definition WHERE uid='KPI_PORTFOLIO_ENTRY_PROGRESS' LIMIT 1));

--//@UNDO

DELETE FROM `kpi_data` WHERE `kpi_value_definition_id`=(SELECT id FROM kpi_value_definition WHERE name='kpi.portfolio_entry_progress.main.name' LIMIT 1);
DELETE FROM `kpi_data` WHERE `kpi_value_definition_id`=(SELECT id FROM kpi_value_definition WHERE name='kpi.portfolio_entry_progress.additional1.name' LIMIT 1);
DELETE FROM `kpi_data` WHERE `kpi_value_definition_id`=(SELECT id FROM kpi_value_definition WHERE name='kpi.portfolio_entry_progress.additional2.name' LIMIT 1);

DELETE FROM `kpi_color_rule` WHERE `kpi_definition_id`=(SELECT id FROM kpi_definition WHERE uid='KPI_PORTFOLIO_ENTRY_PROGRESS' LIMIT 1);

DELETE FROM `kpi_definition` WHERE `uid`='KPI_PORTFOLIO_ENTRY_PROGRESS' LIMIT 1;

DELETE FROM `kpi_value_definition` WHERE `name`='kpi.portfolio_entry_progress.main.name' LIMIT 1;
DELETE FROM `kpi_value_definition` WHERE `name`='kpi.portfolio_entry_progress.additional1.name' LIMIT 1;
DELETE FROM `kpi_value_definition` WHERE `name`='kpi.portfolio_entry_progress.additional2.name' LIMIT 1;

