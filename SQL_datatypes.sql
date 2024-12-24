--USE: select a specific database to work with
--USE Company

--ALTER DATABASE database_name: modifies a databases Attributes
--ALTER DATABASE Company

--CREATING IN SQL
CREATE TABLE employees(
    employee_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    department VARCHAR(50),
    salary DECIMAL(10,2)
)

INSERT INTO employees(employee_id,first_name,last_name,department,salary)
VALUES
(1,'Abigael', 'Zawadi', 'CEO', 5000000.00),
(2,'George', 'Njoroge', 'HR', 800000.00),
(3,'John', 'Njogu', 'MD', 200000.00),
(4,'Neeve', 'Wanjiku', 'Driver', 70000.00),
(5,'Rachael', 'Mpemba', 'Cook', 5000.00);

ALTER TABLE employees
ADD age INT;

UPDATE employees
SET age = 20
WHERE employee_id = 1

UPDATE employees
SET age = 50
WHERE employee_id = 2

UPDATE employees
SET age = 27
WHERE employee_id = 3

UPDATE employees
SET age = 29
WHERE employee_id = 4

UPDATE employees
SET age = 47
WHERE employee_id = 5

SELECT * FROM employees

SELECT DISTINCT department FROM employees

SELECT DISTINCT department FROM employees
WHERE age = 20

--SELECT * FROM employees LIMIT 2

--SELECT * FROM employees OFFSET 2; in sql server this has tobe followed by an ORDER BY CLAUSE
 
SELECT TOP 3 * FROM employees

--performing conditional logic in a query
--CASE STATEMENT(CONDITIONAL EXPRESSIONS)
ALTER TABLE employees
ADD payment_class VARCHAR(20);  

UPDATE employees
SET payment_class = 
    CASE
        WHEN salary > 50000000 THEN 'highly paid'
        WHEN salary BETWEEN 800000 AND 50000000 THEN 'Paid well'
        ELSE 'poorly paid'
    END 
SELECT first_name, last_name, salary,payment_class
FROM employees

--if statements(in stored procedures)
IF (SELECT COUNT(*) FROM employees) > 5
BEGIN 
    PRINT 'There are more than 5 employees'
END
ELSE
BEGIN 
    PRINT 'There are 5 or fewer employees'
END

--COALESE FUNCTIONS
--they are used to handle null values by providing an alternative value when the null is encountered
SELECT COALESCE(payment_class, 'to_be_reviewed') AS [PAYMENT STATUS]
FROM employees

--LOGICAL OPERATORS
--AND returns true only if all conditions are true
SELECT * FROM employees
WHERE first_name = 'John' AND age = 27

--  OR returns TRUE if atleast one condition is TRUE
SELECT * FROM employees
WHERE employee_id = 3 or first_name = 'Abigael'

--NOT negates a condition
SELECT * FROM employees
WHERE first_name  NOT LIKE '%A%'

--Find employees in the HR department with a salary greater than 5000000 or employees NOT inthe HR department
SELECT * FROM employees
WHERE (department = 'HR' AND salary > 500000)

--The HAVING clause is used to filter the reSult of the GROUP BY based on the specified condtion, generally used after GROUO BY
--ORDER BY us to be placed after the HAVING CLAUSE IF ANY
SELECT department, SUM(salary) AS Salary
FrOM employees
GROUP BY department
HAVING SUM(Salary) >= 500000

SELECT department, SUM(salary) AS Salary
FrOM employees
GROUP BY department
HAVING SUM(Salary) <= 500000 AND AVG(Salary) > 500000

--This is used to find departments where there are more than two employees
SELECT department, count(employee_id) AS Employees
FROM employees
GROUP BY department
HAVING COUNT(employee_id) >= 2

--ORDERBY clause is used in SQL to sort query results in either ascending or descending order
--Sorting the employees first in decending order then ascending as per names
SELECT * FROM employees ORDER BY 4 DESC, first_name ASC

--GROUP BY is used for organising and summarisig data based on identical values in specifies columns
SELECT first_name, department, sum(salary) FROM employees
GROUP BY first_name, department

--SQL aggregate functions
--COUNT() provides the number of rows that match a specfied condition.
SELECT first_name, COUNT(employee_id) FROM employees
WHERE salary > 400000

--The AVG() calculates the average value of a numeric column
SELECT AVG(salary) AS [CUMMULATIVE AVG]
FROM employees
WHERE first_name LIKE '%a%'

--SQL CONTRAINTS
--constraints are used to enforce rules on data ensuriing accuaracy, and consistency

--we can add NOT NULL constraint when altering a table
ALTER TABLE employeeS ALTER COLUMN  department VARCHAR(50) NOT NULL

--UNIQUE CONSTAINT

CREATE TABLE customers(
    customer_id INT PRIMARY KEY,
    email NVARCHAR(255) CONSTRAINT unique_email UNIQUE,
    department NVARCHAR (50)
)
