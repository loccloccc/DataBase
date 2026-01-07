create database demo_sql;

use demo_sql;


create table classes(
	class_id char(20) not null primary key,
    class_name varchar(100) not null unique
);

create table students(
	stu_id int auto_increment primary key,
    full_name varchar(50),
    gender bit,
    birthday date,
    address varchar(200),
    class_id char(20),
    foreign key(class_id) references classes(class_id)
);

insert into classes(class_id,class_name) values
('hn-k24-cntt01','Lớp lập trình vien 01 k24 Hà Nội'),
('hn-k24-cntt02','Lớp lập trình vien 02 k24 Hà Nội'),
('hn-k24-cntt03','Lớp lập trình vien 03 k24 Hà Nội'),
('hn-k24-cntt04','Lớp lập trình vien 04 k24 Hà Nội'),
('hn-k24-cntt05','Lớp lập trình vien 05 k24 Hà Nội');

select * from classes;

select class_id as 'Mã lớp', class_name as 'Tên lớp' from classes;

insert into students(full_name,gender,birthday,address,class_id) values
('Nguyễn Văn Cường',1,'2005-12-21','Thái Bình','hn-k24-cntt01'),
('Nguyễn Lâm Anh',1,'2005-06-03','Thái Bình','hn-k24-cntt01'),
('Nguyễn Thuý Hường',0,'2005-10-11','Hà Nội','hn-k24-cntt02'),
('Nguyễn Vân Giang',0,'2005-08-17','Tuyên Quang','hn-k24-cntt02'),
('Nguyễn Tường Vy',0,'2005-05-25','Hà Nội','hn-k24-cntt03');

-- Lấy ra số sinh viên của các lớp, thông tin gồm: Mã lớp, tên lớp, số sinh viên
select c.class_id as 'Mã lớp', c.class_name as 'Tên lớp', count(*) as 'Số sinh viên' 
from classes c join students s on c.class_id = s.class_id
group by c.class_id, c.class_name;

-- Lấy ra thông tin các sinh viên của lớp cntt02:
select * from students where class_id = 'hn-k24-cntt02';

-- Lấy ra thông tin các sinh viên nam của lớp hn-24-cntt01:
select * from students where class_id='hn-k24-cntt01' and gender=1;

select s.stu_id,s.full_name,s.gender, s.birthday,s.address,c.class_name 
from students s join classes c on s.class_id = c.class_id;

select s.stu_id,s.full_name,case s.gender when 1 then 'Nam' when 0 then 'Nữ' end as 'gender', s.birthday,s.address,c.class_name 
from students s join classes c on s.class_id = c.class_id;

-- LEFT JOIN:
select * from classes;

select c.*,s.* from classes c left join students s on c.class_id=s.class_id;

-- DEMO: BỎ KHOÁ NGOẠI ĐI, THÊM 1 SỐ DÒNG CHỈ CÓ DỮ LIỆU Ở BÊN PHẢI
alter table students drop constraint students_ibfk_1;

-- Thêm dl mã lớp ở bảng students mà không tồn tại ở bảng classes
insert into students(full_name,gender,birthday,address,class_id) values
('Trần Đức Nam',1,'2005-04-11','Thái Nguyên','hn-k24-cntt10'),
('Lê Thanh Hà',0,'2005-03-16','Nghệ An','hn-k24-cntt11');

select * from students;

-- SỬ DỤNG CÂU LỆNH RIGHT JOIN: -> Lấy hết dữ liệu ở bảng bên phải, bảng bên trái không có dl thì để null
select c.*,s.* from classes c right join students  s on c.class_id = s.class_id;

-- Thông thường chỉ sử dụng: JOIN hoặc INNER JOIN 
-- -> Chỉ lấy ra các bản ghi mà có giá trị bằng nhau ở các cột chung giữa 2 bảng

-- Lấy ra thông tin các lớp học chưa có sinh viên nào? (mã lớp, tên lớp)
	select * from students;
    
    select c.class_id as 'Mã lớp', c.class_name as 'Tên lớp' from classes c
    where c.class_id not in (select distinct class_id from students);
    
    
