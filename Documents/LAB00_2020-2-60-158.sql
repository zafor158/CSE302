                                                            Lab 00 task online
--creating a table
CREATE TABLE Instructor(
instructor_id varchar2(6),
instructor_name varchar2(20)  not null,
joining_date DATE,
salary NUMBER,
primary key(instructor_id),
check(joining_date >  ('01-JAN-2000')),
check(salary > 50000 and salary < 500000)
);

-- insert record in  Instructor  table
INSERT INTO Instructor VALUES ('ABC-01', 'Alice', '01-FEB-2001',120000);
INSERT INTO Instructor VALUES ('ABC-10', 'Bob', '03-MAR-2002',78000);
INSERT INTO Instructor VALUES ('ABC-21', 'Charlie', '10-JAN-2000',210000);

--Update an existing record
#Update salary of Alice to 150000;
Update Instructor
Set salary=150000
where instructor_name='Alice';

--show only name and salary of Instructor
select instructor_name,salary from Instructor;

--show name and joining_date of Instructor who get more than 100000
select instructor_name ,joining_date from Instructor
where salary >100000;

--Delete Instructor who has id ABC-10
delete from Instructor 
where instructor_id='ABC-10';