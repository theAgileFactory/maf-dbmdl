-- Planned milestones
ALTER TABLE planned_life_cycle_milestone_instance ADD COLUMN creation_date datetime AFTER deleted;
ALTER TABLE planned_life_cycle_milestone_instance ADD COLUMN created_by_id BIGINT(20) AFTER creation_date;
ALTER TABLE planned_life_cycle_milestone_instance ADD FOREIGN KEY fk_plcmi_created_by (created_by_id) REFERENCES actor (id) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Portfolio entries
ALTER TABLE portfolio_entry ADD COLUMN created_by_id bigint(20);
ALTER TABLE portfolio_entry add column updated_by_id bigint(20);
ALTER TABLE portfolio_entry add foreign key fk_pe_created_by (created_by_id) references actor (id) on delete no action on update no action;
ALTER TABLE portfolio_entry add foreign key fk_pe_updated_by (updated_by_id) references actor (id) on delete no action on update no action;

-- Portfolio entry dependencies
ALTER TABLE portfolio_entry_dependency ADD COLUMN creation_date datetime;
ALTER TABLE portfolio_entry_dependency ADD COLUMN created_by_id bigint(20);
ALTER TABLE portfolio_entry_dependency ADD COLUMN last_update datetime;
ALTER TABLE portfolio_entry_dependency add column updated_by_id bigint(20);
alter table portfolio_entry_dependency add column deleted tinyint(1);
ALTER TABLE portfolio_entry_dependency add foreign key fk_ped_created_by (created_by_id) references actor (id) on delete no action on update no action;
ALTER TABLE portfolio_entry_dependency add foreign key fk_ped_updated_by (updated_by_id) references actor (id) on delete no action on update no action;

-- Portfolio entry budget lines
ALTER TABLE portfolio_entry_budget_line ADD COLUMN creation_date datetime;
ALTER TABLE portfolio_entry_budget_line ADD COLUMN created_by_id bigint(20);
ALTER TABLE portfolio_entry_budget_line add column updated_by_id bigint(20);
alter table portfolio_entry_budget_line modify column last_update datetime;
ALTER TABLE portfolio_entry_budget_line add foreign key fk_pebl_created_by (created_by_id) references actor (id) on delete no action on update no action;
ALTER TABLE portfolio_entry_budget_line add foreign key fk_pebl_updated_by (updated_by_id) references actor (id) on delete no action on update no action;

-- Work orders
ALTER TABLE work_order ADD COLUMN created_by_id bigint(20);
ALTER TABLE work_order add column updated_by_id bigint(20);
alter table work_order modify column last_update datetime;
ALTER TABLE work_order add foreign key fk_wo_created_by (created_by_id) references actor (id) on delete no action on update no action;
ALTER TABLE work_order add foreign key fk_wo_updated_by (updated_by_id) references actor (id) on delete no action on update no action;

-- packages
alter table portfolio_entry_planning_package add column creation_date datetime;
alter table portfolio_entry_planning_package add column created_by_id bigint(20);
alter table portfolio_entry_planning_package add column updated_by_id bigint(20);
alter table portfolio_entry_planning_package modify column last_update datetime;
alter table portfolio_entry_planning_package add foreign key fk_pepp_created_by (created_by_id) references actor(id) on delete no action on update no action;
alter table portfolio_entry_planning_package add foreign key fk_pepp_updated_by (updated_by_id) references actor(id) on delete no action on update no action;

-- actor resources
alter table portfolio_entry_resource_plan_allocated_actor add column creation_date datetime;
alter table portfolio_entry_resource_plan_allocated_actor add column created_by_id bigint(20);
alter table portfolio_entry_resource_plan_allocated_actor add column updated_by_id bigint(20);
alter table portfolio_entry_resource_plan_allocated_actor modify column last_update datetime;
alter table portfolio_entry_resource_plan_allocated_actor add foreign key fk_perpaa_created_by (created_by_id) references actor(id) on delete no action on update no action;
alter table portfolio_entry_resource_plan_allocated_actor add foreign key fk_perpaa_updated_by (updated_by_id) references actor(id) on delete no action on update no action;

-- org unit resources
alter table portfolio_entry_resource_plan_allocated_org_unit add column creation_date datetime;
alter table portfolio_entry_resource_plan_allocated_org_unit add column created_by_id bigint(20);
alter table portfolio_entry_resource_plan_allocated_org_unit add column updated_by_id bigint(20);
alter table portfolio_entry_resource_plan_allocated_org_unit modify column last_update datetime;
alter table portfolio_entry_resource_plan_allocated_org_unit add foreign key fk_perpaou_created_by (created_by_id) references actor(id) on delete no action on update no action;
alter table portfolio_entry_resource_plan_allocated_org_unit add foreign key fk_perpaou_updated_by (updated_by_id) references actor(id) on delete no action on update no action;

