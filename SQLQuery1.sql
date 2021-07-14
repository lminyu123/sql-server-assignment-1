--Q1
SELECT p.ProductID,p.Color, p.Name, p.ListPrice
FROM Production.Product p
--Q2
SELECT p.ProductID,p.Color, p.Name, p.ListPrice
FROM Production.Product p
WHERE P.ListPrice =0
--Q3
SELECT p.ProductID,p.Color, p.Name, p.ListPrice
FROM Production.Product p
WHERE P.Color IS NULL
--Q4
SELECT p.ProductID,p.Color, p.Name, p.ListPrice
FROM Production.Product p
WHERE P.Color IS NOT NULL 
--Q5
SELECT p.ProductID,p.Color, p.Name, p.ListPrice
FROM Production.Product p
WHERE P.Color IS NOT NULL AND P.ListPrice>0
--Q6
SELECT Color +' '+ Name AS New_name
FROM Production.Product p
WHERE P.Color IS NOT NULL
--Q7
SELECT 'NAME: '+ Name+ '--' + 'COLOR: ' + Color AS 'Name And Color'
FROM Production.Product 
WHERE Color IS NOT NULL
--Q8
SELECT ProductID, Name
FROM Production.Product 
WHERE ProductId between 400 and 500
--Q9
SELECT ProductID, Name
FROM Production.Product 
WHERE Color IN ('blue','black')
--Q10
SELECT *
FROM Production.Product p
WHERE Name LIKE 'S%'
--Q11
SELECT TOP 6
Name, ListPrice
FROM Production.Product 
WHERE Name LIKE 'S%'
ORDER BY Name
--Q12
SELECT Name, ListPrice
FROM Production.Product 
WHERE Name LIKE 'S%' OR Name LIKE 'A%'
ORDER BY Name
--Q13
SELECT ProductID, Color, Name, ListPrice
FROM Production.Product 
WHERE Name like 'SPO%' AND Name NOT LIKE 'K%'
ORDER BY Name
--Q14
SELECT DISTINCT Color
FROM Production.Product 
WHERE Color IS NOT NULL
ORDER BY Color DESC
--Q15
SELECT P.ProductSubcategoryID, P.Color 
FROM Production.Product p
WHERE P.ProductSubcategoryID IS NOT NULL AND p.Color IS NOT NULL
--Q16
SELECT ProductSubCategoryID
      , LEFT([Name],35) AS [Name]
      , Color, ListPrice 
FROM Production.Product
WHERE Color NOT IN ('Red','Black') 
      OR ListPrice BETWEEN 1000 AND 2000 
      AND ProductSubCategoryID = 1
ORDER BY ProductID
--Q17
SELECT ProductSubCategoryID
      , LEFT([Name],35) AS [Name]
      ,  Color, ListPrice 
FROM Production.Product
WHERE ProductSubCategoryID <=14 
      AND (Name LIKE 'HL Road Frame%' OR Name LIKE 'Road-350-W%'
	  OR Name LIKE'Mountain-500 Black%' OR  Name LIKE 'HL Mountain Frame%')
	   and	Name  NOT like 'HL Road Frame - Black%'

ORDER BY ProductSubCategoryID DESC







