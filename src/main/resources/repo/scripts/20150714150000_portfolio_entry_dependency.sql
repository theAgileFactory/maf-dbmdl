--dependency table

CREATE TABLE `portfolio_entry_dependency` (
  `source_portfolio_entry_id` bigint(20) NOT NULL,
  `destination_portfolio_entry_id` bigint(20) NOT NULL,
  `portfolio_entry_dependency_type_id` bigint(20) NOT NULL,
  PRIMARY KEY (`source_portfolio_entry_id`,`destination_portfolio_entry_id`,`portfolio_entry_dependency_type_id`),
  KEY `fk_portfolio_entry_dependency_1_idx` (`source_portfolio_entry_id`),
  KEY `fk_portfolio_entry_dependency_2_idx` (`destination_portfolio_entry_id`),
  KEY `fk_portfolio_entry_dependency_3_idx` (`portfolio_entry_dependency_type_id`),
  CONSTRAINT `fk_portfolio_entry_dependency_3` FOREIGN KEY (`portfolio_entry_dependency_type_id`) REFERENCES `portfolio_entry_dependency_type` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_portfolio_entry_dependency_1` FOREIGN KEY (`source_portfolio_entry_id`) REFERENCES `portfolio_entry` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_portfolio_entry_dependency_2` FOREIGN KEY (`destination_portfolio_entry_id`) REFERENCES `portfolio_entry` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
);

--//@UNDO

drop table `portfolio_entry_dependency`;





