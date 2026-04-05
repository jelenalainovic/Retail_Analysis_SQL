PRAGMA foreign_keys = ON;


-- Removing tables if they already exsist

DROP TABLE IF EXISTS order_line;
DROP TABLE IF EXISTS shipment_line;
DROP TABLE IF EXISTS shipment;
DROP TABLE IF EXISTS inventory;
DROP TABLE IF EXISTS color;
DROP TABLE IF EXISTS item;
DROP TABLE IF EXISTS category;
DROP TABLE IF EXISTS item_category;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS customer;


-- SQL to create all the tables

CREATE TABLE customer
(c_id INTEGER, 
c_last VARCHAR(30),
c_first VARCHAR(30),
c_mi CHAR(1),
c_birthdate DATE,
c_address VARCHAR(30),
c_city VARCHAR(30),
c_state CHAR(2),
c_zip VARCHAR(10),
c_dphone VARCHAR(10),
c_ephone VARCHAR(10),
c_userid VARCHAR(50),
c_password VARCHAR(15),
CONSTRAINT customer_c_id_pk PRIMARY KEY (c_id));

CREATE TABLE orders
(o_id INTEGER, 
o_date DATE,
o_pmtmeth VARCHAR(10),
c_id INTEGER,
CONSTRAINT orders_o_id_pk PRIMARY KEY (o_id),
CONSTRAINT orders_c_id_fk FOREIGN KEY (c_id) REFERENCES customer(c_id));

CREATE TABLE category
(cat_id INTEGER,
cat_desc VARCHAR(20),
CONSTRAINT category_cat_id_pk PRIMARY KEY (cat_id));

CREATE TABLE item
(item_id INTEGER,
item_desc VARCHAR(30),
cat_id INTEGER,
CONSTRAINT item_item_id_pk PRIMARY KEY (item_id),
CONSTRAINT item_cat_id_fk FOREIGN KEY (cat_id) REFERENCES category(cat_id));

CREATE TABLE color
(color VARCHAR(20),
CONSTRAINT color_color_pk PRIMARY KEY (color));

CREATE TABLE inventory
(inv_id INTEGER,
item_id INTEGER,
color VARCHAR(20),
inv_size VARCHAR(10),
inv_price REAL,
inv_qoh INTEGER,
CONSTRAINT inventory_inv_id_pk PRIMARY KEY (inv_id),
CONSTRAINT inventory_item_id_fk FOREIGN KEY (item_id) REFERENCES item(item_id),
CONSTRAINT inventory_color_fk FOREIGN KEY (color) REFERENCES color(color));

CREATE TABLE shipment
(ship_id INTEGER,
ship_date_expected DATE,
CONSTRAINT shipment_ship_id_pk PRIMARY KEY (ship_id));

CREATE TABLE shipment_line
(ship_id INTEGER, 
inv_id INTEGER,
sl_quantity INTEGER,
sl_date_received DATE, 
CONSTRAINT shipment_line_ship_id_fk FOREIGN KEY (ship_id) REFERENCES shipment(ship_id),
CONSTRAINT shipment_line_inv_id_fk FOREIGN KEY (inv_id) REFERENCES inventory(inv_id),
CONSTRAINT shipment_line_shipid_invid_pk PRIMARY KEY(ship_id, inv_id));

CREATE TABLE order_line 
(o_id INTEGER, 
inv_id INTEGER, 
ol_quantity INTEGER NOT NULL, 
 
CONSTRAINT order_line_o_id_fk FOREIGN KEY (o_id) REFERENCES orders(o_id),
CONSTRAINT order_line_inv_id_fk FOREIGN KEY (inv_id) REFERENCES inventory(inv_id),
CONSTRAINT order_line_oid_invid_pk PRIMARY KEY (o_id, inv_id));


-- Inserting data into tables

INSERT INTO CUSTOMER VALUES
(11, 'Jones', 'Tom', NULL, date('1967-12-10'), '9815 Circle Dr.', 'Tallahassee', 'FL', '32308', '9045551897', '904558599', 'tjones', 'barbiecar');

INSERT INTO CUSTOMER VALUES
(22, 'White', 'Chris', 'B', date('1958-08-14'), '172 Alto Park', 'Seattle', 'WA','42180', '4185551791', '4185556643', 'cwhite', 'qwert5');

