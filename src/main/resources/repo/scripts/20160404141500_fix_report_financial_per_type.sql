CREATE OR REPLACE VIEW `v_pe_budget_per_type` AS (select
	`pe`.`id` AS `pe_id`,
	`pebl`.`currency_code` AS `currency_code`,
	`pebl`.`is_opex` AS `is_opex`,
	`peblt`.`id` AS `peblt_id`,
	sum((`pebl`.`amount` * `pebl`.`currency_rate`)) AS `budget`
from ((((`portfolio_entry_budget_line` `pebl`
	join `portfolio_entry_budget` `peb` on((`pebl`.`portfolio_entry_budget_id` = `peb`.`id`)))
	join `life_cycle_instance_planning` `lcip` on((`peb`.`id` = `lcip`.`portfolio_entry_budget_id`)))
	join `portfolio_entry` `pe` on((`lcip`.`life_cycle_instance_id` = `pe`.`active_life_cycle_instance_id`)))
	left outer join `portfolio_entry_budget_line_type` `peblt` on((`peblt`.`id` = `pebl`.`portfolio_entry_budget_line_type_id`)))
where ((`pebl`.`deleted` = 0) and (`peb`.`deleted` = 0) and (`lcip`.`deleted` = 0) and (`lcip`.`is_frozen` = 0))
group by `pe`.`id`,`pebl`.`currency_code`,`pebl`.`is_opex`,`peblt`.`id`);

CREATE OR REPLACE VIEW `v_pe_cost_to_complete_rows_per_type` AS (select 
	`pe`.`id` AS `id`,
	`wo`.`currency_code` AS `currency_code`,
	`wo`.`is_opex` AS `is_opex`,
	`peblt`.`id` AS `peblt_id`,
	sum(`wo`.`amount` * `wo`.`currency_rate`) AS `cost_to_complete`,
	1 AS `use_purchase_order`
from (
	`work_order` `wo`
	join `portfolio_entry` `pe` on((`wo`.`portfolio_entry_id` = `pe`.`id`))
	left outer join `portfolio_entry_budget_line` `pebl` on ((`wo`.`portfolio_entry_budget_line_id` = `pebl`.`id`))
	left outer join `portfolio_entry_budget_line_type` `peblt` on ((`pebl`.`portfolio_entry_budget_line_type_id` = `peblt`.`id`)))
where (
	isnull(`wo`.`purchase_order_line_item_id`) and (`wo`.`deleted` = 0))
group by
	`pe`.`id`,`wo`.`currency_code`,`wo`.`is_opex`,`peblt`.`id`)

union

(select
	`pe`.`id` AS `id`,
	`wo`.`currency_code` AS `currency_code`,
	`wo`.`is_opex` AS `is_opex`,
	`peblt`.`id` AS `peblt_id`,
	sum(`wo`.`amount` * `wo`.`currency_rate`) AS `cost_to_complete`,
	1 AS `use_purchase_order`
from (
(`work_order` `wo`
	join `portfolio_entry` `pe` on((`wo`.`portfolio_entry_id` = `pe`.`id`)))
	join `purchase_order_line_item` `poli` on((`wo`.`purchase_order_line_item_id` = `poli`.`id`))
	left outer join `portfolio_entry_budget_line` `pebl` on ((`wo`.`portfolio_entry_budget_line_id` = `pebl`.`id`))
	left outer join `portfolio_entry_budget_line_type` `peblt` on ((`pebl`.`portfolio_entry_budget_line_type_id` = `peblt`.`id`)))
where (((`poli`.`deleted` = 1) or (`poli`.`is_cancelled` = 1)) and (`wo`.`deleted` = 0))
group by `pe`.`id`,`wo`.`currency_code`,`wo`.`is_opex`,`peblt`.`id`)

union

(select
	`pe`.`id` AS `id`,
	`wo`.`currency_code` AS `currency_code`,
	`wo`.`is_opex` AS `is_opex`,
	`peblt`.`id` AS `peblt_id`,
	sum(`wo`.`amount` * `wo`.`currency_rate`) AS `cost_to_complete`,
	0 AS `use_purchase_order`
from (
	`work_order` `wo` 
	join `portfolio_entry` `pe` on((`wo`.`portfolio_entry_id` = `pe`.`id`))
	left outer join `portfolio_entry_budget_line` `pebl` on ((`wo`.`portfolio_entry_budget_line_id` = `pebl`.`id`))
	left outer join `portfolio_entry_budget_line_type` `peblt` on ((`pebl`.`portfolio_entry_budget_line_type_id` = `peblt`.`id`)))
where ((`wo`.`is_engaged` = 0) and (`wo`.`deleted` = 0))
group by `pe`.`id`,`wo`.`currency_code`,`wo`.`is_opex`,`peblt`.`id`);


