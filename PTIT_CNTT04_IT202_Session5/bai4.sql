create database bai4;

use bai4;

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

-- lay 10 sp ban chay nhat
select *from Products order by sold_quantity desc limit 10;

-- lay 5 san pham ban chay tiep theo
select *from Products order by sold_quantity desc limit 5 offset 10 ;

select *from Products where price < 2000000 order by sold_quantity desc;




