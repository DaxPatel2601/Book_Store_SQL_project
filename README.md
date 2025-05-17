# 📖 Online Bookstore SQL Project

This project demonstrates how to design and interact with a relational database for an **Online Bookstore**. It includes the creation of tables, data import from CSV files, and SQL queries for both basic and advanced analysis. This documentation is suitable for uploading to GitHub.

---

## 🔢 Database Initialization

```sql
CREATE DATABASE sql_project_1;
```

Creates a new SQL database named `sql_project_1`.

---

## 📁 Step 1: Table Creation

### Books Table

```sql
CREATE TABLE Books(
    Book_ID SERIAL PRIMARY KEY,
    Title VARCHAR(100),
    Author VARCHAR(100),
    Genre VARCHAR(50),
    Published_Year INT,
    Price NUMERIC(10, 2),
    Stock INT
);
```

Stores book metadata such as title, author, genre, price, etc.

**Import from CSV**

```sql
COPY Books(Book_ID,Title,Author,Genre,Published_Year,Price,Stock)
FROM 'path_to/Books.csv'
DELIMITER ','
CSV HEADER;
```

### Customer Table

```sql
CREATE TABLE customer(
    Customer_ID SERIAL PRIMARY KEY,
    Name VARCHAR(100),
    Email VARCHAR(100),
    Phone VARCHAR(100),
    City VARCHAR(100),
    Country VARCHAR(100)
);
```

Holds customer information such as name, email, and location.

**Import from CSV**

```sql
COPY customer(Customer_ID,Name,Email,Phone,City,Country)
FROM 'path_to/Customers.csv'
DELIMITER ','
CSV HEADER;
```

### Orders Table

```sql
CREATE TABLE IF NOT EXISTS Orders(
    Order_ID SERIAL PRIMARY KEY,
    Customer_ID INT REFERENCES customer(Customer_ID),
    Book_ID INT REFERENCES Books(Book_ID),
    Order_Date  DATE,
    Quantity INT,
    Total_Amount NUMERIC(10,2)
);
```

Captures transaction details including which customer ordered which book, in what quantity, and for what price.

**Import from CSV**

```sql
COPY Orders(Order_ID,Customer_ID,Book_ID,Order_Date,Quantity,Total_Amount)
FROM 'path_to/Orders.csv'
DELIMITER ','
CSV HEADER;
```

---

## 📈 Step 2: SQL Operations

### 🔍 Basic Queries

1. **All Fiction books**

```sql
SELECT * FROM books WHERE genre='Fiction';
```

Retrieve all books in the 'Fiction' genre.

2. **Books published after 1950**

```sql
SELECT * FROM books WHERE published_year > 1950;
```

Fetch books released after the year 1950.

3. **Customers from Canada**

```sql
SELECT * FROM customer WHERE country='Canada';
```

List all customers residing in Canada.

4. **Orders in November 2023**

```sql
SELECT * FROM orders WHERE order_date BETWEEN '2023/11/01' AND '2023/11/30';
```

Display all orders placed during November 2023.

5. **Total books in stock**

```sql
SELECT SUM(stock) AS Total_book_store FROM books;
```

Calculate the total available inventory of books.

6. **Most expensive book**

```sql
SELECT * FROM books ORDER BY price DESC LIMIT 1;
```

Fetch the book with the highest price.

7. **Customers who ordered more than 1 quantity**

```sql
SELECT * FROM orders WHERE quantity > 1 ORDER BY quantity;
```

List all orders where quantity exceeds one.

8. **Orders where amount > \$20**

```sql
SELECT * FROM orders WHERE total_amount > 20;
```

Retrieve orders with a value greater than \$20.

9. **List of genres**

```sql
SELECT DISTINCT genre FROM books;
```

Display unique genres available in the book catalog.

10. **Book with the lowest stock**

```sql
SELECT * FROM books ORDER BY stock ASC LIMIT 1;
```

Find the book that is closest to being out of stock.

11. **Total revenue from orders**

```sql
SELECT SUM(total_amount) FROM orders;
```

Calculate total income generated from all book sales.

---

### 🔹 Advanced Queries

1. **Total books sold per genre**

```sql
SELECT b.genre, SUM(o.quantity) AS total_sold
FROM orders o
JOIN books b ON o.book_id = b.book_id
GROUP BY b.genre;
```

Summarize total number of books sold per genre.

2. **Average price of Fantasy books**

```sql
SELECT AVG(price) AS Fantasy_avg FROM books WHERE genre = 'Fantasy';
```

Compute the average price of books in the Fantasy genre.

3. **Customers with at least 2 orders**

```sql
SELECT c.name, COUNT(o.order_id) AS total_orders
FROM customer c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id
HAVING COUNT(o.order_id) >= 2
ORDER BY total_orders DESC;
```

Identify loyal customers who have ordered two or more times.

4. **Most frequently ordered book**

```sql
SELECT b.title, o.book_id, COUNT(o.order_id) AS order_count
FROM orders o
JOIN books b ON o.book_id = b.book_id
GROUP BY o.book_id, b.title
ORDER BY order_count DESC
LIMIT 1;
```

Highlight the book with the highest number of orders.

5. **Top 3 most expensive Fantasy books**

```sql
SELECT title, price FROM books
WHERE genre = 'Fantasy'
ORDER BY price DESC
LIMIT 3;
```

List the top three priciest Fantasy books.

6. **Total quantity sold by author**

```sql
SELECT b.author, SUM(o.quantity) AS total_quantity
FROM orders o
JOIN books b ON o.book_id = b.book_id
GROUP BY b.author
ORDER BY total_quantity DESC;
```

Aggregate total book sales by author.

7. **Cities with customers spending > \$30**

```sql
SELECT c.city, SUM(o.total_amount) AS total_spending
FROM orders o
JOIN customer c ON o.customer_id = c.customer_id
GROUP BY c.city
HAVING SUM(o.total_amount) > 30
ORDER BY total_spending DESC;
```

Identify cities with customers who spent more than \$30.

8. **Top spending customer**

```sql
SELECT c.name, c.customer_id, SUM(o.total_amount) AS total_spent
FROM orders o
JOIN customer c ON o.customer_id = c.customer_id
GROUP BY c.name, c.customer_id
ORDER BY total_spent DESC
LIMIT 1;
```

Determine the customer who spent the most overall.

9. **Remaining stock after orders**

```sql
SELECT b.book_id, b.title, b.stock, COALESCE(SUM(o.quantity), 0) AS total_ordered,
       b.stock - COALESCE(SUM(o.quantity), 0) AS remaining_stock
FROM books b
LEFT JOIN orders o ON b.book_id = o.book_id
GROUP BY b.book_id, b.title, b.stock
ORDER BY b.book_id;
```

Calculate the current stock level for each book after orders.

---

## 📅 Dataset

Book.CSV --> https://github.com/DaxPatel2601/Book_Store_SQL_project/blob/main/Dataset/Books.csv    
Customer.CSV --> https://github.com/DaxPatel2601/Book_Store_SQL_project/blob/main/Dataset/Customers.csv    
Orders.CSV --> https://github.com/DaxPatel2601/Book_Store_SQL_project/blob/main/Dataset/Orders.csv     

## 🚀 Summary

This SQL project showcases essential database operations for an online bookstore, including schema creation, data manipulation, and analytical querying. It's a great example of how SQL can be used for real-world data projects.

Feel free to clone or fork this project and adapt it for your own learning or development purposes!

---

## 🌐 Author

DAX PATEL  
https://github.com/DaxPatel2601


---

