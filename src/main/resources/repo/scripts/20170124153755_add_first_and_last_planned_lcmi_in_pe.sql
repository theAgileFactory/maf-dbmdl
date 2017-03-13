-- // add first and last planned lcmi in pe
-- Migration SQL that makes the change goes here.

ALTER TABLE `portfolio_entry`
ADD COLUMN `start_date` DATE
AFTER `last_portfolio_entry_report_id`;

ALTER TABLE `portfolio_entry`
ADD COLUMN `end_date` DATE
AFTER `start_date`;

UPDATE portfolio_entry pe
  JOIN
  (SELECT
     PP.ID,
     (SELECT
        MIN(plcmi.planned_date)
      FROM
        planned_life_cycle_milestone_instance plcmi
        JOIN life_cycle_instance_planning lcip ON plcmi.life_cycle_instance_planning_id = lcip.id
        JOIN life_cycle_instance lci ON lcip.life_cycle_instance_id = lci.id
        JOIN life_cycle_milestone lcm ON plcmi.life_cycle_milestone_id = lcm.id
      WHERE
        lci.portfolio_entry_id = PP.ID
        AND plcmi.deleted = FALSE
        AND lcip.deleted = FALSE
        AND lci.deleted = FALSE
        AND lci.is_active = TRUE
        AND lcm.deleted = FALSE
        AND (lcm.is_active = TRUE
             OR (SELECT
                   COUNT(*)
                 FROM
                   life_cycle_milestone_instance lcmi
                 WHERE
                   lcmi.deleted = FALSE
                   AND lcmi.life_cycle_instance_id = lci.id
                   AND lcmi.life_cycle_milestone_id = lcm.id) > 0)
        AND lcip.creation_date = (SELECT
                                    MAX(ilcip.creation_date)
                                  FROM
                                    planned_life_cycle_milestone_instance iplcmi
                                    JOIN life_cycle_instance_planning ilcip ON iplcmi.life_cycle_instance_planning_id = ilcip.id
                                    JOIN life_cycle_instance ilci ON ilcip.life_cycle_instance_id = ilci.id
                                    JOIN life_cycle_milestone ilcm ON iplcmi.life_cycle_milestone_id = ilcm.id
                                  WHERE
                                    ilci.portfolio_entry_id = PP.ID
                                    AND iplcmi.deleted = FALSE
                                    AND ilcip.deleted = FALSE
                                    AND ilci.deleted = FALSE
                                    AND ilci.is_active = TRUE
                                    AND ilcm.deleted = FALSE
                                    AND (ilcm.is_active = TRUE
                                         OR (SELECT
                                               COUNT(*)
                                             FROM
                                               life_cycle_milestone_instance ilcmi
                                             WHERE
                                               ilcmi.deleted = FALSE
                                               AND ilcmi.life_cycle_instance_id = ilci.id
                                               AND ilcmi.life_cycle_milestone_id = ilcm.id) > 0)
                                  GROUP BY iplcmi.life_cycle_milestone_id
                                  HAVING iplcmi.life_cycle_milestone_id = plcmi.life_cycle_milestone_id)
      ORDER BY lcm.order) AS DATE_MIN,
     (SELECT
        MAX(plcmi.planned_date)
      FROM
        planned_life_cycle_milestone_instance plcmi
        JOIN life_cycle_instance_planning lcip ON plcmi.life_cycle_instance_planning_id = lcip.id
        JOIN life_cycle_instance lci ON lcip.life_cycle_instance_id = lci.id
        JOIN life_cycle_milestone lcm ON plcmi.life_cycle_milestone_id = lcm.id
      WHERE
        lci.portfolio_entry_id = PP.ID
        AND plcmi.deleted = FALSE
        AND lcip.deleted = FALSE
        AND lci.deleted = FALSE
        AND lci.is_active = TRUE
        AND lcm.deleted = FALSE
        AND (lcm.is_active = TRUE
             OR (SELECT
                   COUNT(*)
                 FROM
                   life_cycle_milestone_instance lcmi
                 WHERE
                   lcmi.deleted = FALSE
                   AND lcmi.life_cycle_instance_id = lci.id
                   AND lcmi.life_cycle_milestone_id = lcm.id) > 0)
        AND lcip.creation_date = (SELECT
                                    MAX(ilcip.creation_date)
                                  FROM
                                    planned_life_cycle_milestone_instance iplcmi
                                    JOIN life_cycle_instance_planning ilcip ON iplcmi.life_cycle_instance_planning_id = ilcip.id
                                    JOIN life_cycle_instance ilci ON ilcip.life_cycle_instance_id = ilci.id
                                    JOIN life_cycle_milestone ilcm ON iplcmi.life_cycle_milestone_id = ilcm.id
                                  WHERE
                                    ilci.portfolio_entry_id = PP.ID
                                    AND iplcmi.deleted = FALSE
                                    AND ilcip.deleted = FALSE
                                    AND ilci.deleted = FALSE
                                    AND ilci.is_active = TRUE
                                    AND ilcm.deleted = FALSE
                                    AND (ilcm.is_active = TRUE
                                         OR (SELECT
                                               COUNT(*)
                                             FROM
                                               life_cycle_milestone_instance ilcmi
                                             WHERE
                                               ilcmi.deleted = FALSE
                                               AND ilcmi.life_cycle_instance_id = ilci.id
                                               AND ilcmi.life_cycle_milestone_id = ilcm.id) > 0)
                                  GROUP BY iplcmi.life_cycle_milestone_id
                                  HAVING iplcmi.life_cycle_milestone_id = plcmi.life_cycle_milestone_id)
      ORDER BY lcm.order) AS date_MAX
   FROM
     portfolio_entry PP
   ORDER BY ID ASC) a ON pe.id = a.ID
SET
  start_date = date_min,
  end_date = date_max;

-- //@UNDO
-- SQL to undo the change goes here.

ALTER TABLE `portfolio_entry` DROP COLUMN `start_date`;
ALTER TABLE `portfolio_entry` DROP COLUMN `end_date`;


