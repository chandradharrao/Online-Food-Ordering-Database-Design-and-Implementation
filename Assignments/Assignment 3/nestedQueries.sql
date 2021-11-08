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

-- 3 List of all customer names who ordered between a certain date .
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

-- 4 List maximum spending user
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