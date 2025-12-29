create database bai4;
use bai4;
create table Students3(
	id_Stu int primary key ,
    full_name varchar(50) not null,
    date_of_birth date ,
    email varchar(50) unique
);

create table Subjects(
	id_Sub int primary key,
    sub_Name varchar(50) unique not null,
    credit int check (credit > 0)
);

create table Enrollment(
	Student_id int  not null,
    Subject_id int not null,
    Enroll_date date not null,
    primary key(Student_id , Subject_id),
    foreign key(Student_id) references Students3(id_Stu),
    foreign key(Subject_id) references Subjects(id_Sub)
);
-- sinh vien
insert into Students3 values 
(1,"Duong Duc Loc",'2006-05-25',"a@gmail.com"),
(5,"Duong Duc Hoang",'2001-05-25',"f@gmail.com");

-- mon hoc
insert into Subjects value
(1,"lap trinh web" , 3),
(2,'lap trinh c' , 4);

-- dang ki mon
insert into Enrollment values 
(1,2,'2025-05-06'),
(5,1,'2025-06-06');

select *from Enrollment;
select *from Enrollment where Student_id = 1;

