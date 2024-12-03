SELECT year, 
	unemployment_rate, 
	unemployment_rate - lag(unemployment_rate)
	OVER (ORDER BY year) AS ur_change_by_year,
	ROUND((((unemployment_rate - lag(unemployment_rate) OVER (ORDER BY year)) /
	LAG(unemployment_rate) OVER (ORDER BY year)) * 100), 4) as ur_percentage_change_by_year
	FROM Unemployment_Rate_NZ;