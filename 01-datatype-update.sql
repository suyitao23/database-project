#modify attribute name
ALTER TABLE `database-demo`.vaccination_county 
CHANGE COLUMN `Report_As_Of` `Report_Date` TEXT;

#change datatype of report_date attribute to date
#first modify the format
UPDATE `database-demo`.fatalities_age_group
SET Report_Date = STR_TO_DATE(Report_Date, '%m/%d/%Y');
ALTER TABLE `database-demo`.fatalities_age_group MODIFY `Report_Date` DATE;

UPDATE `database-demo`.fatalities_county
SET Report_Date = STR_TO_DATE(Report_Date, '%m/%d/%Y');
ALTER TABLE `database-demo`.fatalities_county MODIFY `Report_Date` DATE;

UPDATE `database-demo`.fatalities_sex
SET Report_Date = STR_TO_DATE(Report_Date, '%m/%d/%Y');
ALTER TABLE `database-demo`.fatalities_sex MODIFY `Report_Date` DATE;

UPDATE `database-demo`.testing
SET Test_Date = STR_TO_DATE(Test_Date, '%m/%d/%Y');
ALTER TABLE `database-demo`.testing MODIFY `Test_Date` DATE;

UPDATE `database-demo`.testing_age_group
SET Test_Date = STR_TO_DATE(Test_Date, '%m/%d/%Y');
ALTER TABLE `database-demo`.testing_age_group MODIFY `Test_Date` DATE;

UPDATE `database-demo`.vaccination_age_group
SET Report_Date = STR_TO_DATE(Report_Date, '%m/%d/%Y');
ALTER TABLE `database-demo`.vaccination_age_group MODIFY `Report_Date` DATE;

UPDATE `database-demo`.vaccination_county
SET Report_Date = STR_TO_DATE(Report_Date, '%m/%d/%Y');
ALTER TABLE `database-demo`.vaccination_county MODIFY `Report_Date` DATE;

UPDATE `database-demo`.`fatalities_age_group`
SET `Age_Group` = 'Unknown'
WHERE `Age_Group` IS NULL OR `Age_Group` = '';

UPDATE `database-demo`.`fatalities_age_group`
SET `Age_Group` = '90 & Over'
WHERE `Age_Group` = '90 and Over';

ALTER TABLE `database-demo`.testing
CHANGE COLUMN MyUnknownColumn Test_Performed INT;

UPDATE `database-demo`.`vaccination_age_group`
SET `Age_Group` = 'Unknown'
WHERE `Age_Group` IS NULL OR `Age_Group` = '';

UPDATE `database-demo`.`vaccination_age_group`
SET `Age_Group` = '12-17'
WHERE `Age_Group` = '12--17';

UPDATE `database-demo`.`vaccination_age_group`
SET `Age_Group` = '05-11'
WHERE `Age_Group` = '05--11';

UPDATE `database-demo`.`vaccination_age_group`
SET `Age_Group` = '<5'
WHERE `Age_Group` = 'Unknown';
