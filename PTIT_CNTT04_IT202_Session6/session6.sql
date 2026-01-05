create database session6;

use session6;

create table Customers(
	customers_id int primary key,
    full_name varchar(255) not null,
    city varchar(255)
);

create table Orders(
	order_id int primary key,
    customers_id int,
    order_date date not null,
    statu enum('pending', 'completed', 'cancelled'),
    foreign key(customers_id) references Customers(customers_id)
);

-- Thêm dữ liệu vào bảng customers tối thiếu 5 dữ liệu
insert into Customers values 
(1,"Nguyen Van A","Ha Noi"),
(2,"Nguyen Van B","Phu Tho"),
(3,"Nguyen Van C","Ha Giang"),
(4,"Nguyen Van D","Bac Ninh"),
(5,"Nguyen Van E","Sa Pa");
-- Thêm dữ liệu vào bảng orders tối thiểu 5 dữ liệu
insert into Orders values 
(1,1,'2020-05-04','pending'),
(2,3,'2020-06-04','completed'),
(3,4,'2020-02-04','completed'),
(4,3,'2020-06-04','cancelled'),
(5,5,'2020-08-04','completed'),
(6,2,'2020-11-04','pending'),
(7,5,'2020-10-04','cancelled'),
(8,1,'2020-05-04','pending');

-- Hiển thị danh sách đơn hàng kèm tên khách hàng
select o.order_id, c.full_name as "ten khach", o.order_date,o.statu
from Customers c 
join Orders o on c.customers_id = o.customers_id;
-- Hiển thị mỗi khách hàng đã đặt bao nhiêu đơn hàng
select c.full_name as "ten khach hang", count(o.order_id) as "so lan"
from Customers c
join Orders o on c.customers_id = o.customers_id
group by c.customers_id, c.full_name;
-- Chỉ hiển thị các khách hàng có ít nhất 1 đơn hàng
select c.full_name as "ten khach hang", count(o.order_id) as "so lan"
from Customers c
join Orders o on c.customers_id = o.customers_id
group by c.customers_id, c.full_name
having count(o.order_id) >= 1 ;