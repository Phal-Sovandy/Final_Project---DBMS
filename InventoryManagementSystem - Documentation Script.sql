CREATE DATABASE InventoryManagementSystem;
USE InventoryManagementSystem;

CREATE TABLE locations (
    location_id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    address VARCHAR(255) NOT NULL,
    city VARCHAR(100) NOT NULL,
    country VARCHAR(100) NOT NULL,
    postal_code VARCHAR(20) NOT NULL,
    region VARCHAR(100) NOT NULL
);

CREATE TABLE manufacturers (
    manufacturer_id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    contact_name VARCHAR(255) NOT NULL,
    phone VARCHAR(20) NOT NULL,
    location_id INT UNSIGNED NOT NULL,
    FOREIGN KEY (location_id) REFERENCES locations(location_id) ON DELETE CASCADE
);

CREATE TABLE categories (
    category_id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL,
    description VARCHAR(255) NOT NULL
);

CREATE TABLE products (
    product_id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    quantity INT DEFAULT 0 CHECK (quantity >= 0),
    price DECIMAL(10,2) DEFAULT 0.0 CHECK (price > 0),
    category_id INT UNSIGNED NOT NULL,
    manufacturer_id INT UNSIGNED NOT NULL,
    FOREIGN KEY (category_id) REFERENCES categories(category_id) ON DELETE CASCADE,
    FOREIGN KEY (manufacturer_id) REFERENCES manufacturers(manufacturer_id) ON DELETE CASCADE
);

CREATE TABLE customers (
    customer_id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    contact_name VARCHAR(100) NOT NULL,
    contact_title VARCHAR(100) NOT NULL,
    company_name VARCHAR(100) NOT NULL,
    phone VARCHAR(20) NOT NULL,
    location_id INT UNSIGNED NOT NULL,
    FOREIGN KEY (location_id) REFERENCES locations(location_id) ON DELETE CASCADE
);

CREATE TABLE employees (
    employee_id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    gender BOOLEAN NOT NULL,
    salary DECIMAL(10,2) DEFAULT 0.0 CHECK (salary > 0),
    birth_date DATETIME NOT NULL,
    hire_date DATETIME NOT NULL,
    phone VARCHAR(20) NOT NULL,
    supervisor_id INT UNSIGNED,
    location_id INT UNSIGNED NOT NULL,
    FOREIGN KEY (supervisor_id) REFERENCES employees(employee_id) ON DELETE SET NULL,
    FOREIGN KEY (location_id) REFERENCES locations(location_id) ON DELETE CASCADE
);

CREATE TABLE deliveries (
    delivery_id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    company_name VARCHAR(100) NOT NULL,
    phone VARCHAR(20) NOT NULL
);

CREATE TABLE orders (
    order_id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    customer_id INT UNSIGNED NOT NULL,
    employee_id INT UNSIGNED NOT NULL,
    delivery_id INT UNSIGNED NOT NULL,
    shipping_location_id INT UNSIGNED NOT NULL,
    order_date DATETIME NOT NULL DEFAULT NOW(),
    shipped_date DATETIME NOT NULL,
    arrived_date DATETIME NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id) ON DELETE CASCADE,
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id) ON DELETE CASCADE,
    FOREIGN KEY (delivery_id) REFERENCES deliveries(delivery_id) ON DELETE CASCADE,
    FOREIGN KEY (shipping_location_id) REFERENCES locations(location_id) ON DELETE CASCADE
);

