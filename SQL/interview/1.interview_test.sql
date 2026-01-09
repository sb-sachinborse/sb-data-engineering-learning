/* =========================================================
   TABLE CREATION
   ========================================================= */

CREATE TABLE Employee (
    employee_id    INT,
    employee_name  VARCHAR(50),
    department_id  INT,
    position       VARCHAR(50),
    salary         DECIMAL(10, 2)
);


/* =========================================================
   INSERT SAMPLE DATA
   (Contains intentional duplicate records for interview use)
   ========================================================= */

INSERT INTO Employee (employee_id, employee_name, department_id, position, salary)
VALUES
    (1, 'Alice Johnson', 101, 'Software Engineer', 70000),
    (2, 'Bob Smith', 102, 'Data Scientist', 80000),
    (3, 'Carol White', 103, 'Project Manager', 75000),
    (4, 'David Brown', 104, 'Quality Assurance', 60000),
    (5, 'Eva Green', 105, 'HR Specialist', 55000),
    (6, 'Frank Martin', 101, 'Software Engineer', 70000),
    (3, 'Carol White', 103, 'Project Manager', 75000),
    (4, 'David Brown', 104, 'Quality Assurance', 60000);


/* =========================================================
   VIEW ALL EMPLOYEES
   ========================================================= */

SELECT *
FROM Employee;


/* =========================================================
   INTERVIEW QUESTIONS & SOLUTIONS
   ========================================================= */


/* ---------------------------------------------------------
   1. Remove duplicate records from Employee table
   --------------------------------------------------------- */

SELECT DISTINCT *
FROM Employee;


/* ---------------------------------------------------------
   2. Find duplicate records in Employee table
   --------------------------------------------------------- */

-- Approach 1: GROUP BY + HAVING
SELECT
    employee_id,
    employee_name,
    department_id,
    position,
    salary,
    COUNT(*) AS duplicate_count
FROM Employee
GROUP BY
    employee_id,
    employee_name,
    department_id,
    position,
    salary
HAVING COUNT(*) > 1;


-- Approach 2: Using CTE + ROW_NUMBER()
WITH cte AS (
    SELECT *,
           ROW_NUMBER() OVER (
               PARTITION BY employee_id
               ORDER BY department_id
           ) AS rn
    FROM Employee
)
SELECT *
FROM cte
WHERE rn > 1;


/* ---------------------------------------------------------
   3. Highest earning employee based on each position
   --------------------------------------------------------- */

-- Simple aggregation
SELECT
    position,
    MAX(salary) AS highest_salary
FROM Employee
GROUP BY position;


/* ---------------------------------------------------------
   4. Top 3 highest earning employees (including duplicates)
   --------------------------------------------------------- */

SELECT TOP 3 *
FROM Employee
ORDER BY salary DESC;


/* ---------------------------------------------------------
   5. Top 3 highest earning employees (without duplicates)
   --------------------------------------------------------- */

WITH cte AS (
    SELECT DISTINCT *
    FROM Employee
)
SELECT TOP 3 *
FROM cte
ORDER BY salary DESC;


/* ---------------------------------------------------------
   6. Top 3 lowest earning employees (without duplicates)
   --------------------------------------------------------- */

WITH cte AS (
    SELECT DISTINCT *
    FROM Employee
)
SELECT TOP 3 *
FROM cte
ORDER BY salary ASC;
