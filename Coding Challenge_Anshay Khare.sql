create database Ecom;
use Ecom;

create table customers(
customer_id INT PRIMARY KEY,
first_name VARCHAR(20) NOT NULL,
last_name VARCHAR(20) NOT NULL,
email VARCHAR(30) NOT NULL,
address VARCHAR(30) NOT NULL);

Insert Into customers(customer_id,first_name, last_name, email, address)
VALUES
(1,'John', 'Doe', 'johndoe@example.com' ,'123 Main St, City'), 
(2,'Jane', 'Smith', 'janesmith@example.com' ,'456 Elm St, Town'), 
(3,'Robert', 'Johnson', 'robert@example.com' ,'789 Oak St, Village'), 
(4,'Sarah', 'Brown', 'sarah@example.com' ,'101 Pine St, Suburb'), 
(5,'David', 'Lee', 'david@example.com' ,'234 Cedar St, District'), 
(6,'Laura', 'Hall', 'laura@example.com' ,'567 Birch St, County'), 
(7,'Michael', 'Davis', 'michael@example.com' ,'890 Maple St, State'), 
(8,'Emma', 'Wilson', 'emma@example.com' ,'321 Redwood St, Country'), 
(9,'William', 'Taylor', 'william@example.com' ,'432 Spruce St, Province'), 
(10,'Olivia', 'Adams', 'olivia@example.com' ,'765 Fir St, Territory');

select * from customers;

create table products(
product_id INT IDENTITY PRIMARY KEY,
name VARCHAR(20) NOT NULL,
Description VARCHAR(30),
price decimal,
stockQuantity int);

insert into products(name,Description,price,stockQuantity)
Values
('Laptop','High-performance laptop',800.00,10),
('Smartphone','Latest smartphone',600.00,15),
('Tablet','Portable tablet',300.00,20),
('Headphones','Noise-canceling',150.00,30),
('TV','4K Smart TV',900.00,5),
('Coffee Maker','Automatic coffee maker',50.00,25),
('Refrigerator','Energy-efficient',700.00,10),
('Microwave Oven','Countertop microwave',80.00,15),
('Blender','High-speed blender',70.00,20),
('Vacuum Cleaner','Bagless vacuum cleaner',120.00,10);

select * from products;

create table cart(
cart_id INT IDENTITY PRIMARY KEY,
customer_id INT FOREIGN KEY REFERENCES customers(customer_id),
product_id INT FOREIGN KEY REFERENCES products(product_id),
quantity int);

insert into cart(customer_id,product_id,quantity)
Values
(1,1,2),
(1,3,1),
(2,2,3),
(3,4,4),
(3,5,2),
(4,6,1),
(5,1,1),
(6,10,2),
(6,9,3),
(7,7,2);

select* from cart;

create table orders(
order_id INT IDENTITY PRIMARY KEY,
customer_id INT FOREIGN KEY REFERENCES customers(customer_id),
order_date Varchar(15),
total_amount decimal);

insert into orders(customer_id,order_date,total_amount)
Values
(1,'2023-01-05',1200.00),
(2,'2023-02-10',900.00),
(3,'2023-03-15',300.00),
(4,'2023-04-20',150.00),
(5,'2023-05-25',1800.00),
(6,'2023-06-30',400.00),
(7,'2023-07-05',700.00),
(8,'2023-08-10',160.00),
(9,'2023-09-15',140.00),
(10,'2023-10-20',1400.00);

select * from orders;

create table order_items(
order_item_id INT IDENTITY PRIMARY KEY,
order_id INT FOREIGN KEY REFERENCES orders(order_id),
product_id INT FOREIGN KEY REFERENCES products(product_id),
quantity INT,
item_amount decimal);

insert into order_items(order_id,product_id,quantity,item_amount)
Values
(1,1,2,1600.00),
(1,3,1,300.00),
(2,2,3,1800.00),
(3,5,2,1800.00),
(4,4,4,600.00),
(4,6,1,50.00),
(5,1,1,800.00),
(5,2,2,1200.00),
(6,10,2,240.00),
(6,9,3,210.00);

select * from order_items;

--1. Update refrigerator product price to 800. 
update products
set price = 800
where product_id = 7;

--2. Remove all cart items for a specific customer.
delete from cart where customer_id = 3;

--3. Retrieve Products Priced Below $100. 
select * From products
where price<100.00;

--4. Find Products with Stock Quantity Greater Than 5. 
select product_id,name,stockQuantity From products
where stockQuantity>5;

--5. Retrieve Orders with Total Amount Between $500 and $1000. 
select * from orders
where total_amount between 500 and 1000; 

--6. Find Products which name end with letter ‘r’.
select * from products
where name like '%r';

--7. Retrieve Cart Items for Customer 5.
select * from cart
where customer_id = 5;

--8. Find Customers Who Placed Orders in 2023.
select c.first_name, c. last_name, o.order_date 
from customers c join orders o on c.customer_id = o.customer_id
where o.order_date like '2023%';

--9. Determine the Minimum Stock Quantity for Each Product Category.
select MIN(stockQuantity) AS min_stockQuantity 
from products

--10. Calculate the Total Amount Spent by Each Customer.  
select customer_id, total_amount from orders

--11. Find the Average Order Amount for Each Customer.
select customer_id, avg(total_amount) AS AVG_Amount 
from orders group by customer_id;


--12. Count the Number of Orders Placed by Each Customer.
select customer_id,sum(quantity) AS orders_placed from cart
group by customer_id

--13. Find the Maximum Order Amount for Each Customer. 
SELECT customer_id, MAX(total_amount) AS max_order_amount
FROM orders
GROUP BY customer_id;

--14. Get Customers Who Placed Orders Totaling Over $1000.
select * from orders
where total_amount>1000;

--15. Subquery to Find Products Not in the Cart.
select p.product_id,c.quantity from products p  left join cart c
on p.product_id = c.product_id
where quantity IS NULL

--16. Subquery to Find Customers Who Haven't Placed Orders.
select c.* from customers c  left join orders o
on c.customer_id = o.customer_id
where o.order_id IS NULL

--17. Subquery to Calculate the Percentage of Total Revenue for a Product. 
select *, (price*stockQuantity) AS total_revenue,
       ((price*stockQuantity)/100) AS revenue_percentage 
from products

--18. Subquery to Find Products with Low Stock. 
declare @stockShortage int = 12;
select * from products
where stockQuantity< @stockShortage;

--19. Subquery to Find Customers Who Placed High-Value Orders. 
declare @expensive int = 1100;
select customer_id, total_amount from orders
where total_amount> @expensive;