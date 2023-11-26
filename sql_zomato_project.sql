-- Welcome to the Zomato Analytics project, a comprehensive SQL-based exploration of a food service provider app 
-- inspired by Zomato. In this project, we've designed a relational database comprising 
-- four key tables - Users, GoldUsers, Sales, and Products -
-- to capture and analyze essential data for enhancing business insights.

-- creating new tables

-- GoldUsers Table: Focused on users who have availed the gold membership, 
-- this table records userid and the respective gold_signup_date.

drop table if exists goldusers_signup;
CREATE TABLE goldusers_signup(userid integer,gold_signup_date date); 

INSERT INTO goldusers_signup(userid,gold_signup_date) 
 VALUES (1,'09-22-2017'),
(3,'04-21-2017');

-- Users Table: This table houses user details, including userid and their signup_date.

drop table if exists users;
CREATE TABLE users(userid integer,signup_date date); 

INSERT INTO users(userid,signup_date) 
 VALUES (1,'09-02-2014'),
(2,'01-15-2015'),
(3,'04-11-2014');

-- Sales Table: A crucial table containing transaction data with columns for userid, created_date, and product_id.

drop table if exists sales;
CREATE TABLE sales(userid integer,created_date date,product_id integer); 

INSERT INTO sales(userid,created_date,product_id) 
 VALUES (1,'04-19-2017',2),
(3,'12-18-2019',1),
(2,'07-20-2020',3),
(1,'10-23-2019',2),
(1,'03-19-2018',3),
(3,'12-20-2016',2),
(1,'11-09-2016',1),
(1,'05-20-2016',3),
(2,'09-24-2017',1),
(1,'03-11-2017',2),
(1,'03-11-2016',1),
(3,'11-10-2016',1),
(3,'12-07-2017',2),
(3,'12-15-2016',2),
(2,'11-08-2017',2),
(2,'09-10-2018',3);


-- Products Table: Details about various menu items, including product_id, product_name, and price.

drop table if exists product;
CREATE TABLE product(product_id integer,product_name text,price integer); 

INSERT INTO product(product_id,product_name,price) 
 VALUES
(1,'p1',980),
(2,'p2',870),
(3,'p3',330);


select * from sales;
select * from product;
select * from goldusers_signup;
select * from users;

-- Total Amount Spent by Each Customer: Determine the overall expenditure for every customer on Zomato.

select a.userid, sum(b.price ) as amount_spent
from sales a 
inner join product b 
on a.product_id=b.product_id
group by a.userid

-- how many days customer visited zomato

select userid, count(distinct created_date) as days_visited from sales group by userid

-- First Product Purchased by Each Customer: Identify the initial purchase made by each customer.

select * from
(select *, rank() over(partition by userid order by created_date) as rnk from sales) a where rnk=1

-- Most Purchased Item on the Menu: Find the menu item with the highest frequency of purchases 
-- and quantify the number of times it was bought.

select userid, count(product_id) as cnt from sales where product_id =
(select top 1 product_id from sales group by product_id order by count(product_id) desc)
group by userid

-- Most Popular Item for Each Customer: Identify the preferred item for each customer based on their purchase history.

select * from
(select userid, product_id, cnt, rank() over (partition by userid order by cnt desc) as rnk
from (
  select userid, product_id, count(product_id) as cnt
  from sales
  group by userid, product_id
) a) b
where rnk=1

-- Gold Membership Insights: Analyze purchasing behavior concerning the gold membership, 
-- such as the first item purchased after becoming gold member 

select * from
(select c.*,rank() over (partition by userid order by created_date) rnk from
(select a.userid,a.created_date,a.product_id,b.gold_signup_date from sales a 
inner join goldusers_signup b
on a.userid = b.userid
and created_date>=gold_signup_date) c) d
where rnk=1

-- Gold Membership Insights: Analyze purchasing behavior concerning the gold membership, 
-- such as the last item that was purchased just before the customer became the gold member

select * from
(select c.*,rank() over (partition by userid order by created_date desc) rnk from
(select a.userid,a.created_date,a.product_id,b.gold_signup_date from sales a 
inner join goldusers_signup b
on a.userid = b.userid
and created_date<=gold_signup_date) c) d
where rnk=1

-- GGold Membership Insights: Analyze purchasing behavior concerning the gold membership, 
-- such as the total orders and amount spent for each member before they become a gold member

select userid, count(created_date) as orders_purchased,sum(price) as total_amount_spent from
(select c.*, d.price from
(select a.userid,a.created_date,a.product_id,b.gold_signup_date from sales a 
inner join goldusers_signup b
on a.userid = b.userid
and created_date<=gold_signup_date) c 
inner join product d on c.product_id = d.product_id) e
group by userid


-- Zomato Points Calculation: Implement a points system for purchases and analyze the product 
-- that has generated the most points.

--- if buying each product generates points for eg. Rs. 5 gives 2 zomato points and each product 
--- has different purchasing points for eg for product1 5 rs = 1 zomato point and 
--- for product2 10 rs = 5 zomato points
--- and product3 5 rs = 1 zomato point

