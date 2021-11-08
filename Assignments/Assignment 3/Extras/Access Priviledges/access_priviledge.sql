-- CEO of the company can see almost everything except sensitive information

CREATE user ceo with password 'ceo';
GRANT SELECT on address,cooks,customer,dish,dish_category,employee_delivery_boys,order_contains,order_details,restaurant_admin,review to ceo;

-- Finance department should be only able to view and update order statistics in case of emergency
create user finance with password 'fin';
GRANT SELECT, update, delete, insert on order_details,order_contains,payment_reciept to finance;

-- Delivery boys manager head should be able to only see ,update and delete delivery boys info
create user manager with password 'manager';
GRANT select,update,delete on employee_delivery_boys to manager;

-- create view to show only restraunt name
create VIEW restraunt_interface as select name,id,address_id from restaurant_admin;

-- Marketing user should be able to only read dish_category,dish,address and restraunt name to make offers
create user marketing with password 'marketing';
GRANT select on dish,dish_category,address,restraunt_interface to marketing;

-- Connect to foodsystem database and execute below command for each table to see which user has what access priviledge
select grantee,privilege_type FROM information_schema.role_table_grants where table_name='address';