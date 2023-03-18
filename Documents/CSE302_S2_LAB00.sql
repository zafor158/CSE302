-- create a new user

CREATE USER CSE302_S2_F22 IDENTIFIED BY cse302;

-- giving permission to user

GRANT CONNECT, CREATE SESSION, CREATE TABLE, CREATE VIEW, 
CREATE SEQUENCE, CREATE ANY TRIGGER, UNLIMITED TABLESPACE 
TO CSE302_S2_F22;

-- create a table

CREATE TABLE Student(
   id VARCHAR2(13),
   name VARCHAR2(10),
   addr VARCHAR2(3),
   age NUMBER(3,0),
   gender CHAR(1),
   dob DATE,
   credits_earned NUMBER(5,2),
   cgpa NUMBER(3,2),
   PRIMARY KEY (id),
   CHECK (cgpa >=0 and cgpa <=4.0),
   CHECK (credits_earned >=0 and credits_earned <= 140)
);
-- drop a table (optional)
DROP TABLE Student;
-- insert record in  Student table
INSERT INTO Student VALUES (
    '2017-1-60-001', 'Alice', 'DHK', 21, 'F', 
    '01-FEB-2000', 85, 3.75);

INSERT INTO Student VALUES (
    '2018-2-60-999', 'Bob', 'CTG', 20, 'M', 
    '01-JAN-2001', 105, 3.25);

INSERT INTO Student VALUES (
    '2019-1-60-303', 'Charlie', 'KHL', 20, 'M', 
    '10-OCT-2001', 57, 2.75);



-- update an existing record
-- update the row of student id 2017-1-60-001 with credits_earned 
 99 and cgpa 3.8

UPDATE Student
SET credits_earned = 99, cgpa = 3.8
WHERE id = '2017-1-60-001';

-- delete student with id 2019-1-60-303

DELETE FROM Student
WHERE id = '2019-1-60-303';


SELECT id, name, gender
FROM Student;


SELECT id, name, gender
FROM Student
WHERE addr = 'DHK';

-- for saving
commit;
















