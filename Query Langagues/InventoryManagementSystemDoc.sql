CREATE DATABASE InventoryManagementSys;
USE InventoryManagementSys;

CREATE TABLE manufacturers (
    manufacturer_id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    company_name VARCHAR(100) NOT NULL UNIQUE,
    contact_name VARCHAR(100) NOT NULL,
    phone VARCHAR(15) NOT NULL
);

CREATE TABLE manufacturer_locations (
    manufacturer_id INT UNSIGNED NOT NULL PRIMARY KEY,
    address VARCHAR(255) NOT NULL,
    city VARCHAR(100) NOT NULL,
    country VARCHAR(100) NOT NULL,
    postal_code VARCHAR(10) NOT NULL,
    region VARCHAR(100) NOT NULL,
    CONSTRAINT fk_manufacturer_location FOREIGN KEY (manufacturer_id) REFERENCES manufacturers(manufacturer_id) ON DELETE CASCADE
);

CREATE TABLE customers (
    customer_id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    contact_name VARCHAR(100) NOT NULL,
    contact_title VARCHAR(100) NOT NULL,
    company_name VARCHAR(100) NOT NULL,
    age INT NOT NULL,
    gender BOOLEAN NOT NULL,
    phone VARCHAR(15) NOT NULL
);

CREATE TABLE customer_locations (
    customer_id INT UNSIGNED NOT NULL PRIMARY KEY,
    address VARCHAR(255) NOT NULL,
    city VARCHAR(100) NOT NULL,
    country VARCHAR(100) NOT NULL,
    postal_code VARCHAR(10) NOT NULL,
    region VARCHAR(100) NOT NULL,
    CONSTRAINT fk_customer_location FOREIGN KEY (customer_id) REFERENCES customers(customer_id) ON DELETE CASCADE
);

CREATE TABLE categories (
    category_id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL UNIQUE,
    description VARCHAR(255)
);

CREATE TABLE products (
    product_id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL UNIQUE,
    stock INT UNSIGNED NOT NULL CHECK (stock >= 0),
    price DECIMAL(10,2) NOT NULL CHECK (price > 0),
    category_id INT UNSIGNED NOT NULL,
    manufacturer_id INT UNSIGNED NOT NULL,
    details VARCHAR(255),
    CONSTRAINT fk_product_category FOREIGN KEY (category_id) REFERENCES categories(category_id) ON DELETE CASCADE,
    CONSTRAINT fk_product_manufacturer FOREIGN KEY (manufacturer_id) REFERENCES manufacturers(manufacturer_id) ON DELETE CASCADE
);

CREATE TABLE employees (
    employee_id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    gender BOOLEAN NOT NULL,
    salary DECIMAL(10,2) NOT NULL CHECK (salary > 0),
    birthdate DATE NOT NULL,
    hire_date DATE NOT NULL,
    phone VARCHAR(15) NOT NULL,
    supervisor_id INT UNSIGNED,
    CONSTRAINT fk_employee_supervisor FOREIGN KEY (supervisor_id) REFERENCES employees(employee_id) ON DELETE SET NULL
);

CREATE TABLE employee_locations (
    employee_id INT UNSIGNED NOT NULL PRIMARY KEY,
    address VARCHAR(255) NOT NULL,
    city VARCHAR(100) NOT NULL,
    country VARCHAR(100) NOT NULL,
    postal_code VARCHAR(10) NOT NULL,
    region VARCHAR(100) NOT NULL,
    CONSTRAINT fk_employee_location FOREIGN KEY (employee_id) REFERENCES employees(employee_id) ON DELETE CASCADE
);

CREATE TABLE deliveries (
    delivery_id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    company_name VARCHAR(100) NOT NULL UNIQUE,
    phone VARCHAR(15) NOT NULL
);

