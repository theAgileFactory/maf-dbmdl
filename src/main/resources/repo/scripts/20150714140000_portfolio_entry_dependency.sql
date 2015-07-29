--dependency type table

CREATE TABLE `portfolio_entry_dependency_type` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `deleted` tinyint(1) DEFAULT '0',
  `last_update` datetime NOT NULL,
  `name` varchar(256) NOT NULL,
  `contrary` varchar(256) NOT NULL,
  `description` varchar(1500) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
);

--//@UNDO

drop table `portfolio_entry_dependency_type`;





