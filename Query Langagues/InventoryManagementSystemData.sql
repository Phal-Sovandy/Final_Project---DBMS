-- Insert Manufacturers
INSERT INTO manufacturers (company_name, contact_name, phone) VALUES
('Tech Supplies Inc.', 'John Doe', '123-456-7890'),
('Quality Tools Ltd.', 'Jane Smith', '987-654-3210'),
('Global Electronics', 'Michael Johnson', '111-222-3333'),
('Mega Tools', 'Emma Watson', '444-555-6666'),
('Precision Instruments', 'Olivia Brown', '222-333-4444'),
('Industrial Solutions', 'Liam Wilson', '555-666-7777'),
('Advanced Robotics Corp.', 'Sophia Turner', '888-777-6666'),
('Innovative Devices Ltd.', 'Ethan Walker', '333-444-5555'),
('GreenTech Systems', 'Ava Davis', '777-888-9999'),
('TechMinds Inc.', 'Benjamin Clark', '666-555-4444');


-- Insert Manufacturer Locations
INSERT INTO manufacturer_locations (manufacturer_id, address, city, country, postal_code, region) VALUES
(1, '123 Tech Street', 'New York', 'USA', '10001', 'East Coast'),
(2, '456 Industrial Ave', 'Los Angeles', 'USA', '90001', 'West Coast'),
(3, '789 Silicon Road', 'San Francisco', 'USA', '94102', 'West Coast'),
(4, '321 Hardware Lane', 'Dallas', 'USA', '75201', 'South'),
(5, '555 Precision Dr', 'Houston', 'USA', '77002', 'Southwest'),
(6, '666 Industry Blvd', 'Chicago', 'USA', '60602', 'Midwest'),
(7, '999 Robotics Way', 'Seattle', 'USA', '98101', 'West'),
(8, '555 Innovation Blvd', 'Boston', 'USA', '02110', 'Northeast'),
(9, '888 GreenTech Circle', 'Portland', 'USA', '97201', 'Pacific Northwest'),
(10, '444 TechMinds St', 'San Diego', 'USA', '92101', 'Southwest');


-- Insert Customers
INSERT INTO customers (contact_name, contact_title, company_name, age, gender, phone) VALUES
('John Doe', 'Manager', 'Acme Corp', 32, TRUE, '123-456-7890'),
('Jane Smith', 'CEO', 'Tech Solutions', 45, FALSE, '123-456-7891'),
('Sam Brown', 'Sales Lead', 'Brown Innovations', 28, TRUE, '123-456-7892'),
('Alice Green', 'Marketing Lead', 'Green Enterprises', 40, FALSE, '123-456-7893'),
('Bob White', 'Sales Associate', 'White Products', 35, TRUE, '123-456-7894'),
('Chris Black', 'CFO', 'Black Industries', 50, TRUE, '123-456-7895'),
('Diana Harris', 'Product Manager', 'Harris Designs', 30, FALSE, '123-456-7896'),
('Eva Johnson', 'Lead Developer', 'Tech Works', 27, FALSE, '123-456-7897'),
('Frank Wilson', 'CEO', 'Wilson Corporation', 55, TRUE, '123-456-7898'),
('Gina Lee', 'Product Designer', 'Lee Creations', 33, FALSE, '123-456-7899'),
('Henry King', 'Sales Manager', 'King Enterprises', 42, TRUE, '123-456-7900'),
('Isabel Clark', 'Lead Marketing', 'Clark Enterprises', 38, FALSE, '123-456-7901'),
('Jack Lewis', 'Senior Engineer', 'Lewis Industries', 48, TRUE, '123-456-7902'),
('Kimberly Scott', 'HR Manager', 'Scott Enterprises', 36, FALSE, '123-456-7903'),
('Liam Thomas', 'Operations Manager', 'Thomas Solutions', 49, TRUE, '123-456-7904'),
('Monica Martinez', 'CFO', 'Martinez Group', 53, FALSE, '123-456-7905'),
('Nina White', 'Tech Support', 'White Innovations', 29, FALSE, '123-456-7906'),
('Oscar Gray', 'VP of Sales', 'Gray Enterprises', 44, TRUE, '123-456-7907'),
('Paul Miller', 'Marketing Specialist', 'Miller Marketing', 31, TRUE, '123-456-7908'),
('Quinn Cooper', 'Customer Service', 'Cooper Solutions', 26, TRUE, '123-456-7909');


