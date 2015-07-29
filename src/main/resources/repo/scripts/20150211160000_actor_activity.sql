--timesheet activity allocated actor table

CREATE TABLE `timesheet_activity_allocated_actor` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `last_update` datetime NOT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `timesheet_activity_id` bigint(20) NOT NULL,
  `actor_id` bigint(20) NOT NULL,
  `days` decimal(12,2) NOT NULL,
  `start_date` datetime DEFAULT NULL,
  `end_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_activity_allocated_actor_1_idx` (`timesheet_activity_id`),
  KEY `fk_activity_allocated_actor_2_idx` (`actor_id`),
  CONSTRAINT `fk_activity_allocated_actor_1` FOREIGN KEY (`timesheet_activity_id`) REFERENCES `timesheet_activity` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_activity_allocated_actor_2` FOREIGN KEY (`actor_id`) REFERENCES `actor` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
);

--//@UNDO

drop table `timesheet_activity_allocated_actor`;

