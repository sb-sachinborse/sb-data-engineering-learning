
---************* Data Manupulation Language (DML) **************---

-- INSERT
-- UPDATE
-- DELETE

SELECT *
FROM customers;

--------*** INSERT ***------------
INSERT INTO customers(id,first_name,country,score)
VALUES 
	(6,'John','USA',NULL),
	(7,'Anna',NULL,100)

-- ANOTHE WAY
INSERT INTO customers
VALUES 
	(8,'Adam','Germany',940)

-- COLUMN SPECIFIC
INSERT INTO customers(id,first_name,score)
VALUES 
	(9,'Millie',780

-- INSERT USING SELECT FROM ANTOHER TABLE (SOURCE TABLE TO TARGET TABLE)
	
--Copy data from 'customers' table into 'persons' table

INSERT INTO persons(id,person_name,birth_date,phone)
SELECT 
	id,
	first_name,
	Null,
	'Unknown'
FROM customers

SELECT * FROM persons;



--------*** UPDATE ***------------
-- change the score of customer with id 6 to 0

UPDATE customers 
SET score = 0   -- CAUTION(wihtout a WHERE ,all rows will be updated)
WHERE id = 6;

--change the country name of customer with id 7 
UPDATE customers
SET country = 'UK'
WHERE id = 7;

SELECT *
FROM customers


--------*** DELETE ***------------
--Delete all customers with an id greater than 5
DELETE
FROM customers
WHERE id > 5;

-- Delete all data from the persons table

--DELETE FROM persons

-- TRUNCATE (Clear the whole table at once without checking or logging)
TRUNCATE TABLE persons;

SELECT * 
FROM persons;

