/*The Full Join (Also known as Full Outer join) includes the rows from both the tables. 
Wherever the rows do not match a null value is assigned to every column of the table that does not have a matching row. 
A Full join looks like a Right Join & Left Join combined together in one query. 

Syntax
The syntax of the Full join is as follows
 
SELECT <Columns>   
FROM tableA 
FULL JOIN tableB
ON (join_condition)

The matching rows from both tables
All the unmatched rows from Table A with null for columns from Table B
All the unmatched rows from Table B with null for columns from Table A
 
The join_condition defines the condition on which the tables are joined.

All the rows from both the tables are included in the final result. 
A NULL value is assigned to every column of the table that does not have a matching row based on the join condition.

The FULL OUTER JOIN & FULL JOIN are the same. The Keyword OUTER is optional

Sample database
Consider the following tables from the table reservation system of a restaurant. You can use the following script to create the database

CustomerType : Type of Customer like VIP / Regular etc
Customers List of customers with Customer Type.
Tables The list of tables available in the restaurant. CustomerID field indicates that the customer has reserved the table.
Orders : The orders placed by the customer
DiscVoucher The discounts slab based on the total value of the order

*/

USE DEMODATABASE;

CREATE OR REPLACE TABLE LOAN_TABLE(
LOAN_ID INT,
LOAN_STATUS VARCHAR(15),
STATE VARCHAR(25),
LOAN_AMOUNT INT,
AP_DATE DATE);

INSERT INTO LOAN_TABLE 
VALUES
(12,'OPEN','RANCHI',30000,'2015-02-01'),
(23,'CLOSE','PATNA',50000,'2017-04-03'),
(31,'PENDING','KOLKATA',80000,'2018-07-09'),
(43,'APPROVAL','MUMBAI',54000,'2019-11-10'),
(11,'REJECTED','BANGLORE',43000,'2014-04-03'),
(33,'CLOSE','PATNA',9000,'2018-07-09'),
(44,'OPEN','KOLKATA',67000,'2020-01-01');

CREATE OR REPLACE TABLE BORROWER(
LOAN_ID INT,
BORROWER_NAME VARCHAR(20),
BORROWER_DATE DATE,
BANK_ID CHAR(2));

INSERT INTO BORROWER
VALUES
(12,'RAM','2014-07-09','A1'),
(27,'SUNDAR','2016-06-19','A2'),
(43,'BROWNY','2019-07-16','A4'),
(31,'BLACKY','2015-07-09','A2');

SELECT L.LOAN_ID,
L.LOAN_STATUS,
B.BORROWER_DATE
FROM LOAN_TABLE AS L
FULL OUTER JOIN BORROWER AS B
ON L.LOAN_ID = B.LOAN_ID;

-- IF WE WANT TO IGNORE NULLS

SELECT L.LOAN_ID,
L.LOAN_STATUS,
B.BORROWER_DATE
FROM LOAN_TABLE AS L
FULL OUTER JOIN BORROWER AS B
ON L.LOAN_ID = B.LOAN_ID
WHERE B.BORROWER_DATE IS NOT NULL AND L.LOAN_ID IS NOT NULL;


SELECT L.LOAN_ID,
L.LOAN_STATUS,
B.BORROWER_NAME,
B.BORROWER_DATE,
L.STATE,
L.LOAN_AMOUNT
FROM LOAN_TABLE AS L
FULL OUTER JOIN BORROWER AS B
ON L.LOAN_ID = B.LOAN_ID;
