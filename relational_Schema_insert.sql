\c foodsystem
INSERT INTO
	Address (street_num,zip_code,building_num)
VALUES
	(4,560061,12),
	(7,560072,82),
	(1,560022,93),
	(6,560036,02),
	(1,560022,95),
	(4,560061,13),
	(10,560033,45),
	(7,560043,47),
	(9,560038,22);
INSERT INTO
	Customer (passkey,email_id,phone_num,last_name,first_name,address_id)
VALUES
	('password1','dhoni@gmail.com','1234567891','dhoni','ms',1),
	('pass2','watson@yahoo.com','1987654321','shane','watson',2),
	('pass3','rahul@hptmail.com','6541237891','rahul','dravid',3),
	('pass4','smriti@gmail.com','4312561987','smriti','mand',4),
	('pass4','yohan@rollsroyce.com','9738971585','yohan','blake',5);
INSERT INTO
	Restaurant_admin (name,passkey,email_id,bank_number,address_id)
VALUES
	('Pizza Hut','key1','stephan@gmail.com','t3gcg594ec',6),
	('Dominoes','key2','warne@yahoo.com','1ylv4a6msq',7),
	('Shri Upahar','key3','moody@gmail.com','7pyyslu06n',8),
	('New Darshini Veg','key4','kumble@yahoo.com','w21uimvnzt',9);
INSERT INTO
	Employee_delivery_boys (status,emp_name)
VALUES
	(false,'Ramesh'),
	(true,'Suresh'),
	(true,'Mukesh'),
	(false,'Sitesh'),
	(true,'Amit');
INSERT INTO
	Credit_card (card_number, cust_id)
VALUES
	('7036168047848018',1),
	('8869885781886543',2),
	('7445899631786909',3),
	('1285141157637826',4),
	('5650644677784290',5);
INSERT INTO
	Dish_category (cat_name)
VALUES
	('Starter'),
	('Dessert'),
	('Apetizers'),
	('Mid Course'),
	('Breakfast'),
	('Fast Food'),
	('Meal');
INSERT INTO
	Dish (dish_id,dish_name,description,price,category_id)
VALUES
	(1,'Pizza','bread filled with cheese and vegies',120,7),
	(2,'Idly','a type of savoury rice cake',30,6),
	(3,'Breadsticks','soft bread dipped with mayo',60,6),
	(4,'Dosa','a thin pancake',45,3),
	(5,'Ice Cream','A sweet and creamy frozen food',30,3);
INSERT INTO
	Cooks (dish_id,restaurant_id)
VALUES
	(1,1),
	(2,4),
	(1,2),
	(3,2),
	(3,1),
	(4,4),
	(5,1),
	(2,3);
INSERT INTO
	Payment_reciept (date_time,restaurant_id)
VALUES
	('2002-12-13',1),
	('2003-03-15',4),
	('2004-08-26',2),
	('2005-11-19',2),
	('2006-06-01',3);
INSERT INTO
	Order_details (total_amount, status, transaction_id, emp_id, cust_id, restaurant_id)
VALUES
	(1250.00, true, 1, 1, 1, 2),
	(420.69, false, 2, 2, 2, 3),
	(543.21, true, 3, 3, 3, 4),
	(1200.00, false, 4, 4, 4, 1 ),
	(382.21, true, 5, 5, 5, 2);
INSERT INTO
	Review (stars,cust_id,restaurant_id,order_id)
VALUES
	(2,1,4,2),
	(5,2,1,3),
	(5,4,3,2),
	(4,3,1,3),
	(3,2,2,4);
INSERT INTO
	Order_contains (order_id, dish_id, restaurant_id)
VALUES
	(1, 2, 4),
	(2, 1, 2),
	(3, 3, 2),
	(4, 2, 4),
	(5, 4, 4);
