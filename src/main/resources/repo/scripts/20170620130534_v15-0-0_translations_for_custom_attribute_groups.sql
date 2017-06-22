-- // v15-0-0 translations for custom attribute groups
-- Migration SQL that makes the change goes here.

INSERT INTO i18n_messages (`key`, language, value) VALUES
  ('object.custom_attribute_group.label', 'en', 'Custom attributes'),
  ('object.custom_attribute_group.label', 'fr', 'Attributs personnalisés'),
  ('object.custom_attribute_group.label', 'de', 'Zusatzfelder');

-- //@UNDO
-- SQL to undo the change goes here.

DELETE FROM i18n_messages
WHERE `key` = 'object.custom_attribute_group.label';
