
CREATE TABLE `data_syndication` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `deleted` tinyint(1) DEFAULT '0',
  `last_update` datetime NOT NULL,
  `data_syndication_agreement_link_id` bigint(20) NOT NULL,
  `data_syndication_agreement_item_id` bigint(20) NOT NULL,
  `data` longblob NOT NULL,
  PRIMARY KEY (`id`)
);

--//@UNDO

drop table `data_syndication`;


