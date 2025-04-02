-- ==================== TEST VIEWS ====================
-- Test Order Summary View
SELECT * FROM order_summary;
select * from deliveries;

-- Test Product Inventory View
SELECT * FROM product_inventory;

-- Test Customer Order History View
SELECT * FROM customer_order_history;

-- Test Employee Performance Summary View
SELECT * FROM employee_performance;

-- ==================== TEST PROCEDURES ====================
-- Test Get Customer Order History Procedure
CALL GetCustomerOrders(1); -- Replace 1 with an existing customer_id

-- Test Place Order Procedure
CALL PlaceOrder(2, 3, 1, 12.50, '2025-04-10 10:00:00', '2025-04-15 18:00:00');
SELECT * FROM orders ORDER BY order_id DESC LIMIT 1; -- Check if order was inserted
SELECT * FROM order_details ORDER BY order_id DESC LIMIT 1;

-- Test Cancel Order Procedure
CALL CancelOrder(1); -- Replace 1 with an existing order_id
SELECT * FROM orders WHERE order_id = 1; -- Should return no rows if deleted

-- Test Get Product Details Procedure
CALL GetProductDetails(1); -- Replace 1 with an existing product_id

-- ==================== TEST FUNCTIONS ====================
-- Test Calculate Order Total Function
SELECT CalculateOrderTotal(1) AS order_total; -- Replace 1 with an existing order_id

-- Test Get Stock Level Function
SELECT GetStockLevel(1) AS stock_level; -- Replace 1 with an existing product_id
