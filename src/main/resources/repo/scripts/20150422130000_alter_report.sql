--alter reporting table

ALTER TABLE `reporting` ADD COLUMN `languages` VARCHAR(256) NOT NULL DEFAULT 'en,fr,de'  AFTER `template` , ADD COLUMN `formats` VARCHAR(256) NOT NULL DEFAULT 'PDF,EXCEL,CSV'  AFTER `languages` ;

--//@UNDO

ALTER TABLE `reporting` DROP COLUMN `formats` , DROP COLUMN `languages` ;

