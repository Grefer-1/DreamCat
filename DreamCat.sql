Create database DreamCat
go

use DreamCat
go


create table Customer (
  id varchar(80) primary key,
  username varchar(32),
  password varchar(32),
  name  varchar(80),
  phone varchar(15),
  address varchar(80)
);

alter table Customer
add Role varchar(20);

drop table Customer

select * from Customer

create table Product (
  id integer identity primary key,
  name varchar(80),
  image_file_name varchar(30) not null, 
  price int not null,
  stock integer,
  descrip varchar(MAX),
);

select * from Product

update Product set stock = 999 where id = 1
delete from Product

drop table Product

insert into Product values ('KeyChain Gokemon', './Files/Shop/1.png', '20', '999', 'Plastic key chain 4x5cm')
insert into Product values ('T-Shirt Female', './Files/Shop/2.png', '120', '999', 'Female T-Shirt freesize')
insert into Product values ('Hoodies Unisex', './Files/Shop/3.png', '250', '999', 'Hoodies Unisex freesize')
insert into Product values ('T-Shirt Male', './Files/Shop/4.png', '100', '999', 'T-Shirt Male freesize')
insert into Product values ('KeyChain Ib', './Files/Shop/5.png', '30', '999', 'Random KeyChain with Ib charater')
insert into Product values ('Wada Past', './Files/Shop/6.png', '60', '999', 'Poster Wada Past 30x45cm')
insert into Product values ('Wada Future', './Files/Shop/7.png', '80', '999', 'Poster Wada Future 30x45cm')
insert into Product values ('Sticker RPG Maker', './Files/Shop/8.png', '10', '999', 'Sticker RPG Maker 30x45cm')
insert into Product values ('Star the Cat', './Files/Shop/9.png', '40', '999', 'Star the Cat medium size')
insert into Product values ('Wada Now', './Files/Shop/10.png', '70', '999', 'Poster Wada Now 30x45cm')

select * from Product

select stock from Product where id = 1

create table Orders (
  id integer identity primary key,
  cust varchar(80) references customer(id) on delete set null,
  odate date
);

alter table Orders
add statuss bit default '0'

update Orders set statuss = '0' where id = 3 and cust = 1

select o.id, o.cust, i.prod, i.qty, o.odate, o.statuss from Orders o inner join Item i on o.id = i.ordr

select * from Orders
select id, cust, odate, statuss from Orders
select * from Item

select MAX(id) as 'orderNo' from Orders where cust = '3'
insert into Orders values ('4', '2021-11-08', '')
insert into Item values (1, '3', 1)
update Item set qty = '2' where ordr = 1 and prod = 3
select ordr as 'orderNo' from Item where ordr = '2'
update Orders set odate = '' where id = 2 and cust = 3
delete Item where ordr = 1 and prod = 5
select qty from Item where prod = 1 and ordr = 10
update Item set qty = +1 where prod = 1 and ordr = 10
delete from Item where prod = 1 and ordr = 10

select p.id, p.name, p.image_file_name, p.price, p.stock, i.qty from Product p join Item i on p.id = i.prod where i.ordr = 1

select p.id, p.name, p.image_file_name, p.price, p.stock, i.qty from Product p join Item i on p.id = i.prod where i.ordr = 1

drop table Item
drop table Orders

create table Item (
  ordr integer references Orders(id) on delete set null,
  prod integer references Product(id) on delete set null,
  qty integer
);

delete Orders where cust = '2'
delete Item where prod = '3'

insert into Item values (1, '5', 2)

drop table Item

create table Team (
  id varchar(10) primary key,
  name varchar(20),
  image_file_name varchar(30) not null, 
  job varchar(20),
  dsc varchar(50)
)

