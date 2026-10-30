#First create a database

CREATE database rohit_db;

USE rohit_db;

CREATE TABLE employees(
      emp_id INT,
      name VARCHAR(50),
      salary DECIMAL(10,2),
      department VARCHAR(50),
      city VARCHAR(50)
      );
      
INSERT INTO employees
(emp_id, name, salary, department, city)
VALUES
(101, 'Amit', 55000, 'IT', 'Delhi'),
(102, 'Rahul', 72000, 'HR', 'Gurgaon'),
(103, 'Priya', 68000, 'Finance', 'Mumbai'),
(104, 'Neha', 90000, 'IT', 'Bangalore'),
(105, 'Ravi', 45000, 'Sales', 'Delhi'),
(106, 'Sneha', 85000, 'Finance', 'Pune'),
(107, 'Vikas', 62000, 'IT', 'Noida'),
(108, 'Anjali', 75000, 'HR', 'Delhi'),
(109, 'Karan', 95000, 'Sales', 'Mumbai'),
(110, 'Pooja', 58000, 'Finance', 'Delhi'),
(111, 'Arjun', 82000, 'IT', 'Pune'),
(112, 'Meena', 47000, 'HR', 'Noida'),
(113, 'Rohit', 88000, 'Sales', 'Bangalore'),
(114, 'Kavya', 66000, 'Finance', 'Mumbai'),
(115, 'Suresh', 91000, 'IT', 'Delhi'),
(116, 'Nisha', 54000, 'HR', 'Pune'),
(117, 'Manish', 78000, 'Sales', 'Delhi'),
(118, 'Simran', 63000, 'Finance', 'Noida'),
(119, 'Deepak', 99000, 'IT', 'Bangalore'),
(120, 'Tanya', 70000, 'Sales', 'Pune');

SELECT COUNT(*) FROM employees;

CREATE TABLE bonus(
       emp_id INT,
       name VARCHAR(50),
       bonus DECIMAL(10,2),
       department VARCHAR(50)
);

INSERT INTO bonus
(emp_id, name, bonus, department)
VALUES
(101, 'Amit', 5000, 'IT'),
(102, 'Rahul', 7000, 'HR'),
(104, 'Neha', 10000, 'IT'),
(109, 'Karan', 12000, 'Sales'),
(111, 'Arjun', 8000, 'IT'),
(113, 'Rohit', 9000, 'Sales'),
(115, 'Suresh', 11000, 'IT'),
(119, 'Deepak', 15000, 'IT');

SELECT * FROM bonus;

#Ques 1 : Find the 3rd highest salary from the employee table using normal SQL.
SELECT  DISTINCT salary 
FROM employees
ORDER BY salary desc 
LIMIT 1 OFFSET 2;

#Ques 2: find the 3rd highest salary from the employee table using window function
SELECT emp_id,name,salary
FROM ( 
SELECT emp_id,
       name,
       salary,
       dense_rank() over(order by salary desc ) as salary_rank
FROM employees) as ranked_employees
WHERE salary_rank = 3;

#Ques 3: 3rd Highest Salary Using CTE
WITH salary_rank as (
SELECT 
      emp_id,
      name,
      salary,
      DENSE_RANK() OVER(ORDER BY salary DESC) as sal_rank
FROM employees) 
SELECT *
FROM salary_rank
WHERE sal_rank = 3;

#Ques- 4: Create second database + CTAS(create table as select)
CREATE DATABASE rohit_db2;

USE rohit_db2;

SELECT DATABASE();

CREATE TABLE employees AS
SELECT * 
FROM rohit_db.employees;

SELECT * FROM employees;

# Ques- 5: Find duplicate employees_id
SELECT emp_Id, COUNT(*) as occurrence 
FROM employees
GROUP BY 1
HAVING COUNT(*) > 1;

#Ques- 6: Highest salary by department
SELECT emp_id,
       salary,
       department
FROM (
SELECT emp_id,
       salary,
       department,
       DENSE_RANK() OVER(PARTITION BY department ORDER BY salary DESC) as sal_rank
FROM employees) as ranked_sal
WHERE sal_rank = 1;

SELECT department,
       MAX(salary)
FROM employees
GROUP BY department;

#Ques- 7 Create sales and orders tables
USE rohit_db;

SELECT DATABASE();

CREATE TABLE sales (
    sale_id INT,
    emp_id INT,
    product VARCHAR(50),
    amount DECIMAL(10,2),
    sale_date DATE,
    city VARCHAR(50)
);

INSERT INTO sales
(sale_id, emp_id, product, amount, sale_date, city)
VALUES
(1, 101, 'Laptop', 75000, '2026-01-05', 'Delhi'),
(2, 102, 'Mouse', 1500, '2026-01-06', 'Gurgaon'),
(3, 103, 'Keyboard', 2500, '2026-01-07', 'Mumbai'),
(4, 104, 'Monitor', 18000, '2026-01-08', 'Bangalore'),
(5, 105, 'Laptop', 65000, '2026-01-10', 'Delhi'),
(6, 106, 'Mouse', 1800, '2026-01-11', 'Pune'),
(7, 107, 'Keyboard', 3000, '2026-01-12', 'Noida'),
(8, 108, 'Monitor', 22000, '2026-01-13', 'Delhi'),
(9, 109, 'Laptop', 80000, '2026-01-15', 'Mumbai'),
(10, 110, 'Mouse', 1200, '2026-01-16', 'Delhi'),
(11, 111, 'Monitor', 20000, '2026-01-17', 'Pune'),
(12, 112, 'Keyboard', 2800, '2026-01-18', 'Noida'),
(13, 113, 'Laptop', 85000, '2026-01-20', 'Bangalore'),
(14, 114, 'Mouse', 1400, '2026-01-21', 'Mumbai'),
(15, 115, 'Monitor', 25000, '2026-01-22', 'Delhi'),
(16, 116, 'Keyboard', 3200, '2026-01-23', 'Pune'),
(17, 117, 'Laptop', 70000, '2026-01-24', 'Delhi'),
(18, 118, 'Mouse', 1600, '2026-01-25', 'Noida'),
(19, 119, 'Monitor', 27000, '2026-01-26', 'Bangalore'),
(20, 120, 'Laptop', 72000, '2026-01-27', 'Pune');