-- Insert Customer Locations
INSERT INTO customer_locations (customer_id, address, city, country, postal_code, region) VALUES
(1, '123 Oak St', 'New York', 'USA', '10001', 'East'),
(2, '456 Maple Ave', 'San Francisco', 'USA', '94105', 'West'),
(3, '789 Pine Rd', 'Chicago', 'USA', '60616', 'Midwest'),
(4, '101 Birch Ln', 'Los Angeles', 'USA', '90001', 'West'),
(5, '202 Cedar Blvd', 'Miami', 'USA', '33101', 'South'),
(6, '303 Elm Dr', 'Seattle', 'USA', '98101', 'West'),
(7, '404 Willow Way', 'Austin', 'USA', '73301', 'South'),
(8, '505 Maple Ct', 'Boston', 'USA', '02108', 'Northeast'),
(9, '606 Pine St', 'Denver', 'USA', '80202', 'West'),
(10, '707 Oak Rd', 'Atlanta', 'USA', '30303', 'South'),
(11, '808 Birch Ave', 'Dallas', 'USA', '75201', 'South'),
(12, '909 Cedar St', 'Houston', 'USA', '77001', 'South'),
(13, '1010 Elm Ave', 'Phoenix', 'USA', '85001', 'West'),
(14, '1111 Willow Ln', 'Portland', 'USA', '97201', 'West'),
(15, '1212 Maple Dr', 'San Diego', 'USA', '92101', 'West'),
(16, '1313 Oak Ave', 'Salt Lake City', 'USA', '84101', 'West'),
(17, '1414 Birch Rd', 'Tampa', 'USA', '33601', 'South'),
(18, '1515 Cedar Dr', 'Minneapolis', 'USA', '55101', 'Midwest'),
(19, '1616 Elm Ln', 'Cleveland', 'USA', '44101', 'Midwest'),
(20, '1717 Willow Ct', 'Charlotte', 'USA', '28201', 'South');

-- Insert Categories
INSERT INTO categories (category_name, description) VALUES
('Electronics', 'Various electronic devices and gadgets'),
('Clothing', 'Apparel and fashion accessories'),
('Home Appliances', 'Electrical and mechanical home devices'),
('Furniture', 'Indoor and outdoor furniture'),
('Sports', 'Sports equipment and apparel');

