RENAME TABLE life_cycle_milestone_approver TO life_cycle_milestone_actor_approver;

CREATE TABLE `life_cycle_milestone_org_unit_approver` (
    `life_cycle_milestone_id` bigint(20) NOT NULL,
    `org_unit_id` bigint(20) NOT NULL,
    PRIMARY KEY (`life_cycle_milestone_id`,`org_unit_id`),
    KEY `fk_life_cycle_milestone_has_org_unit_idx` (`org_unit_id`),
    KEY `fk_life_cycle_milestone_has_org_unit_life_cycle_milestone1_idx` (`life_cycle_milestone_id`),
    CONSTRAINT `fk_life_cycle_milestone_has_org_unit_life_cycle_milestone1` FOREIGN KEY (`life_cycle_milestone_id`) REFERENCES `life_cycle_milestone` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
    CONSTRAINT `fk_life_cycle_milestone_has_org_unit_org_unit1` FOREIGN KEY (`org_unit_id`) REFERENCES `org_unit` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

ALTER TABLE life_cycle_milestone_instance_approver
    ADD COLUMN org_unit_id BIGINT(20) AFTER actor_id,
    MODIFY COLUMN actor_id BIGINT(20) NULL,
    ADD KEY fk_life_cycle_milestone_instance_orgunit1_idx (org_unit_id),
    ADD CONSTRAINT fk_life_cycle_milestone_instance_has_org_unit_org_unit1 FOREIGN KEY (org_unit_id) REFERENCES org_unit (id) ON DELETE NO ACTION ON UPDATE NO ACTION,
    DROP INDEX uq_actor_id_life_cycle_milestone_instance_id,
    ADD CONSTRAINT uq_actor_id_life_cycle_milestone_instance_id_org_unit_id UNIQUE INDEX (life_cycle_milestone_instance_id, actor_id, org_unit_id);