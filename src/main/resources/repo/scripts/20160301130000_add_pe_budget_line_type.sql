--pe_entry_budget_line_type

CREATE TABLE `portfolio_entry_budget_line_type` (
  `id` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `deleted` TINYINT(1) NOT NULL,
  `selectable` TINYINT(1) NOT NULL,
  `last_update` TIMESTAMP NOT NULL,
  `name` VARCHAR(64),
  `description` VARCHAR(1500),
  `ref_id` VARCHAR(64),
  PRIMARY KEY(`id`)
);

ALTER TABLE `portfolio_entry_budget_line`
ADD COLUMN `portfolio_entry_budget_line_type_id` BIGINT(20) NULL DEFAULT NULL AFTER currency_rate,
ADD CONSTRAINT `fk_portfolio_entry_budget_line_type_id`
  FOREIGN KEY (`portfolio_entry_budget_line_type_id` )
  REFERENCES `portfolio_entry_budget_line_type` (`id` )
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

--//@UNDO
