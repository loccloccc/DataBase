use social_network_pro;

create view view_user_post as 
select u.user_id , count(p.user_id) as total_user_post
from posts p
join users u on u.user_id = p.user_id
where u.user_id = 1
group by u.user_id;

select *from view_user_post;

-- bai 2
EXPLAIN ANALYZE
select *from users;
create index  idx_hometown on users(hometown);
drop index idx_hometown on users;

-- bai 3
