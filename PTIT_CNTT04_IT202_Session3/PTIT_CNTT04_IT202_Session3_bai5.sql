CREATE DATABASE bai5;
USE bai5;

CREATE TABLE Students3(
	id_Stu INT PRIMARY KEY ,
    full_name VARCHAR(50) NOT NULL,
    date_of_birth DATE ,
    email VARCHAR(50) UNIQUE
);

CREATE TABLE Subjects(
	id_Sub INT PRIMARY KEY,
    sub_Name VARCHAR(50) UNIQUE NOT NULL,
    credit INT CHECK (credit > 0)
);

CREATE TABLE Enrollment(
	Student_id INT NOT NULL,
    Subject_id INT NOT NULL,
    Enroll_date DATE NOT NULL,
    PRIMARY KEY(Student_id , Subject_id),
    FOREIGN KEY(Student_id) REFERENCES Students3(id_Stu),
    FOREIGN KEY(Subject_id) REFERENCES Subjects(id_Sub)
);

CREATE TABLE Score(
	student_id INT NOT NULL,
	subject_id INT NOT NULL,
	mid_score  INT CHECK(mid_score >=0 AND mid_score<=10),
	final_score INT CHECK(final_score>=0 AND final_score<=10),
	PRIMARY KEY (student_id,subject_id),
	FOREIGN KEY (student_id) REFERENCES Students3(id_Stu),
	FOREIGN KEY (subject_id) REFERENCES Subjects(id_Sub)
);


INSERT INTO Students3 VALUES 
(1,'Duong Duc Loc','2006-05-25','a@gmail.com'),
(5,'Duong Duc Hoang','2001-05-25','f@gmail.com');


INSERT INTO Subjects VALUES
(1,'lap trinh web',3),
(2,'lap trinh c',4);


INSERT INTO Score VALUES
(1,1,9,9),
(1,2,5,5),
(5,2,8,7);


UPDATE Score
SET final_score = 8
WHERE student_id = 5 AND subject_id = 2;


SELECT * FROM Score;
SELECT * FROM Score WHERE final_score >= 8;
