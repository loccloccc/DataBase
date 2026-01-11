USE social_network_mini;

select *from users;
select *from posts;

-- Tạo một view tên view_user_post hiển thị danh sách các User với các cột: user_id(mã người dùng) và total_user_post (Tổng số bài viết mà từng người dùng đã đăng).
create or replace view view_user_post  as 
select  u.user_id as "mã người dùng" , count(p.user_id) as "total_user_post" 
from users u
join posts p on u.user_id = p.user_id
group by p.user_id; 

-- Tiến hành hiển thị lại view_user_post để kiểm chứng
select *from view_user_post;

-- Kết hợp view view_user_post với bảng users để hiển thị các cột: full_name(họ tên) và  total_user_post (Tổng số bài viết mà từng người dùng đã đăng)
select  u.full_name as "Ho va ten" , count(p.user_id) as "Tong so bai viet" 
from users u
join posts p on u.user_id = p.user_id
group by p.user_id; 