CREATE TABLE order_details (
    order_id INT UNSIGNED NOT NULL,
    product_id INT UNSIGNED NOT NULL,
    quantity INT NOT NULL CHECK (quantity > 0),
    discount DECIMAL(3,2) DEFAULT 0.0 CHECK (discount >= 0 AND discount <= 100),
    shipping_price DECIMAL(5,2) DEFAULT 0.0 CHECK (shipping_price >= 0),
    PRIMARY KEY (order_id, product_id),
    FOREIGN KEY (order_id) REFERENCES orders(order_id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products(product_id) ON DELETE CASCADE
);

-- STORE PROCEDURES
DELIMITER $$ -- Change Delimiter to '$$'
CREATE PROCEDURE place_order(
    IN customerId INT, 
    IN employeeId INT, 
    IN deliveryId INT, 
    IN shippingDestination INT, 
    IN orderDate DATETIME, 
    IN shippedDate DATETIME, 
    IN arrivedDate DATETIME
)
BEGIN
    INSERT INTO orders (customer_id, employee_id, delivery_id, shipping_location_id, order_date, shipped_date, arrived_date)
    VALUES (customerId, employeeId, deliveryId, shippingDestination, orderDate, shippedDate, arrivedDate);
END $$
DELIMITER ; -- Change Delimiter back to ';'

DELIMITER $$ -- Change Delimiter to '$$'
CREATE PROCEDURE add_product_to_order(
    IN orderId INT,
    IN productId INT,
    IN quantity INT,
    IN discount DECIMAL(3,2),
    IN shippingPrice DECIMAL(3,2)
)
BEGIN
    INSERT INTO order_details (order_id, product_id, quantity, discount, shipping_price)
    VALUES (orderId, productId, quantity, discount, shippingPrice);
END $$
DELIMITER ; -- Change Delimiter back to ';'


-- FUNCTIONS
CREATE FUNCTION get_order_total(orderId INT) RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE total DECIMAL(10,2);
    SELECT SUM((p.price * od.quantity) - ((od.discount / 100) * (p.price * od.quantity)) + od.shipping_price)
    INTO total
    FROM order_details AS od
    INNER JOIN products AS p ON od.product_id = p.id
    WHERE od.order_id = orderId;
    
    RETURN IFNULL(total, 0);
END;

CREATE FUNCTION total_stock_count() RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE total INT;
    SELECT SUM(quantity) INTO total FROM products;
    RETURN IFNULL(total, 0);
END;


-- TRIGGERS
CREATE TRIGGER update_stock_after_order
AFTER INSERT ON order_details
FOR EACH ROW
UPDATE products
SET quantity = quantity - NEW.quantity
WHERE id = NEW.product_id;

CREATE TRIGGER prevent_negative_stock
BEFORE INSERT ON order_details
FOR EACH ROW
BEGIN
    DECLARE available_stock INT;
    SELECT quantity INTO available_stock FROM products WHERE product_id = NEW.product_id;
    IF NEW.quantity > available_stock THEN
        SET NEW.quantity = available_stock;  -- Adjusts order to maximum available stock
    END IF;
END;


CREATE TRIGGER restore_stock_on_order_deletion
AFTER DELETE ON order_details
FOR EACH ROW
UPDATE products
SET quantity = quantity + OLD.quantity
WHERE product_id = OLD.product_id;


-- View for order summary including customer and employee details
CREATE VIEW order_summary AS
SELECT 
    o.order_id, 
    c.contact_name AS customer_name, 
    e.first_name AS employee_first_name, 
    e.last_name AS employee_last_name, 
    d.company_name AS delivery_company, 
    l.address AS shipping_address, 
    o.order_date, 
    o.shipped_date, 
    o.arrived_date
FROM orders AS o
INNER JOIN customers AS c ON o.customer_id = c.customer_id
INNER JOIN employees AS e ON o.employee_id = e.employee_id
INNER JOIN deliveries AS d ON o.delivery_id = d.delivery_id
INNER JOIN locations AS l ON o.shipping_location_id = l.location_id;

-- View for stock levels of products
CREATE VIEW stock_levels AS
SELECT 
    p.product_id, 
    p.product_name, 
    p.quantity, 
    CASE
        WHEN p.quantity = 0 THEN 'Out of Stock'
        WHEN p.quantity < 10 THEN 'Low Stock'
        ELSE 'In Stock'
    END AS stock_status
FROM products p;

-- View for sales revenue per product
CREATE VIEW sales_revenue AS
SELECT 
    od.product_id, 
    p.product_name, 
    SUM(od.quantity) AS total_units_sold, 
    SUM((p.price * od.quantity) - ((od.discount / 100) * (p.price * od.quantity)) + od.shipping_price) AS total_revenue
FROM order_details AS od
INNER JOIN products AS p ON od.product_id = p.product_id
GROUP BY od.product_id, p.product_name;

-- View for employee performance (number of orders handled)
CREATE VIEW employee_performance AS
SELECT 
    e.employee_id, 
    e.first_name, 
    e.last_name, 
    COUNT(o.order_id) AS orders_handled
FROM employees AS e
LEFT JOIN orders AS o ON e.employee_id = o.employee_id
GROUP BY e.employee_id, e.first_name, e.last_name;