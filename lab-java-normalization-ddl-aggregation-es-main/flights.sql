USE labs_sql;

DROP TABLE IF EXISTS booking;
DROP TABLE IF EXISTS flights;
DROP TABLE IF EXISTS aircrafts;
DROP TABLE IF EXISTS customers;

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR (255) NOT NULL,
    customer_status VARCHAR (20),
    total_mileage INT
);

CREATE TABLE aircrafts (
    aircraft_id INT PRIMARY KEY,
    model VARCHAR(50) NOT NULL,
    total_seats INT NOT NULL
);

CREATE TABLE flights (
    flight_id INT PRIMARY KEY NOT NULL,
    flight_number VARCHAR (10) NOT NULL,
    aircraft_id INT NOT NULL,
    mileage INT NOT NULL,
    FOREIGN KEY (aircraft_id) REFERENCES aircrafts (aircraft_id)
);

CREATE TABLE bookings(
    booking_id INT PRIMARY KEY,
    customer_id INT NOT NULL,
    flight_id INT NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES customers (customer_id),
    FOREIGN KEY (flight_id) REFERENCES flights (flight_id)
);

INSERT INTO customers (customer_id, customer_name, customer_status, total_mileage)
VALUES
    (1, 'Agustine Riviera', 'Silver', 115235),
    (2, 'Alaina Sepulvida', 'None', 6008),
    (3, 'Tom Jones', 'Gold', 205767),
    (4, 'Sam Rio', 'None', 2653),
    (5, 'Jessica James', 'Silver', 127656),
    (6, 'Ana Janco', 'Silver', 136773),
    (7, 'Jennifer Cortez', 'Gold', 300582),
    (8, 'Christian Janco', 'Silver', 14642);


INSERT INTO aircrafts (aircraft_id, model, total_seats)
VALUES
    (1, 'Boeing 747', 400),
    (2, 'Airbus A330', 236),
    (3, 'Boeing 777', 264);

INSERT INTO flights (flight_id, flight_number, aircraft_id, mileage)
VALUES
    (1, 'DL143', 1, 135),
    (2, 'DL122', 2, 4370),
    (3, 'DL53', 3, 2078),
    (4, 'DL222', 3, 1765),
    (5, 'DL37', 1, 531);

INSERT INTO bookings (booking_id, customer_id, flight_id)
VALUES
    (1, 1, 1),
    (2, 1, 2),
    (3, 2, 2),
    (4, 1, 1),
    (5, 3, 2),
    (6, 3, 3),
    (7, 1, 1),
    (8, 4, 1),
    (9, 1, 1),
    (10, 3, 4),
    (11, 5, 1),
    (12, 4, 1),
    (13, 6, 4),
    (14, 7, 4),
    (15, 5, 2),
    (16, 4, 5),
    (17, 8, 4);

SHOW TABLES;

#Ejercicio 3

SELECT COUNT(DISTINCT flight_number) AS total_flights
FROM flights;

SELECT AVG(mileage) AS average_distance
FROM flights;

SELECT AVG(total_seats) AS avg_seats
FROM aircrafts;

SELECT customer_status, AVG(total_mileage) AS avg_mileage
FROM customers
GROUP BY customer_status;

SELECT customer_status, MAX(total_mileage) AS max_mileage
FROM customers
GROUP BY customer_status;

SELECT COUNT(*) AS boeing_aircrafts
FROM aircrafts
WHERE model LIKE '%Boeing%';

SELECT *
FROM flights
WHERE mileage BETWEEN 300 AND 2000;

SELECT c.customer_status, AVG(f.mileage) AS avg_reserved_mileage
FROM bookings b
         JOIN customers c ON b.customer_id = c.customer_id
         JOIN flights f ON b.flight_id = f.flight_id
GROUP BY c.customer_status;

SELECT a.model, COUNT(*) AS total_bookings
FROM bookings b
         JOIN customers c ON b.customer_id = c.customer_id
         JOIN flights f ON b.flight_id = f.flight_id
         JOIN aircrafts a ON f.aircraft_id = a.aircraft_id
WHERE c.customer_status = 'Gold'
GROUP BY a.model
ORDER BY total_bookings DESC
LIMIT 1;

