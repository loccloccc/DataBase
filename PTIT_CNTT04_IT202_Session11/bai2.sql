use social_network_pro;

delimiter //
create procedure getData(p_post_id int , out total_likes int)
begin
	set total_likes = ( select count(post_id)
    from likes
    where post_id = p_post_id);
end //
delimiter ;

call getData(101,@ketQua);

select @ketQua;

drop procedure if exists getData;