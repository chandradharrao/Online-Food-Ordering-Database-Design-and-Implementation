-- for each hotel retrive number of orders (complexQueries.sql)
select ra1.name,T.num_orders
from (select ra.id,COUNT(*) as num_orders
    from restaurant_admin ra
    inner JOIN order_details as o
    on o.restaurant_id=ra.id
    GROUP BY ra.id) as T
inner JOIN restaurant_admin ra1
on T.id=ra1.id;

-- dishes whose list price is equal to the highest list price of the dish within the same category (complexQueries.sql)
select d.dish_name,d.price
from dish d
where d.price in (
    select MAX(d1.price)
    from dish d1
    where d1.category_id=d.category_id
    GROUP BY d1.category_id
);