-- DB update 2021_09_20_10 -> 2021_09_20_11
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_09_20_10';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_09_20_10 2021_09_20_11 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1631773465270858700'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1631773465270858700');

SET @Entry = 35010;

UPDATE 
	`creature_loot_template`
SET
	`Chance` = 36
WHERE
	`Entry` IN (5712, 5713, 5714, 5715, 5716, 5717)
AND
	`Item` = @Entry;

UPDATE 
	`reference_loot_template` 
SET 
	`Chance` = 
(
	CASE WHEN 
		`Item` = 10783 THEN 11.11
	WHEN 
		`Item` = 10784 THEN 8.33
	WHEN 
		`Item` = 10785 THEN 13.9
	WHEN 
		`Item` = 10786 THEN 22.22
	WHEN 
		`Item` = 10787 THEN 19.44
	WHEN 
		`Item` = 10788 THEN 25
	END
) 
WHERE 
	`Entry` = @Entry 
AND 
	`Item` IN (10783, 10784, 10785, 10786, 10787, 10788);

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_09_20_11' WHERE sql_rev = '1631773465270858700';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;