-- Insert Products
INSERT INTO products (product_name, stock, price, category_id, manufacturer_id, details) VALUES
('Wireless Mouse', 150, 19.99, 1, 1, 'Ergonomic wireless mouse with USB receiver.'),
('Laptop Stand', 100, 29.99, 1, 2, 'Adjustable laptop stand with multiple angles.'),
('Bluetooth Headphones', 200, 59.99, 1, 3, 'Noise-canceling over-ear Bluetooth headphones.'),
('USB-C Cable', 300, 9.99, 1, 4, 'Durable USB-C cable for fast charging and data transfer.'),
('Smartphone Holder', 250, 14.99, 1, 5, 'Adjustable holder for smartphones, compatible with all sizes.'),
('Portable Charger', 180, 39.99, 1, 6, 'Power bank with 10000mAh capacity and fast charge support.'),
('Gaming Mouse', 120, 49.99, 1, 7, 'High precision gaming mouse with customizable buttons.'),
('LED Desk Lamp', 160, 24.99, 1, 8, 'Energy-efficient LED desk lamp with adjustable brightness.'),
('Mechanical Keyboard', 75, 89.99, 1, 9, 'Mechanical keyboard with RGB backlighting and key switch options.'),
('Laptop Sleeve', 220, 19.99, 1, 10, 'Slim and protective sleeve for 15-inch laptops.'),
('Running Shoes', 250, 59.99, 2, 1, 'Comfortable and lightweight running shoes for all terrains.'),
('Yoga Mat', 300, 19.99, 2, 2, 'Non-slip yoga mat with extra thickness for added comfort.'),
('Dumbbells', 150, 29.99, 2, 3, 'Pair of adjustable dumbbells for home workouts.'),
('Jump Rope', 350, 9.99, 2, 4, 'Durable and adjustable jump rope for cardio and training.'),
('Resistance Bands', 200, 14.99, 2, 5, 'Set of resistance bands for strength training and flexibility.'),
('Bluetooth Speaker', 180, 79.99, 2, 6, 'Portable Bluetooth speaker with clear sound and long battery life.'),
('Headphone Stand', 250, 19.99, 2, 7, 'Desk stand for headphones with built-in USB charger.'),
('Wireless Charger', 220, 39.99, 2, 8, 'Fast wireless charger compatible with all Qi-enabled devices.'),
('Smartwatch', 150, 129.99, 2, 9, 'Fitness smartwatch with heart rate monitor and activity tracking.'),
('Phone Case', 300, 14.99, 2, 10, 'Slim and durable phone case for iPhone and Android models.'),
('Office Chair', 100, 149.99, 3, 1, 'Ergonomic office chair with adjustable height and lumbar support.'),
('Standing Desk', 80, 199.99, 3, 2, 'Adjustable standing desk with electric height controls.'),
('Desk Organizer', 200, 24.99, 3, 3, 'Wooden desk organizer for keeping office supplies neat.'),
('Bookcase', 75, 99.99, 3, 4, 'Modern 5-shelf bookcase with a sturdy wooden frame.'),
('Desk Mat', 150, 19.99, 3, 5, 'Large desk mat to protect surfaces and keep things organized.'),
('Coffee Maker', 220, 49.99, 4, 6, 'Coffee maker with programmable features and strong brewing power.'),
('Smart Thermostat', 150, 129.99, 4, 7, 'Wi-Fi-enabled smart thermostat for energy savings and comfort.'),
('Robot Vacuum', 100, 199.99, 4, 8, 'Automatic robot vacuum with mapping and smart app control.'),
('Water Filter', 250, 34.99, 4, 9, 'Advanced water filtration system for home use.'),
('Smart Light Bulbs', 300, 39.99, 4, 10, 'Smart LED bulbs that work with Alexa and Google Home.'),
('Electric Grill', 150, 79.99, 5, 1, 'Indoor electric grill with adjustable temperature settings.'),
('Blender', 200, 59.99, 5, 2, 'Powerful blender with multiple speeds for smoothies and soups.'),
('Food Processor', 120, 89.99, 5, 3, 'Multi-functional food processor with various attachments.'),
('Coffee Grinder', 180, 19.99, 5, 4, 'Electric coffee grinder with stainless steel blades.'),
('Rice Cooker', 250, 39.99, 5, 5, '5-cup rice cooker with keep-warm feature.'),
('Bluetooth Keyboard', 180, 49.99, 1, 1, 'Wireless keyboard with backlit keys for easy typing.'),
('Smartphone Stand', 150, 19.99, 2, 2, 'Adjustable stand for smartphones and tablets.'),
('Electric Toothbrush', 100, 69.99, 3, 3, 'Rechargeable electric toothbrush with multiple brushing modes.'),
('Office Desk', 200, 149.99, 4, 4, 'Modern office desk with a minimalist design and plenty of space.'),
('Massage Gun', 120, 129.99, 5, 5, 'Portable massage gun with multiple speed settings for muscle relief.'),
('Gaming Chair', 80, 299.99, 1, 2, 'Ergonomic gaming chair with adjustable armrests and lumbar support.'),
('Air Purifier', 250, 199.99, 3, 1, 'HEPA filter air purifier with multiple cleaning modes.'),
('LED Flashlight', 300, 19.99, 2, 3, 'Compact and durable LED flashlight with adjustable brightness.'),
('Smart Light Switch', 180, 49.99, 4, 4, 'Wi-Fi-enabled light switch for remote control and automation.'),
('Portable Air Conditioner', 100, 349.99, 3, 5, 'Energy-efficient portable air conditioner with cooling and dehumidifying functions.'),
('Electric Kettle', 250, 29.99, 2, 1, 'Stainless steel electric kettle with fast boiling time.'),
('Smart Plugs', 300, 39.99, 1, 2, 'Set of Wi-Fi-enabled smart plugs for controlling appliances remotely.'),
('Coffee Maker Machine', 150, 79.99, 3, 3, 'Coffee machine with programmable settings and a 12-cup capacity.'),
('4K Camera', 120, 499.99, 1, 4, 'Ultra high-definition 4K camera with image stabilization and zoom lens.'),
('Wireless Earbuds', 200, 89.99, 2, 5, 'True wireless earbuds with noise cancellation and long battery life.'),
('Waterproof Bluetooth Speaker', 250, 129.99, 3, 1, 'Portable Bluetooth speaker with waterproof rating and high-quality sound.'),
('Smart Thermostat', 150, 99.99, 1, 2, 'Programmable thermostat with Wi-Fi connectivity for home temperature control.'),
('Coffee Table', 80, 149.99, 4, 3, 'Modern coffee table with a glass top and wooden legs.'),
('Fitness Tracker', 200, 59.99, 5, 4, 'Slim fitness tracker with heart rate monitoring and step tracking.'),
('Gaming Monitor', 120, 249.99, 1, 5, 'High refresh rate gaming monitor with ultra-fast response time.');


