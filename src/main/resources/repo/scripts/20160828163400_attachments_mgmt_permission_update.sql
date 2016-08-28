-- Adding a new permission "without" the confidential projects

INSERT INTO system_permission (name, description, deleted, selectable, last_update)
VALUES (
  'ADMIN_ATTACHMENTS_MANAGEMENT_PERMISSION_NO_CONFIDENTIAL',
  'permission.admin_attachments_management_permission_no_confidential.description',
  0,
  1,
  NOW()
);

-- //@UNDO
-- SQL to undo the change goes here.

DELETE FROM system_permission
WHERE name = 'ADMIN_ATTACHMENTS_MANAGEMENT_PERMISSION_NO_CONFIDENTIAL';
