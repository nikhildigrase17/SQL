USE DATABASE DEMO_DATABASE;

create or replace table strings (v varchar(50));
insert into strings (v) values
    ('San Francisco'),
    ('San Jose'),
    ('Santa Clara'),
    ('Sacramento');
    
--Use wildcards to search for a pattern:
select v from strings
where v regexp 'San* [fF].*' -- San followed by zero or more occurances then small or capital f followed by zero or more occurances
order by v;    

INSERT INTO strings (v)
VALUES
    ('Contains embedded single \\backslash');

    
SELECT * 
    FROM strings
    ORDER BY v;

--This example shows how to search for strings that start with “San”, where “San” is a complete word (e.g. not part of “Santa”). \b is the escape sequence for a word boundary.

SELECT v, v regexp 'San\\b.*' AS MATCHES
    FROM strings
    ORDER BY v;

--This example shows how to search for a blank followed by a backslash. Note that the single backslash to search for is represented by four backslashes below; for REGEXP to look for a literal backslash, that backslash must be escaped, so you need two backslashes. The string parser requires that each of those backslashes be escaped, so the expression contains four backslashes to represent the one backslash that the expression is searching for:

SELECT v, v regexp '.*\\s\\\\.*' AS MATCHES
    FROM strings 
    ORDER BY v;

-- The following example is the same as the preceding example, except that it uses $$ as a string delimiter to tell the string parser that the string is a literal and that backslashes should not be interpreted as escape sequences. (The backslashes are still interpreted as escape sequences by REGEXP.)

SELECT v, v regexp $$.*\s\\.*$$ AS MATCHES
    FROM strings
    ORDER BY v;

----------------------------------------------------------------------------------------------

/*

--REGEXP_COUNT->Returns the number of times that a pattern occurs in a string.

The REGEXP_COUNT function searches a string and returns an integer that indicates the number of 
 times the pattern occurs in the string. If no match is found, then the function returns 0.

Patterns also support the following Perl backslash-sequences:

\d: decimal digit (0-9).

\D: not a decimal digit.

\s: whitespace character.

\S: not a whitespace character.

\w: “word” character (a-z, A-Z, underscore (“_”), or decimal digit).

\W: not a word character.

\b: word boundary.

\B: not a word boundary.
*/

--The following example counts occurrences of the word was. Matching begins at the 1st character in the string:

select regexp_count('It was the best of times, it was the worst of times', '\\bwas\\b', 1) as "result" from dual;

select regexp_count('It was the best of times, it was the worst of times', '\\bof\\b', 1) as "result" from dual;

select regexp_count('It was the best of times, it was the worst of times', '\\bit|It\\b', 1) as "result" from dual;

select regexp_count('It was the best of times, it was the worst of times', '\\bit\\b', 1,'i') as "result" from dual;--another way by given 'i' as case insensitive

--syntax : REGEXP_COUNT( <string> , <pattern> [ , <position> , <parameters> ] )  

select regexp_count('qqqabcrtrababcbcd', 'abc'); --count whole abc in string
select regexp_count('qqqabcrtrababcbcd', '[abc]') as abc_character_count; -- count abc as individual alphabet
select regexp_count('qqqabcrtrababcbcd', '[bac]') as abc_character_count; -- count abc as individual alphabet
select REGEXP_COUNT('QQQABCRTRABABCBCD', '[ABC]{3}');
select REGEXP_COUNT('QQQABCRTRABABCBCD', '[CAB]{3}');
select REGEXP_COUNT('QQQABCRTRABABCBCD', '[ABC]{4}');--ONLY B IS 4
select REGEXP_COUNT('QQQABCRTRABABCBCD', '[Q]{1}');
select REGEXP_COUNT('QQQABCRTRABABCBCD', '[Q]{2}');
select REGEXP_COUNT('QQQABCRTRABABCBCD', '[Q]{3}');

--The following example illustrates overlapping occurrences:

create or replace table overlap (id number, text string);
insert into overlap values (1,',abc,def,ghi,jkl,');--first and last ccomma counted
insert into overlap values (2,',abc,,def,,ghi,,jkl,');-- first and last counted+ 2 comma counted in between, it doesnt matter how much commas in between it will count only as 2
insert into overlap values (3,',abc,,def,,ghi,jkl,');
insert into overlap values (4,',abc,,def,ghi,jkl,');
insert into overlap values (5,',abc,,def,,ghi,,jkl');
insert into overlap values (6,'abc,,def,,ghi,,jkl');
insert into overlap values (7,'abc,,def,,ghi,,jkl,,mno,');

select * from overlap;

