-- Planned milestones
ALTER TABLE planned_life_cycle_milestone_instance ADD COLUMN creation_date datetime AFTER deleted;
ALTER TABLE planned_life_cycle_milestone_instance ADD COLUMN created_by VARCHAR(256) AFTER creation_date;
alter table planned_life_cycle_milestone_instance drop foreign key fk_plcmi_updated_by;
ALTER TABLE planned_life_cycle_milestone_instance CHANGE updated_by_id updated_by VARCHAR(256);

-- Portfolio entries
ALTER TABLE portfolio_entry ADD COLUMN created_by VARCHAR(256);
ALTER TABLE portfolio_entry add column updated_by VARCHAR(256);

-- Portfolio entry dependencies
ALTER TABLE portfolio_entry_dependency ADD COLUMN creation_date datetime;
ALTER TABLE portfolio_entry_dependency ADD COLUMN created_by VARCHAR(256);
ALTER TABLE portfolio_entry_dependency ADD COLUMN last_update datetime;
ALTER TABLE portfolio_entry_dependency add column updated_by VARCHAR(256);
alter table portfolio_entry_dependency add column deleted tinyint(1) not null default 0;

-- Portfolio entry budget lines
ALTER TABLE portfolio_entry_budget_line ADD COLUMN creation_date datetime;
ALTER TABLE portfolio_entry_budget_line ADD COLUMN created_by VARCHAR(256);
ALTER TABLE portfolio_entry_budget_line add column updated_by VARCHAR(256);
alter table portfolio_entry_budget_line modify column last_update datetime;

-- Work orders
ALTER TABLE work_order ADD COLUMN created_by VARCHAR(256);
ALTER TABLE work_order add column updated_by VARCHAR(256);
alter table work_order modify column last_update datetime;

-- packages
alter table portfolio_entry_planning_package add column creation_date datetime;
alter table portfolio_entry_planning_package add column created_by VARCHAR(256);
alter table portfolio_entry_planning_package add column updated_by VARCHAR(256);
alter table portfolio_entry_planning_package modify column last_update datetime;

-- actor resources
alter table portfolio_entry_resource_plan_allocated_actor add column creation_date datetime;
alter table portfolio_entry_resource_plan_allocated_actor add column created_by VARCHAR(256);
alter table portfolio_entry_resource_plan_allocated_actor add column updated_by VARCHAR(256);
alter table portfolio_entry_resource_plan_allocated_actor modify column last_update datetime;

-- org unit resources
alter table portfolio_entry_resource_plan_allocated_org_unit add column creation_date datetime;
alter table portfolio_entry_resource_plan_allocated_org_unit add column created_by VARCHAR(256);
alter table portfolio_entry_resource_plan_allocated_org_unit add column updated_by VARCHAR(256);
alter table portfolio_entry_resource_plan_allocated_org_unit modify column last_update datetime;

-- competency resources
alter table portfolio_entry_resource_plan_allocated_competency add column creation_date datetime;
alter table portfolio_entry_resource_plan_allocated_competency add column created_by VARCHAR(256);
alter table portfolio_entry_resource_plan_allocated_competency add column updated_by VARCHAR(256);
alter table portfolio_entry_resource_plan_allocated_competency modify column last_update datetime;

-- risks
alter table portfolio_entry_risk add column created_by VARCHAR(256);
alter table portfolio_entry_risk add column updated_by VARCHAR(256);
alter table portfolio_entry_risk modify column last_update datetime;

-- issues
alter table portfolio_entry_issue add column created_by VARCHAR(256);
alter table portfolio_entry_issue add column updated_by VARCHAR(256);
alter table portfolio_entry_issue modify column last_update datetime;

-- reports
alter table portfolio_entry_report add column created_by VARCHAR(256);
alter table portfolio_entry_report add column updated_by VARCHAR(256);
alter table portfolio_entry_report modify column last_update datetime;

-- events
alter table portfolio_entry_event add column created_by VARCHAR(256);
alter table portfolio_entry_event add column updated_by VARCHAR(256);
alter table portfolio_entry_event modify column last_update datetime;

-- timesheet activities
alter table timesheet_activity_allocated_actor add column creation_date datetime;
alter table timesheet_activity_allocated_actor add column created_by VARCHAR(256);
alter table timesheet_activity_allocated_actor add column updated_by VARCHAR(256);
alter table timesheet_activity_allocated_actor modify column last_update datetime;

-- Add allocation status translations in DB
insert into i18n_messages (`key`, `language`, `value`) values
('object.allocated_resource.status_type.DRAFT.label', 'fr', 'Brouillon'),
('object.allocated_resource.status_type.DRAFT.label', 'en', 'Draft'),
('object.allocated_resource.status_type.DRAFT.label', 'de', 'Entwurf'),
('object.allocated_resource.status_type.PENDING.label', 'fr', 'En attente'),
('object.allocated_resource.status_type.PENDING.label', 'en', 'Pending'),
('object.allocated_resource.status_type.PENDING.label', 'de', 'Anstehend'),
('object.allocated_resource.status_type.CONFIRMED.label', 'fr', 'Confirmé'),
('object.allocated_resource.status_type.CONFIRMED.label', 'en', 'Confirmed'),
('object.allocated_resource.status_type.CONFIRMED.label', 'de', 'Bestätigt'),
('object.allocated_resource.status_type.REFUSED.label', 'fr', 'Refusé'),
('object.allocated_resource.status_type.REFUSED.label', 'en', 'Refused'),
('object.allocated_resource.status_type.REFUSED.label', 'de', 'Abgelehnt');

-- //@UNDO
-- SQL to undo the change goes here.

ALTER TABLE planned_life_cycle_milestone_instance DROP FOREIGN KEY fk_plcmi_created_by;
ALTER TABLE planned_life_cycle_milestone_instance DROP COLUMN created_by;
ALTER TABLE planned_life_cycle_milestone_instance DROP COLUMN creation_date;
alter table portfolio_entry drop foreign key fk_pe_updated_by;
ALTER TABLE portfolio_entry drop foreign key fk_pe_created_by;
ALTER TABLE portfolio_entry drop column updated_by;
ALTER TABLE portfolio_entry drop column created_by;
alter table portfolio_entry_dependency drop foreign key fk_ped_created_by;
alter table portfolio_entry_dependency drop foreign key fk_ped_updated_by;
alter table portfolio_entry_dependency drop column creation_date;
alter table portfolio_entry_dependency drop column created_by;
alter table portfolio_entry_dependency drop column last_update;
alter table portfolio_entry_dependency drop column updated_by;
alter table portfolio_entry_dependency drop column deleted;
alter table portfolio_entry_budget_line drop foreign key fk_pebl_created_by;
alter table portfolio_entry_budget_line drop foreign key fk_pebl_updated_by;
alter table portfolio_entry_budget_line drop column creation_date;
alter table portfolio_entry_budget_line drop column created_by;
alter table portfolio_entry_budget_line drop column updated_by;
alter table work_order drop foreign key fk_wo_created_by;
alter table work_order drop foreign key fk_wo_updated_by;
alter table work_order drop column created_by;
alter table work_order drop column updated_by;
alter table portfolio_entry_planning_package drop foreign key fk_pepp_created_by;
alter table portfolio_entry_planning_package drop foreign key fk_pepp_updated_by;
alter table portfolio_entry_planning_package drop column creation_date;
alter table portfolio_entry_planning_package drop column created_by;
alter table portfolio_entry_planning_package drop column updated_by;
