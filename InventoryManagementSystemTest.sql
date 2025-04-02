-- Test Views
SELECT * FROM order_summary;
SELECT * FROM product_inventory;
SELECT * FROM customer_order_history;
SELECT * FROM employee_performance;

-- Test Procedures
CALL GetCustomerOrders(1);  -- Replace '1' with an existing customerID
CALL GetProductDetails(1);  -- Replace '1' with an existing productID
CALL PlaceOrder(
    1,               -- customer_id
    1,               -- employee_id
    1,               -- delivery_id
    5.00,            -- shipping_price
    '2025-04-03 10:00:00', -- ship_date
    '2025-04-05 10:00:00', -- arrived_date
    '123 Main St',    -- order_address
    'New York',       -- order_city
    'USA',            -- order_country
    '10001',          -- order_postal_code
    'NY'              -- order_region
);
CALL AddProductToOrder(1, 1, 2, 0.10);  -- orderID, productID, quantity, discount
CALL CancelOrder(1);  -- Replace '1' with an existing orderID

-- Test Functions
SELECT CalculateOrderTotal(1);  -- Replace '1' with an existing orderID
SELECT GetStockLevel(1);  -- Replace '1' with an existing productID

-- Test Triggers

-- Trigger: update_stock_after_order
INSERT INTO ordered_items (order_id, product_id, quantity, discount)
VALUES (1, 1, 2, 0.10);  -- Use valid orderID and productID

-- Trigger: delete_customer_data
DELETE FROM customers WHERE customer_id = 1;  -- Replace '1' with a valid customerID

-- Trigger: delete_employee_data
DELETE FROM employees WHERE employee_id = 1;  -- Replace '1' with a valid employeeID

-- Trigger: delete_product_data
DELETE FROM products WHERE product_id = 1;  -- Replace '1' with a valid productID

-- Trigger: delete_manufacturer_data
DELETE FROM manufacturers WHERE manufacturer_id = 1;  -- Replace '1' with a valid manufacturerID

-- Trigger: delete_order_data
DELETE FROM orders WHERE order_id = 1;  -- Replace '1' with a valid orderID

-- Trigger: delete_delivery_data
DELETE FROM deliveries WHERE delivery_id = 1;  -- Replace '1' with a valid deliveryID
