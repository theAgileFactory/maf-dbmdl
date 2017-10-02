-- // v16-0-0_add_request_comment_in_life_cycle_milestone_instance
-- Migration SQL that makes the change goes here.

-- Add request comments in life cycle milestone instance details
ALTER TABLE life_cycle_milestone_instance
ADD COLUMN request_comments VARCHAR(1500);

-- Increase comments size in a portfolio entry status report
ALTER TABLE portfolio_entry_report
MODIFY COLUMN comments VARCHAR(5000);

-- Add preference to use week days only when computing allocation details
INSERT INTO preference (deleted, last_update, uuid, system_preference)
VALUES (0, NOW(), 'RESOURCES_WEEK_DAYS_ALLOCATION_PREFERENCE', 1);

INSERT INTO `custom_attribute_definition`
(`object_type`,
 `configuration`,
 `attribute_type`,
 `uuid`,
 `name`,
 `description`,
 `last_update`)
VALUES
  (
    'java.lang.Object',
    'default.value=false',
    'BOOLEAN',
    'RESOURCES_WEEK_DAYS_ALLOCATION_PREFERENCE',
    'preference.resources_week_days_allocation_preference.name',
    'preference.resources_week_days_allocation_preference.description',
    NOW()
  );

-- Add defaut format configuration to reporting
ALTER TABLE reporting
ADD COLUMN default_format VARCHAR(256);

-- //@UNDO
-- SQL to undo the change goes here.

ALTER TABLE life_cycle_milestone_instance
DROP COLUMN request_comments;

ALTER TABLE portfolio_entry_report
MODIFY COLUMN comments VARCHAR(2500);

DELETE FROM preference
WHERE uuid = 'RESOURCES_WEEK_DAYS_ALLOCATION_PREFERENCE';

DELETE FROM custom_attribute_definition
WHERE uuid = 'RESOURCES_WEEK_DAYS_ALLOCATION_PREFERENCE';

ALTER TABLE reporting
DROP COLUMN default_format ;