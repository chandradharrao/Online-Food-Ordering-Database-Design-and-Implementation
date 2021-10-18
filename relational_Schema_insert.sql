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
	(5,1);