-- competency resources
alter table portfolio_entry_resource_plan_allocated_competency add column creation_date datetime;
alter table portfolio_entry_resource_plan_allocated_competency add column created_by_id bigint(20);
alter table portfolio_entry_resource_plan_allocated_competency add column updated_by_id bigint(20);
alter table portfolio_entry_resource_plan_allocated_competency modify column last_update datetime;
alter table portfolio_entry_resource_plan_allocated_competency add foreign key fk_perpac_created_by (created_by_id) references actor(id) on delete no action on update no action;
alter table portfolio_entry_resource_plan_allocated_competency add foreign key fk_perpac_updated_by (updated_by_id) references actor(id) on delete no action on update no action;

-- risks
alter table portfolio_entry_risk add column created_by_id bigint(20);
alter table portfolio_entry_risk add column updated_by_id bigint(20);
alter table portfolio_entry_risk modify column last_update datetime;
alter table portfolio_entry_risk add foreign key fk_peri_created_by (created_by_id) references actor(id) on delete no action on update no action;
alter table portfolio_entry_risk add foreign key fk_peri_updated_by (updated_by_id) references actor(id) on delete no action on update no action;

-- issues
alter table portfolio_entry_issue add column created_by_id bigint(20);
alter table portfolio_entry_issue add column updated_by_id bigint(20);
alter table portfolio_entry_issue modify column last_update datetime;
alter table portfolio_entry_issue add foreign key fk_pei_created_by (created_by_id) references actor(id) on delete no action on update no action;
alter table portfolio_entry_issue add foreign key fk_pei_updated_by (updated_by_id) references actor(id) on delete no action on update no action;

-- reports
alter table portfolio_entry_report add column created_by_id bigint(20);
alter table portfolio_entry_report add column updated_by_id bigint(20);
alter table portfolio_entry_report modify column last_update datetime;
alter table portfolio_entry_report add foreign key fk_pere_created_by (created_by_id) references actor(id) on delete no action on update no action;
alter table portfolio_entry_report add foreign key fk_pere_updated_by (updated_by_id) references actor(id) on delete no action on update no action;

-- events
alter table portfolio_entry_event add column created_by_id bigint(20);
alter table portfolio_entry_event add column updated_by_id bigint(20);
alter table portfolio_entry_event modify column last_update datetime;
alter table portfolio_entry_event add foreign key fk_pee_created_by (created_by_id) references actor(id) on delete no action on update no action;
alter table portfolio_entry_event add foreign key fk_pee_updated_by (updated_by_id) references actor(id) on delete no action on update no action;

-- //@UNDO
-- SQL to undo the change goes here.

ALTER TABLE planned_life_cycle_milestone_instance DROP FOREIGN KEY fk_plcmi_created_by;
ALTER TABLE planned_life_cycle_milestone_instance DROP COLUMN created_by_id;
ALTER TABLE planned_life_cycle_milestone_instance DROP COLUMN creation_date;
alter table portfolio_entry drop foreign key fk_pe_updated_by;
ALTER TABLE portfolio_entry drop foreign key fk_pe_created_by;
ALTER TABLE portfolio_entry drop column updated_by_id;
ALTER TABLE portfolio_entry drop column created_by_id;
alter table portfolio_entry_dependency drop foreign key fk_ped_created_by;
alter table portfolio_entry_dependency drop foreign key fk_ped_updated_by;
alter table portfolio_entry_dependency drop column creation_date;
alter table portfolio_entry_dependency drop column created_by_id;
alter table portfolio_entry_dependency drop column last_update;
alter table portfolio_entry_dependency drop column updated_by_id;
alter table portfolio_entry_dependency drop column deleted;
alter table portfolio_entry_budget_line drop foreign key fk_pebl_created_by;
alter table portfolio_entry_budget_line drop foreign key fk_pebl_updated_by;
alter table portfolio_entry_budget_line drop column creation_date;
alter table portfolio_entry_budget_line drop column created_by_id;
alter table portfolio_entry_budget_line drop column updated_by_id;
alter table work_order drop foreign key fk_wo_created_by;
alter table work_order drop foreign key fk_wo_updated_by;
alter table work_order drop column created_by_id;
alter table work_order drop column updated_by_id;
alter table portfolio_entry_planning_package drop foreign key fk_pepp_created_by;
alter table portfolio_entry_planning_package drop foreign key fk_pepp_updated_by;
alter table portfolio_entry_planning_package drop column creation_date;
alter table portfolio_entry_planning_package drop column created_by_id;
alter table portfolio_entry_planning_package drop column updated_by_id;
