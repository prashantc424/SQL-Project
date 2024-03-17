SELECT COLUMN_NAME
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'purchase';

SELECT DISTINCT Category_Grouped
FROM purchase;

SELECT COUNT(DISTINCT Category_Grouped) AS UniqueCategoriesCount
FROM Purchase;

SELECT TOP 5 Shipping_city, COUNT(*) AS OrdersCount
FROM Purchase
GROUP BY Shipping_city
ORDER BY OrdersCount DESC;

SELECT *
FROM Purchase
WHERE Category_Grouped = 'Electronics';

SELECT *
FROM Purchase
WHERE Category_Grouped = 'Electronics' AND Sale_Flag = 'Yes';




SELECT TOP 1 *
FROM Purchase
ORDER BY Item_Price DESC;

SELECT *,
    CASE
        WHEN Special_Price_effective < 50 THEN 'Below $50'
        ELSE 'Above $50'
    END AS Price_Category
FROM Purchase;


SELECT Category_Grouped, SUM(Item_Price) AS TotalSalesValue
FROM Purchase
GROUP BY Category_Grouped;

---question 8,9 power bi

UPDATE Purchase
SET Payment_Method = 
    CASE 
        WHEN Payment_Method NOT IN ('Visa', 'MasterCard') THEN NULL -- Replace with appropriate value
        ELSE Payment_Method 
    END;

SELECT Product_Gender, AVG(Quantity) AS AverageQuantitySold
FROM Purchase
WHERE Category_Grouped = 'Clothing'
GROUP BY Product_Gender;

SELECT TOP 5 *,
       Value_CM1 / NULLIF(Value_CM2, 0) AS Ratio_Value_CM1_to_CM2
FROM Purchase
WHERE Value_CM2 <> 0
ORDER BY Ratio_Value_CM1_to_CM2 DESC;

SELECT TOP 3 Class, SUM(Item_Price) AS TotalSales
FROM Purchase
GROUP BY Class
ORDER BY TotalSales DESC;

SELECT Color
FROM Purchase
WHERE Item_NM = 'your_specific_Item_NM';

SELECT 
    SUM(coupon_money_effective) AS TotalCouponMoney,
    SUM(Coupon_Percentage) AS TotalCouponPercentage
FROM Purchase
WHERE Category_Grouped = 'Electronics';

--SELECT top 1
--    DATEPART(month, YourDateColumn) AS SalesMonth,
--    SUM(Item_Price) AS TotalSales
--FROM Purchase
--GROUP BY DATEPART(month, YourDateColumn)
--ORDER BY TotalSales DESC
--
SELECT AVG(Item_Price) AS AverageItemPrice
FROM Purchase
WHERE Sale_Flag = 'Yes';

SELECT *
FROM Purchase P1
WHERE Paid_pr > (
    SELECT AVG(Paid_pr)
    FROM Purchase P2
    WHERE P1.Family = P2.Family AND P1.Brand = P2.Brand
);

SELECT 
    Color,
    SUM(Item_Price) AS TotalSales
FROM Purchase
WHERE Category_Grouped = 'Clothing'
GROUP BY Color;
