DROP DATABASE IF EXISTS JOINS;
CREATE DATABASE JOINS;
USE JOINS;

drop table student;

CREATE TABLE STUDENT
(
student_id int,
name varchar(20),
course_id int,
duration int);

insert into student
values
(1,'adam',1,3),
(2,'peter',2,4),
(1,'adam',2,4),
(3,'brian',3,2),
(2,'shane',3,5);

select * from student;

-- now, we are going to get all the result(student_id and name) from the table where student_id is equal, and course_id is not equal.

select s1.student_id, s1.name
from student as s1, student s2
where s1.student_id=s2.student_id
and s1.course_id <> s2.course_id;  -- adam showing two time

select distinct s1.student_id, s1.name
from student as s1, student s2
where s1.student_id=s2.student_id
and s1.course_id <> s2.course_id;  -- remove duplicates

-- SELF JOIN USING INNER JOIN CLAUSE
-- the following  example explains how we can use inner join with self join. this query returns student_id 
-- and name from the table where student_id is equal, and course_id is not equal.

select s1.student_id, s1.name
from student s1
inner join student s2
on s1.student_id = s2.student_id
and s1.course_id <> s2.course_id
group by 1,2; -- if group by not apply it gives duplicates. use the upper one(distinct self join)

-- SELF JOIN USING LEFT JOIN
-- the following example explains how we can use left join with self join.
-- this query returns the student name as monitor and city when the student_id of the both tables are equal.

drop table persons;

CREATE TABLE Persons 
(PersonID int NOT NULL PRIMARY KEY,
 LastName varchar(255) NOT NULL,
 FirstName varchar(255),
 ReportsTo int, 
 Title varchar(255),
 Salary Decimal);
 
 insert into persons
 values
 (1,'Jha','Anand',8,'Analyst',1200000),
 (8,'M','Sangeetha',10,'Manager',4500000),
 (2,'Chaturvedi','Ishan',8,'Data Scientist',1800000),
 (10,'Shekhar','Shreenu',123,'Tech Lead',2300000),
 (4,'Meshram','Vineet',10,'Consultant',1200000),
 (123,'Goel','Neha',134,'Manager',4000000),
 (20,'Kumar','Satish',18,'Data Engineer',800000),
 (18,'Gupta','Ankita',10, 'Buisness Analyst',1000000),
 (7,'Yadav','Abhishek',20,'Data Analyst',1000000),
 (134, 'Dixit','Nitest',27,'VP',20000000),
 (24,'Bandekar','Kalpana',32,'CEO', 50000000);
 
 select * from persons;
 
 -- list of employee who reports to the same manager
select distinct p1.personid as emp_id,
concat(p1.FirstName,' ', p1.LastName) as empfullname, p2.reportsto as manager_id
from persons as p1, persons p2
where p1.personid <> p2.personid
and p1.reportsto = p2.reportsto
order by emp_id,empfullname,manager_id;

-- list of all the managers/reportee and the no of employee directly reporting to them
select distinct p2.reportsto as manager_id,
-- concat(p2.FirstName,' ', p2.LastName) as managerfullname, 
count(distinct p1.personid) as total_emp_reporting
from persons as p1, persons p2
where  p1.personid <> p2.personid
and p1.reportsto = p2.reportsto
group by manager_id
order by manager_id;

-- list of all the manager and the associated employees reporting to them
select concat(b.firstname,' ', b.lastname) as 'Direct Reporting',
 concat(a.firstname,' ', a.lastname) as Manager
from persons b
inner join persons a on a.personid = b.reportsto
order by Manager;

-- list of all the employees and the associated managers if exists
select concat(b.firstname,' ', b.lastname) as 'Direct Reporting',
 concat(a.firstname,' ', a.lastname) as Manager
from persons b
left outer join persons a on a.personid = b.reportsto
order by Manager;


select concat(a.firstname,' ', a.lastname) as Manager,
count(concat(b.firstname,' ', b.lastname)) as tot_emp_reporting
from persons b
left outer join persons a on a.personid = b.reportsto
group by 1
having tot_emp_reporting >= 2
order by 2 desc;

-- successive rows compare salary

select p1.personid,concat(p1.firstname,' ', p1.lastname) as emp_name,
p1.salary
from persons as p1, persons p2
where p1.salary < p2.salary;

-- https://www.educba.com/mysql-self-join/ (read at the time of revising)