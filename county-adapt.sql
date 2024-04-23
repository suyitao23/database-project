ALTER TABLE `database-demo`.fatalities_county
ADD COLUMN County_ID INT;

UPDATE `database-demo`.fatalities_county fc
JOIN `database-demo`.Counties c ON fc.County = c.County_Name
SET fc.County_ID = c.County_ID;

ALTER TABLE `database-demo`.vaccination_county
ADD COLUMN County_ID INT;

UPDATE `database-demo`.vaccination_county vc
JOIN `database-demo`.Counties c ON vc.County = c.County_Name
SET vc.County_ID = c.County_ID;


CREATE TABLE `database-demo`.County_Region_Mapping (
  County_ID INT PRIMARY KEY,
  County_Name VARCHAR(255),
  Region_Name VARCHAR(255),
  FOREIGN KEY (County_ID) REFERENCES Counties(County_ID)
);

INSERT INTO `database-demo`.County_Region_Mapping (County_ID, County_Name, Region_Name)
SELECT c.County_ID, c.County_Name, vc.Region
FROM `database-demo`.Counties c
JOIN `database-demo`.vaccination_county vc ON c.County_Name = vc.County
ON DUPLICATE KEY UPDATE
County_Name = VALUES(County_Name),
Region_Name = VALUES(Region_Name);
