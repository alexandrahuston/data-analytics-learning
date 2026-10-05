-- SQL Practice
-- MySQL
-- Alex the Analyst Data Analyst Bootcamp
--
-- This file contains practice examples
-- and notes as I learn SQL.


-- ============================================================
-- SELECT STATEMENT
-- ============================================================

-- The SELECT statement is used to specify which columns we want to retrieve from a table.

-- SELECT * returns every column from the table
SELECT *
FROM parks_and_recreation.employee_demographics;

-- Returns every column and its corresponding data.


-- Replace "*" with a specific column to return only that column
SELECT first_name
FROM parks_and_recreation.employee_demographics;

-- Returns only the first_name column.


-- Use "," to select multiple columns
SELECT first_name, last_name
FROM parks_and_recreation.employee_demographics;

-- Returns both first_name and last_name.


-- Columns can also be written on separate lines to make longer queries easier to read
SELECT last_name, 
       first_name, 
       gender, 
       age
FROM parks_and_recreation.employee_demographics;

-- This produces the same result as writing all columns on one line.


-- SQL can also perform mathematical operations
-- SQL follows the standard order of operations (PEMDAS)
SELECT first_name, 
       last_name, 
       birth_date,
       age,
       (age + 10) * 10
FROM parks_and_recreation.employee_demographics;


-- ============================================================
-- DISTINCT
-- ============================================================

-- DISTINCT returns only unique combinations of the
-- selected columns. Duplicate results are removed.

SELECT DISTINCT first_name, gender
FROM parks_and_recreation.employee_demographics;

-- Because both first_name AND gender are selected,
-- DISTINCT removes duplicate first_name/gender combinations.


-- To return only unique genders:
SELECT DISTINCT gender
FROM parks_and_recreation.employee_demographics;

-- This returns each unique gender value only once.

