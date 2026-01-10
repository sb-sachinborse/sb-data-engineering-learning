Use sql_interview

CREATE TABLE .Deloitte_Products (
    ProductID INT PRIMARY KEY,
    Product VARCHAR(255),
    Category VARCHAR(100)
);

INSERT INTO Deloitte_Products (ProductID, Product, Category)
VALUES
    (1, 'Laptop', 'Electronics'),
    (2, 'Smartphone', 'Electronics'),
    (3, 'Tablet', 'Electronics'),
    (4, 'Headphones', 'Accessories'),
    (5, 'Smartwatch', 'Accessories'),
    (6, 'Keyboard', 'Accessories'),
    (7, 'Mouse', 'Accessories'),
    (8, 'Monitor', 'Accessories'),
    (9, 'Printer', 'Electronics');


SELECT *
FROM Deloitte_Products;
/*
SELECT
    max_id - rn + 1 AS ProductID,
    PRODUCT
    category
FROM (
    SELECT
       ProductID,
       Product,
       Category,
       ROW_NUMBER() OVER (PARTITION BY Category ORDER BY ProductID) AS rn,
       MAX(ProductID) OVER(PARTITION BY Category)AS max_id
    FROM Deloitte_Products
)t
ORDER BY category,ProductID
*/
SELECT
    b.ProductID AS new_ProductID,
    a.product,
    a.category
FROM
        (SELECT *,
            ROW_NUMBER() OVER (PARTITION BY category ORDER BY ProductID ASC) AS rn_asc
     FROM Deloitte_Products) a
     JOIN
    (SELECT *,
            ROW_NUMBER() OVER (PARTITION BY category ORDER BY ProductID DESC) AS rn_desc
     FROM Deloitte_Products) b
ON a.category = b.category
AND a.rn_asc = b.rn_desc
ORDER BY a.category, b.ProductID;