CREATE TABLE orders (
    order_id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    customer_id INT UNSIGNED NOT NULL,
    employee_id INT UNSIGNED,
    delivery_id INT UNSIGNED,
    CONSTRAINT fk_order_customer FOREIGN KEY (customer_id) REFERENCES customers(customer_id) ON DELETE CASCADE,
    CONSTRAINT fk_order_employee FOREIGN KEY (employee_id) REFERENCES employees(employee_id) ON DELETE SET NULL,
    CONSTRAINT fk_order_delivery FOREIGN KEY (delivery_id) REFERENCES deliveries(delivery_id) ON DELETE SET NULL
);

CREATE TABLE ordered_items (
    order_id INT UNSIGNED NOT NULL,
    product_id INT UNSIGNED NOT NULL,
    quantity INT UNSIGNED NOT NULL CHECK (quantity > 0),
    discount DECIMAL(5,2) NOT NULL CHECK (discount BETWEEN 0 AND 1),
    PRIMARY KEY (order_id, product_id),
    CONSTRAINT fk_ordered_items_order FOREIGN KEY (order_id) REFERENCES orders(order_id) ON DELETE CASCADE,
    CONSTRAINT fk_ordered_items_product FOREIGN KEY (product_id) REFERENCES products(product_id) ON DELETE CASCADE
);

CREATE TABLE order_details (
    order_id INT UNSIGNED NOT NULL PRIMARY KEY,
    shipping_price DECIMAL(10,2) NOT NULL CHECK (shipping_price >= 0),
    ship_date DATETIME NOT NULL,
    arrived_date DATETIME NOT NULL,
    order_date DATETIME NOT NULL,
    CONSTRAINT chk_ship_arrival CHECK (arrived_date >= ship_date),
    CONSTRAINT fk_order_details FOREIGN KEY (order_id) REFERENCES orders(order_id) ON DELETE CASCADE
);

CREATE TABLE order_locations (
    order_id INT UNSIGNED NOT NULL PRIMARY KEY,
    address VARCHAR(255) NOT NULL,
    city VARCHAR(100) NOT NULL,
    country VARCHAR(100) NOT NULL,
    postal_code VARCHAR(10) NOT NULL,
    region VARCHAR(100) NOT NULL,
    CONSTRAINT fk_order_location FOREIGN KEY (order_id) REFERENCES order_details(order_id) ON DELETE CASCADE
);

-- ==================== INDEXES ====================
-- Index on common search attributes to improve search efficiency (B-Tree)
CREATE INDEX idx_order_date ON order_details(order_date);
CREATE INDEX idx_product_name ON products(product_name);
CREATE INDEX idx_company_name ON customers(company_name);
CREATE INDEX idx_order_customer ON orders(customer_id, order_id);

-- ==================== TRIGGERS ====================
-- Trigger: Update stock when order is placed
CREATE TRIGGER update_stock_after_order
AFTER INSERT ON ordered_items
FOR EACH ROW
UPDATE products
SET stock = stock - NEW.quantity
WHERE product_id = NEW.product_id;


-- ==================== VIEWS ====================
-- View: Order Summary
CREATE VIEW order_summary AS
SELECT o.order_id, c.company_name AS customer, e.first_name AS employee,
       d.company_name AS delivery_service, od.shipping_price, od.order_date
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN employees e ON o.employee_id = e.employee_id
JOIN deliveries d ON o.delivery_id = d.delivery_id
JOIN order_details od ON o.order_id = od.order_id
ORDER BY o.order_id;

-- View: Product Inventory
CREATE VIEW product_inventory AS
SELECT p.product_id, p.product_name, c.category_name, p.stock, p.price
FROM products p
JOIN categories c ON p.category_id = c.category_id;

-- View: Customer Order History
CREATE VIEW customer_order_history AS
SELECT o.order_id, c.company_name AS customer, od.order_date, 
       SUM(oi.quantity * p.price) AS total_cost
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN order_details od ON o.order_id = od.order_id
JOIN ordered_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id
GROUP BY o.order_id, c.company_name, od.order_date;

