-- Fix Custom attribute name
UPDATE custom_attribute_definition
SET name = 'report.timesheet_period.group_by_month.name'
where uuid = 'GROUP_BY_MONTH';

-- Rename Actuals and Budget KPI
UPDATE kpi_definition
set uid = 'KPI_PORTFOLIO_ENTRY_ACTUALS_CAPEX_OPEX',
    clazz = 'services.kpi.PortfolioEntryActualsCapexOpexKpi'
where uid = 'KPI_PORTFOLIO_ENTRY_ACTUALS';

UPDATE kpi_definition
set uid = 'KPI_PORTFOLIO_ENTRY_BUDGET_CAPEX_OPEX',
    clazz = 'services.kpi.BudgetCapexOpexKpi'
where uid = 'KPI_PORTFOLIO_ENTRY_BUDGET';

update kpi_value_definition
set render_type = 'PATTERN',
    render_pattern = ':default_currency_code :d'
where name like 'kpi.pe_budget.%';

-- Create Actuals Internal External KPI
insert into kpi_value_definition (deleted, last_update, name, render_type, render_pattern, is_trend_displayed, is_displayed)
VALUES (0, now(), 'kpi.pe_actuals_internal.main.name', 'PATTERN', ':default_currency_code :d', 0, 1),
       (0, now(), 'kpi.pe_actuals_internal.additional1.name', 'PATTERN', ':default_currency_code :d', 0, 1),
       (0, now(), 'kpi.pe_actuals_internal.additional2.name', 'PATTERN', ':default_currency_code :d', 0, 1);

insert into kpi_definition (deleted, last_update, uid, css_glyphicon, is_active, is_displayed, `order`, object_type, is_external, is_standard, clazz, scheduler_start_time, scheduler_frequency, scheduler_real_time, main_kpi_value_definition_id, additional1kpi_value_definition_id, additional2kpi_value_definition_id)
SELECT 0, now(), 'KPI_PORTFOLIO_ENTRY_ACTUALS_INTERNAL_EXTERNAL', 'fa fa-money', 0, 1, max(`order`) + 1, 'models.pmo.PortfolioEntry', 0, 1, 'services.kpi.PortfolioEntryActualsInternalExternalKpi', '03h00', '1440', 0, kvd_main.id, kvd_additional1.id, kvd_additional2.id
from
     (select id from kpi_value_definition where name = 'kpi.pe_actuals_internal.main.name') kvd_main,
     (select id from kpi_value_definition where name = 'kpi.pe_actuals_internal.additional1.name') kvd_additional1,
     (select id from kpi_value_definition where name = 'kpi.pe_actuals_internal.additional2.name') kvd_additional2,
     kpi_definition kd
where kd.object_type = 'models.pmo.PortfolioEntry' and kd.is_external = 0;

insert into kpi_definition_has_system_permission
  select
    kd.id,
    sp.id
  from
    kpi_definition kd,
    system_permission sp
  where kd.uid = 'KPI_PORTFOLIO_ENTRY_ACTUALS_INTERNAL_EXTERNAL'
     and sp.name in (
    'PORTFOLIO_ENTRY_VIEW_FINANCIAL_INFO_ALL_PERMISSION',
    'PORTFOLIO_ENTRY_VIEW_FINANCIAL_INFO_AS_MANAGER_PERMISSION',
    'PORTFOLIO_ENTRY_VIEW_FINANCIAL_INFO_AS_PORTFOLIO_MANAGER_PERMISSION',
    'PORTFOLIO_ENTRY_VIEW_FINANCIAL_INFO_AS_STAKEHOLDER_PERMISSION'
  );

INSERT INTO `kpi_color_rule` (`last_update`, `order`, `rule`, `css_color`, `render_label`, `kpi_definition_id`)
	VALUES (NOW(), '0', 'true;', 'primary', NULL, (SELECT id FROM kpi_definition WHERE uid='KPI_PORTFOLIO_ENTRY_ACTUALS_INTERNAL_EXTERNAL' LIMIT 1));

