create database mini_Prj;
use mini_Prj;


-- sinh vien
create table Student(
	id_stu int primary key,
    full_name varchar(50),
    date_of_birth date,
    email varchar(50) unique
);
-- khoa hoc
create table Coures(
	id_coures int primary key,
    name_coures varchar(100),
    describe_coures varchar(100),
    lession int not null check(lession > 0 )
);
-- giang vien
create table Teacher(
	id_tea int primary key,
    full_name varchar(50),
    email varchar(50) unique,
    id_coures int ,
    foreign key(id_coures) references Coures(id_coures)
);
-- dang ki mon
create table Enrollment(
	id_stu int,
    id_coures int,
    primary key(id_stu ,id_coures ),
    foreign key(id_stu) references Student(id_stu),
    foreign key(id_coures) references Coures(id_coures),
    date_enrollment date
);
-- ket qua hoc tap 
create table Score(
	midterm_score int check(midterm_score >= 0 and midterm_score <= 10),
    last_score int check(last_score >= 0 and last_score <= 10),
    id_stu int ,
    id_coures int,
    primary key(id_stu,id_coures),
    foreign key(id_stu) references Student(id_stu),
    foreign key(id_coures) references Coures(id_coures)
);
-- nhập dữ liệu ban đầu

-- sinh viên 
insert into Student values 
(1,"duong duc loc",'2000-04-04',"loc@gmail.com"),
(2,"duong duc hai",'2000-05-04',"hai@gmail.com"),
(3,"duong duc ba",'2000-04-03',"ba@gmail.com"),
(4,"duong duc tu",'2000-09-04',"tu@gmail.com"),
(5,"duong duc dung",'2000-04-01',"dung@gmail.com");

-- khoa hoc
insert into Coures values
(1,"lap trinh c","lam quen voi it",10),
(2,"DSA","giai thuat voi c++",12),
(3,"lap trinh Web voi ReactJs","lap trinh web nang cao",13),
(4,"AI co ban","lam quen voi AI co ban",14),
(5,"lap trinh mang","lam quen voi mang may tinh",15);

-- giang vien
insert into Teacher values
(1,"Nguyen Van A" , "a@gmail.com",1),
(2,"Nguyen Van B" , "b@gmail.com",2),
(3,"Nguyen Van C" , "c@gmail.com",3),
(4,"Nguyen Van D" , "d@gmail.com",2),
(5,"Nguyen Van F" , "f@gmail.com",1);

-- dang ki hoc cho sinh vien
insert into Enrollment values
(1,1,'2020-02-02'),
(1,2,'2020-05-02'),
(2,2,'2020-05-02'),
(2,4,'2020-02-02'),
(5,1,'2020-08-02');

-- ket qua hoc tap
insert into Score values
(8,8,1,2) , (8,9,1,1) , (5,6,1,5) , (7,8,3,4) , (10,10,2,4); 

-- cap nhat

-- sinh vien
update Student 
set email = "update@gmail.com"
where id_stu = 1;


-- mo ta khoa hoc
update Coures 
set describe_coures = "update noi dung khoa hoc"
where id_coures = 1;

-- diem cuoi ki cho 1 sinh vien
update Score 
set last_score = 10
where id_stu = 1 and id_coures = 1;

-- xoa du lieu 
delete from Enrollment
where id_stu = 2 and id_coures = 4;

delete from Score
where id_stu = 2 and id_coures = 4;

-- lay du lieu
SELECT * FROM Student;
SELECT * FROM Teacher;
SELECT * FROM Coures;
SELECT * FROM Enrollment;
SELECT * FROM Score;

