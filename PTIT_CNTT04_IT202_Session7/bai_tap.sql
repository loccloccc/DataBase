create database bai_tap;
use bai_tap;

create table Students(
	id_Stu int primary key,
    name_Stu varchar(255) not null,
    class varchar(255)
);

create table Subjects(
	id_Sub int primary key,
    name_Sub varchar(255) unique,
    credit int
);

create table Exam(
	exam_id int primary key,
    id_Stu int,
    id_Sub int,
    mark decimal(2,2) ,
    exam_date date,
    foreign key(id_Stu) references  Students(id_Stu),
    foreign key(id_Sub) references Subjects(Subjects)
);

-- theem du lieu
insert into Students (id_Stu, name_Stu, class) values
(1, 'Nguyen Van A', '10A1'),
(2, 'Tran Thi B', '10A2'),
(3, 'Le Van C', '11B1'),
(4, 'Pham Thi D', '11B2'),
(5, 'Hoang Van E', '12C1');

insert into Subjects (id_Sub, name_Sub, credit) values
(101, 'Toan', 3),
(102, 'Ly', 3),
(103, 'Hoa', 3),
(104, 'Van', 2),
(105, 'Anh', 2);

insert into Exam (exam_id, id_Stu, id_Sub, mark, exam_date) values
(1001, 1, 101, 8.50, '2025-05-20'),
(1002, 1, 102, 7.75, '2025-05-22'),
(1003, 2, 103, 9.00, '2025-05-21'),
(1004, 3, 104, 6.50, '2025-05-23'),
(1005, 4, 105, 8.00, '2025-05-24'),
(1006, 5, 101, 9.25, '2025-05-25'),
(1007, 5, 102, 7.00, '2025-05-26');

-- Liệt kê sinh viên có điểm cao hơn điểm trung bình môn SQL

