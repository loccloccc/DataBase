create database session2_HW1;
use session2_HW1;
create table Class(
	id_Class int primary key auto_increment,
    name_Class char(10) not null unique,
    year_School int not null
);

create table Student(
	id_Stu int primary key not null auto_increment,
    id_Class int,
    name_Stu varchar(50) not null,
    birth_Day_Stu date,
    foreign key (id_Class) references Class(id_Class)
);



