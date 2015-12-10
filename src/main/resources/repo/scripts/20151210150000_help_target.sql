--Help target

DELETE FROM help_target where route LIKE '%release%';

UPDATE help_target SET route='/portfolio-entry/requirement/manage' WHERE route='/portfolio-entry/requirement/edit';

INSERT INTO `help_target` (`last_update`, `route`, `target`) VALUES (NOW(), '/portfolio-entry/deliverables', 'user-guide:initiative:delivery');
INSERT INTO `help_target` (`last_update`, `route`, `target`) VALUES (NOW(), '/portfolio-entry/deliverable/view', 'user-guide:initiative:delivery');
INSERT INTO `help_target` (`last_update`, `route`, `target`) VALUES (NOW(), '/portfolio-entry/deliverable/edit', 'user-guide:initiative:delivery');
INSERT INTO `help_target` (`last_update`, `route`, `target`) VALUES (NOW(), '/portfolio-entry/deliverable/requirements/edit', 'user-guide:initiative:delivery');
INSERT INTO `help_target` (`last_update`, `route`, `target`) VALUES (NOW(), '/portfolio-entry/deliverable/follow', 'user-guide:initiative:delivery');


--//@UNDO