insert into Team values('1', 'Larue', './Files/Team/1.png', 'Writer', '"GOD"')
insert into Team values('2', 'Grefer', './Files/Team/2.png', 'Developer', '...')
insert into Team values('3', 'FoodBoy', './Files/Team/3.png', 'Developer', '"..."')
insert into Team values('4', '...', './Files/Team/4.png', '...', '...')
insert into Team values('5', '...', './Files/Team/5.png', '...', '...')
insert into Team values('6', '...', './Files/Team/6.png', '...', '...')

select * from Team

drop table Team

create table game (
  id varchar(10) primary key,
  name varchar(50),
  image_file_name varchar(30) not null, 
  dsc varchar(1000)
)

drop table game

insert into game values('1', 'Alice To Underland', './Files/Game/1.png', '"Do you remember what is your precious thing ?"
The story of a girl who lost all her memory and stuck in a strang land called Underland. In here, she meet new friends and know the srecet of this world. What is she forgetting ? What is her precious thing ? Lets fing out in "Alice in Underland"')
insert into game values('2', 'The Notebook', './Files/Game/2.png', '"You... you can do anything after all..."
Meet Minh, a boy who can not return home after go to hospital to meet his mom. He was stuck in a hospital realm, meeting strange things and a little girl call Nhi. Nhi seem to hide something and Minh know he has to get out of this mess. 
Come to "The Notebook", where you can not know if this your own dream...')
insert into game values('3', 'Work in process', './Files/Game/3.png', 'Somthing is still working in Process!
We promise to have contents soon. 
Maybe, just maybe, we will meet some monster and a girl who is a prist but hang out with some monster friends.
We are always beside you, even in your Dream...')

select * from game

create table gallery (
  id varchar(50) primary key,
  image_file_name varchar(30) not null
)

drop table gallery

insert into gallery values ('1', './Files/Gallery/1.png')
insert into gallery values ('2', './Files/Gallery/2.png')
insert into gallery values ('3', './Files/Gallery/3.png')
insert into gallery values ('4', './Files/Gallery/4.png')
insert into gallery values ('5', './Files/Gallery/5.png')
insert into gallery values ('6', './Files/Gallery/6.png')
insert into gallery values ('7', './Files/Gallery/7.png')
insert into gallery values ('8', './Files/Gallery/8.png')
insert into gallery values ('9', './Files/Gallery/9.png')
insert into gallery values ('10', './Files/Gallery/10.png')
insert into gallery values ('11', './Files/Gallery/11.png')
insert into gallery values ('12', './Files/Gallery/12.png')
insert into gallery values ('13', './Files/Gallery/13.png')
insert into gallery values ('14', './Files/Gallery/14.png')
insert into gallery values ('15', './Files/Gallery/15.png')
insert into gallery values ('16', './Files/Gallery/16.png')
insert into gallery values ('17', './Files/Gallery/17.png')
insert into gallery values ('18', './Files/Gallery/18.png')
insert into gallery values ('19', './Files/Gallery/19.png')
insert into gallery values ('20', './Files/Gallery/20.png')
insert into gallery values ('21', './Files/Gallery/21.png')
insert into gallery values ('22', './Files/Gallery/22.png')
insert into gallery values ('23', './Files/Gallery/23.png')
insert into gallery values ('24', './Files/Gallery/24.png')
insert into gallery values ('25', './Files/Gallery/25.png')

select * from gallery

insert into Customer values('1', 'aaa', 'aaa', 'abc', 'abc', 'aaa')
insert into Customer values('2', 'aaa', 'aaa', 'abc', 'abc', 'aaa')

update Customer set Role = 'Admin' where id = 6

select count(*) 'count' from Customer where username = 'aaa' and password = 'aaa'

select count(*) 'count' from Orders where cust = '3'

select name from Customer where username = 'aaa' and password = 'aaa'

select id, username, password, name, phone, address, Role from Customer where Role = 'user'

select * from Customer

select * from Customer

select id, username, password, name, phone, address from Customer where username = 'nghia'

update Customer set password = '123', name = 'ha', phone = '123', address = 'BG' where username = 'aaa'

delete Customer where id='9'