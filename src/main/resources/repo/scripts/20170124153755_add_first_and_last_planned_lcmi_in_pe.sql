-- // add first and last planned lcmi in pe
-- Migration SQL that makes the change goes here.

ALTER TABLE `portfolio_entry`
ADD COLUMN `start_date` DATE
AFTER `last_portfolio_entry_report_id`;

ALTER TABLE `portfolio_entry`
ADD COLUMN `end_date` DATE
AFTER `start_date`;



-- //@UNDO
-- SQL to undo the change goes here.

ALTER TABLE `portfolio_entry` DROP COLUMN `first_planned_lifecycle_milestone_instance_id`;
ALTER TABLE `portfolio_entry` DROP COLUMN `last_planned_lifecycle_milestone_instance_id`;


