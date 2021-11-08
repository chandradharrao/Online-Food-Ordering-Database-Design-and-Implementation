-- // List all dishes with price greater than or equal to 50
select dish_id,dish_name,description
from Dish
where price >= 25;

-- // List of restaurant names who have rating greater than or equal to  3 stars
select r.name
from Restaurant_admin as r
where id in ( select restaurant_id from Review where stars >=3 )

-- 2nd Method ***Check ONCE ERROR****

select r.name
from (select restaurant_id from review where stars >=3 ) as t1 join restaurant_admin as r on t1.id = r.id;


-- //List of all customer names who ordered between a certain date

select first_name,last_name 
from customer 
where cust_id in (select cust_id from order_details where transaction_id in (select p.transaction_id from payment_reciept as p where date_time between '2002-12-13' and '2004-08-26'));


