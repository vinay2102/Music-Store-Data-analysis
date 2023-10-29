/* Q1: Find how much amount spent by each customer on artists? Write a query to return
customer name, artist name and total spent */

select c.customer_id , c.first_name, c.last_name , ar.name,
sum (il.unit_price * il.quantity) as Total_spent
from customer as c
join invoice as i on c.customer_id= i.customer_id
join invoice_line as il on il.invoice_id = i.invoice_id
join track as t on t.track_id= il.track_id
join album as alb on alb.album_id= t.album_id
join artist as ar on ar.artist_id = alb.artist_id
group by 1,2,3,4
order by 5 DESC

/* Q2: We want to find out the most popular music Genre for each country. We determine the
most popular genre as the genre with the highest amount of purchases. Write a query
that returns each country along with the top Genre. For countries where the maximum
number of purchases is shared return all Genres */

with popular_genre as (
	select count(invoice_line.quantity) as Purchase, c.country,g.name,g.genre_id,
	row_number() OVER(PARTITION by c.country order by count(invoice_line.quantity) desc) as RowNo
	from invoice_line
	join invoice as i on i.invoice_id = invoice_line.invoice_id
	join customer as c on c.customer_id = i.customer_id
	join track as t on t.track_id = invoice_line.track_id
	join genre as g on g.genre_id = t.genre_id
	group by 2,3,4
	order by 2 asc , 1 DESC	
)
select * from popular_genre where RowNo <=1

/* Q3: Write a query that determines the customer that has spent the most on music for each
country. Write a query that returns the country along with the top customer and how
much they spent. For countries where the top amount spent is shared, provide all
customers who spent this amount */

with cust_country as (
	select c.customer_id,first_name,last_name,billing_country , sum(total) as Total_spending,
	row_number() over(PARTITION by billing_country order by sum(total) desc ) as RowNo
	from invoice 
	join customer as c on c. customer_id = invoice.customer_id
	group by 1,2,3,4
	order by 4 asc,5 desc)
select * from cust_country where RowNo <=1	

