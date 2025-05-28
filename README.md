📊 Minimum Wage vs Unemployment Rate in New Zealand – README

📝 Overview

This project explores the relationship between New Zealand's minimum wage and the national unemployment rate over time. By combining publicly available datasets, the analysis aims to identify trends and correlations between wage policy changes and employment outcomes.

📁 Project Contents

| File                               | Description                                                                                                 |
| ---------------------------------- | ----------------------------------------------------------------------------------------------------------- |
| `Minimum_Wage_NZ.csv`              | Contains annual minimum wage rates (typically effective from April each year).                              |
| `Unemployment_Rate_NZ.csv`         | Contains annual unemployment rate data (June quarter only, for people aged 15–64).                                |
| `neet_rate_analysis.sql`           | SQL scripts for cleaning and transforming the data (e.g., splitting quarters, calculating yearly averages). |
| `minimum_wage_vs_unemployment.sql` | SQL queries to aggregate and join wage and unemployment rate data for comparison.                           |
| `README.md`                        | This file. Summary of the purpose, sources, and approach.                                                   |

📊 Data Sources

Minimum Wage Rates:
Sourced from employment.govt.nz – Previous minimum wage rates.
The historical minimum wage rates were extracted manually from the website's table into an Excel spreadsheet.

Unemployment Rate:
Sourced from Stats NZ – Household Labour Force Survey (HLF):
Labour Force Status for people aged 15 to 64 years (Annual – June quarter).
This dataset captures the seasonally adjusted unemployment rate as of the June quarter each year.

Why June?

The June quarter was selected because New Zealand’s minimum wage changes typically take effect in April each year. Using June quarter unemployment data allows sufficient time for any initial impacts of these wage changes to be reflected in the labour market statistics.

🧮 Methodology

Data Preparation:

Minimum wage rates were matched to their corresponding calendar year.

Unemployment rate data was already extracted as June quarter values from Stats NZ. This dataset was initially sorted in Excel by year to ensure the records aligned with the minimum wage dataset before being uploaded to SQL.

Ensured both datasets were in the same chronological order to facilitate accurate joins and comparisons.

Data Joining:

Annual minimum wage values were joined with corresponding June quarter unemployment rates to allow year-on-year comparison.

Analysis Preparation:

Focused on consistent, representative time points for valid comparison.

Verified data alignment by year for accuracy in trend analysis.

🔍 Analysis Goals

Investigate whether increases in minimum wage correlate with changes in unemployment levels.

Identify broader trends in wage policy and labour market response.

Set up for potential extensions of analysis (e.g., NEET rate, youth unemployment, or lag effects).

📌 Notes

This analysis currently focuses on the overall unemployment rate for working-age individuals (15–64), not youth-specific figures.

Only June quarter data is used for unemployment rates to maintain consistency and allow time for minimum wage changes (usually implemented in April) to potentially affect employment figures.

Minimum wage refers to the adult minimum wage, not the starting-out or training wage.

🛠 Tools Used

PostgreSQL (for data transformation and SQL queries)

Excel (for manual data extraction and formatting)

Official data sources:

employment.govt.nz

Stats NZ – Household Labour Force Survey
