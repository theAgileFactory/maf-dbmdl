--application block table

CREATE TABLE `application_block` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `deleted` tinyint(1) DEFAULT '0',
  `last_update` datetime NOT NULL,
  `order` int(11) NOT NULL,
  `archived` tinyint(4) DEFAULT '0',
  `ref_id` varchar(64) DEFAULT NULL,
  `name` varchar(256) NOT NULL,
  `description` varchar(2500) DEFAULT NULL,
  `parent_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_application_block_1_idx` (`parent_id`),
  CONSTRAINT `fk_application_block_1` FOREIGN KEY (`parent_id`) REFERENCES `application_block` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
);

--//@UNDO

drop table `application_block`;





