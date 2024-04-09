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

-----------------------------------------------------------------------------------------------------------------


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

-------------------------------------------------------------------------------------------

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

-----------------------------------------------------------------------------------------------------

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

-------------------------------------------------------------------------------------------------

--LENGTH FUNCTION

SELECT LEN(trim('  Snowflake Space Remove  ')) as length_string;

SELECT LENGTH(trim('  Snowflake Space Remove  ')) as length_string;

----------------------------------------------------------------------------

-- REVERSE IN STRING

SELECT REVERSE('Hello, world!');

-------------------------------------------------------------

-- SPLIT

SELECT SPLIT  ('127.0.0.1', '.');

SELECT SPLIT  ('127.0.0.1', '.');

SELECT SPLIT  ('NIKHIL-DIGRASE', '-');

-----------------------------------------------------------------------------

CREATE OR REPLACE TABLE ND_PERSONS
(
    NAME CHAR (10),
    CHILDREN VARCHAR (30)
);


SELECT * FROM ND_PERSONS;

INSERT INTO ND_PERSONS
VALUES
    ('MARK','MARKY, MARK JR, MARIA'), ('JOHN','JOHNNY, JANE');

SELECT SPLIT(CHILDREN, ',') FROM ND_PERSONS;    

SELECT NAME, C.VALUE :: STRING AS CHILDNAME
FROM ND_PERSONS,
    LATERAL FLATTEN (INPUT=> SPLIT(CHILDREN,',')) C;

SELECT SPLIT_PART('aaa--bbb-BBB--ccc', '--',1); --INDEX POSITION WISE SPLITTING
SELECT SPLIT_PART('aaa--bbb-BBB--ccc', '--',2);
SELECT SPLIT_PART('aaa--bbb-BBB--ccc', '--',3);
SELECT SPLIT_PART('aaa--bbb-BBB--ccc', '--',4);
SELECT SPLIT_PART('11.22.33', '.',  0);

SELECT SPLIT_PART('11.22.33', '.',  0) AS FIRSTPART,
       SPLIT_PART('11.22.33', '.',  2) AS SECONDPART; -- TO CREATE TWO COLUMN GIVE COMMA IN BETWEEN

-------------------------------------------------------------------------------------------------------------

-- UPPER AND LOWER

SELECT LOWER('NIKHIL DIGRASE') AS LOWER_STRING;

SELECT UPPER('NIKHIL DIGRASE') AS UPPER_STRING;

SELECT UPPER(CONCAT(SUBSTR('NIKHIL MAROTI DIGRASE', 1,1),
                    SUBSTR('NIKHIL MAROTI DIGRASE', 8,1),
                    SUBSTR('NIKHIL MAROTI DIGRASE', -7,1))) AS INITIAL;

--INITCAP-> RETURNS THE INPUT STRING WITH THE FIRST LETTER OF EACH WORD IN UPPERCASE AND THE SUBSEQUENT IN LOWERCASE

SELECT INITCAP('NIKHIL DIGRASE') AS INITCAP_STRING;

SELECT INITCAP('this is the new Frame+work', '');

SELECT INITCAP('iqamqinterestedqinqthisqtopic','q');-- THE LETTER AFTER DELIMMETER GETS CAPITAL

select initcap('lion☂fRog potato⨊cLoUD', '⨊☂');

select initcap('apple is僉sweetandballIsROUND', '僉a b');

-------------------------------------------------------------------------------------------------------------------

--REPLACE->Removes all occurrences of a specified substring, and optionally replaces them with another substring.

SELECT REPLACE('    NIKHIL DIGRASE   ', ' ', '*'); --SPACE REPLACE WITH STAR

SELECT REPLACE('    NIKHIL DIGRASE   ', ' ');-- SPACE GETS REPLACE ONLY

SELECT REPLACE('   T  E  S   T  I  N  G 1 2 3', ' ');

--Replace the string down with the string up
SELECT REPLACE('down', 'down', 'up');

--Replace the substring Athens in the string Vacation in Athens with the substring Rome
SELECT REPLACE('Vacation in Athens', 'Athens', 'Rome');

--Replace the substring bc in the string abcd with an empty substring
SELECT REPLACE('abcd', 'bc');

--Replace the string down with the string up
CREATE OR REPLACE TABLE replace_example(
  subject VARCHAR(10),
  pattern VARCHAR(10),
  replacement VARCHAR(10));

