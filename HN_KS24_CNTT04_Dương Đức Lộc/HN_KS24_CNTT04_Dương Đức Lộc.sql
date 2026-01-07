CREATE DATABASE mini_project_ss08;
USE mini_project_ss08;

-- Xóa bảng nếu đã tồn tại (để chạy lại nhiều lần)
DROP TABLE IF EXISTS bookings;
DROP TABLE IF EXISTS rooms;
DROP TABLE IF EXISTS guests;

-- Bảng khách hàng
CREATE TABLE guests (
    guest_id INT PRIMARY KEY AUTO_INCREMENT,
    guest_name VARCHAR(100),
    phone VARCHAR(20)
);

-- Bảng phòng
CREATE TABLE rooms (
    room_id INT PRIMARY KEY AUTO_INCREMENT,
    room_type VARCHAR(50),
    price_per_day DECIMAL(10,0)
);

-- Bảng đặt phòng
CREATE TABLE bookings (
    booking_id INT PRIMARY KEY AUTO_INCREMENT,
    guest_id INT,
    room_id INT,
    check_in DATE,
    check_out DATE,
    FOREIGN KEY (guest_id) REFERENCES guests(guest_id),
    FOREIGN KEY (room_id) REFERENCES rooms(room_id)
);

INSERT INTO guests (guest_name, phone) VALUES
('Nguyễn Văn An', '0901111111'),
('Trần Thị Bình', '0902222222'),
('Lê Văn Cường', '0903333333'),
('Phạm Thị Dung', '0904444444'),
('Hoàng Văn Em', '0905555555');

INSERT INTO rooms (room_type, price_per_day) VALUES
('Standard', 500000),
('Standard', 500000),
('Deluxe', 800000),
('Deluxe', 800000),
('VIP', 1500000),
('VIP', 2000000);

INSERT INTO bookings (guest_id, room_id, check_in, check_out) VALUES
(1, 1, '2024-01-10', '2024-01-12'), -- 2 ngày
(1, 3, '2024-03-05', '2024-03-10'), -- 5 ngày
(2, 2, '2024-02-01', '2024-02-03'), -- 2 ngày
(2, 5, '2024-04-15', '2024-04-18'), -- 3 ngày
(3, 4, '2023-12-20', '2023-12-25'), -- 5 ngày
(3, 6, '2024-05-01', '2024-05-06'), -- 5 ngày
(4, 1, '2024-06-10', '2024-06-11'); -- 1 ngày


-- Liệt kê tên khách và số điện thoại của tất cả khách hàng
select  guest_name as "Ten khach hang", phone as "So dien thoai" from guests;

-- ●Liệt kê các loại phòng khác nhau trong khách sạn
select distinct room_type as "Cac loai phong" from rooms;

-- ●Hiển thị loại phòng và giá thuê theo ngày, sắp xếp theo giá tăng dần
select  room_type as "Loai phong" ,  price_per_day as "gia phong" from rooms order by price_per_day asc;

-- ●Hiển thị các phòng có giá thuê lớn hơn 1.000.000
select  room_type as "Loai phong" ,  price_per_day as "gia phong" from rooms where price_per_day > 1000000;

-- ●Liệt kê các lần đặt phòng diễn ra trong năm 2024
select *from bookings where (check_in >= '2024-01-01' and check_in <= '2024-12-31');

-- ●Cho biết số lượng phòng của từng loại phòng
select r.room_type as "phong" , count(b.room_id) as "so phong" 
from rooms r
join bookings b on b.room_id = r.room_id 
group by b.room_id;

-- hien thi : ten khach hang , loai phong da dat , ngay nhan phong
select g.guest_name as "Ten khach hang" , r.room_type as "Loai phong" , b.check_in as "Ngay dat"
from bookings b
join guests g on g.guest_id = b.guest_id
join rooms r on r.room_id = b.room_id;

-- ●Cho biết mỗi khách đã đặt phòng bao nhiêu lần
select g.guest_name  as "Ten khach hang" , count(b.guest_id) as "So lan"
from guests g
join bookings b on b.guest_id = g.guest_id
group by b.guest_id;
 
 -- Tính doanh thu của mỗi phòng 
 select r.room_type as "Ten phong" , sum((b.check_out - b.check_in) * r.price_per_day) as "Doanh thu" 
 from rooms r
 join bookings b on b.room_id = r.room_id
 group by b.room_id;
 
 -- ●Tìm những khách đã đặt phòng từ 2 lần trở lên
 select g.guest_name  as "Ten khach hang" , count(b.guest_id) as "So lan"
from guests g
join bookings b on b.guest_id = g.guest_id
group by b.guest_id
having count(b.guest_id) >= 2;

