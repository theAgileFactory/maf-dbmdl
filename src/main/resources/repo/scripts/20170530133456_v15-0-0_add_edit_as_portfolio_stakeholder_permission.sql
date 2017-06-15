-- // v15-0-0 add edit as portfolio stakeholder permission
-- Migration SQL that makes the change goes here.

INSERT INTO system_permission (name, description, deleted, selectable, last_update)
VALUES (
  'PORTFOLIO_ENTRY_EDIT_AS_PORTFOLIO_STAKEHOLDER_PERMISSION',
  'permission.portfolio_entry_edit_as_portfolio_stakeholder_permission.description',
  0,
  1,
  NOW()
), (
    'PORTFOLIO_ENTRY_EDIT_FINANCIAL_INFO_AS_PORTFOLIO_STAKEHOLDER_PERMISSION',
    'permission.portfolio_entry_edit_as_financial_info_portfolio_stakeholder_permission.description',
    0,
    1,
    NOW()
  );

-- //@UNDO
-- SQL to undo the change goes here.

DELETE FROM system_level_role_type_has_system_permission WHERE system_permission_id in (
    SELECT id FROM system_permission where name in ('PORTFOLIO_ENTRY_EDIT_AS_PORTFOLIO_STAKEHOLDER_PERMISSION', 'PORTFOLIO_ENTRY_EDIT_FINANCIAL_INFO_AS_PORTFOLIO_STAKEHOLDER_PERMISSION')
);

DELETE FROM system_permission where name in ('PORTFOLIO_ENTRY_EDIT_AS_PORTFOLIO_STAKEHOLDER_PERMISSION', 'PORTFOLIO_ENTRY_EDIT_FINANCIAL_INFO_AS_PORTFOLIO_STAKEHOLDER_PERMISSION');