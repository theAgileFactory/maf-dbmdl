DELETE FROM `help_target` WHERE route='/portfolio-entry/custom-attr/edit' LIMIT 1;

INSERT INTO `help_target` (`last_update`, `route`, `target`) VALUES (NOW(), '/admin/config/translation/search', 'admin-guide:configuration:translations');
INSERT INTO `help_target` (`last_update`, `route`, `target`) VALUES (NOW(), '/admin/config/translation/search/results', 'admin-guide:configuration:translations');
INSERT INTO `help_target` (`last_update`, `route`, `target`) VALUES (NOW(), '/admin/config/translation/edit', 'admin-guide:configuration:translations');

INSERT INTO `help_target` (`last_update`, `route`, `target`) VALUES (NOW(), '/admin/config/ref-data/package/type/manage', 'admin-guide:configuration:reference-data:packages');

INSERT INTO `help_target` (`last_update`, `route`, `target`) VALUES (NOW(), '/portfolio-entry/packages/manage', 'user-guide:initiative:planning');

DELETE FROM `help_target` WHERE route = '/portfolio-entry/create/1' LIMIT 1;

--//@UNDO






