--currencies

ALTER TABLE `currency` 
CHANGE COLUMN `conversion_rate` `conversion_rate` DECIMAL(18,8) NOT NULL ;
UPDATE `currency` SET `conversion_rate` = "1";

ALTER TABLE `budget_bucket_line` 
ADD COLUMN `currency_rate` DECIMAL(18,8) NOT NULL DEFAULT 1 AFTER `budget_bucket_id`;

ALTER TABLE `goods_receipt` 
ADD COLUMN `currency_code` VARCHAR(3) NULL AFTER `last_update`,
ADD COLUMN `currency_rate` DECIMAL(18,8) NOT NULL DEFAULT 1 AFTER `currency_code`;
UPDATE `goods_receipt` SET `currency_code` = (SELECT `code` FROM `currency` WHERE `is_default` = 1 LIMIT 1);
ALTER TABLE `goods_receipt` 
CHANGE COLUMN `currency_code` `currency_code` VARCHAR(3) CHARACTER SET 'latin1' NOT NULL ,
ADD INDEX `fk_goods_receipt_1_idx` (`currency_code` ASC);
ALTER TABLE `goods_receipt` 
ADD CONSTRAINT `fk_goods_receipt_1`
  FOREIGN KEY (`currency_code`)
  REFERENCES `currency` (`code`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

ALTER TABLE `portfolio_entry_budget_line` 
ADD COLUMN `currency_rate` DECIMAL(18,8) NOT NULL DEFAULT 1 AFTER `resource_object_id`;

ALTER TABLE `portfolio_entry_resource_plan_allocated_actor` 
ADD COLUMN `currency_code` VARCHAR(3) NULL AFTER `forecast_days`,
ADD COLUMN `currency_rate` DECIMAL(18,8) NOT NULL DEFAULT 1 AFTER `currency_code`,
ADD COLUMN `forecast_daily_rate` DECIMAL(12,2) NULL AFTER `currency_rate`,
CHANGE COLUMN `forecast_days` `forecast_days` DECIMAL(12,2) NULL ;
UPDATE `portfolio_entry_resource_plan_allocated_actor` SET `currency_code` = (SELECT `code` FROM `currency` WHERE `is_default` = 1 LIMIT 1);
ALTER TABLE `portfolio_entry_resource_plan_allocated_actor` 
CHANGE COLUMN `currency_code` `currency_code` VARCHAR(3) CHARACTER SET 'latin1' NOT NULL ,
ADD INDEX `fk_portfolio_entry_resource_plan_allocated_actor_2_idx` (`currency_code` ASC);
ALTER TABLE `portfolio_entry_resource_plan_allocated_actor` 
ADD CONSTRAINT `fk_portfolio_entry_resource_plan_allocated_actor_2`
  FOREIGN KEY (`currency_code`)
  REFERENCES `currency` (`code`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

ALTER TABLE `portfolio_entry_resource_plan_allocated_org_unit` 
CHANGE COLUMN `forecast_days` `forecast_days` DECIMAL(12,2) NULL ,
ADD COLUMN `currency_code` VARCHAR(3) NULL AFTER `forecast_days`,
ADD COLUMN `currency_rate` DECIMAL(18,8) NOT NULL DEFAULT 1 AFTER `currency_code`,
ADD COLUMN `forecast_daily_rate` DECIMAL(12,2) NULL AFTER `currency_rate`;
UPDATE `portfolio_entry_resource_plan_allocated_org_unit` SET `currency_code` = (SELECT `code` FROM `currency` WHERE `is_default` = 1 LIMIT 1);
ALTER TABLE `portfolio_entry_resource_plan_allocated_org_unit` 
CHANGE COLUMN `currency_code` `currency_code` VARCHAR(3) CHARACTER SET 'latin1' NOT NULL ,
ADD INDEX `fk_portfolio_entry_resource_plan_allocated_org_unit_2_idx` (`currency_code` ASC);
ALTER TABLE `portfolio_entry_resource_plan_allocated_org_unit` 
ADD CONSTRAINT `fk_portfolio_entry_resource_plan_allocated_org_unit_2`
  FOREIGN KEY (`currency_code`)
  REFERENCES `currency` (`code`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;


ALTER TABLE `portfolio_entry_resource_plan_allocated_competency` 
DROP COLUMN `forecast_days`,
ADD COLUMN `currency_code` VARCHAR(3) NULL AFTER `daily_rate`,
ADD COLUMN `currency_rate` DECIMAL(18,8) NOT NULL DEFAULT 1 AFTER `currency_code`;
UPDATE `portfolio_entry_resource_plan_allocated_competency` SET `currency_code` = (SELECT `code` FROM `currency` WHERE `is_default` = 1 LIMIT 1);
ALTER TABLE `portfolio_entry_resource_plan_allocated_competency` 
CHANGE COLUMN `currency_code` `currency_code` VARCHAR(3) CHARACTER SET 'latin1' NOT NULL,
ADD INDEX `fk_portfolio_entry_resource_plan_allocated_competency_2_idx` (`currency_code` ASC);
ALTER TABLE `portfolio_entry_resource_plan_allocated_competency` 
ADD CONSTRAINT `fk_portfolio_entry_resource_plan_allocated_competency_2`
  FOREIGN KEY (`currency_code`)
  REFERENCES `currency` (`code`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

ALTER TABLE `purchase_order_line_item` 
DROP FOREIGN KEY `fk_purchase_order_line_item_1`;
ALTER TABLE `purchase_order_line_item` 
CHANGE COLUMN `currency_code` `currency_code` VARCHAR(3) CHARACTER SET 'latin1' NOT NULL ,
ADD COLUMN `currency_rate` DECIMAL(18,8) NOT NULL DEFAULT 1 AFTER `is_cancelled`;
ALTER TABLE `purchase_order_line_item` 
ADD CONSTRAINT `fk_purchase_order_line_item_1`
  FOREIGN KEY (`currency_code`)
  REFERENCES `currency` (`code`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

ALTER TABLE `work_order` 
DROP FOREIGN KEY `fk_work_order_1`;
ALTER TABLE `work_order` 
CHANGE COLUMN `currency_code` `currency_code` VARCHAR(3) CHARACTER SET 'latin1' NOT NULL ,
ADD COLUMN `currency_rate` DECIMAL(18,8) NOT NULL DEFAULT 1 AFTER `resource_object_id`;
ALTER TABLE `work_order` 
ADD CONSTRAINT `fk_work_order_1`
  FOREIGN KEY (`currency_code`)
  REFERENCES `currency` (`code`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

--//@UNDO

