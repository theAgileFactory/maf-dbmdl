--requirements

ALTER TABLE `requirement` CHANGE COLUMN `initial_estimation` `initial_estimation` DOUBLE NULL DEFAULT NULL  , CHANGE COLUMN `effort` `effort` DOUBLE NULL DEFAULT NULL  , CHANGE COLUMN `remaining_effort` `remaining_effort` DOUBLE NULL DEFAULT NULL  ;


--//@UNDO


ALTER TABLE `requirement` CHANGE COLUMN `initial_estimation` `initial_estimation` INT(11) NULL DEFAULT NULL  , CHANGE COLUMN `effort` `effort` INT(11) NULL DEFAULT NULL, CHANGE COLUMN `remaining_effort` `remaining_effort` INT(11) NULL DEFAULT NULL  ;



