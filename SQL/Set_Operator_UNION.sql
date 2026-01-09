

-- SET Operators
	-- Union
	-- Union All
	-- Except
	-- Intersect

--********#1.RULES -> CLAUSE**********
-- SET Oprators can be used almost in all clauses like WHERE | JOIN | GROUP BY | HAVING
-- ORDER BY is allowd only once at the end of query

--********#2.RULES -> NUMBER OF COLUMNS**********
-- The number of columns in each query must be the same

--********#3.RULES -> DATA TYPES**********
-- Data types of colums in each query must be compatible

--********#3.RULES -> ORDER OF COLUMNS**********
-- The order of colums in each query must be the same

--********#3.RULES -> COLUMS ALIAES**********
-- The colums names in the result set are determind by the column names 
-- specific in the first query.

--********#3.RULES -> CORRECT COLUMNS**********
-- Even if all rules are met and SQL shows no errors,the result may be incorrect.
-- Incorrect column selection leads to inaccurrate results


SELECT 
	FirstName,
	LastName
FROM Sales.Customers
UNION
SELECT 
	FirstName,
	LastName
FROM Sales.Employees

SELECT *
FROM Sales.Employees

SELECT * 
FROM Sales.Customers

--combine the data from employees and customers into one table

SELECT 
	e.EmployeeID,
	e.FirstName as customer_firstName,
	e.LastName as customer_lastName
FROM Sales.Employees as e 
UNION
SELECT 
	c.CustomerID,
	c.FirstName,
	c.LastName
FROM Sales.Customers as c


--********* UNION ALL ******************----------

-- Return all rows from both queries , including ducplicates
SELECT 
	e.EmployeeID,
	e.FirstName as customer_firstName,
	e.LastName as customer_lastName
FROM Sales.Employees as e 
UNION ALL
SELECT 
	c.CustomerID,
	c.FirstName,
	c.LastName
FROM Sales.Customers as c

--********* Except ******************----------

SELECT 
	e.EmployeeID,
	e.FirstName as customer_firstName,
	e.LastName as customer_lastName
FROM Sales.Employees as e 
Except
SELECT 
	c.CustomerID,
	c.FirstName,
	c.LastName
FROM Sales.Customers as c


--********* Intersect ******************----------

SELECT 
	e.EmployeeID,
	e.FirstName as customer_firstName,
	e.LastName as customer_lastName
FROM Sales.Employees as e 
Except
SELECT 
	c.CustomerID,
	c.FirstName,
	c.LastName
FROM Sales.Customers as c



--********* USECASE ******************----------
--use when all colums and datatype are same



--combin orders and ordrsArchive
--dont use * . coz in the future might be the coloum ordrs chnages 
--best practics to add sourc of information in table like from table1 and table2
SELECT
	'Orders' as Sourcetable,  -- for know this is souce table
	   [OrderID]
      ,[ProductID]
      ,[CustomerID]
      ,[SalesPersonID]
      ,[OrderDate]
      ,[ShipDate]
      ,[OrderStatus]
      ,[ShipAddress]
      ,[BillAddress]
      ,[Quantity]
      ,[Sales]
      ,[CreationTime]
FROM Sales.Orders
UNION
SELECT 
'OrdersArchive' as Sourcetable,  -- for know this is souce table
	   [OrderID]
      ,[ProductID]
      ,[CustomerID]
      ,[SalesPersonID]
      ,[OrderDate]
      ,[ShipDate]
      ,[OrderStatus]
      ,[ShipAddress]
      ,[BillAddress]
      ,[Quantity]
      ,[Sales]
      ,[CreationTime]
FROM Sales.OrdersArchive
ORDER BY OrderID