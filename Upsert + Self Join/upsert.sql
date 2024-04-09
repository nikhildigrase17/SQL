CREATE DATABASE UPSERT;
USE UPSERT;
DROP TABLE ND_STUDENTS;
CREATE TABLE ND_Student (  
  Stud_ID int AUTO_INCREMENT PRIMARY KEY,  
  Name varchar(45) DEFAULT NULL,  
  Email varchar(45) NOT NULL UNIQUE,  
  City varchar(25) DEFAULT NULL  
);  

INSERT INTO ND_Student(Stud_ID, Name, Email, City)   
VALUES (1,'Stephen', 'stephen@javatpoint.com', 'Texas'),   
(2, 'Joseph', 'Joseph@javatpoint.com', 'Alaska'),   
(3, 'Peter', 'Peter@javatpoint.com', 'California');  

SELECT * FROM ND_STUDENT;

INSERT INTO ND_Student(Stud_ID, Name, Email, City)   
VALUES (4,'Donald', 'donald@javatpoint.com', 'New York'),   
(5, 'Joseph', 'Joseph@javatpoint.com', 'Chicago');

-- After the above statement's execution, we will see the error: ERROR 1062 (23000):
-- Duplicate entry 'Joseph@javatpoint.com' for key 'student.Email' because of the email violets the UNIQUE constraint.
-- But, when we perform the same statement using the INSERT IGNORE command, we have not received any error. Instead, we receive a warning only.

INSERT IGNORE INTO ND_Student(Stud_ID, Name, Email, City)   
VALUES (4,'Donald', 'donald@javatpoint.com', 'New York'),   
(5, 'Joseph', 'Joseph@javatpoint.com', 'Chicago'); 

-- Now, we will use the REPLACE statement to update the city of the student whose id = 2 
-- with the new city Los Angeles. To do this, execute the following statement:

REPLACE INTO ND_Student(Stud_ID, Name, Email, City)  
VALUES(2, 'Joseph', 'joseph@javatpoint.com', 'Los Angeles');  

INSERT INTO ND_Student(Stud_ID, Name, Email, City)   
VALUES (5,'John', 'john@javatpoint.com', 'New York');  -- ERROR DUPLICATE

INSERT INTO ND_Student(Stud_ID, Name, Email, City)   
VALUES (5, 'John', 'john@javatpoint.com', 'New York')  
ON DUPLICATE KEY UPDATE City = 'California';  

 