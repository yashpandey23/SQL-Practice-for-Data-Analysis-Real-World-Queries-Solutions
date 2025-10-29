-- CREATE TABLE orders (
--     order_id INT PRIMARY KEY,
--     customer VARCHAR(50),
--     city VARCHAR(50),
--     order_date DATE,
--     amount DECIMAL(10,2),
--     status VARCHAR(20),
--     quantity INT
-- );

-- INSERT INTO orders VALUES
-- (1, 'Amit',  'Mumbai',  '2025-09-01',  500.00,  'Completed', 2),
-- (2, 'Riya',  'Delhi',   '2025-09-03', 1500.00,  'Pending',   1),
-- (3, 'Karan', 'Mumbai',  '2025-08-28',  200.00,  'Completed', 5),
-- (4, 'Sita',  'Bengaluru','2025-09-02',  800.00,  'Cancelled', 1),
-- (5, 'Amit',  'Hyderabad','2025-07-15', 1200.00,  'Completed', 1),
-- (6, 'Riya',  'Mumbai',  '2025-06-20',   50.00,  'Completed',10),
-- (7, 'Tom',   'Delhi',   '2025-09-10',  300.00,  'Pending',   3),
-- (8, 'Lucy',  'Chennai', '2024-12-25',  250.00,  'Completed', 2),
-- (9, 'Karan', 'Mumbai',  '2025-09-11', 1000.00,  'Completed', 1),
-- (10,'Sita',  'Delhi',   '2025-01-05',  400.00,  'Completed', 2),
-- (11,'Amit',  'Mumbai',  '2025-09-12',    0.00,  'Refunded',  0),
-- (12,'Riya',  NULL,      '2025-09-15',  600.00,  'Completed', 2);

-- QUESTIONS (WHERE-focused) — 10 items

-- Select all orders where city = 'Mumbai'.

select * 
from orders
where city = 'Mumbai';

-- Select orders with amount > 500.

select * 
from orders 
where amount > 500;

-- Select orders where status is in ('Pending', 'Cancelled').

select * 
from orders 
where status in ('Pending', 'Cancelled');

-- Select orders with order_date between 2025-09-01 and 2025-09-12 (inclusive).

select * 
from orders 
where order_date between date('2025-09-01') and date('2025-09-12');

-- Select orders where customer starts with 'A'.
select * 
from orders
where customer like 'A%' ; 

-- Select orders where city IS NULL.

select * 
from orders
where city is null ;

-- Select orders where quantity = 0 OR amount = 0.
select * 
from orders 
where quantity = 0 or amount = 0 ;

-- Select orders where NOT (status = 'Completed').

select * 
from orders 
where status != 'completed';

-- Select orders where city is in the set of cities that have at least one order with amount >= 1000. (Use a subquery.)

select * 
from orders 
where city in (select city from orders) or amount >=1000;

-- Select orders where (city = 'Mumbai' AND amount >= 500) OR (status = 'Pending').
select * 
from orders 
where (city = 'Mumbai' AND amount >= 500) OR (status = 'Pending');