-- // v15-0-0 Budget and Forecast KPIs
-- Migration SQL that makes the change goes here.

INSERT INTO kpi_value_definition (deleted, last_update, name, render_type, is_trend_displayed) VALUES
  (0, NOW(), 'kpi.pe_budget.main.name', 'VALUE', 1),
  (0, NOW(), 'kpi.pe_budget.additional1.name', 'VALUE', 1),
  (0, NOW(), 'kpi.pe_budget.additional2.name', 'VALUE', 1),
  (0, NOW(), 'kpi.pe_forecast.main.name', 'VALUE', 1),
  (0, NOW(), 'kpi.pe_forecast.additional1.name', 'VALUE', 1),
  (0, NOW(), 'kpi.pe_forecast.additional2.name', 'VALUE', 1);

INSERT INTO kpi_definition (deleted, last_update, uid, css_glyphicon, is_active, is_displayed, `order`, object_type, is_external, is_standard, clazz, scheduler_start_time, scheduler_frequency, scheduler_real_time, main_kpi_value_definition_id, additional1kpi_value_definition_id, additional2kpi_value_definition_id)
SELECT 0, NOW(), 'KPI_PORTFOLIO_ENTRY_BUDGET', 'fa fa-money', 1, 1, max(`order`) + 1, 'models.pmo.PortfolioEntry', 0, 1, 'services.kpi.BudgetKpi', '03h00', '1440', 0, kvd_main.id, kvd_additional1.id, kvd_additional2.id
FROM
  (SELECT id FROM kpi_value_definition WHERE name = 'kpi.pe_budget.main.name') kvd_main,
  (select id from kpi_value_definition where name = 'kpi.pe_budget.additional1.name') kvd_additional1,
  (select id from kpi_value_definition where name = 'kpi.pe_budget.additional2.name') kvd_additional2,
  kpi_definition kd
WHERE kd.object_type = 'models.pmo.PortfolioEntry';

INSERT INTO kpi_definition (deleted, last_update, uid, css_glyphicon, is_active, is_displayed, `order`, object_type, is_external, is_standard, clazz, scheduler_start_time, scheduler_frequency, scheduler_real_time, main_kpi_value_definition_id, additional1kpi_value_definition_id, additional2kpi_value_definition_id)
  SELECT 0, NOW(), 'KPI_PORTFOLIO_ENTRY_FORECAST', 'fa fa-money', 1, 1, max(`order`) + 1, 'models.pmo.PortfolioEntry', 0, 1, 'services.kpi.ForecastKpi', '03h00', '1440', 0, kvd_main.id, kvd_additional1.id, kvd_additional2.id
  FROM
    (SELECT id FROM kpi_value_definition WHERE name = 'kpi.pe_forecast.main.name') kvd_main,
    (select id from kpi_value_definition where name = 'kpi.pe_forecast.additional1.name') kvd_additional1,
    (select id from kpi_value_definition where name = 'kpi.pe_forecast.additional2.name') kvd_additional2,
    kpi_definition kd
  WHERE kd.object_type = 'models.pmo.PortfolioEntry';

INSERT INTO kpi_color_rule (deleted, last_update, `order`, rule, css_color, render_label, kpi_definition_id)
SELECT 0, now(), 0, 'true', 'primary', null, kd.id
FROM kpi_definition kd
WHERE kd.uid in ('KPI_PORTFOLIO_ENTRY_BUDGET', 'KPI_PORTFOLIO_ENTRY_FORECAST');

UPDATE kpi_color_rule SET rule  = 'true;' WHERE rule = 'true';

INSERT INTO kpi_definition_has_system_permission
  SELECT
    kd.id,
    sp.id
  FROM
    kpi_definition kd,
    system_permission sp
  WHERE kd.uid IN (
    'KPI_PORTFOLIO_ENTRY_BUDGET',
    'KPI_PORTFOLIO_ENTRY_FORECAST'
  ) AND sp.name IN (
    'PORTFOLIO_ENTRY_VIEW_FINANCIAL_INFO_ALL_PERMISSION',
    'PORTFOLIO_ENTRY_VIEW_FINANCIAL_INFO_AS_MANAGER_PERMISSION',
    'PORTFOLIO_ENTRY_VIEW_FINANCIAL_INFO_AS_PORTFOLIO_MANAGER_PERMISSION',
    'PORTFOLIO_ENTRY_VIEW_FINANCIAL_INFO_AS_STAKEHOLDER_PERMISSION'
  );



-- //@UNDO
-- SQL to undo the change goes here.

DELETE
FROM kpi_definition_has_system_permission
WHERE kpi_definition_id IN (
    SELECT id
    FROM kpi_definition
    WHERE uid IN ('KPI_PORTFOLIO_ENTRY_BUDGET' ,'KPI_PORTFOLIO_ENTRY_FORECAST')
  );

DELETE
FROM kpi_data
WHERE kpi_value_definition_id IN (
    SELECT id FROM kpi_value_definition WHERE name IN (
      'kpi.pe_budget.main.name',
      'kpi.pe_budget.additional1.name',
      'kpi.pe_budget.additional2.name',
      'kpi.pe_forecast.main.name',
      'kpi.pe_forecast.additional1.name',
      'kpi.pe_forecast.additional2.name')
);

DELETE
FROM kpi_color_rule
WHERE kpi_definition_id IN (
    SELECT id
           FROM kpi_definition
           WHERE uid IN ('KPI_PORTFOLIO_ENTRY_BUDGET' ,'KPI_PORTFOLIO_ENTRY_FORECAST')
);

DELETE
FROM kpi_definition
WHERE uid IN ('KPI_PORTFOLIO_ENTRY_BUDGET' ,'KPI_PORTFOLIO_ENTRY_FORECAST');

DELETE
FROM kpi_value_definition
WHERE name IN ('kpi.pe_budget.main.name',
               'kpi.pe_budget.additional1.name',
               'kpi.pe_budget.additional2.name',
               'kpi.pe_forecast.main.name',
               'kpi.pe_forecast.additional1.name',
               'kpi.pe_forecast.additional2.name');