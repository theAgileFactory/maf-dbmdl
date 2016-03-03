--kpis

INSERT INTO `kpi_value_definition` (`last_update`, `name`, `render_type`, `render_pattern`, `computation_js_code`, `is_trend_displayed`) 
	VALUES (NOW(), 'kpi.pe_allocation_progress.main.name', 'PATTERN', ':i %', NULL, '1');
INSERT INTO `kpi_value_definition` (`last_update`, `name`, `render_type`, `render_pattern`, `computation_js_code`, `is_trend_displayed`) 
	VALUES (NOW(), 'kpi.pe_allocation_progress.additional1.name', 'PATTERN', ':d md', NULL, '1');
INSERT INTO `kpi_value_definition` (`last_update`, `name`, `render_type`, `render_pattern`, `computation_js_code`, `is_trend_displayed`) 
	VALUES (NOW(), 'kpi.pe_allocation_progress.additional2.name', 'PATTERN', ':d md', NULL, '1');

INSERT INTO `kpi_definition` (`last_update`, `uid`, `css_glyphicon`, `is_active`, `is_displayed`, `order`, `object_type`, `is_external`, `is_standard`, `clazz`, `scheduler_start_time`, `scheduler_frequency`, `scheduler_real_time`, `parameters`, `main_kpi_value_definition_id`, `additional1kpi_value_definition_id`, `additional2kpi_value_definition_id`) 
	VALUES (NOW(), 'KPI_PORTFOLIO_ENTRY_ALLOCATION_PROGRESS', 'fa fa-tasks', '1', '1', '11', 'models.pmo.PortfolioEntry', '0', '1', 'services.kpi.PortfolioEntryAllocationProgressKpi', '03h00', '1440', '0', NULL, (SELECT id FROM kpi_value_definition WHERE name='kpi.pe_allocation_progress.main.name' LIMIT 1), (SELECT id FROM kpi_value_definition WHERE name='kpi.pe_allocation_progress.additional1.name' LIMIT 1), (SELECT id FROM kpi_value_definition WHERE name='kpi.pe_allocation_progress.additional2.name' LIMIT 1));

INSERT INTO `kpi_color_rule` (`last_update`, `order`, `rule`, `css_color`, `render_label`, `kpi_definition_id`) 
	VALUES (NOW(), '0', 'true;', 'primary', NULL, (SELECT id FROM kpi_definition WHERE uid='KPI_PORTFOLIO_ENTRY_ALLOCATION_PROGRESS' LIMIT 1));


--//@UNDO