CREATE OR REPLACE VIEW `v_pe_cost_to_complete_per_type` AS (
select
	`v_pe_cost_to_complete_rows_per_type`.`id` AS `id`,
	`v_pe_cost_to_complete_rows_per_type`.`currency_code` AS `currency_code`,
	`v_pe_cost_to_complete_rows_per_type`.`is_opex` AS `is_opex`,
	`v_pe_cost_to_complete_rows_per_type`.`peblt_id` AS `peblt_id`,
	sum(`v_pe_cost_to_complete_rows_per_type`.`cost_to_complete`) AS `cost_to_complete`,
	`v_pe_cost_to_complete_rows_per_type`.`use_purchase_order` AS `use_purchase_order`
from `v_pe_cost_to_complete_rows_per_type`
group by `v_pe_cost_to_complete_rows_per_type`.`id`,`v_pe_cost_to_complete_rows_per_type`.`currency_code`,`v_pe_cost_to_complete_rows_per_type`.`is_opex`,`v_pe_cost_to_complete_rows_per_type`.`use_purchase_order`,`v_pe_cost_to_complete_rows_per_type`.`peblt_id`);

CREATE OR REPLACE VIEW `v_pe_engaged_rows_per_type` AS (
select 
	`pe`.`id` AS `id`,
	`wo`.`currency_code` AS `currency_code`,
	`wo`.`is_opex` AS `is_opex`,
	`peblt`.`id` AS `peblt_id`,
	sum(`wo`.`amount` * `wo`.`currency_rate`) AS `engaged`,
	1 AS `use_purchase_order`
from (
	(`work_order` `wo`
	join `portfolio_entry` `pe` on((`wo`.`portfolio_entry_id` = `pe`.`id`)))
	join `purchase_order_line_item` `poli` on((`wo`.`purchase_order_line_item_id` = `poli`.`id`))
	left outer join `portfolio_entry_budget_line` `pebl` on ((`wo`.`portfolio_entry_budget_line_id` = `pebl`.`id`))
	left outer join `portfolio_entry_budget_line_type` `peblt` on ((`pebl`.`portfolio_entry_budget_line_type_id` = `peblt`.`id`)))
where ((`poli`.`deleted` = 0) and (`poli`.`is_cancelled` = 0) and (`wo`.`deleted` = 0))
group by `pe`.`id`,`wo`.`currency_code`,`wo`.`is_opex`,`peblt`.`id`)

union 

(select 
	`pe`.`id` AS `id`,
	`poli`.`currency_code` AS `currency_code`,
	`poli`.`is_opex` AS `is_opex`,
	`peblt`.`id` AS `peblt_id`,
	sum(`poli`.`amount` * `poli`.`currency_rate`) AS `engaged`,
	1 AS `use_purchase_order`
from (((`purchase_order_line_item` `poli`
	join `purchase_order` `po` on((`poli`.`purchase_order_id` = `po`.`id`)))
	join `portfolio_entry` `pe` on((`po`.`portfolio_entry_id` = `pe`.`id`))
	left join `work_order` `wo` on((`poli`.`id` = `wo`.`purchase_order_line_item_id`)))
	left outer join `portfolio_entry_budget_line` `pebl` on ((`wo`.`portfolio_entry_budget_line_id` = `pebl`.`id`))
	left outer join `portfolio_entry_budget_line_type` `peblt` on ((`pebl`.`portfolio_entry_budget_line_type_id` = `peblt`.`id`)))
where ((`poli`.`deleted` = 0) and (`poli`.`is_cancelled` = 0) and (`po`.`deleted` = 0) and (`po`.`is_cancelled` = 0) and isnull(`wo`.`purchase_order_line_item_id`))
group by `pe`.`id`,`poli`.`currency_code`,`poli`.`is_opex`,`peblt`.`id`)

union

