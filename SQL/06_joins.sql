-- ============================================================
-- JOINS
-- ============================================================

-- A JOIN allows you to combine data from two or more tables
-- based on a related column between the tables.
--
-- The columns used to join the tables do NOT have to have
-- the same name.
--
-- What matters is that the values in the columns can be
-- matched to establish a relationship between the tables.
--
-- Example:
-- employee_demographics.employee_id
-- employee_salary.employee_id
--
-- Both tables contain employee IDs that can be used
-- to connect the employee information.


-- ============================================================
-- THE TABLES WE WILL BE JOINING
-- ============================================================

-- Employee demographic information
SELECT *
FROM employee_demographics;


-- Employee salary and job information
SELECT *
FROM employee_salary;


-- ============================================================
-- INNER JOIN
-- ============================================================

-- INNER JOIN returns only rows where there is a match
-- in BOTH tables based on the JOIN condition.
--
-- JOIN and INNER JOIN mean the same thing in this context.


-- This does NOT work:

SELECT *
FROM employee_demographics
INNER JOIN employee_salary
    ON employee_id = employee_id;

-- SQL returns an error because employee_id exists in BOTH
-- tables, so it does not know which employee_id we mean.
--
-- This is called an "ambiguous" column reference.


-- ============================================================
-- SPECIFYING WHICH TABLE A COLUMN COMES FROM
-- ============================================================

-- We can specify the table name before the column name.

SELECT *
FROM employee_demographics
INNER JOIN employee_salary
    ON employee_demographics.employee_id = employee_salary.employee_id;

-- This tells SQL:
-- Match the employee_id from employee_demographics
-- with the employee_id from employee_salary.
--
-- Only employees that exist in BOTH tables are returned.


-- ============================================================
-- ALIASING TABLES
-- ============================================================

-- Table aliases make JOIN queries shorter and easier to read.
--
-- "AS dem" gives employee_demographics the alias "dem."
-- "AS sal" gives employee_salary the alias "sal."
--
-- AS is optional, so these also work:
-- employee_demographics dem
-- employee_salary sal


SELECT *
FROM employee_demographics AS dem
INNER JOIN employee_salary AS sal
    ON dem.employee_id = sal.employee_id;


-- Aliases can also be used when selecting specific columns.

SELECT dem.employee_id,
       dem.age,
       sal.occupation
FROM employee_demographics AS dem
INNER JOIN employee_salary AS sal
    ON dem.employee_id = sal.employee_id;

-- dem.employee_id → employee ID from demographics
-- dem.age         → age from demographics
-- sal.occupation  → occupation from salary


-- ============================================================
-- OUTER JOINS
-- ============================================================

-- OUTER JOINs allow us to keep rows even when there is
-- no matching record in the other table.
--
-- The two main types covered here are:
--
-- LEFT JOIN
-- RIGHT JOIN


-- ============================================================
-- LEFT JOIN
-- ============================================================

-- LEFT JOIN returns:
-- 1. ALL rows from the LEFT table
-- 2. Matching rows from the RIGHT table
--
-- If there is no matching row in the right table,
-- SQL fills the right-table columns with NULL.


SELECT *
FROM employee_demographics AS dem
LEFT JOIN employee_salary AS sal
    ON dem.employee_id = sal.employee_id;

-- employee_demographics is the LEFT table.
-- employee_salary is the RIGHT table.
--
-- Every employee from employee_demographics is returned,
-- even if they do not have a matching record in employee_salary.
--
-- Missing salary-table information will appear as NULL.


-- LEFT OUTER JOIN can also be written as LEFT JOIN.
-- The word OUTER is optional.


-- ============================================================
-- RIGHT JOIN
-- ============================================================

-- RIGHT JOIN does the opposite of LEFT JOIN.
--
-- It returns:
-- 1. ALL rows from the RIGHT table
-- 2. Matching rows from the LEFT table
--
-- If there is no matching row in the left table,
-- SQL fills the left-table columns with NULL.


SELECT *
FROM employee_demographics AS dem
RIGHT JOIN employee_salary AS sal
    ON dem.employee_id = sal.employee_id;

-- employee_salary is the RIGHT table.
--
-- Every employee from employee_salary is returned,
-- even if they do not have a matching record in
-- employee_demographics.
--
-- Missing demographic information will appear as NULL.


