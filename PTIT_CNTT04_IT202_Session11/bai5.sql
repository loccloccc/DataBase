use social_network_pro;

delimiter //
create procedure CalculateUserActivityScore(p_user_id int , out activity_score int , out activity_level varchar(50))
begin
	declare total_posts int default 0;
    declare total_comments int default 0;
    declare total_likes int default 0;
    
    set total_posts = (select count(*) from posts p where p.user_id = p_user_id);
    set total_comments = (select count(*) from  comments c where c.user_id = p_user_id);
    set total_likes = (select count(*) from likes l where l.user_id = p_user_id);
    
    set activity_score = total_posts + total_comments + total_likes;
    if activity_score > 500 then set activity_level = "Rất tích cực";
    elseif activity_score > 200 and activity_score <= 500 then set activity_level = "Tích cực" ;
    else set activity_level = "Bình thường";
    end if;
end //
delimiter ;

call CalculateUserActivityScore(1,@ketQua ,@ketQua2);
select @ketQua,@ketQua2;
drop procedure if exists CalculateUserActivityScore;