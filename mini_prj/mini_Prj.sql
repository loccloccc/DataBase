create database mini_Prj;
use mini_Prj;



create table Student(
	id_stu int primary key,
    full_name varchar(50) not null,
    date_of_birth date,
    email varchar(50) unique not null
);

create table Coures(
	id_coures int primary key,
    name_coures varchar(100) not null,
    describe_coures varchar(100),
    lession int not null check(lession > 0 )
);

create table Teacher(
	id_tea int primary key,
    full_name varchar(50) not null ,
    email varchar(50) unique not null,
    id_coures int ,
    foreign key(id_coures) references Coures(id_coures)
);

create table Enrollment(
	id_stu int,
    id_coures int,
    primary key(id_stu ,id_coures ),
    foreign key(id_stu) references Student(id_stu),
    foreign key(id_coures) references Coures(id_coures),
    date_enrollment date not null 
);

create table Score(
	midterm_score int check(midterm_score >= 0 and midterm_score <= 10),
    last_score int check(last_score >= 0 and last_score <= 10),
    id_stu int,
    id_coures int,
    primary key(id_stu,id_coures),
    foreign key(id_stu) references Student(id_stu),
    foreign key(id_coures) references Coures(id_coures)
);

insert into Student values 
(1,"duong duc loc",'2000-04-04',"loc@gmail.com"),
(2,"duong duc hai",'2000-05-04',"hai@gmail.com"),
(3,"duong duc ba",'2000-04-03',"ba@gmail.com"),
(4,"duong duc tu",'2000-09-04',"tu@gmail.com"),
(5,"duong duc dung",'2000-04-01',"dung@gmail.com");


insert into Coures values
(1,"lap trinh c","lam quen voi it",10),
(2,"DSA","giai thuat voi c++",12),
(3,"lap trinh Web voi ReactJs","lap trinh web nang cao",13),
(4,"AI co ban","lam quen voi AI co ban",14),
(5,"lap trinh mang","lam quen voi mang may tinh",15);


insert into Teacher values
(1,"Nguyen Van A" , "a@gmail.com",1),
(2,"Nguyen Van B" , "b@gmail.com",2),
(3,"Nguyen Van C" , "c@gmail.com",3),
(4,"Nguyen Van D" , "d@gmail.com",2),
(5,"Nguyen Van F" , "f@gmail.com",1);


insert into Enrollment values
(1,1,'2020-02-02'),
(1,2,'2020-05-02'),
(2,2,'2020-05-02'),
(2,4,'2020-02-02'),
(5,1,'2020-08-02');

insert into Score values
(8,8,1,2) , (8,9,1,1) , (5,6,1,5) , (7,8,3,4) , (10,10,2,4); 


update Student 
set email = "update@gmail.com"
where id_stu = 1;


update Coures 
set describe_coures = "update noi dung khoa hoc"
where id_coures = 1;


update Score 
set last_score = 10
where id_stu = 1 and id_coures = 1;


delete from Enrollment
where id_stu = 2 and id_coures = 4;

delete from Score
where id_stu = 2 and id_coures = 4;


SELECT * FROM Student;
SELECT * FROM Teacher;
SELECT * FROM Coures;
SELECT * FROM Enrollment;
SELECT * FROM Score;

