SELECT * FROM pharma_data;

 SELECT COUNT(DISTINCT Country) AS UniqueCountriesCount FROM pharma_data;

 SELECT [Customer Name]
FROM pharma_data
WHERE Channel = 'Retail';

SELECT SUM(Quantity) AS TotalQuantitySold
FROM pharma_data
WHERE [Product Class] = 'Electronics';

SELECT DISTINCT Month
FROM pharma_data

SELECT Year, SUM(Sales) AS TotalSales
FROM pharma_data
GROUP BY Year;

SELECT top 1 [Customer Name], MAX(Sales) AS HighestSales
FROM pharma_data
GROUP BY [Customer Name]
ORDER BY HighestSales DESC

SELECT DISTINCT(a.[Name of Sales Rep])
FROM pharma_data AS a
JOIN pharma_data AS m ON a.Manager = m.[Name of Sales Rep]
WHERE m.Manager = 'John Smith'
 AND a.[Sales Team] = 'Sales Rep';

 SELECT top 5 City, SUM(Sales) AS TotalSales
FROM pharma_data
GROUP BY City
ORDER BY TotalSales DESC

SELECT [Sub-channel], AVG(Price) AS AveragePrice
FROM pharma_data
GROUP BY [Sub-channel];

--SELECT e.Employee_Name, p.*
--FROM Employees AS e
--JOIN pharma_data AS p ON e.Name_of_Sales_Rep = p.Name_of_Sales_Rep;
--
SELECT *
FROM pharma_data
WHERE City = 'Rendsburg'
AND YEAR([year]) = 2018;

SELECT 
    [Year],
    [Month],
    [Product Class],
    SUM(Sales) AS TotalSales
FROM pharma_data
GROUP BY [Year], [Month], [Product Class]
ORDER BY [Year], [Month], [Product Class];


SELECT top 3
    [Name of Sales Rep],
    SUM(Sales) AS TotalSales
FROM pharma_data
WHERE YEAR([year]) = 2019
GROUP BY [Name of Sales Rep]
ORDER BY TotalSales DESC



;WITH MonthlyTotalSales AS (
    SELECT 
        [Year] AS SalesYear,
        [Month] AS SalesMonth,
        [Sub-channel],
        SUM(Sales) AS MonthlySales
    FROM pharma_data
    GROUP BY [Year], [Month], [Sub-channel]
),
AverageMonthlySales AS (
    SELECT 
        [Sub-channel],
        AVG(MonthlySales) AS AvgMonthlySales
    FROM MonthlyTotalSales
    GROUP BY [Sub-channel]
)
SELECT 
    [Sub-channel],
    AVG(AvgMonthlySales) AS AverageMonthlySales
FROM AverageMonthlySales
GROUP BY [Sub-channel];




SELECT 
    [Product Class],
    SUM(Sales) AS TotalSales,
    AVG(Price) AS AveragePrice,
    SUM(Quantity) AS TotalQuantity
FROM pharma_data
GROUP BY [Product Class];



;WITH RankedSales AS (
    SELECT 
        [Customer Name],
        [Year] AS SalesYear,
        SUM(Sales) AS TotalSales,
        ROW_NUMBER() OVER (PARTITION BY [Year] ORDER BY SUM(Sales) DESC) AS SalesRank
    FROM pharma_data
    GROUP BY [Customer Name], [Year]
)
SELECT 
    [Customer Name],
    SalesYear,
    TotalSales
FROM RankedSales
WHERE SalesRank <= 5;



;WITH SalesByYear AS (
    SELECT 
        [Year] AS SalesYear,
        Country,
        SUM(Sales) AS TotalSales
    FROM pharma_data
    GROUP BY [Year], Country
)
SELECT 
    Country,
    SalesYear,
    TotalSales,
    LAG(TotalSales) OVER (PARTITION BY Country ORDER BY SalesYear) AS PreviousYearSales,
    CASE 
        WHEN LAG(TotalSales) OVER (PARTITION BY Country ORDER BY SalesYear) IS NULL THEN NULL
        ELSE (TotalSales - LAG(TotalSales) OVER (PARTITION BY Country ORDER BY SalesYear)) / LAG(TotalSales) OVER (PARTITION BY Country ORDER BY SalesYear) * 100
    END AS YearOverYearGrowth
FROM SalesByYear
ORDER BY Country, SalesYear;




SELECT
    [Year],
    [Month],
    TotalSales AS LowestSales
FROM (
    SELECT
        SUBSTRING([Month], 1, 3) AS [Month],
        [Year],
        SUM(Sales) AS TotalSales,
        ROW_NUMBER() OVER (PARTITION BY [Year] ORDER BY SUM(Sales) ASC) AS SalesRank
    FROM pharma_data
    GROUP BY
        [Year],
        SUBSTRING([Month], 1, 3)
) AS MonthlySales
WHERE SalesRank = 1
ORDER BY
    [Year];


	;WITH SubChannelSales AS (
    SELECT
        Country,
        [Sub-channel],
        SUM(Sales) AS TotalSales,
        ROW_NUMBER() OVER(PARTITION BY [Sub-Channel] ORDER BY SUM(Sales) DESC) AS CountryRank
    FROM
        Pharma_data -- Replace 'YourTableName' with your actual table name
    GROUP BY
        Country,
        [Sub-channel]
)

SELECT
    Country,
    [Sub-channel],
    TotalSales
FROM
    SubChannelSales
WHERE
    CountryRank = 1
ORDER BY
    [Sub-Channel];
