Lab Task#01 (Schema Definition):

--creating an account table
CREATE TABLE Account (
account_no char(5),
balance number not null,
CONSTRAINT P_PK PRIMARY KEY (account_no),
CONSTRAINT BN_CHK check(balance>0)
);

--creating a customer table
create table Customer (
customer_no char(5),
customer_name varchar2(20) not null,
customer_city varchar2(10),
CONSTRAINT P_P PRIMARY KEY (customer_no)
);

--creating a depositor table
create table Depositor(
account_no char(5),
customer_no char(5),
CONSTRAINT F_FK FOREIGN KEY (account_no) REFERENCES Account,
CONSTRAINT F_FK1 FOREIGN KEY (customer_no) REFERENCES Customer
);

Lab Task #02 (Schema Modification):
1--Write SQL statement to add a new attribute 'date_of_birth'(date type) in customer table 

ALTER TABLE Customer Add date_of_birth date;

2--Write SQL statement to drop the attribute 'date_of_birth' from customer table
 
ALTER TABLE Customer drop column date_of_birth;

3--Write SQL statement to rename the attribute 
account_no, customer_no from depositor table to a_no  
and c_no, respectively. 

ALTER TABLE Depositor Rename column account_no to a_no;
ALTER TABLE Depositor Rename column customer_no to c_no;

4--Write SQL statements to add two foreign key constraints 
‘depositor_fk1’ and ‘depositor_fk2’ which
identifies a_no and c_no as a foreign key.

ALTER TABLE Depositor drop CONSTRAINT F_FK ;
ALTER TABLE Depositor drop CONSTRAINT F_FK1 ;

ALTER TABLE Depositor add CONSTRAINT depositor_fk1 FOREIGN KEY (a_no) references Account;
ALTER TABLE Depositor add CONSTRAINT depositor_fk2 FOREIGN KEY (c_no) references Customer;

Lab Task #03 (Inserting Records into Tables): 
--inserting data into Account table
insert into Account values('A-101',12000);
insert into Account values('A-102',6000);
insert into Account values('A-103',2500);

--inserting data into Customer table
insert into Customer values('C-101','Alice','Dhaka');
insert into  Customer  values('C-102','Annie','Dhaka');
insert into Customer values('C-103','Bob','Chittagong');
insert into Customer values('C-104','Charlie','Khulna');


--inserting data into Depositor table
insert into Depositor values ('A-101','C-101');
insert into Depositor values ('A-103','C-102');
insert into Depositor values ('A-103','C-104');
insert into Depositor values ('A-102','C-103');


Lab Task #04 (Queries):
i--Display customer name and customer city only. 

select customer_name,customer_city from Customer;

ii--Display the unique customer city. No repetitions are allowed. 

select distinct customer_city from Customer;

iii--Find account numbers with balance more than 7000. 

select account_no from Account
where balance>7000;

iv--Find customer number and customer name who live in Khulna. 
select customer_no,customer_name from Customer
 where customer_city='Khulna';

v--Find customer number and customer name who 
do not live in Dhaka. 
select customer_no,customer_name from customer
where customer_city!='Dhaka';

vi. Find customer name and customer city who have accounts 
with balance more than 7000. 

select customer_name,customer_city from Customer,Depositor,
Account where Customer.customer_no=Depositor.c_no and 
Account.account_no=Depositor.a_no and balance>7000;

vii--Find customer name and customer city who 
have accounts with balance more than 7000 and 
do not live in Khulna. 

select customer_name,customer_city from Customer,Depositor,
Account where Customer.customer_no=Depositor.c_no and 
Account.account_no=Depositor.a_no and balance>7000 
and customer_city!='Khulna';

viii--Find account number and balance for those accounts 
which belong to a customer with id ‘C-102’.

select account_no,balance from Customer,Depositor,
Account where Customer.customer_no=Depositor.c_no and 
Account.account_no=Depositor.a_no and c_no = 'C-102'; 


ix--Find all account number and balance for those 
accounts which belong to customers of Dhaka and Khulna city. 

select Account.account_no,balance from Customer,Depositor,
Account where Customer.customer_no=Depositor.c_no and 
Account.account_no=Depositor.a_no and 
customer_city In ('Dhaka','Khulna');


x--Find the customer who have no accounts. [Result of this query will be empty for this dataset.
However, you must write the correct SQL]
select customer_name ,customer_no,customer_city from customer 
minus
select customer_name,customer_no,customer_city from
Customer,depositor where Customer.customer_no=Depositor.c_no;


