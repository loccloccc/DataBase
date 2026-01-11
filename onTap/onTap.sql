create database on_tap;
use on_tap;
--  drop database on_tap;

create table customers(
    id int primary key auto_increment,
    name varchar(255) not null,
    email varchar(255) not null
);

create table orders(
    id int primary key auto_increment,
    customer_id int,
    order_date date,
    total_amount decimal(10,2),
    foreign key(customer_id) references customers(id)
);

insert into customers(name, email) values
('Nguyen Van A', 'a@example.com'),
('Tran Thi B', 'b@example.com'),
('Le Van C', 'c@example.com'),
('Pham Thi D', 'd@example.com'),
('Hoang Van E', 'e@example.com');


insert into orders(customer_id, order_date, total_amount) values
(1, '2026-01-01', 12000000),
(2, '2026-01-02', 8000000),
(1, '2026-01-03', 15000000),
(3, '2026-01-04', 6000000),
(4, '2026-01-05', 9000000);

select name as "ten khach hang", (select sum(total_amount) from orders o where o.customer_id  = c.id) as "so luong " from customers c where id in (select customer_id from orders);


