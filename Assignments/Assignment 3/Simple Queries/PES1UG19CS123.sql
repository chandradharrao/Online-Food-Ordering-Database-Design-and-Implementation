-- Retrieve the names of all users who have given 5 stars for a particular hotel (complexQueries.sql)
select cust.first_name
from customer cust
inner join review r 
on r.cust_id=cust.cust_id
where r.stars=5;