-- Insert Employees
INSERT INTO employees (first_name, last_name, gender, salary, birthdate, hire_date, phone, supervisor_id) VALUES
('Alice', 'Green', FALSE, 55000.00, '1990-02-15', '2015-06-10', '234-567-8901', NULL),
('Bob', 'Taylor', TRUE, 48000.00, '1985-07-25', '2010-03-05', '234-567-8902', NULL),
('Charlie', 'King', TRUE, 50000.00, '1987-12-01', '2012-04-13', '234-567-8903', NULL),
('David', 'Black', TRUE, 51000.00, '1988-05-20', '2013-02-15', '234-567-8904', NULL),
('Eve', 'White', FALSE, 60000.00, '1991-08-22', '2018-01-15', '234-567-8999', NULL),
('Fiona', 'Blue', FALSE, 45000.00, '1992-03-18', '2017-11-12', '234-567-8905', NULL),
('George', 'Brown', TRUE, 54000.00, '1980-11-09', '2009-07-30', '234-567-8906', NULL),
('Hannah', 'Clark', FALSE, 47000.00, '1986-04-04', '2011-09-01', '234-567-8907', NULL),
('Ivy', 'Davis', FALSE, 53000.00, '1993-01-14', '2020-05-24', '234-567-8908', NULL),
('Jack', 'Evans', TRUE, 49000.00, '1990-07-30', '2016-03-20', '234-567-8909', NULL),
('Kelly', 'Ford', FALSE, 55000.00, '1989-09-17', '2014-04-11', '234-567-8910', NULL),
('Liam', 'Gray', TRUE, 51000.00, '1987-10-25', '2012-02-02', '234-567-8911', NULL),
('Megan', 'Hall', FALSE, 47000.00, '1988-06-30', '2015-05-10', '234-567-8912', NULL),
('Nathan', 'Irving', TRUE, 48000.00, '1986-08-15', '2010-11-17', '234-567-8913', NULL),
('Olivia', 'Jones', FALSE, 56000.00, '1992-12-10', '2019-01-06', '234-567-8914', NULL),
('Paul', 'King', TRUE, 52000.00, '1983-02-09', '2007-03-08', '234-567-8915', NULL),
('Quincy', 'Lee', TRUE, 46000.00, '1990-10-05', '2014-08-22', '234-567-8916', NULL),
('Rachel', 'Miller', FALSE, 50000.00, '1985-05-13', '2012-12-03', '234-567-8917', NULL),
('Steven', 'Nelson', TRUE, 49000.00, '1984-09-25', '2011-06-17', '234-567-8918', NULL),
('Tina', 'O Brien', FALSE, 52000.00, '1990-03-30', '2016-04-19', '234-567-8919', NULL);

