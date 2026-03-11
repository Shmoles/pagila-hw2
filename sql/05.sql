SELECT a.last_name, a.first_name
FROM actor a
WHERE (a.first_name, a.last_name) NOT IN (
    SELECT c.first_name, c.last_name
    FROM customer c
)
ORDER BY a.last_name, a.first_name;
