-- // v17-0-0_misc_updates
-- Migration SQL that makes the change goes here.

INSERT INTO preference (deleted, last_update, uuid, system_preference)
  VALUE (0, NOW(), 'GOVERNANCE_MILESTONE_DISPLAY_PREFERENCE', 1);

INSERT INTO custom_attribute_definition (object_type, configuration, attribute_type, uuid, name, description, last_update)
  VALUE ('java.lang.Object', 'constraint.required=true', 'SINGLE_ITEM', 'GOVERNANCE_MILESTONE_DISPLAY_PREFERENCE',
         'preference.governance_milestone_display_preference.name',
         'preference.governance_milestone_display_preference.description', NOW());

INSERT INTO custom_attribute_item_option (name, description, `order`, deleted, last_update, custom_attribute_definition_id)
VALUES
  ('preference.governance_milestone_display_preference.short.name',
   'preference.governance_milestone_display_preference.short.description', 0, 0, NOW(), (SELECT id
                                                                                         FROM
                                                                                           custom_attribute_definition
                                                                                         WHERE uuid =
                                                                                               'GOVERNANCE_MILESTONE_DISPLAY_PREFERENCE')),
  ('preference.governance_milestone_display_preference.long.name',
   'preference.governance_milestone_display_preference.long.description', 1, 0, NOW(), (SELECT id
                                                                                         FROM
                                                                                           custom_attribute_definition
                                                                                         WHERE uuid =
                                                                                               'GOVERNANCE_MILESTONE_DISPLAY_PREFERENCE'));

INSERT INTO single_item_custom_attribute_value (object_type, object_id, deleted, last_update, custom_attribute_definition_id, value_id)
  VALUE
  ('java.lang.Object', 1, 0, now(), (SELECT id
                                     FROM custom_attribute_definition
                                     WHERE uuid = 'GOVERNANCE_MILESTONE_DISPLAY_PREFERENCE'), (SELECT id
                                                                                               FROM
                                                                                                 custom_attribute_item_option
                                                                                               WHERE name =
                                                                                                     'preference.governance_milestone_display_preference.long.name'));



-- //@UNDO
-- SQL to undo the change goes here.

DELETE FROM preference
WHERE uuid = 'GOVERNANCE_MILESTONE_DISPLAY_PREFERENCE';

DELETE FROM single_item_custom_attribute_value
WHERE custom_attribute_definition_id = (SELECT id
                                        FROM
                                          custom_attribute_definition
                                        WHERE uuid =
                                              'GOVERNANCE_MILESTONE_DISPLAY_PREFERENCE');

DELETE FROM custom_attribute_item_option
WHERE custom_attribute_definition_id = (SELECT id
                                        FROM
                                          custom_attribute_definition
                                        WHERE uuid =
                                              'GOVERNANCE_MILESTONE_DISPLAY_PREFERENCE');

DELETE FROM custom_attribute_definition
WHERE uuid = 'GOVERNANCE_MILESTONE_DISPLAY_PREFERENCE';

