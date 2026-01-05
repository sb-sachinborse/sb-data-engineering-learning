

-- *********Data Defination Language(DDL) ************--

-- CREATE
-- ALTER
-- DROP

--*********CREATE**********--

-- create new table called persons with 
--columns: id,person_name,birth_date and phone

CREATE TABLE persons (
	id INT NOT NULL,
	person_name VARCHAR(50) NOT NULL,
	birth_date DATE,
	phone VARCHAR(15) NOT NULL,
	CONSTRAINT pk_persons PRIMARY KEY(id)
);

SELECT *
FROM persons;


--*********ALTER**********--
--update anything in table

ALTER TABLE persons
ADD email VARCHAR(50) NOT NULL UNIQUE  --Adding new column are append at the end of table by default



-- Remove the column phone from the persons table
ALTER TABLE persons
DROP COLUMN phone;  -- carefull removeing colums means all the data are remove with the column



--*********DROP**********--
-- Delete the table persons from the databse

DROP TABLE persons;