select userid, sum(total_points) as total_points_earned from
(select e.*, total_price/points as total_points from
(select d.*, case when product_id= 1 then 5 when product_id=2 then 2 when product_id=3 then 5 else 0 end as points from
(select c.userid, c.product_id, sum(price) as total_price from
(select a.*,b.price from sales a inner join product b on a.product_id= b.product_id) c
group by userid, product_id) d)e)f
group by userid;

-- Cashbacks earned: Calculate total cashbacks earned by each customer on their respective points earned 
-- here we are assuming that 5 rs= 2 zomato points hence 1 zomato point = 2.5 rs

select userid, sum(total_points)*2.5 as total_cashbacks_earned from
(select e.*, total_price/points as total_points from
(select d.*, case when product_id= 1 then 5 when product_id=2 then 2 when product_id=3 then 5 else 0 end as points from
(select c.userid, c.product_id, sum(price) as total_price from
(select a.*,b.price from sales a inner join product b on a.product_id= b.product_id) c
group by userid, product_id) d)e)f
group by userid;

-- Zomato point calculation: Calculate for which product most points have been given till now

select * from
(select *, rank() over(order by total_points desc) as rnk from
(select product_id, sum(total_points) as total_points from
(select e.*, total_price/points as total_points from
(select d.*, case when product_id= 1 then 5 when product_id=2 then 2 when product_id=3 then 5 else 0 end as points from
(select c.userid, c.product_id, sum(price) as total_price from
(select a.*,b.price from sales a inner join product b on a.product_id= b.product_id) c
group by userid, product_id) d)e)f
group by product_id) g) h
where rnk=1


-- Gold Member Points in the First Year: Assess the Zomato points earned by gold members in their first year, considering the 5 points for every 10 Rs spent.
-- Comparative Point Earnings: Determine and compare the point earnings of specific users (e.g., User 1 and User 3).

-- in the first one year after customer joins the gold membership (including their joining date)
-- irrespective of what customer has purchased they earn 5 zomato points for every 10 rs spent


-- if 5 zomato points = 10 rs then we can also say that every 1 zomato point = 2 rs thus 0.5 zomato point = 1 rs


select c.*,d.price*0.5 as total_points_earned from
(select a.userid,a.created_date,a.product_id,b.gold_signup_date from sales a 
inner join goldusers_signup b
on a.userid = b.userid 
and created_date>= gold_signup_date
and created_date<=DATEADD(year,1,gold_signup_date))c
inner join product d on c.product_id =d.product_id


-- Transaction Ranking: Rank all transactions

select *, rank() over(partition by userid order by created_date) as rnk from sales

--Transaction Ranking: Rank all transactions, both overall and specifically for gold and non-gold members.

 select d.*, case when rnk=0 then 'na' else rnk end as rnk from
(select c.*, cast( (case when gold_signup_date is null then 0 
else rank() over(partition by userid order by created_date desc ) end) as varchar) as rnk from
(select a.userid,a.created_date,a.product_id,b.gold_signup_date from sales a 
left join goldusers_signup b
on a.userid = b.userid
and created_date>=gold_signup_date) c ) d

-- KEY INSIGHTS from the project

-- The key findings of the Zomato Analytics project are as follows:

-- 1) User Spending Patterns: Identified the total amount spent by each customer on the Zomato platform, offering insights into user expenditure.

-- 2) Initial Purchase Insights:Determined the first product purchased by each customer, shedding light on the entry points of user engagement.
----- product with product id 1 was the first product purchased by all the customers.

-- 3) Menu Item Popularity: Discovered the most purchased item on the menu, providing valuable information for menu optimization and marketing.
-----Products with product id 2 and 3 were found out to be most popular items.

-- 4) Customer Preferences: Established the most popular item for each customer, allowing for personalized marketing strategies and menu recommendations.
----- product with product id 3 was most popular for user id 1 and 3 whereas for user id 2 the most  popular item was product 1.

-- 5) Gold Membership Impact: Explored purchasing behavior before and after users became Gold Members, understanding the influence of membership on user transactions.
----- First item purchased after becoming gold member- userid 1 purchased product id 3 and user id 3 purchased product id 2.
----- Last item purchased before becoming gold member- Both userid 1 and 3 purchased product id 2.

-- 6) Zomato Points System: Implemented a points system for purchases, revealing the product that generated the most points and enhancing customer engagement.
----- Total Zomato points earned by each user : user id 1 = 1829 points ; user id 2 = 763 points ; user id 3 = 1697 points.

-- 7) First-Year Gold Member Points: Calculated Zomato points earned by gold members in their first year, considering the additional points awarded during this period.
----- Total points earned in first year of gold membership : user id 1 = 165 points ; user id 3 = 435 points

-- 8) Comparative Point Earnings: Compared point earnings between specific users, providing insights into individual user loyalty and engagement. 
------ User with userid 3 had most zomato points who earned 435 points in total.

-- 9) Transaction Rankings: Ranked all transactions, both overall and for gold and non-gold members separately, facilitating a deeper understanding of transaction dynamics.

-- CONCLUSION
--These findings collectively offer a comprehensive view of user behavior, preferences, 
-- and the impact of the gold membership program. The project showcases your ability 
--to extract meaningful insights from a relational database, providing valuable information 
--for strategic decision-making within the context of a food service provider app like Zomato.