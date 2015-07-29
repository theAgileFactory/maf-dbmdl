--alter work order

ALTER TABLE `work_order` ADD COLUMN `portfolio_entry_planning_package_id` BIGINT(20) NULL DEFAULT NULL  AFTER `is_engaged` , ADD COLUMN `start_date` DATETIME NULL  AFTER `portfolio_entry_planning_package_id` ;

ALTER TABLE `work_order` 
  ADD CONSTRAINT `fk_work_order_2`
  FOREIGN KEY (`portfolio_entry_planning_package_id` )
  REFERENCES `portfolio_entry_planning_package` (`id` )
  ON DELETE NO ACTION
  ON UPDATE NO ACTION
, ADD INDEX `fk_work_order_2_idx` (`portfolio_entry_planning_package_id` ASC) ;

ALTER TABLE `work_order` ADD COLUMN `follow_package_dates` TINYINT(1) NULL DEFAULT NULL  AFTER `start_date` ;


--//@UNDO

ALTER TABLE `work_order` DROP COLUMN `follow_package_dates` ;

ALTER TABLE `work_order` DROP FOREIGN KEY `fk_work_order_2` ;
ALTER TABLE `work_order` DROP COLUMN `start_date` , DROP COLUMN `portfolio_entry_planning_package_id` 
, DROP INDEX `fk_work_order_2_idx` ;