-- Create Budget Internal External KPI
insert into kpi_value_definition (deleted, last_update, name, render_type, render_pattern, is_trend_displayed, is_displayed)
VALUES (0, now(), 'kpi.pe_budget_internal.main.name', 'PATTERN', ':default_currency_code :d', 0, 1),
       (0, now(), 'kpi.pe_budget_internal.additional1.name', 'PATTERN', 'default_currency_code :d', 0, 1),
       (0, now(), 'kpi.pe_budget_internal.additional2.name', 'PATTERN', ':default_currency_code :d', 0, 1);

insert into kpi_definition (deleted, last_update, uid, css_glyphicon, is_active, is_displayed, `order`, object_type, is_external, is_standard, clazz, scheduler_start_time, scheduler_frequency, scheduler_real_time, main_kpi_value_definition_id, additional1kpi_value_definition_id, additional2kpi_value_definition_id)
SELECT 0, now(), 'KPI_PORTFOLIO_ENTRY_BUDGET_INTERNAL_EXTERNAL', 'fa fa-money', 0, 1, max(`order`) + 1, 'models.pmo.PortfolioEntry', 0, 1, 'services.kpi.BudgetInternalExternalKpi', '03h00', '1440', 0, kvd_main.id, kvd_additional1.id, kvd_additional2.id
from
     (select id from kpi_value_definition where name = 'kpi.pe_budget_internal.main.name') kvd_main,
     (select id from kpi_value_definition where name = 'kpi.pe_budget_internal.additional1.name') kvd_additional1,
     (select id from kpi_value_definition where name = 'kpi.pe_budget_internal.additional2.name') kvd_additional2,
     kpi_definition kd
where kd.object_type = 'models.pmo.PortfolioEntry' and kd.is_external = 0;

insert into kpi_definition_has_system_permission
  select
    kd.id,
    sp.id
  from
    kpi_definition kd,
    system_permission sp
  where kd.uid = 'KPI_PORTFOLIO_ENTRY_BUDGET_INTERNAL_EXTERNAL'
     and sp.name in (
    'PORTFOLIO_ENTRY_VIEW_FINANCIAL_INFO_ALL_PERMISSION',
    'PORTFOLIO_ENTRY_VIEW_FINANCIAL_INFO_AS_MANAGER_PERMISSION',
    'PORTFOLIO_ENTRY_VIEW_FINANCIAL_INFO_AS_PORTFOLIO_MANAGER_PERMISSION',
    'PORTFOLIO_ENTRY_VIEW_FINANCIAL_INFO_AS_STAKEHOLDER_PERMISSION'
  );

INSERT INTO `kpi_color_rule` (`last_update`, `order`, `rule`, `css_color`, `render_label`, `kpi_definition_id`)
	VALUES (NOW(), '0', 'true;', 'primary', NULL, (SELECT id FROM kpi_definition WHERE uid='KPI_PORTFOLIO_ENTRY_BUDGET_INTERNAL_EXTERNAL' LIMIT 1));

-- Create Internal deviation KPI
insert into kpi_value_definition (deleted, last_update, name, render_type, render_pattern, is_trend_displayed, is_displayed)
VALUES (0, now(), 'kpi.pe_deviation_internal.main.name', 'PATTERN', ':si %' , 0, 1),
       (0, now(), 'kpi.pe_deviation_internal.additional1.name', 'PATTERN', ':default_currency_code :d', 0, 1),
       (0, now(), 'kpi.pe_deviation_internal.additional2.name', 'PATTERN', ':default_currency_code :d', 0, 1);

insert into kpi_definition (deleted, last_update, uid, css_glyphicon, is_active, is_displayed, `order`, object_type, is_external, is_standard, clazz, scheduler_start_time, scheduler_frequency, scheduler_real_time, main_kpi_value_definition_id, additional1kpi_value_definition_id, additional2kpi_value_definition_id)
SELECT 0, now(), 'KPI_PORTFOLIO_ENTRY_DEVIATION_INTERNAL', 'fa fa-money', 0, 1, max(`order`) + 1, 'models.pmo.PortfolioEntry', 0, 1, 'services.kpi.DeviationInternalKpi', '03h00', '1440', 0, kvd_main.id, kvd_additional1.id, kvd_additional2.id
from
     (select id from kpi_value_definition where name = 'kpi.pe_deviation_internal.main.name') kvd_main,
     (select id from kpi_value_definition where name = 'kpi.pe_deviation_internal.additional1.name') kvd_additional1,
     (select id from kpi_value_definition where name = 'kpi.pe_deviation_internal.additional2.name') kvd_additional2,
     kpi_definition kd
