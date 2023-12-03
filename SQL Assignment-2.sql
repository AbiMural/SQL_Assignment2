-- SQL Assignment-2 
-- Retrieve the total number of rentals made in the Sakila database
select * from rental;
select count(*) from rental;
-- ------------------------------------------------------------------------------------------------------------------------------------------

-- Find the average rental duration (in days) of movies rented from the Sakila database.

select * from film;
select avg(rental_duration) from film;
-- -----------------------------------------------------------------------------------------------------------------------------------------------

-- Display the first name and last name of customers in uppercase

select * from customer;
select upper(first_name), upper(last_name) from customer;
-- ------------------------------------------------------------------------------------------------------------------------------------------------

-- Extract the month from the rental date and display it alongside the rental ID. 

select * from rental;
select rental_id, month(rental_date) as rental_month from rental;
-- ---------------------------------------------------------------------------------------------------------------------------------------------------

-- Retrieve the count of rentals for each customer (display customer ID and the count of rentals).

select * from rental;
select customer_id, count(rental_id) as count_of_rentals from rental group by customer_id;
-- ---------------------------------------------------------------------------------------------------------------------------------------------------

-- Find the total revenue generated by each store

select * from payment;
select staff_id as store, sum(amount) from payment group by staff_id;
-- ------------------------------------------------------------------------------------------------------------------------------------------------------

-- Display the title of the movie, customer s first name, and last name who rented it. 

select * from film;
select * from inventory;
select * from rental;
select * from customer;

SELECT 
    title, first_name, last_name
FROM
    film
        INNER JOIN
    inventory ON film.film_id = inventory.film_id
        INNER JOIN
    rental ON inventory.inventory_id = rental.inventory_id
        INNER JOIN
    customer ON rental.customer_id = customer.customer_id;
 -- ----------------------------------------------------------------------------------------------------------------------------------------------------------
 
    -- Retrieve the names of all actors who have appeared in the film "Gone with the Wind." 
    
    select * from film_actor;
    select * from film;
    select * from actor;
    
    SELECT 
    CONCAT(first_name, ' ', last_name) AS name
FROM
    actor
        INNER JOIN
    film_actor ON film_actor.actor_id = actor.actor_id
        INNER JOIN
    film ON film_actor.film_id = film.film_id
WHERE
    title = "Gone with the Wind";
   -- ---------------------------------------------------------------------------------------------------------------------------------------------
   
    -- Determine the total number of rentals for each category of movies
    
    select * from film_category;
    select * from film;
    select * from rental;
    select * from inventory;
    
    select count(rental_id), category_id from rental
    inner join inventory on rental.inventory_id = inventory.inventory_id
    inner join film_category on film_category.film_id = inventory.inventory_id
    group by category_id;
    
 -- --------------------------------------------------------------------------------------------------------------------------------------------------------
 
    -- Find the average rental rate of movies in each language. 
    
    select * from film;
    select * from language;
     
	select avg(rental_rate) from film inner join language on film.language_id = language.language_id group by language.name;
  -- ----------------------------------------------------------------------------------------------------------------------------------------------------
  
    -- Retrieve the customer names along with the total amount they've spent on rentals. 
    
    select * from customer; 
    select * from payment;
    select * from rental;
    
    SELECT 
    CONCAT(first_name, ' ', last_name) AS name, SUM(amount)
FROM
    customer
        INNER JOIN
    payment ON customer.customer_id = payment.customer_id
        INNER JOIN
    rental ON payment.rental_id = rental.rental_id
GROUP BY name;
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------

-- List the titles of movies rented by each customer in a particular city (e.g., 'London'). 

select * from customer;
select * from address;
select * from city;
select * from rental;
select * from inventory;
select * from film;

SELECT 
    title, CONCAT(first_name, ' ', last_name) AS name, city
FROM
    city
        INNER JOIN
    address ON city.city_id = address.city_id
        INNER JOIN
    customer ON address.address_id = customer.address_id
        INNER JOIN
    rental ON rental.customer_id = customer.customer_id
        INNER JOIN
    inventory ON rental.inventory_id = inventory.inventory_id
        INNER JOIN
    film ON inventory.film_id = film.film_id
GROUP BY title , name , city;
-- ----------------------------------------------------------------------------------------------------------------------------------------------------

-- Display the top 5 rented movies along with the number of times they've been rented. 

select * from film;
select * from inventory;
select * from rental;

SELECT 
    title, COUNT(title)
FROM
    film
        INNER JOIN
    inventory ON film.film_id = inventory.film_id
        INNER JOIN
    rental ON inventory.inventory_id = rental.inventory_id
GROUP BY title
LIMIT 5;
-- --------------------------------------------------------------------------------------------------------------------------------------------

-- Determine the customers who have rented movies from both stores (store ID 1 and store ID 2). 

select * from rental;
select * from inventory;
select * from customer;

SELECT 
    rental.customer_id, COUNT(DISTINCT inventory.store_id)
FROM
    rental
        INNER JOIN
    inventory ON rental.inventory_id = inventory.inventory_id
        INNER JOIN
    customer ON customer.customer_id = rental.customer_id
GROUP BY rental.customer_id
HAVING COUNT(DISTINCT inventory.store_id) = 2;
-- --------------------------------------------------------------------------------------------------------------------------------------------------



    