USE DATABASE DEMO_DATABASE;

CREATE OR REPLACE TABLE ND_AGENTS
(
AGENT_CODE CHAR(6) NOT NULL PRIMARY KEY,
AGENT_NAME CHAR(40),
WORKING_AREA CHAR(35),
COMMISSION NUMBER(10,2) DEFAULT 0.05,
PHONE_NO CHAR(15),
COUNTRY VARCHAR(25)
);

INSERT INTO ND_AGENTS VALUES ('A007', 'Ramasundar', 'Bangalore',0.15,'077-25814763', '');
INSERT INTO ND_AGENTS(AGENT_CODE,AGENT_NAME,WORKING_AREA) 
VALUES ('A110', 'Anand', 'Germany');
INSERT INTO ND_AGENTS 
VALUES  ('A003', 'Alex ', 'London', '0.13', '075-12458969', ''),
        ('A008', 'Alford', 'New York', '0.12', '044-25874365', ''),
        ('A011', 'Ravi Kumar', 'Bangalore', '0.15', '077-45625874', ''),
        ('A010', 'Santakumar', 'Chennai', '0.14', '007-22388644', ''),
        ('A012', 'Lucida', 'San Jose', '0.12', '044-52981425', ''),
        ('A005', 'Anderson', 'Brisban', '0.13', '045-21447739', ''),
        ('A001', 'Subbarao', 'Bangalore', '0.14', '077-12346674', ''),
        ('A002', 'Mukesh', 'Mumbai', '0.11', '029-12358964', ''),
        ('A006', 'McDen', 'London', '0.15', '078-22255588', ''),
        ('A004', 'Ivan', 'Torento', '0.15', '008-22544166', ''),
        ('A009', 'Benjamin', 'Hampshair', '0.11', '008-22536178', '');


SELECT * FROM ND_AGENTS;

--SET THE COUNTRY TO 'IN' WHEREEVER COUNTRY ISNULL OR BLANK

UPDATE ND_AGENTS
SET COUNTRY = 'IN' WHERE COUNTRY IS NULL OR COUNTRY = '';


/* The SUBSTRING () function returns the position of a string or binary value from the complete string, 
starting with the character specified by substring_start_index. If any input is null, null is returned */

--Example 1: Get the substring from a specific string in Snowflake

select substring('NIKHIL DIGRASE', 1, 5) AS PARTIAL_NAME;
select substring(' NIKHIL DIGRASE', 0, 5); -- N-1
select substr('Raja Ram',0,3);
select substr('Raja Ram',3);

select substring('NIKHIL DIGRASE', -7, 4); -- START FROM INDEX -7 AND GIVE 4 CHARACTERS FROM THAT INDEX

select substring('NIKHIL DIGRASE', -7, -4); -- NO OUTPUT

select substring('NIKHIL DIGRASE', NULL); -- IF GIVE NULL RESULT WILL BE NULL

-- GET THE SUBSTRING FROM A SPECIFIC STRING BY USING TABLE DATA

SELECT AGENT_CODE, SUBSTR (AGENT_CODE, -3,3) AS AGENT_CODE_INITIALS FROM ND_AGENTS;-- NEGATIVE INDEXING

SELECT AGENT_CODE, SUBSTR (AGENT_CODE, 2,5) AS AGENT_CODE_INITIALS FROM ND_AGENTS; -- POSITIVE INDEXING

-- SELECT N FROM NIKHIL AND D FROM DIGRASE
-- CONCAT FUNCTION

SELECT SUBSTR ('NIKHIL DIGRASE',1,1) || SUBSTR ('NIKHIL DIGRASE',-7,1) AS INITIALS;

SELECT CONCAT (SUBSTR ('NIKHIL DIGRASE', 1,1), SUBSTR ('NIKHIL DIGRASE',-7,1));

SELECT CONCAT ('NIKHIL', 'DIGRASE');

SELECT 'NIKHIL' || 'DIGRASE' AS FULL_NAME;

-- CONCAT TWO COLUMNS IN TABLE

