-- // v16-0-0_Create_resource_allocation_status_type
-- Migration SQL that makes the change goes here.

CREATE TABLE `portfolio_entry_resource_plan_allocation_status_type` (
  `id` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `last_update` TIMESTAMP NOT NULL,
  `deleted` TINYINT(1) NOT NULL,
  `status` VARCHAR(32) NOT NULL,
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `portfolio_entry_resource_plan_allocation_status_type` (last_update, deleted, status) VALUES
  (now(), 0, 'PENDING'),
  (now(), 0, 'CONFIRMED'),
  (now(), 0, 'REFUSED'),
  (now(), 0, 'DRAFT');

ALTER TABLE `portfolio_entry_resource_plan_allocated_org_unit`
ADD COLUMN portfolio_entry_resource_plan_allocation_status_type_id BIGINT(20) AFTER last_update,
ADD KEY fk_perpaou_has_perpast_idx (portfolio_entry_resource_plan_allocation_status_type_id),
ADD CONSTRAINT fk_perpaou_has_perpast FOREIGN KEY (portfolio_entry_resource_plan_allocation_status_type_id) REFERENCES portfolio_entry_resource_plan_allocation_status_type (id)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

ALTER TABLE `portfolio_entry_resource_plan_allocated_actor`
ADD COLUMN portfolio_entry_resource_plan_allocation_status_type_id BIGINT(20) AFTER last_update,
ADD KEY fk_perpaa_has_perpast_idx (portfolio_entry_resource_plan_allocation_status_type_id),
ADD CONSTRAINT fk_perpaa_has_perpast FOREIGN KEY (portfolio_entry_resource_plan_allocation_status_type_id) REFERENCES portfolio_entry_resource_plan_allocation_status_type (id)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

ALTER TABLE `portfolio_entry_resource_plan_allocated_competency`
ADD COLUMN portfolio_entry_resource_plan_allocation_status_type_id BIGINT(20) AFTER last_update,
ADD KEY fk_perpac_has_perpast_idx (portfolio_entry_resource_plan_allocation_status_type_id),
ADD CONSTRAINT fk_perpac_has_perpast FOREIGN KEY (portfolio_entry_resource_plan_allocation_status_type_id) REFERENCES portfolio_entry_resource_plan_allocation_status_type (id)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

UPDATE portfolio_entry_resource_plan_allocated_org_unit
SET portfolio_entry_resource_plan_allocation_status_type_id =
CASE
WHEN is_confirmed = 0 THEN (select id from portfolio_entry_resource_plan_allocation_status_type where status = 'PENDING')
WHEN is_confirmed = 1 THEN (select id from portfolio_entry_resource_plan_allocation_status_type where status = 'CONFIRMED')
END;

UPDATE portfolio_entry_resource_plan_allocated_actor
SET portfolio_entry_resource_plan_allocation_status_type_id =
CASE
WHEN is_confirmed = 0 THEN (select id from portfolio_entry_resource_plan_allocation_status_type where status = 'PENDING')
WHEN is_confirmed = 1 THEN (select id from portfolio_entry_resource_plan_allocation_status_type where status = 'CONFIRMED')
END;

UPDATE portfolio_entry_resource_plan_allocated_competency
SET portfolio_entry_resource_plan_allocation_status_type_id =
CASE
WHEN is_confirmed = 0 THEN (select id from portfolio_entry_resource_plan_allocation_status_type where status = 'PENDING')
WHEN is_confirmed = 1 THEN (select id from portfolio_entry_resource_plan_allocation_status_type where status = 'CONFIRMED')
END;

ALTER TABLE `portfolio_entry_resource_plan_allocated_actor` DROP is_confirmed;
ALTER TABLE `portfolio_entry_resource_plan_allocated_org_unit` DROP is_confirmed;
ALTER TABLE `portfolio_entry_resource_plan_allocated_competency` DROP is_confirmed;

-- //@UNDO
-- SQL to undo the change goes here.

ALTER TABLE portfolio_entry_resource_plan_allocated_actor ADD COLUMN is_confirmed TINYINT(1) NOT NULL AFTER last_update;
ALTER TABLE portfolio_entry_resource_plan_allocated_org_unit ADD COLUMN is_confirmed TINYINT(1) NOT NULL AFTER last_update;
ALTER TABLE portfolio_entry_resource_plan_allocated_competency ADD COLUMN is_confirmed TINYINT(1) NOT NULL AFTER last_update;

UPDATE portfolio_entry_resource_plan_allocated_actor SET is_confirmed =
CASE
WHEN (select status from portfolio_entry_resource_plan_allocation_status_type where id = portfolio_entry_resource_plan_allocation_status_type_id) = 'PENDING' THEN 0
WHEN (select status from portfolio_entry_resource_plan_allocation_status_type where id = portfolio_entry_resource_plan_allocation_status_type_id) = 'CONFIRMED' THEN 1
END;

UPDATE portfolio_entry_resource_plan_allocated_org_unit SET is_confirmed =
CASE
WHEN (select status from portfolio_entry_resource_plan_allocation_status_type where id = portfolio_entry_resource_plan_allocation_status_type_id) = 'PENDING' THEN 0
WHEN (select status from portfolio_entry_resource_plan_allocation_status_type where id = portfolio_entry_resource_plan_allocation_status_type_id) = 'CONFIRMED' THEN 1
END;

UPDATE portfolio_entry_resource_plan_allocated_competency SET is_confirmed =
CASE
WHEN (select status from portfolio_entry_resource_plan_allocation_status_type where id = portfolio_entry_resource_plan_allocation_status_type_id) = 'PENDING' THEN 0
WHEN (select status from portfolio_entry_resource_plan_allocation_status_type where id = portfolio_entry_resource_plan_allocation_status_type_id) = 'CONFIRMED' THEN 1
END;

ALTER TABLE portfolio_entry_resource_plan_allocated_org_unit DROP FOREIGN KEY fk_perpaou_has_perpast;
ALTER TABLE portfolio_entry_resource_plan_allocated_actor DROP FOREIGN KEY fk_perpaa_has_perpast;
ALTER TABLE portfolio_entry_resource_plan_allocated_competency DROP FOREIGN KEY fk_perpac_has_perpast;
DROP INDEX fk_perpaou_has_perpast_idx ON portfolio_entry_resource_plan_allocated_org_unit;
DROP INDEX fk_perpaa_has_perpast_idx ON portfolio_entry_resource_plan_allocated_actor;
DROP INDEX fk_perpac_has_perpast_idx ON portfolio_entry_resource_plan_allocated_competency;
ALTER TABLE portfolio_entry_resource_plan_allocated_org_unit DROP portfolio_entry_resource_plan_allocation_status_type_id;
ALTER TABLE portfolio_entry_resource_plan_allocated_actor DROP portfolio_entry_resource_plan_allocation_status_type_id;
ALTER TABLE portfolio_entry_resource_plan_allocated_competency DROP portfolio_entry_resource_plan_allocation_status_type_id;

DROP TABLE `portfolio_entry_resource_plan_allocation_status_type`;