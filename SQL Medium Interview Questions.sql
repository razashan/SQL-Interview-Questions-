use sakila

Which actors have the first name ‘Scarlett’
select * 
from actor 
where first_name = 'Scarlett'

Which actors have the last name ‘Johansson’
select * 
from actor 
where last_name = 'Johansson'

How many distinct actors last names are there?
select distinct last_name
from actor 

Which last names are not repeated?
select last_name
from actor 
group by last_name
having count(last_name) = 1

Which last names appear more than once?
select last_name
from actor 
group by last_name
having count(last_name) > 1

Which actor has appeared in the most films?
select actor.actor_id,actor.first_name,actor.last_name,count(actor_id) as film_count
from actor
join film_actor
using(actor_id)
group by actor_id
order by film_count desc
limit 1;

Is ‘Academy Dinosaur’ available for rent from Store 1?
select film.film_id, film.title, store.store_id, inventory.inventory_id
from inventory
join store 
using(store_id)
join film
using(film_id) 
where film.title = 'Academy Dinosaur' and store_id = 1; 

Insert a record to represent Mary Smith renting ‘Academy Dinosaur’ from Mike Hillyer at Store 1 today .
insert into rental(rental_date,inventory_id,customer_id,staff_id)
values ( NOW(),1,1,1)


select  rental_duration 
from film 
where film_id = 1;
When is ‘Academy Dinosaur’ due?

Which rental are we referring to -- the last one.
select rental_id 
from rental 
order by rental_id desc 
limit 1;

add the rental duration to the rental date.
select rental_date,
       rental_date + interval
                   (select rental_duration from film where film_id = 1) day
                   as due_date
from rental
where rental_id = (select rental_id from rental order by rental_id desc limit 1);

select rental_date,
rental_date + interval (select rental_duration from film where film_id = 1) day  as due_date
from rental
where rental_id = (select rental_id from rental order by rental_id desc limit 1) ;

What is that average length of all the films in the sakila DB?
select  avg(length) from film



What is the average length of films by category?
select category.name,avg(length)
from film join film_category using(film_id) 
join category using(category_id)
group by category.name
order by avg(length) desc;



Which film categories are long?
select category.name,avg(length)
from film join film_category using(film_id)
join category using (category_id)
group by category.name
having avg(length) >(select avg(length) from film)
order by avg(length) desc; 