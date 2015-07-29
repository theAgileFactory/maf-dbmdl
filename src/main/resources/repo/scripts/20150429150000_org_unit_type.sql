--org unit type

ALTER TABLE `org_unit_type` ADD COLUMN `ref_id` VARCHAR(64) NULL DEFAULT NULL  AFTER `last_update` ;

--//@UNDO

ALTER TABLE `org_unit_type` DROP COLUMN `ref_id` ;

