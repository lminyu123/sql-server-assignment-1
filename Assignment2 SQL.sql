--answer following	question
--Q1 What is a result set?
---  result set is set of data,could be empty or not, 
---  returned by select statement or store procedure. And save in RAW or displayed on screen.
--Q2 What is the difference between Union and Union All?
--  UNION: only keeps unique records
--  UNION ALL: keeps all records, including duplicates
--Q3 What are the other Set Operators SQL Server has?
--  MINUS
--  INTERSECT
--  EXCEPT
-- Q4 What is the difference between Union and Join?
--  JOIN in SQL is used to combine data from many tables based on a matched condition between them
--  UNION in SQL is used to combine the result-set of two or more SELECT statements
-- Q5 What is the difference between INNER JOIN and FULL JOIN?
--   inner join will only return rows in which there is a match based on the join predicate
--   full join, the result set will retain all of the rows from both of the tables.
-- Q6 What is difference between left join and outer join
--   LEFT JOIN: Return all rows from the left table, and the matched rows from the right table
--   OUTER JOIN: Return all rows from both the tables
-- Q7 What is cross join?
--   cross join returns the Cartesian product of the sets of records from the two joined tables. 
-- Q8 What is the difference between WHERE clause and HAVING clause?
--   The WHERE clause is used to filter rows before the grouping is performed.
--    The HAVING clause is used to filter rows after the grouping is performed. It often includes the result of aggregate functions and is used with GROUP BY.
-- Q9 Can there be multiple group by columns?
--    Yes, you can group by multiple columns

