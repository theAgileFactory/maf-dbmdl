--Data syndication

INSERT INTO `system_permission` (`name`,`description`,`deleted`,`selectable`,`last_update`) VALUES ('PARTNER_SYNDICATION_PERMISSION','permission.partner_syndication_permission.description',0,1,NOW());

ALTER TABLE `portfolio_entry` ADD COLUMN `is_syndicated` TINYINT(1) NOT NULL DEFAULT 0  AFTER `last_portfolio_entry_report_id` ;


--//@UNDO

DELETE FROM `system_permission` WHERE `name`='PARTNER_SYNDICATION_PERMISSION';

ALTER TABLE `portfolio_entry` DROP COLUMN `is_syndicated` ;


