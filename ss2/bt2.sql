create database bt2;
use bt2;
-- bt2 
create table Students(
	id_Stu int  auto_increment primary key,
    name_Stu varchar(50)
);

create table Subjects(
	id_Sub int auto_increment primary key,
    name_Sub varchar(50) ,
    credits int not null check (credits > 0)
);

-- bt3
create table Enrollment(
	id_Stu int not null,
    id_Sub int not null,
    enroll date, 
    primary key (id_Stu , id_Sub),
    foreign key (id_Stu) references Students(id_Stu),
    foreign key (id_Sub) references Subjects(id_Sub)
);


-- bt4
create table Teacher(
	id_Tea int auto_increment primary key,
    name_Tea varchar(50),
    email varchar(50)
);

alter table Subjects add id_Tea int ;
alter table Subjects 
add constraint FK_Subjects_Teacher
foreign key (id_Tea)
references Teacher(id_Tea);
-- bt5 

create table Score(
    id_Stu int,
    id_Sub int,
    point_Process int check( point_Process >= 0 and point_Process <= 10),
    point_Final int check(point_Final >= 0 and point_Final <= 10),
    foreign key(id_Stu) references Students(id_Stu),
    foreign key(id_Sub) references Subjects(id_Sub),
    primary key (id_Stu,id_Sub)
);

-- bt6 



 