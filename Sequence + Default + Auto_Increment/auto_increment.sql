CREATE DATABASE airlines;
use airlines;

CREATE TABLE nd_airlines
(
id INT AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(90)
)
AUTO_INCREMENT = 100;

-- INSERT A ROW, ID WILL BE AUTOMATICALLY GENERATED
INSERT INTO nd_airlines (name)
VALUES 
	('United Airlines'),
	('Indigo'),
	('Air Asia'),
	('Go Air'),
	('Vistara'),
	('Spicejet'),
	('Air India');
    
INSERT INTO nd_airlines (id,name)
VALUES (150,'Air France'),
		(null,'KLM');
        
INSERT IGNORE INTO nd_airlines
VALUES 
(150,'North Air'),
(0,'Emirates'),
(0,'Qantas');

-- this row will be skipped as ID 150 already exists and IGNORE option
-- RESET ID

ALTER TABLE nd_airlines AUTO_INCREMENT = 1;
INSERT INTO nd_airlines (name) VALUES ('US Airways');
-- you cannot reset the auto_increment counter to the start value less or equal than the current maximum id.

## FOR DELETION
SET SQL_SAFE_UPDATES = 0;

DELETE FROM nd_airlines;
INSERT INTO nd_airlines (name)
VALUES ('United');
-- IT WILL ALWAYS TAKE THE LAST ID

SELECT * FROM nd_airlines;

Refer this link compulsary
https://www.sqlines.com/mysql/auto_increment