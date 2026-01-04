create database bai1;

use bai1;

create table Products(
	product_id int primary key,
    product_name varchar(150) not null,
    price decimal(10,2) not null,
    stock int ,
    status_products enum('active','inactive')
);

-- them san pham
insert into Products values
(1,"mi tom" ,1200000,100,'active'),
(2,"san" ,10000,101,'active'),
(3,"khoai" ,1400000,120,'inactive'),
(4,"gao" ,10000,103,'active'),
(5,"ngo" ,10000,102,'inactive');

-- lay toan bo
select *from Products;
-- lay danh sach san pham dang ban active
select *from Products where status_products = 'active';
-- lay danh sach tren 1000000
select * from Products where price > 1000000;

-- sap xep san phan dang ban theo gia tang dan
select * from Products where status_products = 'active' order by price asc;