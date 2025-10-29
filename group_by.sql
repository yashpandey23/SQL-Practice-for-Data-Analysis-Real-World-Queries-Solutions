CREATE TABLE sale (
    sale_id INT PRIMARY KEY,
    region VARCHAR(20),
    salesperson VARCHAR(50),
    sale_date DATE,
    product VARCHAR(50),
    quantity INT,
    unit_price DECIMAL(10,2)
);

INSERT INTO sale VALUES
(1,  'North', 'Amit', '2025-01-05', 'Pen',       10, 5.00),
(2,  'South', 'Riya', '2025-01-06', 'Notebook',   5, 25.00),
(3,  'North', 'Amit', '2025-02-10', 'Notebook',   2, 25.00),
(4,  'West',  'Karan','2025-03-15', 'Mouse',      3, 499.00),
(5,  'South', 'Sita', '2025-03-20', 'Pen',       20, 5.00),
(6,  'East',  'Tom',  '2025-04-01', 'Keyboard',   1, 799.00),
(7,  'North', 'Amit', '2025-04-15', 'Desk Lamp',  1, 850.00),
(8,  'South', 'Riya', '2025-05-12', 'Mouse',      2, 499.00),
(9,  'West',  'Karan','2025-06-05', 'Pen',       50, 5.00),
(10, 'East',  'Lucy', '2025-06-20', 'Notebook',  10, 25.00),
(11, 'North', 'Sita', '2025-07-01', 'Keyboard',   2, 799.00),
(12, 'South', 'Riya', '2025-07-10', 'Pen',       30, 5.00);

-- QUESTIONS (GROUP BY-focused) — 10 items
select * from sale;

-- For each salesperson, compute total revenue (SUM(quantity * unit_price)).
select sale_id , region , salesperson ,sale_date, product, quantity,unit_price,(SUM(quantity * unit_price)) as "total revenue"
from sale
group by salesperson,sale_date, product, quantity,unit_price,sale_id , region ;

-- For each region, compute total quantity sold.
select region , sum(quantity)
from sale
group by region;

-- For each product, compute the average unit_price.
select product , avg(unit_price)
from sale
group by product;

-- For each region, compute total revenue and show only regions with revenue > 1000 (use HAVING).
select region , (SUM(quantity * unit_price)) "total revenue"
from sale 
group by region 
having  (SUM(quantity * unit_price)) > 1000;

-- For each salesperson, count distinct products they sold.

select salesperson ,  count(distinct(product))
from sale 
group by salesperson ;

-- Compute monthly revenue (group by month extracted from sale_date).

select monthNAME(sale_date) , (SUM(quantity * unit_price)) "total revenue"
from sale
group by month(sale_date);

-- For each region, find the top salesperson by revenue (tie-breaking not required).

select distinct(region) , max(salesperson) , (SUM(quantity * unit_price)) as "total_revenue"
from sale
group by region;



-- List salespeople whose total sold quantity >= 10 (use HAVING).

select salesperson , sum(quantity) as total_quantity 
from sale 
group by salesperson
having sum(quantity) >= 10;

-- Compute revenue share (%) for each salesperson (revenue / total_revenue * 100) rounded to 2 decimals.

select salesperson , (SUM(quantity * unit_price)) as revenue , round (((SUM(quantity * unit_price)) / 6717.00 * 100) ,2) as share_pct
from sale 
group by salesperson;

-- Categorize salespeople as 'High' if their revenue >= 1500 else 'Low', then show counts and total revenue per category (use CASE in GROUP BY or a derived grouping expression).
select 
		case when revenue >=1500 then 'High'
        else 'Low'
        end as  Categorize , count(*) , sum(revenue) 
from(select salesperson , 
			SUM(quantity * unit_price) as revenue
	 from sale
     group by salesperson) as t 
group by case when revenue >=1500 then 'High'
        else 'Low'
        end 
        