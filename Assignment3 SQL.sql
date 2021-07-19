--1. In SQL Server, assuming you can find the result by using both joins and subqueries, which one would you prefer to use and why?
	I prefer to use subqueries, because subqueries can divide the complex query into isolated
	parts so that a complex query can be broken down into a series of logical steps.
--2.What is CTE and when to use it?
    CTE IS COMMON TABLE EXPRESSION. It can create recursive query and 
    offer the advantages of improved readability and ease maintenance of complex queries.
--3.What are Table Variables? What is their scope and where are they created in SQL Server?
    Table variable is a data type that can be used within a transact SQL batch, stored procedure or function
	and is created and defined similarly to a table, only with a strictly defined lifetime scope
	The scope of a table variable is limited to the specific batch, while a local temporary table is limited to the specific spid.
-- 4.What is the difference between DELETE and TRUNCATE? Which one will have better performance and why?
	DELETE can remove specific or all records from table.
	Truncate only remove all the records from table.
	Can use DELETE with indexed view. TRUNCATE can not use indexed view.
	DELETE can activate trigger, but TRUNCATE can not activate.
	DELETE Can change rollback,  but TRUNCATE can not.
	Truncate is better performance, beacuse it faster than DELETE
--5.What is Identity column? How does DELETE and TRUNCATE affect it?
	SQL identity column is a column whose values are automatically generated when you add a new row to the table. 
	DELETE not reset
	TRUNCATE reset the identity value
--6.What is difference between “delete from table_name” and “truncate table table_name”?
	delete from table_name is delete all row
	truncate table table_name is delete all row with no change rollback

--1.
    SELECT distinct c.city
	FROM customers c
	JOIN employees e on c.city=e.city
--2.
--a)Use sub-query
    SELECT distinct c.city
	FROM customers c
	WHERE C.CITY NOT IN (SELECT E.CITY FROM EMPLOYEES E)
--b)Do not use sub-query
	SELECT distinct c.city
	FROM customers c
	left JOIN employees e
	on e.city=c.city
	WHERE E.CITY IS NULL
--3.
	SELECT P.PRODUCTID, SUM(OD.Quantity) totalquantity
	FROM [ORDER DETAILS] OD
	JOIN Orders O ON OD.OrderID=O.OrderID
	JOIN Products P ON P.ProductID=OD.ProductID
	GROUP BY P.ProductID
--4.
	SELECT C.City, COUNT(OD.ProductID) TOTALPRODUCT
	FROM Customers C
	LEFT JOIN Orders O ON C.CustomerID=O.CustomerID
	LEFT JOIN [Order Details] OD ON OD.OrderID=O.OrderID
	GROUP BY C.City
--5.
--a)Use Uion
SELECT C.City
FROM Customers C
GROUP BY C.City
HAVING COUNT(C.City) =2
UNION 
SELECT C.City
FROM Customers C
GROUP BY C.City
HAVING COUNT(C.City) >2
--b)Use sub-query and no union
SELECT distinct city 
FROM Customers
WHERE City in 
(SELECT  c.city 
FROM customers c 
GROUP BY c.city 
HAVING count(*)>=2)
--6.
SELECT DISTINCT C.City
FROM Customers C
JOIN Orders O ON O.CustomerID=C.CustomerID
JOIN [Order Details] OD ON OD.OrderID=O.OrderID
GROUP BY C.City
HAVING COUNT(DISTINCT OD.ProductID)>=2
--7.
SELECT DISTINCT  C.CustomerID
FROM Customers C 
WHERE C.City NOT IN (SELECT ShipCity FROM Orders)
--8
SELECT top 5 OD.ProductID, 
ROUND(SUM(OD.UnitPrice*Quantity*(1-Discount))/SUM(OD.Quantity),2) AvgPrice,
c.City
FROM Customers C
JOIN Orders O ON O.CustomerID=C.CustomerID
JOIN [Order Details] OD ON OD.OrderID=O.OrderID
GROUP BY OD.ProductID, c.City
ORDER BY AvgPrice DESC
--9.
--a)
SELECT E.City
FROM Employees E
WHERE E.City NOT IN (SELECT City FROM Customers )

--b)
SELECT E.City
FROM Employees E
LEFT JOIN Customers C ON C.City=E.City
WHERE C.CITY IS NULL
--10
SELECT *
FROM
(SELECT TOP 1 C.City, COUNT(O.OrderID) TOTALORDER
FROM Customers c
JOIN Orders O ON C.CustomerID=O.CustomerID
JOIN [Order Details] OD ON OD.OrderID=O.OrderID
GROUP BY C.City
ORDER BY COUNT(O.OrderID) DESC) TB1
JOIN 
(select top 1 c.city, sum(od.quantity) Totalquantity
from [Order Details] od
JOIN orders o on o.OrderID = od.OrderID
JOIN Customers c on c.customerid = o.CustomerID
group by c.city
order by SUM(od.quantity) desc) TB2
ON TB1.City=TB2.City
--11

USE DELETE STATEMENT or 
use group by find duplicate row 
--12
SELECT e.empid FROM employee e
WHERE  e.empid NOT IN 
(SELECT a.mgrid FROM employee a WHERE a.mgrid = e.empid)

--13
SELECT * 
FROM
(SELECT d.deptid, dt.Cnt, 
dense_rank() over (order by dt.Cnt desc) rank 
FROM Dept d) tb1
JOIN 
	(SELECT e.deptid, COUNT(e.empid) Cnt 
	FROM employee e 
	GROUP BY e.deptid)
on d.deptid = dt.deptid) TB2
where TB1.rank = 1
--14
WITH empCTE (deptid,empid, salary,rnk)
AS (
	SELECT
		d.deptid,e.empid,e.salary,
		DENSE_RANK() over (partition by d.deptid order by e.salary desc) rnk
	FROM
		dept d
		JOIN Employee e on d.deptid = e.deptid
	)
select * 
from empCTE 
where rnk <=3



-- assignment course question
--1.TOP PRODUCT FROM EVERYCITY WITH MAX SALE

WITH SalesCTE (City, ProductID, SALES, RK)
AS
	(
		SELECT C.City,OD.ProductID,
		SUM(OD.Quantity) SALES,
		RANK() OVER (PARTITION BY C.City ORDER BY SUM(OD.Quantity) DESC) RK
		FROM [Order Details] OD
		JOIN Orders O ON O.OrderID = OD.OrderID
		JOIN Customers C ON C.CustomerID = O.CustomerID
		GROUP BY C.City, OD.ProductID
	)
SELECT * FROM SalesCTE
WHERE RK <= 3
--2.FIND DISTANCE BETWEEN TWO DESTINATION

CREATE TABLE #DIS(Destination varchar(8) , Distance int)

INSERT INTO #DIS VALUES ('A', 0)
INSERT INTO #DIS VALUES ('B', 20)
INSERT INTO #DIS VALUES ('C', 50)
INSERT INTO #DIS VALUES ('D', 70)
INSERT INTO #DIS VALUES ('E', 85)

SELECT
	D1.Destination + '-' + D2.Destination AS Destination,
	D2.Distance - D1.Distance AS Distance
FROM #DIS D1
LEFT JOIN #DIS D2
ON ASCII(D2.Destination) = ASCII(D1.Destination) + 1
WHERE D2.Destination IS NOT NULL

