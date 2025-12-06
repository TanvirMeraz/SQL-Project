# SQL-Project
Multi-Vendor SaaS E-Commerce Platform — Database Design &amp; SQL Implementation.
This project demonstrates the complete database design and SQL implementation for a Multi-Vendor SaaS E-Commerce platform, where multiple vendors can register, manage products, and sell to customers. The system supports product categorization, customer management, order processing, payments, and subscription plans for vendors.

The project includes:

ERD (Entity–Relationship Diagram)

Relational Schema

SQL DDL (table creation scripts)

SQL DML (insert, update, delete operations)

SQL DQL (queries for reporting and analytics)

Advanced SQL queries for business insights

📌 Project Overview

The platform is designed to support:

✔ Multi-Vendor Functionality

Vendors can register with business information.

Each vendor subscribes to a single subscription plan.

Vendors can list multiple products.

✔ Product Management

Each product belongs to one vendor.

Products can fall under multiple categories (M:N relationship).

Includes real attributes like name, price, stock, and active/inactive status.

✔ Customer & Orders

Customers can register and place multiple orders.

Orders can include products from different vendors.

Order items track product-wise quantity, unit price, and subtotal.

✔ Payments

Each order has one payment.

Supports Card, PayPal, Bkash, Cash on Delivery, etc.

✔ Subscription Plans

Plans include name, price, duration, and features.

Vendors can subscribe to exactly one plan at a time.

📌 What This Project Includes
1. ERD (Entity Relationship Diagram)

A clearly designed ERD with:

Vendor

SubscriptionPlan

Product

Category

ProductCategory (bridge table)

Customer

Orders

OrderItems

Payments

Includes proper 1:1, 1:N, and M:N relationships.

2. Relational Schema

Complete schema with:

Primary keys

Foreign keys

Constraints

3. SQL DDL

Table creation scripts for all entities, including:

Vendor with FK to SubscriptionPlan

ProductCategory bridge table for Product–Category M:N

4. SQL DML

Insert, update, and delete operations:

New vendor registration

Add new product

Update stock levels

Delete customer

5. SQL Queries (DQL)

Useful reporting queries such as:

Vendors with subscription plans

Products by category

Orders by customer

Payment details

Best-selling products

6. Advanced SQL

Analytical queries:

Total sales per vendor

Customers with no orders

Active product count

Vendors by subscription type

Average order amount per customer

Customers buying from multiple vendors

🛠️ Tools Used

PostgreSQL / MySQL (any SQL RDBMS-compatible)

DrawSQL / Lucidchart for ERD

SQL (DDL, DML, DQL)
