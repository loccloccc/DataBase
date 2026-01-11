USE social_network_pro;

-- Tạo một view tên view_users_summary để thống kê số lượng bài viết của từng người dùng.
create or replace view view_users_summary as 
select u.user_id as "Mã người dùng" , u.username as "Tên người dùng" , count(p.post_id) as "Tổng số lượng"
from users u 
left join posts p on p.user_id = u.user_id
group by u.user_id , u.username;

select *from view_users_summary;


-- Truy vấn từ view_users_summary để hiển thị các thông tin về user_id, username và total_posts của các người dùng có total_posts lớn hơn 5.
create or replace view view_users_summary as 
select u.user_id as "Mã người dùng" , u.username as "Tên người dùng" , count(p.post_id) as "Tổng số lượng"
from users u 
left join posts p on p.user_id = u.user_id
group by u.user_id , u.username
having count(p.post_id) > 5;

select *from view_users_summary;