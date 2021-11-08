-- 1 list all available delivery boys
select emp_id, emp_name
from employee_delivery_boys
where status = 't';

-- 2 List all dishes with price greater than or equal to 50
select dish_id,dish_name,description, price
from Dish
where price >= 25;

-- 3 List of restaurant names who have rating greater than or equal to  3 stars
select r.name
from Restaurant_admin as r
where id in ( select restaurant_id from Review where stars >=3 )

-- 4 List all restaurants based on their zipcode
select a.zip_code, rest.name
from restaurant_admin as rest
inner join address as a
on a.id = rest.id

-- 5 List all dishes available in the restaurants
select d.dish_name as dish, d.description as description, d.price as cost, dc.cat_name as category
from dish as d, dish_category as dc 
where d.category_id = dc.category_id;

-- 6 List dishes based on their category
select d.dish_name, dc.cat_name
from dish as d
inner join dish_category as dc 
on d.category_id = dc.category_id
order by dc.cat_name;