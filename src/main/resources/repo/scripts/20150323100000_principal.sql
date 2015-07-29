--delete principal should delete associated objects

ALTER TABLE `principal_reporting_authorization` DROP FOREIGN KEY `fk_actor_reporting_authorization_actor` ;
ALTER TABLE `principal_reporting_authorization` 
  ADD CONSTRAINT `fk_actor_reporting_authorization_actor`
  FOREIGN KEY (`principal_id` )
  REFERENCES `principal` (`id` )
  ON DELETE CASCADE
  ON UPDATE CASCADE;


--//@UNDO

ALTER TABLE `principal_reporting_authorization` DROP FOREIGN KEY `fk_actor_reporting_authorization_actor` ;
ALTER TABLE `principal_reporting_authorization` 
  ADD CONSTRAINT `fk_actor_reporting_authorization_actor`
  FOREIGN KEY (`principal_id` )
  REFERENCES `principal` (`id` )
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;









