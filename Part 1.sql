-- Q1: Who is senior most employee based on job title ?
select * from employee
order by levels desc
limit 1;

-- Q2: Which country have the most invoice ?
select count(*) as c, billing_country 
from invoice
group by billing_country
order by c desc;

-- Q3 What are top three values of total invoice
select total 
from invoice
order by total desc

/* Q4: Which city has the best customers? We would like to throw a promotional Music Festival in the city we made the most money. 
Write a query that returns one city that has the highest sum of invoice totals. 
Return both the city name & sum of all invoice totals */

select billing_city,sum(total) as Total_Billing 
from invoice
group by billing_city
order by Total_Billing desc

/* Q5: Who is the best customer? The customer who has spent the most money will be
declared the best customer. Write a query that returns the person who has spent the
most money*/

select c.customer_id,c.first_name ,c.last_name,sum(inv.total) as total
from customer as c
join invoice as inv
on c.customer_id= inv.customer_id
group by c.customer_id 
order by total DESC
limit 1