where kd.object_type = 'models.pmo.PortfolioEntry' and kd.is_external = 0;

insert into kpi_definition_has_system_permission
  select
    kd.id,
    sp.id
  from
    kpi_definition kd,
    system_permission sp
  where kd.uid = 'KPI_PORTFOLIO_ENTRY_DEVIATION_INTERNAL'
     and sp.name in (
    'PORTFOLIO_ENTRY_VIEW_FINANCIAL_INFO_ALL_PERMISSION',
    'PORTFOLIO_ENTRY_VIEW_FINANCIAL_INFO_AS_MANAGER_PERMISSION',
    'PORTFOLIO_ENTRY_VIEW_FINANCIAL_INFO_AS_PORTFOLIO_MANAGER_PERMISSION',
    'PORTFOLIO_ENTRY_VIEW_FINANCIAL_INFO_AS_STAKEHOLDER_PERMISSION'
  );

INSERT INTO `kpi_color_rule` (`last_update`, `order`, `rule`, `css_color`, `render_label`, `kpi_definition_id`)
	VALUES (NOW(), '0', 'if (main != null && main <= 0) { true; } else { false; }', 'success', NULL, (SELECT id FROM kpi_definition WHERE uid='KPI_PORTFOLIO_ENTRY_DEVIATION_INTERNAL' LIMIT 1));

INSERT INTO `kpi_color_rule` (`last_update`, `order`, `rule`, `css_color`, `render_label`, `kpi_definition_id`)
	VALUES (NOW(), '0', 'if (main != null && main <= 10) { true; } else { false; }', 'warning', NULL, (SELECT id FROM kpi_definition WHERE uid='KPI_PORTFOLIO_ENTRY_DEVIATION_INTERNAL' LIMIT 1));

INSERT INTO `kpi_color_rule` (`last_update`, `order`, `rule`, `css_color`, `render_label`, `kpi_definition_id`)
	VALUES (NOW(), '0', 'if (main != null) { true; } else { false; }', 'danger', NULL, (SELECT id FROM kpi_definition WHERE uid='KPI_PORTFOLIO_ENTRY_DEVIATION_INTERNAL' LIMIT 1));

-- Create External deviation KPI
insert into kpi_value_definition (deleted, last_update, name, render_type, render_pattern, is_trend_displayed, is_displayed)
VALUES (0, now(), 'kpi.pe_deviation_external.main.name', 'PATTERN', ':si %', 0, 1),
       (0, now(), 'kpi.pe_deviation_external.additional1.name', 'PATTERN', ':default_currency_code :d', 0, 1),
       (0, now(), 'kpi.pe_deviation_external.additional2.name', 'PATTERN', ':default_currency_code :d', 0, 1);

insert into kpi_definition (deleted, last_update, uid, css_glyphicon, is_active, is_displayed, `order`, object_type, is_external, is_standard, clazz, scheduler_start_time, scheduler_frequency, scheduler_real_time, main_kpi_value_definition_id, additional1kpi_value_definition_id, additional2kpi_value_definition_id)
SELECT 0, now(), 'KPI_PORTFOLIO_ENTRY_DEVIATION_EXTERNAL', 'fa fa-money', 0, 1, max(`order`) + 1, 'models.pmo.PortfolioEntry', 0, 1, 'services.kpi.DeviationExternalKpi', '03h00', '1440', 0, kvd_main.id, kvd_additional1.id, kvd_additional2.id
from
     (select id from kpi_value_definition where name = 'kpi.pe_deviation_external.main.name') kvd_main,
     (select id from kpi_value_definition where name = 'kpi.pe_deviation_external.additional1.name') kvd_additional1,
     (select id from kpi_value_definition where name = 'kpi.pe_deviation_external.additional2.name') kvd_additional2,
     kpi_definition kd
where kd.object_type = 'models.pmo.PortfolioEntry' and kd.is_external = 0;

