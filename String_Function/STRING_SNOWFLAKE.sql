USE DATABASE DEMO_DATABASE;
CREATE OR REPLACE TABLE AGENTS
   (	
     AGENT_CODE CHAR(6) NOT NULL PRIMARY KEY, 
	 AGENT_NAME CHAR(40) , 
	 WORKING_AREA CHAR(35), 
	 COMMISSION NUMBER(10,2) DEFAULT 0.05, 
	 PHONE_NO CHAR(15), 
	 COUNTRY VARCHAR2(25) 
	 );

INSERT INTO AGENTS VALUES ('A007', 'Ramasundar', 'Bangalore',0.15,'077-25814763', '');
INSERT INTO AGENTS(AGENT_CODE,AGENT_NAME,WORKING_AREA) 
VALUES ('A110', 'Anand', 'Germany');
INSERT INTO AGENTS VALUES ('A003', 'Alex ', 'London', '0.13', '075-12458969', '');
INSERT INTO AGENTS VALUES ('A008', 'Alford', 'New York', '0.12', '044-25874365', '');
INSERT INTO AGENTS VALUES ('A011', 'Ravi Kumar', 'Bangalore', '0.15', '077-45625874', '');
INSERT INTO AGENTS VALUES ('A010', 'Santakumar', 'Chennai', '0.14', '007-22388644', '');
INSERT INTO AGENTS VALUES ('A012', 'Lucida', 'San Jose', '0.12', '044-52981425', '');
INSERT INTO AGENTS VALUES ('A005', 'Anderson', 'Brisban', '0.13', '045-21447739', '');
INSERT INTO AGENTS VALUES ('A001', 'Subbarao', 'Bangalore', '0.14', '077-12346674', '');
INSERT INTO AGENTS VALUES ('A002', 'Mukesh', 'Mumbai', '0.11', '029-12358964', '');
INSERT INTO AGENTS VALUES ('A006', 'McDen', 'London', '0.15', '078-22255588', '');
INSERT INTO AGENTS VALUES ('A004', 'Ivan', 'Torento', '0.15', '008-22544166', '');
INSERT INTO AGENTS VALUES ('A009', 'Benjamin', 'Hampshair', '0.11', '008-22536178', '');




SELECT * FROM AGENTS;

/* The SUBSTRING () function returns the position of a string or binary value from the complete string, 
starting with the character specified by substring_start_index. If any input is null, null is returned */

--Example 1: Get the substring from a specific string in Snowflake
select substring(' ANAND KUMAR JHA', 1, 7);
select substring(' ANAND KUMAR JHA', 0, 7);
select substr('Raja Ram',0,3);
select substr('Raja Ram',3);

select substring('ANAND KUMAR JHA', -7);
---sajkdsdjfsfbffbkjtqjUK

--Example 2: Get the substring from a specific string by using table data
select AGENT_CODE,AGENT_NAME,substring(AGENT_NAME,0,2) AS AGENT_INITIALS from agents;

/* To get a specific substring from an expression or string. 
You can also use the substring function if you want to get the substrings in reverse order from the strings. */

-- If you use the substrings in reverse order, use the starting index as a negative value.
select AGENT_CODE,AGENT_NAME,substring(AGENT_NAME,-3,3) AS NAME_BACKWARDS from agents;

/*
Snowflake CAST is a data-type conversion command. Snowflake CAST works similar to the TO_ datatype conversion functions. 
If a particular data type conversion is not possible,
it raises an error. Let’s understand the Snowflake CAST in detail via the syntax and a few examples.
*/

select cast('1.6845' as decimal(6,2));
select '1.6845'::decimal(6,1);

select cast('10-Sep-2021' as timestamp);
-- When the provided precision is insufficient to hold the input value, the Snowflake CAST command raises an error as follows:
select cast('123.12' as number(4,2));
--Here, precision is set as 4 but the input value has a total of 5 digits, thereby raising the error.

