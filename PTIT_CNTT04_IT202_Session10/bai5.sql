
USE social_network_pro;

-- Tạo chỉ mục có tên idx_hometown trên cột hometown của bảng users
create index idx_hometown on users(hometown);

-- truy vấn
select u.username , p.post_id , p.content 
from users u
join posts p on   p.user_id = u.user_id
where u.hometown = "Hà Nội"
order by u.username desc
limit 10;

-- Sử dụng EXPLAIN ANALYZE để kiểm tra lại kế hoạch thực thi trước và sau khi có chỉ mục.
EXPLAIN ANALYZE
select u.username , p.post_id , p.content 
from users u
join posts p on   p.user_id = u.user_id
where u.hometown = "Hà Nội"
order by u.username desc
limit 10;