CREATE TABLE customers (
  customer_id INT PRIMARY KEY,
  customer_name VARCHAR(50),
  city VARCHAR(50)
);

CREATE TABLE orders (
  order_id INT PRIMARY KEY,
  customer_id INT,
  order_date DATE,
  total_amount DECIMAL(10,2),
  FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE order_items (
  item_id INT PRIMARY KEY,
  order_id INT,
  product_name VARCHAR(50),
  quantity INT,
  price_per_unit DECIMAL(10,2),
  FOREIGN KEY (order_id) REFERENCES orders(order_id)
);

INSERT INTO customers VALUES
(1, 'Amit', 'Delhi'),
(2, 'Riya', 'Mumbai'),
(3, 'Karan', 'Chennai'),
(4, 'Sita', 'Bangalore'),
(5, 'Tom', 'Kolkata');

INSERT INTO orders VALUES
(101, 1, '2024-01-15', 500.00),
(102, 2, '2024-01-20', 1200.00),
(103, 3, '2024-02-01', 800.00),
(104, 1, '2024-02-05', 1000.00),
(105, 4, '2024-02-10', 600.00);

INSERT INTO order_items VALUES
(1, 101, 'Pen', 10, 10.00),
(2, 101, 'Notebook', 5, 20.00),
(3, 102, 'Mouse', 2, 300.00),
(4, 102, 'Keyboard', 1, 600.00),
(5, 103, 'Desk Lamp', 2, 400.00),
(6, 104, 'Water Bottle', 10, 50.00),
(7, 104, 'Laptop Stand', 1, 500.00),
(8, 105, 'Book', 3, 100.00);

-- Level 1 – Basic INNER JOINS

-- Get each customer’s name and their corresponding order IDs.

-- Show all orders with their customer name and city.

-- Display all products purchased (product name) along with the name of the customer who bought them.

-- Show each order’s total amount and the sum of the product prices (quantity × price_per_unit) from order_items to verify if they match.

-- Display customer names and the number of items they bought in total across all their orders.


select c.customer_name , o.order_id
from customers c join orders o 
on c.customer_id = o.customer_id ;

select order_id , c.customer_name , c.city
from customers c join orders o 
on c.customer_id = o.customer_id ;


select p.product_name , c.customer_name
from customers c join orders o 
on c.customer_id = o.customer_id join order_items p
on o.order_id = p.order_id;



select o.order_id ,total_amount , sum(quantity * price_per_unit) as product_prices
from orders o left join order_items oi 
on o.order_id = oi.order_id
group by o.order_id , o.total_amount;


select c.customer_name , coalesce(sum(quantity) , 0 ) as total_quailty
from customers c left join orders o 
on c.customer_id = o.customer_id 
left join order_items oi
on o.order_id = oi.order_id
group by c.customer_name;



-- 🟡 Level 2 – LEFT and RIGHT JOINS

-- List all customers and their order IDs (include customers who haven’t placed any orders).

-- Show all products from order_items and include orders even if the customer info is missing (simulate partial data).

-- Get a list of customers who haven’t placed any orders yet.

-- Find any orders that don’t have corresponding items in the order_items table (edge cases).

-- Display all customers with their most recent order date — even if they never ordered.




select customer_name , GROUP_CONCAT(order_id SEPARATOR ',') AS order_ids
from customers c left join orders o
on c.customer_id = o.customer_id
group by customer_name ;



select ;




select c.customer_id , customer_name 
from customers c left join orders o
on c.customer_id = o.customer_id
where order_id is null;


select o.order_id , product_name
from orders o left join order_items oi
on o.order_id = oi.order_id
where item_id is null;


select c.customer_id , c.customer_name  , coalesce(max(order_date) , '0000 - 00 - 0')
from customers c left join orders o 
on c.customer_id = o.customer_id
group by c.customer_id , c.customer_name ;


-- Level 3 – ADVANCED JOINS (MULTI-TABLE + CONDITIONS)

-- For each customer, show their total spend (sum of order totals) and the number of distinct products purchased.

-- Show all customers who have bought at least one product with a price_per_unit > 500.

-- Find the top 3 customers by total amount spent (use ORDER BY + LIMIT).

-- For each city, find the average order amount of its customers.

-- Display customer names who have bought the same product more than once across different orders.

-- Show all customers and the total number of different products they’ve purchased (e.g., a customer who bought Pen, Book, and Mouse = 3).

-- Find the product that has generated the highest revenue (quantity × price_per_unit).

-- Display customers who have spent more than the average spending across all customers.

-- For each city, find the customer who placed the highest-value single order.

-- List all unique combinations of customers and products they have purchased (even if repeated in different orders).


select  customer_name , coalesce(sum(total_amount) , 0) 'total spend' , count(distinct product_name)
from customers c left join orders o 
on c.customer_id = o.customer_id
left join order_items oi 
on o.order_id = oi.order_id
group by customer_name  ;



select customer_name 
from customers c left join orders o 
on c.customer_id = o.customer_id
join order_items oi 
on o.order_id = oi.order_id
where price_per_unit > 500



