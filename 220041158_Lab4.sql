--vehicule table 

CREATE TABLE vehicle(
vehicle_id INT PRIMARY KEY,
model VARCHAR(50),
type VARCHAR(20),
horsepower INT ,
torque INT,
weight INT,
speed INT
);


-- owner table 

CREATE TABLE owner (
owner_id INT PRIMARY KEY,
first_name VARCHAR(30),
last_name VARCHAR(30),
city VARCHAR(30)
);


--vehicule

INSERT INTO vehicle VALUES (1, 'Toyota Corolla', 'Sedan', 132, 128, 2800, 112);
INSERT INTO vehicle VALUES (2, 'Honda Civic', 'Sedan', 158, 138, 2760, 125);
INSERT INTO vehicle VALUES (3, 'Ford Fusion', 'Sedan', 175, 175, 3431, 125);
INSERT INTO vehicle VALUES (4, 'Ford Mustang', 'Sports', 310, 350, 3532, 155);
INSERT INTO vehicle VALUES (5, 'Chevrolet Camaro', 'Sports', 275, 295, 3354, 155);
INSERT INTO vehicle VALUES (6, 'Dodge Challenger', 'Sports', 305, 268, 3894, 155);
INSERT INTO vehicle VALUES (7, 'Honda CR-V', 'SUV', 190, 179, 3337, 112);
INSERT INTO vehicle VALUES (8, 'Toyota RAV4', 'SUV', 203, 184, 3370, 112);
INSERT INTO vehicle VALUES (9, 'Ford Explorer', 'SUV', 203, 310, 4345, 112);
INSERT INTO vehicle VALUES (10, 'Tesla Model 3', 'Electric', 283, 307, 3554, 112);
INSERT INTO vehicle VALUES (11, 'Tesla Model S', 'Electric', 762, 723, 4647, 155);



--owner

INSERT INTO owner VALUES(1, 'John', 'Smith', 'New York');
INSERT INTO owner VALUES(2, 'Sarah', 'johnson', 'Los Angeles');
INSERT INTO owner VALUES(3, 'Micheal', 'Williams', 'Chicago');
INSERT INTO owner VALUES(4, 'Emily', 'Brown', 'New York');
INSERT INTO owner VALUES(5, 'David', 'Jones', 'Houston');



-- onwner_vehicle
CREATE TABLE owner_vehicle (
ownner_id INT,
vehicle_id INT
);


INSERT INTO owner_vehicle  VALUES (1,4);
INSERT INTO owner_vehicle  VALUES (1,5);
INSERT INTO owner_vehicle  VALUES (1,7);
INSERT INTO owner_vehicle  VALUES (1,10);
INSERT INTO owner_vehicle  VALUES (2,8);
INSERT INTO owner_vehicle  VALUES (2,9);
INSERT INTO owner_vehicle  VALUES (3,4);
INSERT INTO owner_vehicle  VALUES (4,1);
INSERT INTO owner_vehicle  VALUES (4,5);
INSERT INTO owner_vehicle  VALUES (6,8);
INSERT INTO owner_vehicle  VALUES (7,4);
INSERT INTO owner_vehicle  VALUES (8,5);



-- 1

--2
SELECT AVG(horsepower)
FROM vehicle ;

--3

SELECT type, AVG(horsepower) AS avg
FROM vehicle 
GROUP BY type 
ORDER BY avg DESC
WHERE ROW= 1;




--4

SELECT type , COUNT(*) AS number_vehicle  
FROM vehicle
GROUP BY type  
ORDER BY number_vehicle  DESC;

--5

SELECT model 
FROM vehicle 
WHERE weight > (SELECT AVG(weight) FROM vehicle);

--6
SELECT 







