# SQL configs
SET SQL_MODE ='IGNORE_SPACE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

# create database and use it
CREATE DATABASE IF NOT EXISTS ecommjava;
USE ecommjava;

# create the category table
CREATE TABLE IF NOT EXISTS CATEGORY(
category_id int unique key not null auto_increment primary key,
name        varchar(255) null
);

# insert default categories
INSERT INTO CATEGORY(name) VALUES ('Fruits'),
                                  ('Vegetables'),
                                  ('Meat'),
                                  ('Fish'),
                                  ('Dairy'),
                                  ('Bakery'),
                                  ('Drinks'),
                                  ('Sweets'),
                                  ('Other');

# create the customer table
CREATE TABLE IF NOT EXISTS CUSTOMER(
id       int unique key not null auto_increment primary key,
address  varchar(255) null,
email    varchar(255) null,
password varchar(255) null,
role     varchar(255) null,
username varchar(255) null,
UNIQUE (username)
);

# insert default customers
INSERT INTO CUSTOMER(address, email, password, role, username) VALUES
                                                                   ('123, Albany Street', 'admin@nyan.cat', '123', 'ROLE_ADMIN', 'admin'),
                                                                   ('765, 5th Avenue', 'lisa@gmail.com', '765', 'ROLE_NORMAL', 'lisa');

# create the product table with TEXT field for image URL (to prevent data truncation)
CREATE TABLE IF NOT EXISTS PRODUCT(
product_id  int unique key not null auto_increment primary key,
description varchar(255) null,
image       TEXT null, -- Changed from varchar(255) to TEXT
name        varchar(255) null,
price       int null,
quantity    int null,
weight      int null,
category_id int null,
customer_id int null
);

# insert default products
INSERT INTO PRODUCT(description, image, name, price, quantity, weight, category_id) VALUES
                                                                                        ('Fresh and juicy', 'https://freepngimg.com/save/9557-apple-fruit-transparent/744x744', 'Apple', 3, 40, 76, 1),
                                                                                        ('Woops! There goes the eggs...', 'https://www.nicepng.com/png/full/813-8132637_poiata-bunicii-cracked-egg.png', 'Cracked Eggs', 1, 90, 43, 9);

# create the cart table
CREATE TABLE IF NOT EXISTS CART(
id          int unique key not null auto_increment primary key,
customer_id int null,
is_checkout BOOLEAN DEFAULT false,
FOREIGN KEY (customer_id) REFERENCES CUSTOMER(id) ON DELETE CASCADE
);

# create the cart_items table for many-to-many relationship between carts and products
CREATE TABLE IF NOT EXISTS CART_ITEMS(
id          int unique key not null auto_increment primary key,
cart_id     int not null,
product_id  int not null,
quantity    int default 1,
FOREIGN KEY (cart_id) REFERENCES CART(id) ON DELETE CASCADE,
FOREIGN KEY (product_id) REFERENCES PRODUCT(product_id) ON DELETE CASCADE
);

# create the orders table
CREATE TABLE IF NOT EXISTS ORDERS(
order_id    int unique key not null auto_increment primary key,
customer_id int not null,
order_date  TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
total_price decimal(10,2) not null,
status      varchar(50) DEFAULT 'Pending',
shipping_address varchar(255) not null,
payment_method varchar(50) DEFAULT 'Credit Card',
FOREIGN KEY (customer_id) REFERENCES CUSTOMER(id) ON DELETE CASCADE
);

# create the order_items table
CREATE TABLE IF NOT EXISTS ORDER_ITEMS(
id          int unique key not null auto_increment primary key,
order_id    int not null,
product_id  int not null,
quantity    int not null,
price       decimal(10,2) not null,
FOREIGN KEY (order_id) REFERENCES ORDERS(order_id) ON DELETE CASCADE,
FOREIGN KEY (product_id) REFERENCES PRODUCT(product_id) ON DELETE CASCADE
);

# create indexes
CREATE INDEX FK7u438kvwr308xcwr4wbx36uiw
    ON PRODUCT (category_id);

CREATE INDEX FKt23apo8r9s2hse1dkt95ig0w5
    ON PRODUCT (customer_id);