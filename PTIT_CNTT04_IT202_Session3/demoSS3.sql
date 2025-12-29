create database bttl;

use bttl;

create table Students(
	id_Stu int primary key,
    full_name varchar(50) not null,
    date_of_birth date not null,
    email varchar(50) unique
);

create table Subjects(
	id_Sub int primary key,
    name_Sub varchar(50) not null unique
);

create table Enrollment(
	id_Stu int,
    id_Sub int,
    primary key(id_Stu , id_Sub),
    foreign key(id_Stu) references Students(id_Stu),
    foreign key(id_Sub) references Subjects(id_Sub),
    start_day date not null
);

create table Score(
	id_Stu int,
    id_Sub int,
    number_of_exams int ,
    score_exams int,
    primary key(id_Stu , id_Sub , number_of_exams),
    foreign key(id_Stu) references Students(id_Stu),
    foreign key(id_Sub) references Subjects(id_Sub)
);


-- thêm sinh viên 
insert into Students values
(1,"loc",'2000-05-02',"a@gmail.com"),
(2,"dung",'2000-05-02',"b@gmail.com"),
(3,"hoang",'2000-05-02',"c@gmail.com");

-- theem mon hoc
insert into Subjects values 
(1,"toan"),
(2,"van"),
(3,"anh");

-- them dang ki mon
insert into Enrollment values 
(1,1,'2025-11-20');

-- them diem 
insert into Score values
(2,1,2,4),
(2,2,1,4),
(3,1,2,4),
(1,1,4,4);

-- xoa sinh vien id 2
delete from Score where id_Stu = 2;


delete from Students where id_Stu = 2;

-- lay toan bo sinh vien 
select *from Students;
select *from Score;
select *from Enrollment;
select *from Subjects;

-- drop database bttl;
