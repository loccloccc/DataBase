-- drop database bai1;
use bai1;

create table likes(
	like_id int primary key auto_increment,
    user_id int references users(user_id) on delete cascade,
    post_id int references posts(post_id) on delete cascade,
    liked_at datetime default current_timestamp()
);



-- ạo trigger AFTER INSERT và AFTER DELETE trên likes để tự động cập nhật like_count trong bảng posts.
delimiter //
create trigger ad_tg_like_count 
after insert on likes
for each row
begin
	update posts set like_count = like_count + 1 where new.post_id = post_id;
end //
delimiter ;

delimiter //
create trigger dl_tg_like_count 
after delete on likes
for each row
begin
		update posts set like_count = like_count - 1 where post_id = old.post_id;

end //
delimiter ;
INSERT INTO likes (user_id, post_id, liked_at) VALUES
(2, 1, '2025-01-10 11:00:00'),
(3, 1, '2025-01-10 13:00:00'),
(1, 3, '2025-01-11 10:00:00'),
(3, 4, '2025-01-12 16:00:00');
-- Tạo một View tên user_statistics hiển thị: user_id, username, post_count, total_likes (tổng like_count của tất cả bài đăng của người dùng đó).
create view user_statistics as
select u.user_id, 
	u.username, 
    u.post_count, 
    sum(p.like_count)  as total_likes 
from users u
join posts p on p.user_id = u.user_id 
group by u.user_id , u.username, u.post_count ;


select *from posts;
INSERT INTO likes (user_id, post_id, liked_at) VALUES (2, 4, NOW());

SELECT * FROM posts WHERE post_id = 4;

SELECT * FROM user_statistics;

-- Xóa một lượt thích và kiểm chứng lại View.
delete from likes where like_id = 2;
SELECT * FROM user_statistics;