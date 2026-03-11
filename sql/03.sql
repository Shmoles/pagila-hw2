SELECT DISTINCT c.customer_id
FROM customer c
JOIN rental r USING (customer_id)
JOIN inventory i USING (inventory_id)
WHERE i.film_id IN (
    SELECT i2.film_id
    FROM inventory i2
    JOIN rental r2 USING (inventory_id)
    JOIN payment p2 USING (rental_id)
    GROUP BY i2.film_id
    ORDER BY SUM(p2.amount) DESC
    LIMIT 5
)
ORDER BY c.customer_id;
