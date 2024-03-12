-- Challenge 1:
-- 1.1 and 1.2 Shortest movie and average in hours and minutes
SELECT 
	MIN(length) AS 'shortest movie duration',
    MAX(length) AS 'longest movie duration',
    ROUND(AVG(length),0) AS 'average in min',
    CEILING(AVG(length)/60) AS 'average in hours'
FROM film;

-- 2.1 number of days that the company has been operating
SELECT DATEDIFF(MAX(rental_date),MIN(rental_date)) FROM rental;

-- 2.2 and 2.3 Two additional columns to show the month and weekday of the rental. Return 20 rows of results.
-- dditional column called DAY_TYPE with values 'weekend' or 'workday', depending on the day of the week
SELECT rental_date, DATE_FORMAT(rental_date, '%M') AS 'Month',
DATE_FORMAT(rental_date, '%a') AS 'Weekday',
CASE
	WHEN DATE_FORMAT(rental_date, '%a') = 'Sat' THEN 'Weekend'
    WHEN DATE_FORMAT(rental_date, '%a') = 'Sun' THEN 'Weekend'
    ELSE 'Worday'
END AS 'Date_type'
 FROM rental
 limit 20;
 
-- 3. retrieve the film titles and their rental duration. If any rental duration value is NULL, 
-- replace it with the string 'Not Available'. Sort the results of the film title in ascending order

SELECT title, rental_duration FROM film
WHERE IFNULL(rental_duration, 'Not Available');

-- 4. personalized email campaign for customers

SELECT CONCAT(first_name,' ', last_name) AS 'Name', LEFT(email,3) FROM customer;

-- Challenge 2:
-- 1.1 The total number of films that have been released. ANSWER= 1000
SELECT * FROM film;
SELECT COUNT(film_id) FROM film;

-- 1.2 The number of films for each rating.
SELECT rating, COUNT(film_id) FROM film
GROUP BY rating; 

-- 1.3 The number of films for each rating, sorting the results in descending order of the number
-- of films. This will help you to better understand the popularity of different film ratings and 
-- adjust purchasing decisions accordingly.

SELECT rating, COUNT(film_id) FROM film
GROUP BY rating
ORDER BY COUNT(film_id) DESC;

-- 2.1 The mean film duration for each rating, and sort the results in descending order of the 
-- mean duration. Round off the average lengths to two decimal places. This will help identify 
-- popular movie lengths for each category.

SELECT rating, COUNT(film_id) AS 'COUNT', ROUND(AVG(length),2) AS 'AVG' FROM film
GROUP BY rating
ORDER BY ROUND(AVG(length),2) DESC;

-- 2.2 Identify which ratings have a mean duration of over two hours in order to help select 
-- films for customers who prefer longer movies.

SELECT rating, COUNT(film_id) AS 'COUNT', ROUND(AVG(length),2) AS 'AVG' FROM film
GROUP BY rating
HAVING (ROUND(AVG(length),2)/60) >2
ORDER BY ROUND(AVG(length),2) DESC;

-- 3. Bonus: determine which last names are not repeated in the table actor.
SELECT last_name, COUNT(*) FROM actor
GROUP BY last_name
HAVING COUNT(*)=1;
