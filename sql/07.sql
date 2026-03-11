SELECT DISTINCT f.title
FROM film f
JOIN inventory i USING (film_id)
WHERE f.film_id NOT IN (
    SELECT DISTINCT i2.film_id
    FROM inventory i2
    JOIN rental r USING (inventory_id)
    JOIN customer c USING (customer_id)
    JOIN address a USING (address_id)
    JOIN city ci USING (city_id)
    JOIN country co USING (country_id)
    WHERE co.country = 'United States'
)
ORDER BY f.title;
