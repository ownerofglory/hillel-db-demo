-- show databases;
-- use db;
-- show tables;
-- CREATE DATABASE webstore; 
-- SHOW DATABASES;
-- USE webstore;
-- customer, product, order
--  customer: name, email, age
-- CREATE TABLE customer (
-- 	name VARCHAR(64),-- variable lentgh character
-- 	email VARCHAR(128),
-- 	age INT
-- );
-- show tables;
-- DESCRIBE customer;
--  SHOW CREATE TABLE customer;
-- INSERT INTO customer 
-- VALUES ("John Doe", "jd@mail.com", 34);

SELECT * FROM customer;

-- describe customer;

-- INSERT INTO customer (name, email)
-- VALUES ("Ivan Petrnko", "ip@mail.com");
INSERT INTO customer (email, age, name)
VALUES ("ai@mail.com", 23, "Anna Ivanchenko");

-- TRUNCATE customer;
-- DROP TABLE customer;
-- show tables;
CREATE TABLE customer (
	name VARCHAR(64), -- string 
	email VARCHAR(128),
	birth_date DATE
);

DESCRIBE customer;


-- CREATE TABLE `customer` (
--   `name` varchar(64) DEFAULT NULL,
--   `email` varchar(128) DEFAULT NULL,
--   `age` int(11) DEFAULT NULL
-- ) ENGINE=InnoDB DEFAULT CHARSET=latin1

