create database session6_2;
use session6_2;

-- bai 4 
create table Products(
	product_id int primary key,
    product_name varchar(255) not null,
    price decimal(10,2) not null
);

create table Order_items(
	order_id int primary key,
    product_id int,
    quantity int not null,
    foreign key(product_id) references Products(product_id)
);

insert into Products values
(1,'Laptop Dell Inspiron',18500000.00),
(2,'Chuột Logitech M331',450000.00),
(3,'Bàn phím cơ DareU',890000.00),
(4,'Màn hình Samsung 24 inch',3200000.00),
(5,'Tai nghe Sony WH-CH510',1490000.00),
(6,'USB Kingston 32GB',190000.00);


insert into Order_items values
(101,1,2),   
(102,3,1),   
(103,5,3),   
(104,2,4),   
(105,4,1),   
(106,6,5);   

-- Hiển thị mỗi sản phẩm đã bán được bao nhiêu sản phẩm
select p.product_id,p.product_name,p.price,o.quantity
from Products p 
left join Order_items o
on p.product_id = o.product_id;
-- Tính doanh thu của từng sản phẩm
select p.product_id,p.product_name,sum(o.quantity*p.price) as toatl_price
from Products p 
left join Order_items o
on p.product_id = o.product_id
group by p.product_id,p.product_name;
-- Chỉ hiển thị các sản phẩm có doanh thu > 5.000.000
select p.product_id,p.product_name,sum(o.quantity*p.price) as toatl_price
from Products  p 
left join Order_items o
on p.product_id = o.product_id
group by p.product_id,p.product_name
having sum(o.quantity*p.price)>5000000;

-- bài 6 
select p.product_name ,sum(o.quantity) as quantity ,sum(o.quantity*p.price) as total_price  ,sum(o.quantity * p.price) / SUM(o.quantity) as avg_price
from Products p
join Order_items o
on p.product_id = o.product_id
group by p.product_id,p.product_name
having sum(o.quantity) >= 10
order by  total_price desc 
limit 5;

