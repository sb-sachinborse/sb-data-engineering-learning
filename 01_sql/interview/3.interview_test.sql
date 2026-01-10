/* =========================================================
   SQL INTERVIEW QUESTION: JOIN BEHAVIOR WITH DUPLICATES & NULL
   =========================================================
   /* =========================================================
   SACHIN BORSE
   ========================================================= */

   QUESTION:
   Table A has 5 rows with id = 1
   Table B has 6 rows:
     - 5 rows with id = 1
     - 1 row with id = NULL

   Asked in interviews at:
   Amazon | Google | Microsoft | Accenture | TCS | Infosys

   KEY CONCEPTS TESTED:
   - Join behavior with duplicate keys
   - Cartesian multiplication
   - NULL handling in JOINs
   ========================================================= */


/* =========================================================
   TABLE CREATION
   ========================================================= */

CREATE TABLE A (
    id INT
);

CREATE TABLE B (
    id INT
);


/* =========================================================
   INSERT DATA
   ========================================================= */

-- Table A: 5 rows with value = 1
INSERT INTO A (id) VALUES
(1),
(1),
(1),
(1),
(1);

-- Table B: 5 rows with value = 1 and 1 NULL
INSERT INTO B (id) VALUES
(1),
(1),
(1),
(1),
(1),
(NULL);


/* =========================================================
   VIEW DATA
   ========================================================= */

SELECT * FROM A;
SELECT * FROM B;


/* =========================================================
   NOTE++ IMPORTANT RULES (READ BEFORE JOINS)
   =========================================================
   NOTE++ 1: NULL never matches any value (even NULL = NULL is FALSE)
   NOTE++ 2: When duplicate keys exist, joins create a CARTESIAN EFFECT
   NOTE++ 3: Matching rows = (rows in A) × (rows in B)
   ========================================================= */


/* =========================================================
   1. INNER JOIN
   =========================================================
   RULE:
   - Returns ONLY matching rows from both tables
   - NULL values are ignored

   CALCULATION:
   - A has 5 rows with id = 1
   - B has 5 rows with id = 1
   - Result = 5 × 5 = 25 rows
   ========================================================= */

SELECT A.id AS A_id, B.id AS B_id
FROM A
INNER JOIN B
ON A.id = B.id;

-- RESULT ROWS: 25


/* =========================================================
   2. LEFT JOIN (A LEFT JOIN B)
   =========================================================
   RULE:
   - All rows from Table A
   - Matching rows from Table B
   - NULL in B does NOT match

   CALCULATION:
   - All A rows have matches
   - No unmatched rows in A
   - Result = 5 × 5 = 25 rows
   ========================================================= */

SELECT A.id AS A_id, B.id AS B_id
FROM A
LEFT JOIN B
ON A.id = B.id;

-- RESULT ROWS: 25


/* =========================================================
   3. RIGHT JOIN (A RIGHT JOIN B)
   =========================================================
   RULE:
   - All rows from Table B
   - Matching rows from Table A
   - Unmatched rows from B appear with NULLs from A

   CALCULATION:
   - Matching rows: 5 × 5 = 25
   - One NULL row in B has NO match → included
   - Total = 25 + 1 = 26 rows
   ========================================================= */

SELECT A.id AS A_id, B.id AS B_id
FROM A
RIGHT JOIN B
ON A.id = B.id;

-- RESULT ROWS: 26


/* =========================================================
   4. FULL OUTER JOIN
   =========================================================
   RULE:
   - All rows from BOTH tables
   - Matching rows + unmatched rows from both sides

   CALCULATION:
   - Matching rows: 5 × 5 = 25
   - Unmatched row in B (NULL): +1
   - No unmatched rows in A
   - Total = 26 rows
   ========================================================= */

SELECT A.id AS A_id, B.id AS B_id
FROM A
FULL OUTER JOIN B
ON A.id = B.id;

-- RESULT ROWS: 26


/* =========================================================
   FINAL INTERVIEW SUMMARY (MEMORIZE)
   =========================================================
   INNER JOIN → 25 rows
   LEFT JOIN  → 25 rows
   RIGHT JOIN → 26 rows
   FULL JOIN  → 26 rows

   INTERVIEW ONE-LINER:
   "Duplicate keys cause Cartesian multiplication, and NULLs
    never participate in join conditions."
   ========================================================= */
