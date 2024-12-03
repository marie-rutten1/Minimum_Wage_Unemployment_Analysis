SELECT 
	Year,
	Adult as Minimum_wage,
	Adult - LAG(Adult)
	OVER (ORDER by Year) As mw_Change_by_year,
	ROUND((((ADULT - LAG(Adult) OVER (ORDER by Year)) /
	LAG(ADULT) OVER (ORDER by Year)) * 100), 4) as mw_percentage_change_by_year
	FROM Minimum_Wage;