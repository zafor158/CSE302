-- querying data dictionary

SELECT TABLE_NAME FROM USER_TABLES;

SELECT CONSTRAINT_NAME, TABLE_NAME FROM USER_CONS_COLUMNS;

-- schema modification 

-- add a new attribute
-- add a new attribute 'date_of_birth' to student table

ALTER TABLE STUDENT ADD date_of_birth DATE;
ALTER TABLE STUDENT ADD phone_number VARCHAR2(11);

-- drop an existing attribute

ALTER TABLE STUDENT DROP COLUMN phone_number;

-- modify the data type of an existing attribute

ALTER TABLE STUDENT MODIFY ID NUMBER;
ALTER TABLE STUDENT MODIFY dept_name NUMBER;

-- rename an existing attribute

ALTER TABLE STUDENT RENAME COLUMN dept_name TO dept_code;

-- about zipcode

ALTER TABLE STUDENT ADD zipcode NUMBER;
ALTER TABLE STUDENT MODIFY zipcode VARCHAR2(4);
ALTER TABLE STUDENT RENAME COLUMN zipcode to postalcode;

-- add a new constraint in a table

ALTER TABLE STUDENT ADD CONSTRAINT ST_DOB_CHK 
                    CHECK (date_of_birth >= '01-JAN-1989');

-- drop an existing constraint from a table

ALTER TABLE STUDENT DROP CONSTRAINT ST_DOB_CHK;

-- rename an existing table

ALTER TABLE COURSEADVISING RENAME TO ENROLMENT_INFO;

-- SQL Queries

-- Find account number and branch name of those accounts which have balance
-- more than or equal to 500 and less than or equal to 750.

SELECT account_number, branch_name
FROM account
WHERE balance >= 500 AND balance <= 750;

SELECT account_number, branch_name
FROM account
WHERE balance BETWEEN 500 AND 750;

-- Find loan number and branch name of those loans which have amount
-- more than 1000 and less than 1300. (Use BETWEEN keyword)

SELECT loan_number, branch_name
FROM loan
WHERE amount BETWEEN 1001 AND 1299;

-- Find customer names who have accounts.

SELECT customer_name
FROM depositor;


-- Find unique customer names who have accounts.

SELECT DISTINCT customer_name
FROM depositor;

-- Find customer name and customer city who have loans. Avoid repetition.
SELECT DISTINCT C.customer_name, customer_city
FROM customer C, borrower B
WHERE C.customer_name = B.customer_name;


SELECT DISTINCT customer_name, customer_city
FROM customer NATURAL JOIN borrower;

-- Find account number, customer name of those account which have balance 
-- more than 750

SELECT account_number, customer_name
FROM account NATURAL JOIN Depositor
WHERE balance > 750;

SELECT A.account_number, customer_name
FROM account A, Depositor D
WHERE A.account_number = D.account_number and balance > 750;

-- Set Operations

-- Find customer name of those who have an account or a loan or both.

SELECT customer_name
FROM Depositor
UNION
SELECT customer_name
FROM Borrower;

-- Find customer name of those who have both accounts and loans.

SELECT customer_name
FROM Depositor
INTERSECT
SELECT customer_name
FROM Borrower;

-- Find customer name who have accounts but no loans.
SELECT customer_name
FROM Depositor
MINUS
SELECT customer_name
FROM Borrower;

-- Find customer name who have loans but no accounts.
SELECT customer_name
FROM Borrower
MINUS
SELECT customer_name
FROM Depositor;



























