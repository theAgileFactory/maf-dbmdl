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
ADD COLUMN last_status_type_update_time DATETIME,
ADD COLUMN last_status_type_update_actor_id BIGINT(20),
ADD KEY fk_perpaou_has_perpast_idx (portfolio_entry_resource_plan_allocation_status_type_id),
ADD KEY perpaou_actor_idx (last_status_type_update_actor_id),
ADD CONSTRAINT fk_perpaou_has_perpast FOREIGN KEY (portfolio_entry_resource_plan_allocation_status_type_id) REFERENCES portfolio_entry_resource_plan_allocation_status_type (id)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION,
ADD CONSTRAINT perpaou_actor_fk FOREIGN KEY (last_status_type_update_actor_id) REFERENCES actor (id)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

ALTER TABLE `portfolio_entry_resource_plan_allocated_actor`
ADD COLUMN portfolio_entry_resource_plan_allocation_status_type_id BIGINT(20) AFTER last_update,
ADD COLUMN last_status_type_update_time DATETIME,
ADD COLUMN last_status_type_update_actor_id BIGINT(20),
ADD KEY fk_perpaa_has_perpast_idx (portfolio_entry_resource_plan_allocation_status_type_id),
ADD KEY perpaa_actor_idx (last_status_type_update_actor_id),
ADD CONSTRAINT fk_perpaa_has_perpast FOREIGN KEY (portfolio_entry_resource_plan_allocation_status_type_id) REFERENCES portfolio_entry_resource_plan_allocation_status_type (id)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION,
ADD CONSTRAINT perpaa_actor_fk FOREIGN KEY (last_status_type_update_actor_id) REFERENCES actor (id)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

ALTER TABLE `portfolio_entry_resource_plan_allocated_competency`
ADD COLUMN portfolio_entry_resource_plan_allocation_status_type_id BIGINT(20) AFTER last_update,
ADD COLUMN last_status_type_update_time DATETIME,
ADD COLUMN last_status_type_update_actor_id BIGINT(20),
ADD KEY fk_perpac_has_perpast_idx (portfolio_entry_resource_plan_allocation_status_type_id),
ADD KEY perpac_actor_idx (last_status_type_update_actor_id),
ADD CONSTRAINT fk_perpac_has_perpast FOREIGN KEY (portfolio_entry_resource_plan_allocation_status_type_id) REFERENCES portfolio_entry_resource_plan_allocation_status_type (id)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION,
ADD CONSTRAINT perpac_actor_fk FOREIGN KEY (last_status_type_update_actor_id) REFERENCES actor (id)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

UPDATE portfolio_entry_resource_plan_allocated_org_unit
SET portfolio_entry_resource_plan_allocation_status_type_id =
IF(
    is_confirmed = 1,
    (select id from portfolio_entry_resource_plan_allocation_status_type where status = 'CONFIRMED'),
    (select id from portfolio_entry_resource_plan_allocation_status_type where status = 'DRAFT')
);

UPDATE portfolio_entry_resource_plan_allocated_actor
SET portfolio_entry_resource_plan_allocation_status_type_id =
IF(
    is_confirmed = 1,
    (select id from portfolio_entry_resource_plan_allocation_status_type where status = 'CONFIRMED'),
    (select id from portfolio_entry_resource_plan_allocation_status_type where status = 'DRAFT')
);

UPDATE portfolio_entry_resource_plan_allocated_competency
SET portfolio_entry_resource_plan_allocation_status_type_id =
IF(
    is_confirmed = 1,
    (select id from portfolio_entry_resource_plan_allocation_status_type where status = 'CONFIRMED'),
    (select id from portfolio_entry_resource_plan_allocation_status_type where status = 'DRAFT')
);

ALTER TABLE `portfolio_entry_resource_plan_allocated_actor` DROP is_confirmed;
ALTER TABLE `portfolio_entry_resource_plan_allocated_org_unit` DROP is_confirmed;
ALTER TABLE `portfolio_entry_resource_plan_allocated_competency` DROP is_confirmed;

-- //@UNDO
-- SQL to undo the change goes here.

ALTER TABLE portfolio_entry_resource_plan_allocated_actor ADD COLUMN is_confirmed TINYINT(1) NOT NULL AFTER last_update;
ALTER TABLE portfolio_entry_resource_plan_allocated_org_unit ADD COLUMN is_confirmed TINYINT(1) NOT NULL AFTER last_update;
ALTER TABLE portfolio_entry_resource_plan_allocated_competency ADD COLUMN is_confirmed TINYINT(1) NOT NULL AFTER last_update;

UPDATE portfolio_entry_resource_plan_allocated_actor SET is_confirmed =
IF((select status from portfolio_entry_resource_plan_allocation_status_type where id = portfolio_entry_resource_plan_allocation_status_type_id) = 'CONFIRMED', 1, 0);

UPDATE portfolio_entry_resource_plan_allocated_org_unit SET is_confirmed =
IF((select status from portfolio_entry_resource_plan_allocation_status_type where id = portfolio_entry_resource_plan_allocation_status_type_id) = 'CONFIRMED', 1, 0);

UPDATE portfolio_entry_resource_plan_allocated_competency SET is_confirmed =
IF((select status from portfolio_entry_resource_plan_allocation_status_type where id = portfolio_entry_resource_plan_allocation_status_type_id) = 'CONFIRMED', 1, 0);

ALTER TABLE portfolio_entry_resource_plan_allocated_org_unit
DROP FOREIGN KEY fk_perpaou_has_perpast,
DROP FOREIGN KEY perpaou_actor_fk;
ALTER TABLE portfolio_entry_resource_plan_allocated_actor
DROP FOREIGN KEY fk_perpaa_has_perpast,
DROP FOREIGN KEY perpaa_actor_fk;
ALTER TABLE portfolio_entry_resource_plan_allocated_competency
DROP FOREIGN KEY fk_perpac_has_perpast,
DROP FOREIGN KEY perpac_actor_fk;
DROP INDEX fk_perpaou_has_perpast_idx ON portfolio_entry_resource_plan_allocated_org_unit;
DROP INDEX fk_perpaa_has_perpast_idx ON portfolio_entry_resource_plan_allocated_actor;
DROP INDEX fk_perpac_has_perpast_idx ON portfolio_entry_resource_plan_allocated_competency;
DROP INDEX perpaou_actor_idx ON portfolio_entry_resource_plan_allocated_org_unit;
DROP INDEX perpaa_actor_idx ON portfolio_entry_resource_plan_allocated_actor;
DROP INDEX perpac_actor_idx ON portfolio_entry_resource_plan_allocated_competency;
ALTER TABLE portfolio_entry_resource_plan_allocated_org_unit
DROP portfolio_entry_resource_plan_allocation_status_type_id,
DROP last_status_type_update_time,
DROP last_status_type_update_actor_id;
ALTER TABLE portfolio_entry_resource_plan_allocated_actor
DROP portfolio_entry_resource_plan_allocation_status_type_id,
DROP last_status_type_update_time,
DROP last_status_type_update_actor_id;
ALTER TABLE portfolio_entry_resource_plan_allocated_competency
DROP portfolio_entry_resource_plan_allocation_status_type_id,
DROP last_status_type_update_time,
DROP last_status_type_update_actor_id;

DROP TABLE `portfolio_entry_resource_plan_allocation_status_type`;