/* =========================================================
   DATA ENGINEER – SQL INTERVIEW PRACTICE
   REAL-WORLD SCENARIOS & QUESTIONS
   ========================================================= */

/* =========================================================
   SACHIN BORSE 
   ========================================================= */

/* =========================================================
   TABLE 1: EMPLOYEES
   ========================================================= */

CREATE TABLE Employees (
    employee_id   INT PRIMARY KEY,
    employee_name VARCHAR(50),
    department    VARCHAR(50),
    salary        INT,
    join_date     DATE,
    location      VARCHAR(50)
);


/* =========================================================
   INSERT SAMPLE DATA
   ========================================================= */

INSERT INTO Employees VALUES
(1, 'Alice',   'Engineering', 90000, '2021-01-10', 'Bangalore'),
(2, 'Bob',     'Engineering', 85000, '2020-03-15', 'Hyderabad'),
(3, 'Carol',   'HR',          60000, '2019-06-01', 'Mumbai'),
(4, 'David',   'HR',          65000, '2021-09-23', 'Mumbai'),
(5, 'Eva',     'Finance',     95000, '2018-12-11', 'Delhi'),
(6, 'Frank',   'Finance',     90000, '2020-08-19', 'Delhi'),
(7, 'Grace',   'Engineering', 92000, '2022-02-01', 'Bangalore'),
(8, 'Harry',   'Sales',       70000, '2019-05-30', 'Chennai'),
(9, 'Ivy',     'Sales',       72000, '2020-07-14', 'Chennai'),
(10,'Jack',    'Engineering', 90000, '2021-11-01', 'Hyderabad');


/* =========================================================
   TABLE 2: ORDERS (VERY COMMON IN INTERVIEWS)
   ========================================================= */

CREATE TABLE Orders (
    order_id     INT PRIMARY KEY,
    customer_id  INT,
    order_date   DATE,
    amount       INT
);


INSERT INTO Orders VALUES
(101, 1, '2024-01-01', 500),
(102, 1, '2024-01-10', 700),
(103, 2, '2024-01-05', 300),
(104, 3, '2024-02-01', 900),
(105, 2, '2024-02-10', 400),
(106, 4, '2024-03-01', 1200);


/* =========================================================
   MOST ASKED SQL INTERVIEW QUESTIONS (DATA ENGINEER)
   ========================================================= */


/* ---------------------------------------------------------
   Q1. Find the highest salary in each department
   (Asked at: Amazon, Accenture)
   --------------------------------------------------------- */

SELECT department, MAX(salary) AS highest_salary
FROM Employees
GROUP BY department;


/* ---------------------------------------------------------
   Q2. Find employees earning more than average salary
   (Asked at: Google, Microsoft)
   --------------------------------------------------------- */

SELECT *
FROM Employees
WHERE salary > (SELECT AVG(salary) FROM Employees);


/* ---------------------------------------------------------
   Q3. Find the 2nd highest salary overall
   (Asked at: Amazon, Flipkart)
   --------------------------------------------------------- */

WITH cte AS (
    SELECT *,
           DENSE_RANK() OVER (ORDER BY salary DESC) AS ranking
    FROM Employees
)
SELECT *
FROM cte
WHERE ranking = 2;


/* ---------------------------------------------------------
   Q4. Find top 2 highest-paid employees per department
   (Asked at: Walmart, Adobe)
   --------------------------------------------------------- */

WITH cte AS (
    SELECT *,
           ROW_NUMBER() OVER (
               PARTITION BY department
               ORDER BY salary DESC
           ) AS rn
    FROM Employees
)
SELECT *
FROM cte
WHERE rn <= 2;


/* ---------------------------------------------------------
   Q5. Find departments having more than 2 employees
   (Asked at: TCS, Infosys)
   --------------------------------------------------------- */

SELECT department, COUNT(*) AS emp_count
FROM Employees
GROUP BY department
HAVING COUNT(*) > 2;


/* ---------------------------------------------------------
   Q6. Find duplicate salaries
   (Asked at: Cognizant, Capgemini)
   --------------------------------------------------------- */

SELECT salary, COUNT(*) AS count_salary
FROM Employees
GROUP BY salary
HAVING COUNT(*) > 1;


/* ---------------------------------------------------------
   Q7. Get employees who joined in the last 2 years
   (Asked at: Deloitte)
   --------------------------------------------------------- */

SELECT *
FROM Employees
WHERE join_date >= DATEADD(YEAR, -2, GETDATE());


/* ---------------------------------------------------------
   Q8. Find customers who placed more than one order
   (Asked at: Amazon, Meesho)
   --------------------------------------------------------- */

SELECT customer_id, COUNT(*) AS total_orders
FROM Orders
GROUP BY customer_id
HAVING COUNT(*) > 1;


/* ---------------------------------------------------------
   Q9. Find total revenue per customer
   (Asked at: Paytm, Razorpay)
   --------------------------------------------------------- */

SELECT customer_id, SUM(amount) AS total_spent
FROM Orders
GROUP BY customer_id;


/* ---------------------------------------------------------
   Q10. Find customers who never placed an order
   (Asked at: Google, Walmart)
   --------------------------------------------------------- */

SELECT e.employee_id, e.employee_name
FROM Employees e
LEFT JOIN Orders o
ON e.employee_id = o.customer_id
WHERE o.customer_id IS NULL;


/* ---------------------------------------------------------
   Q11. Find running total of order amount
   (Asked at: Amazon, Netflix)
   --------------------------------------------------------- */

SELECT order_id,
       customer_id,
       order_date,
       amount,
       SUM(amount) OVER (
           PARTITION BY customer_id
           ORDER BY order_date
       ) AS running_total
FROM Orders;


/* ---------------------------------------------------------
   Q12. Find the latest order per customer
   (Asked at: Uber, Swiggy)
   --------------------------------------------------------- */

WITH cte AS (
    SELECT *,
           ROW_NUMBER() OVER (
               PARTITION BY customer_id
               ORDER BY order_date DESC
           ) AS rn
    FROM Orders
)
SELECT *
FROM cte
WHERE rn = 1;
