-- Tạo database
create database session6;
use session6;

-- Tạo bảng Customers
create table Customers(
    customers_id int primary key,
    full_name varchar(255) not null,
    city varchar(255)
);

-- Tạo bảng Orders
create table Orders(
    order_id int primary key,
    customers_id int,
    order_date date not null,
    statu enum('pending', 'completed', 'cancelled'),
    foreign key(customers_id) references Customers(customers_id)
);


-- BÀI 1


-- Thêm dữ liệu vào Customers
insert into Customers values 
(1,"Nguyen Van A","Ha Noi"),
(2,"Nguyen Van B","Phu Tho"),
(3,"Nguyen Van C","Ha Giang"),
(4,"Nguyen Van D","Bac Ninh"),
(5,"Nguyen Van E","Sa Pa");

-- Thêm dữ liệu vào Orders
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
select o.order_id, c.full_name as "Ten khach", o.order_date, o.statu
from Customers c 
join Orders o on c.customers_id = o.customers_id;

-- Hiển thị mỗi khách hàng đã đặt bao nhiêu đơn hàng
select c.full_name as "Ten khach hang", count(o.order_id) as "So lan dat"
from Customers c
join Orders o on c.customers_id = o.customers_id
group by c.customers_id, c.full_name;

-- Chỉ hiển thị các khách hàng có ít nhất 1 đơn hàng
select c.full_name as "Ten khach hang", count(o.order_id) as "So lan dat"
from Customers c
join Orders o on c.customers_id = o.customers_id
group by c.customers_id, c.full_name
having count(o.order_id) >= 1;

-- BÀI 2


-- Thêm cột total_amount
alter table Orders add total_amount decimal(10,2);

-- Cập nhật tổng tiền
update Orders set total_amount = 1000000 where order_id = 1;
update Orders set total_amount = 1200000 where order_id = 2;
update Orders set total_amount = 1100000 where order_id = 3;
update Orders set total_amount = 1400000 where order_id = 4;
update Orders set total_amount = 1200000 where order_id = 5;
update Orders set total_amount = 1100000 where order_id = 6;
update Orders set total_amount = 1500000 where order_id = 7;
update Orders set total_amount = 2300000 where order_id = 8;

-- Hiển thị tổng tiền mỗi khách đã chi tiêu
select c.full_name as "Ten khach hang",
       sum(o.total_amount) as "Tong chi tieu"
from Customers c
join Orders o on o.customers_id = c.customers_id
group by c.customers_id, c.full_name;

-- Hiển thị giá trị đơn hàng cao nhất của từng khách
select c.full_name as "Ten khach hang",
       max(o.total_amount) as "Don cao nhat"
from Customers c
join Orders o on o.customers_id = c.customers_id
group by c.customers_id, c.full_name;

-- Sắp xếp danh sách khách hàng theo tổng tiền giảm dần
select c.full_name as "Ten khach hang",
       sum(o.total_amount) as "Tong chi tieu"
from Customers c
join Orders o on o.customers_id = c.customers_id
group by c.customers_id, c.full_name
order by sum(o.total_amount) desc;


-- BÀI 3


-- Tính tổng doanh thu theo từng ngày
select od.order_date as "Ngay",
       sum(od.total_amount) as "Tong doanh thu"
from Orders od
group by od.order_date;

-- Tính số lượng đơn hàng theo từng ngày
select od.order_date as "Ngay",
       count(*) as "So don"
from Orders od
group by od.order_date;

-- Chỉ hiển thị ngày có doanh thu > 2.000.000
select od.order_date as "Ngay",
       sum(od.total_amount) as "Doanh thu"
from Orders od
group by od.order_date
having sum(od.total_amount) > 2000000;

-- BÀI 5


select c.customers_id,
       c.full_name,
       count(o.order_id) as total_order,
       sum(o.total_amount) as total_spent,
       avg(o.total_amount) as avg_order_price
from Customers c
join Orders o on c.customers_id = o.customers_id
group by c.customers_id, c.full_name
having count(o.order_id) >= 3
   and sum(o.total_amount) > 10000000
order by total_spent desc;
