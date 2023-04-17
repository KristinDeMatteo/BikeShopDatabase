-- Creates vendors database
drop database if exists vendors;
create database if not exists vendors;
use vendors;

-- drop table if exists company;
create table if not exists company(
vcid int,
company_name varchar(255),
address varchar(255),
city varchar(255),
state varchar(255),
zip int,
primary key(vcid)
);

drop table if exists salesperson;
create table if not exists salesperson(
eid int,
vcid int,
ename varchar(255),
employee_contact varchar(255),
contact_type varchar(255),
primary key(eid,vcid),
constraint fk1_vcid
	foreign key(vcid)
    references company(vcid)
    on delete cascade
    on update cascade
);

insert into company values(101, 'Speedster', '42 West Overland Drive', 'Augusta', 'ME', 04333);
insert into company values(202, 'Acme', '100 Mountain View Road', 'Colchester', 'VT', 05446);
insert into company values(303, 'Widget', '1 Main Street Suite 4A', 'Manchester', 'NH', 03108);
insert into salesperson values(1,101, 'Elliot Jones','ejones@speedster.com','email');																
insert into salesperson values(2,101, 'Mary Course','mcourse@speedster.com', 'email');
insert into salesperson values(3,101, 'Sarah Hopkins', 'shopkins@speedster.com', 'email');
insert into salesperson values(4,202, 'Sally Saw','888-865-6547', 'phone');
insert into salesperson values(5,202, 'Steve Perez','888-865-1235', 'phone');
insert into salesperson values(6,202, 'Jane Smith','888-865-4569', 'phone');
insert into salesperson values(7,303, 'John Cuts','800-654-9874', 'phone');

-- Creates products database
drop database if exists products;

create database if not exists products;
use products;

drop table if exists product;
create table if not exists product(
prod_id int,
prod_name varchar(255),
prod_desc varchar(255),
price double,
-- Checks to ensure max value isn't exceeded
qt_on_hand int CHECK (qt_on_hand BETWEEN 0 and 100),
as_of_date varchar(255),
bike_type varchar(255) unique,
trigger_order int,
primary key(prod_id)
);

INSERT INTO `product` VALUES (23,'Premier Mountain Bike','This bike will have you scaling new heights',780,25,'3/1/2022','mountain',45),
(125,'Racing Bike','Our premier racing bike',1900,18,'3/1/2022','racing',25),
(705,'Cruising Bike','For those who enjoy a causal bike ride or racing events.',2500,10,'3/1/2022','cruising',20),
(896,'The Road Warrior','This is our finest all-purpose bike. Great for all activites',450,10,'3/1/2022','road warrior',15);


drop table if exists prodparts;
create table prodparts(
prod_id int,
price_date varchar(255),
price int,
last_price int,
primary key(prod_id),
constraint fk1_vendor
	foreign key(prod_id)
    references products.product(prod_id)
    on delete cascade
    on update cascade
);

insert into prodparts(prod_id,price_date,price) values
(23,'12/16/2020',625),(23,'7/1/2021',675) ,
(23,'2/16/2022',700),(125,'8/16/2020',1600),
(125,'10/12/2021',1700),(125,'2/6/2022',1800),
(125,'1/10/2022',1890),(705,'6/11/2020',1700),
(705,'1/1/2021',1900),(705,'3/1/2021',2000),
(896,'11/30/2020',350),(896,'2/18/2021',390),
(896,'9/10/2021',400)
on duplicate key update last_price = price, price = VALUES(price);


-- Creates parts database
drop database if exists parts;

create database parts;
use parts;

-- Assume vendors and product db already exists
drop table if exists vendorpart;
create table if not exists vendorpart(
vcid int,
pid varchar(255),
part_name varchar(255),
bike_type varchar(255),
price double,
primary key(vcid,pid(255)),
constraint fk1_vendorpart
	foreign key(vcid)
    references vendors.company(vcid)
    on delete cascade
    on update cascade
);

INSERT INTO `vendorpart` VALUES (101,'BBS087','brake systems w/cables - mountain bike','mountain',175),(101,'BDR510','derailleurs w/cables - cruising bike','cruising',90),(101,'BF1478','bike frame - road warrior','road warrior',90),(101,'BF2001','bike frame - cruising bike','cruising',175),(101,'BP301','bike pedals - cruising bike','cruising',90),(101,'BP942','bike pedals - racing bike','racing',50),(101,'BR4563','reflectors - racing bike','racing',175),(101,'BT9635','front tire - racing','racing',175),(101,'RTW025','rear tire w/chain & mount - mountain bike','mountain',175),(101,'S0023','gear set - cruising bike','cruising',175),(101,'S1029','handle bar - racing bike','racing',90),(101,'S267','bike seat - muntain bike','muntain',50),(101,'S3297','bike seat - cruising bike','cruising',60),(101,'S4501','bike seat - road warrior','road warrior',50),(101,'S678','bike seat - racing bike','racing',60),(202,'BBS777','brake systems w/cables - road warrior bike','road warrior',250),(202,'BBS986','brake systems w/cables - cruising bike','cruising',45),(202,'BDR001','derailleurs w/cables - mountain bike','mountain',450),(202,'BDT311','derailleurs w/cables - racing bike','racing',625),(202,'BDT888','derailleurs w/cables - road warrior bike','road warrior',45),(202,'BP0504','bike pedals - road warrior','road warrior',600),(202,'BP9802','bike pedals - mountain bike','mountain',450),(202,'BR0021','reflectors - cruising bike','cruising',120),(202,'BR7896','reflectors - road warrior bike','road warrior',190),(202,'BT4697','front tire - road warrior','road warrior',45),(202,'CS3214','gear set - road warrior','road warrior',250),(202,'F0235','bike frame - mountain','mountain',600),(202,'F6431','bike frame - racing','racing',450),(202,'F9632','bike frame - road warrior','road warrior',625),(202,'F9870','bike frame - cruising bike','cruising',625),(202,'J8790','handle bar - mountain bike','mountain',120),(202,'K98','gear set - racing bike','racing',190),(202,'RTW7135','rear tire w/chain & mount - cruising bike','cruising',625),(202,'RTW985','rear tire w/chain & mount - racing bike','racing',600),(202,'S124','handle bar - cruising bike','cruising',90),(202,'S258','bike seat - cruising bike','cruising',45),(303,'BBS055','brake systems w/cables - racing bike','racing',200),(303,'BF452','bike frame - racing','racing',550),(303,'BR9164','reflectors - mountain bike','mountain',120),(303,'BT852','front- tire - cruising bike','cruising',550),(303,'BT987','front tire - mountain','mountain',45),(303,'C3402','gear set - mountain bike','mountain',200),(303,'FF45','front & rear fenders - cruising bike','cruising',550),(303,'FF99','front & rear fenders - road warrior bike','road warrior',45),(303,'RT7391','rear tire w/chain & mount - raod warrior','raod warrior',550),(303,'S2301','handle bar - road warrior','road warrior',120);