INSERT INTO CUSTOMER VALUES
(33, 'Adams', 'Fred', 'M', date('1960-04-12'), '850 East Main', 'Santa Ana', 'MA', '51875', '3075557841', '3075559852', 'fadams', 'joshua5');

INSERT INTO CUSTOMER VALUES
(44, 'Baker', 'Jimmy', 'T', date('1981-01-18'), '994 Kirkman Rd.', 'Northpoint', 'NY', '11795', '4825554788', '4825558219', 'jbaker1', 'hold98er');

INSERT INTO CUSTOMER VALUES
(55, 'Peterson', 'Sharon', 'A', date('1978-08-30'), '195 College Blvd.', 'Newton', 'GA', '37812', '3525554972', '3525551811', 'spete', '125pass');

INSERT INTO CUSTOMER VALUES
(66, 'Smith', 'Norm', 'D', date('1973-06-01'), '348 Rice Lane', 'Radcliff', 'WY', '87195', '7615553485', '7615553319', 'nsmith3', 'nok$tell');


INSERT INTO orders VALUES (1, DATE('2013-05-29'), 'CC', 11);
INSERT INTO orders VALUES (2, DATE('2013-05-29'), 'CC', 55);
INSERT INTO orders VALUES (3, DATE('2013-05-31'), 'CHECK', 22);
INSERT INTO orders VALUES (4, DATE('2013-05-31'), 'CC', 33);
INSERT INTO orders VALUES (5, DATE('2013-06-01'), 'CC', 44);
INSERT INTO orders VALUES (6, DATE('2013-06-01'), 'CC', 44);


INSERT INTO category VALUES (1, 'Organization');
INSERT INTO category VALUES (2, 'Paper');
INSERT INTO category VALUES (3, 'Office Supplies');
INSERT INTO category VALUES (4, 'Furniture');


INSERT INTO item VALUES (1, 'Pencil', 3);
INSERT INTO item VALUES (2, 'Desk', 4);
INSERT INTO item VALUES (3, 'Binder', 1);
INSERT INTO item VALUES (4, 'Folder', 1);
INSERT INTO item VALUES (5, 'Notebook', 2);
INSERT INTO item VALUES (6, 'Post-it Notes', 2);
INSERT INTO item VALUES (7, 'Chair', 4);


INSERT INTO color VALUES ('Sky Blue');
INSERT INTO color VALUES ('Light Grey');
INSERT INTO color VALUES ('Khaki');
INSERT INTO color VALUES ('Navy');
INSERT INTO color VALUES ('Royal');
INSERT INTO color VALUES ('Eggplant');
INSERT INTO color VALUES ('Blue');
INSERT INTO color VALUES ('Red');
INSERT INTO color VALUES ('Spruce');
INSERT INTO color VALUES ('Turquoise');
INSERT INTO color VALUES ('Bright Pink');
INSERT INTO color VALUES ('White');


