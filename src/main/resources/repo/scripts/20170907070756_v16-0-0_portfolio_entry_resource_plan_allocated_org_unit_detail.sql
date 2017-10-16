-- // v16-0-0_portfolio_entry_resource_plan_allocated_org_unit_detail
-- Migration SQL that makes the change goes here.

ALTER TABLE `portfolio_entry_resource_plan_allocated_org_unit` ADD COLUMN `monthly_allocated` TINYINT(1) DEFAULT 0;

CREATE TABLE `portfolio_entry_resource_plan_allocated_org_unit_detail` (
  `id`                                                  BIGINT(20) NOT NULL AUTO_INCREMENT,
  `portfolio_entry_resource_plan_allocated_org_unit_id` BIGINT(20) NOT NULL,
  `year`                                                YEAR(4),
  `month`                                               INT(11),
  `days`                                                DECIMAL(12, 2),
  `last_update`                                         DATETIME,
  `deleted`                                             TINYINT(1),
  PRIMARY KEY (`id`),
  KEY `perpaoud_perpaou_idx` (`portfolio_entry_resource_plan_allocated_org_unit_id`),
  CONSTRAINT `perpaoud_perpaou_fk` FOREIGN KEY (`portfolio_entry_resource_plan_allocated_org_unit_id`) REFERENCES `portfolio_entry_resource_plan_allocated_org_unit` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
);

ALTER TABLE `timesheet_activity_allocated_actor` ADD COLUMN `monthly_allocated` TINYINT(1) DEFAULT 0;

CREATE TABLE `timesheet_activity_allocated_actor_detail` (
  `id`                                      BIGINT(20) NOT NULL AUTO_INCREMENT,
  `timesheet_activity_allocated_actor_id`   BIGINT(20) NOT NULL,
  `year`                                    YEAR(4),
  `month`                                   INT(11),
  `days`                                    DECIMAL(12, 2),
  `last_update`                             DATETIME,
  `deleted`                                 TINYINT(1),
  PRIMARY KEY (`id`),
  KEY `taaad_taaa_idx` (`timesheet_activity_allocated_actor_id`),
  CONSTRAINT `taaad_taaa_fk` FOREIGN KEY (`timesheet_activity_allocated_actor_id`) REFERENCES `timesheet_activity_allocated_actor` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
);

-- //@UNDO
-- SQL to undo the change goes here.

DROP TABLE `portfolio_entry_resource_plan_allocated_org_unit_detail`;

ALTER TABLE `portfolio_entry_resource_plan_allocated_org_unit` DROP COLUMN `monthly_allocated`;

DROP TABLE `timesheet_activity_allocated_actor_detail`;

ALTER TABLE `timesheet_activity_allocated_actor` DROP COLUMN `monthly_allocated`;