-- ============================================================
-- HAVING VS WHERE
-- ============================================================

-- WHERE and HAVING are both used to filter data,
-- but they filter at different stages of the query.
--
-- WHERE filters individual ROWS before they are grouped.
-- HAVING filters GROUPS after GROUP BY and can be used
-- with aggregate functions such as AVG(), SUM(), and COUNT().


-- ============================================================
-- WHY WHERE CANNOT FILTER AN AGGREGATE FUNCTION
-- ============================================================

-- This does NOT work:

SELECT gender, AVG(age)
FROM employee_demographics
WHERE AVG(age) > 40
GROUP BY gender;

-- This produces an error because WHERE is evaluated BEFORE
-- the GROUP BY and aggregate functions.
--
-- At the WHERE stage, AVG(age) has not been calculated yet.
--
-- Use HAVING when you need to filter based on an aggregate.


-- ============================================================
-- HAVING WITH AN AGGREGATE FUNCTION
-- ============================================================

SELECT gender, AVG(age)
FROM employee_demographics
GROUP BY gender
HAVING AVG(age) > 40;

-- First, SQL groups the employees by gender.
-- Then AVG(age) is calculated for each gender group.
-- Finally, HAVING keeps only the groups where the
-- average age is greater than 40.


-- ============================================================
-- WHERE VS HAVING -- SIMPLE EXAMPLE
-- ============================================================

-- First, calculate the average salary for each occupation.

SELECT occupation, AVG(salary)
FROM employee_salary
GROUP BY occupation;


-- WHERE can be used to filter the individual rows
-- BEFORE they are grouped.

SELECT occupation, AVG(salary)
FROM employee_salary
WHERE occupation LIKE '%manager%'
GROUP BY occupation;

-- WHERE first keeps only employees whose occupation
-- contains the word "manager."
--
-- Then GROUP BY groups those employees by occupation.
-- Finally, AVG(salary) calculates the average salary
-- for each manager occupation.


-- ============================================================
-- USING WHERE AND HAVING TOGETHER
-- ============================================================

SELECT occupation, AVG(salary)
FROM employee_salary
WHERE occupation LIKE '%manager%'
GROUP BY occupation
HAVING AVG(salary) > 75000;

-- WHERE filters the individual rows FIRST:
-- Only employees whose occupation contains "manager"
-- are included.
--
-- GROUP BY then groups those remaining employees
-- by occupation.
--
-- AVG(salary) calculates the average salary for each group.
--
-- HAVING then filters those groups:
-- Only manager occupations with an average salary
-- greater than $75,000 are returned.


-- ============================================================
-- THE KEY DIFFERENCE
-- ============================================================

-- WHERE = filters ROWS before grouping
--
-- HAVING = filters GROUPS after grouping
--
-- A useful way to remember:
--
-- WHERE asks:
-- "Which individual rows should I include?"
--
-- HAVING asks:
-- "Which groups should I keep after I calculate
--  something about those rows?"


-- ============================================================
-- SIMPLIFIED QUERY ORDER
-- ============================================================

-- A simplified way to think about the order SQL processes
-- these parts of a query is:
--
-- 1. FROM       → Choose the table
-- 2. WHERE      → Filter individual rows
-- 3. GROUP BY   → Create groups
-- 4. HAVING     → Filter groups
-- 5. SELECT     → Determine what to return
-- 6. ORDER BY   → Sort the final results
--
-- This is why an aggregate function such as AVG()
-- generally cannot be used in WHERE:
--
-- WHERE happens before AVG() is calculated.
--
-- HAVING happens after the groups and their aggregate
-- calculations have been created.