SELECT AGENT_CODE || ' ' ||AGENT_NAME AS AGENT_DETAILS
FROM ND_AGENTS;

SELECT PHONE_NO || ' ' || COUNTRY AS DETAILS
FROM ND_AGENTS;

SELECT * FROM ND_CONSUMER_COMPLAINTS;

CREATE OR REPLACE VIEW ND_CONSUMER_COMPLAINTS_VIEW AS
SELECT *,
CONCAT (ZIP_CODE, ' ' ,PRODUCT_NAME) AS DETAILS_1
FROM ND_CONSUMER_COMPLAINTS;

DESCRIBE VIEW ND_CONSUMER_COMPLAINTS_VIEW;

CREATE OR REPLACE VIEW CUSTOM_CONSUMER_COMPLAINTS_VIEW AS
SELECT *,
CONCAT (STATE_NAME || '-' ||ZIP_CODE) AS STATE_ZIP_DETAILS
FROM ND_CONSUMER_COMPLAINTS
WHERE SUB_ISSUE IS NOT NULL 
AND CONSUMER_COMPLAINT_NARRATIVE IS NOT NULL
AND COMPANY_PUBLIC_RESPONSE IS NOT NULL
AND SUB_PRODUCT IS NOT NULL;

SELECT * FROM CUSTOM_CONSUMER_COMPLAINTS_VIEW;

/*
Snowflake CAST is a data-type conversion command. Snowflake CAST works similar to the TO_ datatype conversion functions. 
If a particular data type conversion is not possible,
it raises an error. Let’s understand the Snowflake CAST in detail via the syntax and a few examples.
*/

SELECT CAST ('1.12345' AS DECIMAL(6,2));

SELECT '1.12345' :: DECIMAL(6,2);

SELECT CAST ('10-SEP-2023' AS TIMESTAMP);

-- When the provided precision is insufficient to hold the input value, the Snowflake CAST command raises an error as follows:

SELECT CAST ('123.12' AS NUMBER(4,2)); --OUT OF RANGE

SELECT CAST ('123.12' AS NUMBER(4,1));

--TRY_CAST( <source_string_expr> AS <target_data_type> )

SELECT TRY_CAST ('10-09-2023' AS TIMESTAMP); -- NULL VALUE

SELECT TRY_CAST ('2023-09-10' AS TIMESTAMP); -- DATE HAS TO BE IN THE FORM OF YYYY-MM-DD

-- TRIM FUNCTION

SELECT TRIM ('❄-❄ABC-❄-', '❄-') AS TRIMMED_STRING;

SELECT TRIM ('❄-❄ABC-❄-', '❄') AS TRIMMED_STRING;

SELECT TRIM ('❄-❄ABC-❄-', '-') AS TRIMMED_STRING;

SELECT TRIM('********T E S T I N G 1 2 3 4********','*') AS TRIMMED_SPACE; -- IT ONLY REMOVE FROM START AND END

SELECT TRIM('********T E S T I N* G* 1 2 3 4********','*') AS TRIMMED_SPACE; -- IT ONLY REMOVE FROM START AND END NOT IN THE MIDDLE

-- LTRIM

SELECT LTRIM ('#000000123', '0#');

SELECT LTRIM ('#0000NIKHIL', '0#');

SELECT LTRIM ('      NIKHIL DIGRASE', '');

-- RTRIM

SELECT RTRIM ('$125.00', '0.');

SELECT RTRIM ('NIKHIL DIGRASE*****', '*');

--To remove the white spaces or the blank spaces from the string TRIM function can be used. 
--It can remove the whitespaces from the start and end both.

SELECT TRIM('  Snwoflake Space Remove  ', ' ');

--To remove the first character from the string you can pass the string in the RTRIM function.

SELECT LTRIM('Snowflake Remove  ', 'S');

--To remove the last character from the string you can pass the string in the RTRIM function.

SELECT RTRIM('Snwoflake Remove  ', 'e');

--LENGTH FUNCTION

SELECT LEN(trim('  Snowflake Space Remove  ')) as length_string;

SELECT LENGTH(trim('  Snowflake Space Remove  ')) as length_string;