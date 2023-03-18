
--create Building table 
create table Building (
building varchar2(5),
area number,
floor number,
CONSTRAINT BT_PK PRIMARY KEY (building)
);
INSERT INTO Building VALUES('Main', 500000, 8);
INSERT INTO Building VALUES('AB-1', 200000, 10);
INSERT INTO Building VALUES('AB-2', 100000, 8);

---create department table
create table Department(
dept_name varchar2(5),
building varchar2(6),
budget number,
CONSTRAINT DT_PK PRIMARY KEY (dept_name),
CONSTRAINT DT_FK FOREIGN KEY (building) references Building,
CONSTRAINT DT_chk check (budget>100000)
);
INSERT INTO Department VALUES('CSE', 'Main', 240000);
INSERT INTO Department VALUES('EEE', 'AB-1', 330000);
INSERT INTO Department VALUES('ECE', 'AB-2', 450000);

----create Instructor table
create table Instructor(
id varchar2(13),
name varchar2(20) not null,
dept_name varchar2(4),
salary number,
CONSTRAINT IT_PK PRIMARY KEY (id),
CONSTRAINT IT_FK FOREIGN KEY (dept_name) references Department,
CONSTRAINT IT_chk check (salary>30000)
);
INSERT INTO Instructor VALUES('1001', 'Alice', 'CSE', 50000);
INSERT INTO Instructor VALUES('1002', 'Bob', 'EEE', 75000);
INSERT INTO Instructor VALUES('1003', 'Charlie', 'EEE', 85000);

---questions----
a. Find instructor id, name, salary of those who have their departments located in 'Main' building.
SELECT  id, name, salary
FROM Department, Instructor
WHERE Department.dept_name = Instructor.dept_name and building = 'Main';

b. Find the department names which are located in a building with more than 2,00,000 square feet area.
SELECT  Department.dept_name
FROM Building, Department
WHERE Building.building = Department.building and area > 2000000;

c. Find name and department name of instructors who have departments with budget in between 1,00,000 amd 2,00,000.
SELECT name, Instructor.dept_name 
FROM Department, Instructor
WHERE Department.dept_name = Instructor.dept_name and budget >= 100000 and budget <= 200000;

d.Find instructor name, dept name and building of those who gets salary more than 50,000 and their departments are located in a building having less than 2,00,000 square feet area.
SELECT name, Department.dept_name, Building.building
FROM Building, Department, Instructor
WHERE Department.building = Building.building and Instructor.dept_name = Department.dept_name and salary > 50000 and area < 2000000;
