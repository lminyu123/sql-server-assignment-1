----1.What is an object in SQL?
   database
--2.What is Index? What are the advantages and disadvantages of using Indexes?
	An index can be used to efficiently find all rows matching some column in 
	your query and then walk through only that subset of the table to find exact matches.
	Their use in queries usually results in much better performance.
	advantages:
	They make it possible to quickly retrieve (fetch) data.
	They can be used for sorting. A post-fetch-sort operation can be eliminated.
	disadvantage:
	They decrease performance on inserts, updates, and deletes.
	They take up space (this increases with the number of fields used and the length of the fields).
	Some databases will monocase values in fields that are indexed.
	Unique indexes guarantee uniquely identifiable records in the database
--3.What are the types of Indexes?
    Clustered index and non-Clustered index
--4.Does SQL Server automatically create indexes when a table is created? If yes, under which constraints?

--5.Can a table have multiple clustered index? Why?
	NO,Clustered indexes sort and store the data rows in the table or view based on their key values. 
	These are the columns included in the index definition. There can be only one clustered index per table, 
	because the data rows themselves can be stored in only one order.
--6.Can an index be created on multiple columns? Is yes, is the order of columns matter?
	Yes.
--7.Can indexes be created on views?
	Yes
--8.What is normalization? What are the steps (normal forms) to achieve normalization?
	Database Normalization is a process of organizing data to minimize redundancy (data duplication), 
	which in turn ensures data consistency. 
	1NF,2NF,3NF
--9.What is denormalization and under which scenarios can it be preferable?
	Denormalization is a strategy used on a previously-normalized database to increase performance. 
	The idea behind it is to add redundant data where we think it will help us the most
--10.How do you achieve Data Integrity in SQL Server?

--11.What are the different kinds of constraint do SQL Server have?
	NOT NULL
	CHECK
	UNIQUE
	PRIMARY KEY
	FOREIGN KEY
	DEFAULT
--12.What is the difference between Primary Key and Unique Key?
	Primary Key is a column that is used to uniquely identify each tuple of the table.
	Unique key is a constraint that is used to uniquely identify a tuple in a table.
--13.What is foreign key?
	Foreign key is a column that creates a relationship between two tables. 
	The purpose of the Foreign key is to maintain data integrity and allow navigation between two different 
	instances of an entity
--14.Can a table have multiple foreign keys?
	yes
--15.Does a foreign key have to be unique? Can it be null?
	Foregin key don not have to be unique, and it can be null.
--16.Can we create indexes on Table Variables or Temporary Tables?
	You can create indexes on temporary tables (#).
	You can only create a clustered index a table variable (@) by setting a primary key constraint on creation.
--17.What is Transaction? What types of transaction levels are there in SQL Server?
	Transactions by definition are a logical unit of work.
	Transaction is a single recoverable unit of work that executes either: Completely,Not at all.
	Atomicity
	Consistency
	Isolation
	Durability

--Q1
Create table customer(cust_id int,  iname varchar (50)) 
	INSERT INTO customer 
    (cust_id, iname) 
VALUES 
    (1,'will'),
    (2,'ada'),
    (3,'lily');
select *
from customer
drop table customer
create table [order](order_id int,cust_id int,amount money,order_date smalldatetime)
	INSERT INTO [order] (order_id ,cust_id ,amount,order_date )
	VALUES
	(121,1,20,'2019-01-02 10:43:10'),
	(332,2,45,'2002-02-12 12:43:10'),
	(312,3,10,'2002-09-01 14:43:10');
DROP TABLE [ORDER]
SELECT *
FROM [ORDER]
SELECT c.iname, count(o.order_id) ordertotal
FROM customer c
JOIN [ORDER] O ON c.cust_id=o.cust_id
WHERE YEAR(O.order_date)=2002
GROUP BY C.iname
--Q2
Create table person (id int, firstname varchar(100), lastname varchar(100)) 
SELECT *
FROM person 
WHERE lastname like 'A%'
--Q3
Create table person(
					person_id int primary key, 
					manager_id int null, 
					name varchar(100)not null)
Insert into person values (1, 2,'Tom')
Insert into person values (2, null, 'Josh')
Insert into person values (3, 2 ,'Mike')
Insert into person values (4, 3 ,'John')
Insert into person values (5, 1,'Pam')
Insert into person values (6, 3,'Mary')
Insert into person values (7,1 ,'James')
Insert into person values (8, 5,'Sam')
drop table person

select *
from person
The filed managed_id contains the person_id of the employee’s manager.

select *
from person

SELECT p1.name,p1.manager_id,tb1.countnum Countotal	
FROM PERSON p1
JOIN (SELECT p2.manager_id,count(p2.person_id) countnum
		from PERSON p2
		WHERE P2.manager_id is not null
		group by p2.manager_id) tb1
ON TB1.manager_id=P1.person_ID
where P1.manager_id is null

--Q4
INSERT, UPDATE, DELETE