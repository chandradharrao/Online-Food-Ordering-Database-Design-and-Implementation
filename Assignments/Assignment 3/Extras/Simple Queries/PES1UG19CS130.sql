-- List all dishes available in the restaurant (simpleQueries.sql)
select d.dish_name as dish, d.description as description, d.price as cost, dc.cat_name as category
from dish as d, dish_category as dc 
where d.category_id == dc.category_id;

-- get total dishes sold by each restaurant (complexQueries.sql)
select rest.name, sum(q.dish_count) as total_dish_sold
from restaurant_admin as rest
inner join (
    select restaurant_id as rid, dish_id, count(*) as dish_count
    from order_contains
    group by dish_id, restaurant_id
) as q on q.rid = rest.id
group by rest.name;

-- sort & list restaurants based on average ratings (complexQueries.sql)
select rest.name, r.avg_review
from (
    select restaurant_id, avg(stars) as avg_review
    from review
    group by restaurant_id
) as r
join restaurant_admin as rest
on rest.id = r.restaurant_id
order by r.avg_review desc;

-- list all available delivery boys (simpleQueries.sql)
select emp_id, emp_name
from employee_delivery_boys
where status = 't';

-- list dishes based on their category (simpleQueries.sql)
select d.dish_name, dc.cat_name
from dish as d
inner join dish_category as dc 
on d.category_id = dc.category_id
order by dc.cat_name;

