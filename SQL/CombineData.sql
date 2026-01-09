

-----------************COMBINE DATA****************-----------------

-- JOIN 
	-- Inner Join
	-- Full Join
	-- Left Join
	-- Right Join
	--*****************--
	--Advanced
		--Left anti join
		--Right anti join



SELECT *
FROM customers

SELECT *
FROM orders
--*****************************************************************


--No Join-- Return Data flow tables without combining them

SELECT *
FROM customers

SELECT *
FROM orders

--Inner Join -- Return only matching rows from both tables

/* Get all customers along with their orders,but only for custoers who
have placed an order*/
SELECT *
FROM customers
INNER JOIN orders
ON id = customer_id ;

--********************************
SELECT 
	customers.id,
	customers.first_name,
	orders.order_id,
	orders.sales
FROM customers
INNER JOIN orders
ON customers.id = orders.customer_id ;


--use alices
SELECT 
	c.id,
	c.first_name,
	o.order_id,
	o.sales
FROM customers AS c
INNER JOIN orders AS o
ON c.id = o.customer_id;




--Left Join -- Return ALl rows from left table and only matching from right table
-- in the LEFT JOIN the order of table important

/* Get all customers along with their orders including those without orders*/
SELECT 
	c.id,
	c.first_name,
	o.order_id,
	o.sales
FROM customers AS c
LEFT JOIN orders AS o
ON c.id = o.customer_id;


--Right Join -- Return ALl rows from Right table and only matching from left table
-- in the Right JOIN the order of table important

/* Get all customers along with their orders including orders without matching customers*/

SELECT 
	c.id,
	c.first_name,
	o.order_id,
	o.sales
FROM customers AS c
RIGHT JOIN orders AS o
ON c.id = o.customer_id;



--FULL Join -- Return all rows from both table

SELECT 
	c.id,
	c.first_name,
	o.order_id,
	o.sales
FROM customers AS c
FULL JOIN orders AS o
ON c.id = o.customer_id;


--Left anti join -- Return all rows from left table that has NO match in Right table

/* Get all customers who have't place any orrders */
SELECT *
FROM customers AS c
LEFT JOIN orders AS o
ON c.id = o.customer_id
WHERE o.order_id IS NUll;


--Right anti join -- Return all rows from Right table that has NO match in Left table

/*Get all orders without matching customers*/
SELECT *
FROM customers AS c
Right JOIN orders AS o
ON c.id = o.customer_id
WHERE c.id IS NUll;

--using left join
SELECT *
FROM orders AS o
LEFT JOIN customers AS c
ON c.id = o.customer_id
WHERE c.id IS NULL



--Full anti join -- Return only rows that Don't match in either tables

/*Find customers without orders and orders wihtout customers */

SELECT *
FROM customers AS c
FULL JOIN orders AS o
ON c.id = o.customer_id
WHERE o.customer_id IS NULL OR c.id IS NULL

/*Get all customers along with their orders but only for customers who have
placed and order witout using INNER JOIN*/

SELECT *
FROM customers AS c
LEFT JOIN orders AS o
ON c.id = o.customer_id
where o.customer_id IS NOT NULL


--Cross join 
/*Combines every row from left and every row from right table all possible combination - Cartersian join
*/

SELECT *
FROM customers 
CROSS JOIN orders;



-- ************MULTI JOIN*********************

USE SalesDB

SELECT *
FROM Sales.Customers;
SELECT *
FROM Sales.Orders;
SELECT *
FROM Sales.Products;
SELECT *
FROM Sales.Employees;
SELECT *
FROM Sales.OrdersArchive;



/*
	using SalesDB , Retrive a list of all orders ,along with the
	relatd customer, product, and employee details.
*/

SELECT 
	O.OrderID,
	O.Sales,
	C.FirstName AS customer_firstName,
	C.LastName AS customer_lastName ,
	P.Product,
	p.Price,
	E.FirstName AS employee_firstName,
	E.LastName As employee_lastName
FROM Sales.Orders AS O
LEFT JOIN Sales.Products AS P
ON O.ProductID = P.ProductID
LEFT JOIN Sales.Customers AS C
ON C.CustomerID = O.CustomerID
LEFT JOIN Sales.Employees AS E
ON E.EmployeeID = O.SalesPersonID