-- // v15-0-0_portfolio_entry_resource_plan_allocated_actor_details
-- Migration SQL that makes the change goes here.

CREATE TABLE `portfolio_entry_resource_plan_allocated_actor_detail` (
  `id`                                               BIGINT(20) NOT NULL AUTO_INCREMENT,
  `portfolio_entry_resource_plan_allocated_actor_id` BIGINT(20) NOT NULL,
  `year`                                             YEAR(4),
  `month`                                            INT(11),
  `days`                                             DECIMAL(12, 2),
  `last_update`                                      DATETIME,
  `deleted`                                          TINYINT(1),
  PRIMARY KEY (`id`),
  KEY `fk_entry_portfolio_entry_resource_plan_allocated_actor_id` (`portfolio_entry_resource_plan_allocated_actor_id`),
  CONSTRAINT `fk_portfolio_entry_resource_plan_allocated_actor_fk` FOREIGN KEY (`portfolio_entry_resource_plan_allocated_actor_id`) REFERENCES `portfolio_entry_resource_plan_allocated_actor` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
);

-- //@UNDO
-- SQL to undo the change goes here.

DROP TABLE `portfolio_entry_resource_plan_allocated_actor_detail`;