-- View: Employee Performance Summary
CREATE VIEW employee_performance AS
SELECT e.employee_id, e.first_name, e.last_name, COUNT(o.order_id) AS total_orders_handled
FROM employees e
LEFT JOIN orders o ON e.employee_id = o.employee_id
GROUP BY e.employee_id, e.first_name, e.last_name;

-- ==================== PROCEDURES ====================
-- Stored Procedure: Get Customer Order History
DELIMITER $$
CREATE PROCEDURE GetCustomerOrders(IN customerID INT)
BEGIN
    SELECT o.order_id, od.order_date, SUM(oi.quantity * p.price) AS total_cost
    FROM orders o
    JOIN order_details od ON o.order_id = od.order_id
    JOIN ordered_items oi ON o.order_id = oi.order_id
    JOIN products p ON oi.product_id = p.product_id
    WHERE o.customer_id = customerID
    GROUP BY o.order_id;
END;
$$
DELIMITER ;

-- Procedure: Get Product Details
DELIMITER $$
CREATE PROCEDURE GetProductDetails(IN productID INT)
BEGIN
    SELECT p.product_id, p.product_name, c.category_name, p.stock, p.price, p.details
    FROM products p
    JOIN categories c ON p.category_id = c.category_id
    WHERE p.product_id = productID;
END;
$$
DELIMITER ;

-- Stored Procedure: Place an Order
DELIMITER $$

CREATE PROCEDURE PlaceOrder(
    IN cust_id INT, 
    IN emp_id INT, 
    IN del_id INT, 
    IN ship_price DECIMAL(10,2), 
    IN ship_dt DATETIME, 
    IN arr_dt DATETIME, 
    IN order_address VARCHAR(255), 
    IN order_city VARCHAR(100), 
    IN order_country VARCHAR(100), 
    IN order_postal_code VARCHAR(10), 
    IN order_region VARCHAR(100)
)
BEGIN
    DECLARE new_order_id INT;

    -- Insert into orders
    INSERT INTO orders (customer_id, employee_id, delivery_id)
    VALUES (cust_id, emp_id, del_id);

    -- Get the last inserted order ID
    SET new_order_id = LAST_INSERT_ID();

    -- Insert into order_details
    INSERT INTO order_details (order_id, shipping_price, ship_date, arrived_date, order_date)
    VALUES (new_order_id, ship_price, ship_dt, arr_dt, NOW());

    -- Insert into order_locations
    INSERT INTO order_locations (order_id, address, city, country, postal_code, region)
    VALUES (new_order_id, order_address, order_city, order_country, order_postal_code, order_region);

END $$

DELIMITER ;

-- Stored Procedure: Add product to order
DELIMITER $$

CREATE PROCEDURE AddProductToOrder(
    IN orderID INT UNSIGNED,
    IN productID INT UNSIGNED,
    IN quantity INT UNSIGNED,
    IN discount DECIMAL(5,2)
)
BEGIN
    DECLARE product_stock INT;

    -- Insert product into order
    INSERT INTO ordered_items (order_id, product_id, quantity, discount)
    VALUES (orderID, productID, quantity, discount);
    
END $$

DELIMITER ;


-- Procedure: Cancel an Order and Restore Stock
DELIMITER $$
CREATE PROCEDURE CancelOrder(IN orderID INT)
BEGIN
    -- Restore stock levels
    UPDATE products p
    JOIN ordered_items oi ON p.product_id = oi.product_id
    SET p.stock = p.stock + oi.quantity
    WHERE oi.order_id = orderID;

    -- Delete the order (this will cascade delete from order_details and ordered_items)
    DELETE FROM orders WHERE order_id = orderID;
END;
$$
DELIMITER ;