(select
	`pe`.`id` AS `id`,
	`wo`.`currency_code` AS `currency_code`,
	`wo`.`is_opex` AS `is_opex`,
	`peblt`.`id` AS `peblt_id`,
	sum(`wo`.`amount` * `wo`.`currency_rate`) AS `engaged`,
	0 AS `use_purchase_order`
from (`work_order` `wo` join `portfolio_entry` `pe` on((`wo`.`portfolio_entry_id` = `pe`.`id`))
	left outer join `portfolio_entry_budget_line` `pebl` on ((`wo`.`portfolio_entry_budget_line_id` = `pebl`.`id`))
	left outer join `portfolio_entry_budget_line_type` `peblt` on ((`pebl`.`portfolio_entry_budget_line_type_id` = `peblt`.`id`)))
where ((`wo`.`is_engaged` = 1) and (`wo`.`deleted` = 0))
group by `pe`.`id`,`wo`.`currency_code`,`wo`.`is_opex`,`peblt`.`id`);

CREATE OR REPLACE VIEW `v_pe_engaged_per_type` AS (
select
	`t`.`id` AS `id`,
	`t`.`currency_code` AS `currency_code`,
	`t`.`is_opex` AS `is_opex`,
	`t`.`peblt_id` AS `peblt_id`,
	sum(`t`.`engaged`) AS `engaged`,
	`t`.`use_purchase_order` AS `use_purchase_order`
from `v_pe_engaged_rows_per_type` `t`
group by `t`.`id`,`t`.`currency_code`,`t`.`is_opex`,`t`.`use_purchase_order`, `t`.`peblt_id`);

CREATE OR REPLACE VIEW `v_pe_financial_per_type` AS (select 
	`pe`.`id` AS `id`,
	`c`.`code` AS `currency_code`,
	`upo`.`flag` AS `use_purchase_order`,
	`peblt`.`name` AS `peblt_name`,
	`peblt`.`id` AS `peblt_id`,
	ifnull(
		(select sum(`peb`.`budget`) from `v_pe_budget_per_type` `peb` 
			where ((`peb`.`currency_code` = `c`.`code`) and (`peb`.`is_opex` = 0) and (`peb`.`pe_id` = `pe`.`id`) and (`peb`.`peblt_id` = `peblt`.`id`))),
		0) AS `capex_budget`,
	ifnull(
		(select sum(`peb`.`budget`) from `v_pe_budget_per_type` `peb` 
			where ((`peb`.`currency_code` = `c`.`code`) and (`peb`.`is_opex` = 1) and (`peb`.`pe_id` = `pe`.`id`) and (`peb`.`peblt_id` = `peblt`.`id`))),
		0) AS `opex_budget`,
	ifnull(
		(select sum(`pecc`.`cost_to_complete`) from `v_pe_cost_to_complete_per_type` `pecc`
			where ((`pecc`.`currency_code` = `c`.`code`) and (`pecc`.`is_opex` = 0) and (`pecc`.`id` = `pe`.`id`) and (`pecc`.`use_purchase_order` = `upo`.`flag`) and (`pecc`.`peblt_id` = `peblt`.`id`))),
		0) AS `capex_cost_to_complete`,
	ifnull(
		(select sum(`pecc`.`cost_to_complete`) from `v_pe_cost_to_complete_per_type` `pecc`
			where ((`pecc`.`currency_code` = `c`.`code`) and (`pecc`.`is_opex` = 1) and (`pecc`.`id` = `pe`.`id`) and (`pecc`.`use_purchase_order` = `upo`.`flag`) and (`pecc`.`peblt_id` = `peblt`.`id`))),
		0) AS `opex_cost_to_complete`,
	ifnull((select `pee`.`engaged` from `v_pe_engaged_per_type` `pee` 
			where ((`pee`.`currency_code` = `c`.`code`) and (`pee`.`is_opex` = 0) and (`pee`.`id` = `pe`.`id`) and (`pee`.`use_purchase_order` = `upo`.`flag`) and (`pee`.`peblt_id` = `peblt`.`id`))),
		0) AS `capex_engaged`,
	ifnull(
		(select sum(`pee`.`engaged`) from `v_pe_engaged_per_type` `pee`
			where ((`pee`.`currency_code` = `c`.`code`) and (`pee`.`is_opex` = 1) and (`pee`.`id` = `pe`.`id`) and (`pee`.`use_purchase_order` = `upo`.`flag`) and (`pee`.`peblt_id` = `peblt`.`id`))),
		0) AS `opex_engaged`
from ((`portfolio_entry_budget_line_type` `peblt`, `portfolio_entry` `pe` join `currency` `c`) 
	join `v_use_purchase_order` `upo`)
where ((`pe`.`deleted` = 0) and (`c`.`deleted` = 0) and (`c`.`is_active` = 1))
group by `pe`.`id`,`c`.`code`,`upo`.`flag`,`peblt`.`id`);
