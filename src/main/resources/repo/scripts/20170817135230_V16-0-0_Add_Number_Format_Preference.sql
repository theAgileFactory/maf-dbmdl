-- // V16-0-0_Add_Number_Format_Preference
-- Migration SQL that makes the change goes here.

INSERT INTO preference (deleted, last_update, uuid, system_preference)
VALUES (0, NOW(), 'FINANCIAL_NUMBERS_FORMAT_PREFERENCE', 1);

INSERT INTO custom_attribute_definition (object_type, `order`, attribute_type, uuid, name, description, deleted, last_update, is_displayed)
VALUES ('java.lang.Object', 0, 'STRING', 'FINANCIAL_NUMBERS_FORMAT_PREFERENCE',
        'preference.financial_numbers_format_preference.name',
        'preference.financial_numbers_format_preference.description', 0, NOW(), 1);

-- //@UNDO
-- SQL to undo the change goes here.

DELETE FROM preference
WHERE uuid = 'FINANCIAL_NUMBERS_FORMAT_PREFERENCE';

DELETE FROM string_custom_attribute_value
WHERE custom_attribute_definition_id = (SELECT id
                                        FROM custom_attribute_definition
                                        WHERE uuid = 'FINANCIAL_NUMBERS_FORMAT_PREFERENCE');

DELETE FROM custom_attribute_definition
WHERE uuid = 'FINANCIAL_NUMBERS_FORMAT_PREFERENCE';