INSERT INTO replace_example VALUES
  ('old car', 'old car', 'new car'),
  ('sad face', 'sad', 'happy'),
  ('snowman', 'snow', 'fire');

  SELECT * FROM replace_example;

SELECT subject,
       pattern,
       replacement,
       REPLACE(subject, pattern, replacement) AS new
FROM replace_example;

-------------------------------------------------------------------------------------

--STARTSWITH->Returns true if expr1 starts with expr2. Both expressions must be text or binary expressions.

SELECT * FROM ND_CONSUMER_COMPLAINTS WHERE STARTSWITH(PRODUCT_NAME, 'Bank');

SELECT * FROM ND_CONSUMER_COMPLAINTS WHERE PRODUCT_NAME LIKE 'Bank%';

SELECT * FROM ND_CONSUMER_COMPLAINTS WHERE ENDSWITH(PRODUCT_NAME, 'service');

SELECT * FROM ND_CONSUMER_COMPLAINTS WHERE PRODUCT_NAME LIKE '%service';

---------------------------------------------------------------------------------------------

--RIGHT->Returns a rightmost substring of its input.

SELECT RIGHT('ABCDEFG', 3);

SELECT LEFT('ABCDEFG', 3);

SELECT RIGHT('DASHDASGYDU254512421417E981US',2) AS COUNTRY_CODE;

-- WE CAN USE SUBSTRING FUNCTION HERE ALSO

SELECT SUBSTR('DASHDASGYDU254512421417E981US',-2,2) AS COUNTRY_CODE; --USING SUBSTRING

--CONTAINS

SELECT * FROM ND_CONSUMER_COMPLAINTS WHERE CONTAINS(PRODUCT_NAME, 'Bank');

-------------------------------------------------------------------------------------------

--NVL->If expr1 is NULL, returns expr2, otherwise returns expr1.

SELECT NVL('FOOD','BARD') AS COL_1,
       NVL(NULL, 3.14) AS COL_2; --IF 1ST EXPRESSION IS NULL THEN ONLY GIVE 2ND EXPRESSION


SELECT NVL(NULL,'BARD') AS COL_1,
       NVL(NULL, 3.14) AS COL_2;

CREATE TABLE IF NOT EXISTS suppliers (
  supplier_id INT PRIMARY KEY,
  supplier_name VARCHAR(30),
  phone_region_1 VARCHAR(15),
  phone_region_2 VARCHAR(15));

INSERT INTO suppliers(supplier_id, supplier_name, phone_region_1, phone_region_2)
  VALUES(1, 'Company_ABC', NULL, '555-01111'),
        (2, 'Company_DEF', '555-01222', NULL),
        (3, 'Company_HIJ', '555-01333', '555-01444'),
        (4, 'Company_KLM', NULL, NULL);

SELECT *,
       NVL(phone_region_1, phone_region_2) IF_REGION_1_NULL,
       NVL(phone_region_2, phone_region_1) IF_REGION_2_NULL
  FROM suppliers;

------------------------------------------------------------------------------------------

--COALESCE-> Returns the first non-NULL expression among its arguments, or NULL if all its arguments are NULL.

SELECT column1, column2, column3,
coalesce(column1, column2, column3) AS EXTRACTED_VALUES
FROM (values
  (1,    2,    3   ),--IT TAKES 1ST NON NULL VALUE
  (null, 2,    3   ),-- CHECK RESULT FOR BETTER UNDERSTANDING
  (null, null, 3   ),
  (null, null, null),
  (1,    null, 3   ),
  (1,    null, null),
  (1,    2,    null)
) v;

SELECT column1, column2, column3,
coalesce(column1, column2, column3) AS EXTRACTED_VALUES
FROM (values
  ('NIKHIL',    'VAIBHAV',    NULL   ),--IT TAKES 1ST NON NULL VALUE
  (null, 'SANSKRUTI',    NULL   ),-- CHECK RESULT FOR BETTER UNDERSTANDING
  (null, 'VAIBHAV', 'TRISHUL'   ),
  (null, null, 'TRISHUL'),
  ('NIKHIL',    null, 'TRISHUL'   ),
  ('PRATYUSHA',    null, null),
  ('VAISHNAVI',    'AAYU',    null)
) v;

-- IT DOESNT WORK ON DIFFRENT DATATYPES, IT HAS TO BE SAME DATATYPE
