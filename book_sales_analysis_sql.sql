--Create Table
DROP TABLE IF EXISTS books;
CREATE TABLE books (
    Book_id      SERIAL PRIMARY KEY,
    Title        VARCHAR(100),
    Author       VARCHAR(100),
    Genre        VARCHAR(50),
    Publish_Year INT,
    Price        DECIMAL(10,2),
    Stock        INT
);

DROP TABLE IF EXISTS customers;
CREATE TABLE customers (
    Customer_Id SERIAL PRIMARY KEY,
    Name        VARCHAR(100),
    Email       VARCHAR(100),
    Phone       VARCHAR(15),
    City        VARCHAR(50),
    Country     VARCHAR(150)
);

DROP TABLE IF EXISTS orders;
CREATE TABLE orders (
    order_id    SERIAL PRIMARY KEY,
    customer_id INT,
    book_id     INT,
    order_date  DATE,
    quantity    INT,
    total_amount DECIMAL(10,2),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (book_id)     REFERENCES books(book_id)
);

--Import Data into books table
COPY Books(Book_id,Title ,Author ,Genre ,Publish_Year,Price,Stock )
FROM 'D:\sql project\Books.csv'
CSV HEADER;

SELECT * FROM Books;

--Import Data into Customers table
COPY customers( Customer_Id,Name,Email,Phone,City,Country)
FROM 'D:\sql project\Customers.csv'
CSV HEADER;

SELECT * FROM Customers;

--Import Data into orders table
COPY orders (Order_Id,Customer_Id,Book_Id,Order_Date,Quantity,Total_Amount)
FROM 'D:\sql project\Orders.csv'
CSV HEADER;

SELECT * FROM Orders;


---1. Retrive all books in the "Fricton" genre:
--This query selects and displays all records from the books table where the Genre column has the value 'Fiction'.
SELECT * FROM books 
WHERE Genre = 'Fiction' ;

---2. Find books published after the year 1950:
--This query retrieves all books from the books table that were published after the year 1950.
SELECT * FROM books
WHERE Publish_Year > 1950 ;

---3. List all customers from the Canada:
--This query fetches all records from the CUSTOMERS table where the Country is 'Canada'.
SELECT * FROM CUSTOMERS
WHERE Country = 'Canada'

---4. Show orders placed in november 2023:
--This query retrieves all orders from the orders table that were placed between November 1 and November 30, 2023.
SELECT * FROM orders
WHERE order_date BETWEEN '2023-11-01' AND '2023-11-30';

---5. Retrive the total stock of books avaliable:
--This query calculates the total number of books in stock by summing the Stock column from the Books table.
SELECT SUM (Stock) AS Total_Stock
FROM Books;

---6. Find the details of the most expensive book:
--This query retrieves the details of the book with the highest price by sorting the Price column in descending order and selecting the top result.
SELECT * FROM books 
ORDER BY Price 
DESC LIMIT 1;

---7. Show all customers who ordered more than 1 quantity of a book:
--This query retrieves all orders from the orders table where the quantity of books ordered is greater than 1.
SELECT * FROM orders
WHERE Quantity > 1;

---8. Retrieve all orders where the total amount exceeds $20:
--This query retrieves all orders from the orders table where the Total_Amount is greater than 20.
SELECT * FROM orders
WHERE Total_Amount > 20;

---9. List all genres avaliable in the books table:
--This query retrieves a list of all unique genres available in the books table by removing duplicates. Using distint.
SELECT DISTINCT genre FROM books;

---10. Find the book with the lowest stock:
--This query retrieves the details of the book with the lowest stock by sorting the Stock column in ascending order and selecting the first result.
SELECT * FROM books 
ORDER BY Stock 
ASC LIMIT 1;


---11. Caculate the total revenue generated from all orders:
--This query calculates the total revenue by summing the Total_Amount column from all records in the orders table.
SELECT SUM(Total_Amount) AS Revenue 
FROM orders;


---ADVANCE QUERY:
---1. Retrieve the total {(number of book sold)1} for {[each genre]2}:
SELECT b.Genre, SUM(o.Quantity) AS Total_Books_Sold
FROM Orders o
JOIN Books b ON o.book_ID = b.book_ID
GROUP BY b.Genre;
--This query joins the Orders and Books tables using book_ID, then groups the data by Genre and calculates the total quantity of books sold 
--for each genre using SUM(o.Quantity).


---2. Find the average price of books in the "Fantasy" Genre:
SELECT AVG(Price) AS Average_Price
FROM Books
WHERE Genre = 'Fantasy';
--This query calculates the average price of all books in the 'Fantasy' genre by filtering those books and applying the AVG() function on the Price column.


---3. List customers who have placed at least 2 orders:
SELECT Customer_ID , COUNT(Order_ID) AS Order_Count
FROM Orders
GROUP BY Customer_ID 
HAVING COUNT (Order_ID) >= 2;
--This query groups orders by Customer_ID, counts how many orders each customer placed, and returns only those customers who have placed 2 or more
--orders using the HAVING clause.


---4. Find the most frequently ordered book:
SELECT book_id , COUNT(Order_id) AS order_count
FROM orders
GROUP BY book_id
ORDER BY order_count DESC
LIMIT 1;
--This query counts how many times each book was ordered, sorts them in descending order of count, and returns the book with the highest number of orders.


---5. Show the top 3 mose expensive books of 'Fantasy' Genre:
SELECT * FROM books
WHERE Genre = 'Fantasy'
ORDER BY price DESC
LIMIT 3;
--This query filters books in the 'Fantasy' genre, sorts them by price in descending order, and returns the top 3 most expensive books.


---6. Retrieve the total quantity of books sold by each author:
SELECT b.Author , SUM(o.Quantity) AS Total_books_sold
FROM orders o
JOIN books b ON o.book_id = b.book_id
GROUP BY b.Author;
--This query joins the orders and books tables, groups the data by author, and calculates the total number of books sold for each author by summing the quantities.


---7. List the cities where customers who spent over $30 are located:
SELECT DISTINCT c.city , o.Total_Amount 
FROM orders o
JOIN Customers c ON o.customer_id = c.customer_id
WHERE o.Total_Amount > 30;
--This query joins the orders and customers tables, filters orders where the total amount is greater than $30, and lists the distinct cities of those customers.


---8. Find the customer(NAME) who spent(AMOUNT) the most on orders:
SELECT c.customer_id, c.name , SUM(o.Total_Amount) AS Total_spent
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
GROUP BY c.customer_id, c.name
ORDER BY Total_spent DESC ;
-- Gets the customer who spent the highest total amount by summing each customer's orders, sorting them in descending order of total spending, and returning only the top record.


---9. Caculate the stock remaining after fulfilling all orders:
SELECT b.book_id, b.title, b.stock , COALESCE(SUM(o.Quantity),0) AS Order_Quantity,
b.stock- COALESCE(SUM(o.Quantity),0) AS Remaining_Quantity
FROM books b
LEFT JOIN orders o ON b.book_id = o.book_id 
GROUP BY b.book_id
ORDER BY b.book_id;
-- For each book, calculates total ordered quantity (treating no orders as 0) and subtracts it from stock to find the remaining quantity after fulfilling all orders.