--competency table (reference data)

CREATE  TABLE `competency` (
  `id` BIGINT(20) NOT NULL AUTO_INCREMENT ,
  `deleted` TINYINT(1) NULL DEFAULT 0,
  `last_update` DATETIME NOT NULL ,
  `is_active` TINYINT(1) NULL DEFAULT 1 ,
  `name` VARCHAR(64) NOT NULL ,
  `description` VARCHAR(1500) NULL ,
  PRIMARY KEY (`id`) );

--//@UNDO

drop table `competency`;

