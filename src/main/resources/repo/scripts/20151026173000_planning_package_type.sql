
CREATE TABLE `portfolio_entry_planning_package_type` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `last_update` datetime NOT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `name` varchar(64) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `css_class` varchar(64) NOT NULL,
  PRIMARY KEY (`id`)
);

ALTER TABLE `portfolio_entry_planning_package` ADD COLUMN `portfolio_entry_planning_package_type_id` BIGINT(20) NULL  AFTER `status` , 
  ADD CONSTRAINT `fk_portfolio_entry_planning_package_3`
  FOREIGN KEY (`portfolio_entry_planning_package_type_id` )
  REFERENCES `portfolio_entry_planning_package_type` (`id` )
  ON DELETE NO ACTION
  ON UPDATE NO ACTION
, ADD INDEX `fk_portfolio_entry_planning_package_3_idx` (`portfolio_entry_planning_package_type_id` ASC) ;


ALTER TABLE `portfolio_entry_planning_package_pattern` ADD COLUMN `portfolio_entry_planning_package_type_id` BIGINT(20) NULL DEFAULT NULL  AFTER `portfolio_entry_planning_package_group_id` , 
  ADD CONSTRAINT `fk_portfolio_entry_planning_package_pattern_2`
  FOREIGN KEY (`portfolio_entry_planning_package_type_id` )
  REFERENCES `portfolio_entry_planning_package_type` (`id` )
  ON DELETE NO ACTION
  ON UPDATE NO ACTION
, ADD INDEX `fk_portfolio_entry_planning_package_pattern_2_idx` (`portfolio_entry_planning_package_type_id` ASC) ;


--//@UNDO

ALTER TABLE `portfolio_entry_planning_package_pattern` DROP FOREIGN KEY `fk_portfolio_entry_planning_package_pattern_2` ;
ALTER TABLE `portfolio_entry_planning_package_pattern` DROP COLUMN `portfolio_entry_planning_package_type_id` 
, DROP INDEX `fk_portfolio_entry_planning_package_pattern_2_idx` ;

ALTER TABLE `portfolio_entry_planning_package` DROP FOREIGN KEY `fk_portfolio_entry_planning_package_3` ;
ALTER TABLE `portfolio_entry_planning_package` DROP COLUMN `portfolio_entry_planning_package_type_id` 
, DROP INDEX `fk_portfolio_entry_planning_package_3_idx` ;

drop table `portfolio_entry_planning_package_type`;





