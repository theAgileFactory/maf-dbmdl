--add approver for a milestone instance

ALTER TABLE `life_cycle_milestone_instance` ADD COLUMN `approver_id` BIGINT(20) NULL DEFAULT NULL  AFTER `portfolio_entry_resource_plan_id` , 
  ADD CONSTRAINT `fk_life_cycle_milestone_instance_1`
  FOREIGN KEY (`approver_id` )
  REFERENCES `actor` (`id` )
  ON DELETE NO ACTION
  ON UPDATE NO ACTION
, ADD INDEX `fk_life_cycle_milestone_instance_1_idx` (`approver_id` ASC) ;

--//@UNDO

ALTER TABLE `life_cycle_milestone_instance` DROP FOREIGN KEY `fk_life_cycle_milestone_instance_1` ;
ALTER TABLE `life_cycle_milestone_instance` DROP COLUMN `approver_id` 
, DROP INDEX `fk_life_cycle_milestone_instance_1_idx` ;