INSERT INTO inventory VALUES (1, 2, 'Sky Blue', NULL, 259.99, 16);
INSERT INTO inventory VALUES (2, 2, 'Light Grey', NULL, 259.99, 12);
INSERT INTO inventory VALUES (3, 3, 'Khaki', 'S', 29.95, 150);
INSERT INTO inventory VALUES (4, 3, 'Khaki', 'M', 29.95, 147);
INSERT INTO inventory VALUES (5, 3, 'Khaki', 'L', 29.95, 0);
INSERT INTO inventory VALUES (6, 3, 'Navy', 'S', 29.95, 139);
INSERT INTO inventory VALUES (7, 3, 'Navy', 'M', 29.95, 137);
INSERT INTO inventory VALUES (8, 3, 'Navy', 'L', 29.95, 115);
INSERT INTO inventory VALUES (9, 4, 'Eggplant', 'S', 59.95, 135);
INSERT INTO inventory VALUES (10, 4, 'Eggplant', 'M', 59.95, 168);
INSERT INTO inventory VALUES (11, 4, 'Eggplant', 'L', 59.95, 187);
INSERT INTO inventory VALUES (12, 4, 'Royal', 'S', 59.95, 0);
INSERT INTO inventory VALUES (13, 4, 'Royal', 'M', 59.95, 124);
INSERT INTO inventory VALUES (14, 4, 'Royal', 'L', 59.95, 112);
INSERT INTO inventory VALUES (15, 5, 'Turquoise', '10', 15.99, 121);
INSERT INTO inventory VALUES (16, 5, 'Turquoise', '11', 15.99, 111);
INSERT INTO inventory VALUES (17, 5, 'Turquoise', '12', 15.99, 113);
INSERT INTO inventory VALUES (18, 5, 'Turquoise', '1', 15.99, 121);
INSERT INTO inventory VALUES (19, 5, 'Bright Pink', '10', 15.99, 148);
INSERT INTO inventory VALUES (20, 5, 'Bright Pink', '11', 15.99, 137);
INSERT INTO inventory VALUES (21, 5, 'Bright Pink', '12', 15.99, 134);
INSERT INTO inventory VALUES (22, 5, 'Bright Pink', '1', 15.99, 123);
INSERT INTO inventory VALUES (23, 1, 'Spruce', 'S', 199.95, 114);
INSERT INTO inventory VALUES (24, 1, 'Spruce', 'M',199.95, 17);
INSERT INTO inventory VALUES (25, 1, 'Spruce', 'L', 209.95, 0);
INSERT INTO inventory VALUES (26, 1, 'Spruce', 'XL', 209.95, 12);
INSERT INTO inventory VALUES (27, 6, 'Blue', 'S', 15.95, 50);
INSERT INTO inventory VALUES (28, 6, 'Blue', 'M', 15.95, 100);
INSERT INTO inventory VALUES (29, 6, 'Blue', 'L', 15.95, 100);
INSERT INTO inventory VALUES (30, 7, 'White', 'S', 19.99, 100);
INSERT INTO inventory VALUES (31, 7, 'White', 'M', 19.99, 100);
INSERT INTO inventory VALUES (32, 7, 'White', 'L', 19.99, 100);


INSERT INTO shipment VALUES (1, DATE('2006-09-15'));
INSERT INTO shipment VALUES (2, DATE('2006-11-15'));
INSERT INTO shipment VALUES (3, DATE('2006-06-25'));
INSERT INTO shipment VALUES (4, DATE('2006-06-25'));
INSERT INTO shipment VALUES (5, DATE('2006-08-15'));


INSERT INTO shipment_line VALUES (1, 1, 25, DATE('2006-09-10'));
INSERT INTO shipment_line VALUES (1, 2, 25, DATE('2006-09-10'));
INSERT INTO shipment_line VALUES (2, 2, 25, NULL);
INSERT INTO shipment_line VALUES (3, 5, 200, NULL);
INSERT INTO shipment_line VALUES (3, 6, 200, NULL);
INSERT INTO shipment_line VALUES (3, 7, 200, NULL);
INSERT INTO shipment_line VALUES (4, 12, 100, DATE('2012-08-15'));
INSERT INTO shipment_line VALUES (4, 13, 100, DATE('2012-08-25'));
INSERT INTO shipment_line VALUES (5, 23, 50, DATE('2012-08-15'));
INSERT INTO shipment_line VALUES (5, 24, 100, DATE('2012-08-15'));
INSERT INTO shipment_line VALUES (5, 25, 100, DATE('2012-08-15'));


INSERT INTO order_line VALUES (1,  1, 1);
INSERT INTO order_line VALUES (1,  4, 7);
INSERT INTO order_line VALUES (1, 14, 2);
INSERT INTO order_line VALUES (2,  6, 10);
INSERT INTO order_line VALUES (2, 13, 4);
INSERT INTO order_line VALUES (2, 19, 1);
INSERT INTO order_line VALUES (2, 28, 2);
INSERT INTO order_line VALUES (2, 31, 3);
INSERT INTO order_line VALUES (3, 24, 1);
INSERT INTO order_line VALUES (3, 26, 1);
INSERT INTO order_line VALUES (4, 12, 2);
INSERT INTO order_line VALUES (5,  8, 8);
INSERT INTO order_line VALUES (5, 13, 1);
INSERT INTO order_line VALUES (6,  2, 1);
INSERT INTO order_line VALUES (6,  7, 3);


