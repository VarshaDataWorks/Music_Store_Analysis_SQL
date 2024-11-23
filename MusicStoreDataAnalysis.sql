/* Question Set 1 - Easy */

/* Q1: Who is the senior-most employee based on job title? */

/* Checking the employee table */
-- SELECT * FROM employee;
/* Finding the senior-most employee */
SELECT * FROM employee WHERE reports_to IS NULL;
/* Or */
SELECT * FROM employee ORDER BY levels DESC LIMIT 1;

/* Q2: Which countries have the most invoices? */

/* Checking the invoice table */
-- SELECT * FROM invoice;
/* Finding the country with the most invoices */
SELECT billing_country, COUNT(*) AS total_bill
FROM invoice
GROUP BY billing_country
ORDER BY total_bill DESC
LIMIT 1;

/* Q3: What are the top 3 values of total invoice? */

/* Checking the invoice table */
-- SELECT * FROM invoice;
/* Finding the top 3 total invoice values */
SELECT total
FROM invoice
ORDER BY total DESC
LIMIT 3;

/* Q4: Which city has the best customers? We would like to throw a promotional music festival in the city where we made the most money. 
Write a query that returns the city name and sum of all invoice totals. */

/* Checking the invoice table */
-- SELECT * FROM invoice;
/* Finding the city with the highest sum of invoice totals */
SELECT billing_city, SUM(total) AS total_invoice
FROM invoice
GROUP BY billing_city
ORDER BY total_invoice DESC
LIMIT 1;

/* Q5: Who is the best customer? The customer who has spent the most money will be declared the best customer. 
Write a query that returns the person who has spent the most money. */

/* Checking the customer table */
-- SELECT * FROM customer;
/* Checking the invoice table */
-- SELECT * FROM invoice;
/* Finding the best customer */
SELECT i.customer_id, c.first_name, c.last_name, SUM(total) AS total_amount
FROM invoice AS i
JOIN customer AS c ON c.customer_id = i.customer_id
GROUP BY i.customer_id, c.first_name, c.last_name
ORDER BY total_amount DESC
LIMIT 1;

/* Question Set 2 - Moderate */

/* Q1: Write a query to return the email, first name, last name, and genre of all Rock music listeners. 
Return your list ordered alphabetically by email starting with A. */

/* Checking the genre table */
-- SELECT * FROM genre;
/* Checking the track table */
-- SELECT * FROM track;
/* Checking the invoice_line table */
-- SELECT * FROM invoice_line;
/* Checking the invoice table */
-- SELECT * FROM invoice;
/* Checking the customer table */
-- SELECT * FROM customer;
/* Query for Rock music listeners */
SELECT DISTINCT(email), first_name, last_name, g.name
FROM genre AS g
JOIN track AS t ON g.genre_id = t.genre_id
JOIN invoice_line AS il ON il.track_id = t.track_id
JOIN invoice AS i ON i.invoice_id = il.invoice_id
JOIN customer AS c ON c.customer_id = i.customer_id
WHERE g.name = 'Rock'
ORDER BY email;

/* Q2: Write a query that returns the top 10 artist names and total track count based on their total track count for Rock music. */

/* Checking the artist table */
-- SELECT * FROM artist;
/* Checking the album table */
-- SELECT * FROM album;
/* Checking the track table */
-- SELECT * FROM track;
/* Query for the top 10 artists */
SELECT art.name, COUNT(track_id) AS total_track_count
FROM artist AS art
JOIN album AS al ON art.artist_id = al.artist_id
JOIN track AS t ON t.album_id = al.album_id
JOIN genre AS g ON t.genre_id = g.genre_id
WHERE g.name = 'Rock'
GROUP BY art.name
ORDER BY total_track_count DESC
LIMIT 10;

/* Q3: Return all the track names that have a song length longer than the average song length. 

Return the name and milliseconds for each track. Order by song length, with the longest songs listed first. */
/* Checking the track table */
-- SELECT * FROM track;
/* Query for tracks longer than the average song length */
SELECT name, milliseconds
FROM track
WHERE milliseconds > (SELECT AVG(milliseconds) FROM track)
ORDER BY milliseconds DESC;

/* Question Set 3 - Advanced */

/* Q1: Find how much amount each customer spent on artists. 

Write a query to return customer name, artist name, and total spent. */
/* Checking the invoice_line table */
-- SELECT * FROM invoice_line;
/* Checking the artist table */
-- SELECT * FROM artist;
/* Checking the track table */
-- SELECT * FROM track;
/* Query to find total spent by each customer on artists */
SELECT c.first_name, art.name, SUM(il.unit_price * il.quantity) AS total_spent
FROM artist AS art
JOIN album AS al ON art.artist_id = al.artist_id
JOIN track AS t ON al.album_id = t.album_id
JOIN invoice_line AS il ON il.track_id = t.track_id
JOIN invoice AS i ON i.invoice_id = il.invoice_id
JOIN customer AS c ON c.customer_id = i.customer_id
GROUP BY c.first_name, art.name
ORDER BY total_spent DESC;
