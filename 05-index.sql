ALTER TABLE `database-demo`.fatalities_county
ADD COLUMN Fatality_Report_ID INT AUTO_INCREMENT PRIMARY KEY;

ALTER TABLE `database-demo`.vaccination_county
ADD COLUMN Vaccination_Report_ID INT AUTO_INCREMENT PRIMARY KEY;

ALTER TABLE `database-demo`.`vaccination_county`
DROP COLUMN `Region`,
DROP COLUMN `County`;

DELETE FROM `database-demo`.`fatalities_county`
WHERE `County_ID` IS NULL;

ALTER TABLE `database-demo`.`fatalities_county`
DROP COLUMN `County`;
