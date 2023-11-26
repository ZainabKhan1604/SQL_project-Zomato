# SQL_project-Zomato
Project Introduction: Zomato Analytics

Welcome to the Zomato Analytics project, a comprehensive SQL-based exploration of a food service provider app inspired by Zomato. In this project, I've designed a relational database comprising four key tables - Users, GoldUsers, Sales, and Products - to capture and analyze essential data for enhancing business insights.

# Table Descriptions:

  - Users Table: This table houses user details, including userid and their signup_date.

  - GoldUsers Table: Focused on users who have availed the gold membership, this table records userid and the respective gold_signup_date.

  - Sales Table: A crucial table containing transaction data with columns for userid, created_date, and product_id.

  - Products Table: Details about various menu items, including product_id, product_name, and price.

# Key Project Queries:

  - Total Amount Spent by Each Customer:  Determine the overall expenditure for every customer on Zomato.
    
  - First Product Purchased by Each Customer: Identify the initial purchase made by each customer.
 
  - Most Purchased Item on the Menu: Find the menu item with the highest frequency of purchases and quantify the number of times it was bought.
  
  - Most Popular Item for Each Customer: Identify the preferred item for each customer based on their purchase history.
  
  - Gold Membership Insights: Analyze purchasing behavior concerning the gold membership, such as the first and last items bought, total orders, and spending before 
    becoming a gold member.
  
  - Zomato Points Calculation: Implement a points system for purchases and analyze the product that has generated the most points.
  
  - Gold Member Points in the First Year: Assess the Zomato points earned by gold members in their first year, considering the 5 points for every 10 Rs spent.
  
  - Comparative Point Earnings: Determine and compare the point earnings of specific users (e.g., User 1 and User 3).
  
  - Transaction Ranking: Rank all transactions, both overall and specifically for gold and non-gold members.

This Zomato Analytics project aims to showcase not only your SQL proficiency but also your ability to derive meaningful insights from complex data structures. The queries address various aspects of user behavior, membership trends, and point generation, providing a holistic view of the application's performance. The code and results for these queries can be explored in the repository, demonstrating your skills in database management and analysis.

# Key findings:
The key findings of the Zomato Analytics project are as follows:

1) User Spending Patterns: Identified the total amount spent by each customer on the Zomato platform, offering insights into user expenditure.

2) Initial Purchase Insights:Determined the first product purchased by each customer, shedding light on the entry points of user engagement.
   product with product id 1 was the first product purchased by all the customers.

3) Menu Item Popularity: Discovered the most purchased item on the menu, providing valuable information for menu optimization and marketing.
   Products with product id 2 and 3 were found out to be most popular items.

4) Customer Preferences: Established the most popular item for each customer, allowing for personalized marketing strategies and menu recommendations.
   product with product id 3 was most popular for user id 1 and 3 whereas for user id 2 the most  popular item was product 1.

5) Gold Membership Impact: Explored purchasing behavior before and after users became Gold Members, understanding the influence of membership on user transactions.
   First item purchased after becoming gold member- userid 1 purchased product id 3 and user id 3 purchased product id 2.
   Last item purchased before becoming gold member- Both userid 1 and 3 purchased product id 2.

6) Zomato Points System: Implemented a points system for purchases, revealing the product that generated the most points and enhancing customer engagement.
   Total Zomato points earned by each user : user id 1 = 1829 points ; user id 2 = 763 points ; user id 3 = 1697 points.

7) First-Year Gold Member Points: Calculated Zomato points earned by gold members in their first year, considering the additional points awarded during this period.
   Total points earned in first year of gold membership : user id 1 = 165 points ; user id 3 = 435 points

8) Comparative Point Earnings: Compared point earnings between specific users, providing insights into individual user loyalty and engagement. 
   User with userid 3 had most zomato points who earned 435 points in total.

9) Transaction Rankings: Ranked all transactions, both overall and for gold and non-gold members separately, facilitating a deeper understanding of transaction dynamics.

# CONCLUSION
These findings collectively offer a comprehensive view of user behavior, preferences, and the impact of the gold membership program. The project showcases your ability 
to extract meaningful insights from a relational database, providing valuable information for strategic decision-making within the context of a food service provider app like Zomato.




