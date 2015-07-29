--add is roadmap phase

ALTER TABLE `life_cycle_phase` ADD COLUMN `is_roadmap_phase` TINYINT(1) NOT NULL DEFAULT 1  AFTER `gap_days_end` ;

--//@UNDO

ALTER TABLE `life_cycle_phase` DROP COLUMN `is_roadmap_phase` ;



