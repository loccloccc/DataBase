create database bai5;
use bai5;

create table Orders(
	order_id int primary key,
    customer_id int ,
    total_amount decimal(10,2),
    order_date date,
    status_order enum("pending","completed","cancelled")
);

insert into Orders values 
(1, 101, 2500000.50, '2026-01-01', 'pending'),
(2, 102, 1200000.00, '2026-01-02', 'pending'),
(3, 103, 750000.25,  '2026-01-03', 'pending'),
(4, 104, 3100000.00, '2026-01-04', 'pending'),
(5, 105, 990000.99,  '2026-01-05', 'pending'),

(6, 106, 4500000.00, '2026-01-06', 'completed'),
(7, 107, 2200000.75, '2026-01-07', 'completed'),
(8, 108, 1800000.40, '2026-01-08', 'completed'),
(9, 109, 5600000.00, '2026-01-09', 'completed'),
(10, 110, 3000000.00,'2026-01-10', 'completed'),

(11, 111, 1500000.00,'2026-01-11', 'cancelled'),
(12, 112, 2000000.00,'2026-01-12', 'cancelled'),
(13, 113, 9900000.50, '2026-01-13', 'cancelled'),
(14, 114, 7500000.00, '2026-01-14', 'cancelled'),
(15, 115, 4000000.00,'2026-01-15', 'cancelled'),

(16, 106, 4500000.00, '2026-01-06', 'completed'),
(17, 107, 2200000.75, '2026-01-07', 'completed'),
(18, 108, 1800000.40, '2026-01-08', 'completed'),
(19, 109, 5600000.00, '2026-01-09', 'completed'),
(20, 110, 3000000.00,'2026-01-10', 'completed'),

(21, 101, 2500000.50, '2026-01-01', 'pending'),
(22, 102, 1200000.00, '2026-01-02', 'pending'),
(23, 103, 750000.25,  '2026-01-03', 'pending'),
(24, 104, 3100000.00, '2026-01-04', 'pending'),
(25, 105, 990000.99,  '2026-01-05', 'pending');

-- lay 5sp trang 1
select *from Orders where  status_order <> "cancelled" order by order_date desc limit 5 offset 5;

-- trang 2 
select *from Orders where  status_order <> "cancelled" order by order_date desc limit 5 offset 10;

-- trang 3
select *from Orders where  status_order <> "cancelled" order by order_date desc limit 5 offset 15;