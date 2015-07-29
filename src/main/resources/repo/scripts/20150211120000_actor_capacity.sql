--actor capacity table

CREATE TABLE `actor_capacity` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `last_update` datetime NOT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `actor_id` bigint(20) NOT NULL,
  `year` year(4) NOT NULL,
  `month` int(11) NOT NULL,
  `value` decimal(12,2) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_actor_capacity_1_idx` (`actor_id`),
  CONSTRAINT `fk_actor_capacity_1` FOREIGN KEY (`actor_id`) REFERENCES `actor` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
);


--//@UNDO

drop table `actor_capacity`;


