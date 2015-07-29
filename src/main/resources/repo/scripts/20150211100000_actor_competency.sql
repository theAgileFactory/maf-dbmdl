--actor has competency table

CREATE TABLE `actor_has_competency` (
  `actor_id` bigint(20) NOT NULL,
  `competency_id` bigint(20) NOT NULL,
  PRIMARY KEY (`actor_id`,`competency_id`),
  KEY `fk_actor_has_competency_1_idx` (`actor_id`),
  KEY `fk_actor_has_competency_2_idx` (`competency_id`),
  CONSTRAINT `fk_actor_has_competency_1` FOREIGN KEY (`actor_id`) REFERENCES `actor` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_actor_has_competency_2` FOREIGN KEY (`competency_id`) REFERENCES `competency` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
);

--//@UNDO

drop table `actor_has_competency`;