CREATE TABLE orders (
    order_id INT,
    emp_id INT,
    product VARCHAR(50),
    quantity INT,
    order_amount DECIMAL(10,2),
    order_date DATE
);

INSERT INTO orders
(order_id, emp_id, product, quantity, order_amount, order_date)
VALUES
(1001, 101, 'Laptop', 1, 75000, '2026-01-05'),
(1002, 102, 'Mouse', 2, 3000, '2026-01-06'),
(1003, 103, 'Keyboard', 1, 2500, '2026-01-07'),
(1004, 104, 'Monitor', 1, 18000, '2026-01-08'),
(1005, 105, 'Laptop', 1, 65000, '2026-01-10'),
(1006, 106, 'Mouse', 3, 4500, '2026-01-11'),
(1007, 107, 'Keyboard', 2, 6000, '2026-01-12'),
(1008, 108, 'Monitor', 1, 22000, '2026-01-13'),
(1009, 109, 'Laptop', 1, 80000, '2026-01-15'),
(1010, 110, 'Mouse', NULL, 1200, '2026-01-16'),
(1011, 111, 'Monitor', 1, NULL, '2026-01-17'),
(1012, 112, 'Keyboard', 2, 5600, '2026-01-18'),
(1013, 113, 'Laptop', 1, 85000, '2026-01-20'),
(1014, 114, 'Mouse', NULL, 1400, '2026-01-21'),
(1015, 115, 'Monitor', 1, 25000, '2026-01-22'),
(1016, 116, 'Keyboard', 2, 6400, '2026-01-23'),
(1017, 117, 'Laptop', 1, 70000, '2026-01-24'),
(1018, 118, 'Mouse', 2, 3200, '2026-01-25'),
(1019, 119, 'Monitor', 1, 27000, '2026-01-26'),
(1020, 120, 'Laptop', 1, 72000, '2026-01-27');


#find employees where total sales + bonus > annual salary 
use rohit_db;

WITH sale_per_employee as (SELECT emp_id,
       sum(amount) as total_sale
FROM sales
GROUP BY emp_id),
bonus_per_employee as (
SELECT emp_id,
       sum(bonus) as total_bonus
FROM bonus
GROUP BY emp_id)
SELECT e.emp_id,
       e.name,
       e.department,
       e.salary,
       COALESCE(bp.total_bonus,0) as total_bonus,
       COALESCE(sp.total_sale,0) as total_sale,
       COALESCE(bp.total_bonus,0) + COALESCE(sp.total_sale,0) as sale_plus_bonus
FROM employees e
LEFT JOIN sale_per_employee sp
on  e.emp_id = sp.emp_id
LEFT JOIN bonus_per_employee bp
on e.emp_id = bp.emp_id
WHERE (COALESCE(bp.total_bonus,0) +
       COALESCE(sp.total_sale,0)) > e.salary  ;     

#Highest selling product in each city
WITH product_sales as 
(SELECT
       product,
       city,
       sum(amount) as total_amount
FROM sales
GROUP BY product,city),
ranked_sales as (SELECT *,
       RANK() OVER(PARTITION BY city ORDER BY total_amount DESC) as rnk_sales
FROM product_sales )
SELECT *
FROM ranked_sales 
WHERE rnk_sales = 1;

INSERT INTO sales (emp_id, product, amount, sale_date, city)
VALUES
(101, 'Laptop', 85000, '2026-02-10', 'Delhi'),
(101, 'Laptop', 95000, '2026-03-15', 'Delhi'),

(102, 'Mobile', 2200, '2026-02-12', 'Mumbai'),
(102, 'Mobile', 3000, '2026-03-18', 'Mumbai'),

(103, 'Tablet', 3500, '2026-02-08', 'Pune'),
(103, 'Tablet', 2800, '2026-03-20', 'Pune'),

(104, 'Monitor', 22000, '2026-02-14', 'Delhi'),
(104, 'Monitor', 25000, '2026-03-22', 'Delhi'),

(105, 'Laptop', 70000, '2026-02-11', 'Bangalore'),
(105, 'Laptop', 80000, '2026-03-17', 'Bangalore');

#Employees monthly sales growth(month over month sales growth)
WITH monthly_sales as(
SELECT emp_id,
       date_format(sale_date , '%Y-%m') as month,
       sum(amount) as sale
FROM sales
GROUP BY 1,2),
compare_sales as (
SELECT emp_id,
        month,
       LAG(sale) OVER (PARTITION BY emp_id ORDER BY month) as previous_month_sale,
       sale as current_month_sale
FROM monthly_sales)
SELECT *,
      round((((current_month_sale - NULLIF(previous_month_sale,0))/ NULLIF(previous_month_sale,0))*100),2)as growth_percentage
FROM compare_sales;















       



































      