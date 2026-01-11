USE social_network_pro; 

-- Tạo một index idx_user_gender trên cột gender của bảng users
create index  idx_user_gender on users(gender);

-- Tạo một view tên view_user_activity để hiển thị tổng số lượng bài viết và bình luận của mỗi người dùng. Các cột trong view bao gồm: user_id (Mã người dùng), total_posts (Tổng số bài viết), total_comments (Tổng số bình luận).

create or replace view view_user_activity as
select u.user_id as user_id, count(distinct p.post_id) as total_posts  ,count(distinct c.comment_id) as total_comments 
from users u
join posts p on p.user_id = u.user_id
join comments c on c.user_id = u.user_id
group by u.user_id;

-- Hiển thị lại view trên.
select *from view_user_activity;

-- Viết truy vấn kết hợp view_user_activity với bảng users để lấy thông tin người dùng:
select u.username as "Ten nguoi dung" , vua.total_posts as "tong bai viet" , vua.total_comments as "tong comments"
from view_user_activity vua
join users u on u.user_id = vua.user_id
having vua.total_posts > 5 or vua.total_comments > 20
order by total_comments desc
limit 5;