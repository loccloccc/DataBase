USE social_network_pro;

-- Tạo một view với tên view_user_activity_status hiển thị các cột:  user_id , username, gender, created_at, status. 
create or replace view view_user_activity_status as 
select 
u.user_id  as "Ma nguoi dung", 
u.username as "Ten", 
u.gender as "gioi tinh" , 
u.created_at as "Thời gian tạo tài khoản" ,
case  when count(distinct p.user_id) >=1 or count(distinct c.user_id) >= 1 then "Active" else "Inactive" end as "Trang thai"
from users u
join posts p on p.user_id = u.user_id
join comments c on c.user_id = u.user_id
group by u.user_id , u.username , u.gender , u.created_at;

-- Truy vấn view view_user_activity_status 
select *from view_user_activity_status;

-- 
select status,
       count(*) as user_count
from view_user_activity_status
group by status
order by user_count desc;