--TRY_CAST( <source_string_expr> AS <target_data_type> )
select try_cast('05-Mar-2016' as timestamp);

--The Snowflake TRY_CAST command returns NULL as the input value 
--has more characters than the provided precision in the target data type.
select try_cast('ANAND' as char(4));

--trim function
select trim('❄-❄ABC-❄-', '❄-') as trimmed_string;
select trim('❄-❄ABC-❄-', '') as trimmed_string;
SELECT TRIM('********T E S T I N G 1 2 3 4********','*') AS TRIMMED_SPACE;

--ltrim
select ltrim('#000000123', '0#');
select ltrim('#0000AISHWARYA', '0#');
select ltrim('      ANAND JHA', '');


--RTRIM
select rtrim('$125.00', '0.');
select rtrim('ANAND JHA*****', '*');

--To remove the white spaces or the blank spaces from the string TRIM function can be used. 
--It can remove the whitespaces from the start and end both.
select TRIM('  Snwoflake Space Remove  ', ' ');

--To remove the first character from the string you can pass the string in the RTRIM function.
select LTRIM('Snowflake Remove  ', 'S');
--To remove the last character from the string you can pass the string in the RTRIM function.
select RTRIM('Snwoflake Remove  ', 'e');

select BTRIM('  Snwoflake Space Remove  ', ' ');

--LENGTH FUNCTION
SELECT LEN(trim('  Snowflake Space Remove  ')) as length_string;
SELECT LENGTH(trim('  Snowflake Space Remove  ')) as length_string;

--concat
select * from agents;
SELECT CONCAT('KA', ', ', 'India') as state_country;
SELECT *,concat(AGENT_CODE, '-', AGENT_NAME) AS agent_details from agents;

--Snowflake CONCAT_WS Function
/* The concat_ws function concatenates two or more strings, or concatenates two or more binary values 
and adds separator between those strings.
The CONCAT_WS operator requires at least two arguments, and uses the first argument to separate all following arguments

Following is the concat_ws function syntax
CONCAT_WS( <separator> , <expression1> [ , <expressionN> ... ] ) */

SELECT CONCAT_WS('-', 'KA','India') as state_country;

/*
Snowflake Concat Operator (||)
The concatenation operator concatenates two strings on either side of the || symbol and returns the concatenated string. 
The || operator provides alternative syntax for CONCAT and requires at least two arguments.

For example,
*/
select 'Nested' || ' CONCAT' || ' example!' as Concat_operator;
--Handling NULL Values in CONCAT function and the Concatenation operator
--For both the CONCAT function and the concatenation operator,
--if one or both strings are null, the result of the concatenation is null.
--For example,

select concat('Bangalore, ', NULL) as null_example;
select 'Bangalore, '|| NULL as null_example;

--how to handle it?
select concat('Bangalore ', NVL(NULL,'')) as null_example;
select 'Bangalore'|| NVL(NULL, '') as null_example;

-- REVERSE IN STRING
select reverse('Hello, world!');

-- SPLIT
select split('127.0.0.1', '.');
SELECT SPLIT('ANAND-KUMAR-JHA','-');
select  0, split_part('11.22.33', '.',  0);
select split_part('aaa--bbb-BBB--ccc', '--',1);
select split_part('aaa--bbb-BBB--ccc', '--',2);
select split_part('aaa--bbb-BBB--ccc', '--',3);
select split_part('aaa--bbb-BBB--ccc', '--',4);

SELECT split(AGENT_DETAILS, '-')
FROM (
SELECT *,concat(AGENT_CODE, '-', AGENT_NAME) AS agent_details 
  from agents );
 
SELECT lower('India Is My Country') as lwr_strng;
SELECT UPPER('India Is My Country') as upr_strng;

--REPLACE COMMAND
-- REPLACE( <subject> , <pattern> [ , <replacement> ] )

