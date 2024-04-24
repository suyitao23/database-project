#5 Monthly Fatality-Age Group
SELECT 
    YEAR(fag.Report_Date) AS Year, 
    MONTH(fag.Report_Date) AS Month, 
    agf.Age_Group_Description, 
    SUM(fag.Fatality_Count) AS Total_Fatalities
FROM 
    fatalities_age_group AS fag
INNER JOIN 
    Age_Group_id_fatality AS agf ON fag.Age_Group = agf.Age_Group_ID
WHERE 
    agf.Age_Group_ID != 11 -- Excluding the 'Statewide Total' group
GROUP BY 
    Year, Month, agf.Age_Group_Description
ORDER BY 
    Year, Month, agf.Age_Group_ID;
