use bai1;

create table friendships (
    follower_id int,
    followee_id int,
    status enum('pending','accepted') default 'accepted',
    primary key (follower_id, followee_id),
    foreign key (follower_id) references users(user_id) on delete cascade,
    foreign key (followee_id) references users(user_id) on delete cascade
);



-- Tạo trigger AFTER INSERT/DELETE trên friendships để cập nhật follower_count của followee.
delimiter $$
create trigger after_friendship_insert
after insert on friendships
for each row
begin
     if new.status = 'accepted' then
         update users
        set follower_count = follower_count + 1
        where user_id = new.followee_id;
    end if;
end $$
delimiter ;

delimiter $$
create trigger after_friendship_delete
after delete on friendships
for each row
begin
    if old.status = 'accepted' then
        update users
        set follower_count = follower_count - 1
        where user_id = old.followee_id;
    END IF;
END$$
delimiter ;


-- Tạo Procedure follow_user(follower_id, followee_id, status) xử lý logic (tránh tự follow, tránh trùng).

delimiter $$
create procedure follow_user(
    in p_follower_id int,
    in p_followee_id int,
    in p_status enum('pending','accepted')
)
begin
    -- Không cho phép tự follow
    if p_follower_id = p_followee_id then
        signal sqlstate '45000'
        set message_text = 'k follow được';
    end if;

    -- Kiểm tra trùng
    if exists (select 1 from friendships 
               where follower_id = p_follower_id 
                 and followee_id = p_followee_id) then
        signal sqlstate'45000'
        set message_text = 'đã tồn tại';
    end if;

    -- Thêm quan hệ follow
    insert into friendships (follower_id, followee_id, status)
    values (p_follower_id, p_followee_id, p_status);
end $$
delimiter ;


-- Tạo View user_profile chi tiết.
create or replace view user_profile as
select u.user_id,u.username,u.follower_count,u.post_count,count(l.like_id) as total_likes
from users u
left join posts p on u.user_id = p.user_id
left join likes l on p.post_id = l.post_id
group by u.user_id, u.username, u.follower_count, u.post_count;

select post_id, content, created_at
from posts
where user_id = 2
order by created_at desc
limit 3;

-- Thực hiện một số follow/unfollow và kiểm chứng follower_count, View.
call follow_user(2, 1, 'accepted');
delete from friendships where follower_id = 2 and followee_id = 1;

select * from users;
select * from user_profile;