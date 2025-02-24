--1 

CREATE TABLE RESTAURANT( 
rest_id INT PRIMARY KEY,
name VARCHAR(50), 
city VARCHAR(30),
cuisine VARCHAR(30)
);



CREATE TABLE DISH(
dish_id INT PRIMARY KEY,
name VARCHAR(50),
cuisine VARCHAR(30),
price DECIMAL(5,2),
taste VARCHAR(20),
rest_id INT,
CONSTRAINT FK_DISH FOREIGN KEY (rest_id)
REFERENCES RESTAURANT(rest_id)
);


CREATE TABLE CUSTOMER(
cust_id INT PRIMARY KEY,
first_name VARCHAR(30),
last_name VARCHAR(30),
city VARCHAR(30)
);



-- RESTAURANT

INSERT INTO RESTAURANT VALUES (1, 'Bella Italia', 'New York', 'Italian');
INSERT INTO RESTAURANT VALUES (2, 'Dragon Palace', 'San Francisco', 'Chinese');
INSERT INTO RESTAURANT VALUES (3, 'Spice Route', 'Chicago', 'Indian');
INSERT INTO RESTAURANT VALUES (4, 'Sushi World', 'Los Angeles', 'Japanese');
INSERT INTO RESTAURANT VALUES (5, 'Taco Fiesta', 'Houston', 'Mexican');


--  DISH

INSERT INTO DISH VALUES (1, 'Margherita Pizza', 'Italian', 12.99, 'Savory', 1);
INSERT INTO DISH VALUES (2, 'Spaghetti Carbonara', 'Italian', 14.99, 'Savory', 1);
INSERT INTO DISH VALUES (3, 'Sweet and Sour Pork', 'Chinese', 11.99, 'Sweet', 2);
INSERT INTO DISH VALUES (4, 'Kung Pao Chicken', 'Chinese', 14.99, 'Spicy', 2);
INSERT INTO DISH VALUES (5, 'Butter Chicken', 'Indian', 13.50, 'Spicy', 3);
INSERT INTO DISH VALUES (6, 'Tandoori Chicken', 'Indian', 14.00, 'Spicy', 3);
INSERT INTO DISH VALUES (7, 'California Roll', 'Japanese', 8.99, 'Savory', 4);
INSERT INTO DISH VALUES (8, 'Salmon Sashimi', 'Japanese', 15.99, 'Savory', 4);
INSERT INTO DISH VALUES (9, 'Chicken Tacos', 'Mexican', 9.99, 'Spicy', 5);
INSERT INTO DISH VALUES (10, 'Beef Burrito', 'Mexican', 11.50, 'Spicy', 5);


-- CUSTOMER

INSERT INTO CUSTOMER VALUES (1, 'John', 'Smith', 'New York');
INSERT INTO CUSTOMER VALUES (2, 'Mary', 'Johnson', 'Los Angeles');
INSERT INTO CUSTOMER VALUES (3, 'Robert', 'Brown', 'Chicago');
INSERT INTO CUSTOMER VALUES (4, 'Linda', 'Davis', 'Houston'); 
INSERT INTO CUSTOMER VALUES (5, 'Michael', 'Miller', 'Phoenix');


--2 

SELECT DISTINCT cuisine FROM DISH;

--3

SELECT * FROM DISH WHERE price BETWEEN 10 AND 15;

--4
SELECT * FROM DISH WHERE name LIKE 'Chicken%';

--5 

SELECT * FROM DISH WHERE name LIKE '%Roll%';

--6
SELECT * FROM DISH WHERE name LIKE '___';

--7

SELECT first_name || '' || last_name AS full_name, city FROM CUSTOMER;

--8

SELECT * FROM DISH ORDER BY cuisine ASC, price DESC;

--9

CREATE TABLE CUSTOMERS_DISH(
cust_id INT,
dish_id INT,
order_date DATE
);


--10

ALTER TABLE CUSTOMER_DISH
ADD CONSTRAINT fk_cust FOREIGN KEY (cust_id) REFERENCES CUSTOMER(cust_id),
ADD CONSTRAINT fk_dish FOREIGN KEY (dish_id) REFERENCES DISH(dish_id);




