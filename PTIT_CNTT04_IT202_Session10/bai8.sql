USE social_network_pro; 

-- Tạo một index idx_user_gender trên cột gender của bảng users
create index  idx_user_gender on users(gender);


-- Tạo một View tên view_popular_posts để lưu trữ post_id, username người đăng,content(Nội dung bài viết), số like, số comment (sử dụng JOIN giữa posts, users, likes, comments; GROUP BY post_id).
create or replace view view_popular_posts as 
select p.post_id , u.username , p.content , count(p.post_id) as  total_like ,count(p.post_id) as total_comment
from posts p 
join users u on u.user_id = p.user_id
join likes l on l.post_id = p.post_id
join comments c on c.post_id = p.post_id
group by p.post_id, u.username,p.content ;


-- Truy vấn các thông tin của view view_popular_posts
select *from view_popular_posts;

-- viết query sử dụng View này để liệt kê các bài viết có số like + comment > 10, ORDER BY tổng tương tác giảm dần.
create or replace view view_popular_posts as 
select p.post_id , u.username , p.content , count(p.post_id) as  total_like ,count(p.post_id) as total_comment , (count(p.post_id) + count(p.post_id)) as total
from posts p 
join users u on u.user_id = p.user_id
join likes l on l.post_id = p.post_id
join comments c on c.post_id = p.post_id
group by  p.post_id, u.username,p.content
having count(p.post_id) + count(p.post_id) > 10
order by total desc;
 
select *from view_popular_posts;