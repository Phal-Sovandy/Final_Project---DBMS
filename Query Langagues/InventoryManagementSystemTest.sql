-- ==================== Test Case 1: Place an Order and Update Stock ====================

-- Step 1: Setting up for the Test Case

-- Insert a product a product
INSERT INTO products (product_name, stock, price, category_id, manufacturer_id, details)
VALUES ('Test Product', 100, 50.00, 1, 1, 'Test product details');

-- Insert a customer using the AddCustomer procedure
CALL AddCustomer(
    'Will Smith', 
    'Mr.', 
    'Doe Enterprises', 
    30, 
    TRUE, 
    '123-456-7890', 
    '123 Test St', 
    'Test City', 
    'Test Country', 
    '12345', 
    'Test Region'
);

-- Insert an employee using the AddEmployee procedure
CALL AddEmployee(
    'Micheal', 
    'Jackson', 
    TRUE, 
    3000.00, 
    '1985-07-15', 
    '2010-06-01', 
    '987-654-3210', 
    NULL,  -- No supervisor_id for this case
    '456 Employee St', 
    'Employee City', 
    'Employee Country', 
    '67890', 
    'Employee Region'
);

-- Verify changes:
-- Check the product insertion (should show stock = 100)
SELECT product_id, product_name, stock, price FROM products WHERE product_name = 'Test Product';

-- Verify customer is inserted (should return Will Smith)
SELECT * FROM customers WHERE contact_name = 'Will Smith';

-- Verify employee insertion (should return Micheal Jackson)
SELECT * FROM employees WHERE first_name = 'Micheal' AND last_name = 'Jackson';


-- Step 2: Place an Order using the `PlaceOrder` stored procedure
CALL PlaceOrder(
    21,                -- customer_id
    21,                -- employee_id
    1,                 -- delivery_id
    10.00,             -- shipping_price
    '2025-04-03 10:00:00',  -- ship_date
    '2025-04-05 10:00:00',  -- arrived_date
    '123 Test St',     -- order_address
    'Test City',       -- order_city
    'Test Country',    -- order_country
    '12345',           -- order_postal_code
    'Test Region'      -- order_region
);

-- Verify changes:
-- Check if a new order was created (should return the order details with order_id)
SELECT * FROM orders WHERE customer_id = 21;

-- Check if the order details are inserted (should return order details)
SELECT * FROM order_details WHERE order_id = 21;

-- Step 3: Add Product to the Order using `AddProductToOrder`
CALL AddProductToOrder(21, 56, 2, 0.10);  -- 2 units, 10% discount

-- Verify changes:
-- Check the ordered_items table (should show 2 units added to the order)
SELECT * FROM ordered_items WHERE order_id = 21;

-- Step 4: Verify Stock Update
-- Check if the stock is updated (should show stock = 98)
SELECT product_name, stock FROM products WHERE product_name = 'Test Product';

-- Step 5: Verify Data in `ordered_items` and `order_details`
-- Verify the `ordered_items` table (should show 2 units of 'Test Product' added to the order)
SELECT * FROM ordered_items WHERE order_id = 21;

-- Verify the `order_details` table (should show order details like shipping price, dates)
SELECT * FROM order_details WHERE order_id = 21;

-- Verify the `order_locations` table (should show order order_locations like address, city, country,...)
SELECT * FROM order_locations WHERE order_id = 21;


-- ==================== Test Case 2: Delete Customer and Cascade Deletion ====================

-- Step 1: Setup for the Test Case
-- Insert a product
INSERT INTO products (product_name, stock, price, category_id, manufacturer_id, details)
VALUES ('Sample Product', 50, 25.00, 1, 1, 'Sample product description');

-- Insert a customer using the AddCustomer procedure
CALL AddCustomer(
    'Johnpoy Junior', 
    'Mr.', 
    'Super Poy.', 
    28, 
    TRUE, 
    '111-222-3333', 
    '456 Example Rd', 
    'Sample City', 
    'Sample Country', 
    '67890', 
    'Sample Region'
);

-- Place an order for the customer
CALL PlaceOrder(
    22,  -- customer_id
    14,  -- employee_id
    3,   -- delivery_id
    15.00,  -- shipping_price
    '2025-04-03 10:00:00',  -- ship_date
    '2025-04-06 10:00:00',  -- arrived_date
    '456 Example Rd',  -- order_address
    'Sample City',  -- order_city
    'Sample Country',  -- order_country
    '67890',  -- order_postal_code
    'Sample Region'  -- order_region
);

-- Add product to the order
CALL AddProductToOrder(22, 57, 13, 0.05);  -- Add 13 unit of 'Sample Product' with a 5% discount

-- Verify changes:
-- Check that the customer was inserted
SELECT * FROM customers WHERE contact_name = 'Johnpoy Junior';

-- Check that the customer location was inserted
SELECT * FROM customer_locations WHERE customer_id = 22;

-- Check if the product 'Sample Product' was inserted
SELECT * FROM products WHERE product_name = 'Sample Product';

-- Check that the order for the customer was placed
SELECT * FROM orders WHERE customer_id = 22;

-- Check the order details and ordered items
SELECT * FROM order_details WHERE order_id = 22;
SELECT * FROM ordered_items WHERE order_id = 22;


-- Step 2: Delete the Customer
-- Delete the customer and check if associated data is cascaded
DELETE FROM customers WHERE customer_id = 21;

-- Verify changes:
-- Check that the customer is deleted
SELECT * FROM customers WHERE customer_id = 21;

-- Check if the associated customer location was deleted
SELECT * FROM customer_locations WHERE customer_id = 21;
	 
-- Check if the orders related to the customer were deleted
SELECT * FROM orders WHERE customer_id = 21;

-- Check if the order details and ordered items were deleted
SELECT * FROM order_details WHERE order_id IN (SELECT order_id FROM orders WHERE customer_id = 21);
SELECT * FROM ordered_items WHERE order_id IN (SELECT order_id FROM orders WHERE customer_id = 21);


-- Additonal Test Cases

-- VIEWS
-- Test: Check data from the order_summary view
SELECT * FROM order_summary LIMIT 10;

-- Test: Check data from the product_inventory view
SELECT * FROM product_inventory LIMIT 10;

-- Test: Check data from the customer_order_history view for a specific customer
SELECT * FROM customer_order_history WHERE customer = 'Super Poy.';

-- Test: Employee Performance Summary
SELECT * FROM employee_performance;

-- PROCEDURES
-- Test: Sum all customer purchases price
CALL GetCustomerOrders(22);

-- Test: Cancel customer order
CALL CancelOrder(2);

-- FUNCTIONS
-- Test: Calculate total of an order
SELECT CalculateOrderTotal(5);

-- Test: Find available stock of a product
SELECT GetStockLevel(20);