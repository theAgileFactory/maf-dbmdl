--Budget tracking

INSERT INTO `purchase_order` (`ref_id`, `deleted`, `is_cancelled`, `last_update`) VALUES ('_PO_BUDGET_TRACKING', '0', '0', NOW());

ALTER TABLE `portfolio_entry` ADD COLUMN `budget_tracking_last_run` DATETIME NULL DEFAULT NULL  AFTER `default_is_opex` , ADD COLUMN `budget_tracking_has_unallocated_timesheet` TINYINT(1) NOT NULL DEFAULT 0  AFTER `budget_tracking_last_run` ;


--//@UNDO

ALTER TABLE `portfolio_entry` DROP COLUMN `budget_tracking_has_unallocated_timesheet` , DROP COLUMN `budget_tracking_last_run` ;