--Write queries for following scenarios
--Q1 
SELECT COUNT(*)
FROM Production.Product p
--Q2
SELECT COUNT(*) CountedProducts
FROM Production.Product p
WHERE p.ProductSubcategoryID IS NOT NULL
--Q3
SELECT p.ProductSubcategoryID, COUNT(*) CountedProducts
FROM Production.Product p
WHERE p.ProductSubcategoryID IS NOT NULL
GROUP BY P.ProductSubcategoryID
--Q4
SELECT  P.ProductSubcategoryID, COUNT(*) CountedProducts
FROM Production.Product p
WHERE p.ProductSubcategoryID IS NULL
GROUP BY P.ProductSubcategoryID
--Q5
SELECT SUM (Quantity)
FROM Production.ProductInventory
--Q6
SELECT ProductID, Quantity TheSum
FROM Production.ProductInventory
WHERE LocationID = 40 AND Quantity <100
--Q7
SELECT Shelf,ProductID, Quantity TheSum
FROM Production.ProductInventory
WHERE LocationID = 40 AND Quantity <100
--Q8
SELECT AVG(Quantity) TheAvg
FROM Production.ProductInventory
WHERE LocationID = 10 
--Q9
SELECT ProductID, Shelf, AVG(Quantity) TheAvg
FROM Production.ProductInventory
GROUP BY ProductID,Shelff
--Q10
SELECT ProductID, Shelf, AVG(Quantity) TheAvg
FROM Production.ProductInventory
WHERE Shelf IS NOT NULL
GROUP BY ProductID,Shelf
--Q11
SELECT Color, Class, COUNT(ListPrice) TheCount ,AVG(ListPrice) AvgPrice
FROM Production.Product
WHERE Color IS NOT NULL AND CLASS IS NOT NULL
GROUP BY Color,Class
--Q12
SELECT tb2.Name Country, tb1.Name Province
FROM Person.CountryRegion tb1
JOIN Person.StateProvince tb2 ON tb2.CountryRegionCode=tb1.CountryRegionCode
--Q13
SELECT tb2.Name Country, tb1.Name Province
FROM Person.CountryRegion tb1
JOIN Person.StateProvince tb2 ON tb2.CountryRegionCode=tb1.CountryRegionCode
WHERE tb1.Name IN ('Germany', 'Canada')
--Q14
SELECT p.ProductID, p.ProductName,o.OrderDate
FROM [Order Details] od
JOIN Orders o ON od.OrderID=o.OrderID
JOIN Products p ON p.ProductID=od.ProductID
WHERE o.OrderDate>DATEADD(YEAR, -25, GETDATE())
--Q15
SELECT TOP 5
o.ShipPostalCode, sum(od.Quantity) TOP5
FROM [Order Details] od
JOIN Orders o ON od.OrderID=o.OrderID
WHERE O.ShipPostalCode IS NOT NULL
group by o.ShipPostalCode
order by sum(od.Quantity) DESC
--Q16
SELECT TOP 5
o.ShipPostalCode,sum(od.Quantity) TOP5
FROM [Order Details] od
JOIN Orders o ON od.OrderID=o.OrderID
JOIN Products p on p.ProductID=od.ProductID
WHERE o.OrderDate>DATEADD(YEAR, -20, GETDATE())
group by o.ShipPostalCode
order by sum(od.Quantity) DESC
--Q17
SELECT c.City, count(c.CustomerID) CountNum
FROM Customers c
group by City
--Q18
SELECT c.City, count(c.CustomerID) CountNum
FROM Customers c
group by City
HAVING COUNT(CustomerID)>10
--Q19
SELECT c.ContactName,o.OrderDate
FROM Customers c
JOIN Orders o ON o.CustomerID=c.CustomerID
WHERE O.OrderDate >'1998-01-01'
--Q20
SELECT c.ContactName,MAX(o.OrderDate) Recentorder
FROM Customers c
JOIN Orders o ON o.CustomerID=c.CustomerID
GROUP BY c.ContactName
--Q21
SELECT c.ContactName, COUNT(od.Quantity) TotalCount 
FROM Customers c
JOIN Orders o ON c.CustomerID=o.CustomerID
JOIN [Order Details] od ON o.OrderID=od.OrderID
GROUP BY c.ContactName
--Q22
SELECT c.ContactName, COUNT(od.Quantity) TotalCount 
FROM Customers c
JOIN Orders o ON c.CustomerID=o.CustomerID
JOIN [Order Details] od ON o.OrderID=od.OrderID
GROUP BY c.ContactName
HAVING COUNT(od.Quantity)>100
--Q23
SELECT tb1.CompanyName as [Supplier Company Name] ,tb2.CompanyName as [Shipping Company Name]
FROM Suppliers tb1
JOIN Shippers tb2 on tb1.SupplierID=tb2.ShipperID
--Q24
SELECT c.ContactName, o.OrderDate
FROM Customers c
JOIN Orders o ON c.CustomerID=o.CustomerID
JOIN [Order Details] od ON o.OrderID=od.OrderID
--Q25
SELECT e1.FirstName +'' +e1.LastName EmployeeName1, e2.FirstName +''+e2.LastName EmployeeName2
FROM Employees e1
JOIN Employees e2 on e1.Title=e2.Title and e2.EmployeeID >e1.EmployeeID
--Q26
SELECT e1.FirstName +'' +e1.LastName ManagerName
FROM Employees e1
JOIN Employees e2 on e1.ReportsTo=e2.EmployeeID
GROUP BY e1.FirstName, e1.LastName
HAVING COUNT(e2.EmployeeID)>2
--Q27
SELECT s.City, s.ContactName, 'Supplier' as "Type",
       c.City, c.ContactName, 'Customer' as "Type"
FROM Customers c
JOIN Suppliers s ON c.CompanyName=s.CompanyName
--Q28
SELECT T1,T2
FROM F1 
INNER JOIN F2 ON F1.T1=F2.T2
---  F1.T1 F2.T2
----   2    2
----   3    3

--Q29
SELECT T1,T2
FROM F1 
LEFT JOIN F2 ON F1.T1=F2.T2
---  F1.T1 F2.T2
----   1    NULL
----   2     2
----   3     3







