create database Sales;
use sales;

-- 1.	Create the Salespeople as below screenshot.

create table salespeople(snum int not null unique,
sname varchar(50),city varchar(50),
comm float,constraint pk_snum primary key(snum)); 

insert into salespeople values
(1001,"peel","london",0.12),
(1002,"serres","san jose",0.13),
(1003,"axelrod","new york",0.10),
(1004,"motika","london",0.11),
(1007,"rafkin","barcelona",0.15);

select * from salespeople;----- 1
show tables;
drop table salespeople;


-- 2. Create the Cust Table as below Screenshot  
   	
create table cust(cnum int not null primary key,
cname varchar(50),
city varchar(50),
rating int,
snum int references salespeople(snum)); 

insert  into cust values(2001,"Hoffman","london",100,1001),
(2002,"giovanne","rome",200,1003),
(2003,"liu","san jose",300,1002),
(2004,"graaa","berlin",100,1002),
(2006,"clemens","london",500,1007),
(2007,"pereira","rome",100,1004),
(2008,"james","london",200,1007);
select * from cust;----- 2
drop table cust;

-- 3. Create orders table as below screenshot.

create table orders(onum int,
amount float,
odate date,
cnum int references cust(cnum),snum int);

insert into orders values(3001,18.69,"1994-10-03",2008,1007),
(3002,1900.10,"1994-10-03",2007,1004),
(3003,767.19,"1994-10-03",2001,1001),
(3005,5160.45,"1994-10-03",2003,1002),
(3006,1098.16,"1994-10-04",2008,1007),
(3007,75.75,"1994-10-05",2004,1002),
(3008,4723.00,"1994-10-05",2006,1001),
(3009,1713.23,"1994-10-04",2002,1003),(3010,1309.95,"1994-10-06",2004,1002),(3011,9891.88,"1994-10-06",2006,1001);
Select * from orders;----- 3
drop table orders;


-- 4.	Write a query to match the salespeople to the customers according to the city they are living.
select c.cname,s.sname,c.city from salespeople as s cross join cust as c on c.snum=s.snum where c.city=s.city;

-- 5.	Write a query to select the names of customers and the salespersons who are providing service to them.
select c.cname,s.sname,s.comm,c.rating from cust as c 
inner join salespeople as s on c.snum=s.snum;

-- 6.	Write a query to find out all orders by customers not located in the same cities as that of their salespeople
select c.cname,s.sname,s.city,o.odate from salespeople as s inner join cust as c on s.snum=c.snum inner join orders as o on
 c.cnum=o.cnum where s.city <> c.city;

-- 7.	Write a query that lists each order number followed by name of customer who made that order
select distinct(o.onum), c.cname from orders as o inner join cust as c on c.cnum=o.cnum;

-- 8. Write a query that finds all pairs of customers having the same rating
select c.cname, r.rating from cust as c , cust as r where c.rating=r.rating;


-- 9.	Write a query to find out all pairs of customers served by a single salesperson
select c.cname,s.sname from cust as c inner join salespeople as s where c.snum=s.snum;

-- 10.	Write a query that produces all pairs of salespeople who are living in same city 
select s.sname,t.city from salespeople as s, salespeople as t where s.city=t.city;


-- 11.	Write a Query to find all orders credited to the same salesperson who services Customer 2008
select * from orders where snum=(select distinct snum from orders where cnum=2008);


-- 12.	Write a Query to find out all orders that are greater than the average for Oct 4th 
select * from orders where amount >( select avg(amount) as avg_amt from orders  where odate>="1994-10-04");

-- 13.	Write a Query to find all orders attributed to salespeople in London. 
select * from orders where snum in (select snum from salespeople where city="london");


-- 14. Write a query to find all the customers whose cnum is 1000 above the snum of Serres. 
select cnum,cname from cust where cnum >(select snum+1000 from salespeople where sname="serres");

-- 15.	Write a query to count customers with ratings above San Jose’s average rating 

select count(cnum) as c_num, rating from cust where rating >(select avg(rating) as avg_rating from cust where city="san jose") group by cnum, city;


-- 16.	Write a query to show each salesperson with multiple customers.
SELECT * FROM salespeople WHERE snum IN (SELECT DISTINCT snum FROM cust a
 WHERE EXISTS (SELECT * FROM cust b WHERE b.snum=a.snum AND b.cname<>a.cname));



