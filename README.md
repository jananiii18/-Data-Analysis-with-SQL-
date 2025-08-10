# SQL for Data Analysis

This contains:
- Queries for basic to advanced SQL (SELECT, JOINs, subqueries, views, indexes)
- Screenshots of query results

##  How to run
1. Open SQL Server Management Studio (SSMS)
2. Create a database:
 ```sql
   CREATE DATABASE EcommerceDB;
```
3. Import Customer_support_data table
4. Run the queries and get the output

### 1. Show all data
```sql
SELECT * 
FROM dbo.Customer_support_data;
```
![Show all data](https://github.com/jananiii18/-Data-Analysis-with-SQL-/blob/f84a218f161f65b6ff4c808c9a05d0e03a46316e/Screenshot1.png)
### 2. Orders after 1 Aug 2023
```sql
SELECT * 
FROM dbo.Customer_support_data
WHERE TRY_CONVERT(date, order_date_time, 103) > '2023-08-01';
```
![Specific orders](https://github.com/jananiii18/-Data-Analysis-with-SQL-/blob/f84a218f161f65b6ff4c808c9a05d0e03a46316e/Screenshot2.png)
### 3. Total CSAT score per agent
```sql
SELECT Agent_name, SUM([CSAT_Score]) AS TotalCSAT
FROM dbo.Customer_support_data
GROUP BY Agent_name
ORDER BY TotalCSAT DESC;
```
![Sum](https://github.com/jananiii18/-Data-Analysis-with-SQL-/blob/f84a218f161f65b6ff4c808c9a05d0e03a46316e/Screenshot3.png)
### 4. Average item price per product category
```sql
SELECT Product_category, ROUND(AVG(Item_price), 2) AS AvgPrice
FROM dbo.Customer_support_data
GROUP BY Product_category
ORDER BY AvgPrice DESC;
```
![Average](https://github.com/jananiii18/-Data-Analysis-with-SQL-/blob/f84a218f161f65b6ff4c808c9a05d0e03a46316e/Screenshot4.png)
### 5. Inner join - All agents with their product categories and managers
```sql
SELECT a.Agent_name, a.Product_category, b.Manager
FROM dbo.Customer_support_data a
INNER JOIN dbo.Customer_support_data b
    ON a.Agent_name = b.Agent_name;
```
![Inner Join](https://github.com/jananiii18/-Data-Analysis-with-SQL-/blob/cbcc26b6e032540fe0cc93ca250f7f520ab7b11a/Screenshot5.png)
### 6. Left Join - All agents and their product categories
```sql
SELECT a.Agent_name, 
       p.Product_category
FROM dbo.Customer_support_data a
LEFT JOIN dbo.Customer_support_data p
    ON a.Agent_name = p.Agent_name
ORDER BY a.Agent_name;
```
![Left Join](https://github.com/jananiii18/-Data-Analysis-with-SQL-/blob/f84a218f161f65b6ff4c808c9a05d0e03a46316e/Screenshot6.png)
### 7. Right Join - All product categories and their agents
```sql
SELECT p.Product_category, 
       a.Agent_name
FROM dbo.Customer_support_data a
RIGHT JOIN dbo.Customer_support_data p
    ON a.Agent_name = p.Agent_name
ORDER BY p.Product_category;
```
![Right Join](https://github.com/jananiii18/-Data-Analysis-with-SQL-/blob/f84a218f161f65b6ff4c808c9a05d0e03a46316e/Screenshot7.png)
### 8. Subquery - Products with price above average
```sql
SELECT Product_category, Item_price
FROM dbo.Customer_support_data
WHERE Item_price > (
    SELECT AVG(Item_price)
    FROM dbo.Customer_support_data
);
```
![Subquery](https://github.com/jananiii18/-Data-Analysis-with-SQL-/blob/f84a218f161f65b6ff4c808c9a05d0e03a46316e/Screenshot8.png)
### 9. Create or replace a view for average CSAT score per agent
```sql
CREATE OR ALTER VIEW Average_CSAT_Per_Agent AS
SELECT Agent_name,
       ROUND(AVG([CSAT_Score]), 2) AS AvgCSAT
FROM dbo.Customer_support_data
GROUP BY Agent_name;
```
### Query the view
```sql
SELECT * FROM Average_CSAT_Per_Agent;
```
![View](https://github.com/jananiii18/-Data-Analysis-with-SQL-/blob/f84a218f161f65b6ff4c808c9a05d0e03a46316e/Screenshot9.png)

### 10. Index for faster queries by agent and date
```sql
CREATE INDEX idx_custsupport_agent_orderdate
ON dbo.Customer_support_data (Agent_name);
```
### Query 
```sql
SELECT Agent_name,
       order_date_time
FROM dbo.Customer_support_data
WHERE Agent_name = 'Dillon Miller';
```
![Index](https://github.com/jananiii18/-Data-Analysis-with-SQL-/blob/f84a218f161f65b6ff4c808c9a05d0e03a46316e/Screenshot10.png)
