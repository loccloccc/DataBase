create database quanlybanhang;

use quanlybanhang;

create table customer(
	customer_id int primary key auto_increment,
    customer_name varchar(100) not null,
    phone varchar(20) not null unique,
    address varchar(100)
);

create table products(
	product_id int primary key auto_increment,
    product_name varchar(100) not null unique,
    price decimal(10,2) not null,
    quantity int not null check(quantity >= 0),
    category varchar(50) not null
);

create table employees(
	employee_id  int primary key auto_increment,
	employee_name varchar(100) not null,
    birthday date,
    position varchar(50) not null ,
    salary decimal(10,2) not null,
    revenue decimal(10,2) default 0
 );
 
 create table orders(
	order_id int primary key auto_increment,
    customer_id int ,
    employee_id int , 
    order_date datetime default current_timestamp,
    total_amount decimal(10,2) default 0,
    foreign key(customer_id) references customer(customer_id),
    foreign key(employee_id) references employees(employee_id)
 );
 
 create table orderDetails(
	order_detail_id int primary key auto_increment,
    order_id int ,
    product_id int ,
    quantity int not null check(quantity >= 0),
    unit_price decimal(10,2) not null ,
    foreign key(order_id) references orders(order_id),
    foreign key(product_id) references products(product_id)
 );
 
 -- Câu 3 - Chỉnh sửa cấu trúc bảng
-- 3.1 Thêm cột email có kiểu dữ liệu varchar(100) not null unique vào bảng Customers
alter table customer add email varchar(100) not null unique ;
-- 3.2 Xóa cột ngày sinh ra khỏi bảng Employees 
alter table employees drop column birthday;

-- Câu 4 - Chèn dữ liệu
-- Viết câu lệnh chèn dữ liệu vào bảng (mỗi bảng ít nhất 5 bản ghi phù hợp)
INSERT INTO customer (customer_name, phone, address, email) VALUES
('Nguyen Van An',  '0901234567', 'Ha Noi',        'an.nguyen@gmail.com'),
('Tran Thi Binh',  '0912345678', 'TP Ho Chi Minh','binh.tran@gmail.com'),
('Le Van Cuong',   '0923456789', 'Da Nang',       'cuong.le@gmail.com'),
('Pham Thi Dao',   '0934567890', 'Hai Phong',     'dao.pham@gmail.com'),
('Hoang Van Em',   '0945678901', 'Can Tho',       'em.hoang@gmail.com');

INSERT INTO products (product_name, price, quantity, category) VALUES
('Laptop Dell', 15000000, 10, 'Laptop'),
('iPhone 14', 20000000, 15, 'Phone'),
('Ban phim co', 1200000, 30, 'Accessory'),
('Chuot Logitech', 800000, 25, 'Accessory'),
('Man hinh Samsung', 5000000, 12, 'Monitor');

INSERT INTO employees (employee_name, position, salary, revenue) VALUES
('Nguyen Minh', 'Sales', 8000000, 0),
('Tran Long', 'Sales', 8500000, 0),
('Le Hoa', 'Manager', 15000000, 0),
('Pham Quang', 'Sales', 8200000, 0),
('Vo Thanh', 'Cashier', 7000000, 0);

INSERT INTO orders (customer_id, employee_id, order_date, total_amount) VALUES
(1, 1, '2025-01-10 09:30:00', 0),
(2, 2, '2025-01-11 10:00:00', 0),
(1, 4, '2025-01-12 14:15:00', 0),
(4, 1, '2025-01-13 16:45:00', 0),
(2, 5, '2025-01-14 11:20:00', 0);


INSERT INTO orderDetails (order_id, product_id, quantity, unit_price) VALUES
(1, 1, 112, 15000000),
(1, 3, 20, 1200000),
(2, 2, 111, 20000000),
(3, 4, 201, 800000),
(4, 5, 10, 5000000);

