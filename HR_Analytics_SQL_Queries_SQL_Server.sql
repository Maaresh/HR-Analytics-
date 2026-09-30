USE HR_Analytics_DB;
GO

/* HR Analytics Project - SQL Server / SSMS
   Table: dbo.HR_Analytics
   Assumed standard HR Analytics employee attrition columns.
*/

-- 1. Check data
SELECT TOP 10 * FROM dbo.HR_Analytics;
SELECT COUNT(*) AS Total_Employees FROM dbo.HR_Analytics;

-- 2. Attrition count
SELECT COUNT(*) AS Attrition_Count
FROM dbo.HR_Analytics
WHERE Attrition = 'Yes';

-- 3. Attrition rate
SELECT
    COUNT(CASE WHEN Attrition = 'Yes' THEN 1 END) AS Attrition_Count,
    COUNT(*) AS Total_Employees,
    CAST(100.0 * COUNT(CASE WHEN Attrition = 'Yes' THEN 1 END)
         / NULLIF(COUNT(*),0) AS DECIMAL(10,2)) AS Attrition_Rate_Percent
FROM dbo.HR_Analytics;

-- 4. Attrition breakdown
SELECT Attrition, COUNT(*) AS Employee_Count
FROM dbo.HR_Analytics
GROUP BY Attrition;

-- 5. Employees by department
SELECT Department, COUNT(*) AS Employee_Count
FROM dbo.HR_Analytics
GROUP BY Department
ORDER BY Employee_Count DESC;

-- 6. Attrition by department
SELECT
    Department,
    COUNT(*) AS Total_Employees,
    SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END) AS Attrition_Count,
    CAST(100.0 * SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END)
         / NULLIF(COUNT(*),0) AS DECIMAL(10,2)) AS Attrition_Rate_Percent
FROM dbo.HR_Analytics
GROUP BY Department
ORDER BY Attrition_Rate_Percent DESC;

-- 7. Employees by job role
SELECT JobRole, COUNT(*) AS Employee_Count
FROM dbo.HR_Analytics
GROUP BY JobRole
ORDER BY Employee_Count DESC;

-- 8. Attrition by job role
SELECT
    JobRole,
    COUNT(*) AS Total_Employees,
    SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END) AS Attrition_Count,
    CAST(100.0 * SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END)
         / NULLIF(COUNT(*),0) AS DECIMAL(10,2)) AS Attrition_Rate_Percent
FROM dbo.HR_Analytics
GROUP BY JobRole
ORDER BY Attrition_Rate_Percent DESC;

-- 9. Attrition by gender
SELECT
    Gender,
    COUNT(*) AS Total_Employees,
    SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END) AS Attrition_Count,
    CAST(100.0 * SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END)
         / NULLIF(COUNT(*),0) AS DECIMAL(10,2)) AS Attrition_Rate_Percent
FROM dbo.HR_Analytics
GROUP BY Gender;

-- 10. Attrition by overtime
SELECT
    OverTime,
    COUNT(*) AS Total_Employees,
    SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END) AS Attrition_Count,
    CAST(100.0 * SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END)
         / NULLIF(COUNT(*),0) AS DECIMAL(10,2)) AS Attrition_Rate_Percent
FROM dbo.HR_Analytics
GROUP BY OverTime;

-- 11. Attrition by business travel
SELECT
    BusinessTravel,
    COUNT(*) AS Total_Employees,
    SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END) AS Attrition_Count,
    CAST(100.0 * SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END)
         / NULLIF(COUNT(*),0) AS DECIMAL(10,2)) AS Attrition_Rate_Percent
FROM dbo.HR_Analytics
GROUP BY BusinessTravel;

-- 12. Salary distribution
SELECT
    CASE
        WHEN MonthlyIncome < 3000 THEN 'Below 3K'
        WHEN MonthlyIncome < 6000 THEN '3K - 5.9K'
        WHEN MonthlyIncome < 10000 THEN '6K - 9.9K'
        ELSE '10K+'
    END AS Salary_Slab,
    COUNT(*) AS Employee_Count
FROM dbo.HR_Analytics
GROUP BY
    CASE
        WHEN MonthlyIncome < 3000 THEN 'Below 3K'
        WHEN MonthlyIncome < 6000 THEN '3K - 5.9K'
        WHEN MonthlyIncome < 10000 THEN '6K - 9.9K'
        ELSE '10K+'
    END;

-- 13. Attrition by salary slab
SELECT
    CASE
        WHEN MonthlyIncome < 3000 THEN 'Below 3K'
        WHEN MonthlyIncome < 6000 THEN '3K - 5.9K'
        WHEN MonthlyIncome < 10000 THEN '6K - 9.9K'
        ELSE '10K+'
    END AS Salary_Slab,
    COUNT(*) AS Total_Employees,
    SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END) AS Attrition_Count,
    CAST(100.0 * SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END)
         / NULLIF(COUNT(*),0) AS DECIMAL(10,2)) AS Attrition_Rate_Percent
