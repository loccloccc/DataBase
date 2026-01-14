	create database trigger_db;
	use trigger_db;

	create table product(
		pro_id int auto_increment primary key,
		pro_name varchar(255),
		producer varchar(255),
		price numeric(15,2) check (price >= 0)
	);

	create table pro_stock(
		stock_id int auto_increment primary key,
		pro_id int references product(pro_id),
		quantity int check(quantity >= 0) default 0
	);

	create table pro_export(
		export int auto_increment primary key ,
		pro_id int references product(pro_id),
		quantity int check(quantity > 0)
	);

	-- cai dat trigger de so luong xuat kho phai nho hon so luong ton kho

	delimiter //
	create trigger tg_quantity_export 
	before insert on pro_export 
	for each row
	begin
		if New.quantity > (select quantity from pro_stock where pro_id = New.pro_id) then 
			signal sqlstate '45000' set message_text = "so luong xuat kho khong duoc vuot kho so luong ton kho";
		end if;
	end //
	delimiter ;

	-- insert

	insert into product(pro_name,producer,price) values 
	("a1","dell",100000),
	("a2","dell",100000),
	("a3","dell",100000);

	insert into pro_stock(pro_id,quantity) values
	(1,10) , (2,5) , (3,11);

	insert into pro_export(pro_id,quantity) values
	(1,20)