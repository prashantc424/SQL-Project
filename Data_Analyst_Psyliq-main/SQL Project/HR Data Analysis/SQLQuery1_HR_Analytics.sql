SELECT * FROM GENERAL_DATA;
select count(employeeid) as Total_Number_of_Employees from general_data
SELECT DISTINCT(JobRole) FROM GENERAL_DATA;
SELECT AVG(Age) as Average_Age FROM GENERAL_DATA 
SELECT [Emp Name] as Employee_Name,AGE FROM GENERAL_DATA WHERE yearsatcompany<5;
SELECT Department, COUNT(*) as Number FROM GENERAL_DATA GROUP BY DEPARTMENT;
SELECT EMPLOYEEID,[Emp Name] FROM GENERAL_DATA where joblevel=3;
 SELECT MAX(MONTHLYINCOME) as Max_Monthly_Income FROM GENERAL_DATA;
 SELECT EMPLOYEEID,[emp name] as Employees_who_Travel_Rarely FROM GENERAL_DATA WHERE BusinessTravel IN('TRAVEL_RARELY');
 SELECT DISTINCT(MaritalStatus) as MaritalStatus_Categories FROM GENERAL_DATA;
 SELECT EMPLOYEEID,[emp name] as Employee_with_years_between_2_and_4_at_Company FROM GENERAL_DATA WHERE TotalWorkingYears>2 AND
YEARSATCOMPANY<4;




SELECT 
    EmployeeID,
    [Emp Name],
    CurrentJobRole,
    PreviousJobRole,
    CurrentJobLevel,
    PreviousJobLevel
FROM (
    SELECT 
        EmployeeID,
        [Emp Name],
        JobRole AS CurrentJobRole,
        JobLevel AS CurrentJobLevel,
        LAG(JobRole) OVER (PARTITION BY EmployeeID ORDER BY YearsAtCompany) AS PreviousJobRole,
        LAG(JobLevel) OVER (PARTITION BY EmployeeID ORDER BY YearsAtCompany) AS PreviousJobLevel
    FROM general_data
) AS JobChanges
WHERE (CurrentJobRole <> PreviousJobRole)
    OR (CurrentJobLevel <> PreviousJobLevel)

SELECT Department,AVG(DistanceFromHome) as AVG_Distance_from_Home_to_Office FROM GENERAL_DATA GROUP BY DEPARTMENT;


SELECT top 5
    EmployeeID,
    [Emp Name],
    MonthlyIncome
FROM 
    general_data
ORDER BY 
    MonthlyIncome DESC
;

SELECT 
    COUNT(CASE WHEN YearsSinceLastPromotion <= 1 THEN 1 END) AS EmployeesWithPromotionLastYear,
    COUNT(*) AS TotalEmployees,
    (COUNT(CASE WHEN YearsSinceLastPromotion <= 1 THEN 1 END) * 100.0 / COUNT(*)) AS PercentagePromotedLastYear
FROM 
    general_data;


--SELECT 
--    a.EmployeeID,a.[emp name],
--   b.EnvironmentSatisfaction
--   -- e.JobSatisfaction,
--   -- e.WorkLifeBalance,
--   -- ed.OtherColumn1, -- Replace OtherColumn1, OtherColumn2, etc. with the relevant columns from the other table
--   -- ed.OtherColumn2
--FROM general_data a JOIN employee_survey_data b ON a.EmployeeID = b.EmployeeID 
--WHERE a.EnvironmentSatisfaction = (SELECT MAX(EnvironmentSatisfaction) FROM employee_data)
	
    --a.EnvironmentSatisfaction = (SELECT MIN(EnvironmentSatisfaction) FROM employee_data);

SELECT a.EmployeeID, a.[emp name],b.environmentsatisfaction
FROM general_data a
JOIN employee_survey_data b ON a.EmployeeID = b.EmployeeID
WHERE b.EnvironmentSatisfaction IN (
    SELECT MAX(EnvironmentSatisfaction) 
    FROM employee_survey_data
    UNION
    SELECT MIN(EnvironmentSatisfaction) 
    FROM employee_survey_data
);


SELECT EmployeeID, JobRole, MaritalStatus
FROM general_Data e1
WHERE EXISTS (
    SELECT 1
    FROM general_Data e2
    WHERE e1.EmployeeID <> e2.EmployeeID
    AND e1.JobRole = e2.JobRole
    AND e1.MaritalStatus = e2.MaritalStatus
)
ORDER BY JobRole, MaritalStatus, EmployeeID;


--SELECT a.EmployeeID, a.[emp name]
--FROM general_data a
--JOIN manager_survey_data b ON a.EmployeeID = b.EmployeeID
--WHERE b.performancerating IN (
--    SELECT MAX(performancerating) 
--    FROM manager_survey_data) and (SELECT Max(totalworkingyears) 
--    FROM general_data)
--
select* from manager_survey_data

SELECT a.EmployeeID, a.[Emp name]
FROM general_data a
JOIN manager_survey_data b ON a.EmployeeID = b.EmployeeID
WHERE b.performancerating = 4
AND a.totalworkingyears = (
    SELECT MAX(totalworkingyears)
    FROM general_data
    WHERE EmployeeID IN (
        SELECT EmployeeID
        FROM manager_survey_data
        WHERE performancerating = 4
    )
);


 SELECT AVG(age) as Average_Age,AVG(JobSatisfaction) as JobSatisfaction_AVG
FROM GENERAL_DATA a  join employee_survey_data b on a.EmployeeID=b.EmployeeID
GROUP BY BusinessTravel;


SELECT TOP 1 EducationField, COUNT(*) AS FieldCount
FROM general_Data
GROUP BY EducationField
ORDER BY COUNT(*) DESC;


SELECT EmployeeID, [emp name], YearsAtCompany, YearsSinceLastPromotion
FROM general_data
WHERE YearsAtCompany = (
    SELECT MAX(YearsAtCompany)
    FROM general_data
)
AND YearsSinceLastPromotion = 0;