-- Listing item's id and description for items under the category "Firniture"
SELECT i.item_id, i.item_desc
FROM item i
WHERE i.cat_id IN (
    SELECT c.cat_id
    FROM category c
    WHERE c.cat_desc = 'Furniture');


-- Listing orders that are not paid by payment method "CC"
SELECT c.c_first, c.c_last, c.c_address, c.c_city, c.c_state, c.c_zip
FROM customer c
WHERE c.c_id IN (
    SELECT o.c_id
    FROM orders o
    WHERE o.o_pmtmeth != 'CC');


-- Listing description of all items that are included in order number 5
SELECT i.item_desc 
FROM item i
WHERE i.item_id IN (
	SELECT inv.item_id
	FROM inventory inv
	WHERE inv.inv_id IN (
		SELECT ol.inv_id
		FROM order_line ol 
		WHERE ol.o_id = 5
		)
	)
ORDER BY i.item_desc ASC;


-- Listing id and last name of customers who ordered an item of which the color is "Blue"
SELECT c.c_id, c.c_last 
FROM customer c 
WHERE c.c_id IN (
	SELECT o.c_id
	FROM orders o 
	WHERE o.o_id IN (
		SELECT ol.o_id
		FROM order_line ol 
		WHERE ol.inv_id IN (
			SELECT inv.inv_id
			FROM inventory inv
			WHERE inv.color = 'Blue'
			)
		)
	);


-- Listing the id and last name of customers who have not placed an order yet
SELECT c.c_id, c.c_last 
FROM customer c 
WHERE c.c_id NOT IN (
	SELECT o.c_id
	FROM orders o 
	);


-- Listing the city and state of customers who have never placed an order that includes items in color "Navy" or "Red" or "White"
SELECT c.c_city, c.c_state
FROM customer c
WHERE c.c_id NOT IN (
    SELECT o.c_id
    FROM orders o
    WHERE o.o_id IN (
        SELECT ol.o_id
        FROM order_line ol
        WHERE ol.inv_id IN (
            SELECT i.inv_id
            FROM inventory i
            WHERE i.color IN ('Navy', 'Red', 'White')
        )
    )
);


-- Listing the id of items that are either under the category "Organization" or include a shipment revieved on or afer 8/25/2006
SELECT i.item_id, i.item_desc 
FROM item i 
WHERE i.cat_id IN (
	SELECT ct.cat_id
	FROM category ct
	WHERE ct.cat_desc = 'Organization'
	)
OR i.item_id IN (
	SELECT inv.item_id
	FROM inventory inv
	WHERE inv.inv_id IN (
		SELECT sl.inv_id
		FROM shipment_line sl 
		WHERE sl.sl_date_received >= '2006-08-25'
		)
	);


-- Listing the id of items that are either under the category "Office Supplies" and include a shipment revieved on or afer 8/15/2012
SELECT i.item_id, i.item_desc 
FROM item i 
WHERE i.cat_id IN (
	SELECT ct.cat_id
	FROM category ct
	WHERE ct.cat_desc = 'Office Supplies'
	)
AND i.item_id IN (
	SELECT inv.item_id
	FROM inventory inv
	WHERE inv.inv_id IN (
		SELECT sl.inv_id
		FROM shipment_line sl 
		WHERE sl.sl_date_received >= '2012-08-15'
		)
	);


-- Listing the id of items that are either under the category "Paper" and not include a shipment revieved on or afer 8/15/2012
SELECT i.item_id, i.item_desc 
FROM item i 
WHERE i.cat_id IN (
	SELECT ct.cat_id
	FROM category ct
	WHERE ct.cat_desc = 'Paper'
	)
AND i.item_id NOT IN (
	SELECT inv.item_id
	FROM inventory inv
	WHERE inv.inv_id IN (
		SELECT sl.inv_id
		FROM shipment_line sl 
		WHERE sl.sl_date_received >= '2012-08-15'
		)
	);


-- Listing states and the total amount of order revenue placed by customers from that state over $500 (inventory price * order quantity)
SELECT c.c_state , SUM(i.inv_price * ol.ol_quantity) AS [total order revenue]
FROM customer c, orders o , order_line ol , inventory i 
WHERE c.c_id = o.c_id AND o.o_id = ol.o_id AND ol.inv_id = i.inv_id 
	GROUP BY c.c_state 
	HAVING SUM(i.inv_price * ol.ol_quantity) > 500
	ORDER BY SUM(i.inv_price * ol.ol_quantity) DESC;


