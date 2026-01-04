create database bai2;

use bai2;

create table Customers(
	customers_id int primary key,
    full_name varchar(255) not null unique,
    email varchar(255) not null unique, 
    city varchar(255),
    status_customer enum("active","inactive")
);
-- them 
insert into Customers values 
(1,"Nguyen Van A" , "a@gmail.com","Ha Noi","active"),
(2,"Nguyen Van B" , "b@gmail.com","TP HCM","active"),
(3,"Nguyen Van K" , "c@gmail.com","Ha Noi","inactive"),
(4,"Nguyen Van D" , "d@gmail.com","TP HCM","active"),
(5,"Nguyen Van E" , "e@gmail.com","TP HCM","inactive"),
(6,"Nguyen Van F" , "f@gmail.com","Ha Noi","active");

select *from Customers;

-- lay khach o HCM
select *from Customers where city = "TP HCM";

-- lay khach dang hoat dong o ha noi
select *from Customers where city = "Ha Noi" and status_customer = "active";

-- sap xep khach hang theo ten 
select *from Customers order by full_name asc;

