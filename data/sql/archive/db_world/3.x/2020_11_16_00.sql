-- DB update 2020_11_15_02 -> 2020_11_16_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2020_11_15_02';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2020_11_15_02 2020_11_16_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1605096696090340600'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1605096696090340600');

UPDATE `gameobject_template` SET `data1` = 4 WHERE `entry` = 30;
UPDATE `gameobject` SET `position_x` = 5911.18 WHERE `guid` = 5272;
UPDATE `gameobject` SET `position_x` = 5904.73 WHERE `guid` = 5273;

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;