--the count of first punctuation+the count of other punctuation+alphabet is given result
select id, regexp_count(text,'[[:punct:]][[:alnum:]]+[[:punct:]]', 1, 'i') from overlap;

/*
REGEXP_REPLACE->
The Snowflake REGEXP_REPLACE function returns the string by replacing specified pattern. 
If no matches found, original string will be returned.

Following is the syntax of the Regexp_replace function.

REGEXP_REPLACE( <string> , <pattern> [ , <replacement> , <position> , <occurrence> , <parameters> ] )

1. Extract date from a text string using Snowflake REGEXP_REPLACE Function
The REGEXP_REPLACE function is one of the easiest functions to get the required value when manipulating strings data.
Consider the below example to replace all characters except the date value. */

--For example, consider following query to return only user name.

select regexp_replace( 'anandjha2309@gmail.com', '@.*\\.(com)'); --remove all the data after @

select regexp_replace( 'anandjha_2309@gmail.com', '@.*\\.(com)');

select regexp_replace( 'anandjha_2309@gmail.com', '@.*');--another way

select regexp_replace( 'anandjha_2309@gmail.co.in', '@.*\\.(co).(in)');

select regexp_replace( 'anandjha_2309@gmail.co.in', '@.*');--another way

select regexp_replace('Customers - (NY)','\\(|\\)','') as customers;--| is OR space and bracket

SELECT TRIM(REGEXP_REPLACE(string, '[a-z/-/A-Z/.]', ''))
AS date_value 
FROM (SELECT 'My DOB is 04-12-1976.' AS string) a;

--The following example replaces all spaces in the string with nothing (i.e. all spaces are removed):

select regexp_replace('It was the best of times, it was the worst of times', '( ){1,}','') as "result" from dual;

--The following example matches the string times and replaces it with the string days. Matching begins at the 1st character in the string and replaces the second occurrence of the substring:

select regexp_replace('It was the best of times, it was the worst of times', 'times','days',1,2) as "result" from dual;

--The following example uses backreferences to rearrange the string firstname middlename lastname as lastname, firstname middlename and insert a comma between lastname and firstname:

select regexp_replace('firstname middlename lastname','(.*) (.*) (.*)','\\3, \\1 \\2') as "name sort" from dual;

select regexp_replace('firstname middlename lastname','(.*) (.*) (.*)','\\3, \\2 \\1') as "name sort" from dual;

SELECT  TRIM(REGEXP_REPLACE(string, '[^[:digit:]]', ' ')) AS Numeric_value
FROM (SELECT ' Area code for employee ID 112244 is 12345.' AS string) a;

SELECT  TRIM(REGEXP_REPLACE(string, '[^[:alpha:]]', ' ')) AS String_value
FROM (SELECT ' Area code for employee ID 112244 is 12345.' AS string) a;

----------------------------------------------------------------------------------------------------

/*
REGEXP_LIKE->

Performs a comparison to determine whether a string matches a specified pattern. Both inputs must be text expressions.

REGEXP_LIKE is similar to the [ NOT ] LIKE function, but with POSIX extended regular expressions instead of SQL LIKE pattern syntax. It supports more complex matching conditions than LIKE.

The function implicitly anchors a pattern at both ends (i.e. '' automatically becomes '^$', and 'ABC' automatically becomes '^ABC$'). To match any string starting with ABC, the pattern would be 'ABC.*'.
*/

CREATE OR REPLACE TABLE cities(city varchar(20));
INSERT INTO cities VALUES
    ('Sacramento'),
    ('San Francisco'),
    ('San Jose'),
    (null);

SELECT * FROM cities;

--Execute a case-sensitive query with a wildcard:

SELECT * FROM cities WHERE REGEXP_LIKE(city, 'san.*');

--Execute a case-insensitive query with a wildcard:

SELECT * FROM cities WHERE REGEXP_LIKE(city, 'san.*', 'i');

-- String pattern matching using REGEXP_LIKE
WITH tbl
  AS (select t.column1 mycol 
      from values('A1 something'),('B1 something'),('Should not be matched'),('C1 should be matched') t )

SELECT * FROM tbl WHERE regexp_like (mycol,'[a-zA-z]\\d{1,}[\\s0-9a-zA-Z]*');--second word start with small s

/*
REGEXP_INSTR->
Returns the position of the specified occurrence of the regular expression pattern in the string subject. If no match is found, returns 0.

String of one or more characters that specifies the regular expression parameters used for searching for matches. The supported values are:

c: case-sensitive.

i: case-insensitive.

m: multi-line mode.

e: extract sub-matches.

s: the ‘.’ wildcard also matches newline.
*/