-- Lấy ra thông tin các sinh viên có mã lớp nhưng chưa đúng? (mã sinh viên, họ tên, giới tính, ngày sinh, quê quán, mã lớp sai)
	select * from students where class_id not in (select class_id from classes);

insert into students(full_name,gender,birthday,address,class_id) values
('Lại Thành Nam',1,'2005-10-22','TP. Hồ Chí Minh','hn-k24-cntt03'),
('Ngô Quang Hà',1,'2005-11-13','Nghệ An','hn-k24-cntt03');

-- Lấy ra thông tin các sinh viên có tên là Nam:   '%Nam', 'Nguyễn%', '%Nam%'
select * from students where full_name like '%Nam';    

-- CASE EXPRESSION 
-- WHEN <VALUE_1> THEN <RETURN_VALUE1>
-- WHEN <VALUE_2> THEN <RETURN_VALUE2>
-- ...
-- END AS 'COLUMN_DISPLAY_NAME'
select * from students;

-- sử dụng case ... when để hiển thị cột giới tính là nam hay nữ
select stu_id,full_name,case gender when 1 then 'Nam' when 0 then 'Nữ' end as 'gender',
birthday,address,class_id from students;

-- Hiển thị thông tin sinh viên mà cột giới tính hiển thị là Nam, Nữ; 
-- cột ngày sinh hiển thị theo định dạng việt nam : dd-mm-yyyy
select stu_id,full_name,case gender when 1 then 'Nam' when 0 then 'Nữ' end as 'gender',
date_format(birthday,'%d-%m-%Y') as birthday,address,class_id from students;
	
    
-- Dữ liệu bóng đá
create table doi_bong(
	ma_doi_bong char(15) not null primary key,
    ten_doi_bong varchar(100) not null unique
);

create table tt_thi_dau(
	ma_tran_dau int auto_increment primary key,
    ngay_thi_dau date,
    ma_doi_bong char(15),
    so_ban_thang int check(so_ban_thang>=0),
    so_ban_thua int check(so_ban_thua>=0),
    diem int check(diem>=0 and diem<=3)
);

insert into doi_bong(ma_doi_bong,ten_doi_bong) values
('MU','Manchester United'),
('ARS','Arsenal'),
('LIV','Liverpool');

insert into tt_thi_dau(ngay_thi_dau,ma_doi_bong,so_ban_thang,so_ban_thua) values
('2025-10-22','MU',3,1),
('2025-10-22','ARS',1,3),
('2025-10-30','MU',2,2),
('2025-10-30','LIV',2,2),
('2025-11-10','ARS',0,2),
('2025-11-10','LIV',2,0);

select * from tt_thi_dau;

-- Cập nhật cột điểm trong bảng tt_thi_dau cho các đội bong
-- Cách tính: số bàn thắng>số bàn thua: 3 điểm
-- số bàn thắng = số bàn thua: 1 điểm
-- số bàn thắng < số bàn thua: 0 điểm

update tt_thi_dau set diem =(
	case when so_ban_thang - so_ban_thua>0 then 3
    when so_ban_thang - so_ban_thua=0 then 1
    when so_ban_thang - so_ban_thua<0 then 0 end
);

-- Truy vấn để lấy thông tin 2 trận thắng trong bảng trên
-- asc: ascending -> Tăng dần;  desc: descending -> Giảm dần
select * from tt_thi_dau order by diem desc limit 2 offset 0;

-- Nhập thêm 2 đội khác nữa
insert into doi_bong(ma_doi_bong,ten_doi_bong) values
('MC','Manchester City'),
('CHE','Cheseal');

-- Hiển thị thông tin các đội bóng chưa thi đấu trận nào?
select * from doi_bong where ma_doi_bong not in (select distinct ma_doi_bong from tt_thi_dau);

-- Demo left join: 
select db.*,td.* from doi_bong db left join tt_thi_dau td
on db.ma_doi_bong = td.ma_doi_bong;

-- Lấy ra thông tin trận đấu của các đội bóng chỉ thắng hoặc hoà
select * from tt_thi_dau where diem between 1 and 3;