select REPLACE( '   ANAND KUMAR JHA   ' ,' ','*');
select REPLACE( '   ANAND KUMAR JHA   ' ,' '); -- 
SELECT REPLACE('   T  E S T I N G 1 2 3 4   ',' ')

*********************************CODE DISCUSSED IN CLASS**************************
SELECT SUBSTR('ANAND KUMAR JHA',0,5) AS FIRST_NAME;
SELECT substr('ANAND KUMAR JHA',6,6) AS MIDDLE_NAME;
SELECT substr('ANAND KUMAR JHA',-3,5) AS LAST_NAME;

select substr('ANAND KUMAR JHA',1,1) || substr('ANAND KUMAR JHA',-3,1) as
initial;

select CONCAT(substr('ANAND KUMAR JHA',1,1),substr('ANAND KUMAR JHA',-3,1)) as
initial;

SELECT CONCAT('ANAND ',' ',2,3,4,NULL,' JHA') AS FULL_NAME;

CREATE OR REPLACE TABLE AGENTS
(
AGENT_CODE CHAR(6) NOT NULL PRIMARY KEY,
AGENT_NAME CHAR(40) ,
WORKING_AREA CHAR(35),
COMMISSION NUMBER(10,2) DEFAULT 0.05,
PHONE_NO CHAR(15),
COUNTRY VARCHAR2(25)
);

