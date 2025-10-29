CREATE TABLE sales (
  sale_id INT,
  region VARCHAR(50),
  category VARCHAR(50),
  product_name VARCHAR(100),
  quantity INT,
  unit_price DECIMAL(10,2),
  sale_date DATE
);

INSERT INTO sales VALUES
(1, 'North', 'Electronics', 'Laptop', 5, 50000, '2024-01-10'),
(2, 'South', 'Electronics', 'Mobile', 10, 15000, '2024-02-15'),
(3, 'East', 'Furniture', 'Chair', 20, 1500, '2024-02-18'),
(4, 'West', 'Electronics', 'TV', 8, 40000, '2024-03-01'),
(5, 'North', 'Furniture', 'Table', 5, 8000, '2024-03-20'),
(6, 'East', 'Electronics', 'Headphones', 15, 3000, '2024-04-02'),
(7, 'South', 'Clothing', 'T-shirt', 50, 500, '2024-05-12'),
(8, 'West', 'Clothing', 'Jacket', 10, 3000, '2024-06-05'),
(9, 'North', 'Electronics', 'Laptop', 3, 52000, '2024-07-20'),
(10, 'East', 'Clothing', 'Shoes', 25, 2000, '2024-08-11'),
(11, 'South', 'Furniture', 'Sofa', 2, 30000, '2024-08-25'),
(12, 'West', 'Furniture', 'Chair', 15, 1800, '2024-09-05'),
(13, 'North', 'Electronics', 'Mobile', 6, 17000, '2024-09-22'),
(14, 'South', 'Electronics', 'Laptop', 4, 49000, '2024-10-01'),
(15, 'East', 'Clothing', 'Jeans', 30, 1200, '2024-10-15');



-- Write a SQL query to find the top 3 regions (based on total revenue) that have at least 2 product categories whose average revenue per sale exceeds 25,000.

-- Show region name, number of qualifying categories, and total revenue.

-- Sort the result by total revenue (highest first).

-- If two regions have the same total revenue, order them alphabetically.

-- Finally, display only the top 3 results.