-- THÔNG TIN ĐIỂM THI
create table subject(
	subject_id char(15) not null primary key,
    subject_name varchar(100) not null unique
);

create table exam(	
	stu_id char(20) not null,
    subject_id char(15) not null,
    times int check(times>0),
    exam_date date,
    mark float check(mark>=0 and mark<=10)
);

insert into subject(subject_id, subject_name) values
('c','Lập trình C'),
('ja','Lập trình Java'),
('c#','Lập trình .Net');

select * from students;
insert into exam(stu_id,subject_id,times,exam_date,mark) values
(1,'c',1,'2025-05-10',3),
(1,'c',2,'2025-05-20',4),
(1,'c',3,'2025-06-08',7),
(1,'ja',1,'2025-07-11',6),
(2,'c',1,'2025-05-10',10),
(3,'c',1,'2025-05-10',2),
(3,'c',2,'2025-05-20',6),
(2,'ja',1,'2025-07-11',9),
(3,'ja',1,'2025-07-11',4),
(3,'ja',2,'2025-08-15',7);

select * from exam;

insert into exam(stu_id,subject_id,times,exam_date,mark) values
(4,'c',1,'2025-05-10',1),
(4,'c',2,'2025-05-20',2);

insert into exam(stu_id,subject_id,times,exam_date,mark) values
(3,'c',3,'2025-11-28',6);

-- Lấy thông tin điểm thi của tất cả sinh viên, điểm thi là điểm thi cao nhất trong các lần thi

-- Truy vấn lần 1 để lấy điểm thi cao nhất theo môn của từng sinh viên
-- -> Nhóm theo mã sinh viên và mã môn, lấy max(điểm)
-- Truy vấn lần 2 để lấy ngày thi sau cùng nếu điểm thi các lần bằng nhau
-- Truy vấn lền 3 để lấy toàn bộ thông tin của bảng điểm thi

SELECT e1.* FROM exam e1
JOIN (
    SELECT stu_id, subject_id, mark, MAX(exam_date) AS exam_date
    FROM exam
    WHERE (stu_id, subject_id, mark) IN (
        SELECT stu_id, subject_id, MAX(mark)
        FROM exam
        GROUP BY stu_id, subject_id
    )
    GROUP BY stu_id, subject_id, mark
) e2
ON e1.stu_id = e2.stu_id
AND e1.subject_id = e2.subject_id
AND e1.mark = e2.mark
AND e1.exam_date = e2.exam_date;


-- DỮ LIỆU TEST PHÂN TRANG:
create table san_pham(
	ma_sp int auto_increment primary key,
    ten_sp varchar(100),
    nha_cc varchar(100)
);

insert into san_pham(ten_sp,nha_cc) values
('sanpham_01','nhacc_01'),
('sanpham_02','nhacc_02'),
('sanpham_03','nhacc_03'),
('sanpham_04','nhacc_04'),
('sanpham_05','nhacc_05'),
('sanpham_06','nhacc_06'),
('sanpham_07','nhacc_07'),
('sanpham_08','nhacc_08'),
('sanpham_09','nhacc_09'),
('sanpham_10','nhacc_10'),
('sanpham_11','nhacc_11'),
('sanpham_12','nhacc_12'),
('sanpham_13','nhacc_13'),
('sanpham_14','nhacc_14'),
('sanpham_15','nhacc_15'),
('sanpham_16','nhacc_16'),
('sanpham_17','nhacc_17'),
('sanpham_18','nhacc_18'),
('sanpham_19','nhacc_19'),
('sanpham_20','nhacc_20'),
('sanpham_21','nhacc_21'),
('sanpham_22','nhacc_22'),
('sanpham_23','nhacc_23'),
('sanpham_24','nhacc_24'),
('sanpham_25','nhacc_25'),
('sanpham_26','nhacc_26'),
('sanpham_27','nhacc_27'),
('sanpham_28','nhacc_28'),
('sanpham_29','nhacc_29'),
('sanpham_30','nhacc_30');

-- Trang 0:
select * from san_pham limit 5 offset 0;

-- Trang 1:
select * from san_pham limit 5 offset 5;

-- Trang 5:
select * from san_pham limit 5 offset 20;