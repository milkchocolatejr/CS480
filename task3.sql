DROP DATABASE IF EXISTS hw_prog_1;
CREATE DATABASE hw_prog_1;
USE hw_prog_1;

CREATE TABLE Employee (
    emp_id INT PRIMARY KEY,
    name VARCHAR(100),
    manager_id INT,
    position VARCHAR(50)
);


INSERT INTO Employee VALUES
(1, 'Alice', NULL, 'CEO'),        
(2, 'Bob', 1, 'CTO'),            
(3, 'Carol', 1, 'CFO'),           
(4, 'Dave', 2, 'Senior Engineer'),
(5, 'Eve', 2, 'Engineer'),        
(6, 'Frank', 3, 'Accountant'),    
(7, 'Grace', 4, 'Intern');


-- Task 3.1: Find all subordinates of Bob, ordered by emp_id in ascending order.



-- Task 3.2: Find the chain of managers above Grace, ordered by emp_id in ascending order



-- Task 3.3: Assign levels to all employees relative to CEO, ordered by level in ascending order.
