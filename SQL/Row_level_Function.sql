
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

