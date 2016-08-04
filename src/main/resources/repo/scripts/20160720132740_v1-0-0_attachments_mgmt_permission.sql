-- // v1-0-0_attachments_mgmt_permission
-- Migration SQL that makes the change goes here.

INSERT INTO system_permission (name, description, deleted, selectable, last_update)
VALUES (
  'ADMIN_ATTACHMENTS_MANAGEMENT_PERMISSION',
  'permission.admin_attachments_management_permission.description',
  0,
  1,
  NOW()
);

-- //@UNDO
-- SQL to undo the change goes here.

DELETE FROM system_permission
WHERE name = 'ADMIN_ATTACHMENTS_MANAGEMENT_PERMISSION';
