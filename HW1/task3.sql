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
WITH RECURSIVE subordinates AS (
    SELECT *
    FROM Employee
    WHERE manager_id = (
        SELECT emp_id
        FROM Employee
        WHERE name = 'Bob'
    )

    UNION ALL

    SELECT e.emp_id, e.name, e.manager_id, e.position
    FROM Employee e
    INNER JOIN subordinates s
        ON e.manager_id = s.emp_id
)
SELECT *
FROM subordinates
ORDER BY emp_id ASC;



-- Task 3.2: Find the chain of managers above Grace, ordered by emp_id in ascending order

WITH RECURSIVE managers AS (
    SELECT *
    FROM Employee
    WHERE name = 'Grace'

    UNION ALL

    SELECT e.emp_id, e.name, e.manager_id, e.position
    FROM Employee e
    INNER JOIN managers m
        ON e.emp_id = m.manager_id
)
SELECT *
FROM managers
WHERE name <> 'Grace'
ORDER BY emp_id ASC;


-- Task 3.3: Assign levels to all employees relative to CEO, ordered by level in ascending order.

WITH RECURSIVE hierarchy AS (
    SELECT 
        emp_id,
        name,
        manager_id,
        position,
        0 AS level
    FROM Employee
    WHERE manager_id IS NULL

    UNION ALL

    SELECT 
        e.emp_id,
        e.name,
        e.manager_id,
        e.position,
        h.level + 1 AS level
    FROM Employee e
    INNER JOIN hierarchy h
        ON e.manager_id = h.emp_id
)
SELECT emp_id, name, manager_id, position, level
FROM hierarchy
ORDER BY level ASC, emp_id ASC;