-- Câu 5 - Truy vấn cơ bản
-- 5.1 Lấy danh sách tất cả khách hàng từ bảng Customers. Thông tin gồm : mã khách hàng, tên khách hàng, email, số điện thoại và địa chỉ
select
customer_id as Ma_khach_hang , 
customer_name as Ten_khach_hang, 
phone as So_dien_thoai , 
address as Dia_chi , 
email as Email
from customer;
-- 5.2 Sửa thông tin của sản phẩm có product_id = 1 theo yêu cầu : product_name= “Laptop Dell XPS” và price = 99.99
update products set product_name= "Laptop Dell XPS" , price = 99.99 where product_id = 1;
-- 5.3 Lấy thông tin những đơn đặt hàng gồm : mã đơn hàng, tên khách hàng, tên nhân viên, tổng tiền và ngày đặt hàng.
select od.order_id as "mã đơn hàng",
c.customer_name as "tên khách hàng",
e.employee_name as "tên nhân viên" ,
od.order_date as "ngày đặt hàng",
od.total_amount as "tổng tiền"
from orders od
join customer c on c.customer_id = od.customer_id
join employees e on e.employee_id = od.employee_id;

-- Câu 6 - Truy vấn đầy đủ
-- 6.1 Đếm số lượng đơn hàng của mỗi khách hàng. Thông tin gồm : mã khách hàng, tên khách hàng, tổng số đơn
select 
c.customer_id as "mã khách hàng" ,
c.customer_name as "tên khách hàng",
count(od.customer_id) as "tổng số đơn" 
from  customer c
join orders od on od.customer_id = c.customer_id
group by c.customer_id ,c.customer_name;
-- 6.2 Thống kê tổng doanh thu của từng nhân viên trong năm hiện tại. Thông tin gồm : mã nhân viên, tên nhân viên, doanh thu
select 
employee_id as "mã nhân viên",
employee_name as "tên nhân viên",
revenue as "doanh thu"
from employees;
-- 6.3 Thống kê những sản phẩm có số lượng đặt hàng lớn hơn 100 trong tháng hiện tại. Thông tin gồm : mã sản phẩm, tên sản phẩm, số lượt đặt và sắp xếp theo số lượng giảm dần
select 
p.product_id as "mã sản phẩm",
p.product_name as "tên sản phẩm" ,
odD.quantity as "số lượt đặt"
from orderDetails odD 
left  join products p on p.product_id = odD.product_id 
where odD.quantity > 100
order by odD.unit_price desc;

-- Câu 7 - Truy vấn nâng cao
-- 7.1 Lấy danh sách khách hàng chưa từng đặt hàng. Thông tin gồm : mã khách hàng và tên khách hàng
select 
c.customer_id as "mã khách hàng",
c.customer_name as "tên khách hàng"
FROM customer c
left join orders od on c.customer_id = od.customer_id
where od.order_id is null;
-- 7.2 Lấy danh sách sản phẩm có giá cao hơn giá trung bình của tất cả sản phẩm
select product_id , product_name from Products
where price > (select avg(price) from Products);

-- 7.3 Tìm những khách hàng có mức chi tiêu cao nhất. Thông tin gồm : mã khách hàng, tên khách hàng và tổng chi tiêu .(Nếu các khách hàng có cùng mức chi tiêu thì lấy hết)

select c.customer_id, c.customer_name, sum(o.total_amount) as tong_chi_tieu
from customers c
join orders o on c.customer_id = o.customer_id
group by c.customer_id, c.customer_name
having sum(o.total_amount) = (select max(tong_chi_tieu) from (
								select sum(total_amount) as tong_chi_tieu
								from orders
								group by customer_id
								) t
);


-- Câu 8 - Tạo view
	-- 8.1 Tạo view có tên view_order_list hiển thị thông tin đơn hàng gồm : mã đơn hàng, tên khách hàng, tên nhân viên, tổng tiền và ngày đặt. Các bản ghi sắp xếp theo thứ tự ngày đặt mới nhất

create or replace view view_order_list as
select o.order_id, c.customer_name, e.employee_name, o.total_amount, o.order_date
from orders o
join customers c on o.customer_id = c.customer_id
join employees e on o.employee_id = e.employee_id
order by o.order_date desc;

	-- 8.2 Tạo view có tên view_order_detail_product hiển thị chi tiết đơn hàng gồm : Mã chi tiết đơn hàng, tên sản phẩm, số lượng và giá tại thời điểm mua. Thông tin sắp xếp theo số lượng giảm dần

create or replace view view_order_detail_product 
as
select od.order_detail_id ,p.product_name ,od.quantity, od.unit_price from OrderDetails od
join Products p on od.product_id = p.product_id
order by od.quantity  desc;

-- Câu 9 - Tạo thủ tục lưu trữ