INSERT INTO AGENTS VALUES ('A007', 'Ramasundar', 'Bangalore',0.15,'077-
25814763', '');
INSERT INTO AGENTS VALUES ('A003', 'Alex ', 'London', '0.13', '075-12458969',
'');
INSERT INTO AGENTS VALUES ('A008', 'Alford', 'New York', '0.12', '044-
25874365', '');
INSERT INTO AGENTS VALUES ('A011', 'Ravi Kumar', 'Bangalore', '0.15', '077-
45625874', '');
INSERT INTO AGENTS VALUES ('A010', 'Santakumar', 'Chennai', '0.14', '007-
22388644', '');
INSERT INTO AGENTS VALUES ('A012', 'Lucida', 'San Jose', '0.12', '044-
52981425', '');
INSERT INTO AGENTS VALUES ('A005', 'Anderson', 'Brisban', '0.13', '045-
21447739', '');
INSERT INTO AGENTS VALUES ('A001', 'Subbarao', 'Bangalore', '0.14', '077-
12346674', '');
INSERT INTO AGENTS VALUES ('A002', 'Mukesh', 'Mumbai', '0.11', '029-
12358964', '');
INSERT INTO AGENTS VALUES ('A006', 'McDen', 'London', '0.15', '078-
22255588', '');
INSERT INTO AGENTS VALUES ('A004', 'Ivan', 'Torento', '0.15', '008-22544166',
'');
INSERT INTO AGENTS VALUES ('A009', 'Benjamin', 'Hampshair', '0.11', '008-
22536178', '');
INSERT INTO AGENTS(AGENT_CODE,AGENT_NAME,WORKING_AREA)
VALUES ('A110', 'Anand', 'Germany');

SELECT * FROM AGENTS;

SELECT CONCAT(AGENT_CODE,'-',AGENT_NAME) AS AGENT_DETAIL FROM AGENTS;
SELECT CONCAT_WS('-',AGENT_CODE,AGENT_NAME) AS AGENT_DETAIL FROM AGENTS;

SELECT CONCAT_WS('-', 'KA','India') as state_country;

SELECT * FROM DEMO_DB.PUBLIC."txn_table_hold_mult_value" 
WHERE PRODUCT_ID LIKE '%48%';

SELECT CONCAT(STORE_ID,'-',PRODUCT_ID) AS STORE_PROD_PAIR 
FROM DEMO_DB.PUBLIC."txn_table_hold_mult_value";

SELECT CONCAT_WS('-',STORE_ID,PRODUCT_ID) AS STORE_PROD_PAIR 
FROM DEMO_DB.PUBLIC."txn_table_hold_mult_value";

SELECT LENGTH(' ANAND ') AS MY_NAME_LENGTH;

select LTRIM('#00001AISHWARYA', '#0') AS LEFT_TRIMMED_STR;

select LTRIM('#0001230AISHWARYA', '#0') AS LEFT_TRIMMED_STR;

select RTRIM('AISHWARYA#0000', '#0')AS RIGHT_TRIMMED_STR
select TRIM('#0000AISHWARYA#0000', '#0')AS TRIMMED_STR;

select RTRIM ('$125.00', '0.');

select TRIM('❄-❄ABC-❄-', '❄-') as trimmed_string;

--Remove leading and trailing *
SELECT TRIM('********T*E*S*T*I N G 1 2 3 4********','*') AS
TRIMMED_SPACE;

SELECT REVERSE('Hello, world!');
SELECT REVERSE('16-09-2023');
SELECT REVERSE('INDEPENDENCE') AS REVERSED_STRING;
select replace('abcd', 'bc') as replaced_nothing_just_remove;
select REPLACE( ' ANAND KUMAR JHA ' ,' ','*') AS REPLACING_BLANK_WITH_STAR;
SELECT REPLACE(' T E S T I N G 1 2 3 4 ',' ');
SELECT REPEAT('ANAND JHA ', 5);


SELECT LOWER('ANAND KUMAR JHA') AS LOWER_CASE;
SELECT UPPER('ANAND KUMAR JHA') AS UPPER_CASE;
SELECT INITCAP('INDIA Is MY cOUntRY') AS TITLE;

SELECT LOWER('BehaviorTriggeredAPAC_APP_ALL_ALL_RegisteredNotTransacted-Promocode_Wave1_EN_APAC_AU')
AS LOWER_CASE_STRING;
SELECT UPPER('BehaviorTriggeredAPAC_APP_ALL_ALL_RegisteredNotTransacted-Promocode_Wave1_EN_APAC_AU')
AS UPPER_CASE_STRING;
SELECT INITCAP('BehaviorTriggeredAPAC_APP_ALL_ALL_RegisteredNotTransacted-Promocode_Wave1_EN_APAC_AU')
AS CAMEL_CASE_STRING;
select * from agents;

CREATE OR REPLACE VIEW AGENTS_VIEW AS
select *,
split_part(PHONE_NO,'-', 1) as COUNTRY_CODE ,
split_part(PHONE_NO,'-', 2) as STD_NO 
FROM AGENTS;

SELECT * FROM AGENTS_VIEW;

 create or replace table aj_persons
(
 NAME CHAR(10),
 CHILDREN VARCHAR(30)
);


INSERT INTO AJ_PERSONS
VALUES('Mark','Marky,Mark Jr,Maria'),('John','Johnny,Jane');
SELECT * FROM AJ_PERSONS;

SELECT SPLIT(CHILDREN,',') AS SPLITTED_CHILDREN FROM AJ_persons;
SELECT split(AGENT_DETAILS, '-')
 FROM (
 SELECT *,concat(AGENT_CODE, '-', AGENT_NAME) AS
 agent_details
 from agents );

 select TO_NUMBER(split_part('11.22.33', '.', 1)) as first_part ,
 split_part('11.22.33', '.', 2) as sec_part;

 --NO OF POSSIBLE SPLIT WHICH CAN HAPPEN
SELECT ARRAY_SIZE(split('shivam panwar',' ')) as no_of_splits;

 select 
 split_part('ANAND KUMAR JHA', ' ', 1) as first_name ,
 split_part('ANAND KUMAR JHA', ' ', 2) as middle_name,
 split_part('ANAND KUMAR JHA', ' ', 3) as last_name,
 split_part('ANAND KUMAR JHA', ' ', 4) as no_part_avaialble;

select split_part('aaa--bbb-BBB--ccc', '--',2) as first_part;

select split('anand-kumar-jha','-') as splitted_string;

select * from AGENTS
 where working_area LIKE '%e';


