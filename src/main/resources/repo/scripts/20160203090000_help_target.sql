--help target

DELETE FROM `help_target` WHERE target='user-guide:cockpit';

INSERT INTO `help_target` (`last_update`, `route`, `target`) VALUES (NOW(), '/', 'user-guide:home');
