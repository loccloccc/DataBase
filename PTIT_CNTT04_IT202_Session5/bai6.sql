create database bai6;

use bai6;

create table Products(
	product_id int primary key,
    product_name varchar(150) not null,
    price decimal(10,2) not null,
    stock int ,
    status_products enum('active','inactive')
);

-- them bang sold_quantity
alter table Products add sold_quantity int;

insert into Products values
(1,"mi tom" ,7200000,100,'active',1000),
(2,"san" ,410000,101,'active',2133),
(3,"khoai" ,1400000,120,'inactive',3000),
(4,"gao" ,10000,103,'active',100),
(5,"ngo" ,1110000,102,'inactive',50),
(6,"gao" ,2210000,103,'active',100),
(7,"gao" ,10000,103,'active',300),
(8,"gao" ,5410000,103,'active',1100),
(9,"gao" ,10000,103,'active',4100),
(10,"gao" ,1110000,103,'active',1400),
(11,"gao" ,1670000,103,'active',1500),
(12,"gao" ,10000,103,'active',6100),
(13,"gao" ,10000,103,'active',1200),
(14,"gao" ,10000,103,'active',2100);

select *from Products where (status_products = "active" and (price >= 1000000 and price <= 3000000));

select *from Products order by price asc;

select *from Products limit 10 ;
select *from Products limit 10 offset 10;