-- // v16-0-0_Change_french_locale
-- Migration SQL that makes the change goes here.

UPDATE i18n_messages
SET language = 'fr-CH'
WHERE language = 'fr';

UPDATE reporting
SET languages = replace(languages, 'fr', 'fr-CH');

-- //@UNDO
-- SQL to undo the change goes here.

UPDATE i18n_messages
SET language = 'fr'
WHERE language = 'fr-CH';

UPDATE reporting
SET languages = replace(languages, 'fr-CH', 'fr');
