--Help target

UPDATE help_target SET target='admin-guide:plugins:redmine-plugin-integrated' WHERE route='/admin/plugin/definition/redm1';
UPDATE help_target SET target='admin-guide:plugins:jenkins-plugin-integrated' WHERE route='/admin/plugin/definition/jenk1';
UPDATE help_target SET target='admin-guide:plugins:bizdock-internal-plugins:employee-loader-plugin' WHERE route='/admin/plugin/definition/actorsload1';
UPDATE help_target SET target='admin-guide:plugins:svn-plugin-integrated' WHERE route='/admin/plugin/definition/subv1';
UPDATE help_target SET target='admin-guide:plugins:bizdock-internal-plugins:financial-integration-plugin' WHERE route='/admin/plugin/definition/finance1';
UPDATE help_target SET target='admin-guide:plugins:jira-plugin' WHERE route='/admin/plugin/definition/jira1';
UPDATE help_target SET target='admin-guide:plugins:nexus-plugin-integrated' WHERE route='/admin/plugin/definition/nex1';
UPDATE help_target SET target='admin-guide:plugins:bizdock-internal-plugins:bizdock-event-handler' WHERE route='/admin/plugin/definition/notification1';
UPDATE help_target SET target='admin-guide:plugins' WHERE route='/admin/plugin/definition/sharp1';
UPDATE help_target SET target='admin-guide:plugins:redmine-plugin' WHERE route='/admin/plugin/definition/redm2';

INSERT INTO `help_target` (`last_update`, `route`, `target`) VALUES (NOW(), '/admin/plugin/definition/orgunitsload1', 'admin-guide:plugins:bizdock-internal-plugins:org-unit-loader-plugin');
INSERT INTO `help_target` (`last_update`, `route`, `target`) VALUES (NOW(), '/admin/plugin/definition/genint1', 'admin-guide:plugins:bizdock-internal-plugins:bizdock-url-integration');
INSERT INTO `help_target` (`last_update`, `route`, `target`) VALUES (NOW(), '/admin/plugin/definition/schedule1', 'admin-guide:plugins:bizdock-internal-plugins:bizdock-scheduled-script');


--//@UNDO


