-- // v15-0-0 Add work order loader plugin
-- Migration SQL that makes the change goes here.

INSERT INTO plugin_definition (identifier, clazz, is_available)
VALUES ('workOrderLoad', 'services.plugins.system.workOrderLoad.ExpensesLoaderPluginRunner', 1);

-- //@UNDO
-- SQL to undo the change goes here.

DELETE FROM plugin_definition
WHERE identifier = 'workOrderLoad';