-- Stored Procedure: Add a New Customer
DELIMITER $$
CREATE PROCEDURE AddCustomer(
    IN contact_name VARCHAR(100),
    IN contact_title VARCHAR(100),
    IN company_name VARCHAR(100),
    IN age INT,
    IN gender BOOLEAN,
    IN phone VARCHAR(15),
    IN address VARCHAR(255),
    IN city VARCHAR(100),
    IN country VARCHAR(100),
    IN postal_code VARCHAR(10),
    IN region VARCHAR(100)
)
BEGIN
    DECLARE new_customer_id INT;
    
    -- Insert into customers
    INSERT INTO customers (contact_name, contact_title, company_name, age, gender, phone)
    VALUES (contact_name, contact_title, company_name, age, gender, phone);
    
    -- Get the last inserted customer ID
    SET new_customer_id = LAST_INSERT_ID();
    
    -- Insert into customer_locations
    INSERT INTO customer_locations (customer_id, address, city, country, postal_code, region)
    VALUES (new_customer_id, address, city, country, postal_code, region);
END $$
DELIMITER ;

-- Stored Procedure: Add a New Employee
DELIMITER $$
CREATE PROCEDURE AddEmployee(
    IN first_name VARCHAR(100),
    IN last_name VARCHAR(100),
    IN gender BOOLEAN,
    IN salary DECIMAL(10,2),
    IN birthdate DATE,
    IN hire_date DATE,
    IN phone VARCHAR(15),
    IN supervisor_id INT,
    IN address VARCHAR(255),
    IN city VARCHAR(100),
    IN country VARCHAR(100),
    IN postal_code VARCHAR(10),
    IN region VARCHAR(100)
)
BEGIN
    DECLARE new_employee_id INT;
    
    -- Insert into employees
    INSERT INTO employees (first_name, last_name, gender, salary, birthdate, hire_date, phone, supervisor_id)
    VALUES (first_name, last_name, gender, salary, birthdate, hire_date, phone, supervisor_id);
    
    -- Get the last inserted employee ID
    SET new_employee_id = LAST_INSERT_ID();
    
    -- Insert into employee_locations
    INSERT INTO employee_locations (employee_id, address, city, country, postal_code, region)
    VALUES (new_employee_id, address, city, country, postal_code, region);
END $$
DELIMITER ;

-- Stored Procedure: Add a New Manufacturer
DELIMITER $$
CREATE PROCEDURE AddManufacturer(
    IN company_name VARCHAR(100),
    IN contact_name VARCHAR(100),
    IN phone VARCHAR(15),
    IN address VARCHAR(255),
    IN city VARCHAR(100),
    IN country VARCHAR(100),
    IN postal_code VARCHAR(10),
    IN region VARCHAR(100)
)
BEGIN
    DECLARE new_manufacturer_id INT;
    
    -- Insert into manufacturers
    INSERT INTO manufacturers (company_name, contact_name, phone)
    VALUES (company_name, contact_name, phone);
    
    -- Get the last inserted manufacturer ID
    SET new_manufacturer_id = LAST_INSERT_ID();
    
    -- Insert into manufacturer_locations
    INSERT INTO manufacturer_locations (manufacturer_id, address, city, country, postal_code, region)
    VALUES (new_manufacturer_id, address, city, country, postal_code, region);
END $$
DELIMITER ;

-- ==================== FUNCTIONS ====================
-- Function: Calculate Order Total
DELIMITER $$
CREATE FUNCTION CalculateOrderTotal(orderID INT) RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE total DECIMAL(10,2);
    
    SELECT SUM(oi.quantity * p.price * (1 - oi.discount))
    INTO total
    FROM ordered_items oi
    JOIN products p ON oi.product_id = p.product_id
    WHERE oi.order_id = orderID;
    
    RETURN IFNULL(total, 0);
END;
$$
DELIMITER ;
-- Function: Get Stock Level for a Product
DELIMITER $$
CREATE FUNCTION GetStockLevel(productID INT) RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE stockLevel INT;
    
    SELECT stock INTO stockLevel
    FROM products
    WHERE product_id = productID;
    
    RETURN IFNULL(stockLevel, 0);
END;
$$
DELIMITER ;