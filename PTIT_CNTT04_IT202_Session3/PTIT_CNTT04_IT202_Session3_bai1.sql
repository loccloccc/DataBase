create database bai1;

use bai1;

create table Students2(
	id_Stu int primary key ,
    full_name varchar(50) not null,
    date_of_birth date ,
    email varchar(50) unique
);

insert into Students2 values 
(1,"Duong Duc Loc",'2006-05-25',"a@gmail.com"),
(2,"Duong Duc Dung",'2003-05-25',"v@gmail.com"),
(3,"Duong Duc Hoang",'2001-05-25',"q@gmail.com");

select *from Students2; 
select id_Stu , full_name from Students2;