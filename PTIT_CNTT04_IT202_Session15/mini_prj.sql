/*
 * DATABASE SETUP - SESSION 15 EXAM
 * Database: StudentManagement
 */

DROP DATABASE IF EXISTS StudentManagement;
CREATE DATABASE StudentManagement;
USE StudentManagement;

-- =============================================
-- 1. TABLE STRUCTURE
-- =============================================

-- Table: Students
CREATE TABLE Students (
    StudentID CHAR(5) PRIMARY KEY,
    FullName VARCHAR(50) NOT NULL,
    TotalDebt DECIMAL(10,2) DEFAULT 0
);

-- Table: Subjects
CREATE TABLE Subjects (
    SubjectID CHAR(5) PRIMARY KEY,
    SubjectName VARCHAR(50) NOT NULL,
    Credits INT CHECK (Credits > 0)
);

-- Table: Grades
CREATE TABLE Grades (
    StudentID CHAR(5),
    SubjectID CHAR(5),
    Score DECIMAL(4,2) CHECK (Score BETWEEN 0 AND 10),
    PRIMARY KEY (StudentID, SubjectID),
    CONSTRAINT FK_Grades_Students FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
    CONSTRAINT FK_Grades_Subjects FOREIGN KEY (SubjectID) REFERENCES Subjects(SubjectID)
);

-- Table: GradeLog
CREATE TABLE GradeLog (
    LogID INT PRIMARY KEY AUTO_INCREMENT,
    StudentID CHAR(5),
    OldScore DECIMAL(4,2),
    NewScore DECIMAL(4,2),
    ChangeDate DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- =============================================
-- 2. SEED DATA
-- =============================================

-- Insert Students
INSERT INTO Students (StudentID, FullName, TotalDebt) VALUES 
('SV01', 'Ho Khanh Linh', 5000000),
('SV03', 'Tran Thi Khanh Huyen', 0);

-- Insert Subjects
INSERT INTO Subjects (SubjectID, SubjectName, Credits) VALUES 
('SB01', 'Co so du lieu', 3),
('SB02', 'Lap trinh Java', 4),
('SB03', 'Lap trinh C', 3);

-- Insert Grades
INSERT INTO Grades (StudentID, SubjectID, Score) VALUES 
('SV01', 'SB01', 8.5), -- Passed
('SV03', 'SB02', 3.0); -- Failed

-- End of File

-- Câu 1 (Trigger - 2đ): Nhà trường yêu cầu điểm số (Score) nhập vào hệ thống phải luôn hợp
-- lệ (từ 0 đến 10). Hãy viết một Trigger có tên tg_CheckScore chạy trước khi thêm
-- (BEFORE INSERT) dữ liệu vào bảng Grades.
-- ● Nếu người dùng nhập Score < 0 thì tự động gán về 0.
-- ● Nếu người dùng nhập Score > 10 thì tự động gán về 10.

delimiter //
create trigger tg_CheckScore 
before insert on Grades
for each row
begin 
	if new.Score < 0 then
		set new.Score = 0;
	elseif new.Score > 10 then set new.Score = 10;
    end if;
end //
delimiter ;

-- Câu 2 (Transaction - 2đ): Viết một đoạn script sử dụng Transaction để thêm một sinh viên
-- mới. Yêu cầu đảm bảo tính trọn vẹn "All or Nothing" của dữ liệu:
-- 1. Bắt đầu Transaction.
-- 2. Thêm sinh viên mới vào bảng Students: StudentID = 'SV02', FullName = 'Ha Bich
-- Ngoc'.
-- 3. Cập nhật nợ học phí (TotalDebt) cho sinh viên này là 5,000,000.
-- 4. Xác nhận (COMMIT) Transaction

start transaction ;
insert into Students(StudentID,FullName) values ('SV02','Ha Bich Ngoc');
update Students set TotalDebt = 5000000;
commit;

-- Câu 3 (Trigger - 1.5đ): Để chống tiêu cực trong thi cử, mọi hành động sửa đổi điểm số cần
-- được ghi lại. Hãy viết Trigger tên tg_LogGradeUpdate chạy sau khi cập nhật (AFTER
-- UPDATE) trên bảng Grades.
-- ● Yêu cầu: Khi điểm số thay đổi, hãy tự động chèn một dòng vào bảng GradeLog với
-- các thông tin: StudentID, OldScore (lấy từ OLD), NewScore (lấy từ NEW), và
-- ChangeDate là thời gian hiện tại (NOW()).

delimiter ..
create trigger tg_LogGradeUpdat
after update on Grades
for each row
begin 
	if old.Score <> new.Score then 
		insert into GradeLog(StudentID,oldScore,NewScore,ChangeDate) values (old.StudentID , old.Score , new.Score , now());
	end if;
end ..
delimiter ;

-- Câu 4 (Transaction & Procedure cơ bản - 1.5đ): Viết một Stored Procedure đơn
-- giản tên sp_PayTuition thực hiện việc đóng học phí cho sinh viên 'SV01' với số tiền
-- 2,000,000.
-- ● Bắt đầu Transaction.
-- ● Trừ 2,000,000 trong cột TotalDebt của bảng Students (StudentID = 'SV01').
-- ● Kiểm tra logic: Nếu sau khi trừ, TotalDebt < 0, hãy ROLLBACK để hủy bỏ.
-- Ngược lại, hãy COMMIT.

delimiter ..
create procedure sp_PayTuition(sp_StudentID char(5), sp_TotalDebt decimal(10,2))
begin
start transaction ;
update Students set TotalDebt = TotalDebt - sp_TotalDebt where StudentID  = sp_StudentID ;
if (select TotalDebt from Students where StudentID  = sp_StudentID) < 0 then rollback;
else commit;
end if;
end ..
delimiter ;
call sp_PayTuition('SV01',2000000);

-- Câu 5 (Trigger nâng cao - 1.5đ): Viết Trigger tên tg_PreventPassUpdate.
-- ● Quy tắc nghiệp vụ: Sinh viên đã qua môn (Điểm cũ >= 4.0) thì không được phép sửa
-- điểm nữa để đảm bảo tính minh bạch.
-- ● Yêu cầu: Viết trigger BEFORE UPDATE trên bảng Grades. Nếu OldScore
-- (OLD.Score) >= 4.0, hãy hủy thao tác cập nhật bằng cách phát sinh lỗi (Sử dụng
-- SIGNAL SQLSTATE với thông báo lỗi tùy ý).

delimiter ..
create trigger tg_PreventPassUpdate 
before update on Grades
for each row
begin
if old.Score >= 4.0 then signal  sqlstate '45000' set message_text = "loi";
end if;
end ..
delimiter ;