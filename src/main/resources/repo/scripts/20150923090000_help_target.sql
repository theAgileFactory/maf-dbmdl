
UPDATE help_target SET target='user-guide:initiative:integration-plugin' WHERE route='/portfolio-entry/plugin/config' LIMIT 1;

INSERT INTO `help_target` (`last_update`, `route`, `target`) VALUES (NOW(), '/portfolio-entry/timesheets', 'user-guide:initiative:status-reporting');

INSERT INTO `help_target` (`last_update`, `route`, `target`) VALUES (NOW(), '/portfolio-entry/data-syndication', 'user-guide:initiative:integration-partner-syndication');
INSERT INTO `help_target` (`last_update`, `route`, `target`) VALUES (NOW(), '/portfolio-entry/data-syndication/link/view', 'user-guide:initiative:integration-partner-syndication');
INSERT INTO `help_target` (`last_update`, `route`, `target`) VALUES (NOW(), '/portfolio-entry/data-syndication/link/submit', 'user-guide:initiative:integration-partner-syndication');

INSERT INTO `help_target` (`last_update`, `route`, `target`) VALUES (NOW(), '/admin/data-syndication/master-agreements', 'admin-guide:partner-syndication');
INSERT INTO `help_target` (`last_update`, `route`, `target`) VALUES (NOW(), '/admin/data-syndication/consumer-agreements', 'admin-guide:partner-syndication');
INSERT INTO `help_target` (`last_update`, `route`, `target`) VALUES (NOW(), '/admin/data-syndication/partner/search', 'admin-guide:partner-syndication');
INSERT INTO `help_target` (`last_update`, `route`, `target`) VALUES (NOW(), '/admin/data-syndication/agreement/submit', 'admin-guide:partner-syndication');
INSERT INTO `help_target` (`last_update`, `route`, `target`) VALUES (NOW(), '/admin/data-syndication/agreement/submit/no-slave', 'admin-guide:partner-syndication');
INSERT INTO `help_target` (`last_update`, `route`, `target`) VALUES (NOW(), '/admin/data-syndication/agreement/view', 'admin-guide:partner-syndication');
INSERT INTO `help_target` (`last_update`, `route`, `target`) VALUES (NOW(), '/admin/data-syndication/agreement/process', 'admin-guide:partner-syndication');
INSERT INTO `help_target` (`last_update`, `route`, `target`) VALUES (NOW(), '/admin/data-syndication/agreement/link/process', 'admin-guide:partner-syndication');

--//@UNDO



