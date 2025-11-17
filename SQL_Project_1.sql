-- Tasks:
-- Create both tables (DDL).
-- Insert 20 sample rows.
-- Queries: total revenue, revenue by city, top 3 customers, customers with no orders , orders in last 30 days (DATE filters).
-- One subquery: customers whose total spend > average spend.

create table Customers (
CustomerID int primary key ,
Name VARCHAR(50),
  City VARCHAR(50)
);

create table Orders (
OrderID INT PRIMARY KEY,
  CustomerID INT,
  Amount INT,
  OrderDate DATE,
  FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

insert into Customers (CustomerID, Name, City) VALUES
(1, 'Rahul', 'Mumbai'),
(2, 'Sneha', 'Delhi'),
(3, 'Arjun', 'Chennai'),
(4, 'Riya', 'Kolkata'),
(5, 'Vikram', 'Hyderabad'),
(6, 'Neha', 'Bengaluru'),
(7, 'Karan', 'Pune'),
(8, 'Priya', 'Jaipur'),
(9, 'Amit', 'Surat'),
(10, 'Sara', 'Chandigarh');

INSERT INTO Orders (OrderID, CustomerID, Amount, OrderDate) VALUES
(101, 1, 55000, '2023-06-01'),
(102, 2, 2000, '2023-06-01'),
(103, 3, 12000, '2023-06-02'),
(104, 1, 2000, '2023-06-03'),
(105, 4, 1500, '2023-06-04'),
(106, 5, 3000, '2023-06-05'),
(107, 2, 4000, '2023-06-06'),
(108, 6, 800,  '2023-06-06'),
(109, 7, 15000,'2023-06-07'),
(110, 1, 4500, '2023-06-08'),
(111, 8, 2200, '2023-06-08'),
(112, 9, 1800, '2023-06-09'),
(113, 10, 7000,'2023-06-10'),
(114, 6, 2500, '2023-06-10'),
(115, 3, 9000, '2023-06-11');




-- Queries: total revenue, revenue by city, top 3 customers, customers with no orders, orders in last 30 days (DATE filters).


select CustomerID , sum(amount) As total_revenue
from orders
group by CustomerID;


select c.city , sum(amount) as revenue_by_city
from customers c join orders o 
on c.CustomerID = o.CustomerID
group by c.city ; 


select c.CustomerID ,  Name , o.amount
from customers c join orders o 
on c.CustomerID = o.CustomerID
order by Amount desc 
limit 3;


select c.CustomerID ,  Name
from customers c left join orders o 
on c.CustomerID = o.CustomerID
where orderid is null ;



select c.CustomerID ,  Name
from customers c join orders o 
on c.CustomerID = o.CustomerID
WHERE o.OrderDate >= (select min(OrderDate)
from orders ) - INTERVAL 30 DAY;


-- customers whose total spend > average spend.


select c.CustomerID ,  Name
from customers c  join orders o 
on c.CustomerID = o.CustomerID
group by c.CustomerID ,  Name
having sum(amount) > avg(amount);


