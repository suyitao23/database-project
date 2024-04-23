

CREATE VIEW County_Fatality_Rate AS
SELECT 
    fc.County_ID, 
    c.County_Name, 
    SUM(fc.Place_of_Fatality) AS Total_Fatalities
FROM fatalities_county AS fc
JOIN Counties AS c ON fc.County_ID = c.County_ID
GROUP BY fc.County_ID, c.County_Name;


CREATE VIEW Daily_Vaccination_Summary AS
SELECT Report_Date, SUM(First_Dose) AS Total_First_Doses, SUM(Series_Complete) AS Total_Series_Completed
FROM vaccination_county
GROUP BY Report_Date;

CREATE VIEW Fatality_Rates_Age_Group AS
SELECT a.Report_Date, b.Age_Group_Description, a.Fatality_Count, a.Percent
FROM fatalities_age_group AS a
JOIN Age_Group_id_fatality AS b ON a.Age_Group = b.Age_Group_ID;

CREATE VIEW County_Covid_Summary AS
SELECT t.Test_Date, c.County_Name, SUM(t.New_Positives) AS New_Positives, SUM(f.Deaths_by_County_of_Residence) AS Total_Deaths, SUM(v.First_Dose) AS First_Dose, SUM(v.Series_Complete) AS Series_Completed
FROM testing AS t
JOIN Counties AS c ON t.County_ID = c.County_ID
JOIN fatalities_county AS f ON t.County_ID = f.County_ID AND t.Test_Date = f.Report_Date
JOIN vaccination_county AS v ON t.County_ID = v.County_ID AND t.Test_Date = v.Report_Date
GROUP BY t.Test_Date, c.County_Name;

CREATE VIEW Age_Group_Summary AS
SELECT 
    a.Age_Group_Description,
    SUM(t.Total_Positive_Cases) AS Total_Positive_Cases,
    SUM(f.Fatality_Count) AS Total_Fatalities
FROM Age_Group_id_fatality AS a
LEFT JOIN Testing_Age_Group AS t ON a.Age_Group_Description = t.Age_Group
LEFT JOIN Fatalities_Age_Group AS f ON a.Age_Group_Description = f.Age_Group
GROUP BY a.Age_Group_Description;


CREATE OR REPLACE VIEW Combined_Age_Group_Data AS
SELECT 
    tg.Test_Date, 
    CASE
        WHEN tg.Age_Group IN ('75 to 84', '85+') THEN '75+' 
        ELSE tg.Age_Group
    END AS Testing_Age_Group, 
    SUM(tg.Total_Positive_Cases) AS Total_Positive_Cases, 
    SUM(tg.Total_Cases_Per_100k) AS Total_Cases_Per_100k,  
    SUM(vg.First_Dose_Ct) AS First_Dose_Ct, 
    SUM(vg.Series_Complete_Cnt) AS Series_Complete_Cnt
FROM 
    testing_age_group AS tg
JOIN 
    vaccination_age_group AS vg
ON 
    CASE 
        WHEN tg.Age_Group = '45 to 54' THEN '45-54'
        WHEN tg.Age_Group = '55 to 64' THEN '55-64'
        WHEN tg.Age_Group = '65 to 74' THEN '65-74'
        WHEN tg.Age_Group IN ('75 to 84', '85+') THEN '75+'
    END = vg.Age_Group
AND 
    tg.Test_Date = vg.Report_Date
WHERE 
    tg.Age_Group IN ('45 to 54', '55 to 64', '65 to 74', '75 to 84', '85+')
AND 
    vg.Age_Group IN ('45-54', '55-64', '65-74', '75+')
GROUP BY 
    tg.Test_Date, 
    Testing_Age_Group, 
    vg.Report_Date;
