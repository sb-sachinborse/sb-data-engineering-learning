
--******** Filtering Data **********

/*
## WHERE operators: 
	-- Comparison Operator (=, <>, =! , > ,<, >= ,<= )
	-- Logical operators ( AND, OR, NOT)
	-- Range Operator ( BETWEEN )
	-- Membreship Operator ( IN, NOT IN )
	-- Search operator ( LIKE) 
*/

--Retrieve the customers whose score falls in the range between 100 and 500
SELECT *
FROM customers
WHERE score >= 100  AND score <= 500;

SELECT *
FROM customers
WHERE score BETWEEN 100 AND 500;


--retrieve all customers from either Germany or USA
SELECT *
FROM customers
WHERE country = 'Germany' OR country = 'USA';

SELECT *
FROM customers
WHERE country IN ('Germany' ,'USA');

--
SELECT *
FROM customers
WHERE first_name LIKE '%in';

SELECT *
FROM customers
WHERE first_name LIKE 'M%';

SELECT *
FROM customers
WHERE country LIKE '%a%';

SELECT *
FROM customers
WHERE first_name LIKE '%r%';

SELECT *
FROM customers
WHERE first_name LIKE '__r%';



