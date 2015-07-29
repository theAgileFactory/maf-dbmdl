--Role name should be not unique

ALTER TABLE `system_level_role_type` DROP INDEX `name_UNIQUE` ;

--//@UNDO

ALTER TABLE `system_level_role_type` ADD UNIQUE INDEX `name_UNIQUE` (`name` ASC) ;






