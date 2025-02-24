-- 1

CREATE TABLE vehicle(
vehicle_id INT PRIMARY KEY,
model VARCHAR(50),
type VARCHAR(20),
horsepower INT ,
torque INT,
weight INT,
speed INT
);



CREATE TABLE owner (
owner_id INT PRIMARY KEY,
first_name VARCHAR(30),
last_name VARCHAR(30),
city VARCHAR(30)
);



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




INSERT INTO owner VALUES(1, 'John', 'Smith', 'New York');
INSERT INTO owner VALUES(2, 'Sarah', 'johnson', 'Los Angeles');
INSERT INTO owner VALUES(3, 'Micheal', 'Williams', 'Chicago');
INSERT INTO owner VALUES(4, 'Emily', 'Brown', 'New York');
INSERT INTO owner VALUES(5, 'David', 'Jones', 'Houston');



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




--2
SELECT AVG(horsepower) FROM vehicle ;


--3

SELECT type, AVG(horsepower) AS avg FROM vehicle GROUP BY type ORDER BY avg DESC WHERE ROW= 1;


--4

SELECT type , COUNT(*) AS number_vehicle FROM vehicle GROUP BY type ORDER BY number_vehicle  DESC WHERE ROW = 1;

--5

SELECT model FROM vehicle WHERE weight > (SELECT AVG(weight) FROM vehicle);

--6

SELECT DISTINCT o.first_name FROM owner o JOIN owner_vehicle ov ON o.owner_id = ov.owner_id JOIN vehicle v ON ov.vehicle_id = v.vehicle WHERE v.model LIKE  'Tesla%';

--7

SELECT O.first_name || ' ' || O.last_name || 'owns' || , V.model AS ownership_Info FROM owner O JOIN owner_vehicle OV ON OV.owner_id = O.owner_id JOIN vehicle V ON V.vehicle_id = OV.vehicle_id;


--8

SELECT AVG(torque) AS avgtorque FROM vehicle GROUP BY type HAVING AVG(torque) > 250;


--9 

SELECT O.city FROM owner O JOIN owner_vehicle OV ON OV.owner_id = O.owner_id JOIN vehicle V ON V.vehicle_id = OV.vehicle_id WHERE V.type IN ('Sedan ,Sports Car') GROUP BY O.city HAVING COUNT(V.vehicle_id) > 1;


--10

SELECT model , speed FROM vehicle WHERE model LIKE 'Ford%' ORDER BY speed DESC;

--11

SELECT O.first_name || ' ' || O.last_name AS Name FROM owner O JOIN owner_vehicle OV ON O.owner_id = OV.owner_id JOIN vehicle V ON V.vehicle_id = OV.vehicle_id WHERE V.speed = (SELECT MIN(speed) FROM vehicle);

--12

SELECT * FROM vehicle WHERE type = 'SUV' AND speed > ALL (SELECT speed FROM vehicle WHERE type = 'Sedan');

--13 

SELECT DISTINCT O.owner_id FROM owner O JOIN owner_vehicle OV ON O.owner_id = OV.owner_id JOIN vehicle V ON V.vehicle_id = OV.vehicle_id WHERE V.type = 'Electric' ;


--14 

SELECT V.model, O.first_name || ' ' || O.last_name AS owners FROM owner O JOIN owner_vehicle OV ON O.owner_id = OV.owner_id JOIN vehicle V ON V.vehicle_id = OV.vehicle_id GROUP BY V.model HAVING COUNT(O.owner_id) > 1;


--15 

SELECT V.model, O.first_name || ' ' || O.last_name AS owners FROM owner O JOIN owner_vehicle OV ON O.owner_id = OV.owner_id JOIN vehicle V ON V.vehicle_id = OV.vehicle_id WHERE V.speed = (SELECT MIN(speed) FROM vehicle WHERE type ='Sports');



