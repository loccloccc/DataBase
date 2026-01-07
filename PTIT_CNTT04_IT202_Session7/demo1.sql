create database demo_sql_1;

use demo_sql_1;


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

insert into students(full_name,gender,birthday,address,class_id) values
('Nguyễn Văn Cường',1,'2005-12-21','Thái Bình','hn-k24-cntt01'),
('Nguyễn Lâm Anh',1,'2005-06-03','Thái Bình','hn-k24-cntt01'),
('Nguyễn Thuý Hường',0,'2005-10-11','Hà Nội','hn-k24-cntt02'),
('Nguyễn Vân Giang',0,'2005-08-17','Tuyên Quang','hn-k24-cntt02'),
('Nguyễn Tường Vy',0,'2005-05-25','Hà Nội','hn-k24-cntt03'); 

select * from classes;
select * from students;

-- dat ten ma lop va ten lop cho bang class dung as 
select class_id  as "Ma lop", class_name as "Ten lop" from classes;

-- Lấy ra số sinh viên của các lớp, thông tin gồm: Mã lớp, tên lớp, số sinh viên
-- join on : Nối 2 bảng lại với nhau dựa trên điều kiện

select c.class_id as "Mã lớp" , c.class_name as "Tên lớp"  , count(*) as "Số sinh viên"
from classes c
join students s on s.class_id = c.class_id
group by c.class_id , c.class_name;

select s.stu_id,s.full_name,s.gender, s.birthday,s.address,c.class_name 
from students s join classes c on s.class_id = c.class_id;

-- xóa khóa ngoại bằng alert : alter table students drop constraint students_ibfk_1;
-- thêm khóa ngoiaj bằng alert : ALTER TABLE students ADD CONSTRAINT fk_students_class FOREIGN KEY (class_id) REFERENCES classes(class_id);

