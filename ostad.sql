-- Active: 1755463613880@@127.0.0.1@3306@ecommerce
-- PART-B ALL ANSWERS
-- OSTAD SHOULD GIVE US MORE PRACTICE PRBLEMS 1RATHER THAN GIVING ONE PROBLEM.
-- WHY IS OSTAD BEHAVING LIKE A FASCIST CO.?
CREATE DATABASE Ecommerce;

CREATE TABLE SubscriptionPlan(
    plan_id INT PRIMARY KEY AUTO_INCREMENT,
    plan_name VARCHAR(50) NOT NULL,
    price INT NOT NULL,
    duration INT NOT NULL,
    features TEXT
);
INSERT INTO SubscriptionPlan(plan_name,price,duration,features)
VALUES
        ('Basic',1000,1,'Basic Features'),
        ('Enterprise',5000,12,'All Features');
CREATE TABLE Vendor (
    vendor_id INT PRIMARY KEY AUTO_INCREMENT,
    business_name VARCHAR(100) NOT NULL,
    contact_person VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    phone VARCHAR(20) NOT NULL,
    address VARCHAR(255) NOT NULL,
    subscription_plan_id INT NOT NULL,
    FOREIGN KEY (subscription_plan_id) REFERENCES SubscriptionPlan(plan_id)
);
INSERT INTO Vendor (business_name, contact_person, email, phone, address, subscription_plan_id)
VALUES
        ('SmartTech Ltd.', 'Rahim Khan', 'rahim@smarttech.com', '01711111111', 'Dhaka, Bangladesh', 1),
        ('GadgetWorld', 'Salma Begum', 'salma@gadgetworld.com', '01822222222', 'Chittagong, Bangladesh', 2);

CREATE TABLE Category (
    category_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    description TEXT
);
INSERT INTO Category (name, description) 
VALUES
        ('Electronics', 'Electronic gadgets and devices'),
        ('Accessories', 'Electronic and non-electronic accessories');

CREATE TABLE Product (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    vendor_id INT NOT NULL,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    price INT NOT NULL,
    stock_quantity INT NOT NULL,
    status ENUM('active','inactive') NOT NULL,
    FOREIGN KEY (vendor_id) REFERENCES Vendor(vendor_id)
);

INSERT INTO Product (vendor_id, name, description, price, stock_quantity, status) 
VALUES
        (1, 'Laptop', 'High performance laptop', 75000, 10, 'active'),
        (2, 'Bluetooth Headset', 'Wireless headset', 2500, 20, 'active');

CREATE TABLE ProductCategory (
    product_id INT NOT NULL,
    category_id INT NOT NULL,
    PRIMARY KEY (product_id, category_id),
    FOREIGN KEY (product_id) REFERENCES Product(product_id),
    FOREIGN KEY (category_id) REFERENCES Category(category_id)
);

INSERT INTO ProductCategory (product_id, category_id) VALUES
(1, 1),
(2, 1);

CREATE TABLE Customer (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    phone VARCHAR(20) NOT NULL,
    address VARCHAR(255) NOT NULL
);
INSERT INTO Customer (name, email, phone, address) 
VALUES
        ('Karim Uddin', 'karim@customer.com', '01933333333', 'Sylhet, Bangladesh'),
        ('Old Customer', 'oldcustomer@gmail.com', '01944444444', 'Rajshahi, Bangladesh');

CREATE TABLE Orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL,
    order_date DATETIME NOT NULL,
    total_amount INT NOT NULL,
    status VARCHAR(20) NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id)
);

INSERT INTO Orders(customer_id, order_date, total_amount, status) 
VALUES
        (1, '2025-09-01 10:00:00', 75000, 'Completed'),
        (1, '2025-09-02 08:00:00', 2500, 'Pending');

CREATE TABLE OrderItem(
    order_item_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    unit_price INT NOT NULL,
    subtotal INT NOT NULL,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Product(product_id)
);
INSERT INTO OrderItem(order_id, product_id, quantity, unit_price, subtotal) 
VALUES
        (1, 1, 1, 75000, 75000),
        (2, 2, 1, 2500, 2500);

CREATE TABLE Payment(
    payment_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT NOT NULL,
    method ENUM('Card','Bkash','PayPal','Cash on Delivery') NOT NULL,
    amount INT NOT NULL,
    payment_date DATETIME NOT NULL,
    status VARCHAR(20) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id)
);
INSERT INTO Payment(order_id, method, amount, payment_date, status) 
VALUES
        (1, 'Card', 75000, '2025-09-01 10:10:00', 'Paid'),
        (2, 'Bkash', 2500, '2025-09-02 08:10:00', 'Pending');


-- PART-C ALL ANSWERS
UPDATE Product SET stock_quantity = 15 WHERE name = 'Laptop';
DELETE FROM Customer WHERE email = 'oldcustomer@gmail.com';

-- PART D:
-- 10.
SELECT v.business_name, v.contact_person, v.email, sp.plan_name, sp.price
FROM Vendor v
JOIN SubscriptionPlan sp ON v.subscription_plan_id = sp.plan_id;
--11.
SELECT p.name, p.price, p.stock_quantity
FROM Product p
JOIN ProductCategory pc ON p.product_id = pc.product_id
JOIN Category c ON pc.category_id = c.category_id
WHERE c.name = 'Electronics';
-- 12,
SELECT o.order_id, o.order_date, o.total_amount, o.status
FROM Orders o
JOIN Customer c ON o.customer_id = c.customer_id
WHERE c.name = 'Karim Uddin';
-- 13.
SELECT method, amount, status
FROM Payment
WHERE order_id = 1;
--PART-E
--15
SELECT v.business_name, SUM(oi.subtotal) AS total_sales
FROM Vendor v
JOIN Product p ON v.vendor_id = p.vendor_id
JOIN OrderItem oi ON p.product_id = oi.product_id
GROUP BY v.vendor_id, v.business_name;
--16
SELECT c.name
FROM Customer c
LEFT JOIN Orders o ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;
--17
SELECT COUNT(*) AS active_products
FROM Product
WHERE status = 'active';
--18
SELECT v.business_name, v.contact_person, v.email
FROM Vendor v
JOIN SubscriptionPlan sp ON v.subscription_plan_id = sp.plan_id
WHERE sp.plan_name = 'Enterprise';
--19
SELECT c.name, AVG(o.total_amount) AS avg_order_amount
FROM Customer c
JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.name;
--20
SELECT c.name
FROM Customer c
JOIN Orders o ON c.customer_id = o.customer_id
JOIN OrderItem oi ON o.order_id = oi.order_id
JOIN Product p ON oi.product_id = p.product_id
GROUP BY c.customer_id, c.name
HAVING COUNT(DISTINCT p.vendor_id) > 1;