FROM dbo.HR_Analytics
GROUP BY
    CASE
        WHEN MonthlyIncome < 3000 THEN 'Below 3K'
        WHEN MonthlyIncome < 6000 THEN '3K - 5.9K'
        WHEN MonthlyIncome < 10000 THEN '6K - 9.9K'
        ELSE '10K+'
    END;

-- 14. Average income by department
SELECT
    Department,
    COUNT(*) AS Employee_Count,
    CAST(AVG(CAST(MonthlyIncome AS DECIMAL(18,2))) AS DECIMAL(18,2)) AS Average_Monthly_Income
FROM dbo.HR_Analytics
GROUP BY Department
ORDER BY Average_Monthly_Income DESC;

-- 15. Average income by job role
SELECT
    JobRole,
    COUNT(*) AS Employee_Count,
    CAST(AVG(CAST(MonthlyIncome AS DECIMAL(18,2))) AS DECIMAL(18,2)) AS Average_Monthly_Income
FROM dbo.HR_Analytics
GROUP BY JobRole
ORDER BY Average_Monthly_Income DESC;

-- 16. Job satisfaction vs attrition
SELECT
    JobSatisfaction,
    COUNT(*) AS Total_Employees,
    SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END) AS Attrition_Count,
    CAST(100.0 * SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END)
         / NULLIF(COUNT(*),0) AS DECIMAL(10,2)) AS Attrition_Rate_Percent
FROM dbo.HR_Analytics
GROUP BY JobSatisfaction
ORDER BY JobSatisfaction;

-- 17. Work-life balance vs attrition
SELECT
    WorkLifeBalance,
    COUNT(*) AS Total_Employees,
    SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END) AS Attrition_Count,
    CAST(100.0 * SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END)
         / NULLIF(COUNT(*),0) AS DECIMAL(10,2)) AS Attrition_Rate_Percent
FROM dbo.HR_Analytics
GROUP BY WorkLifeBalance
ORDER BY WorkLifeBalance;

-- 18. Environment satisfaction vs attrition
SELECT
    EnvironmentSatisfaction,
    COUNT(*) AS Total_Employees,
    SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END) AS Attrition_Count,
    CAST(100.0 * SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END)
         / NULLIF(COUNT(*),0) AS DECIMAL(10,2)) AS Attrition_Rate_Percent
FROM dbo.HR_Analytics
GROUP BY EnvironmentSatisfaction
ORDER BY EnvironmentSatisfaction;

-- 19. Attrition by tenure
SELECT
    CASE
        WHEN YearsAtCompany < 2 THEN 'Less than 2 Years'
        WHEN YearsAtCompany <= 5 THEN '2 - 5 Years'
        WHEN YearsAtCompany <= 10 THEN '6 - 10 Years'
        ELSE '10+ Years'
    END AS Tenure_Group,
    COUNT(*) AS Total_Employees,
    SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END) AS Attrition_Count,
    CAST(100.0 * SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END)
         / NULLIF(COUNT(*),0) AS DECIMAL(10,2)) AS Attrition_Rate_Percent
FROM dbo.HR_Analytics
GROUP BY
    CASE
        WHEN YearsAtCompany < 2 THEN 'Less than 2 Years'
        WHEN YearsAtCompany <= 5 THEN '2 - 5 Years'
        WHEN YearsAtCompany <= 10 THEN '6 - 10 Years'
        ELSE '10+ Years'
    END
ORDER BY Attrition_Rate_Percent DESC;

-- 20. Attrition by total working years
SELECT
    CASE
        WHEN TotalWorkingYears < 5 THEN '0 - 4 Years'
        WHEN TotalWorkingYears <= 10 THEN '5 - 10 Years'
        WHEN TotalWorkingYears <= 20 THEN '11 - 20 Years'
        ELSE '20+ Years'
    END AS Experience_Group,
    COUNT(*) AS Total_Employees,
    SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END) AS Attrition_Count,
    CAST(100.0 * SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END)
         / NULLIF(COUNT(*),0) AS DECIMAL(10,2)) AS Attrition_Rate_Percent
FROM dbo.HR_Analytics
GROUP BY
    CASE
        WHEN TotalWorkingYears < 5 THEN '0 - 4 Years'
        WHEN TotalWorkingYears <= 10 THEN '5 - 10 Years'
        WHEN TotalWorkingYears <= 20 THEN '11 - 20 Years'
        ELSE '20+ Years'
    END
ORDER BY Attrition_Rate_Percent DESC;

-- 21. Current role tenure vs attrition
SELECT
    CASE
        WHEN YearsInCurrentRole <= 1 THEN '0 - 1 Year'
        WHEN YearsInCurrentRole <= 4 THEN '2 - 4 Years'
        WHEN YearsInCurrentRole <= 8 THEN '5 - 8 Years'
        ELSE '9+ Years'
    END AS Current_Role_Tenure,
    COUNT(*) AS Total_Employees,
    SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END) AS Attrition_Count,
    CAST(100.0 * SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END)
         / NULLIF(COUNT(*),0) AS DECIMAL(10,2)) AS Attrition_Rate_Percent
