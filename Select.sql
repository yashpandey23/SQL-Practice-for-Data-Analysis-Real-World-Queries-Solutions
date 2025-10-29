-- Create table
-- CREATE TABLE products (
--     product_id INT PRIMARY KEY,
--     product_name VARCHAR(100),
--     category VARCHAR(50),
--     price DECIMAL(10,2),
--     stock INT,
--     launch_date DATE
-- );

-- Insert sample data
-- INSERT INTO products VALUES
-- (1, 'Pen', 'Stationery', 5.00, 100, '2025-01-10'),
-- (2, 'Notebook', 'Stationery', 25.00, 200, '2024-11-05'),
-- (3, 'Stapler', 'Stationery', 150.00, 50, '2023-06-20'),
-- (4, 'Water Bottle', 'Home', 120.00, 80, '2025-03-15'),
-- (5, 'Desk Lamp', 'Electronics', 850.00, 30, '2022-12-01'),
-- (6, 'Mouse', 'Electronics', 499.00, 150, '2024-05-10'),
-- (7, 'Keyboard', 'Electronics', 799.00, 60, '2024-07-22'),
-- (8, 'Pen Set', 'Stationery', 45.00, NULL, '2025-06-01');


-- QUESTIONS (SELECT-focused) — 10 items

-- Select all columns for every product.

select * from products;

-- Select only product_name and price.

select product_name , price 
from products ; 

-- Select the distinct category values.

select distinct category 
from products;

-- Select product_name and compute price * 1.10 as price_with_tax.

select product_name , price*1.10 as price_with_tax 
from products;

-- Select a label combining name and category in one column (e.g., product_name - category).

select concat_ws( " - ", product_name , category) as label 
from products;

-- Select product_name and cast price to integer.

select product_name , round(price , 0) AS price_integer
from products;

-- Select product_name and replace NULL stock with 0.

select product_name  , coalesce(stock , 0)  -- , ifnull(stock , 0)
from products;

-- Select product_name and its name length.

select product_name , length(product_name) as length 
from products;

-- Select product_name and the launch year extracted from launch_date.

select product_name , year(launch_date)
from products;

-- Select the top 3 most expensive product names (price desc).

select product_name
from  products
order by price desc
limit 3 