CREATE  OR REPLACE TABLE demo1 (id INT, string1 VARCHAR);
INSERT INTO demo1 (id, string1) VALUES 
    (1, 'nevermore1, nevermore2, nevermore3.');

SELECT * FROM demo1;

--Search for a matching string. In this case, the string is “nevermore” followed by a single decimal digit (e.g. “nevermore1”):

select id, string1,
     regexp_substr(string1, 'nevermore\\d') AS "SUBSTRING", 
      regexp_instr( string1, 'nevermore\\d') AS "POSITION"
    from demo1
    order by id;

--Search for a matching string, but starting at the 5th character in the string, rather than at the 1st character in the string:

select id, string1,
      regexp_substr(string1, 'nevermore\\d', 5) AS "SUBSTRING", 
      regexp_instr( string1, 'nevermore\\d', 5) AS "POSITION"
    from demo1
    order by id;

--Search for a matching string, but look for the 3rd match rather than the 1st match:

select id, string1,
      regexp_substr(string1, 'nevermore\\d', 1, 3) AS "SUBSTRING", 
      regexp_instr( string1, 'nevermore\\d', 1, 3) AS "POSITION"
    from demo1
    order by id;

--This query is nearly identical the previous query, but this shows how to use the option parameter to indicate whether you want the position of the matching expression, or the position of the first character after the matching expression:

select id, string1,
       regexp_substr(string1, 'nevermore\\d', 1, 3) AS "SUBSTRING", 
       regexp_instr( string1, 'nevermore\\d', 1, 3, 0) AS "START_POSITION",
       regexp_instr( string1, 'nevermore\\d', 1, 3, 1) AS "AFTER_POSITION"
    from demo1
    order by id;

--This query shows that if you search for an occurrence beyond the last actual occurrence, the position returned is 0:

select id, string1, 
       regexp_substr(string1, 'nevermore', 1, 4) AS "SUBSTRING",
       regexp_instr( string1, 'nevermore', 1, 4) AS "POSITION"
    from demo1
    order by id;

-------------------------------------------------------------------------------------------------------------------

/*
REGEXP_SUBSTR->
Returns the substring that matches a regular expression within a string. If no match is found, returns NULL.
*/

CREATE TABLE demo3 (id INT, string1 VARCHAR);
INSERT INTO demo3 (id, string1) VALUES 
    -- A string with multiple occurrences of the word "the".
    (2, 'It was the best of times, it was the worst of times.'),
    -- A string with multiple occurrences of the word "the" and with extra
    -- blanks between words.
    (3, 'In    the   string   the   extra   spaces  are   redundant.'),
    -- A string with the character sequence "the" inside multiple words 
    -- ("thespian" and "theater"), but without the word "the" by itself.
    (4, 'A thespian theater is nearby.');

SELECT * FROM demo3;

/*
The next example looks for:

the word “the”

followed by one or more non-word characters

followed by one or more word characters.

“Word characters” include not only the letters a-z and A-Z, but also the underscore (“_”) and the decimal digits 0-9, but not whitespace, punctuation, etc.
*/

select id, string1,
    regexp_substr(string1, 'the\\W+\\w+') as "RESULT"
    from demo3
    order by id;

/*
Starting from position 1 of the string, look for the 2nd occurrence of

the word “the”

followed by one or more non-word characters

followed by one or more word characters.
*/

select id, string1,
    regexp_substr(string1, 'the\\W+\\w+', 1, 2) as "RESULT"
    from demo3
    order by id;

/*
Starting from position 1 of the string, look for the 2nd occurrence of

the word “the”

followed by one or more non-word characters

followed by one or more word characters.

Rather than returning the entire match, return only the “group” (i.e. the portion of the substring that matches the part of the regular expression in parentheses). In this case, the returned value should be the word after “the”. */


select id, string1,
    regexp_substr(string1, 'the\\W+(\\w+)', 1, 2, 'e', 1) as "RESULT"
    from demo3
    order by id;

CREATE TABLE demo4 (id INT, string1 VARCHAR);
INSERT INTO demo4 (id, string1) VALUES
    (5, 'A MAN A PLAN A CANAL');

select id, 
    regexp_substr(string1, 'A\\W+(\\w+)', 1, 1, 'e', 1) as "RESULT1",
    regexp_substr(string1, 'A\\W+(\\w+)', 1, 2, 'e', 1) as "RESULT2",
    regexp_substr(string1, 'A\\W+(\\w+)', 1, 3, 'e', 1) as "RESULT3",
    regexp_substr(string1, 'A\\W+(\\w+)', 1, 4, 'e', 1) as "RESULT4"
    from demo4;
