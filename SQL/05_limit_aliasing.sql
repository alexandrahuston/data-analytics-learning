-- ============================================================
-- LIMIT
-- ============================================================

-- LIMIT specifies the maximum number of rows returned
-- in the query result.

SELECT *
FROM employee_demographics
LIMIT 3;

-- Returns a maximum of 3 rows.
--
-- Without an ORDER BY clause, SQL does not guarantee
-- which 3 rows will be returned.


-- ============================================================
-- LIMIT WITH ORDER BY
-- ============================================================

-- LIMIT becomes especially useful when combined with ORDER BY.

SELECT *
FROM employee_demographics
ORDER BY age DESC
LIMIT 3;

-- First, the employees are sorted by age from oldest to youngest.
-- Then, LIMIT returns only the first 3 rows.
--
-- Therefore, this returns the 3 oldest employees.


-- ============================================================
-- LIMIT WITH OFFSET
-- ============================================================

-- LIMIT can also be used with an offset:
--
-- LIMIT offset, number_of_rows
--
-- The offset tells SQL how many rows to skip BEFORE
-- returning the requested number of rows.

SELECT *
FROM employee_demographics
ORDER BY age DESC
LIMIT 2, 1;

-- Skips the first 2 rows and then returns 1 row.
--
-- Because the results are sorted by age DESC, this returns
-- the 3rd oldest employee.


-- IMPORTANT:
-- The offset is zero-based.
--
-- LIMIT 0, 1 → skip 0 rows, return 1 row
-- LIMIT 1, 1 → skip 1 row, return 1 row
-- LIMIT 2, 1 → skip 2 rows, return 1 row


-- ============================================================
-- ALIASING
-- ============================================================

-- An alias gives a column or table a temporary name
-- within a query result.
--
-- Aliases can make output easier to understand and can make
-- long or complicated queries easier to read.
--
-- AS is used to assign an alias.


SELECT gender, AVG(age) AS avg_age
FROM employee_demographics
GROUP BY gender
HAVING avg_age > 40;

-- AVG(age) would normally appear in the output with the
-- name "AVG(age)."
--
-- AS avg_age gives the calculated column a more readable name:
-- "avg_age."
--
-- The alias can then be referenced in HAVING in MySQL.


-- ============================================================
-- ALIASING WITHOUT AS
-- ============================================================

-- The AS keyword is optional when creating an alias.

SELECT gender, AVG(age) avg_age
FROM employee_demographics
GROUP BY gender
HAVING avg_age > 40;

-- This produces the same result as the query above.
--
-- Using AS is often clearer for beginners because it makes
-- it obvious that "avg_age" is an alias.


-- ============================================================
-- WHY USE ALIASES?
-- ============================================================

-- Aliases are especially useful when working with:
-- * Aggregate functions
-- * Calculated columns
-- * Long column names
-- * Complex expressions
--
-- For example:

SELECT first_name,
       last_name,
       salary * 1.10 AS salary_with_raise
FROM employee_salary;

-- The calculation creates a new output column.
-- The alias "salary_with_raise" gives that column
-- a clear and meaningful name.