insert into kpi_definition_has_system_permission
  select
    kd.id,
    sp.id
  from
    kpi_definition kd,
    system_permission sp
  where kd.uid = 'KPI_PORTFOLIO_ENTRY_DEVIATION_EXTERNAL'
     and sp.name in (
    'PORTFOLIO_ENTRY_VIEW_FINANCIAL_INFO_ALL_PERMISSION',
    'PORTFOLIO_ENTRY_VIEW_FINANCIAL_INFO_AS_MANAGER_PERMISSION',
    'PORTFOLIO_ENTRY_VIEW_FINANCIAL_INFO_AS_PORTFOLIO_MANAGER_PERMISSION',
    'PORTFOLIO_ENTRY_VIEW_FINANCIAL_INFO_AS_STAKEHOLDER_PERMISSION'
  );

INSERT INTO `kpi_color_rule` (`last_update`, `order`, `rule`, `css_color`, `render_label`, `kpi_definition_id`)
	VALUES (NOW(), '0', 'if (main != null && main <= 0) { true; } else { false; }', 'success', NULL, (SELECT id FROM kpi_definition WHERE uid='KPI_PORTFOLIO_ENTRY_DEVIATION_EXTERNAL' LIMIT 1));
INSERT INTO `kpi_color_rule` (`last_update`, `order`, `rule`, `css_color`, `render_label`, `kpi_definition_id`)
	VALUES (NOW(), '0', 'if (main != null) { true; } else { false; }', 'warning', NULL, (SELECT id FROM kpi_definition WHERE uid='KPI_PORTFOLIO_ENTRY_DEVIATION_EXTERNAL' LIMIT 1));
INSERT INTO `kpi_color_rule` (`last_update`, `order`, `rule`, `css_color`, `render_label`, `kpi_definition_id`)
	VALUES (NOW(), '0', 'if (main != null && main <= 10) { true; } else { false; }', 'danger', NULL, (SELECT id FROM kpi_definition WHERE uid='KPI_PORTFOLIO_ENTRY_DEVIATION_EXTERNAL' LIMIT 1));

-- //@UNDO

delete from kpi_data where kpi_value_definition_id in
  (select id from `kpi_color_rule` where kpi_definition_id in (select id from kpi_definition where uid in (
    'KPI_PORTFOLIO_ENTRY_DEVIATION_EXTERNAL',
    'KPI_PORTFOLIO_ENTRY_DEVIATION_INTERNAL',
    'KPI_PORTFOLIO_ENTRY_BUDGET_INTERNAL_EXTERNAL',
    'KPI_PORTFOLIO_ENTRY_ACTUALS_INTERNAL_EXTERNAL'
)));

delete from `kpi_color_rule` where kpi_definition_id in (select id from kpi_definition where uid in (
  'KPI_PORTFOLIO_ENTRY_DEVIATION_EXTERNAL',
  'KPI_PORTFOLIO_ENTRY_DEVIATION_INTERNAL',
  'KPI_PORTFOLIO_ENTRY_BUDGET_INTERNAL_EXTERNAL',
  'KPI_PORTFOLIO_ENTRY_ACTUALS_INTERNAL_EXTERNAL'
));

delete from kpi_definition_has_system_permission where kpi_definition_id in (select id from kpi_definition where uid in (
  'KPI_PORTFOLIO_ENTRY_DEVIATION_EXTERNAL',
  'KPI_PORTFOLIO_ENTRY_DEVIATION_INTERNAL',
  'KPI_PORTFOLIO_ENTRY_BUDGET_INTERNAL_EXTERNAL',
  'KPI_PORTFOLIO_ENTRY_ACTUALS_INTERNAL_EXTERNAL'
));

delete from kpi_definition where uid in (
  'KPI_PORTFOLIO_ENTRY_DEVIATION_EXTERNAL',
  'KPI_PORTFOLIO_ENTRY_DEVIATION_INTERNAL',
  'KPI_PORTFOLIO_ENTRY_BUDGET_INTERNAL_EXTERNAL',
  'KPI_PORTFOLIO_ENTRY_ACTUALS_INTERNAL_EXTERNAL'
);

delete from kpi_value_definition where
  name like 'kpi.pe_deviation_external.%' ||
  name like 'kpi.pe_deviation_internal.%' ||
  name like 'kpi.pe_budget_internal.%' ||
  name like 'kpi.pe_actuals_internal.%';


