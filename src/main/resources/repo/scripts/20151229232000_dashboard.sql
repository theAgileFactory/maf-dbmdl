--Dashboard objects

DROP TABLE `dashboard_widget_configuration`;
DROP TABLE `dashboard_widget_definition`;
DROP TABLE `dashboard`;

-- -----------------------------------------------------
-- Table `dashboard_page`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `dashboard_page` (
  `id` BIGINT(20) NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(256) NOT NULL ,
  `template` VARCHAR(32) NOT NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dashboard_widget`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `dashboard_widget` (
  `id` BIGINT(20) NOT NULL AUTO_INCREMENT ,
  `identifier` VARCHAR(64) NOT NULL ,
  `position` VARCHAR(32) NOT NULL ,
  `order` INT(11) NOT NULL ,
  `config` MEDIUMBLOB,
  `dashboard_page_id` BIGINT(20) NOT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_dashboard_widget_dashboard_page1_idx` (`dashboard_page_id` ASC) ,
  CONSTRAINT `fk_dashboard_widget_dashboard_page1`
    FOREIGN KEY (`dashboard_page_id` )
    REFERENCES `dashboard_page` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

--//@UNDO

DROP TABLE `dashboard_widget`;
DROP TABLE `dashboard_page`;


