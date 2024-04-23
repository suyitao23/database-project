CREATE TABLE Geographies (
  Geography_ID INT AUTO_INCREMENT PRIMARY KEY,
  Name VARCHAR(255) UNIQUE NOT NULL
);

INSERT INTO Geographies (Name)
SELECT DISTINCT Geography FROM `database-demo`.testing
WHERE Geography IS NOT NULL;

ALTER TABLE `database-demo`.testing
ADD COLUMN Geography_ID INT;

UPDATE `database-demo`.testing AS t
INNER JOIN Geographies AS g ON t.Geography = g.Name
SET t.Geography_ID = g.Geography_ID;

ALTER TABLE `database-demo`.testing
DROP COLUMN Geography;

ALTER TABLE `database-demo`.testing
ADD CONSTRAINT FK_Geography
FOREIGN KEY (Geography_ID) REFERENCES Geographies(Geography_ID);

CREATE TABLE Counties (
  County_ID INT AUTO_INCREMENT PRIMARY KEY,
  County_Name VARCHAR(255) UNIQUE NOT NULL
);

INSERT INTO Counties (County_Name)
SELECT DISTINCT County FROM `database-demo`.testing
WHERE County IS NOT NULL AND County != 'STATEWIDE';

ALTER TABLE `database-demo`.testing
ADD COLUMN County_ID INT;


UPDATE `database-demo`.testing AS t
INNER JOIN Counties AS c ON t.County = c.County_Name
SET t.County_ID = c.County_ID
WHERE t.County IS NOT NULL AND t.County != 'STATEWIDE';

CREATE TABLE Test_Results (
  Test_Result_ID INT AUTO_INCREMENT PRIMARY KEY,
  Test_Date DATE,
  County_ID INT,
  Geography_ID INT,
  New_Positives INT,
  Test_Performed INT,
  Test_Positive_Percentage FLOAT,
  FOREIGN KEY (County_ID) REFERENCES Counties(County_ID),
  FOREIGN KEY (Geography_ID) REFERENCES Geographies(Geography_ID)
);

INSERT INTO Test_Results (Test_Date, County_ID, Geography_ID, New_Positives, Test_Performed, Test_Positive_Percentage)
SELECT 
    Test_Date, 
    County_ID, 
    Geography_ID, 
    New_Positives, 
    Test_Performed, 
       ROUND(Test_Positive, 2)
FROM 
    `database-demo`.testing;

ALTER TABLE `database-demo`.Test_Results DROP COLUMN Test_Positive_Percentage;


CREATE INDEX idx_county_id ON Test_Results (County_ID);
CREATE INDEX idx_geography_id ON Test_Results (Geography_ID);

