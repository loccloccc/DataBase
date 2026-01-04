create database bai3;
use bai3;

create table Orders(
	order_id int primary key,
    customer_id int unique,
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
(15, 115, 4000000.00,'2026-01-15', 'cancelled');

-- lay down hang da hoan thanh
select *from Orders where status_order = "completed";
-- lay don hang co tong > 5 tr
select *from Orders where total_amount > "5000000";
-- hien thi 5 don hang moi nhat
select *from Orders order by order_date desc limit 5;
-- lay cac don hang da hoan thanh va sap xep tong tien giam dan
select *from Orders where status_order = "completed" order by total_amount desc;