SELECT u.special_feature, ROUND(SUM(x.revenue), 2) AS profit
FROM (
    SELECT
        f.film_id,
        f.special_features,
        COALESCE(SUM(p.amount), 0)::numeric(10,2) AS revenue
    FROM film f
    LEFT JOIN inventory i USING (film_id)
    LEFT JOIN rental r USING (inventory_id)
    LEFT JOIN payment p USING (rental_id)
    GROUP BY f.film_id, f.special_features
) x
CROSS JOIN LATERAL UNNEST(x.special_features) AS u(special_feature)
GROUP BY u.special_feature
ORDER BY u.special_feature;
