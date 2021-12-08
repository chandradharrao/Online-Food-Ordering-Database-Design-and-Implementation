select r.name, T.total_reviews
from (
    select restaurant_id as res_id,COUNT(*) as total_reviews
    from review 
    GROUP BY restaurant_id
) as T
join restaurant_admin as r
on T.res_id = r.id;

select best_sell.restaurant_id, dc.dish_id, best_sell.dish_sold_count
from (
    select dc.restaurant_id, max(dc.dish_count) as dish_sold_count
    from ( select restaurant_id, dish_id, count(*) as dish_count
    from order_contains
    group by dish_id, restaurant_id
    ) as dc
    group by dc.restaurant_id
) as best_sell
inner join ( select restaurant_id, dish_id, count(*) as dish_count
    from order_contains
    group by dish_id, restaurant_id
) as dc
on best_sell.dish_sold_count = dc.dish_count;

select rest.name, d.dish_name, max(dish_sold_count.dish_count)
from (
    select restaurant_id, dish_id, count(*) as dish_count
    from order_contains
    group by dish_id, restaurant_id
) as dish_sold_count
inner join dish as d
on dish_sold_count.dish_id = d.dish_id
inner join restaurant_admin as rest
on dish_sold_count.restaurant_id = rest.id;

select name, dish_name, max()



select r_count.id, dc.dish_id, r_count.max_dish_count
from(
    select dc.restaurant_id as id, max(dc.dish_count) as max_dish_count
    from ( select restaurant_id, dish_id, count(*) as dish_count
    from order_contains
    group by dish_id, restaurant_id
    ) as dc
    group by dc.restaurant_id
) as r_count
join (
    select restaurant_id, dish_id, count(*) as dish_count
    from order_contains
    group by dish_id, restaurant_id
) as dc
on r_count.max_dish_count = dc.dish_count;