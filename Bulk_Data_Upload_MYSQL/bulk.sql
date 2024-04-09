create database salesdata;

use salesdata;

create table salesdata
(
Model Varchar(30),
Color Varchar(30),
ReportingYear Varchar(5),
ReportingMonth Varchar(5),
Registration_Date Varchar(10),
VehicleType  Varchar(15),
InvoiceNumber Varchar(250)
);

Load Data infile
"D:/Data Analyst/Resources/LECTURE 20 BULK DATA UPLOAD IN MYSQL/SalesData.csv"
into table salesdata
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 rows;

show global variables like 'local_infile';
set global local_infile = 1;

select * from salesdata;