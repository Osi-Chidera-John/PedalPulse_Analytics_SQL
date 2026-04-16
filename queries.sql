SELECT *
FROM sales;
       
       -- Removing Duplicates
CREATE TABLE `sales1` (
  `Date` text,
  `Day` int DEFAULT NULL,
  `Month` text,
  `Year` int DEFAULT NULL,
  `Customer_Age` int DEFAULT NULL,
  `Age_Group` text,
  `Customer_Gender` text,
  `Country` text,
  `State` text,
  `Product_Category` text,
  `Sub_Category` text,
  `Product` text,
  `Order_Quantity` int DEFAULT NULL,
  `Unit_Cost` int DEFAULT NULL,
  `Unit_Price` int DEFAULT NULL,
  `Profit` int DEFAULT NULL,
  `Cost` int DEFAULT NULL,
  `Revenue` int DEFAULT NULL,
  `Row_num` int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO sales1
SELECT *, ROW_NUMBER() OVER(PARTITION BY `Date`, `Day`, `Month`, `Year`,
Customer_Age, Age_Group, Customer_Gender,Country,
State,Product_Category,Sub_Category,Product,
Order_Quantity,Unit_Cost,Unit_Price,Profit,Cost,Revenue)
FROM sales;

DELETE
FROM sales1
WHERE Row_num > 1;

            -- Data Standardization
            
SELECT * 
FROM sales1;

UPDATE sales1
SET Age_Group = 'Youth'
WHERE Age_Group LIKE 'Youth (%)';

UPDATE sales1
SET Age_Group = 'Young Adults'
WHERE Age_Group LIKE 'Young Adults (%)';

UPDATE sales1
SET Age_Group = 'Adults'
WHERE Age_Group LIKE 'Adults (%)';

UPDATE sales1
SET Customer_Gender = 'Female'
WHERE Customer_Gender = 'F';

UPDATE sales1
SET Customer_Gender = 'Male'
WHERE Customer_Gender = 'M';

UPDATE sales1
SET `Date` = STR_TO_DATE(`Date`,'%Y/%m/%d');

ALTER TABLE sales1
MODIFY `Date` Date;

				-- Removing Unuseful Columns
ALTER TABLE sales1
DROP COLUMN Row_num;

ALTER TABLE sales1
DROP COLUMN `Day`;

ALTER TABLE sales1
DROP COLUMN `Month`;

ALTER TABLE sales1
DROP COLUMN `Year`;

              -- Yearly Best Performing Product Ranking By Total Profit Generated
WITH Product AS
(
SELECT YEAR(`Date`) AS `Year`, Product, 
 SUM(Revenue) AS Total_Revenue, SUM(Profit) AS Total_Profit
FROM sales1
GROUP BY YEAR(`Date`), Product
)
SELECT *, DENSE_RANK() OVER(PARTITION BY `Year` ORDER BY Total_Profit DESC) AS Best_Performing
FROM Product;

                -- Best Performing Year Ranking By Revenue/Profit Size
  WITH Yearly_Performance AS (
  SELECT YEAR(`date`) AS `Year`, 
  SUM(Revenue) AS Total_Revenue, SUM(Profit) AS Total_Profit
  FROM sales1
  GROUP BY YEAR(`date`)
  )
  SELECT *, DENSE_RANK() OVER(ORDER BY Total_Profit DESC) AS Best_Performing
  FROM Yearly_Performance;

                 -- Overall Revenue/Profit
SELECT SUM(Revenue) AS Overall_Revenue, SUM(Profit) AS Overall_Profit
FROM sales1;

                 -- Overall Volume Of Sales By Age_Group
WITH Preference AS (
SELECT Age_Group, Product, COUNT(Product) AS Num_Of_Sales
FROM sales1
GROUP BY Age_Group, Product
ORDER BY 3 DESC)
SELECT *, DENSE_RANK() OVER( PARTITION BY Age_Group ORDER BY Num_Of_Sales DESC) AS Ranking
FROM Preference;

                 -- Yearly Breakdown Of Customer Purchase Behaviour By Age_Group
SELECT Year(`date`) AS `Year`, Age_Group, SUM(Revenue) AS Total_Revenue,
 SUM(Profit) AS Total_Profit
FROM sales1
GROUP BY Age_Group, `Year`
ORDER BY 2 ASC;

				-- Overall Total Revenue/Profit By Age_Group
SELECT  Age_Group, SUM(Revenue) AS Total_Revenue,
 SUM(Profit) AS Total_Profit
FROM sales1
GROUP BY Age_Group
ORDER BY 2 DESC;

                   -- Overall Best Perfoming Country By Sales Volume
SELECT Country, SUM(Order_Quantity) AS Order_Size
FROM sales1
GROUP BY Country
ORDER BY 2 DESC;

				  -- Yearly Breakdown Of Best Perfoming Country By Sales Volume
SELECT Country, YEAR(`date`) AS `Year`, SUM(Order_Quantity) AS Order_Size
FROM sales1
GROUP BY Country, `Year`
ORDER BY 3 DESC;

                  -- Overall Best Perfoming Country By Revenue/Profit Size
SELECT Country, SUM(Revenue) AS Total_Revenue, SUM(Profit) AS Total_Profit
FROM sales1
GROUP BY Country
ORDER BY 2 DESC;

                  -- Yearly Breakdown Of Best Perfoming Country By Revenue Size
SELECT Country, YEAR(`date`) AS `Year`, SUM(Revenue) AS Revenue_Size
FROM sales1
GROUP BY Country, `Year`
ORDER BY 3 DESC;

              -- Overall Best Performing State In The United States By Revenue/Order Size
SELECT Country, State, SUM(Revenue) Total_Revenue, SUM(Order_Quantity) Order_Size
FROM sales1
WHERE Country = 'United States'
GROUP BY Country, State
ORDER BY 3 DESC;

			-- Overall Monthly Performance by Total Revenue/Order Size
WITH Monthly_Perf AS (
SELECT MONTH(`DATE`) AS `Month`, 
SUM(Order_Quantity) AS Order_size,
SUM(Revenue) AS Total_Revenue
FROM sales1
GROUP BY `Month`)
SELECT *, DENSE_RANK() OVER(ORDER BY TOtal_Revenue DESC) AS Ranking
FROM Monthly_Perf;

SELECT *
FROM sales1;

                -- Yearly Total Cost Of Purchasing All Products
SELECT YEAR(`date`) as `Year`,
 SUM(Cost) AS Total_Cost
FROM sales1
GROUP BY `Year`;

               -- Yearly Total Cost Of Purchasing Each Products And Profit Trend
SELECT YEAR(`date`) as `Year`,
 Product,
 SUM(Cost) AS Total_Cost,
 SUM(Profit) AS Total_Profit
FROM sales1
GROUP BY `Year`, Product;

               -- Yearly Performance Comparison
SELECT *, Total_Revenue - Previos_Year AS YoY_Increase,
 ROUND(((Total_Revenue - Previos_Year)/Previos_Year)*100,2) AS YoY_Percentage
FROM(
SELECT YEAR(`date`) AS `Year`, SUM(Revenue) AS Total_Revenue,
LAG(SUM(Revenue)) OVER(ORDER BY YEAR(`date`)) AS Previos_Year
FROM sales1
GROUP BY `Year`) AS X
;











































