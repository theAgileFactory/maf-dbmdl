SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

CREATE TABLE `actor` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `deleted` tinyint(1) DEFAULT '0',
  `ref_id` varchar(256) DEFAULT NULL,
  `erp_ref_id` varchar(64) DEFAULT NULL,
  `first_name` varchar(64) DEFAULT NULL,
  `last_name` varchar(64) DEFAULT NULL,
  `title` varchar(64) DEFAULT NULL,
  `mail` varchar(256) DEFAULT NULL,
  `mobile_phone` varchar(30) DEFAULT NULL,
  `fix_phone` varchar(30) DEFAULT NULL,
  `employee_id` varchar(32) DEFAULT NULL,
  `uid` varchar(32) DEFAULT NULL,
  `actor_type_id` bigint(20) DEFAULT NULL,
  `manager_id` bigint(20) DEFAULT NULL,
  `last_update` datetime NOT NULL,
  `org_unit_id` bigint(20) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `ix_actor_actorType_4` (`actor_type_id`),
  KEY `ix_actor_manager_5` (`manager_id`),
  KEY `fk_actor_org_unit1_idx` (`org_unit_id`),
  KEY `mail_index` (`mail`),
  KEY `login_index` (`uid`),
  KEY `ref_id_index` (`ref_id`),
  CONSTRAINT `fk_actor_actorType_4` FOREIGN KEY (`actor_type_id`) REFERENCES `actor_type` (`id`),
  CONSTRAINT `fk_actor_manager_5` FOREIGN KEY (`manager_id`) REFERENCES `actor` (`id`),
  CONSTRAINT `fk_actor_org_unit1` FOREIGN KEY (`org_unit_id`) REFERENCES `org_unit` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `actor_type` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `deleted` tinyint(1) DEFAULT '0',
  `name` varchar(64) NOT NULL,
  `description` varchar(1500) DEFAULT NULL,
  `ref_id` varchar(64) DEFAULT NULL,
  `selectable` tinyint(1) DEFAULT '1',
  `last_update` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name_UNIQUE` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `budget_bucket` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `deleted` tinyint(1) DEFAULT '0',
  `ref_id` varchar(64) DEFAULT NULL,
  `name` varchar(64) DEFAULT NULL,
  `owner_id` bigint(20) DEFAULT NULL,
  `is_approved` tinyint(1) NOT NULL,
  `last_update` datetime NOT NULL,
  `is_active` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `fk_budget_bucket_1_idx` (`owner_id`),
  CONSTRAINT `fk_budget_bucket_1` FOREIGN KEY (`owner_id`) REFERENCES `actor` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `budget_bucket_line` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `deleted` tinyint(1) DEFAULT '0',
  `last_update` datetime NOT NULL,
  `name` varchar(64) DEFAULT NULL,
  `ref_id` varchar(64) DEFAULT NULL,
  `is_opex` tinyint(1) DEFAULT '0',
  `amount` decimal(12,2) NOT NULL,
  `currency_code` varchar(3) NOT NULL,
  `budget_bucket_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_budget_bucket_line_1_idx` (`currency_code`),
  KEY `fk_budget_bucket_line_2_idx` (`budget_bucket_id`),
  CONSTRAINT `fk_budget_bucket_line_1` FOREIGN KEY (`currency_code`) REFERENCES `currency` (`code`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_budget_bucket_line_2` FOREIGN KEY (`budget_bucket_id`) REFERENCES `budget_bucket` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `cost_center` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `deleted` tinyint(1) DEFAULT '0',
  `ref_id` varchar(64) DEFAULT NULL,
  `name` varchar(64) NOT NULL,
  `owner_id` bigint(20) DEFAULT NULL,
  `last_update` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ix_cost_center_owner_7` (`owner_id`),
  KEY `name_index` (`name`),
  KEY `ref_id_index` (`ref_id`),
  CONSTRAINT `fk_cost_center_owner_7` FOREIGN KEY (`owner_id`) REFERENCES `actor` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `currency` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `deleted` tinyint(1) NOT NULL DEFAULT '0',
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `code` varchar(3) NOT NULL,
  `is_default` tinyint(1) NOT NULL DEFAULT '0',
  `conversion_rate` decimal(12,2) NOT NULL,
  `symbol` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `code_UNIQUE` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

INSERT INTO `currency` VALUES (1,0,1,'CHF',1,1.00,'Fr.'),(2,0,0,'USD',0,1.00,'$'),(3,0,0,'EUR',0,1.00,'€'),(4,0,0,'JPY',0,1.00,'¥'),(5,0,0,'GBP',0,1.00,'£'),(6,0,0,'CAD',0,1.00,'$');

CREATE TABLE `currency_conversions` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `creation_date` datetime NOT NULL,
  `currency_from_code` varchar(3) NOT NULL,
  `currency_to_code` varchar(3) NOT NULL,
  `conversion_rate` decimal(12,2) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_currency_conversions_1_idx` (`currency_from_code`),
  KEY `fk_currency_conversions_2_idx` (`currency_to_code`),
  CONSTRAINT `fk_currency_conversions_1` FOREIGN KEY (`currency_from_code`) REFERENCES `currency` (`code`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_currency_conversions_2` FOREIGN KEY (`currency_to_code`) REFERENCES `currency` (`code`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `custom_attribute_definition` (`id`,`object_type`,`configuration`,`order`,`attribute_type`,`uuid`,`name`,`description`,`deleted`,`last_update`,`is_displayed`) VALUES (1,'java.lang.Object','default.value=10',0,'INTEGER','DISPLAY_LIST_PAGE_SIZE_PREFERENCE','preference.display_list_page_size_preference.name','preference.display_list_page_size_preference.description',0,'2015-02-16 15:51:36',0),(2,'java.lang.Object','default.value=15',0,'INTEGER','GOVERNANCE_REVIEWED_REQUESTS_DISPLAY_DURATION','preference.governance_reviewed_requests_display_duration.name','preference.governance_reviewed_requests_display_duration.description',0,'2015-02-16 15:51:36',0),(3,'java.lang.Object','default.value=false',0,'BOOLEAN','FINANCIAL_USE_PURCHASE_ORDER_PREFERENCE','preference.financial_use_purchase_order_preference.name','preference.financial_use_purchase_order_preference.description',0,'2015-02-16 15:51:37',0),(5,'models.framework_models.account.Principal','',0,'TEXT','ROADMAP_FILTER_STORAGE_PREFERENCE','preference.roadmap_filter_storage_preference.name','preference.roadmap_filter_storage_preference.description',0,'2015-02-16 15:51:38',0),(6,'java.lang.Object','default.value=10',0,'INTEGER','FINANCIAL_WARNING_LIMIT_DEVIATION_PREFERENCE','preference.financial_warning_limit_deviation_preference.name','preference.financial_warning_limit_deviation_preference.description',1,'2015-02-16 15:51:38',0),(7,'java.lang.Object','default.value=/assets/images/white-logo-ver1.0-32x32.png\nimage.max.height=50',0,'IMAGE','APPLICATION_LOGO_PREFERENCE','preference.application_logo_preference.name','preference.application_logo_preference.description',0,'2015-02-16 15:51:41',0),(9,'java.lang.Object','default.value=true',0,'BOOLEAN','TIMESHEET_MUST_APPROVE_PREFERENCE','preference.timesheet_must_approve_preference.name','preference.timesheet_must_approve_preference.description',0,'2015-02-16 15:51:44',0),(10,'java.lang.Object','default.value=5',0,'INTEGER','TIMESHEET_REMINDER_LIMIT_PREFERENCE','preference.timesheet_reminder_limit_preference.name','preference.timesheet_reminder_limit_preference.description',0,'2015-02-16 15:51:44',0),(11,'utils.form.ReportingParamsFormData:portfolios','constraint.required=true\ninput.field.type=AUTOCOMPLETE\nselection.query=SELECT id AS value, name FROM portfolio WHERE is_active=1 AND deleted=0\nfilter.where.clause=AND name like :searchstring\nname.from.value.where.clause=AND id = :valuetofind',1,'DYNAMIC_SINGLE_ITEM','REPORT_PORTFOLIOS_PORTFOLIO','report.portfolios.portfolio.name','',0,'2015-02-16 15:51:45',0),(12,'java.lang.Object','default.value=8.5',0,'DECIMAL','TIMESHEET_HOURS_PER_DAY','preference.timesheet_hours_per_day.name','preference.timesheet_hours_per_day.description',0,'2015-02-16 15:51:45',0),(13,'utils.form.ReportingParamsFormData:actor_allocation','constraint.required=true\ninput.field.type=AUTOCOMPLETE\nselection.query=SELECT id AS value, CONCAT(first_name, \' \', last_name) AS name FROM actor WHERE is_active=1 AND deleted=0\nfilter.where.clause=AND (CONCAT(first_name, \' \', last_name) like :searchstring OR CONCAT(last_name, \' \', first_name) like :searchstring)\nname.from.value.where.clause=AND id = :valuetofind',1,'DYNAMIC_SINGLE_ITEM','REPORT_ACTOR_ALLOCATION_ACTOR','report.actor_allocation.actor.name','',0,'2015-02-16 15:51:46',0),(14,'utils.form.ReportingParamsFormData:org_unit_allocation','constraint.required=true\ninput.field.type=AUTOCOMPLETE\nselection.query=SELECT id AS value, name FROM org_unit WHERE is_active=1 AND deleted=0\nfilter.where.clause=AND (name like :searchstring OR ref_id like :searchstring)\nname.from.value.where.clause=AND id = :valuetofind',1,'DYNAMIC_SINGLE_ITEM','REPORT_ORG_UNIT_ALLOCATION_ORG_UNIT','report.org_unit_allocation.org_unit.name','',0,'2015-02-16 15:51:46',0),(15,'utils.form.ReportingParamsFormData:org_unit_actors_allocation','constraint.required=true\ninput.field.type=AUTOCOMPLETE\nselection.query=SELECT id AS value, name FROM org_unit WHERE is_active=1 AND deleted=0\nfilter.where.clause=AND (name like :searchstring OR ref_id like :searchstring)\nname.from.value.where.clause=AND id = :valuetofind',1,'DYNAMIC_SINGLE_ITEM','REPORT_ORG_UNIT_ACTORS_ALLOCATION_ORG_UNIT','report.org_unit_actors_allocation.org_unit.name','',0,'2015-02-16 15:51:46',0),(16,'models.framework_models.account.Principal','',0,'TEXT','REQUIREMENTS_FILTER_STORAGE_PREFERENCE','preference.requirements_filter_storage_preference.name','preference.requirements_filter_storage_preference.description',0,'2015-02-16 15:51:46',0),(17,'models.framework_models.account.Principal','',0,'TEXT','PACKAGES_FILTER_STORAGE_PREFERENCE','preference.packages_filter_storage_preference.name','preference.packages_filter_storage_preference.description',0,'2015-02-16 15:51:46',0),(18,'models.framework_models.account.Principal','default.value=true\ntour.all_pages=true\ntour.start_page=',0,'BOOLEAN','TOP_MENU_BAR_TOUR','The top menu bar tour','',0,'2015-02-16 15:51:48',0),(19,'models.framework_models.account.Principal','default.value=true\ntour.all_pages=true\ntour.start_page=',0,'BOOLEAN','BREADCRUMB_TOUR','The breadcrumb bar tour','',0,'2015-02-16 15:51:48',0),(20,'models.framework_models.account.Principal','',0,'TEXT','EVENTS_FILTER_STORAGE_PREFERENCE','Stores the JSON configuration of the events filter','Stores the JSON representation of the filter configuration for the default events view.',0,'2015-02-16 15:51:48',0),(21,'models.framework_models.account.Principal','',0,'TEXT','ITERATIONS_FILTER_STORAGE_PREFERENCE','Stores the JSON configuration of the iterations filter','Stores the JSON representation of the filter configuration for the default iterations view.',0,'2015-02-16 15:51:48',0),(22,'models.framework_models.account.Principal','',0,'TEXT','RELEASES_FILTER_STORAGE_PREFERENCE','Stores the JSON configuration of the releases filter','Stores the JSON representation of the filter configuration for the default releases view.',0,'2015-02-16 15:51:49',0),(23,'utils.form.ReportingParamsFormData:release_requirements','constraint.required=true\ninput.field.type=AUTOCOMPLETE\nselection.query=SELECT id AS value, name FROM `release` WHERE deleted=0\nfilter.where.clause=AND (name like :searchstring)\nname.from.value.where.clause=AND id = :valuetofind',1,'DYNAMIC_SINGLE_ITEM','REPORT_RELEASE_REQUIREMENTS_RELEASE','report.release_requirements.release.name','',0,'2015-02-16 15:51:49',0);

CREATE TABLE `dashboard` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `layout` mediumblob NOT NULL,
  `principal_uid` varchar(256) NOT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `last_update` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `dashboard_widget_configuration` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `title` varchar(256) NOT NULL,
  `config` mediumblob NOT NULL,
  `dashboard_id` bigint(20) NOT NULL,
  `dashboard_widget_definition_id` bigint(20) NOT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `last_update` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_dashboard_widget_configuration_dashboard1_idx` (`dashboard_id`),
  KEY `fk_dashboard_widget_configuration_dashboard_widget_definiti_idx` (`dashboard_widget_definition_id`),
  CONSTRAINT `fk_dashboard_widget_configuration_dashboard1` FOREIGN KEY (`dashboard_id`) REFERENCES `dashboard` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_dashboard_widget_configuration_dashboard_widget_definition1` FOREIGN KEY (`dashboard_widget_definition_id`) REFERENCES `dashboard_widget_definition` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `dashboard_widget_definition` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(32) NOT NULL,
  `widget_class` varchar(256) NOT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `last_update` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `flowmetertalend` (
  `moment` datetime DEFAULT NULL,
  `pid` varchar(20) DEFAULT NULL,
  `father_pid` varchar(20) DEFAULT NULL,
  `root_pid` varchar(20) DEFAULT NULL,
  `system_pid` bigint(20) DEFAULT NULL,
  `project` varchar(50) DEFAULT NULL,
  `job` varchar(255) DEFAULT NULL,
  `job_repository_id` varchar(255) DEFAULT NULL,
  `job_version` varchar(255) DEFAULT NULL,
  `context` varchar(50) DEFAULT NULL,
  `origin` varchar(255) DEFAULT NULL,
  `label` varchar(255) DEFAULT NULL,
  `count` bigint(20) DEFAULT NULL,
  `reference` bigint(20) DEFAULT NULL,
  `thresholds` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `goods_receipt` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `deleted` tinyint(1) DEFAULT '0',
  `ref_id` varchar(64) DEFAULT NULL,
  `purchase_order_line_item_id` bigint(20) DEFAULT NULL,
  `quantity_received` decimal(12,2) DEFAULT NULL,
  `amount_received` decimal(12,2) DEFAULT NULL,
  `last_update` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ix_goods_receipt_purchaseOrderLineItem_8` (`purchase_order_line_item_id`),
  CONSTRAINT `fk_goods_receipt_purchaseOrderLineItem_8` FOREIGN KEY (`purchase_order_line_item_id`) REFERENCES `purchase_order_line_item` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `help_target` VALUES (1,0,'2015-02-03 10:58:16','/notifications','user-guide:notifications-messages'),(2,0,'2015-02-03 10:58:16','/messaging','user-guide:notifications-messages'),(3,0,'2015-02-03 10:58:16','/my/personalstorage/display','user-guide:my-account'),(4,0,'2015-02-03 10:58:16','/admin/kpis','admin-guide:kpi'),(5,0,'2015-02-03 10:58:16','/admin/kpi/view','admin-guide:kpi'),(6,0,'2015-02-03 10:58:16','/admin/kpi/edit','admin-guide:kpi'),(7,0,'2015-02-03 10:58:16','/admin/kpi/value/edit','admin-guide:kpi'),(8,0,'2015-02-03 10:58:16','/admin/kpi/rule/manage','admin-guide:kpi'),(9,0,'2015-02-03 10:58:16','/admin/kpi/scheduler/edit','admin-guide:kpi'),(10,0,'2015-02-03 10:58:16','/request/milestone/list','user-guide:governance:milestone-requests'),(11,0,'2015-02-03 10:58:16','/request/milestone/process','user-guide:governance:milestone-requests'),(12,0,'2015-02-03 10:58:16','/portfolio/overview','user-guide:entity:portfolio'),(13,0,'2015-02-03 10:58:16','/portfolio/view','user-guide:entity:portfolio'),(14,0,'2015-02-03 10:58:16','/portfolio/new','user-guide:entity:portfolio'),(15,0,'2015-02-03 10:58:16','/portfolio/edit','user-guide:entity:portfolio'),(16,0,'2015-02-03 10:58:16','/portfolio/stakeholder/manage','user-guide:entity:portfolio'),(17,0,'2015-02-03 10:58:16','/budget-bucket/view','user-guide:entity:budgetbucket'),(18,0,'2015-02-03 10:58:16','/budget-bucket/new','user-guide:entity:budgetbucket'),(19,0,'2015-02-03 10:58:16','/budget-bucket/edit','user-guide:entity:budgetbucket'),(20,0,'2015-02-03 10:58:16','/budget-bucket/line/manage','user-guide:entity:budgetbucket'),(21,0,'2015-02-03 10:58:16','/cockpit/my-initiatives','user-guide:cockpit'),(22,0,'2015-02-03 10:58:16','/cockpit/my-portfolios','user-guide:cockpit'),(23,0,'2015-02-03 10:58:16','/cockpit/my-employees/overview','user-guide:cockpit'),(24,0,'2015-02-03 10:58:16','/cockpit/my-employees/allocation','user-guide:cockpit'),(25,0,'2015-02-03 10:58:16','/cockpit/my-employees/timesheet','user-guide:cockpit'),(26,0,'2015-02-03 10:58:16','/cockpit/my-org-units','user-guide:cockpit'),(27,0,'2015-02-03 10:58:16','/cockpit/my-budget-buckets','user-guide:cockpit'),(28,0,'2015-02-03 10:58:16','/cockpit/my-releases','user-guide:cockpit'),(29,0,'2015-02-03 10:58:16','/roadmap','user-guide:roadmap'),(30,0,'2015-02-03 10:58:16','/roadmap/planning/view','user-guide:roadmap'),(31,0,'2015-02-03 10:58:16','/portfolio-entry/create','user-guide:initiative:create-initiative'),(32,0,'2015-02-03 10:58:16','/portfolio-entry/create/1','user-guide:initiative:create-initiative'),(33,0,'2015-02-03 10:58:16','/portfolio-entry/overview','user-guide:initiative'),(34,0,'2015-02-03 10:58:16','/portfolio-entry/view','user-guide:initiative'),(35,0,'2015-02-03 10:58:16','/portfolio-entry/edit','user-guide:initiative'),(36,0,'2015-02-03 10:58:16','/portfolio-entry/custom-attr/edit','user-guide:initiative'),(37,0,'2015-02-03 10:58:16','/portfolio-entry/plugin/config','user-guide:initiative:integration'),(38,0,'2015-02-03 10:58:16','/portfolio-entry/portfolios/edit','user-guide:initiative'),(39,0,'2015-02-03 10:58:16','/portfolio-entry/attachment/create','user-guide:initiative'),(40,0,'2015-02-03 10:58:16','/portfolio-entry/financial/status','user-guide:initiative:financial'),(41,0,'2015-02-03 10:58:16','/portfolio-entry/financial/details','user-guide:initiative:financial'),(42,0,'2015-02-03 10:58:16','/portfolio-entry/financial/budget-line/view','user-guide:initiative:financial:budget'),(43,0,'2015-02-03 10:58:16','/portfolio-entry/financial/budget-line/manage','user-guide:initiative:financial:budget'),(44,0,'2015-02-03 10:58:16','/portfolio-entry/financial/work-order/view','user-guide:initiative:financial:work-order'),(45,0,'2015-02-03 10:58:16','/portfolio-entry/financial/work-order/manage','user-guide:initiative:financial:work-order'),(46,0,'2015-02-03 10:58:16','/portfolio-entry/financial/work-order/engage/1','user-guide:initiative:financial:work-order'),(47,0,'2015-02-03 10:58:16','/portfolio-entry/financial/work-order/line-item/select/1','user-guide:initiative:financial:work-order'),(48,0,'2015-02-03 10:58:16','/portfolio-entry/financial/work-order/line-item/select/2','user-guide:initiative:financial:work-order'),(49,0,'2015-02-03 10:58:16','/portfolio-entry/financial/work-order/line-item/select/3','user-guide:initiative:financial:work-order'),(50,0,'2015-02-03 10:58:16','/portfolio-entry/financial/work-order/report-balance','user-guide:initiative:financial:work-order'),(51,0,'2015-02-03 10:58:16','/portfolio-entry/stakeholder','user-guide:initiative:stakeholders'),(52,0,'2015-02-03 10:58:16','/portfolio-entry/stakeholder/manage','user-guide:initiative:stakeholders'),(53,0,'2015-02-03 10:58:16','/portfolio-entry/governance','user-guide:initiative:governance'),(54,0,'2015-02-03 10:58:16','/portfolio-entry/governance/milestone/view','user-guide:initiative:governance'),(55,0,'2015-02-03 10:58:16','/portfolio-entry/governance/milestone/request','user-guide:initiative:governance'),(56,0,'2015-02-03 10:58:16','/portfolio-entry/governance/planning/edit','user-guide:initiative:governance'),(57,0,'2015-02-03 10:58:16','/portfolio-entry/governance/process/change','user-guide:initiative:governance'),(58,0,'2015-02-03 10:58:16','/portfolio-entry/requirements','user-guide:initiative:delivery'),(59,0,'2015-02-03 10:58:16','/portfolio-entry/requirements/status','user-guide:initiative:delivery'),(60,0,'2015-02-03 10:58:16','/portfolio-entry/requirement/view','user-guide:initiative:delivery'),(61,0,'2015-02-03 10:58:16','/portfolio-entry/requirement/edit','user-guide:initiative:delivery'),(62,0,'2015-02-03 10:58:16','/portfolio-entry/iterations','user-guide:initiative:delivery'),(63,0,'2015-02-03 10:58:16','/portfolio-entry/iteration/view','user-guide:initiative:delivery'),(64,0,'2015-02-03 10:58:16','/portfolio-entry/iteration/edit','user-guide:initiative:delivery'),(65,0,'2015-02-03 10:58:16','/portfolio-entry/releases','user-guide:initiative:delivery'),(66,0,'2015-02-03 10:58:16','/portfolio-entry/release/assign','user-guide:initiative:delivery'),(67,0,'2015-02-03 10:58:16','/portfolio-entry/packages','user-guide:initiative:planning'),(68,0,'2015-02-03 10:58:16','/portfolio-entry/package/view','user-guide:initiative:planning'),(69,0,'2015-02-03 10:58:16','/portfolio-entry/package/manage','user-guide:initiative:planning'),(70,0,'2015-02-03 10:58:16','/portfolio-entry/package/groups/add','user-guide:initiative:planning'),(71,0,'2015-02-03 10:58:16','/portfolio-entry/resources','user-guide:initiative:planning'),(72,0,'2015-02-03 10:58:16','/portfolio-entry/allocated-actor/manage','user-guide:initiative:planning'),(73,0,'2015-02-03 10:58:16','/portfolio-entry/allocated-org-unit/manage','user-guide:initiative:planning'),(74,0,'2015-02-03 10:58:16','/portfolio-entry/allocated-org-unit/reallocate','user-guide:initiative:planning'),(75,0,'2015-02-03 10:58:16','/portfolio-entry/registers','user-guide:initiative:status-reporting'),(76,0,'2015-02-03 10:58:16','/portfolio-entry/risk/view','user-guide:initiative:status-reporting'),(77,0,'2015-02-03 10:58:16','/portfolio-entry/risk/manage','user-guide:initiative:status-reporting'),(78,0,'2015-02-03 10:58:16','/portfolio-entry/report/manage','user-guide:initiative:status-reporting'),(79,0,'2015-02-03 10:58:16','/portfolio-entry/events','user-guide:initiative:status-reporting'),(80,0,'2015-02-03 10:58:16','/portfolio-entry/event/manage','user-guide:initiative:status-reporting'),(81,0,'2015-02-03 10:58:16','/timesheet/weekly','user-guide:tools:enter-timesheet'),(82,0,'2015-02-03 10:58:16','/purchase-order/view','user-guide:initiative:financial:purchase-order'),(83,0,'2015-02-03 10:58:16','/purchase-order/line-item/view','user-guide:initiative:financial:purchase-order'),(84,0,'2015-02-03 10:58:16','/purchase-order/line-item/work-order/edit','user-guide:initiative:financial:purchase-order'),(85,0,'2015-02-03 10:58:16','/milestone/overview','user-guide:governance:milestone-planning'),(86,0,'2015-02-03 10:58:16','/milestone/approval/list','user-guide:governance:milestone-approval'),(87,0,'2015-02-03 10:58:16','/milestone/approval/process','user-guide:governance:milestone-approval'),(88,0,'2015-02-03 10:58:16','/search','user-guide:search'),(89,0,'2015-02-03 10:58:16','/actor/view','user-guide:entity:employee'),(90,0,'2015-02-03 10:58:16','/actor/new','user-guide:entity:employee'),(91,0,'2015-02-03 10:58:16','/actor/edit','user-guide:entity:employee'),(92,0,'2015-02-03 10:58:16','/actor/portfolio-entry/list','user-guide:entity:employee'),(93,0,'2015-02-03 10:58:16','/actor/portfolio/list','user-guide:entity:employee'),(94,0,'2015-02-03 10:58:16','/actor/allocation','user-guide:entity:employee'),(95,0,'2015-02-03 10:58:16','/actor/timesheet/weekly/view','user-guide:tools:review-and-approve-timesheet'),(96,0,'2015-02-03 10:58:16','/orgunit/view','user-guide:entity:orgunit'),(97,0,'2015-02-03 10:58:16','/orgunit/new','user-guide:entity:orgunit'),(98,0,'2015-02-03 10:58:16','/orgunit/edit','user-guide:entity:orgunit'),(99,0,'2015-02-03 10:58:16','/orgunit/portfolio-entry/list','user-guide:entity:orgunit'),(100,0,'2015-02-03 10:58:16','/orgunit/allocation','user-guide:entity:orgunit'),(101,0,'2015-02-03 10:58:16','/orgunit/actors/allocation','user-guide:entity:orgunit'),(102,0,'2015-02-03 10:58:16','/reporting','user-guide:tools:reporting'),(103,0,'2015-02-03 10:58:16','/reporting/category','user-guide:tools:reporting'),(104,0,'2015-02-03 10:58:16','/reporting/parametrize','user-guide:tools:reporting'),(105,0,'2015-02-03 10:58:16','/releases','user-guide:delivery:release'),(106,0,'2015-02-03 10:58:16','/releases/planning','user-guide:delivery:release'),(107,0,'2015-02-03 10:58:16','/release/view','user-guide:delivery:release'),(108,0,'2015-02-03 10:58:16','/release/initiatives','user-guide:delivery:release'),(109,0,'2015-02-03 10:58:16','/release/initiative/view','user-guide:delivery:release'),(110,0,'2015-02-03 10:58:16','/release/new','user-guide:delivery:release'),(111,0,'2015-02-03 10:58:16','/release/edit','user-guide:delivery:release'),(112,0,'2015-02-03 10:58:16','/admin/my-account/view','user-guide:my-account'),(113,0,'2015-02-03 10:58:16','/admin/my-account/basic-data/edit','user-guide:my-account'),(114,0,'2015-02-03 10:58:16','/admin/my-account/email/edit','user-guide:my-account'),(115,0,'2015-02-03 10:58:16','/admin/my-account/password/edit','user-guide:my-account'),(116,0,'2015-02-03 10:58:16','/admin/user-management/search','admin-guide:user-management'),(117,0,'2015-02-03 10:58:16','/admin/user-management/view','admin-guide:user-management:manage-user'),(118,0,'2015-02-03 10:58:16','/admin/user-management/find','admin-guide:user-management:manage-user'),(119,0,'2015-02-03 10:58:16','/admin/user-management/basic-data/edit','admin-guide:user-management:manage-user'),(120,0,'2015-02-03 10:58:16','/admin/user-management/mail/edit','admin-guide:user-management:manage-user'),(121,0,'2015-02-03 10:58:16','/admin/user-management/roles/edit','admin-guide:user-management:manage-user'),(122,0,'2015-02-03 10:58:16','/admin/user-management/new','admin-guide:user-management'),(123,0,'2015-02-03 10:58:16','/admin/user-management/create','admin-guide:user-management'),(124,0,'2015-02-03 10:58:16','/admin/config/system-preferences','admin-guide:configuration:system-preferences'),(125,0,'2015-02-03 10:58:16','/admin/config/system-preferences/edit','admin-guide:configuration:system-preferences'),(126,0,'2015-02-03 10:58:16','/admin/config/roles','admin-guide:configuration:roles'),(127,0,'2015-02-03 10:58:16','/admin/config/roles/permissions/edit','admin-guide:configuration:roles'),(128,0,'2015-02-03 10:58:16','/admin/config/ref-data/portfolios','admin-guide:configuration:reference-data:initiatives-and-portfolios'),(129,0,'2015-02-03 10:58:16','/admin/config/ref-data/portfolio-entry-type/manage','admin-guide:configuration:reference-data:initiatives-and-portfolios'),(130,0,'2015-02-03 10:58:16','/admin/config/ref-data/portfolio-type/manage','admin-guide:configuration:reference-data:initiatives-and-portfolios'),(131,0,'2015-02-03 10:58:16','/admin/config/ref-data/actors-org-units','admin-guide:configuration:reference-data:employees-and-org-units'),(132,0,'2015-02-03 10:58:16','/admin/config/ref-data/actor-type/manage','admin-guide:configuration:reference-data:employees-and-org-units'),(133,0,'2015-02-03 10:58:16','/admin/config/ref-data/org-unit-type/manage','admin-guide:configuration:reference-data:employees-and-org-units'),(134,0,'2015-02-03 10:58:16','/admin/config/ref-data/stakeholder-type/manage','admin-guide:configuration:reference-data:employees-and-org-units'),(135,0,'2015-02-03 10:58:16','/admin/config/ref-data/requirements','admin-guide:configuration:reference-data:requirements'),(136,0,'2015-02-03 10:58:16','/admin/config/ref-data/requirement-status/manage','admin-guide:configuration:reference-data:requirements'),(137,0,'2015-02-03 10:58:16','/admin/config/ref-data/requirement-priority/manage','admin-guide:configuration:reference-data:requirements'),(138,0,'2015-02-03 10:58:16','/admin/config/ref-data/requirement-severity/manage','admin-guide:configuration:reference-data:requirements'),(139,0,'2015-02-03 10:58:16','/admin/config/ref-data/registers','admin-guide:configuration:reference-data:registers'),(140,0,'2015-02-03 10:58:16','/admin/config/ref-data/risk-type/manage','admin-guide:configuration:reference-data:registers'),(141,0,'2015-02-03 10:58:16','/admin/config/ref-data/timesheet-activities','admin-guide:configuration:reference-data:timesheet-activity'),(142,0,'2015-02-03 10:58:16','/admin/config/ref-data/timesheet-activity-type/manage','admin-guide:configuration:reference-data:timesheet-activity'),(143,0,'2015-02-03 10:58:16','/admin/config/ref-data/timesheet-activity/manage','admin-guide:configuration:reference-data:timesheet-activity'),(144,0,'2015-02-03 10:58:16','/admin/config/ref-data/governance','admin-guide:configuration:reference-data:governance'),(145,0,'2015-02-03 10:58:16','/admin/config/ref-data/governance/process/view','admin-guide:configuration:reference-data:governance'),(146,0,'2015-02-03 10:58:16','/admin/config/ref-data/governance/process/manage','admin-guide:configuration:reference-data:governance'),(147,0,'2015-02-03 10:58:16','/admin/config/ref-data/governance/status-type/manage','admin-guide:configuration:reference-data:governance'),(148,0,'2015-02-03 10:58:16','/admin/config/ref-data/governance/milestone/manage','admin-guide:configuration:reference-data:governance'),(149,0,'2015-02-03 10:58:16','/admin/config/ref-data/governance/phase/manage','admin-guide:configuration:reference-data:governance'),(150,0,'2015-02-03 10:58:16','/admin/reporting','admin-guide:reporting'),(151,0,'2015-02-03 10:58:16','/admin/reporting/category','admin-guide:reporting'),(152,0,'2015-02-03 10:58:16','/admin/reporting/edit','admin-guide:reporting'),(153,0,'2015-02-03 10:58:16','/admin/audit/list','admin-guide:audit-log'),(154,0,'2015-02-03 10:58:16','/admin/audit/create','admin-guide:audit-log'),(155,0,'2015-02-03 10:58:16','/admin/plugin/index','admin-guide:plugins'),(156,0,'2015-02-03 10:58:16','/admin/plugin/registration/index','admin-guide:plugins'),(157,0,'2015-02-03 10:58:16','/admin/plugin/registration/new','admin-guide:plugins'),(158,0,'2015-02-03 10:58:16','/admin/plugin/edit','admin-guide:plugins'),(159,0,'2015-02-03 10:58:16','/admin/plugin/definition/redm1','admin-guide:plugins:redmine-plugin'),(160,0,'2015-02-03 10:58:16','/admin/plugin/definition/jenk1','admin-guide:plugins:jenkins-plugin'),(161,0,'2015-02-03 10:58:16','/admin/plugin/definition/actorsload1','admin-guide:plugins:actor-loader-plugin'),(162,0,'2015-02-03 10:58:16','/admin/plugin/definition/subv1','admin-guide:plugins:svn-plugin'),(163,0,'2015-02-03 10:58:16','/admin/plugin/definition/finance1','admin-guide:plugins:enterprise'),(164,0,'2015-02-03 10:58:16','/admin/plugin/definition/jira1','admin-guide:plugins:enterprise'),(165,0,'2015-02-03 10:58:16','/admin/plugin/definition/nex1','admin-guide:plugins:enterprise'),(166,0,'2015-02-03 10:58:16','/admin/plugin/definition/notification1','admin-guide:plugins:enterprise'),(167,0,'2015-02-03 10:58:16','/admin/plugin/definition/sharp1','admin-guide:plugins:enterprise'),(168,0,'2015-02-03 10:58:16','/admin/sharedstorage/display','admin-guide:plugins');

CREATE TABLE `hub_job` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `deleted` tinyint(1) DEFAULT '0',
  `etl_job_name` varchar(256) DEFAULT NULL,
  `name` varchar(256) DEFAULT NULL,
  `description` varchar(1500) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `i18n_messages` VALUES ('portfolio_entry_event_type.decision.name','de','Entscheidung'),('portfolio_entry_event_type.decision.name','en','Decision'),('portfolio_entry_event_type.decision.name','fr','Décision'),('portfolio_entry_event_type.info.name','de','Informationen'),('portfolio_entry_event_type.info.name','en','Information'),('portfolio_entry_event_type.info.name','fr','Information'),('report.actor_allocation.actor.name','de','Mitarbeiter'),('report.actor_allocation.actor.name','en','Employee'),('report.actor_allocation.actor.name','fr','Employé'),('report.org_unit_actors_allocation.org_unit.name','de','Organisationseinheit'),('report.org_unit_actors_allocation.org_unit.name','en','Org unit'),('report.org_unit_actors_allocation.org_unit.name','fr','Unité d\'organisation'),('report.org_unit_allocation.org_unit.name','de','Organisationseinheit'),('report.org_unit_allocation.org_unit.name','en','Org unit'),('report.org_unit_allocation.org_unit.name','fr','Unité d\'organisation'),('report.portfolios.portfolio.name','de','Portfolio'),('report.portfolios.portfolio.name','en','Portfolio'),('report.portfolios.portfolio.name','fr','Portefeuille'),('reporting.actor_allocation.description','de','Liste der Zuteilungen für einen Mitarbeiter.'),('reporting.actor_allocation.description','en','List of allocations for an employee.'),('reporting.actor_allocation.description','fr','Liste des affectations pour un employé'),('reporting.actor_allocation.name','de','Mitarbeiter Zuteilung'),('reporting.actor_allocation.name','en','Employee allocation'),('reporting.actor_allocation.name','fr','Affectation d\'employé'),('reporting.data_quality.description','de','KPIs bezüglich korrekter Verwendung von BizDock'),('reporting.data_quality.description','en','KPIs about the correct use of BizDock'),('reporting.data_quality.description','fr','ICPs sur l\'utilisation correcte de BizDock'),('reporting.data_quality.name','de','BizDock Daten Qualität'),('reporting.data_quality.name','en','BizDock master data quality'),('reporting.data_quality.name','fr','Qualité des données de BizDock'),('reporting.financial.description','de','Liste der aktiven Initiativen mit Finanzstatus.'),('reporting.financial.description','en','List of active initiatives with financial status.'),('reporting.financial.description','fr','Liste des initiatives actives avec l\'état financier.'),('reporting.financial.name','de','Finanzstatus'),('reporting.financial.name','en','Financial status'),('reporting.financial.name','fr','Etat financier'),('reporting.org_unit_actors_allocation.description','de','Liste der Zuteilungen für die Mitarbeiter um einer Organisationseinheit.'),('reporting.org_unit_actors_allocation.description','en','List of allocations for the employees of an org unit.'),('reporting.org_unit_actors_allocation.description','fr','Liste des affectations des employées d\'une unité d\'organisation'),('reporting.org_unit_actors_allocation.name','de','Mitarbeiter der Organisationseinheit Zuteilung'),('reporting.org_unit_actors_allocation.name','en','Employees\' org unit allocation'),('reporting.org_unit_actors_allocation.name','fr','Affectation d\'employés d\'une unité d\'organisation'),('reporting.org_unit_allocation.description','de','Liste der Zuteilungen für einen Organisationseinheit.'),('reporting.org_unit_allocation.description','en','List of allocations for an org unit.'),('reporting.org_unit_allocation.description','fr','Liste des affectations pour une unité d\'organisation'),('reporting.org_unit_allocation.name','de','Organisationseinheit Zuteilung'),('reporting.org_unit_allocation.name','en','Org unit allocation'),('reporting.org_unit_allocation.name','fr','Affectation d\'unité d\'organisation'),('reporting.portfolios.description','de','Liste der aktiven Portfolios mit Initiativen.'),('reporting.portfolios.description','en','List of active portfolios with initiatives.'),('reporting.portfolios.description','fr','Liste des portefeuilles actifs avec ses initiatives.'),('reporting.portfolios.name','de','Portfolios'),('reporting.portfolios.name','en','Portfolios'),('reporting.portfolios.name','fr','Portefeuilles'),('reporting.roadmap.description','de','Liste der aktiven und nicht-Konzept-Initiativen.'),('reporting.roadmap.description','en','List of active and non-concept initiatives.'),('reporting.roadmap.description','fr','Liste des initiatives actives et non-conceptuelles.'),('reporting.roadmap.name','de','Roadmap'),('reporting.roadmap.name','en','Roadmap'),('reporting.roadmap.name','fr','Feuille de route'),('reporting_category.default.name','de','Berichte ohne Zuordnung'),('reporting_category.default.name','en','Unclassified reports'),('reporting_category.default.name','fr','Rapports non classés');

CREATE TABLE `iteration` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `deleted` tinyint(1) DEFAULT '0',
  `last_update` datetime NOT NULL,
  `name` varchar(256) NOT NULL,
  `description` longtext,
  `is_closed` tinyint(1) DEFAULT NULL,
  `story_points` int(11) DEFAULT NULL,
  `start_date` datetime DEFAULT NULL,
  `end_date` datetime DEFAULT NULL,
  `portfolio_entry_id` bigint(20) NOT NULL,
  `source` varchar(256) DEFAULT NULL,
  `release_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_iteration_1_idx` (`portfolio_entry_id`),
  KEY `fk_iteration_2_idx` (`release_id`),
  CONSTRAINT `fk_iteration_2` FOREIGN KEY (`release_id`) REFERENCES `release` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_iteration_1` FOREIGN KEY (`portfolio_entry_id`) REFERENCES `portfolio_entry` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `kpi_color_rule` VALUES (1,0,'2015-02-16 15:51:45',0,'true;','primary',NULL,1),(2,0,'2015-02-16 15:51:45',0,'if (main != null && main <= 0) {\n    true;\n} else {\n    false;\n}','success',NULL,2),(3,0,'2015-02-16 15:51:45',1,'if (main != null && main <= 10) {\n    true;\n} else {\n    false;\n}','warning',NULL,2),(4,0,'2015-02-16 15:51:45',2,'if (main != null) {\n    true;\n} else {\n    false;\n}','danger',NULL,2),(5,0,'2015-02-16 15:51:45',0,'if (main != null && main <= 0) {\n    true;\n} else {\n    false;\n}','success',NULL,3),(6,0,'2015-02-16 15:51:45',1,'if (main != null && main <= 10) {\n    true;\n} else {\n    false;\n}','warning',NULL,3),(7,0,'2015-02-16 15:51:45',2,'if (main != null) {\n    true;\n} else {\n    false;\n}','danger',NULL,3),(8,0,'2015-02-16 15:51:45',0,'true;','primary',NULL,4),(9,0,'2015-02-16 15:51:45',0,'if (main != null && main <= 0) {\n    true;\n} else {\n    false;\n}','success',NULL,5),(10,0,'2015-02-16 15:51:45',1,'if (main != null && main <= 10) {\n    true;\n} else {\n    false;\n}','warning',NULL,5),(11,0,'2015-02-16 15:51:45',2,'if (main != null) {\n    true;\n} else {\n    false;\n}','danger',NULL,5),(12,0,'2015-02-16 15:51:45',0,'if (main != null && main <= 0) {\n    true;\n} else {\n    false;\n}','success',NULL,6),(13,0,'2015-02-16 15:51:45',1,'if (main != null && main <= 10) {\n    true;\n} else {\n    false;\n}','warning',NULL,6),(14,0,'2015-02-16 15:51:45',2,'if (main != null) {\n    true;\n} else {\n    false;\n}','danger',NULL,6),(15,0,'2015-02-16 15:51:46',0,'if(main == additional1) {\n   true;\n} else {\n   false;\n}','success',NULL,7),(16,0,'2015-02-16 15:51:46',1,'if(additional1 != 0) {\n   true;\n} else {\n   false;\n};','warning',NULL,7),(17,0,'2015-02-16 15:51:46',2,'if(main == additional2) {\n   true;\n} else {\n   false;\n};','danger',NULL,7),(18,0,'2015-02-16 15:51:46',0,'if(main == additional1) {\n   true;\n} else {\n   false;\n}','success',NULL,8),(19,0,'2015-02-16 15:51:46',1,'if(additional1 != 0) {\n   true;\n} else {\n   false;\n};','warning',NULL,8),(20,0,'2015-02-16 15:51:46',2,'if(main == additional2) {\n   true;\n} else {\n   false;\n};','danger',NULL,8),(21,0,'2015-02-16 15:51:46',0,'true;','primary',NULL,9),(22,0,'2015-02-16 15:51:46',0,'true;','primary',NULL,10),(23,0,'2015-02-16 15:51:47',0,'if(main == 0) {\n   true;\n} else {\n   false;\n}','success',NULL,11),(24,0,'2015-02-16 15:51:47',1,'if(additional1 == 0) {\n   true;\n} else {\n   false;\n};','warning',NULL,11),(25,0,'2015-02-16 15:51:47',2,'if(additional1 > 0) {\n   true;\n} else {\n   false;\n};','danger',NULL,11),(26,0,'2015-02-16 15:51:48',0,'if((additional1 - main) == 0) {\n   true;\n} else {\n   false;\n}','success',NULL,12),(27,0,'2015-02-16 15:51:48',1,'if(additional2 != 0) {\n   true;\n} else {\n   false;\n};','danger',NULL,12),(28,0,'2015-02-16 15:51:48',2,'if(additional1 > 0) {\n   true;\n} else {\n   false;\n};','primary',NULL,12);

INSERT INTO `kpi_definition` VALUES (1,0,'2015-02-16 15:51:45','KPI_RISKS_AND_ISSUES','glyphicons glyphicons-fire',1,1,0,'models.pmo.PortfolioEntry',0,1,'services.kpi.RisksAndIssuesKpi','03h00',1440,1,NULL,1,2,3),(2,0,'2015-02-16 15:51:45','KPI_DEVIATION_CAPEX','glyphicons glyphicons-coins',1,0,1,'models.pmo.PortfolioEntry',0,1,'services.kpi.DeviationCapexKpi','03h00',1440,0,NULL,4,5,6),(3,0,'2015-02-16 15:51:45','KPI_DEVIATION_OPEX','glyphicons glyphicons-coins',1,0,2,'models.pmo.PortfolioEntry',0,1,'services.kpi.DeviationOpexKpi','03h00',1440,0,NULL,7,8,9),(4,0,'2015-02-16 15:51:45','KPI_PORTFOLIO_NUMBER_OF_ENTRIES','glyphicons glyphicons-wallet',1,1,0,'models.pmo.Portfolio',0,1,'services.kpi.PortfolioNumberOfEntriesKpi','03h00',1440,1,NULL,10,11,12),(5,0,'2015-02-16 15:51:45','KPI_PORTFOLIO_DEVIATION_CAPEX','glyphicons glyphicons-coins',1,0,1,'models.pmo.Portfolio',0,1,'services.kpi.PortfolioDeviationCapexKpi','03h00',1440,0,NULL,13,14,15),(6,0,'2015-02-16 15:51:45','KPI_PORTFOLIO_DEVIATION_OPEX','glyphicons glyphicons-coins',1,0,2,'models.pmo.Portfolio',0,1,'services.kpi.PortfolioDeviationOpexKpi','03h00',1440,0,NULL,16,17,18),(7,0,'2015-02-16 15:51:46','KPI_ALLOCATED_ACTOR_DAYS','glyphicons glyphicons-address-book',1,1,3,'models.pmo.PortfolioEntry',0,1,'services.kpi.AllocatedActorDaysKpi',NULL,NULL,NULL,NULL,19,20,21),(8,0,'2015-02-16 15:51:46','KPI_ALLOCATED_ORG_UNIT_DAYS','glyphicons glyphicons-address-book',1,1,4,'models.pmo.PortfolioEntry',0,1,'services.kpi.AllocatedOrgUnitDaysKpi',NULL,NULL,NULL,NULL,22,23,24),(9,0,'2015-02-16 15:51:46','KPI_REQUIREMENT_STORY_POINTS','glyphicons glyphicons-log-book',1,1,5,'models.pmo.PortfolioEntry',0,1,'services.kpi.RequirementStoryPointsKpi','03h00',1440,0,NULL,25,26,27),(10,0,'2015-02-16 15:51:46','KPI_REQUIREMENT_NUMBER','glyphicons glyphicons-log-book',1,1,6,'models.pmo.PortfolioEntry',0,1,'services.kpi.RequirementNumberKpi','03h00',1440,0,NULL,28,29,30),(11,0,'2015-02-16 15:51:47','KPI_DEFECT_NUMBER','glyphicons glyphicons-bug',1,1,7,'models.pmo.PortfolioEntry',0,1,'services.kpi.DefectNumberKpi','03h00',1440,0,NULL,31,32,33),(12,0,'2015-02-16 15:51:48','KPI_REQUIREMENT_IS_SCOPED','glyphicons glyphicons-calendar',1,1,8,'models.pmo.PortfolioEntry',0,1,'services.kpi.RequirementIsScopedKpi','03h00',1440,0,NULL,34,35,36);

INSERT INTO `kpi_value_definition` (`id`, `deleted`, `last_update`, `name`, `render_type`, `render_pattern`, `computation_js_code`)  VALUES (1,0,'2015-02-16 15:51:45','kpi.risks_and_issues.main.name','VALUE',NULL,NULL),(2,0,'2015-02-16 15:51:45','kpi.risks_and_issues.additional1.name','VALUE',NULL,NULL),(3,0,'2015-02-16 15:51:45','kpi.risks_and_issues.additional2.name','VALUE',NULL,NULL),(4,0,'2015-02-16 15:51:45','kpi.deviation_capex.main.name','PATTERN',':si %',NULL),(5,0,'2015-02-16 15:51:45','kpi.deviation_capex.additional1.name','PATTERN',':default_currency_code :i',NULL),(6,0,'2015-02-16 15:51:45','kpi.deviation_capex.additional2.name','PATTERN',':default_currency_code :i',NULL),(7,0,'2015-02-16 15:51:45','kpi.deviation_opex.main.name','PATTERN',':si %',NULL),(8,0,'2015-02-16 15:51:45','kpi.deviation_opex.additional1.name','PATTERN',':default_currency_code :i',NULL),(9,0,'2015-02-16 15:51:45','kpi.deviation_opex.additional2.name','PATTERN',':default_currency_code :i',NULL),(10,0,'2015-02-16 15:51:45','kpi.portfolio_number_of_entries.main.name','VALUE',NULL,NULL),(11,0,'2015-02-16 15:51:45','kpi.portfolio_number_of_entries.additional1.name','VALUE',NULL,NULL),(12,0,'2015-02-16 15:51:45','kpi.portfolio_number_of_entries.additional2.name','VALUE',NULL,NULL),(13,0,'2015-02-16 15:51:45','kpi.portfolio_deviation_capex.main.name','PATTERN',':si %',NULL),(14,0,'2015-02-16 15:51:45','kpi.portfolio_deviation_capex.additional1.name','PATTERN',':default_currency_code :i',NULL),(15,0,'2015-02-16 15:51:45','kpi.portfolio_deviation_capex.additional2.name','PATTERN',':default_currency_code :i',NULL),(16,0,'2015-02-16 15:51:45','kpi.portfolio_deviation_opex.main.name','PATTERN',':si %',NULL),(17,0,'2015-02-16 15:51:45','kpi.portfolio_deviation_opex.additional1.name','PATTERN',':default_currency_code :i',NULL),(18,0,'2015-02-16 15:51:45','kpi.portfolio_deviation_opex.additional2.name','PATTERN',':default_currency_code :i',NULL),(19,0,'2015-02-16 15:51:46','kpi.allocated_actor_days.main.name','VALUE',NULL,NULL),(20,0,'2015-02-16 15:51:46','kpi.allocated_actor_days.additional1.name','VALUE',NULL,NULL),(21,0,'2015-02-16 15:51:46','kpi.allocated_actor_days.additional2.name','VALUE',NULL,NULL),(22,0,'2015-02-16 15:51:46','kpi.allocated_org_unit_days.main.name','VALUE',NULL,NULL),(23,0,'2015-02-16 15:51:46','kpi.allocated_org_unit_days.additional1.name','VALUE',NULL,NULL),(24,0,'2015-02-16 15:51:46','kpi.allocated_org_unit_days.additional2.name','VALUE',NULL,NULL),(25,0,'2015-02-16 15:51:46','kpi.requirement_story_points.main.name','VALUE',NULL,NULL),(26,0,'2015-02-16 15:51:46','kpi.requirement_story_points.additional1.name','VALUE',NULL,NULL),(27,0,'2015-02-16 15:51:46','kpi.requirement_story_points.additional2.name','VALUE',NULL,NULL),(28,0,'2015-02-16 15:51:46','kpi.requirement_number.main.name','VALUE',NULL,NULL),(29,0,'2015-02-16 15:51:46','kpi.requirement_number.additional1.name','VALUE',NULL,NULL),(30,0,'2015-02-16 15:51:46','kpi.requirement_number.additional2.name','VALUE',NULL,NULL),(31,0,'2015-02-16 15:51:47','kpi.defect_number.main.name','VALUE',NULL,NULL),(32,0,'2015-02-16 15:51:47','kpi.defect_number.additional1.name','VALUE',NULL,NULL),(33,0,'2015-02-16 15:51:47','kpi.defect_number.additional2.name','VALUE',NULL,NULL),(34,0,'2015-02-16 15:51:48','kpi.requirement_is_scoped.main.name','VALUE',NULL,NULL),(35,0,'2015-02-16 15:51:48','kpi.requirement_is_scoped.additional1.name','VALUE',NULL,NULL),(36,0,'2015-02-16 15:51:48','kpi.requirement_is_scoped.additional2.name','VALUE',NULL,NULL);

CREATE TABLE `life_cycle_instance` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `portfolio_entry_id` bigint(20) NOT NULL,
  `is_active` tinyint(1) DEFAULT '0',
  `deleted` tinyint(1) DEFAULT '0',
  `last_update` datetime NOT NULL,
  `life_cycle_process_id` bigint(20) NOT NULL,
  `is_concept` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `fk_life_cycle_instance_entry1_idx` (`portfolio_entry_id`),
  KEY `fk_life_cycle_instance_life_cycle_process1_idx` (`life_cycle_process_id`),
  CONSTRAINT `fk_life_cycle_instance_entry1` FOREIGN KEY (`portfolio_entry_id`) REFERENCES `portfolio_entry` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_life_cycle_instance_life_cycle_process1` FOREIGN KEY (`life_cycle_process_id`) REFERENCES `life_cycle_process` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `life_cycle_instance_planning` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `life_cycle_instance_id` bigint(20) NOT NULL,
  `creation_date` datetime NOT NULL,
  `version` int(4) NOT NULL,
  `is_frozen` tinyint(1) DEFAULT '0',
  `deleted` tinyint(1) DEFAULT '0',
  `name` varchar(64) DEFAULT NULL,
  `comments` varchar(1500) DEFAULT NULL,
  `last_update` datetime NOT NULL,
  `portfolio_entry_resource_plan_id` bigint(20) DEFAULT NULL,
  `portfolio_entry_budget_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_life_cycle_instance_planning_life_cycle_instance1_idx` (`life_cycle_instance_id`),
  KEY `fk_life_cycle_instance_planning_1_idx` (`portfolio_entry_resource_plan_id`),
  KEY `fk_life_cycle_instance_planning_2_idx` (`portfolio_entry_budget_id`),
  CONSTRAINT `fk_life_cycle_instance_planning_2` FOREIGN KEY (`portfolio_entry_budget_id`) REFERENCES `portfolio_entry_budget` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_life_cycle_instance_planning_1` FOREIGN KEY (`portfolio_entry_resource_plan_id`) REFERENCES `portfolio_entry_resource_plan` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_life_cycle_instance_planning_life_cycle_instance1` FOREIGN KEY (`life_cycle_instance_id`) REFERENCES `life_cycle_instance` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `life_cycle_milestone` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `deleted` tinyint(1) DEFAULT '0',
  `short_name` varchar(64) NOT NULL,
  `name` varchar(64) NOT NULL,
  `description` varchar(1500) DEFAULT NULL,
  `order` int(5) DEFAULT NULL,
  `life_cycle_process_id` bigint(20) NOT NULL,
  `last_update` datetime NOT NULL,
  `is_review_required` tinyint(1) DEFAULT '1',
  `default_life_cycle_milestone_instance_status_type_id` bigint(20) NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `fk_life_cycle_milestone_life_cyle_process1_idx` (`life_cycle_process_id`),
  KEY `name_index` (`name`),
  KEY `short_name_index` (`short_name`),
  KEY `fk_life_cycle_milestone_status_type1_idx` (`default_life_cycle_milestone_instance_status_type_id`),
  CONSTRAINT `fk_life_cycle_milestone_life_cyle_process1` FOREIGN KEY (`life_cycle_process_id`) REFERENCES `life_cycle_process` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_life_cycle_milestone_status_type1` FOREIGN KEY (`default_life_cycle_milestone_instance_status_type_id`) REFERENCES `life_cycle_milestone_instance_status_type` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `life_cycle_milestone_approver` (
  `life_cycle_milestone_id` bigint(20) NOT NULL,
  `actor_id` bigint(20) NOT NULL,
  PRIMARY KEY (`life_cycle_milestone_id`,`actor_id`),
  KEY `fk_life_cycle_milestone_has_actor_actor1_idx` (`actor_id`),
  KEY `fk_life_cycle_milestone_has_actor_life_cycle_milestone1_idx` (`life_cycle_milestone_id`),
  CONSTRAINT `fk_life_cycle_milestone_has_actor_life_cycle_milestone1` FOREIGN KEY (`life_cycle_milestone_id`) REFERENCES `life_cycle_milestone` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_life_cycle_milestone_has_actor_actor1` FOREIGN KEY (`actor_id`) REFERENCES `actor` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `life_cycle_milestone_instance` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `life_cycle_instance_id` bigint(20) NOT NULL,
  `life_cycle_milestone_id` bigint(20) NOT NULL,
  `passed_date` datetime NOT NULL,
  `gate_comments` varchar(2500) DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `has_attachments` tinyint(1) DEFAULT '0',
  `last_update` datetime NOT NULL,
  `portfolio_entry_budget_id` bigint(20) DEFAULT NULL,
  `life_cycle_milestone_instance_status_type_id` bigint(20) DEFAULT NULL,
  `is_passed` tinyint(1) DEFAULT '0',
  `portfolio_entry_resource_plan_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_life_cycle_milestone_instance_life_cycle_instance1_idx` (`life_cycle_instance_id`),
  KEY `fk_life_cycle_milestone_instance_life_cycle_milestone1_idx` (`life_cycle_milestone_id`),
  KEY `fk_life_cycle_milestone_instance_entry_budget1_idx` (`portfolio_entry_budget_id`),
  KEY `fk_life_cycle_milestone_instance_life_cycle_m_instance_idx` (`life_cycle_milestone_instance_status_type_id`),
  KEY `fk_life_cycle_milestone_instance_entry_resource_plan1_idx` (`portfolio_entry_resource_plan_id`),
  CONSTRAINT `fk_life_cycle_milestone_instance_life_cycle_instance1` FOREIGN KEY (`life_cycle_instance_id`) REFERENCES `life_cycle_instance` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_life_cycle_milestone_instance_life_cycle_milestone1` FOREIGN KEY (`life_cycle_milestone_id`) REFERENCES `life_cycle_milestone` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_life_cycle_milestone_instance_entry_budget1` FOREIGN KEY (`portfolio_entry_budget_id`) REFERENCES `portfolio_entry_budget` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_life_cycle_milestone_instance_life_cycle_miletsone_instanc1` FOREIGN KEY (`life_cycle_milestone_instance_status_type_id`) REFERENCES `life_cycle_milestone_instance_status_type` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_life_cycle_milestone_instance_entry_resource_plan1` FOREIGN KEY (`portfolio_entry_resource_plan_id`) REFERENCES `portfolio_entry_resource_plan` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `life_cycle_milestone_instance_approver` (
  `actor_id` bigint(20) NOT NULL,
  `life_cycle_milestone_instance_id` bigint(20) NOT NULL,
  `has_approved` tinyint(1) DEFAULT NULL,
  `comments` varchar(2500) DEFAULT NULL,
  `approval_date` datetime DEFAULT NULL,
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `deleted` tinyint(1) DEFAULT '0',
  `last_update` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_actor_id_life_cycle_milestone_instance_id` (`actor_id`,`life_cycle_milestone_instance_id`),
  KEY `fk_actor_has_life_cycle_milestone_instance_life_cycle_miles_idx` (`life_cycle_milestone_instance_id`),
  KEY `fk_actor_has_life_cycle_milestone_instance_actor1_idx` (`actor_id`),
  CONSTRAINT `fk_actor_has_life_cycle_milestone_instance_actor1` FOREIGN KEY (`actor_id`) REFERENCES `actor` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_actor_has_life_cycle_milestone_instance_life_cycle_milesto1` FOREIGN KEY (`life_cycle_milestone_instance_id`) REFERENCES `life_cycle_milestone_instance` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `life_cycle_milestone_instance_status_type` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `deleted` tinyint(1) DEFAULT '0',
  `name` varchar(64) NOT NULL,
  `description` varchar(1500) DEFAULT NULL,
  `is_approved` tinyint(1) DEFAULT '0',
  `selectable` tinyint(1) DEFAULT '1',
  `last_update` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name_UNIQUE` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `life_cycle_phase` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `deleted` tinyint(1) DEFAULT '0',
  `name` varchar(64) NOT NULL,
  `life_cycle_process_id` bigint(20) NOT NULL,
  `order` int(11) DEFAULT NULL,
  `start_life_cycle_milestone_id` bigint(20) NOT NULL,
  `end_life_cycle_milestone_id` bigint(20) NOT NULL,
  `last_update` datetime NOT NULL,
  `gap_days_start` int(11) DEFAULT '0',
  `gap_days_end` int(11) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fk_life_cycle_phase_1_idx` (`life_cycle_process_id`),
  KEY `fk_life_cycle_phase_2_idx` (`start_life_cycle_milestone_id`),
  KEY `fk_life_cycle_phase_3_idx` (`end_life_cycle_milestone_id`),
  CONSTRAINT `fk_life_cycle_phase_1` FOREIGN KEY (`life_cycle_process_id`) REFERENCES `life_cycle_process` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_life_cycle_phase_2` FOREIGN KEY (`start_life_cycle_milestone_id`) REFERENCES `life_cycle_milestone` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_life_cycle_phase_3` FOREIGN KEY (`end_life_cycle_milestone_id`) REFERENCES `life_cycle_milestone` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `life_cycle_process` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `deleted` tinyint(1) DEFAULT '0',
  `short_name` varchar(64) NOT NULL,
  `name` varchar(64) NOT NULL,
  `description` varchar(1500) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT '0',
  `last_update` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `name_index` (`name`),
  KEY `short_name_index` (`short_name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `logtalend` (
  `moment` datetime DEFAULT NULL,
  `pid` varchar(20) DEFAULT NULL,
  `root_pid` varchar(20) DEFAULT NULL,
  `father_pid` varchar(20) DEFAULT NULL,
  `project` varchar(50) DEFAULT NULL,
  `job` varchar(255) DEFAULT NULL,
  `context` varchar(50) DEFAULT NULL,
  `priority` int(11) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `origin` varchar(255) DEFAULT NULL,
  `message` varchar(255) DEFAULT NULL,
  `code` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `notification_category` VALUES (1,0,'2015-02-16 15:51:41','USER_MANAGEMENT','User management','glyphicons glyphicons-user'),(2,0,'2015-02-16 15:51:41','APPROVAL','Approval','glyphicons glyphicons-thumbs-up'),(3,0,'2015-02-16 15:51:41','REQUEST_REVIEW','Request review','glyphicons glyphicons-transfer'),(4,0,'2015-02-16 15:51:41','DOCUMENT','Document','glyphicons glyphicons-file'),(5,0,'2015-02-16 15:51:41','ISSUE','Issue','glyphicons glyphicons-bug'),(6,0,'2015-02-16 15:51:41','AUDIT','Audit','glyphicons glyphicons-signal'),(7,0,'2015-02-16 15:51:41','PORTFOLIO_ENTRY','Portfolio entry','glyphicons glyphicons-wallet'),(8,0,'2015-02-16 15:51:44','TIMESHEET','Timesheet','glyphicons glyphicons-clock');

CREATE TABLE `org_unit` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `deleted` tinyint(1) DEFAULT '0',
  `name` varchar(64) NOT NULL,
  `ref_id` varchar(64) DEFAULT NULL,
  `can_sponsor` tinyint(1) DEFAULT '1',
  `org_unit_type_id` bigint(20) DEFAULT NULL,
  `parent_id` bigint(20) DEFAULT NULL,
  `last_update` datetime NOT NULL,
  `manager_id` bigint(20) DEFAULT NULL,
  `can_deliver` tinyint(1) DEFAULT '1',
  `is_active` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `ix_org_unit_orgUnitType_9` (`org_unit_type_id`),
  KEY `ix_org_unit_parent_10` (`parent_id`),
  KEY `name_index` (`name`),
  KEY `ref_id_index` (`ref_id`),
  KEY `fk_org_unit_actor1_idx` (`manager_id`),
  CONSTRAINT `fk_org_unit_parent_10` FOREIGN KEY (`parent_id`) REFERENCES `org_unit` (`id`),
  CONSTRAINT `fk_org_unit_orgUnitType_9` FOREIGN KEY (`org_unit_type_id`) REFERENCES `org_unit_type` (`id`),
  CONSTRAINT `fk_org_unit_actor1` FOREIGN KEY (`manager_id`) REFERENCES `actor` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `org_unit_type` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `deleted` tinyint(1) DEFAULT '0',
  `name` varchar(64) NOT NULL,
  `description` varchar(1500) DEFAULT NULL,
  `selectable` tinyint(1) DEFAULT '1',
  `last_update` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name_UNIQUE` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `planned_life_cycle_milestone_instance` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `planned_date` datetime DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `last_update` datetime NOT NULL,
  `life_cycle_instance_planning_id` bigint(20) NOT NULL,
  `life_cycle_milestone_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_planned_life_cycle_milestone_instance_life_cycle_instanc_idx` (`life_cycle_instance_planning_id`),
  KEY `fk_planned_life_cycle_milestone_instance_life_cycle_milesto_idx` (`life_cycle_milestone_id`),
  CONSTRAINT `fk_planned_life_cycle_milestone_instance_life_cycle_instance_1` FOREIGN KEY (`life_cycle_instance_planning_id`) REFERENCES `life_cycle_instance_planning` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_planned_life_cycle_milestone_instance_life_cycle_milestone1` FOREIGN KEY (`life_cycle_milestone_id`) REFERENCES `life_cycle_milestone` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `portfolio` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `deleted` tinyint(1) DEFAULT '0',
  `is_active` tinyint(1) DEFAULT '0',
  `ref_id` varchar(64) DEFAULT NULL,
  `name` varchar(64) NOT NULL,
  `last_update` datetime NOT NULL,
  `portfolio_type_id` bigint(20) NOT NULL,
  `manager_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_portfolio_portfolio_type_idx` (`portfolio_type_id`),
  KEY `ref_id_index` (`ref_id`),
  KEY `fk_portfolio_actor1_idx` (`manager_id`),
  CONSTRAINT `fk_portfolio_actor1` FOREIGN KEY (`manager_id`) REFERENCES `actor` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_portfolio_portfolio_type1` FOREIGN KEY (`portfolio_type_id`) REFERENCES `portfolio_type` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `portfolio_entry` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `deleted` tinyint(1) DEFAULT '0',
  `ref_id` varchar(64) DEFAULT NULL,
  `governance_id` varchar(32) DEFAULT NULL,
  `erp_ref_id` varchar(64) DEFAULT NULL,
  `name` varchar(64) NOT NULL,
  `description` varchar(2500) DEFAULT NULL,
  `creation_date` datetime NOT NULL,
  `manager_id` bigint(20) DEFAULT NULL,
  `sponsoring_unit_id` bigint(20) DEFAULT NULL,
  `is_public` tinyint(1) DEFAULT '0',
  `archived` tinyint(1) DEFAULT '0',
  `last_update` datetime NOT NULL,
  `portfolio_entry_type_id` bigint(20) DEFAULT NULL,
  `last_approved_life_cycle_milestone_instance_id` bigint(20) DEFAULT NULL,
  `active_life_cycle_instance_id` bigint(20) DEFAULT NULL,
  `last_portfolio_entry_report_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ix_portfolio_entry_manager_1` (`manager_id`),
  KEY `ix_portfolio_entry_sponsoringUnit_2` (`sponsoring_unit_id`),
  KEY `fk_portfolio_entry_portfolio_entry_type1_idx` (`portfolio_entry_type_id`),
  KEY `name_index` (`name`),
  KEY `ref_id_index` (`ref_id`),
  KEY `governance_id_index` (`governance_id`),
  KEY `fk_portfolio_entry_1_idx` (`last_approved_life_cycle_milestone_instance_id`),
  KEY `fk_portfolio_entry_2_idx` (`active_life_cycle_instance_id`),
  KEY `fk_portfolio_entry_3_idx` (`last_portfolio_entry_report_id`),
  CONSTRAINT `fk_portfolio_entry_3` FOREIGN KEY (`last_portfolio_entry_report_id`) REFERENCES `portfolio_entry_report` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_portfolio_entry_1` FOREIGN KEY (`last_approved_life_cycle_milestone_instance_id`) REFERENCES `life_cycle_milestone_instance` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_portfolio_entry_2` FOREIGN KEY (`active_life_cycle_instance_id`) REFERENCES `life_cycle_instance` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_portfolio_entry_manager_1` FOREIGN KEY (`manager_id`) REFERENCES `actor` (`id`),
  CONSTRAINT `fk_portfolio_entry_portfolio_entry_type1` FOREIGN KEY (`portfolio_entry_type_id`) REFERENCES `portfolio_entry_type` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_portfolio_entry_sponsoringUnit_2` FOREIGN KEY (`sponsoring_unit_id`) REFERENCES `org_unit` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `portfolio_entry_budget` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `deleted` tinyint(1) DEFAULT '0',
  `allocation_date` datetime DEFAULT NULL,
  `last_update` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `portfolio_entry_budget_line` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `deleted` tinyint(1) DEFAULT '0',
  `name` varchar(64) DEFAULT NULL,
  `ref_id` varchar(64) DEFAULT NULL,
  `is_opex` tinyint(1) DEFAULT '0',
  `amount` decimal(12,2) NOT NULL,
  `gl_account` varchar(64) DEFAULT NULL,
  `currency_code` varchar(3) NOT NULL,
  `budget_bucket_id` bigint(20) DEFAULT NULL,
  `last_update` datetime NOT NULL,
  `portfolio_entry_budget_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_entry_budget_line_entry_budget1_idx` (`portfolio_entry_budget_id`),
  KEY `fk_portfolio_entry_budget_line_1_idx` (`currency_code`),
  KEY `fk_portfolio_entry_budget_line_3_idx` (`budget_bucket_id`),
  CONSTRAINT `fk_portfolio_entry_budget_line_3` FOREIGN KEY (`budget_bucket_id`) REFERENCES `budget_bucket` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_entry_budget_line_entry_budget1` FOREIGN KEY (`portfolio_entry_budget_id`) REFERENCES `portfolio_entry_budget` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_portfolio_entry_budget_line_1` FOREIGN KEY (`currency_code`) REFERENCES `currency` (`code`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `portfolio_entry_event` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `deleted` tinyint(1) DEFAULT '0',
  `last_update` datetime NOT NULL,
  `creation_date` datetime NOT NULL,
  `portfolio_entry_event_type_id` bigint(20) NOT NULL,
  `message` longtext NOT NULL,
  `portfolio_entry_id` bigint(20) NOT NULL,
  `actor_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_event_1_idx` (`portfolio_entry_event_type_id`),
  KEY `fk_event_2_idx` (`portfolio_entry_id`),
  KEY `fk_event_3_idx` (`actor_id`),
  CONSTRAINT `fk_event_1` FOREIGN KEY (`portfolio_entry_event_type_id`) REFERENCES `portfolio_entry_event_type` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_event_2` FOREIGN KEY (`portfolio_entry_id`) REFERENCES `portfolio_entry` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_event_3` FOREIGN KEY (`actor_id`) REFERENCES `actor` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `portfolio_entry_event_type` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `deleted` tinyint(1) DEFAULT '0',
  `last_update` datetime NOT NULL,
  `selectable` tinyint(1) DEFAULT '1',
  `name` varchar(64) NOT NULL,
  `bootstrap_glyphicon` varchar(64) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

INSERT INTO `portfolio_entry_event_type` VALUES (1,0,'2015-02-16 15:51:43',1,'portfolio_entry_event_type.info.name','glyphicons glyphicons-circle-info'),(2,0,'2015-02-16 15:51:43',1,'portfolio_entry_event_type.decision.name','glyphicons glyphicons-thumbs-up');

CREATE TABLE `portfolio_entry_has_delivery_unit` (
  `portfolio_entry_id` bigint(20) NOT NULL,
  `org_unit_id` bigint(20) NOT NULL,
  PRIMARY KEY (`portfolio_entry_id`,`org_unit_id`),
  KEY `fk_entry_has_org_unit_org_unit1_idx` (`org_unit_id`),
  KEY `fk_entry_has_org_unit_entry1_idx` (`portfolio_entry_id`),
  CONSTRAINT `fk_entry_has_org_unit_entry1` FOREIGN KEY (`portfolio_entry_id`) REFERENCES `portfolio_entry` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_entry_has_org_unit_org_unit1` FOREIGN KEY (`org_unit_id`) REFERENCES `org_unit` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `portfolio_entry_planning_package` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `deleted` tinyint(1) DEFAULT '0',
  `last_update` datetime NOT NULL,
  `name` varchar(64) NOT NULL,
  `description` varchar(1500) DEFAULT NULL,
  `start_date` datetime DEFAULT NULL,
  `end_date` datetime DEFAULT NULL,
  `css_class` varchar(64) DEFAULT NULL,
  `portfolio_entry_id` bigint(20) NOT NULL,
  `is_important` tinyint(1) DEFAULT '0',
  `order` int(11) DEFAULT NULL,
  `portfolio_entry_planning_package_group_id` bigint(20) DEFAULT NULL,
  `status` varchar(64) NOT NULL DEFAULT 'NOT_STARTED',
  PRIMARY KEY (`id`),
  KEY `fk_portfolio_entry_planning_package_1_idx` (`portfolio_entry_id`),
  KEY `fk_portfolio_entry_planning_package_2_idx` (`portfolio_entry_planning_package_group_id`),
  CONSTRAINT `fk_portfolio_entry_planning_package_2` FOREIGN KEY (`portfolio_entry_planning_package_group_id`) REFERENCES `portfolio_entry_planning_package_group` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_portfolio_entry_planning_package_1` FOREIGN KEY (`portfolio_entry_id`) REFERENCES `portfolio_entry` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `portfolio_entry_planning_package_group` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `deleted` tinyint(1) DEFAULT '0',
  `last_update` datetime NOT NULL,
  `name` varchar(64) NOT NULL,
  `description` varchar(2500) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `portfolio_entry_planning_package_pattern` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `deleted` tinyint(1) DEFAULT '0',
  `last_update` datetime NOT NULL,
  `name` varchar(64) NOT NULL,
  `description` varchar(1500) DEFAULT NULL,
  `is_important` tinyint(1) DEFAULT NULL,
  `order` int(11) DEFAULT NULL,
  `css_class` varchar(64) DEFAULT NULL,
  `portfolio_entry_planning_package_group_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_portfolio_entry_planning_package_pattern_1_idx` (`portfolio_entry_planning_package_group_id`),
  CONSTRAINT `fk_portfolio_entry_planning_package_pattern_1` FOREIGN KEY (`portfolio_entry_planning_package_group_id`) REFERENCES `portfolio_entry_planning_package_group` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `portfolio_entry_report` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `creation_date` datetime NOT NULL,
  `publication_date` datetime DEFAULT NULL,
  `comments` varchar(2500) DEFAULT NULL,
  `author_id` bigint(20) NOT NULL,
  `is_published` tinyint(1) DEFAULT '0',
  `deleted` tinyint(1) DEFAULT '0',
  `last_update` datetime NOT NULL,
  `portfolio_entry_report_status_type_id` bigint(20) NOT NULL,
  `portfolio_entry_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_entry_report_actor1_idx` (`author_id`),
  KEY `fk_entry_report_entry_report_status_type1_idx` (`portfolio_entry_report_status_type_id`),
  KEY `fk_entry_report_entry1_idx` (`portfolio_entry_id`),
  CONSTRAINT `fk_portfolio_entry_report_actor1` FOREIGN KEY (`author_id`) REFERENCES `actor` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_portfolio_entry_report_portfolio_entry_report_status_type1` FOREIGN KEY (`portfolio_entry_report_status_type_id`) REFERENCES `portfolio_entry_report_status_type` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_portfolio_entry_report_portfolio_entry1` FOREIGN KEY (`portfolio_entry_id`) REFERENCES `portfolio_entry` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `portfolio_entry_report_status_type` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL,
  `description` varchar(1500) DEFAULT NULL,
  `selectable` tinyint(1) DEFAULT '1',
  `deleted` tinyint(1) DEFAULT '0',
  `css_class` varchar(32) NOT NULL,
  `last_update` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name_UNIQUE` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `portfolio_entry_resource_plan` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `deleted` tinyint(1) DEFAULT '0',
  `last_update` datetime NOT NULL,
  `allocation_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `portfolio_entry_resource_plan_allocated_actor` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `portfolio_entry_resource_plan_id` bigint(20) NOT NULL,
  `actor_id` bigint(20) NOT NULL,
  `days` decimal(12,2) NOT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `start_date` datetime DEFAULT NULL,
  `end_date` datetime DEFAULT NULL,
  `last_update` datetime NOT NULL,
  `portfolio_entry_planning_package_id` bigint(20) DEFAULT NULL,
  `is_confirmed` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fk_entry_resource_plan_has_actor_actor1_idx` (`actor_id`),
  KEY `fk_entry_resource_plan_has_actor_entry_resource_plan1_idx` (`portfolio_entry_resource_plan_id`),
  KEY `uq_actor_id_entry_resource_plan_id` (`portfolio_entry_resource_plan_id`,`actor_id`),
  KEY `fk_portfolio_entry_resource_plan_allocated_actor_1_idx` (`portfolio_entry_planning_package_id`),
  CONSTRAINT `fk_entry_resource_plan_has_actor_actor1` FOREIGN KEY (`actor_id`) REFERENCES `actor` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_entry_resource_plan_has_actor_entry_resource_plan1` FOREIGN KEY (`portfolio_entry_resource_plan_id`) REFERENCES `portfolio_entry_resource_plan` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_portfolio_entry_resource_plan_allocated_actor_1` FOREIGN KEY (`portfolio_entry_planning_package_id`) REFERENCES `portfolio_entry_planning_package` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `portfolio_entry_resource_plan_allocated_org_unit` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `days` decimal(12,2) NOT NULL,
  `portfolio_entry_resource_plan_id` bigint(20) NOT NULL,
  `org_unit_id` bigint(20) NOT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `start_date` datetime DEFAULT NULL,
  `end_date` datetime DEFAULT NULL,
  `last_update` datetime NOT NULL,
  `portfolio_entry_planning_package_id` bigint(20) DEFAULT NULL,
  `is_confirmed` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fk_entry_resource_plan_allocated_org_unit_entry_resou_idx` (`portfolio_entry_resource_plan_id`),
  KEY `fk_entry_resource_plan_allocated_org_unit_org_unit1_idx` (`org_unit_id`),
  KEY `fk_portfolio_entry_resource_plan_allocated_org_unit_1_idx` (`portfolio_entry_planning_package_id`),
  CONSTRAINT `fk_entry_resource_plan_allocated_org_unit_entry_resourc1` FOREIGN KEY (`portfolio_entry_resource_plan_id`) REFERENCES `portfolio_entry_resource_plan` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_entry_resource_plan_allocated_org_unit_org_unit1` FOREIGN KEY (`org_unit_id`) REFERENCES `org_unit` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_portfolio_entry_resource_plan_allocated_org_unit_1` FOREIGN KEY (`portfolio_entry_planning_package_id`) REFERENCES `portfolio_entry_planning_package` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `portfolio_entry_risk` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `creation_date` datetime NOT NULL,
  `target_date` datetime DEFAULT NULL,
  `name` varchar(64) NOT NULL,
  `description` varchar(1500) DEFAULT NULL,
  `portfolio_entry_id` bigint(20) NOT NULL,
  `has_occured` tinyint(1) DEFAULT '0',
  `is_mitigated` tinyint(1) DEFAULT '0',
  `closure_date` datetime DEFAULT NULL,
  `mitigation_comment` varchar(1500) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT '1',
  `deleted` tinyint(1) DEFAULT '0',
  `last_update` datetime NOT NULL,
  `portfolio_entry_risk_type_id` bigint(20) DEFAULT NULL,
  `owner_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_entry_risk_entry1_idx` (`portfolio_entry_id`),
  KEY `fk_entry_risk_entry_risk_type1_idx` (`portfolio_entry_risk_type_id`),
  KEY `fk_portfolio_entry_risk_actor1_idx` (`owner_id`),
  CONSTRAINT `fk_entry_risk_entry1` FOREIGN KEY (`portfolio_entry_id`) REFERENCES `portfolio_entry` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_entry_risk_entry_risk_type1` FOREIGN KEY (`portfolio_entry_risk_type_id`) REFERENCES `portfolio_entry_risk_type` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_entry_risk_actor1` FOREIGN KEY (`owner_id`) REFERENCES `actor` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `portfolio_entry_risk_type` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL,
  `description` varchar(1500) DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `selectable` tinyint(1) DEFAULT '1',
  `last_update` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `portfolio_entry_type` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `deleted` tinyint(1) DEFAULT '0',
  `name` varchar(64) NOT NULL,
  `description` varchar(1500) DEFAULT NULL,
  `selectable` tinyint(1) DEFAULT '1',
  `last_update` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name_UNIQUE` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `portfolio_entry_type_has_stakeholder_type` (
  `portfolio_entry_type_id` bigint(20) NOT NULL,
  `stakeholder_type_id` bigint(20) NOT NULL,
  PRIMARY KEY (`portfolio_entry_type_id`,`stakeholder_type_id`),
  KEY `fk_entry_type_has_stakeholder_type_stakeholder_ty_idx` (`stakeholder_type_id`),
  KEY `fk_entry_type_has_stakeholder_type_entr_idx` (`portfolio_entry_type_id`),
  CONSTRAINT `fk_portfolio_entry_type_has_stakeholder_type_portfolio_entry_1` FOREIGN KEY (`portfolio_entry_type_id`) REFERENCES `portfolio_entry_type` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_portfolio_entry_type_has_stakeholder_type_stakeholder_type1` FOREIGN KEY (`stakeholder_type_id`) REFERENCES `stakeholder_type` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `portfolio_has_portfolio_entry` (
  `portfolio_id` bigint(20) NOT NULL,
  `portfolio_entry_id` bigint(20) NOT NULL,
  PRIMARY KEY (`portfolio_id`,`portfolio_entry_id`),
  KEY `fk_portfolio_has_entry_entry1_idx` (`portfolio_entry_id`),
  KEY `fk_portfolio_has_entry_portfolio1_idx` (`portfolio_id`),
  CONSTRAINT `fk_portfolio_has_entry_portfolio1` FOREIGN KEY (`portfolio_id`) REFERENCES `portfolio` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_portfolio_has_entry_entry1` FOREIGN KEY (`portfolio_entry_id`) REFERENCES `portfolio_entry` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `portfolio_type` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL,
  `description` varchar(1500) DEFAULT NULL,
  `last_update` datetime NOT NULL,
  `selectable` tinyint(1) DEFAULT '1',
  `deleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name_UNIQUE` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `portfolio_type_has_stakeholder_type` (
  `portfolio_type_id` bigint(20) NOT NULL,
  `stakeholder_type_id` bigint(20) NOT NULL,
  PRIMARY KEY (`portfolio_type_id`,`stakeholder_type_id`),
  KEY `fk_portfolio_type_has_stakeholder_type_stakeholder_type1_idx` (`stakeholder_type_id`),
  KEY `fk_portfolio_type_has_stakeholder_type_portfolio_type1_idx` (`portfolio_type_id`),
  CONSTRAINT `fk_portfolio_type_has_stakeholder_type_portfolio_type1` FOREIGN KEY (`portfolio_type_id`) REFERENCES `portfolio_type` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_portfolio_type_has_stakeholder_type_stakeholder_type1` FOREIGN KEY (`stakeholder_type_id`) REFERENCES `stakeholder_type` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `preference` VALUES (1,0,'2015-02-16 15:51:36','DISPLAY_LIST_PAGE_SIZE_PREFERENCE',1),(2,0,'2015-02-16 15:51:36','GOVERNANCE_REVIEWED_REQUESTS_DISPLAY_DURATION',1),(3,0,'2015-02-16 15:51:37','FINANCIAL_USE_PURCHASE_ORDER_PREFERENCE',1),(4,0,'2015-02-16 15:51:38','ROADMAP_FILTER_STORAGE_PREFERENCE',0),(5,1,'2015-02-16 15:51:38','FINANCIAL_WARNING_LIMIT_DEVIATION_PREFERENCE',1),(6,0,'2015-02-16 15:51:41','APPLICATION_LOGO_PREFERENCE',1),(8,0,'2015-02-16 15:51:44','TIMESHEET_MUST_APPROVE_PREFERENCE',1),(9,0,'2015-02-16 15:51:44','TIMESHEET_REMINDER_LIMIT_PREFERENCE',1),(10,0,'2015-02-16 15:51:45','TIMESHEET_HOURS_PER_DAY',1),(11,0,'2015-02-16 15:51:46','REQUIREMENTS_FILTER_STORAGE_PREFERENCE',0),(12,0,'2015-02-16 15:51:46','PACKAGES_FILTER_STORAGE_PREFERENCE',0),(13,0,'2015-02-16 15:51:48','TOP_MENU_BAR_TOUR',0),(14,0,'2015-02-16 15:51:48','BREADCRUMB_TOUR',0),(15,0,'2015-02-16 15:51:48','EVENTS_FILTER_STORAGE_PREFERENCE',0),(16,0,'2015-02-16 15:51:48','ITERATIONS_FILTER_STORAGE_PREFERENCE',0),(17,0,'2015-02-16 15:51:49','RELEASES_FILTER_STORAGE_PREFERENCE',0);

CREATE TABLE `principal_reporting_authorization` (
  `principal_id` bigint(20) NOT NULL,
  `reporting_authorization_id` bigint(20) NOT NULL,
  PRIMARY KEY (`principal_id`,`reporting_authorization_id`),
  KEY `fk_actor_reporting_authorization_reporting_authorization_idx` (`reporting_authorization_id`),
  KEY `fk_actor_reporting_authorization_actor_idx` (`principal_id`),
  CONSTRAINT `fk_actor_reporting_authorization_reporting_authorization` FOREIGN KEY (`reporting_authorization_id`) REFERENCES `reporting_authorization` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_actor_reporting_authorization_actor` FOREIGN KEY (`principal_id`) REFERENCES `principal` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `process_transition_request` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `title` varchar(256) DEFAULT NULL,
  `creation_date` datetime NOT NULL,
  `accepted` tinyint(1) DEFAULT '0',
  `review_date` datetime DEFAULT NULL,
  `comments` varchar(1500) DEFAULT NULL,
  `request_type` varchar(32) NOT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `last_update` datetime NOT NULL,
  `requester_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_process_transition_request_actor1_idx` (`requester_id`),
  CONSTRAINT `fk_process_transition_request_actor1` FOREIGN KEY (`requester_id`) REFERENCES `actor` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `purchase_order` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `ref_id` varchar(64) DEFAULT NULL,
  `description` varchar(1500) DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `last_update` datetime NOT NULL,
  `portfolio_entry_id` bigint(20) DEFAULT NULL,
  `is_cancelled` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fk_po_portfolio_entry_idx` (`portfolio_entry_id`),
  KEY `ref_id_index` (`ref_id`),
  CONSTRAINT `fk_po_portfolio_entry` FOREIGN KEY (`portfolio_entry_id`) REFERENCES `portfolio_entry` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `purchase_order_line_item` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `deleted` tinyint(1) DEFAULT '0',
  `ref_id` varchar(64) DEFAULT NULL,
  `description` varchar(1500) DEFAULT NULL,
  `line_id` int(11) DEFAULT NULL,
  `supplier_id` bigint(20) DEFAULT NULL,
  `quantity` decimal(12,2) DEFAULT NULL,
  `quantity_total_received` decimal(12,2) DEFAULT NULL,
  `quantity_billed` decimal(12,2) DEFAULT NULL,
  `amount` decimal(12,2) DEFAULT NULL,
  `amount_received` decimal(12,2) DEFAULT NULL,
  `amount_billed` decimal(12,2) DEFAULT NULL,
  `unit_price` decimal(12,2) DEFAULT NULL,
  `material_code` varchar(32) DEFAULT NULL,
  `gl_account` varchar(32) DEFAULT NULL,
  `is_opex` tinyint(1) DEFAULT '0',
  `creation_date` datetime DEFAULT NULL,
  `due_date` datetime DEFAULT NULL,
  `shipment_type_id` bigint(20) DEFAULT NULL,
  `requester_id` bigint(20) DEFAULT NULL,
  `cost_center_id` bigint(20) DEFAULT NULL,
  `last_update` datetime NOT NULL,
  `purchase_order_id` bigint(20) NOT NULL,
  `currency_code` varchar(3) DEFAULT NULL,
  `is_cancelled` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `ix_purchase_order_line_item_supplier_12` (`supplier_id`),
  KEY `ix_purchase_order_line_item_shipmentType_14` (`shipment_type_id`),
  KEY `ix_purchase_order_line_item_requester_15` (`requester_id`),
  KEY `ix_purchase_order_line_item_costCenter_16` (`cost_center_id`),
  KEY `fk_purchase_order_line_item_purchase_order1_idx` (`purchase_order_id`),
  KEY `identifier_index` (`ref_id`,`line_id`),
  KEY `fk_purchase_order_line_item_1_idx` (`currency_code`),
  CONSTRAINT `fk_purchase_order_line_item_1` FOREIGN KEY (`currency_code`) REFERENCES `currency` (`code`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_purchase_order_line_item_costCenter_16` FOREIGN KEY (`cost_center_id`) REFERENCES `cost_center` (`id`),
  CONSTRAINT `fk_purchase_order_line_item_purchase_order1` FOREIGN KEY (`purchase_order_id`) REFERENCES `purchase_order` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_purchase_order_line_item_requester_15` FOREIGN KEY (`requester_id`) REFERENCES `actor` (`id`),
  CONSTRAINT `fk_purchase_order_line_item_shipmentType_14` FOREIGN KEY (`shipment_type_id`) REFERENCES `purchase_order_line_shipment_status_type` (`id`),
  CONSTRAINT `fk_purchase_order_line_item_supplier_12` FOREIGN KEY (`supplier_id`) REFERENCES `supplier` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `purchase_order_line_shipment_status_type` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `deleted` tinyint(1) DEFAULT '0',
  `ref_id` varchar(64) DEFAULT NULL,
  `name` varchar(32) NOT NULL,
  `description` varchar(1500) DEFAULT NULL,
  `is_amount_expanded` tinyint(1) NOT NULL,
  `selectable` tinyint(1) DEFAULT '1',
  `last_update` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name_UNIQUE` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `release` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `deleted` tinyint(1) DEFAULT '0',
  `last_update` datetime NOT NULL,
  `name` varchar(256) NOT NULL,
  `description` longtext,
  `capacity` int(11) DEFAULT NULL,
  `cut_off_date` datetime DEFAULT NULL,
  `end_tests_date` datetime DEFAULT NULL,
  `deployment_date` datetime DEFAULT NULL,
  `manager_id` bigint(20) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `fk_release_1_idx` (`manager_id`),
  CONSTRAINT `fk_release_1` FOREIGN KEY (`manager_id`) REFERENCES `actor` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `release_portfolio_entry` (
  `portfolio_entry_id` bigint(20) NOT NULL,
  `release_id` bigint(20) NOT NULL,
  `type` varchar(64) NOT NULL,
  PRIMARY KEY (`portfolio_entry_id`,`release_id`),
  KEY `fk_release_has_portfolio_entry_1_idx` (`portfolio_entry_id`),
  KEY `fk_release_has_portfolio_entry_2_idx` (`release_id`),
  CONSTRAINT `fk_release_has_portfolio_entry_1` FOREIGN KEY (`portfolio_entry_id`) REFERENCES `portfolio_entry` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_release_has_portfolio_entry_2` FOREIGN KEY (`release_id`) REFERENCES `release` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `reporting` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `deleted` tinyint(1) DEFAULT '0',
  `last_update` datetime NOT NULL,
  `reporting_category_id` bigint(20) NOT NULL,
  `reporting_authorization_id` bigint(20) NOT NULL,
  `name` varchar(64) NOT NULL,
  `description` varchar(256) DEFAULT NULL,
  `is_public` tinyint(1) DEFAULT '0',
  `is_active` tinyint(1) DEFAULT '1',
  `is_standard` tinyint(1) NOT NULL DEFAULT '1',
  `template` varchar(64) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_report_1_idx` (`reporting_category_id`),
  KEY `fk_report_2_idx` (`reporting_authorization_id`),
  CONSTRAINT `fk_report_1` FOREIGN KEY (`reporting_category_id`) REFERENCES `reporting_category` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_report_2` FOREIGN KEY (`reporting_authorization_id`) REFERENCES `reporting_authorization` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;

INSERT INTO `reporting` VALUES (1,0,'2015-02-16 15:51:41',3,1,'reporting.roadmap.name','reporting.roadmap.description',0,1,1,'roadmap'),(2,0,'2015-02-16 15:51:42',3,2,'reporting.portfolios.name','reporting.portfolios.description',0,1,1,'portfolios'),(3,0,'2015-02-16 15:51:42',3,3,'reporting.financial.name','reporting.financial.description',0,1,1,'financial'),(4,0,'2015-02-16 15:51:46',3,4,'reporting.actor_allocation.name','reporting.actor_allocation.description',0,1,1,'actor_allocation'),(5,0,'2015-02-16 15:51:46',3,5,'reporting.org_unit_allocation.name','reporting.org_unit_allocation.description',0,1,1,'org_unit_allocation'),(6,0,'2015-02-16 15:51:46',3,6,'reporting.org_unit_actors_allocation.name','reporting.org_unit_actors_allocation.description',0,1,1,'org_unit_actors_allocation'),(7,0,'2015-02-16 15:51:48',3,7,'reporting.data_quality.name','reporting.data_quality.description',0,1,1,'data_quality'),(8,0,'2015-02-16 15:51:49',3,8,'report.release_requirements.name','report.release_requirements.description',0,1,1,'release_requirements');

CREATE TABLE `reporting_authorization` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `expression` varchar(256) NOT NULL,
  `type` int(1) NOT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `last_update` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;

INSERT INTO `reporting_authorization` VALUES (1,'reporting.roadmap',0,0,'2015-02-16 15:51:41'),(2,'reporting.portfolios',0,0,'2015-02-16 15:51:42'),(3,'reporting.financial',0,0,'2015-02-16 15:51:42'),(4,'reporting.actor_allocation',0,0,'2015-02-16 15:51:46'),(5,'reporting.org_unit_allocation',0,0,'2015-02-16 15:51:46'),(6,'reporting.org_unit_actors_allocation',0,0,'2015-02-16 15:51:46'),(7,'reporting.data_quality',0,0,'2015-02-16 15:51:48'),(8,'reporting.release_requirements',0,0,'2015-02-16 15:51:49');

CREATE TABLE `reporting_category` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `deleted` tinyint(1) DEFAULT '0',
  `last_update` datetime NOT NULL,
  `name` varchar(64) NOT NULL,
  `manageable` tinyint(1) DEFAULT '1',
  `order` int(11) NOT NULL,
  `parent_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_reporting_category_1_idx` (`parent_id`),
  CONSTRAINT `fk_reporting_category_1` FOREIGN KEY (`parent_id`) REFERENCES `reporting_category` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

INSERT INTO `reporting_category` VALUES (3,0,'2015-02-16 15:51:41','reporting_category.default.name',0,10,NULL);

CREATE TABLE `requirement` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `deleted` tinyint(1) DEFAULT '0',
  `last_update` datetime NOT NULL,
  `is_defect` tinyint(1) NOT NULL,
  `portfolio_entry_id` bigint(20) NOT NULL,
  `external_ref_id` varchar(64) DEFAULT NULL,
  `external_link` varchar(256) DEFAULT NULL,
  `name` varchar(256) NOT NULL,
  `description` longtext,
  `category` varchar(64) DEFAULT NULL,
  `requirement_status_id` bigint(20) DEFAULT NULL,
  `requirement_priority_id` bigint(20) DEFAULT NULL,
  `requirement_severity_id` bigint(20) DEFAULT NULL,
  `author_id` bigint(20) DEFAULT NULL,
  `story_points` int(11) DEFAULT NULL,
  `initial_estimation` int(11) DEFAULT NULL,
  `is_scoped` tinyint(1) DEFAULT NULL,
  `iteration_id` bigint(20) DEFAULT NULL,
  `release_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_requirement_1_idx` (`author_id`),
  KEY `fk_requirement_2_idx` (`portfolio_entry_id`),
  KEY `fk_requirement_3_idx` (`requirement_priority_id`),
  KEY `fk_requirement_4_idx` (`requirement_status_id`),
  KEY `fk_requirement_5_idx` (`requirement_severity_id`),
  KEY `fk_requirement_6_idx` (`iteration_id`),
  KEY `fk_requirement_7_idx` (`release_id`),
  CONSTRAINT `fk_requirement_7` FOREIGN KEY (`release_id`) REFERENCES `release` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_requirement_1` FOREIGN KEY (`author_id`) REFERENCES `actor` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_requirement_2` FOREIGN KEY (`portfolio_entry_id`) REFERENCES `portfolio_entry` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_requirement_3` FOREIGN KEY (`requirement_priority_id`) REFERENCES `requirement_priority` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_requirement_4` FOREIGN KEY (`requirement_status_id`) REFERENCES `requirement_status` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_requirement_5` FOREIGN KEY (`requirement_severity_id`) REFERENCES `requirement_severity` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_requirement_6` FOREIGN KEY (`iteration_id`) REFERENCES `iteration` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `requirement_priority` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `deleted` tinyint(1) DEFAULT '0',
  `last_update` datetime NOT NULL,
  `name` varchar(64) NOT NULL,
  `description` varchar(1500) DEFAULT NULL,
  `is_must` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `requirement_severity` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `deleted` tinyint(1) DEFAULT '0',
  `last_update` datetime NOT NULL,
  `name` varchar(64) NOT NULL,
  `description` varchar(1500) DEFAULT NULL,
  `is_blocker` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `requirement_status` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `deleted` tinyint(1) DEFAULT '0',
  `last_update` datetime NOT NULL,
  `type` varchar(64) NOT NULL,
  `name` varchar(64) NOT NULL,
  `description` varchar(1500) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `stakeholder` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `deleted` tinyint(1) DEFAULT '0',
  `stakeholder_type_id` bigint(20) DEFAULT NULL,
  `actor_id` bigint(20) DEFAULT NULL,
  `portfolio_entry_id` bigint(20) DEFAULT NULL,
  `portfolio_id` bigint(20) DEFAULT NULL,
  `last_update` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ix_stakeholder_stakeholderType_17` (`stakeholder_type_id`),
  KEY `ix_stakeholder_actor_18` (`actor_id`),
  KEY `ix_stakeholder_portfolio_entry_19` (`portfolio_entry_id`),
  KEY `ix_stakeholder_portfolio_20` (`portfolio_id`),
  CONSTRAINT `fk_stakeholder_portfolio_20` FOREIGN KEY (`portfolio_id`) REFERENCES `portfolio` (`id`),
  CONSTRAINT `fk_stakeholder_portfolio_entry_19` FOREIGN KEY (`portfolio_entry_id`) REFERENCES `portfolio_entry` (`id`),
  CONSTRAINT `fk_stakeholder_actor_18` FOREIGN KEY (`actor_id`) REFERENCES `actor` (`id`),
  CONSTRAINT `fk_stakeholder_stakeholderType_17` FOREIGN KEY (`stakeholder_type_id`) REFERENCES `stakeholder_type` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `stakeholder_type` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `deleted` tinyint(1) DEFAULT '0',
  `name` varchar(64) NOT NULL,
  `description` varchar(1500) DEFAULT NULL,
  `selectable` tinyint(1) DEFAULT '1',
  `last_update` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name_UNIQUE` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `stattalend` (
  `moment` datetime DEFAULT NULL,
  `pid` varchar(20) DEFAULT NULL,
  `father_pid` varchar(20) DEFAULT NULL,
  `root_pid` varchar(20) DEFAULT NULL,
  `system_pid` bigint(20) DEFAULT NULL,
  `project` varchar(50) DEFAULT NULL,
  `job` varchar(255) DEFAULT NULL,
  `job_repository_id` varchar(255) DEFAULT NULL,
  `job_version` varchar(255) DEFAULT NULL,
  `context` varchar(50) DEFAULT NULL,
  `origin` varchar(255) DEFAULT NULL,
  `message_type` varchar(255) DEFAULT NULL,
  `message` varchar(255) DEFAULT NULL,
  `duration` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `supplier` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `deleted` tinyint(1) DEFAULT '0',
  `ref_id` varchar(64) DEFAULT NULL,
  `name` varchar(256) NOT NULL,
  `last_update` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `name_index` (`name`),
  KEY `ref_id_index` (`ref_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `system_permission` VALUES (1,'ROADMAP_DISPLAY_PERMISSION','permission.roadmap_display_permission.description',0,1,'2015-02-16 15:51:36'),(2,'COCKPIT_DISPLAY_PERMISSION','permission.cockpit_display_permission.description',0,1,'2015-02-16 15:51:36'),(3,'PORTFOLIO_ENTRY_VIEW_PUBLIC_PERMISSION','permission.portfolio_entry_view_public_permission.description',0,1,'2015-02-16 15:51:36'),(4,'PORTFOLIO_ENTRY_VIEW_DETAILS_ALL_PERMISSION','permission.portfolio_entry_view_details_all_permission.description',0,1,'2015-02-16 15:51:36'),(5,'PORTFOLIO_ENTRY_VIEW_DETAILS_AS_MANAGER_PERMISSION','permission.portfolio_entry_view_details_as_manager_permission.description',0,1,'2015-02-16 15:51:36'),(6,'PORTFOLIO_ENTRY_VIEW_DETAILS_AS_STAKEHOLDER_PERMISSION','permission.portfolio_entry_view_details_as_stakeholder_permission.description',0,1,'2015-02-16 15:51:36'),(7,'PORTFOLIO_ENTRY_VIEW_DETAILS_AS_PORTFOLIO_MANAGER_PERMISSION','permission.portfolio_entry_view_details_as_portfolio_manager_permission.description',0,1,'2015-02-16 15:51:36'),(8,'PORTFOLIO_ENTRY_EDIT_ALL_PERMISSION','permission.portfolio_entry_edit_all_permission.description',0,1,'2015-02-16 15:51:36'),(9,'PORTFOLIO_ENTRY_EDIT_AS_MANAGER_PERMISSION','permission.portfolio_entry_edit_as_manager_permission.description',0,1,'2015-02-16 15:51:36'),(10,'PORTFOLIO_ENTRY_EDIT_AS_PORTFOLIO_MANAGER_PERMISSION','permission.portfolio_entry_edit_as_portfolio_manager_permission.description',0,1,'2015-02-16 15:51:36'),(11,'PORTFOLIO_ENTRY_VIEW_FINANCIAL_INFO_ALL_PERMISSION','permission.portfolio_entry_view_financial_info_all_permission.description',0,1,'2015-02-16 15:51:36'),(12,'PORTFOLIO_ENTRY_VIEW_FINANCIAL_INFO_AS_MANAGER_PERMISSION','permission.portfolio_entry_view_financial_info_as_manager_permission.description',0,1,'2015-02-16 15:51:36'),(13,'PORTFOLIO_ENTRY_VIEW_FINANCIAL_INFO_AS_PORTFOLIO_MANAGER_PERMISSION','permission.portfolio_entry_view_financial_info_as_portfolio_manager_permission.description',0,1,'2015-02-16 15:51:36'),(14,'PORTFOLIO_ENTRY_DELETE_ALL_PERMISSION','permission.portfolio_entry_delete_all_permission.description',0,1,'2015-02-16 15:51:36'),(15,'ADMIN_USER_ADMINISTRATION_PERMISSION','permission.admin_user_administration_permission.description',0,1,'2015-02-16 15:51:36'),(16,'ADMIN_HUB_MONITORING_PERMISSION','permission.admin_hub_monitoring_permission.description',0,1,'2015-02-16 15:51:36'),(17,'ADMIN_AUDIT_LOG_PERMISSION','permission.admin_audit_log_permission.description',0,1,'2015-02-16 15:51:36'),(18,'PERSONAL_SPACE_READ_PERMISSION','permission.personal_space_read_permission.description',0,1,'2015-02-16 15:51:36'),(21,'ADMIN_PROVISIONING_MANAGER_PERMISSION','permission.admin_provisioning_manager_permission.description',0,1,'2015-02-16 15:51:36'),(23,'SCM_DEVELOPER_PERMISSION','permission.scm_developer_permission.description',0,1,'2015-02-16 15:51:36'),(24,'SCM_ADMIN_PERMISSION','permission.scm_admin_permission.description',0,1,'2015-02-16 15:51:36'),(27,'PORTFOLIO_ENTRY_SUBMISSION_PERMISSION','permission.portfolio_entry_submission_permission.description',0,1,'2015-02-16 15:51:36'),(28,'ADMIN_CONFIGURATION_PERMISSION','permission.admin_configuration_permission.description',0,1,'2015-02-16 15:51:36'),(29,'MILESTONE_APPROVAL_PERMISSION','permission.milestone_approval_permission.description',0,1,'2015-02-16 15:51:36'),(32,'SEARCH_PERMISSION','permission.search_permission.description',0,1,'2015-02-16 15:51:36'),(33,'ACTOR_VIEW_ALL_PERMISSION','permission.actor_view_all_permission.description',0,1,'2015-02-16 15:51:36'),(34,'ACTOR_EDIT_ALL_PERMISSION','permission.actor_edit_all_permission.description',0,1,'2015-02-16 15:51:36'),(35,'ORG_UNIT_VIEW_ALL_PERMISSION','permission.org_unit_view_all_permission.description',0,1,'2015-02-16 15:51:36'),(36,'ORG_UNIT_EDIT_ALL_PERMISSION','permission.org_unit_edit_all_permission.description',0,1,'2015-02-16 15:51:36'),(37,'PORTFOLIO_VIEW_DETAILS_ALL_PERMISSION','permission.portfolio_view_details_all_permission.description',0,1,'2015-02-16 15:51:36'),(38,'PORTFOLIO_EDIT_ALL_PERMISSION','permission.portfolio_edit_all_permission.description',0,1,'2015-02-16 15:51:36'),(39,'PORTFOLIO_EDIT_AS_PORTFOLIO_MANAGER_PERMISSION','permission.portfolio_edit_as_portfolio_manager_permission.description',0,1,'2015-02-16 15:51:36'),(40,'PORTFOLIO_ENTRY_REVIEW_REQUEST_ALL_PERMISSION','permission.portfolio_entry_review_request_all_permission.description',0,1,'2015-02-16 15:51:36'),(41,'PORTFOLIO_ENTRY_REVIEW_REQUEST_AS_PORTFOLIO_MANAGER_PERMISSION','permission.portfolio_entry_review_request_as_portfolio_manager_permission.description',0,1,'2015-02-16 15:51:36'),(42,'MILESTONE_DECIDE_PERMISSION','permission.milestone_decide_permission.description',0,1,'2015-02-16 15:51:36'),(43,'PORTFOLIO_ENTRY_VIEW_FINANCIAL_INFO_AS_STAKEHOLDER_PERMISSION','permission.portfolio_entry_view_financial_info_as_stakeholder_permission.description',0,1,'2015-02-16 15:51:36'),(44,'PORTFOLIO_ENTRY_EDIT_FINANCIAL_INFO_ALL_PERMISSION','permission.portfolio_entry_edit_financial_info_all_permission.description',0,1,'2015-02-16 15:51:36'),(45,'PORTFOLIO_ENTRY_EDIT_FINANCIAL_INFO_AS_MANAGER_PERMISSION','permission.portfolio_entry_edit_financial_info_as_manager_permission.description',0,1,'2015-02-16 15:51:36'),(46,'PURCHASE_ORDER_VIEW_ALL_PERMISSION','permission.purchase_order_view_all_permission.description',0,1,'2015-02-16 15:51:37'),(49,'BUDGET_BUCKET_VIEW_ALL_PERMISSION','permission.budget_bucket_view_all_permission.description',0,1,'2015-02-16 15:51:38'),(50,'BUDGET_BUCKET_VIEW_AS_OWNER_PERMISSION','permission.budget_bucket_view_as_owner_permission.description',0,1,'2015-02-16 15:51:38'),(51,'BUDGET_BUCKET_EDIT_ALL_PERMISSION','permission.budget_bucket_edit_all_permission.description',0,1,'2015-02-16 15:51:38'),(52,'BUDGET_BUCKET_EDIT_AS_OWNER_PERMISSION','permission.budget_bucket_edit_as_owner_permission.description',0,1,'2015-02-16 15:51:38'),(53,'REPORTING_VIEW_ALL_PERMISSION','permission.reporting_view_all_permission.description',0,1,'2015-02-16 15:51:40'),(54,'REPORTING_VIEW_AS_VIEWER_PERMISSION','permission.reporting_view_as_viewer_permission.description',0,1,'2015-02-16 15:51:40'),(55,'REPORTING_ADMINISTRATION_PERMISSION','permission.reporting_administration_permission.description',0,1,'2015-02-16 15:51:40'),(56,'MILESTONE_OVERVIEW_PERMISSION','permission.milestone_overview_permission.description',0,1,'2015-02-16 15:51:43'),(57,'PORTFOLIO_VIEW_DETAILS_AS_MANAGER_PERMISSION','permission.portfolio_view_details_as_manager_permission.description',0,1,'2015-02-16 15:51:43'),(58,'PORTFOLIO_VIEW_DETAILS_AS_STAKEHOLDER_PERMISSION','permission.portfolio_view_details_as_stakeholder_permission.description',0,1,'2015-02-16 15:51:43'),(59,'PORTFOLIO_VIEW_FINANCIAL_INFO_ALL_PERMISSION','permission.portfolio_view_financial_info_all_permission.description',0,1,'2015-02-16 15:51:43'),(60,'PORTFOLIO_VIEW_FINANCIAL_INFO_AS_MANAGER_PERMISSION','permission.portfolio_view_financial_info_as_manager_permission.description',0,1,'2015-02-16 15:51:43'),(61,'JENKINS_VIEWER_PERMISSION','permission.jenkins_viewer_permission.description',0,1,'2015-02-16 15:51:43'),(62,'JENKINS_DEPLOY_PERMISSION','permission.jenkins_deploy_permission.description',0,1,'2015-02-16 15:51:43'),(63,'TIMESHEET_ENTRY_PERMISSION','permission.timesheet_entry_permission.description',0,1,'2015-02-16 15:51:43'),(64,'TIMESHEET_APPROVAL_ALL_PERMISSION','permission.timesheet_approval_all_permission.description',0,1,'2015-02-16 15:51:43'),(65,'TIMESHEET_APPROVAL_AS_MANAGER_PERMISSION','permission.timesheet_approval_as_manager_permission.description',0,1,'2015-02-16 15:51:43'),(66,'TIMESHEET_LOCK_ALL_PERMISSION','permission.timesheet_lock_all_permission.description',0,1,'2015-02-16 15:51:43'),(68,'ADMIN_PLUGIN_MANAGER_PERMISSION','permission.admin_plugin_manager_permission.description',0,1,'2015-02-16 15:51:44'),(69,'ADMIN_SYSTEM_OWNER_PERMISSION','permission.admin.system_owner.description',0,1,'2015-02-16 15:51:45'),(70,'ADMIN_KPI_MANAGER_PERMISSION','permission.admin_kpi_manager_permission.description',0,1,'2015-02-16 15:51:45'),(71,'ACTOR_VIEW_AS_SUPERIOR_PERMISSION','permission.actor_view_as_superior_permission.description',0,1,'2015-02-16 15:51:46'),(72,'ORG_UNIT_VIEW_AS_RESPONSIBLE_PERMISSION','permission.org_unit_view_as_responsible_permission.description',0,1,'2015-02-16 15:51:46'),(73,'RELEASE_VIEW_ALL_PERMISSION','permission.release_view_all_permission.description',0,1,'2015-02-16 15:51:49'),(74,'RELEASE_VIEW_AS_MANAGER_PERMISSION','permission.release_view_as_manager_permission.description',0,1,'2015-02-16 15:51:49'),(75,'RELEASE_EDIT_ALL_PERMISSION','permission.release_edit_all_permission.description',0,1,'2015-02-16 15:51:49'),(76,'RELEASE_EDIT_AS_MANAGER_PERMISSION','permission.release_edit_as_manager_permission.description',0,1,'2015-02-16 15:51:49');

CREATE TABLE `timesheet_activity` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `deleted` tinyint(1) DEFAULT '0',
  `last_update` datetime NOT NULL,
  `name` varchar(64) NOT NULL,
  `description` varchar(1500) DEFAULT NULL,
  `timesheet_activity_type_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_timesheet_activity_1_idx` (`timesheet_activity_type_id`),
  CONSTRAINT `fk_timesheet_activity_1` FOREIGN KEY (`timesheet_activity_type_id`) REFERENCES `timesheet_activity_type` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `timesheet_activity_type` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `deleted` tinyint(1) DEFAULT '0',
  `last_update` datetime NOT NULL,
  `name` varchar(64) NOT NULL,
  `description` varchar(1500) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `timesheet_entry` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `deleted` tinyint(1) DEFAULT '0',
  `last_update` datetime NOT NULL,
  `timesheet_report_id` bigint(20) NOT NULL,
  `portfolio_entry_id` bigint(20) DEFAULT NULL,
  `portfolio_entry_planning_package_id` bigint(20) DEFAULT NULL,
  `timesheet_activity_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_timesheet_entry_1_idx` (`timesheet_report_id`),
  KEY `fk_timesheet_entry_2_idx` (`portfolio_entry_id`),
  KEY `fk_timesheet_entry_3_idx` (`portfolio_entry_planning_package_id`),
  KEY `fk_timesheet_entry_4_idx` (`timesheet_activity_id`),
  CONSTRAINT `fk_timesheet_entry_1` FOREIGN KEY (`timesheet_report_id`) REFERENCES `timesheet_report` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_timesheet_entry_2` FOREIGN KEY (`portfolio_entry_id`) REFERENCES `portfolio_entry` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_timesheet_entry_3` FOREIGN KEY (`portfolio_entry_planning_package_id`) REFERENCES `portfolio_entry_planning_package` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_timesheet_entry_4` FOREIGN KEY (`timesheet_activity_id`) REFERENCES `timesheet_activity` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `timesheet_log` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `deleted` tinyint(1) DEFAULT '0',
  `last_update` datetime NOT NULL,
  `timesheet_entry_id` bigint(20) NOT NULL,
  `log_date` datetime NOT NULL,
  `hours` decimal(12,2) DEFAULT '0.00',
  PRIMARY KEY (`id`),
  KEY `fk_timesheet_log_1_idx` (`timesheet_entry_id`),
  KEY `timesheet_log_1_idx` (`log_date`),
  CONSTRAINT `fk_timesheet_log_1` FOREIGN KEY (`timesheet_entry_id`) REFERENCES `timesheet_entry` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `timesheet_report` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `deleted` tinyint(1) DEFAULT '0',
  `last_update` datetime NOT NULL,
  `actor_id` bigint(20) NOT NULL,
  `type` varchar(32) NOT NULL,
  `start_date` datetime NOT NULL,
  `status` varchar(32) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_timesheet_report_1_idx` (`actor_id`),
  CONSTRAINT `fk_timesheet_report_1` FOREIGN KEY (`actor_id`) REFERENCES `actor` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `work_order` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `deleted` tinyint(1) DEFAULT '0',
  `last_update` datetime NOT NULL,
  `creation_date` datetime NOT NULL,
  `due_date` datetime DEFAULT NULL,
  `name` varchar(64) NOT NULL,
  `description` varchar(1500) DEFAULT NULL,
  `amount` decimal(12,2) DEFAULT NULL,
  `amount_received` decimal(12,2) DEFAULT NULL,
  `is_opex` tinyint(1) DEFAULT '0',
  `currency_code` varchar(3) DEFAULT NULL,
  `shared` tinyint(1) DEFAULT '0',
  `portfolio_entry_id` bigint(20) NOT NULL,
  `purchase_order_line_item_id` bigint(20) DEFAULT NULL,
  `is_engaged` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fk_work_order_portfolio_entry1_idx` (`portfolio_entry_id`),
  KEY `fk_work_order_purchase_order_line_item1_idx` (`purchase_order_line_item_id`),
  KEY `fk_work_order_1_idx` (`currency_code`),
  CONSTRAINT `fk_work_order_1` FOREIGN KEY (`currency_code`) REFERENCES `currency` (`code`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_work_order_portfolio_entry1` FOREIGN KEY (`portfolio_entry_id`) REFERENCES `portfolio_entry` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_work_order_purchase_order_line_item1` FOREIGN KEY (`purchase_order_line_item_id`) REFERENCES `purchase_order_line_item` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE VIEW `v_use_purchase_order` AS select 1 AS `flag` union select 0 AS `flag`;

CREATE VIEW `v_pe_budget` AS (select `pe`.`id` AS `id`,`pebl`.`currency_code` AS `currency_code`,`pebl`.`is_opex` AS `is_opex`,sum(`pebl`.`amount`) AS `budget` from (((`portfolio_entry_budget_line` `pebl` join `portfolio_entry_budget` `peb` on((`pebl`.`portfolio_entry_budget_id` = `peb`.`id`))) join `life_cycle_instance_planning` `lcip` on((`peb`.`id` = `lcip`.`portfolio_entry_budget_id`))) join `portfolio_entry` `pe` on((`lcip`.`life_cycle_instance_id` = `pe`.`active_life_cycle_instance_id`))) where ((`pebl`.`deleted` = 0) and (`peb`.`deleted` = 0) and (`lcip`.`deleted` = 0) and (`lcip`.`is_frozen` = 0)) group by `pe`.`id`,`pebl`.`currency_code`,`pebl`.`is_opex`);

CREATE VIEW `v_pe_cost_to_complete_rows` AS (select `pe`.`id` AS `id`,`wo`.`currency_code` AS `currency_code`,`wo`.`is_opex` AS `is_opex`,sum(`wo`.`amount`) AS `cost_to_complete`,1 AS `use_purchase_order` from (`work_order` `wo` join `portfolio_entry` `pe` on((`wo`.`portfolio_entry_id` = `pe`.`id`))) where (isnull(`wo`.`purchase_order_line_item_id`) and (`wo`.`deleted` = 0)) group by `pe`.`id`,`wo`.`currency_code`,`wo`.`is_opex`) union (select `pe`.`id` AS `id`,`wo`.`currency_code` AS `currency_code`,`wo`.`is_opex` AS `is_opex`,sum(`wo`.`amount`) AS `cost_to_complete`,1 AS `use_purchase_order` from ((`work_order` `wo` join `portfolio_entry` `pe` on((`wo`.`portfolio_entry_id` = `pe`.`id`))) join `purchase_order_line_item` `poli` on((`wo`.`purchase_order_line_item_id` = `poli`.`id`))) where (((`poli`.`deleted` = 1) or (`poli`.`is_cancelled` = 1)) and (`wo`.`deleted` = 0)) group by `pe`.`id`,`wo`.`currency_code`,`wo`.`is_opex`) union (select `pe`.`id` AS `id`,`wo`.`currency_code` AS `currency_code`,`wo`.`is_opex` AS `is_opex`,sum(`wo`.`amount`) AS `cost_to_complete`,0 AS `use_purchase_order` from (`work_order` `wo` join `portfolio_entry` `pe` on((`wo`.`portfolio_entry_id` = `pe`.`id`))) where ((`wo`.`is_engaged` = 0) and (`wo`.`deleted` = 0)) group by `pe`.`id`,`wo`.`currency_code`,`wo`.`is_opex`);

CREATE VIEW `v_pe_cost_to_complete` AS (select `v_pe_cost_to_complete_rows`.`id` AS `id`,`v_pe_cost_to_complete_rows`.`currency_code` AS `currency_code`,`v_pe_cost_to_complete_rows`.`is_opex` AS `is_opex`,sum(`v_pe_cost_to_complete_rows`.`cost_to_complete`) AS `cost_to_complete`,`v_pe_cost_to_complete_rows`.`use_purchase_order` AS `use_purchase_order` from `v_pe_cost_to_complete_rows` group by `v_pe_cost_to_complete_rows`.`id`,`v_pe_cost_to_complete_rows`.`currency_code`,`v_pe_cost_to_complete_rows`.`is_opex`,`v_pe_cost_to_complete_rows`.`use_purchase_order`);

CREATE VIEW `v_pe_engaged_rows` AS (select `pe`.`id` AS `id`,`wo`.`currency_code` AS `currency_code`,`wo`.`is_opex` AS `is_opex`,sum(`wo`.`amount`) AS `engaged`,1 AS `use_purchase_order` from ((`work_order` `wo` join `portfolio_entry` `pe` on((`wo`.`portfolio_entry_id` = `pe`.`id`))) join `purchase_order_line_item` `poli` on((`wo`.`purchase_order_line_item_id` = `poli`.`id`))) where ((`poli`.`deleted` = 0) and (`poli`.`is_cancelled` = 0) and (`wo`.`deleted` = 0)) group by `pe`.`id`,`wo`.`currency_code`,`wo`.`is_opex`) union (select `pe`.`id` AS `id`,`poli`.`currency_code` AS `currency_code`,`poli`.`is_opex` AS `is_opex`,sum(`poli`.`amount`) AS `engaged`,1 AS `use_purchase_order` from (((`purchase_order_line_item` `poli` join `purchase_order` `po` on((`poli`.`purchase_order_id` = `po`.`id`))) join `portfolio_entry` `pe` on((`po`.`portfolio_entry_id` = `pe`.`id`))) left join `work_order` `wo` on((`poli`.`id` = `wo`.`purchase_order_line_item_id`))) where ((`poli`.`deleted` = 0) and (`poli`.`is_cancelled` = 0) and (`po`.`deleted` = 0) and (`po`.`is_cancelled` = 0) and isnull(`wo`.`purchase_order_line_item_id`)) group by `pe`.`id`,`poli`.`currency_code`,`poli`.`is_opex`) union (select `pe`.`id` AS `id`,`wo`.`currency_code` AS `currency_code`,`wo`.`is_opex` AS `is_opex`,sum(`wo`.`amount`) AS `engaged`,0 AS `use_purchase_order` from (`work_order` `wo` join `portfolio_entry` `pe` on((`wo`.`portfolio_entry_id` = `pe`.`id`))) where ((`wo`.`is_engaged` = 1) and (`wo`.`deleted` = 0)) group by `pe`.`id`,`wo`.`currency_code`,`wo`.`is_opex`);

CREATE VIEW `v_pe_engaged` AS (select `t`.`id` AS `id`,`t`.`currency_code` AS `currency_code`,`t`.`is_opex` AS `is_opex`,sum(`t`.`engaged`) AS `engaged`,`t`.`use_purchase_order` AS `use_purchase_order` from `v_pe_engaged_rows` `t` group by `t`.`id`,`t`.`currency_code`,`t`.`is_opex`,`t`.`use_purchase_order`);

CREATE VIEW `v_pe_financial` AS (select `pe`.`id` AS `id`,`c`.`code` AS `currency_code`,`upo`.`flag` AS `use_purchase_order`,ifnull((select `peb`.`budget` from `v_pe_budget` `peb` where ((`peb`.`currency_code` = `c`.`code`) and (`peb`.`is_opex` = 0) and (`peb`.`id` = `pe`.`id`))),0) AS `capex_budget`,ifnull((select `peb`.`budget` from `v_pe_budget` `peb` where ((`peb`.`currency_code` = `c`.`code`) and (`peb`.`is_opex` = 1) and (`peb`.`id` = `pe`.`id`))),0) AS `opex_budget`,ifnull((select `pecc`.`cost_to_complete` from `v_pe_cost_to_complete` `pecc` where ((`pecc`.`currency_code` = `c`.`code`) and (`pecc`.`is_opex` = 0) and (`pecc`.`id` = `pe`.`id`) and (`pecc`.`use_purchase_order` = `upo`.`flag`))),0) AS `capex_cost_to_complete`,ifnull((select `pecc`.`cost_to_complete` from `v_pe_cost_to_complete` `pecc` where ((`pecc`.`currency_code` = `c`.`code`) and (`pecc`.`is_opex` = 1) and (`pecc`.`id` = `pe`.`id`) and (`pecc`.`use_purchase_order` = `upo`.`flag`))),0) AS `opex_cost_to_complete`,ifnull((select `pee`.`engaged` from `v_pe_engaged` `pee` where ((`pee`.`currency_code` = `c`.`code`) and (`pee`.`is_opex` = 0) and (`pee`.`id` = `pe`.`id`) and (`pee`.`use_purchase_order` = `upo`.`flag`))),0) AS `capex_engaged`,ifnull((select `pee`.`engaged` from `v_pe_engaged` `pee` where ((`pee`.`currency_code` = `c`.`code`) and (`pee`.`is_opex` = 1) and (`pee`.`id` = `pe`.`id`) and (`pee`.`use_purchase_order` = `upo`.`flag`))),0) AS `opex_engaged` from ((`portfolio_entry` `pe` join `currency` `c`) join `v_use_purchase_order` `upo`) where ((`pe`.`deleted` = 0) and (`c`.`deleted` = 0) and (`c`.`is_active` = 1)));

CREATE VIEW `v_profile` AS select distinct `p`.`uid` AS `username`,'groups' AS `attr_name`,`sp`.`name` AS `attr_value` from ((((`system_level_role` `r` join `system_level_role_type` `rt` on((`r`.`system_level_role_type_id` = `rt`.`id`))) join `principal` `p` on((`r`.`principal_id` = `p`.`id`))) join `system_level_role_type_has_system_permission` `rt_sp` on((`rt`.`id` = `rt_sp`.`system_level_role_type_id`))) join `system_permission` `sp` on((`rt_sp`.`system_permission_id` = `sp`.`id`))) where ((`rt`.`deleted` = 0) and (`p`.`deleted` = 0) and (`sp`.`deleted` = 0));

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

--//@UNDO


