use social_network_pro;

delimiter //
create procedure CalculateBonusPoints(p_user_id int , inout p_bonus_points int)
begin
	declare total int;
    set total = (select count(post_id) from posts where posts.user_id = p_user_id);
    if total >= 10 then set p_bonus_points = p_bonus_points + 50;
    elseif total >= 20 then set p_bonus_points = p_bonus_points + 100;
    end if;
end //
delimiter ;

set @ketQua = 100;
call CalculateBonusPoints(1,@ketQua);

Select @ketQua ;

drop procedure if exists CalculateBonusPoints;