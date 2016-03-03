ALTER TABLE `work_order`
ADD COLUMN `portfolio_entry_budget_line_id` BIGINT(20) NULL DEFAULT NULL AFTER `purchase_order_line_item_id`,
ADD CONSTRAINT `fk_portfolio_entry_budget_line_id`
  FOREIGN KEY (`portfolio_entry_budget_line_id` )
  REFERENCES `portfolio_entry_budget_line` (`id` )
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;
