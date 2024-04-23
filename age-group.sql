CREATE TABLE Age_Group_id_fatality (
  Age_Group_ID INT AUTO_INCREMENT PRIMARY KEY,
  Age_Group_Description VARCHAR(255) UNIQUE NOT NULL
);

INSERT INTO Age_Group_id_fatality (Age_Group_Description)
SELECT DISTINCT Age_Group 
FROM `database-demo`.fatalities_age_group;

UPDATE `database-demo`.fatalities_age_group AS fag
INNER JOIN Age_Group_id_fatality AS ag 
ON fag.Age_Group = ag.Age_Group_Description
SET fag.Age_Group = ag.Age_Group_ID;


