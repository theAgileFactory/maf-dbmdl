-- // v16-0-0_add_next_milestone_to_roadmap
-- Migration SQL that makes the change goes here.

ALTER TABLE `portfolio_entry`
  ADD COLUMN `next_planned_life_cycle_milestone_instance_id` bigint(20) DEFAULT NULL AFTER `last_approved_life_cycle_milestone_instance_id`,
  ADD KEY `pe_plcmi_idx` (`next_planned_life_cycle_milestone_instance_id`),
  ADD CONSTRAINT fk_pe_plcmi FOREIGN KEY (next_planned_life_cycle_milestone_instance_id) REFERENCES planned_life_cycle_milestone_instance (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

update
    portfolio_entry pe
    left join life_cycle_instance lci on pe.active_life_cycle_instance_id = lci.id
    left join life_cycle_instance_planning lcip on lci.id = lcip.life_cycle_instance_id and lcip.deleted = 0 and lcip.is_frozen = 0
    left join planned_life_cycle_milestone_instance plcmi on lcip.id = plcmi.life_cycle_instance_planning_id and plcmi.deleted = 0 and plcmi.id = (
      select  min(id)
      from    planned_life_cycle_milestone_instance
      where   life_cycle_instance_planning_id = lcip.id
    )
set
  pe.next_planned_life_cycle_milestone_instance_id = plcmi.id;

-- //@UNDO
-- SQL to undo the change goes here.

ALTER TABLE portfolio_entry
  DROP FOREIGN KEY fk_pe_plcmi,
  DROP COLUMN next_planned_life_cycle_milestone_instance_id;
