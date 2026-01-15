create database social_network;
use social_network;
create table users(
	user_id int auto_increment primary key,
    username varchar(50) not null, 
    posts_count int default 0
);
-- drop database social_network;
create table posts(
	post_id int primary key auto_increment,
    user_id int not null, 
    foreign key(user_id) references users(user_id),
    content text not null,
    created_at datetime default current_timestamp
);


insert into users values 
(1, "nguyen van a", 0),
(2, "nguyen van b", 0),
(3, "nguyen van c", 0); 


delimiter ..
create procedure getData(g_user_id int , g_content text)
begin
-- check loi
	declare exit handler for sqlexception
    begin
		signal sqlstate '45000' set message_text = "loi";
        rollback;
	end ;
	start transaction; 
	insert into posts(user_id , content) values(g_user_id,g_content);
    update users set posts_count = posts_count + 1 where user_id = g_user_id;
    commit;
end ..
delimiter ;

call getData(1,"aaaaa");
call getData(5,"bbbb");