--add default competency for an actor

ALTER TABLE `actor` ADD COLUMN `default_competency_id` BIGINT(20) NULL DEFAULT NULL  AFTER `is_active` , 
  ADD CONSTRAINT `fk_actor_1`
  FOREIGN KEY (`default_competency_id` )
  REFERENCES `competency` (`id` )
  ON DELETE NO ACTION
  ON UPDATE NO ACTION
, ADD INDEX `fk_actor_1_idx` (`default_competency_id` ASC) ;

--//@UNDO

ALTER TABLE `actor` DROP FOREIGN KEY `fk_actor_1` ;
ALTER TABLE `actor` DROP COLUMN `default_competency_id` 
, DROP INDEX `fk_actor_1_idx` ;

