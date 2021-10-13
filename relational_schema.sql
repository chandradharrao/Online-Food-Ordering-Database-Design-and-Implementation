DROP DATABASE foodsystem;
CREATE DATABASE foodsystem;

\c foodsystem

CREATE TABLE Address
(
  street_num CHAR(2) NOT NULL,
  zip_code CHAR(6) NOT NULL,
  building_num CHAR(2) NOT NULL,
  id CHAR(5) NOT NULL,
  PRIMARY KEY (id)
); 

CREATE TABLE Customer
(
  cust_id CHAR(5) NOT NULL,
  passkey VARCHAR(20) NOT NULL,
  email_id VARCHAR(50) NOT NULL,
  phone_num CHAR(10) NOT NULL,
  last_name VARCHAR(15) NOT NULL,
  first_name VARCHAR(15) NOT NULL,
  address_id CHAR(5) NOT NULL,
  PRIMARY KEY (cust_id),
  FOREIGN KEY (address_id) REFERENCES Address(id)
);

CREATE TABLE Menu
(
  menu_id CHAR(5) NOT NULL,
  PRIMARY KEY (menu_id)
);

CREATE TABLE Restaurant_admin
(
  name VARCHAR(20) NOT NULL,
  id CHAR(5) NOT NULL,
  passkey VARCHAR(20) NOT NULL,
  email_id VARCHAR(50) NOT NULL,
  bank_number CHAR(10) NOT NULL,
  address_id CHAR(5) NOT NULL,
  menu_id CHAR(5) NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (address_id) REFERENCES Address(id),
  FOREIGN KEY (menu_id) REFERENCES Menu(menu_id),
  UNIQUE (bank_number)
);

CREATE TABLE Employee_delivery_boys
(
  emp_id CHAR(5) NOT NULL,
  status BOOLEAN NOT NULL,
  emp_name VARCHAR(20) NOT NULL,
  PRIMARY KEY (emp_id)
);

CREATE TABLE Credit_card
(
  card_number CHAR(16) NOT NULL,
  cust_id CHAR(5) NOT NULL,
  PRIMARY KEY (card_number, cust_id),
  FOREIGN KEY (cust_id) REFERENCES Customer(cust_id)
);

CREATE TABLE Dish_category
(
  category_id INT NOT NULL,
  cat_name VARCHAR(15) NOT NULL,
  PRIMARY KEY (category_id)
);

CREATE TABLE Dish
(
  dish_name VARCHAR(15) NOT NULL,
  description VARCHAR(100),
  dish_id CHAR(5) NOT NULL,
  price FLOAT NOT NULL,
  menu_id CHAR(5) NOT NULL,
  restaurant_id CHAR(5) NOT NULL,
  category_id INT,
  PRIMARY KEY (dish_id),
  FOREIGN KEY (menu_id) REFERENCES Menu(menu_id),
  FOREIGN KEY (restaurant_id) REFERENCES Restaurant_admin(id),
  FOREIGN KEY (category_id) REFERENCES Dish_category(category_id)
);

CREATE TABLE Payment_reciept
(
  date_time DATE NOT NULL,
  transaction_id CHAR(5) NOT NULL,
  restaurant_id CHAR(5) NOT NULL,
  PRIMARY KEY (transaction_id),
  FOREIGN KEY (restaurant_id) REFERENCES Restaurant_admin(id)
);

CREATE TABLE Order_Item
(
  total_amount FLOAT NOT NULL,
  status BOOLEAN NOT NULL,
  order_id CHAR(5) NOT NULL,
  transaction_id CHAR(5) NOT NULL,
  emp_id CHAR(5) NOT NULL,
  cust_id CHAR(5) NOT NULL,
  restaurant_id CHAR(5) NOT NULL,
  PRIMARY KEY (order_id),
  FOREIGN KEY (transaction_id) REFERENCES Payment_reciept(transaction_id),
  FOREIGN KEY (emp_id) REFERENCES Employee_delivery_boys(emp_id),
  FOREIGN KEY (cust_id) REFERENCES Customer(cust_id),
  FOREIGN KEY (restaurant_id) REFERENCES Restaurant_admin(id)
);

CREATE TABLE Review
(
  stars INT NOT NULL CHECK (stars <= 5 AND stars >=1),
  id CHAR(5) NOT NULL,
  cust_id CHAR(5) NOT NULL,
  restaurant_id CHAR(5) NOT NULL,
  order_id CHAR(5) NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (cust_id) REFERENCES Customer(cust_id),
  FOREIGN KEY (restaurant_id) REFERENCES Restaurant_admin(id),
  FOREIGN KEY (order_id) REFERENCES Order_Item(order_id)
);

CREATE TABLE Order_contains
(
  dish_id CHAR(5) NOT NULL,
  order_id CHAR(5) NOT NULL,
  PRIMARY KEY (dish_id, order_id),
  FOREIGN KEY (dish_id) REFERENCES Dish(dish_id),
  FOREIGN KEY (order_id) REFERENCES Order_Item(order_id)
);
