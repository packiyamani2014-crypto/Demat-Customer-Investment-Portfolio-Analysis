CREATE DATABASE demat_project;
USE demat_project;
SELECT DATABASE();
CREATE TABLE investment_data (
    CustomerID VARCHAR(20),
    CustomerName VARCHAR(100),
    Age INT,
    City VARCHAR(50),
    Investment_Date DATE,
    Product_Type VARCHAR(50),
    Gender VARCHAR(20),
    Investment_Amount DECIMAL(15,2),
    Occupation VARCHAR(100),
    Profit_Loss DECIMAL(15,2),
    ProfitLossStatus VARCHAR(30),
    DematAccountID VARCHAR(30),
    InvestmentType VARCHAR(50),
    AccountStatus VARCHAR(30),
    Current_Price DECIMAL(15,2),
    Purchase_Price DECIMAL(15,2),
    ReturnLevel VARCHAR(30),
    InvestmentDurationMonths INT,
    Investment_Date_2 DATE,
    Quantity INT,
    Return_Percentage DECIMAL(10,2)
);
USE demat_project;

DESCRIBE investment_data;
SELECT
    COUNT(DISTINCT CustomerID) AS Total_Customers
FROM investment_data;
SELECT
    SUM(Investment_Amount) AS Total_Investment
FROM investment_data;
SELECT
    SUM(Investment_Amount) /
    COUNT(DISTINCT CustomerID) AS Average_Investment_Per_Customer
FROM investment_data;
SELECT
    CustomerID,
    CustomerName,
    SUM(Investment_Amount) AS Total_Investment
FROM investment_data
GROUP BY
    CustomerID,
    CustomerName
ORDER BY Total_Investment DESC
LIMIT 10;
SELECT
    CASE
        WHEN Age BETWEEN 18 AND 25 THEN '18-25'
        WHEN Age BETWEEN 26 AND 35 THEN '26-35'
        WHEN Age BETWEEN 36 AND 45 THEN '36-45'
        WHEN Age BETWEEN 46 AND 55 THEN '46-55'
        ELSE '56+'
    END AS Age_Group,

    SUM(Investment_Amount) AS Total_Investment
FROM investment_data
GROUP BY Age_Group
ORDER BY Total_Investment DESC;

SELECT
    Product_Type,
    COUNT(DISTINCT CustomerID) AS Total_Customers
FROM investment_data
GROUP BY Product_Type
ORDER BY Total_Customers DESC;
SELECT
Product_Type,
    SUM(Investment_Amount) AS Total_Investment
FROM investment_data
GROUP BY Product_Type
ORDER BY Total_Investment DESC;
SELECT
    Product_Type,
    SUM(
        CASE
            WHEN Profit_Loss > 0 THEN 1
            ELSE 0
        END
    ) AS Profitable_Records
FROM investment_data
GROUP BY Product_Type
ORDER BY Profitable_Records DESC;
DESCRIBE investment_data;
SELECT
    Risk_Category,
    COUNT(DISTINCT CustomerID) AS Total_Customers,

    ROUND(
        COUNT(DISTINCT CustomerID) * 100.0 /
        (SELECT COUNT(DISTINCT CustomerID)
         FROM investment_data),
        2
    ) AS return_ percentage

FROM investment_data

GROUP BY Risk_Category;
SELECT
    ROUND(AVG(Return_Percentage), 2) AS Average_Return
FROM investment_data;
SELECT
    ROUND(
        SUM(Investment_Amount) /
        COUNT(DISTINCT CustomerID),
        2
    ) AS Average_Investment
FROM investment_data;
SELECT
    Product_Type,
    SUM(Investment_Amount) AS Total_Investment
FROM investment_data
GROUP BY Product_Type
ORDER BY Total_Investment DESC;
SELECT
    Product_Type,
    COUNT(DISTINCT CustomerID) AS Total_Customers
FROM investment_data
GROUP BY Product_Type
ORDER BY Total_Customers DESC;
SELECT
    Product_Type,
    ROUND(AVG(Return_Percentage), 2) AS Average_Return
FROM investment_data
GROUP BY Product_Type
ORDER BY Average_Return DESC;
SELECT
    CustomerID,
    SUM(Investment_Amount) AS Total_Investment
FROM investment_data
GROUP BY CustomerID
ORDER BY Total_Investment DESC
LIMIT 10;
SELECT
    CASE
        WHEN Age BETWEEN 18 AND 25 THEN '18-25'
        WHEN Age BETWEEN 26 AND 35 THEN '26-35'
        WHEN Age BETWEEN 36 AND 45 THEN '36-45'
        WHEN Age BETWEEN 46 AND 55 THEN '46-55'
        ELSE '56+'
    END AS Age_Group,
    SUM(Investment_Amount) AS Total_Investment
FROM investment_data
GROUP BY Age_Group
ORDER BY Total_Investment DESC;
SELECT
    City,
    SUM(Investment_Amount) AS Total_Investment
FROM investment_data
GROUP BY City
ORDER BY Total_Investment DESC;
SELECT
    DATE_FORMAT(Investment_Date, '%Y-%m') AS Investment_Month,
    SUM(Investment_Amount) AS Total_Investment
FROM investment_data
GROUP BY DATE_FORMAT(Investment_Date, '%Y-%m')
ORDER BY Investment_Month;
SELECT
    DATE_FORMAT(Investment_Date, '%Y-%m') AS Investment_Month,
    SUM(Investment_Amount) AS Total_Investment
FROM investment_data
GROUP BY DATE_FORMAT(Investment_Date, '%Y-%m')
ORDER BY Total_Investment DESC
LIMIT 1;
SELECT
    CASE
        WHEN Return_Percentage < 5 THEN 'Low Return'
        WHEN Return_Percentage <= 15 THEN 'Medium Return'
        ELSE 'High Return'
    END AS Return_Category,
    COUNT(DISTINCT CustomerID) AS Total_Customers,
    ROUND(AVG(Investment_Amount), 2) AS Average_Investment,
    ROUND(AVG(Return_Percentage), 2) AS Average_Return
FROM investment_data
GROUP BY Return_Category
ORDER BY Average_Return DESC;
CREATE OR REPLACE VIEW vw_customer_summary AS
SELECT
    CustomerID,
    SUM(Investment_Amount) AS Total_Investment,
    AVG(Return_Percentage) AS Average_Return
FROM investment_data
GROUP BY CustomerID;
CREATE OR REPLACE VIEW vw_product_summary AS
SELECT
    Product_Type,
    COUNT(DISTINCT CustomerID) AS Total_Customers,
    SUM(Investment_Amount) AS Total_Investment,
    AVG(Return_Percentage) AS Average_Return
FROM investment_data
GROUP BY Product_Type;
CREATE OR REPLACE VIEW vw_monthly_investment AS
SELECT
    DATE_FORMAT(Investment_Date, '%Y-%m') AS Investment_Month,
    SUM(Investment_Amount) AS Total_Investment
FROM investment_data
GROUP BY DATE_FORMAT(Investment_Date, '%Y-%m');
SELECT
    AVG(Return_Percentage) AS Average_Return_Percentage
FROM investment_data;
SELECT
    AVG(Investment_Amount) AS Average_Investment_Amount
FROM investment_data;