SELECT film_id, title
FROM film
WHERE rating IN (
    SELECT rating
    FROM film
    GROUP BY rating
    ORDER BY COUNT(*) DESC
    LIMIT 2
)
ORDER BY title;
