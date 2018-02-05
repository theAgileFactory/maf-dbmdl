-- // Separate risk and issues
-- Migration SQL that makes the change goes here.

CREATE TABLE portfolio_entry_issue_type (
  id                            BIGINT(20) NOT NULL AUTO_INCREMENT,
  name                          VARCHAR(64) NOT NULL,
  description                   VARCHAR(1500) DEFAULT NULL,
  deleted                       TINYINT(1) DEFAULT 0,
  selectable                    TINYINT(1) DEFAULT 1,
  last_update                   DATETIME NOT NULL,
  PRIMARY KEY (id),
  UNIQUE KEY name_unique (name)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE portfolio_entry_issue (
  id                            BIGINT(20) NOT NULL AUTO_INCREMENT,
  portfolio_entry_id            BIGINT(20) NOT NULL,
  creation_date                 DATETIME NOT NULL,
  due_date                      DATETIME DEFAULT NULL,
  name                          VARCHAR(64) NOT NULL,
  portfolio_entry_issue_type_id BIGINT(20) DEFAULT NULL,
  description                   VARCHAR(1500) DEFAULT NULL,
  owner_id                      BIGINT(20) DEFAULT NULL,
  closure_date                  DATETIME DEFAULT NULL,
  is_active                     TINYINT(1) DEFAULT 1,
  deleted                       TINYINT(1) DEFAULT 0,
  last_update                   DATETIME NOT NULL,
  PRIMARY KEY (id),
  KEY fk_pei_pe_idx (portfolio_entry_id),
  KEY fk_pei_peit_idx (portfolio_entry_issue_type_id),
  KEY fk_pei_a_idx (owner_id),
  CONSTRAINT fk_pei_pe FOREIGN KEY (portfolio_entry_id) REFERENCES portfolio_entry (id) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT fk_pei_peit FOREIGN KEY (portfolio_entry_issue_type_id) REFERENCES portfolio_entry_issue_type (id) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT fk_pei_a FOREIGN KEY (owner_id) REFERENCES actor (id) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO portfolio_entry_issue_type
  SELECT *
  FROM portfolio_entry_risk_type;

INSERT INTO portfolio_entry_issue (id, portfolio_entry_id, creation_date, due_date, name, portfolio_entry_issue_type_id, description, owner_id, closure_date, is_active, deleted, last_update)
  SELECT
    id,
    portfolio_entry_id,
    creation_date,
    target_date,
    name,
    portfolio_entry_risk_type_id,
    description,
    owner_id,
    closure_date,
    is_active,
    deleted,
    last_update
  FROM portfolio_entry_risk
  WHERE has_occured = 1;

DELETE FROM portfolio_entry_risk
WHERE has_occured = 1;

ALTER TABLE portfolio_entry_risk DROP COLUMN has_occured;

-- //@UNDO
-- SQL to undo the change goes here.

ALTER TABLE portfolio_entry_risk ADD COLUMN has_occured TINYINT(1) DEFAULT FALSE AFTER portfolio_entry_id;

INSERT INTO portfolio_entry_risk (id, creation_date, target_date, name, description, has_occured, portfolio_entry_id, is_mitigated, closure_date, mitigation_comment, is_active, deleted, last_update, portfolio_entry_risk_type_id, owner_id)
  SELECT
    id,
    creation_date,
    due_date,
    name,
    description,
    1,
    portfolio_entry_id,
    0,
    closure_date,
    '',
    is_active,
    deleted,
    last_update,
    portfolio_entry_issue_type_id,
    owner_id
  FROM portfolio_entry_issue;

DROP TABLE portfolio_entry_issue;

DROP TABLE portfolio_entry_issue_type;
