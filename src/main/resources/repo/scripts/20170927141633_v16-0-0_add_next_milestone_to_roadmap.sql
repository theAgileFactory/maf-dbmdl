-- // v16-0-0_add_next_milestone_to_roadmap
-- Migration SQL that makes the change goes here.

ALTER TABLE `portfolio_entry`
  ADD COLUMN `next_planned_life_cycle_milestone_instance_id` bigint(20) DEFAULT NULL AFTER `last_approved_life_cycle_milestone_instance_id`,
  ADD KEY `pe_plcmi_idx` (`next_planned_life_cycle_milestone_instance_id`),
  ADD CONSTRAINT fk_pe_plcmi FOREIGN KEY (next_planned_life_cycle_milestone_instance_id) REFERENCES planned_life_cycle_milestone_instance (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

UPDATE
    portfolio_entry pe
    LEFT JOIN life_cycle_instance lci ON pe.active_life_cycle_instance_id = lci.id
    LEFT JOIN life_cycle_instance_planning lcip
      ON lci.id = lcip.life_cycle_instance_id AND lcip.deleted = 0 AND lcip.is_frozen = 0
    LEFT JOIN planned_life_cycle_milestone_instance plcmi
      ON lcip.id = plcmi.life_cycle_instance_planning_id AND plcmi.deleted = 0
    LEFT JOIN life_cycle_milestone lcm ON plcmi.life_cycle_milestone_id = lcm.id
    LEFT JOIN i18n_messages lcm_name ON lcm_name.`key` = lcm.short_name AND lcm_name.language = 'fr'
    LEFT JOIN (
                SELECT
                  pe.id,
                  min(lcm.`order`) AS min
                FROM
                  portfolio_entry pe
                  LEFT JOIN life_cycle_instance lci ON pe.active_life_cycle_instance_id = lci.id
                  LEFT JOIN life_cycle_instance_planning lcip
                    ON lci.id = lcip.life_cycle_instance_id AND lcip.deleted = 0 AND lcip.is_frozen = 0
                  LEFT JOIN planned_life_cycle_milestone_instance plcmi
                    ON lcip.id = plcmi.life_cycle_instance_planning_id AND plcmi.deleted = 0
                  LEFT JOIN life_cycle_milestone lcm ON plcmi.life_cycle_milestone_id = lcm.id
                  LEFT JOIN i18n_messages lcm_name ON lcm_name.`key` = lcm.short_name AND lcm_name.language = 'fr'
                GROUP BY
                  pe.id

              ) AS minOrder ON minOrder.id = pe.id
SET
  pe.next_planned_life_cycle_milestone_instance_id = plcmi.id
WHERE minOrder.min = lcm.`order`;

-- //@UNDO
-- SQL to undo the change goes here.

ALTER TABLE portfolio_entry
  DROP FOREIGN KEY fk_pe_plcmi,
  DROP COLUMN next_planned_life_cycle_milestone_instance_id;
