--remove the cockepit permission

DELETE FROM system_level_role_type_has_system_permission WHERE system_permission_id = (SELECT id FROM system_permission WHERE name='COCKPIT_DISPLAY_PERMISSION' LIMIT 1);

DELETE FROM `system_permission` WHERE `name`='COCKPIT_DISPLAY_PERMISSION';


