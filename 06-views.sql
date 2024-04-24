#1
CREATE OR REPLACE VIEW County_Covid_Summary AS
SELECT t.Test_Date, c.County_Name, SUM(t.New_Positives) AS New_Positives, SUM(f.Deaths_by_County_of_Residence) AS Total_Deaths, SUM(v.First_Dose) AS First_Dose, SUM(v.Series_Complete) AS Series_Completed
FROM testing AS t
JOIN Counties AS c ON t.County_ID = c.County_ID
JOIN fatalities_county AS f ON t.County_ID = f.County_ID 
AND t.Test_Date = f.Report_Date
JOIN vaccination_county AS v ON t.County_ID = v.County_ID 
AND t.Test_Date = v.Report_Date
WHERE
    c.County_Name = 'Albany'
GROUP BY Test_Date;

#2
CREATE OR REPLACE VIEW county_death_100 AS
SELECT t.Test_Date, c.County_Name, SUM(t.New_Positives) AS New_Positives, SUM(f.Deaths_by_County_of_Residence) AS Total_Deaths, SUM(v.First_Dose) AS First_Dose, SUM(v.Series_Complete) AS Series_Completed
FROM testing AS t
JOIN Counties AS c ON t.County_ID = c.County_ID
JOIN fatalities_county AS f ON t.County_ID = f.County_ID 
AND t.Test_Date = f.Report_Date
JOIN vaccination_county AS v ON t.County_ID = v.County_ID 
AND t.Test_Date = v.Report_Date
GROUP BY t.Test_Date, c.County_Name
HAVING SUM(f.Deaths_by_County_of_Residence) > 100;

#3
CREATE OR REPLACE VIEW Monthly_County_Covid_Summary_2021 AS
SELECT EXTRACT(YEAR FROM t.Test_Date) AS Year, EXTRACT(MONTH FROM t.Test_Date) AS Month, c.County_Name, SUM(t.New_Positives) AS New_Positives, SUM(f.Deaths_by_County_of_Residence) AS Total_Deaths, SUM(v.First_Dose) AS First_Dose, SUM(v.Series_Complete) AS Series_Completed
FROM 
    testing AS t
    JOIN Counties AS c ON t.County_ID = c.County_ID
    JOIN fatalities_county AS f ON t.County_ID = f.County_ID 
    AND t.Test_Date = f.Report_Date
    JOIN vaccination_county AS v ON t.County_ID = v.County_ID 
    AND t.Test_Date = v.Report_Date
WHERE 
    EXTRACT(YEAR FROM t.Test_Date) = 2021
GROUP BY 
    EXTRACT(YEAR FROM t.Test_Date), 
    EXTRACT(MONTH FROM t.Test_Date), 
    c.County_Name;

