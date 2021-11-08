-- 1 get total dishes sold by each restaurant
select rest.name, sum(q.dish_count) as total_dish_sold
from restaurant_admin as rest
inner join (
    select restaurant_id as rid, dish_id, count(*) as dish_count
    from order_contains
    group by dish_id, restaurant_id
) as q on q.rid = rest.id
group by rest.name;

-- 2 sort & list restaurants based on average ratings
select rest.name, r.avg_review
from (
    select restaurant_id, avg(stars) as avg_review
    from review
    group by restaurant_id
) as r
join restaurant_admin as rest
on rest.id = r.restaurant_id
order by r.avg_review desc;

-- 3 Retrieve the names of all users who have given 5 stars for a particular hotel 
select cust.first_name
from customer cust
inner join review r 
on r.cust_id=cust.cust_id
where r.stars=5;

-- 4 for each hotel retrive number of orders
select ra1.name,T.num_orders
from (select ra.id,COUNT(*) as num_orders
    from restaurant_admin ra
    inner JOIN order_details as o
    on o.restaurant_id=ra.id
    GROUP BY ra.id) as T
inner JOIN restaurant_admin ra1
on T.id=ra1.id;

-- 5 dishes whose list price is equal to the highest list price of the dish within the same category
select d.dish_name,d.price
from dish d
where d.price in (
    select MAX(d1.price)
    from dish d1
    where d1.category_id=d.category_id
    GROUP BY d1.category_id
);

-- 6 List of all customer names who ordered between a certain date .
select first_name,last_name 
from customer 
where cust_id in (
    select cust_id 
	from order_details 
	where transaction_id in (
        select p.transaction_id 
		from payment_reciept as p 
		where date_time between '2002-12-13' and '2004-08-26'
    )
);

-- 7 List hotels in the same city / zipcode as that of user
-- create userXaddress TABLE 
-- create hotelXaddress TABLE 
select UA.first_name,RA.name
FROM (
    select c.first_name,a.zip_code
    from customer c
    inner JOIN address a
    on c.address_id=a.id
) as UA
inner join (
    select r.name,a.zip_code
    from restaurant_Admin r
    inner JOIN address a
    on r.address_id=a.id
) as RA
on UA.zip_code=RA.zip_code
where UA.first_name='ms';

-- 8 List maximum spending user
select MAX(T.money_spent) as max_spent
from customer c
inner JOIN (
    select u.cust_id,SUM(o.total_amount) as money_spent
    from customer u
    inner join order_details o
    on o.cust_id=u.cust_id
    GROUP BY u.cust_id
) as T  
on c.cust_id=T.cust_id;

-- 9 Retrieve the max number of reviews written to any hotel
selectMAX(T.total_reviews)
from restaurant_admin r
inner JOIN (
    select o.restaurant_id as res_id,COUNT(*) as total_reviews
    from review o
    GROUP BY o.restaurant_id
) as T
on T.res_id = r.id;