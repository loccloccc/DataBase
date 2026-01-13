CREATE DATABASE social_network;
USE social_network;

CREATE TABLE Users (
    user_id INT PRIMARY KEY ,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Posts (
    post_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    content TEXT NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

CREATE TABLE Comments (
    comment_id INT PRIMARY KEY AUTO_INCREMENT,
    post_id INT,
    user_id INT,
    content TEXT NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (post_id) REFERENCES Posts(post_id),
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

CREATE TABLE Friends (
    user_id INT,
    friend_id INT,
    status VARCHAR(20) CHECK (status IN ('pending','accepted')),
    PRIMARY KEY (user_id, friend_id),
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (friend_id) REFERENCES Users(user_id)
);

CREATE TABLE Likes (
    user_id INT,
    post_id INT,
    PRIMARY KEY (user_id, post_id),
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (post_id) REFERENCES Posts(post_id)
);

-- bai 1 
-- Thêm người dùng mới
INSERT INTO Users (user_id ,username, password, email) VALUES
(1,'loc', '123456', 'loc@gmail.com'),
(2,'an', '123456', 'an@gmail.com'),
(3,'binh', '123456', 'binh@gmail.com'),
(4,'bao', '123456', 'bao@gmail.com'),
(5,'hoa', '123456', 'hoa@gmail.com');
-- Hiển thị danh sách người dùng.
select *from Users;

-- bai 2
-- SELECT từ View
create or replace view vw_public_users as 
select user_id, username, created_at from Users;

select *from vw_public_users;

-- So sánh với SELECT trực tiếp từ bảng Users : 2 bang giong nhau


-- bai 3 
-- Tối ưu tìm kiếm người dùng bằng INDEX
-- Chức năng mô phỏng: Tìm kiếm bạn bè
-- Yêu cầu
-- Tạo Index cho:
-- username trong bảng Users.
-- Viết truy vấn:
-- Tìm user theo username.
-- So sánh:
-- Truy vấn có Index
-- Truy vấn không Index (mô tả lý thuyết).
-- => Sau mức Trung bình, sinh viên đã xây dựng được:
-- Chức năng đăng ký – xem hồ sơ – tìm kiếm người dùng

create index id_username on Users(username);
select *from Users where username = "loc";
explain analyze
select *from Users where username = "loc";


