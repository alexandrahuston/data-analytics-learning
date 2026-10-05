-- ============================================================
-- WHERE CLAUSE
-- ============================================================

-- The WHERE clause is used to filter rows of data.
-- It returns only the records that meet a specified condition.


-- ============================================================
-- COMPARISON OPERATORS
-- ============================================================

-- Text values should be written inside single quotation marks (' ').
-- The = operator checks whether a value exactly matches the
-- specified value.

SELECT *
FROM employee_salary
WHERE first_name = 'Leslie';

-- Returns only rows where first_name is exactly "Leslie".


-- Other comparison operators include:
-- >   Greater than
-- <   Less than
-- =   Equal to
-- >=  Greater than or equal to
-- <=  Less than or equal to
-- !=  Not equal to
--
-- When using >= or <=, the equal sign must come AFTER
-- the greater-than or less-than symbol.


SELECT *
FROM employee_salary
WHERE salary >= 50000;

-- Returns employees whose salary is greater than or equal to $50,000.


-- The != operator means "not equal to."

SELECT *
FROM employee_demographics
WHERE gender != 'female';

-- Returns all rows where gender is NOT equal to "female."


-- ============================================================
-- WHERE WITH DATE VALUES
-- ============================================================

-- The WHERE clause can also be used to filter dates.
-- Dates are written inside single quotation marks.
--
-- The date format used in this dataset is:
-- YYYY-MM-DD
-- Year-Month-Day


SELECT *
FROM employee_demographics
WHERE birth_date > '1985-01-01';

-- Returns employees born after January 1, 1985.


-- ============================================================
-- AND, OR, NOT -- LOGICAL OPERATORS
-- ============================================================

-- Logical operators allow multiple conditions to be combined.
--
-- AND  = ALL conditions must be true
-- OR   = AT LEAST ONE condition must be true
-- NOT  = reverses a condition


-- AND
-- Both conditions must be true.

SELECT *
FROM employee_demographics
WHERE birth_date > '1985-01-01'
AND gender = 'male';

-- Returns employees who were born after January 1, 1985
-- AND have a gender value of "male."


-- OR
-- At least one of the conditions must be true.

SELECT *
FROM employee_demographics
WHERE birth_date > '1985-01-01'
OR gender = 'male';

-- Returns employees who were born after January 1, 1985
-- OR have a gender value of "male."
--
-- An employee only needs to meet ONE of these conditions
-- to be included in the results.


-- NOT
-- NOT reverses the condition.

SELECT *
FROM employee_demographics
WHERE birth_date > '1985-01-01'
OR NOT gender = 'male';

-- Returns employees who were born after January 1, 1985
-- OR whose gender is NOT "male."


-- Parentheses can be used to control the order in which
-- logical conditions are evaluated.

SELECT *
FROM employee_demographics
WHERE (first_name = 'Leslie' AND age = 44)
OR age > 55;

-- First, SQL evaluates:
-- (first_name = 'Leslie' AND age = 44)
--
-- Then it checks whether age > 55.
--
-- Parentheses work similarly to PEMDAS in mathematical
-- expressions by controlling which part is evaluated first.


-- ============================================================
-- LIKE OPERATOR
-- ============================================================

-- LIKE is used to search for a pattern within text.
-- It is useful when we don't know the exact value we are
-- looking for.
--
-- LIKE uses two special wildcard characters:
--
-- % = any number of characters (including zero characters)
-- _ = exactly ONE character


-- % at the END
-- "Jer%" means the value must start with "Jer"
-- and can have any number of characters after it.

SELECT *
FROM employee_demographics
WHERE first_name LIKE 'Jer%';

-- Examples that could match:
-- Jeremy
-- Jerry
-- Jerald


-- % at the BEGINNING and END
-- "%er%" means "er" can appear anywhere in the string.

SELECT *
FROM employee_demographics
WHERE first_name LIKE '%er%';

-- "er" can appear at the beginning, middle, or end
-- of the value.


-- % at the END
-- "a%" means the value must start with "a"
-- and can have any number of characters after it.

SELECT *
FROM employee_demographics
WHERE first_name LIKE 'a%';


-- _ represents exactly ONE character.
-- Each underscore requires one character in that position.

SELECT *
FROM employee_demographics
WHERE first_name LIKE 'a___%';

-- "a" must be the first character.
-- Each "_" represents exactly one required character.
-- "%" allows any number of additional characters afterward.
--
-- Therefore, this pattern requires the name to have
-- at least 4 characters and start with "a."


-- LIKE can also be used with dates when searching for
-- a specific pattern within the date value.

SELECT *
FROM employee_demographics
WHERE birth_date LIKE '1989%';

-- Returns employees whose birth year is 1989.
--
-- "1989%" means the date must start with "1989"
-- followed by any number of additional characters.
