CREATE DATABASE migration_sql_postgres;

USE migration_sql_postgres;

CREATE TABLE customers_raw (
    customer_id INT PRIMARY KEY,
    full_name VARCHAR(100),
    email VARCHAR(100),
    city VARCHAR(50),
    created_at DATE
);

CREATE TABLE orders_raw (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    order_amount DECIMAL(10,2),
    order_status VARCHAR(20)
);

CREATE TABLE payments_raw (
    payment_id INT PRIMARY KEY,
    order_id INT,
    payment_date DATE,
    payment_mode VARCHAR(20),
    payment_amount DECIMAL(10,2)
);

--Generate 1,000 Customers (Dirty Data)

;WITH numbers AS (
    SELECT TOP 1000 ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS n
    FROM sys.objects
)
INSERT INTO customers_raw
SELECT
    n AS customer_id,
    CASE WHEN n % 10 = 0 THEN NULL ELSE CONCAT('Customer_', n) END,
    CASE WHEN n % 7 = 0 THEN NULL ELSE CONCAT('customer', n, '@mail.com') END,
    CASE
        WHEN n % 5 = 0 THEN NULL
        WHEN n % 3 = 0 THEN 'Mumbai'
        WHEN n % 4 = 0 THEN 'Pune'
        ELSE 'Delhi'
    END,
    DATEADD(DAY, -n, GETDATE())
FROM numbers;


SELECT * FROM customers_raw;

--Generate 3,000 Orders (With Broken FK)

;WITH numbers AS (
    SELECT TOP 3000 ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS n
    FROM sys.objects a CROSS JOIN sys.objects b
)
INSERT INTO orders_raw
SELECT
    n AS order_id,
    CASE
        WHEN n % 20 = 0 THEN 9999         -- invalid customer
        ELSE (n % 1000) + 1
    END,
    CASE WHEN n % 15 = 0 THEN NULL ELSE DATEADD(DAY, -n, GETDATE()) END,
    CASE WHEN n % 8 = 0 THEN NULL ELSE ABS(CHECKSUM(NEWID())) % 10000 END,
    CASE
        WHEN n % 6 = 0 THEN 'cancelled'
        WHEN n % 9 = 0 THEN 'pending'
        ELSE 'completed'
    END
FROM numbers;

SELECT * FROM orders_raw;

--Generate 1,000 Payments (Partial Coverage)

;WITH numbers AS (
    SELECT TOP 1000 ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS n
    FROM sys.objects
)
INSERT INTO payments_raw
SELECT
    n AS payment_id,
    CASE
        WHEN n % 12 = 0 THEN 8888       -- invalid order
        ELSE (n % 3000) + 1
    END,
    CASE WHEN n % 10 = 0 THEN NULL ELSE DATEADD(DAY, -n, GETDATE()) END,
    CASE
        WHEN n % 3 = 0 THEN 'UPI'
        WHEN n % 4 = 0 THEN 'CARD'
        ELSE 'NETBANKING'
    END,
    CASE WHEN n % 9 = 0 THEN NULL ELSE ABS(CHECKSUM(NEWID())) % 8000 END
FROM numbers;



SELECT * FROM payments_raw;

--Data Validation Queries (Optional but Recommended)

-- Null check
SELECT COUNT(*) AS null_customers FROM customers_raw WHERE full_name IS NULL;

-- Invalid FK
SELECT COUNT(*) AS invalid_orders
FROM orders_raw
WHERE customer_id NOT IN (SELECT customer_id FROM customers_raw);

-- Cancelled orders
SELECT order_status, COUNT(*) FROM orders_raw GROUP BY order_status;



--create table in postgres
SELECT
    city,
    COUNT(*) AS customers,
    SUM(total_revenue) AS revenue
FROM customer_order_summary
GROUP BY city
ORDER BY revenue DESC;