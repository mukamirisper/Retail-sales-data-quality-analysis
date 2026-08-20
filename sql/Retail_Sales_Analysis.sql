USE retail_data;

-- ============================================================
-- RETAIL SALES DATA QUALITY & BUSINESS ANALYSIS
-- Tools: MySQL, Excel, Power BI
-- Dataset: Retail Sales Analysis
-- ============================================================
-- ============================================================
-- 01. DATA QUALITY VALIDATION
-- ============================================================

-- 1. Missing Customer IDs
SELECT COUNT(*) AS Missing_Customer_IDs
FROM retail_sales_data
WHERE Customer_ID IS NULL;

-- 2. Missing Order IDs
SELECT COUNT(*) AS Missing_Order_IDs
FROM retail_sales_data
WHERE Order_ID IS NULL;

-- 3. Duplicate Row IDs
SELECT
    Row_ID,
    COUNT(*) AS Occurrences
FROM retail_sales_data
GROUP BY Row_ID
HAVING COUNT(*) > 1;

-- 4. Invalid Sales
SELECT COUNT(*) AS Invalid_Sales
FROM retail_sales_data
WHERE Sales < 0;

-- 5. Invalid Quantity
SELECT COUNT(*) AS Invalid_Quantity
FROM retail_sales_data
WHERE Quantity < 0;

-- 6. Invalid Discount
SELECT COUNT(*) AS Invalid_Discount
FROM retail_sales_data
WHERE Discount < 0
   OR Discount > 1;

-- 7. Invalid Shipping Dates
SELECT COUNT(*) AS Invalid_Shipping_Dates
FROM retail_sales_data
WHERE Ship_Date < Order_Date;

-- 8. Customer ID / Name inconsistencies
SELECT COUNT(*) AS Inconsistent_Customer_IDs
FROM (
    SELECT Customer_ID
    FROM retail_sales_data
    GROUP BY Customer_ID
    HAVING COUNT(DISTINCT Customer_Name) > 1
) AS InconsistentCustomers;
-- ============================================================
-- 02. BUSINESS KPIs
-- ============================================================

-- Total Orders
SELECT
    COUNT(DISTINCT Order_ID) AS Total_Orders
FROM retail_sales_data;

-- Total Quantity Sold
SELECT
    SUM(Quantity) AS Total_Quantity_Sold
FROM retail_sales_data;

-- Total Sales
SELECT
    ROUND(SUM(Sales), 2) AS Total_Sales
FROM retail_sales_data;

-- Total Profit
SELECT
    ROUND(SUM(Profit), 2) AS Total_Profit
FROM retail_sales_data;

-- Profit Margin
SELECT
    ROUND(
        SUM(Profit) * 100.0 / SUM(Sales),
        2
    ) AS Profit_Margin_Percentage
FROM retail_sales_data;

-- Average Order Value
SELECT
    ROUND(
        SUM(Sales) / COUNT(DISTINCT Order_ID),
        2
    ) AS Average_Order_Value
FROM retail_sales_data;
-- ============================================================
-- 03. REGIONAL PERFORMANCE
-- ============================================================

-- Sales by Region
SELECT
    Region,
    ROUND(SUM(Sales), 2) AS Total_Sales
FROM retail_sales_data
GROUP BY Region
ORDER BY Total_Sales DESC;

-- Profit by Region
SELECT
    Region,
    ROUND(SUM(Profit), 2) AS Total_Profit
FROM retail_sales_data
GROUP BY Region
ORDER BY Total_Profit DESC;

-- Regional Profitability
SELECT
    Region,
    ROUND(SUM(Sales), 2) AS Total_Sales,
    ROUND(SUM(Profit), 2) AS Total_Profit,
    ROUND(
        SUM(Profit) * 100.0 / SUM(Sales),
        2
    ) AS Profit_Margin_Percentage
FROM retail_sales_data
GROUP BY Region
ORDER BY Profit_Margin_Percentage DESC;

-- East Region: Category Performance
SELECT
    Category,
    ROUND(SUM(Sales), 2) AS Total_Sales,
    ROUND(SUM(Profit), 2) AS Total_Profit,
    ROUND(
        SUM(Profit) * 100.0 / SUM(Sales),
        2
    ) AS Profit_Margin_Percentage
FROM retail_sales_data
WHERE Region = 'East'
GROUP BY Category
ORDER BY Profit_Margin_Percentage ASC;
-- ============================================================
-- 04. CUSTOMER ANALYSIS
-- ============================================================

-- Top 10 Customers by Sales
SELECT
    Customer_ID,
    Customer_Name,
    ROUND(SUM(Sales), 2) AS Total_Sales
