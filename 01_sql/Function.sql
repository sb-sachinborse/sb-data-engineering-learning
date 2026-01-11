
---*************** SQL FUNCTIONS *************************------

--Function is a built-in SQL code:
	-- access an input valu
	-- process it
	-- returns an ouput value

--******Types of functions*************
--1.Signle-Row Function (ROW-LEVEL FUNCTION)
	--String function
	--Number function
	--Date and time function
	--Null Function

--2.Multi-Row Function(AGGRGATION)
	--Aggregate functions(Basic)
	--Window functions(advaned)

--Nested Function
	-- Function used inside another function

--##############################################################

-- **********String Function***********--
--1.Manipulation	
	--CONCAT
	--UPPER
	--LOWER
	--TRIM
	--REPLACE
--2.Calculation
	--LEN
--3.String Extraction
	--LEFT
	--RIGHT
	--SUBSTRING

--CONCAT
--Concat first name and country into one colums

SELECT 
	FirstName,
	Country,
	CONCAT(FirstName,'-',country) as name_country
FROM Sales.Customers

--UPPER and LOWER
SELECT 
	FirstName,
	LOWER(FirstName) AS low_names
from Sales.Customers;

SELECT 
	FirstName,
	UPPER(FirstName) AS up_names
from Sales.Customers;

--TRIM -> Removes lading and trailing spaces
--Find customers whose firstName contains leading or trailing spaces
SELECT 
	first_name,
	LEN(first_name) , -- check spaces
	LEN(TRIM(first_name)) AS len_trim_name
from dbo.customers
--WHERE first_name != TRIM(first_name)  -- check any space


--REPLACE -> replace specific character with a new character
SELECT 
	'13-323-34' as phone,
	REPLACE('13-323-34','-','') as clean_phone ,
	REPLACE('13-323-34','-','/') as add_slash_phone  

--change file extention
SELECT
	'report.txt' AS repots,
	'reports.json' As json,
	REPLACE('report.txt' ,'.txt','.csv') AS txt_csv,
	REPLACE('reports.json','.json','.txt') AS json_txt


--LEN -> counts how many characters 
SELECT
	first_name,
	LEN(first_name) AS len_char
FROM dbo.customers


--LEFT -> extract specfic number of characters from the start
--RIGHT -> extract specfic number of characters from the end
SELECT
	first_name,
	LEFT(first_name,2) as left_char
FROM dbo.customers


SELECT 
	OrderDate,
	LEFT(OrderDate,4) as extract_year,
	RIGHT(OrderDate,2) as extracte_date,
	CONCAT(LEFT(OrderDate,4) ,'/',RIGHT(OrderDate,2)) as formated_date
FROM Sales.Orders

	
--SUBSTRING -> extract a part of string at a specified position
--SUBSTRING(VALUE,START,LENGHT)

SELECT
	first_name,
	SUBSTRING( TRIM(first_name) ,2,3) AS len_char
FROM dbo.customers


-- **********NUMBER Function***********--

 --ROUND
 SELECT 
	3.516,
	ROUND(3.516,2) AS round_2,
	ROUND(3.516,1) AS round_1,
	ROUND(3.516,0) AS round_0

--ABS -> returns the absolute (positive) valu of the numbers, removing any netative sign
SELECT
	-10,
	ABS(10),
	ABS(20)


-- **********Date and time function***********--

SELECT 
	OrderID,
	OrderDate,
	ShipDate,
	CreationTime
FROM
Sales.Orders

--Values

SELECT 
	OrderID,
	CreationTime,
	'2026-01-10' as hardcoded
FROM
Sales.Orders

--GATEDATE() -> returns the current date and time at the moment when query is executed.
SELECT 
	OrderID,
	CreationTime,
	GETDATE() Today
 FROM
Sales.Orders

--categories
	--1.Part Extraction
		--DAY
		--MONTH
		--YEAR
		--DATEPART
		--DATENAME
		--DATETRUNC
		--EOMONTH
	--2.Format and casting
		--FORMAT
		--CONVERT
		--CAST
	--3.Calculation
		--DATEADD
		--DATEDIFF
	--4.Validation
		--ISDATE

--*******************************************************************************

--*******************************************************************************
--DAY() -> returns the day from a date
--MONTH() -> retruns the month from the date
--MONTH() -> retruns the year from the date

SELECT 
	OrderID,
	CreationTime,
	GETDATE() Today,
	DAY(creationTime) as days,
	MONTH(creationTime) as months,
	YEAR(creationTime) as years
 FROM Sales.Orders

--DATEPART -> returns a specific part of a date as a number (week , quarter)
SELECT 
	OrderID,
	CreationTime,
	DATEPART(DAY, CreationTime) days,
	DATEPART(WEEK, CreationTime) weeks,
	DATEPART(HOUR, CreationTime) hours,
	DATEPART(SECOND, CreationTime) seconds,
	DATEPART(QUARTER, CreationTime) quarters,
	DATEPART(WEEKDAY, CreationTime) weekdays,
	DATEPART(WEEK, CreationTime) weeks
 FROM
Sales.Orders

----DATENAME -> 
--DATENAME(part,date)

SELECT 
	OrderID,
	CreationTime,
	DATENAME(MONTH,CreationTime) month_dn,
	DATENAME(YEAR,CreationTime) year_dn, -- it will return number but datatype is string
	DATENAME(DAY,CreationTime) day_dn -- it will return number but datatype is string
 FROM Sales.Orders


--DATETRUNC -> DATETRUNCATES the date to th specific part
--DATETRUNC(part,date) 

SELECT 
	OrderID,
	CreationTime,
	DATETRUNC(HOUR,CreationTime) month_dt,
	DATETRUNC(YEAR,CreationTime) year_dt, 
	DATETRUNC(DAY,CreationTime) day_dt ,
	DATETRUNC(MINUTE,CreationTime) minute_dt
 FROM Sales.Orders

----EOMONTH -> Returns the last day of month
SELECT 
	OrderID,
	CreationTime,
	EOMONTH(CreationTime) end_of_month
 FROM Sales.Orders


 SELECT 
	OrderID,
	CreationTime,
	EOMONTH(CreationTime) end_of_month, -- last day of month
	CAST(DATETRUNC(MONTH,CreationTime) AS DATE) satrt_of_month --cast remove time
 FROM Sales.Orders

--How many orders were placed each year?
SELECT 
	YEAR(orderDate)
	OrderDate,
	COUNT(*) Number_of_orders
FROM Sales.Orders
GROUP BY YEAR(orderDate)

--how many orders were placed each month
SELECT 
	DATENAME(month,orderDate)
	OrderDate,
	COUNT(*) Number_of_orders
FROM Sales.Orders
GROUP BY DATENAME(month,orderDate)

-- Show all orders that were placed during the month of february

SELECT *
FROM Sales.Orders
WHERE MONTH(OrderDate) = 2
---------------------------------
--approch 2 (but not recommended coz datename is finding by string)
SELECT 
	*,DATENAME(month,orderDate) months
FROM Sales.Orders
where DATENAME(month,orderDate) = 'february'  