--1.What is View? What are the benefits of using views?
  A view is a virtual table whose contents are defined by a query. Like a real table,
  a view consists of a set of named columns and rows of data.
  A view representing a subset of the data present in a table, and performing functions such as
  joining and simplification of multiple tables into a single table, data aggregation, handling data complexity,
  providing security etc.
--2.Can data be modified through views?
  NO 
--3.What is stored procedure and what are the benefits of using it?
	A stored procedure groups one or more Transact-SQL statements into a logical unit, 
	stored as an object in a SQL Server database
--4.What is the difference between view and stored procedure?
	View cannot accept parameters but store procedure accept.
	view only contain select query, but store procedure have serval statement
--5.What is the difference between stored procedure and functions?
	A function has a return type and returns a value.
	A procedure does not have a return type. But it returns values using the OUT parameters.
	You cannot call stored procedures from a function.
	You can call a function from a stored procedure.
--5.Can stored procedure return multiple result sets?
	YES
--6.Can stored procedure be executed as part of SELECT Statement? Why?
	YES
--7.What is Trigger? What types of Triggers are there?
	A trigger is a special type of stored procedure in database that automatically invokes/runs/fires
	when an event occurs in the database server. A trigger uses the special table to keep a copy of the 
	row which we have just inserted, deleted or modified.
	There are three types of triggers in SQL Server.  
	DDL Trigger
	DML Trigger
	Logon Trigger
--8.What are the scenarios to use Triggers?
	 trigger can be invoked when a row is inserted into a specified table or when 
	 certain table columns are being updated
--9.What is the difference between Trigger and Stored Procedure?
	Trigger can not be called manually where stored procedure can be called manually. 
	Trigger executes automatically when event happens and can be use for reporting and 
	data protection from deleting or dropping the table and data from database. We can 
	prevent from trigger. On the other hand, a stored procedure has to be called by somebody.



--Q1
--A new region called “Middle Earth”;
SELECT*
FROM Region
INSERT INTO Region VALUES(5,'Middle Earth')
--A new territory called “Gondor”, belongs to region “Middle Earth”;
SELECT *
FROM Territories
SELECT*
FROM Region
INSERT INTO Territories VALUES(99101,'Gondor',5)
--A new employee “Aragorn King” who's territory is “Gondor”.
SELECT *
FROM Employees
SELECT *
FROM Territories
INSERT INTO Employees(EmployeeID, FullName, Territory)
VALUES(9,'Aragorn King' ,'Gondor')
--Q2
UPDATE Territories
SET TerritoryDescription ='Arnor'
WHERE TerritoryID=99101
--Q3
DELETE 
FROM Territories
WHERE RegionID =5
DELETE 
FROM Region
WHERE RegionID =5
SELECT *
FROM Region
--Q4
CREATE VIEW view_product_order_LIANG
AS 
	SELECT OD.ProductID, SUM(OD.Quantity) AS Totalquantity
	FROM [Order Details] OD
	GROUP BY OD.ProductID
	
SELECT *
FROM view_product_order_LIANG
--Q5

CREATE PROC sp_product_order_quantity_LIANG
@pid int,
@sumquantity int out
as
begin 
SELECT @pid=ProductID, @sumquantity=Quantity
FROM [Order Details] 
WHERE @pid=ProductID
end

BEGIN
DECLARE @sumquantity int
EXECUTE sp_product_order_quantity_LIANG 3,@sumquantity OUT
PRINT @sumquantity
END
--Q6

CREATE PROC sp_product_order_city_LIANGMY
@pname varchar(20),
@topcity varchar(20) out
AS
	BEGIN	
		SELECT TOP 5 p.ProductName, c.City
		FROM Products p 
		JOIN [Order Details] od ON od.ProductID = p.ProductID
		JOIN Orders O ON O.OrderID=od.OrderID
		JOIN Customers C ON C.CustomerID=O.CustomerID
		group by p.ProductName, C.City
		ORDER BY SUM(OD.Quantity)
    RETURN
	END

DROP PROC sp_product_order_city_LIANG
			
--Q7
CREATE PROC sp_move_employees_LIANG
@A INT
AS
BEGIN
	SELECT t.TerritoryID, e.EmployeeID
	FROM EmployeeTerritories e 
	JOIN Territories t ON e.TerritoryID=t.TerritoryID
	JOIN Region r ON r.RegionID=t.RegionID
END
--Q8
--Q9
CREATE TABLE PEOPLE_LIANG (id int, Name varchar(20), City int)
INSERT INTO PEOPLE_LIANG VALUES (1, 'Aaron Rodgers', 2)
INSERT INTO PEOPLE_LIANG VALUES (2, 'Russell Wilson', 1)
INSERT INTO PEOPLE_LIANG VALUES (3, 'Jody Nelson', 2)

CREATE TABLE CITY_LIANG(id int, city varchar(20))
INSERT INTO CITY_LIANG VALUES (1, 'Seattle')
INSERT INTO CITY_LIANG VALUES  (2,'Green Bay')

select *
from CITY_LIANG
select *
from PEOPLE_LIANG

--Remove seattle, replace to madison
update CITY_LIANG
SET city=replace(city,'Seattle','Madison')
--create view table
CREATE VIEW PACKERS_LIANG
AS
	SELECT p.Name FROM PEOPLE_LIANG p
	JOIN CITY_LIANG C ON P.id=C.id
	where C.City='Green Bay'
select *
from PACKERS_LIANG
--drop table and view 
DROP TABLE CITY_LIANG
DROP TABLE PEOPLE_LIANG
DROP VIEW PACKERS_LIANG
--Q10
CREATE TABLE birthday_employees_liang(empid int, name varchar(40), birthday date)
INSERT INTO birthday_employees_liang VALUES(1,'Lily','1996-02-02')
INSERT INTO birthday_employees_liang VALUES(2,'Will', '2000-02-09')
INSERT INTO birthday_employees_liang VALUES(3, 'Tracy', '1995-02-17')
INSERT INTO birthday_employees_liang VALUES(4, 'Ada', '1990-02-16')
INSERT INTO birthday_employees_liang VALUES(5,'Ki', '1992-02-20')
INSERT INTO birthday_employees_liang VALUES(6,'Kinny', '1992-08-20')
INSERT INTO birthday_employees_liang VALUES(7,'Ken', '1999-07-20')
INSERT INTO birthday_employees_liang VALUES(8,'Yili', '1998-03-20')

create proc sp_birthday_employees_liang
@name varchar(20),
@bdate date
as
begin
SELECT @name =bl.name,
@bdate=bl.birthday
from birthday_employees_liang bl
where month(bl.birthday)=02
return
end
drop table birthday_employees_liang
drop proc sp_birthday_employees_liang
--Q11
--I will store the date with those two table
--Q14

Create table tb1 (FirstName NVARCHAR(20), LastName NVARCHAR(20), 
MiddleName NVARCHAR(20))
insert into tb1 values('John','Green',NULL)
insert into tb1 values('Mike','White','M.')

SELECT tb1.FirstName+'_'+tb1.LastName+'_'+tb1.MiddleName as fullname
FROM tb1
--Q15
create table TB2 (Student varchar(20) primary key , Marks int, Sex char NULL)
insert TB2 values('Ci', 70, 'F')
insert TB2 values('Bob', 80, 'M')
insert TB2 values('Li', 90, 'F')
insert TB2 values('Mi', 95, 'M')

select top 1 student, max(marks) 
from TB2 where sex = 'F'
group by Student
order by student desc

--Q16
SELECT *
FROM TB2
order BY Sex, Marks desc
