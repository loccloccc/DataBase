create database bai3;
use bai3;

create table Subjects(
	id_Sub int primary key,
    sub_Name varchar(50) unique not null,
    credit int check (credit > 0)
);

insert into Subjects value
(1,'lap trinh c' , 4);

update Subjects 
set  credit = 5 
where id_Sub = 1;


update Subjects set sub_Name = "lap trinh web" where id_Sub = 1 ;
select *from Subjects;
-- drop database bai3;