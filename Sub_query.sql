-- TABLE CREATION
CREATE TABLE departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(50),
    budget DECIMAL(12,2),
    location VARCHAR(50)
);

CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    department_id INT,
    salary DECIMAL(10,2),
    hire_date DATE,
    performance_rating INT,
    FOREIGN KEY (department_id) REFERENCES departments(department_id)
);

CREATE TABLE projects (
    project_id INT PRIMARY KEY,
    project_name VARCHAR(100),
    department_id INT,
    budget DECIMAL(12,2),
    start_date DATE,
    end_date DATE,
    status VARCHAR(20),
    FOREIGN KEY (department_id) REFERENCES departments(department_id)
);

CREATE TABLE sales (
    sale_id INT PRIMARY KEY,
    employee_id INT,
    sale_amount DECIMAL(10,2),
    sale_date DATE,
    region VARCHAR(50),
    product_category VARCHAR(50),
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id)
);

-- SAMPLE DATA INSERTION
INSERT INTO departments VALUES 
(1, 'Engineering', 500000.00, 'New York'),
(2, 'Sales', 300000.00, 'Chicago'),
(3, 'Marketing', 200000.00, 'Boston'),
(4, 'HR', 150000.00, 'New York'),
(5, 'Finance', 250000.00, 'Chicago');

INSERT INTO employees VALUES 
(1, 'John', 'Smith', 1, 85000, '2020-03-15', 4),
(2, 'Sarah', 'Johnson', 2, 75000, '2021-06-20', 5),
(3, 'Mike', 'Davis', 1, 95000, '2019-11-10', 3),
(4, 'Emily', 'Wilson', 2, 70000, '2022-01-05', 4),
(5, 'David', 'Brown', 3, 65000, '2020-08-30', 5),
(6, 'Lisa', 'Anderson', 1, 88000, '2021-09-12', 4),
(7, 'Kevin', 'Miller', 4, 60000, '2022-03-22', 3),
(8, 'Amy', 'Clark', 2, 72000, '2020-12-01', 5),
(9, 'Chris', 'Lee', 3, 68000, '2021-04-18', 4),
(10, 'Maria', 'Garcia', 5, 80000, '2019-07-25', 5);

INSERT INTO projects VALUES 
(1, 'Website Redesign', 3, 50000, '2023-01-15', '2023-06-15', 'Completed'),
(2, 'CRM Implementation', 2, 75000, '2023-02-01', '2023-08-01', 'In Progress'),
(3, 'Mobile App Development', 1, 120000, '2023-03-10', '2023-12-10', 'In Progress'),
(4, 'Employee Training', 4, 30000, '2023-04-05', '2023-05-05', 'Completed'),
(5, 'Financial System Upgrade', 5, 90000, '2023-05-20', '2023-11-20', 'In Progress');

INSERT INTO sales VALUES 
(1, 2, 15000, '2023-01-10', 'East', 'Software'),
(2, 4, 8000, '2023-01-15', 'West', 'Hardware'),
(3, 2, 22000, '2023-02-05', 'East', 'Software'),
(4, 8, 12000, '2023-02-12', 'North', 'Services'),
(5, 4, 18000, '2023-03-08', 'West', 'Hardware'),
(6, 2, 25000, '2023-03-20', 'East', 'Software'),
(7, 8, 9000, '2023-04-02', 'North', 'Services'),
(8, 4, 16000, '2023-04-18', 'West', 'Hardware'),
(9, 2, 19000, '2023-05-10', 'East', 'Software'),
(10, 8, 14000, '2023-05-25', 'North', 'Services');




-- Single-row Subquery: Find all employees who earn more than the average salary of their department

SELECT
    first_name,
    last_name,
    salary,
    department_id
FROM
    employees e1
WHERE
    salary > (
        SELECT
            AVG(salary)
        FROM
            employees e2
        WHERE
            e2.department_id = e1.department_id
    );



-- Multi-row Subquery with IN: Find all employees who work in departments that have projects with budgets exceeding $70,000.


select employee_id , first_name , last_name , department_id 
from employees 
where department_id in (select department_id from projects where budget > 70000);


-- Find employees whose salary is greater than ANY employee in the Marketing department.

select employee_id , first_name , last_name , department_id , salary
from employees 
where salary > any(select salary from employees where department_id = (select department_id from departments where department_name = 'Marketing'));

--  Find employees who have the highest salary in their respective departments and also have above-average performance ratings.

select first_name , last_name , salary
from employees e1
where 
salary in (select max(salary) from employees e2 where e2.department_id = e1.department_id) 
and 
performance_rating > (select avg(performance_rating) from employees );


-- Calculate the average salary difference between each employee and their department's average salary, then find departments where this average difference exceeds $5,000.

WITH employee_differences AS (
    SELECT 
        department_id,
        first_name,
        last_name,
        salary,
        AVG(salary) OVER (PARTITION BY department_id) as dept_avg_salary,
        salary - AVG(salary) OVER (PARTITION BY department_id) as individual_difference
    FROM employees
),
department_stats AS (
    SELECT 
        department_id,
        AVG(ABS(individual_difference)) as avg_abs_difference_per_dept
    FROM employee_differences
    GROUP BY department_id
)
SELECT 
    d.department_name,
    ds.avg_abs_difference_per_dept
FROM department_stats ds
JOIN departments d ON ds.department_id = d.department_id
WHERE ds.avg_abs_difference_per_dept > 1000;




















 

