                                            -----------------------------------------Lab05---------------------------------------
-- 1

select c.customer_name, c.customer_city, c.customer_street
from customer c ,depositor d , account a ,branch b
where a.account_number = d.account_number and b.branch_name = a.branch_name
	and d.customer_name = c.customer_name 
	and c.customer_city = b.branch_city;



select c_city.customer_name, c_city.customer_city, c_city.customer_street
from (select * from account natural join branch) b_city, 
     (select * from customer natural join depositor) c_city
where b_city.account_number = c_city.account_number 
      and b_city.branch_city = c_city.customer_city;


--2


select distinct customer_name, customer_city, customer_street
from customer natural join borrower natural join loan natural join branch  
where customer.customer_city = branch.branch_city;



select c_city.customer_name, c_city.customer_city, c_city.customer_street
from (select * from customer natural join borrower) c_city,
     (select * from loan natural join branch) b_city
where c_city.loan_number = b_city.loan_number
      and customer_city = branch_city;
	


--3


select branch_city, avg(balance) from account natural join branch
group by branch_city
having sum(balance) >= 1000;


select b_avg.branch_city, b_avg.avg_balance 
from (select branch_city, avg(balance) as avg_balance 
      from account natural join branch
      group by branch_city) b_avg, 
      (select branch_city, sum(balance) as total_balance 
      from account natural join branch
      group by branch_city) b_total
where b_avg.branch_city = b_total.branch_city
      and b_total.total_balance >= 1000;




--4

select branch_city, avg(amount) as avg_loan
from loan natural join branch
group by branch_city
having avg(amount) >= 1500;


select l_avg.branch_city, l_avg.avg_loan
from (select branch_city, avg(amount) as avg_loan
     from loan natural join branch
     group by branch_city) l_avg
where l_avg.avg_loan >= 1500;


--5

select customer_name, customer_city, customer_street
from customer natural join depositor natural join account
where balance = (select max(balance) from account);

select customer_name, customer_city, customer_street
from customer natural join depositor natural join account
where balance >= All (select balance from account);


--6

select customer_name, customer_city, customer_street
from customer natural join borrower natural join loan
where amount = (select min(amount) from loan);

select customer_name, customer_city, customer_street
from customer natural join borrower natural join loan
where amount <= All(select amount from loan);


--7 


select branch_name, branch_city from branch
where branch_name in (select distinct branch_name 
		      from account natural join 
		           branch natural join loan);


select distinct branch_name, branch_city from branch b
where exists (select branch_name 
		      from account natural join 
		           branch natural join loan
		      where b.branch_name = branch_name);


--8



select distinct customer_name, customer_city
from customer natural join depositor
where customer_name not in (select distinct customer_name
			    from customer natural join borrower);

select distinct customer_name, customer_city
from customer natural join depositor 
where not exists (select customer_name
		  from customer natural join borrower l
		  where a.customer_name = l.customer_name);



select distinct customer_name, customer_city
from (select * from customer natural join depositor) acc_list
where not exists (select customer_name from
		          (select * from customer natural join borrower) loan_list
	 	    where acc_list.customer_name = loan_list.customer_name);


–9

with branch_balance (branch_name, total_balance) as
	(select branch_name, sum(balance) as total_balance
	 from branch natural join account
	 group by branch_name),
	avg_balance(avg_of_total) as 
	 (select avg(total_balance) from branch_balance)
select b.branch_name
from branch_balance b, avg_balance a
where b.total_balance > a.avg_of_total;


select temp1.branch_name from
(select branch_name, sum(balance) as total_balance
      from branch natural join account
      group by branch_name) temp1
where temp1.total_balance > (select avg(total_balance) as avg_balance from 
      			        (select branch_name, sum(balance) as total_balance
            			 from branch natural join account
            			  group by branch_name));
  


–10

select temp1.branch_name from
(select branch_name, sum(amount) as total_amount
      from loan natural join account
      group by branch_name) temp1
where temp1.total_amount > (select avg(total_amount) as avg_amount from 
      			        (select branch_name, sum(amount) as total_amount
            			 from loan natural join account
            			 group by branch_name));

with total_amount (branch_name, total_amount) as 
		   (select branch_name, sum(amount) as total_amount
		   from loan natural join account
		   group by branch_name), 
		  avg_amount (avg_of_all) as 
		   (select avg(total_amount) as avg_loan_taken
		   from total_amount)
select t.branch_name
from total_amount t, avg_amount a
where t.total_amount > a.avg_of_all;






