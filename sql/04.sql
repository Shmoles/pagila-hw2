SELECT f.title
FROM film f
JOIN inventory i USING (film_id)
JOIN rental r USING (inventory_id)
WHERE r.customer_id = 1
GROUP BY f.film_id, f.title
HAVING COUNT(*) > 1
ORDER BY f.title;
