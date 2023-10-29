/* Q1: Write query to return the email, first name, last name, & Genre of all Rock Music
listeners. Return your list ordered alphabetically by email starting with A */

select distinct email,first_name,last_name
from customer
join invoice as inv
on inv.customer_id = customer.customer_id
JOIN invoice_line as inl
on inl.invoice_id = inv.invoice_id
where track_id in(
	select track_id from track
	join genre on track.genre_id=genre.genre_id
	where genre.name like 'Rock'
)
order by email;

/* Q2: Let's invite the artists who have written the most rock music in our dataset. Write a
query that returns the Artist name and total track count of the top 10 rock bands */

select a.name , count(a.artist_id) as Total_Track
from artist as a 
join album as ab on a.artist_id = ab.artist_id
join track as t on t.album_id = ab.album_id
join genre as g on g.genre_id = t.genre_id
where g.name like 'Rock'
GROUP by a.artist_id
order by Total_Track desc
limit 10;

/* Q3: Return all the track names that have a song length longer than the average song length.
Return the Name and Milliseconds for each track. Order by the song length with the
longest songs listed first */

select  t.name, t.milliseconds as length_of_song
from track as t
where t.milliseconds > ( select avg(milliseconds) from track)
order by length_of_song desc;