-- =================================================================================
-- Modifying the Database (Renaming a table - new name will be used moving forward)
-- =================================================================================

-- Renaming the category table into item_category (all future queries will use this name)
ALTER TABLE category 
RENAME TO item_category;


-- Adding a new column to the table
ALTER TABLE item_category  
ADD cat_mgr VARCHAR(20);


-- Looking at properties of the item_category table
PRAGMA TABLE_INFO ('item_category');


-- Updating data in the item_category table
UPDATE item_category SET cat_mgr = 'Jane Doe' WHERE cat_id = '1';
UPDATE item_category SET cat_mgr = 'John Smith' WHERE cat_id = '2';
UPDATE item_category SET cat_mgr = 'Allen Marks' WHERE cat_id = '3';
UPDATE item_category SET cat_mgr = 'Ray Brown' WHERE cat_id = '4';


-- Displaying data in the item_category table
SELECT * FROM item_category;


-- Changing the expexted ship date to 12/31/2006 for ship id 5
UPDATE shipment 
SET ship_date_expected = DATE('2006-12-31')
WHERE ship_id = 5;

SELECT * FROM shipment;


-- Customer Lifetime Value (total spending per customer)
SELECT 
    c.c_id, c.c_first, c.c_last,
    SUM(i.inv_price * ol.ol_quantity) AS total_spent
FROM customer c
JOIN orders o ON c.c_id = o.c_id
JOIN order_line ol ON o.o_id = ol.o_id
JOIN inventory i ON ol.inv_id = i.inv_id
GROUP BY c.c_id
ORDER BY total_spent DESC;


-- Average order value
SELECT 
    o.o_id,
    SUM(i.inv_price * ol.ol_quantity) AS order_total
FROM orders o
JOIN order_line ol ON o.o_id = ol.o_id
JOIN inventory i ON ol.inv_id = i.inv_id
GROUP BY o.o_id;


-- Overall average
SELECT AVG(order_total) AS avg_order_value
FROM (
    SELECT o.o_id,
           SUM(i.inv_price * ol.ol_quantity) AS order_total
    FROM orders o
    JOIN order_line ol ON o.o_id = ol.o_id
    JOIN inventory i ON ol.inv_id = i.inv_id
    GROUP BY o.o_id
);


-- Total inventory value
SELECT 
    SUM(inv_price * inv_qoh) AS total_inventory_value
FROM inventory;


-- Items with low or zero stock (with item description)
SELECT 
    i.item_id, it.item_desc, i.color, i.inv_qoh
FROM inventory i
JOIN item it ON i.item_id = it.item_id
WHERE i.inv_qoh <= 20
ORDER BY i.inv_qoh ASC;


-- Revenue by category
SELECT 
    ic.cat_desc,
    SUM(i.inv_price * ol.ol_quantity) AS revenue
FROM item_category ic
JOIN item it ON ic.cat_id = it.cat_id
JOIN inventory i ON it.item_id = i.item_id
JOIN order_line ol ON i.inv_id = ol.inv_id
GROUP BY ic.cat_desc
ORDER BY revenue DESC;


-- Estimated profit (assuming cost is 60% of the price given)
SELECT 
    SUM(i.inv_price * ol.ol_quantity) AS revenue,
    SUM(i.inv_price * ol.ol_quantity * 0.6) AS estimated_cost,
    SUM(i.inv_price * ol.ol_quantity * 0.4) AS estimated_profit
FROM order_line ol
JOIN inventory i ON ol.inv_id = i.inv_id;


-- Customer segmentation
SELECT 
    c.c_id,
    SUM(i.inv_price * ol.ol_quantity) AS total_spent,
    CASE 
        WHEN SUM(i.inv_price * ol.ol_quantity) > 600 THEN 'High Value'
        WHEN SUM(i.inv_price * ol.ol_quantity) > 300 THEN 'Medium Value'
        ELSE 'Low Value'
    END AS customer_segment
FROM customer c
JOIN orders o ON c.c_id = o.c_id
JOIN order_line ol ON o.o_id = ol.o_id
JOIN inventory i ON ol.inv_id = i.inv_id
GROUP BY c.c_id;