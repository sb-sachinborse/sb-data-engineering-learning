SELECT *
FROM Employee;

SELECT * 
FROM table3;

SELECT * 
FROM table4;

--1. write a queery to create new table with same schema as employee tabl (only schema)
SELECT * INTO table3 from Employee WHERE 1=2

--2. create a new table same like employee table(data + schema)
SELECT * INTO table4 from Employee WHERE 1=1

--3. write a query where employee_name starts with letter A 
SELECT * 
FROM table4
WHERE employee_name LIKE 'A%';


--4. write a query where departmnet_id starts letter and ends letter is same
SELECT * 
FROM table4
WHERE left(department_id ,1)=right(department_id,1)

--5 write a query to gt records in xml format
SELECT *
FROM Employee 
for xml auto;

--6. how to get current date
SELECT getdate();
SELECT CURRENT_TIMESTAMP;

--7.query to get current month
SELECT MONTH(GETDATE())

--8. query to get current year
SELECT YEAR(GETDATE());