-- ============================================================
-- LEFT JOIN VS RIGHT JOIN
-- ============================================================

-- LEFT JOIN:
-- Keep EVERYTHING from the table on the LEFT.
--
-- RIGHT JOIN:
-- Keep EVERYTHING from the table on the RIGHT.
--
-- In practice, LEFT JOIN is often preferred because you can
-- usually rearrange the tables and use a LEFT JOIN instead
-- of a RIGHT JOIN. This can make queries easier to read.


-- ============================================================
-- SELF JOIN
-- ============================================================

-- A SELF JOIN is when a table is joined to itself.
--
-- This is useful when you want to compare rows within the
-- same table or create relationships between records
-- in the same table.
--
-- Because the same table is being used twice, aliases are
-- necessary to distinguish between the two versions.


SELECT *
FROM employee_salary;


-- ============================================================
-- SELF JOIN EXAMPLE: SECRET SANTA
-- ============================================================

-- Imagine we want to assign each employee a Secret Santa.
--
-- For this example, we will pair each employee with the
-- employee whose ID is one number higher.
--
-- emp1 represents one copy of the employee_salary table.
-- emp2 represents a second copy of the same table.


SELECT *
FROM employee_salary AS emp1
JOIN employee_salary AS emp2
    ON emp1.employee_id = emp2.employee_id;

-- This matches each employee with themselves because
-- the employee IDs are equal.
--
-- This demonstrates how a SELF JOIN works, but it is not
-- useful for our Secret Santa example yet.


-- ============================================================
-- SELF JOIN WITH A DIFFERENT JOIN CONDITION
-- ============================================================

-- By adding 1 to emp1's employee_id, we can match each
-- employee with the employee whose ID is one number higher.

SELECT *
FROM employee_salary AS emp1
JOIN employee_salary AS emp2
    ON emp1.employee_id + 1 = emp2.employee_id;

-- Example:
-- Employee ID 1 is matched with Employee ID 2.
-- Employee ID 2 is matched with Employee ID 3.
-- And so on.


-- ============================================================
-- MAKING THE SELF JOIN EASIER TO UNDERSTAND
-- ============================================================

SELECT emp1.employee_id AS emp_santa,
       emp1.first_name AS santa_first_name,
       emp1.last_name AS santa_last_name,
       emp2.employee_id AS employee_id,
       emp2.first_name AS employee_first_name,
       emp2.last_name AS employee_last_name
FROM employee_salary AS emp1
JOIN employee_salary AS emp2
    ON emp1.employee_id + 1 = emp2.employee_id;

-- emp1 represents the person giving the gift.
-- emp2 represents the person receiving the gift.
--
-- The result shows which employee is assigned to
-- which Secret Santa recipient.


-- ============================================================
-- IMPORTANT SELF JOIN NOTE
-- ============================================================

-- This Secret Santa example is only demonstrating how
-- a SELF JOIN works.
--
-- In a real application, employee IDs would not necessarily
-- be sequential or appropriate for assigning Secret Santas.
--
-- A real Secret Santa assignment would normally use a
-- randomized matching process instead.


-- ============================================================
-- JOINING MULTIPLE TABLES
-- ============================================================

-- JOINs can be chained together to combine data from
-- more than two tables.


-- Department information
SELECT *
FROM parks_departments;

-- parks_departments acts as a reference table containing
-- department IDs and department names.


-- First, join employee_demographics to employee_salary.

SELECT *
FROM employee_demographics AS dem
INNER JOIN employee_salary AS sal
    ON dem.employee_id = sal.employee_id;


-- Then, add parks_departments to the existing JOIN.

SELECT *
FROM employee_demographics AS dem
INNER JOIN employee_salary AS sal
    ON dem.employee_id = sal.employee_id
INNER JOIN parks_departments AS pd
    ON sal.dept_id = pd.department_id;

-- The relationships work like this:
--
-- employee_demographics
--          |
--          | employee_id
--          ↓
-- employee_salary
--          |
--          | dept_id
--          ↓
-- parks_departments
--
-- employee_demographics connects to employee_salary
-- through employee_id.
--
-- employee_salary connects to parks_departments
-- through dept_id and department_id.
--
-- employee_demographics does NOT need to have a
-- department ID because the relationship can be
-- established through employee_salary.
