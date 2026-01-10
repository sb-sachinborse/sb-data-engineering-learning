USE MyDatabase;

-----------------------Select-----------------------------
-- to see all data --
SELECT * 
FROM customers;

-- columns select --
SELECT
	first_name,
	country
FROM customers;

------------------------- where ------------------------------
-- retrieve customers with a score is greater than 500
SELECT * 
FROM customers
WHERE
	score > 500;

-- retrieve customers with a score not equal to 0
SELECT * 
FROM customers
WHERE
	score != 0;

-- retrieve customers from Germany
SELECT *
FROM customers
WHERE 
	country = 'Germany';

-----------------------OrderBy-----------------------------
	
---- retrieve customers and sort the result by th highest score first -------

SELECT *
FROM customers
ORDER BY score DESC;   

---- retrieve customers and sort the result by th lowest score first -------

SELECT *
FROM customers
ORDER BY score ASC;

-----------------------Neested(OrderBy)-----------------------------

---Retrieve all customers and sort the result by the country and then by the highest score

SELECT * 
FROM customers
ORDER BY country ASC , score DESC;

----------------------- Group By (aggregate data) ---------------------------------------

-- Find the total score for each country
SELECT 
	country,
	SUM(score) AS total_score	--aslias
FROM customers
GROUP BY country;


--Find the total score and total number of customers for each country--
SELECT 
	country,
	SUM(score) AS total_score,
	COUNT(id) AS total_customers
FROM customers
GROUP BY country


----------------------- Having (Fiter aggregate data) ---------------------------------------


SELECT 
	country,
	SUM(score) AS total_score,
	COUNT(id) AS total_customers
FROM customers
GROUP BY country
HAVING SUM(score)> 800;  -- HAVING CONDITION WORK AFTER AGGREATION BEFORE AGGREATION WE CAN USE WHERE CLAUS



--Find the avreage score for each country considering only customers with a score not equal to 0
-- and return only those countries with an average score greater than 430

SELECT 
	country,
	AVG(score) AS avg_score
FROM customers
WHERE 
	score != 0
GROUP BY country
HAVING AVG(score) > 430;



----------------------- DISTINCT ---------------------------------------
--(it's used for remove duplicates(Repeated values) and each value appears only once)
-- (BAD HABIT with DISTINCT)
-- Don't use unless it's necessary; it can slow down query

-- Return Unique list of all countries --


SELECT DISTINCT
	country
FROM customers;



----------------------- TOP (limit data) ---------------------------------------
-- Restrict the number of rows retured

SELECT TOP 3 *
FROM customers;

-- Retrieve the TOP3 Customers with the Highest scores

SELECT TOP 3 *
FROM customers
ORDER BY score DESC;

-- Retrieve the Lowest 2 Customers with the score
SELECT TOP 2 *
FROM customers
ORDER BY score ASC;

-- Get the two most Recent Orders
SELECT TOP 2 *
FROM orders
ORDER BY order_date DESC;


-------------------*****************************-------------------------------------

SELECT * 
FROM customers;

SELECT *
FROM orders;

--static data 
SELECT 123 AS static_number; 
SELECT 'Hello World' As string;

--
SELECT 
	id,
	first_name,
	'New customer' As customer_type
FROM customers
WHERE country = 'USA';
