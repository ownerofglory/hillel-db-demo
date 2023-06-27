show databases;
use db;
show tables;
CREATE DATABASE webstore; 
SHOW DATABASES;
USE webstore;
customer, product, order
 customer: name, email, age
CREATE TABLE customer (
	name VARCHAR(64),-- variable lentgh character
	email VARCHAR(128),
	age INT
);
show tables;
DESCRIBE customer;
 SHOW CREATE TABLE customer;
INSERT INTO customer 
VALUES ("John Doe", "jd@mail.com", 34);

SELECT * FROM customer;

describe customer;

INSERT INTO customer (name, email)
VALUES ("Ivan Petrnko", "ip@mail.com");

INSERT INTO customer (email, age, name)
VALUES ("ai@mail.com", 23, "Anna Ivanchenko");

TRUNCATE customer;
DROP TABLE customer;
show tables;
CREATE TABLE customer (
	name VARCHAR(64), -- string 
	email VARCHAR(128),
	birth_date DATE
);

DESCRIBE customer;


CREATE TABLE `customer` (
  `name` varchar(64) DEFAULT NULL,
  `email` varchar(128) DEFAULT NULL,
  `age` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1

SHOW CREATE TABLE webstore.customer ;
USE webstore;
SHOW CREATE TABLE customer;

SELECT * FROM customer;
-- identifiaction 
-- 
ALTER TABLE customer 
ADD COLUMN id INT;

INSERT INTO customer (id, name, email, birth_date)
VALUES(3, "Anna Muster", "am@mail.com", "1990-01-01");

DELETE FROM customer
WHERE name = "Anna Muster";

-- 

ALTER TABLE customer 
MODIFY COLUMN id INT PRIMARY KEY AUTO_INCREMENT;
Postgresql
ALTER TABLE customer 
MODIFY COLUMN id SERIAL PRIMARY KEY;

DESCRIBE customer;


INSERT INTO customer (name, email, birth_date)
VALUES("Anna Muster", "am@mail.com", "1990-01-01");


ALTER TABLE customer 
DROP COLUMN password;

ALTER TABLE customer 
ADD COLUMN password VARCHAR(256) DEFAULT "no-password";


UPDATE customer 
SET password = "default password"
-- 
CREATE TABLE t_order( -- ORDER 
	id INT PRIMARY KEY AUTO_INCREMENT,
	order_date DATETIME DEFAULT NOW(), -- current date time
	total_amount FLOAT DEFAULT 0, -- at least 0
	customer_id INT,
	CHECK(total_amount >= 0),
	FOREIGN KEY (customer_id) REFERENCES customer(id)
	ON DELETE SET NULL
);
-- 
describe t_order;
-- 
INSERT INTO t_order (total_amount, customer_id)
VALUES(200.0, 1),
(450.0, 1),
(1004.0, 2),
(599.99, 3);

SELECT * FROM t_order;
 
SELECT customer.*, t_order.* FROM customer
LEFT JOIN t_order 
ON customer.id = t_order.customer_id;
WHERE customer.id = 1;

CREATE TABLE cutomer_tax_info (
	id INT PRIMARY KEY AUTO_INCREMENT,
	tax_id VARCHAR(12),
	customer_id INT UNIQUE,
	expiration_date DATE DEFAULT "2030-01-01",
	CONSTRAINT fk_customer_id 
	FOREIGN KEY (customer_id) REFERENCES customer(id)
);
-- 
INSERT INTO cutomer_tax_info (tax_id, customer_id)
VALUE("i768768", 1),
("340879347", 2),
("6t97269", 3),
("35456456", 4);

SELECT c.id, c.name, ct.tax_id
FROM customer AS c
JOIN cutomer_tax_info AS ct
ON c.id = ct.customer_id;

CREATE TABLE product(
	id INT PRIMARY KEY AUTO_INCREMENT,
	name VARCHAR(100) NOT NULL,
	description TEXT,
	price FLOAT DEFAULT 0,
	image_url VARCHAR(1024),
	CHECK(price >= 0),
	CHECK(name <> "")
);

INSERT INTO product (name, description, price, image_url)
VALUES("T-Shirt-1", "About T-Shirt-1", 23.50, "http://img.com/t-shirt-1"),
("T-Shirt-2", "About T-Shirt-2", 54.50, "http://img.com/t-shirt-2"),
("Jacket-1", "About Jacket-1", 150, "http://img.com/jacket-1"),
("Jacket-2", "About Jacket-2", 540, "http://img.com/jacket-2");

SELECT * FROM product;

SELECT * FROM t_order;

CREATE TABLE order_item(
	id INT PRIMARY KEY AUTO_INCREMENT,
	order_id INT,
	product_id INT,
	FOREIGN KEY (order_id) REFERENCES t_order(id),
	FOREIGN KEY (product_id) REFERENCES product(id)
);

-- alternative option
CREATE TABLE order_item(
	order_id INT,
	product_id INT,
	PRIMARY KEY (order_id, product_id)
	FOREIGN KEY (order_id) REFERENCES t_order(id),
	FOREIGN KEY (product_id) REFERENCES product(id)
);

-- id|name     |description    |price|image_url               |
-- --+---------+---------------+-----+------------------------+
--  1|T-Shirt-1|About T-Shirt-1| 23.5|http://img.com/t-shirt-1|
--  2|T-Shirt-2|About T-Shirt-2| 54.5|http://img.com/t-shirt-2|
--  3|Jacket-1 |About Jacket-1 |150.0|http://img.com/jacket-1 |
--  4|Jacket-2 |About Jacket-2 |540.0|http://img.com/jacket-2 |


-- id|order_date         |total_amount|customer_id|
-- --+-------------------+------------+-----------+
--  1|2023-06-23 16:59:39|       200.0|          1|
--  2|2023-06-23 16:59:39|       450.0|          1|
--  3|2023-06-23 16:59:39|      1004.0|          2|
--  4|2023-06-23 16:59:39|      599.99|          3|

-- 
INSERT INTO order_item(order_id, product_id)
VALUES(1, 1), (1, 2), (1, 3), (1, 4),
(2, 3), (2, 2),
(3, 1),
(4, 4);
-- 

SELECT c.id, c.name, o.order_date, p.name, p.price
FROM customer AS c
LEFT JOIN t_order AS o ON c.id = o.customer_id
LEFT JOIN order_item AS oi ON o.id = oi.order_id
LEFT JOIN product AS p ON p.id = oi.product_id;
-- 
-- 
SELECT c.name, SUM(p.price) AS total_price
FROM customer AS c
LEFT JOIN t_order AS o ON c.id = o.customer_id
LEFT JOIN order_item AS oi ON o.id = oi.order_id
LEFT JOIN product AS p ON p.id = oi.product_id
GROUP BY c.id
HAVING total_price > 50
ORDER BY total_price ASC
LIMIT 10;
-- 


SELECT * FROM customer
WHERE name = "John Doe";

SELECT * FROM customer
WHERE id = 3;

CREATE INDEX customer_email_idx
ON customer(email);

SELECT * FROM customer 
WHERE email = "jd@mail.com"

-- SHOW CREATE TABLE t_order;

-- DELETE FROM customer WHERE id = 2
ALTER TABLE t_order 
DROP  FOREIGN KEY t_order_ibfk_1

ALTER TABLE t_order
ADD CONSTRAINT customer_id_fk 
FOREIGN KEY (customer_id)
REFERENCES customer(id)
ON DELETE SET NULL;

SHOW CREATE TABLE cutomer_tax_info ;

ALTER TABLE cutomer_tax_info 
DROP FOREIGN KEY fk_customer_id;

ALTER TABLE cutomer_tax_info 
ADD CONSTRAINT fk_customer_id 
FOREIGN KEY (customer_id)
REFERENCES customer(id)
ON DELETE CASCADE;

SELECT * FROM customer WHERE id = 2


DELETE FROM customer WHERE id = 2

(SELECT * FROM product WHERE price > 500)
UNION
(SELECT * FROM product WHERE price < 100);





-- 
GRANT ALL PRIVILEGES ON webstore.* 
TO 'user'@'%';
-- 
-- 
CREATE USER 'read-only-user'@'%'
IDENTIFIED BY 'password';

GRANT SELECT ON webstore.* 
TO 'read-only-user'@'%';


SHOW GRANTS FOR 'read-only-user'

CREATE USER 'john'@'%'
IDENTIFIED BY 'password';

GRANT ALL PRIVILEGES ON webstore.* 
TO 'john'@'%';

FLUSH PRIVILEGES;

SHOW GRANTS FOR 'john';

SET GLOBAL TRANSACTION ISOLATION LEVEL 
READ UNCOMMITTED;

-- transactions for USER 'user'
-- USE webstore;
-- 
-- -- start a transaction
-- BEGIN;
-- -- find customer
-- SELECT * FROM customer WHERE id = 3;
-- 
-- -- find product
-- SELECT * FROM product WHERE id = 4;
-- 
-- -- create an order
-- INSERT INTO t_order (total_amount, customer_id)
-- VALUES(540, 3);
-- 
-- SELECT * FROM t_order 
-- ORDER BY order_date  DESC
-- LIMIT 1;
-- 
-- -- add product to order
-- INSERT INTO order_item (order_id, product_id)
-- VALUES(6, 4);
-- 
-- COMMIT;
-- -- ROLLBACK;
-- 
-- SELECT * FROM t_order 
-- ORDER BY order_date  DESC

-- 
-- -- SELECT @@global.transaction_ISOLATION;
-- SET TRANSACTION ISOLATION LEVEL 
-- READ COMMITTED 

-- SET TRANSACTION ISOLATION LEVEL 
-- REPEATABLE READ;

SET TRANSACTION ISOLATION LEVEL 
SERIALIZABLE ;


BEGIN;
-- ADD PRODUCT
-- INSERT INTO product (name, description, image_url)
-- VALUES("Backpack-1", "Backpack-1",  "http://img.com/backpack-1");
-- 	
UPDATE product 
SET price = 120
WHERE id = 6;


SELECT * FROM product WHERE id = 6;
COMMIT
-- ROLLBACK

SELECT * FROM product WHERE id = 6;


-- transactions for USER 'john'
 SELECT * FROM customer;
--  SET TRANSACTION ISOLATION LEVEL
--      READ COMMITTED;

--  SET TRANSACTION ISOLATION LEVEL
--      REPEATABLE READ ;

SET TRANSACTION ISOLATION LEVEL
    SERIALIZABLE ;

BEGIN;

SELECT * FROM product WHERE id = 6;
UPDATE product
SET price = 150
WHERE id = 6;

COMMIT;

SELECT * FROM product WHERE id = 6;