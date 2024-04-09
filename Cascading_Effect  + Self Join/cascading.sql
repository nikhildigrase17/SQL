-- The following statement creates a table Employee:
CREATE DATABASE CASCADING;
USE CASCADING;

DROP TABLE employee;
DROP TABLE Payment;
CREATE TABLE Employee (  
  emp_id int(10) NOT NULL,  
  name varchar(40) NOT NULL,  
  birthdate date NOT NULL,  
  gender varchar(10) NOT NULL,  
  hire_date date NOT NULL,  
  PRIMARY KEY (emp_id)  
);

-- Next, execute the insert query to fill the records.

INSERT INTO Employee (emp_id, name, birthdate, gender, hire_date) VALUES  
(101, 'Bryan', '1988-08-12', 'M', '2015-08-26'),  
(102, 'Joseph', '1978-05-12', 'M', '2014-10-21'),  
(103, 'Mike', '1984-10-13', 'M', '2017-10-28'),  
(104, 'Daren', '1979-04-11', 'M', '2006-11-01'),  
(105, 'Marie', '1990-02-11', 'F', '2018-10-12');  

SELECT * FROM   Employee;

-- The below statement creates a table Payment:

CREATE TABLE Payment (  
  payment_id int(10) PRIMARY KEY NOT NULL,  
  emp_id int(10) NOT NULL,  
  amount float NOT NULL,  
  payment_date date NOT NULL,  
  FOREIGN KEY (emp_id) REFERENCES Employee (emp_id) ON DELETE CASCADE ON UPDATE CASCADE -- ASK THIS BEFORE IMPLIMENTING
);  

-- Next, execute the insert statement to fill the records into a table.

INSERT INTO Payment (payment_id, emp_id, amount, payment_date) VALUES   
(301, 101, 1200, '2015-09-15'),  
(302, 101, 1200, '2015-09-30'),  
(303, 101, 1500, '2015-10-15'),  
(304, 101, 1500, '2015-10-30'),  
(305, 102, 1800, '2015-09-15'),  
(306, 102, 1800, '2015-09-30');  

SELECT * FROM Payment;

CREATE TABLE ND_MASTERTABLE_CASCADE AS
SELECT E.emp_id, E.name, E.birthdate, E.gender,P.payment_id, P.amount, E.hire_date, P.payment_date
FROM Employee E
LEFT OUTER JOIN Payment P ON E.emp_id = P.emp_id;

SELECT * FROM ND_MASTERTABLE_CASCADE;

-- Let us delete data from the parent table Employee. To do this, execute the following statement:
DELETE FROM Employee WHERE emp_id = 102;  

DELETE FROM Payment WHERE emp_id = 101;  

-- How to find the affected table by ON DELETE CASCADE action?
USE information_schema;  
SELECT table_name FROM referential_constraints  
WHERE constraint_schema = 'CASCADING'  
        AND referenced_table_name = 'Employee'  
        AND delete_rule = 'CASCADE';  
        
-- First, we need to use the ALTER TABLE statement to add the ON UPDATE CASCADE clause in the table Payment as below:
-- ALTER TABLE Payment ADD CONSTRAINT `payment_fk`   
-- FOREIGN KEY(emp_id) REFERENCES Employee (emp_id) ON UPDATE CASCADE;

SELECT * FROM Payment;

UPDATE Employee SET emp_id = 107 WHERE emp_id = 103;
SELECT * FROM Employee;

-- https://www.javatpoint.com/mysql-on-delete-cascade (OPEN WHILE REVISING)