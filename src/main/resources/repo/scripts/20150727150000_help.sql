--help target

INSERT INTO `help_target` (`last_update`, `route`, `target`) VALUES (NOW(), '/architecture', 'user-guide:architecture');
INSERT INTO `help_target` (`last_update`, `route`, `target`) VALUES (NOW(), '/architecture/application-blocks', 'user-guide:architecture:application-block');
INSERT INTO `help_target` (`last_update`, `route`, `target`) VALUES (NOW(), '/admin/config/ref-data/portfolio-entry-dependency-type/manage', 'admin-guide:configuration:reference-data:initiatives-and-portfolios');
INSERT INTO `help_target` (`last_update`, `route`, `target`) VALUES (NOW(), '/portfolio-entry/dependency/add', 'user-guide:initiative');
INSERT INTO `help_target` (`last_update`, `route`, `target`) VALUES (NOW(), '/orgunit/allocated-activity/actor/manage', 'user-guide:entity:orgunit');
INSERT INTO `help_target` (`last_update`, `route`, `target`) VALUES (NOW(), '/admin/kpi/create', 'admin-guide:kpi');
DELETE FROM `help_target` WHERE `route`='/release/initiatives' LIMIT 1;

--//@UNDO