-- Insert Employee Locations
INSERT INTO employee_locations (employee_id, address, city, country, postal_code, region) VALUES
(1, '1234 Elm Street', 'New York', 'USA', '10001', 'NY'),
(2, '5678 Oak Avenue', 'Los Angeles', 'USA', '90001', 'CA'),
(3, '2345 Pine Road', 'Chicago', 'USA', '60007', 'IL'),
(4, '6789 Maple Lane', 'Houston', 'USA', '77001', 'TX'),
(5, '3456 Birch Blvd', 'Phoenix', 'USA', '85001', 'AZ'),
(6, '7890 Cedar Street', 'Philadelphia', 'USA', '19101', 'PA'),
(7, '1357 Redwood Drive', 'San Antonio', 'USA', '78201', 'TX'),
(8, '2468 Willow Way', 'San Diego', 'USA', '92101', 'CA'),
(9, '5432 Spruce Court', 'Dallas', 'USA', '75201', 'TX'),
(10, '9876 Fir Avenue', 'Austin', 'USA', '73301', 'TX'),
(11, '1122 Chestnut Road', 'Jacksonville', 'USA', '32201', 'FL'),
(12, '3344 Oakwood Blvd', 'Columbus', 'USA', '43201', 'OH'),
(13, '5567 Pinecrest Drive', 'Charlotte', 'USA', '28201', 'NC'),
(14, '7789 Cedar Ridge', 'Detroit', 'USA', '48201', 'MI'),
(15, '9901 Birchwood Lane', 'Seattle', 'USA', '98001', 'WA'),
(16, '2233 Maple Street', 'Denver', 'USA', '80201', 'CO'),
(17, '4455 Willowbrook Ave', 'Washington', 'USA', '20001', 'DC'),
(18, '6677 Redwood Drive', 'Boston', 'USA', '02101', 'MA'),
(19, '8899 Spruce Terrace', 'Miami', 'USA', '33101', 'FL'),
(20, '1010 Pinewood Place', 'Atlanta', 'USA', '30301', 'GA');

-- Insert Deliveries
INSERT INTO deliveries (company_name, phone) VALUES
('Express Delivery', '555-111-0001'),
('Fast Movers', '555-111-0002'),
('Global Freight', '555-111-0003'),
('Quick Ship', '555-111-0004'),
('Speedy Logistics', '555-111-0005');

-- Insert Orders
INSERT INTO orders (customer_id, employee_id, delivery_id)
VALUES
(1, 1, 1),
(2, 2, 2),
(3, 3, 3),
(4, 4, 4),
(5, 5, 5),
(6, 6, 1),
(7, 7, 2),
(8, 8, 3),
(9, 9, 4),
(10, 10, 5),
(11, 11, 1),
(12, 12, 2),
(13, 13, 3),
(14, 14, 4),
(15, 15, 5),
(16, 16, 1),
(17, 17, 2),
(18, 18, 3),
(19, 19, 4),
(20, 20, 5);

