--allocated competency table

CREATE TABLE `portfolio_entry_resource_plan_allocated_competency` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `days` decimal(12,2) NOT NULL,
  `portfolio_entry_resource_plan_id` bigint(20) NOT NULL,
  `competency_id` bigint(20) NOT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `start_date` datetime DEFAULT NULL,
  `end_date` datetime DEFAULT NULL,
  `last_update` datetime NOT NULL,
  `portfolio_entry_planning_package_id` bigint(20) DEFAULT NULL,
  `is_confirmed` tinyint(1) DEFAULT '0',
  `follow_package_dates` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_entry_resource_plan_allocated_competency_idx1` (`portfolio_entry_resource_plan_id`),
  KEY `fk_entry_resource_plan_allocated_competency_idx2` (`competency_id`),
  KEY `fk_entry_resource_plan_allocated_competency_idx3` (`portfolio_entry_planning_package_id`),
  CONSTRAINT `fk_entry_resource_plan_allocated_competency_fk1` FOREIGN KEY (`portfolio_entry_resource_plan_id`) REFERENCES `portfolio_entry_resource_plan` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_entry_resource_plan_allocated_competency_fk2` FOREIGN KEY (`competency_id`) REFERENCES `competency` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_entry_resource_plan_allocated_competency_fk3` FOREIGN KEY (`portfolio_entry_planning_package_id`) REFERENCES `portfolio_entry_planning_package` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
);

--//@UNDO

drop table `portfolio_entry_resource_plan_allocated_competency`;
