CREATE DATABASE sql_project_1;

-- ONLINE BOOK STORE SOL PROJECT

-- STEP 1 : PREPARE TABLES

-- Create Book Tables 

CREATE TABLE Books(
    Book_ID SERIAL PRIMARY KEY,
    Title VARCHAR(100),
    Author VARCHAR(100),
    Genre VARCHAR(50),
    Published_Year INT,
    Price NUMERIC(10, 2),
    Stock INT
)


SELECT * FROM Books;

-- Import data From CSV (Book.csv)

COPY
Books(Book_ID,Title,Author,Genre,Published_Year,Price,Stock)
FROM 'D:\Dx\CODING\DATA SCIENCE AIML\SQL\sql quires\SQL BOOK_STORE_PROJECT\DATASET\Books.csv'
DELIMITER ','
CSV HEADER;

SELECT * FROM Books;

-- Create Customer table
CREATE TABLE customer(
    Customer_ID SERIAL PRIMARY KEY,
    Name VARCHAR(100),
    Email VARCHAR(100),
    Phone VARCHAR(100),
    City VARCHAR(100),
    Country VARCHAR(100)
);

SELECT * FROM customer;

-- Import data From CSV (Customer.csv)
COPY
customer(Customer_ID,Name,Email,Phone,City,Country)
FROM 'D:\Dx\CODING\DATA SCIENCE AIML\SQL\sql quires\SQL BOOK_STORE_PROJECT\DATASET\Customers.csv'
DELIMITER ','
CSV HEADER;

SELECT * FROM customer;

-- Create Orders table

CREATE TABLE IF NOT EXISTS Orders(
    Order_ID SERIAL PRIMARY KEY,
    Customer_ID INT REFERENCES customer(Customer_ID),
    Book_ID INT REFERENCES Books(Book_ID),
    Order_Date  DATE,
    Quantity INT,
    Total_Amount NUMERIC(10,2)
)

SELECT * FROM Orders;

-- Import Data From Orders.csv

COPY
Orders(Order_ID,Customer_ID,Book_ID,Order_Date,Quantity,Total_Amount)
FROM 'D:\Dx\CODING\DATA SCIENCE AIML\SQL\sql quires\SQL BOOK_STORE_PROJECT\DATASET\Orders.csv'
DELIMITER ','
CSV HEADER;

SELECT * FROM Orders;


-- STEP 2 : OPERATION

-- BASIC

-- 1) Retrieve all books in the "Fiction" genre

SELECT * FROM books
WHERE genre='Fiction'

-- 2) Find books published after the year 1950

SELECT * FROM books
WHERE published_year>1950;

-- 3) List all customers from the Canada

SELECT * FROM customer
WHERE country='Canada';

-- 4) Show orders placed in November 2023
SELECT * FROM orders
WHERE order_date BETWEEN '2023/11/01' AND '2023/11/30';

--  5) Retrieve the total stock of books available

SELECT SUM(book_id) From books AS Total_book_store;


-- 6) Find the details of the most expensive book

SELECT MAX(price) FROM Books AS Most_expensive_book;


-- 7) Show all customers who ordered more than 1 quantity of a book

SELECT * FROM orders
WHERE quantity>1 ORDER BY quantity;


-- 8) Retrieve all orders where the total amount exceeds $20

SELECT * FROM orders
WHERE total_amount>20;

-- 9) List all genres available in the Books table

SELECT DISTINCT genre 
FROM Books;

-- 10) Find the book with the lowest stock
SELECT * FROM Books
ORDER BY Stock LIMIT 5;

-- 11) Calculate the total revenue generated from all orders
SELECT SUM(total_amount) FROM orders;

-- ADVANCE

-- 1) Retrieve the total number of books sold for each genre

SELECT b.genre,SUM(o.quantity) AS TOTAL_SOLD 
FROM orders o 
JOIN books b
ON o.book_id=b.book_id
GROUP BY b.genre;

--  2) Find the average price of books in the "Fantasy" genre

SELECT AVG(price) AS Fantasy_avg
FROM Books 
WHERE genre='Fantasy';


--  3) List customers who have placed at least 2 orders

SELECT c.name , COUNT(o.order_id) AS total_order FROM customer c 
JOIN orders o
ON c.customer_id=o.customer_id
GROUP BY c.customer_id
HAVING COUNT(o.order_id)>=2
ORDER BY total_order DESC;


--  4) Find the most frequently ordered book

SELECT b.title,o.book_id,COUNT(o.order_id) AS MOST_order
FROM orders o
JOIN books b
ON o.book_id=b.book_id
GROUP BY o.book_id , b.title
ORDER BY most_order DESC LIMIT 1;


-- 5) Show the top 3 most expensive books of 'Fantasy' Genre 

SELECT title , price FROM books
WHERE genre='Fantasy'
ORDER BY price DESC LIMIT 3;

-- 6) Retrieve the total quantity of books sold by each author

SELECT b.author , SUM(o.quantity) AS total_quantity_by_author
FROM orders o
JOIN books b
ON o.book_id=b.book_id
GROUP BY b.author
ORDER BY total_quantity_by_author DESC;

-- 7) List the cities where customers who spent over $30 are located

SELECT c.city , SUM(o.total_amount) AS most_spending
FROM orders o
JOIN customer c
ON o.customer_id=c.customer_id
GROUP BY c.city , o.total_amount
HAVING o.total_amount>30
ORDER BY most_spending DESC;

-- 8) Find the customer who spent the most on orders

SELECT c.name,c.customer_id,SUM(o.Total_amount) AS Most_order_by_customer
FROM orders o
JOIN customer c
ON o.customer_id=c.customer_id
GROUP BY c.name, c.customer_id
ORDER BY Most_order_by_customer DESC LIMIT 1;

-- 9) Calculate the stock remaining after fulfilling all orders

SELECT b.book_id , b.title , b.stock , COALESCE(SUM(o.quantity),0) AS order_quantity,
b.stock- COALESCE(o.quantity,0) AS Remaining_quantity
FROM books b
LEFT JOIN orders o 
ON b.book_id=o.book_id
GROUP BY b.book_id , o.quantity
ORDER BY b.book_id;

	





