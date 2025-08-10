--SQL for Data Analysis
--Dataset: Customer_support_data

--Show all data
SELECT * 
FROM dbo.Customer_support_data;

-- Orders after 1 Aug 2023
SELECT * 
FROM dbo.Customer_support_data
WHERE TRY_CONVERT(date, order_date_time, 103) > '2023-08-01';

-- Total CSAT score per agent
SELECT Agent_name, SUM([CSAT_Score]) AS TotalCSAT
FROM dbo.Customer_support_data
GROUP BY Agent_name
ORDER BY TotalCSAT DESC;

-- Average item price per product category
SELECT Product_category, ROUND(AVG(Item_price), 2) AS AvgPrice
FROM dbo.Customer_support_data
GROUP BY Product_category
ORDER BY AvgPrice DESC;

-- Inner join - All agents with their product categories and managers
SELECT a.Agent_name, a.Product_category, b.Manager
FROM dbo.Customer_support_data a
INNER JOIN dbo.Customer_support_data b
    ON a.Agent_name = b.Agent_name;

-- Left Join - All agents and their product categories
SELECT a.Agent_name, 
       p.Product_category
FROM dbo.Customer_support_data a
LEFT JOIN dbo.Customer_support_data p
    ON a.Agent_name = p.Agent_name
ORDER BY a.Agent_name;

-- Right Join - All product categories and their agents
SELECT p.Product_category, 
       a.Agent_name
FROM dbo.Customer_support_data a
RIGHT JOIN dbo.Customer_support_data p
    ON a.Agent_name = p.Agent_name
ORDER BY p.Product_category;

-- Subquery - Products with price above average
SELECT Product_category, Item_price
FROM dbo.Customer_support_data
WHERE Item_price > (
    SELECT AVG(Item_price)
    FROM dbo.Customer_support_data
);

-- Create or replace a view for average CSAT score per agent
CREATE OR ALTER VIEW Average_CSAT_Per_Agent AS
SELECT Agent_name,
       ROUND(AVG([CSAT_Score]), 2) AS AvgCSAT
FROM dbo.Customer_support_data
GROUP BY Agent_name;

-- Query the view
SELECT * FROM Average_CSAT_Per_Agent;

-- Index for faster queries by agent and date
CREATE INDEX idx_custsupport_agent_orderdate
ON dbo.Customer_support_data (Agent_name, order_date_time);

-- Query 
SELECT Agent_name,
       order_date_time
FROM dbo.Customer_support_data
WHERE Agent_name = 'John Doe'
  AND order_date_time >= '2023-08-01';
