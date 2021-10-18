DROP DATABASE foodsystem;
CREATE DATABASE foodsystem;

\c foodsystem

CREATE TABLE Address
(
  street_num CHAR(2) NOT NULL,
  zip_code CHAR(6) NOT NULL,
  building_num INTEGER NOT NULL,
  id BIGSERIAL NOT NULL,
  PRIMARY KEY (id),
  UNIQUE (building_num)
); 

CREATE TABLE Customer
(
  cust_id BIGSERIAL NOT NULL,
  passkey VARCHAR(20) NOT NULL,
  email_id VARCHAR(50) NOT NULL,
  phone_num CHAR(10) NOT NULL,
  last_name VARCHAR(15) NOT NULL,
  first_name VARCHAR(15) NOT NULL,
  address_id INTEGER NOT NULL,
  PRIMARY KEY (cust_id),
  FOREIGN KEY (address_id) REFERENCES Address(id)
);


CREATE TABLE Restaurant_admin
(
  name VARCHAR(20) NOT NULL,
  id BIGSERIAL NOT NULL,
  passkey VARCHAR(20) NOT NULL,
  email_id VARCHAR(50) NOT NULL,
  bank_number CHAR(10) NOT NULL,
  address_id INTEGER NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (address_id) REFERENCES Address(id),
  UNIQUE (bank_number)
);

CREATE TABLE Employee_delivery_boys
(
  emp_id BIGSERIAL NOT NULL,
  status BOOLEAN NOT NULL,
  emp_name VARCHAR(20) NOT NULL,
  PRIMARY KEY (emp_id)
);

CREATE TABLE Credit_card
(
  card_number CHAR(16) NOT NULL,
  cust_id INTEGER NOT NULL,
  PRIMARY KEY (card_number, cust_id),
  FOREIGN KEY (cust_id) REFERENCES Customer(cust_id)
);

CREATE TABLE Dish_category
(
  category_id BIGSERIAL NOT NULL,
  cat_name VARCHAR(15) NOT NULL,
  PRIMARY KEY (category_id)
);

CREATE TABLE Dish
(
  dish_id BIGSERIAL NOT NULL,
  dish_name VARCHAR(15) NOT NULL,
  description VARCHAR(100) NOT NULL,
  price INT NOT NULL,
  category_id INT,
  PRIMARY KEY (dish_id),
  FOREIGN KEY (category_id) REFERENCES Dish_category(category_id)
);


CREATE TABLE Cooks
(
  restaurant_id INTEGER NOT NULL,
  dish_id INTEGER NOT NULL,
  PRIMARY KEY (restaurant_id, dish_id),
  FOREIGN KEY (restaurant_id) REFERENCES Restaurant_admin(id),
  FOREIGN KEY (dish_id) REFERENCES Dish(dish_id)
);

CREATE TABLE Payment_reciept
(
  date_time DATE NOT NULL,
  transaction_id BIGSERIAL NOT NULL,
  restaurant_id INTEGER NOT NULL,
  PRIMARY KEY (transaction_id),
  FOREIGN KEY (restaurant_id) REFERENCES Restaurant_admin(id)
);

CREATE TABLE Order_Details
(
  total_amount FLOAT NOT NULL,
  status BOOLEAN NOT NULL,
  order_id BIGSERIAL NOT NULL,
  transaction_id INTEGER NOT NULL,
  emp_id INTEGER NOT NULL,
  cust_id INTEGER NOT NULL,
  restaurant_id INTEGER NOT NULL,
  PRIMARY KEY (order_id),
  FOREIGN KEY (transaction_id) REFERENCES Payment_reciept(transaction_id),
  FOREIGN KEY (emp_id) REFERENCES Employee_delivery_boys(emp_id),
  FOREIGN KEY (cust_id) REFERENCES Customer(cust_id),
  FOREIGN KEY (restaurant_id) REFERENCES Restaurant_admin(id)
);

CREATE TABLE Review
(
  stars INT NOT NULL CHECK (stars <= 5 AND stars >=1),
  id BIGSERIAL NOT NULL,
  cust_id INTEGER NOT NULL,
  restaurant_id INTEGER NOT NULL,
  order_id INTEGER NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (cust_id) REFERENCES Customer(cust_id),
  FOREIGN KEY (restaurant_id) REFERENCES Restaurant_admin(id),
  FOREIGN KEY (order_id) REFERENCES Order_Details(order_id)
);

CREATE TABLE Order_contains
(
  order_id INTEGER NOT NULL,
  dish_id INTEGER NOT NULL,
  restaurant_id INTEGER NOT NULL,
  PRIMARY KEY (order_id),
  FOREIGN KEY (order_id) REFERENCES Order_Details(order_id),
  FOREIGN KEY (dish_id, restaurant_id) REFERENCES Cooks(dish_id, restaurant_id)
);