FROM dbo.HR_Analytics
GROUP BY
    CASE
        WHEN YearsInCurrentRole <= 1 THEN '0 - 1 Year'
        WHEN YearsInCurrentRole <= 4 THEN '2 - 4 Years'
        WHEN YearsInCurrentRole <= 8 THEN '5 - 8 Years'
        ELSE '9+ Years'
    END;

-- 22. Promotion gap vs attrition
SELECT
    CASE
        WHEN YearsSinceLastPromotion <= 1 THEN '0 - 1 Year'
        WHEN YearsSinceLastPromotion <= 4 THEN '2 - 4 Years'
        WHEN YearsSinceLastPromotion <= 8 THEN '5 - 8 Years'
        ELSE '9+ Years'
    END AS Promotion_Gap,
    COUNT(*) AS Total_Employees,
    SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END) AS Attrition_Count,
    CAST(100.0 * SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END)
         / NULLIF(COUNT(*),0) AS DECIMAL(10,2)) AS Attrition_Rate_Percent
FROM dbo.HR_Analytics
GROUP BY
    CASE
        WHEN YearsSinceLastPromotion <= 1 THEN '0 - 1 Year'
        WHEN YearsSinceLastPromotion <= 4 THEN '2 - 4 Years'
        WHEN YearsSinceLastPromotion <= 8 THEN '5 - 8 Years'
        ELSE '9+ Years'
    END;

-- 23. Performance rating vs attrition
SELECT
    PerformanceRating,
    COUNT(*) AS Total_Employees,
    SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END) AS Attrition_Count,
    CAST(100.0 * SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END)
         / NULLIF(COUNT(*),0) AS DECIMAL(10,2)) AS Attrition_Rate_Percent
FROM dbo.HR_Analytics
GROUP BY PerformanceRating
ORDER BY PerformanceRating;

-- 24. Training vs attrition
SELECT
    TrainingTimesLastYear,
    COUNT(*) AS Total_Employees,
    SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END) AS Attrition_Count,
    CAST(100.0 * SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END)
         / NULLIF(COUNT(*),0) AS DECIMAL(10,2)) AS Attrition_Rate_Percent
FROM dbo.HR_Analytics
GROUP BY TrainingTimesLastYear
ORDER BY TrainingTimesLastYear;

-- 25. Department + job role + overtime analysis
SELECT
    Department,
    JobRole,
    OverTime,
    COUNT(*) AS Total_Employees,
    SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END) AS Attrition_Count,
    CAST(100.0 * SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END)
         / NULLIF(COUNT(*),0) AS DECIMAL(10,2)) AS Attrition_Rate_Percent
FROM dbo.HR_Analytics
GROUP BY Department, JobRole, OverTime
ORDER BY Attrition_Rate_Percent DESC;

-- 26. Top job roles by attrition count
SELECT TOP 10
    JobRole,
    COUNT(*) AS Attrition_Count
FROM dbo.HR_Analytics
WHERE Attrition='Yes'
GROUP BY JobRole
ORDER BY Attrition_Count DESC;

-- 27. High-income employees who left
SELECT
    EmployeeNumber,
    Age,
    Department,
    JobRole,
    MonthlyIncome,
    OverTime,
    JobSatisfaction,
    YearsAtCompany,
    Attrition
FROM dbo.HR_Analytics
WHERE Attrition='Yes'
  AND MonthlyIncome >= 10000
ORDER BY MonthlyIncome DESC;

-- 28. Data quality - NULL checks
SELECT
    SUM(CASE WHEN EmployeeNumber IS NULL THEN 1 ELSE 0 END) AS Null_EmployeeNumber,
    SUM(CASE WHEN Department IS NULL THEN 1 ELSE 0 END) AS Null_Department,
    SUM(CASE WHEN JobRole IS NULL THEN 1 ELSE 0 END) AS Null_JobRole,
    SUM(CASE WHEN Attrition IS NULL THEN 1 ELSE 0 END) AS Null_Attrition,
    SUM(CASE WHEN MonthlyIncome IS NULL THEN 1 ELSE 0 END) AS Null_MonthlyIncome
FROM dbo.HR_Analytics;

-- 29. Duplicate employee numbers
SELECT EmployeeNumber, COUNT(*) AS Record_Count
FROM dbo.HR_Analytics
GROUP BY EmployeeNumber
HAVING COUNT(*) > 1
ORDER BY Record_Count DESC;

-- 30. Employee profile with window function
SELECT
    EmployeeNumber,
    Department,
    JobRole,
    MonthlyIncome,
    AVG(MonthlyIncome) OVER (PARTITION BY Department) AS Dept_Avg_Income,
    MonthlyIncome -
        AVG(MonthlyIncome) OVER (PARTITION BY Department) AS Difference_From_Dept_Avg
FROM dbo.HR_Analytics
ORDER BY Department, MonthlyIncome DESC;
