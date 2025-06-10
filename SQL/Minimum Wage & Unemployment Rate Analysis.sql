-- Create Minimum Wage Table
CREATE TABLE Minimum_Wage (
    Year INT,
    Adult DECIMAL(10,2),
    Starting_Out DECIMAL(10,2),
    Training DECIMAL(10,2)
);

-- Get Overview of Minimum Wage
SELECT * 
FROM Minimum_Wage;

-- Calculate Changes in Minimum Wage by Year 
SELECT 
    Year,
    Adult,
    Adult - LAG(Adult) OVER (ORDER BY Year) AS Change_by_year
FROM Minimum_Wage;

-- Calculate Changes & Percentage Changes in Minimum Wage by Year
SELECT 
    Year,
    Adult AS Minimum_wage,
    Adult - LAG(Adult) OVER (ORDER BY Year) AS mw_Change_by_year,
    ROUND(
        (
            (Adult - LAG(Adult) OVER (ORDER BY Year)) / 
            LAG(Adult) OVER (ORDER BY Year)
        ) * 100, 2
    ) AS mw_percentage_change_by_year
FROM Minimum_Wage;

-- Create Unemployment Rate Table
CREATE TABLE Unemployment_Rate_NZ ( 
    Year INT,
    Unemployment_Rate DECIMAL(18,1)
);

-- Get an Overview of Unemployment Rate Table
SELECT * 
FROM Unemployment_Rate_NZ;

-- Calculate Changes in Unemployment Rate by Year
SELECT 
    Year, 
    Unemployment_Rate, 
    Unemployment_Rate - LAG(Unemployment_Rate) OVER (ORDER BY Year) AS change_in_unemployment_rate
FROM Unemployment_Rate_NZ;

-- Calculate Changes & Percentage Changes in Unemployment Rate by Year
SELECT 
    Year, 
    Unemployment_Rate, 
    Unemployment_Rate - LAG(Unemployment_Rate) OVER (ORDER BY Year) AS ur_change_by_year,
    ROUND(
        (
            (Unemployment_Rate - LAG(Unemployment_Rate) OVER (ORDER BY Year)) / 
            LAG(Unemployment_Rate) OVER (ORDER BY Year)
        ) * 100, 2
    ) AS ur_percentage_change_by_year
FROM Unemployment_Rate_NZ;

-- INNER JOIN Minimum Wage Percentage Changes with Unemployment Rate Percentage Changes
SELECT 
    mw.Year,
    Adult AS Minimum_wage,
    Adult - LAG(Adult) OVER (ORDER BY mw.Year) AS mw_change,
    ROUND(
        (
            (Adult - LAG(Adult) OVER (ORDER BY mw.Year)) / 
            LAG(Adult) OVER (ORDER BY mw.Year)
        ) * 100, 2
    ) AS mw_pntg_chng,
    unemployment_rate, 
    unemployment_rate - LAG(unemployment_rate) OVER (ORDER BY urn.Year) AS ur_change,
    ROUND(
        (
            (unemployment_rate - LAG(unemployment_rate) OVER (ORDER BY urn.Year)) / 
            LAG(unemployment_rate) OVER (ORDER BY urn.Year)
        ) * 100, 2
    ) AS ur_pntg_chng
FROM Minimum_Wage mw 
INNER JOIN Unemployment_Rate_NZ urn 
    ON mw.Year = urn.Year;

-- Calculate Correlation Coefficient Between Minimum Wage Percentage Changes and Unemployment Rate Percentage Changes
WITH mwur AS (
    SELECT 
        mw.Year,
        Adult AS Minimum_wage,
        Adult - LAG(Adult) OVER (ORDER BY mw.Year) AS mw_Change_by_year,
        ROUND(
            (
                (Adult - LAG(Adult) OVER (ORDER BY mw.Year)) / 
                LAG(Adult) OVER (ORDER BY mw.Year)
            ) * 100, 2
        ) AS mw_percentage_change_by_year,
        unemployment_rate, 
        unemployment_rate - LAG(unemployment_rate) OVER (ORDER BY urn.Year) AS change_in_unemployment_rate,
        ROUND(
            (
                (unemployment_rate - LAG(unemployment_rate) OVER (ORDER BY mw.Year)) / 
                LAG(unemployment_rate) OVER (ORDER BY urn.Year)
            ) * 100, 2
        ) AS ur_percentage_change_unemployment_rate
    FROM Minimum_Wage mw 
    INNER JOIN Unemployment_Rate_NZ urn 
        ON mw.Year = urn.Year
) 
SELECT 
	ROUND(
    	(
        	COUNT(*) * SUM(mw_percentage_change_by_year * ur_percentage_change_unemployment_rate) - 
        	SUM(mw_percentage_change_by_year) * SUM(ur_percentage_change_unemployment_rate)
    	) / 
    	(
        	SQRT(
            	COUNT(*) * SUM(POWER(mw_percentage_change_by_year, 2)) - 
            	POWER(SUM(mw_percentage_change_by_year), 2)
        	) * 
        	SQRT(
            	COUNT(*) * SUM(POWER(ur_percentage_change_unemployment_rate, 2)) - 
            	POWER(SUM(ur_percentage_change_unemployment_rate), 2)
        	)
		),
		4
   	) AS correlation_coefficient
FROM mwur;

-- Calculate Correlation Coefficient Between Minimum Wage Percentage Changes and Unemployment Rate Percentage Changes Excluding Null Values
WITH mwur AS (
    SELECT 
        mw.Year,
        Adult AS Minimum_wage,
        Adult - LAG(Adult) OVER (ORDER BY mw.Year) AS mw_Change_by_year,
        ROUND(
            (
                (Adult - LAG(Adult) OVER (ORDER BY mw.Year)) / 
                LAG(Adult) OVER (ORDER BY mw.Year)
            ) * 100, 4
        ) AS mw_percentage_change_by_year,
        unemployment_rate, 
        unemployment_rate - LAG(unemployment_rate) OVER (ORDER BY mw.Year) AS change_in_unemployment_rate,
        ROUND(
            (
                (unemployment_rate - LAG(unemployment_rate) OVER (ORDER BY mw.Year)) / 
                LAG(unemployment_rate) OVER (ORDER BY mw.Year)
            ) * 100, 4
        ) AS ur_percentage_change_unemployment_rate
    FROM Minimum_Wage mw 
    INNER JOIN Unemployment_Rate_NZ urn 
        ON mw.Year = urn.Year
) 
SELECT 
    ROUND(
        (
            COUNT(*) * SUM(mw_percentage_change_by_year * ur_percentage_change_unemployment_rate) - 
            SUM(mw_percentage_change_by_year) * SUM(ur_percentage_change_unemployment_rate)
        ) / (
            SQRT(
                COUNT(*) * SUM(POWER(mw_percentage_change_by_year, 2)) - 
                POWER(SUM(mw_percentage_change_by_year), 2)
            ) * 
            SQRT(
                COUNT(*) * SUM(POWER(ur_percentage_change_unemployment_rate, 2)) - 
                POWER(SUM(ur_percentage_change_unemployment_rate), 2)
            )
        ), 4
    ) AS correlation_coefficient
FROM mwur
WHERE mw_percentage_change_by_year IS NOT NULL 
  AND ur_percentage_change_unemployment_rate IS NOT NULL;



