ALTER TABLE `database-demo`.`vaccination_county`
DROP COLUMN `Region`,
DROP COLUMN `County`;

DELETE FROM `database-demo`.`fatalities_county`
WHERE `County_ID` IS NULL;

ALTER TABLE `database-demo`.`fatalities_county`
DROP COLUMN `County`;