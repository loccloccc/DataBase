use social_network_pro;

DELIMITER $$
create procedure getData(in p_user_id int)
begin 
	select p.post_id , p.content , p.created_at from users u
    join posts p on p.user_id = u.user_id;
end $$
DELIMITER ;

call getData(1);

drop procedure if exists getData;