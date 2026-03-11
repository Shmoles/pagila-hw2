SELECT
    RANK() OVER (ORDER BY revenue DESC) AS rank,
    title,
    revenue
FROM (
    SELECT
        f.title,
        COALESCE(SUM(p.amount), 0)::numeric(10,2) AS revenue
    FROM film f
    LEFT JOIN inventory i USING (film_id)
    LEFT JOIN rental r USING (inventory_id)
    LEFT JOIN payment p USING (rental_id)
    GROUP BY f.film_id, f.title
) x
ORDER BY revenue DESC, title;