-- Insert Orders_Details
INSERT INTO order_details (order_id, shipping_price, ship_date, arrived_date, order_date)
VALUES
(1, 10.00, '2025-04-01 10:00:00', '2025-04-03 10:00:00', '2025-04-01 09:00:00'),
(2, 12.50, '2025-04-02 11:00:00', '2025-04-04 11:00:00', '2025-04-02 10:00:00'),
(3, 15.00, '2025-04-03 12:00:00', '2025-04-05 12:00:00', '2025-04-03 11:00:00'),
(4, 9.00, '2025-04-04 13:00:00', '2025-04-06 13:00:00', '2025-04-04 12:00:00'),
(5, 20.00, '2025-04-05 14:00:00', '2025-04-07 14:00:00', '2025-04-05 13:00:00'),
(6, 8.50, '2025-04-06 15:00:00', '2025-04-08 15:00:00', '2025-04-06 14:00:00'),
(7, 18.00, '2025-04-07 16:00:00', '2025-04-09 16:00:00', '2025-04-07 15:00:00'),
(8, 22.00, '2025-04-08 17:00:00', '2025-04-10 17:00:00', '2025-04-08 16:00:00'),
(9, 10.50, '2025-04-09 18:00:00', '2025-04-11 18:00:00', '2025-04-09 17:00:00'),
(10, 16.00, '2025-04-10 19:00:00', '2025-04-12 19:00:00', '2025-04-10 18:00:00'),
(11, 7.50, '2025-04-11 20:00:00', '2025-04-13 20:00:00', '2025-04-11 19:00:00'),
(12, 14.00, '2025-04-12 21:00:00', '2025-04-14 21:00:00', '2025-04-12 20:00:00'),
(13, 11.00, '2025-04-13 22:00:00', '2025-04-15 22:00:00', '2025-04-13 21:00:00'),
(14, 9.50, '2025-04-14 23:00:00', '2025-04-16 23:00:00', '2025-04-14 22:00:00'),
(15, 17.50, '2025-04-15 00:00:00', '2025-04-17 00:00:00', '2025-04-15 23:00:00'),
(16, 19.50, '2025-04-16 01:00:00', '2025-04-18 01:00:00', '2025-04-16 00:00:00'),
(17, 21.00, '2025-04-17 02:00:00', '2025-04-19 02:00:00', '2025-04-17 01:00:00'),
(18, 8.00, '2025-04-18 03:00:00', '2025-04-20 03:00:00', '2025-04-18 02:00:00'),
(19, 12.00, '2025-04-19 04:00:00', '2025-04-21 04:00:00', '2025-04-19 03:00:00'),
(20, 10.00, '2025-04-20 05:00:00', '2025-04-22 05:00:00', '2025-04-20 04:00:00');


-- Insert Order Items
INSERT INTO ordered_items (order_id, product_id, quantity, discount)
VALUES
(1, 1, 1, 0.05), (1, 2, 2, 0.10), (1, 3, 1, 0.15), (1, 4, 1, 0.20), (1, 5, 2, 0.25), (1, 6, 1, 0.30),
(2, 7, 1, 0.05), (2, 8, 2, 0.10), (2, 9, 1, 0.15), (2, 10, 1, 0.20), (2, 11, 2, 0.25), (2, 12, 1, 0.30),
(3, 13, 1, 0.05), (3, 14, 2, 0.10), (3, 15, 1, 0.15), (3, 16, 1, 0.20), (3, 17, 2, 0.25), (3, 18, 1, 0.30),
(4, 19, 1, 0.05), (4, 20, 2, 0.10), (4, 1, 1, 0.15), (4, 2, 1, 0.20), (4, 3, 2, 0.25), (4, 4, 1, 0.30),
(5, 5, 1, 0.05), (5, 6, 2, 0.10), (5, 7, 1, 0.15), (5, 8, 1, 0.20), (5, 9, 2, 0.25), (5, 10, 1, 0.30),
(6, 11, 1, 0.05), (6, 12, 2, 0.10), (6, 13, 1, 0.15);
