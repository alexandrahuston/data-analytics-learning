-- ============================================================
-- GROUP BY
-- ============================================================

-- GROUP BY is used to group rows that have the same value(s)
-- in one or more specified columns.
--
-- It is commonly used with aggregate functions such as:
-- AVG()   = Average
-- MAX()   = Maximum
-- MIN()   = Minimum
-- COUNT() = Count
-- SUM()   = Sum


-- View the original data before grouping it
SELECT *
FROM employee_demographics;


-- ============================================================
-- GROUPING BY ONE COLUMN
-- ============================================================

-- When selecting a column by itself with GROUP BY,
-- the selected column must also appear in the GROUP BY clause.

SELECT gender
FROM employee_demographics
GROUP BY gender;

-- Returns each unique gender value once.
--
-- GROUP BY combines rows that have the same value
-- in the specified column.


-- ============================================================
-- GROUP BY WITH AN AGGREGATE FUNCTION
-- ============================================================

-- Aggregate functions perform calculations on multiple rows
-- and return a single result for each group.

-- AVG() calculates the average value.

SELECT gender, AVG(age)
FROM employee_demographics
GROUP BY gender;

-- Returns the average age for each gender group.


-- ============================================================
-- WHY THE SELECTED COLUMNS MATTER
-- ============================================================

-- The columns being selected must either:
-- 1. Be included in the GROUP BY clause, OR
-- 2. Be used inside an aggregate function.


-- This works because gender is included in GROUP BY.

SELECT gender
FROM employee_demographics
GROUP BY gender;


-- This does NOT work because first_name is selected,
-- but first_name is not included in GROUP BY
-- and is not being used with an aggregate function.

SELECT first_name
FROM employee_demographics
GROUP BY gender;

-- SQL cannot determine which first_name to return
-- for each gender group.


-- ============================================================
-- GROUP BY WITH MULTIPLE COLUMNS
-- ============================================================

-- Multiple columns can be included in GROUP BY.
--
-- SQL will create a group for each UNIQUE COMBINATION
-- of the selected columns.

SELECT occupation
FROM employee_salary
GROUP BY occupation;


SELECT occupation, salary
FROM employee_salary
GROUP BY occupation, salary;

-- Each unique occupation + salary combination becomes a group.
--
-- This is different from grouping by occupation alone because
-- employees with the same occupation but different salaries
-- will be placed into separate groups.


-- ============================================================
-- MULTIPLE AGGREGATE FUNCTIONS
-- ============================================================

SELECT gender,
       AVG(age),
       MAX(age),
       MIN(age),
       COUNT(age)
FROM employee_demographics
GROUP BY gender;

-- Returns one row for each gender group with:
-- AVG(age)   = Average age
-- MAX(age)   = Oldest age in the group
-- MIN(age)   = Youngest age in the group
-- COUNT(age) = Number of non-NULL age values in the group


-- ============================================================
-- ORDER BY
-- ============================================================

-- ORDER BY is used to sort the results of a query.
--
-- ASC  = Ascending order
-- DESC = Descending order
--
-- ASC is the default sorting order.


-- ============================================================
-- ASCENDING ORDER
-- ============================================================

-- If no direction is specified, ORDER BY uses ascending order
-- by default.

SELECT *
FROM employee_demographics
ORDER BY first_name;


-- ASC can also be written explicitly.

SELECT *
FROM employee_demographics
ORDER BY first_name ASC;

-- For text, ascending order generally goes A → Z.
-- For numbers, it goes smallest → largest.


-- ============================================================
-- DESCENDING ORDER
-- ============================================================

SELECT *
FROM employee_demographics
ORDER BY first_name DESC;

-- For text, descending order generally goes Z → A.
-- For numbers, it goes largest → smallest.


-- ============================================================
-- ORDER BY MULTIPLE COLUMNS
-- ============================================================

-- Multiple columns can be used with ORDER BY.
--
-- SQL sorts by the FIRST column first.
-- If two or more rows have the same value in that column,
-- SQL uses the SECOND column to determine their order.

SELECT *
FROM employee_demographics
ORDER BY gender, age;

-- First sorts by gender.
-- Then sorts by age within each gender group.


-- Each column can have its own sort direction.

SELECT *
FROM employee_demographics
ORDER BY gender, age DESC;

-- First sorts by gender in ascending order.
-- Then sorts age from highest to lowest within each gender.


SELECT *
FROM employee_demographics
ORDER BY age, gender;

-- First sorts by age.
-- If multiple employees have the same age,
-- gender is used as the secondary sort.


-- The order of the columns in ORDER BY matters.
--
-- ORDER BY gender, age
-- is NOT the same as:
-- ORDER BY age, gender


-- ============================================================
-- ORDER BY USING COLUMN NUMBERS
-- ============================================================

-- SQL can also sort by the position of a column
-- in the SELECT statement.

SELECT *
FROM employee_demographics
ORDER BY 5, 4;

-- In this example:
-- 5 = the 5th column in the SELECT result
-- 4 = the 4th column in the SELECT result
--
-- This works, but it is NOT recommended.
--
-- Using actual column names is easier to read and maintain,
-- especially when working with larger queries or changing
-- the order of columns in the SELECT statement.
