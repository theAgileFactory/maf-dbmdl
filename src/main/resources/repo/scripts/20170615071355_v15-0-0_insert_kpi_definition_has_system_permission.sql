-- // v15-0-0_insert_kpi_definition_has_system_permission
-- Migration SQL that makes the change goes here.

insert into kpi_definition_has_system_permission
  select
    kd.id,
    sp.id
  from
    kpi_definition kd,
    system_permission sp
  where kd.uid in (
    'KPI_RISKS_AND_ISSUES',
    'KPI_ALLOCATED_ACTOR_DAYS',
    'KPI_ALLOCATED_ORG_UNIT_DAYS',
    'KPI_REQUIREMENT_STORY_POINTS',
    'KPI_REQUIREMENT_NUMBER',
    'KPI_DEFECT_NUMBER',
    'KPI_REQUIREMENT_IS_SCOPED',
    'KPI_PORTFOLIO_ENTRY_PROGRESS',
    'KPI_RELEASE_BURNDOWN',
    'KPI_PORTFOLIO_ENTRY_ALLOCATION_PROGRESS'
  ) and sp.name in (
    'PORTFOLIO_ENTRY_VIEW_DETAILS_ALL_PERMISSION',
    'PORTFOLIO_ENTRY_VIEW_DETAILS_AS_MANAGER_PERMISSION',
    'PORTFOLIO_ENTRY_VIEW_DETAILS_AS_PORTFOLIO_MANAGER_PERMISSION',
    'PORTFOLIO_ENTRY_VIEW_DETAILS_AS_STAKEHOLDER_PERMISSION',
    'PORTFOLIO_ENTRY_VIEW_PUBLIC_PERMISSION'
  );

insert into kpi_definition_has_system_permission
  select
    kd.id,
    sp.id
  from
    kpi_definition kd,
    system_permission sp
  where kd.uid in (
    'KPI_DEVIATION_CAPEX',
    'KPI_DEVIATION_OPEX',
    'KPI_PORTFOLIO_ENTRY_ACTUALS'
  ) and sp.name in (
    'PORTFOLIO_ENTRY_VIEW_FINANCIAL_INFO_ALL_PERMISSION',
    'PORTFOLIO_ENTRY_VIEW_FINANCIAL_INFO_AS_MANAGER_PERMISSION',
    'PORTFOLIO_ENTRY_VIEW_FINANCIAL_INFO_AS_PORTFOLIO_MANAGER_PERMISSION',
    'PORTFOLIO_ENTRY_VIEW_FINANCIAL_INFO_AS_STAKEHOLDER_PERMISSION'
  );

insert into kpi_definition_has_system_permission
  select
    kd.id,
    sp.id
  from
    kpi_definition kd,
    system_permission sp
  where kd.uid in (
    'KPI_PORTFOLIO_NUMBER_OF_ENTRIES'
  ) and sp.name in (
    'PORTFOLIO_VIEW_DETAILS_ALL_PERMISSION',
    'PORTFOLIO_VIEW_DETAILS_AS_MANAGER_PERMISSION',
    'PORTFOLIO_VIEW_DETAILS_AS_STAKEHOLDER_PERMISSION'
  );

insert into kpi_definition_has_system_permission
  select
    kd.id,
    sp.id
  from
    kpi_definition kd,
    system_permission sp
  where kd.uid in (
    'KPI_PORTFOLIO_DEVIATION_CAPEX',
    'KPI_PORTFOLIO_DEVIATION_OPEX'
  ) and sp.name in (
    'PORTFOLIO_VIEW_FINANCIAL_INFO_ALL_PERMISSION'
  );

-- //@UNDO
-- SQL to undo the change goes here.

delete from kpi_definition_has_system_permission;
