create database bai2;

use bai2;

create table Students3(
	id_Stu int primary key ,
    full_name varchar(50) not null,
    date_of_birth date ,
    email varchar(50) unique
);

insert into Students3 values 
(1,"Duong Duc Loc",'2006-05-25',"a@gmail.com"),
(2,"Duong Duc Dung",'2003-05-25',"v@gmail.com"),
(3,"Duong Duc Chung",'2003-05-25',"q@gmail.com"),
(4,"Duong Duc Mai",'2003-05-25',"e@gmail.com"),
(5,"Duong Duc Hoang",'2001-05-25',"f@gmail.com");

select *from Students3; 

-- cap nhat email id = 3 
update Students3
set email = "ID3@gmail.com"
where id_Stu = 3;
-- cap nhap ngay sinh id = 2 
update Students3
set date_of_birth = '2025-05-05'
where id_Stu = 2;

-- xóa sinh viên id = 5 

delete from Students3
where id_Stu = 5;