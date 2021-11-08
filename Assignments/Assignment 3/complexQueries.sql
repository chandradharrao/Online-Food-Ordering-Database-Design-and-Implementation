-- 1 Retrieve the names of all users who have given 5 stars for a particular hotel 
select cust.first_name
from customer cust
inner join review r 
on r.cust_id=cust.cust_id
where r.stars=5;

-- 2 for each hotel retrive number of orders
select ra1.name,T.num_orders
from (select ra.id,COUNT(*) as num_orders
    from restaurant_admin ra
    inner JOIN order_details as o
    on o.restaurant_id=ra.id
    GROUP BY ra.id) as T
inner JOIN restaurant_admin ra1
on T.id=ra1.id;

-- 3 dishes whose list price is equal to the highest list price of the dish within the same category
select d.dish_name,d.price
from dish d
where d.price in (
    select MAX(d1.price)
    from dish d1
    where d1.category_id=d.category_id
    GROUP BY d1.category_id
);

-- 4 List hotels in the same city / zipcode as that of user
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

-- 5 Retrieve the max number of reviews written to any hotel
selectMAX(T.total_reviews)
from restaurant_admin r
inner JOIN (
    select o.restaurant_id as res_id,COUNT(*) as total_reviews
    from review o
    GROUP BY o.restaurant_id
) as T
on T.res_id = r.id;