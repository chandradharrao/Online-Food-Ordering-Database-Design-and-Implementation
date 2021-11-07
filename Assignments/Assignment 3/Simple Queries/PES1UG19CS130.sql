-- List all dishes available in the restaurant
select d.dish_name as dish, d.description as description, d.price as cost, dc.cat_name as category
from dish as d, dish_category as dc 
where d.category_id == dc.category_id;

-- list the top 5 dishes sold by restaurant



-- list the bestsellers of the restaurant limit 3 (views) change code for each restaurant

-- sort & list restaurants based on average ratings
select rest.name, r.avg_review
from (
    select restaurant_id, avg(stars) as avg_review
    from review
    group by restaurant_id
) as r
join restaurant_admin as rest
on rest.id = r.restaurant_id
order by r.avg_review desc;

-- list all available delivery boys
select emp_id, emp_name
from employee_delivery_boys
where status = 't';

-- order dishes in a restaurant based on category (Views)
select d.dish_name, dc.cat_name
from dish as d
inner join dish_category as dc 
on d.category_id = dc.category_id
order by dc.cat_name;

