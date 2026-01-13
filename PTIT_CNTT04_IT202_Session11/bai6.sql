use social_network_pro;

delimiter //
create procedure NotifyFriendsOnNewPost(p_user_id  int , p_content varchar(255))
begin
	declare full_name_post varchar(255);
	if char_length(p_content) > 0 then
    insert into posts(user_id,content) values (p_user_id , p_content) ;
    -- Lấy full_name của người đăng
    select  full_name into full_name_post from users where users.user_id = p_user_id;
    
    
    end if;
end //

delimiter ;