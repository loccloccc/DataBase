use bai1;

delimiter //
create procedure add_user(
	in p_username varchar(50),
	in p_email varchar(100),
	in p_created_at datetime
)
begin
	insert into users(username, email, create_at)
	values (p_username, p_email, p_created_at);
end //
delimiter ;

delimiter //
create trigger be_users_validate
before insert on users
for each row
begin
	if new.email not like '%@%.%' then
		signal sqlstate '45000'
		set message_text = 'email khong hop le';
	end if;
	if new.username not regexp '^[a-zA-Z0-9_]+$' then
		signal sqlstate '45000'
		set message_text = 'username chi duoc chua chu, so va dau gach duoi';
	end if;
end //
delimiter ;

call add_user(
	'nguyen_van_a',
	'nguyenvana@gmail.com',
	now()
);

call add_user(
	'user1',
	'nguyenvanagmail.com',
	now()
);


call add_user(
	'user@123',
	'user123@gmail.com',
	now()
);

SELECT * FROM users