FROM retail_sales_data
GROUP BY Customer_ID, Customer_Name
ORDER BY Total_Sales DESC
LIMIT 10;

-- Top 10 Customers by Profit
SELECT
    Customer_ID,
    Customer_Name,
    ROUND(SUM(Sales), 2) AS Total_Sales,
    ROUND(SUM(Profit), 2) AS Total_Profit
FROM retail_sales_data
GROUP BY Customer_ID, Customer_Name
ORDER BY Total_Profit DESC
LIMIT 10;

-- Repeat vs One-Time Customers
SELECT
    SUM(CASE WHEN Order_Count > 1 THEN 1 ELSE 0 END)
        AS Repeat_Customers,
    SUM(CASE WHEN Order_Count = 1 THEN 1 ELSE 0 END)
        AS One_Time_Customers
FROM (
    SELECT
        Customer_ID,
        COUNT(DISTINCT Order_ID) AS Order_Count
    FROM retail_sales_data
    GROUP BY Customer_ID
) AS CustomerOrders;

-- Customer ID / Name Integrity
SELECT
    Customer_ID,
    COUNT(DISTINCT Customer_Name) AS Different_Names
FROM retail_sales_data
GROUP BY Customer_ID
HAVING COUNT(DISTINCT Customer_Name) > 1
ORDER BY Different_Names DESC;

-- Total Customer ID Integrity Issues
SELECT
    COUNT(*) AS Inconsistent_Customer_IDs
FROM (
    SELECT Customer_ID
    FROM retail_sales_data
    GROUP BY Customer_ID
    HAVING COUNT(DISTINCT Customer_Name) > 1
) AS InconsistentCustomers;

-- Unique Customer IDs vs Customer Names
SELECT
    COUNT(DISTINCT Customer_ID) AS Unique_Customer_IDs,
    COUNT(DISTINCT Customer_Name) AS Unique_Customer_Names
FROM retail_sales_data;
-- ============================================================
-- 05. CATEGORY & PRODUCT ANALYSIS
-- ============================================================

-- Category Performance
SELECT
    Category,
    COUNT(DISTINCT Order_ID) AS Total_Orders,
    ROUND(SUM(Sales), 2) AS Total_Sales,
    ROUND(SUM(Profit), 2) AS Total_Profit,
    ROUND(
        SUM(Profit) * 100.0 / SUM(Sales),
        2
    ) AS Profit_Margin_Percentage
FROM retail_sales_data
GROUP BY Category
ORDER BY Total_Sales DESC;

-- Top 10 Products by Sales
SELECT
    Product_Name,
    ROUND(SUM(Sales), 2) AS Total_Sales
FROM retail_sales_data
GROUP BY Product_Name
ORDER BY Total_Sales DESC
LIMIT 10;

-- Loss-Making Products
SELECT
    Product_Name,
    ROUND(SUM(Sales), 2) AS Total_Sales,
    ROUND(SUM(Profit), 2) AS Total_Profit
FROM retail_sales_data
GROUP BY Product_Name
HAVING SUM(Profit) < 0
ORDER BY Total_Profit ASC;

-- East Region: Technology Products
SELECT
    Product_Name,
    ROUND(SUM(Sales), 2) AS Total_Sales,
    ROUND(SUM(Profit), 2) AS Total_Profit
FROM retail_sales_data
WHERE Region = 'East'
  AND Category = 'Technology'
GROUP BY Product_Name
ORDER BY Total_Profit ASC;

-- East Technology: Product-Level Discount Analysis
SELECT
    Product_Name,
    SUM(Quantity) AS Total_Quantity,
    ROUND(SUM(Sales), 2) AS Total_Sales,
    ROUND(AVG(Discount) * 100, 2) AS Average_Discount_Percentage,
    ROUND(SUM(Profit), 2) AS Total_Profit
FROM retail_sales_data
WHERE Region = 'East'
  AND Category = 'Technology'
GROUP BY Product_Name
ORDER BY Total_Profit ASC;
-- ============================================================
-- 06. SALES TRENDS
-- ============================================================

-- Monthly Sales Trend
SELECT
    YEAR(Order_Date) AS Year,
    MONTH(Order_Date) AS Month,
    ROUND(SUM(Sales), 2) AS Total_Sales
FROM retail_sales_data
GROUP BY
    YEAR(Order_Date),
    MONTH(Order_Date)
ORDER BY
    Year,
    Month;
   -- ============================================================
-- END OF RETAIL SALES DATA ANALYSIS
-- ============================================================ 