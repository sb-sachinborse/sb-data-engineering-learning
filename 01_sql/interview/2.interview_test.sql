

/* =========================================================
   SACHIN BORSE 
   ========================================================= */

/* =========================================================
   TABLE CREATION
   ========================================================= */

CREATE TABLE Emp (
    employee_id    INT PRIMARY KEY,
    employee_name  VARCHAR(50),
    department     VARCHAR(50),
    salary         DECIMAL(10, 2),
    location       VARCHAR(50)
);
 

/* =========================================================
   INSERT SAMPLE DATA
   ========================================================= */

INSERT INTO Emp (employee_id, employee_name, department, salary, location)
VALUES
    (1,  'Alice Johnson',  'Engineering',        75000, 'New York'),
    (2,  'Bob Smith',     'Data Science',       85000, 'San Francisco'),
    (3,  'Carol White',   'Human Resources',    65000, 'Chicago'),
    (4,  'David Brown',   'Engineering',        78000, 'Austin'),
    (5,  'Eva Green',     'Marketing',          70000, 'Seattle'),
    (6,  'Frank Martin',  'Data Science',       82000, 'New York'),
    (7,  'Grace Lee',     'Finance',             90000, 'Los Angeles'),
    (8,  'Harry Clark',   'Sales',               72000, 'Chicago'),
    (9,  'Ivy Baker',     'Human Resources',    67000, 'Austin'),
    (10, 'Jack Wilson',   'Marketing',          71000, 'San Francisco'),
    (11, 'Karen Evans',   'Engineering',        76000, 'Seattle'),
    (12, 'Leo Adams',     'Data Science',       84000, 'New York'),
    (13, 'Mona Scott',    'Finance',             88000, 'Los Angeles'),
    (14, 'Nate Perry',    'Sales',               74000, 'Chicago'),
    (15, 'Olivia Cooper', 'Engineering',        78000, 'Austin');


/* =========================================================
   VIEW DATA
   ========================================================= */

SELECT *
FROM Emp;


/* =========================================================
   INTERVIEW QUESTIONS – WINDOW FUNCTIONS
   ========================================================= */


/* ---------------------------------------------------------
   1. Find the 2nd highest salary employee
   --------------------------------------------------------- */

WITH cte AS (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY salary DESC) AS ranking
    FROM Emp
)
SELECT *
FROM cte
WHERE ranking = 2;


/* ---------------------------------------------------------
   2. Find the 2nd lowest earning employee
   --------------------------------------------------------- */

WITH cte AS (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY salary ASC) AS ranking
    FROM Emp
)
SELECT *
FROM cte
WHERE ranking = 2;


/* ---------------------------------------------------------
   3. Find the 2nd highest salary in each department
   --------------------------------------------------------- */

WITH cte AS (
    SELECT *,
           ROW_NUMBER() OVER (
               PARTITION BY department
               ORDER BY salary DESC
           ) AS ranking
    FROM Emp
)
SELECT *
FROM cte
WHERE ranking = 2;
-- Note: If duplicate salaries exist, use RANK() or DENSE_RANK()


/* ---------------------------------------------------------
   4. Find the 3rd lowest salary in each location
   --------------------------------------------------------- */

WITH cte AS (
    SELECT *,
           ROW_NUMBER() OVER (
               PARTITION BY location
               ORDER BY salary ASC
           ) AS ranking
    FROM Emp
)
SELECT *
FROM cte
WHERE ranking = 3;


/* ---------------------------------------------------------
   5. Find the bottom 2 salaries in each location
   --------------------------------------------------------- */

WITH cte AS (
    SELECT *,
           ROW_NUMBER() OVER (
               PARTITION BY location
               ORDER BY salary ASC
           ) AS ranking
    FROM Emp
)
SELECT *
FROM cte
WHERE ranking IN (1, 2);
-- Alternative: ranking < 3


/* ---------------------------------------------------------
   6. Find the top 2 salaries in each department
   --------------------------------------------------------- */

WITH cte AS (
    SELECT *,
           ROW_NUMBER() OVER (
               PARTITION BY department
               ORDER BY salary DESC
           ) AS ranking
    FROM Emp
)
SELECT *
FROM cte
WHERE ranking IN (1, 2);