-- 9.1 Tạo thủ tục có tên proc_insert_employee nhận vào các thông tin cần thiết (trừ mã nhân viên và tổng doanh thu) , thực hiện thêm mới dữ liệu vào bảng nhân viên và trả về mã nhân viên vừa mới thêm.
delimiter //
 create procedure proc_insert_employee (
	 employee_name_in varchar(100),
	 position_in varchar(50),
	 salary_in decimal(10,2),
     out employee_id_out int )
begin
	
    insert into Employees (employee_name,position ,salary ) values (
    employee_name_in ,position_in,salary_in  );
    set employee_id_out = last_insert_id();
end //
delimiter ;

call proc_insert_employee( 'huy', 'bảo vệ' , 1 , @new_employee_id);
select @new_employee_id;
   
-- 9.2 Tạo thủ tục có tên proc_get_orderdetails lọc những chi tiết đơn hàng dựa theo mã đặt hàng.
delimiter //

create procedure proc_get_orderdetails (in order_id_in int)
begin
    select od.order_detail_id, p.product_name, od.quantity, od.unit_price
    from orderdetails od
    join products p on od.product_id = p.product_id
    where od.order_id = order_id_in;
end //

delimiter ;


call proc_get_orderdetails(1);


-- 9.3 Tạo thủ tục có tên proc_cal_total_amount_by_order nhận vào tham số là mã đơn hàng và trả về số lượng loại sản phẩm trong đơn hàng đó.

delimiter //

create procedure proc_cal_total_amount_by_order ( in order_id_in int, out total_product_types int)
begin
    select count(distinct product_id) into total_product_types
    from orderdetails
    where order_id = order_id_in;
end //

delimiter ;

call proc_cal_total_amount_by_order(1, @total_types);
select @total_types;

-- Câu 10 - Tạo trigger
   -- Tạo trigger có tên trigger_after_insert_order_details để tự động cập nhật số lượng
	-- sản phẩm trong kho mỗi khi thêm một chi tiết đơn hàng mới. Nếu số lượng trong kho
	-- không đủ thì ném ra thông báo lỗi “Số lượng sản phẩm trong kho không đủ” và hủy
	-- thao tác chèn.

delimiter //

create trigger trigger_after_insert_order_details
before insert on orderdetails
for each row
begin
    declare current_quantity int;

    select quantity into current_quantity
    from products
    where product_id = new.product_id
    for update;

    if current_quantity < new.quantity then
        signal sqlstate '45000'
        set message_text = 'so luong san pham trong kho khong du';
    else
        update products
        set quantity = quantity - new.quantity
        where product_id = new.product_id;
    end if;
end //

delimiter ;

   
-- Câu 11 - Quản lý transaction
	-- Tạo một thủ tục có tên proc_insert_order_details nhận vào tham số là mã đơn hàng, mã sản phẩm, số lượng và giá sản phẩm. Sử dụng transaction thực hiện các yêu cầu sau :

	-- Kiểm tra nếu mã hóa đơn không tồn tại trong bảng order thì ném ra thông báo
	-- lỗi “không tồn tại mã hóa đơn”.
	-- Chèn dữ liệu vào bảng order_details
	-- Cập nhật tổng tiền của đơn hàng ở bảng Orders
	-- Nếu như có bất cứ lỗi nào sinh ra, rollback lại Transaction
delimiter //

create procedure proc_insert_order_details (
    in order_id_in int,
    in product_id_in int,
    in quantity_in int,
    in unit_price_in decimal(10,2)
)
begin
    declare order_count int;
    declare total_money decimal(10,2);

    declare exit handler for sqlexception
    begin
        rollback;
        signal sqlstate '45000'
        set message_text = 'co loi xay ra, rollback transaction';
    end;

    start transaction;

    -- kiem tra ma hoa don
    select count(*) into order_count
    from orders
    where order_id = order_id_in;

    if order_count = 0 then
        signal sqlstate '45000'
        set message_text = 'khong ton tai ma hoa don';
    end if;

    -- them chi tiet don hang
    insert into orderdetails (order_id, product_id, quantity, unit_price)
    values (order_id_in, product_id_in, quantity_in, unit_price_in);

    -- cap nhat tong tien don hang
    select sum(quantity * unit_price) into total_money
    from orderdetails
    where order_id = order_id_in;

    update orders
    set total_amount = total_money
    where order_id = order_id_in;

    commit;
end //

delimiter ;