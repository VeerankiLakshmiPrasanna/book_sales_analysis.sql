# book_sales_analysis.sql
SQL-based analysis of book sales and customer data to uncover insights on revenue, customer behavior, and inventory management.

Project Overview

This project focuses on analyzing book sales data using SQL to derive meaningful business insights. It involves designing a relational database, importing data, and performing analysis on customer behavior, sales trends, and inventory management.

Dataset Description

The project consists of three main datasets:

Books: Contains book details such as title, author, genre, price, and stock
Customers: Includes customer information like name, location, and contact details
Orders: Stores transaction data including order date, quantity, and total amount


Tools & Technologies

SQL (PostgreSQL)
CSV Files for Data Storage


Database Design

Created three tables: Books, Customers, and Orders
Established relationships using foreign keys:
customer_id → Customers table
book_id → Books table


Steps Performed

Created database tables using SQL
Imported data from CSV files using COPY command
Performed data exploration using SELECT queries
Applied filtering, sorting, and aggregation
Used JOINs to combine multiple tables
Generated business insights from data


Key Analysis Performed

Genre-wise book analysis
Customer segmentation
Monthly sales analysis
Revenue calculation
Inventory tracking
Author performance analysis


Key Business Insights

Identified best-selling genres and books
Found high-value and repeat customers
Analyzed revenue contribution patterns
Detected low-stock items for inventory management
Identified high-performing regions and authors


Project Outcome

This project demonstrates how SQL can be used to:

Analyze customer behavior
Track sales performance
Optimize inventory
Support data-driven business decisions


Sample Queries

-- Total Revenue
SELECT SUM(Total_Amount) AS Revenue FROM Orders;

-- Top Selling Book
SELECT book_id, COUNT(*) AS order_count
FROM Orders
GROUP BY book_id
ORDER BY order_count DESC
LIMIT 1;



Author

Veeranki Lakshmi Prasanna

