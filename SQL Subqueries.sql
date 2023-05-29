USE sakila;

##How many copies of the film Hunchback Impossible exist in the inventory system?
SELECT * FROM inventory;

SELECT * FROM(
 SELECT f.title , f.film_id ,count(i.inventory_id) AS exist
 FROM film f
 JOIN inventory i
 ON f.film_id = i.film_id
 GROUP BY f.film_id
)sub1
WHERE title = 'HUNCHBACK IMPOSSIBLE';

##List all films whose length is longer than the average of all the films.


##Use subqueries to display all actors who appear in the film Alone Trip.
SELECT * FROM (
 SELECT f.title , fa.film_id , concat(a.first_name ,'  ' ,a.last_name) AS ACTORS
  FROM film f
  JOIN film_actor fa 
  ON f.film_id = fa.film_id
  JOIN actor a
  ON fa.actor_id = a.actor_id
  )sub1 
 WHERE film_id = '17';


##Sales have been lagging among young families, and you wish to target all family movies for a promotion. 
##Identify all movies categorized as family films.
SELECT * FROM category;
SELECT *FROM film;

SELECT * FROM (
   SELECT f.title , c.name , f.rating
   FROM film f
   JOIN film_category fc
   ON f.film_id = fc.film_id
   JOIN category c
   ON fc.category_id = c.category_id
   ) SUB1
   WHERE rating = 'G'
   ;
   
##Get name and email from customers from Canada using subqueries. Do the same with joins.
## Note that to create a join, you will have to identify the correct tables with their primary keys and foreign keys, that will help you get the relevant information.
SELECT * FROM city;
SELECT * FROM COUNTRY;
 
SELECT * FROM (
   SELECT cu.first_name, cu.email , co.country
   FROM customer cu
   JOIN address a
   ON cu.address_id = a.address_id
   JOIN city ci
   ON a.city_id = ci.city_id
   JOIN country co
   ON ci.country_id = co.country_id
   )sub1 
   WHERE country = 'canada';

##Which are films starred by the most prolific actor?
 ##Most prolific actor is defined as the actor that has acted in the most number of films. First you will have to find the most prolific actor and then use that actor_id to find the different films that he/she starred.
SELECT *FROM ACTOR;
SELECT*FROM film_actor;
   SELECT fa.film_id, a.first_name , a.last_name ,COUNT(a.actor_id) as count_actor
   FROM actor a
   JOIN film_actor fa
   ON a.actor_id = fa.actor_id
   JOIN film f
   ON fa.film_id = f.film_id
   group by a.actor_id , fa. film_id;
   SELECT*FROM actor1;
 
 SELECT first_name,last_name, SUM(count_actor) as ACTED
 FROM actor1
 GROUP BY first_name,last_name
 order by ACTED DESC;
 

##Films rented by most profitable customer. You can use the customer table and payment table to find the most profitable customer ie the customer that has made the largest sum of payments

SELECT * FROM payment;
SELECT*FROM customer;


   CREATE TEMPORARY TABLE actor1
   SELECT cu.first_name, cu.last_name, COUNT(p.customer_id) AS rented_customer
   FROM customer cu
   JOIN payment p
   ON cu.customer_id = p.customer_id
   GROUP BY p.customer_id
   ORDER BY rented_customer desc;
 
 
##Get the client_id and the total_amount_spent of those clients who spent more than the average of the total_amount spent by each client.

SELECT* FROM clientp;

   CREATE TEMPORARY TABLE clientp
    SELECT p.customer_id , cu.first_name, cu.last_name, SUM(p.amount) AS total_amount
     FROM customer cu
     JOIN payment p
     ON cu.customer_id = p.customer_id
	GROUP BY p.customer_id;

 CREATE TEMPORARY TABLE clientp2
    SELECT p.customer_id , cu.first_name, cu.last_name, SUM(p.amount) AS total_amount
     FROM customer cu
     JOIN payment p
     ON cu.customer_id = p.customer_id
	GROUP BY p.customer_id;

SELECT AVG(total_amount) as total_amount_spent
FROM clientp; ##112.531 

SELECT * FROM clientp2
WHERE total_amount > (
SELECT AVG(total_amount) 
FROM clientp);
