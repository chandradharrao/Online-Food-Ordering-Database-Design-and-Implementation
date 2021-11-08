-- List hotels in the same city / zipcode as that of user (complexQueries.sql)
-- create userXaddress TABLE 
-- create hotelXaddress TABLE 
select UA.first_name,RA.name
FROM 

(select c.first_name,a.zip_code
from customer c
inner JOIN address a
on c.address_id=a.id) as UA

inner join

(select r.name,a.zip_code
from restaurant_Admin r
inner JOIN address a
on r.address_id=a.id) as RA

on UA.zip_code=RA.zip_code
where UA.first_name='ms';

-- List maximum spending user (complexQueries.sql)
select MAX(T.money_spent) as max_spent
from customer c
inner JOIN
(select u.cust_id,SUM(o.total_amount) as money_spent
    from customer u
    inner join order_details o
    on o.cust_id=u.cust_id
    GROUP BY u.cust_id
) as T  
    on c.cust_id=T.cust_id;

-- Retrieve the max number of reviews written to any hotel (complexQueries.sql)
selectMAX(T.total_reviews)
from restaurant_admin r
inner JOIN (
    select o.restaurant_id as res_id,COUNT(*) as total_reviews
    from review o
    GROUP BY o.restaurant_id
) as T
on T.res_id = r.id;
